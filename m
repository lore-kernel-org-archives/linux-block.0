Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DE46450;
	Sun,  9 Jun 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921691; cv=none; b=IjGXWO+0raqIOlIYBFNISPM4QqIp68erIY3xJYKxIT0qcnVgBvGIuVzLhMTXGvFqjuiWFcBIk8QLw6Xwu+Jx4TiRQbQJ2SL8R3+7YEz+DUkY1ePIG6OT2syTbIZDUfw4ahk7mT0RQRj0sJEsCNKYMQnF3GeNrQgF4bh6oFgImjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921691; c=relaxed/simple;
	bh=GPl3J34M1d7NjmG00uBdfMYpPYDtbP1uZbBHCNdhJQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQS972VpI44Ka0TYbz1Euw1KMiQ5MQhTqL34Av4ypvicDKwp9xOjXqYbUMF/uomQOeq2+EDGwiMPSAGbMzw0MAeQyI0xuuOliHaNPCASle2t6Y/1NBx+RshtbUtYoLiVd8K76obvBv4TNRslrQUB2yXZIk4f9NAeZnJStyaA2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=IgQ0MyW2; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="IgQ0MyW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQXnrH/08rhpNkHP4SNUqJ/atSEr8v14IoPZZmef880=;
  b=IgQ0MyW2rkojQw4XJ41XCYNyMbhdPXIdKBamHkri3xuQXbotjCSMI0PI
   7bMEDVQSODgpQ5t3pXWVvE1Ck+JMwYJ5vvwSMbuWhDWEOVMQHlCI3Vhsf
   JKCB30mAP/Y0kzTFt2wadul2Jc2GMBRC04jev/bvyWJj4x6d+13yI4Qgj
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169696904"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 10:27:49 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel-janitors@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 09/14] block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun,  9 Jun 2024 10:27:21 +0200
Message-Id: <20240609082726.32742-10-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240609082726.32742-1-Julia.Lawall@inria.fr>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed, it is not necessary to use call_rcu
when the callback only performs kmem_cache_free. Use
kfree_rcu() directly.

The changes were done using the following Coccinelle semantic patch.
This semantic patch is designed to ignore cases where the callback
function is used in another way.

// <smpl>
@r@
expression e;
local idexpression e2;
identifier cb,f;
position p;
@@

(
call_rcu(...,e2)
|
call_rcu(&e->f,cb@p)
)

@r1@
type T;
identifier x,r.cb;
@@

 cb(...) {
(
   kmem_cache_free(...);
|
   T x = ...;
   kmem_cache_free(...,x);
|
   T x;
   x = ...;
   kmem_cache_free(...,x);
)
 }

@s depends on r1@
position p != r.p;
identifier r.cb;
@@

 cb@p

@script:ocaml@
cb << r.cb;
p << s.p;
@@

Printf.eprintf "Other use of %s at %s:%d\n"
   cb (List.hd p).file (List.hd p).line

@depends on r1 && !s@
expression e;
identifier r.cb,f;
position r.p;
@@

- call_rcu(&e->f,cb@p)
+ kfree_rcu(e,f)

@r1a depends on !s@
type T;
identifier x,r.cb;
@@

- cb(...) {
(
-  kmem_cache_free(...);
|
-  T x = ...;
-  kmem_cache_free(...,x);
|
-  T x;
-  x = ...;
-  kmem_cache_free(...,x);
)
- }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

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

