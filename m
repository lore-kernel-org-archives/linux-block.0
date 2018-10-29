Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:40022 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeJ3BE4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 21:04:56 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: linux-block@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH blktests] Fix build failure for discontiguous-io on 32-bit platforms
Date: Mon, 29 Oct 2018 12:15:34 -0400
Message-Id: <20181029161534.7564-1-tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/discontiguous-io.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/discontiguous-io.cpp b/src/discontiguous-io.cpp
index 5e0ee0f..a59c18d 100644
--- a/src/discontiguous-io.cpp
+++ b/src/discontiguous-io.cpp
@@ -291,7 +291,7 @@ int main(int argc, char **argv)
 			unsigned char *p = &*buf.begin();
 			for (int i = 0; i < len / 4; i++)
 				iov.append(p + 4 + i * 8,
-					   std::min(4ul, len - i * 4));
+					   std::min(4ul, (unsigned long) len - i * 4));
 		} else {
 			iov.append(&*buf.begin(), buf.size());
 		}
-- 
2.18.0.rc0
