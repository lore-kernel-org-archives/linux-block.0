Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626B0C433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BB161465
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhDWW46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 18:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhDWW45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 18:56:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E359C061574;
        Fri, 23 Apr 2021 15:56:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x19so49368402lfa.2;
        Fri, 23 Apr 2021 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KfnCAYdtX4ALPXWJJjuQArnTYYCUMVEl462yj1Y6sR8=;
        b=THJnr/PoclY6cWHewUeBet0iF51429NzvLRllT4L8fYM8ajk+bdr61vqTq7Q/tlmUk
         7A+M1Mq4n2G5BUMTahgRhYIgsDlS8Xasy2txlWxHwCSVeF+ifYJl3qshwQldCqn8VpKj
         FTsReQY2DgPSyJ0DkXNDnsuVtiw+lCQsOgXCZudePfeEQU7FLOasAQgAUCN8YghwDgQ9
         qqfkSIDBnMo74b3tYAPZyveAG7j20crRA6Lw1KCIBETjwlGyjqv8kasak5klFhhEWAwG
         DIrseHnAQpov+WlbvwNaL9Uj1nQr0cSNoEerNwze6AXNq4dbywWSP4aHEwC5CI1LpM/H
         M+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KfnCAYdtX4ALPXWJJjuQArnTYYCUMVEl462yj1Y6sR8=;
        b=aImmyeCwFnT0HDnipUSGggvWpIDvNPqR1uXjyxpBlRTE4AMqv12N4pzbyzNnSsIVnd
         LlkCD6zTf/Fz6BUrQ57Q5227Kn3Hal9fhiR3A6VeF1TqDUxtkrrjOzFp0LNxUEpUBix/
         jZnk5Yt2cla7Z6hLhIGfEX8WhDChcv8y6/A6WcVZfAF9Y57FC/vFaq6zc2H0MC++m6yb
         dFNwOu0U/2gZRKXHGoLFPQv6s5r7Sh7qWk8A13qlLSEB3R8m8SyvvljeSPxXdM/efpLs
         +WcCaYOLhsW5ghPuB4+oGs1cdAJgDBYPUqI8hMyOStMfQ4g/NWw9kYbhhw1evA1cHb5n
         WJCA==
X-Gm-Message-State: AOAM533QSMXHXOAEqnVzN2to5/yCTS/hOJR+4IjmUqvDx4omQrvAIPol
        E1aif49XaUht2CfW3ZU3KQb7aDNJQqRHoLOfbKRsLInbLAxkhQ==
X-Google-Smtp-Source: ABdhPJxhC1dHFb4XwpXNpOFL6SfngTfL+tHmW4rRG6obNksUhwSdLLKRbOSURjqR6Q5l0GqhUOUoP2MBKrY8aAAqu4A=
X-Received: by 2002:a05:6512:3f08:: with SMTP id y8mr4332000lfa.657.1619218576023;
 Fri, 23 Apr 2021 15:56:16 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 24 Apr 2021 03:56:05 +0500
Message-ID: <CABXGCsPWS8mCsGFR_NbhCv-8p1JxBbmV_L4C=zPzev8y-omwow@mail.gmail.com>
Subject: [bug][5.12-rc8] It sounds like madness but nvme controller is down
 when I plug at the same time 3.5 jack headphones and USB headset to MB.
To:     linux-usb@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, kbusch@kernel.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
It sounds like madness but "nvme controller is down" when I plug at
the same time 3.5 jack headphones and USB headset to MB.
This really scares me because I've never seen such an easy way to make
a system broken.
The most offensive thing is that in the kernel logs nothing strange is
visible except for connecting a USB device and disabling the nvme
controller.

