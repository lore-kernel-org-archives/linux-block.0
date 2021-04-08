Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA6C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAF96113D
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhDHQrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhDHQrS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 12:47:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95854C061760;
        Thu,  8 Apr 2021 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VAaxG7DlA7LeEZLGQT4kdCo/q34NW8YrEoeuVr25p5M=; b=Gyj3FrmnULP7lQRybm7S3yj4qD
        B/GaTufZN+kEXewgtAMcVD5ukz5ql3LJH2LRk8yQJtH/tcLW92dQgcS2BUQPZ5qwsXD84ZcRymulN
        QV3ZUjwut8tGZcEVwBo7hUIADrNyFsQ9UmZV1wsW3dGPbw3XkhGuhl/o4WQzVF9MbN6BrL4/AwtLW
        2Dq977YtYltmFn8usn+2hTEsfBY44EfX4YDOerl9gFwppM48r8Hdzten93iYQL4jrygYCWApr6grV
        /ffjNwN3TR+348ifDNwvnDT3RVy/1TbR8qfx/0blAISMoYwaQRc/8SkmcRExUKV86tWvWlEBIeWNn
        Zd0rQBLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXna-00GXc3-SG; Thu, 08 Apr 2021 16:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CD4A3001CD;
        Thu,  8 Apr 2021 18:46:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E90432BE57BBA; Thu,  8 Apr 2021 11:46:12 +0200 (CEST)
Date:   Thu, 8 Apr 2021 11:46:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix sys_ioprio_set(.which=IOPRIO_WHO_PGRP) task
 iteration
Message-ID: <YG7Q5C4Rb5dx5GFx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


do_each_pid_thread() { } while_each_pid_thread() is a double loop and
thus break doesn't work as expected. Also, it should be used under
tasklist_lock because otherwise we can race against change_pid() for
PGID/SID.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 block/ioprio.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -119,11 +119,17 @@ SYSCALL_DEFINE3(ioprio_set, int, which,
 				pgrp = task_pgrp(current);
 			else
 				pgrp = find_vpid(who);
+
+			read_lock(&tasklist_lock);
 			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 				ret = set_task_ioprio(p, ioprio);
-				if (ret)
-					break;
+				if (ret) {
+					read_unlock(&tasklist_lock);
+					goto out;
+				}
 			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+			read_unlock(&tasklist_lock);
+
 			break;
 		case IOPRIO_WHO_USER:
 			uid = make_kuid(current_user_ns(), who);
@@ -153,6 +159,7 @@ SYSCALL_DEFINE3(ioprio_set, int, which,
 			ret = -EINVAL;
 	}
 
+out:
 	rcu_read_unlock();
 	return ret;
 }
