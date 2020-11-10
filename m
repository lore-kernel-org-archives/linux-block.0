Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38908C4741F
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1349207D3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="PxOyYkZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgKJCYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:24:47 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31618 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgKJCYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604975791; x=1636511791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1LQfy4MRoLNkEPF2WpyasCEthNejxsNzCQhgw0uUJ4=;
  b=PxOyYkZlug9eCHiLCdkr6hosTdvBzsjyrwqDwQc8CZGF2FJhummc3JDz
   ZZrhVlnrbHXk7UuInwIYqrMllzgh0CrPwSTM9VhE+nlG9IMltqljBcyCI
   NZHzL/dny381BUOaGNUpWr23Amj46BwAf/xsZK20J1KEzV81+m2A/K6OS
   eNo9wXM3pguPGNVS5IK2/Gg1klrRrd9X0c3Tb235T1bicp/JlqkRtG5uM
   vp53owFRer598in0gAKNpgc0DdFY87MvAJqoRBbuzNr8jg3yxYEyftpCO
   ncPZRQKhxzJNcR08EAMnH+ixfmG3oKMuYOkFIILcG1dI11r1ay7CDSDGo
   Q==;
IronPort-SDR: mM2eSRvbLt0wnLxp5jpBeheuj508O1r0UcqZdmoHXZzxYBWXOg/RcR4y0mwKVOnnEEkur58pha
 J3UxjcwcwvQsCYLxL+56tVOwhYtrOEBo44isc7FkGkPqAqIVpUD+r4PJ6Wj/JqDGBfvCb74yBe
 0IWf8xaReMQZiwxRE2WaCnKGaEDMDvaixl96a0ro9L5OpWuGGWrIjV2dvQFGQlme9VqsS4+oWm
 1D9XPkrPD1UsNGh+N0uW41BHb9MKkfmgC0PysmA4cvBIPAKfdYMEoh9NlXmiBWeQYmDoSiou9j
 3/Q=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="255796356"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:36:26 +0800
IronPort-SDR: AAktyGr5Dj92aGItWfpY50L0ciB93BNx6IUskCSkhqac6CaHZefYzFzbONlhMOwChq/GY9GMAr
 t/aJZ0qvsjm29+idEvEYqHrek39DFklX4D8uhnZ+JD1gE2+vTPzZmqIBLRl7bDyqIGtRelXdCR
 4/868UOzUGoLKpA+ZsXe/SiCHEpmaRfRgi7fr8nnpfMJfRMS9SLGacJI21Y3rARvD5U8SHon9Z
 i2zRGE+uHIngPimzFrJ1n2Zn6qL9KdAOWn2Xa4xEZ1BWNk6r+CP669VS5WBIJt6mcD8Ql5HPXW
 oKCD9wII5JmYUqz7uzg6UDuE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 18:10:44 -0800
IronPort-SDR: P8mz4sKNOXfIpKb8h8P194X/N7Oaeqr06qSPde+ZymKxBLG91oXcpOAjn4YZnr40gtDXWrHRXN
 bvIzeKzgdNfzuBbWmw8OVuwI4i0kqj+u3sqUUDvuUnDZ+yX12rahpH9KnBgAEYFe/N3D+/L6ka
 QX66VbLpzNUsebw953vQlluu8ePzZNTh3NiZAJIYirdf+dDDpBg1SOnrw1B2Snjm+PlFRZRGLz
 vBgiStmcTGtc0c6rfOch3kcOxxGcWwi379bcJScomLimKHoItwMiugXbS1vxsTOQkxnw7aw5CV
 Cek=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:43 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH V4 5/6] nvmet: use minimized version of blk_rq_append_bio
Date:   Mon,  9 Nov 2020 18:24:04 -0800
Message-Id: <20201110022405.6707-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function blk_rq_append_bio() is a genereric API written for all
types driver (having bounce buffers) and different context (where
request is already having a bio i.e. rq->bio != NULL).

It does mainly three things: calculating the segments, bounce queue and
if req->bio == NULL call blk_rq_bio_prep() or handle low level merge()
case.

The NVMe PCIe and fabrics transports currently does not use queue
bounce mechanism. In order to find this for each request processing
in the passthru blk_rq_append_bio() does extra work in the fast path
for each request.

When I ran I/Os with different block sizes on the passthru controller
I found that we can reuse the req->sg_cnt instead of iterating over the
bvecs to find out nr_segs in blk_rq_append_bio(). This calculation in
blk_rq_append_bio() is a duplication of work given that we have the
value in req->sg_cnt. (correct me here if I'm wrong).

With NVMe passthru request based driver we allocate fresh request each
time, so every call to blk_rq_append_bio() rq->bio will be NULL i.e.
we don't really need the second condition in the blk_rq_append_bio()
and the resulting error condition in the caller of blk_rq_append_bio().

So for NVMeOF passthru driver recalculating the segments, bounce check
and ll_back_merge code is not needed such that we can get away with the
minimal version of the blk_rq_append_bio() which removes the error check
in the fast path along with extra variable in nvmet_passthru_map_sg().

This patch updates the nvmet_passthru_map_sg() such that it does only
appending the bio to the request in the context of the NVMeOF Passthru
driver. Following are perf numbers :-

With current implementation (blk_rq_append_bio()) :-
----------------------------------------------------
+    5.80%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.88%     0.00%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.86%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.17%     0.00%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd

With this patch using blk_rq_bio_prep() :-
----------------------------------------------------
+    3.14%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    3.26%     0.01%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.37%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.18%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.84%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.87%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 1c84dadfb38f..2b24205ee79d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -189,7 +189,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	struct scatterlist *sg;
 	struct bio *bio;
-	int i, ret;
+	int i;
 
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
@@ -206,11 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 		}
 	}
 
-	ret = blk_rq_append_bio(rq, &bio);
-	if (unlikely(ret)) {
-		bio_put(bio);
-		return ret;
-	}
+	blk_rq_bio_prep(rq, bio, req->sg_cnt);
 
 	return 0;
 }
-- 
2.22.1

