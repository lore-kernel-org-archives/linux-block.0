Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB23FF8BD
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944241; cv=none; b=kbkSHzw71l232yJ3gAiQmMumIdsya5uq6R+m0MPFWkOAyQBKql2id8JVczEbP8YqyjB3e40OCvxfI0FB3TiD5lrumx6lKXhXaJf3F5hq6KN92Q1hqZXDbZHmK/ZpAoMYRk4ZgeE4X7anfI3plJli85T3yfeDphOXfNoTf+2awsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944241; c=relaxed/simple;
	bh=ZYPlUQQ8NxbRmIt812/pyp1086j6CiJO2t2sgFOKsSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QoDli3pOIRj09gb1UvcRlaRmopJAEGJbz7GFxCF+UXHAJ2NXKMFmDhBsrikq6G9EqyborW86JWcNryEGuZ5cDWiDgbak6097JmaMZ9uDJfLCGOE6QnRdOmaCQTN3gs/DLsik2hn+wuC2B/x2vKWmkRoD6vrD8OWqbCmQwGfebi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjqPVD2T; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjqPVD2T"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc6207127aso16014275ad.1
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944240; x=1784549040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdrPerGbmq5NMDa7g7PMgXL4m2wISq1Mdu9LzzqhMGo=;
        b=HjqPVD2TDoITQepsUFBIz7TpaTgvFVqECKRbZrFK3TUGhfCvLyoumpnZaRfLzJl7xK
         vz3mti5j3NtApZHvxcbl9TsJKfEu/NTW9l48sNmZ+9hpTNG+CeMtsbzZLwH1BO61Aalh
         ilPUokikmveH53mVtKN2OWDNhZGx01BoAOupJwtI6y9OqOiowcxycKNyagMHQGPdNS3j
         /x7J2OQDFJ9PxeeV0VqhJMHruzcdpZeb7ErqSuSRZtBA/tPJOomdL9D7YvzOvCeTrlBI
         k3berGHi5JnHn00t8BSMFY/cn705cUDXrDPMp2yJddQgysi3VSopu26NmCuL1d/lPNSK
         fI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944240; x=1784549040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdrPerGbmq5NMDa7g7PMgXL4m2wISq1Mdu9LzzqhMGo=;
        b=jcNuPpybdfjJYfLkcXxUx5vnb5Hl7aK2AZfxHPHvm3PHMeOnGcgjlVAh31yshysPwc
         ZcXyc4Z6Efl9TiD5Y02pedwdh76gTvC9Ah5OmhKbD8r++Qewm/5rRBNGBPtczN+6ZPg9
         WTWvdcPP6IRXDtJW/uze4RTMiFi4W9Dtw/kk5HSo/qOBrGGHgN2XtqVWmfry8Rf6EWyQ
         QcTjG96GOBbqZL51dHk9eREMJ0AiQG+3b4e9dEeCrXdGwOZBrmOEIjbJmeVKx4zHdEtg
         E3hqDSTiHEBxOd8E2NFU0raTtMK9pynQJo0YmwFCP6eFFFBGkZbt26mZ1nbfZ6bWTsBb
         mLwA==
X-Forwarded-Encrypted: i=1; AHgh+RptcP63O/V6DEcbMYxB2Z4a+Rp04R9b7rSe6wcwowoR35smukN6keZE+9kkPPFSdANlnZSdC9y29ORtrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NRkP461MXS0wZEnCIvhJ/2E+SLrIoA0/76qF7aQsntVgfhen
	QrXOp8eoCzQq6KmzRFjxYiwN9hs+aWXdV3vo7x3I+IqsAkQbe4UJr0ez
X-Gm-Gg: AfdE7cmoJQYOv30sgnoCyGb4BQDprO6Dv8nFj6qGAztr3DrpgN40uEYCBjnIPXNehAL
	Qub6dyMtjA5gf5xE13FlkKgG1fA/7wwy+vnoWo/6agcZLNT24Tal3gFgDLIOIEgaWpOo95pUStC
	D20bjxIiw1k3HuydQ0xpAmxeAUhfsX95H18tITmlpRwAYpt4ITiSAkrvgJUm+nQDg4eEKfkzn9d
	Df/0UgesrHw0D1q9T84Ynny0ctxZohAe6AHw812Z6ecBTZ3/4NmU8vHRL/mSdvxCZeYCV3wAvNg
	Zjb6BVrIeOVU1DO3E4Qomf2F5LrrMlSw/kmUSMGm8ttUkUr8ahJwGn50AHbR+bn2xyH1kzJ7WDK
	jV547EgvKoYQcWIljDqsxR5ZrL5zbj4HhFN6xqtJn6G2JePNRmBO31G1wDIj36CAwkBHchXBoAn
	ZgfDwhTw3MXDgT5ptb9dqc
X-Received: by 2002:a17:903:350c:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2ce9eac6af3mr84428895ad.14.1783944239683;
        Mon, 13 Jul 2026 05:03:59 -0700 (PDT)
Received: from amax.cluster.local ([115.233.223.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c100adsm97053395ad.32.2026.07.13.05.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:03:59 -0700 (PDT)
From: l1za0.sec@gmail.com
To: josef@toxicpanda.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	Haocheng Yu <l1za0.sec@gmail.com>
Subject: [PATCH] nbd: do not reclassify userspace sockets
Date: Mon, 13 Jul 2026 20:02:42 +0800
Message-Id: <20260713120242.1284559-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <l1za0.sec@gmail.com>

A Syzkaller-based tool we developed reported a pvqspinlock warning when
one thread passes a TCP socket to NBD_SET_SOCK while another thread
concurrently calls setsockopt() on the same socket:

  pvqspinlock: lock ... has corrupted value 0x0
  sockopt_lock_sock()
  do_ip_setsockopt()
  __sys_setsockopt()

NBD gets the socket with sockfd_lookup(), so the socket remains a normal
userspace-visible file descriptor. Under CONFIG_DEBUG_LOCK_ALLOC,
nbd_add_socket() calls nbd_reclassify_socket(), which in turn calls
sock_lock_init_class_and_name(). This function resets sk_lock.owned,
reinitializes sk_lock.wq, and calls spin_lock_init() on sk_lock.slock.

The sock_allow_reclassification() check only samples the current socket
lock state. It does not prevent a concurrent syscall from acquiring or
using the socket lock immediately after the check. Reinitializing the
socket lock while setsockopt() is using it can therefore clear the
queued spinlock state and make the later unlock trigger the corrupted-lock
warning.

Only reclassify sockets that are private to the kernel before they are
published. NBD accepts sockets supplied by userspace and cannot make
that guarantee, so remove the NBD-specific reclassification.

Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
 drivers/block/nbd.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f10762e90ef..e2fe9e3308fc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1238,42 +1238,6 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	return sock;
 }
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-static struct lock_class_key nbd_key[3];
-static struct lock_class_key nbd_slock_key[3];
-
-static void nbd_reclassify_socket(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
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
@@ -1290,7 +1254,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
-	nbd_reclassify_socket(sock);
 
 	/*
 	 * We need to make sure we don't get any errant requests while we're

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.51.0

