Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2FC3276C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3295320866
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dLFl/AbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgABHxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:53:34 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18013 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgABHxe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 02:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577951613; x=1609487613;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=PVg07FoUIijqCDgNCxD6SqGn7u8VxPLR6RUrEx5u2Xs=;
  b=dLFl/AbOeGdRIBz3NymYSOhglVOSDz76UA5YyM3i4c66oa9vrnPaGTL3
   IZOXGX5VYohLxQFCJpVtE6LUpIJiId8OW5zZD6lzAzjPDzZ2HP0NL2yYx
   9Lsf/Nz7BrQudKxM7f3G+vizakmYv6Xeao2Ee2ShEwIvXQkKe7CQrz831
   Y=;
IronPort-SDR: Q8h005rSzjI1pkx7eTWj8InTdlJl4q+w4jgOi5elBCR2/fK7u77rpRkaQyTWfDNiEVbVkVRzrV
 rNnJKZ4HaWXw==
X-IronPort-AV: E=Sophos;i="5.69,385,1571702400"; 
   d="scan'208";a="16411671"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Jan 2020 07:53:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 65A71A1ED5;
        Thu,  2 Jan 2020 07:53:19 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:17 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Jan 2020 07:53:16 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <ssomesh@amazon.com>, <jejb@linux.ibm.com>,
        <hch@lst.de>, <mst@redhat.com>, <Chaitanya.Kulkarni@wdc.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [resend v1 0/5] Add support for block disk resize notification
Date:   Thu, 2 Jan 2020 07:53:10 +0000
Message-ID: <20200102075315.22652-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow block/genhd to notify user space about disk size changes
using a new helper disk_set_capacity(), which is a wrapper on top
of set_capacity(). disk_set_capacity() will only notify if
the current capacity or the target capacity is not zero.

Background:

As a part of a patch to allow sending the RESIZE event on disk capacity
change, Christoph (hch@lst.de) requested that the patch be made generic
and the hacks for virtio block and xen block devices be removed and
merged via a generic helper.

This series consists of 5 changes. The first one adds the basic
support for changing the size and notifying. The follow up patches
are per block subsystem changes. Other block drivers can add their
changes as necessary on top of this series.

Testing:
1. I did some basic testing with an NVME device, by resizing it in
the backend and ensured that udevd received the event.

NOTE: After these changes, the notification might happen before
revalidate disk, where as it occured later before.

Balbir Singh (5):
  block/genhd: Notify udev about capacity change
  drivers/block/virtio_blk.c: Convert to use disk_set_capacity
  drivers/block/xen-blkfront.c: Convert to use disk_set_capacity
  drivers/nvme/host/core.c: Convert to use disk_set_capacity
  drivers/scsi/sd.c: Convert to use disk_set_capacity

 block/genhd.c                | 19 +++++++++++++++++++
 drivers/block/virtio_blk.c   |  4 +---
 drivers/block/xen-blkfront.c |  5 +----
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/sd.c            |  2 +-
 include/linux/genhd.h        |  1 +
 6 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.16.5

