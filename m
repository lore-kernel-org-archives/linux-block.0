Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E2C2BB85
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 22:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FB1207FF
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 22:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Za+87sx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDFWOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:14:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58672 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgDFWOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 18:14:52 -0400
Received: from dede-linux.corp.microsoft.com (unknown [131.107.147.242])
        by linux.microsoft.com (Postfix) with ESMTPSA id D9FD4207295C;
        Mon,  6 Apr 2020 15:14:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9FD4207295C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586211289;
        bh=vtS7tZDadPt65wOWMS99/Fu0/Y/o77wsMAmWG3vccKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Za+87sx4it9lXflcDR643xZamIdKSRNW/GYBWvhRnJY/lwsO6L9cUb4fldBG+L0eu
         I70hwphAqelfOGA5PDk87j/F5H8srGusw7HpbcL3e9aQ6phKfyrYld39BRzHwHWthl
         nm7+OpOibz+6WWUVY9WYu2CS1KumKIhu2DVpA1oo=
From:   deven.desai@linux.microsoft.com
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 09/12] dm-verity: add bdev_setsecurity hook for root-hash
Date:   Mon,  6 Apr 2020 15:14:36 -0700
Message-Id: <20200406221439.1469862-10-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
References: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Deven Bowers <deven.desai@linux.microsoft.com>

Add a security hook call to set a security property of a block_device
in dm-verity with the root-hash that was verified to match the merkel-tree.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 drivers/md/dm-verity-target.c | 8 ++++++++
 include/linux/device-mapper.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index c507f3a4e237..225f67ab378d 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -16,8 +16,10 @@
 #include "dm-verity.h"
 #include "dm-verity-fec.h"
 #include "dm-verity-verify-sig.h"
+#include "dm-core.h"
 #include <linux/module.h>
 #include <linux/reboot.h>
+#include <linux/security.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -530,6 +532,12 @@ static int verity_verify_io(struct dm_verity_io *io)
 			return -EIO;
 	}
 
+	r = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+				      DM_VERITY_ROOTHASH_SEC_NAME,
+				      v->root_digest, v->digest_size);
+	if (unlikely(r < 0))
+		return r;
+
 	/*
 	 * At this point, the merkel tree has finished validating.
 	 * if signature was specified, validate the signature here.
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 6bd49aa48186..467db44de194 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -625,5 +625,6 @@ static inline unsigned long to_bytes(sector_t n)
 }
 
 #define DM_VERITY_SIGNATURE_SEC_NAME DM_NAME	".verity-sig"
+#define DM_VERITY_ROOTHASH_SEC_NAME DM_NAME	".verity-rh"
 
 #endif	/* _LINUX_DEVICE_MAPPER_H */
-- 
2.26.0

