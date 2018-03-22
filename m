Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:53530 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeCVRnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Mar 2018 13:43:55 -0400
Received: by mail-it0-f41.google.com with SMTP id b136-v6so12382052iti.3
        for <linux-block@vger.kernel.org>; Thu, 22 Mar 2018 10:43:55 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
MIME-Version: 1.0
Date: Thu, 22 Mar 2018 23:13:53 +0530
Message-ID: <2521f708170ecd4bd607aa660d781751@mail.gmail.com>
Subject: smp affinity and kworker io submission
To: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I am running FIO script on Linux 4.15. This is generic behavior even on
3.x kernels as well. I wanted to know if my observation is correct or not.

Here is FIO command -

numactl -C 0-2  fio single --bs=4k  --iodepth=64 --rw=randread
--ioscheduler=none --group_report --numjobs=2

If driver is provides affinity_hint, kernel choose only kworker (0,1,2)
(it looks like kworker binding is smartly handled by kernel because I am
running FIO from cpu0,1,2)  for IO submission from delayed context.

14140 root      15  -5  519296   1560    612 R  87.7  0.0   0:20.91 fio

 14138 root      15  -5  519292   1556    608 R  76.1  0.0   0:21.79 fio

 14142 root      15  -5  519308   1560    612 R  66.8  0.0   0:19.69 fio

 14141 root      15  -5  519304   1564    616 R  54.5  0.0   0:20.51 fio

   923 root       0 -20       0      0      0 S   6.3  0.0   0:09.73
kworker/1:1H

  1075 root       0 -20       0      0      0 S   5.3  0.0   0:08.69
kworker/0:1H

   924 root       0 -20       0      0      0 S   3.3  0.0   0:12.82
kworker/2:1H

If driver is not providing affinity_hint, kernel choose *any* kworker from
local numa node for IO submission from delayed context. In below snippet,
you can see kworke4, kworke5 and kworke3 was participating in IO
submission.

14281 root      15  -5  519308   1556    612 R  87.0  0.0   0:16.16 fio

 14280 root      15  -5  519304   1560    616 R  74.1  0.0   0:14.62 fio

 14279 root      15  -5  519296   1556    612 R  71.8  0.0   0:15.02 fio

 14277 root      15  -5  519292   1552    608 R  66.8  0.0   0:15.06 fio

  1887 root       0 -20       0      0      0 R  15.3  0.0   0:40.91
kworker/4:1H

  3856 root       0 -20       0      0      0 S  13.6  0.0   0:38.90
kworker/5:1H

  3646 root       0 -20       0      0      0 S  13.0  0.0   0:40.17
kworker/3:1H

Which kernel component is making this decision ? Is this behavior tied to
block layer/irq subsystem  ?

I am trying to see which behavior is most suitable for my test. I am
seeing performance is not improving because it is CPU bound and If I
choose not to do smp affinity hint in driver, it is helping as explained
above.


Thanks, Kashyap
