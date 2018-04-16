Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:45199 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeDPKZH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:07 -0400
Received: by mail-wr0-f176.google.com with SMTP id u11so24430828wri.12
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 03:25:06 -0700 (PDT)
MIME-Version: 1.0
From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Mon, 16 Apr 2018 12:24:24 +0200
Message-ID: <CAOLZvyFA8Dm1L1Dc0dJAVL8pZ9z3SwiLGvyxDNQ-Gkp40fbhJw@mail.gmail.com>
Subject: Change device block count from userspace?
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

I have a SATA SSD which suddenly reports its size as 2.2TB, 0xFFFFFFFF
block count:

[   30.620086] sd 10:0:0:0: [sdc] 4294967295 512-byte logical blocks:
(2.20 TB/2.00 TiB)
[   30.620327] sd 10:0:0:0: [sdc] Write Protect is off
[   30.620329] sd 10:0:0:0: [sdc] Mode Sense: 43 00 00 00
[   30.620771] sd 10:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   34.170412] GPT:Primary header thinks Alt. header is not at the end
of the disk.
[   34.170413] GPT:4004704367 != 4294967294
[   34.170414] GPT:Alternate GPT header not at the end of the disk.
[   34.170414] GPT:4004704367 != 4294967294
[   34.170414] GPT: Use GNU Parted to correct GPT errors.
[   34.170419]  sdc: sdc1
[   34.172408] sd 10:0:0:0: [sdc] Attached SCSI disk
[   64.293698] sd 10:0:0:0: [sdc] tag#15 uas_eh_abort_handler 0
uas-tag 1 inflight: CMD IN
[   64.293702] sd 10:0:0:0: [sdc] tag#15 CDB: Read(10) 28 00 ff ff ff
00 00 00 08 00

It's impossible to access this device with either dd or any other
tools because apparently
the kernel tries to access higher blocks which, one after the other,
time out after around 5 minutes.  It's possible to access the disk on
Windows with an Ext4 driver, data seems fine but retrieval is very
slow.

Is there a way from userspace to tell the block layer that this device
has only 4004704368 blocks, and that it should not touch the higher
ones?

Thanks!
      Manuel
