Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E485C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 04:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5283238E5
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 04:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAUEu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 23:50:57 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:41723 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbhAUEpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 23:45:06 -0500
Received: by mail-lj1-f176.google.com with SMTP id f11so998957ljm.8;
        Wed, 20 Jan 2021 20:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f9bbvmIOKEeCYUQRPFOOVdYth7vYiJBVFzn7Om7oKyw=;
        b=O89m19fCyCQLTYQdq7l+ECZRc3H7VhzvSRG39/LgsDfhTsDs0op2mLQ89BJeM7lQWI
         mlZa+rIB8ljR2VU7UBxSwb2B6GpcHESoKInye0P0HUb9o2oLx7qw8VLnPKE0dcWFgglz
         yql+C/NYsxvfcGatN2Y6KKRnK0u5eNFlKADRANLRurakh4GF/a6BRUj1jW4hVTrq5asc
         n2TfEzH/lwozcExON3i+n+AM8JO6VLcK8wy3s1VQGUR7kr/eRb0baykWl8p9bg0p5SWl
         CPvMEkhlfJ2PwjbtPA3MM6awu/SsHKJp/8sJ92CNoCoPl4/WsGRQa4seXNLVbOnupYaW
         53gg==
X-Gm-Message-State: AOAM531iVMqE5Bdz5xBD8LTLRnlF1OUOmAD8fPV7CSMw4ubUKWzCkYaV
        pUr3rlbT+5Llt0LoyFs1B58chXyX5is=
X-Google-Smtp-Source: ABdhPJxOqw3xd1Tos0Qlvw4CbA4x84U4Vgw6vdbsiB8+EeqtZIbskGJAeLl/ya7StQa9SC8jVVjbMw==
X-Received: by 2002:a05:651c:1398:: with SMTP id k24mr6085638ljb.30.1611204262043;
        Wed, 20 Jan 2021 20:44:22 -0800 (PST)
Received: from [10.68.32.148] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id b31sm434380ljf.38.2021.01.20.20.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:44:21 -0800 (PST)
Reply-To: efremov@linux.com
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Wim Osterholt <wim@djo.tudelft.nl>
References: <20160610230255.GA27770@djo.tudelft.nl>
 <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm>
 <20160614184308.GA6188@djo.tudelft.nl>
 <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm>
 <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm>
 <20160615224722.GA9545@djo.tudelft.nl>
 <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
 <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <5cb57175-7f0b-5536-925d-337241bcda93@linux.com>
Date:   Thu, 21 Jan 2021 07:44:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 1/19/21 6:53 PM, Jiri Kosina wrote:
> On Mon, 25 Jul 2016, Jens Axboe wrote:
> 
>>> From: Jiri Kosina <jkosina@suse.cz>
>>>
>>> Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
>>> side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
>>> this is being used setfdprm userspace for ioctl-only open().
>>>
>>> Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE)
>>> modes, while still keeping the original O_NDELAY bug fixed.
>>>
>>> Cc: stable@vger.kernel.org # v4.5+
>>> Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
>>> Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
>>> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>>
>> Added for this series, thanks.
> 
> [ CCing Denis too ]
> 
> Let me revive this 4 years old thread.
> 
> I've just now noticed that instead of my patch above being merged, what 
> happened instead was
> 
> 	commit f2791e7eadf437633f30faa51b30878cf15650be
> 	Author: Jens Axboe <axboe@fb.com>
> 	Date:   Thu Aug 25 08:56:51 2016 -0600
> 
> 	    Revert "floppy: refactor open() flags handling"
>     
> 	    This reverts commit 09954bad448791ef01202351d437abdd9497a804.
> 
> 
> which was plain revert of 09954bad4 (without any further explanation), 
> which in turn reintroduced the O_NDELAY issue, and I've just been hit by 
> it again.
> 
> I am not able to find any e-mail thread that'd indicate why ultimately 
> revert happened, instead of mergin my fix.

I think it's hard to recall the exact reasons after so many years.
I'll send a patch today based on this one.

Best Regards,
Denis
