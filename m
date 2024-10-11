Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B289197A9F;
	Fri, 11 Oct 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662209; cv=none; b=cla4YJQytNaOc2XPnJuih5oSitcP+uuKACNJ116fR+MoVidb3bWlyZemQCzRDVRQ1/Hp/wS6WCJ1FR9aViXnxrkhNvOC1++ReyvbmELbhJtFOziqK2reLsLStJVZOt1FXEEvw0ZNPldPFyVtMkpgyL37esqW3RNQU4nni/th8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662209; c=relaxed/simple;
	bh=oL0B8WhvV9HlIWbRkHl3q/AFYqOubI9dz+gH0QUroXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kG08px6maVPQwgjL37/fla78kDiLXpWCSH11d+lppA2ePA1TQjoc4TmALzhcAfz3klM8MLndbzaaRyhmuR/9PiKryPfypi9ODmEmd9Bo/RZIGyWJ1deirOXrPFyKYgnDlxquW2qIPh0ilQuZk5DFD8ItIb1Y8teD75vkBwX1/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so23635065e9.3;
        Fri, 11 Oct 2024 08:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728662205; x=1729267005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk9tn5ydhdwoKVQDhImzSPs8EtpceWdxm3uEUMtcxn8=;
        b=vovqVfngu0IbYtT+bveYfqNRl0PM7tAmW2eOkDF308L1QH/Y3Ik6pkbkIpAj1NY15I
         RXCQGR+gdxdpPR8iyxOsql8REbsfDAI+w5jEArDtPs4Rnpc3+h3Q982UU2CO1XvgzcRR
         iwF1+pF0Hb9EcnxCz7/Fp6ZaNZsDMHWf43dWa2KFf6FH4eMexO6wOn3hBxywCPN/vxd1
         x1Ejt2kbMrCMoqnQU3MipqoxNIN2/7JQ5d1ZtLVFmfL7OP1zE4RvDRkIGoQRN629kS8h
         NgBiQHEFVaLFJdo3nJbvDnYw7KEmBaD8NrafmkvATDS9RcCeSawQWfFHwhpDGvEdilZS
         K6OA==
X-Forwarded-Encrypted: i=1; AJvYcCVDotOn8zU7w/yMUbmN/D54b52VaTiobsoWL3XeOEAdxuhlSgtB28g4GOdEbURfK1GJH4FB2MMdUbzFTQ==@vger.kernel.org, AJvYcCWCLcNusJkal6Na+ZbNvnNQa+Lsc9a4mpHTdwdUPzuT/yRcXbiOYw7cf7QNHwXbuEc9KcRFEji3vLFH6T8S@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnEGRS5igYWYm/WHF42Duh9T4zKl96jhCqzSAwqgemqU8pFC4
	dlfMiZO/5a3qCXbehrb3nx6w7G0N3oCDXLFfMJYkJeftVYdwnNm2
X-Google-Smtp-Source: AGHT+IE+rjEpG5QFGOkm0LC8xG9DFvh3m1qd9YXpUSFdwwXU+z9ltw2I6ZTmxURY24S4A6cB45BUfw==
X-Received: by 2002:a05:600c:4f07:b0:42f:75e0:780e with SMTP id 5b1f17b1804b1-4311dec95demr31975695e9.10.1728662205289;
        Fri, 11 Oct 2024 08:56:45 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0217sm4229868f8f.60.2024.10.11.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:56:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hch@infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Cc: kernel-team@meta.com,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] elevator: Remove argument from elevator_find_get
Date: Fri, 11 Oct 2024 08:56:15 -0700
Message-ID: <20241011155615.3361143-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e4eb37cc0f3ed ("block: Remove elevator required features")
removed the usage of `struct request_queue` from elevator_find_get(),
but didn't removed the argument.

Remove the "struct request_queue *q" argument from elevator_find_get()
given it is useless.

Fixes: e4eb37cc0f3e ("block: Remove elevator required features")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 block/elevator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 4122026b11f1..565807f0b1c7 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -106,8 +106,7 @@ static struct elevator_type *__elevator_find(const char *name)
 	return NULL;
 }
 
-static struct elevator_type *elevator_find_get(struct request_queue *q,
-		const char *name)
+static struct elevator_type *elevator_find_get(const char *name)
 {
 	struct elevator_type *e;
 
@@ -569,7 +568,7 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 	    !blk_mq_is_shared_tags(q->tag_set->flags))
 		return NULL;
 
-	return elevator_find_get(q, "mq-deadline");
+	return elevator_find_get("mq-deadline");
 }
 
 /*
@@ -697,7 +696,7 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
-	e = elevator_find_get(q, elevator_name);
+	e = elevator_find_get(elevator_name);
 	if (!e)
 		return -EINVAL;
 	ret = elevator_switch(q, e);
-- 
2.43.5

