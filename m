Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB63C2D0A8
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E558238E6
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 12:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUrlYIh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZM2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZM2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Sep 2020 08:28:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C459C0613CE;
        Sat, 26 Sep 2020 05:28:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so6828787wrt.3;
        Sat, 26 Sep 2020 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ukPC7rmXAjITkh9QvzaxHnIgCpBroSSJwAuRpnTjvZg=;
        b=WUrlYIh3JOLuEoy7v8KquU6Q1ZT803y9AKF6VPpxKLeAu5HEDINHpG8qlHEaCcTs8T
         890tjsbXr41PERshgKXEDk4eGgv+XL5IwBiOgp/UVWufxwNqVZLhibrDmS0Udd7QCQTF
         Y+H1DmcPC4Yl0VPy6Ay8FkswHozo2sRpVhELkgBxk9Z3IkAXJNX2vju5ASWCu3KPLvXS
         QhWqUyxGMRDgz7x8QKA3C78JB/gbciwgfM2S2KFs3cwt0cN6zfkmYjQdw9Gb1ggst3Gy
         ZiuH3LkAkoNiiQFAOaHrmLLeAeVdCTOzUcwNMXMEtdVGk7QN1B6/CP2HSy+fhSwvxRFf
         ZEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ukPC7rmXAjITkh9QvzaxHnIgCpBroSSJwAuRpnTjvZg=;
        b=pddAoE3VONmRj8rq+7pUY9tBCaxybS86bB4GX04BrBZCAAn5A6d+xixhjNdSFYI4ng
         SVRqfUmWN+yEOFc2kyfvNzbN7JOWMKjKv2jzg9s6c3u2NNJFA9XSnK4OJboZv3d5Fmk8
         GmsQh4VSypueKOVnokbIVcQBY76qFDg6G1U+bgLWtKH52tvbBDE72oFRQZVN5QDamjLc
         OTvQ0YfYXugPqw6HeOW12VpPNGglbCW7q0LUmmLIcuaHBh3DBMS3dWJ9wVqHLXR/egRQ
         KU7Ea1918ulvrkX+2zTt+Kz1OE/1zScoSM2gGwNNNyyH8A2ApvDAdvq4gtrPaMTzbuw3
         76hg==
X-Gm-Message-State: AOAM531BCtj5o10BVrBzfaZwPdYASy2T1oK+vMVnFLNUJsV5phLI07kt
        o4WSC9sDfqljDh+O8FdNQRw=
X-Google-Smtp-Source: ABdhPJxb18/TB7iewoxegAd2aldWgy/HfRi2qoBw4JHBsn8Ss7p91Nblu+L5GnrG0np6nvk6AbnehQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr9221106wro.362.1601123296596;
        Sat, 26 Sep 2020 05:28:16 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y68sm2521686wmd.39.2020.09.26.05.28.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Sep 2020 05:28:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Deadlock under load with Linux 5.9 and other recent kernels
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <c431ae48-6913-acc0-dc0a-b52065e9eaed@kernel.dk>
Date:   Sat, 26 Sep 2020 16:28:13 +0400
Cc:     linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org, furkan@fkardame.com,
        Brad Harper <bjharper@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91886A80-8164-4699-8662-E7D3444A4F12@gmail.com>
References: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
 <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
 <EE8C801E-0AD8-43E2-9C65-92CD512904BE@gmail.com>
 <c431ae48-6913-acc0-dc0a-b52065e9eaed@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 26 Sep 2020, at 4:13 pm, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 9/26/20 5:55 AM, Christian Hewitt wrote:
>>>=20
>>> On 26 Sep 2020, at 2:51 pm, Jens Axboe <axboe@kernel.dk> wrote:
>>>=20
>>> On 9/26/20 1:55 AM, Christian Hewitt wrote:
>>>> I am using an ARM SBC device with Amlogic S922X chip (Beelink
>>>> GS-King-X, an Android STB) to boot the Kodi mediacentre distro
>>>> LibreELEC (which I work on) although the issue is also reproducible
>>>> with Manjaro and Armbian on the same hardware, and with the GT-King
>>>> and GT-King Pro devices from the same vendor - all three devices =
are
>>>> using a common dtsi:
>>>>=20
>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gsking-x.dts
>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking-pro.dts
>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking.dts
>>>> =
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-w400.dtsi
>>>>=20
>>>> I have schematics for the devices, but can only share those =
privately
>>>> on request.
>>>>=20
>>>> For testing I am booting LibreELEC from SD card. The box has a 4TB
>>>> SATA drive internally connected with a USB > SATA bridge, see =
dmesg:
>>>> http://ix.io/2yLh and I connect a USB stick with a 4GB ISO file =
that I
>>>> copy to the internal SATA drive. Within 10-20 seconds of starting =
the
>>>> copy the box deadlocks needing a hard power cycle to recover. The
>>>> timing of the deadlock is variable but the device _always_ =
deadlocks.
>>>> Although I am using a simple copy use-case, there are similar =
reports
>>>> in Armbian forums performing tasks like installs/updates that =
involve
>>>> I/O loads.
>>>>=20
>>>> Following advice in the #linux-amlogic IRC channel I added
>>>> CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK and was able =
to
>>>> get output on the HDMI screen (it is not possible to connect to =
UART
>>>> pins without destroying the box case). If you advance the following
>>>> video frame by frame in VLC you can see the output:
>>>>=20
>>>> https://www.dropbox.com/s/klvcizim8cs5lze/lockup_clip.mov?dl=3D0
>>>=20
>>> Try with this patch:
>>>=20
>>> =
https://lore.kernel.org/linux-block/20200925191902.543953-1-shakeelb@googl=
e.com/
>>=20
>> It still locks up approx. 25 seconds into the copy operation. =
Here=E2=80=99s the output in video again (a little blurry):
>>=20
>> https://www.dropbox.com/s/3j2czaq509arg6g/lockup_clip2.mov?dl=3D0
>=20
> Can you try and set CONFIG_SLUB in your .config instead of =
CONFIG_SLAB?

CONFIG_SLUB is already set, here=E2=80=99s the full defconfig =
http://paste.ubuntu.com/p/5BNdZv6J3c/

# dmesg | grep -i slub
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D6, =
Nodes=3D1

> Also, just take a picture, should be easier to get readable than a =
video.
> And the static trace is all that is needed.

This is from a GT-King Pro which someone reminded me has a large RS232 =
port on the rear:

https://pastebin.com/raw/sGtzgreN

Christian=
