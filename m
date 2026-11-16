Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865704;
	b=r3XSc2HNxIZ8CMHV5hvX+SGM/b3xuzD69Ae0n21GOobvM4DWbnYGEtUjxsqpyWpHVJ+o
	 7/X8mIWn4tlmKH+o2/LzF4d4XdjrlsRXECQT7E4LIw6EyVsVH04h3AQCRnhHojtNrpp/t
	 J5E77/m+OE1Etx0PC6TB67sJ3lDd5qAFhr5EWuFoBe+g9SteFnjiZTbwx9UwrC9KLw5YA
	 nhvwJBFVOch3jYMeEd4ginipzsR8zokierUqWa8UvRE86nzUR37VeD8wbRHsfYYaBzzrN
	 ZuTFM6Jif55TTK7l8cfvoj4j8iGcSKpG9d1tgNh43fJdxDMO9wn1HLajKBHythcG9sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=cumaufiNoF2gw1e2LAAbTjYg75bMtDQYVLindkgKuS0=;
	b=wEpRsg2xP2gJL+Id2QPP4XiCGkqm1ICNhY9Uxt3wJvXrmaV96xlupTt9swc6kGR80c3u
	 aRuJ4/mJ+L9S8GojRVxtoPH1a0wtJvw+gWG7oEDM45B5wkrAw7Pw8Wbh3zSpIbdQCTyeo
	 UGo3wPtU3bLzff4FaNX0Nranhr+iEXLUe73yHu1EdnOysw/ubzZFljrmpffjsmIIfCC6b
	 E32TwrfPBLBgjtoNkY/JOch6K5ycbBgyi28vXIOVqDEgzWtF30oes3W55Ndmk+AoA/wc6
	 e0zEd7VQuG3++V4cibJKSvtq0tGnS92fMeKSojSNFEnWLjrZ6T2+2u5060EuMLSxw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=uBFS0bnS;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C3606A331
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B85C3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=uBFS0bnS
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1h73vcWzlpJ43;
	Mon, 16 Nov 2026 21:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865699; x=1797457700; bh=cumau
	fiNoF2gw1e2LAAbTjYg75bMtDQYVLindkgKuS0=; b=uBFS0bnSkl3flNP3mImAg
	mGHCB4gSF6MI+xGzykciUHzAJSHD16tbfZ5KHa+TcVAHp0jIbExsDcMFqDN+Rf4h
	YnFyJvG/WErZ3DGWor45Zb0h2ryRDntCTKptbM2ilR4CwiwXqZlAWAxbac0NYyQi
	C8hY1zmtTGSr1kVggpfbMwaq2FYdhPgWgXUWBvEBj8OJfr9SKI2OOEIxrd8I30GH
	QsOjiEUyLH6LLtPDdqjUS///HYU1jJ/or82LZqG1HHMmLi+bD4eYf8WkCwdjBYbI
	AU0rTJW8SSdgWQTB+xn6WF1mToXlbBKiO+uQc72B/6DeJfbsQlzBlH7m/hi6iM+b
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kSR_gcFrDSBw; Mon, 16 Nov 2026 21:48:19 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h15vcTzlpHxj;
	Mon, 16 Nov 2026 21:48:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>,
	syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com
Subject: [PATCH 6/8] nbd: Remove socket lockdep reclassification
Date: Mon, 16 Nov 2026 13:48:06 -0800
Message-ID: <b4af82c8a780afdf7497d2cc7873552c63eb9bd2.1794865298.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <cover.1794865298.git.bvanassche@acm.org>
References: <cover.1794865298.git.bvanassche@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove nbd_reclassify_socket() and its lockdep class keys, reverting
commit d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular
dependency") and commit 9280e6edf656 ("nbd: don't warn when reclassifying
a busy socket lock").

Unlike kernel-internal sockets created via sock_create_kern(), NBD socket=
s
are passed from user space as already-connected file descriptors and
remain accessible to user-space system calls, timers, and softirqs.
Calling sock_lock_init_class_and_name() on a live user-space socket:
- Races lockdep_init_map_type() against concurrent lock_acquire() calls
  in bh_lock_sock() and lock_sock_nested(), corrupting lockdep state and
  causing spinlock/lockdep splats.
- Calls sk_owner_set() repeatedly when the same socket fd is passed to
  NBD_SET_SOCK multiple times, leaking module reference counts because
  sk_prot_free() only calls sk_owner_put() once.
- Does not prevent circular lockdep reports when user space performs
  sendmsg() on the retained socket fd and faults in user pages under
  sk_lock-AF_INET-NBD.

The reclassification suppressed a false positive involving the chain
fs_reclaim -> q->q_usage_counter -> ... -> sk_lock, where the last step
was socket transmission from nbd_queue_rq(). Now that request
transmission is deferred from nbd_queue_rq() to a workqueue, sk_lock is
no longer acquired while blk-mq holds q->q_usage_counter, and
transmission happens under memalloc_noio_save(), so no fs_reclaim ->
sk_lock dependency is recorded for NBD sockets. Hence socket lockdep
reclassification is no longer needed.

Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular d=
ependency")
Fixes: 9280e6edf656 ("nbd: don't warn when reclassifying a busy socket lo=
ck")
Reported-by: syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6aec63fd.5f5735a5.290c1c.0003.GAE@goo=
gle.com/
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fd0789849612..f713779b5a5d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1318,42 +1318,6 @@ static struct socket *nbd_get_socket(struct nbd_de=
vice *nbd, unsigned long fd,
 	return sock;
 }
=20
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-static struct lock_class_key nbd_key[3];
-static struct lock_class_key nbd_slock_key[3];
-
-static void nbd_reclassify_socket(struct socket *sock)
-{
-	struct sock *sk =3D sock->sk;
-
-	if (!sock_allow_reclassification(sk))
-		return;
-
-	switch (sk->sk_family) {
-	case AF_INET:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
-					      &nbd_slock_key[0],
-					      "sk_lock-AF_INET-NBD",
-					      &nbd_key[0]);
-		break;
-	case AF_INET6:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NBD",
-					      &nbd_slock_key[1],
-					      "sk_lock-AF_INET6-NBD",
-					      &nbd_key[1]);
-		break;
-	case AF_UNIX:
-		sock_lock_init_class_and_name(sk, "slock-AF_UNIX-NBD",
-					      &nbd_slock_key[2],
-					      "sk_lock-AF_UNIX-NBD",
-					      &nbd_key[2]);
-		break;
-	}
-}
-#else
-static inline void nbd_reclassify_socket(struct socket *sock) {}
-#endif
-
 static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 			  bool netlink)
 {
@@ -1376,7 +1340,6 @@ static int nbd_add_socket(struct nbd_device *nbd, u=
nsigned long arg,
 	sock =3D nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
-	nbd_reclassify_socket(sock);
=20
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
