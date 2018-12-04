Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF56C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834EA2081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lc9e5sMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834EA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeLDP1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:27:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45659 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDP1k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 10:27:40 -0500
Received: by mail-io1-f68.google.com with SMTP id o5so7941240iop.12
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A9tg/TZfoRi46T/5QLmu+csxC6cl1yW14hEbSfRv7bw=;
        b=Lc9e5sMrZPOlz6Bf2vV73CaQ0xZPFmV8oPN7bKB8FPeLsYgfBRqyF/P1ILlGt+OHE3
         4lU6IdvYQakxuf8/qiHZ3pxYs+yDlLaByWFfSEbIbKhSZDIGoOYAIe+5+uGQ5rVpq5Cd
         5KH6I4f16EtivIzleYHJtmOdJpeRn6DTUlzPE1x4yJdjPThtUPH3ey+rt6wfjgsXpTXu
         z8lJtTxDt/RK2vMwowIt/raU96m89nNtZvpOwQJgFjxLrT8uDJBc4/lHMfU7M+WUiteJ
         74Od1Edry11QKlwAU0/gRtPwNQ9uRlcpp3ftzx70yW1k8bdZs70R91MSR/XXe1+14q1U
         /BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A9tg/TZfoRi46T/5QLmu+csxC6cl1yW14hEbSfRv7bw=;
        b=Gliqzo5z8kKDGt3ydufoKOgGMFhR1Q4w4IDDLlFH8ZmrrztFf6v3VPiCOdZwMnmCtJ
         GS6KbsYzuviSRFqS73tzUC11uJtmAne3Le1Exyukft3KO9psmj6fRAhfy0aaF67+lpnd
         dQ2xVSoZJdoOb6I8g//Sv1PWYBO9qPEO8VGrqZ8uFiKJjovExYepUTx1/jJoMKIpZjv+
         AF1Ogemw3TMj/muniEvz/IfYoRJh6CvfwH3cxh4s6hzGNTA2PcjtPKo0n32y0oGfeH6m
         xUv2oJGxnwRWNJyh1hGvX+DorRxontKe5ZbXhC4oIq27arM2aiQWc99h0NqNRdVebszk
         OySg==
X-Gm-Message-State: AA+aEWbX+cT/4R7P6pGEJoFJpV8o4WpgqtH7zcZ3WhnxJKZxpa+dLzTJ
        1Q1VlPSJkaBh0bFL4kiGZ9bzHQ==
X-Google-Smtp-Source: AFSGD/VCXg6+AEXSnTguhXqYCXKoStAbZiuRdvVXGWlPB3HVXTbxPrDNqEQD8ucIPPdlYk9UmLHaCg==
X-Received: by 2002:a6b:5c14:: with SMTP id z20mr17218387ioh.39.1543937260025;
        Tue, 04 Dec 2018 07:27:40 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y13sm6361782ioa.56.2018.12.04.07.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:27:39 -0800 (PST)
Subject: Re: [PATCH 10/27] aio: don't zero entire aio_kiocb aio_get_req()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-11-axboe@kernel.dk> <20181204144921.GE3180@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <466fed7f-3e89-c659-f150-3fd1a59d0271@kernel.dk>
Date:   Tue, 4 Dec 2018 08:27:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204144921.GE3180@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 7:49 AM, Christoph Hellwig wrote:
>> -	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
>> -	if (unlikely(!req))
>> -		return NULL;
>> +	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
>> +	if (req) {
>> +		percpu_ref_get(&ctx->reqs);
>> +		req->ki_ctx = ctx;
>> +		INIT_LIST_HEAD(&req->ki_list);
>> +		refcount_set(&req->ki_refcnt, 0);
>> +		req->ki_eventfd = NULL;
>> +	}
>>  
>> -	percpu_ref_get(&ctx->reqs);
>> -	INIT_LIST_HEAD(&req->ki_list);
>> -	refcount_set(&req->ki_refcnt, 0);
>> -	req->ki_ctx = ctx;
>>  	return req;
> 
> Why the reformatting?  Otherwise this looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Probably just the (over) abuse of likely/unlikely in aio.c. I can get
rid of it.

-- 
Jens Axboe

