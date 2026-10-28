Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197360;
	b=DhC1erqgtAdlvUarhTp9kXvsCBMexpP8JkqVAD78ctnceo0XjoVRDwnztnOHf3izcWOm
	 oSUn1w72YAxfGUQd8pkNaPoI9VlE6es796+UQ9r/USJsvJ4tlGXxc4fdYhYPjVdJKBYD3
	 TLne8XyDUVcJAjZNiWzsFbcAX7TnUq1M3lWI2OYFHJGE+dFs5bvUv1NpjdOoR8FzEgul8
	 FRWSYzqjw7bqEBLVZiI8WAW2KTjoiCfyPGNIliGicUCsc0QaM2aZEayYX5Ma8qu65TM6q
	 IfAAFDhj8jCQ1RADvaPhOk9JH0SR5n4gxM9N1mGESq6LIAlytgM3BHRXRqX/kdYRGvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d6xo5cJLzMRcEzyBwDsvWjXaejYriCDwwrXb5CZ5N94=;
	b=2MYwuRYtP4C+Q7oixpK8yZWLNY1b1poZXnxxhdbnkF66ISoSlSbNYFuvrImLvWNXCNyy
	 9TUC3/IfhNqmakVoOrBpkNkb0fCbNqxgQqM0VEKM027jSlxWKBrAQN/DJKeBmpalRmljx
	 Wh4IDeXVpmxNmf11xn0cFXvNXLfXmllX3unWttOmNRp5Y78M6brNOFcoi6FkCoLA4dqjj
	 /B/p9+jh9IFM5+d4rBSmUXq+ceFRm9Tdze8tcgGzUC2ZkfvgjbIHbzUs764EDO7hXuMx1
	 IO5Jiq8/oGcqb0P6YMF+42858oV2OFT+14QX1NVqs5Xq3KtcQIZRkP47oWcztQLlmLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYFX5FBy;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFD606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDFD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYFX5FBy
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso8202855ad.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197360; x=1793802160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6xo5cJLzMRcEzyBwDsvWjXaejYriCDwwrXb5CZ5N94=;
        b=QYFX5FBy3/KO2MAF1zdZmN0FZcrCcprFxmjM3IgVmExPv/cdUmYODAZiVqqFUpyZv8
         HRfV1q/1tPZh+J1RQWtL9/dauWbXyi6wD0veX3qTkO7HNIK6sFmNRTloFQWc0Usz6I8K
         eP0351D4C5rXW3pDsClwJBLNUdWtniyDNMFmYvi8MQNPPGs0PZRyxGNS+zMB5ZI2XmX4
         bVblquPgCSvW16twws9nr95pNg4gjLO+bgc3U9joxk9GUEM4Kc0n4bxxIZIZYgYN4jr1
         yoEMwILo94+NcludKGnzm19tlGdC6/HbWikvah8WhuqSDbU7S4afLDAjY3eatyNkGL5W
         7ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197360; x=1793802160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6xo5cJLzMRcEzyBwDsvWjXaejYriCDwwrXb5CZ5N94=;
        b=fdSRYYCRPrW6CQjqikMY9ugiJcyUCCnTEvwIhdqAVtaTLwJx9t8gLC5Lifnp0SobG7
         0Gn+ztHXoMOKIbB6EnUQelpFyTjjIjz/CewuwDXIUp0spdtX2LVuahNp/o1ti6etTLr/
         XA2al8XcZLchUT2/J0hn3OM942ERR21SK+bRW+Z6kA/kpNhqWHK/FJqPJ/yoko6S3iv4
         CBPatat9vrewJttXGV1WYikvqKjOGe1id7GoFux6T/vdDigA/cK5IyKzromcrKA4xxUe
         cwWWR6abEI7kHz1b9nb9KqM5ptSoY2er0xvuIWubYYGK837cgZEyZ/tE1k2hjd9Fnl3G
         uVrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWlITDwbQRmGu4c21P/6U6RtDQuw9KpaSvnKxgQDbi0LcGvIjQxMadl9YvvSisPgQdBOaNXaaKVRAJww==@vger.kernel.org
