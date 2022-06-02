Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6263FC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 07:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiFBHwF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 03:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiFBHwE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 03:52:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9920E6F3
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654156323; x=1685692323;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7egVhZPa83J3B+QTyyoC+gBKb8QbsDr2d6gFsP851z0=;
  b=et19LA1RIpBp+Q4elLoP7Rejw+I9EMifAW+k69xTlmqebLyCYyNUZBjD
   GznQPUVqePG82NfEHwx+PmwP+d/ybPt+yur9Sa77yWxsoe010t3nhiub4
   iP9udR/xCNxLdlKbozw9MUE7NdbLKzmYwXdG14Qm1KaoLWrYeCFokvTc6
   V/JIYdj0O5jiob4AECsP5tk8+M3qEw1vem2den/ITSD9g4HxcztfyPFoo
   vCZ11EfsDJfBKVBFhtiaS+Qo6lJYksR9BJW00M1e11WXU1b35sf4R1C5J
   uk3OXQe7d6/XLABUt2jsKC4BcQ3bMrTWbNgdB8FEjKFf7VWaNEHiIBmPd
   A==;
X-IronPort-AV: E=Sophos;i="5.91,270,1647273600"; 
   d="scan'208";a="200824817"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 15:52:02 +0800
IronPort-SDR: pU8uDXK7TpEG/cZZribeArd7VmcxxtdE3P5Fl2EYGtXxkUY125qhCSnm5z9Q/BdYSSE+eYRqrI
 +C0HkMT+xw7GcrMg2G3d8eInopKizxicxsqKz1bGt1PaWUihDW04mDxDOq2WpvZ3TLh1lhJJ4/
 Z6y6DbxyUJD8RBO4tw2cltl+mU852dUcIl0JBpTLns/OR0bUYNAT9+N3EYBeYkfOhrYJ1gzDC1
 aznobapYahTngKQ25i4qWhpV4Aj04n2duwyRJ4xTJVavYPNR7og4ffXLUlo1uMqncGeI7p09l5
 UZjvmbOGPrPuSGRiwsadzeoB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 00:11:11 -0700
IronPort-SDR: 3gsmSbiiSNgWQ2IysSVzFGUZxJud29xBMC7TrYvx0U+WgV9SsreGIRyezHS8q1Xc453YKqxwH6
 MScn9stcaCjJV+1aRE7U+ncUTDrhb2A6WcBLMY35XBdH6/c93lAKyRlbik2igk5k1RjnxP2PtX
 8JmDUSXl5lM9A0lNQzoFTlwz54/fshxjNWoe1F++0pY+MmTYC4ZzCM6d4nPZy4l7s7x9yLK8F2
 dshh00kRpcZBExtEgptziiGJ6eU0on4qQZqUZEvPek1FyhZBd7RNToprZmz476431gF+FAJXuN
 bgU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 00:52:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDJBT4K1gz1Rwrw
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 00:52:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1654156321;
         x=1656748322; bh=7egVhZPa83J3B+QTyyoC+gBKb8QbsDr2d6gFsP851z0=; b=
        IOK5dNhoTWk4Xqjnfg4CLvxqLxGZb6ZB76iPGRi4XPFGyRItiVNH8R5k7tiN0znw
        WOnN1Saz1vr2Di7B4KQnP6r+PyYt6MqaBNw0ErWw3l/rycNA2nEl0LXTPG5Du/Yp
        vGmgZhGrDSGZR3n0IPKFlJJv3Z9SmJeiRopl4BYnWNyqVcahF9C0HMdn5fLsP2a4
        ODNyNtBnGI4DpDTBvrJiYVqc8m0OribdT5rszqnr1ajsMhnUhN1SGdwfGXIvVMg7
        RoDdBLdnReAS45D83Y9PMvH8ldxPxEak/zCx7EQbghv6tn/23UpPnT+BOuCXoNFg
        6BntXl4HQ8YMzioiw6F6Lw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jHO7C3YV-lcO for <linux-block@vger.kernel.org>;
        Thu,  2 Jun 2022 00:52:01 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDJBS5M3zz1SHwl;
        Thu,  2 Jun 2022 00:52:00 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: remove useless BUG_ON() in blk_mq_put_tag()
Date:   Thu,  2 Jun 2022 16:51:59 +0900
Message-Id: <20220602075159.1273366-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the if condition in blk_mq_put_tag() checks that the tag to put is
not a reserved one, the BUG_ON() check in the else branch checking if
the tag is indeed a reserved one is useless. Remove it.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/blk-mq-tag.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 68ac23d0b640..2dcd738c6952 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -228,7 +228,6 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct =
blk_mq_ctx *ctx,
 		BUG_ON(real_tag >=3D tags->nr_tags);
 		sbitmap_queue_clear(&tags->bitmap_tags, real_tag, ctx->cpu);
 	} else {
-		BUG_ON(tag >=3D tags->nr_reserved_tags);
 		sbitmap_queue_clear(&tags->breserved_tags, tag, ctx->cpu);
 	}
 }
--=20
2.36.1

