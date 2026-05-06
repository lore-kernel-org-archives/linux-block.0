Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9C44CF54
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071187; cv=none; b=hSN77JeUGQ17TKmLleglk45junW383Osc9SLh1LsGa+Ojgk9BdZHKMEduHadfEeGozy84UtjopiEy67652GD8xxcqF4mWpkykgFfYlKmLsk6ng9uowwIBl+Zw0sW/8w8ZEuYEbkF3od0F2WGVrbcicqtA3/sT437qEhFcV6klD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071187; c=relaxed/simple;
	bh=k2OsgyNizxusADUde0S14UIFkxXaowbHk4UidSMtIxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ko/h3hbDYXFQKKOQR4xmrEDzy1u87figjiXli+cV//x1ys2AV81ij3xP55KAGgmxoJYqmohvNuNPEpJQ27495IKKRRc5Qw26M0h7EfBYhWhkmk9evBcbvGFyCNKIndoR8K3I4SwdA0RsnKTBwjqAX2D64iA9vJ5diFNGWF/3ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=kN7alnMn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="kN7alnMn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso45681545e9.1
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071183; x=1778675983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=kN7alnMnOMyXU4H482oQdv3HwPLilXiX6/vOa8/br9j7nTSO+cqGJbeyP1q3tTVKyZ
         LntjB2EcJskhXPIl9j3l6ngvnvFznYYOyLQ25P/7F9LfDua/bRX/mH4vtpcOleOllU3X
         HDBx5FSFns6a/zmXf5mg5gl1aklov8GhB46olnWuSyg3q9Khau7HhjOls4GLzeEbnobm
         iru73HNrQZyh51wttt0DxeLBXgYHevosQs/Q34f0VfIC3xFF5AicBEm9ek65jsb2fxaw
         p7rRekdub/ZwjgEXmNkTjEkKmOwcveUT7lE7/vv9kEsDNPexTu9kP9oLU1yaHRFuId2v
         +C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071183; x=1778675983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=LiQ7ylwPieJNS4K2+OPLdtIlnNLrMMpfs7uz+Zsb/KbH8gqqvRshgyj8Q1Qem8gYMD
         LvxrIBOG9ahYcw0pzVhtRT7athKyE5BYIBBBFSWYxJzs9ZojLjMlaVq/amwzo+Bc6qYT
         TdMM9erIm7B1aeY2lTUDmLKJ5UD6kMxUP3exHthC3qCrCyfYJjFPaYCVPiZhMTSgQA8h
         HBTs6uJsimGp435GPP+1dsCaTZOEM53Xyyhk0BcHw9WrlziM5L5BQwQKWJzQs3UgLKv1
         b7haeR+27zwrj04M68Q2YjP+7S85U71VdLghNdWyo26GwLY8Fi9OeF33DHG5jmyVc2N1
         3WBA==
X-Forwarded-Encrypted: i=1; AFNElJ+IsiaBH9CF/kCM6kXb7Ig2ThTKyIYuFDwK3RBfeGTS7FlwS7+hFw5stdF8TUxg+VcXNfwusuWEGmBAww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOSPsiK5IKRYfEMTqi/VbVlwuJ6dnDyMva4XKahuUoWhQSkTr
	HNGlAxBHK7ZwDcOirPv99rjDkrV+dwVx6l/z+kDtFjIPJriE1btGAMREoKoX6s7hnE4=
X-Gm-Gg: AeBDietzPxSdjD8T+7OXwGwQQdDvqU+JqfnvoZJ666ieQJX/Uf7TZl7JakQZe78bfGe
	cB4UBf63ESf+Re1Uu1HIdy4evfNR/YsDqAJgrhzzk6Qj9PRvZXJJRswhxV5DAyn+ZKOKzXHoRvW
	U+/qWi9hf/KHmTN753qadXK4AazJde8OPIYVuIP7gucYEQdXsrdrVqn2Kq4IRyJRZlCLRo68HMp
	NFgvC9vajHMkPD3KksBUW7o7/SGeq5ip9WIMUOuNaoemQkjcVl/PHkQT8JI+VaUp8P5pBGaFILz
	A6RYlw8EO4Ma+LqY/nnQHQkQq2fyWxgAFQ5tae8G8q90RrTlVCJQmeNHvAqIMuqWRARIIqj9DxC
	msZh4AHebvZqVkyq72GdSpV9YqU8VdoDyTMGimnU3hkawwjuTgdC36NC9MIU4OvcG6XaS2u42jF
	59HFUaDaJxpSnE7KTgynZ3vyZLK4yy056Na7jIO+NrhzI2eJzYIYM+PdKJB3wvFDPT7T8vFpNwS
	Ys5bUNlC/F1yb0D3VaEG0gOOl12yUCn
X-Received: by 2002:a05:600d:8408:b0:489:fec9:a17e with SMTP id 5b1f17b1804b1-48e51f30534mr42486405e9.12.1778071182844;
        Wed, 06 May 2026 05:39:42 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891d62sm76399015e9.1.2026.05.06.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:39:42 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drbd: move UAPI headers to include/uapi/linux/
Date: Wed,  6 May 2026 14:39:25 +0200
Message-ID: <20260506123926.1944290-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
References: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
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

