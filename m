Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865703;
	b=XAEqdwePNJKqQerRci3t2VAK74+t5+3Uy24tzvtJI2qF7Fdf6BOzu6WToLlTFZkrjJKP
	 7RosYGTUhaTs++TXQnuQ2tZJpFAnlVkmQIMKu7rS6sXPcMJzZhLIkwTQeTR3lWU9venbl
	 8PSsaksgjoFr7nS4fFay4NvStdtTHrUbua4yDWnbk+VkbP838kLx6CVILj9S6piH20XY3
	 9a6EndYOafHzolpV8rEnB9uPQeIa7iR2KV3PYHWlF3FeMdXQCADwQyW0M3Evx0fRDiaGp
	 ao1CcWfO7kL3fHkhY+8b+nY03Nj2lepn3v5iy/ztkD88vH6e/00RvTdO7593DqZEB7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ihOd46Z1r7lc3Fvx08G7KbSHEwB67LojQs9y5hYYQgs=;
	b=RAw2wflETKLlAXskWwIP6f+679S/zYvK+6j8Z0VGpxxG3PDeLvg3l1HQy+2vDh7P/rer
	 URJrxMi9sr9wNuZ/wkT4n/2DEBjaCAGWRIHdqZOt82UsrMDvL2EhDCY7IqhqSxuABSgCa
	 ercKvkjyzeM+/AkLpMnzU2rIzOm1RojJ0naXc8UfM4eEP87mky1218mR2AYDuY2GJHrH1
	 7h3EAUFyKtZGtIhyexeXH75p2S26oi6D+ahVtkjoQ6jmUC53vQItsG1PSXMWBi+xuK6bu
	 /fJdbSoDYbdZuOdiZnltxka6wYni1fEk16lvMwilIwL1hSxS+1BkIgqTFczP+gwZw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=gj1A2Usx;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB84606A323
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAB84606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=gj1A2Usx
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1h63RmlzlpHx8;
	Mon, 16 Nov 2026 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865699; x=1797457700; bh=ihOd4
	6Z1r7lc3Fvx08G7KbSHEwB67LojQs9y5hYYQgs=; b=gj1A2UsxmJ8V413eSg8r9
	Gn2Ql822ky5/cyZbJ2G5rPT3i3Fod7uQagrlsGW1zFMlvS8JoKNCJPAwJEuUiJUL
	pttIrUdCCtIweMP0Ei4ZMdYQPFz47NULIvKFseFTHe3sCPRnk3XLf2KRVvDp1cpV
	f4P77/nNJaChQfD2q9v4E4qQkbSl4CAlIpGDdGy4d/0QrbrPDR7nvkqSsxhPXCSW
	YHYRaW55qsFPBrUHj1E6q/NoeP67BMqlkxjN2AUsgUm4kxiPbdAoRbobBQ1ZmCeA
	Ig+e29QAwDhoJXhq2qlvJfn5TjPeeVsJeh/LVHgMvwBAcPgm6D4zz2f4itBfLQ5u
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dVkgliVttX1G; Mon, 16 Nov 2026 21:48:19 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h13KDwzlpHxg;
	Mon, 16 Nov 2026 21:48:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>,
	syzbot+72fceb8393e04ce876d9@syzkaller.appspotmail.com
Subject: [PATCH 5/8] nbd: Call sk_set_memalloc() outside nsock->tx_lock
Date: Mon, 16 Nov 2026 13:48:05 -0800
Message-ID: <99643c402a9ba2d7bdb18b32acd29484f401f912.1794865298.git.bvanassche@acm.org>
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

Call sk_set_memalloc() before acquiring nsock->tx_lock in
nbd_genl_reconnect_sock_cb() instead of while holding nsock->tx_lock.

sk_set_memalloc() increments the memalloc_socks_key static branch, which
acquires cpu_hotplug_lock and jump_label_mutex. Calling it under
nsock->tx_lock creates a nsock->tx_lock -> cpu_hotplug_lock lockdep
dependency chain. Because nbd_genl_reconnect_sock_cb() is called with
nbd->config_lock held and is the only place that transitions nsock->dead
from true to false, nsock->dead cannot become false after the initial
check, so sk_set_memalloc() can safely be called before acquiring
nsock->tx_lock. Since other contexts may set nsock->dead concurrently,
read it with READ_ONCE() and annotate the stores in
nbd_mark_nsock_dead() and nbd_genl_reconnect_sock_cb() with
WRITE_ONCE().

Fixes: b7aa3d39385d ("nbd: add a reconfigure netlink command")
Reported-by: syzbot+72fceb8393e04ce876d9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6aece79e.382bd2ce.33e041.0001.GAE@go=
ogle.com/
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4d362e3cc395..fd0789849612 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -335,7 +335,7 @@ static void nbd_mark_nsock_dead(struct nbd_device *nb=
d, struct nbd_sock *nsock,
 			}
 		}
 	}
-	nsock->dead =3D true;
+	WRITE_ONCE(nsock->dead, true);
 	nsock->pending =3D NULL;
 	nsock->sent =3D 0;
 }
@@ -1447,26 +1447,31 @@ static int nbd_genl_reconnect_sock_cb(struct nbd_=
device *nbd, unsigned long arg)
 		return -ENOMEM;
 	}
=20
+	lockdep_assert_held(&nbd->config_lock);
+
 	for (i =3D 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock =3D config->socks[i];
=20
-		if (!nsock->dead)
+		/*
+		 * Only this function, with config_lock held, clears
+		 * nsock->dead. Other contexts may set it concurrently; if that
+		 * happens after this check, the socket is reconnected on a
+		 * later reconfigure request.
+		 */
+		if (!READ_ONCE(nsock->dead))
 			continue;
=20
-		mutex_lock(&nsock->tx_lock);
-		if (!nsock->dead) {
-			mutex_unlock(&nsock->tx_lock);
-			continue;
-		}
 		sk_set_memalloc(sock->sk);
 		if (nbd->tag_set.timeout)
 			sock->sk->sk_sndtimeo =3D nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
+
+		mutex_lock(&nsock->tx_lock);
 		old =3D nsock->sock;
 		nsock->fallback_index =3D -1;
 		nsock->sock =3D sock;
-		nsock->dead =3D false;
+		WRITE_ONCE(nsock->dead, false);
 		INIT_WORK(&args->work, recv_work);
 		args->index =3D i;
 		args->nbd =3D nbd;
