Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D2FC001DB
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjHHR7n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjHHR7Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E1F2CC6E
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891656258C
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 13:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DC9C433C9;
        Tue,  8 Aug 2023 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691503026;
        bh=w7Y2xPFH5gXXKwUA3NGRtJVk+zfqAzoQ45e4ECd0wI4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TbDnCOO8kWotQJLhZBSr6EEqhcMjQP5DTpTvuqY5P1rN+eypJmxGBN6TYO2DwkydL
         X6gTKrFgVT+v8/tZrg/mszS0Ry/ZP/V07C4quAiltFhdkynFDvqxywl9GFlzXt0xjY
         rlpQpD3IpfgTQelMRSnlCXdfjFGvoTwfgerr56nUDys/LnwRR/jGKKycoiiNYiEsEG
         p+49G2Rt1e90rHRCO5hNPxNLcEkcpTFCnoaZh1DkMfQV/+2S2CVbyWP8Q0AearXU3i
         6CC19//+i9S+2P1ZoT2CwhaQKUnJKXnkkngBZ9eZ5SANQG8diuU5TiGV2AYJNxwTHN
         Ds1QKmSDAijUw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: Improve efi partition debug messages
Date:   Tue,  8 Aug 2023 22:57:01 +0900
Message-ID: <20230808135702.628588-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808135702.628588-1-dlemoal@kernel.org>
References: <20230808135702.628588-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the missing definition of pr_fmt to prefix the debug messages from
partitions/efi.c with "partition: efi: ".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/partitions/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..33fe70282e38 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -90,6 +90,9 @@
 #include "check.h"
 #include "efi.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "partition: efi: " fmt
+
 /* This allows a kernel command line option 'gpt' to override
  * the test for invalid PMBR.  Not __initdata because reloading
  * the partition tables happens after init too.
-- 
2.41.0

