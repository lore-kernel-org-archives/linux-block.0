Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E540C433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E46207E8
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 15:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2Pme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:42:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54462 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2Pme (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 11:42:34 -0400
Received: by mail-pj1-f65.google.com with SMTP id mt12so2033691pjb.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 08:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=URQcAfOf1ouF+y8jPF7NpxLOZy8xYKuPUwawJ7U2yPQ=;
        b=GMhsazePZxr5o0v555L7diHBkytAqTqohcKizkNbkignAF4UbPvhSD8AfXpVzba1h4
         DRYdk4Ktl/j/MjCaANKJTw2WSbwBnnmY56SUG/Jqk1lBO8nBkwA+CY2RPmeXI2NKuU/Y
         /xHPLTCA709K5YQk005lt1i4dr5b0b5zZFkL2pkZmz4BSYp4yosdgHOqASxu0M6vUcwz
         E3vxrR/69UFBLHMuZAmIfJSvrUo34O47AGQy2HC4rEFhEBwpvK81w1a6r99QEuLivIgW
         81FtFXjOrqj3/Hz+jZ53DS68v7tEs1LN7qeJp39m6UhQAvzwCYTykZ1QI1Nw19/hdH+8
         63Wg==
X-Gm-Message-State: AOAM5308FBbIsjouvx8uIbxU8ec+hTqXJ/T0Lrnqmyj/0nKXbuGsXcWQ
        +jXZOCeGsix1oShflnZrdaOtxQvv
X-Google-Smtp-Source: ABdhPJyDVNZMmMQG10id3lfhZhKjGZpmoeWB2+XX2u2MCydnkvsjmrXBKHXnx9eKNA0AvkRvqe0i/Q==
X-Received: by 2002:a17:90b:1254:: with SMTP id gx20mr1147627pjb.117.1596037353578;
        Wed, 29 Jul 2020 08:42:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8475:db3f:c2a2:c61c? ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
        by smtp.gmail.com with ESMTPSA id b13sm3071839pgd.36.2020.07.29.08.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 08:42:32 -0700 (PDT)
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
Date:   Wed, 29 Jul 2020 08:42:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729102856.GA1563056@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
>> section during dispatching request, then request queue quiesce is based on
>> SRCU. What we want to get is low cost added in fast path.
>>
>> However, from srcu_read_lock/srcu_read_unlock implementation, not see
>> it is quicker than percpu refcount, so use percpu_ref to implement
>> queue quiesce. This usage is cleaner and simpler & enough for implementing
>> queue quiesce. The main requirement is to make sure all read sections to observe
>> QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
>>
>> Also it becomes much easier to add interface of async queue quiesce.
> 
> BTW, no obvious IOPS difference is observed with this patch applied when running
> io on null_blk(blocking, submit_queues=32) in one dual-socket, 32cores system.

Thanks Ming, can you test for non-blocking on the same setup?

I can test some reset storms during traffic.
