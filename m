Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB2C8DF
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825654; cv=none; b=qajwRY+UNGYcV4C4GQcfRdmiv150UD2G4elNrp8YBF8ByYWbaWRtuhnhS/PjC7kyo0d2oPQsQ06DGuJd4DCE553X19+EZEHJJyM3tclS3J7Aip9UmCmmeulgcENzBxIXhaCdjYQhECzB5j4QPV56l8/NCyGcx4913JewXYLrfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825654; c=relaxed/simple;
	bh=4Up7llp93TzxHMadJkeLylkY36+RTr3wjXZAZ0Q6ynw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kFszR7lVK/1Nylej1gorxLlRIuqDiDVcTpYYm8Xbm/88/7vjhoYqlZLAujPrtmMqNJxPqPluUWa+a7Z9nQgRADM2icUnIzHDrR2kDesNp9SgRblfEOdZc/1ETkrHbj3hzg1pEOUztnS7VszThnVMU9RDpGI1s0CG0BHMO/vF9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 410795b6927e11efa216b1d71e6e1362-20241025
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7b600df3-4113-4a34-a380-f2f3c1e837cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:18cc2e093df12ef7caaa79bae9b09a59,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 410795b6927e11efa216b1d71e6e1362-20241025
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1590586329; Fri, 25 Oct 2024 11:07:22 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 73B17B804842;
	Fri, 25 Oct 2024 11:07:22 +0800 (CST)
X-ns-mid: postfix-671B0B61-322270602
Received: from localhost.localdomain (unknown [172.25.120.36])
	by node2.com.cn (NSMail) with ESMTPA id 91B45B804842;
	Fri, 25 Oct 2024 03:07:12 +0000 (UTC)
From: Hongling Zeng <zenghongling@kylinos.cn>
To: inux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] blk-core: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Fri, 25 Oct 2024 11:07:09 +0800
Message-Id: <20241025030709.9520-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 block/blk-core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc5e8c5..459eb7e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -245,14 +245,6 @@ void blk_clear_pm_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_pm_only);
=20
-static void blk_free_queue_rcu(struct rcu_head *rcu_head)
-{
-	struct request_queue *q =3D container_of(rcu_head,
-			struct request_queue, rcu_head);
-
-	percpu_ref_exit(&q->q_usage_counter);
-	kmem_cache_free(blk_requestq_cachep, q);
-}
=20
 static void blk_free_queue(struct request_queue *q)
 {
@@ -261,7 +253,7 @@ static void blk_free_queue(struct request_queue *q)
 		blk_mq_release(q);
=20
 	ida_free(&blk_queue_ida, q->id);
-	call_rcu(&q->rcu_head, blk_free_queue_rcu);
+	kfree_rcu(q, rcu_head);
 }
=20
 /**
--=20
2.1.0

