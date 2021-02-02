Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47100C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1468E64EAC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhBBFhO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43351 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhBBFhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244233; x=1643780233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6uNsj2Bymx/trVcIbMskT9AETzSX5KyNZzqdu9PdFA=;
  b=mTUlaKeY/SZk57U51WvqeB2CsxG6EAY7frPMPfyVCBrVycbHibqbA/M+
   3nYzUUo6asqtqUdc2LJaHo772UkQHlErgeeTBsMW+zKxWTpugMHoRrONh
   iNGWBr+mwX2Dcxq/9L8WkyogUiu0YxOqfrrwN9ul4DODAHEqe4BjYx/0w
   c0+IyImmfd9iUYmBqJHfSTJN8OhvmPZVn4BbDIE01Zt39i3OZONKZP68A
   CmHJlJA67Bjb9ZkO4uifotIIXiN1Tafw9MNZflbj0bZRWcYmk721zFYEm
   kwfsmNUP0ur9INI1tSIacCguVHzh6qpDzWl1Iyo2dub6mfDDjRiHVk9k3
   g==;
IronPort-SDR: m0fgVR8Y3cLhkO1FTuMg+XRqAKVEzw659k8Mn/EIEPzAhbeHhY6o97H3GdNJeIO5yFpIxsVe/H
 VZ/EPyQtQHAJrf10NSumR9me1tAA35Uostk9Uqi82jkyxt6W/B7L6sVlB/icTuTIm+sJxLrwtA
 8vsRi6Xc7qAAalGIpJYNhIsnQoEYXZbB1k6LPoc8BWEunjPB4Hbl0YF9MD/YVG5CN0pslEHV5m
 C33nzCY3Ma6eA//T3SnUzCThnU7ylQGnSxCcYmuhRQlllIEFl0bpK/i1VTaShU32sNrunjVfYf
 1ds=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163334270"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:08 +0800
IronPort-SDR: NMBTylOjT8NZONU3U3INNuaozT/TlY6Ad+QyYdivz3qwogQKvDM9WlH4TCRudb6lfQ2hgNgD8R
 RAiDQX0dNGltyrsexZngHe+7T5SJeN9OUSDfIETVJSCRE6Ja82xEExpNbvMcedW4rhhrOii5w6
 eBBqEPcXsCZxtgRGcqMeh+7jWBBTu98hUlYgXoAeETA4in50p57jbW/9yErTX/IXchIwkCO0eW
 KLI6mKUUVnhod49M+Ae4WgWs+OSB3xXOYn7EREuNRdJsCwEHQ4iuPa1srd7Kw1Omtt2vh8E5qr
 kMUAHJLEtZepjwtQA3Y7vJ2x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:18:17 -0800
IronPort-SDR: xDqGMD1zwtXMkchJQ/C+BcfM2aFI8vBsrhB28qwB/fvEm9NyzEhyRp0MyYZ9BW2osbF20URBSP
 jr46qPW0rjrg/nPZuKVBrdIbKzJxFOp6tVsXqone5QzMaHnYE87lXgF5kkLSNevlmvAD52mo3Z
 kBQ6iMSfs8irxZ7/XiRT1H52CLpYwPpnydF8JdRxGvmVxf2h57mjKRGZF6dHQHsQLW4F8IwnBU
 Z0b+uxVhRSDDyTIcNdz+7IFnXmV1w57vyL3donVHCazOP8wMfV0UgjAxzVjf5ZUq6C96v85i99
 J30=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:08 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 02/20] loop: add lockdep assert in loop_add()
Date:   Mon,  1 Feb 2021 21:35:34 -0800
Message-Id: <20210202053552.4844-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current code loop_add() is called from loop_probe(),
loop_control_ioctl(), and loop_init(). Each of these functions hold
global mutex lock loop_ctrl_mutex with two variants mutex_lock() and
mutex_lock_killable().

Add lockdep_asset_lock_held() in loop_add() to make sure it will
generate an appropriate error message in case of misuse.  

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 578fc034db3f..3bfdcabaf6b1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2081,6 +2081,8 @@ static int loop_add(struct loop_device **l, int i)
 	struct gendisk *disk;
 	int err;
 
+	lockdep_assert_held(&loop_ctl_mutex);
+
 	err = -ENOMEM;
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
-- 
2.22.1

