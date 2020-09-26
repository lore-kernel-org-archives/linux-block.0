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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5AC2D0A8
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 07:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DF22080A
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2qZB5X/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgIZHzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Sep 2020 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZHzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Sep 2020 03:55:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644DBC0613D3;
        Sat, 26 Sep 2020 00:55:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so1493210wmi.3;
        Sat, 26 Sep 2020 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=pTA0hmsHcNqtI2fDLdRBHiVrah9nomJTQoK+wEwr798=;
        b=M2qZB5X/m3H5K3GEzXLTtYtmeCpkv+I2oOf9AfMMhw2L9ostZgECSYCShrtjuYCzIZ
         tlmSRnhVu6LS1IgqHXUvxO8GpNH3K5fhLNufRbT7TaLfL+ZzhDdpl0ZowGuzdiZ5KcIJ
         DMbjGNXpgT4Ltq8aeuPlijaf8B/J8njbPYCBga1UcGM1MsRsF828mrY46juXbG54J/5K
         9AwRIqswp+Cfj5u6jAWuZyK+NR+9REsWvUwXQQ3K9b2v0MxZHY/A7y6mgOk8dviU6vT+
         p+nP92EHVn90ZVo3F/eg7TVPJXwU2cUJMT7c/0to1OSysbh6p1yhR6VbsGeXqwgnjcOU
         Lh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=pTA0hmsHcNqtI2fDLdRBHiVrah9nomJTQoK+wEwr798=;
        b=FXBnGMFKGHN3AnO4v8zegTuhNTKKYyXsxMTTK9CAhBlgPCrzHYKk34rBWNH/SgGfsQ
         eiEbBvZO9C6a5JuEcXQTaK9+WKblIxxub+UYHX6wue5DWXj4JvgZIKl9dFJMemxgTTkQ
         AumHsVrRqs12D7z3u0y0PZsidZq2pjzjPWPydGGYrhtdEadD+gJud8+uYV3sc/n1K+5g
         /2NWQUmx7aruaFLxbW8ckxIPpGM/ze632scLdoIV8tDJYXx2xpLBSIdm2qiwn02w5rkZ
         9zPQQ9/5Lv1YFzAxJzR1EzX7dHuUQHVdfZaHjeMqYDc/0KwFrOgolaX76rKV+bGKg/oI
         v9cw==
X-Gm-Message-State: AOAM5309mSGPzA2tpvBq1W4o8RNCHf1tdPa7Yla7yH+nNfY8ybfux+Uv
        449r1VVxbw79B/lFhXAgfu9QIWhnKD4=
X-Google-Smtp-Source: ABdhPJxN2sf8T0c2574PbIWh7ZWRVLX9R78jkbwc5JkiNrZ7OZvOcpuA3qjy4kdEL2QUwiCZ+bimbA==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr1464744wmj.171.1601106942638;
        Sat, 26 Sep 2020 00:55:42 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r206sm1735863wma.47.2020.09.26.00.55.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Sep 2020 00:55:42 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Deadlock under load with Linux 5.9 and other recent kernels
Message-Id: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
Date:   Sat, 26 Sep 2020 11:55:39 +0400
Cc:     furkan@fkardame.com, Brad Harper <bjharper@gmail.com>
To:     linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I am using an ARM SBC device with Amlogic S922X chip (Beelink GS-King-X, =
an Android STB) to boot the Kodi mediacentre distro LibreELEC (which I =
work on) although the issue is also reproducible with Manjaro and =
Armbian on the same hardware, and with the GT-King and GT-King Pro =
devices from the same vendor - all three devices are using a common =
dtsi:

=
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gsking-x.dts
=
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking-pro.dts
=
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-gtking.dts
=
https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dt=
s/amlogic/meson-g12b-w400.dtsi

I have schematics for the devices, but can only share those privately on =
request.

For testing I am booting LibreELEC from SD card. The box has a 4TB SATA =
drive internally connected with a USB > SATA bridge, see dmesg: =
http://ix.io/2yLh and I connect a USB stick with a 4GB ISO file that I =
copy to the internal SATA drive. Within 10-20 seconds of starting the =
copy the box deadlocks needing a hard power cycle to recover. The timing =
of the deadlock is variable but the device _always_ deadlocks. Although =
I am using a simple copy use-case, there are similar reports in Armbian =
forums performing tasks like installs/updates that involve I/O loads.

Following advice in the #linux-amlogic IRC channel I added =
CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK and was able to =
get output on the HDMI screen (it is not possible to connect to UART =
pins without destroying the box case). If you advance the following =
video frame by frame in VLC you can see the output:

https://www.dropbox.com/s/klvcizim8cs5lze/lockup_clip.mov?dl=3D0

I am not a coding developer so the output doesn=E2=80=99t mean much to =
me, but I am happy to follow guidance or install patches to get more =
output or test things.

Christian=
