Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AD2D6409
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781324783; cv=none; b=PZS8McCbHmw39b1Djf7Sn4u+QmECnZmwOj4YJM8nuOEMWVPFF0c6Vvbwj1NkkBd5wIgjZruR6XMZMbtkXGSxDpd4gW0ISMX6r9jEvC5WKNChXq1q+QbmiKUjKf0zyzZIXNDhk/vkG7+FYNxP621uGst/+czlyGr8LQ+KFr+4FNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781324783; c=relaxed/simple;
	bh=xYvnBoU24LowK9XsuA1dWBRvMVViHxPRA9DkZeY0a+A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jCTjZfdA/vB43wtt9Tnr8BaUnnOW4iNjkgoEZoYQ2BYcLnRFHfTQPktPuhlWn3v9OCkjY42eqfdDTqe4e6q6vgLxpQbqR5My/9EAbDetd/JkfiG8eL7+WyjuOUyU1t11whsSdOyPa+EL+fYAK/uXTTiIDQrFHDj2wYAnW1NQI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+sFa2fk; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+sFa2fk"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5195760750bso3407191cf.0
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781324781; x=1781929581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6l2xGU+3qIFZEhz6OluRSAKcM6KzJn808ttYDsC9+QQ=;
        b=N+sFa2fkbGf9QmHpMmDGIr7Vpu8TbgqzCWJmut9Noc0/CO5USHoncHqmOZ4YBMWjGz
         GJHVQFCd27Z/31CcWKsx49BoM8/u8wrICVmZSHYlaEeBZ5zX3QulAGzG29l4ZuUNOI/N
         DAkOOJrKGNanO3xJq1LWFXizuaLkbY8NYqI1ULa5HQRuXv3ZZeE4gY3f4iozxUp5/p0A
         WoW1eL4bG+ktwK2pVI0ctalLS4+ZHxip4UW6XRf3ZmaVEkyO5kh0rm4XdRCoLiPzbDjC
         sda8Bg8JIlErnI8TApH+Q/VSL9N5Gf9ipYP8mFLugz0T1bZkI6OvaOSD/qiBfG4ljIU2
         UN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781324781; x=1781929581;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6l2xGU+3qIFZEhz6OluRSAKcM6KzJn808ttYDsC9+QQ=;
        b=Nso//79rB32diM4ReFblHuqDVGAkNOFrHorq+G/T+9t5wESVWdC9zltiAaWWiTv07s
         R3fWPc4R+yRfHoMPKMfb8Nghqrq4BKRhKb0Gr2+DXm6Pu8RsGqfDrsp58njUIccahB6C
         /LknupHTtJOH8dUv68ZGtZlma0gAMeR1B6Wt7dYUSYii/hHI7IJ7KNoQE3Uopfo7k6YD
         oMCvG2nmLMZjSr65rJvXmFratgyIGw8eLUozrC15cRPr+pG6LChA2iiFtKN7o9l5ZZ/f
         CsgGXsXqaMQ8iyNEZIleTEzti0H3OQxF81G3PF7QMlaV8/72igvgk2XTENngKMJxoaVz
         X7yA==
X-Forwarded-Encrypted: i=1; AFNElJ8bGHrWWvV8TvzGjq5IabgZLQP+xZVMwHPAOnpIkT2yKWSevmwrUA4+mN4aaWt6XCB/48p7pqv4NPhzAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykhlB7qZzNiyadRD/XJBg4+FmZ67zcbHSw3WsatVImmP+FtVhR
	9xwZ+bmo4BO5bRPdS8IiSSR5wLefMuYzAfVr+ElxqvQW3C71Twar0hu0sLal5rC2/ovVhLHXWvt
	G7g5AMiBaC5rIBg==
X-Received: from qtc12.prod.google.com ([2002:a05:622a:8e0c:b0:517:29b8:33b3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5e08:0:b0:517:6a26:43b with SMTP id d75a77b69052e-51953553d89mr38847661cf.44.1781324780985;
 Fri, 12 Jun 2026 21:26:20 -0700 (PDT)
Date: Sat, 13 Jun 2026 04:26:19 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613042619.1108126-1-edumazet@google.com>
Subject: [PATCH] nbd: Reclassify sockets to avoid lockdep circular dependency
From: Eric Dumazet <edumazet@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org, 
	nbd@other.debian.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a possible circular locking dependency in udp_sendmsg()
where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
can eventually depend on another sk_lock (e.g., if NBD is used for swap
or writeback and NBD uses TLS/TCP which acquires sk_lock).

Since the UDP socket and the NBD TCP/TLS socket are different, this is a
false positive. Fix this by reclassifying NBD sockets to a separate lock
class when they are added to the NBD device.

This is similar to what nvme-tcp and other network block devices do.

Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")
Reported-by: syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2cdafe.428ffe26.258b27.0161.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/block/nbd.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d960a1a4bbb2c60738cbbece10719..0e2180e910c4eaaa58556a0c75c1b9c3fdc1930d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1238,6 +1238,42 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	return sock;
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key nbd_key[3];
+static struct lock_class_key nbd_slock_key[3];
+
+static void nbd_reclassify_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+		return;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
+					      &nbd_slock_key[0],
+					      "sk_lock-AF_INET-NBD",
+					      &nbd_key[0]);
+		break;
+	case AF_INET6:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NBD",
+					      &nbd_slock_key[1],
+					      "sk_lock-AF_INET6-NBD",
+					      &nbd_key[1]);
+		break;
+	case AF_UNIX:
+		sock_lock_init_class_and_name(sk, "slock-AF_UNIX-NBD",
+					      &nbd_slock_key[2],
+					      "sk_lock-AF_UNIX-NBD",
+					      &nbd_key[2]);
+		break;
+	}
+}
+#else
+static inline void nbd_reclassify_socket(struct socket *sock) {}
+#endif
+
 static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 			  bool netlink)
 {
@@ -1254,6 +1290,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
+	nbd_reclassify_socket(sock);
 
 	/*
 	 * We need to make sure we don't get any errant requests while we're
-- 
2.54.0.1136.gdb2ca164c4-goog

