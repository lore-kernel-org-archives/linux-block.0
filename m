Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21ADC432BE
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B6F61050
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhHBJWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:22:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7966 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHBJWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 05:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627896119; x=1659432119;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Wp3XBQ4C2+RmXOsZliWFH3OmT1O2FHqUTFX3us6q2JE=;
  b=IgXoQHSJcNWS5rl9BroRLTRlw1RHwOPVlkdkx36/NFdwcGiIq/f7iN/d
   /y+fksaZlkHDBnpgeWDw3pTxR1Tiw4Xw5dkEBPtXRdZtYEyAe9xVRsSkA
   OKVjaeBZ5ytlVWD410jUiSxsE/mc/YnGALAj/N3Aahz/hpXN4X6nSezt0
   BMeqar3BsGXkDkXx9EWxV+QzYecLsuMTd5tcoly9Aj95tLWOBklpra9Ed
   WzfW6QfeF3BDBEFd3W8eKd6cjktP19Ikatj9GDwWPpNcWuN5nGvuQUT5M
   XmFK3F2DdTn5H3eOvnEzjYk7VZxvsjFp2rkeDu83cShabfjOYRvY7P04l
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,288,1620662400"; 
   d="scan'208";a="180888880"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2021 17:21:59 +0800
IronPort-SDR: XwQN7D6/AfZ6fKJuQ9JBI4vxb88A1yhPfq3dfQ+gC6Xs6L5bncu3ZWohdM1FBbTrK8RaFGolm7
 uOwoxUls3FXYTapAJ7aIHVoLRUPPDIZR4qlABuL2IwtQT8hDKHJS4YldO18Rkjx8SE9qsSaRkN
 7YBASJnjw245FqqdrcfsOrCMxQnroX4h5l3cjAq62D5hbvPNEtYCNFBARllpOhaPPurq4/jmBw
 lemTlEFGWyah4zUtej0McuOGANnHHHi93kzO2+Gcz4HO5T/tHEHEf9yXye6l0XHJFActA67pff
 JxcEf39AOHB+RjRli5FAy638
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 01:57:40 -0700
IronPort-SDR: t9hCOL3wt0gMcO9YwDxpRnLbpDj+wi56JzzPLwem83Il4zUhuOVTEJmWL4RMUmJ9jdNqqSrwHw
 +IPay0HFTpVcXsJNxo0VaRUS25LKaYjavGWaq++P3lc3Vyr1sp3IC5QS9+CiPyjN50Ikp2UMVV
 E43fY3Cwx/kAGilL/e9c/WouVw46KxcP+N/JgccwJ3hVygrQOO/H3SgHVQ2jaH7P7uAyYqwbom
 HFdPS1dFKPvMsVmr40C6oHA5Tu1Pmf1HjysYOnHluaabM3F8ud85wUrcOqk4l7QpVUWz3kogBW
 +lQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Aug 2021 02:21:58 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/3] block: bfq: fix bfq_set_next_ioprio_data()
Date:   Mon,  2 Aug 2021 18:21:55 +0900
Message-Id: <20210802092157.1260445-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210802092157.1260445-1-damien.lemoal@wdc.com>
References: <20210802092157.1260445-1-damien.lemoal@wdc.com>
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
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 727955918563..1f38d75524ae 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5293,7 +5293,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	if (bfqq->new_ioprio >= IOPRIO_BE_NR) {
 		pr_crit("bfq_set_next_ioprio_data: new_ioprio %d\n",
 			bfqq->new_ioprio);
-		bfqq->new_ioprio = IOPRIO_BE_NR;
+		bfqq->new_ioprio = IOPRIO_BE_NR - 1;
 	}
 
 	bfqq->entity.new_weight = bfq_ioprio_to_weight(bfqq->new_ioprio);
-- 
2.31.1

