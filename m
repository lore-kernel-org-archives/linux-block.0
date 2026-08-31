Received: from mta1.migadu.com (out-233.mta1.migadu.com [95.215.58.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF53F8ED2
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170613; cv=none; b=o7I9dOwg6Xj/H+hEvFWnr7jnopV7kB9bgJS7/jLN3ksID5JiA3y/F1Bm1g4o5EuCls2gIcOqI4eAe4UqgOkT/JXA0unMkjjLskjeH0iV8jFBLufCHWxo+hAC+Vy3/UGDkM5jVAF73EfGfGDHDvWJZVC126brJ9M3Vjr3DecUGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170613; c=relaxed/simple;
	bh=TGVml8SyWuhwAWqjwtLE2/XHGeXxyb0w8NaxARHgkC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHf5lTm3t7ihs4vzA9gG3egFJC2rEcocZx11Q31c3MUNtgZiDnGp+KzSYlTJYLPynJf9OIqzL9dtM/LXGZE86ylLajVlcnsy4CmP2gZB0nKU9r2mWgQxoaWlGNRQ0lTbQOSYGR+tWAaF0ZghUIyIhKkU8l8BSqlm33D48F9NU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vOaiZqaE; arc=none smtp.client-ip=95.215.58.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vOaiZqaE"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TGVml8SyWuhwAWqjwtLE2/XHGeXxyb0w8NaxARHgkC8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788170609; v=1; x=1788775409;
 b=vOaiZqaEF9+8X232s75KBLmSMdfHzJoZdZdUY8ph/Auhb1JhxYHj9gsut7R3h1jyGp+OJFWI
 GgS+vuHfsUu7Do81Gust5EB8nhMo48ZJuRExQuBhGvj5mJlHzuiIQgPLx/cF9Gai14BWxK+Ig84
 +bj4cslA5rSVGkoyi0Gi6ngc=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f9338bf56f71e378;
	Mon, 31 Aug 2026 10:03:29 +0000
X-Mizu-Trace-ID: f9338bf56f71e378
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: bvanassche@acm.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 2/3] loop: replace simple_strtol() with kstrtoint()
Date: Mon, 31 Aug 2026 18:03:04 +0800
Message-ID: <20260831100305.695116-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831100305.695116-1-cui.tao@linux.dev>
References: <20260831100305.695116-1-cui.tao@linux.dev>
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

Only mark max_loop_specified when the option was parsed successfully.
With simple_strtol() a garbage string yields max_loop = 0, and
loop_probe()'s "max_loop_specified && max_loop" check short-circuits
on 0, so legacy autoloading is not capped.  Keeping max_loop at its
default while still setting max_loop_specified would instead turn the
default into a hard upper bound for dynamic device creation.  This
mirrors what max_loop_param_set_int() already does for the module
parameter.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
Changes in v2:
- move max_loop_specified = true under the success path, pointed out
  by an AI-assisted review of v1.
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 68a9cc7aeb13..126f42580632 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2341,7 +2341,10 @@ module_exit(loop_exit);
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
-	max_loop = simple_strtol(str, NULL, 0);
+	if (kstrtoint(str, 0, &max_loop)) {
+		pr_warn("loop: invalid max_loop, keeping default\n");
+		return 1;
+	}
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	max_loop_specified = true;
 #endif
-- 
2.43.0

