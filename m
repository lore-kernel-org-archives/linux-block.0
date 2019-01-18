Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACFCC1B0F7
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 21:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C192086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 21:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfARVci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:32:38 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:44894 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfARVci (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 18 Jan 2019 16:32:38 -0500
Received: from apollon.suse.de.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 18 Jan 2019 14:32:33 -0700
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Martin Wilck <mwilck@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: [PATCH 0/4] block: skip media change event handling if unsupported
Date:   Fri, 18 Jan 2019 22:32:03 +0100
Message-Id: <20190118213207.2309-1-mwilck@suse.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer currently can't distinguish between gendisk devices that
don't support any media change events, and devices that do support them,
but only for internal purposes. Therefore the check_events() function is
called e.g. for ordinary non-removable SCSI disks. While these devices are
not polled under normal conditions, the check_events function is called on
certain synchronization points, in particular while the device is opened,
closed, or probed.

Under unfavorable conditions this can lead to processes being stalled on a
blocked queue: a close() schedules a work item for check_events() which
gets blocked in the work queue, and subsequent open() tries to flush the
workqueue. The flush then stalls too, as long as the the blocked work item
can't finish.

In principle, the gendisk->events field would make it very easy for the
block layer to check only for events actually supported by the device.
Currently this is impossible, because there are lots of drivers which don't
set gendisk->events although they implement the check_events() method.
This was introduced in commit 7c88a168da80 ("block: don't propagate unlisted 
DISK_EVENTs to userland") and follow-up patches because uevent generation by
these drivers was found to possibly generate infinite event loops between
kernel and user space. A side effect of these patches was that the
distinction between such devices and devices supporting no events at all
was lost.

This series implements a slightly different approach to event handling and
uevent suppression. The drivers are changed to set the events field again.
Whether or not uevents should be generated is controlled by a separate flag
bit, which is only set by the drivers that are known to generate proper
uevents (sd and sr). Once this is done, devices that don't support any
media change events can be clearly identified, and the whole events
checking code path can be skipped. This simplifies handling of
non-removable SCSI disks.

I have tested this with removable and non-removable SCSI disks, SCSI cdrom,
and ide-cd.

This patch set targets the same problem as Hannes' late submission "sd:
skip non-removable devices in sd_check_events()".

Martin Wilck (4):
  block: disk_events: introduce event flags
  Revert "ide: unexport DISK_EVENT_MEDIA_CHANGE for ide-gd and ide-cd"
  Revert "block: unexport DISK_EVENT_MEDIA_CHANGE for legacy/fringe
    drivers"
  block: check_events: don't bother with events if unsupported

 block/genhd.c              | 50 +++++++++++++++++++++++++-------------
 drivers/block/amiflop.c    |  1 +
 drivers/block/ataflop.c    |  1 +
 drivers/block/floppy.c     |  1 +
 drivers/block/paride/pcd.c |  1 +
 drivers/block/paride/pd.c  |  1 +
 drivers/block/paride/pf.c  |  1 +
 drivers/block/swim.c       |  1 +
 drivers/block/swim3.c      |  1 +
 drivers/block/xsysace.c    |  1 +
 drivers/cdrom/gdrom.c      |  1 +
 drivers/ide/ide-cd.c       |  1 +
 drivers/ide/ide-cd_ioctl.c |  5 ++--
 drivers/ide/ide-gd.c       |  6 +++--
 drivers/scsi/sd.c          |  3 ++-
 drivers/scsi/sr.c          |  3 ++-
 include/linux/genhd.h      |  7 ++++++
 17 files changed, 62 insertions(+), 23 deletions(-)

-- 
2.19.2

