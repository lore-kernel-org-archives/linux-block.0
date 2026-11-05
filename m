Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866228;
	b=V9GrVTmmbf/m3wrR+ytw1TXCOWUVuAODHZVDsB8M72LL5ilPa5rPLb2UkrFe+C6jlGS9
	 jEQLqfXpFJjFJTxq7+AuXTkr9YwcWlJq0/wxI4tk/5cRMjtXOnUfQxXBE5gxKDqXjMuXS
	 UNSAYfIUtsAbmH6r/RFmyZGy32RStkxPkfae41yPJNtRbyJ77ieVqeg4YPYt0WtRaxBxU
	 5UP8fYjHE4IMKEqdLcz+rW0RlC9QVnjswAV/DIiZsq4WfETCxV4WfhTJfiE2unliNYu7s
	 7NXsInPiMlmRAa4iWnE8D7EYo25kGRqrcod/sD55L14yqjm2nes6vZMvxTXx4jsfxAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uXh0iha/4VP9dzuigCmM9TrRRukz7g4ClrVx0LThZLY=;
	b=icN6kQaDLcuX8dU/p6jD/hMJhIutOfNI9spUx8adyiUFbQgRASYVyw0T/QIWe7njUPiG
	 4Qxk7yDRRjWDmDNiYsn/czW0TE4giSSdz7zHHLyu3nGBLl9Tw/DaZfRhMzw8tMjvWTH68
	 zqHD2Jzh/7iKfpqBPamUnVAL9RhCnGmIVHGCgA90Sp8ddy5XCzamUdUPFrDEDmw7WR2p7
	 TX8fCsh4oMJzy29/dqvuOIu+lDpifnZNXISfGehbB49oLEgr+dINWKlSbGAKtFx/yl+0C
	 PDNiPXFZkMEXrmPK8+Qy7qTf+V1jflU6U63ofYuL2PG6b2W8n0+/sE2bN05darW7MPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="N/Qx1IS5";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4563606A31B
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 08:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4563606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N/Qx1IS5
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1284546f8f.1
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2026 00:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793866226; x=1794471026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXh0iha/4VP9dzuigCmM9TrRRukz7g4ClrVx0LThZLY=;
        b=N/Qx1IS5dy7gvkOcK1TXZaqscveNhbL+KnTmQ99w4X1HCotJLcRwDWMzag0WTqQb0X
         GZKEZattQNx1zbUfXihhqRVerpQrKSNS+ITsYDTA4p7l7kRnzuFeXqMkzCHJ1OXa3Kc0
         eKvTRT79PMQYAr1JM643c8Pfr4z5bjrsM6M2kQdYVE2jUV5trR2EVYG0537Rwa5nKg3n
         9xRP7QBTPvKtNAjucPKwmCnleiCh3lULvU0ncKy0lKmxpjgEvybvxqjRqJCAZXafW4Jx
         oZKtfTyg/fIri8wIZ0CxinlaYybANYnYzm02JfHMaOPM0+yQS1hIEVisEjsyhnlTAPQJ
         r5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866226; x=1794471026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXh0iha/4VP9dzuigCmM9TrRRukz7g4ClrVx0LThZLY=;
        b=O9gXyb4NUkrfNzzVR47PJ9TdiB8WC34xYXVZib7O2DrBUbbKtz3cfsvoiJbUIdE1LJ
         spyfkLm6dXq3xnp+sFSHER2qn22426IXGXLzyKJzd4AtJ4mfp2MUuKOMchpNTuPMDsv6
         LU/r0Tg1K3rr29Yes8VG04q+SeVl21xFerUCqrMza7Th8+4dFJsAhBYYSzLSHmLsHKEq
         p2ErZTMlML8lueL92EhJN2Hj3rW0B5ra0MgTUwi+QPyxhuhelKwtBHLN9rKzgmNudSm2
         7yiFB0s3CTY+PdqtZU490IELtNgFQPsdL32p+ZYCTcrFdyzKYS3fKx0Z6FB3N1gU03TZ
         jbyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWetmIQKcP6S1hdNTKQ/glRO6t09zS9Ot7eDQmKyzrIEdMEyb4PE+IAZ3AafpPEaxob9jWcqgyqCUGsA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+YOkW/VAY5Q4Gf/bw/e9tgOvZF2dBEuYWwADlt2m+6c8I9yT3p
	ySygS52ACGS+N4VPLUUyXlHloUkclVh3aTDvpADTmcTd2HYPmHeL9Ew/
