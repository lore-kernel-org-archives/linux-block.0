Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF24C433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8DD206A5
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 16:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbgEMQCb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 12:02:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:42324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389401AbgEMQCa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 12:02:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D380BAE91;
        Wed, 13 May 2020 16:02:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B9E791E12AE; Wed, 13 May 2020 18:02:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] blktrace: Report pid with note messages
Date:   Wed, 13 May 2020 18:02:23 +0200
Message-Id: <20200513160223.7855-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently informational messages within block trace do not have PID
information of the process reporting the message included. With BFQ it
is sometimes useful to have the information and there's no good reason
to omit the information from the trace. So just fill in pid information
when generating note message.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb..ea47f2084087 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -170,10 +170,10 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
 		blkcg = NULL;
 #ifdef CONFIG_BLK_CGROUP
-	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n,
+	trace_note(bt, current->pid, BLK_TN_MESSAGE, buf, n,
 		   blkcg ? cgroup_id(blkcg->css.cgroup) : 1);
 #else
-	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n, 0);
+	trace_note(bt, current->pid, BLK_TN_MESSAGE, buf, n, 0);
 #endif
 	local_irq_restore(flags);
 }
-- 
2.16.4

