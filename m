Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC03D8105
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196523; cv=none; b=Jk3JKKcRbJD5Ub47e6R+J4VEgf+Iv5etsvN8NJSgc9ikZuusKVF4OBDMKQopkLdy4YYbtT3qBrwBxxUZymZlXvzjVp9H39KijEO4AoBCZXBJfPTOC4qZEwEBHAf3E55zudqL5S4B2sg7NZ7r8KcPXMI9+Ze8UpbBwap9ahlws7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196523; c=relaxed/simple;
	bh=O69nDv+G9K89qoFz2qISQZl5RcKYuTwjmLT1qPHNd6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUTfq+Q3sg3blNjpK8TkWIxTR+cQytfCO0A6DX3kcLCxQZVxXvuZa7ocwIBdzNcA0c8YwmU5Zcx8oEqrsJfCebwHK7iJYMMhx3vW20Nkym2g8ZbChfcvZE6TLKnZ8MUlt5MDzClTwy0jxBlnjLXXTnzkcW0U7N1F4UVg0qRwqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J09uJWY8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J09uJWY8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4798bea72f9so3419254f8f.1
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784196519; x=1784801319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NScQ6CATgA4lggyrRFgaExVSnuJL+6g07OVmMmxDL34=;
        b=J09uJWY8nAKLL6lZ7xlrzn3V+VKEnQXi6tzzEMvPXXoxKNIx9Fy7FSgp+zmFu9Kmg6
         4+OILv5vwxM38eJ6Pzs1scJOenBPP+hTjj0uaQZKFSP9GOnOiStP8m+GqeokoU7qiJFQ
         zhR9bThRkc3MvFbNblR+fuqQs/JLSpcVKeSv+0K553VlyTy1eZfcxpcCAlze3azCpaCd
         lqbNckeFrhFPk3zPyi0EwFnOVKHqxCOxXSxxy5m+2N2d7IJJt6PqRWmyywOkLLcj2HWk
         0b7RztXSLRIpAid9RS4SxjB9I2Wy6hntG2cLw7bKB65qM4Ez7ZWYFZHSy+OE9gpZ7D6b
         cSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196519; x=1784801319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NScQ6CATgA4lggyrRFgaExVSnuJL+6g07OVmMmxDL34=;
        b=eXD01piQTpdYz0jlD3/ysEjsDgJAkoE9FEvbLOcjn2Zfa/fUCK9S6M5Dvo1pjowEtt
         2rHK2gE21abdr9aYqSYoUCU8oLvnwREhFxv/dYfBr7tkA2FA1tOdj8YiJKab4lWchn7g
         UtgAymoNjc26Czls/HKHESBnqS3O7vvnsjMXar91K5SkbTMaU8ttEjxgRRqCTQoSdY/o
         zB1s444fWzMmu+qgktwKmTjNfBx9YthDZap7NNG/6vF8yBPWMSsW/Y9jKZu59/tOIJRt
         0yCqmIZRlI5MrKKZPz1rWEqrQlvF320JGJCGPjqoPNrxauuKOifl+DowchT3nUyz9Om2
         MIpA==
X-Gm-Message-State: AOJu0Ywqbl1+Gw+NJkXpJ4fvDcc2sikvBquZIkuVXmG6qR1J/Wmk8jol
	auK8v9IcgP3jfvUjDfKqYwpzQUWdy7efx+4hw+op7R0CHUGzSKB46tA4PfnpvQ==
X-Gm-Gg: AfdE7cn1EytxAYK+Dus8PXHevR7PwFruX42eWhmaEkdr0GYAHo6Jt/O4TteuLNGuHtJ
	MCjKlSlrvFC2Xlgag0f5i4DO2pjX68zHqW4J8Rj0tjKH+3SFqB6HqbcCT7yhq4bi5yVMczaM0mw
	eYwSBDtPjn4n8FxwI0xJ1W9Cpm7sy2CJxF/RO+1821ZGUm/QeSeGOwA5wwEOzzAQhpE8Sksh/M2
	V2qL6E5VAwHlNVQGUPELJPYqas8mwWp/eqAfpFd6uC/gdekajVcvo2PXK3pIXDom7jV7gnuRIMF
	zOwcVwUS5L4zWsZBmuppiZQcauqtL87LHIuXKVzo4zJZqHO9sojHTajQKnOJFZjgWHjZJ9RK3oy
	EFuPihkbo92lHBkU0ADCfnRZv3dpYrQyNBr9xHlD3RXXCiR2J5XVKVgX9ieKjPAp7pBTGsjpb5G
	Xd+yIqK1mBipk0NJv4lkt2bDXMLkBOPbcxcyEmiMNkkERDluI=
X-Received: by 2002:a05:6000:25c4:b0:47f:5c33:5ec6 with SMTP id ffacd0b85a97d-47f5c335fa6mr1503845f8f.17.1784196518662;
        Thu, 16 Jul 2026 03:08:38 -0700 (PDT)
Received: from localhost.suse.org ([37.109.161.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e5c3sm22743613f8f.1.2026.07.16.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:08:38 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH v2 blktests 1/2] common/rc: add _have_debugfs()
Date: Thu, 16 Jul 2026 12:08:30 +0200
Message-ID: <20260716100832.30570-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel options like FAULT_INJECTION_DEBUG_FS being enabled does not
guarantee debugfs is actually mounted at /sys/kernel/debug: on
systemd systems, sys-kernel-debug.mount may not be started by
default (e.g. SLE).

Add _have_debugfs(), mirroring the existing _have_configfs() and
_have_tracefs() checks, so tests that depend on debugfs-backed
interfaces can skip cleanly with a clear reason instead of failing.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index d60a125..de5eb6d 100644
--- a/common/rc
+++ b/common/rc
@@ -223,6 +223,14 @@ _have_configfs() {
 	return 0
 }
 
+_have_debugfs() {
+	if ! findmnt -t debugfs /sys/kernel/debug >/dev/null; then
+		SKIP_REASONS+=("debugfs is not mounted at /sys/kernel/debug")
+		return 1
+	fi
+	return 0
+}
+
 # Check if the specified kernel config files are available.
 _have_kernel_config_file() {
 	if [[ ! -f /proc/config.gz && ! -f /boot/config-$(uname -r) ]]; then
-- 
2.51.0

