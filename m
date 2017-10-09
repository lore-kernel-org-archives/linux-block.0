Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: don't set the device size until we're connected
To: Josef Bacik <josef@toxicpanda.com>, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org, kernel-team@fb.com
Cc: stable@vger.kernel.org
References: <1507569130-5067-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <29df4da4-fb2d-3e34-95e0-412913de2091@kernel.dk>
Date: Mon, 9 Oct 2017 12:29:41 -0600
MIME-Version: 1.0
In-Reply-To: <1507569130-5067-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/09/2017 11:12 AM, Josef Bacik wrote:
> A user reported a regression with using the normal ioctl interface on
> newer kernels.  This happens because I was setting the device size
> before the device was actually connected, which caused us to error out
> and close everything down.  This didn't happen on netlink because we
> hold the device lock the whole time we're setting things up, but we
> don't do that for the ioctl path.  This fixes the problem.

Applied, thanks Josef.

-- 
Jens Axboe
