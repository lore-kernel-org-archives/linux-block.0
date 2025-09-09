Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2585214204
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424174; cv=none; b=cV5hGgCFnx90Cq22+A1VU+NQ3AWPwQKeYDhfzIA5bhrK4p4UI51J+ZuQ2GZU7pzk35jNy6mvyWc+D7AdnNqBYNK7oB93rpcT5EG5repVs6m0zCXFM/EKoYywWZeeKWipJKOBVOtUgH7Z1eK5b3I6HsTJsgicpYWg+rt1IcghAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424174; c=relaxed/simple;
	bh=kAoIWg0eouVwlZINqB9hM9ZgDWPys75E8dPDrrUOVRI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bcc7fXKgxBda+cDQI48i2HW26bT32qIZi+lQNVuRSzhE+ZE6CF55sAneX25Oj/nBWTC7Ifxi7AdFUK0eEn8AFgN7DDANF7UuFmIW5pLhWARcDSumw8Qwe3yhWVIvcu6McTbXrOo6UAxGfFAZXpWgYMpMVltz17Wf713In3ymSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGQ1gNTm; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGQ1gNTm"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b6090aeaacso66361641cf.3
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757424172; x=1758028972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uchVPC5V5AnCU++0LQSE31dfyzhx8FL2wjNsKVYAXlI=;
        b=XGQ1gNTmJSgz5hjFPrtuVBGnqeKdf1jj/8mf/pZNeqdhyJkwTnWjQEnqraShpxMxti
         CU6WcZm1JHOrnR3D0MTiTAriv9nU1GeFNJDODjehxQNuzMwpevMhw0Zff5VURVLXM2dv
         5c9LKOSP1QfwHX9DgylFmNR5nYunILLJaANmrr387Lb84helrD1k3uK3NszUBAzT8oWT
         qKKRIVELjQXlqwK64Md4qW9tjMuYBGZUrd3U9HyBJ73/uXZo8phM1oMkN8p7bxDVylka
         tU9ldJnU9FbIaYZdYylBhFCA8xad0mdklE4HKWvs02u1Ls3WkAGFj/YH1pYERjm9UJkJ
         2rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424172; x=1758028972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uchVPC5V5AnCU++0LQSE31dfyzhx8FL2wjNsKVYAXlI=;
        b=iToKUtSeh9mF47SYASBd4RIQKOsd44OkmdcZhibu/m6MZCZKJJPmx+e68SAgMX8ZZQ
         4NDE66jCgnD8QP74d00bwIlhGB7cOsFJCHkO9EGzWH3jiKVvAKQE7LhdpUzWt23U7EaC
         bE5J+kKSHVFYoJc4wzltzmqzOcnqYYrFfzoAKGqGJJi074bFuEjUm1uQB8ZYIL7/FbsT
         et3NQaHzhWDwd/og/dCnChObgo5Wy+6IuShqlBDJzyRPji6g2mb9iFKJo6Tp6WlHAGXS
         1HljnnC4sPlQnQPKwhPD8ekjT8h6wvsdqwYMsyiATIQro2UXdIhHXwsH0UbN2awvasAp
         UKTA==
X-Forwarded-Encrypted: i=1; AJvYcCXo5HKrnm3hGqs4bwEp8iSA92kQbJCZFpYqkXwd62F1Botgu4tV1Sh0nQga4xnzQxFcciep0uAfizJaJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEId9Gqz6eP9a4zpPISWoYgtWgoCUBSf4aJcqsDDZWmEsKm2iL
	X255tNzE1cKpSZfAzAR3iJ4H1HH7Qk6xw83vvuJawmvFS0IGpZRi4ZFpPvEc8VmYoUfb2JyxQCd
	JaX/m6HE0yUOCTA==
X-Google-Smtp-Source: AGHT+IGYpVQiEzn9QHE1zn1hAW5xwDjdaQLoTNKxPgWkv7gyao/+uTsXb3LQmW5bD0GeIq3wlXcgPuI+F3/c5w==
X-Received: from qtz5.prod.google.com ([2002:ac8:5945:0:b0:4b0:a157:1d5b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4b14:b0:4b0:da5c:de57 with SMTP id d75a77b69052e-4b5f844d1fbmr103893091cf.54.1757424171653;
 Tue, 09 Sep 2025 06:22:51 -0700 (PDT)
Date: Tue,  9 Sep 2025 13:22:43 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909132243.1327024-1-edumazet@google.com>
Subject: [PATCH] nbd: restrict sockets to TCP and UDP
From: Eric Dumazet <edumazet@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"

Recently, syzbot started to abuse NBD with all kinds of sockets.

Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
made sure the socket supported a shutdown() method.

Explicitely accept TCP and UNIX stream sockets.

Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
Reported-by: syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/CANn89iJ+76eE3A_8S_zTpSyW5hvPRn6V57458hCZGY5hbH_bFA@mail.gmail.com/T/#m081036e8747cd7e2626c1da5d78c8b9d1e55b154
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Cc: nbd@other.debian.org
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6463d0e8d0cef71e73e67fecd16de4dec1c75da7..87b0b78249da3325023949585f4daf40486c9692 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	if (!sock)
 		return NULL;
 
+	if (!sk_is_tcp(sock->sk) &&
+	    !sk_is_stream_unix(sock->sk)) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
+		*err = -EINVAL;
+		sockfd_put(sock);
+		return NULL;
+	}
+
 	if (sock->ops->shutdown == sock_no_shutdown) {
 		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
 		*err = -EINVAL;
-- 
2.51.0.384.g4c02a37b29-goog

