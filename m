Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9E16CD03;
	Wed, 31 Jul 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409443; cv=none; b=PUQvbaY1XmmCHuEzGa8N/fQ293bJpD9+fL/J+Tam2vf70nqJXcfll7FvuS0zkrOo8FYWmD0Vm6RHlXnxhcIdeh73IIIe9or7OntvmvDDpEmqq9NAcYYq+mKaQWe9m8R4svdCZb4pYfsAj0aH0LIh21+fUWW811bDPiuAXbCqDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409443; c=relaxed/simple;
	bh=IXtc+vSUzAJ4RGLHgjuucvwOnmcaeyZSx+7/uBxXmWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APGrY9VQQ9sXXhnT1bktFMwZ3WWcQDJ6SCqc21Oq8WaeUiyuHGDHDF/C2pW1tdCMheNj4dz/KFJ/U8gOhRbU9U70Xiwz4z2Ua+8Gk7IKht0FetKPS2I5JIdSi7eAhxhbqKiR9iJtX2X+BdKQl421MI4ONfIjmCb5RzsF/3vfikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46V71uDV025236;
	Wed, 31 Jul 2024 15:01:56 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WYjYJ4X9qz2L2d7h;
	Wed, 31 Jul 2024 14:56:04 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 31 Jul 2024 15:01:54 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <axboe@kernel.dk>, <dlemoal@kernel.org>, <hch@lst.de>
CC: <bvanassche@acm.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V3] block: uapi: Use unsigned int type for IOPRIO_PRIO_MASK
Date: Wed, 31 Jul 2024 15:01:27 +0800
Message-ID: <1722409287-12183-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 46V71uDV025236

Generally, the input of IOPRIO_PRIO_DATA has 16 bits, but the output of
IOPRIO_PRIO_DATA will be expanded to "UL" from IOPRIO_PRIO_MASK.
 #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
This is not reasonable and meaningless, unsigned int is more suitable for it.

So if use format "%d" to print IOPRIO_PRIO_DATA directly, there will be a
build warning or error showned as the following, which is from the
local test when I modify f2fs codes.

fs/f2fs/sysfs.c:348:31: warning: format ‘%d’ expects argument of type ‘int’,
but argument 4 has type ‘long unsigned int’ [-Wformat=]
   return sysfs_emit(buf, "%s,%d\n",
                              ~^
                              %ld

When modules use IOPRIO_PRIO_CLASS & IOPRIO_PRIO_LEVEL get ioprio's class and
level, their outputs are both unsigned int.
 IOPRIO_CLASS_MASK is:
 #define IOPRIO_CLASS_SHIFT	13
 #define IOPRIO_NR_CLASSES	8
 #define IOPRIO_CLASS_MASK	(IOPRIO_NR_CLASSES - 1)
 IOPRIO_LEVEL_MASK is:
 #define IOPRIO_LEVEL_NR_BITS	3
 #define IOPRIO_NR_LEVELS	(1 << IOPRIO_LEVEL_NR_BITS)
 #define IOPRIO_LEVEL_MASK	(IOPRIO_NR_LEVELS - 1)

Ioprio is passed along as an int internally, so we should not be using an
unsigned long for IOPRIO_PRIO_MASK to not end up with IOPRIO_PRIO_DATA
returning an unsigned long as well.

Fixes: 06447ae5e33b ("ioprio: move user space relevant ioprio bits to UAPI includes")
Cc: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/all/1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com
---
v3: modify commit message according to Damien Le Moal'ssuggestion
v2: add Fixes tag and Cc tag
---
---
 include/uapi/linux/ioprio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0..9ead07f 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -11,7 +11,7 @@
 #define IOPRIO_CLASS_SHIFT	13
 #define IOPRIO_NR_CLASSES	8
 #define IOPRIO_CLASS_MASK	(IOPRIO_NR_CLASSES - 1)
-#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
+#define IOPRIO_PRIO_MASK	((1U << IOPRIO_CLASS_SHIFT) - 1)
 
 #define IOPRIO_PRIO_CLASS(ioprio)	\
 	(((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
-- 
1.9.1

