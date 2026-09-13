Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BB37F00F;
	Sun, 13 Sep 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320369; cv=none; b=t3Hb1yTcANUksPilJKW82/0NPvarFAPPKIjXvSwtvL5JOREtI00tcLN2s0l0R0NQBnmkhVSVGAztyshuKobgwgj00vsRe/DdiQCmlmtkLR2aU/aERjberA1w6sc1pLvE2LKXKax9KCVAyojZcoEKI16qSl3G9wiwiwlKLko8b0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320369; c=relaxed/simple;
	bh=gD1DuDAsBeNpTM/I46LDqshtoMqovpUYCYdE0iS1zus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1O7iLfQJzi0LzrOUGxIU7l/O/lP550qmZXGN/AeEHNrJKMOKml2466fYfmewSDKvHTYyG6BHXgccWyJL0guZzXdQ5kDpaXwvvokxRoCdtadkwD6gjHfOykn8BFn6TsB9JInbFFmkd/KW5LlguXWDFe7IjL7yeHBBjUTqLAN0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Xq7TJglE; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=MDp0Ni/s; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Xq7TJglE";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="MDp0Ni/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789320363; bh=gD1DuDAsBeNpTM/I46LDqshtoMqovpUYCYdE0iS1zus=;
	h=From:To:Cc:Subject:Date:From;
	b=Xq7TJglED36Gh2r3nL01l+I5tyZ5gq0hxAcGUmU0WiXsTw3KSAqJUC5wFWyBd2ZIz
	 rIrpG6rf7GJaf34s1+YAlx5yXNuO37MX7m5QnSVxdKRUvfhmYOuYHpTDPUuzob+tRX
	 1Gx0vm+XyKUr/v7+b0gEsumdipcyeSDq/kxbuq5w4HIZnjkNZR9s88QVF4BODhf+Sv
	 kMD9ZGVqhPr5zez6Y24E5Ay7jt2v66NOZdcJl0zWkrz3ELsq4t92KJtHXREhDAB3M7
	 c1q9bkehDSKAYGVvoBgtgk1pq/KD+7D1w45XNCohHnXnJzB10C/+pZYKry5tvgDVRX
	 Ck+ZrrDwf2UbQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 66B5740B72; Sun, 13 Sep 2026 18:26:03 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789320362; bh=gD1DuDAsBeNpTM/I46LDqshtoMqovpUYCYdE0iS1zus=;
	h=From:To:Cc:Subject:Date:From;
	b=MDp0Ni/sx3tOJkjSwUFjPGtumMKhcxloZqhLerTSILp30ZLpSWSIR8cEarrosCJG3
	 ohCWL7kuFMyhqDqME/+Wfm4DPhsJFNirpPlVS1tCCK4PO1sf9+Ns5eDXSZmR0tKZPs
	 RV1+9qKr4EILVKcNnlo/o829rBXEza28WSdXCD18H779JrhWKdJgH8zaqde0PvWgD+
	 W+1eXoe/QNeSEdSceFDF8wrc0w3L41YsU+XI3IXQuGKeUDHxyNCEcBx8/GDTltCYls
	 uHnH5EXwSwmY6/8b85dr9o9i6+bWdFZjJv4H8tuI+SRYaBvIDRCzHvyHaGw3boyUQs
	 bFKOK1WPwqRKA==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 7AA0B409E0;
	Sun, 13 Sep 2026 18:26:02 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Sean Young <sean@mess.org>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: badblocks: Remove excess comparisons of p[hi - 1]
Date: Sun, 13 Sep 2026 18:25:55 +0100
Message-ID: <20260913172557.62857-1-sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binary search in prev_badblocks() is correct, but it is doing
excessive comparisons. Once p[hi - 1] is compared we do not have to
compare it again.

Also remove the if after the loop since the condition is always true;
s is always greater or equal too p[lo]; on function entry, if p[lo]) > s
is true we exit early, and then lo is set to mid if p[mid] < s.

The first issue was found with an LLM, the second on code inspection.

Signed-off-by: Sean Young <sean@mess.org>
---
 block/badblocks.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8f..143b488b7fe6 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -496,14 +496,14 @@ static int prev_badblocks(struct badblocks *bb, struct badblocks_context *bad,
 	}
 
 	lo = 0;
-	hi = bb->count;
+	hi = bb->count - 1;
 	p = bb->page;
 
 	/* The following bisect search might be unnecessary */
 	if (BB_OFFSET(p[lo]) > s)
 		return -1;
-	if (BB_OFFSET(p[hi - 1]) <= s)
-		return hi - 1;
+	if (BB_OFFSET(p[hi]) <= s)
+		return hi;
 
 	/* Do bisect search in bad table */
 	while (hi - lo > 1) {
@@ -521,8 +521,7 @@ static int prev_badblocks(struct badblocks *bb, struct badblocks_context *bad,
 			hi = mid;
 	}
 
-	if (BB_OFFSET(p[lo]) <= s)
-		ret = lo;
+	ret = lo;
 out:
 	return ret;
 }
-- 
2.55.0

