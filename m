Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D4C433E6
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A9A64ECF
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhBXHSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:18:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26626 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhBXHRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 02:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614151055; x=1645687055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tNvWvVtrlofCH0w5VCyhxXhrOhihrTVKHCDcTWe6xKM=;
  b=c1WqLGrMbQLjqy1bA2qt6uc0hci2l8yQyK2yxLG0dVEa32ECi0ELwhyJ
   SnpSXZOknT+ehymKfrgGzaZMQ/KRPd36G2pOq2XAN7+Vv1IulZ+S7k6Hj
   YA/XGF25nT/E0uA9O5STto3Ih6J5a2b8C0oNRXi9QwQFNsqE2MDuBhNgN
   ZNSR/ZWwSr14vLVpWMXtyZTjGw8wfzjRHUT63hUb2CN/a0anQHL+v06ZV
   Vu65DnXw/kk8wFfL8cgppmD4lgdV2igp/eq0jNrwllyJnCHzstK9nWdsl
   ZOI7epz6DJoP8zpOOo3AipFLLl1orHmN4qFwC7YJv1cxK91bLZk9+LQLW
   g==;
IronPort-SDR: PZkrRA0wB5zFrvAaUrlRUjZpQG/Kj8uQtpi0M6i1fiXbxvlY8ErhvEXcAAxDHT45zZxydA12Ph
 2C3LaNrroSfVC5vvxc/co+eQYrrs20NHTwU/WdddzGqBpQAkMK6WxFLxnPzv0yoNP7sYXcPEOi
 D8YvjlCM0VtCP7sHVHi8YEgRytPWel1GG9/7CFAGaTWY6l8/ua5dqo2PCCHs4ggnTaK0dCmYod
 GaW5RwbqRnMpUoogO9mY1GLe0CBgFY5nAHABzQ8Ppk5gDKrRINVpRRhdQ4a8AKTOQn3JLTKGSY
 WWQ=
X-IronPort-AV: E=Sophos;i="5.81,201,1610380800"; 
   d="scan'208";a="271218441"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 15:16:27 +0800
IronPort-SDR: sFlS71wCrQzH6av4W+23g9DUnnmyRh2ONt0JUUAFpBUU2b8YQVAnc/m0dZUb7iY5P2weCFGMI5
 u/WvAGZz+FV9Znv+/dvoTxbk/+Vdlol8xwT5sa1hUxd6dQ6RjctNZtEBRJ6HBtK+BgfZ8/Gx42
 4YAti2KvGNZclrk8xcXgksCUMyamvj1hmQOjr8JYGaK439WZC1WNQf2Y1pJcoek7BZTFmCBE4H
 iolPJGZVj3Wd46cvzz4tz6rWZFczBOhVcfOtju3+TV3MEHcHAIT0cf0uhvZCMTS5qNhqkQjvXt
 XOVr2+paTp/cPRJRA+TsbYUw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 22:57:53 -0800
IronPort-SDR: RYOw7kL5h6c2jEww7XPS2KjqVTMKr+Mtwik2Lk478WE+qP96hfcS82SjizADXaLJhRjWSWrXV5
 M83SIKRngu4WPXv7tydUnoM/NpW2iYofPle1idoWk2HFC7Ka41bcm0I9lJI/26EqwCVsj4NhIK
 cp2dEkOdPE5s61vzfSjgckMZruR963O3sxoTK+Fc49gVqEd9tALP3ZQVbGlsGAYiHL5OKI3gPv
 I+nJuN6gWeAtSoEy120l+yFZmaoMHqQa+xa17VaXjIJinYT4oHIbs/Y5DmGiaLdg1uZzs3Q8oo
 uoM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2021 23:16:27 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, sfr@canb.auug.org.au,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] blktrace: fix documentation for blk_fill_rw()
Date:   Tue, 23 Feb 2021 23:16:23 -0800
Message-Id: <20210224071623.42164-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add missing ":" after rwbs function parameter documentation that fixes
following warning :-

./kernel/trace/blktrace.c:1877: warning: Function parameter or member 'rwbs' not described in 'blk_fill_rwbs'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 1f83bb4b4914 ("blktrace: add blk_fill_rwbs documentation comment")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---

* This patch is generated with linux-block/for-next on the top follwing
  commit :-

Commit 61ce46f9b9ef2f5918ef784570c3ca668f58c8ce (origin/for-next)
Merge: 818b96ba6e27 452c0bf8754f
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Feb 23 20:31:20 2021 -0700

    Merge branch 'block-5.12' into for-next
    
    * block-5.12:
      block: fix logging on capacity change
      blk-settings: align max_sectors on "logical_block_size" boundary
      block: reopen the device in blkdev_reread_part
      block: don't skip empty device in in disk_uevent
      blktrace: remove debugfs file dentries from struct blk_trace

* Without this patch :-

# makej htmldocs 
SPHINX  htmldocs --> file:///mnt/sdb/linux-block/Documentation/output
make[3]: Nothing to be done for `html'.
WARNING: The kernel documentation build process
        support for Sphinx v3.0 and above is brand new. Be prepared for
        possible issues in the generated output.
        Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
./kernel/trace/blktrace.c:1877: warning: Function parameter or member 'rwbs' not described in 'blk_fill_rwbs'
./include/linux/rcupdate.h:884: warning: Excess function parameter 'ptr' description in 'kfree_rcu'
./include/linux/rcupdate.h:884: warning: Excess function parameter 'rhf' description in 'kfree_rcu'

* With this patch :-

# makej htmldocs 
  SPHINX  htmldocs --> file:///mnt/sdb/linux-block/Documentation/output
make[3]: Nothing to be done for `html'.
WARNING: The kernel documentation build process
        support for Sphinx v3.0 and above is brand new. Be prepared for
        possible issues in the generated output.
        Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
./include/linux/rcupdate.h:884: warning: Excess function parameter 'ptr' description in 'kfree_rcu'
./include/linux/rcupdate.h:884: warning: Excess function parameter 'rhf' description in 'kfree_rcu
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 0c8690d9f6cd..ca6f0ceba09b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1865,7 +1865,7 @@ void blk_trace_remove_sysfs(struct device *dev)
 
 /**
  * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character string.
- * @rwbs	buffer to be filled
+ * @rwbs:	buffer to be filled
  * @op:		REQ_OP_XXX for the tracepoint
  *
  * Description:
-- 
2.22.1

