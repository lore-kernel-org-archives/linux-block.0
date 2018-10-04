Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io1-f41.google.com ([209.85.166.41]:43746 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeJDXJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Oct 2018 19:09:59 -0400
Received: by mail-io1-f41.google.com with SMTP id y10-v6so8348411ioa.10
        for <linux-block@vger.kernel.org>; Thu, 04 Oct 2018 09:16:02 -0700 (PDT)
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 4 Oct 2018 21:15:50 +0500
Message-ID: <CABXGCsOyE2PJMem6TQVC0jpZ-2Zfgzkghwo74B66A4Mntrdoxg@mail.gmail.com>
Subject: Why BFQ scheduler available only for NVMe device?
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sorry I don't finded answer on my question.
Why BFQ scheduler available only for NVMe device?

$ find /sys -name scheduler -exec grep . {} +
find: =E2=80=98/sys/kernel/debug=E2=80=99: Permission denied
find: =E2=80=98/sys/fs/pstore=E2=80=99: Permission denied
find: =E2=80=98/sys/fs/bpf=E2=80=99: Permission denied
/sys/devices/pci0000:00/0000:00:01.3/0000:02:00.1/ata5/host4/target4:0:0/4:=
0:0:0/block/sda/queue/scheduler:noop
deadline [cfq]
/sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/nvme/nvme0/nvme0n1/queue/=
scheduler:[none]
mq-deadline bfq
/sys/devices/pci0000:00/0000:00:07.1/0000:0c:00.3/usb4/4-3/4-3.4/4-3.4.1/4-=
3.4.1:1.0/host9/target9:0:0/9:0:0:0/block/sdb/queue/scheduler:noop
deadline [cfq]

$ uname -r
4.19.0-0.rc5.git3.1.fc30.x86_64

$ cat /boot/config-`uname -r` | grep -i bfq
CONFIG_IOSCHED_BFQ=3Dm
CONFIG_BFQ_GROUP_IOSCHED=3Dy


--
Best Regards,
Mike Gavrilov.
