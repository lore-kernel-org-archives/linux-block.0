Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE72C48BDF
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 01:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CE2611B0
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 01:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFUBeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Jun 2021 21:34:37 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47114 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhFUBeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Jun 2021 21:34:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ud2o7Yc_1624239140;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Ud2o7Yc_1624239140)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 09:32:21 +0800
Subject: Re: [RFC PATCH V2 3/3] dm: support bio polling
To:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
References: <20210617103549.930311-1-ming.lei@redhat.com>
 <20210617103549.930311-4-ming.lei@redhat.com>
 <5ba43dac-b960-7c85-3a89-fdae2d1e2f51@linux.alibaba.com>
 <YMywCX6nLqLiHXyy@T590> <YM0IjWVuPya1SV0V@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <a0eaa522-bce4-4636-b33e-6562a9d3cd10@linux.alibaba.com>
Date:   Mon, 21 Jun 2021 09:32:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YM0IjWVuPya1SV0V@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/19/21 4:56 AM, Mike Snitzer wrote:
> [you really should've changed the subject of this email to
> "[RFC PATCH V3 3/3] dm: support bio polling"]
> 
> On Fri, Jun 18 2021 at 10:39P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
>> From 47e523b9ee988317369eaadb96826323cd86819e Mon Sep 17 00:00:00 2001
>> From: Ming Lei <ming.lei@redhat.com>
>> Date: Wed, 16 Jun 2021 16:13:46 +0800
>> Subject: [RFC PATCH V3 3/3] dm: support bio polling
>>
>> Support bio(REQ_POLLED) polling in the following approach:
>>
>> 1) only support io polling on normal READ/WRITE, and other abnormal IOs
>> still fallback on IRQ mode, so the target io is exactly inside the dm
>> io.
>>
>> 2) hold one refcnt on io->io_count after submitting this dm bio with
>> REQ_POLLED
>>
>> 3) support dm native bio splitting, any dm io instance associated with
>> current bio will be added into one list which head is bio->bi_end_io
>> which will be recovered before ending this bio
>>
>> 4) implement .poll_bio() callback, call bio_poll() on the single target
>> bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
>> dec_pending() after the target io is done in .poll_bio()
>>
>> 4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
>> which is based on Jeffle's previous patch.
> 
> ^ nit: two "4)", last should be 5.
> 
>>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>> V3:
>> 	- covers all comments from Jeffle
> 
> Would really appreciate it if Jeffle could test these changes like he
> did previous dm IO polling patchsets he implemented.  Jeffle?

My pleasure. I would test it today and post the test result as soon as
possible.


-- 
Thanks,
Jeffle