X-Gm-Message-State: AFq9FYLy7S8T9Rdv6WhSBl/amMV+vbd8F7vM9ChnOx58BOvgjZwOrjEX
	wVK+8RTGoEA9/n/1Z5Kq5WTvszGouC04QaTXK627XalY0zI/17M7E3Z8
X-Gm-Gg: AYBFou0aFFXkauTNpFJfQu2ZK0WIV+fyvourzhZypsgRBoFzbwHYIsn5RBhnO4EHpxZ
	F+sTFIw1IQJBRwDJ/mC7V53YPVjJ/HEdhoIYd04RAIes5hCIfh8QLRd//pS1NbScZij6DuCLo7j
	FiBk8dfGD2+RiWC4kIs2HUBuS6hXmyhBsnJKG+ftpJUa2oA87+iCY1ZtvNeuqxroqCeqUA/W31O
	fWiyJWTS6Vv5jcfsckAEsv5Vz9aFzk/rmGYCQzPimC3RyJPQy+iookZP3gl/SXjq+DaIOxsiOHK
	23Zn23CW32v+mxX92eEHiZNXXAr9g5Ot/JWGNzw/8/aCwTTj0wIw3OA9UsuGrG1HHtU/Wx6uLw4
	KjKkycje1HaTag/23hUuV8vNvvvrJndFZlCQHmEX2zPtISQVrkHUkY8ebFH7aO49UvnYqP6dzyi
	vjZjCCpqWrazmzMUSjXvFyz6Lthnenc1s0o4xw4JA3GSxLTuW+51bP5Rkp2gFdiiia9LZyxLsP2
	4WZyVqHnBa5QKKSRZWypYUSF4qFPohNmzUxjlIrBAdlGkxaE0lWZJwLLM4QTJ5Sj7I/JcBc8AJ4
	4T8eSxrOicMat7sNbfM1zNaFfiJd
X-Received: by 2002:a17:902:d4c4:b0:2e9:776f:66b3 with SMTP id d9443c01a7336-2eb001d0688mr25784005ad.2.1793197359610;
        Wed, 28 Oct 2026 07:22:39 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7ac0:50::246:47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9ea8asm23149375ad.66.2026.10.28.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:22:39 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Eric Dumazet <edumazet@google.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH] nbd: reclassify the socket lock on reconnect too
Date: Wed, 28 Oct 2026 21:22:35 +0700
Message-ID: <20261028142235.24675-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular
dependency") moves nbd sockets to their own lockdep class, but only in
nbd_add_socket(). A socket installed by NBD_CMD_RECONFIGURE keeps the
generic sk_lock-AF_INET class, so the false positive comes back as soon
as recv_work() shuts it down under tx_lock:

  WARNING: possible circular locking dependency detected
  kworker/u20:0/67 is trying to acquire lock:
  (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_shutdown+0x67/0x410
  but task is already holding lock:
  (&nsock->tx_lock){+.+.}-{4:4}, at: recv_work+0x657/0xa70
  ...
  Chain exists of:
    sk_lock-AF_INET --> &cmd->lock --> &nsock->tx_lock

Reclassify the socket in the reconnect path as well.

Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Found while testing the fix for
https://syzkaller.appspot.com/bug?extid=a246ab421a728c78b4ad
("nbd: don't take cpu_hotplug_lock under tx_lock on reconnect", sent
separately): once that splat is gone, the same reproducer reports this
one. Independent of that patch; applies on its own.

Tested in x86_64 QEMU (KASAN + PROVE_LOCKING): with both fixes the
reproducer runs clean 5/5.

 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a567c0bce90e..b24f69a2bd82 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1357,6 +1357,7 @@ static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, unsigned long arg)
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
+	nbd_reclassify_socket(sock);
 
 	args = kzalloc_obj(*args);
 	if (!args) {
-- 
2.43.0

