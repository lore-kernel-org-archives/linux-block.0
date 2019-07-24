Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD8C7618F
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2212422ADA
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGXIZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfGXIZD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DB0D87633;
        Wed, 24 Jul 2019 08:25:03 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43E5419C70;
        Wed, 24 Jul 2019 08:25:00 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 2/4] spec: invoke ./configure with arguments
Date:   Wed, 24 Jul 2019 09:24:48 +0100
Message-Id: <20190724082450.12135-3-stefanha@redhat.com>
In-Reply-To: <20190724082450.12135-1-stefanha@redhat.com>
References: <20190724082450.12135-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 24 Jul 2019 08:25:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit fd26c1a2f0eb ("configure: move directory options to ./configure")
moved --prefix=PREFIX and other directory options to ./configure.
Invoke ./configure with these options instead of passing them to the
makefile.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/liburing.spec b/liburing.spec
index 61afac8..189a16a 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -25,12 +25,13 @@ for the Linux-native io_uring.
 %setup
 
 %build
+./configure --prefix=/usr --libdir=/%{_libdir} --mandir=/usr/share/man
 make
 
 %install
 [ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
 
-make install DESTDIR=$RPM_BUILD_ROOT prefix=/usr libdir=/%{_libdir} mandir=/usr/share/man
+make install DESTDIR=$RPM_BUILD_ROOT
 
 %clean
 [ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
-- 
2.21.0

