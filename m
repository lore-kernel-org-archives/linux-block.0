Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA88C433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 17:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiGHRuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiGHRt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 13:49:59 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD9F1EC43
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 10:49:57 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220708174952usoutp02d1c277f93b24aac4af16dc50be3b4053~-6_1B6n2d0359003590usoutp02Z;
        Fri,  8 Jul 2022 17:49:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220708174952usoutp02d1c277f93b24aac4af16dc50be3b4053~-6_1B6n2d0359003590usoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657302592;
        bh=a5Gp/vzRTzap+01UNkdGZ1LwUrL5JdupGvAvuYasbRs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Tq1sU/HVgUM9pbyqYFHfnPg5fNtvIldCKfG/qMecE+fM2OQCEO4ggEKizHaQ+gO53
         Ux0uyggOudYYyQzvLrHW25LfOREpXx+G03o36GXHAnhRPA+ZFc/If73cVF9JlO0ODt
         mvPWBs00DHe5LoKRUr/IbTOAbU5JlKd9FB79XeHU=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220708174952uscas1p1c3bc326d5e07196af346821c31036662~-6_05pmIR2972729727uscas1p10;
        Fri,  8 Jul 2022 17:49:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 4F.19.09642.F3E68C26; Fri, 
        8 Jul 2022 13:49:51 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220708174951uscas1p2c93d4f3ee0b21151298255434919985b~-6_0d2PQG2993929939uscas1p2Y;
        Fri,  8 Jul 2022 17:49:51 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-cf-62c86e3f9f8b
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 36.29.57470.F3E68C26; Fri, 
        8 Jul 2022 13:49:51 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 8 Jul 2022 10:49:50 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Fri,
        8 Jul 2022 10:49:50 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v2 1/2] null_blk: add module parameters for 4
 options
Thread-Topic: [PATCH for-next v2 1/2] null_blk: add module parameters for 4
        options
Thread-Index: AQHYkvMeVTzV+gFY4kS/b4ZtSg72Gg==
Date:   Fri, 8 Jul 2022 17:49:49 +0000
Message-ID: <20220708174943.87787-2-vincent.fu@samsung.com>
In-Reply-To: <20220708174943.87787-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzreV37vBNJBs/XWVmsvtvPZrH3lrbF
        q+ZHbA7MHov3vGTyuHy21OPzJrkA5igum5TUnMyy1CJ9uwSujEvPPzAVHJeruHhyE2MD42qp
        LkZODgkBE4nGGZNZuxi5OIQEVjJK/H+2H8ppZZJYN/cEG0zVzb8PWSASaxkllu6ZAlX1kVGi
        +ctUNghnKaPExlOHmboYOTjYBDQl3u4vAOkWEUiTOHFlBTuIzSxQLXHt6H0WEFtYIEDi3owX
        7BA1oRIdFx6yQdh6Eo837QezWQRUJFr/H2EFsXkFrCXWH+gG6+UUsJG4fes3mM0oICbx/dQa
        Joj54hK3nsxngrhaUGLR7D3MELaYxL9dD6G+UZS4//0l1D16EjemTmGDsLUlli18zQyxS1Di
        5MwnLBD1khIHV9wA+15CYCKHxNPzK1ghEi4S53s2QC2Tlvh7dxkTRFE7o8TcjV+guicwSlx/
        Ag1ta4l/ndegNvNJ/P31iHECo/IsJIfPQnLULCRHzUJy1AJGllWM4qXFxbnpqcVGeanlesWJ
        ucWleel6yfm5mxiBqeT0v8P5Oxiv3/qod4iRiYPxEKMEB7OSCG+88vEkId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rzLMjckCgmkJ5akZqemFqQWwWSZODilGphYLpjpsk3aXMx4kDuz4K2TY2OV
        yqTjU2ZqP77P5VNoND89tWB/WvBN01NWAc4fso7OP+L+6YXe6WcJj7haPD8s6lR4/OWy8vOr
        n2UitZtmvhI2UV8/X+Nrz9swb7miks68wwKn3yx7t/ybuVL+ptftczn7UpQlBeYtaG4XP593
        /LGr6bUvRx1nXd9x5kHylR09jX2ej8Tarp7+zTU3qDZuSZyO3/yPTzZ7H+UJ8Aio3j/7cKX4
        Fp1gXw72ENGv0wILOjpr6zd/PWEV28aouVZ6mrKfhmn3Z7+l1TfXWJgEnChvZnIsLWLLSNFz
        vnNVoZ5xsdaBRQsklz4MS7MLUJBKenPRaO6yOjFP8c88t5VYijMSDbWYi4oTATz3j6GUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWS2cA0Sdc+70SSwfvpUhar7/azWey9pW3x
        qvkRmwOzx+I9L5k8Lp8t9fi8SS6AOYrLJiU1J7MstUjfLoEr49LzD0wFx+UqLp7cxNjAuFqq
        i5GTQ0LAROLm34csXYxcHEICqxklJk15ygrhfGSUmHnpKhuEs5RRYsafr0AOBwebgKbE2/0F
        IN0iAmkSJ66sYAexmQWqJa4dvc8CYgsL+EnsXXqSDaImVGLKruOsELaexONN+8HiLAIqEq3/
        j4DFeQWsJdYf6AbrFQKyb87eAFbDKWAjcfvWb7A4o4CYxPdTa5ggdolL3HoynwniAwGJJXvO
        M0PYohIvH/9jhbAVJe5/fwl1m57EjalT2CBsbYllC18zQ+wVlDg58wkLRL2kxMEVN1gmMIrP
        QrJiFpL2WUjaZyFpX8DIsopRvLS4ODe9otgoL7Vcrzgxt7g0L10vOT93EyMw1k7/Oxy9g/H2
        rY96hxiZOBgPMUpwMCuJ8MYrH08S4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvsyamK8kEB6Yklq
        dmpqQWoRTJaJg1OqgSn8K7fL9ZqDWYF1NqVcd6T0TLSP9KytSxP8o97cM91GKc5zooOtiKLk
        igthN9NE/+zm/NUR5H540fLcsObK/CRfLU2OQ31JOYLHPkt0Z015seBq3/nJYkzhtX/M65RE
        b9qIXeOetfr9pHdzXy35e/pRfJuTw9Uc7lVrFfdeXvniEdvaeY0Pv7hmvEy7vuiX2z2rqXJO
        LQvWLVzoWXNmTdr1vj2eByc+mHVNodTxkkHO23ZbVh5p+YcljmJqFls7GCbOr/h6pagn/IfK
        Vg+v1DNPDeU/+mm6tpps0j5Xt1flC1utTHCO4Lc7Ejalyyw26RxyOmEeIyJzPTx4yZ4C+x9p
        63eaFmTnKOuv+dFzVomlOCPRUIu5qDgRACGT/YkkAwAA
X-CMS-MailID: 20220708174951uscas1p2c93d4f3ee0b21151298255434919985b
CMS-TYPE: 301P
X-CMS-RootMailID: 20220708174951uscas1p2c93d4f3ee0b21151298255434919985b
References: <20220708174943.87787-1-vincent.fu@samsung.com>
        <CGME20220708174951uscas1p2c93d4f3ee0b21151298255434919985b@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add as module parameters these options:

memory_backed
discard
mbps
cache_size

Previously these could only be set via configfs.

Still missing is bad_blocks.

The kernel test robot found a documentation formatting issue in v1 of
this patch.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 Documentation/block/null_blk.rst | 22 ++++++++++++++++++++++
 drivers/block/null_blk/main.c    | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_bl=
k.rst
index edbbab2f1..4dd78f24d 100644
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
