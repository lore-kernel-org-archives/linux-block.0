Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2][RESEND] nbd: wait uninterruptible for the dead
 timeout
To: Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>, stable@vger.kernel.org
References: <1510002718-9574-1-git-send-email-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c8000073-aad0-3da2-ebe5-f3abf5c18693@kernel.dk>
Date: Mon, 6 Nov 2017 14:15:35 -0700
MIME-Version: 1.0
In-Reply-To: <1510002718-9574-1-git-send-email-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/06/2017 02:11 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> If we have a pending signal or the user kills their application then
> it'll bring down the whole device, which is less than awesome.  Instead
> wait uninterruptible for the dead timeout so we're sure we gave it our
> best shot.

Applied 1-2 for 4.15, thanks.

-- 
Jens Axboe
