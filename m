Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4FCC433FE
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB6C207CD
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgG1Deu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:34:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35441 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgG1Deo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 23:34:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id f1so16259336wro.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 20:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sc4FAowpJskWJ+7n9XI9nCyRNop6XuNUwGIt4ML6M/A=;
        b=aFrZm5nWwrdJk8t7HTnmNwMvRVXOF1/8Hu8voUOVYk3S43cjXtOnJT5x8R0rerIuU7
         hmCQgF5UDXJmpPhpLhldrm0E4JymrqLCTzXL2wpJHA0Jczs472fLqceVLuOjqXi8Dr4x
         cMPEBNGcMAj7S3GExVq3BqlfKS1DS3qjOMIYcn1By5DXIZ8uVyhvCyeesSqfO5aHCrks
         2e7Dq+1BqEw9rwG7/zVZALJXSTTkp8g/IHbONlv22sA2V4Mw7NS52e4WmDDV7zCZ65c0
         8+Yntaq4c0ergjWh9HnIZxB2bWbTJN794rMN0VJI4mc1EvtrpCahZ8KwxGTy4BYxl9O2
         xiBA==
X-Gm-Message-State: AOAM530VXZPk3kTV9aziXNCVE6qsKHhsIszRFWGYjZyGZS0FUoNGaPPr
        773F1IoAPoN7SexuhaWCDgM=
X-Google-Smtp-Source: ABdhPJweAqP1gUP39I9aM0lr1EIcnJ+ArNYrUMkbnOTOyRhw7tbtrNLzoyA/wUWYeb3UoA1BXzezSQ==
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr22762126wrq.199.1595907282762;
        Mon, 27 Jul 2020 20:34:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id t25sm1898194wmj.18.2020.07.27.20.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:34:42 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-3-sagi@grimberg.me>
 <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
 <5d11e813-b0dd-3082-366b-176717cdf3a6@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <92b821a6-a774-d85b-2711-418d36fc10d0@grimberg.me>
Date:   Mon, 27 Jul 2020 20:34:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5d11e813-b0dd-3082-366b-176717cdf3a6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> All controller namespaces share the same tagset, so we
>>> can use this interface which does the optimal operation
>>> for parallel quiesce based on the tagset type (e.g.
>>> blocking tagsets and non-blocking tagsets).
>>>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   drivers/nvme/host/core.c | 14 ++------------
>>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 05aa568a60af..c41df20996d7 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>>>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>>>   {
>>> -    struct nvme_ns *ns;
>>> -
>>> -    down_read(&ctrl->namespaces_rwsem);
>>> -    list_for_each_entry(ns, &ctrl->namespaces, list)
>>> -        blk_mq_quiesce_queue(ns->queue);
>>> -    up_read(&ctrl->namespaces_rwsem);
>>> +    blk_mq_quiesce_tagset(ctrl->tagset);
>>
>> Rrr.. this one is slightly annoying. We have the connect_q in
>> fabrics that we use to issue the connect command which is now
>> quiesced too...
>>
>> If we will use this interface, we can unquiesce it right away,
>> but that seems kinda backwards..Io queue and admin queue has different 
>> treat mechanism, introduce
> blk_mq_quiesce_tagset may make the mechanism unclear. So this is
> probably not a good choice.

The meaning of blk_mq_quiesce_tagset is clear, the awkward thing is
that we need to unquiesce the connect_q after blk_mq_quiesce_tagset
quiesced it.

I'm thinking of resorting from this abstraction...
