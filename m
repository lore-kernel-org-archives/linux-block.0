Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288F9CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbiGNSI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbiGNSIW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:22 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990BC68733
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:21 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id v7so2601102pfb.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cr168tYQgG0su4Z1z0svUMsQj1YVnx98U6fmpHkkkWU=;
        b=U6gAA0CwfyP49j1OQw7KIMNWpi2WN5zZjXUrqeDg+d6QM4uQo3+1iIDQcbi1rLlttb
         +czp/s2d/j3PvsoyfIq3EnosfELSY3kGnhX2Trcd9MbRumLyHuYhOEoQVjkRmwOw39nk
         KaEZuXNWE9b0DkMavbwphpnYkUWV9jNnZ9XUNHsJH7OpegNOGr0HavoV6vH3JYfffNzN
         vXQYqlN3Gs3gdbkM+KGDvSjwD6S5e/Ppj4Axuz62so9kr2bivOBXua4FeW2EQlW5hHRJ
         NZj+NOaS/PXiJn2boQsERdifck3tK8hcI/LqPDGDYN33EgnZf215lw+ZoGXccMG8WNKy
         wHJg==
X-Gm-Message-State: AJIora8XP73Nbmo1ofq+M0hTdsjNb31+Gg74mbOW69JvAJSBK8RYKUkV
        SQfpAlxBehM6qHxHxeYg0P8=
X-Google-Smtp-Source: AGRyM1skZEZRzGy67Hut6ttNRJEiXiyQt0o0FCHHoKQidmAAN/fbZ/H94mp3wI1kAldQFRYBcVBpOQ==
X-Received: by 2002:a05:6a00:1aca:b0:528:1f7d:4ffe with SMTP id f10-20020a056a001aca00b005281f7d4ffemr9914371pfv.16.1657822101208;
        Thu, 14 Jul 2022 11:08:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 28/63] dm-snap: Combine request operation type and flags
Date:   Thu, 14 Jul 2022 11:06:54 -0700
Message-Id: <20220714180729.1065367-29-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the request operation and its flags as a single argument to improve
kernel code uniformity.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
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
 
