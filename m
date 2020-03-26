Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE28C2D0E5
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CE120409
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iELsYFB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCZLM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:12:57 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39876 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZLM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 07:12:57 -0400
Received: by mail-pj1-f65.google.com with SMTP id z3so1741546pjr.4;
        Thu, 26 Mar 2020 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lDcRAPOAOCjxei5GIfDQABYJpwvJHNWVWIgGygWjlfU=;
        b=iELsYFB7VpOogk9P9fQpVkKjPl9106/LwwtS35V+SKTH2G9QOEQme56XM0YTTDT0t7
         JyZMHFe17Ei43hfsUIZEl4y4TY2uOS+1VnORvr90+36VcG0y/qfGqU+dm9VBANQut0e0
         B1Z7rSwuXLh7uc8gyk0yGg+OlfSKCzwLTzeUUUvzHRJP7XdUAtt2p8KntcuIv5b5br1t
         GlD9yKSlI00phiyzl+vT22TZuGIa+f+TqCh/CXqFmxepjY4Bxya7ZAhf/cSYZykUmzxV
         fhQ93AF+6vmxuvTds1Q9pMK1+2dBYPI/qtG2EHNvWEzJyhHW1BAYrUCyGpAYwhzcy1U1
         6v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lDcRAPOAOCjxei5GIfDQABYJpwvJHNWVWIgGygWjlfU=;
        b=tB8E9xGCKuv6ui1koY9ucqsmsSKHPAIoYnNir6akk1h/iG1TZp3NRo0GIjKiSZYxhr
         0p99lvyFc+dXZCqcq8bcUc6DiqRGFODTx5Az75G/t+JjoBzK2WVOildFKwWX6cZzH6Zp
         qcnFuzmRsfLBNQ8QC0cTepxyZL7EgNRqq8273jhG0hkTNty2Eh6CuXVCn5pNHF/Pkccd
         MOAX1ZAO1Hr97NKgwSFocFRaKvTbtixl8dvSdafY5+GnelIcFfe8qE+j4SjmgYek6mwo
         qQNay2QYJW9wwyMG0KBd9HGdyw5v8eB06tsKwW3F6bctuI+e9a9BYItYYgph2ywIPPhs
         /SfQ==
X-Gm-Message-State: ANhLgQ23vRXx5t01li8Jv0dLYZ72FwNr5QGSjU/rq02/F2YgTmFELdL8
        2YwDSC9NRLviZyyjUfAFlpI=
X-Google-Smtp-Source: ADFU+vusNe8isEuLjYVdOaSJm3pPllANr4V6EDWHvBZaYRQbgIVI+9LfWkRoZv1XUfRz+yO5J9nohA==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr7030287plc.209.1585221174653;
        Thu, 26 Mar 2020 04:12:54 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m9sm1427723pff.93.2020.03.26.04.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 04:12:54 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, peterz@infradead.org,
        akpm@linux-foundation.org, mhocko@kernel.org, axboe@kernel.dk,
        mgorman@suse.de, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/2] psi, tracepoint: introduce tracepoints for psi_memstall_{enter, leave}
Date:   Thu, 26 Mar 2020 07:12:07 -0400
Message-Id: <1585221127-11458-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the new parameter introduced in psi_memstall_{enter, leave} we can
get the specific type of memstal. To make it easier to use, we'd better
introduce tracepoints for them. Once these two tracepoints are added we
can easily use other tools like ebpf or bash script to collect the
memstall data and analyze.

Here's one example with bpftrace to measure application's latency.
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

With the builtin variable 'cgroup' of bpftrace we can also filter a
memcg and its descendants.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/sched.h | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/psi.c           |  8 ++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e..6aca996 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -7,8 +7,20 @@
 
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
+#include <linux/psi_types.h>
 #include <linux/binfmts.h>
 
+#define show_psi_memstall_type(type) __print_symbolic(type,	\
+	{MEMSTALL_KSWAPD, "MEMSTALL_KSWAPD"},			\
+	{MEMSTALL_RECLAIM_DIRECT, "MEMSTALL_RECLAIM_DIRECT"},	\
+	{MEMSTALL_RECLAIM_MEMCG, "MEMSTALL_RECLAIM_MEMCG"},	\
+	{MEMSTALL_RECLAIM_HIGH, "MEMSTALL_RECLAIM_HIGH"},	\
+	{MEMSTALL_KCOMPACTD, "MEMSTALL_KCOMPACTD"},		\
+	{MEMSTALL_COMPACT, "MEMSTALL_COMPACT"},			\
+	{MEMSTALL_WORKINGSET, "MEMSTALL_WORKINGSET"},		\
+	{MEMSTALL_PGLOCK, "MEMSTALL_PGLOCK"},			\
+	{MEMSTALL_MEMDELAY, "MEMSTALL_MEMDELAY"},		\
+	{MEMSTALL_SWAP, "MEMSTALL_SWAP"})
 /*
  * Tracepoint for calling kthread_stop, performed to end a kthread:
  */
@@ -625,6 +637,35 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
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
index 460f084..4c5a402 100644
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
1.8.3.1

