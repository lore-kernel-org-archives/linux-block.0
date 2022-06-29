Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84393C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiF2Xck (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiF2Xcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:39 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF994CD9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:37 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id a15so16458656pfv.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAjMjRTjj6OvAByVtG84r0ftwTDh4HyRcJLJCCL+8N0=;
        b=hc8HDEkHP9e+iNrY3hR/JAf46H3LUZUy6ZdyCz0yRKi0XJLzOTt+BTe2LUh1Oc16HR
         apTGVYctxF65ekbDyK7YE6jFome2Ij/pDjgMMAK/C3HVcGCY9caxnagw3HpGqO32u1A0
         PyuarIM+zpAVTnfrqgAcUNYqzSvmtdA5u4JjLU41sKdVJHZd/ymyZi1AhSEjaI6QKJrA
         nEOUSQIy0nTQEAH+G+LSE7GyGNszWgnjt9K3ZlJ6QjyQFQVfwt9AZsabKNN6iAdlT5Dh
         5ySmmBJJkjmgWvptjqnbWW07NvUeKJNfMq9fjEcaKxjebXWV0kTNHGgl6+zpQd99AeyD
         fxCg==
X-Gm-Message-State: AJIora/yBNjwiw51uXWExhJ6AzNuovJY3NELAGjfIlVtHzCnjZwTjgYZ
        Iuhp/nr+7A4hvHgK49gO1cc=
X-Google-Smtp-Source: AGRyM1vzFDOyjsNJNz4OREtj95xvtzujrLDb+Q9t9QGZLbflCpf5Q5QUD+XbXi/DSzCyO5hQLgQKFA==
X-Received: by 2002:a63:88c3:0:b0:40d:5f26:bfa8 with SMTP id l186-20020a6388c3000000b0040d5f26bfa8mr4939037pgd.608.1656545557014;
        Wed, 29 Jun 2022 16:32:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 28/63] dm-snap: Combine request operation type and flags
Date:   Wed, 29 Jun 2022 16:31:10 -0700
Message-Id: <20220629233145.2779494-29-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the request operation and its flags as a single argument to improve
kernel code uniformity.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-snap-persistent.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index eaf969de3d3a..f46f930eedf9 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -226,8 +226,8 @@ static void do_metadata(struct work_struct *work)
 /*
  * Read or write a chunk aligned and sized block of data from a device.
  */
-static int chunk_io(struct pstore *ps, void *area, chunk_t chunk, int op,
-		    int op_flags, int metadata)
+static int chunk_io(struct pstore *ps, void *area, chunk_t chunk, blk_opf_t opf,
+		    int metadata)
 {
 	struct dm_io_region where = {
 		.bdev = dm_snap_cow(ps->store->snap)->bdev,
@@ -235,7 +235,7 @@ static int chunk_io(struct pstore *ps, void *area, chunk_t chunk, int op,
 		.count = ps->store->chunk_size,
 	};
 	struct dm_io_request io_req = {
-		.bi_opf = op | op_flags,
+		.bi_opf = opf,
 		.mem.type = DM_IO_VMA,
 		.mem.ptr.vma = area,
 		.client = ps->io_client,
@@ -281,11 +281,11 @@ static void skip_metadata(struct pstore *ps)
  * Read or write a metadata area.  Remembering to skip the first
  * chunk which holds the header.
  */
-static int area_io(struct pstore *ps, int op, int op_flags)
+static int area_io(struct pstore *ps, blk_opf_t opf)
 {
 	chunk_t chunk = area_location(ps, ps->current_area);
 
-	return chunk_io(ps, ps->area, chunk, op, op_flags, 0);
+	return chunk_io(ps, ps->area, chunk, opf, 0);
 }
 
 static void zero_memory_area(struct pstore *ps)
@@ -296,7 +296,7 @@ static void zero_memory_area(struct pstore *ps)
 static int zero_disk_area(struct pstore *ps, chunk_t area)
 {
 	return chunk_io(ps, ps->zero_area, area_location(ps, area),
-			REQ_OP_WRITE, 0, 0);
+			REQ_OP_WRITE, 0);
 }
 
 static int read_header(struct pstore *ps, int *new_snapshot)
@@ -328,7 +328,7 @@ static int read_header(struct pstore *ps, int *new_snapshot)
 	if (r)
 		return r;
 
-	r = chunk_io(ps, ps->header_area, 0, REQ_OP_READ, 0, 1);
+	r = chunk_io(ps, ps->header_area, 0, REQ_OP_READ, 1);
 	if (r)
 		goto bad;
 
@@ -389,7 +389,7 @@ static int write_header(struct pstore *ps)
 	dh->version = cpu_to_le32(ps->version);
 	dh->chunk_size = cpu_to_le32(ps->store->chunk_size);
 
-	return chunk_io(ps, ps->header_area, 0, REQ_OP_WRITE, 0, 1);
+	return chunk_io(ps, ps->header_area, 0, REQ_OP_WRITE, 1);
 }
 
 /*
@@ -733,8 +733,8 @@ static void persistent_commit_exception(struct dm_exception_store *store,
 	/*
 	 * Commit exceptions to disk.
 	 */
-	if (ps->valid && area_io(ps, REQ_OP_WRITE,
-				 REQ_PREFLUSH | REQ_FUA | REQ_SYNC))
+	if (ps->valid && area_io(ps, REQ_OP_WRITE | REQ_PREFLUSH | REQ_FUA |
+				 REQ_SYNC))
 		ps->valid = 0;
 
 	/*
@@ -774,7 +774,7 @@ static int persistent_prepare_merge(struct dm_exception_store *store,
 			return 0;
 
 		ps->current_area--;
-		r = area_io(ps, REQ_OP_READ, 0);
+		r = area_io(ps, REQ_OP_READ);
 		if (r < 0)
 			return r;
 		ps->current_committed = ps->exceptions_per_area;
@@ -811,7 +811,7 @@ static int persistent_commit_merge(struct dm_exception_store *store,
 	for (i = 0; i < nr_merged; i++)
 		clear_exception(ps, ps->current_committed - 1 - i);
 
-	r = area_io(ps, REQ_OP_WRITE, REQ_PREFLUSH | REQ_FUA);
+	r = area_io(ps, REQ_OP_WRITE | REQ_PREFLUSH | REQ_FUA);
 	if (r < 0)
 		return r;
 
