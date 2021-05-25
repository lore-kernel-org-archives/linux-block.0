Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3D9C4707F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C93611BE
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhEYV0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36430 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhEYV0k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977910; x=1653513910;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NfTdCDjWprAigWJYaD23uduh85Vk9Qoh0V7PA2PEAio=;
  b=WKTCEti2pnkhVzEV4uRfHHtZfudAWDK3PTkaGUK3AAZM38oKDSLG3E1l
   U/oPdIxleGVb2CpV6Fl8ONZszQ+NlErkAuL81PNao9voUWX3xflBDGkUx
   GviZWr9y1i4fQ6M/4i2CRs0ZvWx6dtv1tKXmiCUBzfgiGUd5LODg+fmpA
   s/txWRwWCdqXPUV95MT3k7h3sIum4fYwCBXvKKju5TVUw6gHx1AdGVZfK
   HRzOyWapgz2GEPgWkeIN0sAeE8IlsoFT8jp+AqwVSdzNVBBPi30w3Rb9o
   GJoKJWDc2mv1N1X28uYr51KIpqNKJqXAk5ISfXxb0W1rbLt/s25AALvKc
   Q==;
IronPort-SDR: 3DBhMCjvL9RCWCtu9SF1W/lT5WOAVCnCRn1B+HXQJl9k4D6rmWd3i6TIIEErTr7I5aLJFbOlkR
 4PGJUh1+6qWRiv+GdGbpap12cJhSslW54t5jCi/eUy5vPrRlJrPRxM6knMVfsrEH8sAfTXogLn
 uzLTlwC38/2MZ0cNmTPN+mbyrnIk0YXZpcXVcV883WjGHJ3i4DKNiKJzBbRSvHNaMTPfB/jKsc
 RlRAxDrunIm2YItxdE2j5+4KAmK+6OoAPV+PIRDycu9qZYeXjdQv87hKC0q86H2hkYB7tOGMhr
 bXU=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717525"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:10 +0800
IronPort-SDR: nS9Tf5/29Hv+dRkfS8czRYCSXuxu3vCP96S+1WrHVE8S3tFoDROAk7GEH2SLDRcq+n583Px2mf
 0zwNDQXEZRXuWwI3drqQDMuhfZtbCLUKtJWQwzvtbFCrpRvDRabv+rB4VkMk2V2n9ceu/KTAUC
 ylTlAUAVCwY1x5d/zpuFE3wYCPPl5nDbyTmxnO2THDewD4NNyy8KqoBOcu9tuXsPsKY5C75L/V
 44CL8gHEZjQ9kJPpvzE5BjQ0YJdWjClV5kLAjSOWe1p5ZwfOBGLYhE9nAZVWBLODTFFk/mH3+j
 XoEzVJgoAPEGUt5T6Vfe7DPo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:37 -0700
IronPort-SDR: 9MGmzkS4eqpzox3GSh+m6FwTZ2A8jKGfs3LK10mBr04kxWvv+f5pPf+dITjf+/Rgr/JwS4Y91l
 /qfqaRsYRFK/hntKveHxn9+PNamC60e0DQFaBnC4AJvxCnCVJHvk0rc8K0JrNNogBqlGlaDdse
 vjnA+wsKHtk2X2cyt7se75j0b6h2J4rz05kaMfbrCaBoDnKg6KD59UIK963ti52Y3PY0qjkPRn
 uSvw1Sx6Yg/+cwXjPx1w8baliE444Y83EBleDFznQqcptUe+kG38/AEBTdCAjatLi0Q6g7Jc1o
 f3Y=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:10 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 05/11] dm: cleanup device_area_is_invalid()
Date:   Wed, 26 May 2021 06:24:55 +0900
Message-Id: <20210525212501.226888-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In device_area_is_invalid(), use bdev_is_zoned() instead of open
coding the test on the zoned model returned by bdev_zoned_model().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..21fd9cd4da32 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -249,7 +249,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	 * If the target is mapped to zoned block device(s), check
 	 * that the zones are not partially mapped.
 	 */
-	if (bdev_zoned_model(bdev) != BLK_ZONED_NONE) {
+	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
 		if (start & (zone_sectors - 1)) {
-- 
2.31.1

