Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38512C433FE
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 06:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiDNGjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiDNGjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 02:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 242F450B1B
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649918216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YsKS+gtQCw9gSuuCeDFIBxhgvPXSvy6sfDZyth/Ynrk=;
        b=II+xnOpKWAonAr8bprM6k04b/EWvVp6D3A1ISWCHsFfwEY2B76kXoyzNRuTP4JoyrKqFcA
        6hiSQ3F9SIUJ2ssixBoKYsw9yPfAr98ZMw+/tlJYGWhsZHH0vq+w2O74luNjWtQByc/8/h
        MC0G6M1lc/b8DBU1YuuHhO6iMqUHpuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-LYPfr49cM2SHlGrdLrsG2g-1; Thu, 14 Apr 2022 02:36:53 -0400
X-MC-Unique: LYPfr49cM2SHlGrdLrsG2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3B0480352D;
        Thu, 14 Apr 2022 06:36:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BC1840885A6;
        Thu, 14 Apr 2022 06:36:52 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paymon MARANDI <darwinskernel@gmail.com>
Subject: [PATCH] Revert "make: let src/Makefile set *dir vars properly"
Date:   Thu, 14 Apr 2022 07:36:51 +0100
Message-Id: <20220414063651.81341-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 9236f53a8ffe96cc2430f7131bbcba5756b97bc2.

"make install DESTDIR=..." specifies a root directory where files are
installed. For example, includedir=/usr/include DESTDIR=/a should
install header files into /a/usr/include.

Commit 9236f53a8ffe removed the includedir=, etc arguments on the make
command-line in ./Makefile, leaving only prefix=$(DESTDIR)$(prefix). It
claimed "prefix suffice for setting *dir variables in src/Makefile" but
this is incorrect. "make install DESTDIR=..." now has no effect and
files are not installed with a DESTDIR prefix.

The GNU make manual 9.5 Overriding Variables says:

  all ordinary assignments of the same variable in the makefile are
  ignored; we say they have been overridden by the command line
  argument.

This explains why it was necessary to set includedir=, etc on the make
command-line in ./Makefile. We need to override these variables with
DESTDIR from the command-line so they are not clobbered in src/Makefile
when config-host.mak is included.

Cc: Paymon MARANDI <darwinskernel@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index d6f8520..28c0fd8 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,9 @@ endif
 
 install: $(NAME).pc
 	@$(MAKE) -C src install prefix=$(DESTDIR)$(prefix) \
+		includedir=$(DESTDIR)$(includedir) \
+		libdir=$(DESTDIR)$(libdir) \
+		libdevdir=$(DESTDIR)$(libdevdir) \
 		relativelibdir=$(relativelibdir)
 	$(INSTALL) -D -m 644 $(NAME).pc $(DESTDIR)$(libdevdir)/pkgconfig/$(NAME).pc
 	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man2
-- 
2.35.1

