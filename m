Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704785;
	b=GYTX4B0LgaL1D85GfH+AtR9ypsziOPV7uuzeMFs0uHFaLdCH0sP+b+iEGeeNnaft0VzC
	 W4jk7KrrhdZZZBd2H5DlR8sGihp0S67vhORsHclL64G09DBwsf/0eAzvZlsPp8wc6rkpk
	 cgAb2jkgYqEvdXOwOWsaDVUvEVmeSWYAj5QM5G73GQiy8hWtk+71ZccP+b4O6vKsBtWLD
	 eWZdwCk2yaaGT0uULXnY96UUNFv9A0mvUOp2Bpiu6WJe5ybAfJWOVlNcPQz44VlCNi0C5
	 xgazvyiFtPw328h5VkXkE2EKgVZkKRwWwGfOh/mYTG9SRJX6Xmu6uCuEbQwV1xtpcDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TGfh22Ic+UUZqpUU8zmfI3BWZ3bedmz86wF+EG5USP4=;
	b=OWWovShdyw0MIf1++b+7JZd/j5lcT82KPocMsK+0rKwz6dukfaIC62DJ75lHZ5gyHy1I
	 KIb58IIgQe1wxDgTYQv3j98/cr88Pf1S3JvNHe1AfX2H/4aWWCVJamHiLWGs+9s8RLnxO
	 fA16fN9SxUnV0ATxPLp6g9oXXCI1pGjMUt7njVT6oFpLbsKmFoGy2hFfFu7ciFL4vQeWu
	 gBvfZIv387ODOq67x5FEFiykNMsg9+pVfajU+0TSihJemtYsDgFWOCNtnEjR1JYYPNSKH
	 cwxF68nFDcQEaU62U4rHUluY4l+E8ViloBBObb5QLaDRjK1sDiHj55t1MLpmtWI+3fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=pua8J2UW;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB12606A330
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 14:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB12606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=pua8J2UW
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so60960175e9.0
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 06:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704783; x=1796309583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TGfh22Ic+UUZqpUU8zmfI3BWZ3bedmz86wF+EG5USP4=;
        b=pua8J2UW2SaZdOacz6AlcAycR7hh/svS9ofaLn9PAwxeNj5N7HH8wfVEyNxf7c7FBF
         7AEDexG3i+qG1n7cwREX8lMMYRgINXyLbEDh79ZB3Zowc69OMA7dMF5ITl3Dk0EOzKEM
         0drcFnme9V6UxpV71Aw23ClrrQHcgyZ4Ay7gV0a8+rZFYY8adHaFb8BRegGvKYX4k0ns
         Or3Rh54qDTzUCsvzkWDjtJfoEmiMKJMJE6j5tF21zfbfC3KNBe5tmW3+raRGXcGy8JCd
         iq0z7yJyOtu97+kGQeIj4Bnyc6AaXshYEjNzCUNpm36Yp9gxqyFz7chhEymXnnm5r1b8
         +iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704783; x=1796309583;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGfh22Ic+UUZqpUU8zmfI3BWZ3bedmz86wF+EG5USP4=;
        b=LjmFv8JwZGIVxeadrauMpIBkNtGxseM5QhU1uYMqYZhCYBWVo9R7CD2hx3SeQlfMbK
         HvBCPh5mWQkzZie2eaK8MDPbpErUX1KI/Fq7H5N3SLRuOAAIFOZtPCpbkLVX624cJ/xD
         GrmBHCkDIU8UjOJYtbYefUhx9xabfuQb5YGkmaICo0qBETUxG87wX7wOApv7pZKxK1Oj
         UaowOI0rEmJ6jWyZZ75mmCwVpSH0QC6kbtRgVNKU9Fe6KybZ+yI0L3QSIA4cYVvs+8JU
         FyLYQdj6I1AE1P3WlTrw4MaFaRy/BSq/JzwpH0fR/4YkH+BHPEzPzETinDniOyCurux+
         FZHw==
