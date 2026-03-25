Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F41359A8D
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420741; cv=none; b=m6sLtHDNWosuo7OMfrPHE+1f2cEBxvCDPUqBE//12Wl8pHrvd9mGoJCY99i7H3Xshu3UpNlLy4LB6YSvbKKeZ1GzJU5QvxzrrwF7nx9ahwBNOsE65iKhrAGrRm990C3togRN8NN6rMRzIDlNLMMnmcIbuK9vP6lTlf5nHxmpsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420741; c=relaxed/simple;
	bh=LAdKqUyxFbnfvJCphUoGLvSMksWEznMeq0lag3oTTpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tfEtoBjPdvygiJLdf0lbkTVo32nsiQqtE6KP2aPJZRZsGHIXWxNXppSCpA0g/FlSa8J4KRvXVecIS7PeO9z1PqVq4MEnddaBGeyLdkbCYmptRdqr17QAVR/lRyYKeOLd9KHM8d3SjLY94+B3R8HwwfdHSCShPS1OkQR05Obbe/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCixhAJq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCixhAJq"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c6929bd26so2500900b3a.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420739; x=1775025539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEDu3iUfouJb04ptIbRT7+n4Z/VovB4BeMR+pdGzK3s=;
        b=FCixhAJqEA1o/rijNcD5QAs3gQB3TROg2cVbJRPHS+UFXURslFvsGYx/7ZW4BVG+Rk
         Tf0LSQfZEp43zQUdqEXwOXUj5vFuwZen5NFhVkmQDWoTbHnhKJTRc1HS/TMQ4kCRjKSv
         Qjzn0Bf/8jdtyTGKX2H9NTMfRsVl4Nf572GMWFWKIxb8ZBfFKLhaXTMLFsV9djv7IfU4
         f7iBXRx17iuyU56jkY9muvGf8iEnX8mOAVC+zSlOJM52UcfUL/6HVyORmoqE/YqJSf18
         p0+R5SnKJ+BktsXMvzcDFkz2qXYOY6d+v4vwCiYUtyoaPzV9r4tTy502miI9fZlfTmyl
         oCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420739; x=1775025539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEDu3iUfouJb04ptIbRT7+n4Z/VovB4BeMR+pdGzK3s=;
        b=oTKLwKXQ4YgyIr0oerZel0Acg5dgrnBhI5zoYET9/+GIxShYB1Cxim4QMh0sACNk5/
         xGfPLr2F6x3ck3c9axGBdCopWXlQ/BHJdLuIZkx8SE13qVcli6EPA4RDTyhpywcok+q7
         srMcLAlDU75D6NZAqqufaQ2Cyw1HimDFL9CsJH4bHbwSNCZ2VHVNcEQsJG80vYw8vEC9
         dPf0W1xpJGwmUjN2ryVHE7z9nU2oJFL+qxa36CW9PjG5TBlOpb1jpVGY39WO1C1p4V++
         AM4Wc0sku5qn3LOdlah2n4To+aimF9kwviQiNWsjrt/x5R/9pdjxcG67qDRqtxfaCBAN
         WFVw==
X-Forwarded-Encrypted: i=1; AJvYcCXfhc8fedp43GOdTvoaGSJLF76Hc8RXoII9/RlYv5PqD84iP80EYTouAce/gp+E9IUmjs+9nEHujHYl4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iPvpGMBNWrwuAxfAkQhvGwkhQW68+ZM0WqIPI5vRHbfKbMcx
	45K1D8AVW4ZjRNgZyGg0njTbPhJFadXZPRbeY8IGYMCiWJF07VJp+XIvpcxLcdUXODUeKRa3pkJ
	h7nEnpg==
X-Received: from pfbfa24.prod.google.com ([2002:a05:6a00:2d18:b0:829:813e:c970])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4215:b0:81f:3fa0:8c38
 with SMTP id d2e1a72fcca58-82c6ded2d60mr2408162b3a.20.1774420738537; Tue, 24
 Mar 2026 23:38:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:25 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-5-kuniyu@google.com>
Subject: [PATCH 4/5] inet: Add inet_shutdown_locked().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When NBD calls sendmsg() and shutdown() for TCP sockets,
it must use lock_sock_try() to avoid potential deadlock.

While TCP already exports tcp_sendmsg_locked(), there is
no locked variant for inet_shutdown().

Let's add inet_shutdown_locked().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_common.h |  1 +
 net/ipv4/af_inet.c        | 43 +++++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 5dd2bf24449e..c085c39573c9 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -38,6 +38,7 @@ void inet_splice_eof(struct socket *sock);
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
 int inet_shutdown(struct socket *sock, int how);
+int inet_shutdown_locked(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
 int __inet_listen_sk(struct sock *sk, int backlog);
 void inet_sock_destruct(struct sock *sk);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c7731e300a44..6fa8fd11fe6d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -902,21 +902,11 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 }
 EXPORT_SYMBOL(inet_recvmsg);
 
-int inet_shutdown(struct socket *sock, int how)
+static int __inet_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	/* This should really check to make sure
-	 * the socket is a TCP socket. (WHY AC...)
-	 */
-	how++; /* maps 0->1 has the advantage of making bit 1 rcvs and
-		       1->2 bit 2 snds.
-		       2->3 */
-	if ((how & ~SHUTDOWN_MASK) || !how)	/* MAXINT->0 */
-		return -EINVAL;
-
-	lock_sock(sk);
 	if (sock->state == SS_CONNECTING) {
 		if ((1 << sk->sk_state) &
 		    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
@@ -953,11 +943,42 @@ int inet_shutdown(struct socket *sock, int how)
 
 	/* Wake up anyone sleeping in poll. */
 	sk->sk_state_change(sk);
+
+	return err;
+}
+
+int inet_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	/* maps SHUT_RD (0) -> RCV_SHUTDOWN (1), etc */
+	how++;
+
+	if ((how & ~SHUTDOWN_MASK) || !how)
+		return -EINVAL;
+
+	lock_sock(sk);
+	err = __inet_shutdown(sock, how);
 	release_sock(sk);
+
 	return err;
 }
 EXPORT_SYMBOL(inet_shutdown);
 
+int inet_shutdown_locked(struct socket *sock, int how)
+{
+	sock_owned_by_me(sock->sk);
+
+	how++;
+
+	if ((how & ~SHUTDOWN_MASK) || !how)
+		return -EINVAL;
+
+	return __inet_shutdown(sock, how);
+}
+EXPORT_SYMBOL_GPL(inet_shutdown_locked);
+
 /*
  *	ioctl() calls you can issue on an INET socket. Most of these are
  *	device configuration and stuff and very rarely used. Some ioctls
-- 
2.53.0.1018.g2bb0e51243-goog

