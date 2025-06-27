Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6A2F1FEA
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008734; cv=none; b=p2AW08IbMXlUKHnhgzLQbgKgyeMTvkVU0D7BrSTQ+a+JRVSRegHFv/lF68ZBOLMqjFL+PaiLlgjxaMd/ep4Ejhbi1OlQdPFKfSjICv/CWFrVm1WrSuaXOJ9DLgf1Kh3MK7XsmlZCA2ZryeFGpeIb8pAsGCSCWO3QWSyKgG/EKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008734; c=relaxed/simple;
	bh=s0MKz0LYCUSl+PREsipx69b8MkTSre17kmQ/gXk2iMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsnABAeA5bIE1YyJwmYnjRisxQDOoLWyERwV9Rjvm8+RC17uPVxoXut+felOfoiIiODfmxf8/fcppgEH+jmpcM++dj61qOUvOK+tzicCs19Am/szikNR3QUVAOcRswcidwnkEbxDJKgjWQMtE3cWKu8QDkTQlwAuVIMvHVWu5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WK1Ktqc1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WK1Ktqc1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235d6de331fso25936695ad.3
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751008732; x=1751613532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB+J0JTiaeKcpjtbE/NJOgrsuv9/ekzaPkYkdAHom5w=;
        b=WK1Ktqc1LhT832huhg+VSXhfAXseGg++wsouBjz8FdjZhsQN54Vs8af0FTDoBde9B3
         /xEjAYSjCLhafeJmmdtWstN14sLWs5BxrFhE+pql10Gr/EXF04jPc2656vmY3DpbTra7
         SiChav3ZQUVkmBsGiYczLTHgG7BMmGGW6kMKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751008732; x=1751613532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB+J0JTiaeKcpjtbE/NJOgrsuv9/ekzaPkYkdAHom5w=;
        b=SK2HW4Xy6NIAoRNdbQ0QKhk52yFlRKMlLUD4Vq5quGUOVHzFmOhw4eGXWea1Rdu8Xx
         CeZiF8Q/r5sZY2Knezllw95bLOFIr8FnbRvyHMrNBpd4g0ofM2QCzoGhrKGjSyxF1E4B
         cuDycMRKLxU2IpYWz/VprUUBBoDqyKEXpkIEAHmr+luOh1pBIEccjPf/+DCwbY3UcpU7
         aq706xekRRVwxSAjog/SQM38BDEOBJrgFIx7MXrAY35tYZ0OT1NgDDRA1hBXjlHk6l/1
         j8sWSdoc+/G10NYDJpTjSskTJP23ciZpwt/Ivcwt/Y/ukkPfQQ28OBLlqszb9jlwF2nt
         Ne0g==
X-Forwarded-Encrypted: i=1; AJvYcCVRpYhGIjYfCjlw711jxn64VWZpQsM8fPIUQ+SSJzP81W5TJoSVhckzy8G6RCf0oeuCKodtf8yUYkH3kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8tQmcxS5yuYiEmnt4luAufcd2QOwrJmiBuPVss6F1qmGs0MI
	+zzHz2tKF9XKh1MiA8aQdEpLZWW8enwLW7+OEfG3uL4bP+XZnGZhkmRawrEDmNNFxA==
X-Gm-Gg: ASbGncsnRaYucWWaJ7RMoWmX3uiGSyNze+Ojl+hkUkLCoKCjeXuRYzI1g3lD1FnrsHd
	mLEKSFaRwzG5aHA9GCF/6SfZTT037tOI7ckw4cfLSFY19Cf0GNr7OT/+B8EBANe1Y6jK71n3WOf
	gpWY9nWell41q8RYzWsGDujRNkVzktJOAWPD1YIJJnnoK/hv/AaPf+zny0KUrMty8eqzqt4z4rk
	2mIV6o4fGVhq+WRyvSi6747N7r0tKX2B1wyowsKqqcOA7Rjb/KrRXOQekaouYi4YDK9kj/VgXCP
	52pD+dNuPG7XbUX0m9blBogy7xVDFQvsYt9XlzKad7AXdGe5ybqdMGjSKWSUj2eGwc+Qtu5mGr3
	B2Cr1fUkcFT3J
