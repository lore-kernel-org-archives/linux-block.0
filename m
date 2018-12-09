Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC0C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC5D2081F
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC5D2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeLIWOE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38014 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728266AbeLIWOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:04 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002ie-A9; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003P8-RP; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.814123060@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 146/328] tracing/blktrace: Fix to allow setting same
 value
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 757d9140072054528b13bbe291583d9823cde195 upstream.

Masami Hiramatsu reported:

  Current trace-enable attribute in sysfs returns an error
  if user writes the same setting value as current one,
  e.g.

    # cat /sys/block/sda/trace/enable
    0
    # echo 0 > /sys/block/sda/trace/enable
    bash: echo: write error: Invalid argument
    # echo 1 > /sys/block/sda/trace/enable
    # echo 1 > /sys/block/sda/trace/enable
    bash: echo: write error: Device or resource busy

  But this is not a preferred behavior, it should ignore
  if new setting is same as current one. This fixes the
  problem as below.

    # cat /sys/block/sda/trace/enable
    0
    # echo 0 > /sys/block/sda/trace/enable
    # echo 1 > /sys/block/sda/trace/enable
    # echo 1 > /sys/block/sda/trace/enable

Link: http://lkml.kernel.org/r/20180816103802.08678002@gandalf.local.home

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Fixes: cd649b8bb830d ("blktrace: remove sysfs_blk_trace_enable_show/store()")
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/blktrace.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1778,6 +1778,10 @@ static ssize_t sysfs_blk_trace_attr_stor
 	mutex_lock(&q->blk_trace_mutex);
 
 	if (attr == &dev_attr_enable) {
+		if (!!value == !!q->blk_trace) {
+			ret = 0;
+			goto out_unlock_bdev;
+		}
 		if (value)
 			ret = blk_trace_setup_queue(q, bdev);
 		else

