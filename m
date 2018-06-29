Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Block: initialize bio_cnt_ret_time for the first time
To: bo.liu@linux.alibaba.com
Cc: linux-block@vger.kernel.org
References: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
 <17ed5986-02c8-42be-f832-04594a3bc202@kernel.dk>
 <20180629202338.vsnfx6wdy7zcjq6w@US-160370MP2.local>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <49be208d-db81-b6ac-eaa9-161d17e84a3c@kernel.dk>
Date: Fri, 29 Jun 2018 14:26:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180629202338.vsnfx6wdy7zcjq6w@US-160370MP2.local>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/29/18 2:23 PM, Liu Bo wrote:
> On Fri, Jun 29, 2018 at 02:00:01PM -0600, Jens Axboe wrote:
>> On 6/20/18 9:07 PM, Liu Bo wrote:
>>> When a new tg is created, tg->bio_cnt_ret_time is 0, so if the first
>>> IO going thru this tg turns out to be a bad one, we fail to record it
>>> in tg->bad_bio_cnt as
>>>
>>> if (jiffies > bio_cnt_ret_time) {
>>> 	tg->bad_bio_cnt /= 2;
>>> }
>>
>> Shouldn't we rather ensure that ->bio_cnt_ret_time is initialized to
>> jiffies?
>>
> 
> Indeed, it's what the patch does, i.e. initialize tg->bio_cnt_reset_time to
> jiffies on the first use.

You do it on the first use, on the hot path, presumable. My suggestion
was to do it when tg is instantiated instead. From a quick look, that
would appear to be in throtl_pd_alloc().

-- 
Jens Axboe
