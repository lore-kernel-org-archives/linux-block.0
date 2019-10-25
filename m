Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336A6CA9EAF
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 02:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FE621928
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 02:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X4fxl/FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbfJYCYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:24:35 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:38976 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389943AbfJYCYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 22:24:35 -0400
Received: by mail-pg1-f173.google.com with SMTP id p12so500344pgn.6
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3R0LGM+x+3SrV4fsSFOxXhY85Q/ZlqVMZjtZ1oaV5I=;
        b=X4fxl/FOeJcQFNsnROTdDyPSVDerFPcTB2I311gr60NUVWEnb+CNPW9blEqfGoIbBb
         AhYxkMWJUO9w4WxbpZd2cMRNU71UfdOFBPwrJ4/2o8+x+NO46/cpQOt9WE3mjEDFnFqs
         61ZEGzLVS/kSBemQy14KgQmirGo39Jni059VbA9cpBebC02+6uQ1LrsHBxVhnlEu2ute
         vTThXa5VoVY6yjYcaM+Kwk43+I/ca22YlhFdUr0aQSMi84wIUOLhmxCmNXENt/Uorn+N
         DPRw0Di14yd+CjKhWH8l86SFeoqE/iNngAS+HLxs/qNIFsMB5eIJO4B8VawGy9snEJUA
         Gq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3R0LGM+x+3SrV4fsSFOxXhY85Q/ZlqVMZjtZ1oaV5I=;
        b=ms0xtr/U28bbN1GyMG9kUgGn/G19zHmbpysBNvN9KpuXc8UkBW+I06J+EYY4JX/4Sf
         76kxjjNppT2aS3DtwExv9LUOdLslteratSw0JTd0v10QwPlYg+ptiPM2tWwhpQuroJJu
         jtWlIM6W48JjGzlrw4bVOzv5JgSB2Ahc8+UTt/U0u0Ju67EPvWgLJrS9mFmjce3EyUCC
         Y91dPy7bAJKpW98zRpptZsCFZ+enhUJuLsudLKcBg64qNP3oXTkMuXFWse8YSD+kmjRM
         xRboHNL7+cK/TN3xPRKLju+KvxeLt3qZPUJq7k07EKex85ofegcN5uOgDRZPrGlNic/E
         pOMQ==
X-Gm-Message-State: APjAAAXxKlMbELZfTmQWB66sJ8ez/AgaE4EieC1pKT2gMrSGTVsHMjwg
        nenOlPb2j0D3if8qV5Y3kS9yN4CgR2fvhA==
X-Google-Smtp-Source: APXvYqz2Sm/x/hJv3SlBG22nMQANEsSxPIBdUhjXVmdmWvmty17dra1b1j5WDm8PlhlGPCjpR2k07w==
X-Received: by 2002:a63:b211:: with SMTP id x17mr1356351pge.51.1571970274607;
        Thu, 24 Oct 2019 19:24:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e3sm403315pjs.15.2019.10.24.19.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 19:24:33 -0700 (PDT)
Subject: Re: liburing 0.2 release?
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
References: <20191009083406.GA4327@stefanha-x1.localdomain>
 <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk>
 <x49k18ygkxy.fsf@segfault.boston.devel.redhat.com>
 <e4a6052d-b101-cb0b-949b-110c96dba131@kernel.dk>
Message-ID: <568a4400-94d9-8b31-43bd-bd28e405f36f@kernel.dk>
Date:   Thu, 24 Oct 2019 20:24:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e4a6052d-b101-cb0b-949b-110c96dba131@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/19 9:49 AM, Jens Axboe wrote:
> On 10/21/19 9:47 AM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> On 10/9/19 2:34 AM, Stefan Hajnoczi wrote:
>>>> Hi Jens,
>>>> I would like to add a liburing package to Fedora.  The liburing 0.1
>>>> release was in January and there have been many changes since then.  Is
>>>> now a good time for a 0.2 release?
>>>
>>> I've been thinking the same. I'll need to go over the 0.1..0.2 additions
>>> and ensure I'm happy with all of it (before it's set in stone), then we
>>> can tag 0.2.
>>>
>>> Let's aim for a 0.2 next week at the latest.
>>
>> ping?
> 
> Still on the radar, just got dragged out a bit with the changes last week.
> Let's aim for this week :-)

OK, I think we're good to go. I tagged and pushed out 0.2 just now.

-- 
Jens Axboe

