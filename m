Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C867BC46467
	for <linux-block@archiver.kernel.org>; Sat, 26 Nov 2022 02:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKZCz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Nov 2022 21:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiKZCzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 21:55:55 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5140448
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 18:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669431355; x=1700967355;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=V13jW8+5PMPq0JeCmUcIq6AwfK+ulw58b3YjuwFCrIo=;
  b=DRtymJH2JcounOzLDu2oQoISKhEl5qSOneb+YzMbM8o4gdvRqvaHcdp4
   kVJY23aNGNUPXmeNoZXBmjV+jcFZoJC9KEYUrLrDL5NGzzWsfvTQYahi0
   /TE/JN7TffOo9lXAXl698YgDLK44BkcRvISgmGip92qvU35w61c1ola1y
   y9QaC7gHH6KdhUGoQk6LYogFvhJO8ETsN/klZpYt6gOaEmj1RcESv1Dva
   jUghn7Bj/tWlI4hHZSeD8+xTzob5Nbe4feeGuZFsPdpR8QMF8POY0NrlV
   eufKai3usQkf2N3rBxMLtKh78v16VsGDqP/No7LK7fWxuXsvqbI/eGmBe
   g==;
X-IronPort-AV: E=Sophos;i="5.96,194,1665417600"; 
   d="scan'208";a="222364193"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2022 10:55:54 +0800
IronPort-SDR: n2LNmLIzuQ9iFbvj2dv2rgveOJrj2fFAGDZ/i1d5F0YhHK3nBT10jTWPCtnVIc0b+QPJo8+twL
 vis78dEfnT4aURtcvZ3nSzjqwp+Yl8dvwXhNdz9hvcddivFKfReLShTiAPwte0o6hV332rZ7Gs
 KJAxlm+fV2HgTGFnib0bMOP96jMCWdWgeVgTrjU5H194NzWQDuD03B2U70vZbjmhZVRMe0vNpe
 1ccB8DLRNvbLWhT7xZBFNMGcqVcJjL7KbfLi0KIOLuQCXH9zfmDIFOzH7rp4NHbaQ9B5fs3dXj
 Vrw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 18:14:39 -0800
IronPort-SDR: 7JxBpRTV5TgJvsGVT8aOXHJtc1i/9TQ8M5cv7fU8zKJkYRr4pJugaiK8VppeSmdI/j8EIY+Ay6
 +UfVq8LA0q/h5kVbev9AcKqghUGuWuAfnLPo+sFJkS2eWlUJmcpg4daP5qoNQonIcDx8+ZaNi3
 PhsGQp5sifBx8OOJO1qlEl8axsd2ON+XZALFHQFDkjQqVdgabfdpH+cUVSJXyi0G4xXUHGXFyD
 KZS3NmxsEL8Ug6JtVSkUxuyPYk2pX91CQ3VZIhiQokGRiRusWKxS0GrbCNKQ7y0ytCH9dXmhJ3
 8zI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 18:55:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NJxF63lwcz1RvTp
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 18:55:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1669431354; x=1672023355; bh=V13jW8+5PMPq0JeCmU
        cIq6AwfK+ulw58b3YjuwFCrIo=; b=qfXM58F0kIhp3eLPu3f5oHck6sWqd7Wp8T
        Xo/q54dmYKq8hHkGxAyRxCP4vB5IWuRHw2U0M569gT5aYF1zzGCPE7Tlf3AWyqqb
        5d5jliPg9aepGTtgP2zY/XBYTj2VkzlmrTcTNdC+mM/eLjVPOHic7s8yGKCna6Dt
        aGc8QUhPNhCu+5RWuPX79sbXpZXdGT0YFEnygDCG0bbAPQ3IobDD6XmQkiRxBwAK
        SNc8Vxl+5KtYz2bVapXbke37pb3L9YA56NPjKwLoMzYAsTEDLLWKZJvphIHTZB7n
        qfqc1cdGRlqpMvKTNqKfvSeSzWHtvES+k0HmvNdjz1GewECQh+QA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4h6vjsNOls8X for <linux-block@vger.kernel.org>;
        Fri, 25 Nov 2022 18:55:54 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NJxF55lJxz1RvLy;
        Fri, 25 Nov 2022 18:55:53 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fops: Do not set REQ_SYNC for async IOs
Date:   Sat, 26 Nov 2022 11:55:50 +0900
Message-Id: <20221126025550.967914-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Taking a blktrace of a simple fio run on a block device file using
libaio and iodepth > 1 reveals that asynchronous writes are executed as
sync writes, that is, REQ_SYNC is set for the write BIOs.

Fix this by modifying dio_bio_write_op() to set REQ_SYNC only for IOs
that are indeed synchronous ones and set REQ_IDLE only for asynchronous
IOs.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/fops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..5a4f57726828 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -34,7 +34,12 @@ static int blkdev_get_block(struct inode *inode, secto=
r_t iblock,
=20
 static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 {
-	blk_opf_t opf =3D REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
+	blk_opf_t opf =3D REQ_OP_WRITE;
+
+	if (is_sync_kiocb(iocb))
+		opf |=3D REQ_SYNC;
+	else
+		opf |=3D REQ_IDLE;
=20
 	/* avoid the need for a I/O completion work item */
 	if (iocb_is_dsync(iocb))
--=20
2.38.1

