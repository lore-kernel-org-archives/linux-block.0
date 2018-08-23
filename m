Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
From: Jens Axboe <axboe@kernel.dk>
To: Anchal Agarwal <anchalag@amzn.com>,
 "van der Linden, Frank" <fllinden@amazon.com>, jianchao.w.wang@oracle.com
Cc: "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
Message-ID: <969389e7-b1bc-0559-6cc9-9461b034a24f@kernel.dk>
Date: Thu, 23 Aug 2018 17:14:57 -0600
MIME-Version: 1.0
In-Reply-To: <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/23/18 5:03 PM, Jens Axboe wrote:
>> Hi Jens, This patch looks much cleaner for sure as Frank pointed out
>> too. Basically this looks similar to wake_up_nr only making sure that
>> those woken up requests won't get reordered. This does solves the
>> thundering herd issue. However, I tested the patch against my
>> application and lock contention numbers rose to around 10 times from
>> what I had from your last 3 patches.  Again this did add to drop in
>> of total files read by 0.12% and rate at which they were read by
>> 0.02% but this is not a very significant drop. Is lock contention
>> worth the tradeoff?  I also added missing
>> __set_current_state(TASK_RUNNING) to the patch for testing.
> 
> Can you try this variant? I don't think we need a
> __set_current_state() after io_schedule(), should be fine as-is.
> 
> I'm not surprised this will raise contention a bit, since we're now
> waking N tasks potentially, if N can queue. With the initial change,
> we'd always just wake one.  That is arguably incorrect. You say it's
> 10 times higher contention, how does that compare to before your
> patch?
> 
> Is it possible to run something that looks like your workload?

Additionally, is the contention you are seeing the wait queue, or the
atomic counter? When you say lock contention, I'm inclined to think it's
the rqw->wait.lock.

-- 
Jens Axboe
