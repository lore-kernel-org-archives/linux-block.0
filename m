Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A5359A62
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420740; cv=none; b=bATDIpvAZ/auheWeaTjTmxb/0rK9ABYxJHgbkOo/pYnLyJC0yTKV1WijDwTbKEJT/gOx7zHXbwCNjUgz1vLse0zUvVcf34OAksYgcbQVlpwAbcjXPeZaNBq9UbCqNcRSQQv+Cwj89bCAeodu6nhXdP9dbXKNUXlbLrJgSIY6VzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420740; c=relaxed/simple;
	bh=xSf4roTmD9ZMdpxhwYlICgfBMcunW+WN6mwr5Hlp4MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KCSF+oX4IGvxMyG5z59IOjqXdUuY+hppY0VqKzKz37+RfICa0PoXAAW8pFu74eaevcRo585SwI8pOXN4ueoR+pBYH8RLlBElnADT4HcXCBdWVr8gtqjAWQU99J5rSq+x/2ENGL8TkYnirBKnI/4QHYnYvi2yZbRG2efaeII10T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNyC3jlK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNyC3jlK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so1500246a12.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420737; x=1775025537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5KS0AwVtElapM67R1okpaPmVE6Ykz6fWReVphg8duc=;
        b=UNyC3jlKsoguNisdsVx+HIxmH90c0kKfWQmT95i1ViovTqzuOfgj7Li0IoABkrTdZm
         vE3HNgquijw7aPaIbSUY5AHfuKZaQcZjgjuxLAjIoxJ8hnfODTJMV8ZemBcrfNv2dtNY
         DhsRDJtLxuyGhbd8fpAaYcxNqg9oiXyNk3WclV8InjH8hfEYVhlymvjrDylyhWRiZ7Le
         BScXjOpEPHwn5OdN3X5sRLRoFAj3M+akjLGQzT8A+zFnrD5E+dyo6TCCvMJ93QliiB3r
         OgEcJrLagxHNpkvJ8VywEoLv7WwAxKDuKeEdP+EGuKx1cdQVzFHFL4er0sjcX2y4rG+B
         zvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420737; x=1775025537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5KS0AwVtElapM67R1okpaPmVE6Ykz6fWReVphg8duc=;
        b=QROe/SYZtRzXQG2UcjISv1hri4YN5Jz5RXNGufT9nfyZf6lxWU2mCxOBPz+EGlu2k3
         dUjsD2LAlF4qceCwRzlf4kf2pZGIrAJdnsnlj1eCfoI5cm3Bvl003IY6st1SFCXdbCug
         BMNP0nylRTKeiwvzrgEAgXJfQEy/rXs8dqViu5Tsz4tNFOckg2+5ZHA+ZlPg5otGv+dn
         Lo8arxxvi6BXg2kCyWr8FibwXwQrQ0H/SjQ2Cll5eMMrAYA2zEu69jHqFtlTpLSxEhlk
         dWMtmAe07R29h8kT0mxH/jT1i20ZOOpzmlqvcrYt5y9aYCW22nUZ6ipuZU/c5+e71T90
         nW8w==
X-Forwarded-Encrypted: i=1; AJvYcCVzyjj8t9PPj/SlDj2W8mbRdwGu+Kc9739OOqibCxkwPFpq7LiPShwmVF/5JNpnSBaujWTMbjMv0cT/Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypVTeuhOUG+rZ6TFX65EiPBk1bjIL+IJU8iEx4r7PQ/a0GBjBl
	5V18t42dXY9NykzIK9BIGZkiquIVKdCOV1X6g4pATCDS9ITWzqhqrHH0fCg/mXZYVWyXpQUYu6e
	JVNQqmA==
X-Received: from pfbmy7-n2.prod.google.com ([2002:a05:6a00:6d47:20b0:822:4e8c:2c9e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1acf:b0:7f7:2f82:9904
 with SMTP id d2e1a72fcca58-82c6de992dcmr2345147b3a.5.1774420736872; Tue, 24
 Mar 2026 23:38:56 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:24 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-4-kuniyu@google.com>
Subject: [PATCH 3/5] net: Introduce lock_sock_try().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has reported 100+ possible deadlock splats involving NBD,
typically following this pattern:

  lock_sock(sk)
  -> GFP_KERNEL memory allocation
     -> fs reclaim
       -> lock_sock(sk) at NBD

Before calling sock_sendmsg() or sock_recvmsg(), NBD sets
sk->sk_allocation to GFP_NOIO to prevent fs reclaim from being
triggered during memory allocation for the backend socket.

However, even after a socket is passed to NBD, it remains
exposed to userspace and thus can exercise various slow paths
under lock_sock(), where GFP_KERNEL is used directly instead
of sk->sk_allocation, leading to the deadlock.

Some of those paths do not currently have a reference to struct
sock, and plumbing the sk pointer through the call chain just to
fix the allocation flags would be extremely cumbersome.

Even with that, lockdep would not be happy because such a path
could be exercised before passing the socket to NBD, and then
lockdep would learn that the path could trigger fs reclaim.

Additionally, since the socket is exposed to userspace, we
cannot change the lockdep key (even for sk->sk_lock.dep_map,
due to lock_sock_fast()).

We could spread memalloc_noio_{save,restore} over the networking
code, but we want to avoid that and solve it in the NBD layer,
which requires the trylock variant of lock_sock().

Let's introduce lock_sock_try() for that purpose.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6c9a83016e95..69e4b8d17afb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1710,6 +1710,37 @@ static inline void lock_sock(struct sock *sk)
 }
 
 void __lock_sock(struct sock *sk);
+
+/**
+ * lock_sock_try - trylock version of lock_sock
+ * @sk: socket
+ *
+ * Use of this function is strongly discouraged.
+ *
+ * It is primarily intended for NBD, where the driver must avoid
+ * deadlock during fs reclaim caused by the backend socket remaining
+ * exposed to userspace even after being handed over to NBD,
+ * which _is_ bad but too late to change.
+ *
+ * Return: true if the lock was acquired, false otherwise.
+ */
+static inline bool lock_sock_try(struct sock *sk)
+{
+	if (!spin_trylock_bh(&sk->sk_lock.slock))
+		return false;
+
+	if (sk->sk_lock.owned) {
+		spin_unlock_bh(&sk->sk_lock.slock);
+		return false;
+	}
+
+	sk->sk_lock.owned = 1;
+	spin_unlock_bh(&sk->sk_lock.slock);
+
+	mutex_acquire(&sk->sk_lock.dep_map, 0, 1, _RET_IP_);
+	return true;
+}
+
 void __release_sock(struct sock *sk);
 void release_sock(struct sock *sk);
 
-- 
2.53.0.1018.g2bb0e51243-goog

