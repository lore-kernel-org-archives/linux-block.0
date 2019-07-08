Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3614C606CD
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D288E2086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404762AbfGHT6A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:58:00 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33648 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfGHT6A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 15:58:00 -0400
Received: by mail-pf1-f175.google.com with SMTP id g2so3319552pfq.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 12:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+4vD/7jOOisFh2GKSZdPJeUoY2ScvqHM1ihSaIpmiI=;
        b=P7U2vVi5QmQ8Nzb7G3iO9+opt4E6yjWw086TNqEdBhSTunilQ66T13a9CqzAD6jEX9
         TwX6RunNpLz4DeXxr1eKI5z6pY/gjniND19MsfAAyMOFHiaMfOXYNag2+D6piszKJwzh
         9RQF1Ig+K7ysW3Tu4jiy/xIEkFBstRbUSgrc8TlTU5vtJXnUyddKhfPC6moVvQZ1N2pK
         ZGE51AbBvA+YP0s0V/abYmbPbrXTcsx2Rl1o0ibzU+h3QGMmbvC+XRmPw4WDqEEtQdmL
         KW636GENfM3KGbjekPf9TvlJi3S0tdWitz798bovXD0RYa0mZDz4QxsqZruimoZHMR5z
         5MnQ==
X-Gm-Message-State: APjAAAUYrXs8SFC0bGCjZZsk5M+UqaX74v1sXkVi7qtWUccTzAP/yxuN
        JoL2EQ1Re8GKgIXwMeZstcs/H1oh
X-Google-Smtp-Source: APXvYqx2ySh0haekZ5ZE0OLfCXf73Xvn6Op7wJIK3BxluoUAZ0o/khkAnVO5kpYXJ3/KDjCCLh2yyQ==
X-Received: by 2002:a17:90a:cb81:: with SMTP id a1mr27369490pju.81.1562615879295;
        Mon, 08 Jul 2019 12:57:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t8sm298043pji.24.2019.07.08.12.57.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:57:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH liburing 1/4] Makefiles: Support specifying CFLAGS on the command line
Date:   Mon,  8 Jul 2019 12:57:47 -0700
Message-Id: <20190708195750.223103-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708195750.223103-1-bvanassche@acm.org>
References: <20190708195750.223103-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch makes the liburing build work as expected for e.g. the following
command:

make CFLAGS=-m32

and avoids that the build fails as follows for the above command:

make[1]: Entering directory 'liburing/test'
cc -m32 -o poll poll.c -luring
/usr/bin/ld: cannot find -luring
collect2: error: ld returned 1 exit status
Makefile:18: recipe for target 'poll' failed
make[1]: *** [poll] Error 1
make[1]: Leaving directory 'software/liburing/test'
Makefile:12: recipe for target 'all' failed
make: *** [all] Error 2

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 examples/Makefile | 3 ++-
 src/Makefile      | 2 +-
 test/Makefile     | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/examples/Makefile b/examples/Makefile
index 6fe9bb9d15b2..ed73fcdcdaa2 100644
--- a/examples/Makefile
+++ b/examples/Makefile
@@ -1,4 +1,5 @@
-CFLAGS ?= -g -O2 -Wall -D_GNU_SOURCE -L../src/
+CFLAGS ?= -g -O2
+override CFLAGS += -Wall -D_GNU_SOURCE -L../src/
 
 all_targets += io_uring-test io_uring-cp link-cp
 
diff --git a/src/Makefile b/src/Makefile
index b68b57e73013..954e05ea6160 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -3,7 +3,7 @@ includedir=$(prefix)/include
 libdir=$(prefix)/lib
 
 CFLAGS ?= -g -fomit-frame-pointer -O2
-CFLAGS += -Wall -I.
+override CFLAGS += -Wall -I.
 SO_CFLAGS=-shared -fPIC $(CFLAGS)
 L_CFLAGS=$(CFLAGS)
 LINK_FLAGS=
diff --git a/test/Makefile b/test/Makefile
index b94e29ecbbff..52b4c9e53d22 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -1,4 +1,5 @@
-CFLAGS ?= -g -O2 -Wall -D_GNU_SOURCE -L../src/
+CFLAGS ?= -g -O2
+override CFLAGS += -Wall -D_GNU_SOURCE -L../src/
 
 all_targets += poll poll-cancel ring-leak fsync io_uring_setup io_uring_register \
 	       io_uring_enter nop sq-full cq-full 35fa71a030ca-test \
-- 
2.22.0.410.gd8fdbe21b5-goog

