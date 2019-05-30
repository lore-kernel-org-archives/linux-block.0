Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C57C28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AACD254E4
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 09:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtLbf2Hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfE3J2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 05:28:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38462 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfE3J2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 05:28:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so3705997wrs.5;
        Thu, 30 May 2019 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9uS1keBW3VpEfdw8YbBt35z4e82IzpdzTkrruky1E8=;
        b=QtLbf2HmeJA14Jf1AcY7WgDdWbr0B/C84z9/ERtg1Ea1H9PTS7kqNhnGKZY+dPDjPC
         KbeOi8QpjT2t0+jlvl05Jq58LCsRl6NXwYmKRMqm8AAsQqi/VENdBGl0EZJ2mpl1nHRR
         QibgPIATXT/RCX7UeeCr5m7mPYg+ih/oV9mwM1UXYkokeIoQCqhLRSlhCDQ87MxU4r6v
         HtRYiITzXvN1mLjGpneqU5cAIEVRoxDLlvtFFHlIY0iDXjG3QP00tVAKZUf93GH+HQ5n
         iOKumKG/s83Lb1HPwNeapI2hCHj1xk/HotATLvhC7rJbvJTD/ajL9rfERTfhO0OPqSsr
         m8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9uS1keBW3VpEfdw8YbBt35z4e82IzpdzTkrruky1E8=;
        b=VAuPRknRfwLoPuavE7DF9XI97OhYOa0Ep41HUoOkO5NeddUyBVw/SQRZmps0lBzP7d
         P/LdzhUE1+aXHyV1b1vpJJwiS6kuJ6VdqklsWmQ1/POxM/9u28NbzkuSMu6gBMev6jT0
         M+b+LZVM6XJJuy648f/AWNKy5Xwg/Cd2Co4nLJJteXxK34Nth7IIee2H4OsLXuLYFiF/
         srPEwA55/7xlJ3goDQtSSn6vwfxAMw8bbsjctNCzXlIX6aMGhFkxBuj3eIUlKVZ1WtfC
         BYd81E7zKRdhgAI6SI35bR89aaA/Ke2kmyM0Oup69zL8BR6g2bpttXAa98cNNXVw61AW
         yf7A==
X-Gm-Message-State: APjAAAUipeuswXVT2C6y3XyKHNr0IjTO+P/4fVahDO7W0XoRkAH6Mp4g
        oMat//FNHXi5LckzBQxNn24=
X-Google-Smtp-Source: APXvYqwAYe7240hTlEiIsSSbTkHNnMmocCkj0k5gjshu065TwpUUnlDOU/rPhN+bZXP3GcvjnesCAQ==
X-Received: by 2002:adf:fd09:: with SMTP id e9mr1920656wrr.292.1559208479457;
        Thu, 30 May 2019 02:27:59 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.5])
        by smtp.gmail.com with ESMTPSA id u25sm147605wmc.3.2019.05.30.02.27.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 02:27:58 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     osandov@fb.com, ming.lei@redhat.com, Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 1/1] blk-mq: Fix disabled hybrid polling
Date:   Thu, 30 May 2019 12:27:08 +0300
Message-Id: <71c31759a882e00f156a8434caed7064ec93d3da.1559208134.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Commit 4bc6339a583cec650b05 ("block: move blk_stat_add() to
__blk_mq_end_request()") moved blk_stat_add() to reuse ktime_get_ns(),
so now it's called after blk_update_request(), which zeroes
rq->__data_len. Without length, blk_stat_add() can't calculate stat
bucket and returns error, effectively disabling hybrid polling.

v2: Hybrid polling needs pure io time for precision, but according to
the feedback from Omar Sandoval other components require end-to-end
time. So, it can't be reused, and should be sampled twice insted.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32b8ad3d341b..907799282d57 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -537,11 +537,6 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 	if (blk_mq_need_time_stamp(rq))
 		now = ktime_get_ns();
 
-	if (rq->rq_flags & RQF_STATS) {
-		blk_mq_poll_stats_start(rq->q);
-		blk_stat_add(rq, now);
-	}
-
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq, now);
 
@@ -580,6 +575,11 @@ static void __blk_mq_complete_request(struct request *rq)
 	int cpu;
 
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+
+	if (rq->rq_flags & RQF_STATS) {
+		blk_mq_poll_stats_start(rq->q);
+		blk_stat_add(rq, ktime_get_ns());
+	}
 	/*
 	 * Most of single queue controllers, there is only one irq vector
 	 * for handling IO completion, and the only irq's affinity is set
-- 
2.21.0

