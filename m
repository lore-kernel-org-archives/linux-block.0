Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60FCC001DB
	for <linux-block@archiver.kernel.org>; Thu,  3 Aug 2023 21:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHCVVq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHCVVp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Aug 2023 17:21:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B5211E
        for <linux-block@vger.kernel.org>; Thu,  3 Aug 2023 14:21:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 373LLe7Z001074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 17:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691097701; bh=qcpzbiRuVKSH4bm+vKqPl11/5eCczz1lb6g5muV3MG0=;
        h=From:Subject:Date:Message-Id:MIME-Version;
        b=GEPH4kCKryRf2gdBrgnXPK2FOE/NZE47zTxr8E/W4X8HSrbtLjp3vCYnAL42CyTg4
         XBZvkrW6ySrYdyh05AvH+lMrhxdjVUXEUtCfQfWDg63qtCDZa+MHBRkHVbhv9i2k5+
         RZYWylfAX4Mi2xDyBXNRYCE/b6oNiaOW0egO/bz95FBXv29IM/MM5DRhjeGCK9M9sm
         kg+pgyA8a80r6HHbxRyazYmECzOEAOCUCcorX2MxjfRJEWQnlzh/CuNjtsAev+Re+l
         yAhB5Pcvwfo2KHRmM450vq731usL2fKSW24U6Yt+VbUSXzOrqOSENn+7yOAGANmFMH
         cqNbkqFiz0mvA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2388515C04F1; Thu,  3 Aug 2023 17:21:40 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-block@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH blktests] src/Makefile: fix static linking of miniublk
Date:   Thu,  3 Aug 2023 17:20:52 -0400
Message-Id: <20230803212052.1173449-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When using static linking, the libraries need to be placed after the
.o or .c files so they are searched.  Otherwise, the build will fail:

cc -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H  -D_GNU_SOURCE -lpthread -luring -o miniublk miniublk.c
/bin/ld: /tmp/ccfjiUvb.o: in function `ublk_ctrl_init':
miniublk.c:(.text+0xaeb): undefined reference to `io_uring_queue_init_params'
/bin/ld: /tmp/ccfjiUvb.o: in function `ublk_queue_deinit':
miniublk.c:(.text+0xb73): undefined reference to `io_uring_unregister_ring_fd'
/bin/ld: miniublk.c:(.text+0xb85): undefined reference to `io_uring_unregister_files'
/bin/ld: /tmp/ccfjiUvb.o: in function `ublk_io_handler_fn':
miniublk.c:(.text+0xd62): undefined reference to `io_uring_queue_init_params'
/bin/ld: miniublk.c:(.text+0xd77): undefined reference to `io_uring_register_ring_fd'
/bin/ld: miniublk.c:(.text+0xd8c): undefined reference to `io_uring_register_files'
/bin/ld: miniublk.c:(.text+0xe94): undefined reference to `io_uring_submit_and_wait_timeout'
/bin/ld: /tmp/ccfjiUvb.o: in function `__ublk_ctrl_cmd':
miniublk.c:(.text+0x14a6): undefined reference to `io_uring_submit'
/bin/ld: miniublk.c:(.text+0x1533): undefined reference to `__io_uring_get_cqe'
collect2: error: ld returned 1 exit status
make: *** [Makefile:61: miniublk] Error 1

Fixes: d42fe976 ("src: add mini ublk source code")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 1365480..c902649 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -39,7 +39,8 @@ CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
 override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
 override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
 		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
-MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring
+MINIUBLK_FLAGS :=  -D_GNU_SOURCE
+MINIUBLK_LIBS := -lpthread -luring
 LDFLAGS ?=
 
 all: $(TARGETS)
@@ -58,6 +59,7 @@ $(CXX_TARGETS): %: %.cpp
 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $^
 
 $(C_MINIUBLK): %: miniublk.c
-	$(CC) $(CFLAGS) $(LDFLAGS) $(MINIUBLK_FLAGS) -o $@ miniublk.c
+	$(CC) $(CFLAGS) $(LDFLAGS) $(MINIUBLK_FLAGS) -o $@ miniublk.c \
+		$(MINIUBLK_LIBS)
 
 .PHONY: all clean install
-- 
2.31.0

