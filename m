Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0hxxN71"
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1781FE8;
	Sun,  3 Dec 2023 11:33:53 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d7692542beso9716687b3.3;
        Sun, 03 Dec 2023 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632031; x=1702236831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVZe3XB6BGpMjsmT58uwHSSvsAfrjssEwOSYFpssk1M=;
        b=T0hxxN71tOUysJcBgx5SSp6l4d5ZP1JToQcnAoMuKBXgSvgfFJEgDT9Id84n8I2LvV
         4veI4dFX3fVDEdASikQbSLTP7roJs6i+9QtFJCNqLwJfmxDSp7aeEG3N1l7M8gE6myiF
         JqqKFhpq1a8qAvYtzkTJckP89/oGGzHb4wOfulx9cwj2riBwWYPxyd22AtKSi+XFqwm7
         G0TDQHFy5yXDJ6Qd9Bjtj+Qgo4X9j26eXj/ZeX1FeGMsl5xAB/4deoMcsnOurBWVXxqC
         c00sYDHIpsrNxDU5cZ+xrtRsofDd3pPkc0PwHjgq3y8hn6WpdLylAC2WGPE3twhdRCRg
         Iq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632031; x=1702236831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVZe3XB6BGpMjsmT58uwHSSvsAfrjssEwOSYFpssk1M=;
        b=ao4mgTMGaN9BRgyGSq77SWpPYriMtRJqdmCudH6vavZ4WSpvZZbxL9NF7C4Y6pefv+
         J/2h3ZtKvqtDGEe1UMVgPB1pSVvw54cTzLX5hCTjqDST0lTEOq5cVTMLFhFDYcJ3CI2s
         tyRyTPVMhjjsdnzzgL6IGWPjBdwr3JZGgU8i0TP0a+4AMxwWkIKy34dAl6YjwE9is4Tt
         xxOCgt63izu+Fj9At87T6oWz8B7cqCjIsTdgiEo67OxsQn44ouSRajzKQLC0yKUSVCiq
         d1QZcLZNB52mY7ZM/maTC7vsKhsCRrTiHSlc9NyP421c9IN3ez4yQIB/x/kFbk2AxMYH
         dkGA==
X-Gm-Message-State: AOJu0YzXOnoR8+j/WdqUwvpOgyi+FW9/cNX9Qncwk4kDMGsGic8+jGrb
	6dJbu2eri9MEyCmLhbfk0FiMIl3ueYLo3A==
X-Google-Smtp-Source: AGHT+IGcPjR13Jl4a+nkDdC4Xctv8SivBOwYcZ98EQ8qA+lX/xlXnDuxDUbZLR6pW1tMq3OM+vIdkQ==
X-Received: by 2002:a81:af09:0:b0:5d7:1940:53cf with SMTP id n9-20020a81af09000000b005d7194053cfmr1954824ywh.71.1701632031279;
        Sun, 03 Dec 2023 11:33:51 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id p4-20020a815b04000000b0057a918d6644sm2747750ywb.128.2023.12.03.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:50 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-block@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 24/35] block: null_blk: fix opencoded find_and_set_bit() in get_tag()
Date: Sun,  3 Dec 2023 11:32:56 -0800
Message-Id: <20231203193307.542794-23-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_tag() opencodes find_and_set_bit(). Switch the code to use the
dedicated function, and get rid of get_tag entirely.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/block/null_blk/main.c | 41 +++++++++++------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3021d58ca51c..671dbb9ab928 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -760,19 +760,6 @@ static void put_tag(struct nullb_queue *nq, unsigned int tag)
 		wake_up(&nq->wait);
 }
 
-static unsigned int get_tag(struct nullb_queue *nq)
-{
-	unsigned int tag;
-
-	do {
-		tag = find_first_zero_bit(nq->tag_map, nq->queue_depth);
-		if (tag >= nq->queue_depth)
-			return -1U;
-	} while (test_and_set_bit_lock(tag, nq->tag_map));
-
-	return tag;
-}
-
 static void free_cmd(struct nullb_cmd *cmd)
 {
 	put_tag(cmd->nq, cmd->tag);
@@ -782,24 +769,22 @@ static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
 
 static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 {
+	unsigned int tag = find_and_set_bit_lock(nq->tag_map, nq->queue_depth);
 	struct nullb_cmd *cmd;
-	unsigned int tag;
-
-	tag = get_tag(nq);
-	if (tag != -1U) {
-		cmd = &nq->cmds[tag];
-		cmd->tag = tag;
-		cmd->error = BLK_STS_OK;
-		cmd->nq = nq;
-		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
-			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
-				     HRTIMER_MODE_REL);
-			cmd->timer.function = null_cmd_timer_expired;
-		}
-		return cmd;
+
+	if (tag >= nq->queue_depth)
+		return NULL;
+
+	cmd = &nq->cmds[tag];
+	cmd->tag = tag;
+	cmd->error = BLK_STS_OK;
+	cmd->nq = nq;
+	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
+		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		cmd->timer.function = null_cmd_timer_expired;
 	}
 
-	return NULL;
+	return cmd;
 }
 
 static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
-- 
2.40.1

