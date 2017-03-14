Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-sched: don't run the queue async from
 blk_mq_try_issue_directly()
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <3ac4f49e-3bc0-7fc6-e93a-db9ec7ad21cf@kernel.dk>
 <1D08B61A9CF0974AA09887BE32D889DA0EC183@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dccb2e2f-5576-4614-9797-d6cc2970e4d8@kernel.dk>
Date: Tue, 14 Mar 2017 09:26:08 -0600
MIME-Version: 1.0
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA0EC183@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/14/2017 09:17 AM, Bart Van Assche wrote:
> On 03/14/2017 07:57 AM, Jens Axboe wrote:
>> If we have scheduling enabled, we jump directly to insert-and-run.
>> That's fine, but we run the queue async and we don't pass in information
>> on whether we can block from this context or not. Fixup both these
>> cases.
> 
> How about renaming "can_block" into "may_sleep"? Otherwise this patch
> looks fine to me.

Sure, either one is fine with me, at least to me they convey the same
information.

-- 
Jens Axboe
