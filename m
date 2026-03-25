Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA07351C37
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420729; cv=none; b=BEtYkvho0zzUFpjrJysFqsDvZZe4rP+JxQIZElOBdLVKfaix7uarxPd9/aGu6Vgr4polHcmYsGlC1XHlOSixUy3OqHsV2btE9pWFeUjuqEIX57wNUbHkEsOY3tZelxtqJl10m7/wTnc5RJVrBE0guG5FdSrrg7orVIvjyVBMmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420729; c=relaxed/simple;
	bh=G4aUuv5IRjPHJ6XkBrei8QQPcxcp4XaxNuNC+DQhCwM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GHP+KTQ48K5A5Nh3sK5ePRji2mltwIykbORwH1mAKc1ngiJIqNa/KVQxlc9CckAVAikK+KQAnYzxsj7dc4+vpc9JbgdoTxlY3hjpZmzzSlR1QncEcj++KRv+dZIckswKLqSTHj9vtw0J5H4wb+Kk+5I/WKoFJT5LMDcDJmC3IHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m1VTbo2q; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1VTbo2q"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c6929bd26so2500645b3a.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420728; x=1775025528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ps9jyH80iSRUMtuSLZrvtXUJpNI4M5Ryo0aSIRfQLmU=;
        b=m1VTbo2qpdnd5ygOgTnjLXTzutkZvyEB38IqONUSlrrnF+2Le5zmJFUGLUVleznO08
         tirRrpOFbqqNmKoPGRb0CeOqBpCvLjIMYa1ced+Xcmy+qYUvJ2k7rBZ5okJTKtERKW8P
         GQUEFJxFAJ/Xe07unUS4Y7/JkpVGl96v0n8c1kK5boA+pzo4/iyKDb8bwkB1y4p263v4
         DTGfo6ilpTzNbRu7rLSEl9j8ktjPaIqrf76SfmzxEOQ8P5VA+dzbZajP+Q6QUMh0N8tI
         q+p71ssLLPZJLpY8dstKvdCuPpGo2dYtFaTrFwc5XOLAOaGqkQ5YxGCP7vMr62N6G+d2
         YXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420728; x=1775025528;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ps9jyH80iSRUMtuSLZrvtXUJpNI4M5Ryo0aSIRfQLmU=;
        b=hgOLLZ9wrZNhQOfvIjmnK+xTFVqoxGh8UCCQQWVmVbSOYFAmLmH3Q61fHlFAZilRjZ
         JKvggXORrY01kJS6oK+aXrAqfpiAJDPa4DEeCzfo+gbBZ3Y2G5p5fH0FN48MjACFg8U3
         p236OaQCkOHobBlm5JXRveE4kY/3Q/VuDs3kdUoF4gDlk4wxHaBo1i/J7qG6a8UaXQuR
         nj4GwpUJt+lI6cCUd1rawagu7w3F8fC0CqhWs6B5+jF8uzzhXK7HGlyjbMkaAiViwC80
         cqUVtAGnQFxI2FWj0wuUtfybG7cXET27Wt74TWpictxTpTmN+YinnENoXrEgFdyON3mR
         QeNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmURv8x7Zs1n17sEi2NiMDTefoJsOUweiJQVC60Qp9ANSP9+7qPZV4eSkjgh67C7az6jCQ4aiLRbxJQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBJuHXEKpf6VYivG1RteD/937pMLj2l1Y5dj1salP2CRTT0rB
	1tgpa/L/q306danGX+XNncEhJfu/ev/UXN7O/0sCw5xK1dMqiJ4jX7PLcOESEKvey+MERnrS+Mk
	AukAh+g==
X-Received: from pfbdf8.prod.google.com ([2002:a05:6a00:4708:b0:829:94bc:6c15])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4489:b0:82a:899b:d804
 with SMTP id d2e1a72fcca58-82c6dfa883cmr2464688b3a.38.1774420727444; Tue, 24
 Mar 2026 23:38:47 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:21 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-1-kuniyu@google.com>
Subject: [PATCH 0/5] nbd: Fix deadlock during fs reclaim under lock_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recently, syzbot has reported 100+ possible deadlock splats
involving NBD, typically following this pattern:

  lock_sock(sk)
  -> GFP_KERNEL memory allocation
     -> fs reclaim
        -> lock_sock(sk) at NBD

Instead of spreading memalloc_noio_{save,restore} over the
networking code, we want to fix it in the NBD layer.

This series introduces a try-lock version of lock_sock() and
use it in NBD to fix the deadlock.

The try-lock variant should not fail in practice because while
the socket remain exposed to userspace even after being handed
over to NBD, the socket should not be touched by userspace.

The series can be applied cleanly on block-7.0 and net.git.


Kuniyuki Iwashima (5):
  nbd: Remove redundant sock->ops->shutdown() check in nbd_get_socket().
  nbd: Reject unconnected sockets in nbd_get_socket().
  net: Introduce lock_sock_try().
  inet: Add inet_shutdown_locked().
  nbd: Use lock_sock_try() for TCP sendmsg() and shutdown().

 drivers/block/nbd.c       | 44 ++++++++++++++++++++++++++++++++++-----
 include/net/inet_common.h |  1 +
 include/net/sock.h        | 31 +++++++++++++++++++++++++++
 net/ipv4/af_inet.c        | 43 ++++++++++++++++++++++++++++----------
 4 files changed, 103 insertions(+), 16 deletions(-)

-- 
2.53.0.1018.g2bb0e51243-goog

