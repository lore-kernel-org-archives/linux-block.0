Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00736EABF
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027305; cv=none; b=HVU011WlTBZDqLtiE7Tkq6ZrorDHQCRNS22QK2KntyogRSQ+jcg8dcF6Pzbcp6s8V+cs7YWcaEIbpcXDxP47FgeefyZdB0jdo8RlE3oFqO1Jz7qUc7Ua96l9UivJq2AWP9+/QdDk8fFO9Ai8MFW0ubU6hcMjOaOvBze+ln5IVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027305; c=relaxed/simple;
	bh=TYhSlU4/FbYqDOceRoi1fkuBi+H5qncNaY2MhxHMmp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRZQIIe4ZUQlZt/vkndusyLE+FxpNEkBmu0mF9rrAipJkmS7ALhYsCudB9KQXmNCKyhkhU5TimoOvYefr3CdeVr8FPyBCmIfj10lTWr5B6dzCi/1LownhKXOAXBwV7efZCoV0O64T3QsQCfaMyTCnJ3OcdI65onRVM9Jn0e0TwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kSLfCJ1c; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kSLfCJ1c"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8IgJ74GCFlgTb1Kks80tm2nMxIzYm3DwP8MNZYWorE=;
	b=kSLfCJ1c1nTU46+7hnKLHM6VjlWpoosszUKlRtn5D1TWlgaUEFv+qApbp/pva+FwlbRaAd
	LlJ+ALMxGV51ccHyjC9Lur8dKqde06NCI+rmzYzRMW4YDYYQeWudNy01HFZlw2jlaikyrz
	tCYbsGetmwoEvGo3X3g9U0iTZc5syr4=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 06/10] block: convert kyber latency show to sysfs_emit()
Date: Wed,  1 Apr 2026 15:07:12 +0800
Message-ID: <20260401070716.991-7-liu.yun@linux.dev>
In-Reply-To: <20260401070716.991-1-liu.yun@linux.dev>
References: <20260401070716.991-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

Use sysfs_emit() instead of sprintf() in the KYBER_LAT_SHOW_STORE
macro for the kyber I/O scheduler latency target show functions.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/kyber-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index b84163d1f851..4c8070563042 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -852,7 +852,7 @@ static ssize_t kyber_##name##_lat_show(struct elevator_queue *e,	\
 {									\
 	struct kyber_queue_data *kqd = e->elevator_data;		\
 									\
-	return sprintf(page, "%llu\n", kqd->latency_targets[domain]);	\
+	return sysfs_emit(page, "%llu\n", kqd->latency_targets[domain]); \
 }									\
 									\
 static ssize_t kyber_##name##_lat_store(struct elevator_queue *e,	\
-- 
2.51.1

