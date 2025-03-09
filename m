Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA1149C7B
	for <linux-block@vger.kernel.org>; Sun,  9 Mar 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536409; cv=none; b=UhohHffm998d/xRuBkv4azfaXWixQH0VOpTAbO1ra+AP+LrdBlLcJHN57q7YlSdmBMgqVaClPyePgwDV3N++6m5Ptk4BZ4gk6CxkEfHd+5i7CzGkZjcV46Wk7v9fi3Osjuxz/YmM0Quh8iEW9k61bF1Zci7ZQRsN/DnQc4lNFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536409; c=relaxed/simple;
	bh=C6n0CFJ9NSrvUfJnwqjaR9BSECnfLoUe8aERN+3IzuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8sWjULJX7O5qkr9tFbPmTaWCfJei8sAxwHnK/kSpDMSZX9vcPtsij7ULkGYNT8LvSAzlgSG/AZ4rrI7IDhMiIVm3VVXED05ZVyxSfprgPkobHUVve0k2fh8OnKn4o2ZvVLrSnVFPJuQSHK1lsu5zOx9DkYL+kfE2/OAcuiPxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA7EzOwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA7EzOwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD21C4CEE3;
	Sun,  9 Mar 2025 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741536409;
	bh=C6n0CFJ9NSrvUfJnwqjaR9BSECnfLoUe8aERN+3IzuE=;
	h=From:To:Cc:Subject:Date:From;
	b=YA7EzOwZ/FQfWToNKstzdNDuU6IplPDJiAi0WmfjMFGlcHu2PlV7vTkiuOotunnaV
	 5OpbFR02l2HHRjya09VulgZ1uz+tWiBKfxUrhSJSePcXDP0pGVG/+GVsnDBvJqKDEB
	 BDPgGRO+vD69x32gpu6vGgz9CFDBbVIJuEikvyYgesukicDFeWgU1pbyCYGwbGxi3C
	 krnMszZzLSwZf7GJMTuhbgwfpNLAkfoj5zRPIVz2g70RqyIUPt8BFYP4RYPFDeZ864
	 LlVT795UsocxeTzHdLe5sorl2U0et2AWKb+iob1gwgvHEsrVk6pG3u2Vw8czNrMhw6
	 6OOHLQgjpsN4w==
From: colyli@kernel.org
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Coly Li <colyli@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks whether a u64 variable < 0
Date: Sun,  9 Mar 2025 12:05:56 -0400
Message-ID: <20250309160556.42854-1-colyli@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Coly Li <colyli@kernel.org>

In _badblocks_check(), there are lines of code like this,
1246         sectors -= len;
[snipped]
1251         WARN_ON(sectors < 0);

The WARN_ON() at line 1257 doesn't make sense because sectors is
unsigned long long type and never to be <0.

Fix it by checking directly checking whether sectors is less than len.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Coly Li <colyli@kernel.org>
---
 block/badblocks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 673ef068423a..ece64e76fe8f 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1242,14 +1242,15 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 	len = sectors;
 
 update_sectors:
+	/* This situation should never happen */
+	WARN_ON(sectors < len);
+
 	s += len;
 	sectors -= len;
 
 	if (sectors > 0)
 		goto re_check;
 
-	WARN_ON(sectors < 0);
-
 	if (unacked_badblocks > 0)
 		rv = -1;
 	else if (acked_badblocks > 0)
-- 
2.47.2

