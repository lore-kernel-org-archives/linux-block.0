Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] block: pass in queue to inflight accounting
Date: Thu, 3 Aug 2017 20:35:54 +0000
Message-ID: <1501792550.2922.15.camel@wdc.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
	 <1501790516-6924-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-3-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
> No functional change in this patch, just in preparation for
> basing the inflight mechanism on the queue in question.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bio.c                   | 16 ++++++++--------
>  block/blk-core.c              | 22 ++++++++++++----------
>  block/blk-merge.c             |  4 ++--
>  block/genhd.c                 |  4 ++--
>  block/partition-generic.c     |  5 +++--
>  drivers/block/drbd/drbd_req.c | 10 +++++++---
>  drivers/block/rsxx/dev.c      |  6 +++---
>  drivers/block/zram/zram_drv.c |  5 +++--
>  drivers/md/bcache/request.c   |  7 ++++---
>  drivers/md/dm.c               |  6 +++---
>  drivers/nvdimm/nd.h           |  5 +++--
>  include/linux/bio.h           |  9 +++++----
>  include/linux/genhd.h         | 14 +++++++++-----
>  13 files changed, 64 insertions(+), 49 deletions(-)

Hello Jens,

Should the DRBD, rsxx, zram, md and nvdimm driver maintainers be CC-ed?

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>=
