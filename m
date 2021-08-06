Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31C4C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A069D60C41
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbhHFLTS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:19:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39959 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbhHFLTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 07:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628248739; x=1659784739;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=eBYyIbp0CVdKv+DUuPIld1FS7dkZOV4BqVmB32O6afo=;
  b=PMSLUV4DqEGRg2GZWdydilGG4uLid8mv4gD6JEMFi9N20uek1/KCrQnl
   mpkUDclzLHzGnKPqVsnhMnus/6aJ3U0ihkRm9ARIP/eoijLtKupIHROoH
   i381j6rnqUc8iRAjbLCjSSDFU9XZZBVUHoRPXncia4DSIyq99TiOGISU3
   GgDsBBKc1UsqmZfovy1QFR6UDoGp39h5VLwqLaJAsxNm83F5LbzH2/O08
   WtuihJFdg5sJ+bY+DzN68wbWJhJASqaldj+BZ3Ao0eAoYSbmVpVUH8pfP
   yqwvTqMHsNBh/TM8AjGkLA1KQUosxgPMdln5GdyFnhAKkKe5Dmc+og+aM
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,300,1620662400"; 
   d="scan'208";a="181309759"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 19:18:59 +0800
IronPort-SDR: UzdbUD6Zt4trrG3PuBLIHMTF27OqeDhdTzr9KtABaDptBj38YWKhE5SGrCyYde9EhPn5UlO49m
 0C2RseWojlBnZKOwt+Ts1BCKK8q8gIEsZehywVa16X6Hfk0pMGB2AlPBI/c/Wtud1x3Y3PhgFj
 K/qsN6pdQlOmKgVcDBpnyVrz3FpetYFwEUym2s/L77bI9002f4gZergvsfUjHbvWGNy23jARVq
 yfCJXM77whsM/1jGq3TzG9A9e6VhCUGHQerxpk6Kq119Ti8BQWAVb4P0nZxyQg/7f2X8MkiG6q
 r/MNrEW/J2QAJFhY3bgZfmkZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:54:37 -0700
IronPort-SDR: oTraU1UZnUhDYzNkFnTyCEZSYb3R1y0q03QZNJcThma5yfo1nzha3wSAVDuYHtxM3E5xJp/K3D
 hsoQcty3B1rJom29TclStr1w5HcbSYCsLDm/Mw9KNbgpQUWd0twa1Cz2cL8UJ8yU/cmpnUvzhQ
 H7/w3xDv/Eh7gm0cuUaRJKoJoznqISkw/nOhjGwxjjpaUTTox5IFkYXkz33VQFTQcPDDfDfxkQ
 rcedViC5nE+U9IaUC/v3RDFjBoig4edFMFMzYcvDZZ660zpsN/kBDyB3NhH6DKbsjqfpgajeJJ
 Gx0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2021 04:19:00 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 1/4] block: bfq: fix bfq_set_next_ioprio_data()
Date:   Fri,  6 Aug 2021 20:18:54 +0900
Message-Id: <20210806111857.488705-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806111857.488705-1-damien.lemoal@wdc.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
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

