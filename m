Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347863;
	b=oS62FKRcRXr7iq9L0yu//PU5CSyAH+wEBewCj6Ils2LdHCFfMmfwzge5KG+UOrw9NDO3
	 SnrPR+E83iFZBj43LAl+q++b9lMcr1mHAoS2IHr6PoIe4OQOHLzu/+W4U33LFHHORrhwA
	 mSA+eBTnVNBYiAKgTtlnOTxOU8aCfVaHLD0PdYwFt2HXFJVaaQcaIOZ+fLROIc/KFS5hl
	 tCIIYbDmUtJzrg9r4kZ7lKtqiPOLvVgScmshTeVsR0bNXPfsNnNYDO/QB7ffMAqM92ynO
	 Vmy9Ra/EqjZF6VN6Nj8NEr1dJHvRwgO7qDeUZ6WRrVNEcxa74sC6eikCqjYytNSfHLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KtNiiE9TTBKD7Se2r/k45iohaRRy+fN+xVDbL1SGOtg=;
	b=fCP8jE8my/GBV+oBC/AI3KMhSIsEVr6u9xUP3WtnCvJsfNhI2jxil/PWmmEUNi9nvOS1
	 fMIdev0aIX0SvpOvmgN67xUtX1KyhYOUm0UxdDbYNZ/6vwk4SQb29J2Tr//D+Tjx6t8iI
	 ug2sVVnIQWN2cHCxN8ABBmtefzB28ODDPppxpHH7RGedVRwV1AiX58XOVNMZq1BNllS+Q
	 oEwAUaT0noKBnajiL6a/L/uDxkWr8C0wnR8/NZcHfw6sZrrvNv/S6XHF7ofojkUCcFCcN
	 ErxrxRu1Sg9bWXUh9gtIxYAX2Hp17/5i+JeCNEB+CMZnHRq77o7XxlIwmTZo+FCyikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYdAUEGa;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643060A261B
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 21:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5643060A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYdAUEGa
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b305e10ac7so27400137b3.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794347862; x=1794952662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtNiiE9TTBKD7Se2r/k45iohaRRy+fN+xVDbL1SGOtg=;
        b=rYdAUEGayiJdOKCxNPQLEpQR5kU5VPdw5jnM7jQQwdaXvGiVR/TF0WdMqnhnpeHUWo
         josep6Xf1xx5+U3fFudBb9taGXUUKk/VU1fKLQKAfQgurzMqfpgaaMZCLJPV2/OYHiek
         MhLEcZ4XXsCtRa9dZ2eEto5ZWudLGNPruwrCrJm75bBjpQ8IVRzzDQV95FKHaABdpnHL
         mXbA3JRmahUbVKmYUH7OfudaUYhcc+Tmdr7tMWHDRvRqSf2PYD41lz4NOBP26GXQlwqp
         fbA1QpLgjCOQuFsfx7+lnoCvNlS+13TkXbstn7DC5QrVAxenqdBaiPCcm+QzkGUpsam9
         3Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794347862; x=1794952662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtNiiE9TTBKD7Se2r/k45iohaRRy+fN+xVDbL1SGOtg=;
        b=vFFvmd43/drDcVobqzEDrAl21eTpe05elVEplsDC8qPkJHyEDUWBCzF0oQl4FN0HIp
         G3D+CtpyNe43B8j3hH4ENuAEywvJCtQkx528fnTPW8n5d9+vJt65BR8lxcaPhIK3MCRo
         C5FrOy9b0+9Aiw4JmmPHwSFOetz7ihDJL+/2eLaFMKyXXTCQ/T2MQM7zae0zRILtl5/C
         TUDn0v2HvvxypEfKqkE8j/jumfqFHOxwtd3WW3AFHc3cW3HIJF9nXlwtVWQ62u8NRMDf
         qgEYR0vYogn5nmeKTWfGeLMqhzqFySrjbEp1PU7Bmq6Dsfg7Jp/PA86KZZow1vZiFQH0
         42+Q==
X-Gm-Message-State: APuU4Z+jeFsXOHVcjRZGUJPlBUJp1SxsNaoFH8CaLrTwb0oAnXZIXGp5
	blfhwdD6eLNh+vWAcC2EUCPrhAPlzrVFEjxO7q89nYg6ipSeF9z/2Tg4
