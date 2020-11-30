Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F8BC64E7B
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3616D20663
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RbOjY8cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgK3DaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 22:30:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54598 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgK3DaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707021; x=1638243021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ag4Kyb+Xfg9A3G4ksCYAMaUKqGExJXD9X+MkHXHamDY=;
  b=RbOjY8cRcnjYSfQ8oUQlvCBod4HvBjIV520KGH0rwJDozep7x8zC+3jg
   wXBN1QtuIcnI054d4j8O5j1eXZRbuGFSNpqXhPCm0DUwsNyf+Bklnmvpz
   ++u6AdLRSRQDC2g5YbjZg+wmOxeEdgkvxDpN8sfobgZWpUBkpmOcCOFSN
   ULg57MU9oIOgmtWzPZINjYwNmwUqxIvr80+P5qoYCojhRZ7J0Rpff+BOh
   eaOqOwQTTb7WewMdPY9I5eUKsjs1/TdkxOsRzSr7gN9bnMtvwhm2rkKZ/
   g8X8hGsmIoAbqOLfxnywRpNoAAIGyx9/Opo4Jm4cHyjhAaMrZWv1Bgq3r
   A==;
IronPort-SDR: 0VjwiHhLi2axwJcCXyWzwTVJNJZMoB9WGSBSv7MAPoxE8uk/VdpSkDsuvhbKriHent5jn+wJM7
 ScQCJJs5xbryi8RH8cxMiR0G+D7aPfyUuqqzvayL3w/9ib6TDzB1QZvuXbyjGogS9MU2JZyJz1
 V6WmuY4uWiF2ZABbv8Pe2BfXHoGRPnuhF5sC7nyGYojzGdKZEpy5K99+kcbjNtOyNHNNn0p+j7
 QmoStndyNm8vLnxBotiHrjB7+zRuBgV+17F6s2yQEpfle4PCeuomK78a64fQBphN25o9Uzy2rU
 5k0=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="263892470"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:16 +0800
IronPort-SDR: fq7UC5ixwpv3kJNIiDh7Qv4sFFHRX29JL863q+BzLkS8zoSYPxr1ep4MyLcQQaXZM0Bj0mpBAt
 cBOVwrAiVszs/wiAFxERV0nB/aDVv38ak=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:13:30 -0800
IronPort-SDR: vi2W3aBmFtIvVJr54lg+DhWKKgvV+JP7rqEarA+hUsEYRGnGqs+GHmxEQFbpSM7bFDsVQaBIO2
 JQYEVtLJrtqQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:16 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/9] nvmet: add genblk ZBD backend
Date:   Sun, 29 Nov 2020 19:29:00 -0800
Message-Id: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the ZNS mode with the passthru backend. There is no
support for a generic block device backend to handle the ZBD devices
which are not NVMe devices.

This adds support to export the ZBD drives (which are not NVMe drives)
to host from the target with NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for 
patch-series overview.

I've tested the ZoneFS testcases with the null_blk memory backed NVMeOF
namespace with nvme-loop transport. The same testcases are passing on the
NVMeOF zbd-ns and are passing for null_blk without NVMeOF .

Regards,
Chaitanya

Changes from V1:-

1. Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) += zns.o.
2. Mark helpers inline.
3. Fix typos in the comments and update the comments.
4. Get rid of the curly brackets.
5. Don't allow drives with last smaller zones.
6. Calculate the zasl as a function of max_zone_append_sectors,
   bio_max_pages so we don't have to split the bio.
7. Add global subsys->zasl and update the zasl when new namespace
   is enabled.
8. Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and
   move functionality in to the report zone callback.
9. Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().
10, Allocate the zones buffer with zones size instead of bdev nr_zones.

Chaitanya Kulkarni (9):
  block: export __bio_iov_append_get_pages()
	Prep patch needed for implementing Zone Append.
  nvmet: add ZNS support for bdev-ns
	Core Command handlers and various helpers for ZBD backend which
	 will be called by target-core/target-admin etc.
  nvmet: trim down id-desclist to use req->ns
	Cleanup needed to avoid the code repetation for passing extra
	function parameters for ZBD backend handlers.
  nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
	Allows host to identify zoned namesapce.
  nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
	Allows host to identify controller with the ZBD-ZNS.
  nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
	Allows host to identify namespace with the ZBD-ZNS.
  nvmet: add zns cmd effects to support zbdev
	Allows host to support the ZNS commands when zoned-blkdev is
	 selected.
  nvmet: add zns bdev config support
	Allows user to override any target namespace attributes for
	 ZBD.
  nvmet: add ZNS based I/O cmds handlers
	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append.

 block/bio.c                       |   3 +-
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |  38 ++-
 drivers/nvme/target/io-cmd-bdev.c |  12 +
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  19 ++
 drivers/nvme/target/zns.c         | 463 ++++++++++++++++++++++++++++++
 include/linux/bio.h               |   1 +
 8 files changed, 524 insertions(+), 16 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

-- 
2.22.1