X-Forwarded-Encrypted: i=1; AL+hErHRN0bA1u7z3628/FuGICi9kAYjw0nEmO1j8SgSYgOwbdF0xBHEsBeJcU1sMdEh40ltoI9oDbjqC6qjzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9GxQAu7ozdPHdQDqYhZwJnUh1+pjyiRi8b0myP/2+dLkzPND3r
	DwdDwCm/WZbJ/qN/zzEAnbVyfaRUI+GNAR1oYOD3RTIfHo+VRfFtmyyXoMUI8F47esQ=
X-Gm-Gg: AZFdTZdC/lDz3UmHr9OJ3WRAgPexM/qyLeovQnQ+OOB/qjU6blKkbqqKy0+Q1g5cTR3
	Ecd9H4PndzLVnoYWJQEkcSpzD5chw4dMj2uR7TBd6xnxrcXdqXHGrQsUiAeKq+6BTqE5Gyd/uBM
	lpwrUbHhb3DTPPJ4ZIT/iAO8KL4uSh+aIUcF/H1e3xJL+OCBE40ldh4kSainEqHM4RvBJeyAwo6
	ZxoLNj5CjxERJQalHc4gksrhwYVyqKOcWlk6aQGvJNpFj8f5h1nNaq0gMz5LnrH1qlkIrwGYypN
	nv4c+nXBfcDvqUUfh/br6yAgW0yyx9BtQczSRZBpSqP/VedKoDv3Hr6JbpqV2s5V8sgZdh4bOis
	ZhddDbIWg6zpObHHYFp+bw6wT89Arzn70+uRsgZby0T5k4Ww4XoIQ9p/KGG/J+RFOL+mOF6BES1
	itAsYuL1aGRhi4DVok6B9PFHZNuI/X1S4fHA4TTkzfNkwYASHG+71HQuP+gsM/z63R+0VdTCVIg
	R3hyZ57rQOlJdWhYaRKyek/1rQTegWNXuQWpdj7HHf/lQfRgNvP/MoSiGA/MhScbSK9YM8N7h+0
	Lfontpy2aFGeNZ7E15Cy4c8zzhMeWJQkKWkMMrE9QP9NRF58GQSSCjMcpHPMRKfKhjzQSmhMog=
	=
X-Received: by 2002:a05:600c:828e:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb88785a99mr406595745e9.0.1795704783242;
        Thu, 26 Nov 2026 06:53:03 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:02 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/4] drbd: assume a capable peer for the discard limit before the handshake
Date: Thu, 26 Nov 2026 15:52:54 +0100
Message-ID: <20261126145257.592085-2-christoph.boehmwalder@linbit.com>
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

Before the first handshake, agreed_features is 0, so
drbd_max_discard_sectors() limits discards to 4 MiB, the limit for
peers without WRITE_SAME support. Devices stacked on top of DRBD copy
that limit at setup and keep it, even after DRBD connects to a capable
peer and allows 128 MiB.

Assume a capable peer until a handshake has completed. If the
handshake finds an incapable peer, receive_sizes() lowers the limit
again before DRBD sends any request to that peer.

A discard that DRBD split at 128 MiB before the handshake, and that
DRBD submits to an incapable peer after it, exceeds the peer's limit.
The peer then drops the connection, and the resync after the reconnect
covers the range. A module parameter that rejects incapable peers
would avoid this, but adds a permanent interface for a rare case.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 3511a943e4b1..efa6e46326a2 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1257,8 +1257,11 @@ static unsigned int drbd_max_peer_bio_size(struct drbd_device *device)
 static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
 {
 	/* when we introduced REQ_WRITE_SAME support, we also bumped
-	 * our maximum supported batch bio size used for discards. */
-	if (connection->agreed_features & DRBD_FF_WSAME)
+	 * our maximum supported batch bio size used for discards.
+	 * Until a handshake completed, assume a capable peer.
+	 */
+	if (connection->agreed_pro_version < PRO_VERSION_MIN ||
+	    connection->agreed_features & DRBD_FF_WSAME)
 		return DRBD_MAX_BBIO_SECTORS;
 	/* before, with DRBD <= 8.4.6, we only allowed up to one AL_EXTENT_SIZE. */
 	return AL_EXTENT_SIZE >> 9;
-- 
2.56.0

