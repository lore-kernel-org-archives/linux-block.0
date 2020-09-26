Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E1C2D0A8
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 11:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E82238E2
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 11:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx/M0MAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgIZLzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Sep 2020 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZLzY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Sep 2020 07:55:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6DAC0613CE;
        Sat, 26 Sep 2020 04:55:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so6788247wrr.4;
        Sat, 26 Sep 2020 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lHpDGO3eipCJBv/JBXAcsVMlGwZEUUhI8iuzgMFtJmM=;
        b=Wx/M0MAL/yQ+YpBbNrG0u5Kp+tUngk6GDqMhOn8Fj1vTTpFl3vdmWvBK7iUK0yle3d
         yz1Sea7ZDeFH4VeYCP/HABkNfDDgB1j6L+7JanT/IDuMTty92vWPf7/EleMr22lBYP7i
         z+3JDbySwyexLBGTRsQPhPuqYAq5PhYQ1G92kovhmnhePz2Y59ZXJPIUMjhSjEAac3Lp
         Su9A6TgYiV1Cq+jSP1IqIINc0SM6kh541v30iy9uT7grEZE5mloaDht1dxHiO4bVxUiJ
         Dm08X2uQziSlQbYBLQ8C3QebE4/0XEd1ys7d9hoRJkYO1yraiWQJDSg/P5tBq/LfaB/d
         xq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lHpDGO3eipCJBv/JBXAcsVMlGwZEUUhI8iuzgMFtJmM=;
        b=dLIX2suzP3xjkxLBWav0Hm6HfkgS0i7MTC8RU/ovMAC9bUJvVa6hm0FN1+xi0sU1l9
         oTE96V5VXTBcV++gl+49sGFtHipcqbIFn6cV5cEpmqWmh4VFk/zt4aoiWW1SrnO5tQWL
         IzYJ3Rmxe77W7L3e7OqnbZfg9/Exq3eOE/YMMbHOdl2HraDasGJyrSIdg6rCa0Yvpm94
         U7Lmm1itfbmbRLnuKAKhfATMb4TxLrINZULUDnGpuxBVxG6DB3yUki/Vl7H8ZiSyZ8jB
         WfbtSv4fMMOjBrRbf194dCu7EfMLtbG0hgMoHRBSkyfvbbEfv3n+BfJgbJHNsN53H9Ek
         eFlA==
X-Gm-Message-State: AOAM531oIwgxarrHcmOjiS1ZA8qDfQjwyIUW+mjvdxjyGPe3DqMKeyWm
        DuVRonjFzi+8khKHeNlTVS6hQ1PqDuU=
X-Google-Smtp-Source: ABdhPJwezDQMRyJjlJ2x54xV5sUJhYCIpJFqrqR8TiMN0dETRCHh5AGT6FWowwiRJAH+y2cy8/HYIg==
X-Received: by 2002:a5d:660d:: with SMTP id n13mr9515562wru.308.1601121322592;
        Sat, 26 Sep 2020 04:55:22 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c14sm6350811wrm.64.2020.09.26.04.55.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Sep 2020 04:55:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Deadlock under load with Linux 5.9 and other recent kernels
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
Date:   Sat, 26 Sep 2020 15:55:20 +0400
Cc:     linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org, furkan@fkardame.com,
        Brad Harper <bjharper@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE8C801E-0AD8-43E2-9C65-92CD512904BE@gmail.com>
References: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
 <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>=20
> On 26 Sep 2020, at 2:51 pm, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 9/26/20 1:55 AM, Christian Hewitt wrote:
>> I am using an ARM SBC device with Amlogic S922X chip (Beelink
>> GS-King-X, an Android STB) to boot the Kodi mediacentre distro
>> LibreELEC (which I work on) although the issue is also reproducible
>> with Manjaro and Armbian on the same hardware, and with the GT-King
>> and GT-King Pro devices from the same vendor - all three devices are
>> using a common dtsi:
>>=20
>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gsking-x.dts
>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking-pro.dts
>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking.dts
>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-w400.dtsi
>>=20
>> I have schematics for the devices, but can only share those privately
>> on request.
>>=20
>> For testing I am booting LibreELEC from SD card. The box has a 4TB
>> SATA drive internally connected with a USB > SATA bridge, see dmesg:
>> http://ix.io/2yLh and I connect a USB stick with a 4GB ISO file that =
I
>> copy to the internal SATA drive. Within 10-20 seconds of starting the
>> copy the box deadlocks needing a hard power cycle to recover. The
>> timing of the deadlock is variable but the device _always_ deadlocks.
>> Although I am using a simple copy use-case, there are similar reports
>> in Armbian forums performing tasks like installs/updates that involve
>> I/O loads.
>>=20
>> Following advice in the #linux-amlogic IRC channel I added
>> CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK and was able =
to
>> get output on the HDMI screen (it is not possible to connect to UART
>> pins without destroying the box case). If you advance the following
>> video frame by frame in VLC you can see the output:
>>=20
>> https://www.dropbox.com/s/klvcizim8cs5lze/lockup_clip.mov?dl=3D0
>=20
> Try with this patch:
>=20
> =
https://lore.kernel.org/linux-block/20200925191902.543953-1-shakeelb@googl=
e.com/

It still locks up approx. 25 seconds into the copy operation. Here=E2=80=99=
s the output in video again (a little blurry):

https://www.dropbox.com/s/3j2czaq509arg6g/lockup_clip2.mov?dl=3D0

Christian=
