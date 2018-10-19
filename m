Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Bundle together NONE and NOT_SET writehint
 types
To: Avri Altman <avri.altman@wdc.com>, linux-block@vger.kernel.org
Cc: Avi Shchislowski <avi.shchislowski@wdc.com>,
 Alex Lemberg <alex.lemberg@wdc.com>
References: <1539947977-4686-1-git-send-email-avri.altman@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7eeecbc3-0f17-13b7-ef4d-401c3e892c4e@kernel.dk>
Date: Fri, 19 Oct 2018 11:35:41 -0600
MIME-Version: 1.0
In-Reply-To: <1539947977-4686-1-git-send-email-avri.altman@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/19/18 5:19 AM, Avri Altman wrote:
> There are 6 writehint types, but the size of the write_hints array
> in the request queue is BLK_MAX_WRITE_HINTS = 5,
> which causes the EXTREME type to be ignored when iterating
> over the hints.
> 
> We only have effectively 5 hints.
> Bundle together NONE and NOT_SET, since they end up in the same
> bucket on the driver side.
> 
> fixes: f793dfd3f39a (blk-mq: expose write hints through debugfs)

This isn't right, you can't just redefine the user API. Looking at
the whole thing, I don't think there's a bug. We have 5 hints,
as mentioned in my previous reply - 4 valid ones, and 1 none. If
you look at the only current user of streams, NVMe, it already
bundles NONE and NOT_SET into 0. Hence there's no bug.

-- 
Jens Axboe
