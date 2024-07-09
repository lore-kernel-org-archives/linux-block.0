Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF9155382;
	Tue,  9 Jul 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518873; cv=none; b=ePLjj1m2p528W3IFngENHIxU//TqWm3s7+PHvUsi9seppb9F8BNh5+hTjb4DF9t9SE6L7bz7bM+BUoMnOz57kmSWdRDHnoSTk1utYMdgxyK+S88dyJsnIt9fusSsLdSafJ+1TkQcsOQ3wvbuMxBedK606J6ldpzfbBAxmyf8raM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518873; c=relaxed/simple;
	bh=f3W3oZMAYv6oLWkJ3zHuAsWPGs9WWySUB39Nwpx7BDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Usvldb+XTFAPcKGHOxK2VaKR4fcmmX/iRzm4HGY7Z3V5HchM9T1Yll5bcyhjP2Xln6lND88ZlHY+fXRq8jqzgWp7CuR1LCKv6Ski+ppVdy52bE9D0q7OD/wIjka4Y9PZFZVyog2vWfMyJ+II466oifAsszrJT4jp/YrgDC8/kFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4699qMQs091223;
	Tue, 9 Jul 2024 17:52:22 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WJGNx6NwHz2KkvV8;
	Tue,  9 Jul 2024 17:47:13 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 9 Jul 2024 17:52:19 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <axboe@kernel.dk>, <dlemoal@kernel.org>, <hch@lst.de>
CC: <bvanassche@acm.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V2] block: uapi: Fix compliation warning of using IOPRIO_PRIO_DATA
Date: Tue, 9 Jul 2024 17:51:52 +0800
Message-ID: <1720518712-28301-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4699qMQs091223

Generally, the input of IOPRIO_PRIO_DATA has 16 bits. If use format "%d"
to printk IOPRIO_PRIO_DATA, there will be the following warning or error.

fs/f2fs/sysfs.c:348:31: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
   return sysfs_emit(buf, "%s,%d\n",
                              ~^
                              %ld

This is because the output of IOPRIO_PRIO_DATA is converted to "UL" from
IOPRIO_PRIO_MASK, which is not reasonable. unsigned int is more suitable.

Fixes: 06447ae5e33b ("ioprio: move user space relevant ioprio bits to UAPI includes")
Cc: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/all/1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com
---
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

