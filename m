Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Block: blk-throttle: set low_valid immediately once one
 cgroup has io.low configured
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1530237416-105735-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ceee8363-c9ca-fd2d-0b01-ec7cb95d4b91@kernel.dk>
Date: Fri, 29 Jun 2018 09:05:01 -0600
MIME-Version: 1.0
In-Reply-To: <1530237416-105735-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/28/18 7:56 PM, Liu Bo wrote:
> Once one cgroup has io.low configured, @low_valid becomes true and other
> cgroups won't switch it back whatsoever.

Applied for 4.19, thanks.

-- 
Jens Axboe
