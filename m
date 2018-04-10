Return-Path: <hare@suse.de>
Date: Tue, 10 Apr 2018 08:28:44 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, Bart.VanAssche@wdc.com, willy@infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/7] block: consistently use GFP_NOIO instead of
 __GFP_NORECLAIM
Message-ID: <20180410082844.06953a12@pentland.suse.de>
In-Reply-To: <20180409153916.23901-7-hch@lst.de>
References: <20180409153916.23901-1-hch@lst.de>
	<20180409153916.23901-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Mon,  9 Apr 2018 17:39:15 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Same numerical value (for now at least), but a much better
> documentation of intent.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/scsi_ioctl.c               |  2 +-
>  drivers/block/drbd/drbd_bitmap.c |  3 ++-
>  drivers/block/pktcdvd.c          |  2 +-
>  drivers/ide/ide-tape.c           |  2 +-
>  drivers/ide/ide-taskfile.c       |  2 +-
>  drivers/scsi/scsi_lib.c          |  2 +-
>  fs/direct-io.c                   |  4 ++--
>  kernel/power/swap.c              | 14 +++++++-------
>  8 files changed, 16 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
