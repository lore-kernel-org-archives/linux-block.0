Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A3C282CE
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B4520879
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfEVRxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 13:53:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:57850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfEVRxQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 13:53:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 10:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,500,1549958400"; 
   d="scan'208";a="174471726"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2019 10:53:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/2] Reset timeout for paused hardware
Date:   Wed, 22 May 2019 11:48:10 -0600
Message-Id: <20190522174812.5597-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hardware may temporarily stop processing commands that have
been dispatched to it while activating new firmware. Some target
implementation's paused state time exceeds the default request expiry,
so any request dispatched before the driver could quiesce for the
hardware's paused state will time out, and handling this may interrupt
the firmware activation.

This two-part series provides a way for drivers to reset dispatched
requests' timeout deadline, then uses this new mechanism from the nvme
driver's fw activation work.

Keith Busch (2):
  blk-mq: provide way to reset rq timeouts
  nvme: reset request timeouts during fw activation

 block/blk-mq.c           | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 20 ++++++++++++++++++++
 include/linux/blk-mq.h   |  1 +
 3 files changed, 51 insertions(+)

-- 
2.14.4

