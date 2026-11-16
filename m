Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865700;
	b=uvVqAvjBKnyoWRIB2WHUHoAF8XIMNY5IVwQMjBfcssvFifNQW3g4N4MnmoCzRc4oUaSw
	 LdMSdhd13mP1603/2Q6A9VVvcKfpFvhD+RCVguiW1xDTu7ZbKHWA3QrMNm0JxOZGisSvi
	 aobgZOIJD/t/5d2Dj3BPJ3+2dPnTTe6sUW32l6iSkoc4+ZK8mHWAYCj7XBjvkd45JX5sp
	 OCkp5x4Cv7F338WG4nvgl3WlH4TUJCu5Fh7OXKbiGgAlHn7hkU7hWHiRbPrkvg1UlSnNe
	 x0arkKp4PrZ2i1HZmA22k6UOYaEJJRQHEFX00Ou+j2sk6qjyoPnJuWsuTxLdLx6J8xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=hoOcG+dfuokBuzs2pXEu7dc9JBwfur+utfuNxA6+P8o=;
	b=YFnCRBFjTlUrxHdOU1rhsX0YWe/2IPSzYUx7z+Pc/nahgPRVvNn+wRWEHGqLUSbY42Ae
	 qqXScuse22C8a3APBhdVI5HBMJvWPG9QaiCuzxyu3LwQElDngynlaZstuK8naCoiPF/G+
	 GJGntNVnK6sUFntC71yJiPaTM7TxqP/eSoTfphL4agpzV6ITKiqlHfLmGUSHb+fNtyINA
	 qZDHHLdwZ+2t4H9awlvzPpci2dtaMMJt0EwMwLGY7UKy4koa0HeK1LmXxZ35npkVDK8Fz
	 9IUnC24zLR9pve29CYjg5PMIDHIXFwb4VJhzqCjo91Z5vEQgD7qpgi7noVc9EuI30sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hLGC0XUj;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128F606A323
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B128F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hLGC0XUj
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1h32YW2zlfcm2;
	Mon, 16 Nov 2026 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865696; x=1797457697; bh=hoOcG
	+dfuokBuzs2pXEu7dc9JBwfur+utfuNxA6+P8o=; b=hLGC0XUjsQsAKJEEmkVEk
	O2gb2kP+zqFUlvs4rATLKCDGxqjvH3yVYvkr7g8qnz4a6WYGq7ETmXfIxqQJPxqU
	cGRV3N30mKg+Bd4iGOB0vCKVkXFOnaKBLRDt0ObmGy07AD8OGx0fXuud2U1rTpQa
	86HEXvOW4aqwz6ldMQwsoIy2LWDg6zFACPMMve4pE2NtXwqEbhmLEQBLJzZVkIkp
	GTT6XKF5vF5YWZJHsO/2PHTKq6AqHNgFdYdynIqEOMwWpecODQPM4lv0F5mHeUFS
	yaYZRoWNk896JeFRq9YuSuC3PglKwss1hTX0Kbelfqqoa6WdzczSV7I6RTtIhDgG
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kK-bW0M2D8Kh; Mon, 16 Nov 2026 21:48:16 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h00F9TzlpHws;
	Mon, 16 Nov 2026 21:48:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/8] nbd: Wake up config->conn_wait when setting NBD_RT_DISCONNECTED
Date: Mon, 16 Nov 2026 13:48:01 -0800
Message-ID: <d7888d6ceb7cc7d2b82009cd3dfc4792c6d3a0e5.1794865298.git.bvanassche@acm.org>
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

Wake up config->conn_wait in sock_shutdown() after setting
NBD_RT_DISCONNECTED and marking all sockets dead, and also in
nbd_mark_nsock_dead() when it sets NBD_RT_DISCONNECTED because the last
live connection died after a disconnect request. Remove the wake_up()
call from nbd_disconnect_and_put() since it is no longer necessary.

wait_for_reconnect() waits on config->conn_wait for NBD_RT_DISCONNECTED
to be set or for a live connection to become available. However, neither
sock_shutdown() nor nbd_mark_nsock_dead() woke up config->conn_wait after
setting NBD_RT_DISCONNECTED. Hence, callers of wait_for_reconnect() kept
waiting until dead_conn_timeout expired unless the flag was set by
sock_shutdown() called from nbd_disconnect_and_put(). Waking up waiters
wherever NBD_RT_DISCONNECTED is set also guarantees that a wakeup happens
if sock_shutdown() returns early because nbd_mark_nsock_dead() already
set NBD_RT_DISCONNECTED.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..864746624ff5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -322,6 +322,7 @@ static void nbd_mark_nsock_dead(struct nbd_device *nb=
d, struct nbd_sock *nsock,
 					       &nbd->config->runtime_flags)) {
 				set_bit(NBD_RT_DISCONNECTED,
 					&nbd->config->runtime_flags);
+				wake_up(&nbd->config->conn_wait);
 				dev_info(nbd_to_dev(nbd),
 					"Disconnected due to user request.\n");
 			}
@@ -420,6 +421,7 @@ static void sock_shutdown(struct nbd_device *nbd)
 		nbd_mark_nsock_dead(nbd, nsock, 0);
 		mutex_unlock(&nsock->tx_lock);
 	}
+	wake_up(&config->conn_wait);
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
 }
=20
@@ -2327,7 +2329,6 @@ static void nbd_disconnect_and_put(struct nbd_devic=
e *nbd)
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
 	sock_shutdown(nbd);
-	wake_up(&nbd->config->conn_wait);
 	/*
 	 * Make sure recv thread has finished, we can safely call nbd_clear_que=
()
 	 * to cancel the inflight I/Os.
