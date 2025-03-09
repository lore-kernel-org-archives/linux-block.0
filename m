Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF3380
	for <linux-block@vger.kernel.org>; Sun,  9 Mar 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741559355; cv=none; b=hpHmrvTUi9aYbsCWPTqK1GgekNg7iujfhnIEFeS1k0Fx4D1brfgAJi8HX1HW549Cy2tSeHYkYwfM19UW1rvuUHpk9hcPWDvKhiDMXusdkyXbCPBdDNoJjxNN+vhH+BCy1sm7PlVfFGREDLUU8xfbrv0cKRpKaVt44VgtXkJ4WxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741559355; c=relaxed/simple;
	bh=NQESKpUO4ZMrFMIoAIQEI3ZvDpobn+WJnUTsMH0BTGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmGx3KC6Qt/jiquC/AL3zx5IKjvc996eDjHNeRYcGXbykD0J3Qor5IscFWxicxmkmIC7QUYw9Q7NZRl2OTVX3r1V90EPdyWEhHxpp0yfviUbS3FUJwLMt1Mllb+OLOjTfX53oUFL+X4YwfeZDKsI+06cSgNMcVYifF0c0OjCt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSSx0wiO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSSx0wiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741559352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhIqTYUkB46Mb29OKVAlh9WVdW1uNLVb6c9d10hk6Co=;
	b=jSSx0wiOheh/XjsODIA3lOd/aHrpaRfSpJZce3gEHgTPWqV3yj+JZdEEQXoYFl1XKWVNyj
	7CBhF6H7k2h0bzo5Tdm1vHN25cTZuJz9CS5qUS64xniGgCbUpYW5aeU65Vp3QwNgUPoyDF
	cLeRt4XdQndhQuej9HS9hHx7mMmJRms=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-UxP6utj-Mgefkedba8sHLw-1; Sun,
 09 Mar 2025 18:29:09 -0400
X-MC-Unique: UxP6utj-Mgefkedba8sHLw-1
X-Mimecast-MFC-AGG-ID: UxP6utj-Mgefkedba8sHLw_1741559348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B8701955D4B;
	Sun,  9 Mar 2025 22:29:08 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B2CD180AF71;
	Sun,  9 Mar 2025 22:29:07 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 529MT5ZC449847
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 9 Mar 2025 18:29:05 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 529MT5Df449846;
	Sun, 9 Mar 2025 18:29:05 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH 7/7] dm: allow devices to revalidate existing zones
Date: Sun,  9 Mar 2025 18:29:03 -0400
Message-ID: <20250309222904.449803-8-bmarzins@redhat.com>
In-Reply-To: <20250309222904.449803-1-bmarzins@redhat.com>
References: <20250309222904.449803-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

dm_revalidate_zones() only allowed devices that had no zone resources
set up to call blk_revalidate_disk_zones(). If the device already had
zone resources, disk->nr_zones would always equal md->nr_zones so
dm_revalidate_zones() returned without doing any work. Instead, always
call blk_revalidate_disk_zones() if you are loading a new zoned table.

However, if the device emulates zone append operations and already has
zone append emulation resources, the table size cannot change when
loading a new table. Otherwise, all those resources will be garbage.

If emulated zone append operations are needed and the zone write pointer
offsets of the new table do not match those of the old table, writes to
the device will still fail. This patch allows users to safely grow and
shrink zone devices. But swapping arbitrary zoned tables will still not
work.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-zone.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index ac86011640c3..7e9ebeee7eac 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -164,16 +164,8 @@ int dm_revalidate_zones(struct dm_table *t, struct request_queue *q)
 	if (!get_capacity(disk))
 		return 0;
 
-	/* Revalidate only if something changed. */
-	if (!disk->nr_zones || disk->nr_zones != md->nr_zones) {
-		DMINFO("%s using %s zone append",
-		       disk->disk_name,
-		       queue_emulates_zone_append(q) ? "emulated" : "native");
-		md->nr_zones = 0;
-	}
-
-	if (md->nr_zones)
-		return 0;
+	DMINFO("%s using %s zone append", disk->disk_name,
+	       queue_emulates_zone_append(q) ? "emulated" : "native");
 
 	/*
 	 * Our table is not live yet. So the call to dm_get_live_table()
@@ -392,6 +384,17 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 		return 0;
 	}
 
+	/*
+	 * If the device needs zone append emulation, and the device already has
+	 * zone append emulation resources, make sure that the chunk_sectors
+	 * hasn't changed size. Otherwise those resources will be garbage.
+	 */
+	if (!lim->max_hw_zone_append_sectors && disk->zone_wplugs_hash &&
+	    q->limits.chunk_sectors != lim->chunk_sectors) {
+		DMERR("Cannot change zone size when swapping tables");
+		return -EINVAL;
+	}
+
 	/*
 	 * Warn once (when the capacity is not yet set) if the mapped device is
 	 * partially using zone resources of the target devices as that leads to
-- 
2.48.1

