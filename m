Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3ECC48BE0
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 20:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954D66128A
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 20:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFKUlJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:41:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59410 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFKUlI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 16:41:08 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DB921FD6D;
        Fri, 11 Jun 2021 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623443949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZQ2SQMwdANGbatiHgkjUZHqFpFcMpyifm6yWuH18a24=;
        b=baciI1dnUr5I/AvtRCNspDmKTZxhzngi2WQubtUHgmg+Ob5iAdV/3Fk70e/9qqKZ14rmh7
        iiPhIRefxBxtYHZLXNDMStUH/vOWyg8OHrrcJRHGFXxZf21Vg/X22fEQs0iji7LC2qCwZD
        XAtyIo21rGlDFbM+dzckpwtDTJuThWE=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 494C1118DD;
        Fri, 11 Jun 2021 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623443949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZQ2SQMwdANGbatiHgkjUZHqFpFcMpyifm6yWuH18a24=;
        b=baciI1dnUr5I/AvtRCNspDmKTZxhzngi2WQubtUHgmg+Ob5iAdV/3Fk70e/9qqKZ14rmh7
        iiPhIRefxBxtYHZLXNDMStUH/vOWyg8OHrrcJRHGFXxZf21Vg/X22fEQs0iji7LC2qCwZD
        XAtyIo21rGlDFbM+dzckpwtDTJuThWE=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 7BwmEO3Jw2BGEgAALh3uQQ
        (envelope-from <mwilck@suse.com>); Fri, 11 Jun 2021 20:39:09 +0000
From:   mwilck@suse.com
To:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH v3 0/2]  dm: dm_blk_ioctl(): implement failover for SG_IO on dm-multipath
Date:   Fri, 11 Jun 2021 22:25:07 +0200
Message-Id: <20210611202509.5426-1-mwilck@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

Hello Mike,

here is v3 of my attempt to add retry logic to SG_IO on dm-multipath devices.
Sorry that it took such a long time.

Regards
Martin

Changes v2->v3:

 - un-inlined scsi_result_to_blk_status again, and move the helper
   __scsi_result_to_blk_status to block/scsi_ioctl.c instead
   (Bart v. Assche)
 - open-coded the status/msg/host/driver-byte -> result conversion
   where the standard SCSI helpers aren't usable (Bart v. Assche)
    
Changes v1->v2:

 - applied modifications from Mike Snitzer
 - moved SG_IO dependent code to a separate file, no scsi includes in
   dm.c any more
 - made the new code depend on a configuration option 
 - separated out scsi changes, made scsi_result_to_blk_status()
   inline to avoid dependency of dm_mod from scsi_mod (Paolo Bonzini)

Martin Wilck (2):
  scsi: export __scsi_result_to_blk_status() in scsi_ioctl.c
  dm: add CONFIG_DM_MULTIPATH_SG_IO - failover for SG_IO on dm-multipath

 block/scsi_ioctl.c         |  52 ++++++++++++++-
 drivers/md/Kconfig         |  11 ++++
 drivers/md/Makefile        |   4 ++
 drivers/md/dm-core.h       |   5 ++
 drivers/md/dm-rq.h         |  11 ++++
 drivers/md/dm-scsi_ioctl.c | 127 +++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c            |  20 +++++-
 drivers/scsi/scsi_lib.c    |  29 +--------
 include/linux/blkdev.h     |   3 +
 9 files changed, 229 insertions(+), 33 deletions(-)
 create mode 100644 drivers/md/dm-scsi_ioctl.c

-- 
2.31.1

