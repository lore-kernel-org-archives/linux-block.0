Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEECC282DE
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 19:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189DD214AE
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 19:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hrwShM9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDGTht (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:37:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46751 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDGThs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 15:37:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so6016029pll.13
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2019 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=r7De3b2pf9llzaJ7F9JgTeS4probnUYB2Sn+GX9wAAo=;
        b=hrwShM9Qf2LO6mv3FnXFytMhBCsJAXQU1iH+BvOVh4D6ZWaOIqtDxspsxfmoNrExn0
         /H3ITRPxw1avwsOWVHFKYbesY1fexW8qA4Tt0kaWMed/zu0vh/f+kTm42AKPRbOvDFhb
         aZP2nsnEHw1TTQ+RHPExHRP4GZ34ny80k4GTv7THU+VjudXE6mTlpo72t8aJw8ibHcQ7
         mf7Eh4Ti1K7lGlIfKD/FZhBzwMSr3lWRNlbooeD3AlNeRXTqngCqudPuhSg17wsM71eA
         U5lkNlSjyiVXIJMYaIMEz2x2f/bv/xBEea+/o6mHccdWhAPWUhtnbp9kantsMQixIwpD
         okqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=r7De3b2pf9llzaJ7F9JgTeS4probnUYB2Sn+GX9wAAo=;
        b=cAYbmgDQpnNEXE5Y2fEBHrapTjv0tBjLJt5aggr1hNex7Op3t8uVpBiFofqfufKBB/
         aUQ7mPSLpyQKvwKmFDCqSzuSSpjRKCLmMlIcigMnf5nZ2vGuQyYK2FeU4hx3Fk0ujCiW
         IPimpayHIeWW0iGBr7IjOpvH5pCWObBWEr8MtQv3AgGC4Je0wTUE2kd6Lq1jsPsupSUl
         CqEd+L9bnrt7CDkEBQWWEOywcJeHArdnmwwPJj/IOzC2ty3pVDnOrsSMANvwsxysYZmS
         GrtLZ7+tt7h7fm5LNjuU8Shpoz88eiKjfNsGCsgbtDq4ta28NnHPTyPu8z9QkiJlHpvw
         IdgA==
X-Gm-Message-State: APjAAAWk3/mvPw4S/3jJS6YHfVLKATu3X+NhWDbdRzJyKRpOGxggPEGo
        Pz5x9cw1EvKXP9c41xJ8bq2J2KB4lPfS1g==
X-Google-Smtp-Source: APXvYqxpkGz7K9gD8CYhJNf0u9NeMFbYn83grE7vsrFM82psdtutekElE/H8N3BfHkpliwrRMCxjQA==
X-Received: by 2002:a17:902:3e3:: with SMTP id d90mr25963368pld.271.1554665867128;
        Sun, 07 Apr 2019 12:37:47 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k10sm14913328pgo.82.2019.04.07.12.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 12:37:45 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.1-rc4
Message-ID: <1804e67f-8ec6-1188-6522-467ac8e6be20@kernel.dk>
Date:   Sun, 7 Apr 2019 13:37:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A collection of fixes that should go into this round. This pull request
contains:

- Fixups for the pf/pcd queue handling (YueHaibing)

- Revert of the three direct issue changes as they have been proven to
  cause an issue with dm-mpath (Bart)

- Plug rq_count reset fix (Dongli)

- io_uring double free in fileset registration error handling (me)

- Make null_blk handle bad numa node passed in (John)

- BFQ ifdef fix (Konstantin)

- Flush queue leak fix (Shenghui)

- Plug trace fix (Yufen)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190407


----------------------------------------------------------------
Bart Van Assche (1):
      block: Revert v5.0 blk_mq_request_issue_directly() changes

Dongli Zhang (1):
      blk-mq: do not reset plug->rq_count before the list is sorted

Guenter Roeck (1):
      xsysace: Fix error handling in ace_setup

Jens Axboe (1):
      io_uring: fix double free in case of fileset regitration failure

John Pittman (1):
      null_blk: prevent crash from bad home_node value

Konstantin Khlebnikov (1):
      block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y

Shenghui Wang (1):
      block: use blk_free_flush_queue() to free hctx->fq in blk_mq_init_hctx

YueHaibing (2):
      paride/pf: Fix potential NULL pointer dereference
      paride/pcd: Fix potential NULL pointer dereference and mem leak

Yufen Yu (1):
      blk-mq: add trace block plug and unplug for multiple queues

 block/bfq-iosched.c           |   2 +-
 block/bfq-wf2q.c              |   2 +-
 block/blk-core.c              |   4 +-
 block/blk-mq-sched.c          |   8 ++-
 block/blk-mq.c                | 129 ++++++++++++++++++++++--------------------
 block/blk-mq.h                |   6 +-
 drivers/block/null_blk_main.c |   5 ++
 drivers/block/paride/pcd.c    |  14 ++++-
 drivers/block/paride/pf.c     |  12 +++-
 drivers/block/xsysace.c       |   2 +
 fs/io_uring.c                 |   1 +
 11 files changed, 110 insertions(+), 75 deletions(-)

-- 
Jens Axboe

