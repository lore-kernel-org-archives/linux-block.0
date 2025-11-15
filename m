Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AD27B50C
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209199; cv=none; b=Cakvq5aE6YsLjJw27ZorbXW/JylnfSGv1/t6SPv0md55KOH5lT4MkxaFr7Cbcm/OzMxIQONC9EFxF4q0JOCH6qi6r7noOZqoUbiAKEDcC/SiJ2fWyOgm5W9WwJaXsMAHuDJ2O9Oe7YHh136fdsLld1YraVL/k25BRtjubrDP3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209199; c=relaxed/simple;
	bh=Y2j2OUqp1fdw2ztLdU+zfecGyVKRe8r1J612d4cMLkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diAZUoDoINnZGgq6Ul9Ok6KMwFmrzpfG+0+cMRJRnU/j83+sS367seJ4Y5rsip5NT1JuVYHoNQEWFvsrSvbRP9W3aO6xT8uiSfgtdr0bhjEPN54rVp5fHA3+wEpFqFMiKN2Rh2ksUxV0LxEAICXe110hkxOhYE5JJm7QZ11NUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6TNuC2j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6TNuC2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87077C116D0;
	Sat, 15 Nov 2025 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209199;
	bh=Y2j2OUqp1fdw2ztLdU+zfecGyVKRe8r1J612d4cMLkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6TNuC2jNOtI6tmKuC+jLsV63T2ykea4QUPgg5urp6Hg7NccixadDKTJS56wbfDa2
	 GJO4nUVk/+RNGDwBao5Ii7o13t2sSQLHcVfsChHGpuwXkQ+ckDdq6dB8BtHMjJqnJQ
	 qu0qKx+bregzybQju1z4KxuzSL/e7FZ6BKv0CDBX+g8nGye3sl+WjjQ1b76HB24ML/
	 EZ3B7Re2L9NSW6MmrCXkix6OaSnoSig4Q16IdVZlm894SxF3SUz024abVjxHEVGR3N
	 aTVO0HbpzZ4Tqm1X9ERdY6LDE1WxZIY4MX7dCWzle9QI8KMJCE7EFb0NIQ4as0iiVX
	 blMuM96UopmiA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] zloop: make the write pointer of full zones invalid
Date: Sat, 15 Nov 2025 21:15:51 +0900
Message-ID: <20251115121556.196104-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115121556.196104-1-dlemoal@kernel.org>
References: <20251115121556.196104-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write pointer of zones that are in the full condition is always
invalid. Reflect that fact by setting the write pointer of full zones
to ULLONG_MAX.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/zloop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 92be9f0af00a..a975b1d07f1c 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -177,7 +177,7 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 		zone->wp = zone->start;
 	} else if (file_sectors == zlo->zone_capacity) {
 		zone->cond = BLK_ZONE_COND_FULL;
-		zone->wp = zone->start + zlo->zone_size;
+		zone->wp = ULLONG_MAX;
 	} else {
 		zone->cond = BLK_ZONE_COND_CLOSED;
 		zone->wp = zone->start + file_sectors;
@@ -326,7 +326,7 @@ static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 	}
 
 	zone->cond = BLK_ZONE_COND_FULL;
-	zone->wp = zone->start + zlo->zone_size;
+	zone->wp = ULLONG_MAX;
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
 
  unlock:
@@ -433,8 +433,10 @@ static void zloop_rw(struct zloop_cmd *cmd)
 		 * copmpletes.
 		 */
 		zone->wp += nr_sectors;
-		if (zone->wp == zone_end)
+		if (zone->wp == zone_end) {
 			zone->cond = BLK_ZONE_COND_FULL;
+			zone->wp = ULLONG_MAX;
+		}
 	}
 
 	rq_for_each_bvec(tmp, rq, rq_iter)
-- 
2.51.1

