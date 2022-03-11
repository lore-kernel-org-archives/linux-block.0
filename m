Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B129C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 10:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348013AbiCKKgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348024AbiCKKgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 05:36:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAF61BD987;
        Fri, 11 Mar 2022 02:35:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18DCC21900;
        Fri, 11 Mar 2022 10:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646994929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2A0s9MNxg2Q3sbNoaDjqzamUO4PIFL9q9tcCNyUQzoo=;
        b=kOTKT+erKLJg8Sd4nahKDsq5kn2bQQGml4MXQ+m1NTG+glUxRhoBrK+ftjenbbb2FK5k4N
        eJMBxr9G8aAIvMFDCdAYBBuywecStRBkVAMuu2sI8CW0jHZ3ZUIZZpAs+Mz/MUbN1DD61B
        Go1rLUSZ6tZYV9RL/MORon1oqiyXz4s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE33E13A85;
        Fri, 11 Mar 2022 10:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2CMJMfAlK2JydgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 11 Mar 2022 10:35:28 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] xen/blkfront: speed up purge_persistent_grants()
Date:   Fri, 11 Mar 2022 11:35:27 +0100
Message-Id: <20220311103527.12931-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

purge_persistent_grants() is scanning the grants list for persistent
grants being no longer in use by the backend. When having found such a
grant, it will be set to "invalid" and pushed to the tail of the list.

Instead of pushing it directly to the end of the list, add it first to
a temporary list, avoiding to scan those entries again in the main
list traversal. After having finished the scan, append the temporary
list to the grant list.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index aa996b637d0b..378262ec47ae 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2533,6 +2533,7 @@ static void purge_persistent_grants(struct blkfront_info *info)
 
 	for_each_rinfo(info, rinfo, i) {
 		struct grant *gnt_list_entry, *tmp;
+		LIST_HEAD(grants);
 
 		spin_lock_irqsave(&rinfo->ring_lock, flags);
 
@@ -2550,9 +2551,11 @@ static void purge_persistent_grants(struct blkfront_info *info)
 			list_del(&gnt_list_entry->node);
 			rinfo->persistent_gnts_c--;
 			gnt_list_entry->gref = GRANT_INVALID_REF;
-			list_add_tail(&gnt_list_entry->node, &rinfo->grants);
+			list_add_tail(&gnt_list_entry->node, &grants);
 		}
 
+		list_splice_tail(&grants, &rinfo->grants);
+
 		spin_unlock_irqrestore(&rinfo->ring_lock, flags);
 	}
 }
-- 
2.34.1

