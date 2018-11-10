Return-Path: <hare@suse.de>
Subject: Re: [PATCH 6/6] ide: don't use req->special
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
 <20181109183208.19879-7-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0d4f66b0-93a7-8233-862d-3dd2cdbecee0@suse.de>
Date: Sat, 10 Nov 2018 13:59:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 7:32 PM, Christoph Hellwig wrote:
> Just replace it with a field of the same name in struct ide_req.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ide/ide-atapi.c    |  4 ++--
>  drivers/ide/ide-cd.c       |  4 ++--
>  drivers/ide/ide-devsets.c  |  4 ++--
>  drivers/ide/ide-disk.c     |  6 +++---
>  drivers/ide/ide-eh.c       |  2 +-
>  drivers/ide/ide-floppy.c   |  2 +-
>  drivers/ide/ide-io.c       | 14 +++++++++-----
>  drivers/ide/ide-park.c     |  4 ++--
>  drivers/ide/ide-pm.c       | 12 ++++++------
>  drivers/ide/ide-tape.c     |  2 +-
>  drivers/ide/ide-taskfile.c |  2 +-
>  include/linux/ide.h        |  1 +
>  12 files changed, 31 insertions(+), 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
