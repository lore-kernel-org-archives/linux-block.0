Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA2C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbiFUKZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346796AbiFUKY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:24:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD42898A
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:24:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 25C881FB02;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neCImrPNIM49vhJQ2ShqPqogntJNWoMZW4WSJ3vzeOI=;
        b=BSEUQjLIauOjR0k5tzyOtsplLvwsMJf83r2UgmvnxWLMdVdsEuVVl3A44EJmAtnyMO7Dkt
        Ao/bJPwGHAvXJRU381eAWcrpWuoZqvk0WC6ZfVjmT+j20/ybNkj7ug8IUde02rxEHL0ZJ6
        0jxNycRXzjua7xC2pXJlK+KYdll4OkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neCImrPNIM49vhJQ2ShqPqogntJNWoMZW4WSJ3vzeOI=;
        b=WFStd3IyG28jIxJLjmB0XBxoEl1wfXtEw/8+bCHiPOdRhYwhhPdP3Q8eYSvSmn6b2UV4r/
        MVYX6M0lcgWylBCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DDD982C146;
        Tue, 21 Jun 2022 10:24:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E496CA063B; Tue, 21 Jun 2022 12:24:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/9] block: Make ioprio_best() static
Date:   Tue, 21 Jun 2022 12:24:41 +0200
Message-Id: <20220621102455.13183-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
References: <20220621102201.26337-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; h=from:subject; bh=ljYtpqMRICi8VhWJ1c8qfrBUQ6Hh1y2sIbE+Yv5+WBs=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJI2zsn0YesLUy4++b1n9s0rx/6d1GmRfniSsSXKwuX/ZsFY hyLuTkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBMZA0TB8N5x5MnMv+4nVBb51W3In F5H5/5O6sDqSkPWW9O3KD09KVmZUNpe57HWm4pp8k3k00tuoNZsh58vmzZoz7XLIzj+oMuI4YTds/e T/fPWNn3buukX61Ktlc0fOzsjvv5r1CSXGEauFs4XvuBeLpyZFWcoluzp9SKihXcgcevxQc2xNiIX1 dp3fhCSf/8vPu8ixeba2lyLI2burnO/ZtVduNGTX5h2QjGnfOU4607QrNcRFoSi/auMVm/8mKCXNjz Dgv+Sy4HRdVnZL7NSF7ZdCh+w581zFM4X7bapnZvenqoUSZQ+1ooq0BL1fElVX4GJuYBGgYGwXbHuo vunlgkY5InbrV8JnOAnyHPxNsA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nobody outside of block/ioprio.c uses it.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c         | 2 +-
 include/linux/ioprio.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index c4e3476155a1..8c46f672a0ba 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -180,7 +180,7 @@ static int get_task_ioprio(struct task_struct *p)
 	return ret;
 }
 
-int ioprio_best(unsigned short aprio, unsigned short bprio)
+static int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
 		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 788a8ff57068..3ba5804e5770 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -60,11 +60,6 @@ static inline int get_current_ioprio(void)
 	return __get_task_ioprio(current);
 }
 
-/*
- * For inheritance, return the highest of the two given priorities
- */
-extern int ioprio_best(unsigned short aprio, unsigned short bprio);
-
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
 
 #ifdef CONFIG_BLOCK
-- 
2.35.3

