Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F0C432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 04:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0742072C
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 04:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qEy4B9Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3ErM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 23:47:12 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:46240 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfK3ErM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 23:47:12 -0500
Received: by mail-pg1-f180.google.com with SMTP id k1so7083982pga.13
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2019 20:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pgy7igpIJ5WOp97qXan6g9vUo/itqe7db6s2xL510cI=;
        b=qEy4B9Hx0Yck/7Da2ut7GhEHyEiUSPf8zY/kpKoaoaVSK+gZO0ZtZkjIijDuRxfO1a
         iZ0ZGRDZ71LSwHWzcWY2npUDHo1c/2Vrryxrxsa9yT4BuFBVNTZ1KWW1Ho00XUfYPMVv
         UzYWvMvHswDGIw73OoLOwLQ9lDD8OvyErWB7Y8iVpI3CUREZ323n24uGJHxWv++YpycJ
         lMUMdXIGvlivnJFImCyE8vadStBDxZVc8VFi+ulVkUuIsEDIKCO9Vg+hRF6eT5YlHjj+
         BxSX600kZHm41TzO1N5H90UdpXxEfW670WtIAr5/oOcRW7qfezn0vTeqktRMgtjGxm6z
         fKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgy7igpIJ5WOp97qXan6g9vUo/itqe7db6s2xL510cI=;
        b=T1yNV/eTYiITCqDngvz6XRxDjNkUdZiRmPydK4olrLQX8WjfaE9xFk/WhN0hDZfMYX
         M6q4hNxQNQgYcRrIfb2ZLu0ae2HluizV1S8nsOX1RsNTURASe8elFjFGMfZgiN2MZfDx
         vksSrfMt7/yYxXzdRuxoLFDRuNFeeUrtknqHgwW55VEimdu8rShF4s1usxHrGnRdusm3
         u00bqPt7YUAgV+AM73BxGHlrEXGVmBqv79CqjMCkzqLQ5ZGmfY/B/c0ZzkJFO6JYWQcZ
         kQG3ISVGMo8+YSZ05rLzczP+9XqfDAA891wLrf6hR0QtcNgcuT2ujfqi2L9F5GI2deZ4
         Ln0g==
X-Gm-Message-State: APjAAAWOd0YFPWF5MiVDCze8APob5wOw+iB2/obxiz4/yvM4+XpEdw7R
        RsfcJmZxUg4q7RRFoU5EUREhtyYVVi6Bpw==
X-Google-Smtp-Source: APXvYqxQ4Gw/XxbwvQ05lXkpqtbnF6yeuROz91gIJ0lIbb0N8jxXWNSkyY8yZeBlsc/tkGCqDJ/cvA==
X-Received: by 2002:a63:e94d:: with SMTP id q13mr20145588pgj.209.1575089230246;
        Fri, 29 Nov 2019 20:47:10 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:6849:81f9:6b67:ab51? ([2605:e000:100e:8c61:6849:81f9:6b67:ab51])
        by smtp.gmail.com with ESMTPSA id l7sm12403338pfl.11.2019.11.29.20.47.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 20:47:09 -0800 (PST)
Subject: Fwd: [GIT PULL] Final io_uring bits for 5.5-rc1
References: <7976eeb9-b8b5-753b-0d8f-203a00fc1118@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
X-Forwarded-Message-Id: <7976eeb9-b8b5-753b-0d8f-203a00fc1118@kernel.dk>
Message-ID: <62035535-2c12-ecb5-9766-0726e891babe@kernel.dk>
Date:   Fri, 29 Nov 2019 20:47:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <7976eeb9-b8b5-753b-0d8f-203a00fc1118@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Forgot to CC linux-block on this pull request, sent earlier today.


-------- Forwarded Message --------
Subject: [GIT PULL] Final io_uring bits for 5.5-rc1
Date: Thu, 28 Nov 2019 09:05:30 -0800
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: io-uring <io-uring@vger.kernel.org>

