Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD61C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 05:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197B9206C0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 05:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GYZDRws6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgENF43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 01:56:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6862 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgENF43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 01:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589435788; x=1620971788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uZhkTafbhEX35zTDQdtGiAFtVEKXqBC7TMwD7E1beHE=;
  b=GYZDRws69HFJ+ST8fpNgf/iH+2ns4gvbR0M/JNmDJ2vmY0zGonqcPx1+
   quW4JKsYb9AKPP5845gAhXV9TSunj18qvW4TgGc2k6mNVCeh6TblIZQcI
   Br1CXsKPZLPN60Cp3PJbm7AmeHtIxTPg/Gy3FIfZ5DXTDqxtmpl14IoNs
   a9O6Z4+f81A4fVeQFn78T2ASZEZ5q5qxgyJeDUbTzPSSc4lt1FD/TulQj
   tXTkeYzBM0XWOWm1LtQavkoFDXpCIeFnuj+o4JLRWOn+12ipbHQDAWASx
   Q6kYWkrXjENwd5rYEfhQkmzANxjvy+CraqBcwrSURbPA7Y66fbclFW2np
   g==;
IronPort-SDR: p9azwfzSAsxn6BNvvS8Qm382+w6oLBcMSIZyKvft8gY970DiYQre9uy9GSpwT1tlznaV/xrxN2
 zsRDSkpRtLgq8ymRKe+8hUhiVhkeHtI5HXSTUdM5YXpqVcd4H+z1cn2b3jvaFR0981/o8adSRj
 UxhSkNgPnWK2s1vb81ecy0dAAqkgSiuHdRfpycK4+pMFt0wmy7drBgK3o7VPhjCix3OIFm1CIA
 DLZJpQMHFLperSXVqveCqCb+LIgW+YdrMroqAlvAjVa+fiarq25ThrizP3JoZk/eghNZEvY4RF
 Jfc=
X-IronPort-AV: E=Sophos;i="5.73,390,1583164800"; 
   d="scan'208";a="246597488"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 13:56:28 +0800
IronPort-SDR: tH9Ak8Oooidf7q9doE7LGW7PKQkTr7r6C7VTbRE0hG6C10vOqTykibaVtIem/ThFrEl40TAsEA
 CAogQXQwyHbXrGhnjilJuH6nUdVYr6pW4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 22:46:08 -0700
IronPort-SDR: GUFq/y9lxsACD7y2OWcaWX0rCipv4+rEPH95BrEh+PlKRzRHTz8P05Z5LGesYzUvPMhJRJK5tI
 DktGHcDAsvAw==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2020 22:56:28 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] nvme: Fix io_opt limit setting
Date:   Thu, 14 May 2020 14:56:26 +0900
Message-Id: <20200514055626.1111729-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, a namespace io_opt queue limit is set by default to the
physical sector size of the namespace and to the the write optimal
size (NOWS) when the namespace reports optimal IO sizes. This causes
problems with block limits stacking in blk_stack_limits() when a
namespace block device is combined with an HDD which generally do not
report any optimal transfer size (io_opt limit is 0). The code:

/* Optimal I/O a multiple of the physical block size? */
if (t->io_opt & (t->physical_block_size - 1)) {
	t->io_opt = 0;
	t->misaligned = 1;
	ret = -1;
}

in blk_stack_limits() results in an error return for this function when
the combined devices have different but compatible physical sector
sizes (e.g. 512B sector SSD with 4KB sector disks).

Fix this by not setting the optimal IO size queue limit if the namespace
does not report an optimal write size value.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---

* Changes from v1:
  - Rebased on nvme/nvme-5.8 tree

 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 805d289e6cd9..951d558dc662 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1842,7 +1842,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 {
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
-	u32 atomic_bs, phys_bs, io_opt;
+	u32 atomic_bs, phys_bs, io_opt = 0;
 
 	if (ns->lba_shift > PAGE_SHIFT) {
 		/* unsupported block size, set capacity to 0 later */
@@ -1851,7 +1851,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
-	atomic_bs = phys_bs = io_opt = bs;
+	atomic_bs = phys_bs = bs;
 	nvme_setup_streams_ns(ns->ctrl, ns, &phys_bs, &io_opt);
 	if (id->nabo == 0) {
 		/*
-- 
2.25.4

