Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE685C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 20:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiGGUyO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiGGUyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 16:54:13 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9892E9F9
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 13:54:11 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220707205409usoutp02e5bea93b58b91507877c1cbc4bebc5ac~-p2cb3srO0813608136usoutp02i;
        Thu,  7 Jul 2022 20:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220707205409usoutp02e5bea93b58b91507877c1cbc4bebc5ac~-p2cb3srO0813608136usoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657227249;
        bh=dKvuV+Vke9yXzQKdji7pOnqSjxR/gIZILkZLC2ZX7nY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SbwHhk1aU5vC/mE8xgzZp1NK4h/WCHydkMTum6K9RYqjCxI3Sz9zRyQiSTqrtplZv
         es/yNp++RPhGajQM6HVZRGAyhslk2L9BUxa2Nz1yO8DLXL/CUc344bOe1k51xbjsjk
         B8RIiAn43JbpDnqvNNNqAN0Ceo+WYtAlJixIrICY=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220707205409uscas1p1741953af2df22a143b4d3de54f84f64c~-p2cV2Efk2682526825uscas1p15;
        Thu,  7 Jul 2022 20:54:09 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id F5.EA.09749.0F747C26; Thu, 
        7 Jul 2022 16:54:09 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220707205408uscas1p1418aafe8915d04c68946012fab73f698~-p2cEm9JB2699526995uscas1p15;
        Thu,  7 Jul 2022 20:54:08 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-5b-62c747f0e4c3
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 30.CC.52349.0F747C26; Thu, 
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
Subject: [PATCH 2/2] null_blk: add configfs variables for 2 options
Thread-Topic: [PATCH 2/2] null_blk: add configfs variables for 2 options
Thread-Index: AQHYkkOyzJ/fIPlMQ0yClOKz1HwYFg==
Date:   Thu, 7 Jul 2022 20:54:06 +0000
Message-ID: <20220707205401.81664-3-vincent.fu@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djX87of3Y8nGbzczGSx+m4/m8XeW9oO
        TB6Xz5Z6fN4kF8AUxWWTkpqTWZZapG+XwJWxbm4fc8FC6YoHX44xNTDuFO9i5OCQEDCReNRT
        2sXIxSEksJJRorvpFzOE08ok8XziAyaYop+rYiDiaxklLq46zAbhfGSU+Pr+DguEs5RR4vLh
        5YwgHWwCmhJv9xd0MXJyiAikSZy4soIdxGYWiJBoXjCPGcQWFnCWeNv7lQWixkNiy6cXjBC2
        nsSqk/vA6lkEVCQ6p7aA1fAKWEus3zYVLM4pYCPR8PQXWD2jgJjE91NrmCDmi0vcejIfzJYQ
        EJRYNHsPM4QtJvFv10M2CFtR4v73l1D36EncmDqFDcLWlli28DUzxC5BiZMzn7BA1EtKHFxx
        A+xHCYFODonvM3ZAQ8VF4v38TIgaaYmr16cyQ9S0M0rM3fgFqnkCo8T1J1IQtrXEv85rUIv5
        JP7+esQ4gVF5FpK7ZyG5aRaSm2YhuWkBI8sqRvHS4uLc9NRi47zUcr3ixNzi0rx0veT83E2M
        wIRx+t/hgh2Mt2591DvEyMTBeIhRgoNZSYQ3Xvl4khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        ZZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MU3PX+q0OnXoqUaLp9y6TfYcOm5z12suQwvPTyO5J
        AUP/3+7Dy29nn1wSfXbTFJ+JMpKyrD1yKZ7VLjVV/QFVFjIGs+9Z2cXVrlD5rdWofzXXNnIu
        B7dc6UJtTb6mVTNe39v+c/Weid53hHft1sjemaO2uKhVaN9aU69rPe4rt0Vc+cvBcF223GrT
        BOOTslbzc0sXZxmks6u6GQl5t03fdDSyMH0/w7Unomc5+HV4xc4dryuqspH5M/f+Tqe5+9g/
        cPUs95R8+6Lk+moB9aN397Cuc2zdt/dF/KFVsju8VeWXzjy6ZMvZ98ulLkuukL58TIJR825L
        /KymL1s3FW5of6gRf1bqZyX3+ZLSsx++KLEUZyQaajEXFScCAHMpwXKHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LJbGCapPvB/XiSwYQPmhar7/azWey9pe3A
        5HH5bKnH501yAUxRXDYpqTmZZalF+nYJXBnr5vYxFyyUrnjw5RhTA+NO8S5GDg4JAROJn6ti
        uhi5OIQEVjNK/FpzjRXC+cgo0XNjMmMXIyeQs5RRYu+PKpAGNgFNibf7C0DCIgJpEieurGAH
        sZkFIiSaF8xjBrGFBZwl3vZ+ZYGo8ZDY8ukFI4StJ7Hq5D6wehYBFYnOqS1gNbwC1hLrt01l
        h1hlLXHs6lQmEJtTwEai4ekvsF5GATGJ76fWMEHsEpe49WQ+mC0hICCxZM95ZghbVOLl43+s
        ELaixP3vL6Fu05O4MXUKG4StLbFs4WtmiL2CEidnPmGBqJeUOLjiBssERvFZSFbMQtI+C0n7
        LCTtCxhZVjGKlxYX56ZXFBvmpZbrFSfmFpfmpesl5+duYgTG1Ol/hyN3MB699VHvECMTB+Mh
        RgkOZiUR3njl40lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeYVcJ8YLCaQnlqRmp6YWpBbBZJk4
        OKUamPh3X7T5rfjQm5u1a9Wv2Ipzu5Vt7xScqniTyOUheGeX5bW9x5fsuWD1u1JcbdlG2YMJ
        i/7v2mPsEMbp+HZjTLvRu3MxfKpV4hM+2j7Rn+qRU/ByxyGeV4UWq46YZq8sP7+eV/ggf5lU
        959/GfYhl9/HJpovnXmwY1raZLvb35aYa+TZSESer3wd6iCoM0vqfqLf+qav7Y+leuK99ZTv
        adzOm/JucciPTI6D664Ev+8XVjNeJ7xZ78KzmDWaaior658oNTwwnFSoxJo4v6cvi+H4v2o5
        zefvveZfWtJ1vO3atvRnWw/eL7ux9vphS7nGr8Fmy5Yfz5m79clsf3EVlxa/hoP222XdTicb
        +8xx2arEUpyRaKjFXFScCACsOmz3GAMAAA==
