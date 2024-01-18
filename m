Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B22E632
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605841; cv=none; b=RUHCECk/lyKMQpT5/rCdxFBedI4yoMRfAiiPmktP2K25ZxnPXLSIu3HkNBIoLpEMNfla6Ln0IN4rD7DeY5ArsZgeBmVqyfJj8Jlwto19WRvIs/LAYMK/hh7qrY+1A0fvEbcC+ifQytwmNGty/ABOtBd4Z6iPY9cOZk9AxXFJ2l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605841; c=relaxed/simple;
	bh=izpqGQ98MQGbVGqs/qD+xOZIdrARJYufHDBYcyxdY0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utGsa8wnMyugziX0VdBm2HDwVaV/OMHvPA0eYtoXRc7UmzkJI2Z9UDqYH4FQfiBeFZegzwDcFNfXtU5gwV9q4bx1WHit3zBqzaRGx8YilRfS4OA5vNp1leEdzbdDh/FwB2PcHWHlNXkvj6LL+5WIaMZG6pPIEQRcp5iHQ8v/y1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qp+4dD9N; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qp+4dD9N"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso100639f.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705605838; x=1706210638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYN1mAKCjzZWpKS1gzf0M4TIG0GwrP7YPsWEeIuIwrk=;
        b=qp+4dD9NhlPU02ujcAl6KcKtN564VqvmipxKFMQx4tHpBjC3NqzsoBAnkwdET50y+T
         VLRqxz7vH1DSj6uNbX4SIJtXdtDUF66DMyjMWsjoOXeXtQz/A588In6hESkZSjTInMjY
         MpNviTZBExlF7S7XHIpXBa6PbJMAhU4EeEy+6BtFBePrybSbXYADidhshb9Du4k9di2m
         sIxozipRK7VWrzZRPvVdF9dvHAZ+EIivmYvf6pMD70hp6L/AyC40iOY3UmdXcJ4n4hRx
         sBITRcGrc0cmQHgvOfms801PrLkjqS4hEEC9ofpo8wEGN6iTZbR9W39yQQ6DUXNVmjIi
         /3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605838; x=1706210638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYN1mAKCjzZWpKS1gzf0M4TIG0GwrP7YPsWEeIuIwrk=;
        b=Zf7XbY4ye1YB7HZWpT/fHk5KtH2eatFLeDVkaZKj/i7ybC08swhTsJIob/DvnNKunj
         FkhVXBClZCPIB2hv9vZWMS9zWo1unVBn6qLb1bpjwGKTba9A+5a8IaJ9BAyW8UcjgrTf
         SGlFPXILr0SLJFIvNKPoROqls6wMvE/TEQ6/bqyA06GSnTDO89Qp7G8S4fBtraO3AWF/
         SrnZ/vHVNpBe4yRwWYW5+Yh/2MIs/mnHcjnLzll8YTEt+tjrnzbsAzHLLGapik5yO6lJ
         GhWa7hvUujBKFYD7PGYFLrivpU7eTPb86e85qq10c/Qe8HUv2cjZMpfn1zXpfgU1fzbx
         r0/A==
X-Gm-Message-State: AOJu0Yyg1YUIsCRcK6PN+CfSaNB8OHd6Xd7k2BSW2o6aCUMhdYSc7Djq
	GBT1UUBNb1mjMzD8M8FQuOZxnojBwjDYSy8l1fDRj4PEmRBkFUYNC5ZWh7EpBjGpNT5PoY2o6uH
	jEPA=
X-Google-Smtp-Source: AGHT+IFVswBvHO0hg7lwOFANGJ9CZxaQ0mFENKgGRLSn0weUo4B6LrrfY2C6/Y19sbVjtU7cAz+aVQ==
X-Received: by 2002:a5e:8302:0:b0:7be:e376:fc44 with SMTP id x2-20020a5e8302000000b007bee376fc44mr357973iom.2.1705605838367;
        Thu, 18 Jan 2024 11:23:58 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc18-20020a056638671200b0046e5c69376asm1155588jab.40.2024.01.18.11.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:23:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] block: convert struct blk_plug callback list to hlists
