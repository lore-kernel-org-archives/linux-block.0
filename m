Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26829C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1E621104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tzWVPOEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1E621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeK3Esu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:48:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40520 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeK3Est (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:48:49 -0500
Received: by mail-io1-f68.google.com with SMTP id n9so2259765ioh.7
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ASrBaURYNLW0w7hE9c4f5a/t/3cRiaSBRXjmNO/XcE4=;
        b=tzWVPOEkz8IlNIzCfuia+Rb8oG8LRPrh/uFmCnxtH5xZBGw1hYZSmvzSZ+7wQl+9rH
         +5jxU9eNky6E4XqBPENMjUTh60rNRnXEd+fgEXw5LLKfwAgBu32VuT+ZHwwfeSG07IkT
         fj3TXSfNFj4puXX7kprvxdbbaMnr0LbmT+YNgGk3y6xWCt0zOxrFnHBgHdswKgL1LQ40
         W3w3r2pSFaZPtAD6jLCSKscYVVL+Juqce3nh/8tzsctToqZ8E1ighsV+jsNzVtbH4THu
         J66n+ZYF2/yJG+WaYrwc1/JtDeMzE88OrutAbwU2RBVNDmsUNx/QH5vfAiJV/OKALGFv
         RihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ASrBaURYNLW0w7hE9c4f5a/t/3cRiaSBRXjmNO/XcE4=;
        b=p7m36rd7oqN1dmYee6p7IRFEmAsCHEQ1YVPkdjpOaqYksHyA3ryPdTCODFfY+YuQfc
         Mev1q6FIJPZFZUeC0DeYkfdzUl3+PkCU+jJJocSy4FYLkQ4SCoa+FVxZAP/zc3WTyuAe
         Hh9XP8y/ilKKcOqAj90AxzWKqQaVceIxQQi2unzxS1c5BA+nZriAti+Ad5BnmQmlJkv5
         AfN0zrPKyCufVX+i0dYKfbKILwcnDTxk9N48aEO9e+Z1GA/km9hisHFFLko8v3LA5bec
         sN050XZfWC1o2RwLEienswjaumtK0rtJKBR96f88izJLAzAI04PONR3Co050tMJKc+0+
         yKag==
X-Gm-Message-State: AA+aEWbKlPhWSFv5+9F4Ejb30pabfeX47Kjx1AYUaX2UaBjpF5cmdtRe
        b0MH/4QqoIpvO0h6saWMu/DpFw==
X-Google-Smtp-Source: AFSGD/Vg1e/+KDRpoCXoTzsHve2XYccANHRIqgfZx48cu2T7wm2UtohqxewQYgfq1MnzanPbyktbFA==
X-Received: by 2002:a5e:da09:: with SMTP id x9mr2131029ioj.241.1543513360224;
        Thu, 29 Nov 2018 09:42:40 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c3sm1012362ioi.2.2018.11.29.09.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:42:38 -0800 (PST)
Subject: Re: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
To:     Keith Busch <keith.busch@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
 <20181129154713.GC7234@infradead.org>
 <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
 <20181129170430.GA27364@infradead.org>
 <64106f7d-73d9-70f3-7b28-9b836994d5aa@kernel.dk>
 <20181129173806.GA9377@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29b70753-b4e0-d382-c9c1-fe46d85850d4@kernel.dk>
Date:   Thu, 29 Nov 2018 10:42:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129173806.GA9377@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 10:38 AM, Keith Busch wrote:
> On Thu, Nov 29, 2018 at 10:06:20AM -0700, Jens Axboe wrote:
>> On 11/29/18 10:04 AM, Christoph Hellwig wrote:
>>> gcc never warns about unused static inline functions.  Which makes a lot
>>> of sense at least for headers..
>>
>> Not so much for non-headers :-)
> 
> You can #include .c files too! :)

There's always that one guy...

-- 
Jens Axboe

