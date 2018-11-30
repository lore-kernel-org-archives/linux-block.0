Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853DAC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457512145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Axmnp3WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457512145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLAEGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33756 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeLAEGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:47 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so2414554itk.0
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+QzwLfxdGWYLKlpdVqFe/aUiqWqSqwnGSQDDiURGMx8=;
        b=Axmnp3WFN0shdEXogWZ8+F/LMTb2U3gpnzFS/ec2+Hw564TiFEq6plnLjvILhW1YFT
         NISGu7PVKHCiRF+Uwe/RIYQsthofaYgjqvZcvToWGNLp8HAb2Rn3jliczD+sO1d5L9y+
         p28aJNPAmQ4IZdC3wSqKUqTm1hDdqvCZUJHRIeX5Lh4J8XEP6IHdfnh9tgCttpFxlOsh
         5jv+BR/aADMv20hqfXGqRLqvhczUilS3uvzrYPnTpvw8w69t23/cP8GZ5QxbVGdUt+Pg
         5N2zYc2vnnA4f4piRTJYrKr9vFRYs+KsD6Qs6yAnV0tb0MqJamEOnsAiR8lJT4WreQsK
         nIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+QzwLfxdGWYLKlpdVqFe/aUiqWqSqwnGSQDDiURGMx8=;
        b=hH3Cpndnn432iW3efGbLxtNRmT0pgS7hQFRDwbO44EKlRqIxnAtacTikmMoPsS/9zB
         TA4yPLFMrD1u5CuatyGdzLD8I8qwkYWcqRgTwrFbrrffnz8QY7m/KaMCi8AbjmfZXt0p
         V3RTXC6Rvgmbn0ZgH1nXoSsGaosccFNwTQkx2qtLchxDGtUM6BGmd+i/dtf+E2V40WsF
         +uJ41Jn09uBXU/dIvd9J8Ike1a9lLdSrLKXLSLSCk/x4iAEtJW0NutJGgP5/8Q93YOG1
         raCjQA6PvgDhidZRlgI/WiAeBJI025h8bh01KqGpxUn9BikfkTeymFDD6Ie+oBYOE12/
         7YGg==
X-Gm-Message-State: AA+aEWbCUo6PvxVWJhmFMZYmJfnghDF4ljvUNRmIG7OIiFTPIXnSI+2l
        YSzhuCRTVpnhEDfKuoQ3EyHPVc6Wogs=
X-Google-Smtp-Source: AFSGD/WNpjDZNRp6tEbWrNqPVIuA86diyyZti2DRj1Zau7HHvaV/wKQb2kUSjAyTpDSZ5bWCmtyIYA==
X-Received: by 2002:a24:7b90:: with SMTP id q138mr5617541itc.37.1543597010414;
        Fri, 30 Nov 2018 08:56:50 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:56:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de
Subject: [PATCHSET v4] Support for polled aio
Date:   Fri, 30 Nov 2018 09:56:19 -0700
Message-Id: <20181130165646.27341-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the grand introduction to this feature, see my original posting
here:

https://lore.kernel.org/linux-block/20181117235317.7366-1-axboe@kernel.dk/

and refer to the previous postings of this patchset for whatever
features were added there.

Outside of "just" supporting polled IO, it also adds support for user
mapped IOCBs, so we don't have to copy those for every IO. A new
addition in this version is support for pre-mapped buffers as well.
If an application uses fixed IO buffers, it can set IOCTX_FLAG_FIXEDBUFS
along with IOCTX_FLAG_USERIOCB. The iocbs that are mapped in should have
the maximum length already set, and the buffer field pointing to the
right location. That eliminates the need to do get_user_pages() for
every IO.

Everything is solid for me in all the testing I have done, no problems
observed, crashes, corruptions, etc.

For the testing below, 'Mainline' refers to current -git from Linus,
'aio-poll' is the aio-poll branch but with none of the new features
enabled, and finally 'aio-poll-all' is the aio-poll branch with
useriocbs turned on, polling turned on, and user mapped buffers
turned on. In other words, mainline and aio-poll are running the
exact same workload, and aio-poll-all is running that workload,
but with the new features turned on.

All testing done with fio. Latencies quoted are 50th percentile.

All testing is done with a single thread, using a maximum of one
core in the system. Testing is run on two devices - one that supports
high peak IOPS, and one that is low latency.


Peak IOPS testing on an NVMe device that supports high IOPS:

Depth      Mainline           aio-poll        aio-poll-all
============================================================
1            77K                80K              132K
2           145K               163K              262K
4           287K               342K              514K
8           560K               582K              824K
16          616K               727K             1013K
32          636K               773K             1155K
64          635K               776K             1230K


Low latency testing on low latency device:

Depth      Mainline	      aio-poll        aio-poll-all
============================================================
1        84K / 8.5 usec    87K / 8.3 usec    168K / 5.0 usec
2       201K / 7.4 usec   208K / 7.1 usec    330K / 5.0 usec
4       389K / 7.7 usec   398K / 7.2 usec    547K / 6.1 usec

It's worth nothing that the average IO submission time for
'aio-poll-all' is 660 nsec, with aio-poll 1.8 - 2.0 usec, and finally
mainline at 1.8 - 2.1 usec.

As before, patches are against my 'mq-perf' branch, and can also
be found in my aio-poll branch.

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    1 +
 block/bio.c                            |   36 +-
 fs/aio.c                               | 1055 +++++++++++++++++++++---
 fs/block_dev.c                         |   36 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |   10 +-
 fs/gfs2/file.c                         |    2 +
 fs/iomap.c                             |   56 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |    1 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    5 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    2 +
 include/linux/uio.h                    |    3 +
 include/uapi/asm-generic/unistd.h      |    4 +-
 include/uapi/linux/aio_abi.h           |    6 +
 kernel/sys_ni.c                        |    1 +
 lib/iov_iter.c                         |   35 +-
 21 files changed, 1109 insertions(+), 167 deletions(-)

-- 
Jens Axboe


