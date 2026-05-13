Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0F3D3319
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670243; cv=none; b=kUKatML+E2K0M2uL6rp2z04r8CvW2ZqyU3l3z+EVDnNO9wYoszdr/MxsoK3YjpBxw0e+z4vdao2dgouvEgj7OPOTN0+/PjeQfpZFO/RKpHUp58BaKSMaSqRsyehdGIvashHvTFrb6uTygaj+NWtZA20xE2dh8PEJnZiV8KOwu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670243; c=relaxed/simple;
	bh=K7BijF+4pvSiGwWbTjUVNO5a0o+ZiWOZ+bBEO/RlWLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi+V6Gp6TlY3FVB6UALTlB/G0/r2bOvxEdxZRynPwjxGrMshyOhppFCklsbyJxxiixl29dUIp+PlF+FuN9pt+Ys7USVmwmUsaVM9vbRqIOPkddCQ0rh6P1uRi/jO0u4XfQMbgp2O/+M5dFKF+qo2JbJ+0LR4RFg1HnOm103wYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=d9xXK0UK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="d9xXK0UK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4585a116a4aso2590543f8f.3
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778670239; x=1779275039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPoijdvfyfbhp5R8nin4PeEtMV5ISfc/KYpiYJU2YHg=;
        b=d9xXK0UKYNwWlzfPIU4GpMJFiJsAqkdDE4l7ypQ3Pxs0Iv7k/uRCNRqxitsKODHG2V
         OXN4rl02qC1f/bVfB7kN6wWrRndANC4emnf9wiU54mgcGpDibYAcIUCik0TFgPUfixXr
         tSQDD8Lv4HRHomCt+Id/5N72Vu+aX+FWCgjLt8/tQlt6HSN3x40VRrW5TPdW7Lbhr8W+
         wES9SnY3We0XU0CxBOuj0b3mzTee0FFp7gCtnq5vgAt2lLDtYK5gjIx/DJpp5K6+R6SX
         b1LJv1D1/4D8aM8efWrOhhKuR1FjMDOAoetEGGf0Go/KDoiOgs/livHZt6yL7V6jY7b6
         PQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778670239; x=1779275039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPoijdvfyfbhp5R8nin4PeEtMV5ISfc/KYpiYJU2YHg=;
        b=bwutJ/RkNKfmg1XFmPAJ9k/4rIIbRWqswTJuk6RmE860SW/zanlJToDbvOb+T94jPk
         bRRPa2g4ReEp9lhhmNFK4g5Wd9NoYvTD4AaiBUPV/wLtJ+BXMBJTZYY5E9MRsNydcMYH
         0B5aikgQZtB69/B666sBR5t21f7FLi9Pn6AgsFaLWg6SpcR9ZX4E1GF+FBpl6pfnScxv
         wsB1184Ao/n+yGD2dPhXh3udbbE8MCfO7Zl+D2AkLTMNJY6ROfU1nkJq9aLpGgPJOICa
         H6iiCPhVFJYPkPjM5wMuvinQKlAnPo03Qe5FQgdvJHH7G2BeOfTvCcd3lkTry4NuvIUb
         9OZA==
X-Forwarded-Encrypted: i=1; AFNElJ8MxdWi9FeXWjD5dm9s/6776wfY1wRSrCYPWgQ+AidoKhwdRomWOk635uMdYvCe/MAZTgAAp1UUWJiZ0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzoxG8ofQ28qon/Xi2zCgr7VuUECPeGxZfVvrEwMyoDcVkLbO
	ExXhOhMRsi3uiuxNjHYSWqsclebLQoz1ND/41tApA8CkbIsNY9usN+ytL7uyhga1UcE=
X-Gm-Gg: Acq92OEyPLJTWrRBFTxZjrWEIfWC6UHwjpT4x3DH6lH/2MFKhlu/92yeT8XpQCJOkLV
	8MrkRqf6O6uG3/RXW7qJ0Mdk4Z11piwY8BELu1XvHlk49hF5U81APXIBN1D2pCAaDDDiH9MWlkm
	bSwoew3FAyeVaRMXcb6e2iwNt1F0iyDZ+UfkS0jEHXNxVaDRn0gwdqyjjfdpOkCcH22s5ZZxXaG
	82qTIMQwIKNM0YeProdf3NSINXPl1yb+kECCZ+nDDR3kfJOOhgwdCYVEC0/ckk4LkQW9HLdcyHl
	SD54k42I2C58EGSo4/vsZR+W36lVCx2LegsevmZNAdaP7c/Uz5ha2I4WIs5J0ZAH+/lx3XvGWw4
	zMOHLf7eLqDF2AWe5nDRyAGsdj5gBoLppt1FDcgZPtOcLeJJpICszIBi+IGliqiqzu32IbKkdt3
	gqgcEFhOGvtM0RvEtFyChPIJEO7oZSnN6qcCB69UfN69pvJS7hZQi+Fvaf5J92YXYeDstl3c+MB
	nbhElp887rhUG7qCWu+pg==
