Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4CEC433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 22:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417D8207F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 22:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG2Whf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:37:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36861 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Whf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 18:37:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so4474294wmi.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 15:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QvdUYXImQ58NA6zv+esPbk8WyQMuh573WddFfKRbd1M=;
        b=O7PPgw5R209AtJB0TENvf/e3n3M3s9M6VkWFxI/NEXDTYkKz+emqPmC2weFpvl/d8J
         89DQaxg4EgDqTuafbi8/ubH/THX9fkIMGkwMZEzPGCu33TWmh76BR8VDshM9zESxu2wT
         JBiOweYoz+T6NChusaXtOd2yPsPM6yYqFb8a/0wM40jqvf178vP1Tg8I9sYC/BbMHTLk
         dCVBbYRLR6IDCxCQPvN2T26slFzgZ+EjFRcVXi0EuaXhl6dBaSUfmFahdZy2u8bz+anq
         kjQ4WmSrw1W/pz0LlG8JGdoQHWhG1nqlf2/OP5JMYmZWsPNLcUgy2mMY3dwmRxCi5mej
         yqRg==
X-Gm-Message-State: AOAM532gcnV//eL5Ustn/414PwPEyEn69T+CDVCXuycwGW469dKGQ+gh
        1xMSTWXbQCEUkhEQr4EHhnI=
X-Google-Smtp-Source: ABdhPJwB3tBtR/t7ObhTVNaO69MhuhL0FLshyQoP7/xVe2rC2NpLvNpBMsirBxpXwDj7NYsZEE80Lw==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr10396970wmc.162.1596062253445;
        Wed, 29 Jul 2020 15:37:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:11db:a722:81b1:7143? ([2601:647:4802:9070:11db:a722:81b1:7143])
        by smtp.gmail.com with ESMTPSA id k4sm8072024wrd.72.2020.07.29.15.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 15:37:32 -0700 (PDT)
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
 <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
 <20200729154957.GD1698748@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f3ead535-070d-40ec-08b8-56e2c1cd7ba4@grimberg.me>
Date:   Wed, 29 Jul 2020 15:37:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729154957.GD1698748@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
>>>> section during dispatching request, then request queue quiesce is based on
>>>> SRCU. What we want to get is low cost added in fast path.
>>>>
>>>> However, from srcu_read_lock/srcu_read_unlock implementation, not see
>>>> it is quicker than percpu refcount, so use percpu_ref to implement
>>>> queue quiesce. This usage is cleaner and simpler & enough for implementing
>>>> queue quiesce. The main requirement is to make sure all read sections to observe
>>>> QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
>>>>
>>>> Also it becomes much easier to add interface of async queue quiesce.
>>>
>>> BTW, no obvious IOPS difference is observed with this patch applied when running
>>> io on null_blk(blocking, submit_queues=32) in one dual-socket, 32cores system.
>>
>> Thanks Ming, can you test for non-blocking on the same setup?
> 
> OK, I can do that, but this patch supposes to not affect non-blocking,
> care to share your motivation for testing non-blocking?

I think it will be a significant improvement to have a single code path.
The code will be more robust and we won't need to face issues that are
specific for blocking.

If the cost is negligible, I think the upside is worth it.
