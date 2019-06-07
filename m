Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C93C28CC3
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 04:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E7A208C3
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 04:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="usANwv4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbfFGEj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:39:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38599 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfFGEj2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 00:39:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so709958wrs.5
        for <linux-block@vger.kernel.org>; Thu, 06 Jun 2019 21:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fvow+Oyb8lh/2dmvm9S5K/w7QYAFOz5bIlX6D1JLM+k=;
        b=usANwv4AM5TWLAf0VNbtvnSFSzzBKNim/QbTnDwcJIFhU6wFbcg8FcD5DcZRR8bjaN
         zTvgGjdkfjieijRfe95/BXqpZOztjtBxi85BJ/TfgcBnzZfHPWgfyJgUvR/1HmL8RVv8
         icvSap3EWdcxY4SHBi4X5gsT8va6Riy43gPYS+h0G3cs1BBIu0PFE5VGKBucN+9X/WEy
         BTRaa47mhaD7tmMc4a87iA9vmXewuM0W3tkSDUtPLmSaf4jBE5mtCHDVDLs7lpPXmMbr
         KkGivUgzlXN/Jm6sbYsF7oXT9YDTQllpuAjxQ8t3zFOgLHj9NMRMPs5gTOaFvSC4EWi8
         NVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fvow+Oyb8lh/2dmvm9S5K/w7QYAFOz5bIlX6D1JLM+k=;
        b=BNczydoY4JKG52KwvOSRETwK+XI+SztyS0V+D4rIydm8eQht7h4BkAcacD0VoDkQrO
         hg+s5/D/JtLxlkm67xWuOUHP5VKc+ZhhKde1WOq3r78L5ssFR5ui3sn1AwbRqefmwN8x
         M1WeA1ykPZ4CRyy7qJ+iTXO+oPU7tVNLNy4UTjbmGD5e8KxzBHj04E/2KlxfBEsnN61g
         8jwLV07z35gQ+sMYGArc792CkyNVwgM5xjl1Lu5UaYMLyxgXeGaIZNRzsuB73nXkLCxi
         +aDxXcQ32+P0aJL6zMxjtqPMiThZJUTCuXOp4OnJ03C1KeUUHGlsT5Prbw29AMTyMKI8
         tfSQ==
X-Gm-Message-State: APjAAAXV2/gFn/M0k58y3k3F8IZ3cCTyT9Sf6MG3xGq/IPAyWHqtOjrG
        HOSiIySUnJIuHW3tAz6qSbpe1A==
X-Google-Smtp-Source: APXvYqyywPqCgP3LZ5HKFsJU4bAXJt70hJT3RidJpWZ+q9u+y7TjSgReC8Mm0EmpfoBJzThaQy5RCA==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr17482349wrw.232.1559882366181;
        Thu, 06 Jun 2019 21:39:26 -0700 (PDT)
Received: from [10.97.4.179] (aputeaux-682-1-82-78.w90-86.abo.wanadoo.fr. [90.86.61.78])
        by smtp.gmail.com with ESMTPSA id e6sm673004wrw.83.2019.06.06.21.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 21:39:25 -0700 (PDT)
Subject: Re: [PATCH] block: free sched's request pool in blk_cleanup_queue
To:     Ming Lei <ming.lei@redhat.com>,
        Benjamin Block <bblock@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Jens Remus <jremus@linux.ibm.com>
References: <20190604130802.17076-1-ming.lei@redhat.com>
 <20190606144714.GA6549@t480-pf1aa2c2> <20190606224349.GB2165@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f713e77c-7796-9ed0-a87f-d809fef21a57@kernel.dk>
