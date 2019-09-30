Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF62C35280
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EE62053B
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfI3XA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:00:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37526 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:00:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so6466005pfo.4
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=344eJ05CFQcBsgTWyIrRGJ8FcbpIVlOeQYSaWb8S7Fs=;
        b=bKylK8fghroJWf/YC5OPpbdT1wzKD4Vhr4V4MA5QtvH7wTdOmlZX2juz7ZqTiZZREQ
         FZotCs0RMvzsy0YDlzpJ6R+XwZjEeBCRvuZsaSoTsi2Q8y0QsEs4vS0WgVt8uRYFQjVu
         SEcWTJYr0PLSVFCfBOFd5eavIK3A+9+TDnFAEU4GJ84fitGymXs+1PBch6xn8PEyYT9j
         cYHQ6X1LWRtEfPJV/GywDWSGMN5G0XFHqag7DfZL49Ab7FgFPCULNFh6OLtWULc0rpk8
         3OmK9b2lfaX0qaDyT39wc+N0XVlRHlJib7Kozqbk3N7+CRYfUbCBZuUXh5NZLkAW5aYP
         N/zg==
X-Gm-Message-State: APjAAAUungsZxuxHkQ/wTfq27gshNmKzUEsL3Hxp1sxkv5n795F9Fkoj
        fS7RPC+MQ6SKuuLM5+OC83s=
X-Google-Smtp-Source: APXvYqxiLyT2ggXAqcfujMoHjPmqzifRaYLNnCY4UvOXbFr2AooHE1nYPXTTz/lYz280x627E9fGKg==
X-Received: by 2002:a17:90a:1b48:: with SMTP id q66mr1825898pjq.79.1569884458055;
        Mon, 30 Sep 2019 16:00:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:00:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/8] block: Fix writeback throttling W=1 compiler warnings
Date:   Mon, 30 Sep 2019 16:00:41 -0700
Message-Id: <20190930230047.44113-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following compiler warnings:

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:21,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from ./include/linux/bvec.h:13,
                 from ./include/linux/blk_types.h:10,
                 from block/blk-wbt.c:23:
In function 'strncpy',
    inlined from 'perf_trace_wbt_stat' at ./include/trace/events/wbt.h:15:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'perf_trace_wbt_lat' at ./include/trace/events/wbt.h:58:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'perf_trace_wbt_step' at ./include/trace/events/wbt.h:87:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'perf_trace_wbt_timer' at ./include/trace/events/wbt.h:126:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'trace_event_raw_event_wbt_stat' at ./include/trace/events/wbt.h:15:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'trace_event_raw_event_wbt_lat' at ./include/trace/events/wbt.h:58:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'trace_event_raw_event_wbt_timer' at ./include/trace/events/wbt.h:126:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'trace_event_raw_event_wbt_step' at ./include/trace/events/wbt.h:87:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism"; v4.10).
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/trace/events/wbt.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index b048694070e2..37342a13c9cb 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -33,7 +33,8 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev),
+			ARRAY_SIZE(__entry->name));
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
 		__entry->rmax		= stat[0].max;
@@ -67,7 +68,8 @@ TRACE_EVENT(wbt_lat,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev),
+			ARRAY_SIZE(__entry->name));
 		__entry->lat = div_u64(lat, 1000);
 	),
 
@@ -103,7 +105,8 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev),
+			ARRAY_SIZE(__entry->name));
 		__entry->msg	= msg;
 		__entry->step	= step;
 		__entry->window	= div_u64(window, 1000);
@@ -138,7 +141,8 @@ TRACE_EVENT(wbt_timer,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev),
+			ARRAY_SIZE(__entry->name));
 		__entry->status		= status;
 		__entry->step		= step;
 		__entry->inflight	= inflight;
-- 
2.23.0.444.g18eeb5a265-goog

