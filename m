Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58453C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2111622360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d0cZnYq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2111622360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeKOBfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:35:00 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38526 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeKOBfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:35:00 -0500
Received: by mail-it1-f196.google.com with SMTP id k141-v6so24445222itk.3
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4zIANd91zqa+vDFq63YXlKFao7eO7ULYamv5TUdchEM=;
        b=d0cZnYq5fuzN3jT3YF8P5zS7+PM2nYeeIkw1o9H5D98FYzZGuV9uJNErDTVGX6NGLb
         GBJ2u0Gf0uwVQRIWORgP0Ca2pPbzMSNbBG3zN1iLQ84alkiCW7Q+YnP+P1W3S2JO5nSR
         Ugc3p4XZcfEj+W0bU8naVJucgXb+29rd2GgtM4NY2snbM/cfvfTNpDviVbfUPjbHKMCt
         Mt1zNdfhJWqBGPHgUAQc73MlME/QO2ZIs0/YiCLlceJ63WKL3AViBUGiHqNs++PTUDFY
         2gDuxGY/cwpZNFotxsXsFqzD0dpD8ErqlmNN22KZU5BznfjPC7EWJ4TNVqzPH6kS87lr
         GOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4zIANd91zqa+vDFq63YXlKFao7eO7ULYamv5TUdchEM=;
        b=le6kbSrAI2Rb7h5CB6ZojR97SuktDiSjJvVMh4xeYjw/n+hk8pMgampy6dmAqJ6zPd
         hq2PemwsxIDp2LXDStcUYujvAwEzE6+UGhkKJJXrrKzwAFuQRRRsJQwgvXVwyF0tSYjv
         7WhUx5O6a6tyZkL6fn3wIpCi/D7YF8mHOsSye6O3t37AYDGyygClcZPacKhtortVbvNX
         3//JeJBP7WYobjZqAyk2zEHeKYDWft1gUWeFKUCZzlTuvEGaJzcvqMZlztlBwacT6y3f
         FqfgFRfZOVM9K2FIA+TaxD03MBj7HveyCK/xikWeS5onRNd6f+7ssvVJAV2RjM3VUm5Z
         otCg==
X-Gm-Message-State: AGRZ1gJUQOEAAd2d8qXkqe8CsPz9XDTR5ttK/dKiA3KnqDkrEf52dseU
        NQw6665xmi4l0cdNZjdBbsn4eQ==
X-Google-Smtp-Source: AJdET5fSIp/PFXnAfX8IXfZVrwZhQM7afAK42lMM9Xs454Tj4zhaaakt4D+zavzZuEcuoK/twjm9zw==
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr2448410ita.71.1542209476999;
        Wed, 14 Nov 2018 07:31:16 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o74sm4097984itc.44.2018.11.14.07.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:31:15 -0800 (PST)
Subject: Re: [PATCH 1/6] nvme: don't disable local ints for polled queue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
 <20181114084322.GA14954@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fdc36207-ee35-e262-c0b9-1592be817ac3@kernel.dk>
Date:   Wed, 14 Nov 2018 08:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114084322.GA14954@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 1:43 AM, Christoph Hellwig wrote:
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 6aa86dfcb32c..a6e3fbddfadf 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1061,15 +1061,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>>  
>>  static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>>  {
>> +	unsigned long flags = 0; /* gcc 7.x fail */
>>  	u16 start, end;
>> -	bool found;
>> +	bool found, has_irq;
>>  
>>  	if (!nvme_cqe_pending(nvmeq))
>>  		return 0;
>>  
>> -	spin_lock_irq(&nvmeq->cq_lock);
>> +	/*
>> +	 * Polled queue doesn't have an IRQ, no need to disable ints
>> +	 */
>> +	has_irq = !nvmeq->polled;
>> +	if (has_irq)
>> +		local_irq_save(flags);
>> +
>> +	spin_lock(&nvmeq->cq_lock);
>>  	found = nvme_process_cq(nvmeq, &start, &end, tag);
>> -	spin_unlock_irq(&nvmeq->cq_lock);
>> +	spin_unlock(&nvmeq->cq_lock);
>> +
>> +	if (has_irq)
>> +		local_irq_restore(flags);
> 
> Eww, this just looks ugly.  Given that we are micro-optimizing here
> I'd rather just use a different ->poll implementation and thus blk_mq_ops
> if we have a separate poll code.  Then we could leave the existing
> __nvme_poll as-is and have a new nvme_poll_noirq something like this:

Yeah good point, gets rid of those branches too. I'll make that change.

> And while we are at it:  I think for the irq-driven queuest in a
> separate queue for poll setup we might not even need to take the
> CQ lock.  Which might be an argument for only allowing polling
> if we have the separate queues just to keep everything simple.

We can definitely move in that direction, I'll take a look at what
is feasible.

-- 
Jens Axboe

