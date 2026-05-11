Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD775388E55
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534648; cv=none; b=tJe1+J9xxnB6CD8DdMwxHoFHF2yjNZpMhZqAdBI/OO+9CmIhGNkv8t37S8y8YayRVydtY3SqXTMefjGthLiagdHr2cf3eBoAACP/1Vo4usmF0ICttDEDe53rM3ykgJxUlnD4+eCxu9LL4s1ccNuou15iso7+QZ8bn36YTkDm1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534648; c=relaxed/simple;
	bh=3thlf8owW1YrKqHXFc7okAlkd2LemVmenzlnMg4WkV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBU7smmzddtZkb1e+UjqdI69eBNJF4Lr9rRA5GlZpx4Un+VzuGw+7NHdJptnkJlUAJLzQHGCOPmkj9o+0Q3HPYgVwealPZhlv3DDCgujdSVVS+BmvjrBp8CZlueX7atNAGZ/E5OqWjznERMxmKRQFooCIVpQ5D8HVBamsuZnZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YYqRkzKo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YYqRkzKo"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891f6b6388so1478105e9.0
        for <linux-block@vger.kernel.org>; Mon, 11 May 2026 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778534644; x=1779139444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrtoJAjNIEskZcGprZzXovRMS9udKv5uVIH5xK3Q3Q0=;
        b=YYqRkzKoiEois+vPgnWZHBHuiWAonUXfEjSAds26MXI6s7+XfnEKnFgv/AtLdIMA/I
         8qZ/CbvLvqKPDeIDCaq4thYx5ee3fQaso/OHsocs8R6gzPtEGqMo5OU5jYeuGsYEC3pN
         kz8vQzoFFk9QgPJnAg3DhztVBPkQNWzMhn2UWia22ik7Hq/zgBdOMoUmaaKHKHB+iJ4Q
         XU0tcLTydkZLxPWq4IS1Cht71g1a/TCMKeVLTRr1C5l4iGvwUL6qdvbZs/bhCWit81fY
         kXvpDBzIQ4/vZ+YirA1ztj/yvMrSAp3T3AVfsD//Sv1uq+ikl2BnQK/eOzjk0aaGkkBc
         Z9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778534644; x=1779139444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrtoJAjNIEskZcGprZzXovRMS9udKv5uVIH5xK3Q3Q0=;
        b=e177jVR7tSFa4Rxgnt5YEmeXYFk5AVuMojYJ1rvXgGOMI42cnkRwjL5R3jZHfpZ/MI
         HjJweR7lNGN05jt7198WPNRYx2dpbFS0y36s34pC7/96xkgj+7h6qng5hPM9ES3Ydx+9
         WPnwfOWdrU6A6CQZfngHYt43VELfxIhk85TAVVqmx2jnoLWtuIpOAstZEfY6o6IvJJwZ
         5mH5SNT397d2PPf2uyuc//TZsNXNNJvalqtn8oqb6zTZ/iIvGZnKBkAKah019J52pNON
         Fdig6K8ZaqfSOTr2ByiS8rZCq+LRZkmzMwqn/iI7PDv6PpcXqRoyUXg8l0pt2NSkQxz5
         i59g==
X-Forwarded-Encrypted: i=1; AFNElJ+z1zWcVTqcn5VkL16A2wI5vw0PcMKNUZO2iTAxtPUqFM7otPRwfeg8IWj9xv6+PIBgZ2dV/5eA/6dH8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywau+at5P6NA1Cd9BytF9ylZSlu1xQqPRjdFKAlTiHlZvEw4gsI
	8ED/ABnLCy0CGwUbnKcqQqVPcnSGG9dT4MNp7jUfw7kBkWlwKgy5iP2ZU+CghLHvbPs=
