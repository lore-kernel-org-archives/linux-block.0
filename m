Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EBC433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAE020709
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 18:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBSUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:20:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43563 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIBSUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 14:20:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19so71324pgl.10
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 11:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+9Z21nrPIFSzJSNBlRzAi6RLU5IBprT045OWvuPvGE=;
        b=bDCi2OfnY0u9s7INbwsRpZ4wZuyoEartHJ2QTddiWHHCtjNBDV5mLVHZugwbJF4YP7
         CCyw7BnoYdpAIJ8/uVDjU1jogdNMyogLfmkv6ew3A8LRcgwxKhciH0ozArci4UXagklY
         FFVW2LW+Yh6yP47HBOOLe8V4YD8jlitiSoFwLB5b2YBff1ZdaiBrXx6WgzLzSRndCwD5
         gK1QFhF0h8LIqisww0MKvK8G0bKriu/IcfVMywOhuXWkzBGmySj2wOM5RT8yC4B4wU8G
         +gjXeQ06/Kg78FfqYEBxJPthkFYrQX/g7CkPU3/kIqC6nYpTIlsAvKo8YHL4K4SWm2JJ
         7IlA==
X-Gm-Message-State: AOAM5337KmKKF0I52iAyv9QZL3EWEMIQnX9v8eCU34yzg+uFEM/cIBAi
        9X6L/jash7HAv2SB7MO1hVA=
X-Google-Smtp-Source: ABdhPJx6lfzBs/5/BqZ5Uf5ZdpLT5iQb+wO69HVguWWpe1AgmZyc8H8w9UZSZF9iifUMucZKtkVu8w==
X-Received: by 2002:a63:455d:: with SMTP id u29mr2851809pgk.178.1599070839337;
        Wed, 02 Sep 2020 11:20:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4025:ed24:701e:8cf3? ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id t10sm195824pfq.77.2020.09.02.11.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:20:38 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200902031144.GC317674@T590>
 <aef6938d-3762-22bc-50c8-877ee0aa5700@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c33d02c1-5806-94a3-86a8-4e7a6addb36a@grimberg.me>
Date:   Wed, 2 Sep 2020 11:20:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aef6938d-3762-22bc-50c8-877ee0aa5700@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Hi Jens,
>>>
>>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>>> and prepares for replacing srcu with percpu_ref.
>>>
>>> The 2nd patch replaces srcu with percpu_ref.
>>>
>>> V2:
>>> 	- add .mq_quiesce_lock
>>> 	- add comment on patch 2 wrt. handling hctx_lock() failure
>>> 	- trivial patch style change
>>>
>>>
>>> Ming Lei (2):
>>>    blk-mq: serialize queue quiesce and unquiesce by mutex
>>>    blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING

I thought we agreed to have a little more consolidation for blocking and
!blocking paths (move fallbacks to common paths).

>>>
>>>   block/blk-core.c       |   2 +
>>>   block/blk-mq-sysfs.c   |   2 -
>>>   block/blk-mq.c         | 125 +++++++++++++++++++++++------------------
>>>   block/blk-sysfs.c      |   6 +-
>>>   include/linux/blk-mq.h |   7 ---
>>>   include/linux/blkdev.h |   6 ++
>>>   6 files changed, 82 insertions(+), 66 deletions(-)
>>>
>>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Josh Triplett <josh@joshtriplett.org>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Cc: Bart Van Assche <bvanassche@acm.org>
>>> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
>>> Cc: Chao Leng <lengchao@huawei.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>
>> Hello Guys,
>>
>> Is there any objections on the two patches? If not, I'd suggest to move> on.
> 
> Seems like the nested case is one that should either be handled, or at
> least detected.

Personally, I'd like to see the async quiesce piece as well here, which
is the reason why this change was proposed. Don't see a strong urgency
to move forward with it before that, especially as this could
potentially affect various non-trivial reset flows.

