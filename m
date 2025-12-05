Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA4330B3F
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938870; cv=none; b=WiZRQcwK2/L009hhWD5rn09oe8xiP5o9BaoWzzCufwoeTytcQThASndLkyG8qV9zyiNJzVgufnDJJbzHPsbnTRjMPk96q1k18isTWvlmyn0B/izkxrleIOT9z9JivIwB1cAII8CaD5Hy6ATT1X9RYw6JplXUyzyZWhHddYpWIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938870; c=relaxed/simple;
	bh=i8YDnYf1ilzWlANhGaVJQ6tB9sXTRdGLnM7KngzGd6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mha+4FSgu/JVbVcPz8eebfdHFN4IQgjBsVNAJ4sU9hyc86EJyNIMCNOaieDGgt9DLrf9dig+LMediO1OEnoCv9F2BYgX1yYXRDV0LvHfVuWuLAeXjHlk6lYGp6ilWx/ZfnvIdkCKsIDm6CwnAulZJaXG8biRceVIxI78Vb3hyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bKglotLG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bKglotLG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2e40582eso1194852f8f.1
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764938859; x=1765543659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf42qGwyUhFPZSXy4l4ySs4hW6+uyHiw4UyEQszC7j0=;
        b=bKglotLGoTCM4TnJUobcFjQ3INqyCCyKrSQ2EOtCpY2TbGbOQyfCXZX7jYMAvBnvT6
         qrISNgehSzQZGgitQEteDJ/jbuFvwnIh1q/olb8bKlsO0vmtKUon/sccFxCTrw5scPwz
         SJCzStHHmsxpAlmvK6XcaY16azKjeyAIwa9e5u4ri9DhjeHuW3z7GWSpXee3eGIYq7pJ
         Hw4ywlvC4oMIL1nvzdFo8KnoZb97U1RAgSNdL7Ky0Q69MpFXGr7jdFNltKqiOnPvw9df
         9QA7DOANxKncXaXtv73c45zLy6twl+4o/71ADghzLppCHpQJpg+NyB0f6REqIhq7Hjvm
         ToHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938859; x=1765543659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pf42qGwyUhFPZSXy4l4ySs4hW6+uyHiw4UyEQszC7j0=;
        b=ThAGjWuxU7oqzZGhHUJ2tGYgzy3bSjdARegBunNN5iSXOkZ2D3obIy5G5sZoyl5PTc
         n6SXxX2KWQiZGwJ/EiZupDjDWrLTEe/0vweigHknwaQ1w4OkFRbBTjFR6WAqOdOkbEE5
         kV37Vp1p+M9TjrCJ4o+SMjtCz/etY+RxGHnoLdpbFzLxs3MLJNn5UM8WXFSaY1if+CQ8
         5PdhtyQLs0XosHGflprjkMQJABtQk3RAZBEXZIlWYoEmBK0oIohmIEHgJJiWAfh9+vEb
         rA+waHOyYwCzpPYafODPldpDOH1c+br/LCsVTJylQNMbSxM3LPjgpHSOKyqlkk14/2li
         Yeow==
X-Gm-Message-State: AOJu0YyQG2s/gNW8f0c9ip0w3QSPvc5ndPJo0Hxcmyq7YEIpb/fsZcsI
	A1+lXeUFVnYfcknCUTrOKbyi2ZjboNfqDJVALZ5tMzIAnW/hTLHQV/j96joVevFtbKA5ivuoA/Z
	wwabi
X-Gm-Gg: ASbGncu8B/nKUGJzn4HevvwF0xiIu+lfERDF4TxZ1uzru3uhB4wJM/2utQVCGCxxJn+
	oWSYHw4XM2/Bgq2qG/yr6I4CWAkZV9mhhdj3+bMtABa1sWFFXL/Gc8CBNMNqyHCsD0qp/96Mqqz
	Gq172WIOxwSlXuBu4MbhWcgvRWYsnx4Fxs45lZp/eeBEVmpG/dsUS91qUVGo46m3ZICcY6wZhrC
	65u86lpkZYGPvvmS2HGNfGRBXnW40aK0o5UwILeQMEQS7fX1pD4NuZlvg44X4VVxLeRBUq4QYhy
	6MpfN2QzOobZtwDuhmWmxcKOSrUtg9HkvkvH75Prg/Vd9Y18FTVGEwn5gRgatzoFgTO9AM2Dhvt
	O/hNs7Kw4lUoSS+EVIMO+j65ULB0zzlGLwvuAy1YKiSgx0ex5O1tvcovBCh4g3G+FlsQ70bQqkG
	TSuQWiiQbxw9rQYM6DEB6sT0KY5Ei333vYrNqGB13iozjkXDvLEtDsOj8YJ9Q4fyTwfH4H/ZCx6
	sdMvsW6tr3Ycw==
