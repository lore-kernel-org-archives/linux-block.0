Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C7C43613
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536672085A
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TuZrO3RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfFSWCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 18:02:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3312 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSWCC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 18:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560981722; x=1592517722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3krMBlXIv+fvQVshUknz3FAaRGbmVERZA4kodq1qrYI=;
  b=TuZrO3RZFFNDyukhP007uEE+krQ5bDAPlm5swsOs3/0ow+kRvMbUyWga
   K10MSQAp2iOrrIiin4beIK+idJGopYwj8Pq1sBKEz/p8oRAh7k9COPz58
   Eb0WCAapHqvVJ5zmI33I9ydvD/0AW3j3Z1iur1iQNwDFUabNYb9xR6JIg
   GhDcejIvN44SmtMeve5NnshhLYXEScvtUgxNkow+nQMo/n+PdBCgqFkhQ
   oA5Pj3rJ4FVkEgELyKpJLR6c1ZyluBOLQ2eRr9rkBKM9mmyG9P2FsJdie
   hxgkqQxSYZwERfirLu5AfeJukHhosiqHaRdmy8JZfRVTDMmFbIS7EjlCv
   w==;
X-IronPort-AV: E=Sophos;i="5.63,394,1557158400"; 
   d="scan'208";a="112236317"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 06:02:02 +0800
IronPort-SDR: nC1thnorkCFYRKrMuN/aTZuBlgcS/x7YV00V11mloa/NB+x5/FNEGTMHoRLNEakwuH8ov/kHTz
 csuQLDSp2KV/UsBe2ZPjUTlg+2aC/MlXyI1fEcXwTTljGG79c5L8hOq2WhfXIpzU4khiwrmi0r
 SLju45Ci3S5SJPIiwEuwYkrf8WO6HiD8iwx+PmDIQeVQh2Au0DhSTUNL1ML9uXtbWAQlVf752H
 URudBOodBR93KLTdw+PES3MfHus00W8U12vaBOsEm0PhwgDJdHki4rPeeHvSmHj0PHg34NY0jD
 YPyml6MP8+36/lZA6k/CWyd1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 15:01:29 -0700
IronPort-SDR: Eh8nzoEjEo4/6sQZ7gX/2V9zmDpDLOmexXzIJESF5tcnbR1eZkpiazr2OnIY4svmD+OHRqQIXB
 3Xl59w86j++8O1FoI1JzBPF/4JI6Bp5CdWFtZNxiu7GQPXC0dmHpwKJUCVKzMFGwZIZDze3mN4
 X9Pb0uckaGhqyj0gKiBjkfyL8U4D8wufWHvkeN79KDhAmtIIlG9JmaszRJVCNEzZAw2ajM9veG
 8MjzHORUHRJHORJMUZ36YNeS7WezI2T5xOeZiP+GeP8/IPDIMGFDIQrhCVIfPgRCXQlrzZVp9d
 HRE=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 15:02:02 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/3] block: code cleanup queue_poll_stat_show()
Date:   Wed, 19 Jun 2019 15:01:50 -0700
Message-Id: <20190619220150.6271-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
References: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a pure code cleanup patch and doesn't change any functionality.
Having multiple coding styles in the code creates confusion when
someone tries to add a new code.

Make queue_poll_stat_show() consistent by adding spaces around binary
operators with the rest of the code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 03b6aabbe602..a8376cc06a39 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -29,13 +29,13 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
 	struct request_queue *q = data;
 	int bucket;
 
-	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS/2; bucket++) {
-		seq_printf(m, "read  (%d Bytes): ", 1 << (9+bucket));
-		print_stat(m, &q->poll_stat[2*bucket]);
+	for (bucket = 0; bucket < (BLK_MQ_POLL_STATS_BKTS / 2); bucket++) {
+		seq_printf(m, "read  (%d Bytes): ", 1 << (9 + bucket));
+		print_stat(m, &q->poll_stat[2 * bucket]);
 		seq_puts(m, "\n");
 
-		seq_printf(m, "write (%d Bytes): ",  1 << (9+bucket));
-		print_stat(m, &q->poll_stat[2*bucket+1]);
+		seq_printf(m, "write (%d Bytes): ",  1 << (9 + bucket));
+		print_stat(m, &q->poll_stat[2 * bucket + 1]);
 		seq_puts(m, "\n");
 	}
 	return 0;
-- 
2.19.1

