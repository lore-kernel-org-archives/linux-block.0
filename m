Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D713CC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DC42133F
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X2O9CYMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZBsD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:48:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15693 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZBsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 21:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561513683; x=1593049683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xUw+MD3VlgufJngshYeX3WtdTL/x5T203xypje7oPKg=;
  b=X2O9CYMOuC56DzBEeWZBxWn4I+uBLXUTVtviHySev1oA1IqLE5YEy1sv
   /mGhqP0TxmXgy6Kh2by8ROD39W1r1WSw7KEuJYqbz1vM3W5sN91iD/SmS
   eSdEOvghBdh62R+BFcIfu7i02BnxPTQQylGrhYjwJPwYELP6AQIaGPLtW
   LaKC94dpMTze1X8dkGTZ/GkNL3NLxyoFk8l8ymryjZ8Wsq4vYktysDoE7
   HmNWyNcK+RGp76GHAmxzALID6krYbPMR+XEPjMB7eGQahdXOUuiSJNHTX
   ijTWP9DhOn8CVp1kVvQXriSqBsSfqNukl0l51Ytmsut7HYUaWSBBw9WHv
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="116422519"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 09:48:02 +0800
IronPort-SDR: wrWlNOZ0loVmDPtZ3zVa/5p+3oYdKNBLQmJYC8Plk+9HtCF+JDe1glE1alyB0d7Fc8n1w7behf
 mD8vCaEzRgDaFjh9cPi0ajwrWJp/HTuDskdxRe+frtoJ1uzSNP7rTx5ijpfFCzbIqqr+j5k83m
 IhGRbodssFyGTgIGVaQB9+Xz1o0c8rQGUS52vq2U33V2va80ynxOK/8rUcydjAknzSCKsdPS1H
 2X7KSssJAaOiQVrmsma3Fzo3GQs6bQz8W2yMvXs1z/qdG3nyTg7sLpL65EWP31WHIHdU1DB+Um
 SpCdZoWHkrCGB2rC3+0t5KNV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 25 Jun 2019 18:47:11 -0700
IronPort-SDR: Rw8upLbn9kjvv/LaCSkqyBwahxbcThGYFaOun0OwhcHuVU64W87UzuzZrBsjGk2wryuikLLDgC
 T8rZQRrrmkZV5OpiECb4ylHQCOyGU2bsRzQb93LyGELVJtz0xpo3mn91U7CEQpp9FYTW5YJckl
 LOe3nmQm4L0xt0BNMyUZG79A3ng/StDsLHAV59I81tdvLLq0jngIesTj+5eDpQYYCMvrzb5NfW
 QnWdTMajC74Esnfu6av+aFu/Mf42PzfNjXxWaBd6q4W544Q9KDLb7zIP3frST4+R6hcElr+hvg
 Mi8=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2019 18:48:00 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 0/3] Fix zone revalidation memory allocation failures
Date:   Wed, 26 Jun 2019 10:47:56 +0900
Message-Id: <20190626014759.15285-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series addresses a reccuring problem with zone revalidation
failures observed during extensive testing with memory constrained
system and device hot-plugging.

The problem source is failure to allocate large memory areas with
alloc_pages() or kmalloc() in blk_revalidate_disk_zones() to store the
disk array of zones (struct blk_zone) or in sd_zbc_report_zones() for
the report zones command reply buffer.

The solution proposed here is to:
1) limit the number of zones to be reported with a single report zones
command execution, and
2) Use vmalloc to allocate large-ish arrays and buffers in place of
alloc_pages() and kmalloc().

With these changes, tests do not show any zone revalidation failures
while not impacting the time taken for a disk initial zone inspection
during device scan.

Changes from V1:
* Added call to invalidate_kernel_vmap_range() for vmalloc-ed buffers
  in patch 1.
* Fixed patch 2 compilation error with Sparc64 (kbuild robot)

Damien Le Moal (3):
  block: Allow mapping of vmalloc-ed buffers
  sd_zbc: Fix report zones buffer allocation
  block: Limit zone array allocation size

 block/bio.c            | 12 ++++++-
 block/blk-zoned.c      | 29 +++++++--------
 drivers/scsi/sd_zbc.c  | 80 +++++++++++++++++++++++++++++++-----------
 include/linux/blkdev.h |  5 +++
 4 files changed, 89 insertions(+), 37 deletions(-)

-- 
2.21.0

