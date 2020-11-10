Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE9C2D0A3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBDC20789
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="djLNE3RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgKJCYw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:24:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35875 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgKJCYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604975091; x=1636511091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0ZQSIMWivGujGltCMNIh/G4c4WD0kenneuIGVJ9JRA=;
  b=djLNE3RKchnDGdxJ2WDnAO1IXTHCQ3Pbl2JDyUYTvyMj+lATTSx+HQpD
   UktgcyaX09CS8CHFcwrfgsrlHHJlukjUbVIQPCu2BRTDRJAeCSKwioMQE
   EMiQz9Jhrmontw9qjtadS9Mmrrb0n0iOfln+GZolconTLlND5QcMxkUrC
   le0TmibTq2txqAbqhg5yzIcQB2xnD33dAK8LJNfIzLwydp+HP2C6kaAzD
   aXYVbGmQHVOhfnt31tqeUyGHd+MR6xKycmoZUGpYkrTRwPmPS1WX+0of4
   nljYC5yCEIdXoJRrGOWJo6o7Kh/eyJJZGmsPWsWwA6a60jqd5GGTta3Jx
   g==;
IronPort-SDR: B8qILLFTpEi1k31JtBNaSIPNT9sKAChduV5wG0r/PUwqu4gkpkc0/Gt1jUyyEgTSuCcSiDBJRH
 RW7rDPKlqvvSRn+bamBb5d/IXBpRVoYgR52NCyRfgMLRXES36HJ7sNFPfaCcnRjE0c5oQjQ5cf
 LUMPIFrt1hAnYdTjAn6weMaIAK75Pf0D7wdg0b7KMk6sXuuzLm2GwYTCgPnug4bJSmryMMiYDN
 78iF04GxhlQHj2T1md+CqmZaiez0x9nDC0OmzXDuEtnAaLT9AEUY4dXdSVhmzktJ2TIKL98Ym2
 iV4=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="262243737"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:51 +0800
IronPort-SDR: ApY558ypq+wfbBiQ0Va90BpxyXSUsShHIAfyBoVAQNHBdzaVJ6e1yD3gCS6pucaTGhV3HYgrhb
 QjcqWfvNGdXh56lyJA0+7YCCQduH0KJxGOafmpuPC21Pk0EiHoZo+hTCrPX0MX3ev0o0yf0oya
 +5NWGtqGpC/IRvt4g/mP/HNVpfAv3+1XBav6NkQcYX0Ba45l5LLPUxd3zHJF/5yuMmJ64wQFKO
 NrpPg4bOA3Tu5sYRvMAsgAC3Iawd+p2v+2jqFmGBDM9LOxOJUOQheh9PtIHtbEDbRHYFGmFOqW
 IDEEv3VUkUkQL6Jdu8PftBry
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 18:09:39 -0800
IronPort-SDR: OvIUWGUTzFbd1FDzlHGeb5gRqm8aYl3bmZrGrTGqz6hx/+hVf2zkg8cSM6eS8qoqk2/4Ks9jmt
 qaTcPDHoToubJGXTMF1rjkA9brgdpbIG3eW5TTbQ/xviQteqUxNdVZ1NRTrkjuq1QfLd+GMIns
 J5dcQWtj+kjGzBIBQ6NItfTYykiMyai8cNZset+qcaJ+IKOnUL/krsoS3OCeEw2N4mZR1tybu4
 jynsXksQfgJLeS41HWukAOOK9lVZzR0eMX24w/YgYoFAkyjljmjWwcH6O50f2QlvxKXSyRxKp+
 R0w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:51 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH V4 6/6] nvmet: use inline bio for passthru fast path
Date:   Mon,  9 Nov 2020 18:24:05 -0800
Message-Id: <20201110022405.6707-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In nvmet_passthru_execute_cmd() which is a high frequency function
it uses bio_alloc() which leads to memory allocation from the fs pool
for each I/O.

For NVMeoF nvmet_req we already have inline_bvec allocated as a part of
request allocation that can be used with preallocated bio when we
already know the size of request before bio allocation with bio_alloc(),
which we already do.

Introduce a bio member for the nvmet_req passthru anon union. In the
fast path, check if we can get away with inline bvec and bio from
nvmet_req with bio_init() call before actually allocating from the
bio_alloc().

This will be useful to avoid any new memory allocation under high
memory pressure situation and get rid of any extra work of
allocation (bio_alloc()) vs initialization (bio_init()) when
transfer len is < NVMET_MAX_INLINE_DATA_LEN that user can configure at
compile time.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2f9635273629..e89ec280e91a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -332,6 +332,7 @@ struct nvmet_req {
 			struct work_struct      work;
 		} f;
 		struct {
+			struct bio		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 2b24205ee79d..b9776fc8f08f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -194,14 +194,20 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
 
-	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
-	bio->bi_end_io = bio_put;
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->p.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(req->sg_cnt, BIO_MAX_PAGES));
+		bio->bi_end_io = bio_put;
+	}
 	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			bio_put(bio);
+			if (bio != &req->p.inline_bio)
+				bio_put(bio);
 			return -EINVAL;
 		}
 	}
-- 
2.22.1

