Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C2C433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D572072E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgG1DZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:25:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34755 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgG1DZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 23:25:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so16816924wrw.1
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 20:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/kGwtuYOiekxizlErsTnqhYTOEp56sdiJdDnuI594A=;
        b=gKJInvO/LO/UpJDRsgCl5vu028xBMhG+YHyUdP2efgBFy/B0dajlgxL4P+r5Du6t4R
         kpcbP3pJSmxLzd7SX7OHmE2I2pUL5l85Irar12rT0aaMmJ+Ai1jX0uABbwOYvFkNK1Pm
         2c+jAfNugqF1ZcPhyQNyxz7NW47XQBXFCxg1ymQubvkDVfzzaiLCyMbZZP/NucRnZ7sW
         YJmtsf8ZVuuxN+oCEKzqoRCaL0jHb5aD6Bxi6VDe1stWeJ+StzAc4vlE9JOYinVRXF3G
         ZEgGQcYL/qB2sfDO6tN9YYoTRXQSgntiswXawsR3HCrINJWGLrx/wef/o4oW/VNzA0f2
         dYYA==
X-Gm-Message-State: AOAM533cL6So87aVw+KmoGELZ5ukHxxAZjd6Mv2Gdtr1KbJ7C/teYePu
        kTsQR+vlFSGkHCbsdRd8aaM=
X-Google-Smtp-Source: ABdhPJwaDO671D7E8IsibFT67dC+QkKRci0izpvrkXdlCCFDd5282KbIVLCZuy8n8QOVjjECWOBq1Q==
X-Received: by 2002:a5d:6cd0:: with SMTP id c16mr23319265wrc.121.1595906738224;
        Mon, 27 Jul 2020 20:25:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id k1sm6582519wrw.91.2020.07.27.20.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:25:37 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <65634c0a-4f40-ddba-2dbd-6902b902abeb@grimberg.me>
Date:   Mon, 27 Jul 2020 20:25:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728014038.GA1305646@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> drivers that have shared tagsets may need to quiesce potentially a lot
>> of request queues that all share a single tagset (e.g. nvme). Add an interface
>> to quiesce all the queues on a given tagset. This interface is useful because
>> it can speedup the quiesce by doing it in parallel.
>>
>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
>> in parallel such that all of them wait for the same rcu elapsed period with
>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
>> sufficient.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/blk-mq.h |  4 +++
>>   2 files changed, 70 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index abcf590f6238..c37e37354330 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>>   
>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	blk_mq_quiesce_queue_nowait(q);
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>> +		if (!hctx->rcu_sync)
>> +			continue;
> 
> This approach of quiesce/unquiesce tagset is good abstraction.

I'm thinking I don't want to use this interface, it quiesce the
connect_q hctxs as well and then I need to unquiesce them which is
awkward...

> Just one more thing, please allocate a rcu_sync array because hctx is supposed
> to not store scratch stuff.

Sorry, I object to any interface that returns back the rcu_sync
allocation. Its just awkward. really..
