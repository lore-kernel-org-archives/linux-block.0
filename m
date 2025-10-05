Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FC259C80;
	Sun,  5 Oct 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759668828; cv=none; b=ggWsH3wO+XEBhb1t1MUnwKP23301RISlSrKpWSELbJL+0ZUbVCj4ofzt6xrnOtb6rHzPegYra7dHRVzptYZl6duONw2DFHaqikoBbOjvoZaBP9eOUOr8bZFP4wFxTgVbjK+zNXV1Gz2rAUSWzEXoNqk0KB/3sjDCTSHJ6XoZpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759668828; c=relaxed/simple;
	bh=LtmQ63cFAlQoXFlQnT81xNdE1BLSFAbSS3NPLhJHSlk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uKrENOWNvrwhtntEEmp2p8QnfCMVCvFbuiinZP/lxy6YyynL+Lu9i31UIHqDslTQosy+bHDT1WDZmuSLgGX1snvxsU7Drz9Q1HA5kDnfKUmCqDq3PhCrTWy+hbiegnVSMrA0BSD9rB+06UnYZO1jWUtvUxilECGmPkc7Lj5CRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Fushuai
 Wang <wangfushuai@baidu.com>
Subject: [PATCH] loop: Remove redundant __GFP_NOWARN
Date: Sun, 5 Oct 2025 20:53:26 +0800
Message-ID: <20251005125326.29432-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
remove the redundant __GFP_NOWARN flag.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..219f39f0afad 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -822,7 +822,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	if (worker)
 		goto queue_work;
 
-	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
-- 
2.36.1

