Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE5C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409EA2146D
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XeVgyEcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409EA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeK3EIb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:08:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40942 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeK3EIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:08:30 -0500
Received: by mail-io1-f66.google.com with SMTP id n9so2144707ioh.7
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WViLNR3GVSvzR0xL1UYGQkvTcnDaKw+4VZurOf7WlB4=;
        b=XeVgyEcSUkyQsHsJk3I2eAihwxYqCrBp3XVIgvcaX/f9pC22uG+yFsO7TpiadFHZaI
         Xs86nl4KidjHmKUrlgyidi+F3Y6r2GEM7beri/999MHb/uopfqZaZ++onMwRG5wEvnHE
         x0Va37LwHuQeaUH5JYeAzQMXFQiEe9t8HcDSQnho1LR3uf4IJzKHlOAiNBVMZ/GwTLz8
         3f35Oc5syQ7bLP3L5Ex10NVGiDhbf+uLKlb+BcFjtNzn3kNrem6popqvTTgVbd5xVdjK
         MsA/K3x/0xnPivDA4aS859i74epLhrzSq8AHkATJaofLVAlU+k+0byxUAaY/CYQaiLqB
         pCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WViLNR3GVSvzR0xL1UYGQkvTcnDaKw+4VZurOf7WlB4=;
        b=UZdsy87+rZLXKRhnYKibRP+4m6yrEGR+HWf6WS3iohC9rPDyaM8++LJyMcFK7YSyVF
         BKwADDtjckeb5OrY4cuwSxVxhlzP36v7SeUghVnq8ViBGti79XAx5aCauomBu0WvwXO9
         PlHYK+wUR2EMYY6TaO1F15NRjeBrLRPnyX7I/wuiZa0Uc1b4R5hMqvaxFnxsYTdUtbeh
         HVUQ8xDFfE0LCd8Mnr9TJ2JkRqtse6pnjjBdSPvmtw5wNR/dybibuz+ux/txUmMJrCx/
         CMp5gx2bsRazxxRJlfO7HWIaWQcKOVKl90HhGXt4RZf+hMW8SOMRgEO2iXgEKclR0orv
         7iEg==
X-Gm-Message-State: AA+aEWYfbxozFr/d18b/nuT2IjaFDLgx09NTLbNWy5Ax+MNVMVC7i0gd
        uCIUWJeD3jpRbUx/nvlQvzQNnw==
X-Google-Smtp-Source: AFSGD/UmBmwBiSjDEl/Ljg3ortPuN+QESc4oqcYg05YRgdCFyYM2GPyDtEMESyFz3/oPyt9uZrX0FQ==
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr1860824ios.146.1543510947975;
        Thu, 29 Nov 2018 09:02:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t7sm902282iom.27.2018.11.29.09.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:02:26 -0800 (PST)
Subject: Re: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
 <20181129154713.GC7234@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
Date:   Thu, 29 Nov 2018 10:02:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129154713.GC7234@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 8:47 AM, Christoph Hellwig wrote:
>> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
>> +{
>> +	if (++index == nvmeq->q_depth)
>> +		return 0;
>> +
>> +	return index;
>> +}
> 
> This is unused now.

Huh, wonder how I missed that. GCC must not have complained.

> Also what about this little cleanup on top?

That looks good, I like it. With that, can I add your reviewed-by? I'll
run a sanity check on it first.

-- 
Jens Axboe

