Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F158C2D0EE
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50875206DB
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC/8nLqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgCaKFk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:05:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35903 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaKFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 06:05:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id c23so1748594pgj.3;
        Tue, 31 Mar 2020 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jde356x7OUSc/Bp1j+s7N+aNB1dzdB1pnUBgckdQu7k=;
        b=PC/8nLqZRbwWAJDN/Whp+AjZkOzcriGF7a5GXqu/Yw17uTgIRQTr2fCDE8s9RRQcEI
         mRrL08hMmHo6BABkYQRe0Ut0wwJnbhBerHVlJasIpFfsDVniuf9rWedzrJwthsilEEIa
         30Ii5YSl9XZUIhr42cdEAF6H4kZyPxuYs17m9GSnvyytCZFh3NBfGfqnF5XQjmCpkcxR
         NSZvVdYznFWvEjjJR0eHllb156SB2vZwL6ulrqBbgFv1AwOTJPUdPe9wwmYvCBRjeytY
         bovCxxbf8F9Tj8sm+IBkQsbEcvqO6e93YvIyUOPJgH9h5xD5UnOgeRM1kg6X6DpoGKQI
         2loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jde356x7OUSc/Bp1j+s7N+aNB1dzdB1pnUBgckdQu7k=;
        b=NPjyiaMTolW4/hNz+dqOqQEi0vzL61ndi4vo2mTN6vbdbQLFMudHr4n4bWlYIaanTC
         cJYvbau+0YbuWF0iF07ehkOx+X4p9oTAKAVHH/kexu+OPK84X+9TuyhAGU8sdgR63QBO
         Wo7pOdBo2ZRld4103Ghq2cz93tzyKQaBt5+9dVcorHbQNETv3YE2llqHnlCEF1RkiEl7
         0NLsjtTAZCIWKPILiurHaLwnupHGj+8kpsdHROWwpVWG0sFdL8o1dcpumK9UUWIQRcWx
         cchPGDHNHS4ck2esHwAloyPIL1m/QW2R5y2/fty/qFfZ4vAtNlSQwP+xF+DxLCKxOIin
         k+zw==
X-Gm-Message-State: AGi0PuaDyvaI+p7vecpBMA8NvnXw9Rn32buviu9ABcUT8BBrzHojstTJ
        1u0EFlxsYYAR9RMbxG1gosRaEHUSjt0k/w==
X-Google-Smtp-Source: APiQypKKTQ9gpnEDt3Fh2IjtoGiTIL94uGDe2FOPJ2UaKVSv8pSXE4LZyvu98LBIQWhyGhLtK4Zm9A==
X-Received: by 2002:a63:1053:: with SMTP id 19mr3550400pgq.60.1585649137821;
        Tue, 31 Mar 2020 03:05:37 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y207sm12354592pfb.189.2020.03.31.03.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 03:05:37 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, peterz@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 2/2] psi, tracepoint: introduce tracepoints for psi_memstall_{enter, leave}
Date:   Tue, 31 Mar 2020 06:04:37 -0400
Message-Id: <1585649077-10896-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585649077-10896-1-git-send-email-laoar.shao@gmail.com>
References: <1585649077-10896-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the new parameter introduced in psi_memstall_{enter, leave} we can
get the specific type of memstal. To make it easier to use, we'd better
introduce tracepoints for them. Once these two tracepoints are added we
can easily use other tools like ebpf or bash script to collect the
memstall data and analyze.

The output of these tracepoints is,

          usemem-30288 [012] .... 302479.734290: psi_memstall_enter: type=MEMSTALL_RECLAIM_DIRECT
          usemem-30288 [012] .N.. 302479.741186: psi_memstall_leave: type=MEMSTALL_RECLAIM_DIRECT
          usemem-30288 [021] .... 302479.742075: psi_memstall_enter: type=MEMSTALL_COMPACT
          usemem-30288 [021] .... 302479.744869: psi_memstall_leave: type=MEMSTALL_COMPACT
           <...>-388   [000] .... 302514.609040: psi_memstall_enter: type=MEMSTALL_KSWAPD
         kswapd0-388   [000] .... 302514.616376: psi_memstall_leave: type=MEMSTALL_KSWAPD
           <...>-223   [024] .... 302514.616380: psi_memstall_enter: type=MEMSTALL_KCOMPACTD
      kcompactd0-223   [024] .... 302514.618414: psi_memstall_leave: type=MEMSTALL_KCOMPACTD
   supervisorctl-31675 [014] .... 302516.281293: psi_memstall_enter: type=MEMSTALL_WORKINGSET_REFAULT
   supervisorctl-31675 [014] .N.. 302516.281314: psi_memstall_leave: type=MEMSTALL_WORKINGSET_REFAULT
            bash-32092 [034] .... 302526.225639: psi_memstall_enter: type=MEMSTALL_WORKINGSET_THRASH
            bash-32092 [034] .... 302526.225843: psi_memstall_leave: type=MEMSTALL_WORKINGSET_THRASH

Here's one example with bpftrace to measure application's latency with
these tracepoints.

tracepoint:sched:psi_memstall_enter
{
        @start[tid, args->type] = nsecs
}

tracepoint:sched:psi_memstall_leave
{
        @time[comm, args->type] = hist(nsecs - @start[tid, args->type]);
        delete(@start[tid, args->type]);
}

