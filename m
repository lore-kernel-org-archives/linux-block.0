Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6A1B81CA
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235484; cv=none; b=HGE0YovTZc6gbZm8oQHHNNWG1f7M++o6GNtrw3XLief/0gP8vN+kpmTtBTb9J6JfsNg9L3IAiCMeiK0B3QTEeqRtXtT6l4KScYbLnoxod7RJcy2rYI9vN8GYHWcvfNe1ORLkyGWlxV3nCoHAwoaKOgrCfK5e5M8Oc+Pw+pz/FNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235484; c=relaxed/simple;
	bh=PhUnVJbSG1+0575qqavIarUXsqqzRdFnID8OIbmgu9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3eRZOcHw+9hXkSVClyJvGu7uiUvRLnZp20am8o81YFPm4OMKum7kJegq9Qua3hvecDny+ktYn/Znt+MebgxWXuz+UlcJWvPfL/+evH/PwLcPZTZZrl1Lw2gaVOgGAKMD9hCH3WUn6j2AYfvKpImONUVGyVfhJG+TKQgz5caB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rK/5AyfO; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rK/5AyfO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766235481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aHgVcfJqpReMA3Jcz0CAio8V6RlUptBJ8FmdLCH91Rc=;
	b=rK/5AyfOIj86Ytc8QAUyFlU3xsUX9w0W/w3dHV2ixPXmmxbKcdz0QOQG1j+5Z1TCFQxuqK
	n9JSjEu3ZjQUyjfqfdixDJUBSYak2BFiTWA3hKR6MldYzVkKOSyPeoc/XdoYcg6JOmtacL
	ldGbrXgLfU0fPgnx05KayZYtfcFrSH4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] block: Replace deprecated strcpy in devt_from_devname
Date: Sat, 20 Dec 2025 13:57:30 +0100
Message-ID: <20251220125728.76631-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strnlen() and sizeof(s) instead of hard-coding 31 bytes.

strcpy() is deprecated [1] and uses an additional strlen() internally;
use memcpy() directly since we already know the length of 'name' and
that it is guaranteed to be NUL-terminated.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
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
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

