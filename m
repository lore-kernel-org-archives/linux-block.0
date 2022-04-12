Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEFEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 10:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiDLKME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353594AbiDLJy2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 05:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B14D694B2
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649753841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENiG48S4lecm27JC6JuRduBuieawhZMbZ0O9e/hFj/w=;
        b=ewRJiXwfFJiFXRUTHhBIx1m2jBr8+Kaq41XFd0l4A2xpNMrFzSB5CPbfD1FcznN8RMfMzp
        oT+EiJKQcMt6IYpZmAOXW58IirhJ7l5/D2+XK2UeMaHr9b13wi+f7kKb62hbTWxEErFur+
        WcZXHBkOMF4iMJmnpa4jmQaDhauPJo0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-5t-kp4ASPZGp3eNMcZ2hZQ-1; Tue, 12 Apr 2022 04:57:20 -0400
X-MC-Unique: 5t-kp4ASPZGp3eNMcZ2hZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAA673C14841;
        Tue, 12 Apr 2022 08:57:19 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5922401DF3;
        Tue, 12 Apr 2022 08:57:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] dm: don't grab target io reference in dm_zone_map_bio
Date:   Tue, 12 Apr 2022 16:56:14 +0800
Message-Id: <20220412085616.1409626-7-ming.lei@redhat.com>
In-Reply-To: <20220412085616.1409626-1-ming.lei@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm_zone_map_bio() is only called from __map_bio in which the io's
reference is grabbed already, and the reference won't be released
until the bio is submitted, so no necessary to do it dm_zone_map_bio
any more.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-core.h |  7 -------
 drivers/md/dm-zone.c | 10 ----------
 drivers/md/dm.c      |  7 ++++++-
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index aefb080c230d..811c0ccbc63d 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -283,13 +283,6 @@ static inline void dm_io_set_flag(struct dm_io *io, unsigned int bit)
 	io->flags |= (1U << bit);
 }
 
-static inline void dm_io_inc_pending(struct dm_io *io)
-{
-	atomic_inc(&io->io_count);
-}
-
-void dm_io_dec_pending(struct dm_io *io, blk_status_t error);
-
 static inline struct completion *dm_get_completion_from_kobject(struct kobject *kobj)
 {
 	return &container_of(kobj, struct dm_kobject_holder, kobj)->completion;
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index c1ca9be4b79e..85d3c158719f 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -545,13 +545,6 @@ int dm_zone_map_bio(struct dm_target_io *tio)
 		return DM_MAPIO_KILL;
 	}
 
-	/*
-	 * The target map function may issue and complete the IO quickly.
-	 * Take an extra reference on the IO to make sure it does disappear
-	 * until we run dm_zone_map_bio_end().
-	 */
-	dm_io_inc_pending(io);
-
 	/* Let the target do its work */
 	r = ti->type->map(ti, clone);
 	switch (r) {
@@ -580,9 +573,6 @@ int dm_zone_map_bio(struct dm_target_io *tio)
 		break;
 	}
 
-	/* Drop the extra reference on the IO */
-	dm_io_dec_pending(io, sts);
-
 	if (sts != BLK_STS_OK)
 		return DM_MAPIO_KILL;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index df1d013fb793..3c3ba6b4e19b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -937,11 +937,16 @@ static inline bool dm_tio_is_normal(struct dm_target_io *tio)
 		!dm_tio_flagged(tio, DM_TIO_IS_DUPLICATE_BIO));
 }
 
+static void dm_io_inc_pending(struct dm_io *io)
+{
+	atomic_inc(&io->io_count);
+}
+
 /*
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
  */
-void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
+static void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 {
 	/* Push-back supersedes any I/O errors */
 	if (unlikely(error)) {
-- 
2.31.1

