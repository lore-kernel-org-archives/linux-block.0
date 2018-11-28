Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E64C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 13:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD72E20672
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 13:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/GPZsR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD72E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLINCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 08:02:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35709 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLINCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 08:02:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3727017pgs.2;
        Sun, 09 Dec 2018 05:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CW/vXP5FuhAeaOED6Zg1hzVaHvu8cPMGeNKAgU1ecMY=;
        b=p/GPZsR2oicf//XmIFCsb9IMsl1Pq2LBXJwg58G4tHARzNmTWSy2UswOJWddDxMVoX
         XxPJykxboxmzESV+tWIvFbvz7SY0TjOplaQAacCaFEZ/OeBI/dYY1eTGwYmZpzfq9Zwb
         TczqsNah7L4EBhv7pir9seNx6W90uQuzutIkvMwLHx1tLkmRqMg3G8Wv7VBycbRbzFg8
         j2eFuZb1vM0WrDPFbRbNfiP8HXbx+Oc+y1jDKtMWJ2YyvEzpDWJHOj2a9MbJUClli5D+
         nvUzkW6VVoU365/qrI3QB2HtZSPJUMam90eR1fE8xpSYyicMGC+28wDLm+rQn5KZN+0Z
         e/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CW/vXP5FuhAeaOED6Zg1hzVaHvu8cPMGeNKAgU1ecMY=;
        b=GztS8z79que3L96CHHMxcgrwU8cBCHl7rUK/ZR8pM23X+HKdpJ0RFyGoUmhor/EuI+
         yt1BQQ9jS1LcUz2/aejGebUttyPFK2Qtirk4off0i7w+m8D7fzfsNdLION9zKEP9JJOw
         El+fK8q4obvTfuteMP7mez2Qqs2PfYkB2NsxIhdUDqgqQwr96S46cB/jejKNYDhWgYAt
         gQiTWuBQ3thv9N8c8l3Bjmgpyeii3cVkfLxGkkYXCMHvXKg8UNxQ6XJ3lj83FB/2Mddi
         hOJmoeEKXMaW7FPNLqv8zQATdCbpJ+CFy20Svg4dftHOr6l3q0J2h3yEzfdb1UAMOIR3
         psFg==
X-Gm-Message-State: AA+aEWbJpD74jCPna7vsrAPKjiuy6uRf26BxZu/XsuC6GOh8ae4VJvwH
        51Xq1xxL57tfYmcrN7XB8Jw=
X-Google-Smtp-Source: AFSGD/W+0P42er3wNfl2xrLIMeffYa8H8OeP6lrKxcGk0EPkoP6A7bh/SroIMcv5VvibC44Gzb3VrA==
X-Received: by 2002:a63:e348:: with SMTP id o8mr7548452pgj.158.1544360569806;
        Sun, 09 Dec 2018 05:02:49 -0800 (PST)
Received: from localhost.localdomain.localdomain ([113.110.228.23])
        by smtp.gmail.com with ESMTPSA id l19sm18753364pfi.71.2018.12.09.05.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 05:02:48 -0800 (PST)
From:   Guoju Fang <fangguoju@gmail.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, Guoju Fang <fangguoju@gmail.com>
Subject: [PATCH] bcache: print number of keys in trace_bcache_journal_write
Date:   Thu, 29 Nov 2018 05:28:53 +0800
Message-Id: <1543440533-129759-1-git-send-email-fangguoju@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sometimes flush journal may be very frequent, so it's useful to dump
number of keys every time write journal.

Signed-off-by: Guoju Fang <fangguoju@gmail.com>
---
 drivers/md/bcache/journal.c   |  2 +-
 include/trace/events/bcache.h | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 522c742..b2fd412 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -663,7 +663,7 @@ static void journal_write_unlocked(struct closure *cl)
 				 REQ_SYNC|REQ_META|REQ_PREFLUSH|REQ_FUA);
 		bch_bio_map(bio, w->data);
 
-		trace_bcache_journal_write(bio);
+		trace_bcache_journal_write(bio, w->data->keys);
 		bio_list_add(&list, bio);
 
 		SET_PTR_OFFSET(k, i, PTR_OFFSET(k, i) + sectors);
diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
index 2cbd6e4..e4526f8 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -221,9 +221,30 @@
 	TP_ARGS(c)
 );
 
-DEFINE_EVENT(bcache_bio, bcache_journal_write,
-	TP_PROTO(struct bio *bio),
-	TP_ARGS(bio)
+TRACE_EVENT(bcache_journal_write,
+	TP_PROTO(struct bio *bio, u32 keys),
+	TP_ARGS(bio, keys),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev			)
+		__field(sector_t,	sector			)
+		__field(unsigned int,	nr_sector		)
+		__array(char,		rwbs,	6		)
+		__field(u32,		nr_keys			)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= bio_dev(bio);
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
+		__entry->nr_keys	= keys;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+	),
+
+	TP_printk("%d,%d  %s %llu + %u keys %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __entry->nr_keys)
 );
 
 /* Btree */
-- 
1.8.3.1

