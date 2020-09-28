Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D9AC4346E
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 01:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A5F23A51
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 01:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2xbBdbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1Bhb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 21:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgI1Bhb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 21:37:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2DC0613CE;
        Sun, 27 Sep 2020 18:37:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so10322341wrw.11;
        Sun, 27 Sep 2020 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zLGZFQFaWeWMhE5qI1OgAaqF4OKDe3pYPyyGfeXn6g4=;
        b=J2xbBdbwwEdoMqeOr8SHGVm1BtN65wnMTWwxqIB/OOGO3Ede4hmdFnCk6/yLlkEgyN
         VCwCrvp31JaAPLeIil/ec+nmWtHNFAW/oyDir6kH5SEAUGooiYJkq5twNu+ohJLoLhIk
         LVwQmFT0Bfc3Egi1uOxomCLXRDzW6wk0I2dzOldS8wraiNld1shwmMZ/0xiRrZOITfXw
         i9yGUN8vM95/Oa5/FglWEPPTABfpD2UQJ0GQ5p/pOduj7mulHUabGAsB3E6YpKGbfaXh
         Eppa70CRjMYvVZCy6xQ7de4HscEHsFuPGFpodMzzOfPEPBU0Kl3KibRj/V0/yqN2pTk0
         JiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zLGZFQFaWeWMhE5qI1OgAaqF4OKDe3pYPyyGfeXn6g4=;
        b=L0MLtywyNvH4WaYXDqBdAeNeGm8gMVEyg6NqrxU89/CewSt3WvVdxGbAh8+7I3mQP7
         MsJz33DuUYf3LioIniBm/vnk8KXNbh+r/qH5w+sF76M6FaiZEodr44uc6Vmp1uw30mpT
         7mysQYwMpHbCf4zaWUjxBGQCDtxahquTWxdDfKmBNLx3TMfNYc0aXQ/EShXxRy4KytBk
         zYcsGCa89qWWDkYS/S/y+Ljh1YvDJXsAp6I/7VXCSwohCepUr7fxKtKgnZN5U45l0lFS
         hhBOBoqCL7HjrGfgOZkbpp+P1IGJxmNs5e815E3zzv0sRSweGybbIlMonISr+hUdjq3Y
         id9A==
X-Gm-Message-State: AOAM530aCWOdh4DC+GsAjXIu/zy/hBr4xuzo5o/zB91/XSx1SkxI9dcm
        5pBq34KtV5xmYBIVOdLqsOE=
X-Google-Smtp-Source: ABdhPJxwPgg1qSGTiidlI4WlLq5FCulPCs1MOedIoHMaiDsjDkF5nXCuRvcy9YcYDotyujTF6aUUTQ==
X-Received: by 2002:adf:c64e:: with SMTP id u14mr15771941wrg.373.1601257064328;
        Sun, 27 Sep 2020 18:37:44 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id t1sm6792924wmi.16.2020.09.27.18.37.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 18:37:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Deadlock under load with Linux 5.9 and other recent kernels
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <91886A80-8164-4699-8662-E7D3444A4F12@gmail.com>
Date:   Mon, 28 Sep 2020 05:37:40 +0400
Cc:     linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org, furkan@fkardame.com,
        Brad Harper <bjharper@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA41AA25-8647-474E-87E6-64D4F030E590@gmail.com>
References: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
 <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
 <EE8C801E-0AD8-43E2-9C65-92CD512904BE@gmail.com>
 <c431ae48-6913-acc0-dc0a-b52065e9eaed@kernel.dk>
 <91886A80-8164-4699-8662-E7D3444A4F12@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 26 Sep 2020, at 4:28 pm, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
>>=20
>> On 26 Sep 2020, at 4:13 pm, Jens Axboe <axboe@kernel.dk> wrote:
>>=20
>> On 9/26/20 5:55 AM, Christian Hewitt wrote:
>>>>=20
>>>> On 26 Sep 2020, at 2:51 pm, Jens Axboe <axboe@kernel.dk> wrote:
>>>>=20
>>>> On 9/26/20 1:55 AM, Christian Hewitt wrote:
>>>>> I am using an ARM SBC device with Amlogic S922X chip (Beelink
>>>>> GS-King-X, an Android STB) to boot the Kodi mediacentre distro
>>>>> LibreELEC (which I work on) although the issue is also =
reproducible
>>>>> with Manjaro and Armbian on the same hardware, and with the =
GT-King
>>>>> and GT-King Pro devices from the same vendor - all three devices =
are
>>>>> using a common dtsi:
>>>>>=20
>>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gsking-x.dts
>>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking-pro.dts
>>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking.dts
>>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-w400.dtsi
>>>>>=20
>>>>> I have schematics for the devices, but can only share those =
privately
>>>>> on request.
>>>>>=20
>>>>> For testing I am booting LibreELEC from SD card. The box has a 4TB
>>>>> SATA drive internally connected with a USB > SATA bridge, see =
dmesg:
>>>>> http://ix.io/2yLh and I connect a USB stick with a 4GB ISO file =
that I
>>>>> copy to the internal SATA drive. Within 10-20 seconds of starting =
the
>>>>> copy the box deadlocks needing a hard power cycle to recover. The
>>>>> timing of the deadlock is variable but the device _always_ =
deadlocks.
>>>>> Although I am using a simple copy use-case, there are similar =
reports
>>>>> in Armbian forums performing tasks like installs/updates that =
involve
>>>>> I/O loads.
>>>>>=20
>>>>> Following advice in the #linux-amlogic IRC channel I added
>>>>> CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK and was =
able to
>>>>> get output on the HDMI screen (it is not possible to connect to =
UART
>>>>> pins without destroying the box case). If you advance the =
following
>>>>> video frame by frame in VLC you can see the output:
>>>>>=20
>>>>> https://www.dropbox.com/s/klvcizim8cs5lze/lockup_clip.mov?dl=3D0
>>>>=20
>>>> Try with this patch:
>>>>=20
>>>> =
https://lore.kernel.org/linux-block/20200925191902.543953-1-shakeelb@googl=
e.com/
>>>=20
>>> It still locks up approx. 25 seconds into the copy operation. =
Here=E2=80=99s the output in video again (a little blurry):
>>>=20
>>> https://www.dropbox.com/s/3j2czaq509arg6g/lockup_clip2.mov?dl=3D0
>>=20
>> Can you try and set CONFIG_SLUB in your .config instead of =
CONFIG_SLAB?
>=20
> CONFIG_SLUB is already set, here=E2=80=99s the full defconfig =
http://paste.ubuntu.com/p/5BNdZv6J3c/
>=20
> # dmesg | grep -i slub
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, =
CPUs=3D6, Nodes=3D1
>=20
>> Also, just take a picture, should be easier to get readable than a =
video.
>> And the static trace is all that is needed.
>=20
> This is from a GT-King Pro which someone reminded me has a large RS232 =
port on the rear:
>=20
> https://pastebin.com/raw/sGtzgreN

from 5.9=E2=80=94rc7 https://pastebin.com/raw/nbHJmrqe

Christian




