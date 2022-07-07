Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0879CCA479
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 20:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiGGUyP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiGGUyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 16:54:13 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA1E2ED5F
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 13:54:11 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220707205408usoutp02197838f108a6656b6d13c208825581f9~-p2b5KZyK0814008140usoutp02Y;
        Thu,  7 Jul 2022 20:54:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220707205408usoutp02197838f108a6656b6d13c208825581f9~-p2b5KZyK0814008140usoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657227248;
        bh=eD5Y2u9QU7lEZR6xSuM2Z/FqgDvzezZ0oxwiHvcMWtk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iJk8tMQFotud/F8GJ1evM+wxGWHl7APNVrZdiuU7f0/OB93QX3L+kGesZ7vZ27MK/
         I+8EK944EiNgnWJI1SjMFc77qsshgTQS9gAoWpX6ju8ZUddrxmktrk3YFckQMzCVts
         wdMLyUWVm77pMj7hQkNgV7f7dtc3+NSzvfbG5QXc=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220707205408uscas1p29b5fe2b2c078760de09c6518e2383b5e~-p2byOQU_0168401684uscas1p2M;
        Thu,  7 Jul 2022 20:54:08 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 86.C8.09642.0F747C26; Thu, 
        7 Jul 2022 16:54:08 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220707205408uscas1p2a6d8869ffc10faf23bc9728792e7e426~-p2bgvM3w0203702037uscas1p2L;
        Thu,  7 Jul 2022 20:54:08 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-fe-62c747f0d9fc
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id EF.BC.52349.FE747C26; Thu, 
        7 Jul 2022 16:54:08 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 7 Jul 2022 13:54:06 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
        7 Jul 2022 13:54:06 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH 1/2] null_blk: add module parameters for 4 options
Thread-Topic: [PATCH 1/2] null_blk: add module parameters for 4 options
Thread-Index: AQHYkkOyvej/KiD+9EuRcuvImqkv2w==
Date:   Thu, 7 Jul 2022 20:54:06 +0000
Message-ID: <20220707205401.81664-2-vincent.fu@samsung.com>
In-Reply-To: <20220707205401.81664-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djX87of3I8nGWw4I2Gx+m4/m8XeW9oO
        TB6Xz5Z6fN4kF8AUxWWTkpqTWZZapG+XwJWx/nNawV7Ziln9T5kaGHdKdjFyckgImEgsvLyH
        vYuRi0NIYCWjxOHDS9kgnFYmiZb109hhqu5f64NKrGWUuN7zgQnC+cgo8fX9HRYIZymjxOXD
        yxm7GDk42AQ0Jd7uLwDpFhFIkzhxZQXYJGaBCInmBfOYQWxhASeJvZtXsYKUiwi4Syw7ZAFh
        6kn8PqMIUsEioCLRObWFBcTmFbCWWHxqItgUTgEbiYanvxhBbEYBMYnvp9YwQUwXl7j1ZD4T
        xM2CEotm72GGsMUk/u16yAZhK0rc//4S6ho9iRtTp7BB2NoSyxa+ZobYJShxcuYTFoh6SYmD
        K26AfSgh0Mkhca75DtQgF4mrHRuhiqQlrl6fygxR1M4oMXfjF6jEBGBoPZGCsK0l/nVeg9rM
        J/H31yPGCYzKs5AcPgvJUbOQHDULyVELGFlWMYqXFhfnpqcWG+WllusVJ+YWl+al6yXn525i
        BCaM0/8O5+9gvH7ro94hRiYOxkOMEhzMSiK88crHk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        LsvckCgkkJ5YkpqdmlqQWgSTZeLglGpg0tdSf/uXv2f+1vKiw/pmbE+uXL/u+2N+iqWGVtu6
        1MmvTE/7XpJyuP+/pWBKl+wLr+ZSdc+r+emrLt+4smLCFrH+y1NW3iro4FPMYL9SUuyvzGrE
        NOv3eaP9S5SrlpS5nl+nznl3tunz2b8uc/3yyP63XODJOZdK5tfrVx1wE1DSXNOpsjfw0D8Z
        oXVfvtmqW37Y9O2qo19k9b8E3YcTHudc2SYQNfPH1a7ekkPTLeUWTV88N5JbZV/LKY5TFqoF
        TtMWzzv44MyS04KTn/rZGXv/Pca8SU+j5WlCyKt/5m+sl5toXHX6uWsS3/HqNeJ5P2W+B/6v
        C6q66HBbszWLX+H8GZ0k07UqN09fWaf2IEmJpTgj0VCLuag4EQATWCabhwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LJbGCapPvB/XiSwYs1bBar7/azWey9pe3A
        5HH5bKnH501yAUxRXDYpqTmZZalF+nYJXBnrP6cV7JWtmNX/lKmBcadkFyMnh4SAicT9a31s
        XYxcHEICqxklXv76BuV8ZJTouTGZEaRKSGApo8TeH1VdjBwcbAKaEm/3F4CERQTSJE5cWcEO
        YjMLREg0L5jHDGILCzhJ7N28ihWkXETAXWLZIQsIU0/i9xlFkAoWARWJzqktLCA2r4C1xOJT
        E9khFllLHLs6lQnE5hSwkWh4+gvsAEYBMYnvp9YwQWwSl7j1ZD4TxPkCEkv2nGeGsEUlXj7+
        xwphK0rc//4S6jI9iRtTp7BB2NoSyxa+ZobYKyhxcuYTFoh6SYmDK26wTGAUn4VkxSwk7bOQ
        tM9C0r6AkWUVo3hpcXFuekWxYV5quV5xYm5xaV66XnJ+7iZGYDyd/nc4cgfj0Vsf9Q4xMnEw
        HmKU4GBWEuGNVz6eJMSbklhZlVqUH19UmpNafIhRmoNFSZxXyHVivJBAemJJanZqakFqEUyW
        iYNTqoGJ//mMm0t2NL+VN/h9m+Hkopnh0yx2yc5k+Vmgmezy8Ddr1mnnws1WG2M0WBbE8M/e
        edT9+qNS90Nu0psuut3NlfYt8HbadyF+x919Us+eWxc53Cm+/zS7623MPsGupWyyl+x/G18T
        7fwz+bQRt8jq6zMWNQoL3pnXw2n49J2WZfmj7M/aUTUPXy7ZaZv1pzhq76KAxWot+6fK6+0+
        z738WIdoZOblgiPK77K37Kpax3b92/LsSTLrNHNf8f3OKmKby9/Bm5p4cJ2r+ztF7lcJM9Ma
        Dm3Tqz3is0UraEFJkdmlpohzRyNfS4v/1y1QzpVV3BJyIJRPJEjmxS+rMhnFqgdlT0w05SpN
        T3MtTWFSYinOSDTUYi4qTgQAzZQ31hYDAAA=
