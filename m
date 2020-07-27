Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1AC433E1
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BFD2075D
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gumY9iKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgG0Vae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0Vad (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 17:30:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E7C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 14:30:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f185so4875573pfg.10
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Yi3V338uN2DHFSxpTCjmg82EGkr6UhtwNTzyF98WoM=;
        b=gumY9iKTo/cv7/WJEH5V6VG0+qO+ubyHBAYlM1bmQSCCktkobPj6yEcZw/sz3tHwdt
         JIOJ/gyYT8SBLguVXAEOyyCGqUO/44sKv2hPdpEPzNix7EMmokX5/ZLs95jTZDwLuIwi
         MLOCONAREQ4LFocb1aVN7mNYoNLAvYXjfkXF+mXiVhI5/WXgSzC5z9N+uaBEE7c7EAt9
         WCN5em9/MNvz0wa9+GB1OfsHRR2tK43/nqLq2bfS/2S2rLwR68D0FXYujkZWc1KO3cv8
         tdTE0B8kduHsj1xrSnyY3okou71u3TamIq1q0gEB4ZBk5rTo3hHFHd6S4izKiuuWFDHn
         NLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Yi3V338uN2DHFSxpTCjmg82EGkr6UhtwNTzyF98WoM=;
        b=R48ttXKOBtO3+4W70pABp7R1/UC5S/FWdVjADgXMLb4wJAVRir3DJ3Jr1cn0Y0H1lQ
         O7K3eHcx4gFmwVZ39afEkVqK5tKeBwxHsDvxy/00IAD8gCdg4iNUtcIZJXREEP/JHRNN
         3ubkUl4xIqhakhtFG7MoLg6zeuGIuHb/Eh+OMpQ8ubk2k5lQo+y/OLR8BSLxtvZtJA8q
         QOLNdx0M/q7VWnFKGoiF2xQbdpGNAbLHj/ikvPxRyOhHAxQ4G7gYN9bGzoUHeug8NN7F
         hgYHk4G0LDh5BZQtQ82AZACPkKsZHLkAr3lkoNvzqHLWvEzx/gKpnM6vBqVaAKHvn44O
         KBkQ==
X-Gm-Message-State: AOAM531tuuA9DBaQCouxbcTF3GEuqfbn0Q2KyAQzckiuayKInDybrB2c
        blVHC8DOFr6FaUNXcjjVvXHt6g==
X-Google-Smtp-Source: ABdhPJxnXR2P+K0MBF3zXH7c1/69/MgiK6FmzxDzerT6fFfcywUtpm9MzWKAnWo2GACGZWBL9WJ/lw==
X-Received: by 2002:a65:6650:: with SMTP id z16mr22644108pgv.161.1595885432947;
        Mon, 27 Jul 2020 14:30:32 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q17sm18307298pfk.0.2020.07.27.14.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 14:30:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
 <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
 <20200727212137.GA797661@dhcp-10-100-145-180.wdl.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8e79e31-05a8-2238-8aca-d4140d3d4412@kernel.dk>
Date:   Mon, 27 Jul 2020 15:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727212137.GA797661@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 3:21 PM, Keith Busch wrote:
> On Mon, Jul 27, 2020 at 03:05:40PM -0600, Jens Axboe wrote:
>> +void blk_mq_quiesce_queue_wait(struct request_queue *q)
>>  {
>>  	struct blk_mq_hw_ctx *hctx;
>>  	unsigned int i;
>>  	bool rcu = false;
>>  
>> -	blk_mq_quiesce_queue_nowait(q);
>> -
>>  	queue_for_each_hw_ctx(q, hctx, i) {
>>  		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>  			synchronize_srcu(hctx->srcu);
>>  		else
>>  			rcu = true;
>>  	}
>> +
>>  	if (rcu)
>>  		synchronize_rcu();
>>  }
> 
> Either all the hctx's are blocking or none of them are: we don't need to
> iterate the hctx's to see which sync method to use. We can add at the
> very beginning (and get rid of 'bool rcu'):
> 
> 	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING)) {
> 		synchronize_rcu();
> 		return;
> 	}

Agree, was just copy/pasting the existing code.

> But the issue Sagi is trying to address is quiescing a lot
> request queues sharing a tagset where synchronize_rcu() is too time
> consuming to do repeatedly. He wants to synchrnoize once for the entire
> tagset rather than per-request_queue, so I think he needs an API taking
> a 'struct blk_mq_tag_set' instead of a 'struct request_queue'.

Gotcha, yeah that won't work for multiple queues obviously.

Are all these queues sharing a tag set? If so, yes that seems like the
right abstraction. And the pointer addition is a much better idea than
including a full srcu/rcu struct.

-- 
Jens Axboe

