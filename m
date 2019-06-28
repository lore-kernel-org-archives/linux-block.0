Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C9C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C682086D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfF1MCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:02:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbfF1MCE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:02:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E1EDB627;
        Fri, 28 Jun 2019 12:02:03 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 28/37] bcache: set largest seq to ja->seq[bucket_index] in journal_read_bucket()
Date:   Fri, 28 Jun 2019 19:59:51 +0800
Message-Id: <20190628120000.40753-29-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In journal_read_bucket() when setting ja->seq[bucket_index], there might
be potential case that a later non-maximum overwrites a better sequence
number to ja->seq[bucket_index]. This patch adds a check to make sure
that ja->seq[bucket_index] will be only set a new value if it is bigger
then current value.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 98ee467ec3f7..3d321bffddc9 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -156,7 +156,8 @@ reread:		left = ca->sb.bucket_size - offset;
 			list_add(&i->list, where);
 			ret = 1;
 
-			ja->seq[bucket_index] = j->seq;
+			if (j->seq > ja->seq[bucket_index])
+				ja->seq[bucket_index] = j->seq;
 next_set:
 			offset	+= blocks * ca->sb.block_size;
 			len	-= blocks * ca->sb.block_size;
-- 
2.16.4