X-Google-Smtp-Source: AGHT+IEniPdeUaDBJqW2J9JxlFM3DDSGnoXCNLODgE1sh4luqIQPy073VHyEhRaenz6+Ej5gQQv+EQ==
X-Received: by 2002:a17:903:2451:b0:235:5a9:9769 with SMTP id d9443c01a7336-23ac4605d87mr31453005ad.25.1751008732349;
        Fri, 27 Jun 2025 00:18:52 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:de1c:e88f:de93:cd95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1814sm9316095ad.57.2025.06.27.00.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:18:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>,
	Rahul Kumar <rk0006818@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: pass buffer offset to zcomp_available_show()
Date: Fri, 27 Jun 2025 16:18:21 +0900
Message-ID: <20250627071840.1394242-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250627035256.1120740-1-rk0006818@gmail.com>
References: <20250627035256.1120740-1-rk0006818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In most cases zcomp_available_show() is the only emitting
function that is called from sysfs read() handler, so it
assumes that there is a whole PAGE_SIZE buffer to work with.
There is an exception, however: recomp_algorithm_show().

In recomp_algorithm_show() we prepend the buffer with
priority number before we pass it to zcomp_available_show(),
so it cannot assume PAGE_SIZE anymore and must take
recomp_algorithm_show() modifications into consideration.
Therefore we need to pass buffer offset to zcomp_available_show().

Also convert it to use sysfs_emit_at(), to stay aligned
with the rest of zram's sysfs read() handlers.

On practice we are never even close to using the whole PAGE_SIZE
buffer, so that's not a critical bug, but still.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 15 +++++++--------
 drivers/block/zram/zcomp.h    |  2 +-
 drivers/block/zram/zram_drv.c |  9 +++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index d26a58c67e95..b1bd1daa0060 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/cpuhotplug.h>
 #include <linux/vmalloc.h>
+#include <linux/sysfs.h>
 
 #include "zcomp.h"
 
@@ -89,23 +90,21 @@ bool zcomp_available_algorithm(const char *comp)
 }
 
 /* show available compressors */
-ssize_t zcomp_available_show(const char *comp, char *buf)
+ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at)
 {
-	ssize_t sz = 0;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(backends) - 1; i++) {
 		if (!strcmp(comp, backends[i]->name)) {
-			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-					"[%s] ", backends[i]->name);
+			at += sysfs_emit_at(buf, at, "[%s] ",
+					    backends[i]->name);
 		} else {
-			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-					"%s ", backends[i]->name);
+			at += sysfs_emit_at(buf, at, "%s ", backends[i]->name);
 		}
 	}
 
-	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
-	return sz;
+	at += sysfs_emit_at(buf, at, "\n");
+	return at;
 }
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 4acffe671a5e..eacfd3f7d61d 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -79,7 +79,7 @@ struct zcomp {
 
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node);
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
-ssize_t zcomp_available_show(const char *comp, char *buf);
+ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at);
 bool zcomp_available_algorithm(const char *comp);
 
 struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 385aaaa2531b..8acad3cc6e6e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1225,12 +1225,13 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 	zram->comp_algs[prio] = alg;
 }
 
-static ssize_t __comp_algorithm_show(struct zram *zram, u32 prio, char *buf)
+static ssize_t __comp_algorithm_show(struct zram *zram, u32 prio,
+				     char *buf, ssize_t at)
 {
 	ssize_t sz;
 
 	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[prio], buf);
+	sz = zcomp_available_show(zram->comp_algs[prio], buf, at);
 	up_read(&zram->init_lock);
 
 	return sz;
@@ -1387,7 +1388,7 @@ static ssize_t comp_algorithm_show(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 
-	return __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf);
+	return __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf, 0);
 }
 
 static ssize_t comp_algorithm_store(struct device *dev,
@@ -1416,7 +1417,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 			continue;
 
 		sz += sysfs_emit_at(buf, sz, "#%d: ", prio);
-		sz += __comp_algorithm_show(zram, prio, buf + sz);
+		sz += __comp_algorithm_show(zram, prio, buf, sz);
 	}
 
 	return sz;
-- 
2.50.0.727.gbf7dc18ff4-goog

