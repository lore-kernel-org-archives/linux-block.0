Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F9C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 12:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D38206DD
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 12:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9C5PNcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfCEMHx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:07:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45627 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 07:07:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id v21so5534627pfm.12;
        Tue, 05 Mar 2019 04:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BsEzVCvwGK6M7Xc2Y76nAD2CABqsRBztWfQhrBKUuJA=;
        b=S9C5PNcznwBbVXGbrx6Ft+i8qh0ltt18JXL357ajWPitR4XQg4wUBcUF3yu64eAmz7
         tZsCJQCZlwep1s6zw8gjzKXzxGjg/fLuF7etlRe6L5oDhlgGanzIHu7LpHYi6vkQQ0rJ
         IxBK3Sq7M6PNJzK0vsxvz3lB0lgM7m430yQEWrcRn6LqGPKFGDH5io6uh6ikpX2paAYp
         4jIYog4jAhttu3qbuGgli7s7eqFgy8x4/0Z2xNXGAXOJfw60AkVJn8/cWySzwSkb2KCx
         wVAMNiHr0H4wdCdC6nXH3cAFeSXdPMWECcV73gQha4FmyyCWywxvrB0oro9M6Fg6fFia
         fJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BsEzVCvwGK6M7Xc2Y76nAD2CABqsRBztWfQhrBKUuJA=;
        b=CJjharJb0Dzt+d20NISQf/fIwXal8zLSw8K6E0LWsc0lu34DppF+GUyeplsmRN06/P
         WD3161eJYFz5J+YY9PR8X6T1fv5jO/mDVBy5OD7Nd63QEPg3NPQN8c/pdYyjlJg32LUV
         vfsT/9kD2dBVXBLUtkErkvhdlmA2yBHg5ZB1t36sJX18Q4v0Czy03JXwt8RhG4MkSH4P
         frX9utcy1hDksxwtrHlWxm330QdDMgAG08ME/Y27cthz39m1d5ga/Z8JzdxK1mTE3XS6
         k7SMeAlHGpKeeLalbceL3ruouhhSPW5Ke2XVkmEt2P+BfUlnVFT/qNz9PmP3z3uHo8DK
         QTTA==
X-Gm-Message-State: APjAAAXTgfaHdjckR0e4KOqwNsD0zQQKUQUWX7nPn8cT6JVJCR5bKaJY
        Bnnbi5aBm/tPh9uCkVAtnHk=
X-Google-Smtp-Source: APXvYqwG9LsScOtdspf7CU8V4Sys2VsjdT22607NT2xgnpqqixzFc5Qn8BdvX3zEsg06V8OKA7C4+w==
X-Received: by 2002:a63:e752:: with SMTP id j18mr1092948pgk.313.1551787672243;
        Tue, 05 Mar 2019 04:07:52 -0800 (PST)
Received: from localhost.localdomain (172.96.249.239.16clouds.com. [172.96.249.239])
        by smtp.gmail.com with ESMTPSA id m9sm13319601pfi.31.2019.03.05.04.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:07:51 -0800 (PST)
From:   Guoju Fang <fangguoju@gmail.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, Guoju Fang <fangguoju@gmail.com>
Subject: [PATCH 1/2] bcache: fix crashes stopping bcache device before read miss done
Date:   Tue,  5 Mar 2019 07:07:15 -0500
Message-Id: <1551787635-3085-1-git-send-email-fangguoju@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio from upper layer is considered completed when bio_complete()
returns. In most scenarios bio_complete() is called in search_free(),
but when read miss happens, the bio_compete() is called when backing
device reading completed, while the struct search is still in use until
cache inserting finished.

If someone stops the bcache device just then, the device may be closed
and released, but after cache inserting finished the struct search will
access a freed struct cached_dev.

This patch add the reference of bcache device before bio_complete() when
read miss happens, and put it after the search is not used.

Signed-off-by: Guoju Fang <fangguoju@gmail.com>
---
 drivers/md/bcache/request.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 1507041..24aa2a8 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -705,14 +705,14 @@ static void search_free(struct closure *cl)
 {
 	struct search *s = container_of(cl, struct search, cl);
 
-	atomic_dec(&s->d->c->search_inflight);
+	atomic_dec(&s->iop.c->search_inflight);
 
 	if (s->iop.bio)
 		bio_put(s->iop.bio);
 
 	bio_complete(s);
 	closure_debug_destroy(cl);
-	mempool_free(s, &s->d->c->search);
+	mempool_free(s, &s->iop.c->search);
 }
 
 static inline struct search *search_alloc(struct bio *bio,
@@ -755,13 +755,13 @@ static void cached_dev_bio_complete(struct closure *cl)
 	struct search *s = container_of(cl, struct search, cl);
 	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 
-	search_free(cl);
 	cached_dev_put(dc);
+	search_free(cl);
 }
 
 /* Process reads */
 
-static void cached_dev_cache_miss_done(struct closure *cl)
+static void cached_dev_read_error_done(struct closure *cl)
 {
 	struct search *s = container_of(cl, struct search, cl);
 
@@ -799,7 +799,22 @@ static void cached_dev_read_error(struct closure *cl)
 		closure_bio_submit(s->iop.c, bio, cl);
 	}
 
-	continue_at(cl, cached_dev_cache_miss_done, NULL);
+	continue_at(cl, cached_dev_read_error_done, NULL);
+}
+
+static void cached_dev_cache_miss_done(struct closure *cl)
+{
+	struct search *s = container_of(cl, struct search, cl);
+	struct bcache_device *d = s->d;
+
+	if (s->iop.replace_collision)
+		bch_mark_cache_miss_collision(s->iop.c, s->d);
+
+	if (s->iop.bio)
+		bio_free_pages(s->iop.bio);
+
+	cached_dev_bio_complete(cl);
+	closure_put(&d->cl);
 }
 
 static void cached_dev_read_done(struct closure *cl)
@@ -832,6 +847,7 @@ static void cached_dev_read_done(struct closure *cl)
 	if (verify(dc) && s->recoverable && !s->read_dirty_data)
 		bch_data_verify(dc, s->orig_bio);
 
+	closure_get(&dc->disk.cl);
 	bio_complete(s);
 
 	if (s->iop.bio &&
-- 
1.8.3.1

