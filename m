Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58875C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B48920885
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i9yIau67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgFSG7i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:59:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63738 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbgFSG7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 02:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592549978; x=1624085978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c5quv4Y1ifoWvWWj5M/q6agTpovuT/S5FDeFDTvuToQ=;
  b=i9yIau67jOmIDak2pzcTPnfPsw/mnlcPacaxXJ0sLCQicw49ZdtmsSSf
   nVkcBWxU7OfyOZP++UkuSN8J64OVINbX8mIx+TpCAcrVKmSkfz2vrteGg
   l34fSdszkikxkOjxqJRpur1LcnocfISE4a8V1ZOa/VXfsqXuYxjtyJtQc
   +oPot4cuD4VyZFMZMXpzoeqUufA4uM3soQKlhKAiUbn+QZ87bwLmNw4+h
   FxKo7NxpyHnuaABpUF2HqAjFdNQi/uNSEQA5b9zCtRQBz67NOSgoRqumR
   3YG7AmDukyDKH3RKI0LWPwwCmoSlCPlKpNgbZ2mVO9qLV8Y/lFGW0FhPQ
   Q==;
IronPort-SDR: +SwrU1bWulLixbvJE++sllooXgVfbVLLB9PtNMmGR9Cr4fNjVY10F/A/u2iU7YAGSsOjnhOQbI
 O0c7pC4lorUIPG04+NvcKlY+e/RpV6OL5PF17aKsAvlmcro9+IbtSQsNa2rBiAfWGzc7amhRj9
 cGz3B62BgSRAVRoCjAocVspagWvOdUOMXWGNYS/H7TbwtW4TgWgggtRl2xv5nlM042jxIHPaUw
 Op7ZFkf3PlNK05g7I/CKYAGb61ldyvxRzUdRejIPgg/ZostYxurI36HWVyP6yfbyj0GAK1I26L
 U9Q=
X-IronPort-AV: E=Sophos;i="5.75,254,1589212800"; 
   d="scan'208";a="144725648"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:59:38 +0800
IronPort-SDR: wWMd5dyl4EWNG/KecyjExV9DjScNNacibfF6p2eEmr/1E8cS178xfUfC/+C88B2oA7xJYuC2Rx
 smcShz/iaGAre3iz19uamp32k94fc28cE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:48:48 -0700
IronPort-SDR: u9Kv7E5QQyn81KViuTNae0YHX8OB5WFteqds4KJ20uGT18MTcG0vVXBqTzpxKdWm3w6lFrM5dR
 EykqgG4lWh6g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Jun 2020 23:59:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Date:   Fri, 19 Jun 2020 15:59:05 +0900
Message-Id: <20200619065905.22228-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
References: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_OP_ZONE_APPEND bios cannot be split so return EIO if we can't fit it
into one IO.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 058c34abe9d1..c720a7e3269a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1609,6 +1609,9 @@ static int __split_and_process_non_flush(struct clone_info *ci)
 
 	len = min_t(sector_t, max_io_len(ci->sector, ti), ci->sector_count);
 
+	if (bio_op(ci->bio) == REQ_OP_ZONE_APPEND && len < ci->sector_count)
+		return -EIO;
+
 	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
 	if (r < 0)
 		return r;
-- 
2.26.2

