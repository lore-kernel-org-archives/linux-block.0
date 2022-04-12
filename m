Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4590BC38A05
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 10:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357803AbiDLKL5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352158AbiDLJxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 05:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B31AD6578E
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649753830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70p5VagpBmPe1ErjJXzpwZs4Ulq+GjTz3KUD1zbrsgo=;
        b=gFACc/rfDWYgD4+1QXiXDK3l+E+tXX5x3tK4F17ul0z3KCDEzTo00s+mCXPMvyuZqXDbTX
        zq/7Qpugn1hvk3MNam0n5tyJBRTyh3foLKz9TS1R35KQ17BHObCN7s644fW+ftKFUbdFV/
        rfh76pkfG/nUxPbVK//C86DwXuTNZa4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-TDaavN0oOlKTGZoJsZXY3g-1; Tue, 12 Apr 2022 04:57:07 -0400
X-MC-Unique: TDaavN0oOlKTGZoJsZXY3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2A08380390C;
        Tue, 12 Apr 2022 08:57:06 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D73E145BA42;
        Tue, 12 Apr 2022 08:57:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/8] dm: pass 'dm_io' instance to dm_io_acct directly
Date:   Tue, 12 Apr 2022 16:56:11 +0800
Message-Id: <20220412085616.1409626-4-ming.lei@redhat.com>
In-Reply-To: <20220412085616.1409626-1-ming.lei@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All the other 4 parameters are retrieved from the 'dm_io' instance, so
not necessary to pass all four to dm_io_acct().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 62f7af815ef8..ed85cd1165a4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -498,9 +498,12 @@ static bool bio_is_flush_with_data(struct bio *bio)
 	return ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size);
 }
 
-static void dm_io_acct(bool end, struct mapped_device *md, struct bio *bio,
-		       unsigned long start_time, struct dm_stats_aux *stats_aux)
+static void dm_io_acct(struct dm_io *io, bool end)
 {
+	struct dm_stats_aux *stats_aux = &io->stats_aux;
+	unsigned long start_time = io->start_time;
+	struct mapped_device *md = io->md;
+	struct bio *bio = io->orig_bio;
 	bool is_flush_with_data;
 	unsigned int bi_size;
 
@@ -528,7 +531,7 @@ static void dm_io_acct(bool end, struct mapped_device *md, struct bio *bio,
 
 static void __dm_start_io_acct(struct dm_io *io)
 {
-	dm_io_acct(false, io->md, io->orig_bio, io->start_time, &io->stats_aux);
+	dm_io_acct(io, false);
 }
 
 static void dm_start_io_acct(struct dm_io *io, struct bio *clone)
@@ -557,7 +560,7 @@ static void dm_start_io_acct(struct dm_io *io, struct bio *clone)
 
 static void dm_end_io_acct(struct dm_io *io)
 {
-	dm_io_acct(true, io->md, io->orig_bio, io->start_time, &io->stats_aux);
+	dm_io_acct(io, true);
 }
 
 static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
-- 
2.31.1

