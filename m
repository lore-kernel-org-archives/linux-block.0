Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB63B0582
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537060; cv=none; b=P0UVj7uy/UpfMr/kt66Q+k9aWHLug7eriocPVrf+jrip/zCwWDV+fiCO0OR1NG55NkVcNQ6m0lQR6OpdCVrUz0E8ylK8Y05AMK24xqEj/xD2TooEPIb12k4iiVcHJKjwoxkV/YP7eEKHSy+7x9/uAd4becWvfe5slpx49T7l3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537060; c=relaxed/simple;
	bh=inAX3pMQC/YXbe5iF5RfjOtOR4RaRYsQHML/jNQxEY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MAKFTUDU0z8AbmCsVeQByqi1C/d6rYts4hNbPE5A1HLGst1gb19LkcAbuznRjNhnfhXTIbF7iQ80RbL656hwmpXmCPXZgzbpJ85i2uY5PXB8J4idqHHbp4MTFtXwjc2aAzep4Klti0eOLn0hOcTTWf3vKjZr4j15AFzf3olziyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js06mTD3; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js06mTD3"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39ded0d7f52so1934918a91.0
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 22:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789537058; x=1790141858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ChxkeSFlEbvSOnTTbLD4S7oOWfz7/k8QbTvjMY/M5M=;
        b=js06mTD3tWPQqExwOHerKrRf1cGzAgbgpzfRMiJtvQkoF1wH1mRHHOeWynf1eO01DI
         XtmL0UZqW1a1D8N9bjY0nWYPQhhCRslpvszZ23Gjsi4MhfU/E9sfggN6GB6u43gYPF3m
         U9oc15jGwfANB2vrcNANGM22pCCGRyCi3hm2tn+6Sh7oX8iviXYIe+WqxM2wneuGAvAL
         PSlJ/blyGEj7k/UJpGaB7osrtmNIhzor5+4wSfNeEruhtD3dKV6PBUrGba+OQhasYhwN
         mdAKOHflBdO4HIJUjAwkqjXWkT6BLVTPJGlTd4CuuDYiMwyx+j3wL7GmXFfjrS60GX3v
         tLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789537058; x=1790141858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1ChxkeSFlEbvSOnTTbLD4S7oOWfz7/k8QbTvjMY/M5M=;
        b=pxvO90rythSK2GDgWCgQ2RsHsGHPrT+ZMkvOVL2xyF1q7rV/ylCw4HM3GMuZBb7jmy
         bU3HqqiB2suRb1aY80oGNgR+94kmLzXGpxW11xeggHBFYayBJ4Qm25F1RN2Uflb2uyPZ
         f0KycdElJkr9iaxeDrjYIW0hJdfGI5E4JQFu44qr2LhynLeMD6d3uYQ/vdAlXlqMfBDW
         YsdcwJ/OaTExCAu0YxaJFpDRrQk3tVJNz9c0DR9qEv1f0RqgETpqEa65LuP0gCKaQ89i
         yOh0JvfT2D14iYWMn81sF8qljOO9Z5nCXNMVi10gnu6GZzCU6VIABowliNvasgxOhD/2
         vXiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxinj1B882nuqa+WdAhStT30ldrSYiRJXnFSYyDdba5k1D3MrVPJrXUyX3Glwdkt6G4P9LJt2CNmxKoTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ls/4b1wMHxkA3E5dk7tGTB/WUbGy6vzvO9n6l5zb0y9JesYrOn
	6hUH6ps/i94wg7z/qmaUWyg62RC9f4rSLQAOFYsD4W2VE8To4PLIjXmjZF3DUX9OFcNbtlwaaVk
	=
X-Gm-Gg: AYBFou0dN5d/oEbAkQcRUCwMn6asiLyKUY0gSn5y/l7rlblrYadrxAm3H0Zt/EjT7rJ
	CTMpDJyQlvTbXl/elA+yqi3YjZO18pT9uPxQXYgU28PiPPEfc4hNHMS35B/9fGlsPANkgQ9TpfX
	iy4DqeumkMCTH0WetcU+9K9mWGhKVZIayWnSIQn8i6qlcES8G8VczLFc+gnDSsfaJuJrSTR2bz3
	a0RT9FvjM07TYf+FU8a1tI1CLR+hX58VTktZDCMDkRigBzKwtpBYOZUS+vWBEaYoFCcKPMt1awF
	srBVRmZnewYGdWQiN0Kp67uTtlWUmJWFh9asJ/xFIPAZfB5dswDKdzsIMrF5VLSVAhYzorGiKgy
	dJPpzQ0QItcKzk7DB78ZlN6xX8LYPC7+REU57PfBOBsgMKReNOUtWg9Fu51H32Ofgemna6j1pt/
	ISeOT/UXF9TYx5E2ve9A++ikpesxdjAx1M9Ql7WV2Pwyy3PWP7gg2o0hWR48sfARTUsRbWx/Cq1
	MmwOw==
X-Received: by 2002:a17:90b:5803:b0:39e:1329:7816 with SMTP id 98e67ed59e1d1-39e1e484be6mr3114448a91.15.1789537057735;
        Tue, 15 Sep 2026 22:37:37 -0700 (PDT)
Received: from MS-A2.. ([38.103.200.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbe3e62sm2474919a91.10.2026.09.15.22.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:37:37 -0700 (PDT)
From: Li Ruijian <li.richking@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: drop stale @op kernel-doc from bio_copy_kern
Date: Wed, 16 Sep 2026 13:37:27 +0800
Message-ID: <20260916053727.340679-1-li.richking@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bio_copy_kern() no longer takes an explicit operation argument; the
opcode is taken from the request. Remove the leftover @op field so
W=1 kernel-doc stops reporting an excess function parameter.

Signed-off-by: Li Ruijian <li.richking@gmail.com>
---
 block/blk-map.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62..35212355b8cd 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -356,7 +356,6 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	@rq: request to fill
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
- *	@op: bio/request operation
  *	@gfp_mask: allocation flags for bio and page allocation
  *
  *	copy the kernel address into a bio suitable for io to a block
-- 
2.43.0

