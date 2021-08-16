Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861FFC4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B306140B
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhHPBpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37263 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHPBpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078299; x=1660614299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIH026mlpK847URWOEkIJeSWTxgkrb13VQ8oOv5tb/A=;
  b=mOcYbBEuoSG6UCsGOtS3SP3Wa/cs8SHXPVd58xlcnbBWOJPVtGTMp+2x
   rIy5FVNQBwN828/ugElLTVZlsgwK4ljoR4unY9qcilYvgJQ6QRt5UahbO
   3M/MoC1tAEyUeFTdyAbjgLpGNO54yKimBr5wktloXqRqA6Vsc+EC5EbSP
   n3herJqCV+BQ4u0byUoGWomjbwR2VKWsHditLLrCv/YuGWohteKly0QY6
   T5y+DJFxzD5DazNxUQjEbJta8Qj7crYv3AsOnJAyTMaefjvnQm88t2miB
   8g5plmlapptCDwNxknZpRolZ7+K+SxL6bKzTNJKO9taG6ZqP3q1AY6WD9
   g==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326687"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:44:59 +0800
IronPort-SDR: 40m3UTsUxGuFDIjySRusm3AXvVu/0bxfLQa0CzxzWTI3TzMU4I9YXs66aGROmIwbAbmXIJh0LY
 mbIYWdyAqhFdt7ssCfH0u4mZoH1tbZ50NmNelX7CF12tYLIniA+XGDd0Oddjl2kY6aTJB3RtlJ
 nM+AHEHwjDhL8xOwraUyDZTGTbZpAmxB9JZo7fqNsc2KomCmuh/F2uPTXpKMp2e/NaqPJeE+0Y
 tmlVFveOAUj21UYgoxAivx94Uet1nT2ueyQvs9z5b9kenziONG/prsESR0jV3uIeWtHGH8AIcX
 g7pS5SJF5L+oky+dkTvJnM8H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:26 -0700
IronPort-SDR: 3ZtXiOTr1T2SJ6gkNJioKwtGSZNEz5+rKJB8KsfP0Fi2/iRvklUJCOF2DHTKmZXitwQ87LUJju
 dRQAHMvepKKakpivQ3Av2IIWPw8Oe0zxs5g5jbWNlvHMzWTikCbFc+urXzvO9XXGPq9fC569t2
 zMIgMf/RD3yoHTCRIoexQd5wO8XLnFp94vQjLTHcYDWLekTqaCyMNveJJ/hGU32ghnS3OqH21+
 EUhFdCNTrGWL4vAKh1FWDQ/rTVn5hWydF9LZBVhkGJkNbsFR1ac3Rhd33rACX4HKYWMwkuiWuT
 mWk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:01 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 02/11] libata: fix ata_host_start()
Date:   Mon, 16 Aug 2021 10:44:47 +0900
Message-Id: <20210816014456.2191776-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The loop on entry of ata_host_start() may not initialize host->ops to a
non NULL value. The test on the host_stop field of host->ops must then
be preceded by a check that host->ops is not NULL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b237a718ea0f..d3f7830bda2e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5583,7 +5583,7 @@ int ata_host_start(struct ata_host *host)
 			have_stop = 1;
 	}
 
-	if (host->ops->host_stop)
+	if (host->ops && host->ops->host_stop)
 		have_stop = 1;
 
 	if (have_stop) {
-- 
2.31.1

