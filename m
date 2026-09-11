Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C8377A9A
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139118; cv=none; b=JGJOB6WeK0ij3JQVZUT4csLUGw2NfBzdp/ILokaQ3m3t3x0BmupW8MduaoW3HVjsEoFenkWdUTDxSuMJ1a1hDIHgkucyEQDklvKZ/Hw3r9XRCTWYUxy80bsK7A+opUROXUKdSA0UdEuyCxQOf7pl+ZTnduL0MkMUB2df6yatlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139118; c=relaxed/simple;
	bh=jx3j2XbXWnO55UDnCdyL4nYB8h7oZRpXcwhJjfFasT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbuGusLJB3C/CxOtaXH4JRsioE3qTMvdGnhc6rh2mbEvXFxxBGLuEa+r0SXHjVixBT4O1jfDhNCY1FU01bkC7aP9vPL91IbprFI13XS6xgj8sKiFq7ovnqi/TaBrBNwTnIKcayKHLmfaBNCf6za6rJqrlRewywpdDdXauz6+YR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MZduPaIz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MZduPaIz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so6724265e9.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789139113; x=1789743913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XKohTBQhTvhy9wNz0LcPmFyXDw2Vls36EVI0PSYF1LE=;
        b=MZduPaIz+l8Za7XdIBJ01uZ3wldcJoGuDoHHInjQbkz/cqJ/3CD2lScvmKTTiWjYin
         +h0misW0DqVQmTyHDIv64TtRvgb80h4iTOlNEGtE/2hrIKGMT00q6Doy3JkXUjbY5mlo
         raaQvuIkcG2UsgEIvq1UgsobMXJMJrHnyVn/5fUIPamySp74mubvNeaSh7Po4h91rRra
         DyT0X9PuoihJ96RNYis9ozRlXBKx4zbV4edN5ux0ULgg5I0aDEWNls4k2iI1nmS5V68Z
         DkWBTyocYP4mW9xakgPG28XvSa6bDqSizN0ljrPfj4h3GV+w9LHgCpr5KXfERvJC4+Hf
         NLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139113; x=1789743913;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKohTBQhTvhy9wNz0LcPmFyXDw2Vls36EVI0PSYF1LE=;
        b=nszWXL3/Fu5VhT54SiFCsbAN/DKz+j8JauyZfyFKzsbo4GKmOdKLtUt9l2gCeXw5oF
         93b3eWQ++PLw2qHodg+hxLwS8CQSZyThGlwy/q3bqEYUnyZDeND3jV4WmUClb+kMVOhf
         PQianwQZIISqRD5Vt7gXP7X5z8WygPE6/Cq+YDsFMsvqW3iMOEXlsNAbHo7n+goU6or+
         dQrA4o+VaFREGx+jv6349Gc+iDFEPxI+/+m8gCNuL9o1iiemy9gYNOELAjG8uUmKrP2S
         I3MzFwUJd9U7aiN10BY/6bza1UGKwVkWQT44nC1cJNcvaAnFvGxUsB7Qf85j6GjBIOFO
         W2vA==
X-Forwarded-Encrypted: i=1; AKwUvByGDburZCu3lgI+xpYbQfa7bZWOV+Z348aY4EjotaTB4+3yKD1zEx++zTp6zc1eA2fo/fFDy4ksQGajhQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nseCDDfDLJ8Ly86/iLCf4nQooPo174bOP/rHFJXbUxIolJhP2A
	fArbw1LvXMs/aI56keD38n5kHPna3enJM5w9iA5TQKVLRahPx2WZBrLXAVTfJR23GRI=
X-Gm-Gg: AYBFou30WSaEUQM4+DLYnXohGBgnTgUGKPKP0vJRgZJ4mtrs3xnv/Wg+evWQKe6Ie57
	c1ctNot6W7R9Pq0drPJlMmy/qbUe/GKNbNmZe1vASL1VpzWmq/qd8hNeAkxbqj0b/KU/XchT+1B
	I+7gJL2GzcBOUX6VK6ibAT0d3z+BV3s6L/ag5nskaJL4FEXAA0JsTmBSiMYaRIpmktCvyrM3Euw
	lhNqnUPVF4tzONhimAHhPxewE2qKwbGkboiLMbCqtvei0ATb7zugLzljuBBDO5jQaAlaWpk5SoZ
	eLHrmF/gRakDYmKqdmQGOW4uhnp28adqYOi97GSvXY5aPIuSaBVv9F1w24RB8/yiz7MOpYO2IpA
	WhYdE4CJWMfwSYY8CRIG1GL+LdiFtwXkOzGYOmc3OrXIkFvzVEUO06pYyRE6kQwpgA00qevOEbc
	4/jIdDg+y4PFvDwmYg2L5oa4LDHkJbrST0P4Vxwmt1FQiekgqCR4giicEMCAZaKNNnxn10b4PMc
	9k2Mg==
