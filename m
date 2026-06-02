Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D43F2101
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416535; cv=none; b=M7zc/04ohqqThUwSZg00d6dfyb+kaghnwtvwUmDiKlGRV6pK8M93lLs0GOJNfIhGg7wGE6SHsnuIBcvQ4fQfKg5hpDlbFDo8zUvop/B3KvAvD322D6H5xY2j89iR2Utqh1Iqt1T17FyVO0PCeN+bNwnZWPL1Mbax9WwGRHMhx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416535; c=relaxed/simple;
	bh=jHEP54/xzr6y+gurc767XySok3MRWRWSy1e3YUVbHS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnnmbB+8cGjP8xEq91XRWBhcS5Cg3XtoxfuBq9sZaQI2AJxEq70NE49cHLJvN7pPMdVNbebXVPVOwXbLjSz6SDTullk0NCel8S/wv1G+y6+LOjk/RxrFwYW0TsSStXjLbDF9bn3GHEpjDQcOttN75Yjv0TnXBCHD9Bmo4SQOmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QOJhp52C; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QOJhp52C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780416521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k1UMyfTQNPyzDLAJ0fEbSsx0QHZQZ2I3LxkBnFOQYn8=;
	b=QOJhp52CfiUomFL47IChHkBJcLybYekyLGFQvxWIY5feSvk6q9LxLT5Tg6aiKSCow+Qu01
	ga0KBwVixgeuxzsYUKEmqFGNmz87eImNMuihJduih3S69c6WLcJ0PClLt4IWv4zg8wM5LX
	drjVkDxI1RGkYzPDwf4XQ4We6avlMBI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	Josh Law <objecting@objecting.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block/partitions/acorn: use min in {riscix,linux}_partition
Date: Tue,  2 Jun 2026 18:07:57 +0200
Message-ID: <20260602160757.973736-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=thorsten.blum@linux.dev; h=from:subject; bh=jHEP54/xzr6y+gurc767XySok3MRWRWSy1e3YUVbHS4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFly/+8mzX1jULiuR3pRpPntls7lrI92b1Dl/dj5yjp4R rSZVEpJRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEyk+iEjw4nsrc8k+8/bTvgd o75c4cAh6zQuvv1+a4M2GWt1NM9ZI8LIcGD5sSMd3D5GsWHh0wVrZkayZB069yH3Kt/2C9rLPfh d+AE=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to replace the open-coded implementations and to simplify
riscix_partition() and linux_partition().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 block/partitions/acorn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
index 9f7389f174d0..067d6a27a3bd 100644
--- a/block/partitions/acorn.c
+++ b/block/partitions/acorn.c
@@ -9,6 +9,7 @@
  */
 #include <linux/buffer_head.h>
 #include <linux/adfs_fs.h>
+#include <linux/minmax.h>
 
 #include "check.h"
 
@@ -80,7 +81,7 @@ static int riscix_partition(struct parsed_partitions *state,
 
 
 	if (rr->magic == RISCIX_MAGIC) {
-		unsigned long size = nr_sects > 2 ? 2 : nr_sects;
+		unsigned long size = min(nr_sects, 2);
 		int part;
 
 		seq_buf_puts(&state->pp_buf, " <");
@@ -124,7 +125,7 @@ static int linux_partition(struct parsed_partitions *state,
 {
 	Sector sect;
 	struct linux_part *linuxp;
-	unsigned long size = nr_sects > 2 ? 2 : nr_sects;
+	unsigned long size = min(nr_sects, 2);
 
 	seq_buf_puts(&state->pp_buf, " [Linux]");
 