Date:   Thu, 6 Jun 2019 22:39:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606224349.GB2165@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/6/19 4:43 PM, Ming Lei wrote:
> On Thu, Jun 06, 2019 at 04:47:14PM +0200, Benjamin Block wrote:
>> On Tue, Jun 04, 2019 at 09:08:02PM +0800, Ming Lei wrote:
>>> In theory, IO scheduler belongs to request queue, and the request pool
>>> of sched tags belongs to the request queue too.
>>>
>>> However, the current tags allocation interfaces are re-used for both
>>> driver tags and sched tags, and driver tags is definitely host wide,
>>> and doesn't belong to any request queue, same with its request pool.
>>> So we need tagset instance for freeing request of sched tags.
>>>
>>> Meantime, blk_mq_free_tag_set() often follows blk_cleanup_queue() in case
>>> of non-BLK_MQ_F_TAG_SHARED, this way requires that request pool of sched
>>> tags to be freed before calling blk_mq_free_tag_set().
>>>
>>> Commit 47cdee29ef9d94e ("block: move blk_exit_queue into __blk_release_queue")
>>> moves blk_exit_queue into __blk_release_queue for simplying the fast
>>> path in generic_make_request(), then causes oops during freeing requests
>>> of sched tags in __blk_release_queue().
>>>
>>> Fix the above issue by move freeing request pool of sched tags into
>>> blk_cleanup_queue(), this way is safe becasue queue has been frozen and no any
>>> in-queue requests at that time. Freeing sched tags has to be kept in queue's
>>> release handler becasue there might be un-completed dispatch activity
>>> which might refer to sched tags.
>>>
>>> Cc: Bart Van Assche <bvanassche@acm.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Fixes: 47cdee29ef9d94e485eb08f962c74943023a5271 ("block: move blk_exit_queue into __blk_release_queue")
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>> Our CI meanwhile also crashes regularly because of this:
>>
>>    run blktests block/002 at 2019-06-06 14:44:55
>>    Unable to handle kernel pointer dereference in virtual kernel address space, Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803
>>    Fault in home space mode while using kernel ASCE.
>>    AS:0000000057290007 R3:0000000000000024
>>    Oops: 0038 ilc:3 [#1] PREEMPT SMP
>>    Modules linked in: ...
>>    CPU: 4 PID: 139 Comm: kworker/4:2 Kdump: loaded Not tainted 5.2.0-rc3-master-05489-g55f909514069 #3
>>    Hardware name: IBM 3906 M03 703 (LPAR)
>>    Workqueue: events __blk_release_queue
>>    Krnl PSW : 0704e00180000000 000000005657db18 (blk_mq_free_rqs+0x48/0x128)
>>               R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>>    Krnl GPRS: 00000000a8309db5 6b6b6b6b6b6b6b6b 000000008beb3858 00000000a2befbc8
>>               0000000000000000 0000000000000001 0000000056bb16c8 00000000b4070aa8
>>               000000008beb3858 000000008bc46b38 00000000a2befbc8 0000000000000000
>>               00000000bafb8100 00000000568e8040 000003e0092b3c30 000003e0092b3be0
>>    Krnl Code: 000000005657db0a: a7f4006e            brc     15,5657dbe6
>>               000000005657db0e: e31020380004       lg      %r1,56(%r2)
>>              #000000005657db14: b9040082           lgr     %r8,%r2
>>              >000000005657db18: e31010500002       ltg     %r1,80(%r1)
>>               000000005657db1e: a784ffee           brc     8,5657dafa
>>               000000005657db22: e32030000012       lt      %r2,0(%r3)
>>               000000005657db28: a784ffe9           brc     8,5657dafa
>>               000000005657db2c: b9040074           lgr     %r7,%r4
>>    Call Trace:
>>    ([<000000008ff8ed00>] 0x8ff8ed00)
>>     [<0000000056582958>] blk_mq_sched_tags_teardown+0x68/0x98
>>     [<0000000056583396>] blk_mq_exit_sched+0xc6/0xd8
>>     [<0000000056569324>] elevator_exit+0x54/0x70
>>     [<0000000056570644>] __blk_release_queue+0x84/0x110
>>     [<0000000055f416c6>] process_one_work+0x3a6/0x6b8
>>     [<0000000055f41c50>] worker_thread+0x278/0x478
>>     [<0000000055f49e08>] kthread+0x160/0x178
>>     [<00000000568d83e8>] ret_from_fork+0x34/0x38
>>    INFO: lockdep is turned off.
>>    Last Breaking-Event-Address:
>>     [<000000005657daf6>] blk_mq_free_rqs+0x26/0x128
>>    Kernel panic - not syncing: Fatal exception: panic_on_oops
>>    run blktests block/003 at 2019-06-06 14:44:56
>>
>> When I tried to reproduced this with this patch, it went away (at least all of
>> blktest/block ran w/o crash).
>>
>> I don't feel competent enough to review this patch right now, but it would be
>> good if we get something upstream for this.
> 
> Hi Jens, Christoph and Guys,
> 
> Could you take a look at this patch? We have at least 3 reports on this
> issue, and I believe more will come if it isn't fixed.

I have queued it up.

-- 
Jens Axboe

