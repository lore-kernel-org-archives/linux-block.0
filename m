Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/4] loop: LO_FLAGS_BLOCKSIZE fixes
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
 Milan Broz <gmazyland@gmail.com>
References: <cover.1503422996.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d4e4b9aa-d969-8bcd-38ee-47fc5b1b5d35@kernel.dk>
Date: Tue, 22 Aug 2017 14:25:54 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1503422996.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/22/2017 11:32 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Patches 1, 3, and 4 are the same as v2, plus added reviewed-bys and
> tested-bys from Milan. Patch 2 is new.
> 
> Omar Sandoval (4):
>   loop: fix hang if LOOP_SET_STATUS gets invalid blocksize or encrypt
>     type
>   loop: set discard and write zeroes limits in 512 byte sectors
>   loop: use queue limit instead of private lo_logical_blocksize
>   loop: always return block size in LOOP_GET_STATUS

Queued up, thanks Omar.

-- 
Jens Axboe
