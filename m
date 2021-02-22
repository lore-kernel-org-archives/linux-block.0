Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F1C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182D364E61
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBVFbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:31:50 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29572 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVFbs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 00:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613971908; x=1645507908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RwSG67ACNLCwVXwgmCiXvQu1KQSR5+t16hNQS7JHeOY=;
  b=OQFWCJBeeSVgqOkgW/7jv20WWDz+W4BBxx4DZhPeYRaAFxk8Y9h98/f+
   b13rUhYaQGDjy2HYfCTk0bgBg2twi3j0vhkTu5jH4wJdOgf3B92GWtJP0
   GI03eww+OUQ95AIsXvdPBrYVymXp/y4pnDpEPiAW+1hAK2bR/KBnEnVRR
   LMIeDu6WI+O/+7dgmPzmYpyVJIwF+bBvW7KuPxo0Hcn2uRwu7kaSgusXQ
   rW6nDBom01h9pY+MbQMXfDkZjMGzrmY06DiHnPWg5gfwlwehaLXi7V6nR
   ReRGcubbjEZqCNNSSmEz2V9WdpnqScJ07ev5SHZSgxfYeYJ4zOb+zRGCr
   A==;
IronPort-SDR: s3VzK1i7nVHUOhTTC0PTuqvFSZae+z6tZ4GSnXF5e0xL+H9jpVkCKh6TxXgV3G7PERGGZ/dyLo
 dSjZr/QSaZ2e30agTKJ3dHI4Ck3gT1p+cONFHI2TXptZeC93++Qb3SCaYl6CooaDd8uDGbUu/e
 4R+Tw8N//snFxh7uoiDtJfuMX3DyOxEKeDTxB76I9W/mkaOMLun3wFWvYzojcyMAv4UUCOzWOS
 aGXz+KfMPxK7BoA136U61ThskSDVb64ZA8/XJVC5SvzPshB3CbCpn/FRhebppFG1WOmqScBEwU
 pso=
X-IronPort-AV: E=Sophos;i="5.81,196,1610380800"; 
   d="scan'208";a="164956436"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 13:30:36 +0800
IronPort-SDR: zGnwzcr49NlCQyMmjQRECyNSRSmGgpYGnxJAJJE0Bp584vRB3qQkbxuYKCAKHeCo8Z7dKCZ28U
 u2s8Ul+IZwRERPi2qy96RqYMXJh1LjDWltxLcvIu2JSOReINw8gPYLjHJmBIbyNveBAQ3oLrbZ
 WUWpCt6PbioSCUImOlZt1BQZiwH77hYJsDwJ8/2UsLom6Oyl0r3HUJ1ZmMGZXOVBIlV8L+mEyP
 Vt5/E79KBE0gUpa3/Ic7S730Ap1PkEDRPZ4j+UN2G3GQ9soGwe7+7DYJ2pXDnzGXEibw9Fmg2g
 Y47i2hk1xY00/BYd+6FbQQ4q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 21:13:56 -0800
IronPort-SDR: IHgh0m4ktUrZnjO/ITULBV7MqgfxfPxlbXRnSQsErkiuMscu4Zn7BdpC8/XKI2PsOsgCAkp8+Y
 6n6K8riMPpkEh5q0cEBOW0AW0OQIcvr5xjvtj8W6B1fpe2z2LkpSrMMx2fVxx2GHylvhUS/0N8
 gkfFTvhgsdxDfTdmo8twGW/ttIhzd1QNvRqxBZz7zHGEl5Nm85+KqteBlnjTO+wF/V5dDmA2A2
 UDrLtVRxEPEaIq4766YInonX1Ya+goDvyrPdAFt6m0iJyju7zB//8ing7mAX8huhhfZbcl5rRt
 vi4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2021 21:30:37 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, hare@suse.de, colyli@suse.de,
        tj@kernel.org, rdunlap@infradead.org, jack@suse.cz, hch@lst.de
Subject: [PATCH V3 4/5] blktrace: fix blk_rq_merge documentation
Date:   Sun, 21 Feb 2021 21:29:58 -0800
Message-Id: <20210222052959.23155-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
References: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit f3bdc62fd82e ("blktrace: Provide event for request merging")
added the comment for blk_rq_merge() tracepoint. Remove the duplicate
word from the tracepoint documentation.

Fixes: f3bdc62fd82e ("blktrace: Provide event for request merging")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 004cfe34ef37..cc5ab96a7471 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -210,7 +210,7 @@ DEFINE_EVENT(block_rq, block_rq_issue,
 
 /**
  * block_rq_merge - merge request with another one in the elevator
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queue @q is merged to another
  * request queued in the elevator.
-- 
2.22.1

