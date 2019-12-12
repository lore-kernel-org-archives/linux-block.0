Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD4C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000F222B48
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SzI1DOGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfLLPwI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:52:08 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37408 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfLLPwI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 10:52:08 -0500
Received: by mail-il1-f196.google.com with SMTP id t9so2441517iln.4
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V0rzD69sAvpYoYAXwifXkGJ/c3BEX7oHaXNnSu/7R1A=;
        b=SzI1DOGvsgQG/a8ar2Ti7v2aUdaaiCFJizyPBOlaQbK9xD7GDmASaAQWVmpK/PrJFH
         feNXUM8rq1SIkXPCAT3IdmpYkcCHLjZskV2782eYG/I+CAlzZRWzyAKaxSQivhOL22rx
         7TZY0ZwUivRozG48Xlnr1wKrP7wG5Fs9XrK1HM8yGvl2GX/ZcaIxFRgpGvJlo8QFa4Cx
         suElgOqZ7TUVlqGi7Sho7DskEt+8FWde9DkAZprvCODsA4rbSLFXhK9wSGJKw11FAP0g
         JbJMcIRGbqw/iezIhnauvM9V7jaDbpY7HX+dBxn9TMBnNe0ohevkevPACyP75fUBBlUF
         cJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0rzD69sAvpYoYAXwifXkGJ/c3BEX7oHaXNnSu/7R1A=;
        b=Q1iYAh5vBJKFzVmeSVSp+DMbtKO23M2R7m4RKxsEHc7n/om2Llpd/f3r8a51yDziby
         mmVDwBN6XUOxPUqgvHuBF6aAE80zWh15J/1boPH30y6FYfBwxk/zjYp1+/QkVfNhoUN0
         iBNmy0XbZl995IafjzUKRbQX/q8Tq3pkZn1dKgP2La1pQpr72oGs3SxD2zsa1lnY1oR7
         iUkLbl2dlCVBqsMUo8nbsvT6iJm5iscUWMPXnK/jPZU3mB99n62rXXJHelvFLdvSacmg
         RMP8B00aY+fHP162M1tY9adDQZsyECkL8Nqn/Ej8uB+FDp4RJKHJyd/2/NYhOCKx6jTt
         tAJQ==
X-Gm-Message-State: APjAAAUAa6uKue9PjdP0XXUahgS0n+0WRjxtouCjlNg6uaAcTiQtImTJ
        hd/2xkmH2cfv3Zs2yJUu2fSYsi7vrflM6w==
X-Google-Smtp-Source: APXvYqxS2dkp/Ovx5CvFCzb8EkwUApe8FaaO0vOhCgPE2dsCgSj49pRSoy3unKMrBzXFDk9H/Q4mAQ==
X-Received: by 2002:a92:5c4a:: with SMTP id q71mr9001087ilb.266.1576165926938;
        Thu, 12 Dec 2019 07:52:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u10sm1818820ilb.8.2019.12.12.07.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:52:06 -0800 (PST)
Subject: Re: [PATCHSET 0/5] Support for RWF_UNCACHED
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191212154752.GA3936@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <941edff1-76fb-41f8-cb81-15ea0970e949@kernel.dk>
Date:   Thu, 12 Dec 2019 08:52:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212154752.GA3936@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/19 8:47 AM, Christoph Hellwig wrote:
> On Tue, Dec 10, 2019 at 09:24:49AM -0700, Jens Axboe wrote:
>> Seems to me that we have an opportunity to provide something that sits
>> somewhere in between buffered and O_DIRECT, and this is where
>> RWF_UNCACHED enters the picture. If this flag is set on IO, we get the
>> following behavior:
>>
>> - If the data is in cache, it remains in cache and the copy (in or out)
>>   is served to/from that.
>>
>> - If the data is NOT in cache, we add it while performing the IO. When
>>   the IO is done, we remove it again.
>>
>> With this, I can do 100% smooth buffered reads or writes without pushing
>> the kernel to the state where kswapd is sweating bullets. In fact it
>> doesn't even register.
>>
>> Comments appreciated! Patches are against current git (ish), and can
>> also be found here:
> 
> I can't say I particularly like the model, as it still has all the
> page cache overhead.  Direct I/O with bounce buffers for unaligned I/O
> sounds simpler and faster to me.

The current patchset read side does not, hopefully the same can be done
on the write side. No page cache usage for reads, because it did indeed
turn out to have too much overhead.

-- 
Jens Axboe

