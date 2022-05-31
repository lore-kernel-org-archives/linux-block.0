Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8126BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 18:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbiEaSxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiEaSxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 14:53:03 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1591EEFE
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 11:53:01 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220531185259usoutp02c02ca31ea6aa96a6a36bc43acae3d343~0RVFwVcYW0552505525usoutp02e;
        Tue, 31 May 2022 18:52:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220531185259usoutp02c02ca31ea6aa96a6a36bc43acae3d343~0RVFwVcYW0552505525usoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654023179;
        bh=0ytobJGplczLTQneSo5vdPHD9o73Cy9oqki+mftraTg=;
        h=From:To:CC:Subject:Date:References:From;
        b=bQcMKOwW4zRStCDzRQTK0J5Xj9nlpjhqGXEaLx2S9tEIHqRF1/EZlv0oFhJ1bC3xU
         qc1X764RBT3huMrG0a2aUmsXHVECZI7T1OWYQpA1Ajn/QXRljCmkh/5ILFtGmiLPi9
         a9pYXpyuooiq3nF97cz7pgC5m5bAyhf9SWbnQFgk=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220531185258uscas1p192830738ad21590747a73965f7e8f2b1~0RVFZNpDe1869918699uscas1p1V;
        Tue, 31 May 2022 18:52:58 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 18.FE.09642.A0466926; Tue,
        31 May 2022 14:52:58 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220531185258uscas1p29fc501690df21576af035ef48af16daf~0RVFMfv4N0707707077uscas1p2F;
        Tue, 31 May 2022 18:52:58 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-c8-6296640a0ed5
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 9B.F6.52349.A0466926; Tue,
        31 May 2022 14:52:58 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 31 May 2022 11:52:57 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Tue,
        31 May 2022 11:52:57 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
CC:     Vincent Fu <vincent.fu@samsung.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] null_blk: add memory_backed module parameter
Thread-Topic: [PATCH] null_blk: add memory_backed module parameter
Thread-Index: AQHYdR+kBhCunBIlp0yswCbxVP1rHw==
Date:   Tue, 31 May 2022 18:52:57 +0000
Message-ID: <20220531185231.169102-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djX87pcKdOSDDbvN7B4daCD0WL13X42
        i723tB2YPXbOusvucflsqcfnTXIBzFFcNimpOZllqUX6dglcGXtPN7AWHBet+LvHo4HxvFAX
        IyeHhICJxL+57YwgtpDASkaJv9N5uxi5gOxWJokfb5cwwRS9m3+aDSKxllGi6fExVgjnE6PE
        rbZzLBDOMkaJTZteA83i4GAT0JR4u78ApFtEIERi38JLLCA2s0CAxIud81lBbGEBW4n2i+cY
        IWqcJP4/mcwGYetJrJ/3lhlkDIuAqkTXZnaQMK+AjcSu7avADmIUEJP4fmoNE8RIcYlbT+ZD
        HSoosWj2HmYIW0zi366HbBC2osT97y/ZIer1JG5MncIGYWtLLFv4mhlivqDEyZlPWCDqJSUO
        rrgB9paEwF92ifMzvrFCJFwknv48DGVLS1y9PpUZoqidUWLuxi9Q3RMYJa4/kYKwrSX+dV6D
        2swn8ffXI3D4SAjwSnS0CU1gVJqF5IdZSO6bheS+WUjuW8DIsopRvLS4ODc9tdgoL7Vcrzgx
        t7g0L10vOT93EyMwhZz+dzh/B+P1Wx/1DjEycTAeYpTgYFYS4S3ZNTVJiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO+yzA2JQgLpiSWp2ampBalFMFkmDk6pBibjP8rBz/kNe3eaWKu8ZYlju8n6
        obnZ+cqNgm77/WFWqne1m1aVzzx5USNy2e5N+de53LZMu+FqzGguWhgkbCg774+U2MESRnXv
        Y31xNfW9L55UeazfUGc6Z/7k/1K8r8WVMvZMEorueTv1UdlfK5GtpqqLRa6nHPA8UWyUOldp
        sfL6sHwb9j1rpGQmr+nfs2fBfb0uZk7bZ39eij1+FWAdwON9Q6nl18TgMN3r363Kj4aeSF9l
        fIH7vcXzzwwavczblu0PCfc7dOX5ls/PFWZqZJoKbbly8ITCCa6jX0xcDmUdC05/GfpmeZyS
        ye43h4+3TVt7LS+9VIzxjcbrlcnXMzcmiKRuXd19TOHDgjYlluKMREMt5qLiRAC+FnQjkAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWS2cA0UZcrZVqSwa8XchavDnQwWqy+289m
        sfeWtgOzx85Zd9k9Lp8t9fi8SS6AOYrLJiU1J7MstUjfLoErY+/pBtaC46IVf/d4NDCeF+pi
        5OSQEDCReDf/NFsXIxeHkMBqRon/n9+zQjifGCWeT9sF5SxjlDhxfhVjFyMHB5uApsTb/QUg
        3SICIRL7Fl5iAQkzC/hJvLrPChIWFrCVaL94jhGixEni/5PJbBC2nsT6eW+ZQcpZBFQlujaz
        g4R5BWwkdm1fxQRiMwqISXw/tQbMZhYQl7j1ZD4TxJ0CEkv2nGeGsEUlXj7+xwphK0rc//6S
        HaJeT+LG1ClsELa2xLKFr5kh5gtKnJz5hAWiXlLi4IobLBMYRWchWTELSfssJO2zkLQvYGRZ
        xSheWlycm15RbJiXWq5XnJhbXJqXrpecn7uJERg1p/8djtzBePTWR71DjEwcjIcYJTiYlUR4
        S3ZNTRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOK+Q6MV5IID2xJDU7NbUgtQgmy8TBKdXAVFje
        0eV4ouPw2oJ1m8omPqqMqZH+9Coq5kcv3/xQk4RHZ+cnPSmcO/t2srm3T0vixl5Z44LcK1ee
        z4/9LxAd8Ddp1xF2rvvLfthzvf4j45sYylZftqDN7cfNiYXee2bUeNtPnhugNiHtsue2xNqD
        v5YtyDjuvqBi6VJ7l5PTGO6/Ff+ysNBl9eupCx/vVl3NstUh0HXVH8MOk93sU55eb9rSc5ot
        ZhnDku8L1i4Rf2ps2+IjM9uh2C9Pe9mJIFWTGLn7DJwpL3vTt+2WeHPjm1m83BPr/RaS+wXi
        mY6qBV3T23YtQ/Kxdu80exuLv3ESs5obDDa3JcW8nBtkXn+60KPF9OjT7fL5PbdXyvBlKbEU
        ZyQaajEXFScCAEZKv7kJAwAA
