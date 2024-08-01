Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D213211A;
	Thu,  1 Aug 2024 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480240; cv=none; b=UNP6GsExpN7A+Ca6WI8wYLF3oMqrR4OTY6cLJd/P5XJ+tbkIKQiOVfUlXG6Yio7s3JEBMvav2TWZ3VLoFwA/JIVgF6vk4XbR1G6neIlx+CVBQKxIaDdX53rK6Dz/ZkMbPZQKQvBKE7riLTeIw14B5LP/wV/pXUMXhYO4k4xFcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480240; c=relaxed/simple;
	bh=p8WapLWI8NKWhVwG+x2/+3YXF4bmzINsCjHJMt3aowU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uyVH3YBeMW76Kp3+nm1yem9JIjBm1Sn+qp0p5RsSveB73jdatL3l5PQgLC8xu9csC2xG8J7FRl5kHLZjf3xAzgId3mNJsvgphcsXN3W2kgwHqCheDB58FwJVqM7ZjODObpuR65rFcS8Z2AJ2pgH93Wi3F2xzD+NRkIm35Ece9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4712h4l5075897;
	Thu, 1 Aug 2024 10:43:04 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WZCm64cCsz2LQJ6l;
	Thu,  1 Aug 2024 10:37:10 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 1 Aug 2024 10:43:02 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <axboe@kernel.dk>, <dlemoal@kernel.org>, <hch@lst.de>
CC: <bvanassche@acm.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V4] block: uapi: Use unsigned int type for IOPRIO_PRIO_MASK
Date: Thu, 1 Aug 2024 10:42:26 +0800
Message-ID: <1722480146-22924-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4712h4l5075897

An ioprio is passed internally as an int value. When IOPRIO_PRIO_CLASS()
and IOPRIO_PRIO_LEVEL() are used to extract from it the priority class
and level,the values obtained are thus also int.
However, the IOPRIO_PRIO_MASK() macro used to define the IOPRIO_PRIO_DATA()
macro is defined as:

 #define IOPRIO_PRIO_MASK        ((1UL << IOPRIO_CLASS_SHIFT) - 1)

that is, the macro gives an unsigned long value, which leads to
IOPRIO_PRIO_DATA() also returning an unsigned long.

Make things consistent between class, level and data and use int everywhere
by removing forced unsigned long from IOPRIO_PRIO_MASK.

Fixes: 06447ae5e33b ("ioprio: move user space relevant ioprio bits to UAPI includes")
Cc: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/all/1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v4: modify commit message Suggested by Damien Le Moal
v3: modify commit message according to Damien Le Moal's suggestion
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

