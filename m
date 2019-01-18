Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B378C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01EF2087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 10:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FktayEwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfARKbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:31:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33949 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfARKbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 05:31:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so14474892wrw.1;
        Fri, 18 Jan 2019 02:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DG6bk1ejVh8rxbtQA/jlQO7ic8ssgX5N3kx62jr5skA=;
        b=FktayEwlolfuR8urYX2+zd96A4rZG4Xk3Kq6P8EQ+r7A6kUQKipD/GNTK6QUGai9Vz
         4WJ2wCTF/PnrPUEoVg8dPqihrxX2iqKxowv6My5G7AiV0GVPAjDOitj1LKaV6uzE0jld
         O+j/cwrmmfzXlyQINSFotgNUX/aMRdIBjYNcbX3fhi8XbqNFjAUsFzLpDJ0ELFL2ysWQ
         u7/tCE//kFxCdtOAL/CnhePTdXtEvpeVDE4l8kquh5OsA8QoCrcbOPoz7RDjLA3akHT7
         QISJZt6GtUQza+GZOdkEe2r23LqQidFoBZfHFSiBJtkdc4pL27+Gmt7V4OUdG1kFOXf8
         3XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DG6bk1ejVh8rxbtQA/jlQO7ic8ssgX5N3kx62jr5skA=;
        b=lBi1oUKUFLbC4uHEJZ7QvOSjcrrzIZyWQPjjoqFVg3APqNKnx7voCVuClQs/ZHAR2O
         Ufx6WNrFb5gEj85nE6o1Wwk6jF37rC10ZGCP1hUPjY7f+x+HICXWuSoF8/kRly50/6sA
         Ov7jkCBKqBZeKllY2pAoNQVcoY58ssPLnFVleW2CL83n98KMTFoBSoqtv7fppgXMkgKs
         6KF2dufjA7e1nCnoA7sDKwErhOjRFtjVspwb0Re+YJevYkBk9nNBs4iHugewblZzn5Dj
         CBO9xLB3U1ElIdLjU1zuh+s37JKS7ecpTJTWHVy27Xww/uJYpF7Oqd2304mP5i9k1SUB
         c9tA==
X-Gm-Message-State: AJcUukfMRpJqzt0OgnMJLLWTytSNnXAJWIsQ92S361Y3bKqZytIXEPCo
        /vd5HijwNWpjk+Pkpt/FSg==
X-Google-Smtp-Source: ALg8bN4kmPfQ1YD7LKC7QAf4jnXdvBqN8xleSfsv59k7rA6FXtjTCB9cHfbxBVjjZNwVYjX6M0MRBQ==
X-Received: by 2002:adf:c846:: with SMTP id e6mr15221224wrh.243.1547807500291;
        Fri, 18 Jan 2019 02:31:40 -0800 (PST)
Received: from xps-13.homenet.telecomitalia.it (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id g9sm39949652wmg.44.2019.01.18.02.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:31:39 -0800 (PST)
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] cgroup: fsio throttle controller
Date:   Fri, 18 Jan 2019 11:31:24 +0100
Message-Id: <20190118103127.325-1-righi.andrea@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a redesign of my old cgroup-io-throttle controller:
https://lwn.net/Articles/330531/

I'm resuming this old patch to point out a problem that I think is still
not solved completely.

= Problem =

The io.max controller works really well at limiting synchronous I/O
(READs), but a lot of I/O requests are initiated outside the context of
the process that is ultimately responsible for its creation (e.g.,
WRITEs).

Throttling at the block layer in some cases is too late and we may end
up slowing down processes that are not responsible for the I/O that
is being processed at that level.

= Proposed solution =

The main idea of this controller is to split I/O measurement and I/O
throttling: I/O is measured at the block layer for READS, at page cache
(dirty pages) for WRITEs, and processes are limited while they're
generating I/O at the VFS level, based on the measured I/O.

= Example =

Here's a trivial example: create 2 cgroups, set an io.max limit of
10MB/s, run a write-intensive workload on both and after a while, from a
root cgroup, run "sync".

 # cat /proc/self/cgroup
 0::/cg1
 # fio --rw=write --bs=1M --size=32M --numjobs=16 --name=seeker --time_based --runtime=30

 # cat /proc/self/cgroup
 0::/cg2
 # fio --rw=write --bs=1M --size=32M --numjobs=16 --name=seeker --time_based --runtime=30

 - io.max controller:

 # echo "259:0 rbps=10485760 wbps=10485760" > /sys/fs/cgroup/unified/cg1/io.max
 # echo "259:0 rbps=10485760 wbps=10485760" > /sys/fs/cgroup/unified/cg2/io.max

 # cat /proc/self/cgroup
 0::/
 # time sync

 real	0m51,241s
 user	0m0,000s
 sys	0m0,113s

Ideally "sync" should complete almost immediately, because the root
cgroup is unlimited and it's not doing any I/O at all, but instead it's
blocked for more than 50 sec with io.max, because the writeback is
throttled to satisfy the io.max limits.

- fsio controller:

 # echo "259:0 10 10" > /sys/fs/cgroup/unified/cg1/fsio.max_mbs
 # echo "259:0 10 10" > /sys/fs/cgroup/unified/cg2/fsio.max_mbs

 [you can find details about the syntax in the documentation patch]

 # cat /proc/self/cgroup
 0::/
 # time sync

 real	0m0,146s
 user	0m0,003s
 sys	0m0,001s

= Questions =

Q: Do we need another controller?
A: Probably no, I think it would be better to integrate this policy (or
   something similar) in the current blkio controller, this is just to
   highlight the problem and get some ideas on how to address it.

Q: What about proportional limits / latency?
A: It should be trivial to add latency-based limits if we integrate this in the
   current I/O controller. About proportional limits (weights), they're
   strictly related to I/O scheduling and since this controller doesn't touch
   I/O dispatching policies it's not trivial to implement proportional limits
   (bandwidth limiting is definitely more straightforward).

Q: Applying delays at the VFS layer doesn't prevent I/O spikes during
   writeback, right?
A: Correct, the tradeoff here is to tolerate I/O bursts during writeback to
   avoid priority inversion problems in the system.

Andrea Righi (3):
  fsio-throttle: documentation
  fsio-throttle: controller infrastructure
  fsio-throttle: instrumentation

 Documentation/cgroup-v1/fsio-throttle.txt | 142 +++++++++
 block/blk-core.c                          |  10 +
 include/linux/cgroup_subsys.h             |   4 +
 include/linux/fsio-throttle.h             |  43 +++
 include/linux/writeback.h                 |   7 +-
 init/Kconfig                              |  11 +
 kernel/cgroup/Makefile                    |   1 +
 kernel/cgroup/fsio-throttle.c             | 501 ++++++++++++++++++++++++++++++
 mm/filemap.c                              |  20 +-
 mm/page-writeback.c                       |  14 +-
 10 files changed, 749 insertions(+), 4 deletions(-)