[  510.573670] usb 1-3.3.4: new full-speed USB device number 23 using xhci_hcd
[  510.968115] usb 1-3.3.4: New USB device found, idVendor=1b1c,
idProduct=0a5f, bcdDevice= 1.03
[  510.968125] usb 1-3.3.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  510.968129] usb 1-3.3.4: Product: CORSAIR HS60 HAPTIC Gaming Headset
[  510.968132] usb 1-3.3.4: Manufacturer: CORSAIR COMPONENTS, INC.
[  511.896484] input: CORSAIR COMPONENTS, INC. CORSAIR HS60 HAPTIC
Gaming Headset Consumer Control as
/devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.1/usb1/1-3/1-3.3/1-3.3.4/1-3.3.4:1.3/0003:1B1C:0A5F.0019/input/input61
[  511.947854] input: CORSAIR COMPONENTS, INC. CORSAIR HS60 HAPTIC
Gaming Headset as
/devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.1/usb1/1-3/1-3.3/1-3.3.4/1-3.3.4:1.3/0003:1B1C:0A5F.0019/input/input62
[  511.948023] hid-generic 0003:1B1C:0A5F.0019:
input,hiddev99,hidraw5: USB HID v1.11 Device [CORSAIR COMPONENTS, INC.
CORSAIR HS60 HAPTIC Gaming Headset] on usb-0000:06:00.1-3.3.4/input3
[  517.603789] nvme nvme0: controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0xffff
[  517.636775] nvme 0000:01:00.0: can't change power state from D3hot
to D0 (config space inaccessible)
[  517.636899] nvme nvme0: Removing after probe failure status: -19
[  517.654772] nvme0n1: detected capacity change from 937703088 to 0
[  517.654778] blk_update_request: I/O error, dev nvme0n1, sector
5632792 op 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 0
[  517.654781] blk_update_request: I/O error, dev nvme0n1, sector
105981294 op 0x1:(WRITE) flags 0x9800 phys_seg 1 prio class 0
[  517.654795] XFS (nvme0n1p2): log I/O error -5
[  517.654794] blk_update_request: I/O error, dev nvme0n1, sector
3099104 op 0x1:(WRITE) flags 0x1000 phys_seg 3 prio class 0
[  517.654798] nvme0n1p2: writeback error on inode 90909, offset
3129344, sector 5632800
[  517.654805] blk_update_request: I/O error, dev nvme0n1, sector
5632728 op 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 0
[  517.654812] nvme0n1p2: writeback error on inode 90909, offset
3096576, sector 5632736
[  517.654812] XFS (nvme0n1p2): xfs_do_force_shutdown(0x2) called from
line 1272 of file fs/xfs/xfs_log.c. Return address = 000000000bfa0ccf

The issue is reproducing on my system. I checked all the contacts for
a bad connection. Even when I expose the motherboard and connectors to
mechanical stress, nothing happens. So it doesn't look like a hardware
fault.

