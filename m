Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B0371D01
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027307; cv=none; b=TdpCiEvXM8N5sKQBenFlkAhZCYKIWGKxVpHjHjFRv975q8jIVqBqB5Z9/eszEU6b2CTh6vBx1PVBSgRYtYMuQ7v4uTSQ+XKjZrfINfrPwoqzP9AC+9uO+LnDhKrmHdpJ3i0tPzeSl5uburvs+Z3hA6y1pkzSaKXg7bpIytZ0UY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027307; c=relaxed/simple;
	bh=IJbU6xhKJaweGdukujzsnSYZEcFHItHUs308XmP71B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAYqeqxWKaqSel/mVoeXymVc7uuC2qKmTXSNV+1Dfmk+nuH0TI3cEoI/QXBydHfORAMz4CrkhcQ1r2T3TZF2ZdZcaE2DFtrpVmca8cb8xoiwoouko1UrN1M7D7alPDDBAQNYb4vbG/AE8tTG+jRGX6pyP/WXhMAdcrP84Piy5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DX6DojRy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DX6DojRy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLfvwOwxR5cg2gP8LrXy4S8s7FmjYLOXlug9Ekhn5mI=;
	b=DX6DojRyV0viOSI9+tYsmiJKfcPyGKqyuQmSNteTFwGpSfzE0IFuzqTvOZ4T3svgEEz96G
	1yK47xgVShzSIlwmDu3+d4nir46WOiZa0pcpFiXeoG3wT0VQuzWDXl6/yBLvSIXEcIAeC+
	yCkqJnZAjpHCbUNntAT0kO0I6NJXIzY=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 07/10] block: convert bfq_var_show() to sysfs_emit()
Date: Wed,  1 Apr 2026 15:07:13 +0800
Message-ID: <20260401070716.991-8-liu.yun@linux.dev>
In-Reply-To: <20260401070716.991-1-liu.yun@linux.dev>
References: <20260401070716.991-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

Use sysfs_emit() instead of sprintf() in bfq_var_show(), which is
the common helper used by all BFQ sysfs show functions.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 141c602d5e85..4123f42faf39 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7379,7 +7379,7 @@ static int __init bfq_slab_setup(void)
 
 static ssize_t bfq_var_show(unsigned int var, char *page)
 {
-	return sprintf(page, "%u\n", var);
+	return sysfs_emit(page, "%u\n", var);
 }
 
 static int bfq_var_store(unsigned long *var, const char *page)
-- 
2.51.1

