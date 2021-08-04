Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB8C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12A460FC4
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhHDJrD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbhHDJrD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 05:47:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE315C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fvsUbwlFEoRI8kb3Ny9Y/H3Je3QM8w7Pz0LaVm6TT2Q=; b=QatlhMpBN74i8woS7Jq+3bcfD1
        K3e5kJ16jbRkYeJliYQJqcM1dZasG8pRncTpw4fEaCbS/7x/XcGYF3Kj+X8fFSuxwPNS/w53wKRAx
        eoAjuTfDkeNZY6enDTLcevzT22HGNdE/Sbu+Ie18tZsjWSoaOk+B2LcqFYzquIEEzUlmWFKBkTKHI
        JRb2Z69CWgOsj6Jsg1J+xfEC2ORPTgMvG2EqwYNpfLFG/H1EEVdUddnQjQkHLpD+5ORiViO3Xfjjh
        l7nMQWEj5UHtYVqAg926zLicEW1VWnOD6K4E61tDzpqCQl/Gs9aOcOKEWSTeoBvXrLNaEyjZba3YJ
        Ij7BBP6A==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDT1-005eAr-0z; Wed, 04 Aug 2021 09:45:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 6/8] dm: move setting md->type into dm_setup_md_queue
Date:   Wed,  4 Aug 2021 11:41:45 +0200
Message-Id: <20210804094147.459763-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
References: <20210804094147.459763-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move setting md->type from both callers into dm_setup_md_queue.
This ensures that md->type is only set to a valid value after the queue
has been fully setup, something we'll rely on future changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-ioctl.c | 4 ----
 drivers/md/dm.c       | 5 +++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 2209cbcd84db..2575074a2204 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1436,9 +1436,6 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	}
 
 	if (dm_get_md_type(md) == DM_TYPE_NONE) {
-		/* Initial table load: acquire type of table. */
-		dm_set_md_type(md, dm_table_get_type(t));
-
 		/* setup md->queue to reflect md's type (may block) */
 		r = dm_setup_md_queue(md, t);
 		if (r) {
@@ -2187,7 +2184,6 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 	if (r)
 		goto err_destroy_table;
 
-	md->type = dm_table_get_type(t);
 	/* setup md->queue to reflect md's type (may block) */
 	r = dm_setup_md_queue(md, t);
 	if (r) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7971ec8ce677..f003bd5b93ce 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2052,9 +2052,9 @@ EXPORT_SYMBOL_GPL(dm_get_queue_limits);
  */
 int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 {
-	int r;
+	enum dm_queue_mode type = dm_table_get_type(t);
 	struct queue_limits limits;
-	enum dm_queue_mode type = dm_get_md_type(md);
+	int r;
 
 	switch (type) {
 	case DM_TYPE_REQUEST_BASED:
@@ -2081,6 +2081,7 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	r = dm_table_set_restrictions(t, md->queue, &limits);
 	if (r)
 		return r;
+	md->type = type;
 
 	blk_register_queue(md->disk);
 
-- 
2.30.2

