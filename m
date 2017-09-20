Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Wed, 20 Sep 2017 10:38:07 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] nbd: ignore non-nbd ioctl's
Message-ID: <20170920143806.laqzcrjhxsumtdov@destiny>
References: <1494037518-31903-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494037518-31903-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 05, 2017 at 10:25:18PM -0400, Josef Bacik wrote:
> In testing we noticed that nbd would spew if you ran a fio job against
> the raw device itself.  This is because fio calls a block device
> specific ioctl, however the block layer will first pass this back to the
> driver ioctl handler in case the driver wants to do something special.
> Since the device was setup using netlink this caused us to spew every
> time fio called this ioctl.  Since we don't have special handling, just
> error out for any non-nbd specific ioctl's that come in.  This fixes the
> spew.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Jens,

This fell through the cracks, could you pick it up, thanks,

Josef
