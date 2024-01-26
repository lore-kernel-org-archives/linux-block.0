Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB1399
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230235; cv=none; b=YbpsY0KlMv4oA4ICUgnUI18IdDZVD7sGHwo5zwIwVn9nLnFrdY/c/T95O2pWppMvJJ1wVnM24cD+t4k+vgKzd2lz4grcHVev4//0aSE2iOeS7JdvFPTTfDooAt9YDYhdEy3hnKwqD6CTEegTGVknH3NE78yktVlZE19S5SlGjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230235; c=relaxed/simple;
	bh=aLWy7AJGcY/5dv+Meu+RHP02ccp+hiCSiIqjsspDQ14=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=no5jzGFPTySnNvNryTR/nCjuChuQZs6ZRkIoBRe1374kpFtnQadPohXHfhH04JAwbLm8TIRAL4OPpLuGbeELZGFMOW1J1cvhRfRP/twkFlTogu+gTRMlf+rzNgw/+/kIeJlY9Hm8sqk1OYdhcaS7CKM8eZIa3lQaxvGOuiEgNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLyLZemu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLyLZemu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F04C433F1;
	Fri, 26 Jan 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706230234;
	bh=aLWy7AJGcY/5dv+Meu+RHP02ccp+hiCSiIqjsspDQ14=;
	h=From:To:Subject:Date:From;
	b=FLyLZemu5xrTm4P7Ns0buDGJRhCp+FFEwNlRfkPLGRetHMl8lPXsP1kAYi9yQ5Jmn
	 TjJ4KmW+5z+QZsnSTtwRX4kKWxDr3iyL0IiCuFPoUIUEJMwbCPp65TDVcW+MK5q+R7
	 9xjczuMD7C/fk9Medsi8xSkN4O6MPa+WJZApsZOE6SPIgTFxbzkMOOHOpu8kHMq2IU
	 iVYbe6UHSLYHQYw4Cw0JFm0Qn6AQBWxunBKup3L7DcTXQTI1+CY7XhrRQbJFULD6TF
	 Ar+6OsFSmoAUnjnqGaMhfJuyYjIU12mZLnH4FNhQqcywVkdBKq4MDCvADa5DrpKLap
	 Eg5upE1R2qqeg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] null_blk: Always split BIOs to respect queue limits
Date: Fri, 26 Jan 2024 09:50:32 +0900
Message-ID: <20240126005032.1985245-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function null_submit_bio() used for null_blk devices configured
with a BIO-based queue never splits BIOs according to the queue limits
set with the various module and configfs parameters that the user can
specify.

Add a call to bio_split_to_limits() to correctly handle large
BIOs that need splitting. Doing so also fixes issues with zoned devices
as a large BIO may cross over a zone boundary, which breaks null_blk
zone emulation.

While at it, remove all the local variable that are not necessary.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 36755f263e8e..514c2592046a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1528,12 +1528,16 @@ static struct nullb_queue *nullb_to_queue(struct nullb *nullb)
 
 static void null_submit_bio(struct bio *bio)
 {
-	sector_t sector = bio->bi_iter.bi_sector;
-	sector_t nr_sectors = bio_sectors(bio);
-	struct nullb *nullb = bio->bi_bdev->bd_disk->private_data;
-	struct nullb_queue *nq = nullb_to_queue(nullb);
+	struct nullb_queue *nq =
+		nullb_to_queue(bio->bi_bdev->bd_disk->private_data);
+
+	/* Respect the queue limits */
+	bio = bio_split_to_limits(bio);
+	if (!bio)
+		return;
 
-	null_handle_cmd(alloc_cmd(nq, bio), sector, nr_sectors, bio_op(bio));
+	null_handle_cmd(alloc_cmd(nq, bio), bio->bi_iter.bi_sector,
+			bio_sectors(bio), bio_op(bio));
 }
 
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
-- 
2.43.0

