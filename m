Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX0Ty0bL"
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD151BF9;
	Sat, 18 Nov 2023 07:51:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso3362107276.0;
        Sat, 18 Nov 2023 07:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322702; x=1700927502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg2dWT1RhFKme6yZPEIj44E7/nsRkUJhN3arViZI26M=;
        b=LX0Ty0bL4pMGI7gQ5d7p8EDFQ9rDmYzupxxul3h1v0ChIU2ggm3JZfJqnfaxHnlMH7
         dMKNUQ+FdJFnmF5e8H4/8nAqVTSbVQOlRuUDrIwHiqXd4sg2OPukdZDT7WeNCa3sOyqI
         /fo3kQhSmqBcZmgZufy3bEzS8R/LGyjCWczqu6KUYr8Nj3/W9jEjt2Gdx+krsfF0SdUI
         rXzQKd9bZKzK1aQtcKdJQFLzr2h8crIscLZ+g+H2BZO0netk4WdH/N20fl9aXKZyyd50
         TbVdX15R2F919pwplLPX9mQUAxaGk9qHABAdAlJw5fZYAXPjqWxVYZXlFUA7WUHP8b6C
         g9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322702; x=1700927502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg2dWT1RhFKme6yZPEIj44E7/nsRkUJhN3arViZI26M=;
        b=IPF8W04ewcwO6sh9e9zownO9utMV4G+4Rp+V8FnsWAjJjgOkX/MduzvDBqT8VsypF1
         LwQK+k9i9kQ4WqTC/b4JA4vPSqYnWFOUNZchwrcjug5OGpZ/v4sgAb+z5oV/ovuyj5l6
         PFULSZ6ZAcUWw70Xt9c0DWPDM2OyCrQ1IxhBOYgXPfN8svR51mZ3Un5YaXD9oQNrzKAV
         YJV3j5rRmlhW3mkqj2p6TIeIU7K4k6USgM7VORprI9nczBaJXVht7YT/lt52XBNVt8FA
         NuETR2X3WuXonV5MocpaK9n5Arw42p4jZPPDYnetHniHOR9TkVZLo0vGZ1DFkyQGi073
         3ajA==
X-Gm-Message-State: AOJu0Yz2C07TxMPEY/hOyRwClLk8XJH2DDPdQzIhGUiRGtcuOwNNFi3I
	IpVgxBjnchWtS60v3ruwZH2BA1uz1zw+cBmi
X-Google-Smtp-Source: AGHT+IGLuAbyQuCwpl0+dEJc+LhpBrFdlR1P42AFwq9mnuU8O7NnAWExHW0iaDQvbV6DL8BBzMuPMg==
X-Received: by 2002:a25:ad4f:0:b0:daf:7702:fd60 with SMTP id l15-20020a25ad4f000000b00daf7702fd60mr1666669ybe.1.1700322702147;
        Sat, 18 Nov 2023 07:51:42 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id i10-20020a05690200ca00b00daf198ef6fbsm964572ybs.21.2023.11.18.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:41 -0800 (PST)
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
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-block@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 22/34] block: null_blk: fix opencoded find_and_set_bit() in get_tag()
Date: Sat, 18 Nov 2023 07:50:53 -0800
Message-Id: <20231118155105.25678-23-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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
index 22a3cf7f32e2..a41d146663e1 100644
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
2.39.2