X-Received: by 2002:a05:6000:220b:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-45c79586f68mr4008555f8f.17.1778670238975;
        Wed, 13 May 2026 04:03:58 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm38469217f8f.29.2026.05.13.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:03:58 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] drbd: clean up UAPI headers
Date: Wed, 13 May 2026 13:03:42 +0200
Message-ID: <20260513110343.3170338-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b1798910fc7f ("drbd: move UAPI headers to include/uapi/linux/")
broke compilation on targets without a hosted libc:

  ./usr/include/linux/drbd.h:18:10: fatal error: sys/types.h: No such
  file or directory

The underlying issue is that there were some constructs left over in
those headers that don't belong in uapi.

Drop the __KERNEL__-gated split in drbd.h. The !__KERNEL__ branch pulls
in <sys/types.h>, <sys/wait.h> and <limits.h> for symbols that the
header does not actually reference; they were carried over from when
this lived in include/linux/.
Replace <asm/types.h> and the entire #ifdef block with the standard
UAPI combo <linux/types.h> + <asm/byteorder.h>, which provides
__u32/__u64/__s32 and __{LITTLE,BIG}_ENDIAN_BITFIELD in both kernel
and userspace contexts.

drbd_limits.h references some enum values and the DRBD_PROT_C define
from drbd.h, but does not include it. Add the missing include while
we're here.

Drop the unprefixed DEBUG_RANGE_CHECK from drbd_limits.h. It has no
in-kernel users and pollutes the userspace namespace.

Switch the drbd.h and drbd_limits.h include guards to the _UAPI_LINUX_*
convention already used by drbd_genl.h.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605101346.V2wwJqv1-lkp@intel.com/
Fixes: b1798910fc7f ("drbd: move UAPI headers to include/uapi/linux/")
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/uapi/linux/drbd.h        | 28 +++-------------------------
 include/uapi/linux/drbd_limits.h |  8 ++++----
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/include/uapi/linux/drbd.h b/include/uapi/linux/drbd.h
index 5d4d677cf1ad..cf1ec3eb872f 100644
--- a/include/uapi/linux/drbd.h
+++ b/include/uapi/linux/drbd.h
@@ -11,32 +11,10 @@
 
 
 */
-#ifndef DRBD_H
-#define DRBD_H
-#include <asm/types.h>
-
-#ifdef __KERNEL__
+#ifndef _UAPI_LINUX_DRBD_H
+#define _UAPI_LINUX_DRBD_H
 #include <linux/types.h>
 #include <asm/byteorder.h>
-#else
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <limits.h>
-
-/* Although the Linux source code makes a difference between
-   generic endianness and the bitfields' endianness, there is no
-   architecture as of Linux-2.6.24-rc4 where the bitfields' endianness
-   does not match the generic endianness. */
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-#define __LITTLE_ENDIAN_BITFIELD
-#elif __BYTE_ORDER == __BIG_ENDIAN
-#define __BIG_ENDIAN_BITFIELD
-#else
-# error "sorry, weird endianness on this box"
-#endif
-
-#endif
 
 enum drbd_io_error_p {
 	EP_PASS_ON, /* FIXME should the better be named "Ignore"? */
@@ -432,4 +410,4 @@ enum drbd_state_info_bcast_reason {
 	SIB_SYNC_PROGRESS = 5,
 };
 
-#endif
+#endif /* _UAPI_LINUX_DRBD_H */
diff --git a/include/uapi/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
index a72a102d1ca7..acefe84bc602 100644
--- a/include/uapi/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -11,10 +11,10 @@
  * feedback about nonsense settings for certain configurable values.
  */
 
-#ifndef DRBD_LIMITS_H
-#define DRBD_LIMITS_H 1
+#ifndef _UAPI_LINUX_DRBD_LIMITS_H
+#define _UAPI_LINUX_DRBD_LIMITS_H
 
-#define DEBUG_RANGE_CHECK 0
+#include <linux/drbd.h>
 
 #define DRBD_MINOR_COUNT_MIN 1U
 #define DRBD_MINOR_COUNT_MAX 255U
@@ -248,4 +248,4 @@
 #define DRBD_RS_DISCARD_GRANULARITY_DEF 0U     /* disabled by default */
 #define DRBD_RS_DISCARD_GRANULARITY_SCALE '1' /* bytes */
 
-#endif
+#endif /* _UAPI_LINUX_DRBD_LIMITS_H */

base-commit: 8098eeb693c4cc4e774c62fbd4875197cb5578ce
-- 
2.53.0

