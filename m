Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271218;
	b=llDr8x6+6hdKoq3LiuCA7Ki061nZ3W2M6/SgRd2vdBDAK0tNj3Y8kXpG4Ew5kQqU+XgV
	 VbC65JEMjy9kZphMkCYZQesczf7DABPqJsOooC6lh5M/LoKS2Gzzc/Pxdc0fQlFGPKLGg
	 S2go2bYrFjw+xsDUiK5K1GuPVhO/APFnIQV1EvwDdcV2O3XGzxyhTyaAQinqNRgacbhfQ
	 MWYeNr+ViUpeslqbeYx3YKlcEzGrhgCWHPamMkTQhB8C7owhAqSNV22x3fkgMWeOsfg0w
	 Ft35oFt/iISIDwlqyJI5lpCoQSxPP6NwAPg0YBblZx/5wrl9WMVTMZ/nM0BPyvc9CVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G37MhI+O3tqGZVGitzVY1owvDCFJb+kDWkzQZJJlvL0=;
	b=TRB8hCSAIu7JTxIZE2uGeYyIcAygIgYc2WoNE7oHdZyxgsSMrQwJ2Y01XIPo36/kYXfi
	 fZ/r8x1Do2uJVpy/hr12a10IUcezZgX7QB1CxF8L0PM4op3Yccs0daHdPmFdJaZ4AuCPa
	 XIUOXI3hngMXt1kdMFWLlRiSIDZCRQhlHLbXRpNtoGoET3EobGC05koaMTKRAQZem95Q7
	 Q90gLsCdqChyrh3wson3+xdd8Ik0J4ykH4zHOPIQQ0YHSav7Q65Bo19yhOtPlXReHYSzH
	 PQM6ZFzPnzzmWF7I+WTIvb+8PS50ZftV/EXSRpOq5x0CZjqD7kIRo2TC2BFJtglF4jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sn4Aekgg;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F4606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sn4Aekgg
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-170135e43c7so1213741c88.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271217; x=1793876017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G37MhI+O3tqGZVGitzVY1owvDCFJb+kDWkzQZJJlvL0=;
        b=Sn4AekggiRiYWv+bhOGRf3jQL/YlHcseSe/uZChmuKKVlmFgi3vQ6JB9N/W9Sd/YCH
         SxDOlZ4rWMIlgXhshdaxyaNY4GcnInKqn82wucSv9zbH6SUEi4ZtdE2jw7w3aAsvQIi+
         Uj/Qwwq7o6fHzgj021wMFFXgjgFpdQYc3ikqhkBSapCq4BzU/S8B20YU0KL3J4icAZFh
         NMrtnTMT4FyoN1c+MsXuGlG82bImGzLHee1RHd52PvGvteKwMK1sn8rfmKnHl59gGtnz
         +9Gs40hxJ6rw/iLrRW2EKIBO2RpcS0mN0k/JmHL3LQgZWu1ilZimbSOHQUJWIsg/8IyL
         4MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271217; x=1793876017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G37MhI+O3tqGZVGitzVY1owvDCFJb+kDWkzQZJJlvL0=;
        b=H1jLDcijXqcrBiV2HjISDTa9i5Xhalpmusse1BP2LBbAmouhKMCSqSVs6cSeQDCAnP
         Kzfsho37IwA8cVOFrgpUjcEEC22G7/RJTXeOBDCvEPzhM0WhHOVdufX0mmXLZjPcBsxZ
         kmxU75WujfmE2xTYjoVgT54MbH/NDkinT28VHBJ0QVULLQzp/lcxshF6N9T0hlpf8Yrf
         Kee1x8Z8AzJlNX+r3ysWwe8tTYZNlLe6Hu+xCcBDsib8Xq3kwtsHUNsmFs5wFnmmQ7iN
         AuYuuOab744pByk9/MT99LPbHNy8Aci2HP3YdyGRwgvnmLgambMqaZjscTXwLZEA4j5Z
         crww==
X-Forwarded-Encrypted: i=1; AKwUvByZxCoLG1gF/6ChieDhziDHqfm/mkSvQZi6IiwDaUsqIBmhhQYiYhtxQkT9xsSFYVKSVRhm3iJpeO8vPQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKGCIqHK2LGRC/ZpROBxKyOmjYcOtvV1wm9t5xUmzekPekiaZr8
	gWJqCyOiZSY1+v8DFZKr/+tPsKVg/GF4CKPgF/qxWiifHQll/0xWqmI=
X-Gm-Gg: AYBFou2e6y5sSxLFFwWHWZr6moenmcEr7uPr4VymmfqX373rp9YUqz6sQv6wWwApr1Q
	Cbh2oQ2Fzo0zUlwoAnQ22IMhQUYY0/GiyxWV2JNuSXLDqV/P785Xe+eK3C1ScW35OgkQmkXV8Gy
	YX15PWUrsfJ2VQXj1d99rsVJ+C5O/tu7TVg239+Yvy89ja5uyPbpxwaw1sqN3GxrEAQdE8fX/Lx
	qeEcIIsrGzDzY5d9yR5H8I/is/iHiaV+E1PZVkhCLvHKhBjwm4zDCEzaFvfmy9kIPtC7qGTouBB
	a+YRUVDd6WYzJxEKzsZmpE0mf6kF66XmLdt3dWtt9DDuPDmI+y73bXusnx0aDSEnIW/+9uJaIAi
	2z7FObpJ4GfF+uks4yNNf0q3GYBBCryoo+0l2fQBdczf+3cH+5sn7TjpCR9+bm53suCuTYLNX4n
	CBy8VthoSqHR8OR4LTZlYMD2jjmsiiMwnT1iLlh1+D14bRtGvaZvvSrvI1mWltn31MQnYP4QYvI
	5e5Rz1aE4xtNFGVQSh0JAy7H8h2/h6w4bGRWi8fVTvAxQulsXtJ/h1WdK45e0MDxjMgKGlswKMh
	351FAM6hfduxGxK6ANjW4roOmrTSN3UtgVGY65OZ1wn2iB0RNUU6jd/bEm45V2t459m2HrqSdFX
	Zx+yYCE8xO+PoXMq3
X-Received: by 2002:a05:7022:fd04:b0:1a3:bfb6:44ad with SMTP id a92af1059eb24-1a6ce2ff120mr8561631c88.32.1793271217022;
        Thu, 29 Oct 2026 03:53:37 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:9f78:eb3b:17e1:f1b6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e5c6d4fsm24266063c88.14.2026.10.29.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:53:36 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	hch@lst.de
Cc: kbusch@kernel.org,
	linux-block@vger.kernel.org,
	anuj20.g@samsung.com
Subject: [PATCH] block: don't use the bvec fast path for dma-buf bios
Date: Thu, 29 Oct 2026 16:23:30 +0530
Message-ID: <20261029105330.1427462-1-anuj1072538@gmail.com>
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

From: Anuj Gupta <anuj20.g@samsung.com>

bio_may_need_split() reads bi_io_vec, which for dma-buf bios aliases
bi_dmabuf_map, and interprets the map as a bvec. Always run the full
split check for dma-buf bios.

Fixes: d88e44f43e93 ("block: introduce dma map backed bio type")
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 50abfd932886..27b568cedc43 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -404,6 +404,8 @@ static inline bool bio_may_need_split(struct bio *bio,
 
 	if (!bio->bi_io_vec)
 		return true;
+	if (op_is_dmabuf(bio->bi_opf))
+		return true;
 
 	bv = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_offset)
-- 
2.43.0

