Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90580028
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031207; cv=none; b=YKI5X3HfEsAXcCMVf08jhiRTC2x5St8AD5W+LYZe5PiDEPVf+j6qifZfer2DmefC3ke0KaktiCZJFYdKoW3vLiipqLSEHHd5MHJZphQ36I7wTYXBhbKzlQE5d1a+nzECDNuP23ibXhsbc0iUUinoxxn+o2gvSi3C5io0oRuGS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031207; c=relaxed/simple;
	bh=0dAmO6x2styloC+APT5Im4vJgC6epFT1Zp74CyP8Mww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWm4KjnrvLy92DtzA5li9V+MqK7wyzCvTe90qIDLl0x8A0bN5LTitgdYoA7ecnApZDwF1Kxcm+QIVqep9jqp4wrTQ0/JscaH//B1B9o1d+qyyoYBC6LS0G651AdbINIhyrJnFdG5eBo9B3UWav1AkS/X727aQgcyjcKDE8Ihz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U1nfBwfU; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U1nfBwfU"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso60900239f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031205; x=1706636005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/Ald4gHrRglycNy6wXvcN5PFyAD6wLCcn4WkvqJFC0=;
        b=U1nfBwfUVvg4gjho/xp8VxuWK3QoxpChY/ACWDu9+B/v70n4oTQx7ubSDKG57Bflo8
         Xwxy6Wggb8ZUf6U/cbCOhEWssGQTE1PnQtxKA4JevUbcVJqA4mu4JJHG6dDBtqS7Z4cf
         iL6f8PDYD0FdfdoTLUBUVlsQyziN2Blp7L0HLAAsiQVw6Vy62dIy4pPueIJh2qPAuHBY
         BA/TV/d15zjsaz3M/bmKbQraQq7IT6J7kE6Uux9DcJnVZcHnsPiZy5TRmQW4ZGFIa+rx
         p/qxlWzH9eCk2nYMfpfbHEbpppmJ65KstRtRoyO79XsIVvMuORejj+4ZwpBJO8Ohzn42
         y9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031205; x=1706636005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/Ald4gHrRglycNy6wXvcN5PFyAD6wLCcn4WkvqJFC0=;
        b=svn3zoq/DVkPOdGstggYmUNHunWiFlUTSvHzycNJBCVZuUFYUJnn3oHqorZ2tHveDx
         gld/yJe+V26tLgE02lgNsh6n7iiZivS2lovoouAbUY0YYGte4BakmmIn+8gROtS1XZW2
         QJ7QhQxvz36IhLpp5kihFRvwNIc8fGBRcElHJA5o0NDHZfq7WzOv4aYdLGWAVlalU1y8
         vaTlOXcGPqNxg5fuN/mnzt4eovBf9qZ6cYQdqAave3/mrQPpXpKlJc7hZ+hcHBgkDPpj
         L3lVsQYe2GtGdE1HG8KCDPS3IdrSeWGeG4cClnsk+nCT133BpTfT7haiDDc/mYSkcnl7
         Otxg==
X-Gm-Message-State: AOJu0YzKh+yzP0aun5xXs3AdHGnxqwtzjZO5y/CLW8OTDnihX4UNZuuY
	SSL8BQx3IiRgOZ/DiIihI9/MU+ohS3mnlh0HpRn0jz01GxGo0TrvIS/CmijMnfDOCcg/twtUy7k
	quTU=
X-Google-Smtp-Source: AGHT+IElRCm4FAwDKHywvZV0YwCO0C/6R+Ki3OzPgiP7nMOonsmT50PyINzaXuntWvrzICAf02VBow==
X-Received: by 2002:a5d:9304:0:b0:7be:e376:fc44 with SMTP id l4-20020a5d9304000000b007bee376fc44mr9545381ion.2.1706031205127;
        Tue, 23 Jan 2024 09:33:25 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu12-20020a0566382e0c00b0046df4450843sm3640708jab.50.2024.01.23.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:33:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] block: convert struct blk_plug callback list to hlists
Date: Tue, 23 Jan 2024 10:30:38 -0700
Message-ID: <20240123173310.1966157-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123173310.1966157-1-axboe@kernel.dk>
References: <20240123173310.1966157-1-axboe@kernel.dk>
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
index ce6d057de2f0..f3105a519ef4 100644
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

