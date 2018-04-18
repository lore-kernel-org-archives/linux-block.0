Return-Path: <BATV+bb0560cae33c7ec78627+5351+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 18 Apr 2018 03:35:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: information leak in cdrom_ioctl_media_changed()
Message-ID: <20180418103539.GA27207@infradead.org>
References: <20180418095130.GA26904@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180418095130.GA26904@mwanda>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 18, 2018 at 12:51:31PM +0300, Dan Carpenter wrote:
> This cast is wrong.  "cdi->capacity" is an int and "arg" is an unsigned
> long.  The way the check is written now, if one of the high 32 bits is
> set then we could read outside the info->slots[] array.
> 
> This bug is pretty old and it predates git.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
