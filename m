Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F605C06510
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8C206E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 13:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBNYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:24:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfGBNXw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 09:23:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 87E0E767180E0E09C15A;
        Tue,  2 Jul 2019 21:23:49 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 21:23:41 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-raid@vger.kernel.org>, <songliubraving@fb.com>
CC:     <neilb@suse.com>, <linux-block@vger.kernel.org>,
        <snitzer@redhat.com>, <agk@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>
Subject: [RFC PATCH 0/3] md: export internal stats through debugfs
Date:   Tue, 2 Jul 2019 21:29:15 +0800
Message-ID: <20190702132918.114818-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

There are so many io counters, stats and flags in md, so I think
export these info to userspace will be helpful for online-debugging,
especially when the vmlinux file and the crash utility are not
available. And these info can also be utilized during code
understanding.

MD has already exported some stats through sysfs files under
/sys/block/mdX/md, but using sysfs file to export more internal
stats are not a good choice, because we need to create a single
sysfs file for each internal stat according to the use convention
of sysfs and there are too many internal stats. Further, the
newly-created sysfs files would become APIs for userspace tools,
but that is not we wanted, because these files are related with
internal stats and internal stats may change from time to time.

And I think debugfs is a better choice. Because we can show multiple
related stats in a debugfs file, and the debugfs file will never be
used as an userspace API.

Two debugfs files are created to expose these internal stats:
* iostat: io counters and io related stats (e.g., mddev->active_io,
	r1conf->nr_pending, or r1confi->retry_list)
* stat: normal stats/flags (e.g., mddev->recovery, conf->array_frozen)

Because internal stats are spreaded all over md-core and md-personality,
so both md-core and md-personality will create these two debugfs files
under different debugfs directory.

Patch 1 factors out the debugfs files creation routine for md-core and
md-personality, patch 2 creates two debugfs files: iostat & stat under
/sys/kernel/debug/block/mdX for md-core, and patch 3 creates two debugfs
files: iostat & stat under /sys/kernel/debug/block/mdX/raid1 for md-raid1.

The following lines show the hierarchy and the content of these debugfs
files for a RAID1 device:

$ pwd
/sys/kernel/debug/block/md0
$ tree
.
├── iostat
├── raid1
│   ├── iostat
│   └── stat
└── stat

$ cat iostat
active_io 0
sb_wait 0 pending_writes 0
recovery_active 0
bitmap pending_writes 0

$ cat stat
flags 0x20
sb_flags 0x0
recovery 0x0

$ cat raid1/iostat
retry_list active 0
bio_end_io_list active 0
pending_bio_list active 0 cnt 0
sync_pending 0
nr_pending 0
nr_waiting 0
nr_queued 0
barrier 0

$ cat raid1/stat
array_frozen 0

I'm not sure whether the division of internal stats is appropriate and
whether the internal stats in debugfs files are sufficient, so questions
and comments are weclome.

Regards,
Tao

Hou Tao (3):
  md-debugfs: add md_debugfs_create_files()
  md: export inflight io counters and internal stats in debugfs
  raid1: export inflight io counters and internal stats in debugfs

 drivers/md/Makefile     |  2 +-
 drivers/md/md-debugfs.c | 35 ++++++++++++++++++
 drivers/md/md-debugfs.h | 16 +++++++++
 drivers/md/md.c         | 65 ++++++++++++++++++++++++++++++++++
 drivers/md/md.h         |  1 +
 drivers/md/raid1.c      | 78 +++++++++++++++++++++++++++++++++++++++++
 drivers/md/raid1.h      |  1 +
 7 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/md-debugfs.c
 create mode 100644 drivers/md/md-debugfs.h

-- 
2.22.0

