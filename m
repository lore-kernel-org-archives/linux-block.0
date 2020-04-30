Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA0C28CBC
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF372063A
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255501;
	bh=f3rOv7jXSBRKwhcH/xi8Az3LAJfn4iVHQU1B6aVHB9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d+4nRAl61Awoqrf/+dBKgAPVrjfRV+tHY8ofCu/TmtUCF5JCUSZkFd2qrsmY1q5lO
	 nu9tg0urEnpU4s6oxnezlCPkvCa8MWDVU5OBYEug3X4z1+ZKPylzsCOCT2BR1BPzF1
	 XedfPemcKtyY0G4kD28XWbbbtEQEmaqcYde4OiFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgD3NxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgD3NxF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F9F2495A;
        Thu, 30 Apr 2020 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254785;
        bh=f3rOv7jXSBRKwhcH/xi8Az3LAJfn4iVHQU1B6aVHB9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AUGCAvvLE3XIpD9mPyws8R4W3bS6o1xJel2HS3iFs3gXGOj3u7gEn+x8JpfvVjhX
         zyFCqmID1TcyKe3rtxKJANFDu2H8wpyVVUocXy5gCYUp0mYkjwnW9prDZCLQPegv1R
         FoVfb2O+hnRMWw2zDNbDGky9+EL/8HHZeks/gIFM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 41/57] blk-iocost: Fix error on iocost_ioc_vrate_adj
Date:   Thu, 30 Apr 2020 09:52:02 -0400
Message-Id: <20200430135218.20372-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Waiman Long <longman@redhat.com>

[ Upstream commit d6c8e949a35d6906d6c03a50e9a9cdf4e494528a ]

Systemtap 4.2 is unable to correctly interpret the "u32 (*missed_ppm)[2]"
argument of the iocost_ioc_vrate_adj trace entry defined in
include/trace/events/iocost.h leading to the following error:

  /tmp/stapAcz0G0/stap_c89c58b83cea1724e26395efa9ed4939_6321_aux_6.c:78:8:
  error: expected ‘;’, ‘,’ or ‘)’ before ‘*’ token
   , u32[]* __tracepoint_arg_missed_ppm

That argument type is indeed rather complex and hard to read. Looking
at block/blk-iocost.c. It is just a 2-entry u32 array. By simplifying
the argument to a simple "u32 *missed_ppm" and adjusting the trace
entry accordingly, the compilation error was gone.

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c            | 4 ++--
 include/trace/events/iocost.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9a599cc28c290..2dc5dc54e257f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1594,7 +1594,7 @@ skip_surplus_transfers:
 				      vrate_min, vrate_max);
 		}
 
-		trace_iocost_ioc_vrate_adj(ioc, vrate, &missed_ppm, rq_wait_pct,
+		trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
 					   nr_lagging, nr_shortages,
 					   nr_surpluses);
 
@@ -1603,7 +1603,7 @@ skip_surplus_transfers:
 			ioc->period_us * vrate * INUSE_MARGIN_PCT, 100);
 	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
 		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
-					   &missed_ppm, rq_wait_pct, nr_lagging,
+					   missed_ppm, rq_wait_pct, nr_lagging,
 					   nr_shortages, nr_surpluses);
 	}
 
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index 7ecaa65b7106e..c2f580fd371b1 100644
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
2.20.1

