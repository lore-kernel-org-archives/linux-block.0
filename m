Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4159FC31E40
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089221783
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfHCIqF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbfHCIqF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 3 Aug 2019 04:46:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26B4C308FB82;
        Sat,  3 Aug 2019 08:46:05 +0000 (UTC)
Received: from localhost (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDE70608C2;
        Sat,  3 Aug 2019 08:46:04 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 4/4] spec: fix <liburing/*.h> permissions
Date:   Sat,  3 Aug 2019 09:45:26 +0100
Message-Id: <20190803084526.3837-5-stefanha@redhat.com>
In-Reply-To: <20190803084526.3837-1-stefanha@redhat.com>
References: <20190803084526.3837-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 03 Aug 2019 08:46:05 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are two issues with the <liburing/*.h> headers:
1. They are installed with 0755 permissions.
2. The empty /usr/include/liburing/ directory is left behind by rpm -e.

Fix this by specifying the directory (not just globbing the files inside
it) and letting rpm use the default permissions on these files.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liburing.spec b/liburing.spec
index 31dfde0..1337034 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -48,7 +48,7 @@ make install DESTDIR=$RPM_BUILD_ROOT
 
 %files devel
 %defattr(-,root,root)
-%attr(0755,root,root) %{_includedir}/liburing/*
+%attr(-,root,root) %{_includedir}/liburing/
 %attr(0644,root,root) %{_includedir}/liburing.h
 %attr(0755,root,root) %{_libdir}/liburing.so
 %attr(0644,root,root) %{_libdir}/liburing.a
-- 
2.21.0

