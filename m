Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A745C43215
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737512073A
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y73XatIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKOTkv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:40:51 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34280 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfKOTku (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 14:40:50 -0500
Received: by mail-io1-f67.google.com with SMTP id q83so11730152iod.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 11:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KWd4WvqIdKsuAtcf7EW7UDGGZSRzre1Mwnulmg9/DNk=;
        b=Y73XatIwQh/W/d2aW41Dg2huXRboeVadqyLAEwKcuwVeU9Rx0S7qngTxBPH0XXis03
         Vm9eHtTJopw/XjxKEsTIC8tYdBDVhhEb7y5Eg+hUi4BjqrPzRbjUUODvmD1RzWN0T2IB
         ZI7yv7g/zYIfpdMKTPlux19I0EVlbMt6N3tY9DIuUulhBXrLyTSScxhCdzZ+u6Z2roHq
         Mg82Jfq/mT55plYz/ZUy9rnaIo+07GCC7kCqTpWceTrdJlObWms0AX9zlgtJsXZFVwil
         leU/F2I7Onxv1Jm+cpKeoDtOwY7ntuLLOs1I7hF56GtaCu+NK1sIolvG2KnpAFkBUOWe
         aKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KWd4WvqIdKsuAtcf7EW7UDGGZSRzre1Mwnulmg9/DNk=;
        b=F8kR07Wz7ok/JEWV1HF74zGqVaPv22NEeOE+648XwJgpjus+iKPcdzOXh8z3q7Lsu9
         otk0dgl66J3GCAG0WWAG59fU2f6KqbvMKe1XCoy7GBjWBPNqYGdx8cDV8djExBjz1nJN
         wdp68D1n8QsdWdZF2UQQkkKx8lcsCWjRv3dovvcq3ThvfOZ6MuO8DH2rNRhMucBt2X4H
         qa/Oty7YSBxDDR8TAymPAsKXqc3HrT+gwsRoP39UMoKS0iJ1/xFcK2NoY4b9bV9Wr05b
         BOKo+NNc722xGmMkX8aDAA+0QdGCh2yZot0C/gbsWxerpcRP321m5R5em1K0EizEu8Nt
         +90A==
X-Gm-Message-State: APjAAAUXrS+k4IiNCc0C0gd5+jS6aZiZBkwebXJJxJYXvgqCyWS7IcF0
        2FPOBMFAiXVvrsGPUACgRJPz9w==
X-Google-Smtp-Source: APXvYqzx18IX/DyVN6h9/vjvNNa+JaKbDk2F/5LOqHLAdObhk5QnTiJpy0GW6JVUTWLnuPNQ8O/uIQ==
X-Received: by 2002:a05:6638:a27:: with SMTP id 7mr2168776jao.114.1573846849366;
        Fri, 15 Nov 2019 11:40:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k199sm1827239ilk.20.2019.11.15.11.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 11:40:48 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Fixes for 5.4-rc8/final
Message-ID: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
Date:   Fri, 15 Nov 2019 12:40:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

We have a few fixes that should make it into this release. This pull
request contains:

- io_uring:
	- The timeout command assumes sequence == 0 means that we want
	  one completion, but this kind of overloading is unfortunate as
	  it prevents users from doing a pure time based wait. Since
	  this operation was introduced in this cycle, let's correct it
	  now, while we can. (me)
	- One-liner to fix an issue with dependent links and fixed
	  buffer reads. The actual IO completed fine, but the link got
	  severed since we stored the wrong expected value. (me)
	- Add TIMEOUT to list of opcodes that don't need a file. (Pavel)

- rsxx missing workqueue destry calls. Old bug. (Chuhong)

- Fix blk-iocost active list check (Jiufei)

- Fix impossible-to-hit overflow merge condition, that still hit some
  folks very rarely (Junichi)

- Fix bfq hang issue from 5.3. This didn't get marked for stable, but
  will go into stable post this merge (Paolo)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20191115


----------------------------------------------------------------
Chuhong Yuan (1):
      rsxx: add missed destroy_workqueue calls in remove

Jens Axboe (2):
      io_uring: make timeout sequence == 0 mean no sequence
      io_uring: ensure registered buffer import returns the IO length

Jiufei Xue (1):
      iocost: check active_list of all the ancestors in iocg_activate()

Junichi Nomura (1):
      block: check bi_size overflow before merge

Paolo Valente (1):
      block, bfq: deschedule empty bfq_queues not referred by any process

Pavel Begunkov (1):
      io_uring: Fix getting file for timeout

 block/bfq-iosched.c       | 32 ++++++++++++++++++++++++++------
 block/bio.c               |  2 +-
 block/blk-iocost.c        |  8 ++++++--
 drivers/block/rsxx/core.c |  2 ++
 fs/io_uring.c             | 32 ++++++++++++++++++++++++--------
 5 files changed, 59 insertions(+), 17 deletions(-)

-- 
Jens Axboe