X-Google-Smtp-Source: AGHT+IF8UPe0gsxsFhaPg7ML4AN1cPhRCyzWXdjzOd1BA9nJaFtk5AORVDCL6YaYom6MBpIwrJW1Iw==
X-Received: by 2002:a05:6000:22c2:b0:42f:7686:5697 with SMTP id ffacd0b85a97d-42f79851e0bmr6928468f8f.42.1764938858865;
        Fri, 05 Dec 2025 04:47:38 -0800 (PST)
Received: from lb03189.speedport.ip (p200300f00f28af70a31ee45bb042915f.dip0.t-ipconnect.de. [2003:f0:f28:af70:a31e:e45b:b042:915f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm8540037f8f.11.2025.12.05.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:47:38 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>
Subject: [PATCH 1/6] block/rnbd-proto: Handle PREFLUSH flag properly for IOs
Date: Fri,  5 Dec 2025 13:47:28 +0100
Message-ID: <20251205124733.26358-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RNBD client, for a WRITE request of size 0, with only the REQ_PREFLUSH
bit set, while converting from bio_opf to rnbd_opf, we do REQ_OP_WRITE to
RNBD_OP_WRITE, and then check if the rq is flush through function
op_is_flush. That function checks both REQ_PREFLUSH and REQ_FUA flag, and
if any of them is set, the RNBD_F_FUA is set.
On the RNBD server side, while converting the RNBD flags to req flags, if
the RNBD_F_FUA flag is set, we just set the REQ_FUA flag. This means we
have lost the PREFLUSH flag, and added the REQ_FUA flag in its place.

This commits adds a new RNBD_F_PREFLUSH flag, and also adds separate
handling for REQ_PREFLUSH flag. On the server side, if the RNBD_F_PREFLUSH
is present, the REQ_PREFLUSH is added to the bio.

Since it is a change in the wire protocol, bump the minor version of
protocol.
The change is backwards compatible, and does not change the functionality
if either the client or the server is running older/newer versions.
If the client side is running the older version, both REQ_PREFLUSH and
REQ_FUA is converted to RNBD_F_FUA. The server running newer one would
still add only the REQ_FUA flag which is what happens when both client and
server is running the older version.
If the client side is running the newer version, just like before a
RNBD_F_FUA is added, but now a RNBD_F_PREFLUSH is also added to the
rnbd_opf. In case the server is running the older version the
RNBD_F_PREFLUSH is ignored, and only the RNBD_F_FUA is processed.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/block/rnbd/rnbd-proto.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index 77360c2a6069..5e74ae86169b 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -18,7 +18,7 @@
 #include <rdma/ib.h>
 
 #define RNBD_PROTO_VER_MAJOR 2
-#define RNBD_PROTO_VER_MINOR 0
+#define RNBD_PROTO_VER_MINOR 1
 
 /* The default port number the RTRS server is listening on. */
 #define RTRS_PORT 1234
@@ -197,6 +197,7 @@ struct rnbd_msg_io {
  *
  * @RNBD_F_SYNC:	     request is sync (sync write or read)
  * @RNBD_F_FUA:             forced unit access
+ * @RNBD_F_PREFLUSH:	    request for cache flush
  */
 enum rnbd_io_flags {
 
@@ -211,6 +212,7 @@ enum rnbd_io_flags {
 	/* Flags */
 	RNBD_F_SYNC  = 1<<(RNBD_OP_BITS + 0),
 	RNBD_F_FUA   = 1<<(RNBD_OP_BITS + 1),
+	RNBD_F_PREFLUSH = 1<<(RNBD_OP_BITS + 2)
 };
 
 static inline u32 rnbd_op(u32 flags)
@@ -258,6 +260,9 @@ static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 	if (rnbd_opf & RNBD_F_FUA)
 		bio_opf |= REQ_FUA;
 
+	if (rnbd_opf & RNBD_F_PREFLUSH)
+		bio_opf |= REQ_PREFLUSH;
+
 	return bio_opf;
 }
 
@@ -297,6 +302,9 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 	if (op_is_flush(rq->cmd_flags))
 		rnbd_opf |= RNBD_F_FUA;
 
+	if (rq->cmd_flags & REQ_PREFLUSH)
+		rnbd_opf |= RNBD_F_PREFLUSH;
+
 	return rnbd_opf;
 }
 
-- 
2.43.0