X-Received: by 2002:a05:600c:540e:b0:49e:6692:27fd with SMTP id 5b1f17b1804b1-49e66922810mr55050755e9.2.1789139113470;
        Fri, 11 Sep 2026 08:05:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm6853579f8f.27.2026.09.11.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:05:12 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Francois Dugast <francois.dugast@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-block@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-api@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] drm/i915: Include error-injection.h for ALLOW_ERROR_INJECTION()
Date: Fri, 11 Sep 2026 17:04:04 +0200
Message-ID: <20260911-module-include-error_injection-v1-4-5da895d8c84d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Several drivers/gpu/drm/i915/*.c files use ALLOW_ERROR_INJECTION(), which
is defined in asm-generic/error-injection.h. They currently rely on this
header being included indirectly through linux/module.h ->
linux/error-injection.h.

Add the missing includes in preparation for removing the
linux/error-injection.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/gpu/drm/i915/display/intel_connector.c      | 1 +
 drivers/gpu/drm/i915/display/intel_display_driver.c | 1 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c           | 1 +
 drivers/gpu/drm/i915/gt/intel_gt.c                  | 2 ++
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c           | 1 +
 drivers/gpu/drm/i915/gt/uc/intel_uc.c               | 1 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c            | 1 +
 drivers/gpu/drm/i915/i915_driver.c                  | 1 +
 drivers/gpu/drm/i915/i915_pci.c                     | 2 ++
 drivers/gpu/drm/i915/intel_uncore.c                 | 1 +
 10 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/drm/i915/display/intel_connector.c
index 7ef9338d67ab..a287884c0045 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -23,6 +23,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/error-injection.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 70d112fd4287..204810a11e46 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -7,6 +7,7 @@
  * details here.
  */
 
+#include <linux/error-injection.h>
 #include <linux/vga_switcheroo.h>
 #include <acpi/video.h>
 #include <drm/display/drm_dp_mst_helper.h>
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index c0fd349a4600..2c3bc7b67c0d 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -3,6 +3,7 @@
  * Copyright © 2016 Intel Corporation
  */
 
+#include <linux/error-injection.h>
 #include <linux/string_helpers.h>
 
 #include <drm/drm_print.h>
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index 5c7f862f7100..2f0e1cb5578c 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -3,6 +3,8 @@
  * Copyright © 2019 Intel Corporation
  */
 
+#include <linux/error-injection.h>
+
 #include <drm/drm_managed.h>
 #include <drm/intel/intel-gtt.h>
 #include <drm/intel/intel_gmd_interrupt_regs.h>
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
index 1c455d84bf9d..091aa33f624a 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/circ_buf.h>
+#include <linux/error-injection.h>
 #include <linux/ktime.h>
 #include <linux/string_helpers.h>
 #include <linux/time64.h>
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc.c b/drivers/gpu/drm/i915/gt/uc/intel_uc.c
index bd07c72a66fc..d367a897c86b 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc.c
@@ -3,6 +3,7 @@
  * Copyright © 2016-2019 Intel Corporation
  */
 
+#include <linux/error-injection.h>
 #include <linux/string_helpers.h>
 
 #include "gt/intel_gt.h"
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
index 7fac97fe30a6..d7c731fe972b 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/error-injection.h>
 #include <linux/firmware.h>
 #include <linux/highmem.h>
 
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index ce6d20958320..aeb7b24c81c8 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -30,6 +30,7 @@
 #include <linux/aperture.h>
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/error-injection.h>
 #include <linux/module.h>
 #include <linux/oom.h>
 #include <linux/pci.h>
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 2f03f95945f1..84a7dc6ab5db 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -22,6 +22,8 @@
  *
  */
 
+#include <linux/error-injection.h>
+
 #include <drm/drm_color_mgmt.h>
 #include <drm/drm_drv.h>
 #include <drm/intel/pci_config.h>
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index 170e83a8c9fc..e360e4f9d9a2 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -21,6 +21,7 @@
  * IN THE SOFTWARE.
  */
 
+#include <linux/error-injection.h>
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_managed.h>

-- 
2.55.0
