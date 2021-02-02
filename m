Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1788CC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD73864EAC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBBFhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14105 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhBBFhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244225; x=1643780225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Snae7ix+uzrLf3Y+uWSKt6eqc4WPqjkdGb7X5QbFnEE=;
  b=cXyIIFeJ0sJ16qY4h+RpeDjtzn/iGIY1TvNASOm/GFjBnGIRBLHnEmnd
   Y2A0Y+EJh4dqidBj7GIsyhLhK4DhFZs+aVHusbihv0DNJ3oGLpnaukQA2
   tm8B20kONxRoW9egBCu+izY/F2iNn6WDg7F+FYLvzFLPfOPHe/ux3dUYQ
   PCOYChReLe+FUi6gk/AGf71BE7pBfVkj7mhV6kYgaJLVGex/Q/G/YIp6J
   w2dx3QfO/FJGDKL6QQYJe3AFGGKhbRm0W/npRfTZJkHk0nKw/0LGYMu6Q
   MUs9Tt56p3Q7VwgAameoJVIIjxyBlsPNEWKPoeZk0UL9qwMzHBy91c6k/
   g==;
IronPort-SDR: OgZfBaWhuX9DY76MiKxZup668EoRDLvp7l1BmVBglWQMXEJTztDGNvO3uACOz2yaVlkPM3OJME
 OPBoeS0VT3Qf2JpqK+LggzIBP6ttBzkZeVMnoKfOzIzuVO0t2JO4CbCYJBs6PpgVBjSI8LoZvP
 X0X/MlO+8gPUllnN77cl1XK7YXXTh+7VoiE4SAf2XYyYyZekNFo+O4Puav1JmVEMrM7O+W06Ea
 vJDzulRxBxqVvKqI1sTo/LdCtfLzxnni4o4pmIxnyJKIvZpqd2K/cmVXBpBFeuG4sOAhkqq91x
 xDY=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885664"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:00 +0800
IronPort-SDR: O+W3x+Pvvq4BdE5HkCNU/GFqGNATP3n+WBDdvmC6cg9LLxs7pja4gSirXzJfsgiZ/JPCs3iX56
 XwcTu7txHl0Ac09Xki4RFoNiLrv+aXYccN37TGSy7hMbhslUm0TkaoItQpNaq2hrdfaCsRi+gF
 asGuomb27yARET9VTFdLjrtGsOHodSRWHyyTFZZLZ2sgXQdlnvJnKoIC70rB69m7euf7yLGRqn
 7WI/ZrBy4jkJTrrfO/dvCDob8CyfLUE/7UNivipzCTQ43/0/dF3KdcYibvcuJZyP3jZbsmN7t3
 Z+auPc+evxKjHa2St0Muu2cU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:18:09 -0800
IronPort-SDR: UXOC/+Yg2zlkLt5Ld/CujylCc6turbPIk18PhvMRCDWNZW5s9hj/AiZaAnFY6kyPT+kuUKDY0g
 OmmayHp8luIzWmqYhA9coOfVFZuUbaAJdMqB4Q8PDQTB4WMu/pO51wIhBgVY2OIobp6cO6vAwI
 HxzpHC6SZF2DA35kBN1I5jlDB1pcyeqsAxqDmvOmUrE8KccSmVzGgdtisVv7LOmAq+oLbhshCk
 +T7u+NGz1sLSKDcV42x+HO1MlbWNC8iLWN+R8Q0v0NObHcS+3IkBgkULuU2X4NHF17bgFF22L1
 9b8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:00 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 01/20] loop: use uniform alignment for struct members
Date:   Mon,  1 Feb 2021 21:35:33 -0800
Message-Id: <20210202053552.4844-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use uniform alignment and tab spaceing for the struct members. Also,
add bdev identifire name for function pointer to turnoff checkpatch
warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index a3c04f310672..638642bfc76d 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -41,16 +41,16 @@ struct loop_device {
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	int		lo_encrypt_key_size;
 	struct loop_func_table *lo_encryption;
-	__u32           lo_init[2];
+	__u32		lo_init[2];
 	kuid_t		lo_key_owner;	/* Who set the key */
-	int		(*ioctl)(struct loop_device *, int cmd, 
+	int		(*ioctl)(struct loop_device *bdev, int cmd,
 				 unsigned long arg); 
 
-	struct file *	lo_backing_file;
-	struct block_device *lo_device;
-	void		*key_data; 
+	struct file		*lo_backing_file;
+	struct block_device	*lo_device;
+	void			*key_data;
 
-	gfp_t		old_gfp_mask;
+	gfp_t			old_gfp_mask;
 
 	spinlock_t		lo_lock;
 	int			lo_state;
@@ -66,13 +66,13 @@ struct loop_device {
 };
 
 struct loop_cmd {
-	struct kthread_work work;
-	bool use_aio; /* use AIO interface to handle I/O */
-	atomic_t ref; /* only for aio */
-	long ret;
-	struct kiocb iocb;
-	struct bio_vec *bvec;
-	struct cgroup_subsys_state *css;
+	struct kthread_work		work;
+	bool				use_aio; /* use asynchronous I/O */
+	atomic_t			ref; /* only for aio */
+	long				ret;
+	struct kiocb			iocb;
+	struct bio_vec			*bvec;
+	struct cgroup_subsys_state	*css;
 };
 
 /* Support for loadable transfer modules */
-- 
2.22.1

