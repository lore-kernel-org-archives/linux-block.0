Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B16C2D0A8
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 10:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A6C238E2
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 10:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YfemzFvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIZKvo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Sep 2020 06:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZKvn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Sep 2020 06:51:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C4C0613CE
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2020 03:51:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u4so702864plr.4
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2020 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Erv0okPrqcm4hiPfazJ3B+MEgGbrmkvfiAwUSBMTHes=;
        b=YfemzFvwe1AUIq1uBazHfToqDWIuf2mqgxJ2LU1hQxwGCiJqts77x+ngut+gKDqhyu
         L0jV/If4cXfKQgI7ofmQQtAASru2NifOZd2OyX48v5BGSlzEhQZc31S2AhbYotm0THAo
         EnrPESbJ1zEL+w9o8+2tkV9jWWrpDUr6/KCW49HHdbIO62g8Ab/dTtniiVi/JUANGaNK
         Lrn+ye0CnzQS7a2YmpA+hU/1/cq5tj4KQ88CaZyfGIx7IDfvnEBB1XzTCVrMXB5aBgGJ
         5Cuqx87fw4us0mVuVmRuuBqnVrp12zGKKKdOgHIcdOKk+It1htLYK11CkzUjZhbgjykB
         FzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Erv0okPrqcm4hiPfazJ3B+MEgGbrmkvfiAwUSBMTHes=;
        b=ZMu0wqrcE2MWs7K0lS7wUO2sinvIt2J7uYkkvFsia4IFLSnUqkG1Y2auhI6++CEnza
         6S8ep97e94ueFi6PrCrrqKheUt0RAtKQgb4LhggPAg/cPO6KQHBnP4+FCwqq4q2xWeOW
         aVZlgEKrZA7JEGnRcegcIilb4kugK7XX9urJnntZ4NxH+pnWo0Ru6ACkCcfUMHWpwrd+
         JDIR/0zjJa7pOCnTm6RtRgJIPwnOfwYj7JLwVl2ILz6UZbh+iWZp7WFip4+JkY4n/AYo
         77ZZLU2VmOSUYcK1FJSXpHO3zoo1FxkKBtMgjYN9cCwGXxmzp0nkRAcX+onOtL86VRbl
         p4ag==
X-Gm-Message-State: AOAM531b6LdZvd2AQtsOJNcVlR+JcYGTnWYQiiCojUn0UGYSDu/u4Ewr
        lPYIthFXAccbIY9cdMlsEI7pdg==
X-Google-Smtp-Source: ABdhPJyMU8iWdKoFGvrBKhvoBnMIbxxzkFSzD5yj9YM1Q2QfdUWp4vx7kR8Mt1Q+SkQai4c6OUnaSw==
X-Received: by 2002:a17:90a:9708:: with SMTP id x8mr1666114pjo.213.1601117502248;
        Sat, 26 Sep 2020 03:51:42 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w185sm5619297pfc.36.2020.09.26.03.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 03:51:41 -0700 (PDT)
Subject: Re: Deadlock under load with Linux 5.9 and other recent kernels
To:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     furkan@fkardame.com, Brad Harper <bjharper@gmail.com>
References: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
Date:   Sat, 26 Sep 2020 04:51:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/20 1:55 AM, Christian Hewitt wrote:
> I am using an ARM SBC device with Amlogic S922X chip (Beelink
> GS-King-X, an Android STB) to boot the Kodi mediacentre distro
> LibreELEC (which I work on) although the issue is also reproducible
> with Manjaro and Armbian on the same hardware, and with the GT-King
> and GT-King Pro devices from the same vendor - all three devices are
> using a common dtsi:
> 
> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
> 
> I have schematics for the devices, but can only share those privately
> on request.
> 
> For testing I am booting LibreELEC from SD card. The box has a 4TB
> SATA drive internally connected with a USB > SATA bridge, see dmesg:
> http://ix.io/2yLh and I connect a USB stick with a 4GB ISO file that I
> copy to the internal SATA drive. Within 10-20 seconds of starting the
> copy the box deadlocks needing a hard power cycle to recover. The
> timing of the deadlock is variable but the device _always_ deadlocks.
> Although I am using a simple copy use-case, there are similar reports
> in Armbian forums performing tasks like installs/updates that involve
> I/O loads.
> 
> Following advice in the #linux-amlogic IRC channel I added
> CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK and was able to
> get output on the HDMI screen (it is not possible to connect to UART
> pins without destroying the box case). If you advance the following
> video frame by frame in VLC you can see the output:
> 
> https://www.dropbox.com/s/klvcizim8cs5lze/lockup_clip.mov?dl=0

Try with this patch:

https://lore.kernel.org/linux-block/20200925191902.543953-1-shakeelb@google.com/

-- 
Jens Axboe

