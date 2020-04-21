Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462E5C54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2274420663
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGewKZSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgDUNIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:08:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57694 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUNIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 09:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587474515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AzZVGZRFYWkvvcngnwD9TafpdOgkW+w4tQcfoAHS564=;
        b=GGewKZSNG8k8W1UOzWjFh8SflS7U6gNmmj/XMW7hFQwI8HydpPeUlv8mvDQqH5e/8ynDcM
        LxEQKVWay5R1+2OpTm52bzBlumnY4Z0J7J0el3+/9jt/2GPBiQ1cw0brTcHg2CFgq/YcM3
        2UEdWk0tURSxnRjujJyLOvG4Soh4+1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-Z-WAIQBnM6m646W-EYPzhA-1; Tue, 21 Apr 2020 09:08:33 -0400
X-MC-Unique: Z-WAIQBnM6m646W-EYPzhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E9518C8C0C;
        Tue, 21 Apr 2020 13:08:31 +0000 (UTC)
Received: from llong.com (ovpn-114-241.rdu2.redhat.com [10.10.114.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B0B31001B0B;
        Tue, 21 Apr 2020 13:08:24 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
Date:   Tue, 21 Apr 2020 09:07:55 -0400
Message-Id: <20200421130755.18370-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Systemtap 4.2 is unable to correctly interpret the "u32 (*missed_ppm)[2]"
argument of the iocost_ioc_vrate_adj trace entry defined in
include/trace/events/iocost.h leading to the following error:

  /tmp/stapAcz0G0/stap_c89c58b83cea1724e26395efa9ed4939_6321_aux_6.c:78:8=
:
  error: expected =E2=80=98;=E2=80=99, =E2=80=98,=E2=80=99 or =E2=80=98)=E2=
=80=99 before =E2=80=98*=E2=80=99 token
   , u32[]* __tracepoint_arg_missed_ppm

That argument type is indeed rather complex and hard to read. Looking
at block/blk-iocost.c. It is just a 2-entry u32 array. By simplifying
the argument to a simple "u32 *missed_ppm" and adjusting the trace
entry accordingly, the compilation error was gone.

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Signed-off-by: Waiman Long <longman@redhat.com>
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
=20
-		trace_iocost_ioc_vrate_adj(ioc, vrate, &missed_ppm, rq_wait_pct,
+		trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
 					   nr_lagging, nr_shortages,
 					   nr_surpluses);
=20
@@ -1600,7 +1600,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 			ioc->period_us * vrate * INUSE_MARGIN_PCT, 100);
 	} else if (ioc->busy_level !=3D prev_busy_level || nr_lagging) {
 		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
-					   &missed_ppm, rq_wait_pct, nr_lagging,
+					   missed_ppm, rq_wait_pct, nr_lagging,
 					   nr_shortages, nr_surpluses);
 	}
=20
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.=
h
index 7ecaa65b7106..c2f580fd371b 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -130,7 +130,7 @@ DEFINE_EVENT(iocg_inuse_update, iocost_inuse_reset,
=20
 TRACE_EVENT(iocost_ioc_vrate_adj,
=20
-	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 (*missed_ppm)[2],
+	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 *missed_ppm,
 		u32 rq_wait_pct, int nr_lagging, int nr_shortages,
 		int nr_surpluses),
=20
@@ -155,8 +155,8 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 		__entry->old_vrate =3D atomic64_read(&ioc->vtime_rate);;
 		__entry->new_vrate =3D new_vrate;
 		__entry->busy_level =3D ioc->busy_level;
-		__entry->read_missed_ppm =3D (*missed_ppm)[READ];
-		__entry->write_missed_ppm =3D (*missed_ppm)[WRITE];
+		__entry->read_missed_ppm =3D missed_ppm[READ];
+		__entry->write_missed_ppm =3D missed_ppm[WRITE];
 		__entry->rq_wait_pct =3D rq_wait_pct;
 		__entry->nr_lagging =3D nr_lagging;
 		__entry->nr_shortages =3D nr_shortages;
--=20
2.18.1

