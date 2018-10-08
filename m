Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb1-f171.google.com ([209.85.219.171]:37309 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHMPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Oct 2018 08:15:49 -0400
Received: by mail-yb1-f171.google.com with SMTP id h1-v6so7819111ybm.4
        for <linux-block@vger.kernel.org>; Sun, 07 Oct 2018 22:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de> <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain> <20180308074220.GC15748@lst.de>
 <20180309172445.GC14765@localhost.localdomain> <20180312090827.GB23903@ming.t460p>
In-Reply-To: <20180312090827.GB23903@ming.t460p>
From: Prasun Ratn <prasun.ratn@gmail.com>
Date: Mon, 8 Oct 2018 10:35:47 +0530
Message-ID: <CAF6hzxwN4S4C37dbdARcW+tgLMRjvHtzOZjFomVQBVntshZ+7w@mail.gmail.com>
Subject: nvme-pci: number of queues off by one
To: ming.lei@redhat.com
Cc: keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi

I have an NVMe SSD that has 8 hw queues and on older kernels I see all
8 show up. However on a recent kernel (I tried 4.18), I only see 7. Is
this a known issue?

$ uname -r
4.14.1-1.el7.elrepo.x86_64

$ ls /sys/block/nvme*n1/mq/*/cpu_list
/sys/block/nvme0n1/mq/0/cpu_list
/sys/block/nvme0n1/mq/1/cpu_list
/sys/block/nvme0n1/mq/2/cpu_list
/sys/block/nvme0n1/mq/3/cpu_list
/sys/block/nvme0n1/mq/4/cpu_list
/sys/block/nvme0n1/mq/5/cpu_list
/sys/block/nvme0n1/mq/6/cpu_list
/sys/block/nvme0n1/mq/7/cpu_list
/sys/block/nvme1n1/mq/0/cpu_list
/sys/block/nvme1n1/mq/1/cpu_list
/sys/block/nvme1n1/mq/2/cpu_list
/sys/block/nvme1n1/mq/3/cpu_list
/sys/block/nvme1n1/mq/4/cpu_list
/sys/block/nvme1n1/mq/5/cpu_list
/sys/block/nvme1n1/mq/6/cpu_list
/sys/block/nvme1n1/mq/7/cpu_list
/sys/block/nvme2n1/mq/0/cpu_list
/sys/block/nvme2n1/mq/1/cpu_list
/sys/block/nvme2n1/mq/2/cpu_list
/sys/block/nvme2n1/mq/3/cpu_list
/sys/block/nvme2n1/mq/4/cpu_list
/sys/block/nvme2n1/mq/5/cpu_list
/sys/block/nvme2n1/mq/6/cpu_list
/sys/block/nvme2n1/mq/7/cpu_list
/sys/block/nvme3n1/mq/0/cpu_list
/sys/block/nvme3n1/mq/1/cpu_list
/sys/block/nvme3n1/mq/2/cpu_list
/sys/block/nvme3n1/mq/3/cpu_list
/sys/block/nvme3n1/mq/4/cpu_list
/sys/block/nvme3n1/mq/5/cpu_list
/sys/block/nvme3n1/mq/6/cpu_list
/sys/block/nvme3n1/mq/7/cpu_list


$ uname -r
4.18.10-1.el7.elrepo.x86_64

$ ls /sys/block/nvme*n1/mq/*/cpu_list
/sys/block/nvme0n1/mq/0/cpu_list
/sys/block/nvme0n1/mq/1/cpu_list
/sys/block/nvme0n1/mq/2/cpu_list
/sys/block/nvme0n1/mq/3/cpu_list
/sys/block/nvme0n1/mq/4/cpu_list
/sys/block/nvme0n1/mq/5/cpu_list
/sys/block/nvme0n1/mq/6/cpu_list
/sys/block/nvme1n1/mq/0/cpu_list
/sys/block/nvme1n1/mq/1/cpu_list
/sys/block/nvme1n1/mq/2/cpu_list
/sys/block/nvme1n1/mq/3/cpu_list
/sys/block/nvme1n1/mq/4/cpu_list
/sys/block/nvme1n1/mq/5/cpu_list
/sys/block/nvme1n1/mq/6/cpu_list
/sys/block/nvme2n1/mq/0/cpu_list
/sys/block/nvme2n1/mq/1/cpu_list
/sys/block/nvme2n1/mq/2/cpu_list
/sys/block/nvme2n1/mq/3/cpu_list
/sys/block/nvme2n1/mq/4/cpu_list
/sys/block/nvme2n1/mq/5/cpu_list
/sys/block/nvme2n1/mq/6/cpu_list
/sys/block/nvme3n1/mq/0/cpu_list
/sys/block/nvme3n1/mq/1/cpu_list
/sys/block/nvme3n1/mq/2/cpu_list
/sys/block/nvme3n1/mq/3/cpu_list
/sys/block/nvme3n1/mq/4/cpu_list
/sys/block/nvme3n1/mq/5/cpu_list
/sys/block/nvme3n1/mq/6/cpu_list
