Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42979 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdHWWa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 18:30:27 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] <linux/uaccess.h>: Fix copy_in_user() declaration
Date: Wed, 23 Aug 2017 15:29:10 -0700
Message-Id: <20170823222911.29453-2-bart.vanassche@wdc.com>
In-Reply-To: <20170823222911.29453-1-bart.vanassche@wdc.com>
References: <20170823222911.29453-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

copy_in_user() copies data from user-space address @from to user-
space address @to. Hence declare both @from and @to as user-space
pointers.

Fixes: commit d597580d3737 ("generic ...copy_..._user primitives")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index acdd6f915a8d..20ef8e6ec2db 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -156,7 +156,7 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 }
 #ifdef CONFIG_COMPAT
 static __always_inline unsigned long __must_check
-copy_in_user(void __user *to, const void *from, unsigned long n)
+copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	might_fault();
 	if (access_ok(VERIFY_WRITE, to, n) && access_ok(VERIFY_READ, from, n))
-- 
2.14.0