X-CMS-MailID: 20220707205408uscas1p2a6d8869ffc10faf23bc9728792e7e426
CMS-TYPE: 301P
X-CMS-RootMailID: 20220707205408uscas1p2a6d8869ffc10faf23bc9728792e7e426
References: <20220707205401.81664-1-vincent.fu@samsung.com>
        <CGME20220707205408uscas1p2a6d8869ffc10faf23bc9728792e7e426@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add as module parameters these options:

memory_backed
discard
mbps
cache_size

Previously these could only be set via configfs.

Still missing is bad_blocks

Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 Documentation/block/null_blk.rst | 22 ++++++++++++++++++++++
 drivers/block/null_blk/main.c    | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_bl=
k.rst
index edbbab2f1..cf020e4da 100644
--- a/Documentation/block/null_blk.rst
+++ b/Documentation/block/null_blk.rst
@@ -72,6 +72,28 @@ submit_queues=3D[1..nr_cpus]: Default: 1
 hw_queue_depth=3D[0..qdepth]: Default: 64
   The hardware queue depth of the device.
=20
+memory_backed=3D[0/1]: Default: 0
+  Whether or not to use a memory buffer to respond to IO requests
+
+  =3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  0  Transfer no data in response to IO requests
+  1  Use a memory buffer to respond to IO requests
+  =3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+discard=3D[0/1]: Default: 0
+  Support discard operations (requires memory-backed null_blk device).
+
+  =3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  0  Do not support discard operations
+  1  Enable support for discard operations
+  =3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+cache_size=3D[Size in MB]: Default: 0
+  Cache size in MB for memory-backed device.
+
+mbps=3D[Maximum bandwidth in MB/s]: Default: 0 (no limit)
+  Bandwidth limit for device performance.
+
 Multi-queue specific parameters
 -------------------------------
=20
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3778df206..8f821fa94 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -201,6 +201,22 @@ static bool g_use_per_node_hctx;
 module_param_named(use_per_node_hctx, g_use_per_node_hctx, bool, 0444);
 MODULE_PARM_DESC(use_per_node_hctx, "Use per-node allocation for hardware =
context queues. Default: false");
=20
+static bool g_memory_backed;
+module_param_named(memory_backed, g_memory_backed, bool, 0444);
+MODULE_PARM_DESC(memory_backed, "Create a memory-backed block device. Defa=
ult: false");
+
+static bool g_discard;
+module_param_named(discard, g_discard, bool, 0444);
+MODULE_PARM_DESC(discard, "Support discard operations (requires memory-bac=
ked null_blk device). Default: false");
+
+static unsigned long g_cache_size;
+module_param_named(cache_size, g_cache_size, ulong, 0444);
+MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Defaul=
t: 0 (none)");
+
+static unsigned int g_mbps;
+module_param_named(mbps, g_mbps, uint, 0444);
+MODULE_PARM_DESC(mbps, "Limit maximum bandwidth (in MiB/s). Default: 0 (no=
 limit)");
+
 static bool g_zoned;
 module_param_named(zoned, g_zoned, bool, S_IRUGO);
 MODULE_PARM_DESC(zoned, "Make device as a host-managed zoned block device.=
 Default: false");
@@ -650,6 +666,10 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->irqmode =3D g_irqmode;
 	dev->hw_queue_depth =3D g_hw_queue_depth;
 	dev->blocking =3D g_blocking;
+	dev->memory_backed =3D g_memory_backed;
+	dev->discard =3D g_discard;
+	dev->cache_size =3D g_cache_size;
+	dev->mbps =3D g_mbps;
 	dev->use_per_node_hctx =3D g_use_per_node_hctx;
 	dev->zoned =3D g_zoned;
 	dev->zone_size =3D g_zone_size;
--=20
2.25.1
