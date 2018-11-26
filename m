Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_POST,TVD_PH_BODY_META_ALL,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E8C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E718820855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E718820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeK0DwO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:52:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:52438 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeK0DwO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:52:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 08:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="95155555"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2018 08:57:32 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 0/3] scsi timeout handling updates
Date:   Mon, 26 Nov 2018 09:54:27 -0700
Message-Id: <20181126165430.4519-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The iterative update to the previous version taking into account review
comments.

Background:

The main objective is to remove the generic block layer's lock prefix
currently required to transition a request to its completed state by
shifting that expense to lower level drivers that actually need it,
and removing the software layering violation that was required to use
that mechnaism.

Changes since v3:

  The complete state is moved to its own field separate from the
  non-atomic scsi_cmnd "flags" field.

  Code comments added to describe the more obscure handling for fake
  timeout injection.

Keith Busch (3):
  blk-mq: Return true if request was completed
  scsi: Do not rely on blk-mq for double completions
  blk-mq: Simplify request completion state

 block/blk-mq.c            |  9 ++++-----
 drivers/scsi/scsi_error.c | 22 +++++++++++-----------
 drivers/scsi/scsi_lib.c   | 13 ++++++++++++-
 include/linux/blk-mq.h    | 16 +---------------
 include/scsi/scsi_cmnd.h  |  4 ++++
 5 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.14.4

