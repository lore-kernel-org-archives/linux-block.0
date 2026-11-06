Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981204;
	b=xMmBz4LIrvAhBpXqI85UYHF98LXEJ4xSLOyFc68CGGZ2dnl+r8Xn98vVqmLMtP3h2MGM
	 lEWXyzvCMg7doKgjbfDHliiW3Ap0dW2+ep75+gyDJa5M0PL1WtOgIwvEZNwNJvBn5iPWN
	 8ONMch8EYh/Ed/6v6SmouzoCRnjo3GDX2709xn6TvUQzNbesaY3Fb2q2jQeQBhAks98TB
	 uhWfTTr7xSrD7vowZIH6eNaSpFeODN6wbeEKihj9zI+mXaNWY5Lz01gbxuKZcSGwRWln3
	 x/TnT+XtlYCkpVETl+yT+Rj/cSo1mbzqUqit0gcYzZ5Mea5WQ8qvpnsitOroYt3FwLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QyITsV3GE2/jXTbu1YbYi8AKwMzzCHCnDzYN+d5C+sM=;
	b=wKUu3RVnDbhDnrggZDitrZsH+uiNa8a+EZZ+BZYZR1DtXZ8/k7kkpeOYqLiK52UC+R0z
	 qHbX/vX8K7xDogo63CdXOslxb2WniuqtpQ3bnGHMf0WNy1V8tep4t0sre3D1zEtsQvb2K
	 +AACUqDJol3PgrtJEnfJqjZaWomgJbswO5iA4ofsp/TDetwRq9bz/9WM82Ed4kRSnjlMY
	 TNafbDa40bJc+Xasp2JY0pXJ4eHQwtzfNBIYdITYpEnEad65sFiPvymruHUiJSmizvVo9
	 vQvq5O2bxHAQ/anrCgulwIbfqv5oVLhkt1g9S8NIvwXVZQRnUlO7BZEpi7MY5BKBwfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0DWq6ujn;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EE606A326
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 16:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0DWq6ujn
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364648ae07so6978871cf.1
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 08:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981203; x=1794586003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyITsV3GE2/jXTbu1YbYi8AKwMzzCHCnDzYN+d5C+sM=;
        b=0DWq6ujnkqOBlw0+5bxao6e+MKKW7YSzeADPnVGzfA5v1yCZ1ZASbKVO5eDYua21wk
         3KVCLbGDWAO2M9OCg2XemszoBedLtHvb8jmlZhgxJvivkZPV2BB0a8mxHzr7vbGpwowZ
         c8bLecdsp40oDD8s09osS/RBuGXKrjbtyz+wt57DfyXT2nVqSsMDp2ar4PmdSYVE64v2
         o8YvqP5H4Vwrxw6vtNTrjuAhuY9AVzxtvphNakmzOVknVAfuZk3rhXi5F59qjkM8OrKf
         Ol5f3l91qzfbgKA4msmxHzQyu+WiK91TTJQW6UScY+Vj5j383nGBX6Z/zjpbUyb270f5
         2zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981203; x=1794586003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QyITsV3GE2/jXTbu1YbYi8AKwMzzCHCnDzYN+d5C+sM=;
        b=ynO7JPkYOAtf545UoDXrdykucmG6gN07jOlDBkgU/jY11uo9Jv+k9E6pY+ePJai8Hs
         4mw3hXJwtKL8U5fFoBByX3j62XzBTtox3Wu0s2oUNLvT9ACnXNIlhXpjGvhKRi4W457i
         J1fqMYv9A6Ad1BxV9CvW5aYyhb+D11c4KmdxknQ+gt5q57wIej4HQIlUCPO1vni9R4V9
         WXJoOWBH6QzyDCtOauibnJiBwfcHL3+3xqCqEhvJTOjLr60uUeBvkiUeGm3FqFIQC+H+
         84bfLDOgeFXLD6GNk02ViYzXJ+4usqiB7B4+XFtL0rlkXIzEAuYL2aeiFTNVr5fXv1Qh
         ISFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzihvbc5wrJ+iFYMhCm2NX6azNQRN4+q6xED4ELS7y95yr90rXjG0y4xKOfTaQ/QCwdmFbbBMgwWWk5/A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CGH+G42Vw3QssPzKGVBxbcI1UWHUKp0wpl79o01JqJNnh2C5s
	poGyICuhCnLQxyhpqLAlghH1UUscWnYhfVr2fp8wEn5Hia0QdndWEXzhlP6KzuU7
