Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704788;
	b=ieP+vPff5UYeNYKuhGIt8pU9ERsDl3OWTgV0v1Hx6XgXw1rye9LZVyQPlWMjYei1ljzC
	 5eqLKdoLg5fuLM4OKMuryW8hVt2+CEuPHiOC7Y6UjntmA8d5FETm1RC0m0sJMRk/EBdRh
	 hQDDoOkihvVXThHrdUfuPhGeuLQ7G9CXvkerYjuzrwm+8YMiCVqJft/61TurLSUOnpMWU
	 ewZ/34B7XFKHtaqnqdCagZq7g4IAm3jRVwcX0iI0PX5xAY+r0IbfCduw7oM9qmZ6hyYAu
	 GK2teaQmj6OZshEy+vWIDeKrMmiSnQie/0+HlyCISxcoGiV6C9KBRIb++aAlzitlCFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KxeOng6tNZx6tK0gchpIz6DNn1HOF5OU8odsnbpqQQ8=;
	b=vY6xruCS/WWAn+us2ShzzUll7UVReHb5M+M3pPVxp2Dhe34h+mArsW6o+tsSj3yD8fMN
	 4HsHBet+sO478RuY2X6OUMxU70VzBOpvcrkJufSxjIQc4bCmy5whqNY+tE1Y4izBKcYJQ
	 HHy7jMzmA2F7T4SDWuCZSM3/2IZ8c+vXR+HxpCxJoseZjPQiazQn0Hy7/3tfuDCYuCN89
	 8dmepYpaS24vhyyOS2evLwmWaR82ySN3YP4DSUdyEbYzYOYOct3l4sJ87rrHiC1qOsEQM
	 ZAOdgbL8J1I1k8SlR++HYQ1E0Vvr58MJxV+JXhdIjzlB11oyWayiyqK9i9sDLkvqlQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b="ob6qi3K/";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE8606A6A6
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 14:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFE8606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=ob6qi3K/
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so41398565e9.1
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704786; x=1796309586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KxeOng6tNZx6tK0gchpIz6DNn1HOF5OU8odsnbpqQQ8=;
        b=ob6qi3K/KtHx9j06TrGaW5rMXWkSUgZiK+4LwwQxGWqcucs8NL/awrZliJTgBmfpJ0
         32GozPndyf89pudrruNvXTebUOHPe1/aGqUFRUTsShxusomMVEvQNGKnce6NhDzglaDB
         PK7Bz5xhp+GEZUQewy2UeV1svF6VNACyKabGRFkdwbYRCeGfOEWwElY7D1kn0X2+Tq1k
         E3j3qv/KHDIcfB18lC0cCVhI2nx47NLktclMm2llFBt5LwQ+7A8m3on/oiH1cEDaXzVf
         w1S554OmWEH1diK2ZQblR/sbwbTuU6TK30H7mrHODt/ubH5ENqhxT2DC8yhwUl3IRkRc
         ycWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704786; x=1796309586;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxeOng6tNZx6tK0gchpIz6DNn1HOF5OU8odsnbpqQQ8=;
        b=CG3AOF07krYLECi5Zl1bHZtLwRgBPlZITNfw8F6jqx0RCo1zIMbh/kXGskjbSiDJro
         MiNYHArNXUk+yWAAovgGIQiHGwGiVjNX1So9aewzrVPw59LRVGvWyTxNt3sYhg5/SQDY
         EUuxS7AMVPCMcR/fyEv3CLFAmKzjeGERm8fn6ZbjG/FebwlFmXrhxRdZFIKLDVTHEsy0
         ffeO49UzKQcgVJbT68nBQqNMTHCS6N3aH2O7fQkbLhBQ0k0mm9jg9lBWmYn1yw+6hZXG
         2qYtHZneJLGvEmYzHmKSCplTXvvYX63vo7NOpOpxQG6WnccT71HNKzTnvaTF+R0F37x7
         gWmQ==
