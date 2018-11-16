Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D37DC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB102086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XR34yfBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB102086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeKQBfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:35:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36216 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKQBfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 20:35:07 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so2011366itj.1
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=05/7wtGxR+Co0/aTt6fbFCEurf4VKME5yI15PyV5DVk=;
        b=XR34yfBpK8h4otjxgjB1OofV24h4Fb3CFtCrbRZm+pdbdKkWOGQsh5FOHFj0rFYjSg
         91OVFHt2iRFOqqRpMseR8BFCQjE5eeRE/ydz1SQs53RIhcfcJ9RuLutuDDCpdJxKY9h1
         vLqGa46q74WWCw7QdJ2/ZtHNCKLe8mu3T7b9ljg7s9gC1WVZFpqK85Z32lXdrCQsbFoe
         +QdVfQwSFX0j6qkEgeH3ICCz/RRJ4ThMNYq8vtjEf3AZxBrbzLedprLegwYIJP0DKqyc
         w/4BxKqzaJiHeTDF19zFQA4OA2vdlLMQwOanc53MddIVe3gz/Tp0UWhAdlq1oRI/MSTj
         6Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05/7wtGxR+Co0/aTt6fbFCEurf4VKME5yI15PyV5DVk=;
        b=LY37CNx45rsafIKr190ZHTehy0nZuFlvIBm2kDb2nOZQapfk6LNdi2X0KaoQ0RU8jn
         PI0aAzZP/pV6OXtOzFMz6D8ntYIF9nwSKndwg08vxR+Wvi07pU7A5kHRedsii+JWOPBy
         oSC8Q0OhaavMhQzIXBoffBn/oNWhUzFIlgG5WnKgEiCYnjEpbc0On1rD2Sk+6HuAdXRI
         tGwKpWa274/LDiDH7laDgEFkYsbMvv1mFjiz00Zl9Z7ij4KHHizwKA2Ybb4xHjgMFF37
         4GT4pQuuNpDojd1JGjoWAaCx/tA0YewrieV1nI2aRF8KWDLe9AtYv9gz5nV2+kfSy4g8
         Iy0g==
X-Gm-Message-State: AGRZ1gJz4Os5j9Pm0ScCqg/y6tDTKvAUCkA+1Ryx66SBmOFt8Z6XRjt0
        aowWaclAAv3tILInZeJlttnXjyo0dgg=
X-Google-Smtp-Source: AJdET5cWvGL4ilu18d162rEm+uxG/DD4IucvRxR3ByaKFeXBG1e53L/fjnphZvH17DyHuGpOZ0PnVw==
X-Received: by 2002:a02:4ccc:: with SMTP id q73mr10723950jad.8.1542381737550;
        Fri, 16 Nov 2018 07:22:17 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i135sm4782204iti.34.2018.11.16.07.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 07:22:16 -0800 (PST)
Subject: Re: [PATCH 01/11] nvme: provide optimized poll function for separate
 poll queues
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-2-axboe@kernel.dk>
 <20181116083539.GC9023@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9f994097-7966-c629-892e-3f43344541ac@kernel.dk>
Date:   Fri, 16 Nov 2018 08:22:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116083539.GC9023@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 1:35 AM, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 12:51:25PM -0700, Jens Axboe wrote:
>> If we have separate poll queues, we know that they aren't using
>> interrupts. Hence we don't need to disable interrupts around
>> finding completions.
>>
>> Provide a separate set of blk_mq_ops for such devices.
> 
> This looks ok, but I'd prefer if we could offer to just support
> polling with the separate queue.  That way we get ourselves out of
> all kinds of potential races of the interrupt path vs poll path.

As Keith mentioned, we do use polling to find missing completions
in case of timeouts. And that has actually been really useful.

I'd rather keep such a change separate. If we do go down that
route, then there are more optimizations we can make.

Finally, let's not forget that polling is/was still a win even
if we did trigger interrupts. That's how NVMe has been since
polling was introduced. While the newer stuff is a lot more
efficient, I don't think we should totally abandon an easy opt-in
for polling for hardware unless we have strong reasons to do so.

-- 
Jens Axboe

