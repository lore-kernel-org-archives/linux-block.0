Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78984C4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4036E20791
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgLOGEZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:04:25 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8974 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgLOGEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 01:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608012262; x=1639548262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfKvG3DF5+e1xbSx0w/6Rpv8SlZKd4h4pbL+RDgW3Js=;
  b=EDTHmm3uLCunkgL76Kd8yIXCU2pIMn5YHpDfIpYoN9bGyTmerhElCYYZ
   2NNbRl5TTsF++jurC0Kvgz8H2rC6bmuW3kaOfVqEhRciKV7XAtS4XaKAn
   yJmCQC7+NCETitlRDkISgt0pa9nV57R+T74br5CtaL1ur/x/V6BmgCHVY
   W2IWz6MGoBQ5X3sDX+Zge0qtWG3TTx0jIjpy7E1JD9FiP2Ilxy/A40/fF
   ixAt6WPO5S9UZ7l5Sb41AGHW3vvkU2i0tnFx8mu09ZT6uq8Vp89/THO/f
   7jm2kkGwjGQvPWqBNn42LLCnB4WoGJXEB4q2G53Wwd0cWp5WsGHZk1Zjj
   g==;
IronPort-SDR: UC8drgPgtRDpWzRw2Gj341rQp3c3IjXCtehOVIkqe5qTk2NPJkG7oLisp2uctc7krXY0qBjHI/
 o+Kh0MYGLiN03S7cr+ChSmdqyacRN02KzVhB8I/a1NWzvUXtJ8Do9TiFFm71HMdcwPv469V0Dv
 blHWCh/H1Kt5QA4l8yGgyMSdzMVubkrJ1CdaLVhu4POCMwi0Mdxu52UcRciik1rVKYRKFTy7bc
 gtSV6Le+VAStGioHp/rW2iqjN9NroNkE5U+f96rztkLSkfcmK18ndGtcGhAnrgEEuJwBnt7rEt
 3G4=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="156369714"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:03:15 +0800
IronPort-SDR: DJKxgqdkXds7krytASShkBaPRZXFHYS8KKsnnBLs5KL7q1t5YpkQ+qsPJsMKrRCtCpR5zyImF8
 QlGOTlP644wUkGHzZMmIr4bpkmeOJkrYOXuE8hAoRfPMUc+g1ZwBwo/MyqHOoVdT82wFoxlBy9
 ug+qQjus2jmDaTpNXW9e/zjNWIKN33mXg5UO6OWYaTANj750XlEGdekAqsPzW3ICB9h8iqMH4D
 9sNOWBX6XXObC3uiSaz1IuLZmUAQG02xQ4f4zfSa1mnmWCIaTiWrAd2Ws5Hnan0OVfwWicK+ZK
 KfCHJ5NBz2J9xUF3oW/qvNKh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:46:56 -0800
IronPort-SDR: l4I1If61PouEmATpRv5WNuoGaMD2g1GNIOgWhfrbcgIFMfd5lbAACpFAo46tzcnjDoGUhr09aH
 fkBrk7r8r6WtLlquL5MKTmLG4tScimfUigVvRw3PdsrlDnoxRvbXTZVxXe1aOhMTe9ut5UwS5h
 UHiygAOoe99Nwk3sqZWRakfnKdD665u6pP9pf9xXiRueL5tCIEio1al9jjNG+hHJBq1uqzNKc0
 8kMqGiqI9mE0T8U/15IL8Q5/KNKQKA0ATwQ6UTPEwhmbeMTYKIr1cek4wviQMubw8RQYLV/egq
 w08=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:03:14 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V7 1/6] block: export bio_add_hw_pages()
Date:   Mon, 14 Dec 2020 22:03:00 -0800
Message-Id: <20201215060305.28141-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To implement the NVMe Zone Append command on the NVMeOF target side for
generic Zoned Block Devices with NVMe Zoned Namespaces interface, we
need to build the bios with hardware limitations, i.e. we use
bio_add_hw_page() with queue_max_zone_append_sectors() instead of
bio_add_page().

Without this API being exported NVMeOF target will require to use
bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in
extra work which is inefficient.

Export the API so that NVMeOF ZBD over ZNS backend can use it to build
Zone Append bios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c            | 1 +
 block/blk.h            | 4 ----
 include/linux/blkdev.h | 4 ++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..eafd97c6c7fd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	bio->bi_iter.bi_size += len;
 	return len;
 }
+EXPORT_SYMBOL(bio_add_hw_page);
 
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
diff --git a/block/blk.h b/block/blk.h
index e05507a8d1e3..1fdb8d5d8590 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -428,8 +428,4 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 #endif
 }
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2e..2bdaa7cacfa3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2023,4 +2023,8 @@ int fsync_bdev(struct block_device *bdev);
 struct super_block *freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.22.1