X-Forwarded-Encrypted: i=1; AL+hErHrXetulWT9hsYOLiwosd0ZFSJskUoYzWTlnN3Yl9VCxlFqN3RQIE2TqyBf0eeqdFEsvHthKh/hv7+EJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8TDBov4cgsbQhsMWS9k70iE+TmW1ZV03vt94mFExSb1z5srg2+
	pBrm7QUYcBHUQa0R+ojyd/qcE5hVPCn6bWXWRK+S1HzpHD1zd/Pz4YtZmNFZmi+rReUVNO9mI+/
	dFcrIBQJuNA==
X-Gm-Gg: AZFdTZecmGejrGeewl9xesW604boQusflUj8hxBrODTixm7B/KSdEfG70PBoXCSnO4i
	MDGmXlso0lzsJsZKqh77eXecrTLSwhCRiIFBvmeJEtUerIyMcGiGrfg7sGGfKHkcyg4JPu+ZgR4
	57uwqaCzAGpL4ATGtqftAVqDmaYoMt+IHLoz1/x831aXd9lINP58dpanQ6iIW1Qj5jX3F7Jt3TH
	aghIp6znzzMkkmPeqpgV0f4In9CcaAjMhjTUeisUjpU0+rtJjLZ72n7/i7fojqX+7gZRdPajihr
	bZpEt7IWrHd3r8Ha0Dm0ec/4dnl9mIUP8CW6p7LMiPLPad3q9MH69Js5wsUHgtWIiFPgfPBFhgM
	7X3Agj+9eiWIIQrZX8olBlqTgtrAOAHm1+bzNvUlCye98YnaBr8kJ+3PIyBG+qGBjL0pHlC61Qh
	q5ZiAhMl17QVseANEFNA9QoekYU3zE6mm+ih+X65d8p2UnXouTZDA17l2Th6yYnUFdXyz4M3N6l
	Hn+HhfnOj6OXdXbOEtGFKLWDgW0U8DlfRCOj059+27waPRx6iSl0NfDkwALhxqzM/xXr2HpV6Kz
	CCZidcm8DdJAUQwxSqOtdTv010PA7yzUfQ3H9EmwxTiIFPQraO0sX5MLzz3xdZRk1V96fTbtww=
	=
X-Received: by 2002:a05:600c:828e:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4bb88786ddemr394721475e9.0.1795704786159;
        Thu, 26 Nov 2026 06:53:06 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:05 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/4] drbd: resize: do not silently "truncate" the effective size
Date: Thu, 26 Nov 2026 15:52:56 +0100
Message-ID: <20261126145257.592085-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
References: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lars Ellenberg <lars.ellenberg@linbit.com>

During the connection handshake, a node with an established "effective"
(aka last agreed to) size can detect that a peer has a "too small"
backing disk, and refuse to connect to that peer.

Unfortunately it still "caches" the maximum size that peer could
support. We remember that size so we could still grow to an agreeable
size on an unconnected node, if this node's backend size was the
limiting factor and the peer was known to be able to support more.

Now, if we remember a size we rejected because it was too small, that
same logic will silently truncate our own size if we are asked to
"resize" before that cached information is properly reset (by taking
DRBD down/up, or by connecting to a peer that has a backing device of
sufficient size).

Workaround: only ask DRBD to resize when the connection to the peer is
fully established.

Fix: reset that cached size to zero in the moment we refuse the
connection.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 101192d8398f..9cc41bc07ae5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3931,6 +3931,11 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		    (device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS)) {
 			drbd_err(device, "The peer's disk size is too small! (%llu < %llu sectors)\n",
 					(unsigned long long)new_size, (unsigned long long)cur_size);
+			/* We rejected that size, reset to zero so it won't
+			 * confuse the aggregation with min_not_zero() if
+			 * someone requests a resize later.
+			 */
+			device->p_size = 0;
 			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
 			put_ldev(device);
 			return -EIO;
-- 
2.56.0

