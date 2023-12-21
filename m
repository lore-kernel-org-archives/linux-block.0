Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF04420
	for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOenZ1tg"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbb7d80df8so110493a34.1
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2023 19:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129053; x=1703733853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzObqHbWeNKxitmoVg0oGbTzko+SYVdSYHcCza/qiow=;
        b=dOenZ1tgeyvWarDxLT3ACcP1Hzz0Vske5cEv5XLxJ4Qw89i8nfnC6FsRsMyp+Q0qZD
         eLiUQeKOEV+aN1R/OcYr8nBEMPPLBLFZlIkgboa6AVhk34SJ4duwrDCEE9fyzZzhYeIt
         IL8xPYyWj3wFWA7XsY2zuCCvkQhAOpGsF3EQFWRjH9nLTkQfmsHdLXb4FIZacbrzw/no
         y2PScZFqrTy00I8NPtQGxqrnR7mw9CSsJT539obwH5kgW1/hYk9+8R7QR6ZxjGz++q85
         CWfeKpZX0bFQ/6Wb8JsZMAZLUxdizycAV+CmlCKu4wO+C8Aekqfz1WesaYSxbpkxkkmc
         pgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129053; x=1703733853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzObqHbWeNKxitmoVg0oGbTzko+SYVdSYHcCza/qiow=;
        b=ZadjnX35xPkmtKoQCYFByyI+JRpdbAN/qDeb/Kly6yfjFtb7uCPMh4dhkVDGXesELT
         kFRFrseNw9qN311SVpHUPQQ+5JiXY19/39EvOskLThZylU9pviCrF3E2Daf8ZFiCtBjG
         2lGs3h4UI5+fk5kSwdSVlrQpLB0HILu098GGREM/yO8V4AGfgvnwpjgMTc26c/Lkl0po
         j009ABdQ8+Vqfv1Mh9CUO1ldoUdvtMSDvnTbZ7ufEf/TNrOCoLgyFj9WYB/GdByyfGe9
         v9TcPTTAiZ7Rco6aZ2poe7A0Mjow6gLvkYrBFDiRJTWa97MhWJEMbj9U1KdYfvh0qRdd
         NOTA==
X-Gm-Message-State: AOJu0YwZp6iFs5iwxdsU/ZriSO6QyOYpJXGbkfawUKqlnVSay9jSPfTA
	dpxYKXs6EH00ZK6sj4GRgyk=
X-Google-Smtp-Source: AGHT+IGqO69HbozDdaHzdkdh97/2e+jmgHJdDzIFmqXLEgdVLBzcOqGONSlcV0qLIbSY7SsabkStTg==
X-Received: by 2002:a9d:7518:0:b0:6d9:ebaf:a5fa with SMTP id r24-20020a9d7518000000b006d9ebafa5famr19611013otk.54.1703129052973;
        Wed, 20 Dec 2023 19:24:12 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id t26-20020a62d15a000000b006d757ef7541sm513489pfl.209.2023.12.20.19.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:24:12 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] xen-blkback: Use freezable wait_event variants for freezable kthread
Date: Thu, 21 Dec 2023 11:23:51 +0800
Message-Id: <20231221032351.1638686-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A freezable kernel thread can enter frozen state during freezing by
either calling try_to_freeze() or using wait_event_freezable() and its
variants. So for the following snippet of code in a kernel thread loop:
  try_to_freeze();
  wait_event_interruptible();

We can change it to a simple wait_event_freezable() and then eliminate
a function call.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/block/xen-blkback/blkback.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 4defd7f387c7..bef0f950b257 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -563,20 +563,18 @@ int xen_blkif_schedule(void *arg)
 
 	set_freezable();
 	while (!kthread_should_stop()) {
-		if (try_to_freeze())
-			continue;
 		if (unlikely(vbd->size != vbd_sz(vbd)))
 			xen_vbd_resize(blkif);
 
 		timeout = msecs_to_jiffies(LRU_INTERVAL);
 
-		timeout = wait_event_interruptible_timeout(
+		timeout = wait_event_freezable_timeout(
 			ring->wq,
 			ring->waiting_reqs || kthread_should_stop(),
 			timeout);
 		if (timeout == 0)
 			goto purge_gnt_list;
-		timeout = wait_event_interruptible_timeout(
+		timeout = wait_event_freezable_timeout(
 			ring->pending_free_wq,
 			!list_empty(&ring->pending_free) ||
 			kthread_should_stop(),
@@ -593,8 +591,8 @@ int xen_blkif_schedule(void *arg)
 		if (ret > 0)
 			ring->waiting_reqs = 1;
 		if (ret == -EACCES)
-			wait_event_interruptible(ring->shutdown_wq,
-						 kthread_should_stop());
+			wait_event_freezable(ring->shutdown_wq,
+					     kthread_should_stop());
 
 		if (do_eoi && !ring->waiting_reqs) {
 			xen_irq_lateeoi(ring->irq, eoi_flags);
-- 
2.39.2

