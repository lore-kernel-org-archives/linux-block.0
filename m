Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C7C433DF
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 06:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5370223FB
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 06:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404592AbgJTGy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 02:54:26 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37444 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbgJTGyZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 02:54:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UCckCtY_1603176860;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UCckCtY_1603176860)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 14:54:20 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     snitzer@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com,
        haoxu@linux.alibaba.com
Subject: [RFC 0/3] Add support of iopoll for dm device
Date:   Tue, 20 Oct 2020 14:54:17 +0800
Message-Id: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set adds support of iopoll for dm device.

This is only an RFC patch. I'm really looking forward getting your
feedbacks on if you're interested in supporting iopoll for dm device,
or if there's a better design to implement that.

Thanks.


[Purpose]
IO polling is an important mode of io_uring. Currently only mq devices
support iopoll. As for dm devices, only dm-multipath is request-base,
while others are all bio-based and have no support for iopoll.
Supporting iopoll for dm devices can be of great meaning when the
device seen by application is dm device such as dm-linear/dm-stripe,
in which case iopoll is not usable for io_uring.


[Design Notes]

cookie
------
Let's start from cookie. Cookie is one important concept in iopoll. It
is used to identify one specific request in one specific hardware queue.
The concept of cookie is initially designed as a per-bio concept, and
thus it doesn't work well when bio-split involved. When bio is split,
the returned cookie is indeed the cookie of one of the split bio, and
the following polling on this returned cookie can only guarantee the
completion of this specific split bio, while the other split bios may
be still uncompleted. Bio-split is also resolved for dm device, though
in another form, in which case the original bio submitted to the dm
device may be split into multiple bios submitted to the underlying
devices.

In previous discussion, Lei Ming has suggested that iopoll should be
disabled for bio-split. This works for the normal bio-split (done in
blk_mq_submit_bio->__blk_queue_split), while iopoll will never be
usable for dm devices if this also applies for dm device.

So come back to the design of the cookie for dm devices. At the very
beginning I want to refactor the design of cookie, from 'unsigned int'
type to the pointer type for dm device, so that cookie can point to
something, e.g. a list containing all cookies of one original bio,
something like this:

struct dm_io { // the returned cookie points to dm_io
	...
	struct list_head cookies; 
};

In this design, we can fetch all cookies of one original bio, but the
implementation can be difficult and buggy. For example, the
'struct dm_io' structure may be already freed when the returned cookie
is used in blk_poll(). Then what if maintain a refcount in struct dm_io
so that 'struct dm_io' structure can not be freed until blk_poll()
called? Then the 'struct dm_io' structure will never be freed if the
IO polling is not used at all.

So finally I gived up refactoring the design of cookie and maintain all
cookies of one original bio. The initial design of cookie gets retained.
The returned cookie is still the cookie of one of the split bio, and thus
it is not used at all when polling dm devices. The polling of dm device,
is indeed iterating and polling on all hardware queues (in polling mode)
of all underlying target devices.

This design is simple and easy to implement. But I'm not sure if the
performance can be an issue if one dm device mapped to too many target
devices or the dm stack depth grows.

REQ_NOWAIT
----------
The polling bio will set REQ_NOWAIT in bio->bi_flags, and the device
need to be capable of handling REQ_NOWAIT. Commit 021a24460dc2
("block: add QUEUE_FLAG_NOWAIT") and commit 6abc49468eea ("dm: add
support for REQ_NOWAIT and enable it for linear target") add this
support for dm device, and currently only dm-linear supports that.

hybrid polling
--------------
When execute hybrid polling, cookie is used to fetch the request,
and check if the request has completed or not. In the design for
dm device described above, the returned cookie is still the cookie
of one of the split bios, and thus we have no way checking if all
the split bios have completed or not. Thus in the current
implementation, hybrid polling is not supported for dm device.


[Performance]
I test 4k-randread on a dm-linear mapped to only one nvme device.

SSD: INTEL SSDPEDME800G4
dm-linear:dmsetup create testdev --table "0 209715200 linear /dev/nvme0n1 0"

fio configs:
```
ioengine=io_uring
iodepth=128
numjobs=1
thread
rw=randread
direct=1
registerfiles=1
#hipri=1 with iopoll enabled, hipri=0 with iopoll disabled
bs=4k
size=100G
runtime=60
time_based
group_reporting
randrepeat=0

[device]
filename=/dev/mapper/testdev
```

The test result shows that there's ~40% performance growth when iopoll
enabled.

test | iops | bw | avg lat
---- | ---- | ---- | ----
iopoll-disabled | 244k | 953MiB/s  | 524us
iopoll-enabled  | 345k | 1349MiB/s | 370us

[TODO]
The store method of "io_poll"/"io_poll_delay" has not been adapted
for dm device.


Jeffle Xu (3):
  block/mq: add iterator for polling hw queues
  block: add back ->poll_fn in request queue
  dm: add support for IO polling

 block/blk-mq.c         | 30 ++++++++++++++++++++++++------
 drivers/md/dm-core.h   |  1 +
 drivers/md/dm-table.c  | 30 ++++++++++++++++++++++++++++++
 drivers/md/dm.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  6 ++++++
 include/linux/blkdev.h |  3 +++
 6 files changed, 104 insertions(+), 6 deletions(-)

-- 
2.27.0

