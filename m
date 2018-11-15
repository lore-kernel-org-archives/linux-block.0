Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A22C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B3F208E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B3F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbeKPELA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:11:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:28722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKPELA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 23:11:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 10:02:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="91428162"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2018 10:02:09 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 0/3] scsi timeout handling updates
Date:   Thu, 15 Nov 2018 10:58:17 -0700
Message-Id: <20181115175820.13391-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The main objective is to remove the generic block layer's lock prefix
currently required to transition a request to its completed state by
shifting that expense to lower level drivers that need it, and removing
the software layering violation that was required to use that mechnaism.

Changes since v2:

  This one really plugs any gaps with fake timeout injection and
  additional coode comments included.

Keith Busch (3):
  blk-mq: Return true if request was completed
  scsi: Do not rely on blk-mq for double completions
  blk-mq: Simplify request completion state

 block/blk-mq.c            |  9 ++++-----
 drivers/scsi/scsi_error.c | 22 +++++++++++-----------
 drivers/scsi/scsi_lib.c   |  6 +++++-
 include/linux/blk-mq.h    | 16 +---------------
 include/scsi/scsi_cmnd.h  |  5 ++++-
 5 files changed, 25 insertions(+), 33 deletions(-)

-- 
2.14.4

