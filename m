Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D43370EC
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583254; cv=none; b=kSPd6ihOhpl9D7mrJ+agCFCvRNZCNv1QbL3XhNKsesoejGxB55j9QJ8IXRyXEk6TKDUcCfxy3DFydg7m9IEZfxJjtIubVhZPr03zidp4gHT9feBmy46FVwE8szrL1joNumu9lXMuXiRHQOR/bviaTsTx9SX4q0pmTB2Lx78yd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583254; c=relaxed/simple;
	bh=k2OsgyNizxusADUde0S14UIFkxXaowbHk4UidSMtIxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQHtx2+uEmVH80LwhCEXjloTTNWgArRKf9h+eIFxVHH31hzG6K79W1M2Zw74ghmDwtWpnS1t+tOrRzPycbDyDWYZkJlkg15G5J4A0M4Bcq0UOSbrD7DRZQJWRAfrQ8BVigV+7mHvULLoPDTKYdb1YvDxkxa1F/T+6cZMIjVVKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=aS75Wrge; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="aS75Wrge"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso47809675e9.1
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775583251; x=1776188051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=aS75WrgeXCi797Wg1chcHq5c23rOXJXiJ3snu3TkPHASYqTEt0sY7RuNt43YySjwSL
         +PkoISDPilAxem5KevB7G+weescFIZLqXF5cYpKbvBdNvjdgU+zQvhwV0tkhclmVOImJ
         izLO80FTC0INwQjVfiY/5ZKtmfUH8gg+n9rwYKkDv2JpXJA/7iJSmUtkp4EmsD31o7AQ
         RsOWM46JQVUMQR6V/FiGhK05PuMpofLH3WoojwXMarfFfykRrnMGO41LfDUEqiwrsud7
         xo3jyBuM9sN7s62o1uyNoIAdQWKt+HC7mCS5pQw39e1KOKn6O9h5AA+Jpn348yr1DO48
         98iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583251; x=1776188051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=ZhnabP/HmPG3+F8JctqvuPO6P/T1p4SG7zJ15lGrDXhs9Vv/kEg2qQtdVw8fzCrlaP
         DW6EFOwQfduSgiPEqfYupbGhW7Ax0kLyQ5D1ujJ4zpg2EBOxQOnoUD1P59RPkzDZM88o
         aQ8HWMD5CZudOeBKx/Hw4nIo9uqGk2vY7JbmYc4+KLVJt1d6PEh6Z3NAXUFoXRH9zXU6
         wiGA1UMi3YvloxXH24hE+FZ6IYJujslfrBXXQ96qEMBvoJY216srCR+lhMNWFYQ1pVvC
         8sLjL6AGDcCJHaYejU+SGmDKxt/+cdPAXcHpsa+kZe8v19PGg4DByaf1auu5OiCPogY+
         qqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbuOjc/IziDwC67sSW3mC5vfjIh+3LantbGh7DGdyYhOaa/SzlEkzMpwz1zyfzTRTBrptt/VY56HUflg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YZY+D7zX9+PaidUV+SGejOeJfnybCOB7KXgoXml0NlDbmXnW
	SDcf4Vz1eeIboKQTCuxoi3HMmkjJx0KLDe1BytitRfu50A6kQVgYq1rXugYkzNb7ikQ=
X-Gm-Gg: AeBDietAgyor+ErAGRiyO3aYLekPbYNEUbv9W2+OzITmwda7zf/TkoCl7icBJHFDyzc
	jbLFkRZpOkYHBdr9VHOG425dFLR2NW6DvWXp6hjhKrK6QEUyYxuACA/xnnDVWLBJV0TZzvv69ac
	5eTv5I3+dNf8Sk0GihjRo0CWgHq9ozV9QyyzjTgwSEMQsQwKX/U2ey5XaNhBK+4U008fLIiZNJX
	GotBhD10DXAmWDeioOxBNRXwd7D5ON1oTdGWIUG5rpjnHmkocYwcuz0NOK8DKhbFa1WEjx759eA
	1dIUB4jp1wh0Mlv5+Dvb6et/8FgK9aFmUNIxLnG69XHNls0zAyRH3H30vwLBu/OpHBHJ0Gq9P5k
	qMTpDj3UZ/KsUMfS8BT2GILpZrKndxtMulx71wjey8Z1yDqGGNfJeps8k9FT0I0+Woig04ijvct
	z0kyAez0sOHlKlbOhgpcS/z479z4E/ADSDaXvhepPn/AjfzoVG7TZjUFY8K2EmKAxfWNolnoWk/
	Cul8EisVumo4KCXc6ikiw==
X-Received: by 2002:a05:600c:37c8:b0:488:ba5f:984f with SMTP id 5b1f17b1804b1-488ba5f98cemr77455075e9.6.1775583251064;
        Tue, 07 Apr 2026 10:34:11 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c4e930c7sm6667275e9.6.2026.04.07.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:34:10 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/4] drbd: move UAPI headers to include/uapi/linux/
Date: Tue,  7 Apr 2026 19:33:53 +0200
Message-ID: <20260407173356.873887-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drbd.h and drbd_limits.h contain only type definitions, enums, and
constants shared between kernel and userspace. These should be part of
UAPI.

Split the genl_api header into two: the genlmsghdr and the enums are
UAPI, the rest stays there for now (it will be removed by one of the
next commits in this series).