$ git blame drivers/nvme/host/pci.c -L 1239,1259
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1239) static void nvme_warn_reset(struct nvme_dev *dev,
u32 csts)
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1240) {
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1241)      /* Read a config register to help see what
died. */
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1242)      u16 pci_status;
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1243)      int result;
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1244)
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1245)      result =
pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1246)                                    &pci_status);
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1247)      if (result == PCIBIOS_SUCCESSFUL)
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1248)              dev_warn(dev->ctrl.device,
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1249)                       "controller is down; will
reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1250)                       csts, pci_status);
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1251)      else
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1252)              dev_warn(dev->ctrl.device,
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1253)                       "controller is down; will
reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1254)                       csts, result);
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1255) }
b2a0eb1a0ac72 drivers/nvme/host/pci.c   (Keith Busch       2017-06-07
20:32:50 +0200 1256)
31c7c7d2c9f17 drivers/nvme/host/pci.c   (Christoph Hellwig 2015-10-22
14:03:35 +0200 1257) static enum blk_eh_timer_return
nvme_timeout(struct request *req, bool reserved)
c30341dc3c436 drivers/block/nvme-core.c (Keith Busch       2013-12-10
13:10:38 -0700 1258) {
f4800d6d1548e drivers/nvme/host/pci.c   (Christoph Hellwig 2015-11-28
15:43:10 +0100 1259)      struct nvme_iod *iod =
blk_mq_rq_to_pdu(req);

Andy and Keith excuse me, but you wrote code which said to me that
"controller is down". Can you help me clarify what is really happening
here?
I can apply patches for verbose messages for understanding why block
layers depend on USB and audio devices.

My hardware:
# inxi -F
System:    Host: fedora Kernel: 5.12.0-0.rc8.191.fc35.x86_64+debug
x86_64 bits: 64 Console: tty pts/0
           Distro: Fedora release 35 (Rawhide)
Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
v: Rev X.0x serial: 190958552300672
           UEFI: American Megatrends v: 3603 date: 03/20/2021
CPU:       Info: 16-Core (2-Die) model: AMD Ryzen 9 3950X bits: 64
type: MT MCP MCM cache: L2: 8 MiB
           Speed: 2056 MHz min/max: 2200/3500 MHz Core speeds (MHz):
1: 2056 2: 3598 3: 2056 4: 3598 5: 2056 6: 2056 7: 3600
           8: 2057 9: 2056 10: 3599 11: 2056 12: 2398 13: 2057 14:
2198 15: 2198 16: 2200 17: 2200 18: 3593 19: 2056 20: 2054
           21: 3599 22: 2055 23: 2056 24: 2398 25: 3600 26: 2056 27:
2197 28: 2200 29: 2199 30: 2201 31: 3606 32: 2056
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
           Device-2: AVerMedia Live Streamer CAM 513 type: USB driver:
hid-generic,usbhid,uvcvideo
           Display: server: X.org 1.20.11 driver: loaded: amdgpu note:
n/a (using device driver) tty: 238x53
           Message: Advanced graphics data unavailable in console for root.
Audio:     Device-1: Advanced Micro Devices [AMD/ATI] driver: snd_hda_intel
           Device-2: Advanced Micro Devices [AMD] Starship/Matisse HD
Audio driver: snd_hda_intel
           Device-3: Kingston HyperX Cloud Orbit S Hi-Res 2Ch type:
USB driver: hid-generic,snd-usb-audio,usbhid
           Device-4: AVerMedia Live Streamer CAM 513 type: USB driver:
hid-generic,snd-usb-audio,usbhid
           Device-5: Corsair CORSAIR HS60 HAPTIC Gaming Headset type:
USB driver: hid-generic,snd-usb-audio,usbhid
           Sound Server-1: ALSA v: k5.12.0-0.rc8.191.fc35.x86_64+debug
running: yes
           Sound Server-2: PipeWire v: 0.3.26 running: yes
Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
           IF: wlp4s0 state: down mac: fe:0f:cb:73:b4:f0
           Device-2: Intel I211 Gigabit Network driver: igb
           IF: enp5s0 state: up speed: 1000 Mbps duplex: full mac:
a8:5e:45:50:a6:59
Bluetooth: Device-1: Intel AX200 Bluetooth type: USB driver: btusb
           Report: This feature requires one of these tools:
hciconfig/bt-adapter
Drives:    Local Storage: total: 16.81 TiB used: 5.71 TiB (33.9%)
           ID-1: /dev/nvme0n1 vendor: Intel model: SSDPE21D480GA size:
447.13 GiB
           ID-2: /dev/sda vendor: Western Digital model:
WUH721818ALE6L4 size: 16.37 TiB
Partition: ID-1: / size: 99.95 GiB used: 8.66 GiB (8.7%) fs: xfs dev:
/dev/nvme0n1p2
           ID-2: /boot/efi size: 511 MiB used: 20.4 MiB (4.0%) fs:
vfat dev: /dev/nvme0n1p1
           ID-3: /home size: 16.37 TiB used: 5.7 TiB (34.8%) fs: xfs
dev: /dev/sda1
Swap:      ID-1: swap-1 type: partition size: 64 GiB used: 0 KiB
(0.0%) dev: /dev/nvme0n1p3
           ID-2: swap-2 type: zram size: 8 GiB used: 0 KiB (0.0%) dev:
/dev/zram0
Sensors:   System Temperatures: cpu: 51.2 C mobo: N/A gpu: amdgpu temp: 55.0 C
           Fan Speeds (RPM): N/A gpu: amdgpu fan: 561
Info:      Processes: 495 Uptime: 1m Memory: 62.63 GiB used: 1.75 GiB
(2.8%) Init: systemd runlevel: 5 Shell: Bash
           inxi: 3.3.03


Full logs:
[1] https://pastebin.com/ndsqaj4X
[2] https://pastebin.com/J5wjipwN
[3] https://pastebin.com/ZvvcjMzg


-- 
Best Regards,
Mike Gavrilov.
