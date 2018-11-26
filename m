Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE7AC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0BE20659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="08Qwmupg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0BE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeK0Dk2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35253 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeK0Dk2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:28 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so3226570itp.0
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=IdIMzX7VGi53toZUArfDIiA8u5niykH3cJ0sxsqZ4Wg=;
        b=08QwmupgSz8M4bbH34SbuKGJ2G2ZSIimWyh1X/lnSUe3Mn/FGH4maOWENtVI0TVvrj
         0JPm99Bc9OqNoARnqSbD4FJ+7cwC6A4QaKP/cgCAEcEDe+M9fh7Gm20Q+Tz3OLOWmxa2
         7a8asEr963FT1bVIefTyMPC9RKDifHlxp4LHc0QQhOYGTkaPp3dR4SEzL7j2hj8NC9XO
         u8jaDrs34c5DO8K8TbpYF3aADwj9JztWlzJpJcf0J1qX4yx2f9y2dndPzvxr/xvDmgDm
         dPFesOeooTorISEr93Lzh1FB1O55DvL/mmyCWZsYqhWYNVslgZKDiD+ci5yqri2rNXMW
         bGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=IdIMzX7VGi53toZUArfDIiA8u5niykH3cJ0sxsqZ4Wg=;
        b=i+gb8y098JD6yUXiIMoZQ9s++jMyeTDLtMLY2SsU1DHvFL1ZlSAqLfD+PUpvgt00Cr
         EwuSomApfNAZg9RLOC2+JtEdl3AtCYYc6Ij+y+oGjTa338mBGbNmx3N7toVjUj2wWzR5
         b7GHm2RHu0o2NyxoZ8klEiwbi143M5PpB5rMqykjRReKtFlz8xHoYqtCF20SCO/CIRxM
         NBeB5guORyHyExhtVJ/5mhOjYYhvt7xqLhK2XZd7nSzTHMN45cp47S4igtdcVAtumlc0
         1Sbvty+bPK2lXkTA9xPkBBG1CbLKsAziKgY0sCKRyQBIqnHHm4zjlJr6wUHeMZBvb12f
         IZ9A==
X-Gm-Message-State: AGRZ1gIV55dPEQbTxsjpW4DlbJAIrgaePHKqwfz28TFePZlZbvxHMTdm
        oM8uZ0Z+Bx5PET5mDNLjMsm2Xv5ehkc=
X-Google-Smtp-Source: AJdET5f5BANt2bFbLp4fWAx20N2uVadfeU8ZGSa65awZXZpJ6o1a6O4fTFjUtVS2MPjSM/BvUg/Mcg==
X-Received: by 2002:a24:ed4f:: with SMTP id r76mr22598004ith.17.1543250748092;
        Mon, 26 Nov 2018 08:45:48 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:45:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHSET v3 0/18] Support for polled aio
Date:   Mon, 26 Nov 2018 09:45:24 -0700
Message-Id: <20181126164544.5699-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the grand introduction to this feature, see my original posting
here:

https://lore.kernel.org/linux-block/20181117235317.7366-1-axboe@kernel.dk/

The patchset continues to evolve, and has grown some optimizations that
benefit non-polled aio as well. One such example is the user mapped
iocbs, which avoid copying a full iocb for each IO. If you look at
memory performance, we copy 72b for each IO at submission time (8 byte
pointer, 64 byte iocb), then copy back 16 bytes at completion for the
io_event. That's 88 bytes of memory copies, for something that's
potentially a 512b IO.

In terms of observed performance, I've been able to do 1070K 4k IOPS
with this on a single device, using a single thread for both IO
submissions and completions. For actual real life use cases, on a
flash storage box permance is up 25% in terms of IOPS/throughput.

As before, patches are on top of my mq-perf branch

Changes since v2:

- Fix an off-by-one causing QD=1 aio polls to sometimes stall.
- Add fget_many/fput_many optimization.
- Ensure that io_cancel() is never called on a polled iocb.
- Add support for user mapped iocbs.
- IOCTX_FLAG_IOPOLL is now (1 << 1), since it was reordered after
  the user iocb support.
- Kill full aio_kiocb zero on alloc.
- Move fops->iopoll() storage back to the iocb (->ki_cookie). The usage
  in the dio private storage was inherently racy, making the store of
  the submission cookie open to use-after-free.
- Fix narrow use-before-submit race in fops->iopoll() access.
- Batch move submitted iocbs to poll_submitted list.
- Pass back EAGAIN at submission time, don't punt to getevents() time.
- Split some patches up.
- Address review concerns.
- Various little fixes and optimizations.


 Documentation/filesystems/vfs.txt      |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/aio.c                               | 841 +++++++++++++++++++++----
 fs/block_dev.c                         |  20 +-
 fs/file.c                              |  15 +-
 fs/file_table.c                        |  10 +-
 fs/gfs2/file.c                         |   2 +
 fs/iomap.c                             |  51 +-
 fs/xfs/xfs_file.c                      |   1 +
 include/linux/file.h                   |   2 +
 include/linux/fs.h                     |   5 +-
 include/linux/iomap.h                  |   1 +
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/aio_abi.h           |   5 +
 kernel/sys_ni.c                        |   1 +
 16 files changed, 819 insertions(+), 145 deletions(-)

-- 
Jens Axboe


