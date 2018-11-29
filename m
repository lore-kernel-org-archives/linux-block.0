Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF1C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552AD213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XC7lOsjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552AD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeK3ELv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:11:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46349 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbeK3ELu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:11:50 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so2126812ios.13
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 09:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BstV5yGTJ1Ij9VR3tvIzBnSGP+RGtfyNXnT/XAgXMaE=;
        b=XC7lOsjCMFwrQNHoNfHVnkRE4+mKyMrrXbsser0H0R2uPjpwrXMNW5vk/zMdEs+SPN
         wTP4ZBjJtehutI57hpXzW6nvXVYQoqmrM3Z6xinifqAomokF0Ow0v/YG1wPSYt7MKy+e
         7sfdz2FVjhD5k6nfuqDAAaSNnKO8GEnBC4z58PtBUmZ3MDfE1iciWex4VZBNXxsak3fs
         iY/FNCuedoS6QiAtFCi++IUmh8x5s09cIw9kaYVo9eJ34tSaB49u4vGtHd95qXJN4uAh
         4n+h4rVRSwS1a0tZioKZJnVC3pRzXS2wSzGpZZPNeyEsnea2orgGPb+yoZMo95LzXRmS
         kTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BstV5yGTJ1Ij9VR3tvIzBnSGP+RGtfyNXnT/XAgXMaE=;
        b=rak901DGPAeUvkcAfbrQXNWxBrXRjdRXDKZz7sCbAks0vdDX8QjThN8tp1kfRulMCX
         pQc82Iy85KMZePGZ3XASbCELeTiiHJ1vB3yd7JQsDWclTLjaRR5hgBmdS/C4fhO1qhh6
         IiizYxkz6ocowfEY7gfJ+UWAvhVqLygqqTeghJBTsG9+VxJOg+ZnjUTkALe+qSo8wMxB
         W0CFznha+vhGAOGQ8Ga4JjnCxlRgb1BU97kqe2hpTDHPFMuZK5F0Pu0zeOPD91hKE67L
         rxPjJwlh5KR9W4tWHziLD30X6AhXgpl0qk8TbfNlV8PJwWS5xEr6WGXdefy13G695Fni
         SqFg==
X-Gm-Message-State: AA+aEWZjKiDOgSPm2hyY6NnWH4WkG0ppNVdkIllUpPR6C6MtUBJ6zDjE
        mSbvIFlD6U2XC4D/VYQ9LrFSpjS6XcI=
X-Google-Smtp-Source: AFSGD/VKv3SQd1D5SFej+kL/w9POaXE6hZs5UolOXPuMzq3Wz72x8fleuqnT6o6l3qnryhM05vs7dA==
X-Received: by 2002:a5e:c303:: with SMTP id a3mr1805148iok.53.1543511147487;
        Thu, 29 Nov 2018 09:05:47 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n129sm1350103itb.20.2018.11.29.09.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:05:46 -0800 (PST)
Subject: Re: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-8-axboe@kernel.dk>
 <20181129154959.GF7234@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b3b1c19-4c74-2a8c-849d-1bccee8663d4@kernel.dk>
Date:   Thu, 29 Nov 2018 10:05:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129154959.GF7234@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 8:49 AM, Christoph Hellwig wrote:
>> +		/*
>> +		 * Use plugging if we have a ->commit_rqs() hook as well,
>> +		 * as we know the driver uses bd->last in a smart
>> +		 * fashion.
>> +		 */
> 
> Nipick: this could flow on just two lines:
> 
> 		/*
> 		 * Use plugging if we have a ->commit_rqs() hook as well, as we
> 		 * know the driver uses bd->last in a smart fashion.
> 		 */

Fixed up.

-- 
Jens Axboe

