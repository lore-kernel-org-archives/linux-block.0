Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C552C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F81260F11
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhHKDhd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:37:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34651 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhHKDha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628653027; x=1660189027;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RGO3k7Im0/zmf/Hv3HDGjqGVpHrOQ5t3E9jTrtJYPo4=;
  b=AVk75kGGjONvtEstWZPS4JQgUNvMQLNWbjlMCgV4VCgfz8sMeKl/Jna9
   IfASHjhhicy/DoKinCQc6hyx19XMVoaWLVo5zjNputvxX+DKj00mwEkc6
   hfSJhc8hgdHMtCQ44kBN0na6I5hFIbUoFxpciUI2oIyEjWZ1iOeJgx06Z
   FW3wifr6tBjSrmGFKFl9f8YzH3bRjPiYsgghqaRTr18su6dYBrkshGUPV
   EkfsfyNUbcpILrHHNipvAyuur5153yLU3oD1McqJ9LJ2g4gyMMnIv/D+L
   44aRdmovYw+94IOy+lTBUdmkljY7vsoW2t+tE4CBuQfXQcQ+qe4HI1fAh
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177454813"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 11:37:06 +0800
IronPort-SDR: 9fkimOHJDdRTgmQUiAQGXu+jTLU/NiNBeMwl92uuNSuwg292yjiZQGna3NuyI3/3rIg7Ya7YKV
 zWAEQrYQcCuRR6b8hOZutK1AVhPEjhtLJ5JkGOZMakL2mynaqsrfXCCv9/UjXhe/JpxKcgg1cd
 s3TCV9krb5nR06MJkYdjhkwRg6aWfD6Silh6Ot5MWJyoZq2uXvHctjFer234hU5wiBCxz79KtL
 pjvByF+yxFF2jeUvqUQPoiq4cLdEzEAWPERSaDlIZZCqE7svUKBCPzmWGK6bVej9SC/CNpXyuw
 ulcyqSLy1tPK/OHWn/L7rusS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:14:26 -0700
IronPort-SDR: trfAXxLIff8ymscFRb/l6NN/HkytkwfYfAw417EtaTEXyemhSBWjvjNC8ki0XCnK4sIwPxfn7k
 Abmk4qG4Py4oSPrzhMTJ8hjxLYp18VB//UY4PolxdCzCaNGkpt5x1ayHXZak3TPz+dMw3tQ3zh
 0xPwojW92rU0BS4DXETNoZJT7r4e2GQmj6Pn+06g8VMiSUCVNotZJjyXMX+kOZZUKPFr0OOVL2
 /e+b2/phSfkkHuzahvspJ7SV5uk+P9t3GLtkD3uT6gwqMLwRGrveyJuwzidx1JUrm6q3UVWdAU
 QwQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2021 20:37:05 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 1/6] block: bfq: fix bfq_set_next_ioprio_data()
Date:   Wed, 11 Aug 2021 12:36:57 +0900
Message-Id: <20210811033702.368488-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For a request that has a priority level equal to or larger than
IOPRIO_BE_NR, bfq_set_next_ioprio_data() prints a critical warning but
defaults to setting the request new_ioprio field to IOPRIO_BE_NR. This
is not consistent with the warning and the allowed values for priority
levels. Fix this by setting the request new_ioprio field to
IOPRIO_BE_NR - 1, the lowest priority level allowed.

Cc: <stable@vger.kernel.org>
Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e4a61eda2d0f..e546a5f4bff9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5296,7 +5296,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	if (bfqq->new_ioprio >= IOPRIO_BE_NR) {
 		pr_crit("bfq_set_next_ioprio_data: new_ioprio %d\n",
 			bfqq->new_ioprio);
-		bfqq->new_ioprio = IOPRIO_BE_NR;
+		bfqq->new_ioprio = IOPRIO_BE_NR - 1;
 	}
 
 	bfqq->entity.new_weight = bfq_ioprio_to_weight(bfqq->new_ioprio);
-- 
2.31.1

