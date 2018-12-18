Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A22C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8D9217D7
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BXqAYzaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLRENs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:13:48 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45374 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLRENs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 23:13:48 -0500
Received: by mail-pg1-f176.google.com with SMTP id y4so7151915pgc.12
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 20:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YZHb/CSjvdOjj6Y8QAp0mToo71t5KC3IFEPylmuT98I=;
        b=BXqAYzaRj0FvoqzcgZVjw6BglF1VbYClEVNL1FaK9cRciW6yzL0fEDJdjWIXTTleHu
         SdWBu5YMIpXpDKCs8J7PCyxovmLwvKA9PbmQ+txmDAbNuJQf42rxENeHr7/B1ADLDDNu
         1w7pqnmpfU1aCmE8FAokoBXXX63Kz64E8S3xMoFLsVxZzcuemu3JfGXwY3TXcL8ni5Gi
         Kf0lqm07ktpLZcyZqQiniOMYRe+Y7JXc9QTKzKlvqmnVGv466R1GBLuDv7KnrwmXyWta
         X0PeBHQHCcKDS9fz8AGqrqr71zd3YnTXnxu3BezZYO27MVPhhAI25Z4zYU70Pp9VCdSH
         F7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZHb/CSjvdOjj6Y8QAp0mToo71t5KC3IFEPylmuT98I=;
        b=D9fBxawjVYpdzfe2STUft5ubyqBc1DorA0C1Pmq71zuExfemxvCyRr1h2s1ULCRX76
         +J2EvpXlUQVQmHC6WTS8H17IUJtpGQP+RT3yxpdBCOEP02xDDGLlvPwOimjxN3j2i/FV
         iOymLxKobVV3vKHZhXZ1c7p3hOm+jONkSByra3zFnmFFGW1EqMOYzL2eBS7IWNT+bz/8
         4N5y9auSoIVfyMHuZiWqRM8n/SRTind2chDY0kw48v+ivH7oKfmjwvaCxMPh8+TvnU4G
         2NeG69eh7ThDjxqGokw/YRW3ccFp2qa2BpVaeGeY6++NVI2Z2nxigJGOLzpNncZbUJYV
         2RFQ==
X-Gm-Message-State: AA+aEWaXK0wZO7nho9DSJ5VX3GMNYhMWuymkrzb+dbTv9SDeWctxvrwF
        yZHGvdZCF68/eKJGrCfq9QT/aA==
X-Google-Smtp-Source: AFSGD/Wu6MKUU6ty6pW91brcS31qX7FADtRxCrQKbFYJbU/ustP9uTedDzMhgx/+pKIUZ/l3SI8Vcg==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr15081044pfq.61.1545106427370;
        Mon, 17 Dec 2018 20:13:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j197sm20295703pgc.76.2018.12.17.20.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 20:13:45 -0800 (PST)
Subject: Re: Upcoming merge window
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
 <1545088576.185366.443.camel@acm.org>
 <8ae21d8c-81a1-891a-66c4-c94ff8bee20b@kernel.dk>
 <69609425-5f1d-3c4f-3b1c-34f3b156006a@kernel.dk>
 <83df36a6-f36b-43b0-8817-59feff02038e@kernel.dk>
 <0ad2ac54-c1e4-10bb-2129-6ef3e962c43e@kernel.dk>
 <20181218034538.GA15299@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53618f8a-9ae6-62c3-1809-eac6a2868211@kernel.dk>
