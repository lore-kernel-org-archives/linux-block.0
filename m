Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] nbd fixes for this cycle
To: Josef Bacik <josef@toxicpanda.com>, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org, kernel-team@fb.com
References: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c76a59f5-0493-acb8-fa2c-bf3d154c778e@kernel.dk>
Date: Fri, 24 Mar 2017 12:57:10 -0600
MIME-Version: 1.0
In-Reply-To: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/24/2017 12:08 PM, Josef Bacik wrote:
> These 4 patches are to fix up various regressions and problems in NBD.  The
> ERESTARTSYS is the biggest patch but has been pretty well tested with a debug
> patch that forced the behavior to happen.  Everything else is relatively small,
> and the queue timeout patch is a regression from last cycle.  Thanks,

Added for 4.11.

-- 
Jens Axboe
