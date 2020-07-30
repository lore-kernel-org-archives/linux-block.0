Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D29C433EB
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 00:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C75A20809
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 00:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UJMK/ui7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgG3AbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:31:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54208 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgG3AbX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 20:31:23 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA95420B4913;
        Wed, 29 Jul 2020 17:31:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA95420B4913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596069081;
        bh=1DIB71tr0JsOBSiaDkwHhnK28zyctORRWnwH630pHq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJMK/ui7ZCvxuGD/xiVgTPEU0Glqf1bCl3Z72BCDHl0tNHN4QgM8o0698yJKHVLgr
         hieKmi3JTo7JCqZqUjlFtr/BLJMrC3aFFZiPd1H7ki+TheRIuWCCIMcPU1R++oCAXT
         aCzNqWKLwo3ypR48j8q6mKgcnRoCgR8KhjL22T/E=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: [RFC PATCH v6 08/11] dm-verity: add bdev_setsecurity hook for root-hash
Date:   Wed, 29 Jul 2020 17:31:10 -0700
Message-Id: <20200730003113.2561644-9-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
References: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a security hook call to set a security property of a block_device
in dm-verity with the root-hash that was passed to device-mapper.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 drivers/md/dm-verity-target.c | 8 ++++++++
 include/linux/device-mapper.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 9970488e67ed..44914668398d 100644
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
 
@@ -1207,6 +1209,12 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	ti->per_io_data_size = roundup(ti->per_io_data_size,
 				       __alignof__(struct dm_verity_io));
 
+	r = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+				      DM_VERITY_ROOTHASH_SEC_NAME,
+				      v->root_digest, v->digest_size);
+	if (r)
+		goto bad;
+
 	verity_verify_sig_opts_cleanup(&verify_args);
 
 	return 0;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index ab6b8eb0a150..e8ef887e4bae 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -626,5 +626,6 @@ static inline unsigned long to_bytes(sector_t n)
 }
 
 #define DM_VERITY_SIGNATURE_SEC_NAME DM_NAME	".verity-sig"
+#define DM_VERITY_ROOTHASH_SEC_NAME DM_NAME	".verity-rh"
 
 #endif	/* _LINUX_DEVICE_MAPPER_H */
-- 
2.27.0

