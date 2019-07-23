Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0984C7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902102238B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJGfbmAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGWCNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:13:53 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:35895 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfGWCNw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 22:13:52 -0400
Received: by mail-pg1-f178.google.com with SMTP id l21so18572838pgm.3;
        Mon, 22 Jul 2019 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdLHQJMLyqqWCX9DLQ6yy/s/ODU3lHROOjsr5sCJ0ts=;
        b=jJGfbmAFXZmw0ezJd5U0BN2d8UKzSMK7myI0xI2zeN11biMlEGJrkK+6fzKVcAUF3c
         TDGn7kPrza+JNP3upm9TBmBpSwf+DQpsThubJcJ1NcyGE973x8Pi0Y0Sf2GBYVrPaZZ5
         9PKiWQyXMxw31qWdL7dxMt4eubwki+/iZ1D8dNmNtigTwwCKcBlno5Jj7fbHKgVvWqaq
         grUmgPagN50FnvWfBtAyV5FnbhNelxVD9cOBD9iVa0LgT3+9q+T6aguYujojdlLekT/R
         +UarpT3Q8fUwKCIrpIoRPR6curYiIftKeg1BxqmUTQJMPAo7Dl1/LoWNEDX56sL9CHae
         rAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdLHQJMLyqqWCX9DLQ6yy/s/ODU3lHROOjsr5sCJ0ts=;
        b=cjSJkWu7MUXFPGDapEddgJ+gdguixn1a/iy0dQhc70UOApdvdfJddSZGm+4TAWW2Yt
         i7mW2MiS1r7gyL61WupoXuEFjhgqfbPwaAjSnPWKggZ4flYzKBVcgOUO9OSWioYHAls9
         FtrbrFVOm8Zt3ih/9iuMC8AAb3hIM5Dfzxs1tUO0bBweQvxUdTvaHxG6V3cqTZQlPcKd
         8cszZ3iEW7zsYCTIdZQLWGLA1gOsoc/MTzSDp1T4CEE0xFhmNxwsCKmD82qNW2bZG/5B
         4lA5/AQMUeGMu2oAh7F/AiMaJE8usUxActH2hFzM6k+hbrl7q2GSu6+6mDoCjQTfuHhN
         klAg==
X-Gm-Message-State: APjAAAWzEh+kvO5aSfbz8c05e9hr4A2xS+GqC58jCjwFUJpJeLY3sj1D
        uv8IdhYhQwUGVYr1zjZMo72pJ/bnOuc=
X-Google-Smtp-Source: APXvYqwQ1L7RD1UFkuZ7MOfLYDur/m51pRWLot2vgNGvEB3bll+lYlroWSrMJ5eJu9EYhdMa820W0Q==
X-Received: by 2002:a17:90a:9b8a:: with SMTP id g10mr78065617pjp.66.1563848031624;
        Mon, 22 Jul 2019 19:13:51 -0700 (PDT)
Received: from continental.prv.suse.net ([191.248.110.143])
        by smtp.gmail.com with ESMTPSA id v126sm7999257pgb.23.2019.07.22.19.13.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 19:13:49 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hare@suse.com
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 0/2] Remove blk_mq_sched_started_request function
Date:   Mon, 22 Jul 2019 23:14:37 -0300
Message-Id: <20190723021439.8419-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While inspecting the queue_rq calling sites, I verified that
blk_mq_start_request calls blk_mq_sched_started_request, and this function
checks if the elevator of the current request implements the started_request,
but currently none of the available IO schedulers do.

So, let's remove blk_mq_sched_started_request along with started_request, which
is member of the elevator_mq_ops struct.

Marcos Paulo de Souza (2):
  block: blk-mq: Remove blk_mq_sched_started_request function
  include: elevator.h: Remove started_request from elevator_mq_ops

 block/blk-mq-sched.h     | 9 ---------
 block/blk-mq.c           | 2 --
 include/linux/elevator.h | 1 -
 3 files changed, 12 deletions(-)

-- 
2.22.0

