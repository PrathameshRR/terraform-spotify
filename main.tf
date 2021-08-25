terraform {
  required_providers {
    spotify = {
      version = "~> 0.1.5"
      source  = "conradludgate/spotify"
    }
  }
}

variable "spotify_api_key" {
  type = string
  description = "Set this as the APIKey that the authorization proxy server outputs"
}

provider "spotify" {
  api_key = var.spotify_api_key
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Summer Playlist"
  description = "This playlist was created by Terraform"
  public      = true

  tracks = [
    data.spotify_search_track.by_artist.tracks[0].id,
    data.spotify_search_track.by_artist.tracks[1].id,
    data.spotify_search_track.by_artist.tracks[2].id,
  ]
}




data "spotify_search_track" "by_artist" {
  artists = ["Dolly Parton"]
  #  album = "Jolene"
  #  name  = "Early Morning Breeze"
}

output "playlist_url" {
  value       = "https://open.spotify.com/playlist/${spotify_playlist.playlist.id}"
  description = "Visit this URL in your browser to listen to the playlist"
}


