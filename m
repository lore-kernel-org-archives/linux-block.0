Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D0C41536
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4AE206BA
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vi8ngA8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4AE206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeKUDuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50182 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbeKUDuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:11 -0500
Received: by mail-it1-f193.google.com with SMTP id a185so4520403itc.0
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=HrxKn8j47LhUDcHGm2Fyp15jthnSOTT1yZ4dDDUy63g=;
        b=vi8ngA8sgk4LjX9LPYuoTvV1rZr0HXgC782bnr1/5BOfDHDkVG5YDOSv3iUwBebhnU
         3tkfLrhRa0sY++dlogF7lpWfKG1x3kT+v34YS0d3xqfrT8L9tmiBeRLhDWMG6lq4YVO3
         mdj3cG9eNMD6BTmSRTa0G2eP2/XGjxCeiKpycsm0VTnYoqXMxqLmDEj2tFwfRCgbHCNi
         7T97GO6joBPWcnI7UiouJ/9KDhjiGGdZ4gxDX+sPgzSiEwYe/UMzWHfvltJUN3V5PorG
         zgfpBbfB5ZZekJlkD/bXY7xVX6urWjQxzMwKoAd07BdPemzFdYeIwARdN5GUcNUR55c7
         mIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=HrxKn8j47LhUDcHGm2Fyp15jthnSOTT1yZ4dDDUy63g=;
        b=IH+r9+iov4M0ZJfoEpYMzdxr/kONaBwi76V4lN9ObZnZ73j/IrBHlcrnXRBRQ/dq4G
         efp52Q0ERPlQbbgcYIyy3KdgiPBNuy0x3RYiFAxELpJg3oiuSehBc7Rv3LQTwKaeoLr4
         g8qxZTrOF6FgxmWaSowcN4ac2QZUalcvJ+rVvT3VaZgdept0qcczxMRSF2JaksDuczaT
         M4OcLJsvbK23DTF4wij2itRj8iiPV7spv6MJvXOgB/11zLtFNFwuf06a/BE5BwZjTjqA
         k9ZJ13YorZGvSp1WR45++ftr8X70KRPwR/3pGYeh+2UuAg08w86mPKk/vUrFGS7SRgg7
         sF7Q==
X-Gm-Message-State: AA+aEWakRm1zgiSxy8wVZhoca7Ad8FmeD3zZYX2QrL6xs15GSEAdu6X3
        kBN8H0L7pmFN5R4fcD2t4kj684ODjAg=
X-Google-Smtp-Source: AJdET5eZHqOG692C4b3Y9wojsczFwj/ojMwp8FxPDtTGHlnnFkKe1hH4Y5NF/JF0uLZy4h33uCBLZQ==
X-Received: by 2002:a02:9804:: with SMTP id t4mr2427717jaj.68.1542734396886;
        Tue, 20 Nov 2018 09:19:56 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:19:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHSET v2] Support for polled aio
Date:   Tue, 20 Nov 2018 10:19:45 -0700
Message-Id: <20181120171953.1258-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the grand introduction to this feature, see my original posting
here:

https://lore.kernel.org/linux-block/20181117235317.7366-1-axboe@kernel.dk/

Since last time, a number of significant changes has been made:

- Addition of the io_setup2() system call. I didn't like tracking the
  fact that an io_context was polled or not internally, I think it's
  much better to make this explicit. The system call is like io_setup(),
  except we pass in a flags argument. In the flags, the application can
  set IOCTX_FLAG_IOPOLL to ask for this context to be polled. The syscall
  is only wired up for x86-64 for now.

- Addition of fops->iopoll() to properly handle polling on files.

- Various optimizations to how we track and handle poll requests
  internally.

- Split some patches into prep patches, to reduce the size of the
  final poll support patch.

- Various cleanups, tweaks, improvements.

In terms of efficiency, I've got one device that maxes out at 845K
4k IOPS, and the polled IO can reach this with just a single thread/core.
For comparison, non-polled on the same device reaches 600K IOPS. On
a slightly faster device, I can reach 910K IOPS on a single thread. All
of this is on a 2.2GHz server box, faster clock rate will go faster.

In terms of how to use polling, I'd advise you to check out the basic
changes made to fio to support it. It's simple:

1) Ensure that you call io_setup2() with IOCTX_FLAG_IOPOLL, instead
   of io_queue_init() or io_setup().
2) Set iocb->u.c.flags to IOCB_FLAG_HIPRI.

That's it, everything else works like before.

Patches are against my mq-perf branch, and can also be found in my
aio poll branch.

 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/aio.c                               | 469 +++++++++++++++++++++----
 fs/block_dev.c                         |  25 +-
 fs/iomap.c                             |  50 ++-
 fs/xfs/xfs_file.c                      |   1 +
 include/linux/fs.h                     |   1 +
 include/linux/iomap.h                  |   1 +
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/aio_abi.h           |   4 +
 kernel/sys_ni.c                        |   1 +
 11 files changed, 461 insertions(+), 98 deletions(-)

-- 
Jens Axboe


