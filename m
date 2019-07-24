Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1097C7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2F8229FA
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfGXIYz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGXIYz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 04:24:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCEBB335C0;
        Wed, 24 Jul 2019 08:24:54 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4AC75C224;
        Wed, 24 Jul 2019 08:24:51 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 0/4] Fedora packaging preparation
Date:   Wed, 24 Jul 2019 09:24:46 +0100
Message-Id: <20190724082450.12135-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 24 Jul 2019 08:24:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series includes further steps towards Fedora packaging.  The most
notable one is moving private headers into <liburing/*.h> to prevent naming
collisions with other software.  Existing applications are unaffected because
the public <liburing.h> header remains in its old location.

Stefan Hajnoczi (4):
  pkgconfig: add missing config-host.mak dependency
  spec: invoke ./configure with arguments
  src/Makefile: honor the caller's includedir and libdir
  src/Makefile: keep private headers in <liburing/*.h>

 Makefile                              |  2 +-
 examples/Makefile                     |  2 +-
 src/Makefile                          | 18 +++++++++---------
 test/Makefile                         |  2 +-
 src/{ => include}/liburing.h          |  6 +++---
 src/{ => include/liburing}/barrier.h  |  0
 src/{ => include/liburing}/compat.h   |  0
 src/{ => include/liburing}/io_uring.h |  0
 examples/io_uring-cp.c                |  2 +-
 examples/io_uring-test.c              |  2 +-
 examples/link-cp.c                    |  2 +-
 src/queue.c                           |  6 +++---
 src/register.c                        |  4 ++--
 src/setup.c                           |  4 ++--
 src/syscall.c                         |  4 ++--
 test/cq-full.c                        |  2 +-
 test/eeed8b54e0df-test.c              |  2 +-
 test/fsync.c                          |  2 +-
 test/io_uring_enter.c                 |  4 ++--
 test/io_uring_register.c              |  2 +-
 test/io_uring_setup.c                 |  2 +-
 test/link.c                           |  2 +-
 test/nop.c                            |  2 +-
 test/poll-cancel.c                    |  2 +-
 test/poll.c                           |  2 +-
 test/ring-leak.c                      |  2 +-
 test/send_recvmsg.c                   |  2 +-
 test/sq-full.c                        |  2 +-
 liburing.spec                         |  6 ++++--
 29 files changed, 45 insertions(+), 43 deletions(-)
 rename src/{ => include}/liburing.h (98%)
 rename src/{ => include/liburing}/barrier.h (100%)
 rename src/{ => include/liburing}/compat.h (100%)
 rename src/{ => include/liburing}/io_uring.h (100%)

-- 
2.21.0

