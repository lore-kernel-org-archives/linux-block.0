Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F41BC43461
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 14:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9361613DD
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 14:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhEQOOy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 10:14:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238408AbhEQOMX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 10:12:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621260665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHKWqf4XFF6yDcLUh1zTWK08SLSurVXp3htCEcxP5vE=;
        b=E/smndzrybtZpCiCz9AUTl7jnNh2pkguz/VZt6nPJHhKIgSHg5e+tw9ARnJDn1EcyK2+cn
        lFybTRXBH2ocNsv/+wp+GGviqEPear+M6xfRObO9q4jdTFrboawxEbyCMWSdUqoavyooLm
        QhEcb3OMdpcAQwB8NU5o7YmQaot/KFs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3985B226;
        Mon, 17 May 2021 14:11:05 +0000 (UTC)
Subject: Re: [PATCH 4/8] xen/blkfront: don't trust the backend response data
 blindly
To:     Juergen Gross <jgross@suse.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-5-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <315ad8b9-8a98-8d3e-f66c-ab32af2731a8@suse.com>
Date:   Mon, 17 May 2021 16:11:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513100302.22027-5-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.05.2021 12:02, Juergen Gross wrote:
> @@ -1574,10 +1580,16 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
>  	spin_lock_irqsave(&rinfo->ring_lock, flags);
>   again:
>  	rp = rinfo->ring.sring->rsp_prod;
> +	if (RING_RESPONSE_PROD_OVERFLOW(&rinfo->ring, rp)) {
> +		pr_alert("%s: illegal number of responses %u\n",
> +			 info->gd->disk_name, rp - rinfo->ring.rsp_cons);
> +		goto err;
> +	}
>  	rmb(); /* Ensure we see queued responses up to 'rp'. */

I think you want to insert after the barrier.

> @@ -1680,6 +1707,11 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
>  	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
>  
>  	return IRQ_HANDLED;
> +
> + err:
> +	info->connected = BLKIF_STATE_ERROR;
> +	pr_alert("%s disabled for further use\n", info->gd->disk_name);
> +	return IRQ_HANDLED;
>  }

Am I understanding that a suspend (and then resume) can be used to
recover from error state? If so - is this intentional? If so in turn,
would it make sense to spell this out in the description?

Jan
