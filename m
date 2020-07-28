Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3662C433E3
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 07:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F1522B3F
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 07:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgG1Hsm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:48:42 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38169 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgG1Hsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 03:48:41 -0400
Received: by mail-pj1-f66.google.com with SMTP id e22so3900556pjt.3
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 00:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FO3oZnFQw3BE/aK5FD2/kGmXgS1zOp4LbjFEtdo3Kss=;
        b=LntcwYwUsYSUNNlTEWGBGBVHAIIYqMXjpRfx6Pbvso1hT7HJFsE5o/LKoDeqshCac5
         MIO64+GlmlkdMnSLQku/ntVmLQ8GxU9nfEjcEKIp59BpGECioPQ3RUuDV8EqgEuixStD
         /x9QqDiUMDaATPQaSiNhfwh7XsEsgRBsK1HO2j241Da/Dg3a5qUiXohTIp687Bqblj35
         qlXd0UTSDrjrtH1jGeNAt/1EHKymoA21bnfGnMwf3uuHrjKqHP4D+2MUHjwzH4TNLIm/
         cWyDTG2CTmPbo4Hq0CatKXEJr58WtIR6y8qQe3217XBxX20mLsYVVKUVXgYckow1eB/S
         VW8g==
X-Gm-Message-State: AOAM531F+y8rrh0wMcJOqof3JsUMgCh7TFL466HOLYPDdmLtr+hserF7
        dcZSSQHBYZJzzfPwFDTpeYg=
X-Google-Smtp-Source: ABdhPJxiF2YrVEmDeu79GtOv5OlVjYPIrvmpdEyZkbJPAMTCqudVVziGKdUAmW3UYNHmAKI5+Eva1Q==
X-Received: by 2002:a17:90b:1249:: with SMTP id gx9mr3200688pjb.149.1595922521144;
        Tue, 28 Jul 2020 00:48:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id s23sm2000848pjs.47.2020.07.28.00.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 00:48:40 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <54c7f095-c112-eaa7-3c69-65b4b48f2688@grimberg.me>
Date:   Tue, 28 Jul 2020 00:48:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728071859.GA21629@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> I like the tagset based interface.

Even that we need to unquiesce back the connect_q?
See my comment on v5. Kinda bothers me...

   But the idea of doing a per-hctx
> allocation and wait doesn't seem very scalable.

I belong to this camp too..

> Paul, do you have any good idea for an interface that waits on
> multiple srcu heads?  As far as I can tell we could just have a single
> global completion and counter, and each call_srcu would just just
> decrement it and then the final one would do the wakeup.  It would just
> be great to figure out a way to keep the struct rcu_synchronize and
> counter on stack to avoid an allocation.
> 
> But if we can't do with an on-stack object I'd much rather just embedd
> the rcu_head in the hw_ctx.
