Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1721DC74A54
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 15:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19FF20644
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="inrUlWJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfGKPTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:19:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38502 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfGKPTb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 11:19:31 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so13364698ioa.5
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=agDk4Z2vrUSdhA9OxNpWjvY0WgF+Av18M5b1pFureBo=;
        b=inrUlWJR5zLMQtVXhFDEm8rlLQ+hCT0/WMd0YKsPzTgcyBILe6vCN3Xh6JJwL6Xo/7
         L7iG/K8t7KG2oshN8qdBK5zw386u0+BNrfWNsLYwC9WneuDBWjYxiFP2QmrQVaPq3TjS
         sq7BeiPISANYWr5hAGxfuBNDhg2oit/pVZN5aFx76FjCOslkd5KwFJwZDw8A+boZY0He
         dZBX4ChSX2aJfXQzdlEWbH/mp6BEHpR4EVxlwPhL27ATXjsff8Qnae9xCqwmPyCazLQq
         1PjxQ7hkd4pdac+XD5/iXitAq8o6N2so2Xn3WaFBqG+BJ4gp8+9zcghp3JNH51P/IosB
         u6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=agDk4Z2vrUSdhA9OxNpWjvY0WgF+Av18M5b1pFureBo=;
        b=YhaWhmJuvZTOa4ZNsmQirBQAaRfSJsCQJggHQJxW8hAQG3gLQEAxTjhfCR3WM5YMpe
         FRssooIzp0Pj7wIHCQoqRmeuU9faUQkQByvgQ57zVlrKDqIH/ecJJ3/2Q4aRcoOV1/IL
         tyyNiEjgQ3nlUvleBPvBsGUS3QdoKiGffAfnNynlg7081fNWSb4D+dlXn/lss4psUE3S
         cfISSxSWDd0cG7g3IkPA28wcOXrGZsu/ZxFvOGtAqAU6NflKqWjCuhcAneC9+a65PPcp
         OUSJS1f/qeIG5kEGDSiVCLIGzOMRK67v60O1N2rw6GgPCe5JQ+Dwp3sOPGztYHMJU/G9
         AXgA==
X-Gm-Message-State: APjAAAVSnG7oDtLgAj2ULPZU9x00GDcuHX92Xlc8sQBksq6cqZvvY2hv
        rsrnhPsRytVsgKua2o78e5Pzhhm0aQManQ==
X-Google-Smtp-Source: APXvYqwA8ON2g/7IEPm+ajRCowJmLriU7/dUmwuy4BMgAMsimHKsQ6mHp4mjYixx7GpM6VH7j0k3jw==
X-Received: by 2002:a6b:3b03:: with SMTP id i3mr4858009ioa.302.1562858369778;
        Thu, 11 Jul 2019 08:19:29 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s24sm4940492ioc.58.2019.07.11.08.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 08:19:28 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring changes for 5.3
Message-ID: <10c55cd5-8fd2-12ad-248e-09ea58accd15@kernel.dk>
Date:   Thu, 11 Jul 2019 09:19:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Changes that were queued up for this release. This pull request
contains:

- Support for recvmsg/sendmsg as first class opcodes. I don't envision
  going much further down this path, as there are plans in progress to
  support potentially any system call in an async fashion through
  io_uring. But I think it does make sense to have certain core ops
  available directly, especially those that can support a "try this
  non-blocking" flag/mode. (me)

- Handle generic short reads automatically. This can happen fairly
  easily if parts of the buffered read is cached. Since the application
  needs to issue another request for the remainder, just do this
  internally and save kernel/user roundtrip while providing a nicer more
  robust API. (me)

- Support for linked SQEs. This allows SQEs to depend on each other,
  enabling an application to eg queue a
  read-from-this-file,write-to-that-file pair. (me)

- Fix race in stopping SQ thread (Jackie)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.3/io_uring-20190711


----------------------------------------------------------------
Jackie Liu (1):
      io_uring: fix io_sq_thread_stop running in front of io_sq_thread

Jens Axboe (5):
      uio: make import_iovec()/compat_import_iovec() return bytes on success
      io_uring: punt short reads to async context
      io_uring: add support for sqe links
      io_uring: add support for sendmsg()
      io_uring: add support for recvmsg()

 fs/aio.c                      |   9 +-
 fs/io_uring.c                 | 338 +++++++++++++++++++++++++++++++++++-------
 fs/splice.c                   |   8 +-
 include/linux/socket.h        |   7 +
 include/linux/uio.h           |   4 +-
 include/uapi/linux/io_uring.h |   4 +
 lib/iov_iter.c                |  15 +-
 net/compat.c                  |   3 +-
 net/socket.c                  |  18 ++-
 9 files changed, 330 insertions(+), 76 deletions(-)

-- 
Jens Axboe

