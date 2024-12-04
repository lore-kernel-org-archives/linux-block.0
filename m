Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6220C47E;
	Wed,  4 Dec 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323518; cv=none; b=huqSg6k3Xy8kjJotZs6N24DAF7Ho+eVQ47up9WKopWyNfaLEphjOX/9XnXZILPG5sEo+P7i74mHlSXaonRMdbH98Zh7pxQm6x7eAl1qfnuwAVG4y2jFLaSXJ0v8U2m6ggcf78lNCZpIy63Z6Q5CBoCGqZ3pkSCuozgw8rBjwtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323518; c=relaxed/simple;
	bh=DDSRLCpM6+TmkYc6in3pc5ISUjh+R1zgQNtHuLkPJas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDVZhWsaRT92+OtuGjBxnoSbyWHfFNCxSRNPmepyU7GHCJus8GGGNcZdoVDDWwn8YjRjbQNUcDe72mZcUdhWEliy/TSd+kaFZ2HejT0uArV8ZTTll91er8rlxtWHl62dgTOIwEXi0zEQvqP9UPBvNP1Fp22aYeJKN6UP4mKDuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee867506af520a-09256;
	Wed, 04 Dec 2024 22:45:12 +0800 (CST)
X-RM-TRANSID:2ee867506af520a-09256
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.28.197 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee367506af6326-714bd;
	Wed, 04 Dec 2024 22:45:12 +0800 (CST)
X-RM-TRANSID:2ee367506af6326-714bd
From: liujing <liujing@cmss.chinamobile.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] block: Fix the wrong format specifier
Date: Wed,  4 Dec 2024 22:45:02 +0800
Message-Id: <20241204144502.7960-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate a static checker warning. The type
of 'size' is unsigned int, so the correct format specifier should be
%u instead of %d.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/block/bio.c b/block/bio.c
index ac4d77c88932..3a75de450799 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -89,7 +89,7 @@ static struct bio_slab *create_bio_slab(unsigned int size)
 	if (!bslab)
 		return NULL;
 
-	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
+	snprintf(bslab->name, sizeof(bslab->name), "bio-%u", size);
 	bslab->slab = kmem_cache_create(bslab->name, size,
 			ARCH_KMALLOC_MINALIGN,
 			SLAB_HWCACHE_ALIGN | SLAB_TYPESAFE_BY_RCU, NULL);
-- 
2.27.0



