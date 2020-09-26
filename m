Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA7EC2D0A8
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3C92389E
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 12:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ka2QDCWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIZMN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZMN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Sep 2020 08:13:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE0C0613D3
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2020 05:13:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so5538061pfa.10
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2020 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aRXjYNPvAllPLssAHFUtgdpWvskcOPt9BvCCI5W6OtA=;
        b=Ka2QDCWgyF4jROThlTol1M5vTtwbiqi4LO/EVRotYTxBJa1C/tMH8FdKgjnEYC19zJ
         G6Fx8w4z8QsN8X5o+1dH9EBvmmyIp0x+a7fGR/nOq5xiHvAXu/WaLZo0CxlaGHiE4E3r
         Rqkd/xhG8bTMonE93mkRb42DKW+oVBqOjERjHngcdE0HaNRTGl8fG+6G7FhUrwbiQKvV
         NlODNQS2WyXJLCeBr9jGQfjcBSVss6VcJQpijYByZENLads2kYZtRrdWIt5pVg4PKFqn
         OFl9vdvRFBhCnIqHeLvk30bHRYawE+Hh6RdtqgK+ubwKeIY6cVwLZ0/wo0IWrMIXJFQA
         ewJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aRXjYNPvAllPLssAHFUtgdpWvskcOPt9BvCCI5W6OtA=;
        b=LlCCdnpD7X1mdfuT+NjKqx7qQKTeBTCBQhoIsWWKd0po+pWpt/3LCh3DXyE/9xtgCn
         0vMclp2kL6Ar8F8d/Z6L1cuLNforh6dWkh2HQPAndPSy3Uwr803HK+6RzAEmIHRcgZ6R
         3Du0JH9Qvwe9EMHpcmF7bcl9y87c4EccY3wO+X1Y/i18tYEyWt7z072QbpIeL0dmvnlr
         4z8gyIZzFcqw3V37gXAvsdAeIE2egJoIQ5Ibgvy1Vvld1OMqh3xDaQpa4pf16G+X9mDy
         iWRNLe2hZ0JKi+1URpu5EAgp4qmD0apE+5S8Xgr/eEJxLtwGbWSmoAfFT0NJrlAHzePE
         2YLQ==
X-Gm-Message-State: AOAM5316CgCWdilpTgsx8nJ3aEg7SOxr/1W9cTO6Oakw8mswmM3zThnZ
        +SaA+AyNb+NC9wreYYQVpYLb4Q==
X-Google-Smtp-Source: ABdhPJzBir37uzxTY1+XemYaduPLOJdPSP7mTT1f5/5h2CUIjJ+5isOPmF/PCvy93XO0y3tSQ9AT0w==
X-Received: by 2002:a63:4945:: with SMTP id y5mr2532416pgk.181.1601122437798;
        Sat, 26 Sep 2020 05:13:57 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i62sm5571842pfe.140.2020.09.26.05.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 05:13:57 -0700 (PDT)
Subject: Re: Deadlock under load with Linux 5.9 and other recent kernels
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org, furkan@fkardame.com,
        Brad Harper <bjharper@gmail.com>
References: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
 <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
 <EE8C801E-0AD8-43E2-9C65-92CD512904BE@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c431ae48-6913-acc0-dc0a-b52065e9eaed@kernel.dk>
Date:   Sat, 26 Sep 2020 06:13:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <EE8C801E-0AD8-43E2-9C65-92CD512904BE@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/20 5:55 AM, Christian Hewitt wrote:
>>
>> On 26 Sep 2020, at 2:51 pm, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/26/20 1:55 AM, Christian Hewitt wrote:
>>> I am using an ARM SBC device with Amlogic S922X chip (Beelink
>>> GS-King-X, an Android STB) to boot the Kodi mediacentre distro
>>> LibreELEC (which I work on) although the issue is also reproducible
>>> with Manjaro and Armbian on the same hardware, and with the GT-King
>>> and GT-King Pro devices from the same vendor - all three devices are
>>> using a common dtsi:
>>>
>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
>>>
>>> I have schematics for the devices, but can only share those privately
>>> on request.
>>>
>>> For testing I am booting LibreELEC from SD card. The box has a 4TB
>>> SATA drive internally connected with a USB > SATA bridge, see dmesg:
>>> http://ix.io/2yLh and I connect a USB stick with a 4GB ISO file that I
>>> copy to the internal SATA drive. Within 10-20 seconds of starting the
>>> copy the box deadlocks needing a hard power cycle to recover. The
>>> timing of the deadlock is variable but the device _always_ deadlocks.
>>> Although I am using a simple copy use-case, there are similar reports
>>> in Armbian forums performing tasks like installs/updates that involve
>>> I/O loads.
>>>
>>> Following advice in the #linux-amlogic IRC channel I added
>>> CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK and was able to
>>> get output on the HDMI screen (it is not possible to connect to UART
>>> pins without destroying the box case). If you advance the following
>>> video frame by frame in VLC you can see the output:
>>>
>>> https://www.dropbox.com/s/klvcizim8cs5lze/lockup_clip.mov?dl=0
>>
>> Try with this patch:
>>
>> https://lore.kernel.org/linux-block/20200925191902.543953-1-shakeelb@google.com/
> 
> It still locks up approx. 25 seconds into the copy operation. Here’s the output in video again (a little blurry):
> 
> https://www.dropbox.com/s/3j2czaq509arg6g/lockup_clip2.mov?dl=0

Can you try and set CONFIG_SLUB in your .config instead of CONFIG_SLAB?

Also, just take a picture, should be easier to get readable than a video.
And the static trace is all that is needed.

-- 
Jens Axboe

