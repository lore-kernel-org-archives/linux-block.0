Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0EFC433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 04:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F97611BD
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 04:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhDHELE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 00:11:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31432 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHELD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 00:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617855054; x=1649391054;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nr00DxhfNjFZafuDnoMcpTw9tP2wdULzPaUAUJeNaMM=;
  b=eUvlRF1bHKb3uYjUt/R09xbQAWAA6e/1/CUbWxkI6EqKlTY/DGFxnM/q
   Ly9yWIyPanhhsKsDkL9Hf30iJjodjKMm3I6MBxjhxY+udX0ATfmBmMi1s
   Kn/BxD9qLcoXHY8ybYw71Ytz7JkJxm3fM7JDuPHLVb67bQHoEMYbXnZ8Y
   pDnrgi2g/nnEpwxSFxubojLB79xA/OsOYuklFUGFfD4e/UViIA8RDLbT4
   Av8AmkIFR7wDhpRoCGnOmTESv7OZEHGwt7XE2cF3ny3ZdIHHOsfzJQoGQ
   7rjDFhvVgoNWBESyLhy6MWgKQwCAybqL0JVIeY03AebEfPz5gQXip2zGo
   g==;
IronPort-SDR: Irh+RdgD6IwBgh04HhLNTkPFTx138/Ain6/K6MPsaVPKNIa1aQZOxNwfyWzjECCB+xarD2QkGN
 jUdjw4x5rCgMUwpvhgYrwwfch7XsrUwwHUA6fapAtmBref8f1pINPF5ixJ4Zr9GwqiultD2/u3
 Es+FtuXkhMV++bhLNH3DJzeBhatMFc6SU7Ge+tnjcb2hyxoTyhMwfapzpDMNhOZ355iBTICUjM
 HElnvlj0ejgMNI6cri0DljiddPwxyolamwGyaYe34LCLtv/lZAkMnjB861cOJLHj9NYLyFe+yK
 KAs=
X-IronPort-AV: E=Sophos;i="5.82,205,1613404800"; 
   d="scan'208";a="268455725"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 12:10:40 +0800
IronPort-SDR: bk5VJ1kJCIcYsLYUHLgua2lo6rddXEREHqnpTZnPZPm1XqJrrjQnnkpvc3nstv//WBiE2lWZmS
 DjD1bdQW8yLzAdPaH2dSrg+wVTuAU6FoRyse01ZpU/Zhz9Xgm/0QOHchnffCreT0OTWgfE542p
 8pHqolpwrU+75UHe8ArFeshrx5UhhWuvr7mT/NIw6CP88thnCOcsQlZhZJUpXAADW1eyvZfZ7i
 WA3JMrzWJ7/Y9knO2o5li8rDqDqBBT+EOH9gWZVtctQe6LxwVzOpDklMAk/4C95yq4C0NBp56/
 py3KqXwZHVctxZ7i7G2HN0em
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 20:51:51 -0700
IronPort-SDR: seMvj/AUqLQl7FQNl75FkWEV+rC8m8P6N93pHt/qRygcQH6WIjbzFsCR4RDVzYOX4yMCWL7CHr
 BJP4hPKnx1QmjckIF44NTCBtExFKDNCSE0WaHyvoTsTAvarHK7yoO0j+BjFlu0uxtGVSQyFqwb
 xx45mj1qgds5g+QNc24jwbhd5Cur/lirNmI1lndAxSbu32lh/b7GjPZpn36F1iPExmt9NQbPvN
 3cFTwlhnSyzDRPILo7nF2vUDNAFp9HOwnN9kSr4iT+1Opufp7zN2zlT9WO26kE+IVVayXQyn90
 oGQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Apr 2021 21:10:33 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH blktests] tests/block/014: ignore dd error messages
Date:   Thu,  8 Apr 2021 13:10:31 +0900
Message-Id: <20210408041031.2661133-1-damien.lemoal@wdc.com>
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

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
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

