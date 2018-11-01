Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:14587 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbeKAPes (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Nov 2018 11:34:48 -0400
From: Yufen Yu <yuyufen@huawei.com>
To: <osandov@fb.com>
CC: <linux-block@vger.kernel.org>, <bart.vanassche@wdc.com>
Subject: [PATCH blktests] fix discontiguous-io compile error on 32 bit systems
Date: Thu, 1 Nov 2018 14:35:48 +0800
Message-ID: <1541054148-144718-1-git-send-email-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When make discontiguous-io.cpp with -m32, g++ compiler reports
error for std::min(long unsigned int, size_t) has diffent
arguments type.

fixes: fd21728886e7 ("Add the discontiguous-io test program")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 src/discontiguous-io.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/discontiguous-io.cpp b/src/discontiguous-io.cpp
index 5e0ee0f..855aba9 100644
--- a/src/discontiguous-io.cpp
+++ b/src/discontiguous-io.cpp
@@ -291,7 +291,7 @@ int main(int argc, char **argv)
 			unsigned char *p = &*buf.begin();
 			for (int i = 0; i < len / 4; i++)
 				iov.append(p + 4 + i * 8,
-					   std::min(4ul, len - i * 4));
+					   std::min((size_t)4, len - i * 4));
 		} else {
 			iov.append(&*buf.begin(), buf.size());
 		}
-- 
2.7.4
