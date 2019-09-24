Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C9AC432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 10:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2158214D9
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 10:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JYHKJJcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389755AbfIXKuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:50:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37346 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfIXKug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 06:50:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so1111970pgg.4
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1DPVzhJT6eHGHNbVuo6y8DaQ9Qe+6LH9jlqk7w9CcP4=;
        b=JYHKJJcj4tQNY+wy9mNp8pNyupZrUbtMbrG2T1Svz9LJmnv48KGTVC2a9/ebsbTnK+
         U1maCwB3jSfUTE1q+PLYClSzuHBues+35H8GJu2XHV/30BryxzTFVsHNTnLxZyzXDWXV
         htWfuuhJo/m+z+EpccRyJHyInc5TEaWwUg013U1mHAMrwZ0w31JoQ2y4H4EyRWqAg1oo
         yjdQqBxbyIQoOeohvs7PMale5bPq7toFwaTu3Tw3Y6CN83tibl+nGEykiesFIxOdSK+g
         fg612zzQMlkNmAWWvaKXTpezDszE3WoxfSqwY8fkM/AsU6Du+CLSKQg+kx6sqBRPkfuW
         rbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1DPVzhJT6eHGHNbVuo6y8DaQ9Qe+6LH9jlqk7w9CcP4=;
        b=pihGxEnt7MMj2Lf4GWRm3ZwfijgjhTGxG3s2jENgS7LMh5bEaF3PFPKghTAVwqPDRQ
         prW/vkyOEypPFAY++7CcvGfijUQK3O1AikJw4izl8uC7+Po7rzKX4stwT3URKHfrjbtt
         tDQS20VIEtO25ernLk5ECa++FB3522RFSCgsAm5ASF8BjGRgwYpUfG8S+NebwQGhae0M
         8WcGWusmSrrqoRpkJUNiSpD9Djd8gJPpcehnNCfgS+2fawpcCv21VET5KR1eXcxSQ1oM
         verRtkUPN32v6lSKts4WokJxcRdrqjsTrYfd89WbEiB3IVk2ijim2IHzJilldtNV5zc3
         zsjQ==
X-Gm-Message-State: APjAAAWTX7nF+/3mpGvDgj6EnLCCGzo1SK0daAqoY9s9EibdR6BCSzjU
        uorSiWBBFHk6myOo+HbG8YGMc9gcGVWqDijz
X-Google-Smtp-Source: APXvYqzafENUo3jAqmzw/eAwLsG7f3VK/fYnSeJFDzmRXWGs5TOMgQoqYYwCcT7ctO/9+sSnmmZl7w==
X-Received: by 2002:a62:7c14:: with SMTP id x20mr2649521pfc.228.1569322234061;
        Tue, 24 Sep 2019 03:50:34 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:a9a6:f93b:f300:79e6? ([2600:380:8419:743e:a9a6:f93b:f300:79e6])
        by smtp.gmail.com with ESMTPSA id z22sm1759505pgf.10.2019.09.24.03.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:50:33 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring changes for 5.4-rc1
Message-ID: <264fe7b8-5f4a-6c1b-dbed-5b73e71ab442@kernel.dk>
Date:   Tue, 24 Sep 2019 12:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Also a collection of later fixes and additions, that weren't quite ready
for pushing out with the initial pull request. This pull request
contains:

- Fix potential use-after-free of shadow requests (Jackie)

- Fix potential OOM crash in request allocation (Jackie)

- kmalloc+memcpy -> kmemdup cleanup (Jackie)

- Fix poll crash regression (me)

- Fix SQ thread not being nice and giving up CPU for !PREEMPT (me)

- Add support for timeouts, making it easier to do epoll_wait()
  conversions, for instance (me)

- Ensure io_uring works without f_ops->read_iter() and
  f_ops->write_iter() (me)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.4/io_uring-2019-09-24


----------------------------------------------------------------
Jackie Liu (3):
      io_uring: use kmemdup instead of kmalloc and memcpy
      io_uring: fix use-after-free of shadow_req
      io_uring: fix potential crash issue due to io_get_req failure

Jens Axboe (4):
      io_uring: ensure poll commands clear ->sqe
      io_uring: use cond_resched() in sqthread
      io_uring: IORING_OP_TIMEOUT support
      io_uring: correctly handle non ->{read,write}_iter() file_operations

 fs/io_uring.c                 | 241 +++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/io_uring.h |   2 +
 2 files changed, 219 insertions(+), 24 deletions(-)

-- 
Jens Axboe

