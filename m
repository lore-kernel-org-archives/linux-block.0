Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD0C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C7B20693
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xNiXY+OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfDVOHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:07:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35612 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfDVOHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 10:07:10 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so18348072itc.0
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CddJl94vxBG24On5xbtdXxgpGWdcz5Xifcd7D9pV+40=;
        b=xNiXY+OIM1k6OSm0eh34qBSvPcFjSSL/QFgZ8pa4mXIG4a7EXq1IzHBAbE03q2IIIA
         hCPOQUK4fLG6cYs2ypi0G3p7DT+K9imJrMKa+kGd2tdgkrZ0I0Jov/L5AFrRHslZfRWe
         gUcOplolByypO/4VFeAJA9JbhyFFFJOtx+gM81nxrLgLIiZv8M84qMsZvdBTUt9IGwcn
         tnff7djJ3PZXLr0QO+O8T0a6kOngKgjVQD7x41jYDg9X6DJTW+MIkIeo41zsuqX5441B
         X08NFl+XazaM/D01fqa10aFJfXYW1azFwCvUD7LrB6p4fDPRxozDfzYzf0OuJMnzK6Vt
         WwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CddJl94vxBG24On5xbtdXxgpGWdcz5Xifcd7D9pV+40=;
        b=jpLXouQ4lab/VfEyhVjA/AjXYjbsMNf/IbmWOEKngunyTcJOZGKaW6WbkggYQGkXTe
         FN5x7jYp7S1Njy6O7ekgrBIWMO8DMsxOY5OQ7WiZZ+BfZ7w8kfV5mnGEHWDLGuGcntYn
         Mg2V+7bgw+mb2PBAlTSY/wT43tTWMAA3FDkTelhPkem1ZR2V/+EOtBBVBmwDCRSSWyYO
         3shfRMCEw+rIhyhATpJXq+wSn1rVVUgdGuxc8kGTTlYtX2fN2OiSRniV+QDvL1tFQitN
         YvXhwBcXJOSyrfD5kE1Z2f10GP7NVarsrjT7n6oVNnaSJ6q9kEkuVau/rm0KKBUQbIC1
         BMaQ==
X-Gm-Message-State: APjAAAUJSJpvS5NWyr+ofumoPVKz/jCDmyCKwYV8+kIOGTGPKCfFoS2H
        rlx0x9egPrpJsAmS5IEtfHSq7g==
X-Google-Smtp-Source: APXvYqyyMRAxHggd5hDoaovu6S+Wr+8NVkciBHOeDCaUsTuchMB6ibyVMf3yG4HTp37idLwtVA9zTg==
X-Received: by 2002:a24:1f06:: with SMTP id d6mr12494774itd.11.1555942029742;
        Mon, 22 Apr 2019 07:07:09 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w2sm4319741iob.7.2019.04.22.07.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:07:08 -0700 (PDT)
Subject: Re: breakage after "io_uring: offload write to async worker in case
 of -EAGAIN"
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-block@vger.kernel.org, rpenyaev@suse.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <CAKv+Gu-fprVgQ576__VDZ1L8HRghtCus_E-F0Q3gRzDLN=pjtQ@mail.gmail.com>
 <CAKv+Gu-WZLo7UJd8k9Q2piEaJ8E319XRGheratuR47sfbH_DUg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b70cbe19-3be2-c1f3-13d3-c5fba3d6faa4@kernel.dk>
Date:   Mon, 22 Apr 2019 08:07:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-WZLo7UJd8k9Q2piEaJ8E319XRGheratuR47sfbH_DUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 7:41 AM, Ard Biesheuvel wrote:
> On Sun, 21 Apr 2019 at 10:33, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>> Hello all,
>>
>> I ran into an issue booting a graphical desktop (GNOME) on an ARM
>> based system with nvidia graphics and the nouveau driver (which is the
>> only one available on arm64). Bisect identified the following commit
>> as the culprit
>>
>> commit 9bf7933fc3f306bc4ce74ad734f690a71670178a
>> Author: Roman Penyaev <rpenyaev@suse.de>
>> Date:   Mon Mar 25 20:09:24 2019 +0100
>>
>>     io_uring: offload write to async worker in case of -EAGAIN
>>
>> and reverting that on top of v5.1-rc5 gives me a working system again.
>>
>> I don't see any errors in the kernel log, but the graphical desktop
>> never comes up. I can still ssh into the system and everything else
>> appears to work normally.
>>
>> I'm a bit out of my depth there, so could you please help me diagnose
>> this further? Any conditions I should check in the 'else' path?
>>
> 
> Actually, I am struggling to understand why this particular commit
> would make a difference on a Debian Stretch based userland, since I
> don't suppose the new syscalls are being used there yet ...

Yeah, it really makes no sense at all, as that code path is not being
exercised on your system at all.

-- 
Jens Axboe

