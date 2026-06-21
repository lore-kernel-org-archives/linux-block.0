Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66042299943
	for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782085984; cv=none; b=XyOVxTuhgeuGpVXEQWADTz88S55jIEY1CnsWogk+w1+oeUHAFeHsL20fO4+xzpuaghOx6cHBEuxY8TkSzI5lXthrzMiWhE7YHgs7SPk1gW94OPpXK43h/dRR8rGRPtYVAMV5PpwesIA2/gxkIXAYV9yEFiPgU/K6NuhA3RrH3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782085984; c=relaxed/simple;
	bh=w+qTwBUIy4BHf25YNJU+FugZIBmLFo8ynV6bh3KrpWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izSc1C50RiT6VKrSZ+AW6l1Fa+V1qt/6KPspUyqGQfetC3FVkxF7ZMM92mfe095Ze2MgpmnESWBRiM4BmcfcmK/SGy6Q2z8fVZXp4NzvEa2ra0hum+ux1LL7UJzLvOwnHMIBHTp/Qa3CENntHfTQWsXKgk7Yw1YbBsHvM+C/4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IilN3RIY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IilN3RIY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845369f60faso2115100b3a.3
        for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782085983; x=1782690783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUwkknzM3W8jOMgWbU+Q98oClrKuC6/1N4Q1+LqXc2M=;
        b=IilN3RIYA10LKb7CJoig8xS+l+0GB/OZBLTFoD+Jn4cYO2HqrLRQNzF7MIR5vCeMJh
         x7V++00KPZCVffiFTX9I2uibVbzd1OT9xCPG1Zg73lwtpnRVRym8Gw5VYWizZ2EJ9Y+s
         gBPqq409bMx+f+PFN/fA60sAR182WA/kDfoWkHL4xZaZhq4BlNCNZfPt1hCyNHXTdwPU
         UMSF7XB4ZF2JV9gnZBbfbJcWG46L07mZtqHZMuZHtUMA1nrxDI/y9nZTTb1tOCBCUTfj
         zXQSdRB5UjUMTh9cY+rxW09nQWYFR6tFHl9vCFXzFMIHDnV09KJ+skpjrD8VI82XXPkJ
         GvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782085983; x=1782690783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUwkknzM3W8jOMgWbU+Q98oClrKuC6/1N4Q1+LqXc2M=;
        b=TpYtQs370CsfFxMd5N6Sx9PQhyrcO272se8+2y8iGO+FvDyzcZdDndJsz62lvvByCI
         UvmKL8ZGmkhIy/2Yhys/bw+GlqvfZ0tsjtCTvKTujE/bpKfhLfGBrYHZscUCDvvFcADV
         Zwxj7s7T0CtK7wMXlGEbP/Vq5NmNkr7YjWQk/MkkRDGz3x+4OIUTnMRwDDWrCS5biSaq
         5L3aN5lk8uVUQmCs2KAibIgzC3CjnmHEIv7uBwjmnwSYQrZGbNTZhxBr6blbem7WK6SU
         EruYRmmTjNZzYxeHcB2TGmoGYARHOc8MWF78IGZ1E7L2yOFWkZWKk5VLdkdU8wOLEQi2
         APRA==
X-Gm-Message-State: AOJu0YwTsCk7jthcNOteU2Y0348RmjfXwFPJPEhw7P6FjSC5rt1AjJd8
	bydCMQW33VdouJuF6n6bj0N9953IquDVUPFhDvtj+leIr0iVbwF6ZwxD
X-Gm-Gg: AfdE7cmTBmWtOJ8q5Prorbfg7zAcuo4b9AzBOIjnr0gJVM7kIfxMQasU1hCTE/WK9cV
	+HyB3BZOgk7L/LQCPRvz1pVd72jKIaTDU9o9sECM4LOeZpI/IU4UbtOJ/0j08tmkeYcknrnrVN/
	Dhjksg3/DjUUsv6IoOsjpc3JMhuHv4bouzi+UrOfPPPRkaeHnVXmpawHQ1KVSm+Uc9uSpO/Fb9c
	ifmJyyUf8hAA1KJAh4Eou+LgTKCPfy5yqCR4SizJ76E7KDcPiZqoXvoJXc+4JMyEpVDNYASusfs
	Mk81IWDgUQ4HnEYSNwDbJFYjImNrN4o5QsNSKEsjgfv8oGxL+BlUJ6RG/LIsux48glWwTUvESGf
	8+629goip5Xd8XXzEXrpHc+//cmaHbgjzIu+u3dvo+a7aY65ol1HfEIhAFu+GrtAAfjwBdzGKFa
	66vUAMs9gg/h6gq/e5iI8o5KkrfkNDv1mFY3oxiPumh1uZ6PGGpAXSNOLiOdamsC4pEF4=
X-Received: by 2002:a05:6a00:2d8b:b0:845:44c7:2fdd with SMTP id d2e1a72fcca58-845508bb8camr13490364b3a.34.1782085982563;
        Sun, 21 Jun 2026 16:53:02 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:a10c:b74:f527:1266])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ec335csm5449327b3a.49.2026.06.21.16.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 16:53:01 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	edumazet@google.com
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Mon, 22 Jun 2026 05:22:55 +0530
Message-ID: <20260621235255.66015-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock is
held at the point of reclassification. That assertion was copied from
nvme-tcp, where the socket is created internally by the kernel
(sock_create_kern()) and is never visible to user space, so the lock
is guaranteed to be free.

NBD is different: the socket is looked up from a user-supplied fd in
nbd_get_socket(), and user space retains that fd. A concurrent syscall
on the same socket (or softirq processing taking bh_lock_sock() on a
connected TCP socket) can legitimately hold the lock at the instant
NBD reclassifies it. sock_allow_reclassification() then returns false
and the WARN_ON_ONCE() fires, which turns into a crash under
panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
against socket activity on the same fd, as reported by syzbot.

Hitting a held lock here is expected for an externally owned socket and
is not a kernel bug, so skip reclassification silently instead of
warning. Reclassification is a lockdep-only annotation, so skipping it
in the rare racing case is harmless.

Reported-by: syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6b85d1e39a5b8ed9a954
Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3a585a0c882a..8f10762e90ef 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1246,7 +1246,7 @@ static void nbd_reclassify_socket(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 
-	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+	if (!sock_allow_reclassification(sk))
 		return;
 
 	switch (sk->sk_family) {
-- 
2.43.0

