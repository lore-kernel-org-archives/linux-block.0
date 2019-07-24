Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D87C7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8770221BF6
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfGXIY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGXIY6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 04:24:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5A613092657;
        Wed, 24 Jul 2019 08:24:58 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B9DC60BEC;
        Wed, 24 Jul 2019 08:24:55 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 1/4] pkgconfig: add missing config-host.mak dependency
Date:   Wed, 24 Jul 2019 09:24:47 +0100
Message-Id: <20190724082450.12135-2-stefanha@redhat.com>
In-Reply-To: <20190724082450.12135-1-stefanha@redhat.com>
References: <20190724082450.12135-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 24 Jul 2019 08:24:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rebuild the .pc file when config-host.mak changes since @prefix@,
@libdir@, etc could have changed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ea639d6..4f524df 100644
--- a/Makefile
+++ b/Makefile
@@ -29,7 +29,7 @@ ifneq ($(MAKECMDGOALS),clean)
 include config-host.mak
 endif
 
-%.pc: %.pc.in
+%.pc: %.pc.in config-host.mak
 	sed -e "s%@prefix@%$(prefix)%g" \
 	    -e "s%@libdir@%$(libdir)%g" \
 	    -e "s%@includedir@%$(includedir)%g" \
-- 
2.21.0

