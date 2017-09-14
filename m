Return-Path: <prvs=42330e208=damien.lemoal@wdc.com>
Subject: Re: [PATCH] Support for secure erase functionality
To: Philipp Guendisch <philipp.guendisch@fau.de>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, viro@zeniv.linux.org.uk, bart.vanassche@sandisk.com,
 martin.petersen@oracle.com, hare@suse.de, osandov@fb.com,
 dan.j.williams@intel.com, ming.lei@redhat.com, linux-kernel@i4.cs.fau.de,
 Mate Horvath <horvatmate@gmail.com>
References: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <2b2d3855-00e9-77d0-7ee4-050c210b718e@wdc.com>
Date: Thu, 14 Sep 2017 17:46:19 +0900
MIME-Version: 1.0
In-Reply-To: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Philipp,

On 9/14/17 00:37, Philipp Guendisch wrote:
> This patch adds a software based secure erase option to improve data
> confidentiality. The CONFIG_BLK_DEV_SECURE_ERASE option enables a mount
> flag called 'sw_secure_erase'. When you mount a volume with this flag,
> every discard call is prepended by an explicit write command to overwrite
> the data before it is discarded. A volume without a discard compatibility
> can be used as well but the discard calls will be enabled for this device
> and suppressed after the write call is made.

Writing once to a sector stored on spinning rust will *not* fully erase
the previous data. Part of the signal used for storing that data will
remain on the track (because the disk head is never perfectly aligned on
the track). With some signal processing work, the old data can be retrieved.

You will need a *lot* of normal writes to make sure nothing remains of
the old data signal. Granted, even a single write will make it hard to
get to the old data, but it is possible nevertheless. Hence the standard
defined SANITIZE with cryptographic erase option to ensure that the old
data is really dead.

I think that a similar problem also exist for SSDs, and it is even worse
there since writing twice to the same logical sector does not even go to
the same physical sector. The old data is not even overwritten.

Writing to erase just makes reading the old data harder, but from a pure
security perspective, I do not think that works.

Best regards.

-- 
Damien Le Moal,
Western Digital
