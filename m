Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8B2C4361A
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B06920774
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 21:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iAu1j3Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgG1Vhh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:37:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47324 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbgG1Vg3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 17:36:29 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6863720B4911;
        Tue, 28 Jul 2020 14:36:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6863720B4911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595972188;
        bh=vg35NUb5viRTBc3gz5xNFGdvD07DP1igB/7oSuLvUzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAu1j3CwEht1n4k1cq9d7V/dl4YDzypXn9oBpZRIUkO3cZlOgjhb6VbW55GwHTSQG
         ph4ZwMuQSZQUNtgN1Ld3xZVtpPK06eJIPR86MDs0MPDBVWzGuj6H9F3PLrrodhUWN0
         SKkVicjnmrlCD+5W4xrW5duS5X9RuqDp16rWi85w=
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
Subject: [RFC PATCH v5 07/11] dm-verity: add bdev_setsecurity hook for dm-verity signature
Date:   Tue, 28 Jul 2020 14:36:07 -0700
Message-Id: <20200728213614.586312-8-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a security hook call to set a security property of a block_device
in dm-verity with the results of a verified, signed root-hash.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 drivers/md/dm-verity-verify-sig.c | 7 +++++++
 include/linux/device-mapper.h     | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
index 27dac8aa2e5a..242e2421d3c8 100644
--- a/drivers/md/dm-verity-verify-sig.c
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -8,7 +8,10 @@
 #include <linux/device-mapper.h>
 #include <linux/verification.h>
 #include <keys/user-type.h>
+#include <linux/security.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include "dm-core.h"
 #include "dm-verity.h"
 #include "dm-verity-verify-sig.h"
 
@@ -182,6 +185,10 @@ int verity_verify_root_hash(const struct dm_verity *v)
 		goto cleanup;
 
 	sig_target->passed = true;
+
+	ret = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+					DM_VERITY_SIGNATURE_SEC_NAME,
+					v->sig->sig, v->sig->sig_size);
 cleanup:
 	kfree(root_hash);
 	return ret;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 8750f2dc5613..02be0be21d38 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -624,4 +624,6 @@ static inline unsigned long to_bytes(sector_t n)
 	return (n << SECTOR_SHIFT);
 }
 
+#define DM_VERITY_SIGNATURE_SEC_NAME DM_NAME	".verity-sig"
+
 #endif	/* _LINUX_DEVICE_MAPPER_H */
-- 
2.27.0

