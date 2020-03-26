Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40207C43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F86320748
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJpCgo34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgCZLMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:12:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46864 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZLMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 07:12:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id k191so2678216pgc.13;
        Thu, 26 Mar 2020 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UzzDt0/zC8t7ovhe7yIj9+UNLH3ZfB9o+FewH6cOgh4=;
        b=eJpCgo34rTMlyH3BQTttLC8UZfwApCAG/DM+Q6SPEsyflv8/b0pm1u0BWgpAsFEsDN
         LinFDIZOcxNI7oIt+5KyIMBr/pnzuH+wKN1Sua3xMiPXT40HlPYSBa4A3HYZBBR/okXG
         B+Gd2XqPkQLdJNnPwnIvPGwsZ3okp74+Gi6RaTd6Tq7fnwm4HNBQILCRWs9O/9/9VxWz
         WjnqyyApKROpRAwLQsANc/upj2KMXuL81L7kEIlTmCok8V9sPba9ToDQs325MFeGIbCz
         jrbZy5gWvA0nirDhtNON1JeWDZvj+EgDQ6aiLZXFHPPp78GN6mVyeqgp693wacyk2ACO
         N1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UzzDt0/zC8t7ovhe7yIj9+UNLH3ZfB9o+FewH6cOgh4=;
        b=jzx18mznYK3UrfWkpPDtaAxiAjvcC7djx8elfdu/+yks5YgIrGm0T/L69VdBNEkp3f
         pkyLjk1RrjA/SB4OFjcOw3ErXfdRZcxiNPyqQAoLUHedyAoCVQCEM1UfjKzhtcGJCjDF
         y8JA0+V8/o3Dr2/WHoQFgUOivFGk6giiFvA/EO/9hno3NwXFNWTnGGufG9SwlmVTaFY9
         cQRB6CjJkDVXRt9nppH/frdi8q+l0xv07P+OrkGMB5c7NjJNPmBCNdysoY8psJx9sEBe
         LygD+kFZ8Ha5b6KVNviw8/PG+I1AA5lZBbnWoVfF3XKdt8cY6i1VKLGwTYPCZhYYNQhk
         Mm3g==
X-Gm-Message-State: ANhLgQ29Z4DKt6Z1zBqM3uaQzohOK9eIHzc7Hh0VPGqZ19O4zZ9+UKWU
        hjfPZrChck2BQMOx1im2b90=
X-Google-Smtp-Source: ADFU+vvamjy5zGNHJhHUhozynw5nSgVNpikKb1pWFXwb+S/0IjyUw+YsyDdNm/I7Qw9TJEhOD73epQ==
X-Received: by 2002:a62:6807:: with SMTP id d7mr8529801pfc.230.1585221161955;
        Thu, 26 Mar 2020 04:12:41 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m9sm1427723pff.93.2020.03.26.04.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 04:12:41 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, peterz@infradead.org,
        akpm@linux-foundation.org, mhocko@kernel.org, axboe@kernel.dk,
        mgorman@suse.de, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/2] psi: enhance psi with the help of ebpf
Date:   Thu, 26 Mar 2020 07:12:05 -0400
Message-Id: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PSI gives us a powerful way to anaylze memory pressure issue, but we can
make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
Especially with ebpf we can flexiblely get more details of the memory
pressure.

In orderc to achieve this goal, a new parameter is added into
psi_memstall_{enter, leave}, which indicates the specific type of a
memstall. There're totally ten memstalls by now,
        MEMSTALL_KSWAPD
        MEMSTALL_RECLAIM_DIRECT
        MEMSTALL_RECLAIM_MEMCG
        MEMSTALL_RECLAIM_HIGH
        MEMSTALL_KCOMPACTD
        MEMSTALL_COMPACT
        MEMSTALL_WORKINGSET_REFAULT
        MEMSTALL_WORKINGSET_THRASHING
        MEMSTALL_MEMDELAY
        MEMSTALL_SWAPIO
With the help of kprobe or tracepoint to trace this newly added agument we
can know which type of memstall it is and then do corresponding
improvement. I can also help us to analyze the latency spike caused by
memory pressure.

But note that we can't use it to build memory pressure for a specific type
of memstall, e.g. memcg pressure, compaction pressure and etc, because it
doesn't implement various types of task->in_memstall, e.g.
task->in_memcgstall, task->in_compactionstall and etc.

Although there're already some tracepoints can help us to achieve this
goal, e.g.
        vmscan:mm_vmscan_kswapd_{wake, sleep}
        vmscan:mm_vmscan_direct_reclaim_{begin, end}
        vmscan:mm_vmscan_memcg_reclaim_{begin, end}
        /* no tracepoint for memcg high reclaim*/
        compcation:mm_compaction_kcompactd_{wake, sleep}
        compcation:mm_compaction_begin_{begin, end}
        /* no tracepoint for workingset refault */
        /* no tracepoint for workingset thrashing */
        /* no tracepoint for use memdelay */
        /* no tracepoint for swapio */
but psi_memstall_{enter, leave} gives us a unified entrance for all
types of memstall and we don't need to add many begin and end tracepoints
that hasn't been implemented yet.

Patch #2 gives us an example of how to use it with ebpf. With the help of
ebpf we can trace a specific task, application, container and etc. It also
can help us to analyze the spread of latencies and whether they were
clustered at a point of time or spread out over long periods of time.

Yafang Shao (2):
  psi: introduce various types of memstall
  psi, tracepoint: introduce tracepoints for psi_memstall_{enter, leave}

 block/blk-cgroup.c           |  4 ++--
 block/blk-core.c             |  4 ++--
 include/linux/psi.h          | 15 +++++++++++----
 include/linux/psi_types.h    | 13 +++++++++++++
 include/trace/events/sched.h | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/psi.c           | 14 ++++++++++++--
 mm/compaction.c              |  4 ++--
 mm/filemap.c                 |  4 ++--
 mm/memcontrol.c              |  4 ++--
 mm/page_alloc.c              |  8 ++++----
 mm/page_io.c                 |  4 ++--
 mm/vmscan.c                  |  8 ++++----
 12 files changed, 97 insertions(+), 26 deletions(-)

-- 
1.8.3.1

