Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43E78F2E
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554046; cv=none; b=tNvSHkrTM3nOrp5qKbZZTWfxgv33x0vuhqqBC0H6mULixKo6j1n+kJqkrbJLwoGwEt8Ped/1LqPVeacKU4HcSnVLtwsOFrG3rarEIMYtwPOtnbn/UWU5RG6ql8VqsMY0GphZXw6GK/vcVQiq3ALajFk06EWuGBsbcA/RDtk0gJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554046; c=relaxed/simple;
	bh=rxKPwcFV5LiWbF8J192T52CToC0Im8WcvNbwQCSPe48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8sa4Uz5vdegOIRkEhhpfov4IKUAcJ0N5Epup+ZV1KC3wTGI9ZPdQ/nc06sZ3dhv4aFRtNM3oOz5PmGALsWscpOuiBfpqLLTUVV5cg7Xl29mjjqWyU/QUxBj1Z0jpdJxG3R1aWI3FIUyi3yVH4EpaLth/IFKavljymeG6JYG6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ov1wHpv1; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ov1wHpv1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769554042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LPzlGaYUwAZGiguRuCxkDSRCIUPpFM+cmPr/UWKmARM=;
	b=ov1wHpv1orAuCQX8ZaTr9x3OOM6s1euRxC6GqS1NFebtTcZNkjgp40sUPxf+39oyS8Xu62
	8UQgN83oLckWv6aHMXvQM4rf6zJXhRz4/EcNwbGzXSn18Il6us6Mp1nuYKmLvTVGOj9kfc
	mm/glncJPn2X1ymviDPppNkJlneidtM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Replace snprintf with strscpy in check_partition
Date: Tue, 27 Jan 2026 23:47:01 +0100
Message-ID: <20260127224704.440877-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 block/partitions/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 815ed33caa1b..079057ab535a 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/major.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
@@ -130,7 +131,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	state->pp_buf[0] = '\0';
 
 	state->disk = hd;
-	snprintf(state->name, BDEVNAME_SIZE, "%s", hd->disk_name);
+	strscpy(state->name, hd->disk_name);
 	snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
 	if (isdigit(state->name[strlen(state->name)-1]))
 		sprintf(state->name, "p");
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

