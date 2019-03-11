Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C5FC43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4298F20657
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552316062;
	bh=6E5OiG9PvcwioeZLqoP6bCb/pgUEqAFk+fNglkzWem0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CnExs9gFpZ2u2jsqb7xqHHS1pWowrH/Sj+xAESUNsl73qCXlyJ1O7UXxWRn2yjxL+
	 jqGwvM4Bft3g1PUVEcKBVcZxTEgULVrc5Oh//6GJb0gehxvNvNth12TiDYLG1xrEah
	 3kNGhko1EIep1vt+gzOLmOZ3a53fzWdqoMWe8XoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCKOyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:54:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:10660 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfCKOyV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 10:54:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 07:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="327532753"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2019 07:54:20 -0700
Date:   Mon, 11 Mar 2019 08:54:59 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: NVMe: Regression: write zeros corrupts ext4 file system
Message-ID: <20190311145457.GA10411@localhost.localdomain>
References: <20190311022441.GA16849@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311022441.GA16849@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 10:24:42AM +0800, Ming Lei wrote:
> Hi,
> 
> It is observed that ext4 is corrupted easily by running some workloads
> on QEMU NVMe, such as:
> 
> 1) mkfs.ext4 /dev/nvme0n1
> 
> 2) mount /dev/nvme0n1 /mnt
> 
> 3) cd /mnt; git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 4) then the following error message may show up:
> 
> [ 1642.271816] EXT4-fs error (device nvme0n1): ext4_mb_generate_buddy:747: group 0, block bitmap and bg descriptor inconsistent: 32768 vs 23513 free clusters
> 
> Or fsck.ext4 will complain after running 'umount /mnt'
> 
> The issue disappears by reverting 6e02318eaea53eaafe6 ("nvme: add support for the
> Write Zeroes command").
> 
> QEMU version:
> 
> QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

In QEMU, blk_aio_pwrite_zeroes() takes bytes, but the nvme controller
thought it was blocks. Oops, that went by unnoticed till now!

We should fix QEMU (patch below). Question is, should we quirk driver 
for older versions too?

---
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7c8c63e8f5..e8fe8f1ddd 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -324,8 +324,8 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
-    uint64_t aio_slba = slba << (data_shift - BDRV_SECTOR_BITS);
-    uint32_t aio_nlb = nlb << (data_shift - BDRV_SECTOR_BITS);
+    uint64_t offset = slba << data_shift;
+    uint32_t count = nlb << data_shift;
 
     if (unlikely(slba + nlb > ns->id_ns.nsze)) {
         trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
@@ -335,7 +335,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     req->has_sg = false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, aio_slba, aio_nlb,
+    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
                                         BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
     return NVME_NO_COMPLETE;
 }
--
