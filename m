Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F930C433B4
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 15:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674A16144B
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhD2Pvg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:51:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:53552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhD2Pvf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 11:51:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619711447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zbv2sZ8WHRXeuqPvuhzjfpDdJAWYcgxCUn/VjT3s/c8=;
        b=jifMbCfn4Z7YwllS+oCN6/jj7FNV7HPoHoyWsEP2gy7fU6D7/pJ0SrKeQOCg8CFeDP1aHU
        /bRsN8KktqxfRPY14jdofbugxJGG213hqpyu96DMUWV4wpSHUYZ8MPUq9sVHQoIJUvbbya
        4eWOoW2L9Er2im+/2WC4/G91SBvyUV8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2B64AF39;
        Thu, 29 Apr 2021 15:50:47 +0000 (UTC)
From:   mwilck@suse.com
To:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Martin Wilck <mwilck@suse.com>
Subject: [RFC PATCH v2 0/2] dm: dm_blk_ioctl(): implement failover for SG_IO on dm-multipath
Date:   Thu, 29 Apr 2021 17:50:22 +0200
Message-Id: <20210429155024.4947-1-mwilck@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

Hi Mike,

here is v2 of my attempt to add retry logic to SG_IO on dm-multipath devices.

Regards
Martin

Changes v1->v2:

 - applied modifications from Mike Snitzer
 - moved SG_IO dependent code to a separate file, no scsi includes in
   dm.c any more
 - made the new code depend on a configuration option 
 - separated out scsi changes, made scsi_result_to_blk_status()
   inline to avoid dependency of dm_mod from scsi_mod (Paolo Bonzini)

Martin Wilck (2):
  scsi: convert scsi_result_to_blk_status() to inline
  dm: add CONFIG_DM_MULTIPATH_SG_IO - failover for SG_IO on dm-multipath

 block/scsi_ioctl.c         |   5 +-
 drivers/md/Kconfig         |  11 ++++
 drivers/md/Makefile        |   4 ++
 drivers/md/dm-core.h       |   5 ++
 drivers/md/dm-rq.h         |  11 ++++
 drivers/md/dm-scsi_ioctl.c | 127 +++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c            |  20 +++++-
 drivers/scsi/scsi_lib.c    |  40 ------------
 include/linux/blkdev.h     |   2 +
 include/scsi/scsi_cmnd.h   |  83 ++++++++++++++++++++++--
 10 files changed, 259 insertions(+), 49 deletions(-)
 create mode 100644 drivers/md/dm-scsi_ioctl.c

-- 
2.31.1

