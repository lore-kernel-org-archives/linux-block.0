Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66663C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 16:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5EB218F0
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 16:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="A4r+1uMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfBKQk3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:40:29 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:59177 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfBKQk2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=kOKcckl8t/zEAqzIxbp90+VXRyiI3VL/rqTi08+L5O4=; b=A4r+1uMkXdL0
        VYs1T1vnqEtoaUbC4UXwztS5l7oYXlY+Y+g86ZyZ5AGh514yi0d1tNAkkZaPwf2gRXsrqpzKir+D3
        K5K8iH/JN0qbuUJFz6B8mkq/aDKaZlx2+RsQQde2kUryfIHk2Ie3N+zSEIHNVZqkESxpU9UvXJDxi
        u37H0xgfFLv7e56nkdFMCPz5rSxfmCgfvBGlh9oJEHbbgUqsMwhPiqwKzW2fcj37LqTfBwQlsv7B9
        l/Qs+hkELnokj2hQxx89iaQf9v+nc0lQY1FXVv++/gLbXfDOH9ggEmZSSqd71T6zeclx+gmP7mXnv
        iwATIqZTMGccY6Ngtrvbwg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gtEd4-0008Cz-J0; Mon, 11 Feb 2019 17:40:23 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id E5B36C0BDF;
        Mon, 11 Feb 2019 17:40:02 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] Unbreak the continuous integration build
Date:   Mon, 11 Feb 2019 08:39:54 -0800
Message-Id: <20190211163954.256155-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00149603992958)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vnwY2QMA+Lfj8jhOHxsOD1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTaY0xsQ5WWHfD9hz8p4C5sdTYXARcCeY0RPzRMsa11/R44M
 fV5hi61CqoYUfGZVBWSVpTjuGIXBFfbvW1Jyq42T4bx/CNCw+0IkRKo7vn5HMM1Iki6+HZbHtNaS
 1mk9bUcO6WwuB/a/K9tPVA1fAzl/ASQogtXyz/NziIBZESeE2VU/qC6pDtIPoIOIMyQHxt0k4Ndu
 06h2Q8QP5GQeNUYf/yOnVTPWghN18CbQ8x0t04wR75/H4MBR+crAGuUJ4ATNsFlW4xzv3KSabGJb
 xYTPwtvXtwFSUnVvIaLmG0EbEasTatsemRqB3fIy4cypAkiICshFp56ZN00qAbKhx/ImWOInnYou
 U0uQnq/uaXgVJNO9Z5Oc3jQNmPAct+DaFyEXmGz4bmnGVezn9PWPJC54iSrlgXUe2FRrt3Q/saIu
 u9KJ9zpkh4CBVZNevlN99LBB75tz6v0zFYS4i1UpWw5yFbo9hTu9l/2GkCJ+5/mIrN9fxN2oReTD
 HAyOynaY0Cm+1YVZQG7kKIVLKDAfP/fiLz/dsiahQ1DFoGJGH4QvNBsJtQPKQiHZyFvUHYw7eSOJ
 UjxiJ+iyIer32bek7nPrlX1S+8oMSMSBIUAYLLu4muidX4Ts4xdG+C13IyWeZaKK0WJ9Gbx6XC5f
 zmr1Iv0RU34/WMvOa2MADyzbmruTAMadjyGPdQhieMKjzzFc6vqfmZ7ww2G4L5hnRBNVVsfCQ6ie
 30W+SekWG2g23NglFX+g57a6J/5sK4+TfGG8msAA80uNsTeFa4yYJFGS1Hp0ygEwwwWe3xXNBQ8N
 Jdm4PkndMi/yowK/A0SwUdhvH2JdfwF1pZBKlnvazNEyne4/dpx+5i395DA8s0dCg1RJqGYxGv7D
 Zfr3KAxqGJNAwF28CnHyKT6N77/NkdXPDV6r+g8VkhKEFJ2lUlbkduNBMFsWkGe3rrP8epBg83OZ
 BP3RMrw5DdwH1AXXXLvYNFIckdu6/R2FM84kxYRFSvC1IPgY9FHHe9U52OFRRlrQQHTNsFlW4xzv
 3KSabGJbxYTP2MRBN/yBhg133u1IFee4oorsCbHHHr9rzACKpZmvWdFvZfKMnvFRNXBZ7Tcs3Zay
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Travis environment in which the continous integration build is run
does not have the <linux/blkzoned.h> header file. Make sure that the
zbdioctl.c source file builds fine without that header file.

Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Fixes: d42cc3f85e0d ("src: Introduce zbdioctl program")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 src/Makefile   | 10 ++++++++--
 src/zbdioctl.c |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 5a0556f2a37f..cb35497a6089 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,3 +1,7 @@
+HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |			\
+		  $(CC) -x c -c - 2>/dev/null; then echo "$(2)";	\
+		  else echo "$(3)"; fi)
+
 C_TARGETS := \
 	loblksize \
 	loop_get_status_null \
@@ -13,9 +17,11 @@ CXX_TARGETS := \
 
 TARGETS := $(C_TARGETS) $(CXX_TARGETS)
 
-override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS)
+CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
+
+override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
 override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
-		     -Werror $(CXXFLAGS)
+		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
 
 all: $(TARGETS)
 
diff --git a/src/zbdioctl.c b/src/zbdioctl.c
index 93a0f88431b5..9432a8a95b1d 100644
--- a/src/zbdioctl.c
+++ b/src/zbdioctl.c
@@ -6,7 +6,9 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#ifdef HAVE_LINUX_BLKZONED_H
 #include <linux/blkzoned.h>
+#endif
 #include <linux/types.h>
 
 #ifndef BLKGETZONESZ
-- 
2.20.1.791.gb4d0f1c61a-goog

