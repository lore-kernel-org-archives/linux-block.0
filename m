Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2305C4346E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A102145D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo/c9gLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgIVCdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 22:33:02 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF84C061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:33:02 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so8733368qvb.8
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtWlq/47WlrxDfVxu0B44CPpyCD9vao2Nu3MMDC0MmU=;
        b=Eo/c9gLFowJNZLtWG08NnllCNEhxoXXcTsM2WEtV1BiQDZsj2A6l5KvqSum1jKYPxW
         HXPfDzWJcmgJ5sMNghmoxhfeNw2FQ5S3fJm4iKrcnLlHVkXm/YZRcqLP0QBBJdIHSXvu
         MmJv+SAfNu7phAnu2mVQz3e51kRJxf49w//rgCU/Q0HTXhGuhar+KeqXSNXSzU0/ALE9
         1MwVwA5koPlDH0cMfVShop/oBZNUbKx5yRErKoFMSnTgbOsEpAvdyVLkVe1twwwln2a9
         ZLoqDu19nc/PrzEYY3pJTYNuwIFYQ2bzCrX/GtA1ICGi2Xp4F+OgF0Pxxl/G2Ys2QGM+
         JeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NtWlq/47WlrxDfVxu0B44CPpyCD9vao2Nu3MMDC0MmU=;
        b=PjvQzK5RoPAoYKYvBrinGQimzboOxcACWJtk65/KmIu56Mvvo6CLMt6qOlv28pB5ml
         V9dsEJ0PxXVUF95/3B326iiErJtbv4gzOuQkQtVuGBqAB3u04QMD1BBwVUHmY+U4l9qC
         iIdf1gGYZybM2pDpDJGOYGvfcV5PQgQgdl3n510zvK7FBhkH694oAS4MwLJoMV49VIBv
         QEyaKewJCCyXc54tR1o4KuXtdjuzk+rGeL1A/brNr9DWR8Q8bm6MApdKJ8DCZO7J3ge6
         TYHcTSKIU4gLcRXda+p6ChjflHQ6o4/pB75PuVQUrAK3DvOHF9ah0Rs5Bv5b19sAlfMY
         yGvg==
X-Gm-Message-State: AOAM532F3gmPcJEoXkJGxS8mvd03Nso52dSszuScd8x1t/iNGXzRINYC
        0C69Zet6uy6mpbN+tatwVbM=
X-Google-Smtp-Source: ABdhPJwstwVK6opMvdpCo+BnKDX6pHoZtowyEX6H2tPqAhqWRAaCcm28GxGYEq4JsEtXWaht8CgOYw==
X-Received: by 2002:a0c:d443:: with SMTP id r3mr3613860qvh.20.1600741981873;
        Mon, 21 Sep 2020 19:33:01 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m10sm11779149qti.46.2020.09.21.19.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:33:01 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 6/6] dm: change max_io_len() to use blk_max_size_offset()
Date:   Mon, 21 Sep 2020 22:32:51 -0400
Message-Id: <20200922023251.47712-7-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200922023251.47712-1-snitzer@redhat.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using blk_max_size_offset() enables DM core's splitting to impose
ti->max_io_len (via q->limits.chunk_sectors) and also fallback to
respecting q->limits.max_sectors if chunk_sectors isn't set.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6ed05ca65a0f..3982012b1309 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1051,22 +1051,18 @@ static sector_t max_io_len_target_boundary(sector_t sector, struct dm_target *ti
 static sector_t max_io_len(sector_t sector, struct dm_target *ti)
 {
 	sector_t len = max_io_len_target_boundary(sector, ti);
-	sector_t offset, max_len;
+	sector_t max_len;
 
 	/*
 	 * Does the target need to split even further?
+	 * - q->limits.chunk_sectors reflects ti->max_io_len so
+	 *   blk_max_size_offset() provides required splitting.
+	 * - blk_max_size_offset() also respects q->limits.max_sectors
 	 */
-	if (ti->max_io_len) {
-		offset = dm_target_offset(ti, sector);
-		if (unlikely(ti->max_io_len & (ti->max_io_len - 1)))
-			max_len = sector_div(offset, ti->max_io_len);
-		else
-			max_len = offset & (ti->max_io_len - 1);
-		max_len = ti->max_io_len - max_len;
-
-		if (len > max_len)
-			len = max_len;
-	}
+	max_len = blk_max_size_offset(dm_table_get_md(ti->table)->queue,
+				      dm_target_offset(ti, sector));
+	if (len > max_len)
+		len = max_len;
 
 	return len;
 }
-- 
2.15.0

