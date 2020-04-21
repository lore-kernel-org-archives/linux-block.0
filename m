Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E440DC54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 18:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38382054F
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 18:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdDxnU61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDUS6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:58:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40217 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725918AbgDUS6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 14:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587495511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=rUPjxBn3nVUsB3LHb1zBAgrE865CvJIwCFnHhNpJjCs=;
        b=EdDxnU61LMKulDWL2yttQt+HO1fAkQccvZzFEu6RmtklM9/VwhgwXqXGaGTecIvSFxFboh
        6avAEiPYMjP9zw5mbwLop5Ov8lc1yArwTInYA6JRQpkxCUL8QklduASNHwsdRnQFEzktc6
        FAjSCYymLPT8CrbPSJVW5J5aXc5+9do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-QJ7adI31OCuUQsmIm-vRDg-1; Tue, 21 Apr 2020 14:58:27 -0400
X-MC-Unique: QJ7adI31OCuUQsmIm-vRDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F14DE107ACCC;
        Tue, 21 Apr 2020 18:58:25 +0000 (UTC)
Received: from llong.com (ovpn-114-241.rdu2.redhat.com [10.10.114.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17B1A60C63;
        Tue, 21 Apr 2020 18:58:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] blk-iocost: Simplify parameter type in iocost_ioc_vrate_adj trace entry
Date:   Tue, 21 Apr 2020 14:58:00 -0400
Message-Id: <20200421185800.22094-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The iocost_ioc_vrate_adj() trace entry in include/trace/events/iocost.h
has one parameter of type "u32 (*missed_ppm)[2]" which is rather ugly
and hard to read. It makes me think for seconds to figure out what
it is and I have to double-check the the caller to confirm that it is
actually a pointer to a 2-entry u32 array.

It also happens that some tools that parse trace entries may not be
able to correctly interpret this parameter type which leads me to take
a look in the first place.

For simplicity sake, it is better to change the parameter type to just
"u32 *" and adjust the trace entry accordingly.

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c            | 4 ++--
 include/trace/events/iocost.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index db35ee682294..3ab0c1c704b6 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1591,7 +1591,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 				      vrate_min, vrate_max);
 		}
 
-		trace_iocost_ioc_vrate_adj(ioc, vrate, &missed_ppm, rq_wait_pct,
+		trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
 					   nr_lagging, nr_shortages,
 					   nr_surpluses);
 
@@ -1600,7 +1600,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 			ioc->period_us * vrate * INUSE_MARGIN_PCT, 100);
 	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
 		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
-					   &missed_ppm, rq_wait_pct, nr_lagging,
+					   missed_ppm, rq_wait_pct, nr_lagging,
 					   nr_shortages, nr_surpluses);
 	}
 
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index 7ecaa65b7106..c2f580fd371b 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -130,7 +130,7 @@ DEFINE_EVENT(iocg_inuse_update, iocost_inuse_reset,
 
 TRACE_EVENT(iocost_ioc_vrate_adj,
 
-	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 (*missed_ppm)[2],
+	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 *missed_ppm,
 		u32 rq_wait_pct, int nr_lagging, int nr_shortages,
 		int nr_surpluses),
 
@@ -155,8 +155,8 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
-		__entry->read_missed_ppm = (*missed_ppm)[READ];
-		__entry->write_missed_ppm = (*missed_ppm)[WRITE];
+		__entry->read_missed_ppm = missed_ppm[READ];
+		__entry->write_missed_ppm = missed_ppm[WRITE];
 		__entry->rq_wait_pct = rq_wait_pct;
 		__entry->nr_lagging = nr_lagging;
 		__entry->nr_shortages = nr_shortages;
-- 
2.18.1

