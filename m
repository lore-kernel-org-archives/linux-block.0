Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA79C
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 11:47:13 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3536cd414so7979915ad.2
        for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 11:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496833; x=1703101633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpXRJE7vhqiOE95aUr5+CJDrSfhfWn3Wt6w7hSFV9pg=;
        b=MqC8V9R1wlD9uwDNzC0Td5IDmp3uafX400YWsVkPiQY5P3sZ1Kwc7bPpXY52SFa7Iu
         ia1hWf0YC81iU3YGhY1wGrypvdmzrTmQpvneKOp8qsYF67oJOLdqMZkD9xNWNy+qd98h
         lkq2rP46NS3ZmGVsXXiMznD8ZpwXnzYrqBnC0khww7S26/GfRhKXkigFn5EuU3FkFJuJ
         YLf6FVTkRzTo4HoJ48qeAWzZ+De4ogjFGuVos4R9Rpg8NSJJ36Y7WbRi+HOTgThh1STu
         CRIOuuBPD0mRdmod62nZQfhwhvfwZtey6cWkaHTGkZjUEoe+W1/65+EZwu5fUSQfxVa6
         LNcg==
X-Gm-Message-State: AOJu0Yx64vtucEEIkKjWo2WDzKlUIBkWgG4Yer9GuTAu79MFdGgHO957
	ZF8V2jJi+5lFxClKcRyysBQ=
X-Google-Smtp-Source: AGHT+IFUhlsuWHtWuTVrVjxs07VWyfNWVnqi7glEMq89+7sPYJqw2kdfMvMnCpbXKdhYM7+J2rr8LA==
X-Received: by 2002:a17:902:e74e:b0:1cf:9c44:62e with SMTP id p14-20020a170902e74e00b001cf9c44062emr9935031plf.34.1702496832583;
        Wed, 13 Dec 2023 11:47:12 -0800 (PST)
Received: from bvanassche-glaptop2.corp.google.com ([2620:0:1000:5e10:1224:2309:ff46:20a])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001bf52834696sm10965073pld.207.2023.12.13.11.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:47:11 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: Use pr_info() instead of printk(KERN_INFO ...)
Date: Wed, 13 Dec 2023 11:47:02 -0800
Message-ID: <20231213194702.90381-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to the modern style of printing kernel messages. Use %u instead
of %d to print unsigned integers.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..09e3a4d5e4d2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -127,8 +127,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 
 	if ((max_hw_sectors << 9) < PAGE_SIZE) {
 		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_hw_sectors);
+		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);
 	}
 
 	max_hw_sectors = round_down(max_hw_sectors,
@@ -248,8 +247,7 @@ void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments
 {
 	if (!max_segments) {
 		max_segments = 1;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_segments);
+		pr_info("%s: set to minimum %u\n", __func__, max_segments);
 	}
 
 	q->limits.max_segments = max_segments;
@@ -285,8 +283,7 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
 	if (max_size < PAGE_SIZE) {
 		max_size = PAGE_SIZE;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_size);
+		pr_info("%s: set to minimum %u\n", __func__, max_size);
 	}
 
 	/* see blk_queue_virt_boundary() for the explanation */
@@ -740,8 +737,7 @@ void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
 {
 	if (mask < PAGE_SIZE - 1) {
 		mask = PAGE_SIZE - 1;
-		printk(KERN_INFO "%s: set to minimum %lx\n",
-		       __func__, mask);
+		pr_info("%s: set to minimum %lx\n", __func__, mask);
 	}
 
 	q->limits.seg_boundary_mask = mask;
