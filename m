Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B617350A04
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039929; cv=none; b=mJxz5YO+nCbsOTK7SIdn3YT5GTtTvD22yeUmbt6CI1A0ohislRXWJ62CjILFNdhwOxg7bMNDV23t9zVKw8nNnlSNOmXdj7IVXGGLlNlgBciTjTCE0VF8g2Iz3+SNEeAViMj6LoQav9dbKv03xWDQUtlYz9ZibEgHj9SaP6T+TaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039929; c=relaxed/simple;
	bh=BBpsJqxEP7v2OZJUgVFcvfvGE7g14MC4OgCuCg6mXEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKmOqSc7bNB7k65NG7cPiTDsW2wJGldMqZpiex/JBDtWfBfoNH5fJWc9c5Vv/5f1dmksaBs2CtbG8qJa7cyl7ppijf2RoSBn6BruK52vAtzsEnEKUk3qumQIJ52RqTqiNdngKMsxVyq/7jBsDLdNwTJ0yDjP93a/r4evqknl42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dcQzanlO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dcQzanlO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763039925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tLLBDb3sXKAaGvQ1VyRAnDZc4+anqcIji71QoAU2NI=;
	b=dcQzanlO/lJIJYmPY+xye8IcI/QJizffTHZpygExQyRaOVROhPs+qXfck5LxaOGqCcHkc6
	+EJ12GmNF9e+ILnPWcK+VgdFY/c1lBUMu+Hhqdnry00mcx5lCNAwAh1kjt2G+quPkWK/b4
	3/0D2uGO3Ib7Qdm2XIOAg9/gQ+2q7aQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Replace deprecated strcpy in devt_from_devname
Date: Thu, 13 Nov 2025 14:18:33 +0100
Message-ID: <20251113131834.45852-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strnlen() and sizeof(s) instead of hard-coding 31 bytes.

strcpy() is deprecated and uses an additional strlen() internally; use
memcpy() directly since we already know the length of 'name' and that it
is guaranteed to be NUL-terminated.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 block/early-lookup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3fb57f7d2b12..5c30a0cc85a0 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -155,10 +155,11 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	int part;
 	char s[32];
 	char *p;
+	size_t name_len = strnlen(name, sizeof(s));
 
-	if (strlen(name) > 31)
+	if (name_len == sizeof(s))
 		return -EINVAL;
-	strcpy(s, name);
+	memcpy(s, name, name_len + 1);
 	for (p = s; *p; p++) {
 		if (*p == '/')
 			*p = '!';
-- 
2.51.1

