Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] cdrom: information leak in cdrom_ioctl_media_changed()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-block@vger.kernel.org
References: <20180418095130.GA26904@mwanda>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b2f8739b-d93d-e89c-ec70-a96299f47a0c@kernel.dk>
Date: Wed, 18 Apr 2018 08:21:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180418095130.GA26904@mwanda>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/18/18 3:51 AM, Dan Carpenter wrote:
> This cast is wrong.  "cdi->capacity" is an int and "arg" is an unsigned
> long.  The way the check is written now, if one of the high 32 bits is
> set then we could read outside the info->slots[] array.
> 
> This bug is pretty old and it predates git.

Thanks Dan, applied.

-- 
Jens Axboe
