Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5C2CA9EBB
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 13:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA3520679
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RXgCwZZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbfJXNou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:44:50 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36538 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390244AbfJXNou (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 09:44:50 -0400
Received: by mail-il1-f194.google.com with SMTP id s75so12659744ilc.3
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4thFLoY47AqoSU+E+1CT8s+fpAtHxHCjhZ8YtHVbsFc=;
        b=RXgCwZZx2OQNlgOCzpzO7SabTIjg+rSddIgo1YsDAL/+EVMi7vK2CnqQN4VrCe/qZD
         KfeOHmMgKeEhR94t8wIJRF4pYQTsBXJevvnhtH2tJeGw8QV+PcVnUfnXTyUxFRTSVzjj
         UYowJf/3KHlOQTVlhZqZ3KR0k6VCuPzFKVigOuAEABBG4O+3pnnyKSo5/6CBwUlm11xx
         nXlwG4QLALz+tadwg8S59jGrTmSvxLo5/A4xmFWk22xMC1F9KD9o7gQkf9pTOGs8ZZeS
         0Ksj2l4L9AjwdtnYLmasx6plybvRsLa0G3ipMCr8sHmnIxrCQMbJU3vedOMLh3ea6QNi
         Db0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4thFLoY47AqoSU+E+1CT8s+fpAtHxHCjhZ8YtHVbsFc=;
        b=oAXaorHwZ8h0d/3yyDTYTpSeRncFJSIGyi/rP1GjbS3BuOCZk2FVJnqhXzFOIPgSfk
         /FRqiU8BLqHWKsJ+xvWo/OCYzAmWuy7q2zD8CdKg3hVV9+A8/CbG/n7e0FoCLCKl3MRn
         NFvXrdRsiowEwWSuWNf+OimuBJ7+NboLJdnnZSI0CRx/BL1zKA5LmzT5QNHRx5ytDJXa
         8LBjgFpsDAVq8oUiUm+TcmDcrVy+xlSphe0rzpcYO9U+OLsf5IaElJG4gapHfvl8DZ0S
         njcblU5gASBscb5uKeA2XuoKB1GtqwAoGD5x1Kmq5Nbcu7fPrMBMa3kYKi0AbPh0W9HQ
         3qFQ==
X-Gm-Message-State: APjAAAUCNEnyb/fom/ZoZL0MvI25c0JBsM/OL3yZ1Hscz1jpOWkP0aUl
        nXz/z9V50j7DEQsJaR3pALYdrLcdWAFmpg==
X-Google-Smtp-Source: APXvYqzvX4Sn7dNee1pcSHT0nl2WZqRfN+1bIhmKKosQgb8X/WX0HGKMPEph7ABXjmjItCwpZWv4tw==
X-Received: by 2002:a05:6e02:68f:: with SMTP id o15mr43988644ils.210.1571924688817;
        Thu, 24 Oct 2019 06:44:48 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d21sm6092243ilg.12.2019.10.24.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:44:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     tj@kernel.org, peterz@infradead.org, mingo@kernel.org
Subject: [PATCHSET] Replace io_uring workqueues with io-wq
Date:   Thu, 24 Oct 2019 07:44:37 -0600
Message-Id: <20191024134439.28498-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of the justification for this work is done in the commit messages
themselves, but the tldr is that there are various bits of functionality
that io_uring needs that workqueues don't (and can't) provide. Hence
this adds a small replacement thread pool implementation that caters to
the needs of io_uring, both current and future ones.

Hopefully the sched core changes are palatable. io-wq uses the same
sched in/out hooks as workqueue, and if the task isn't either a
workqueue or io-wq worker, there should be no extra overhead there.

Patches are on top of my for-5.5/io_uring branch, and can also be found
here:

http://git.kernel.dk/cgit/linux-block/log/?h=for-5.5/io_uring-wq

This passes io_uring IO testing and repeated runs of the liburing
regressions suite, and passes tests that would previously deadlock.

 fs/Kconfig            |   3 +
 fs/Makefile           |   1 +
 fs/io-wq.c            | 790 ++++++++++++++++++++++++++++++++++++++++++
 fs/io-wq.h            |  55 +++
 fs/io_uring.c         | 402 +++++----------------
 include/linux/sched.h |   1 +
 init/Kconfig          |   1 +
 kernel/sched/core.c   |  16 +-
 8 files changed, 948 insertions(+), 321 deletions(-)

-- 
Jens Axboe


