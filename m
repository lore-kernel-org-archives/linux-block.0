Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271F3563C4
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420735; cv=none; b=rkk2OTszLxcM0F/miR2aI1cmGYMD0DZRksX09d6qOWGzyBIH7ZM1uNR4xzghCO4KqPuMntUMkj3RiZjwjNzz1el37+4nzUDoihYIg4WB6Si3gDaovvQZFo8qh6nDX5Ja+DRxhPpik95CItowXXImOKgbu7l/fXX4PLpbjnnnpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420735; c=relaxed/simple;
	bh=Dvk5vhl0CIvLArJHpPcg4CQ7xAl0HOrfl9NgAH6cT1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ti3HMLME1hSYGYlJA1EqJQRnYaSGgUqpq0JNdFUFxJWiF6rkKnJBxPQYOvINULsL4gRLylP5DXUnYw/oPbdC449X9PdWe/R44G8MvfraUvkGFtMpxl08ypHyTK39R46141Qtq/euOGZymL4xgn3H+twxjm4saRp/0ZNr3nJTWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVIJWWkH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVIJWWkH"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35b991171deso4281428a91.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420734; x=1775025534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe7lwzU/0LJm5TPvDH/KfFTCZrDEcrbFnFZJiKYD2Dg=;
        b=dVIJWWkHI0+UrjpBMaV80kUi31Kk8Oqk4UkSkPJwDw8TnjyjqFUL0QLXl5Y21piddB
         nbJ08c52Guq9AN3nXmDhpeRTCxfcJIvoHP+44t88hhjULjEcjyVELNV/21d6XH2lKny5
         vhHfSm9DPuTFUkiCzEYo1FNNJoemdjrKACA3BOPpWRxCgUhl0Lz/cjjyo2GjAcPmlFhe
         pfiQmzU5Iw9pH/OhfAXf0XX9EKqfJaKZjmPgidQZj/B7OIbG27AU5ghTfLHLdOu4HXbJ
         IFe1/FCzqTJR7Zbqr8Mqo4NLPNKfZuyHsN7KSfsA+VReEuFo/zSWN5jz6/wwqauOl3SH
         ejgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420734; x=1775025534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe7lwzU/0LJm5TPvDH/KfFTCZrDEcrbFnFZJiKYD2Dg=;
        b=dp5PyQsfScqlh0d8TrL8GxzwF2aigidObSzRqotj3DwFZOH9FRPGFHF2GYVpo6sziz
         B8lF+pJCfBdO9q6DUCof3MRQpTJzi+IGI5YpB2o4i3kPO5goucQRAVa3aK1DE/wRwDXN
         qllMBjEML75MXkdqBZv6dSnvEbf2QQevG4P8O91Rc/ouVjsyGbh8/GaIkQk81WZulMYw
         mqpA1xDMAA4vPRhG53BmJxYAMMmK/a8gFYyg+13f/P30+h7TwPRVNTfL+xBplHCRy8Bm
         pXjAT1RTWnGp7qcLPGEvVbyVEEdL4SV5KIOkzSpQ2CE9tGOD38QALMNZz5XY5DKU6nWs
         s8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWF29A/mSxIioX8kIWQc1to+ET+MjgJT8exV80xT2wxc6rJPp8amVKXEoCX8xbBqECv6dvwErycHN8+Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVWyvuid2HjVsJxBczQWll5582bVgZ7Jl7HCGlAbND9zBxZd+
	HL58xccdS65l5Xsqt4ZDreQ7hh5zFp4Bv2fMph5AntYNDXyqtrp22PKDqi5JSK+UKJXPhK+05bM
	YgzMDaQ==
X-Received: from pjbfz5.prod.google.com ([2002:a17:90b:245:b0:35b:8f3f:2b30])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cf:b0:359:f77f:8cff
 with SMTP id 98e67ed59e1d1-35c0dd6a759mr2063094a91.19.1774420733796; Tue, 24
 Mar 2026 23:38:53 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:22 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-2-kuniyu@google.com>
Subject: [PATCH 1/5] nbd: Remove redundant sock->ops->shutdown() check in nbd_get_socket().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit 9f7c02e03157 ("nbd: restrict sockets to TCP
and UDP") (s/UDP/AF_UNIX/), NBD only accepts TCP and AF_UNIX
SOCK_STREAM sockets as backend.

nbd_get_socket() currently checks if sock->ops->shutdown()
is sock_no_shutdown(), but sock->ops->shutdown() is always
inet_shutdown() or unix_shutdown() for these socket types.

Let's remove the redundant check.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/block/nbd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d..fc714cba1f23 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1228,13 +1228,6 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 		return NULL;
 	}
 
-	if (sock->ops->shutdown == sock_no_shutdown) {
-		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
-		*err = -EINVAL;
-		sockfd_put(sock);
-		return NULL;
-	}
-
 	return sock;
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog

