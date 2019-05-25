Return-Path: <SRS0=ocky=TZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08026C04AB0
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC25217F9
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 09:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfEYJGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 May 2019 05:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfEYJGp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 May 2019 05:06:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDC1C8535D;
        Sat, 25 May 2019 09:06:44 +0000 (UTC)
Received: from localhost (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20C785C206;
        Sat, 25 May 2019 09:06:41 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 0/2] pkg-config support
Date:   Sat, 25 May 2019 09:58:28 +0100
Message-Id: <20190525085830.31577-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 25 May 2019 09:06:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 1 adds pkg-config support so that applications are not required to
hardcode compiler flags that may change depending on the distro.

Patch 2 moves installation paths to ./configure so they are adjustable from the
command-line and do not require modifying the makefile.  This is necessary so
Fedora x86_64 can set libdir to /usr/lib64.

I have tested this by building Aarushi Mehta's QEMU io_uring support
using pkg-config on a Fedora x86_64 host.

Stefan Hajnoczi (2):
  pkgconfig: install a liburing.pc file
  configure: move directory options to ./configure

 configure      | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-
 Makefile       | 17 ++++++++++------
 .gitignore     |  2 ++
 liburing.pc.in | 12 +++++++++++
 4 files changed, 79 insertions(+), 7 deletions(-)
 create mode 100644 liburing.pc.in

-- 
2.21.0

