Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E0DC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8E620781
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmh9cw24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgCaKF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:05:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32925 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaKF1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 06:05:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17so10143528pgo.0;
        Tue, 31 Mar 2020 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MW/RUvnmQuaynAgrPchgXaGJmLy9K9MyZdsdP/atZxQ=;
        b=Cmh9cw24+M8BWilx0CjDUaHf3t3v0OLeGEIO8C7anSi3OCUwApzJwB0Hw7p6WnUU2H
         VzCDTbCiTCx7KjDthnON+VQ9NoMDSpUhT+dyRXmi24ctl3Fb0aCmyxTU/WO+Iub2adeN
         6uWNuA1aM3OR5hjG2UcG4Lehhj4m3w3BbaM1/Y4WBCPWamS5d+6ZlHveR22Klk50zxcS
         9+K3yze1rm4Nk9/eAQ65MJaRP7i21Szd89R3bx9w/2d9qbu+1rncnYSlV+ET69dVBcCS
         tDRaa0fYD76+XDtusbMepi42XR2QU8i5ydYHkqzBQacptIj9jIOcyJbHHZ/fDPQZ2U64
         aaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MW/RUvnmQuaynAgrPchgXaGJmLy9K9MyZdsdP/atZxQ=;
        b=QYVYRSkwl+XQvAK9AZjaoCmYH2j4pRhu0TVB5SBwLnhDgIlOoYHj4SR8r29q85XLxk
         +nkoLKRhaRC259hmM5Kxx10sPsprXvyHHRJAzkK0+c75NtMssIH85yUVgV+F04rBJlI+
         EtpVZ3HjdvoAayNb7BRt0D7TO3lgSNjwJvAcrD2zB8Th3uqrz9qqcBo445UwLsCJQp9e
         mYnIwM/yiywo9Hjyze1ptbm6myxH7GQapr6X4j5NKrw6nYdgJrRiAjGZxYkEFdPhxdVW
         pA+8qlSjcTDiqA3gxlmU1iqXn5Zm97vP4m/s6gz1aRIdKiKtG93rAW5+lcKTiiBd+u64
         FR6w==
X-Gm-Message-State: ANhLgQ0JQkjYZYcx74RVUUUuCPF/6kZZYjWS+8MEGG40gOu4Buje+07k
        tFuPB32goO7r3H44nmblMyg=
X-Google-Smtp-Source: ADFU+vvFwk9gIaYwzFtN+osinFKTYw7KGYLSDcNh/AYWbMCZViWyLramfoAPmOtxgl1fyoVsw37kdA==
X-Received: by 2002:a62:2a8c:: with SMTP id q134mr18037787pfq.35.1585649123998;
        Tue, 31 Mar 2020 03:05:23 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y207sm12354592pfb.189.2020.03.31.03.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 03:05:22 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, peterz@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 0/2] psi: enhance psi with the help of ebpf
Date:   Tue, 31 Mar 2020 06:04:35 -0400
Message-Id: <1585649077-10896-1-git-send-email-laoar.shao@gmail.com>
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
        MEMSTALL_WORKINGSET_THRASH
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

To summarize, with the pressure data in /proc/pressure/memroy we know that
the system is under memory pressure, and then with the newly added tracing
facility in this patchset we can get the reason of this memory pressure,
and then thinks about how to make the change.
The workflow can be illustrated as bellow.

		   REASON	  ACTION
		 | compcation	| improve compcation	|
		 | vmscan	| improve vmscan	|
Memory pressure -| workingset	| improve workingset	|
		 | etc		| ...			|

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
2.18.2

