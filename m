Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21499 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753580AbcEJAWT (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 9 May 2016 20:22:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u4A0Losu022569
	for <linux-block@vger.kernel.org>; Mon, 9 May 2016 17:22:18 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0001303.ppops.net with ESMTP id 22u4gm04dt-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 09 May 2016 17:22:18 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.236.87) with ESMTP	id
 401623b6164511e6b9f90002c9521c9e-7b5f7c50 for <linux-block@vger.kernel.org>;
	Mon, 09 May 2016 17:22:16 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: [PATCH 1/3] blktrace: delete garbage for message trace
Date: Mon, 9 May 2016 17:22:13 -0700
Message-ID: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

commit f4a1d08ce65 introduces a regression. Originally for
BLK_TN_MESSAGE, we add message in trace and return. The commit ignores
the early return and add garbage info.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 kernel/trace/blktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f94e7a2..8ae9ea2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1349,6 +1349,7 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
 	if (t->action == BLK_TN_MESSAGE) {
 		log_action(iter, long_act ? "message" : "m");
 		blk_log_msg(s, iter->ent);
+		return trace_handle_return(s);
 	}
 
 	if (unlikely(what == 0 || what >= ARRAY_SIZE(what2act)))
-- 
2.8.0.rc2

