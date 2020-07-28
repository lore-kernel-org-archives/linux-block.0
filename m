Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A9C433DF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF26A20663
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgG1QZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:25:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731318AbgG1QZ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 12:25:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id u185so11217790pfu.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 09:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XNOrn1wxXoARqqWPAobzKyIN7n1CjQyqgnGF84sHvtk=;
        b=izafQOt3K/byYGh1wMYFi5DReXNSVvRHtIvH4fVt6dRHFvJkbcs6pDiyw0HYvxyO48
         SEwLG+XmLtThkJoRxP7WQ1sfL5juulogON5PirPsrtJJtMCH07f2rdxCS682hWX21O8X
         4t7huOAuDqozmQJlsDkD7nL9JBG2QVUqcJbKoIaGwNQB2jBX/RSqUlr4g9ExYmcn0aP/
         FQ/m9KEmbxUwCjpznQMK4YtM4rfCzYvh/JJyhi51LoE3nFCRTKWEhcaNrYviL31QrPJi
         XWfX3w58RY6g+2V4kSdq9vz4xL4qvJYwXmM+jie7oRFVGwluikwBX6F4kFF+hT01ZYnB
         HmLw==
X-Gm-Message-State: AOAM532QKA/9UNC4Z6wsLZxSZsRIvkwKhKkcsAk4IZo05ilFZxIi/xX1
        hFdKQPTwdVMEONGQrmbJBuw=
X-Google-Smtp-Source: ABdhPJzFtFKjhcllQyen4XXXO249Ran65y3aphY4NyGxJv5geHu8um1lAyRIMHBZyloWB8pYx7s2Qg==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr25736021pgv.252.1595953556413;
        Tue, 28 Jul 2020 09:25:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id 204sm19145734pfx.3.2020.07.28.09.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:25:55 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728093326.GC1326626@T590>
 <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
 <20200728105823.GB29763@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f76c2b1c-d035-04dc-9100-fefde659896c@grimberg.me>
Date:   Tue, 28 Jul 2020 09:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728105823.GB29763@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>> I like the tagset based interface.  But the idea of doing a per-hctx
>>>>>> allocation and wait doesn't seem very scalable.
>>>>>>
>>>>>> Paul, do you have any good idea for an interface that waits on
>>>>>> multiple srcu heads?  As far as I can tell we could just have a single
>>>>>> global completion and counter, and each call_srcu would just just
>>>>>> decrement it and then the final one would do the wakeup.  It would just
>>>>>> be great to figure out a way to keep the struct rcu_synchronize and
>>>>>> counter on stack to avoid an allocation.
>>>>>>
>>>>>> But if we can't do with an on-stack object I'd much rather just embedd
>>>>>> the rcu_head in the hw_ctx.
>>>>>
>>>>> I think we can do that, please see the following patch which is against Sagi's V5:
>>>>
>>>> I don't think you can send a single rcu_head to multiple call_srcu calls.
>>>
>>> OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
>>> rcu_synchronize into blk_mq_tag_set.
>>
>> I can cook up a spin, but I still hate the fact that I have a queue that
>> ends up quiesced which I didn't want it to...
> 
> Why do we care so much about the connect_q?  Especially if we generalize
> it into a passthru queue that will absolutely need the quiesce hopefully
> soon.

The connect_q cannot be generalized to a passthru_q, exactly because of
the reason it exists in the first place. There is no way to guarantee
that the connect is issued before any pending request (in case of reset
during traffic).

We can use this API, but we will need to explicitly unquiesce the
connect_q which is a bit ugly like:
--
void nvme_stop_queues(struct nvme_ctrl *ctrl)
{
	blk_mq_quiesce_tagset(ctrl->tagset);
	if (ctrl->connect_q)
		blk_mq_unquiesce_queue(ctrl->connect_q);
}
EXPORT_SYMBOL_GPL(nvme_stop_queues);
--
