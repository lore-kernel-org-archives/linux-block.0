Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCAFC2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749EF2244C
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="rNbzBAjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894553AbgJVBCh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:02:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28379 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440469AbgJVBCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 21:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603329044; x=1634865044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=km+hZ7YgGfWW2fRnp+dFWSxQXntiG3Omd9A/wctZwuk=;
  b=rNbzBAjP1dD+rkjLUiWC1UQnKCR8Fupx1hy7gPKXgqX19IgRgdMohBbO
   ntuiHP8KlVTKufG/OJY7vToVwuj7kCCtr+aN1p348jxtCgSX4Uf5RRzTf
   EBq+wHIIpp8l8OZek5SgvE0C52txA7a3d9WqZ7094wnvfNLusZjOoLnpK
   S9ZXjGTGQ5VJn6NS7/FNeppej4tqhBxozuU/IEyvCnIEIWzxODzt5At+g
   /x/XHRPkKoTGEPG5Lg+uAd2+C+QlDbfUknwXsUINmCFOXfpSoc4klWZ7m
   9yk2xSjCBDH7vBGRzEQPiUDhLWBmxBxGTsL0yUzFN/0v+emRBGZn5fIj+
   w==;
IronPort-SDR: kUntPGPr7IwnOocNZkTJhXLK2aMgUENIsR3SHJjAwl7W6N5Bt5FMWcRqPeO3j08mNayR5aWhLJ
 /E+3iVg0/z7+IhU5JYTgemCb2UBkVEJ72QVmpDTUMJW8ofY/3f6tBPv38OHtcxnSmMaIRmiIAw
 LuikPlMnPXagWSZJ93+zIrO0DLjI5Ds0UQ3+bVTfCLYEKp8YqB8B5XUbCmrsQHg5nOdFUf/bS6
 7rk/1mT+ICFzfVcpikXYMOZXn2iXGzA+ipbJahPDaMPdh2SiDuJI9X/a+tqWaCtLJUzhNrFNrL
 G/A=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; 
   d="scan'208";a="254069068"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:10:44 +0800
IronPort-SDR: fLsUBlsafZZ0ZN//NRRWvq3xdmDQ25s/QQXoT1T1FJf+50FWXGEzL/x/l4dgU4wPeCwC1lP+dk
 gX2NPx3/RymhBu3mIL6qH1fQNJwKXZ5CX3b3yQnUAZzxBiSB3vlkAtF0CMb75fcwKq3Ik+LPP+
 tjWQx0Bi2HCQwyuMKRifx9X3lIBUXI56woUDRYdaP7yqaDiPhaXxxAxXqgHTT7lyohP+penCTH
 Mld9Ce4LkxcOSSMnI7ZNBXH2LStKRZ0KYHVu5Al5cBJ+q8ezliINzP/POkoVu6Rk35d2ER+ObA
 6fwHMwGHCXgQLes09C+Qsh7K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 17:49:01 -0700
IronPort-SDR: /8X3iiyhNko2O9XhVlOWJLTnyXHM4dt+AnycPBTdR01RqFcW+xw/z43tcJjS9gZzjXds8a7mFX
 BLwtZf8aXSRCmImTsreXl4a7dI2uFGOywEcyvd5V3LMaGQEM24UvkyFRuk0Q7f/rEc7Ej2ewhm
 SOTds3MEEOBNcbyGY6I2nYjTMCNgKgdZIxfQXzt1iX1urmjaVoUEzSrXikvZQ6JFFHSh1AZKuT
 Z3PTWPPvptkF9N9OjgwWGSNzmpXrc/W3yuBbFuQFO6lYT3pviQK7ic1uRn+r7yxYqktNXuktxI
 JkY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:02:37 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 0/6] nvmet: passthru fixes and improvements
Date:   Wed, 21 Oct 2020 18:02:28 -0700
Message-Id: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch series has several small trivial fixes and few code
optimizations.

Regards,
Chaitanya

Changes from V2:-

1. Remove "nvme-core: annotate nvme_alloc_request()" patch and
   split the nvme_alloc_request() into nvme_alloc_request_qid_any()
   and nvme_alloc_request_qid() with addition of the prep patch for
   the same.
2. Remove the cleanup patches and trim down the series.
3. Remove the code for setting up the op_flags for passthru.  
4. Rebase and retest on the nvme-5.10.

Changes from V1:-

1. Remove the sg_cnt check and nvmet_passthru_sg_map() annotation.
2. Add annotations and performance numbers for newly added patch #1.
3. Move ctrl refcount and module refcount into nvme_dev_open() and
   nvme_dev_release(). Add prepration patch for the same.
4. Add reviewed-by tags.

Chaitanya Kulkarni (6):
  nvme-core: add a helper to init req from nvme cmd
  nvme-core: split nvme_alloc_request()
  nvmet: remove op_flags for passthru commands
  block: move blk_rq_bio_prep() to linux/blk-mq.h
  nvmet: use minimized version of blk_rq_append_bio
  nvmet: use inline bio for passthru fast path

 block/blk.h                    | 12 --------
 drivers/nvme/host/core.c       | 56 +++++++++++++++++++++++-----------
 drivers/nvme/host/lightnvm.c   |  5 ++-
 drivers/nvme/host/nvme.h       |  4 +--
 drivers/nvme/host/pci.c        |  6 ++--
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 38 +++++++++++++----------
 include/linux/blk-mq.h         | 12 ++++++++
 8 files changed, 81 insertions(+), 53 deletions(-)

-- 
2.22.1

