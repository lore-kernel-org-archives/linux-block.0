Received: from mail-yx1-f103.google.com (mail-yx1-f103.google.com [74.125.224.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF62FF16F
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892953; cv=none; b=dNHjZHiutdmHRaBhuX3IQ3gU2eDOLQTb6psWRgv4r7SPCtUPgtpH84d+4yCMEZVXV1pEqTBrOtMgU1MU5/uWc17qfpM5ahKehOznqPyPuGZD/WOL1CgSnrPSvrvhh9GIV4icYc8AlLBYieJmtOg52Oqs7oy02NelUXCe/37Ha24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892953; c=relaxed/simple;
	bh=i4p29NAYQUFaC6TakPUiO6FyaXMSmwrUFhPBK4q5+XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOQozlqh5AcYOMGP3vgx9TZ3n4GtZ6cCzKwLDniXphKWdANNUqIfIR51/W77SG8BSeKWj6rHleyYTz9WIqVlPegZbH992Q3ae03yylBKZdaSwZO2ugpybIbkBabKu9sZfPBQFbzr3PNMGPR4kCyO6ZuxlrZopF/peVGNUMzxHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eVgl0rGd; arc=none smtp.client-ip=74.125.224.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eVgl0rGd"
Received: by mail-yx1-f103.google.com with SMTP id 956f58d0204a3-646d51949f9so519598d50.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767892951; x=1768497751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxex0w2xVdLJ5pj+6cE9HhLbWu2So1kRLspmYigE0yw=;
        b=eVgl0rGd9VsthzbNMoscq8+rAN8Q2gD0jdD9qqPPEJ8hFGXp5W4mq4biznrcLYUB3y
         ybjSuvg5Ce8RCb00M49kMoX+Ou+43XiEeH7CmzszZZkrnCUvZj/OqTgUf9TzGc4j+RFT
         M8gdtudPJj3AE+qLg8lDFpkOqKidvG9YU6H+RJKSt6NBWJlHQH+lqP0tjAx57UhKQ3qg
         c6zsPwPxqqMMWOub4EdTgDsWZVCJBkFxqnqJBK1jrhNctycVxjhG5xPj1EBaW2t5IuTe
         SAh3nzYmv1/hhQ5hB2Ds7m4mpQPOe2/IL7OO4CFKzLL5s8E0WK5Ebi4xamdPPJ77GXr7
         7QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892951; x=1768497751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxex0w2xVdLJ5pj+6cE9HhLbWu2So1kRLspmYigE0yw=;
        b=GTirjldkoezKtowi46WdTUfMJJ3HgTIJ4ifopjHpxQMFe0OLB0CLBkMCCvucA/gD39
         TKFMKUqL1ZEFnG9AmZi3rCQ6Aor4rwXdw4mlJKcapFyFKPRj83Nitp4sbImWo+RhOkpy
         dOnGOeNLV7twv27uU8HfLE63E+hsV1iMojqc1IryPvvxEIJCes/xwCu3rN4cHOFI6qih
         cDO2gtKlEbEIEAEScBkaPmWnC0bTTvi73LiyVBKuAfd+Ey8op6H1OMJMR31Nrz9InFyX
         FiJYizKhuvEJCEJH3V7iRIMaZxF4iQ7MoLl/BejCC5Sjv6KgFT5Yyi+AQX/oPkvHy+o3
         tyTg==
X-Gm-Message-State: AOJu0YyC3vWj7IrDQLzKeK9wOm7BnDjv1Qscq4GySMzXEYDyQElxBa+H
	cNPrORVE10z35yCri5cFBaJ3oUInHFK0HIX3jtGnVp50zVGbAI3ldmkY8zwX/C/9vQDdA97Yl/Q
	EZV/W8wQ53OIHw62MJEyiouBafiFLpGj8qfkAWGPWxJI0daKfn8wi
X-Gm-Gg: AY/fxX68+zmyQLI01vUaRsTXsIq8E6G2WbSH26ChvSj4dfWyEeG/uwj2WobIQ8iqscS
	cORfBBH0GAtthYQs037sMUTWQBR9iwGudEUCneKu8vtzD5lp/BPgjwnX+1g5KvLLRKPwLQSZl0n
	ukf/B5hg4UHdFLtgipQ7noZ4SVamiZsQk0MYShYnD8TcB7NDIcRWK433ei6vGhLA33BgrRHuajO
	v+ZYdlDzwBnUsdBgsV+qrH8v/Tz1w3S5W9w2xaY4r09Qw8c7CH0T9JYrQfMxliOuqOL1gf+J/cc
	6MQ2uRJ7cYXxGJWF1GpFW01bRRd6z4uesUPxfzur213+6ivOAwvTLrnoDbggg/8/hmmjArBMc/w
	o59MBi3D2ODDTI+43ggIwVB1+tTo=
X-Google-Smtp-Source: AGHT+IHT4rzoi1pIcJ2b2EbFL4SNsnV2Kx5sXAVunV6KAEhZUrhWimnE1b6DVrmZ22bjEufdrqkaea05RYU3
X-Received: by 2002:a05:690c:6608:b0:78f:c943:b2f3 with SMTP id 00721157ae682-790b568e27emr61630227b3.4.1767892951115;
        Thu, 08 Jan 2026 09:22:31 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa6a9f37sm6287247b3.17.2026.01.08.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:22:31 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2966A3406AA;
	Thu,  8 Jan 2026 10:22:30 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1E459E42165; Thu,  8 Jan 2026 10:22:30 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/3] block: replace gfp_t with bool in bio_integrity_prep()
Date: Thu,  8 Jan 2026 10:22:11 -0700
Message-ID: <20260108172212.1402119-3-csander@purestorage.com>
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

Since commit ec7f31b2a2d3 ("block: make bio auto-integrity deadlock
safe"), the gfp_t gfp variable in bio_integrity_prep() is no longer
passed to an allocation function. It's only used to compute the
zero_buffer argument to bio_integrity_alloc_buf(). So change the
variable to bool zero_buffer to simplify the code.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity-auto.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index cff025b06be1..605403b52c90 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -107,11 +107,11 @@ bool __bio_integrity_endio(struct bio *bio)
 bool bio_integrity_prep(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_data *bid;
 	bool set_flags = true;
-	gfp_t gfp = GFP_NOIO;
+	bool zero_buffer = false;
 
 	if (!bi)
 		return true;
 
 	if (!bio_sectors(bio))
@@ -137,13 +137,14 @@ bool bio_integrity_prep(struct bio *bio)
 		 */
 		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
 			if (bi_offload_capable(bi))
 				return true;
 			set_flags = false;
-			gfp |= __GFP_ZERO;
-		} else if (bi->metadata_size > bi->pi_tuple_size)
-			gfp |= __GFP_ZERO;
+			zero_buffer = true;
+		} else {
+			zero_buffer = bi->metadata_size > bi->pi_tuple_size;
+		}
 		break;
 	default:
 		return true;
 	}
 
@@ -152,11 +153,11 @@ bool bio_integrity_prep(struct bio *bio)
 
 	bid = mempool_alloc(&bid_pool, GFP_NOIO);
 	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
 	bid->bio = bio;
 	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
-	bio_integrity_alloc_buf(bio, gfp & __GFP_ZERO);
+	bio_integrity_alloc_buf(bio, zero_buffer);
 
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
 
 	if (set_flags) {
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
-- 
2.45.2

