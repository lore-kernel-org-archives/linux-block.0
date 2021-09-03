Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B2BC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 06:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6FE610C8
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 06:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347434AbhICGvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 02:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhICGvk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 02:51:40 -0400
X-Greylist: delayed 138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Sep 2021 23:50:41 PDT
Received: from devnull.tasossah.com (devnull.tasossah.com [IPv6:2001:41d0:1:e60e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46352C061575
        for <linux-block@vger.kernel.org>; Thu,  2 Sep 2021 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=devnull.tasossah.com; s=vps; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gOolat0RrxckF8uAWUwI0MxKo0sqb8jwXCsNECwLuvY=; b=mJfZ8M4NC28X9IuZSIyO0P0Q8j
        sjxN3jEN8I1xaUhvDQFaFr2E9axY8kLjOASZ80viFBbsyAVgqEtaZ+6oGfrxGyS4mHVPBJSWp/hiH
        m5mO6lgtN/kmPzpDf9WjoQINrdoZ1nkz+8MQCDAfnlf85XUE5QurFanHFYyuzsP7C6Rw=;
Received: from [2a02:587:6a0b:c600::298]
        by devnull.tasossah.com with esmtpsa (TLS1.2:ECDHE_ECDSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <tasos@tasossah.com>)
        id 1mM2zb-00042D-V2; Fri, 03 Sep 2021 09:48:04 +0300
To:     linux-block@vger.kernel.org
From:   Tasos Sahanidis <tasos@tasossah.com>
Cc:     axboe@kernel.dk, efremov@linux.com, jkosina@suse.cz,
        tasos@tasossah.com
Subject: [PATCH] floppy: Fix hang in watchdog when disk is ejected
Message-ID: <399e486c-6540-db27-76aa-7a271b061f76@tasossah.com>
Date:   Fri, 3 Sep 2021 09:47:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the watchdog detects a disk change, it calls cancel_activity(),
which in turn tries to cancel the fd_timer delayed work.

In the above scenario, fd_timer_fn is set to fd_watchdog(), meaning
it is trying to cancel its own work.
This results in a hang as cancel_delayed_work_sync() is waiting for the
watchdog (itself) to return, which never happens.

This can be reproduced relatively consistently by attempting to read a
broken floppy, and ejecting it while IO is being attempted and retried.

To resolve this, this patch calls cancel_delayed_work() instead, which
cancels the work without waiting for the watchdog to return and finish.

Before this regression was introduced, the code in this section used
del_timer(), and not del_timer_sync() to delete the watchdog timer.

Fixes: 070ad7e793dc ("floppy: convert to delayed work and single-thread wq")
Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index fef79ea52..85464d72d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1014,7 +1014,7 @@ static DECLARE_DELAYED_WORK(fd_timer, fd_timer_workfn);
 static void cancel_activity(void)
 {
 	do_floppy = NULL;
-	cancel_delayed_work_sync(&fd_timer);
+	cancel_delayed_work(&fd_timer);
 	cancel_work_sync(&floppy_work);
 }
 
-- 
2.25.1

