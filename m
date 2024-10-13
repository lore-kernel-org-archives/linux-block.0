Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DDA15D5CE;
	Sun, 13 Oct 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850699; cv=none; b=DOfll+G4VScF49ODzQXJJfu6R8fP7VQa4AnaSJGBB0TAKQNk6vb80+0IYrLaNNvytQ/jhhCXLEeP4l8W/ZKuVfcqAKOprFuc7Inv8dC72t/VKlY3Nui5AYkuBW8Q3kJdL6Mf5jE3rKCXV/mF5PBKaKwiYXTDma9ZStpfH8ekIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850699; c=relaxed/simple;
	bh=DX8sXR905kdqIHrrtAmWLDbbRSoCZy6ytgo/x8v5TaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZmfjXHrr+KMX/lnFRo/nH0GEvBQ/G2Vbb5O+19QOQgnAAx+KRSYcTs2oSD/gn+ekJDgXb1/tASGEQELqW/IOhjA1zgxuMqc/s4wP1P48eSM+8aWENfYc+IDfjkILaSEDKZreAPAvU+gukx/BTc35ZHJGMj7Onha/YLB1j9VRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=bemVBM66; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="bemVBM66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uWq5kHOQ0g6AmeD+JbSoxmUBjLV0iBM1hR5RLyN4lME=;
  b=bemVBM664HQotiDljOFdEe3nOWqNpd+lJtjitHV1Ncs3j9wSjAcqOsIE
   +0hFguhESPjlBDLlGPnivlwps/s6DhdbWnCLntVdW/b0jAB+aC0t32/Q9
   PCkekxrqQzcs6c5UT1llylAiGOKjRi1ILcm4BYnKxrg3EeMPqFr7V2Di1
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968284"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:18:00 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:56 +0200
Message-Id: <20241013201704.49576-10-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 block/blk-ioc.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 25dd4db11121..ce82770c72ab 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -32,13 +32,6 @@ static void get_io_context(struct io_context *ioc)
 	atomic_long_inc(&ioc->refcount);
 }
 
-static void icq_free_icq_rcu(struct rcu_head *head)
-{
-	struct io_cq *icq = container_of(head, struct io_cq, __rcu_head);
-
-	kmem_cache_free(icq->__rcu_icq_cache, icq);
-}
-
 /*
  * Exit an icq. Called with ioc locked for blk-mq, and with both ioc
  * and queue locked for legacy.
@@ -102,7 +95,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
 	 */
 	icq->__rcu_icq_cache = et->icq_cache;
 	icq->flags |= ICQ_DESTROYED;
-	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
+	kfree_rcu(icq, __rcu_head);
 }
 
 /*

