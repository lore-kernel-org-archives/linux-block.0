Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82247A0C7
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789213857; cv=none; b=Sa0xMED9Bd6pYT4EPmt78ulpc4yYoxWyucGTHyc7x1xItIPJVNeIy9ULc7Lc5wDK0IeJEe/nyT8V2NKhd/JHUWfJCTnp5dm7DUgMYBf5zhRW5hrCjQvvGqsRstPf6kOvb77WLuz60LoG6kMs5SoPBY/bzroaLtMOozEm3nUqRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789213857; c=relaxed/simple;
	bh=kxErrs4roEhSSClOtlghiIpbOslE858jVpMTxuu3av8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cTUo+R310WelyBEuUIU8B3V28GRrA7JpJ/Di2rtyfTRpUH3EKOt4EUFr80jxvEVE76mZCCKj3m3/QypGOy0AgmWqVQGiJg85Wx3V47FOEPPkXX1pUSdFGL8BWYY7iR1hXKhYPdTy7Y2RbdXitYkAJG1tXzCwppy2rQ/eTZRKRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLzukZBG; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLzukZBG"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so1473895e9.1
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789213853; x=1789818653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mrSSAaN9bpeL0MXOAeJWNyQt5RT1xqA1WET8iXWLSAU=;
        b=XLzukZBG2Ki52eUxDGMvoZenD5X246Jv6M5HwyG/gnY6xoJVLUXyVXzIzp00QBRxZh
         mgOFfcQajei5OZySYwhVHiT4ogvtEZ1gmkjZzn/s6VBIypULuuZfPcfV1fltcrE2yqOe
         0iirDiQFJNAcotSTKujGJFiHKHuCqb86q8ofpNh6pMKdH9jjFRf7zm0iMHsNm6WClk+o
         HXBPErhYfmQPD3W3EXE83ILy3y24SWC/Qvsg26sJOyD1pW3+ht2iogu3Jb0adKtEhQl/
         TFZLudPFSiFbCU+kBh/O5L8G0Tt7RDqHDaT8efuzkXmeCh4rtlHvIgBeJPdz2VQUFjgJ
         H/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789213853; x=1789818653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrSSAaN9bpeL0MXOAeJWNyQt5RT1xqA1WET8iXWLSAU=;
        b=EAP4PDFn58KR/upzLVMapVwrI5+sB59lUnToCg1WlSkZ432chRP3xSbSv8R3Qn8osE
         sj/ywigNUshAlFZsQD0w4Lc3DFaHhUVhuCPEJGFUJ+d+TSOhDS3SrGlGSpOX9ofLnHGF
         iInNI5aGTEaP+meGydO91Fjt+Sz05D9vAvbwEzc+PtJBW7JhVNymBVjLRdgj0ifNtgk2
         vfDrKZaF81Trm8YGGVJepscgSzYF5rwxdWw11eLjsX0eOwbCSfHPilREc84Dr0b9Tb4S
         Rv0DNsDVqaM1t7YCVIxfmceIqROmZSmIHqRpAGRVKW34uDVnywFMC5WF0pFRoPXnuYNe
         5YgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqIHM8q3VvIWlewcQDCyF6rWnjmphhsgtsDuOnIydFKFSdKMKTcoFqlEin3IZHw5Lgd65sAuHp8wIRIA==@vger.kernel.org
X-Gm-Message-State: AFuF++lQu5tpQ9nVjsTfvWkvoUraaXJrmeDEBQyvZPBWk5XnYw283gRb
	Bqcni+8VCeG7pgefAzEIXcHbagfiitOe3mAOPsX4LTicXqe6WA2xwHZoQH/EqrB4
X-Gm-Gg: AYBFou1tGWl57VemH+ausMGPAPUcUD9XgFclwk9NrG9vur+QFe0wK2U1hbA28U2bgy4
	SolAy6Rkc4KH1/hokCL7IT8hz7t60BFcOz8qzTpRclhUW8wk644SHd818eR4/DWVGTEjkZWboZW
	vvIh3oVf0YeAiOYmyyY1j3i7G2WRo0p73j5midT6wbmjbwK2tH8Oqslhx6u/UUyjiHsIP7dqK9t
	/iHA7bPp8gnxq3kxdkqymaqujdkm/6GCV2n+a4I1jPZOeOju5Az7Ho5mUOCCM5SQ9cwp/eiF85C
	lnxx5cXs/w5l4ErExl2m10rPMZN4/k7tur6HT4AVho0djZA8QiN2Fa6pQJ7/Op+CxOY6U/FQblG
	FNLycSLfbCJ67K/cmV0L3+ip9rLyGM0UYIDu/2yUWfYwyADpoQIXCW1oqlTOwiOHDrXL7WmjHz3
	ThyXH8lJsNiXiGuyQLqvB98+mTyQpQnSRy+6vx5LX4LqsSat/Jm86h6eFqmQM3Dhepg9bdkWoUo
	nRuJMXwmh8KdeMvdm26pZ3JdpLOgcwAUPppQxBshztLOsi6s13AzETzVs12x+wAi7Tw4B7VNdeI
	ER2HjRNpqm85FSDNdawtbspe9ix7Qu638rcBUTsXdufGai6vF1W0gQXr/AJoQM8HN6iODpFRX9g
	TEcAafcM=
X-Received: by 2002:a05:600c:6219:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49e6caacf0dmr19258345e9.3.1789213852624;
        Sat, 12 Sep 2026 04:50:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2985dsm400640565e9.6.2026.09.12.04.50.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 04:50:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-block@vger.kernel.org,
	Satya Tangirala <satyat@google.com>
Subject: [PATCH v2] blk-crypto: Fix the num_prealloc_fallback_crypt_ctxs parameter description
Date: Sat, 12 Sep 2026 13:50:50 +0200
Message-Id: <20260912115050.89055-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parameter is num_prealloc_fallback_crypt_ctxs, but its
MODULE_PARM_DESC() uses num_prealloc_crypt_fallback_ctxs.

BLK_INLINE_ENCRYPTION_FALLBACK is a bool, so this code is built in when
enabled. Its parameter metadata is recorded in modules.builtin.modinfo,
where the parm and parmtype entries currently refer to different names.

Use the actual parameter name in MODULE_PARM_DESC() so the description
matches the type entry.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Correct the changelog to describe built-in metadata in
  modules.builtin.modinfo. The patch itself is unchanged.

v1: https://lore.kernel.org/r/20260906165952.2344-1-kmehltretter@gmail.com/

 block/blk-crypto-fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 2a8f40a65158..877934db18ef 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -34,7 +34,7 @@ MODULE_PARM_DESC(num_keyslots,
 
 static unsigned int num_prealloc_fallback_crypt_ctxs = 128;
 module_param(num_prealloc_fallback_crypt_ctxs, uint, 0);
-MODULE_PARM_DESC(num_prealloc_crypt_fallback_ctxs,
+MODULE_PARM_DESC(num_prealloc_fallback_crypt_ctxs,
 		 "Number of preallocated bio fallback crypto contexts for blk-crypto to use during crypto API fallback");
 
 struct bio_fallback_crypt_ctx {

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.39.5 (Apple Git-154)

