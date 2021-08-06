Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E7C4320A
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 05:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB71611C6
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 05:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhHFFMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 01:12:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64546 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbhHFFMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 01:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628226704; x=1659762704;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Wp3XBQ4C2+RmXOsZliWFH3OmT1O2FHqUTFX3us6q2JE=;
  b=PkZN9/87QafCswu3rFn+sZTD5RzOwcKy2wOXKHSXzGa2TdjMaLjCb8Bm
   WqnhwR5OUC+Shzk8/Xj01YrtNSMCKQMBrQ2g9Wwy6jH5egnD0MwO1KVY/
   3CScNY3DgTvTzgyHqm7t3r8ZABqChAP6zmPSOCSrOt7hWMHnl0dHj1uno
   n3P+buHSOvCLuymsAHFjkxa4fdmBQ/hsXzAVUa9NRqG7D7WZ8RbSecNIb
   lL1ZkS+ScdzBCXGM7JNmsy3xjeHWw14EMNnfX5M7YSn2Z8VewF6TQD6Ay
   lotc/foN9JWtpQuMumb8GUObYLJ/0/s/TLPFbkrjQ+7GqMByxLBJiZZZQ
   g==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="176473064"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 13:11:44 +0800
IronPort-SDR: SBYNHn1pIR1bNEbq/VgwN4TfffLoaI+xfHGEh61olLZfX0aQwGu2teJ2hX8sXtTx1UuualG/Q8
 RrIT1FM1oHKrj/prxRhfrJEr0Mt/1eV4SBeBfM1M/hAPuKcs20VgrYPhXaWB/5xaKo1nDyoSRs
 4X8Z8O/WgM3EOVno/252QoJsJAKaIZywHgsXfmkN56cg8/v56lukRNy5bBmQHGQN1IAJ876Wv9
 0LzGkikv1plCzXJOHTJSdmrLCV3w/i69Qir0o+Dh76D0mIZtkNCJ32F0b8KDpaaOicnXg8GSmp
 2YcWEGsqo5vhsHiA+hMXfM9L
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 21:49:13 -0700
IronPort-SDR: QNJm2PaOzMPWCzdw1EsuuAdxLxP8R2nonVFdbU2x6988au7+jluwWdTJf1/OdxcT/WE9I83FS1
 vl/zDDGGUGU67rnSgrqHbb7ehIbOEEINXE6KcFMW6wvRqK26FrwJ3bf/Sn5DsFnArrqRt/tf7W
 GRHYGhPMa7dKQQ6Dqzt1DO4o2cxg5+XjA3UStOJfOO/ap6KlEEkgr/47WbnySi68TsWSZCa+wS
 fU7u83xUuMch1yb+owmg4tgyyzDBjEuyPLK0/taLAd3tgu8emDshcy8Dw7ooELfCoGOWoZkhkU
 7ds=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Aug 2021 22:11:44 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/4] block: bfq: fix bfq_set_next_ioprio_data()
Date:   Fri,  6 Aug 2021 14:11:37 +0900
Message-Id: <20210806051140.301127-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806051140.301127-1-damien.lemoal@wdc.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
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