Date: Thu, 18 Jan 2024 12:20:57 -0700
Message-ID: <20240118192343.953539-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118192343.953539-1-axboe@kernel.dk>
References: <20240118192343.953539-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently use a doubly linked list, which means the head takes up
16 bytes. As any iteration goes over the full list by first splicing it
to an on-stack copy, we never need to remove members from the middle of
the list.

Convert it to an hlist instead, saving 8 bytes in the blk_plug structure.
This also helps save 40 bytes of text in the core block code, tested on
arm64.

This does mean that flush callbacks will be run in reverse. While this
should not pose a problem, we can always change the list splicing to
just iteration-and-add instead, preservering ordering. These lists are
generally just a single entry (or a few entries), either way this should
be fine.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 26 ++++++++++++++------------
 drivers/md/raid1-10.c  |  2 +-
 include/linux/blkdev.h |  4 ++--
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dd593008511c..f28859b4a3ef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1080,7 +1080,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned char nr_ios)
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
 	plug->has_elevator = false;
-	INIT_LIST_HEAD(&plug->cb_list);
+	INIT_HLIST_HEAD(&plug->cb_list);
 
 	/*
 	 * Store ordering should not be needed here, since a potential
@@ -1120,16 +1120,18 @@ EXPORT_SYMBOL(blk_start_plug);
 
 static void flush_plug_callbacks(struct blk_plug *plug, bool from_schedule)
 {
-	LIST_HEAD(callbacks);
+	HLIST_HEAD(callbacks);
 
-	while (!list_empty(&plug->cb_list)) {
-		list_splice_init(&plug->cb_list, &callbacks);
+	while (!hlist_empty(&plug->cb_list)) {
+		struct hlist_node *entry, *tmp;
 
-		while (!list_empty(&callbacks)) {
-			struct blk_plug_cb *cb = list_first_entry(&callbacks,
-							  struct blk_plug_cb,
-							  list);
-			list_del(&cb->list);
+		hlist_move_list(&plug->cb_list, &callbacks);
+
+		hlist_for_each_safe(entry, tmp, &callbacks) {
+			struct blk_plug_cb *cb;
+
+			cb = hlist_entry(entry, struct blk_plug_cb, list);
+			hlist_del(&cb->list);
 			cb->callback(cb, from_schedule);
 		}
 	}
@@ -1144,7 +1146,7 @@ struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug, void *data,
 	if (!plug)
 		return NULL;
 
-	list_for_each_entry(cb, &plug->cb_list, list)
+	hlist_for_each_entry(cb, &plug->cb_list, list)
 		if (cb->callback == unplug && cb->data == data)
 			return cb;
 
@@ -1154,7 +1156,7 @@ struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug, void *data,
 	if (cb) {
 		cb->data = data;
 		cb->callback = unplug;
-		list_add(&cb->list, &plug->cb_list);
+		hlist_add_head(&cb->list, &plug->cb_list);
 	}
 	return cb;
 }
@@ -1162,7 +1164,7 @@ EXPORT_SYMBOL(blk_check_plugged);
 
 void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
-	if (!list_empty(&plug->cb_list))
+	if (!hlist_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
 	blk_mq_flush_plug_list(plug, from_schedule);
 	/*
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 512746551f36..4a1b6f17067f 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -152,7 +152,7 @@ static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 	plug = container_of(cb, struct raid1_plug_cb, cb);
 	bio_list_add(&plug->pending, bio);
 	if (++plug->count / MAX_PLUG_BIO >= copies) {
-		list_del(&cb->list);
+		hlist_del(&cb->list);
 		cb->callback(cb, false);
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 80da19cb3b39..65e8c5f2e43a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -951,13 +951,13 @@ struct blk_plug {
 	bool multiple_queues;
 	bool has_elevator;
 
-	struct list_head cb_list; /* md requires an unplug callback */
+	struct hlist_head cb_list; /* md requires an unplug callback */
 };
 
 struct blk_plug_cb;
 typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
 struct blk_plug_cb {
-	struct list_head list;
+	struct hlist_node list;
 	blk_plug_cb_fn callback;
 	void *data;
 };
-- 
2.43.0