Date:   Mon, 17 Dec 2018 21:13:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218034538.GA15299@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 8:45 PM, Mike Snitzer wrote:
> On Mon, Dec 17 2018 at  7:26pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 12/17/18 5:16 PM, Jens Axboe wrote:
>>> On 12/17/18 4:49 PM, Jens Axboe wrote:
>>>> On 12/17/18 4:27 PM, Jens Axboe wrote:
>>>>> On 12/17/18 4:16 PM, Bart Van Assche wrote:
>>>>>> On Mon, 2018-12-17 at 11:28 -0700, Jens Axboe wrote:
>>>>>>> As I'm sure you're all aware, the merge window is coming up. This time
>>>>>>> it happens to coincide with that is a holiday for most. My plan is to
>>>>>>> send in an EARLY pull request to Linus, Thursday at the latest. If you're
>>>>>>> sitting on anything that should go in with the initial merge, then I need
>>>>>>> to have it ASAP.
>>>>>>>
>>>>>>> I'll do a later pull about a week in with things that were missed, but
>>>>>>> I'm really hoping to make that fixes only. Any driver updates etc should
>>>>>>> go in now.
>>>>>>
>>>>>> Hi Jens,
>>>>>>
>>>>>> If I run blktests/srp/002 against Linus' master branch then that test passes,
>>>>>> no matter how many times I run that test. If I run that test against your
>>>>>> for-next branch however (commit 6a252f2772c0) then that test hangs. The output
>>>>>> of my list-pending-block-requests script is as follows when the hang occurs:
>>>>>
>>>>> Ugh, I'll try and run that here again, that test is unfortunately such a pain
>>>>> to run and requires me to manually install multipath libs (and remember to
>>>>> uninstall before rebooting, or udev fails?).
>>>>>
>>>>> I'll take a look!
>>>>
>>>> Looks like what Ming was talking about. CC'ing Ming and Mike. Lots of
>>>> kworkers are stuck like this:
>>>>
>>>> [  252.310187] kworker/2:19    D14072  8147      2 0x80000000
>>>> [  252.316803] Workqueue: dio/dm-2 dio_aio_complete_work
>>>> [  252.322925] Call Trace:
>>>> [  252.326137]  ? __schedule+0x231/0x5f0
>>>> [  252.330703]  schedule+0x2a/0x80
>>>> [  252.334689]  rwsem_down_write_failed+0x204/0x320
>>>> [  252.340330]  ? generic_make_request_checks+0x55/0x370
>>>> [  252.346542]  ? call_rwsem_down_write_failed+0x13/0x20
>>>> [  252.352669]  call_rwsem_down_write_failed+0x13/0x20
>>>> [  252.358601]  down_write+0x1b/0x30
>>>> [  252.362781]  __generic_file_fsync+0x3e/0xb0
>>>> [  252.367933]  ext4_sync_file+0xcc/0x2e0
>>>> [  252.372599]  dio_complete+0x1c4/0x210
>>>> [  252.377168]  process_one_work+0x1cb/0x350
>>>> [  252.382915]  worker_thread+0x28/0x3c0
>>>> [  252.387482]  ? process_one_work+0x350/0x350
>>>> [  252.392632]  kthread+0x107/0x120
>>>> [  252.396717]  ? kthread_park+0x80/0x80
>>>> [  252.401285]  ret_from_fork+0x1f/0x30
>>>>
>>>> Where did this regression come from? This was passing just fine
>>>> recently.
>>>
>>> Looks like this is the offending commit:
>>>
>>> commit c4576aed8d85d808cd6443bda58393d525207d01
>>> Author: Mike Snitzer <snitzer@redhat.com>
>>> Date:   Tue Dec 11 09:10:26 2018 -0500
>>>
>>>     dm: fix request-based dm's use of dm_wait_for_completion
>>
>> Yep confirmed, reverted that on top and it passes. dm-2 has plenty of
>> requests that are allocated and pending dispatch, so the md_in_flight()
>> will return true. Mike, should it be checking for allocated requests or
>> in-flight?
> 
> I thought we could just check for allocated (as blk_mq_check_busy() does
> now) but clearly that is too broad a scope because I tested your
> suggestion and it allows the srp/002 test to pass:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6847f014606b..edbf4bb1b3e8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -812,7 +812,7 @@ static bool blk_mq_check_busy(struct blk_mq_hw_ctx *hctx, struct request *rq,
>          * If we find a request, we know the queue is busy. Return false
>          * to stop the iteration.
>          */
> -       if (rq->q == hctx->queue) {
> +       if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
>                 bool *busy = priv;
> 
>                 *busy = true;
> 
> blk_mq_check_busy() was introduced for DM to user as a replacement for
> its own inflight accounting it was doing:
>   ae879912 blk-mq: provide a helper to check if a queue is busy
> 
> So nothing else is currently calling it, but if you'd prefer to rename
> the functions to reflect the narrower MQ_RQ_IN_FLIGHT check that is fine
> by me (e.g. blk_mq_check_inflight and blk_mq_queue_has_inflight).

I agree, let's do the fix and rename it to inflight instead, since that
now reflects what it does.

-- 
Jens Axboe

