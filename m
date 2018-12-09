Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEABC07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84872082F
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJeIq3Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84872082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLIUcL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44903 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeLIUcL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 15:32:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so4325731pfh.11
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 12:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cpE9MAYxNuzs0PEOSRMUcGQxMusQrCxN8HutNVv+HSA=;
        b=LJeIq3LvFs13Bo8xUjuJQIkBbs1pxwu7ihvAR5oiGddOGSiTiJJQaijGtJvZXUI+7p
         c0FEUNmantFYDXwzu+qCyHyV8eWjzeQlJc7bSc0Kz23TFezmKyZoG45ZWQQsfuqjvfDe
         xoMPe85pMpoe4PBrQVhthSg01sAI4YMp8+ALNQxRurkO5CUZZSFRNwYn6vvkp1/USxNH
         ZJThTV6aE9oqqSBDn0xp7BCEPDSZOG7+lHL9uaFPaIOa365X2cnA3gBuc14An0auP8yb
         Y4Cfcur60dCNcWuaKOwnqAy1QF4kLStsYPTTaK7JXUBblMnJ/aWps9pCoxWPQhdPgVCQ
         zv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpE9MAYxNuzs0PEOSRMUcGQxMusQrCxN8HutNVv+HSA=;
        b=nOIxq3hpR2bsvaloeBxmaxqCnIoDnkAYXaDjUR1zp4q0rF4KFvL6OoSuDinPLZUDgn
         PJcnDHeZ/zFlWZJZlP7bKWtXUmVdAxlMGOLvE0VFIV0ihyU8Id7Zn/dpVV8tTk81WitC
         +ofTT7UUMscO5pm0kw6HjA+69xS6QkNem/OGbaRrS7c+YXHsfWokQ7k8gywx/MkEwWLs
         xCkLlMIL+fhSlVNckTWQeza2xEb2V0ziNPs+nI5/gsTE0cR6ILZRnpbq6W0SMTlAUIVo
         8b4EaOZdKkV1+Jby95dJS1JwsUpxN9Ut/OvS24sM/APO2fBLimYX9/Un8/m+oi4QAnCw
         KZmg==
X-Gm-Message-State: AA+aEWbNL6CMI+f9s1aur/JIzpQqJ2SJZeADD6+xAuPf5j9kKf6ojkSB
        WsrcMGIbd9T+21y+zF1eyc8=
X-Google-Smtp-Source: AFSGD/VnfQDfjbFlPfCs01YXXqfJM7/DtjtKrcocXfHye4bizHNfIqhWG0XDFSnaTM787kT/XKwUjw==
X-Received: by 2002:a62:75d1:: with SMTP id q200mr9851283pfc.254.1544387529821;
        Sun, 09 Dec 2018 12:32:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k15sm15793177pfb.147.2018.12.09.12.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:32:08 -0800 (PST)
