Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68FCC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AF461994
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 13:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhCWNOb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhCWNNn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 09:13:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B53C61994;
        Tue, 23 Mar 2021 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616505222;
        bh=LqDHJq2C5bM3oecuxbWy2D1v4SxKCuP3OjlMBuhAU7g=;
        h=From:To:Cc:Subject:Date:From;
        b=C6Hlgn3LxfZeY5laGu/OmHFn/DeXk4QmW4SY4fwHsCmhdPJptmiF55rlbueIiP1gW
         r+kzoAZ/59x2FW7chal5PdbwZBceoHL1KfFPXCM/ivfKkbFS7uNryHXTsIw4dger4j
         qjVDFErWaS7KxLeanqZ8wLYL2NFLV1RIqyJx6lMcQNPz7JhSgYsyIjH7lMZRtuPJp+
         cTtspFOrPYYTarJmK0YDBORUEx1xmdQhSiw0owGoAsGYB77R1xvAWye95mFID3qbut
         rchv7jd0wmqjmhy9uXS9kxD0DaW9lg1nvpIyZ1ekhAoQy/4HEC2rMYTQG55FD9F2M3
         W4uz+HoUXYETg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shaohua Li <shli@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: avoid -Wunused-but-set-parameter warning
Date:   Tue, 23 Mar 2021 14:12:19 +0100
Message-Id: <20210323131337.2510952-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows a warning for one function parameter
that is only set but not used in some configurations:

kernel/trace/blktrace.c: In function '__trace_note_message':
kernel/trace/blktrace.c:148:63: error: parameter 'blkcg' set but not used [-Werror=unused-but-set-parameter]
  148 | void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,

Move the assignment into the #ifdef block that contains the only
use to clarify how it's used and avoid the warning.

Apparently this is the only -Wunused-but-set-parameter warning in the
kernel as of v5.12, after similar cleanups done by others. It may be time
to turn it on globally.

Fixes: 35fe6d763229 ("block: use standard blktrace API to output cgroup info for debug notes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c221e4c3f625..f9314351a7e2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -170,9 +170,9 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 	n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
 	va_end(args);
 
+#ifdef CONFIG_BLK_CGROUP
 	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
 		blkcg = NULL;
-#ifdef CONFIG_BLK_CGROUP
 	trace_note(bt, current->pid, BLK_TN_MESSAGE, buf, n,
 		   blkcg ? cgroup_id(blkcg->css.cgroup) : 1);
 #else
-- 
2.29.2