X-CMS-MailID: 20220707205408uscas1p1418aafe8915d04c68946012fab73f698
CMS-TYPE: 301P
X-CMS-RootMailID: 20220707205408uscas1p1418aafe8915d04c68946012fab73f698
References: <20220707205401.81664-1-vincent.fu@samsung.com>
        <CGME20220707205408uscas1p1418aafe8915d04c68946012fab73f698@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow setting via configfs these two options:

no_sched
shared_tag_bitmap

Previously these could only be activated as module parameters.

Still missing are:

shared_tags
timeout
requeue
init_hctx

Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 drivers/block/null_blk/main.c     | 18 +++++++++++++++---
 drivers/block/null_blk/null_blk.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 8f821fa94..c955a07db 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -425,6 +425,8 @@ NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
+NULLB_DEVICE_ATTR(no_sched, bool, NULL);
+NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
=20
 static ssize_t nullb_device_power_show(struct config_item *item, char *pag=
e)
 {
@@ -548,6 +550,8 @@ static struct configfs_attribute *nullb_device_attrs[] =
=3D {
 	&nullb_device_attr_zone_max_open,
 	&nullb_device_attr_zone_max_active,
 	&nullb_device_attr_virt_boundary,
+	&nullb_device_attr_no_sched,
+	&nullb_device_attr_shared_tag_bitmap,
 	NULL,
 };
=20
@@ -604,7 +608,13 @@ nullb_group_drop_item(struct config_group *group, stru=
ct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *pa=
ge)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_c=
apacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors,vi=
rt_boundary\n");
+			"badblocks,blocking,blocksize,cache_size,"
+			"completion_nsec,discard,home_node,hw_queue_depth,"
+			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
+			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
+			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
+			"zone_capacity,zone_max_active,zone_max_open,"
+			"zone_nr_conv,zone_size\n");
 }
=20
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -678,6 +688,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_max_open =3D g_zone_max_open;
 	dev->zone_max_active =3D g_zone_max_active;
 	dev->virt_boundary =3D g_virt_boundary;
+	dev->no_sched =3D g_no_sched;
+	dev->shared_tag_bitmap =3D g_shared_tag_bitmap;
 	return dev;
 }
=20
@@ -1899,9 +1911,9 @@ static int null_init_tag_set(struct nullb *nullb, str=
uct blk_mq_tag_set *set)
 	set->numa_node =3D nullb ? nullb->dev->home_node : g_home_node;
 	set->cmd_size	=3D sizeof(struct nullb_cmd);
 	set->flags =3D BLK_MQ_F_SHOULD_MERGE;
-	if (g_no_sched)
+	if (nullb->dev->no_sched)
 		set->flags |=3D BLK_MQ_F_NO_SCHED;
-	if (g_shared_tag_bitmap)
+	if (nullb->dev->shared_tag_bitmap)
 		set->flags |=3D BLK_MQ_F_TAG_HCTX_SHARED;
 	set->driver_data =3D nullb;
 	if (poll_queues)
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/nul=
l_blk.h
index 8359b4384..ce5c810c1 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -113,6 +113,8 @@ struct nullb_device {
 	bool discard; /* if support discard */
 	bool zoned; /* if device is zoned */
 	bool virt_boundary; /* virtual boundary on/off for the device */
+	bool no_sched; /* no IO scheduler for the device */
+	bool shared_tag_bitmap; /* use hostwide shared tags */
 };
=20
 struct nullb {
--=20
2.25.1
