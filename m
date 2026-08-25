Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFD435EC0
	for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662676; cv=none; b=pPhEtPPOA0kDKXRIt6ORCgDpxPXMmo9VV4I0+wPWMdLDbz9fkLKbuV0vmjp+k+vu0+Jk2Q6XM7ECKeC9JLZ3jWZe2v71+ayLt+erq3NOusdW3KTTK+6fNpdr5f9NY1ZtMM6eY4FVB/e9X+/hGBSNfYl+HpCxZKQUhyuoMKXEEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662676; c=relaxed/simple;
	bh=OxunhIeU7W6Dj0Buao+Q4xAPMOSJpjdpYcxluMBtrz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvsW5Y1creNimI6KSL6ObX08bgBvZE1bIYH8f/BTAbuvv6TP5KtVX+ptYmq33ywgFJMWGX4WAJVHTXsYmD567qs8UjOniBYrwLVO0UDSVOhxpUgVrCJ6rWbqOWQ2kZ0DtzPnDoyAYy3Lp4+vbXG0JD4xVx4qqEz/7S/12ReDWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neafaxY4; arc=none smtp.client-ip=91.218.175.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neafaxY4"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OxunhIeU7W6Dj0Buao+Q4xAPMOSJpjdpYcxluMBtrz4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787662672; v=1; x=1788267472;
 b=neafaxY4wvKG1Gs2QRp1eHovFAOE7mO85aEKJ7VPGkjLyE/dWajkZzAlqKStpF0ElrxxbZ1k
 KcWvlo0UDLd2KYYIfBgxNSHijLz+Iz6ILuPjAxfLkUSTWtnrDgdTwKUAIKbTGW8Gm+xHZP/kECK
 FI609gYVuxNZawtWKDTA2rIk=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 05e8f12338600767;
	Tue, 25 Aug 2026 12:57:52 +0000
X-Mizu-Trace-ID: 05e8f12338600767
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/3] loop: replace simple_strtol() with kstrtoint()
Date: Tue, 25 Aug 2026 20:57:19 +0800
Message-ID: <20260825125720.181793-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825125720.181793-1-cui.tao@linux.dev>
References: <20260825125720.181793-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

simple_strtol() is deprecated and swallows errors.  Use kstrtoint()
in the max_loop setup code; an invalid option keeps the default and
now says so.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 68a9cc7aeb13..8ba146e76a59 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2341,7 +2341,8 @@ module_exit(loop_exit);
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
-	max_loop = simple_strtol(str, NULL, 0);
+	if (kstrtoint(str, 0, &max_loop))
+		pr_warn("loop: invalid max_loop, keeping default\n");
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	max_loop_specified = true;
 #endif
-- 
2.43.0

