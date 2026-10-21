Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614078;
	b=RwlkIs2gq0mS/F9jNOuswoWAlyAZbncG1ixXT3cUxUvebSI2hmbjmLB4J/gquq9jMy4m
	 4PddcofvaMgZj1nlSO89LlPv6ZXpG4YzYE0ZLOGu4dETSY4JrkYl+r8JlmdDmwhjl+j1Y
	 VCcNVlRUFA9aULRJUvktg1p/X77oZmstQE6JNuryH9O1FEblcbATOnaw/rOk9zTcjlQYh
	 F41gsmxAAMitiZNnE/uK05r3pLlc/4T8waEg4NcJXowTuwiWHx2TMH/pNvqyAMhFdZJnM
	 097pyTdZrlVmLHxXLQroHq7bvrYo3dIPWVw9tD1PifMPFkWDsPG5MXXk50xaTgeWDgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=LzMYZpFS82RyIA4sJbsSsajT6VtxZN1xfhZCw/RchAM=;
	b=0kic8O3s1TvdEKtzg53tTPtP9j6Aj4qOPf/Oz00nO2JDFOS7QQdoQKa936SK8Eb0etbc
	 TmcT1w4FCGVznbspJYxKTrKXSh/NqEF2uufhP+vPBpS+OTkVi1ixJzIvZV4ULrg7Ou3WG
	 SEuXR9X/3oy7GJoVo4O3N2TjpAUTBSV3wOLoeb9i1/16wiY6WCqTC6m+ni58TMhhAZZ48
	 sOoe/ieOvMenpoWoknc4ntELxAY00mkTZEjt/YlTYm3vEvgIxQ5xgUFM+ZjUviIJqkgSK
	 cgHr/UKwjUA5vTDBqJQ1Oklga+Uiw13zxc8+7UA7kPbD7zH7ex6plG4Jcwx4/JQPzVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaMrZVQN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86155606A31A
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaMrZVQN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA261F000C1;
	Wed, 21 Oct 2026 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614078;
	bh=LzMYZpFS82RyIA4sJbsSsajT6VtxZN1xfhZCw/RchAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HaMrZVQNYYyxFdKvYy4iQVzqGv7ECWK1MuLnP5S+p3bmReEv5cJkszASRJ3XyPEp/
	 7HBtvwnogI1HwguaN9OX4tegy0aAdPWzP4LoZ27Foxqhv2rLxjqrGHItN248amNkFR
	 fdvuZsOaYy4Hmg53m7iSIMqkN2cFOgErHebzs3yiinKMAWIcQwfkpH7XbmsnsSfv8/
	 vi3uDz24Q5iCfEDXaSqjtcoRtdaQ5Vy7DDQtMMblhnyFpqoE/jgH9VPcjQuyorlQO/
	 GMsMygbOKiohMrdUJHsjCf/b46zgcS/eWa0PKaoqz4ULSKBu74V4Vy78KEXHxmcc4b
	 WURrvTo6oX/zw==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/2] null_blk: don't finish zones to set them read-only or offline
Date: Wed, 21 Oct 2026 22:21:03 +0200
Message-ID: <20261021202100.2017938-6-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021202100.2017938-4-cassel@kernel.org>
References: <20261021202100.2017938-4-cassel@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918; i=cassel@kernel.org; h=from:subject; bh=7WTL4JQ1+qVFEaZKljp9Ppp3jFg0IuUxCeWdruFDs4U=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJuyq0xOS/5y2XB+5anbFxa+9ZzlkfsctlZYFEQdHhGl zWnjktjRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTAC7yleG/7/R9s7LbXXiWtxu8 O1bguF+hs/qbTu3GsDWiey7/fC/TyMjwZPus8N0mgZn7DPsqVllfPfzj7V+D4u3lrxxd5iiu/bW BGwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

null_set_zone_cond() calls null_finish_zone() to release the zone
resources held by a zone before setting it read-only or offline.

For an empty or closed zone, null_finish_zone() first runs the zone
resource checks, which can close an unrelated implicitly open zone, or
fail. As the error is ignored, a failure for a closed zone leaks
nr_zones_closed, permanently lowering the effective active zone limit.

Setting a zone read-only or offline requires no zone resources, so
release the zone resources held by the zone directly instead, using a
new helper, null_release_zone_resources().

Fixes: d3a5738849e0 ("null_blk: support read-only and offline zone conditions")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/block/null_blk/zoned.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index ecdc8d68ca2a..015f5d304c7c 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -743,6 +743,33 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 	}
 }
 
+/*
+ * Release the zone resources held by a zone, before changing the condition of
+ * the zone to a condition that does not hold any zone resources.
+ */
+static void null_release_zone_resources(struct nullb_device *dev,
+					struct nullb_zone *zone)
+{
+	if (!dev->need_zone_res_mgmt)
+		return;
+
+	spin_lock(&dev->zone_res_lock);
+	switch (zone->cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_CLOSED:
+		dev->nr_zones_closed--;
+		break;
+	default:
+		break;
+	}
+	spin_unlock(&dev->zone_res_lock);
+}
+
 /*
  * Set a zone in the read-only or offline condition.
  */
@@ -759,8 +786,8 @@ static void null_set_zone_cond(struct nullb_device *dev,
 	 * If the read-only condition is requested again to zones already in
 	 * read-only condition, restore back normal empty condition. Do the same
 	 * if the offline condition is requested for offline zones. Otherwise,
-	 * set the specified zone condition to the zones. Finish the zones
-	 * beforehand to free up zone resources.
+	 * set the specified zone condition to the zones. Release the zone
+	 * resources held by the zones beforehand.
 	 */
 	if (zone->cond == cond) {
 		zone->cond = BLK_ZONE_COND_EMPTY;
@@ -768,9 +795,7 @@ static void null_set_zone_cond(struct nullb_device *dev,
 		if (dev->memory_backed)
 			null_handle_discard(dev, zone->start, zone->len);
 	} else {
-		if (zone->cond != BLK_ZONE_COND_READONLY &&
-		    zone->cond != BLK_ZONE_COND_OFFLINE)
-			null_finish_zone(dev, zone);
+		null_release_zone_resources(dev, zone);
 		zone->cond = cond;
 		zone->wp = NULL_ZONE_INVALID_WP;
 	}
-- 
2.56.0

