Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6DC433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 04:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287A8611C2
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 04:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDHEjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 00:39:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6203 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhDHEja (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 00:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617856760; x=1649392760;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n8bf7kaBYiCkVZc43zesqL+Gg0IfDtQNwQUTgsLJ+xc=;
  b=qc3yDOH7eZdFQz/3pLvZ9TdCGYq3A5A1esgnjFwpbaWoGOJTkILwNysD
   02ZtXY2oKSlsrDSqBAKDLKUJOMIWZH/waOOrcgLZnEkrhboAWPO6N8UhT
   GtUyclWiFlN1Rjd5Im7CmQASgc7ZySvf1idUBCET27dDD8vHIgibX2kwy
   pD4SafKb6YEvp1VsyjzShzNP9MBpEii/EPEbf2pMgj5AI5/jMWk/wbfyh
   A/VhXI9lmm5RjvgCJO/+UJzDfLgjsWc57Xv6nLcBj3qSGi3T03C/9v9lY
   Zaqkau28AFFlhl9YAKRtaSg2jbesXuoFGj2SRrS1ews07tsCwEJqdtm+M
   A==;
IronPort-SDR: GUAocvaTh0bxIezunYGXDRVoabKPKfEO6oAJc/86BCeUx8VgTcAl5EHKh1V/jYF0y31hMV+7Yx
 eknTgLSGzdk2XBvakLo/kAHN8iVUQ+PnPuJ9Il9cr14V5Ka/yxY8GOLiBmiotA+DzxoRrD+Aff
 DSr089xJ19YWdVb3R/xYJw7N5FnJmzTNpWKmTYtUNc2wwMbk0cspw+MnTFqAgQ+ZWGWpuO+BiT
 3ELj4TihX2gZxQTFzvOcEzK/Q2LqAjYQRC825f4hGySueya6PSNt+IA98kMg51hexoVNCTcA7K
 gi0=
X-IronPort-AV: E=Sophos;i="5.82,205,1613404800"; 
   d="scan'208";a="275015102"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 12:39:20 +0800
IronPort-SDR: LRQiyhCtJtnwEo1bkQ2zG6dWp8xvJneZGV9x4t5Z1VYwJ4DR8bJCAhGelztDFZ9DYHH/ovpwQP
 /g+XUEUeukAeZEk6Jp2k8GhjDD4SG1qaBNlmc9fci3svpCy+KQWhHTH0iXFTPhrB8GUS6ISyJX
 oW7vVeL51O+PFIcxVOnFy95CUITOkV4rmhS5BL+lrvgzbD7g8vPHGBm7+6TfnuxzYykx1cW7de
 n9jOYlqwXDhLuUleatgYAGkkfzZ/iWVqpv0sMVuQFmA23vI+/s7Ei1DVXDGGEXNNN29kRRc6rs
 sm5KecltE5bf7IrNx8Q5B09m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 21:20:38 -0700
IronPort-SDR: 3Zw5njXlc8LMNcDPnY07sAZ4sqv3jCLw4YoOMZeco9C3aWpsrpcDgjVxmQSLMiQVuaYGwhRlGu
 2j8BBRQ0HKS/I2QyycF1/8lqV9vcRxqpspUV9e1TCSTS5dKsjDVFDtoAjJCSTkAU+bEtdMy5WD
 Aiah5suuUU2pySpZC7nnYq/RBJ1xk4yLDhkcSKvW5/SVYNgTIEzRNR7Uytc6O9Iof9+BW8bECT
 YWf55bmtTNP6x90BsAltYxYAAbEqppkI6R5gkxbJbnzQuWeydtKm+JVwqO5QKd0QkpgyGZNt2i
 pEU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Apr 2021 21:39:19 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH blktests v2] tests/block/014: ignore dd error messages
Date:   Thu,  8 Apr 2021 13:39:18 +0900
Message-Id: <20210408043918.4265-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kernel commit de3510e52b0a ("null_blk: fix command timeout
completion handling") fixed null_blk driver to report ETIMEDOUT errors
for IO operations failed with a timeout. This change causes the dd call
in block/014 case to print the following error message:

dd: error reading '/dev/nullb0': Connection timed out

The presence of this message result in a failure of the test case even
without a kernel crash or hang, which is what the block/014 case is
testing. Avoid this failure by ignoring dd error messages using a
redirection of dd stderr to /dev/null.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---

Changes from v1:
* Add Reported-by tag

 tests/block/014 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/014 b/tests/block/014
index 370fc3d..04c34fa 100755
--- a/tests/block/014
+++ b/tests/block/014
@@ -34,7 +34,7 @@ test() {
 		# crash or hang.
 		for ((i = 0; i < 100; i++)); do
 			dd if=/dev/nullb0 of=/dev/null bs=4K count=4 \
-				iflag=direct status=none &
+				iflag=direct status=none > /dev/null 2>&1 &
 		done
 		wait
 	done
-- 
2.30.2

