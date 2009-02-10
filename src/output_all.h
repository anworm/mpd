/*
 * Copyright (C) 2003-2009 The Music Player Daemon Project
 * http://www.musicpd.org
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * Functions for dealing with all configured (enabled) audion outputs
 * at once.
 *
 */

#ifndef OUTPUT_ALL_H
#define OUTPUT_ALL_H

#include <stdbool.h>
#include <stddef.h>

struct audio_format;
struct tag;

/**
 * Returns the total number of audio output devices, including those
 * who are disabled right now.
 */
unsigned int audio_output_count(void);

/**
 * Returns the "i"th audio output device.
 */
struct audio_output *
audio_output_get(unsigned i);

/**
 * Returns the audio output device with the specified name.  Returns
 * NULL if the name does not exist.
 */
struct audio_output *
audio_output_find(const char *name);

void initAudioDriver(void);

void finishAudioDriver(void);

bool openAudioDevice(const struct audio_format *audioFormat);

bool playAudio(const char *playChunk, size_t size);

void audio_output_pause_all(void);

void dropBufferedAudio(void);

void closeAudioDevice(void);

void sendMetadataToAudioDevice(const struct tag *tag);

#endif