Hi Linus,

As mentioned in the first pull request, there was a later batch as well.
This contains fixes to the stuff that already went in, cleanups, and a
few later additions. In particular, this pull request contains:

- Cleanups/fixes/unification of the submission and completion
    path (Pavel,me)

- Linked timeouts improvements (Pavel,me)

- Error path fixes (me)

- Fix lookup window where cancellations wouldn't work (me)

- Improve DRAIN support (Pavel)

- Fix backlog flushing -EBUSY on submit (me)

- Add support for connect(2) (me)

- Fix for non-iter based fixed IO (Pavel)

- creds inheritance for async workers (me)

- Disable cmsg/ancillary data for sendmsg/recvmsg (me)

- Shrink io_kiocb to 3 cachelines (me)

- NUMA fix for io-wq (Jann)

Please pull!


    git://git.kernel.dk/linux-block.git tags/for-5.5/io_uring-post-20191128


----------------------------------------------------------------
Dan Carpenter (1):
        io-wq: remove extra space characters

Hrvoje Zeba (1):
        io_uring: remove superfluous check for sqe->off in io_accept()

Jann Horn (2):
        io_uring: use kzalloc instead of kcalloc for single-element allocations
        io-wq: fix handling of NUMA node IDs

Jens Axboe (23):
        io_uring: io_async_cancel() should pass in 'nxt' request pointer
        io_uring: cleanup return values from the queueing functions
        io_uring: make io_double_put_req() use normal completion path
        io_uring: make req->timeout be dynamically allocated
        io_uring: fix sequencing issues with linked timeouts
        io_uring: remove dead REQ_F_SEQ_PREV flag
        io_uring: correct poll cancel and linked timeout expiration completion
        io_uring: request cancellations should break links
        io-wq: wait for io_wq_create() to setup necessary workers
        io_uring: io_fail_links() should only consider first linked timeout
        io_uring: io_allocate_scq_urings() should return a sane state
        io_uring: allow finding next link independent of req reference count
        io_uring: close lookup gap for dependent next work
        io_uring: improve trace_io_uring_defer() trace point
        io_uring: only return -EBUSY for submit on non-flushed backlog
        net: add __sys_connect_file() helper
        io_uring: add support for IORING_OP_CONNECT
        io-wq: have io_wq_create() take a 'data' argument
        io_uring: async workers should inherit the user creds
        net: separate out the msghdr copy from ___sys_{send,recv}msg()
        net: disallow ancillary data for __sys_{send,recv}msg_file()
        io-wq: shrink io_wq_work a bit
        io_uring: make poll->wait dynamically allocated

Pavel Begunkov (15):
        io_uring: break links for failed defer
        io_uring: remove redundant check
        io_uring: Fix leaking linked timeouts
        io_uring: Always REQ_F_FREE_SQE for allocated sqe
        io_uring: drain next sqe instead of shadowing
        io_uring: rename __io_submit_sqe()
        io_uring: add likely/unlikely in io_get_sqring()
        io_uring: remove io_free_req_find_next()
        io_uring: pass only !null to io_req_find_next()
        io_uring: simplify io_req_link_next()
        io_uring: only !null ptr to io_issue_sqe()
        io_uring: fix dead-hung for non-iter fixed rw
        io_uring: store timeout's sqe->off in proper place
        io_uring: inline struct sqe_submit
        io_uring: cleanup io_import_fixed()

   fs/io-wq.c                      | 187 ++++++----
   fs/io-wq.h                      |  63 +++-
   fs/io_uring.c                   | 776 ++++++++++++++++++++++------------------
   include/linux/socket.h          |   3 +
   include/trace/events/io_uring.h |  16 +-
   include/uapi/linux/io_uring.h   |   1 +
   net/socket.c                    | 214 +++++++----
   7 files changed, 757 insertions(+), 503 deletions(-)

-- 
Jens Axboe