Bellow is part of the result after producing some memory pressure.
@time[objdump, 7]:
[256K, 512K)           1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@time[objdump, 6]:
[8K, 16K)              2 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@time[objcopy, 7]:
[16K, 32K)             1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)             0 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@time[ld, 7]:
[4M, 8M)               1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8M, 16M)              1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@time[khugepaged, 5]:
[4K, 8K)               1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8K, 16K)              0 |                                                    |
[16K, 32K)             0 |                                                    |
[32K, 64K)             0 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              0 |                                                    |
[16M, 32M)             0 |                                                    |
[32M, 64M)             1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@time[kswapd0, 0]:
[16K, 32K)             1 |@@@@@                                               |
[32K, 64K)             0 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              1 |@@@@@                                               |
[16M, 32M)            10 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32M, 64M)             9 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
[64M, 128M)            2 |@@@@@@@@@@                                          |
[128M, 256M)           2 |@@@@@@@@@@                                          |
[256M, 512M)           3 |@@@@@@@@@@@@@@@                                     |
[512M, 1G)             1 |@@@@@                                               |

@time[kswapd1, 0]:
[1M, 2M)               1 |@@@@                                                |
[2M, 4M)               2 |@@@@@@@@                                            |
[4M, 8M)               0 |                                                    |
[8M, 16M)             12 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[16M, 32M)             7 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                      |
[32M, 64M)             5 |@@@@@@@@@@@@@@@@@@@@@                               |
[64M, 128M)            5 |@@@@@@@@@@@@@@@@@@@@@                               |
[128M, 256M)           3 |@@@@@@@@@@@@@                                       |
[256M, 512M)           1 |@@@@                                                |

@time[khugepaged, 1]:
[2M, 4M)               1 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

From these traced data, we can find that the high latencies of user tasks
are always type 7 of memstall,  which is MEMSTALL_WORKINGSET_THRASH, and
then we should look into the details of wokingset of the user tasks and think
about how to improve it - for example by reducing the workingset.

With the builtin variable 'cgroup' of bpftrace we can also filter a
memcg and its descendants.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/sched.h | 41 ++++++++++++++++++++++++++++++++++++
 kernel/sched/psi.c           |  8 +++++++
 2 files changed, 49 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e56e55..8ea2cdf78810 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -7,8 +7,20 @@
 
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
+#include <linux/psi_types.h>
 #include <linux/binfmts.h>
 
+#define show_psi_memstall_type(type) __print_symbolic(type,		\
+	{MEMSTALL_KSWAPD, "MEMSTALL_KSWAPD"},				\
+	{MEMSTALL_RECLAIM_DIRECT, "MEMSTALL_RECLAIM_DIRECT"},		\
+	{MEMSTALL_RECLAIM_MEMCG, "MEMSTALL_RECLAIM_MEMCG"},		\
+	{MEMSTALL_RECLAIM_HIGH, "MEMSTALL_RECLAIM_HIGH"},		\
+	{MEMSTALL_KCOMPACTD, "MEMSTALL_KCOMPACTD"},			\
+	{MEMSTALL_COMPACT, "MEMSTALL_COMPACT"},				\
+	{MEMSTALL_WORKINGSET_REFAULT, "MEMSTALL_WORKINGSET_REFAULT"},	\
+	{MEMSTALL_WORKINGSET_THRASH, "MEMSTALL_WORKINGSET_THRASH"},	\
+	{MEMSTALL_MEMDELAY, "MEMSTALL_MEMDELAY"},			\
+	{MEMSTALL_SWAPIO, "MEMSTALL_SWAPIO"})
 /*
  * Tracepoint for calling kthread_stop, performed to end a kthread:
  */
@@ -625,6 +637,35 @@ DECLARE_TRACE(sched_overutilized_tp,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
 
+DECLARE_EVENT_CLASS(psi_memstall_template,
+
+	TP_PROTO(int type),
+
+	TP_ARGS(type),
+
+	TP_STRUCT__entry(
+		__field(int, type)
+	),
+
+	TP_fast_assign(
+		__entry->type = type;
+	),
+
+	TP_printk("type=%s",
+		show_psi_memstall_type(__entry->type))
+);
+
+DEFINE_EVENT(psi_memstall_template, psi_memstall_enter,
+	TP_PROTO(int type),
+	TP_ARGS(type)
+);
+
+DEFINE_EVENT(psi_memstall_template, psi_memstall_leave,
+	TP_PROTO(int type),
+	TP_ARGS(type)
+);
+
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 460f08436b58..4c5a40222e88 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -142,6 +142,8 @@
 #include <linux/psi.h>
 #include "sched.h"
 
+#include <trace/events/sched.h>
+
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
@@ -822,6 +824,9 @@ void psi_memstall_enter(unsigned long *flags, enum memstall_types type)
 	*flags = current->flags & PF_MEMSTALL;
 	if (*flags)
 		return;
+
+	trace_psi_memstall_enter(type);
+
 	/*
 	 * PF_MEMSTALL setting & accounting needs to be atomic wrt
 	 * changes to the task's scheduling state, otherwise we can
@@ -852,6 +857,9 @@ void psi_memstall_leave(unsigned long *flags, enum memstall_types type)
 
 	if (*flags)
 		return;
+
+	trace_psi_memstall_leave(type);
+
 	/*
 	 * PF_MEMSTALL clearing & accounting needs to be atomic wrt
 	 * changes to the task's scheduling state, otherwise we could
-- 
2.18.2

