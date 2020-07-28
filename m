Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A46C433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 00:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1153420786
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 00:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgG1AMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:12:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39815 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgG1AMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 20:12:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9so8999802plx.6
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 17:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfVP1kKblrSBABZwodiPANe16VZ1uWUWSsP7qtO4DEA=;
        b=nHLn3eqoaSPefvI2FN3EE+jNDi8hRfMYHHTHlbhng4kcIJk+4Azpy1/8QHGAU8kHAt
         CTZxtTDfOYu2lmdWeIKcwHtKf0wWX2BHUlDhm8jrzqbexCCt5RZBPS79awqsP2xSU9uO
         a82Y+PNTLe0r6Jl8SESDVRtff1Ad4NDtrXWaV97PZ3G7MVbXYpcBJkczJ+bKCx2WKubS
         Dl/fEH2y2aKkZx9m8SBo5Fc2UdAfPo+tIH69jVpdcJ+vfgLOaTsrq2vhSQnZdB2znnkU
         hZr6vNvYbeG3W2XV4Ur7xRNdfr0823VMOGsRTWP0TIZdVS9WiTAQ6+h/lq/H2GqfqUEL
         kjyw==
X-Gm-Message-State: AOAM533LUgKeP8VT4yWo86z/cx5zTOdye8hLUSCNuhSbxbvl7528rAr0
        ZcrRKWp2nFZN9ztqWahEWP7QsiIE
X-Google-Smtp-Source: ABdhPJzHhR5439Dn4jhOGcw1RPSH9qal5fvG+CP0DRNjI6vTJgIuwRww1QwIiCaEezccXido6gBBnw==
X-Received: by 2002:a17:90a:a68:: with SMTP id o95mr1687505pjo.148.1595895172505;
        Mon, 27 Jul 2020 17:12:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id j5sm15230788pgi.42.2020.07.27.17.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 17:12:51 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200727233241.GA797782@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <376f8e3d-a8db-9810-0e5b-a022696a893f@grimberg.me>
Date:   Mon, 27 Jul 2020 17:12:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727233241.GA797782@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +static void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>> +		if (!hctx->rcu_sync) {
>> +			synchronize_srcu(hctx->srcu);
>> +			continue;
>> +		}
>> +		wait_for_completion(&hctx->rcu_sync->completion);
>> +		destroy_rcu_head(&hctx->rcu_sync->head);
> 
> Leaking rcu_sync, and not clearing it across quiesce contexts. Needs:
> 
> 		kfree(hctx->rcu_sync);
> 		hctx->rcu_sync = NULL;

Good catch, will wait for some more review and submit a v6.
