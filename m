Return-Path: <linux-scsi-owner@vger.kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: nvmf question - synchronization between target/initiator regarding
 partitions
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc: Mauricio pIO <mauricfo@linux.vnet.ibm.com>,
        Brian J King <bjking1@us.ibm.com>,
        Murali N Iyer <mniyer@us.ibm.com>, vnarasimhan@in.ibm.com,
        gpiccoli@linux.vnet.ibm.com
Date: Mon, 7 Aug 2017 10:42:57 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <82c4d1d8-ffa9-fa99-df58-05e2945eafdc@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

We observed that it's possible to perform partition operations in both
nvmf target and initiator block devices, like creating and deleting
partitions.

But there is no sync mechanism between target and initiator regarding
the partitions operations. After creating a partition on initiator, for
example, we don't see it on target side. We could format it like ext4 on
initiator, and still target cannot see it. It's possible to trigger a
BLKRRPART ioctl on target, which end up calling revalidate_disk() on
nvme driver and then partitions are perceived.

So, question: is this behavior expected/acceptable? Is it completely up
to userspace to deal with the synchronization between host/target?
I think answer might be yes since partitions are a higher level of
abstraction than nvmf (which is purely block device aware).

But if kernel could/should jump in, we possibly could try to issue a
revalidate_disk on target whenever this operation is performed on
initiator side (and vice-versa). I confess I couldn't find such sync
idea in NVMe over fabrics spec, though.
Also, reading NVMe spec 1.3, we do have the optional feature
"reservations", but seems it doesn't mention target (only multiple hosts).

Thanks in advance for any ideas on this subject.
Cheers,



Guilherme
