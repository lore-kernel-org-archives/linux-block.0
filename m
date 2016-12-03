Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: use loff_t for blocksize and nbd_set_size args
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
 mpa@pengutronix.de, nbd-general@lists.sourceforge.net, kernel-team@fb.com
References: <1480713552-3535-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dd4b264f-5529-54f5-5471-5ced434e1b90@kernel.dk>
Date: Fri, 2 Dec 2016 21:06:40 -0700
MIME-Version: 1.0
In-Reply-To: <1480713552-3535-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/02/2016 02:19 PM, Josef Bacik wrote:
> If we have large devices (say like the 40t drive I was trying to test with) we
> will end up overflowing the int arguments to nbd_set_size and not get the right
> size for our device.  Fix this by using loff_t everywhere so I don't have to
> think about this again.  Thanks,

Added, thanks Josef.

-- 
Jens Axboe
