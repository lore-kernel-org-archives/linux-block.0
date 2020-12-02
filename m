Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B649DC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E2E20637
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgLBGX6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:23:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45258 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLBGX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890238; x=1638426238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82+/5kJqGP6zI/njb0x75RSCgHH8h3QmrRRPprctKjs=;
  b=GtfmKMq5mCM6EVYauSfxl/2SudGYJY2r6azQ0ebzMgUTTovoo2mw0jDz
   xdvFbabSN8nHmIjyXHGFBfFu/7pu5vZK/EYDtvxQ13ckvpJt3M7OlJqC+
   3ghWU2kU7gMDV+PJrbE4jLY0ohlWkoU5VUv9oUbvbARL54pVdnNChnjCq
   O/S/AiFrRvOmItj//A0unykSZAu8DUwWnB7aazeruzZ8pgQLHQHoWgZTq
   U0U5NFwm8T341BHAiL+GZHYC5uomMUjRTVn4JkqVxFFe93vqmW26BZyNE
   3L/WwzW2ninl8zYGaroTxKMdY7e86kT3salqRfCdLh+9cbqKlTEJEHQLG
   A==;
IronPort-SDR: ZM7h9AecU8IOD28UkbQ4fpL1cFnRjETrqdrS2yljUSQ7XNNSP0XvVWZLbdpqi2AwIza61XlUJH
 LJ2CEAi/M9twMCgSRpyHM80VIavq8/7jdmWkmzhoigIcIze2TkoqKzZNXnvIgKkwS2WcYPuhM7
 Ck26ouQc/YDxhpgfMT5GKt1cQy3I/gEhG/VglqThLBiVkAMKc1ZckYinRVlUFnar+B3WQ5QuDL
 v/8BYOt956Ld3UgY61S+87KFlrSdNne19J2dDhlAwv4r7vC2jjfy9UG5jpGAhaSJXb1U5YxFja
 2PE=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="154060448"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:22:52 +0800
IronPort-SDR: cwD9WDsh7jnEw7VG4K0SqcZ0hEko0uIECUbdhUX5tqpZ0PbV/dUxBOotCowxM3lNJCE582WT3s
 kTCkH7MttpGjL2KUHVc5KR9pcxAG2Vtr4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:08:27 -0800
IronPort-SDR: FNXPoB4WvPAm0gJxkZMp4eSWXqfhXKyjMr67/9mErB6XiLHz3b0Vx13uYOkiOCzfVzrFFyfv2F
 OVk0pD3ek5Fw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:22:52 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 1/9] block: allow bvec for zone append get pages
Date:   Tue,  1 Dec 2020 22:22:19 -0800
Message-Id: <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the bvec check in the bio_iov_iter_get_pages() for
REQ_OP_ZONE_APPEND so that we can reuse the code and build iter from
bvec.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..54b532bb39f3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1110,8 +1110,6 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	do {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			if (WARN_ON_ONCE(is_bvec))
-				return -EINVAL;
 			ret = __bio_iov_append_get_pages(bio, iter);
 		} else {
 			if (is_bvec)
-- 
2.22.1

