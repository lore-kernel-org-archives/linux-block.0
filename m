Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5D2C04AA9
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 15:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD072075E
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 15:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xb8cs90F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBPBa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 11:01:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42713 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfEBPB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 11:01:29 -0400
Received: by mail-io1-f65.google.com with SMTP id c24so2348316iom.9
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VmRq0p1pnI3PshItJH71dbpJHfu2QD6YU15zD+resKw=;
        b=xb8cs90FZCL6/bFm2X5ozzEwhHaRjKdqx7kSWMKTaORmdNQLsJZGfag50vZxRQ01AG
         a6fCXV4LEI7j9CSApKy4OoEcM3SU8t2m2gFQf8uI0TSU6LHef3ByWx+QdYhq9hsjbAeE
         QK1JUUUC43tauoXWujNWq0CKzzdW56PIvvX3JBNvVWlefecGHrgTWqJH2cSKBLe88M/q
         DvJpt3+/l3Rl/OZYv2YY9mITrZZblyHUn4a34fGnLfXXb+cFoGZC53Ga+2smT+TkP2YB
         mto3NqTnd5qyaYT2291SvEJL3Qt2eHQrq+CcEnjdvYKF2ZTROfaVsJqMk93e29HIZhbb
         0nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VmRq0p1pnI3PshItJH71dbpJHfu2QD6YU15zD+resKw=;
        b=kjkRZD4Ksjbd83YVFBteD77FiLBonPd+Gn42pXp/8B192jAGTZ2hDKcbgk/ES4ud9q
         J2mboqR0BLMJaCB9KNntTwDceeymAkwWqkBgN7a4oZA3In8cvKGbIguMFVkfs8p/Dicv
         eWL3YK6ctD/Nt0E1XRD8AwFU5gTnjal4lltSY0cljYP4L4UbdnjZ2MMtrSnxKATETIOm
         2ylGwr2qKywcfZ+Ckeal7IuhWnEJjF7tw7KrFUv3hIHN9mfrKx0U4vZAX9UVoIjGNBFe
         Q0ZmKtHYCH+rGl3rxjojPXFePQIxCNn5h4roZAtwyGoXnfEaW99gZZnoepPx+XzVFU7L
         jU7w==
X-Gm-Message-State: APjAAAXU3pM1yTDuHP4yQdXyjpPooL+omSCt0SEy6HhThHaWus7M6ulQ
        3gp6mc4yQAOlvWSNH8ArSPwnpBM/QMUhVA==
X-Google-Smtp-Source: APXvYqxvBTuWImxOU9IxUYRsPl//bHceNfyvId4m28vQaLPXVDq0QeyBRq/IYGFJKs0OXJkv4Obrvg==
X-Received: by 2002:a6b:4102:: with SMTP id n2mr211755ioa.256.1556809288082;
        Thu, 02 May 2019 08:01:28 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t191sm4990507itt.17.2019.05.02.08.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 08:01:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Final fixes for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <3c185429-ae45-3152-572e-772d7bd54720@kernel.dk>
Date:   Thu, 2 May 2019 09:01:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This is mostly io_uring fixes/tweaks. Most of these were actually done
in time for the last -rc, but I wanted to ensure that everything tested
out great before including them. The code delta looks larger than it
really is, as it's mostly just comment additions/changes. If you exclude
that one patch, we're down to:

 fs/block_dev.c      |   3 +-
 fs/io_uring.c       | 130 +++++++++++++++++++++++----------------------------------------
 include/linux/uio.h |   2 +-
 3 files changed, 51 insertions(+), 84 deletions(-)

which looks much more reasonable.

Outside of the comment additions/changes, this is mostly removal of
unnecessary barriers. In all, this pull request contains:

- Tweak to how we handle errors at submission time. We now post a
  completion event if the error occurs on behalf of an sqe, instead of
  returning it through the system call. If the error happens outside of
  a specific sqe, we return the error through the system call. This
  makes it nicer to use and makes the "normal" use case behave the same
  as the offload cases. (me)

- Fix for a missing req reference drop from async context (me)

- If an sqe is submitted with RWF_NOWAIT, don't punt it to async
  context. Return -EAGAIN directly, instead of using it as a hint to do
  async punt. (Stefan)

- Fix notes on barriers (Stefan)

- Remove unnecessary barriers (Stefan)

- Fix potential double free of memory in setup error (Mark)

- Further improve sq poll CPU validation (Mark)

- Fix page allocation warning and leak on buffer registration error
  (Mark)

- Fix iov_iter_type() for new no-ref flag (Ming)

- Fix a case where dio doesn't honor bio no-page-ref (Ming)


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190502


----------------------------------------------------------------
Jens Axboe (2):
      io_uring: have submission side sqe errors post a cqe
      io_uring: drop req submit reference always in async punt

Mark Rutland (3):
      io_uring: fix SQPOLL cpu validation
      io_uring: free allocated io_memory once
      io_uring: avoid page allocation warnings

Ming Lei (2):
      block: fix handling for BIO_NO_PAGE_REF
      iov_iter: fix iov_iter_type

Stefan Bühler (8):
      io_uring: fix handling SQEs requesting NOWAIT
      io_uring: fix notes on barriers
      io_uring: remove unnecessary barrier before wq_has_sleeper
      io_uring: remove unnecessary barrier before reading cq head
      io_uring: remove unnecessary barrier after updating SQ head
      io_uring: remove unnecessary barrier before reading SQ tail
      io_uring: remove unnecessary barrier after incrementing dropped counter
      io_uring: remove unnecessary barrier after unsetting IORING_SQ_NEED_WAKEUP

 fs/block_dev.c      |   3 +-
 fs/io_uring.c       | 249 +++++++++++++++++++++++++++++++++-------------------
 include/linux/uio.h |   2 +-
 3 files changed, 161 insertions(+), 93 deletions(-)

-- 
Jens Axboe

