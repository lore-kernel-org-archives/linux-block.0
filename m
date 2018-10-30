Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:44090 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeJ3Xai (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 19:30:38 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: linux-block@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH blktests -v2] Fix build failure for discontiguous-io on 32-bit platforms
Date: Tue, 30 Oct 2018 10:36:49 -0400
Message-Id: <20181030143649.28246-1-tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/discontiguous-io.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/discontiguous-io.cpp b/src/discontiguous-io.cpp
index 5e0ee0f..f51a305 100644
--- a/src/discontiguous-io.cpp
+++ b/src/discontiguous-io.cpp
@@ -251,7 +251,7 @@ int main(int argc, char **argv)
 	const char *dev;
 	int c;
 	std::vector<uint8_t> buf;
-	size_t len = 512;
+	unsigned long len = 512;
 
 	while ((c = getopt(argc, argv, "hl:o:sw")) != EOF) {
 		switch (c) {
-- 
2.18.0.rc0
