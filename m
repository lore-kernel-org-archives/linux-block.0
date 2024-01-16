Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC51CFA0
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k5my/WeK"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso96697439f.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424307; x=1706029107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hysg6RovOTmIXu4nuJHgKMsuZrXXJOpIaO3GwxVeu3A=;
        b=k5my/WeKZU3f0nNY4egjB0PL0eZTjaER18DrBqUCeDOeJXiZqj46DU+HUT6yqx2FIE
         rzMuj3mD1719hdSSDmoT4cXmyZn7FR8tj1NjNOXXiWo+WRMg/gm4j8UBI+P9ZYYehS7A
         g9mmGHB/V4fk3ObEkkcsaaPGB5rG6ln9WrBYHRySBeHPXr8QUsSfl3+ZP8V85TPZxwJ5
         Q2CD2swIp0F78DdDgUKFQBiNedNvZ/8fqT91rWiXuH0XYxKRTVmBHv2eqp0tH2dapGC5
         za1WFLneXaUQ564XeTvI66cEMwvn1hrI4qALL5OnfWIH0Fnbdopw6qM2DDg/L8qbmaWQ
         fJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424307; x=1706029107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hysg6RovOTmIXu4nuJHgKMsuZrXXJOpIaO3GwxVeu3A=;
        b=RmT8BOkzLGpUdnvuidmT2njYf//YBbTI2VjyqiBHBK/NVM3+7N/0oOj7T6r5fpv4tO
         PQdVM6wOWcO9XIPerCEvkl01rlQYsHl9BdL1Ok5MRwCwzqkr+l2hjO23uOmny7/6Kzu5
         S2Ztperj7892dlZw+7Y1o6nCzte9buHH9xHRxQ64MkJ5jHXdfP1IaEYF22ksyDDXpiYY
         nf4maL1tV8TRx6bLfkVnw9k/wWZ18iIZQ33QAxEnRuj5NyHFjEruq8/YVtbFTfIrjRex
         1MNurv8nXEb1lwiYW/XZZVYHWuymcGyPaX/GlPDJgZ2cejblF8sXVM5XIgLum6ikn+bf
         vH3w==
X-Gm-Message-State: AOJu0YxHpQOMIvFm82S8whYidY9S4qWntirMrQrhXySJHoULTrLj+5IL
	pd/YCzzcpaLdM5AIV06g7ZPN+KsuntVOSKvnqMYqyeQT+St0gQ==
X-Google-Smtp-Source: AGHT+IGULg84pADbJMSwXNynNquAyw5GlWcscj23xjlTdycAgOrsC8es4ZEikPhQVN4fGNfBHEq2kw==
X-Received: by 2002:a6b:6a1a:0:b0:7bf:356b:7a96 with SMTP id x26-20020a6b6a1a000000b007bf356b7a96mr7320136iog.2.1705424306829;
        Tue, 16 Jan 2024 08:58:26 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c14-20020a02a60e000000b0046ea43e4d0csm71744jam.168.2024.01.16.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: kbusch@kernel.org,
	joshi.k@samsung.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] block: convert struct blk_plug callback list to hlists
Date: Tue, 16 Jan 2024 09:54:26 -0700
Message-ID: <20240116165814.236767-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116165814.236767-1-axboe@kernel.dk>
References: <20240116165814.236767-1-axboe@kernel.dk>
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 26 ++++++++++++++------------
 include/linux/blkdev.h |  4 ++--
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 902799f71a59..a487881fe2a6 100644
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
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5b17d0e460e4..f339f856e44f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -950,13 +950,13 @@ struct blk_plug {
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