X-Gm-Gg: AYBFou0uYQ+9G9rjO5QKnpeEmxcsCYDsuOgJhVnNOJTou+rOQoLpBilkWg+wfe0rOaq
	xRTCToXRgDjgn15wiLIceGymrN5iKOCY5YvpUIvLybhrZx3yCEvJBgoNgEXgdGx75c/qrjc1nfu
	VSYJcYyTF2tTHTro6NkbCMsAD3pM6zemtD7J0d4dq8+H4Mo+LAgSuk6a8t4dXQWwV/WA231CqOt
	9hL3bbcwNuTMWYYJOYKizEMXpVPmNRk5H5IX8AmVOUoqOMpRlw93bMXyGYUE3qO7JOWOLJpbJN7
	LgAL/EH6oJy4vIbGksAyohITAyeLkqWA36/NugMbzaG8enJakjSfhNgWEBRb+Kj8SJOHhAxDjvq
	AUx8QB4VqZ4EtHEyJ5ZyCeg2mBdwWR2NxoMe+V7zFePm0bpp0axQruxNtauEO0faz06tVzzwmck
	BNiAYa5mUBo7e1mLZoFE5AXvvkhfWtXIc+tQPf3cQS68WYYNLR4z94hfVn8OEgXs+uw+XS5w1OC
	jPgX6Wk2mEfI/AxxIa75M13LW5n2HpLSUKvHnAKHRDH3csHXpripgViJFMLQAdtEW/qDQ/VoJjn
	PH8dloXBs68ZGsBGB423cZTMGHwPBnGBPNdswGPseYpQBzincf51V/bpzO+XMF6du9uynuItkJa
	6o5TpJAuI
X-Received: by 2002:a05:690c:e20c:10b0:8b3:34b6:4bb6 with SMTP id 00721157ae682-8b3a7e06f27mr3032297b3.5.1794347861960;
        Tue, 10 Nov 2026 13:57:41 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933d365fsm29877687b3.20.2026.11.10.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:57:41 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Subject: [PATCH] nbd: fix circular lock dependency
Date: Tue, 10 Nov 2026 18:57:23 -0300
Message-ID: <20261110215723.199948-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
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

nbd_genl_reconnect_sock_cb() replaces a dead socket with a new one
obtained through nbd_get_socket(), but unlike nbd_add_socket() it never
runs the socket through nbd_reclassify_socket().  The replacement socket
therefore keeps the generic sk_lock-AF_INET/AF_INET6/AF_UNIX lock class
instead of the NBD-specific class leading to a possible lock dependency.

Move the reclassification into nbd_get_socket(), the single place where
sockets are acquired for NBD, so both the connect and reconnect paths
reclassify the socket.

nbd_add_socket() no longer needs to do it.

Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d7d72f3d467710442af0
Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/block/nbd.c | 66 +++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..bc74ddb1d9d1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1210,34 +1210,6 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
-				     int *err)
-{
-	struct socket *sock;
-
-	*err = 0;
-	sock = sockfd_lookup(fd, err);
-	if (!sock)
-		return NULL;
-
-	if (!sk_is_tcp(sock->sk) &&
-	    !sk_is_stream_unix(sock->sk)) {
-		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
-		*err = -EINVAL;
-		sockfd_put(sock);
-		return NULL;
-	}
-
-	if (sock->ops->shutdown == sock_no_shutdown) {
-		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
-		*err = -EINVAL;
-		sockfd_put(sock);
-		return NULL;
-	}
-
-	return sock;
-}
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key nbd_key[3];
 static struct lock_class_key nbd_slock_key[3];
@@ -1274,6 +1246,43 @@ static void nbd_reclassify_socket(struct socket *sock)
 static inline void nbd_reclassify_socket(struct socket *sock) {}
 #endif
 
+static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
+				     int *err)
+{
+	struct socket *sock;
+
+	*err = 0;
+	sock = sockfd_lookup(fd, err);
+	if (!sock)
+		return NULL;
+
+	if (!sk_is_tcp(sock->sk) &&
+	    !sk_is_stream_unix(sock->sk)) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
+		*err = -EINVAL;
+		sockfd_put(sock);
+		return NULL;
+	}
+
+	if (sock->ops->shutdown == sock_no_shutdown) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
+		*err = -EINVAL;
+		sockfd_put(sock);
+		return NULL;
+	}
+
+	/*
+	 * NBD sockets are used from block/swap/writeback context, which can
+	 * already hold locks that fs_reclaim depends on.  Give them their own
+	 * lockdep class so that a page fault on an unrelated userspace socket
+	 * (sk_lock -> mmap_lock) is not chained to the NBD socket lock.
+	 */
+	if (sock)
+		nbd_reclassify_socket(sock);
+
+	return sock;
+}
+
 static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 			  bool netlink)
 {
@@ -1296,7 +1305,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
-	nbd_reclassify_socket(sock);
 
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
-- 
2.52.0

