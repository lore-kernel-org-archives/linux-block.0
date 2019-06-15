Return-Path: <SRS0=HzVw=UO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFA6C31E50
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917222082C
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGN8va3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfFOQYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jun 2019 12:24:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46809 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfFOQYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jun 2019 12:24:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so3704863lfh.13;
        Sat, 15 Jun 2019 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:mime-version
         :content-transfer-encoding:content-disposition:message-id;
        bh=O8TenXf8n3Y7pwA2CkxS3CiasLg3xi/TeSP6+th2mY4=;
        b=kGN8va3DtJTnAewO5ElzvA2LoOWuyNLEx6u5SbB4Bmi7KZhCr05f4SjJdHUDJdjtDo
         0rUwdEzwEXk6O8lQp5whqVyOHVUEHnvOnVpCQq/lVoLzTpWTIkwaHRcVOA0wwkfBsD1C
         /OP8/tJt7pRaG5SsSHxUhfuU0Vy6h0dg+cUBvWTh+LImUP7q7JPATwyX4n2r8vs0V6/5
         nQfGnYmJoBYw8QGL4UC4hyFKq4s0CWuJNQyRgMf53S1J7kXiZFJPbgCIO1+Mavd1lthe
         jCredm6N87A+ie8JIEwVqTO8C3BF7pvdfQfA/91dunSoHQUxsctB1/XD7xqmTNvx/Tha
         Cv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:mime-version
         :content-transfer-encoding:content-disposition:message-id;
        bh=O8TenXf8n3Y7pwA2CkxS3CiasLg3xi/TeSP6+th2mY4=;
        b=DrSzGWR67rppY5U2IlvDchy9kYlF7OgRIzfVFZh9kPrk+E4+NkhpvnWIhoSTGjQgcP
         KDgRgAwqTe5pnF3ocvdcu/lmgMn+T3X5FWjCIcBVvZGwFM/BYDcS6VmbTtbXc8WS+yXZ
         aGsWM/She+VMDyOYWi2QN8ucTMVwbD8CWgnHSLkfbkvlNNeu5fcAOS0K76szyT4qfWFy
         46XqvNpI8uTgeE0b6Qji130zM8B9LD9YoBkRMKvk3BaWhnhNib357QLaaxVsei74PHB7
         +061+JxxW67pTKObL+ca4LOSmcX7Ee7wgQg5I6ybJAq+OZgJfTEr8y1r0BDZT9znaV9l
         ypdA==
X-Gm-Message-State: APjAAAWvv60smbbISACeb9ls2ov2iZfvgVsdgnON5OCrLAy0yWW49Uu9
        wOTC7fWUvj/Q6g47qAKYPHy1OZZN
X-Google-Smtp-Source: APXvYqxqHog0+uavUMt/3YkHEAzBWKuri1yzFFxIkV8dT2Njs1O78x2OggvP+CW8SDdFnBpViuBxfg==
X-Received: by 2002:ac2:43b7:: with SMTP id t23mr2691780lfl.110.1560615879725;
        Sat, 15 Jun 2019 09:24:39 -0700 (PDT)
Received: from [192.168.1.100] ([176.116.252.109])
        by smtp.gmail.com with ESMTPSA id m21sm918566lfh.20.2019.06.15.09.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 09:24:39 -0700 (PDT)
From:   Andrew Randrianasulu <randrianasulu@gmail.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Bug 7805 strikes again?
Date:   Sat, 15 Jun 2019 19:16:09 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201906151916.09688.randrianasulu@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

I was puzzled by strange fact my qemu stopped to boot DVDs I made over years, if I put them in physical drive and try to boot them via qemu.
After  a lot of digging I found possible reason: wrongly-set block device size on /dev/sr0

And this lead me to
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=619757

and
https://bugzilla.kernel.org/show_bug.cgi?id=7805

so I checked if my dmesg had anything related to pktcdvd:

 dmesg | grep pkt
[    7.681270] pktcdvd: pktcdvd0: writer mapped to sr0


blockdev --getsize64 /dev/sr0
1073741312
pktsetup -d /dev/sr0
pktsetup: Error: Can't tear down packet device '/dev/sr0': Inappropriate ioctl for device

 blockdev --getsize64 /dev/sr0
4700372992

after this I can boot my DVD fully (before it was failing at mounting squashfs images):
qemu-system-x86_64 -enable-kvm -display sdl,gl=on -cdrom /dev/sr0 -m 1G -soundhw es1370 -usbdevice mouse -smp 3 -cpu max

 uname -a
Linux slax 5.1.6-x64 #1 SMP PREEMPT Fri May 31 23:49:35 MSK 2019 x86_64 AMD FX(tm)-4300 Quad-Core Processor AuthenticAMD GNU/Linux

Userspace is 32-bit Slackware (mix of many versions).

 sg_inq /dev/sr0
standard INQUIRY:
  PQual=0  Device_type=5  RMB=1  LU_CONG=0  version=0x05  [SPC-3]
  [AERC=0]  [TrmTsk=0]  NormACA=1  HiSUP=1  Resp_data_format=2
  SCCS=0  ACC=0  TPGS=0  3PC=0  Protect=0  [BQue=0]
  EncServ=0  MultiP=0  [MChngr=0]  [ACKREQQ=0]  Addr16=0
  [RelAdr=0]  WBus16=0  Sync=0  [Linked=0]  [TranDis=0]  CmdQue=0
  [SPI: Clocking=0x0  QAS=0  IUS=0]
    length=96 (0x60)   Peripheral device type: cd/dvd
 Vendor identification: ASUS
 Product identification: DRW-24D5MT
 Product revision level: 1.00