drbd_config.h is clearly DRBD-internal, so move it there.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_buildtag.c            |  2 +-
 .../block/drbd}/drbd_config.h                 |  0
 drivers/block/drbd/drbd_int.h                 |  2 +-
 include/linux/drbd_genl_api.h                 | 40 ------------------
 include/{ => uapi}/linux/drbd.h               | 42 ++++++++++++++++++-
 include/{ => uapi}/linux/drbd_limits.h        |  2 +-
 6 files changed, 44 insertions(+), 44 deletions(-)
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 rename include/{ => uapi}/linux/drbd.h (87%)
 rename include/{ => uapi}/linux/drbd_limits.h (99%)

diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
index cb1aa66d7d5d..cd0389488f63 100644
--- a/drivers/block/drbd/drbd_buildtag.c
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/drbd_config.h>
+#include "drbd_config.h"
 #include <linux/module.h>
 
 const char *drbd_buildtag(void)
diff --git a/include/linux/drbd_config.h b/drivers/block/drbd/drbd_config.h
similarity index 100%
rename from include/linux/drbd_config.h
rename to drivers/block/drbd/drbd_config.h
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f6d6276974ee..f3d746a6d6fd 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -34,7 +34,7 @@
 #include <linux/prefetch.h>
 #include <linux/drbd_genl_api.h>
 #include <linux/drbd.h>
-#include <linux/drbd_config.h>
+#include "drbd_config.h"
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
diff --git a/include/linux/drbd_genl_api.h b/include/linux/drbd_genl_api.h
index 70682c058027..19d263924852 100644
--- a/include/linux/drbd_genl_api.h
+++ b/include/linux/drbd_genl_api.h
@@ -2,46 +2,6 @@
 #ifndef DRBD_GENL_STRUCT_H
 #define DRBD_GENL_STRUCT_H
 
-/**
- * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
- * @minor:
- *     For admin requests (user -> kernel): which minor device to operate on.
- *     For (unicast) replies or informational (broadcast) messages
- *     (kernel -> user): which minor device the information is about.
- *     If we do not operate on minors, but on connections or resources,
- *     the minor value shall be (~0), and the attribute DRBD_NLA_CFG_CONTEXT
- *     is used instead.
- * @flags: possible operation modifiers (relevant only for user->kernel):
- *     DRBD_GENL_F_SET_DEFAULTS
- * @volume:
- *     When creating a new minor (adding it to a resource), the resource needs
- *     to know which volume number within the resource this is supposed to be.
- *     The volume number corresponds to the same volume number on the remote side,
- *     whereas the minor number on the remote side may be different
- *     (union with flags).
- * @ret_code: kernel->userland unicast cfg reply return code (union with flags);
- */
-struct drbd_genlmsghdr {
-	__u32 minor;
-	union {
-	__u32 flags;
-	__s32 ret_code;
-	};
-};
-
-/* To be used in drbd_genlmsghdr.flags */
-enum {
-	DRBD_GENL_F_SET_DEFAULTS = 1,
-};
-
-enum drbd_state_info_bcast_reason {
-	SIB_GET_STATUS_REPLY = 1,
-	SIB_STATE_CHANGE = 2,
-	SIB_HELPER_PRE = 3,
-	SIB_HELPER_POST = 4,
-	SIB_SYNC_PROGRESS = 5,
-};
-
 /* hack around predefined gcc/cpp "linux=1",
  * we cannot possibly include <1/drbd_genl.h> */
 #undef linux
diff --git a/include/linux/drbd.h b/include/uapi/linux/drbd.h
similarity index 87%
rename from include/linux/drbd.h
rename to include/uapi/linux/drbd.h
index 5468a2399d48..7930a972d8a4 100644
--- a/include/linux/drbd.h
+++ b/include/uapi/linux/drbd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
 /*
   drbd.h
   Kernel module for 2.6.x Kernels
@@ -389,4 +389,44 @@ enum write_ordering_e {
 
 #define DRBD_CPU_MASK_SIZE 32
 
+/**
+ * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
+ * @minor:
+ *     For admin requests (user -> kernel): which minor device to operate on.
+ *     For (unicast) replies or informational (broadcast) messages
+ *     (kernel -> user): which minor device the information is about.
+ *     If we do not operate on minors, but on connections or resources,
+ *     the minor value shall be (~0), and the attribute DRBD_NLA_CFG_CONTEXT
+ *     is used instead.
+ * @flags: possible operation modifiers (relevant only for user->kernel):
+ *     DRBD_GENL_F_SET_DEFAULTS
+ * @volume:
+ *     When creating a new minor (adding it to a resource), the resource needs
+ *     to know which volume number within the resource this is supposed to be.
+ *     The volume number corresponds to the same volume number on the remote side,
+ *     whereas the minor number on the remote side may be different
+ *     (union with flags).
+ * @ret_code: kernel->userland unicast cfg reply return code (union with flags);
+ */
+struct drbd_genlmsghdr {
+	__u32 minor;
+	union {
+		__u32 flags;
+		__s32 ret_code;
+	};
+};
+
+/* To be used in drbd_genlmsghdr.flags */
+enum {
+	DRBD_GENL_F_SET_DEFAULTS = 1,
+};
+
+enum drbd_state_info_bcast_reason {
+	SIB_GET_STATUS_REPLY = 1,
+	SIB_STATE_CHANGE = 2,
+	SIB_HELPER_PRE = 3,
+	SIB_HELPER_POST = 4,
+	SIB_SYNC_PROGRESS = 5,
+};
+
 #endif
diff --git a/include/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
similarity index 99%
rename from include/linux/drbd_limits.h
rename to include/uapi/linux/drbd_limits.h
index 5b042fb427e9..a72a102d1ca7 100644
--- a/include/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
   drbd_limits.h
   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
-- 
2.53.0

