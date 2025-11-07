Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA92FCC16
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497758; cv=none; b=cPFZHacLeGVg423gjGIZAS3Y3KoMHk8ocQtsV7LSwquDp/tR4yguuNByCs8xo8r1TOM9xMF6tpm2F/1qQh3SB8lXC+8sdN7s7+kOQZJhtYNXdrep4cljPASbAMpiTaoMkfLLiNrRw22X5vdSAyFMyK/++frGwnC7ZIBBu0mlsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497758; c=relaxed/simple;
	bh=dILuvlTfHqJF3IaMGWVDhHa4iHHeWJGjL83Jk2wwFZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT3swBE45LrEn1oOILUtffhOK4r5X4aqa5FlGz3dvngSJ4cxG7EHf2kL1umcwkbkJlrjUmiYa0c9wuRhjYyEkhfqYAnB2mkMxAgRa0zRc227Z2FHq0czBCaAZ3oQqp20mv/aTSwgW3+hksjTrE4uxwFzw69oMDBjcrXDWZ5kpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4/WYft0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4/WYft0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B957CC116C6;
	Fri,  7 Nov 2025 06:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762497758;
	bh=dILuvlTfHqJF3IaMGWVDhHa4iHHeWJGjL83Jk2wwFZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4/WYft0OzAaXo6Pqs8EddxmxidTPgUK2YuoCaWPADnBK0UNVw3MFxGUEBhaMW7wJ
	 ieZx/ZYxbIGoTBw4qhxLecQkU1iWpMXGrimw37VDbzmAjz0P0HN1ViFsNRTHKD1Z9w
	 PWZaU+/ECZ0Q5LqGcel41TprkLpE8Sqth18SQRlHLFb4UWdSUorrZRKm7fodzx4clu
	 qhAYQj1+Jza+AfQUsDtC3cjES0EVUw9kZzMVqn67+Ouj8Bjxs+qKzjaT7XOKoZS4OU
	 Jm/Yeb9ep/wJwCw8fnpu+aUPQJYtiGaiiHM1kdMnzoTPfmEdIXKHJxUfFY5xcKsUpI
	 kInduLg5y+AqQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/3] block: improve blk_zone_wp_offset()
Date: Fri,  7 Nov 2025 15:38:42 +0900
Message-ID: <20251107063844.151103-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107063844.151103-1-dlemoal@kernel.org>
References: <20251107063844.151103-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_zone_wp_offset() is always called with a struct blk_zone obtained
from the device, that is, it will never see the BLK_ZONE_COND_ACTIVE
condition. However, handling this condition makes this function more
solid and will also avoid issues when propagating cached report requests
to underlying stacked devices is implemented. Add BLK_ZONE_COND_ACTIVE
as a new case in blk_zone_wp_offset() switch.

Also while at it, change the handling of the full condition to return
UINT_MAX for the zone write pointer to reflect the fact that the write
pointer of a full zone is invalid.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8204214e3b89..7ce7b8ea5a4f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -800,18 +800,18 @@ static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 	case BLK_ZONE_COND_CLOSED:
+	case BLK_ZONE_COND_ACTIVE:
 		return zone->wp - zone->start;
-	case BLK_ZONE_COND_FULL:
-		return zone->len;
 	case BLK_ZONE_COND_EMPTY:
 		return 0;
+	case BLK_ZONE_COND_FULL:
 	case BLK_ZONE_COND_NOT_WP:
 	case BLK_ZONE_COND_OFFLINE:
 	case BLK_ZONE_COND_READONLY:
 	default:
 		/*
-		 * Conventional, offline and read-only zones do not have a valid
-		 * write pointer.
+		 * Conventional, full, offline and read-only zones do not have
+		 * a valid write pointer.
 		 */
 		return UINT_MAX;
 	}
-- 
2.51.1

