Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34415 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbdL1Bv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Dec 2017 20:51:29 -0500
Subject: Re: [RFC] distinguish foreground and background IOs in block throttle
To: Paolo Valente <paolo.valente@linaro.org>,
        xuejiufei <xuejiufei@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@fb.com>,
        Shaohua Li <shli@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1fa623a6-e374-de5e-477e-e604cb760f82@gmail.com>
 <A491ADB3-5487-4161-A526-E0C3AF416437@linaro.org>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <02a6f8ff-2f13-9590-93ac-002240f00815@gmail.com>
Date: Thu, 28 Dec 2017 09:51:09 +0800
MIME-Version: 1.0
In-Reply-To: <A491ADB3-5487-4161-A526-E0C3AF416437@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Paolo,

On 17/12/27 20:36, Paolo Valente wrote:
> 
> 
>> Il giorno 25 dic 2017, alle ore 03:44, xuejiufei <xuejiufei@gmail.com> ha scritto:
>>
>> Hi all,
>>
>> Cgroup writeback is supported since v4.2. I found there exists a
>> problem in the following case.
>>
>> A cgroup may send both buffer and direct/sync IOs. The foreground
>> thread will be stalled when periodic writeback IOs is flushed because
>> the service queue already has a plenty of writeback IOs, then
>> foreground IOs should be enqueued with its FIFO policy.
>>
>> I wonder if we can distinguish foreground and background IOs in block
>> throttle to fix the above problem.
>>
>> Any suggestion are always appreciated.
>>
> 
> Hi,
> to address similar issues, I have just sent a patch [1] for the BFQ
> I/O scheduler.  If you want to give it a try, it might solve, or at
> least mitigate, your problem (the patch does not involve groups,
> though, at least for the moment).
> 
> There are still pending patches related to the low_latency mode of
> BFQ, so I suggest you to try with low_latency disabled, i.e., as root:
> echo bfq > /sys/block/<your-device>/queue/scheduler
> echo 0 > /sys/block/<your-device>/queue/iosched/low_latency 
> 
> For your possible convenience, I have attached the patch, gzipped, to
> this email too.
> > Thanks,
> Paolo
> 
> [1] https://www.spinics.net/lists/kernel/msg2684463.html
> 
I don't get why the issue Jiufei described has relations with scheduler.

IMO, the core reason is current we only have read/write queues in block
throttle. That means all sync/async writes will go into the same queue.
Once writeback IOs flush out and throttle happens, sync write will also
have to be queued up. Since there are more async writes ahead of sync
writes in the queue, and the current policy is dispatching 6 reads and 2
writes during each round, sync writes will get significantly delay,
which we don't expect.

So like read/write queue design, we may add another queue in block
throttle to distinguish sync/async writes, and then we can dispatch more
sync writes than async writes.

Thanks,
Joseph
