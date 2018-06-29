Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Block: initialize bio_cnt_ret_time for the first time
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17ed5986-02c8-42be-f832-04594a3bc202@kernel.dk>
Date: Fri, 29 Jun 2018 14:00:01 -0600
MIME-Version: 1.0
In-Reply-To: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/20/18 9:07 PM, Liu Bo wrote:
> When a new tg is created, tg->bio_cnt_ret_time is 0, so if the first
> IO going thru this tg turns out to be a bad one, we fail to record it
> in tg->bad_bio_cnt as
> 
> if (jiffies > bio_cnt_ret_time) {
> 	tg->bad_bio_cnt /= 2;
> }

Shouldn't we rather ensure that ->bio_cnt_ret_time is initialized to
jiffies?

-- 
Jens Axboe
