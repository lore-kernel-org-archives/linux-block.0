Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C544CF5B
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071551; cv=none; b=hGsd7zFQNOQU4CmC2Ba5q1ZKyOPdgvxRU30xyXbnTFzxGz3wHS2FEzVizNEdeYC7cuXyyhrhDuocq3tvVZLjPVtCtpUotejqT0qW0AjgbQ9w0jjqaMWYgXGnskoCLFH0fO4xWVz7C3V8tmnATNycZpr3nkUb1yMOyf0d6zkA6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071551; c=relaxed/simple;
	bh=k2OsgyNizxusADUde0S14UIFkxXaowbHk4UidSMtIxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAdGCc4F/3u3Ec3lATAi6qfAtEpWmWatmzNEpr8p540ytrizlZqniB4+Bb8eDj1jDxF2TZfm0FWDdShlPkRkD5pHeYXwkGwVhRucyfnpxPbaKkdpNGPWkkW/iGA9CwQdZGQAaWf8CPqjgmDnmZS5c0wHfUppdp/fiAhJCTLZa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=dnes0tMD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="dnes0tMD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488d2079582so66417965e9.2
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071548; x=1778676348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=dnes0tMDmtZ2uQ0coCu7g9gHFaRfTYE0an3kbopgQejylt0MQ75kgpO9+0M4k0S93r
         cmqP66/pKaIdTzX4UYPdzkPT6A+Mp4LwSR/gmhv004wr5GahGcIgWuu/8zujAp6IIncM
         xJzFLXhnMNq8eoaGxOmTvBpitA8RXGZnVjKaYTdbL/MBcQJWyFB6bVWzNC2WA4Xx42Iv
         x3GsSEyL7xKCte4KZ2tiqFXYRTrpkee3nfbMnwwbFNdwebBXH1tlHAOczeCZlvHdvBAg
         IZXRZJ5yeM80wZvHwKmjsEWPjSswSGVX6N8W2n9ZxvMv/vjjoHLbsnvuHJ0WXkym3EsJ
         1pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071548; x=1778676348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=BzaJVj+X3ZlRymR+U3wOvDW5U/NqNasKUOV5odP+/BpYlX13S305mLE1Mkc+FUh6Ht
         oDkud6jL2IXNicGbPuBkMauOmKlTvR+uV1XTr+YgvpnBtp05dchphaQ5PlqpBq9aa+Ue
         lSAlFWH4tjJ0ScFoDIuVnRLesmcca8zs+AKipX2UWgtYz2vh3ypuQ8gILXo6wmq5amlk
         Xr2DYPBwwc3voKDDcPKUpNMOIjw3AdjoZoOQIgQrIo0Pr12/mnO9lpV7Oz2NIiDnq1hn
         8f+GO+ce4WA/rTEh0x8l+sI/3tOzHUGgs6zds3iWDBLsvJdywgaPFYsjVUTMIhx341qY
         wGAg==
X-Forwarded-Encrypted: i=1; AFNElJ+F7m05GiFTADA2FHR2Dlv+g6BVDBgN+hE+2i5oGWEbmwx5TNr5A5KBqq1DBmb+3apnVq21Hl1MyyCfdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUlVSioqImbLLjqoXbEcbTZiv+KBTHukOdgtEQ8udeceyEXyL
	TtgVX7MwA5EH7kOzDi7jhs/b7q+bKC0aiQZuEwbTzV+yreHSnFgf4gn58icTjXbuqYA=
X-Gm-Gg: AeBDietZ56WmwrLaE60THaBKN67CWVxJqjoDNygOGP9qVtGeHcNZyHKZwxp6CEvU7rF
	DuhhyEyk+YZji5WStmGiM9z0IKsV5gDuSvnEgBAsVk8rCnCbZMWLQD/QHlH0nhpTfj+7XiH3we2
	tOQZ8dIIutMXNOi4v6BvOzWmj5JTXENm9tJ44eOiEv3Wnn/AAgOCMSNbxmUGeQsk2W6wXB9knCa
	UxCNC5ODvbi5hNJq4KBbVZEdUCLihwhfWxzXbmC/FauHyKRi9YkZfyE/rV7knNlPHAjzPtmP3Jb
	tQNStrrwoFU2MbVS2Kci3m0DRemnFd7qRCJ2qUSqQbcF0tZP6epXdF+2zcq+f0fNySR6NSTJyqT
	VLLeTiqxWYk09hf7a9VBJ5J/ZY+iLZ/gGvZ5kgntoys5clNsnJ2Hm2slOwgW8BC8mFj+laaHlsL
	FqSWX/tZxk9fP+RpXuLATCdm9/+Z2QQsirbXbHghXfDePWzu7/nCL0zvxIsS44CQljIa66JwFrM
	v+3lzpuXrQ0Zwt3SyuWyeUcKgVDDwqmNkL2MOLG9Xs=
X-Received: by 2002:a05:600c:4888:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48e526e10a2mr27782385e9.5.1778071547661;
        Wed, 06 May 2026 05:45:47 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm74792275e9.15.2026.05.06.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:45:47 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drbd: move UAPI headers to include/uapi/linux/
Date: Wed,  6 May 2026 14:45:40 +0200
Message-ID: <20260506124541.1951772-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
References: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
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