X-Gm-Gg: AYBFou02Awr+Y9ogCQbVg4Nh0L5myxEUkGCMy3qm+i8k0tq1pjzLKGIqfGkDo1hsL7N
	sq9RIROi291to5PqBmTInV62xFUiR0Oof/PfYzYqulLNgciO+FnfpGpswerH37eQVZRIKHnadkD
	cEuw38okcdhHPIYQNCo1EvSNJg5ngEr01QZzvFvmYyHp8wim6iVQEfvL4fdfrf4JXO4jLJXI3A9
	GB02N9NYrVP9757MtKEX3H1xA0C3DYqJWfOaeeD7x6B6dLBis28EzMUpJMlLg4208pPrNtrgXE+
	phH5ceNkbehyR6nG69ObGCuc57kd1yq3AFShtLHbBcneA7Dqsk35JqGSopUlCH7TtqB/KeFjbBs
	UvCx6qPcFwbnH94qGVwBJX6bem0ZLxFugR8PLuBzWzOXVmeJ6E9YJcMWkoXULHQXzRreeAowjrO
	zUQKVqRiIYb8LiGIDygStGfQeN2mrJB1BK45/X8iI4afTSfG3EaifozM37/lYxNl/5OTrTqpbj9
	ZGbX+yh8iu2tiwTfQckJpmPu5/PuUCZxwY4ojUWU7sa/zuLQCyjOe3M6IYSX3QYTGtYLas3f7rG
	LS+BEQUic42reeNZ/g==
X-Received: by 2002:a05:622a:514e:b0:535:11bb:c2a3 with SMTP id d75a77b69052e-54e14e69326mr40210301cf.53.1793981202935;
        Fri, 06 Nov 2026 08:06:42 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e2625abafsm23468801cf.16.2026.11.06.08.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:06:42 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] zloop: remove the device ID after del_gendisk()
Date: Fri,  6 Nov 2026 11:06:38 -0500
Message-ID: <20261106160638.2385495-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zloop_ctl_remove() removes the device ID from zloop_index_idr before
del_gendisk() removes the "zloop<N>" disk from sysfs. An "add" request
issued in between can get the same ID, and its add_disk() fails:

  sysfs: cannot create duplicate filename '/devices/virtual/block/zloop0'
  ...
  zloop: add_disk failed (err=-17)

Remove the ID after del_gendisk() and before put_disk() frees the
device. Until then, an "add" requesting the same ID fails with -EEXIST,
and another "remove" fails with -EINVAL from the existing Zlo_deleting
check.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---

Notes:
    Found with a static analysis tool we are developing.
    
    Reproduced in QEMU (x86_64) with two threads that each write
    "add id=0,..." and then "remove id=0" to /dev/zloop-control in a loop
    for 20 seconds, with the zone files on tmpfs. Without this patch,
    add_disk() failed 2126 times with the error above. With it, add_disk()
    never failed, and the requests that overlapped a deletion got -EEXIST
    ("add") or -EINVAL ("remove").

 drivers/block/zloop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65634a39b0bf..8fb1f7fad286 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1467,7 +1467,6 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 	} else if (zlo->state == Zlo_deleting) {
 		ret = -EINVAL;
 	} else {
-		idr_remove(&zloop_index_idr, zlo->id);
 		WRITE_ONCE(zlo->state, Zlo_deleting);
 	}
 
@@ -1477,6 +1476,10 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 
 	del_gendisk(zlo->disk);
 
+	mutex_lock(&zloop_ctl_mutex);
+	idr_remove(&zloop_index_idr, zlo->id);
+	mutex_unlock(&zloop_ctl_mutex);
+
 	if (zlo->discard_write_cache)
 		zloop_forget_cache(zlo);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