X-CMS-MailID: 20220531185258uscas1p29fc501690df21576af035ef48af16daf
CMS-TYPE: 301P
X-CMS-RootMailID: 20220531185258uscas1p29fc501690df21576af035ef48af16daf
References: <CGME20220531185258uscas1p29fc501690df21576af035ef48af16daf@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow the memory_backed option to be set via a module parameter.
Currently memory-backed null_blk devices can only be created using
configfs. Having a module parameter makes it easier to create these
devices.

This patch was originally submitted by Akinobu Mita in 2020 but received
no response. I modified the original patch to apply cleanly and reworded
the documentation from the original patch.

Originally-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 Documentation/block/null_blk.rst | 8 ++++++++
 drivers/block/null_blk/main.c    | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_bl=
k.rst
index edbbab2f1..618a491fa 100644
--- a/Documentation/block/null_blk.rst
+++ b/Documentation/block/null_blk.rst
@@ -72,6 +72,14 @@ submit_queues=3D[1..nr_cpus]: Default: 1
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
 Multi-queue specific parameters
 -------------------------------
=20
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 539cfeac2..e97623c55 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -203,6 +203,10 @@ static int g_hw_queue_depth =3D 64;
 module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Def=
ault: 64");
=20
+static bool g_memory_backed;
+module_param_named(memory_backed, g_memory_backed, bool, 0444);
+MODULE_PARM_DESC(memory_backed, "Create a memory-backed block device. Defa=
ult: false");
+
 static bool g_use_per_node_hctx;
 module_param_named(use_per_node_hctx, g_use_per_node_hctx, bool, 0444);
 MODULE_PARM_DESC(use_per_node_hctx, "Use per-node allocation for hardware =
context queues. Default: false");
@@ -656,6 +660,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->irqmode =3D g_irqmode;
 	dev->hw_queue_depth =3D g_hw_queue_depth;
 	dev->blocking =3D g_blocking;
+	dev->memory_backed =3D g_memory_backed;
 	dev->use_per_node_hctx =3D g_use_per_node_hctx;
 	dev->zoned =3D g_zoned;
 	dev->zone_size =3D g_zone_size;
--=20
2.25.1
