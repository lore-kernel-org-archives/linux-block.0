Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E378EC65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A830720868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/uM0Rex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A830720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLFWPL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:15:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33918 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLFWPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 17:15:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so1363716qkg.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=WfyvmMXtrpyIvab7HtC2qYX/8qJbeeqGuSUAyZrufq4=;
        b=J/uM0RexLv80WFh0yFDlh3+zIvhgNsB4OARagQ8dy7Op8IY9DkMIzYqTtBT/oivRQN
         Ahg3DrJhoz5+RjFs1fPKdW5lpm/yc53e+/Kd/UVG274G6Mr4gzyNQcM0ZjUUvCHCzBRO
         G/THyklgsbH5F67yTqhGTIH1zHseQ2Cp7YnNH9TitT+hZidoxONjO9ePX/qkL2TJCDyR
         P7yKN9QWH3Uzvl61wlsF2DS8f9KjAbVDIeo5CLppMAeMSQfKIKYbitf4cqa5WZOgoWGN
         0h5AugPTtnGlXjFDEmbEqQgQeyAgWciJLzbCzPsJcCpla9DoBrXX5WA6izXUUZLvkVr/
         7LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=WfyvmMXtrpyIvab7HtC2qYX/8qJbeeqGuSUAyZrufq4=;
        b=mKCB3QBcxQSAgkXqjoc5HKPhzFYT/LhILh9adSeNi8rd9T2XkK0vfkWeHiAxNon9Ry
         CyFjxEwv7Hgk73JsVpmV1rp9X+ibszbVEU9drf4OPih9KSBotSbanXcAlQT3LnmfzLzu
         SmVutn4S7NwFXh/w4Topa6ranVz2ZS1YqLOxGs8WHF07D1TH64tVkCB+SBrWXy1CTOg2
         RmfcEBn6AIUtINCNoPGXXzK65eKuAsvpndoyZyJwRuEVSsJXaI41qFgK5lULnRa9WcQP
         KUKCODc9aKe7kc8BSuX4xeEwnjes7RoVaFPshHLQ+FrTAnVR4UFxjNTr29cCGwH06QGI
         iIiA==
X-Gm-Message-State: AA+aEWaqHkQe8vorJ2wRI8JyZamDGsE1UpRJE9ckcCR0rpb5bn/FIYKR
        nMkao72bA/P6sNhfKuXnMdI=
X-Google-Smtp-Source: AFSGD/W7XG2TSGsfhRXLHrO1lx8waFa0x3TEYe8i6oumNl8zTZrAI1r0xMXJvPzjzqqmS96t5ij+3g==
X-Received: by 2002:a37:9584:: with SMTP id x126mr27851855qkd.36.1544134510279;
        Thu, 06 Dec 2018 14:15:10 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v50sm1041335qtc.7.2018.12.06.14.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:15:09 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Wheeler <dm-devel@lists.ewheeler.net>
Subject: [PATCH] dm crypt: fix lost ioprio when queuing crypto bios from task with ioprio
Date:   Thu,  6 Dec 2018 17:15:07 -0500
Message-Id: <20181206221507.5423-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Wheeler <dm-devel@lists.ewheeler.net>

Since dm-crypt queues writes (and sometimes reads) to a different kernel
thread (workqueue), the bios will dispatch from tasks with different
io_context->ioprio settings than the submitting task, thus giving
incorrect ioprio hints to the io scheduler.

By assigning the ioprio to the bio before queuing to a workqueue, the
original submitting task's io_context->ioprio setting can be retained
through the life of the bio.  We only set the bio's ioprio in dm-crypt
if not already set (by somewhere else, higher in the stack).

Signed-off-by: Eric Wheeler <dm-devel@linux.ewheeler.net>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/bio.c           | 24 ++++++++++++++++++++++++
 drivers/md/dm-crypt.c | 15 +++++++++++++--
 include/linux/bio.h   |  2 ++
 3 files changed, 39 insertions(+), 2 deletions(-)

[Jens, too much block code for me to take, please feel free to pick
this up, I tweaked Eric's original for 2 years ago (sorry this slipped
through the cracks Eric!):
https://patchwork.kernel.org/patch/9474535/
]

diff --git a/block/bio.c b/block/bio.c
index 0c2208a5446d..ed68fdd78547 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -647,6 +647,30 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
+/**
+ *	bio_set_task_prio - set bio's ioprio to task's ioprio, if any.
+ *	@bio: bio to set the ioprio of, can be NULL
+ *	@task: task of interest
+ *	@gfp_flags: allocation flags, used if allocation is necessary
+ *	@node: allocation node, used if allocation is necessary
+ */
+void bio_set_task_prio(struct bio *bio, struct task_struct *task,
+		       gfp_t gfp_flags, int node)
+{
+	struct io_context *ioc;
+
+	if (!bio)
+		return;
+
+	ioc = get_task_io_context(current, gfp_flags, node);
+	if (ioc) {
+		if (ioprio_valid(ioc->ioprio))
+			bio_set_prio(bio, ioc->ioprio);
+		put_io_context(ioc);
+	}
+}
+EXPORT_SYMBOL(bio_set_task_prio);
+
 /**
  *	bio_add_pc_page	-	attempt to add page to bio
  *	@q: the target queue
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 509fb20f7f86..4e3f0962f230 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1548,6 +1548,7 @@ static void clone_init(struct dm_crypt_io *io, struct bio *clone)
 	clone->bi_private = io;
 	clone->bi_end_io  = crypt_endio;
 	bio_set_dev(clone, cc->dev->bdev);
+	bio_set_prio(clone, bio_prio(io->base_bio));
 	clone->bi_opf	  = io->base_bio->bi_opf;
 }
 
@@ -2916,10 +2917,20 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 		io->ctx.r.req = (struct skcipher_request *)(io + 1);
 
 	if (bio_data_dir(io->base_bio) == READ) {
-		if (kcryptd_io_read(io, GFP_NOWAIT))
+		if (kcryptd_io_read(io, GFP_NOWAIT)) {
+			if (!ioprio_valid(bio_prio(io->base_bio))) {
+				bio_set_task_prio(io->base_bio, current,
+						  GFP_NOIO, NUMA_NO_NODE);
+			}
 			kcryptd_queue_read(io);
-	} else
+		}
+	} else {
+		if (!ioprio_valid(bio_prio(io->base_bio))) {
+			bio_set_task_prio(io->base_bio, current,
+					  GFP_NOIO, NUMA_NO_NODE);
+		}
 		kcryptd_queue_crypt(io);
+	}
 
 	return DM_MAPIO_SUBMITTED;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 056fb627edb3..93e11424e7f0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -46,6 +46,8 @@
 
 #define bio_prio(bio)			(bio)->bi_ioprio
 #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
+extern void bio_set_task_prio(struct bio *bio, struct task_struct *task,
+			      gfp_t gfp_flags, int node);
 
 #define bio_iter_iovec(bio, iter)				\
 	bvec_iter_bvec((bio)->bi_io_vec, (iter))
-- 
2.15.0

