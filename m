Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F017C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 21:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3021820936
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 21:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgINVgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 17:36:24 -0400
Received: from smtp.infotech.no ([82.134.31.41]:55713 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgINVgY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 17:36:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B8EF52041CB;
        Mon, 14 Sep 2020 23:36:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3vys0KX8cFqd; Mon, 14 Sep 2020 23:36:12 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 1DE0220417A;
        Mon, 14 Sep 2020 23:36:11 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCH] tools/io_uring: fix compile breakage
Date:   Mon, 14 Sep 2020 17:36:09 -0400
Message-Id: <20200914213609.141577-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It would seem none of the kernel continuous integration does this:
    $ cd tools/io_uring
    $ make

Otherwise it may have noticed:
   cc -Wall -Wextra -g -D_GNU_SOURCE   -c -o io_uring-bench.o
	 io_uring-bench.c
io_uring-bench.c:133:12: error: static declaration of ‘gettid’
	 follows non-static declaration
  133 | static int gettid(void)
      |            ^~~~~~
In file included from /usr/include/unistd.h:1170,
                 from io_uring-bench.c:27:
/usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note:
	 previous declaration of ‘gettid’ was here
   34 | extern __pid_t gettid (void) __THROW;
      |                ^~~~~~
make: *** [<builtin>: io_uring-bench.o] Error 1

The problem on Ubuntu 20.04 (with lk 5.9.0-rc5) is that unistd.h
already defines gettid(). So prefix the local definition with
"lk_".

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 tools/io_uring/io_uring-bench.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/io_uring/io_uring-bench.c b/tools/io_uring/io_uring-bench.c
index 0f257139b003..7703f0118385 100644
--- a/tools/io_uring/io_uring-bench.c
+++ b/tools/io_uring/io_uring-bench.c
@@ -130,7 +130,7 @@ static int io_uring_register_files(struct submitter *s)
 					s->nr_files);
 }
 
-static int gettid(void)
+static int lk_gettid(void)
 {
 	return syscall(__NR_gettid);
 }
@@ -281,7 +281,7 @@ static void *submitter_fn(void *data)
 	struct io_sq_ring *ring = &s->sq_ring;
 	int ret, prepped;
 
-	printf("submitter=%d\n", gettid());
+	printf("submitter=%d\n", lk_gettid());
 
 	srand48_r(pthread_self(), &s->rand);
 
-- 
2.25.1

