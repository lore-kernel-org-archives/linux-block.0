Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731143B8D4F
	for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518851; cv=none; b=XEL0hHPO4Q1QNK3aeRtmRDHWIzGOPGA05dja5/5DDkfMhxRaYHVxew77RLu1yOJKaRV+wZRnkZ0jurHvZ0fQWj5XfdoxrtsTI33SvzwMBsO+xKDHyoUNlt+mVLxNi37i5WzNSB/fUaWk8qMjIMEgXX23bhuK5RSlYZs9f+qL00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518851; c=relaxed/simple;
	bh=rewYJ804mTzQ60NoVNjxyHcEpuHioue73AiOm0aU4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlJQypOaI2cv5ZpGldRL5lflcvSVqtiuiIUyAAfSbe7cqjh86bSG4FMlLIH3sFKX5oTBh6Z7d2Ow+HB16kmuCavGAnDI7IVFJLEUHZPK8SploQAeN5adAf+S/2fbVbB7R1Bl12fPW4+Fj/7/ChopX1IqOlynUTeaXdB6yG0g+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiZVZYJX; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiZVZYJX"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3427493501eso885299eec.1
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790518849; x=1791123649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QuFiE8Sn5ZCiAo2F3P+hWDb2ouMekTqqlvB4M0L/MQ8=;
        b=HiZVZYJXNFvEUFnGqmna20rmJwC9EhanTDGZOYOp21a57gwfBiM1R30OzwL01Wr+r8
         fLV3ZESNzy+6LtaILsb3zqrMNlQ+jxn70MfnxrgJLJVDK1rVPb+9qLkwVQTSvVCME7Ae
         akOM5VdfxMcyYbSRKeJXzU7vzTaDsllYoBItS4w0Kjlaof8zoe+RuIH7uGlWOodRxGUn
         jAStjmjKwcZ49njgPihE7oTOStxrUrQOFkJRon+CoIhu/ZTY/2hCSxthMSq8CAryMvFM
         wK4BycH3aZF4m/ewt3waW30jhWfhgmsrU6LuzIHVLXI7CUgOfL3LSC+h1urWFRd5jRlk
         Y3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790518849; x=1791123649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuFiE8Sn5ZCiAo2F3P+hWDb2ouMekTqqlvB4M0L/MQ8=;
        b=d3PfSR0sb3HgFcoFiAJwy/foE+UlpaMXp5hJb1/SBIQ64IliUaUlkrDE9IUwMAOamr
         aO+eHrmnrKy3JE1M5RaFvxBryIehqAdVRmD5uCRkCR7fNlH7tTBWyACWks5Mt1Inw/MR
         WLU47/vvc9vhPUkNEpB2n8YZ0HUj1azKxymjKEpLWNp5XKZRxv+yzsMOdPHYgz5MeAB7
         3H7yFayFwb5dkqXbBULV4w/TyULv2mz0p/B/Oa5f/mQfdd9N1QfWW6y6fBLGWmEKdeaX
         NMo/dg9NMjYGX53Q76oy2QyrnpMIBypDcgIwpcglvzlOix4QW7ssIoTl/zjIa85+2e03
         wa9g==
X-Forwarded-Encrypted: i=1; AKwUvBy5/S5oMdqBB9zyBCEQZGjco1R/70YiF46MyASqIAlmf7tt68AuGNbV+8EYsgc9SbUnMUSFHABGBDmGVg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKagUR64ZOXxHm0/dwRgIH5750KdChfy19QjQKzSIFp1HF59p8K
	tW8vc1mKSj2LLHQyYFw2a0Cq2s2DeALZ0TSP6ySvHg369JGwbdBkRSRv
