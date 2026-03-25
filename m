Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498B35A388
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420737; cv=none; b=ac9JbIRHNchbmEvkEunVWZD4bp57loaYYVNVGrL4t6ntjiqY71xvVCNGFUp/0dfH9Wh4C40mWioo6KRIApdWAHVIocRiw8ehyil7+iP1kZFX3g1FsfUpkzAwTxxK043WHJDU38zD5iX//25qNO1+E9lcfXAQQQWcddjMbR5MwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420737; c=relaxed/simple;
	bh=VIlhogVXZhEGBZnMLXlhILBNvpfmY3ha555h72D4CQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cKgh5aDqcZK61ST4hT2bu19F8nPsvRqfK+1KGvQIOnLlRbztcVZ8/vXzhGW8sa6za9m0oWLGuXtiz7sA12vFydS2Fmw/Pzn+2n8Kbh0jBl5TTQqLb6xFSmdLXMnRfXqnRqJ9F8stYvDJ7sMPpEPzGX8LdTkNGW/GI/0dsfNy9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCbQr+//; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCbQr+//"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35842aa350fso31077419a91.0
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420735; x=1775025535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nL4L22a9Ck1NAZ8TRhufw+BZmJs95X+mOcKWTHsxd3s=;
        b=NCbQr+//g4mcMUrsM8FwMmygQU3i69ieX1PZ/I6gf1WqGcXPiGm3t4mAgtlyMssanL
         VD3uN91avA9rIwEHezwZ2JS9h7WV8WnAQcAD45ERSsX9i3k08se9dvAuZimp4j5rgzSh
         5+DpGgoGBFIeLJiuykySOaZ+5rINVzqzwBH3D3OlJB5zJZpIEs/YCJDxSN+6k5sMRFqa
         KW/0itWrIZHQkrSegvDNYOvqjDOInKhSjMzmgQ0Gx11/APdaU+whDuGeUC2E+B4vbCqj
         ni4UL82OXavrwXiMLEyi+YOk0Vz6BktEaoceMtycJDzuwYzY94bCm4k3HI/XZZbjEfHP
         OiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420735; x=1775025535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nL4L22a9Ck1NAZ8TRhufw+BZmJs95X+mOcKWTHsxd3s=;
        b=oNRfb3NLpTmC/g/0rwUEG4wac/MAabaDV8wS0VWHx+lGpk1icVVzHjazeGmETYZTDD
         ovetzuBfUy9hxeNaedJYy95T2LuQUasXVRsxOHZvH2PRJxfuepb+sheCvxAlrojeD90O
         sShSuTY52a0do3bS91Vs2wJCRCjYmxzMntO/SHIHMSGv4Rx81JlVCOGSLpi190wnxdi8
         YgFzNBUlwzJ2nDCZGRu1ocnryX+uZUqzW8zp6AIazRGxgqtrPm0yKmwtRVtJdjWvbfH+
         GgECfCUJq2OTf4XiXEp5TdF9LSrRqW0+u19+M8JFCwVNwwSwH5aVIoLi/U6l1y1hussC
         MHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwm2+4iJslhv4c9CEBGwXBrGawLqNp6EyIBYnEhh7bCWascEQq8Ciuv/w7YrsNDCgWe6o4MCo/89GoIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUBHPZIjoy5zJnrWFOzc/E+dAuMojJyz0P3gPvHJN8XUilgLc
	yRuGvqUIBiatM5N5/12NJQYs5zd8TS8QpoLNXqijdeVQZXQ7DIKK80gRd8ihJmAAdCdQ7vFru5e
	1Hy9Jzw==
X-Received: from pglu12.prod.google.com ([2002:a63:140c:0:b0:c76:3cb2:929c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:958e:b0:39c:1f90:2867
 with SMTP id adf61e73a8af0-39c4ae9f50bmr2735620637.59.1774420735355; Tue, 24
 Mar 2026 23:38:55 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:23 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-3-kuniyu@google.com>
Subject: [PATCH 2/5] nbd: Reject unconnected sockets in nbd_get_socket().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

NBD requires a handshake, so passing unconnected or half-closed
sockets to NBD does not make sense.

Let's accept TCP_ESTABLISHED sockets only.

Note that AF_UNIX sockets remain in TCP_ESTABLISHED once connect()ed
regardless of shutdown(), but this is a prep patch for TCP, allowing
a subsequent patch to call tcp_sendmsg_locked() directly without extra
setup (e.g. inet_send_prepare()).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fc714cba1f23..1877554d362e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1228,6 +1228,13 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 		return NULL;
 	}
 
+	if (READ_ONCE(sock->sk->sk_state) != TCP_ESTABLISHED) {
+		dev_err(disk_to_dev(nbd->disk), "Socket does not have bi-directional stream.\n");
+		*err = -EPIPE;
+		sockfd_put(sock);
+		return NULL;
+	}
+
 	return sock;
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog

