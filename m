Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F64C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B318721789
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mkJwfCE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgJHPB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgJHPB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 11:01:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5AC061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gCtmTvU+4iB0ZJq8Xk5I9RTnD1fzvpVWZs/DrC+eDx0=; b=mkJwfCE/zdBfQ5/PvlUgeWlPT5
        GeJCtAybmlKtJ7JrAZ+pIBoNvlPfR4irFWuiT5ov9lw5FQuxpF+LVTXLc9bVWaRRQtL15P/y0moyO
        9BWZ9pDerBeUjWij7KP7bWc4QnXOXtf5FimiDKyLpMVmtOXe2tdx06HOzQkr86MdelnWTnpgwxKpI
        5guZR1EXDREF7LmDtDd1J9aJnVMDo3eJ/GesM504HS9sQ+eP3bwzstw9wIuPNIi2CqoHP0ckKekV4
        +U4BHHmgedsHOlgMoq3maYxq65jYZLY43J263AMyUXZrmtzIhZlUNjpkzkIsNJ6AfHY3KxNqJTtoW
        KlK+MaaA==;
Received: from [2001:4bb8:184:92a2:cbfa:206d:64ea:205c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQXQ5-0006Wu-RA; Thu, 08 Oct 2020 15:01:26 +0000
Date:   Thu, 8 Oct 2020 17:01:25 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 5.10
Message-ID: <20201008150125.GA1495381@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:

  scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08

for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:

  nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)

----------------------------------------------------------------
nvme update for 5.10:

 - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
 - misc cleanups (Chaitanya Kulkarni)
 - major refactoring of the scanning code (me)

----------------------------------------------------------------
Chaitanya Kulkarni (3):
      nvme-loop: don't put ctrl on nvme_init_ctrl error
      nvme-core: remove extra variable
      nvme-core: remove extra condition for vwc

Christoph Hellwig (20):
      block: optimize blk_queue_zoned_model for !CONFIG_BLK_DEV_ZONED
      nvme: fix initialization of the zone bitmaps
      nvme: remove the disk argument to nvme_update_zone_info
      nvme: rename nvme_validate_ns to nvme_validate_or_alloc_ns
      nvme: rename _nvme_revalidate_disk
      nvme: rename __nvme_revalidate_disk
      nvme: lift the check for an unallocated namespace into nvme_identify_ns
      nvme: call nvme_identify_ns as the first thing in nvme_alloc_ns_block
      nvme: factor out a nvme_configure_metadata helper
      nvme: freeze the queue over ->lba_shift updates
      nvme: clean up the check for too large logic block sizes
      nvme: remove the 0 lba_shift check in nvme_update_ns_info
      nvme: set the queue limits in nvme_update_ns_info
      nvme: update the known admin effects
      nvme: remove nvme_update_formats
      nvme: revalidate zone bitmaps in nvme_update_ns_info
      nvme: query namespace identifiers before adding the namespace
      nvme: move nvme_validate_ns
      nvme: refactor nvme_validate_ns
      nvme: remove nvme_identify_ns_list

 drivers/nvme/host/core.c   | 455 ++++++++++++++++++++-------------------------
 drivers/nvme/host/nvme.h   |   9 +-
 drivers/nvme/host/zns.c    |  16 +-
 drivers/nvme/target/loop.c |   4 +-
 include/linux/blkdev.h     |   4 +-
 5 files changed, 220 insertions(+), 268 deletions(-)
