Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: remove NULLB_DEV_FL_CONFIGURED on turning off
 nullb device
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1530817633-128360-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <49a67d84-f6a5-193a-f9ce-e6dd72927913@kernel.dk>
Date: Fri, 6 Jul 2018 07:47:38 -0600
MIME-Version: 1.0
In-Reply-To: <1530817633-128360-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/5/18 1:07 PM, Liu Bo wrote:
> Currently mbps knob could only be set once before switching power knob to
> on, after power knob has been set at least once, there is no way to set
> mbps knob again due to -EBUSY.
> 
> As nullb is mainly used for testing, in order to make it flexible, this
> removes the flag NULLB_DEV_FL_CONFIGURED so that mbps knob can be reset
> when power knob is off, e.g.
> 
> echo 0 > /config/nullb/a/power
> echo 40 > /config/nullb/a/mbps
> echo 1 > /config/nullb/a/power
> 
> So does other knobs under /config/nullb/a.

Applied for 4.19, thanks.

-- 
Jens Axboe
