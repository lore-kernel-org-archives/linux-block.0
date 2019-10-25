Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8EBCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA43121E6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gby6FiPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405900AbfJYRW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:22:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46397 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389658AbfJYRW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 13:22:57 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so3234595ioo.13
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3NHvYpt1INk5uRqeGGp/iLhJLHtoVyRZVmvzj7YtHfc=;
        b=Gby6FiPbcP7GP/xAhx69XB+ert7dLv0ZsOGEDJb+0Kl7IeLceOzjPc/hxdVEgbJ5y5
         Y7gbV6i0WaKavPjH9QfdqI8aU+v8rC2pvDiMrTdN6izCvAqIdUENXVihS5ebIaTXC7fw
         Xvr9hXEqkQcqIjX583XD14sxT5HcsFjK2myEt5tpWkOwAxncHDCBXjgnne4YIHksYPNr
         NSP5nNx2HBxKssMnGCPPEu55KgwfI1Obpa8bvwPCZU4rWMvBrO7241oYJjbB4gyBmDPc
         kuVLPKiSlScB8W1qzvkWO+SA56mCseGNW4a3kgWxoE8zNrldYLY1nAPgVpoOwN/4Y3pW
         lm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3NHvYpt1INk5uRqeGGp/iLhJLHtoVyRZVmvzj7YtHfc=;
        b=rO3VlTIpzKuQXnpJQhn+vQ5W/DFuBDhRhm23WMMhHBlI9K2zWL0fquP4Q3zsoau9AJ
         oHo2CkyYXWF28nfELQv9b7oRNomOEWhIjiDb3t3B+AhFFQSFq3DmwlIQLkxwRcBNRzd7
         2oFeKQOTXWS8KB+DU0njRQzpy9U6+J/vNJyqYLKcAG4HWNiVMyw7Eew8wecNn705zCve
         Iq1mZuBjq76cueniToT4euULBZU6BHSIr7V0/1Mvws1lWWVm54LOpg2ug7gps5nSuavp
         zShYus5qM8DHskYm0mxEqwRtXBAL0cs0zfzoNLjm71OtKSXVjDrV1f/XD1kVdhhAyavM
         m5Hw==
X-Gm-Message-State: APjAAAWmIDQbZq+4v1HO3HWiykvFiHCUmz2i2LVtWUEVuPWMvg6SFxRf
        KAOppGBR1tDzPwUfIK69ZD0EHdG2xtkpQA==
X-Google-Smtp-Source: APXvYqzsbSstiYzysC190LTxbGQ9wo/GD1jJzltILb2Hopejv43RWUGno2j9vsp7y//a8GgfpT9o0A==
X-Received: by 2002:a02:c49a:: with SMTP id t26mr3444311jam.94.1572024174555;
        Fri, 25 Oct 2019 10:22:54 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm324082iok.87.2019.10.25.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:22:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org
Subject: [PATCHSET v2 0/2] Replace io_uring workqueues with io-wq
Date:   Fri, 25 Oct 2019 11:22:49 -0600
Message-Id: <20191025172251.12830-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hopefully the sched core changes are palatable. io-wq uses the same
sched in/out hooks as workqueue, and if the task isn't either a
workqueue or io-wq worker, there should be no extra overhead there.

Patches are on top of my for-5.5/io_uring branch, and can also be found
here:

http://git.kernel.dk/cgit/linux-block/log/?h=for-5.5/io_uring-wq

This passes io_uring IO testing and repeated runs of the liburing
regressions suite, and passes tests that would previously deadlock.

Also see LWN article here:

https://lwn.net/Articles/803070/

Changes since v1:

- Fix dependent work hash
- Turn wqe->state into wqe->flags
- Fix issue with unusing mm/files if worker got busy at exit timo
- Fix issue with hashed work bit mangling (Colin)
- Fix issue with dependent work
- Rebase

 fs/Kconfig                      |   3 +
 fs/Makefile                     |   1 +
 fs/io-wq.c                      | 805 ++++++++++++++++++++++++++++++++
 fs/io-wq.h                      |  55 +++
 fs/io_uring.c                   | 414 ++++------------
 include/linux/sched.h           |   1 +
 include/trace/events/io_uring.h |  12 +-
 init/Kconfig                    |   1 +
 kernel/sched/core.c             |  16 +-
 9 files changed, 981 insertions(+), 327 deletions(-)

-- 
Jens Axboe


