Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3652FE05D
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892954; cv=none; b=G58lGkS+raem+EWXw9+Z3ph6xEvCY5RuyUfgKROqVACPXOVXAVck12RIuvyuOPwka6izMo2E9FhL9xRL87hKDIVOpYq6GPVuAyBcHf6iBqL6mThQD5+uk9xu72yUi/yQKwRZo0vLTUnTQ8qlC2IIblLzevT9TNQK3E496HHviYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892954; c=relaxed/simple;
	bh=uSp6bgEKbOC3tTzvHqcKfBiWs/omsHUdUObr3QB3yFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMVt1F0glSRvCN+F/J2m82V5kBxTOakc86BNLCh7XGIswjkKshBlCalFIW49swiWNQW+3P/O74nmem+vaD/shDmcwUrwGKQmtZCMhPgz1GEvvHENkhF1PrgRqPpCmRmckkAmEhmUG5anwjJmjaVCfvAB5rz+u9qlqWQQmNQBWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Mstndcqe; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Mstndcqe"
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2b175c4bb64so206316eec.2
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767892951; x=1768497751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGTTq8K3vQ+V+uQpl8CqSqa2h/Tj/HL+yYnwJhFFpIE=;
        b=Mstndcqe7JoWjeRacZGw3DMPhZ5pFIhSg9eTj7v7gVu27+aLfux6wLaBUzpBrE1Ep5
         EbufN0R52mYWR4KaBtL4SJM4TumoWCCB+oUYf5NsUsq2lYLrzmk1qW1xL3qNDZ5mBjMy
         sM0kc7tZg2L29F0VIS62J/PyGivNzdyjA2ndDaiEZoInUpceHkPTikyJ99e7E9ojGnu3
         bgx12avOsoed5Qg7NqZrkY84YRD0V5cJFTnjZ0mUohv1hKpKJerSi0wdNFsKmBGp+b1N
         6P1YXGS4+J8NZgv1REP0UxIaN4qQCk59entYshzbp3zJDfud+Rolm3dZ/ZtgL+/4pd3R
         m6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892951; x=1768497751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGTTq8K3vQ+V+uQpl8CqSqa2h/Tj/HL+yYnwJhFFpIE=;
        b=R6o0YonOQzWKkXiJTY1x/dbQWgp3z7P/y7eC7aSJE/5Am8fE0RTxW4URFRvGn/K50D
         3MrJZi/Pah2J8vkYc2gG92DwMT2bgB3zRDWjsYD90fSHjDWBhEQsdX9gtUS6/GpyvFpN
         156oqrsryvxCAkIAiiBs1SLExZNzOrsvwsnWK29SuFOawH+nscoBVOzV01qe62RSebaz
         5zOHE6q4ksFkIlYGH2gJ19RkX1EWyaKaoTs/JL1+TONF7RtAHou6psRYdQr4MzXJXcH8
         QzNyY8DI3t2B75xxnHahUETgde09RwOF27IFwIigW/qE2BqU/ho+58tGlD0vcY8neOIe
         kyow==
X-Gm-Message-State: AOJu0Yxno7qqsLIgrQbOPgzGDjl7PilLeAVBuf9X3KFXuEeh33T1Lkh9
	odmN+EOCe4uZ2tkpcsbjR9bFMu3SxQU9/cu5OdAmu3iirlqrJNCvnPYCwcigi2AjubG9e76fK1D
	JX8bovEklvDpN6e2jELcyxOp7qda6RBAN/tcbyNLOl8dMVSoECd1W
X-Gm-Gg: AY/fxX71/Jwx3mapPztJxeRmLvg8PemWpOcEn0VA7iRM2N9POXz2R8tsedsn+865Qkz
	PDZePGu4GqON9PZXDqRcDnmXK8mWoq7X1bSxKE56aVYrgyTjf8zxftH5ZhLeP2j5HVBPV23EY4/
	xV1rJcM4aSRJ/ipwxXmibwRy8gQgGT7fWv0PAaKmJzP+Ht6dAoFTnCkMU9s3m5/VCgcaVmI0Pbx
	VgfSbnaEVW5Nzt8sitlZWSpW8U7RW92bLdGN5tzyoDxN0cgHVvOxvY1DdPdmc//4CxZ7tc+xmj4
	As4bb51ZgYuGxYTI5CvDXms62gKSgzkMTO3xCrBhLah5JEbsSze/sfWWyNtDhlM0Xze555C0+sW
	oZGMpf6k21PO55FN0q1IQezKKZ/Q=
X-Google-Smtp-Source: AGHT+IFJWaVqXL8QZVhWAMzKEfobRXwlVmAyoGeEH2E3UTRcXBRpGCtErafdB8C1hiJLzqQPDnJzA1hizh0L
X-Received: by 2002:a05:7022:2483:b0:122:33e:6ec1 with SMTP id a92af1059eb24-122033e706emr617564c88.0.1767892950828;
        Thu, 08 Jan 2026 09:22:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f23c0e38sm1872968c88.0.2026.01.08.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:22:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5BE58340794;
	Thu,  8 Jan 2026 10:22:30 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 51786E42165; Thu,  8 Jan 2026 10:22:30 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/3] block: use pi_tuple_size in bi_offload_capable()
Date: Thu,  8 Jan 2026 10:22:12 -0700
Message-ID: <20260108172212.1402119-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108172212.1402119-1-csander@purestorage.com>
References: <20260108172212.1402119-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bi_offload_capable() returns whether a block device's metadata size
matches its PI tuple size. Use pi_tuple_size instead of switching on
csum_type. This makes the code considerably simpler and less branchy.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity-auto.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 605403b52c90..626bbe17eb23 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -50,23 +50,11 @@ static bool bip_should_check(struct bio_integrity_payload *bip)
 	return bip->bip_flags & BIP_CHECK_FLAGS;
 }
 
 static bool bi_offload_capable(struct blk_integrity *bi)
 {
-	switch (bi->csum_type) {
-	case BLK_INTEGRITY_CSUM_CRC64:
-		return bi->metadata_size == sizeof(struct crc64_pi_tuple);
-	case BLK_INTEGRITY_CSUM_CRC:
-	case BLK_INTEGRITY_CSUM_IP:
-		return bi->metadata_size == sizeof(struct t10_pi_tuple);
-	default:
-		pr_warn_once("%s: unknown integrity checksum type:%d\n",
-			__func__, bi->csum_type);
-		fallthrough;
-	case BLK_INTEGRITY_CSUM_NONE:
-		return false;
-	}
+	return bi->metadata_size == bi->pi_tuple_size;
 }
 
 /**
  * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
-- 
2.45.2