Subject: Re: [PATCH] nvme: fix irq vs io_queue calculations
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
References: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5a2c709d-19e8-ee51-dfb6-c681d2fbd068@roeck-us.net>
Date:   Sun, 9 Dec 2018 12:32:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 10:21 AM, Jens Axboe wrote:
> Guenter reported an boot hang issue on HPPA after we default to 0 poll
> queues. We have two issues in the queue count calculations:
> 
> 1) We don't separate the poll queues from the read/write queues. This is
>     important, since the former doesn't need interrupts.
> 2) The adjust logic is broken.
> 
> Adjust the poll queue count before doing nvme_calc_io_queues(). The poll
> queue count is only limited by the IO queue count we were able to get
> from the controller, not failures in the IRQ allocation loop. This
> leaves nvme_calc_io_queues() just adjusting the read/write queue map.
> 
> Reported-by: Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7732c4979a4e..0fe48b128aff 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2030,60 +2030,40 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>   	return ret;
>   }
>   
> -static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
> +static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
>   {
>   	unsigned int this_w_queues = write_queues;
> -	unsigned int this_p_queues = poll_queues;
>   
>   	/*
>   	 * Setup read/write queue split
>   	 */
> -	if (nr_io_queues == 1) {
> +	if (irq_queues == 1) {
>   		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
>   		dev->io_queues[HCTX_TYPE_READ] = 0;
> -		dev->io_queues[HCTX_TYPE_POLL] = 0;
>   		return;
>   	}
>   
> -	/*
> -	 * Configure number of poll queues, if set
> -	 */
> -	if (this_p_queues) {
> -		/*
> -		 * We need at least one queue left. With just one queue, we'll
> -		 * have a single shared read/write set.
> -		 */
> -		if (this_p_queues >= nr_io_queues) {
> -			this_w_queues = 0;
> -			this_p_queues = nr_io_queues - 1;
> -		}
> -
> -		dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
> -		nr_io_queues -= this_p_queues;
> -	} else
> -		dev->io_queues[HCTX_TYPE_POLL] = 0;
> -
>   	/*
>   	 * If 'write_queues' is set, ensure it leaves room for at least
>   	 * one read queue
>   	 */
> -	if (this_w_queues >= nr_io_queues)
> -		this_w_queues = nr_io_queues - 1;
> +	if (this_w_queues >= irq_queues)
> +		this_w_queues = irq_queues - 1;
>   
>   	/*
>   	 * If 'write_queues' is set to zero, reads and writes will share
>   	 * a queue set.
>   	 */
>   	if (!this_w_queues) {
> -		dev->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
> +		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
>   		dev->io_queues[HCTX_TYPE_READ] = 0;
>   	} else {
>   		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> -		dev->io_queues[HCTX_TYPE_READ] = nr_io_queues - this_w_queues;
> +		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
>   	}
>   }
>   
> -static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
> +static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   	int irq_sets[2];
> @@ -2093,6 +2073,20 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>   		.sets = irq_sets,
>   	};
>   	int result = 0;
> +	unsigned int irq_queues, this_p_queues;
> +
> +	/*
> +	 * Poll queues don't need interrupts, but we need at least one IO
> +	 * queue left over for non-polled IO.
> +	 */
> +	this_p_queues = poll_queues;
> +	if (this_p_queues >= nr_io_queues) {
> +		this_p_queues = nr_io_queues - 1;
> +		irq_queues = 1;
> +	} else {
> +		irq_queues = nr_io_queues - this_p_queues;
> +	}
> +	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
>   
>   	/*
>   	 * For irq sets, we have to ask for minvec == maxvec. This passes
> @@ -2100,7 +2094,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>   	 * IRQ vector needs.
>   	 */
>   	do {
> -		nvme_calc_io_queues(dev, nr_io_queues);
> +		nvme_calc_io_queues(dev, irq_queues);
>   		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
>   		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
>   		if (!irq_sets[1])
> @@ -2111,11 +2105,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>   		 * 1 + 1 queues, just ask for a single vector. We'll share
>   		 * that between the single IO queue and the admin queue.
>   		 */
> -		if (!(result < 0 && nr_io_queues == 1))
> -			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
> +		if (!(result < 0 || irq_queues == 1))
> +			irq_queues = irq_sets[0] + irq_sets[1] + 1;
>   
> -		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
> -				nr_io_queues,
> +		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
> +				irq_queues,
>   				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>   
>   		/*
> @@ -2125,12 +2119,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>   		 * likely does not. Back down to ask for just one vector.
>   		 */
>   		if (result == -ENOSPC) {
> -			nr_io_queues--;
> -			if (!nr_io_queues)
> +			irq_queues--;
> +			if (!irq_queues)
>   				return result;
>   			continue;
>   		} else if (result == -EINVAL) {
> -			nr_io_queues = 1;
> +			irq_queues = 1;
>   			continue;
>   		} else if (result <= 0)
>   			return -EIO;
> 