X-Gm-Gg: AYBFou23eo4v3JRqzsEHWCSd8ZDZ7I94DpAyE7EB9pQiRQEakVLwLwdo5VRN9SLeABS
	c7ThLv+gwODXIYckEHtfHHfRjvrhUSb6ackorl7l2voyzbjbPs3KL6URmZkOBw8vB7z1T3J9cGU
	jPCTSy9Y4MnCs9noc8AeHTwYabYGyIFtPOnyp0nqUVIcY1yIEeOYkzX+SUwU+W6VHk+pSj1RgZh
	cx107F1NxJZkMWOD/6wbV2Kqr4k3l6IT59dD4umeGsoPXerr4jesCCxQrp3Si2vyeSmGfOZpjrq
	9bPiaZCNaEW2bQQBg8Jb3vANytyHkpvv48/SrgKy8jAVkbgiFPM8wKZ67VQSjXBsaB1pizVNqaR
	Vi7dn+Kdb6z5qERlEUDEZtssE+wygQakwFwggqP7rTFJAUu3rn/ASz56okBjQzEDa2TpO59G5kX
	+OC5bthSeG0kJjWXYhj+sRGnOgrgCcKdF9ELKL4OzYLIu0SWFQiWIcuYtIrEjINBA3FY2wFSbwj
	j11YDY3bhbS+sYmyfHysvIGQsX1ePqI1r+bvOIjgHNDUYqSy4MeD10DDQ0S0cx+tyKm3OY4Lhrc
	/4jT/LQYZW0Y1KL2en1MvoHkur48QeXzr0IPS6HDxq8/sQ==
X-Received: by 2002:a05:6000:2201:b0:48a:f36d:fb57 with SMTP id ffacd0b85a97d-48e6e303ca8mr40111334f8f.18.1793866225864;
        Thu, 05 Nov 2026 00:10:25 -0800 (PST)
Received: from localhost.localdomain ([2a06:c701:4763:5b00:bfea:518b:8c4e:2d27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm9029351f8f.19.2026.11.05.00.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:10:25 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] block: avoid repeated notifications for dead disks
Date: Thu,  5 Nov 2026 10:10:07 +0200
Message-ID: <20261105081007.816058-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031171325.4073830-2-thnkslprpt@gmail.com>
References: <20261031171325.4073830-2-thnkslprpt@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mark_disk_dead() reports disk death even when GD_DEAD is already
set. For example, NVMe reset failure and subsequent namespace removal
can call it twice, repeating holder mark_dead callbacks.

Move the GD_DEAD test-and-set into the callers of
__blk_mark_disk_dead() so blk_mark_disk_dead() reports holder death
only on the first transition. Preserve the helper's queue-drain
return value for __del_gendisk().

Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_dead")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
Updated in v2:
- move the atomic GD_DEAD check into both callers, as suggested by
  Christoph Hellwig
- keep the helper signature and queue-drain return semantics unchanged

 block/genhd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea..7e4570f9cea7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -659,12 +659,6 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 
 static bool __blk_mark_disk_dead(struct gendisk *disk)
 {
-	/*
-	 * Fail any new I/O.
-	 */
-	if (test_and_set_bit(GD_DEAD, &disk->state))
-		return false;
-
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 
@@ -689,17 +683,19 @@ static bool __blk_mark_disk_dead(struct gendisk *disk)
 void blk_mark_disk_dead(struct gendisk *disk)
 {
 	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
-	__blk_mark_disk_dead(disk);
-	blk_report_disk_dead(disk, true);
+	if (!test_and_set_bit(GD_DEAD, &disk->state)) {
+		__blk_mark_disk_dead(disk);
+		blk_report_disk_dead(disk, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
 static void __del_gendisk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	bool start_drain = false;
 	struct block_device *part;
 	unsigned long idx;
-	bool start_drain;
 
 	might_sleep();
 
@@ -727,9 +723,11 @@ static void __del_gendisk(struct gendisk *disk)
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	start_drain = __blk_mark_disk_dead(disk);
-	if (start_drain)
-		blk_freeze_acquire_lock(q);
+	if (!test_and_set_bit(GD_DEAD, &disk->state)) {
+		start_drain = __blk_mark_disk_dead(disk);
+		if (start_drain)
+			blk_freeze_acquire_lock(q);
+	}
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.43.0

