Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663441A5BAE;
	Sun, 31 May 2026 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780267539; cv=none; b=Wd/m9CMFXXBFecDbVfLRB6PTyW+4qU83erZZugZK1MlEMWY/NxH5IsjaES2UHMwy5eGKVnoVw5mf9JCKYnL+SW/M8nMYwIw33RnK65FQVPAaO0MIx1M46UAJkzMq5u2+7ztzAKgiEOENsycCBgK6QgPrDCERhYe+ykIVBI8JV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780267539; c=relaxed/simple;
	bh=YnfHJKF7mTuPs63VbskHBRD+n+a04W5hkmSNy8P7Fv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U4Jx5e+D189/iGKRSLFORR3aRpRTtXr4uX8WFlPDT2fv5A9+9VWmwhEGceXNWSQtn/sXqyKKuXtGg5ozzKtjYL4n0fTgiC2oLHeuYX06wkZUjdh3egQK8sxFVG7vUDAItS86b1BQnSEEavNpJ5gB8DbgR59zIMGkdrgAT6TKwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+cUKk8W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+cUKk8W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E72FFC2BCB4;
	Sun, 31 May 2026 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780267539;
	bh=YnfHJKF7mTuPs63VbskHBRD+n+a04W5hkmSNy8P7Fv0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=N+cUKk8WxUUBSCVi4kqdDJj0WMowIKfptYYQXuXou57WjQ2TkzNYFzeA6/LZHeG6R
	 KDxesYkZSsy9Bsmser8wY+rbnSK8erLJCqIHLWj1TTEiXNmaWM5tANODaZrlNRjeJz
	 19P/NbKz96MjpW4I0jZSTobOlptr9TVJE1XSszI26MRJ+I87BYqWImeD64CJ0vw7tx
	 dgELcIo36rLXaTe0wFUVtCWslisOZKymakRiGwvrk/7WiTTYHa4dhXQek9PkceR51E
	 /YN6zTWGXSp6ljKeA0hEjIgZKJQYnpzThTwk22AgCyb5r/DY865iRWpiZlWbe2FpXH
	 xCYxzXcsE6NYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8D9CD6E56;
	Sun, 31 May 2026 22:45:38 +0000 (UTC)
From: "Samin Y. Chowdhury via B4 Relay" <devnull+samin_c.outlook.com@kernel.org>
Date: Sun, 31 May 2026 18:45:07 -0400
Subject: [PATCH RFC] blk-integrity: fix slab-out-of-bounds in t10_pi_verify
 on namespace revalidation
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-blk-integrity-fix-v1-1-cc7084f42cf1@outlook.com>
X-B4-Tracking: v=1; b=H4sIAPK5HGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU2ND3aScbN3MvJLU9KLMkkrdtMwK3VQLQwNLAwOLxDRTEyWgvoKiVKA
 w2MxopSA3Z6VYiGBxaVJWanIJyDSl2loAKVhpn3oAAAA=
X-Change-ID: 20260531-blk-integrity-fix-e8109008af54
To: Jens Axboe <axboe@kernel.dk>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Samin Y. Chowdhury" <samin_c@outlook.com>, Sungwoo Kim <iam@sung-woo.kim>, 
 Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>, 
 Ruimin Sun <rsun@fiu.edu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780267537; l=3868;
 i=samin_c@outlook.com; s=20260531; h=from:subject:message-id;
 bh=FkeOPgXRBosTQ74NzcoJaEx11Qy3el90YLb0xvy/x8c=;
 b=yybthjaFNIzhCYNjL8VcfvYMrqAqCK63+hEE1YJAArc0bD4S5Cf2ygKs2cTMdpTl4DBTUR0tO
 aptvoVo4h3+BvWoMRnxVCcO4saBJRMlz92C+ZJ/gR8JgHp9Nsbpt5fY
X-Developer-Key: i=samin_c@outlook.com; a=ed25519;
 pk=bhYTQ8dsutJTQ/B9OCMAespkxDADq+Ik/7wRt0sTlPQ=
