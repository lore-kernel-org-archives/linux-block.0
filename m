Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC62853E9
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270647; cv=none; b=QxG2/VRVf5nbyxX4a78v0f2+w6EDvKUHVp8u6LVnZAKtPDWCmA1LwohZ3PcKCpTsOynKZ68bHB2IOsXGBDESQBDw1/RQr6bSsR94vhI5Ecc/XnUsYFdB8c1gieqOuEehVBOjKXTJ7o3cjEpa9T3gs0H8yRAaoKtI5DWsYVgQNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270647; c=relaxed/simple;
	bh=U174URSm8M/UyfNglJScb+jhxWK1f7fMxVBiMtBmJkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4wDZq3jp43Gg/K36bZWNVG+UIuF2SLzVivDsM3yy3D/pIVyiBLZf2oyTxj99dCRO6WySoDy0vL3Bz+sy7Wot41UkEu3zUlm8ROTI9UeFHIU+puqRgyz1aWPeA+xcJ3S6rB8pB1bNdvq8CXeneE4aCVXt1lKMl2NnWOSAcnJ0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ba/o0H/W; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ba/o0H/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=al
	3oiTreKLnkrLRi7GKnjlMtyBbUW0K/r4U+fcd/3b8=; b=Ba/o0H/WENxaTFbQbK
	VKwpCxU/tgWVile8KJownh3TPCVUwB8p+yud3OF883C3XgDCRiv5wxEppMDThkZz
	rcAMIPiLTIpYE7IdsgF7gzTHzwTwaTtzKk/T+bTkDxE5uHVOhXUnbfDnOoWvZu0d
	bz/X791JbAJ+8pjPTqh8AXdOM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD330bigw1qyXqlCg--.57867S2;
	Wed, 20 May 2026 17:50:28 +0800 (CST)
From: dayou5941@163.com
To: linux-block@vger.kernel.org
Cc: yukuai@fnnas.com,
	axboe@kernel.dk,
	liyouhong@kylinos.cn
Subject: [PATCH] block, bfq: skip dispatch when selected queue has no next_rq
Date: Wed, 20 May 2026 17:50:24 +0800
Message-Id: <20260520095024.685338-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330bigw1qyXqlCg--.57867S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWxKry3Ww4ktryfGr4UArb_yoW3KFb_Cw
	1DC39akFWUArn8uF4fKF1UJr1jyFyaga18GryrGr1DX34jqa13Aa9rKFya9Fs8Ja97CFy3
	tws0qwnxtr45ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR3noUUUUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QT3pmoNg+TftgAA3h

From: liyouhong <liyouhong@kylinos.cn>

bfq_dispatch_rq_from_bfqq() dispatches bfqq->next_rq directly. Add a
guard in __bfq_dispatch_request() so that dispatch is skipped if the
selected queue unexpectedly has no next request.

This keeps behavior unchanged in normal paths while avoiding entering
the dispatch helper with a missing next_rq.

Signed-off-by: liyouhong <liyouhong@kylinos.cn>

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 141c602d5e85..c3d9d02064b7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5226,7 +5226,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		goto exit;
 
 	bfqq = bfq_select_queue(bfqd);
-	if (!bfqq)
+	if (!bfqq || !bfqq->next_rq)
 		goto exit;
 
 	rq = bfq_dispatch_rq_from_bfqq(bfqd, bfqq);
-- 
2.25.1

