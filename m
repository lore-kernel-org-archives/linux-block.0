Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6B3C433E1
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 03:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC96C61969
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 03:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhC2Dti (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 23:49:38 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:37592 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhC2Dtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 23:49:32 -0400
Received: by mail-pf1-f178.google.com with SMTP id c204so9023948pfc.4
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 20:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2i2Dk+hgYCL9epAzL/Kxer2dtTcmueBGYlHSczOHNKo=;
        b=XuaysFqDLOcbjrjZFzLoTNPRAi4PsNruEtleaXbEuXnF9GNfcar7VJJsHy0/ED24KU
         m+G7jahUtUp8IFPjA6oDMLqDgJ/aXQ/XCYaqSAe+fOg7y6gsamQxUj8mjxHQLNNmzHjD
         ftp5gOF0JbaqiOyF+DjHK0jVt8IsB/AGARIgxuNKE0udkTaZPFVnXwgw7Ifvky3p2gvP
         w9j64SCeZYfIxeSC5PXvXtsStm30Sa25HkfQsEr6Clgg/XPsWPE9MCdGrFONezVcp41P
         olzVGZxoVd7SsQhMuiAnQo1kV7ZTLXk5DO1N1EZxy4upsesGnUj/wrB6+NG9eBppyPDO
         dg1Q==
X-Gm-Message-State: AOAM531fQ1syjr3zfBT9Sz3qDRQp/m5tPkaISnI17+htQPrEEtKKLjAM
        +WpUt75gDvbkS99I5qB1OFk=
X-Google-Smtp-Source: ABdhPJx0exB69J/msMSTtjL4VkwvRh7vTvGpIg26xIxzFWqnFCNdSeDFgIM9D1VSzIPj9zUILjGA0g==
X-Received: by 2002:a65:6208:: with SMTP id d8mr21843697pgv.365.1616989772072;
        Sun, 28 Mar 2021 20:49:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7123:9470:fec5:1a3a? ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id a15sm14117929pju.34.2021.03.28.20.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 20:49:31 -0700 (PDT)
Subject: Re: [RFC PATCH] block: protect bi_status with spinlock
To:     Keith Busch <kbusch@kernel.org>, Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        ming.lei@redhat.com
References: <20210329022337.3992955-1-yuyufen@huawei.com>
 <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a6a145cc-1ee6-5f13-1bf3-2d3083362c04@acm.org>
Date:   Sun, 28 Mar 2021 20:49:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/21 8:02 PM, Keith Busch wrote:
> On Sun, Mar 28, 2021 at 10:23:37PM -0400, Yufen Yu wrote:
>>  static struct bio *__bio_chain_endio(struct bio *bio)
>>  {
>>  	struct bio *parent = bio->bi_private;
>> +	unsigned long flags;
>>  
>> +	spin_lock_irqsave(&parent->bi_lock, flags);
>>  	if (!parent->bi_status)
>>  		parent->bi_status = bio->bi_status;
>> +	spin_unlock_irqrestore(&parent->bi_lock, flags);
> 
> 
> I don't see a spin_lock_init() on this new lock, though a spinlock seems
> overkill here. If you need an atomic update, you could do:
> 
> 	cmpxchg(&parent->bi_status, 0, bio->bi_status);

Hmm ... isn't cmpxchg() significantly slower than a spinlock?

Thanks,

Bart.
