Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEC3EFFCE
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146259; cv=none; b=Ab0ULzEa5oq85e2GW8rVbQEqreSp0F17T2isqiIxHONLh5CcW/icm2JZV9gvTdpbm2sOv+pYiuzxvCwNaSeida/sSn3X6SVkiXb5FOhrcpMfVkjCgHoyxgLSMhv4xjvnz11vPy/zQiREltYcwgsaWR00xAHOPtytx97u7VHNhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146259; c=relaxed/simple;
	bh=1VASKRYj8O3uyId+LEIuzz27LTt1kP8n8UWmQMWsKBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWGsqbYBPTnDY0cmkLynf3HTY1u/CgDa33iFGKjxBSj1WAGe3pV9F1gU6656sDlkLqSd35wvz1W4YyYh8ioWW/qJhFVfdZcc0EhuikTwx0jMT42ilCjWd/o4Nx1SysALs+c9NEk5bcuC/L3qjHdTE1p4KUS8FA035Odhln1XUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o+/Pm6ga; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o+/Pm6ga"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785146255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pTX5I1JY2W5dtBHTVDxDZLR6fbXEu3f2bbNEFgRRGMQ=;
	b=o+/Pm6ganDINRk55NYnDu1gSHBAKmWKezsMa7HjZqYw1EmMfFKlaZATf3Cjd1GnSDH3Cf4
	m+wZ2HJ/84rQMcItVfnF3SCz6vqtJ3FwxI9r/R5S/dGiqJE5RrX36xhINQQwMLHg28W2qQ
	7+h9sH+4kX0OmEDmLc+eunuOO9EIYEw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] block: Replace deprecated strcpy() in devt_from_devname()
Date: Mon, 27 Jul 2026 11:57:13 +0200
Message-ID: <20260727095712.409334-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=thorsten.blum@linux.dev; h=from:subject; bh=1VASKRYj8O3uyId+LEIuzz27LTt1kP8n8UWmQMWsKBc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnp2hVOO9KzfUVWsZ7/Ef957WpbU7MVDW771v3hPv3E4 kBpQI55RykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzk229GhrM3z154rXq2jndR NTPbMWG1b4WnXL9oS4fJHX8qvV6ZL4iR4Tjb7RmTWdv0g3hmT4rctIRLY8Li6fNO8sw4pCMvHRa 5kw8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated [1] and uses an additional strlen() internally;
use memcpy() directly since we already know the length of name and that
it is guaranteed to be NUL-terminated.  Also use strnlen() and sizeof()
instead of the hard-coded size while at it.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

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