X-Gm-Gg: AYBFou1Onu+XxYulpWOxsqlDnw5BMx67oULIFvgK3oI+oRr/90QfrYabbWsqdPZqHJd
	c9FTug0GjdPKzLCDgsGefUiL3HPp1L1dR952BO+oWbgrX9hL2p+9+Hz3VD9Jngh/po/L8QlpXM3
	dV1myq6Q/y6gRWI7FFbNpkWDffeSOqIT3AC08hioO1UvPAw1BIbhSNII2H5eSsulmwYQ5A1rpoT
	rfTW3YTXw1KqXPi7i/eSiIHFMtyGP5JhlJgCXNeNtQGIBNPFuAN7UFUewIf6DIdNZtGWj6mxXz3
	S7w+GMulMW2jw4w3Y2jilEyQCg/7gDKL56xy8TYxjcdjIviLM+DDlBuPMkNUgXOKf+keOYVKTNt
	8mozTHs1Ol1GDtX5cf0H2HADZB1DWbcVgKhsEhm3JFc9iGHCPrvO1xtvV4WFrlMhGkA8r+5REMe
	+O0GGbLOrgRbD+vI6wHWmzoIhPAKtZ+i4dakKs909cHPec39QaFv1pI4o2dNo1OEegyvVO02tom
	TOBakGTABYwYpUD25xZwo3Rx4KRGxzs
X-Received: by 2002:a05:693c:87d6:10b0:346:7c2c:1d23 with SMTP id 5a478bee46e88-3467c2c2597mr1464216eec.13.1790518849337;
        Sun, 27 Sep 2026 07:20:49 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414504fae2sm22534911eec.20.2026.09.27.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:20:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+4618907cccdeffa@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drbd: keep discarded packet size unsigned
Date: Sun, 27 Sep 2026 22:20:34 +0800
Message-ID: <20260927142033.297349-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packet lengths are decoded into an unsigned int, but
ignore_remaining_packet() stores pi->size in an int.  Values above
INT_MAX therefore become negative; min_t(int, ...) preserves the negative
value and drbd_recv() converts it to size_t, allowing the receive to
overrun the 4 KiB rbuf.

Keep the remaining size unsigned and clamp it as an unsigned value so that
each receive is bounded by DRBD_SOCKET_BUFFER_SIZE.

A KASAN reproducer reported:

  BUG: KASAN: slab-out-of-bounds in _copy_to_iter
  Write of size 32672 at addr ffff888027129000 by task drbd_r_r0/5002
  Call Trace:
   _copy_to_iter lib/iov_iter.c:197
   simple_copy_to_iter net/core/datagram.c:521
   __skb_datagram_iter net/core/datagram.c:435
   skb_copy_datagram_iter net/core/datagram.c:537
   tcp_recvmsg_locked net/ipv4/tcp.c:2846
   tcp_recvmsg net/ipv4/tcp.c:2949
   inet_recvmsg net/ipv4/af_inet.c:896
   sock_recvmsg net/socket.c:1159
   drbd_recv_short drivers/block/drbd/drbd_receiver.c:322
   drbd_recv drivers/block/drbd/drbd_receiver.c:331
   config_unknown_volume drivers/block/drbd/drbd_receiver.c:3624
   receive_SyncParam drivers/block/drbd/drbd_receiver.c:3671
   drbd_receiver drivers/block/drbd/drbd_receiver.c:5366

Fixes: 4a76b1612f35 ("drbd: Map from (connection, volume number) to device in the receive handlers")
Cc: stable@vger.kernel.org
Reported-by: <co+4618907cccdeffa@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 58b95bf4bdca6..3fb73fbfd5f27 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3616,10 +3616,10 @@ static struct crypto_shash *drbd_crypto_alloc_digest_safe(
 static int ignore_remaining_packet(struct drbd_connection *connection, struct packet_info *pi)
 {
 	void *buffer = connection->data.rbuf;
-	int size = pi->size;
+	unsigned int size = pi->size;
 
 	while (size) {
-		int s = min_t(int, size, DRBD_SOCKET_BUFFER_SIZE);
+		int s = min_t(unsigned int, size, DRBD_SOCKET_BUFFER_SIZE);
 		s = drbd_recv(connection, buffer, s);
 		if (s <= 0) {
 			if (s < 0)
-- 
2.55.0