X-Gm-Gg: Acq92OHZoPSt1oN0VaRdwgfPn7ftFoh4r3qIqri6PAAy6iRLFhXhFUqwNOerh93l9ua
	evmjOnJrYWdWhCUJsFAC9EGAqpSd4uu3FevpzOScFEPhzh8Enw2fdFDZivmr6/m2rx5HlH2zvp5
	8X20ueTorpzgWYT2BFMwXDG4CCUKcSm+K8cQmOnrUd2f+EHG6X3Hma3Hq7FTzTiwFzTsHm4XYAv
	3y+cW9gvdbgI+vtPWKCkMbUo3BkgYrzYjEkZS4MdPsZpfgd9E0ljF20vaupGL903u+/hTZ3isjh
	u4rTQTk3E6SRqvq9tLbK9qXAa8f1qUm5CkI3/d3mIrNhOoHqcWmSF1aBtAZ/MsAFmgpNTf84lql
	5qBd3GtV5gWZ/FH1lVLGWx4SeD1YCRdePCFZqgiVKmqek/AgHwaS0A1En3jHC9SVlMDPIkac0cS
	A8mQU9SLsAsg+/+vdVZYVkhYJxqd/EyD5TbzKCtdKtfQDXEfxz
X-Received: by 2002:a05:600c:3595:b0:48a:5664:f44a with SMTP id 5b1f17b1804b1-48e5325018dmr229880365e9.2.1778534644261;
        Mon, 11 May 2026 14:24:04 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e702e042dsm219069155e9.5.2026.05.11.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:24:03 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH] block: recompute nr_integrity_segments in blk_insert_cloned_request
Date: Mon, 11 May 2026 15:22:30 -0600
Message-ID: <20260511212230.27511-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_insert_cloned_request() already recomputes nr_phys_segments
against the bottom queue, because "the queue settings related to
segment counting may differ from the original queue." The exact same
reasoning applies to integrity segments: a stacked driver's underlying
queue can have tighter virt_boundary_mask, seg_boundary_mask, or
max_segment_size than the top queue, in which case
blk_rq_count_integrity_sg() against the bottom queue produces a
different count than the cached rq->nr_integrity_segments inherited
from the source request by blk_rq_prep_clone().

When the cached count is lower than the bottom queue's actual count,
blk_rq_map_integrity_sg() trips

	BUG_ON(segments > rq->nr_integrity_segments);

on dispatch. The same families of stacked setups that motivated the
existing nr_phys_segments recompute -- dm-multipath fanning out to
nvme-rdma in particular -- can produce this.

Mirror the nr_phys_segments handling: when the request carries
integrity, recompute nr_integrity_segments against the bottom queue
and reject the request if it exceeds the bottom queue's
max_integrity_segments. blk_rq_count_integrity_sg() and
queue_max_integrity_segments() are both already available via
<linux/blk-integrity.h>, which blk-mq.c includes.

This closes a latent gap in the stacking contract and brings the
integrity-segment accounting in line with the existing
phys-segment accounting.

Fixes: 76c313f658d2 ("blk-integrity: improved sg segment mapping")
Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 block/blk-mq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..d0c37daf568f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3307,6 +3307,25 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 		return BLK_STS_IOERR;
 	}
 
+	/*
+	 * Integrity segment counting depends on the same queue limits
+	 * (virt_boundary_mask, seg_boundary_mask, max_segment_size) that
+	 * vary across stacked queues, so recompute against the bottom
+	 * queue just like nr_phys_segments above.
+	 */
+	if (blk_integrity_rq(rq) && rq->bio) {
+		unsigned short max_int_segs = queue_max_integrity_segments(q);
+
+		rq->nr_integrity_segments =
+			blk_rq_count_integrity_sg(rq->q, rq->bio);
+		if (rq->nr_integrity_segments > max_int_segs) {
+			printk(KERN_ERR "%s: over max integrity segments limit. (%u > %u)\n",
+				__func__, rq->nr_integrity_segments,
+				max_int_segs);
+			return BLK_STS_IOERR;
+		}
+	}
+
 	if (q->disk && should_fail_request(q->disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
-- 
2.50.1

