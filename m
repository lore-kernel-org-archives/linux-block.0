Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44152C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C20320658
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JiJBQZ+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgBYUCA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:00 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17726 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbgBYUB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 15:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582660917; x=1614196917;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=MiZmJA9pUK0ijDarkYLGiDBqwKVr4yTOHuXUxcsXrBg=;
  b=JiJBQZ+O4SCPC85IVQKfZXX2kORvujEpbDbYEo/QBSvdXqxRmHvvsxIi
   0dzKgDIzE2pvwUniwLAUyEgwq2Xa9qEvADy+Z9wLSGtj7TQw+mBCCjxyo
   Wj3/F+RvwOfku66tHBw4JlJX3ODadUbxUFabUJgQu3TXskTJRXZnhm1xI
   4=;
IronPort-SDR: sN/t/WJn64u0lZCt/DO/e1weHM2PLgt2TP5iya85xnAuukMZpJzpojl5JPgQLB/IleWexU2A2q
 KP+DmoyZ55sA==
X-IronPort-AV: E=Sophos;i="5.70,485,1574121600"; 
   d="scan'208";a="18550457"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Feb 2020 20:01:45 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id DB45EA18EF;
        Tue, 25 Feb 2020 20:01:42 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 20:01:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 20:01:41 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 25 Feb 2020 20:01:41 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <Chaitanya.Kulkarni@wdc.com>, <mst@redhat.com>,
        <jejb@linux.ibm.com>, <hch@lst.de>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 0/5] Add support for block disk resize notification
Date:   Tue, 25 Feb 2020 20:01:24 +0000
Message-ID: <20200225200129.6687-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow block/genhd to notify user space about disk size changes using a
new helper set_capacity_revalidate_and_notify(), which is a wrapper
on top of set_capacity(). set_capacity_revalidate_and_notify() will only notify
iff the current capacity or the target capacity is not zero and the
capacity really changes.

Background:

As a part of a patch to allow sending the RESIZE event on disk capacity
change, Christoph (hch@lst.de) requested that the patch be made generic
and the hacks for virtio block and xen block devices be removed and
merged via a generic helper.

This series consists of 5 changes. The first one adds the basic
support for changing the size and notifying. The follow up patches
are per block subsystem changes. Other block drivers can add their
changes as necessary on top of this series. Since not all devices
are resizable, the default was to add a new API and let users
slowly convert over as needed.

Testing:
1. I did some basic testing with an NVME device, by resizing it in
the backend and ensured that udevd received the event.


Changelog v2:
- Rename disk_set_capacity to set_capacity_revalidate_and_notify
- set_capacity_revalidate_and_notify can call revalidate disk
  if needed, a new bool parameter is passed (suggested by Bob Liu)

Balbir Singh (5):
  block/genhd: Notify udev about capacity change
  drivers/block/virtio_blk.c: Convert to use
    set_capacity_revalidate_and_notify
  drivers/block/xen-blkfront.c: Convert to use
    set_capacity_revalidate_and_notify
  drivers/nvme/host/core.c: Convert to use
    set_capacity_revalidate_and_notify
  drivers/scsi/sd.c: Convert to use set_capacity_revalidate_and_notify

 block/genhd.c                | 24 ++++++++++++++++++++++++
 drivers/block/virtio_blk.c   |  5 +----
 drivers/block/xen-blkfront.c |  6 +-----
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/sd.c            |  3 ++-
 include/linux/genhd.h        |  2 ++
 6 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.16.6