X-Endpoint-Received: by B4 Relay for samin_c@outlook.com/20260531 with
 auth_id=801
X-Original-From: "Samin Y. Chowdhury" <samin_c@outlook.com>
Reply-To: samin_c@outlook.com

From: "Samin Y. Chowdhury" <samin_c@outlook.com>

Abort early with BLK_STS_PROTECTION if a namespace revalidation changed
bi->metadata_size after bio_integrity_prep() sized the allocation.

Found by FuzzNvme (Syzkaller with FEMU fuzzing framework).

When a namespace is revalidated between bio_integrity_prep() and
bio_integrity_verify_fn(), the integrity profile's metadata_size may
change under the in-flight bio. bio_integrity_verify_fn() re-reads the
live blk_integrity via blk_get_integrity(), so blk_integrity_iterate()
uses the new metadata_size as the per-interval step size against a
buffer sized for the old one, advancing iter->prot_buf past the end of
the allocation.

task 1:
  bio_integrity_prep()
    bio_integrity_alloc_buf()
      len = bio_integrity_bytes(bi, bio_sectors(bio))   ...(1)
      bip->bip_iter.bi_size = len

task 2:
  nvme_update_ns_info_block()
    blk_mq_freeze_queue()
    nvme_init_integrity()
      bi->metadata_size = head->ms                      ...(2)
    blk_mq_unfreeze_queue()

task 3:
  bio_integrity_verify_fn()
    bio_integrity_verify()
      blk_integrity_iterate()
        bi = blk_get_integrity()                        ...(3)
        iter->interval_remaining = 1 << bi->interval_exp
        iter->prot_buf += bi->metadata_size per interval
        /* step size from (3), buffer sized at (1): overrun */

Fixes: 8098514bd5ca ("block: always allocate integrity buffer when required")
Signed-off-by: Samin Y. Chowdhury <samin_c@outlook.com>
Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Acked-by: Ruimin Sun <rsun@fiu.edu>
---
When a namespace is revalidated between bio_integrity_prep() and
bio_integrity_verify_fn(), the integrity profile's metadata_size may
change under the in-flight bio. bio_integrity_verify_fn() re-reads the
live blk_integrity via blk_get_integrity(), so blk_integrity_iterate()
uses the new metadata_size as the per-interval step size against a
buffer sized for the old one, advancing iter->prot_buf past the end of
the allocation.

task 1:
  bio_integrity_prep()
    bio_integrity_alloc_buf()
      len = bio_integrity_bytes(bi, bio_sectors(bio))   ...(1)
      bip->bip_iter.bi_size = len

task 2:
  nvme_update_ns_info_block()
    blk_mq_freeze_queue()
    nvme_init_integrity()
      bi->metadata_size = head->ms                      ...(2)
    blk_mq_unfreeze_queue()

task 3:
  bio_integrity_verify_fn()
    bio_integrity_verify()
      blk_integrity_iterate()
        bi = blk_get_integrity()                        ...(3)
        iter->interval_remaining = 1 << bi->interval_exp
        iter->prot_buf += bi->metadata_size per interval
        /* step size from (3), buffer sized at (1): overrun */
---
 block/bio-integrity-auto.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 353eed632fc..b404dbaa9f8 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -38,6 +38,18 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 	struct bio_integrity_data *bid =
 		container_of(work, struct bio_integrity_data, work);
 	struct bio *bio = bid->bio;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	if (bi) {
+		unsigned int required = bio_integrity_bytes(bi, bio_sectors(bio));
+
+		if (unlikely(required > bid->bip.bip_iter.bi_size)) {
+			bio->bi_status = BLK_STS_PROTECTION;
+			bio_integrity_finish(bid);
+			bio_endio(bio);
+			return;
+		}
+	}
 
 	bio->bi_status = bio_integrity_verify(bio, &bid->saved_bio_iter);
 	bio_integrity_finish(bid);

---
base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
change-id: 20260531-blk-integrity-fix-e8109008af54

Best regards,
--  
Samin Y. Chowdhury <samin_c@outlook.com>


