Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177F17B401
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149110; cv=none; b=D14tLZ5pPmmmXhuIsEgSMdv5NHgbRCB6hCbK+0YUDGKDf8edwLpqvjBmWs9KWWM1KXaTsQhEw8Forc6clvA+sRGNEArgdFwTJsWfAo4Oux92HOMP0XEfwm7CVwSuw4ctT/MDELvdXSwCiGuh/ZOzxLzOdvcImJJVMIV4FrF01YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149110; c=relaxed/simple;
	bh=YCvB2zLVSsJ2F/EqHDCzgPYy9aw9uWAPlc71JBsAchY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpfTXb17g2SdyxUaWLxsB1VkTlVqoxy93scMLgoVD1sTGxhMHA/vxo1pS1wGmS4wDzeS7tjO7pESSObBJku5+MM5JUnG233tLHFIYxNMrlk8ZPiuH1eiHKbCeTVOUkBUo2FcfWos7pf+w2RJRxsFrrqU+89OGNrVOq6Z5iQjrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VN57Fndg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN57Fndg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741149107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zv1DnJAzzw0hKA/zI8FzJQ/lM8Dws4ECmStd5xdwNgQ=;
	b=VN57FndglKBHBaqTAsQnAPWSLLNGOApG6TmdPUaiV0M/babBFwcMxXnJqtvUAepMrPS9Vt
	+a/5+xR9mU6p+rYf/p5d7mLvwFbDuOw8si4uo6yiTFyhTTd5K5L4404k12boKwaXNaUh0R
	bsj43lL3BQ2u55Yhqhyv/Wd2N4F/VB8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-XQNepShBPqOAq5Cx2tDEGw-1; Tue,
 04 Mar 2025 23:31:39 -0500
X-MC-Unique: XQNepShBPqOAq5Cx2tDEGw-1
X-Mimecast-MFC-AGG-ID: XQNepShBPqOAq5Cx2tDEGw_1741149098
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29FE5180AB1A;
	Wed,  5 Mar 2025 04:31:38 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF45F195608F;
	Wed,  5 Mar 2025 04:31:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 1/3] blk-throttle: remove last_bytes_disp and last_ios_disp
Date: Wed,  5 Mar 2025 12:31:19 +0800
Message-ID: <20250305043123.3938491-2-ming.lei@redhat.com>
In-Reply-To: <20250305043123.3938491-1-ming.lei@redhat.com>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The two fields are not used any more, so remove them.

Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 5 +----
 block/blk-throttle.h | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a52f0d6b40ad..213e7b04617a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -819,13 +819,10 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_BPS_THROTTLED)) {
+	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
 		tg->bytes_disp[rw] += bio_size;
-		tg->last_bytes_disp[rw] += bio_size;
-	}
 
 	tg->io_disp[rw]++;
-	tg->last_io_disp[rw]++;
 }
 
 /**
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 1a36d1278eea..ba8f6e986994 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -106,9 +106,6 @@ struct throtl_grp {
 	/* Number of bio's dispatched in current slice */
 	unsigned int io_disp[2];
 
-	uint64_t last_bytes_disp[2];
-	unsigned int last_io_disp[2];
-
 	/*
 	 * The following two fields are updated when new configuration is
 	 * submitted while some bios are still throttled, they record how many
-- 
2.47.0

