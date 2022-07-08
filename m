Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14172C433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 17:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiGHRuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiGHRuB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 13:50:01 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F12A406
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 10:49:57 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220708174952usoutp010ee5fc66c9c3f9f88031428793a34f71~-6_1X5Wqo1314813148usoutp01y;
        Fri,  8 Jul 2022 17:49:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220708174952usoutp010ee5fc66c9c3f9f88031428793a34f71~-6_1X5Wqo1314813148usoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657302592;
        bh=dKvuV+Vke9yXzQKdji7pOnqSjxR/gIZILkZLC2ZX7nY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ov7wI++3oKFVHgVVVr1OWjXQpnXyAbyPBIj9Bfmw2qj+FwdHac801ubbHQP4LpUon
         IVGY3pnH7UDu8CYV/nNo4nMdDAJtIqifoWBLQUzZVFngXnGU28Uz7q26aTWbXmonUH
         Pl1yXgF3CsSwB3k68IaGELhOOakpilgYGjRJy33s=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220708174952uscas1p1beacdaeb81d1979499f9ffc9786c3244~-6_1RZf8e0960309603uscas1p1H;
        Fri,  8 Jul 2022 17:49:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id DF.19.09642.04E68C26; Fri, 
        8 Jul 2022 13:49:52 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220708174952uscas1p25f5532b41eb96fe2ddc7a1a06b1a78af~-6_1Ag0pF2800328003uscas1p2W;
        Fri,  8 Jul 2022 17:49:52 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-d3-62c86e405aee
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 96.29.57470.F3E68C26; Fri, 
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
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH for-next v2 2/2] null_blk: add configfs variables for 2
 options
Thread-Topic: [PATCH for-next v2 2/2] null_blk: add configfs variables for 2
        options
Thread-Index: AQHYkvMe9xNxCgftmEOX50bAHtW65Q==
Date:   Fri, 8 Jul 2022 17:49:49 +0000
Message-ID: <20220708174943.87787-3-vincent.fu@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djX87oOeSeSDOZeE7JYfbefzWLvLW0H
        Jo/LZ0s9Pm+SC2CK4rJJSc3JLEst0rdL4MpYN7ePuWChdMWDL8eYGhh3incxcnJICJhIbPl+
        jK2LkYtDSGAlo8Tn/12sEE4rk8Sc1qmMMFV9N34xQiTWMkrcXNXDDuF8ZJRo/jIVqn8po8TG
        U4eZuhg5ONgENCXe7i8A6RYRSJM4cWUFO4jNLBAh0bxgHjOILSwQKDF/ewc7RE2YxOWFb9kg
        bD2J9gfbmEBsFgEVidb/R1hBbF4Ba4kT11+AXcQpYCNx+9ZvFhCbUUBM4vupNUwQ88Ulbj2Z
        zwRxtaDEotl7mCFsMYl/ux6yQdiKEve/v4S6R0/ixtQpbBC2tsSyha+ZIXYJSpyc+YQFol5S
        4uCKGywgP0oIdHJIXL3cBDXIRWLSih1QC6Ql/t5dxgRR1M4oMXfjF6juCYwS159IQdjWEv86
        r0Ft5pP4++sR4wRG5VlIDp+F5KhZSI6aheSoBYwsqxjFS4uLc9NTi43yUsv1ihNzi0vz0vWS
        83M3MQLTxul/h/N3MF6/9VHvECMTB+MhRgkOZiUR3njl40lCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeZdlbkgUEkhPLEnNTk0tSC2CyTJxcEo1MDlGScznUS4zeZx01TR0x7G+/p/6NZemnk/x
        iLyuM2XiKukmmdsPzppqPrun7vUgde+Tmc98G1bzeT/ttBKKsZwzSfVtyaE7x94L7NsmciFj
        wyETs/0pNedmStQ8XaijqnskK+poxoqyQ44TFU9t8OD2FfRf822X3aH2Xz79H6tmNs+2nS/o
        VvVg0R62zo5e2VdfGpkuurmlfHZbEJ7h+fMT00uLt2IKz7f5B1RfkMrk022f9LCC5eR8h/1G
        KREy81VXMXYb/M9TL3t/1+7Muwk2T24KxnDN57p48LP03aroh87zD9h+vW5klBoqWprwNX33
        cTbPbx0my8UeXXq6I2mtqKfdprRHly+qfmt58U2JpTgj0VCLuag4EQAsVIkRigMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LJbGCapGufdyLJ4OFZG4vVd/vZLPbe0nZg
        8rh8ttTj8ya5AKYoLpuU1JzMstQifbsErox1c/uYCxZKVzz4coypgXGneBcjJ4eEgIlE341f
        jF2MXBxCAqsZJWa/2AflfGSUmHnpKhuEs5RRYsafr0AOBwebgKbE2/0FIN0iAmkSJ66sYAex
        mQUiJJoXzGMGsYUFAiXmb+9gh6gJk/i0eR4rhK0n0f5gGxOIzSKgItH6/whYnFfAWuLE9ReM
        ILYQkH1z9gY2EJtTwEbi9q3fLCA2o4CYxPdTa5ggdolL3HoynwniAwGJJXvOM0PYohIvH/9j
        hbAVJe5/fwl1m57EjalT2CBsbYllC18zQ+wVlDg58wkLRL2kxMEVN1gmMIrPQrJiFpL2WUja
        ZyFpX8DIsopRvLS4ODe9otgoL7Vcrzgxt7g0L10vOT93EyMwrk7/Oxy9g/H2rY96hxiZOBgP
        MUpwMCuJ8MYrH08S4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvsyamK8kEB6YklqdmpqQWoRTJaJ
        g1Oqganu1efjhT9ft1ZO4nM86iApOf321L+/P0snr+PW564xjBDY4fD+5Ylzknl8xzKePvus
        2/56+q/D5+fplFQ3Rnj/k3M4988kQfrWmtKvOaYfjX/WNdbsW/E3ae/1BYkpi9L6Sry5DVmX
        tym84A9dZfo6s3ZRjoqdVtus8Lw/yiWHzxefmPpzwoYdUtpfrt8stTe+Y6i14LJv/8KQDw8S
        3Nt5/cWnLbH6LDFvctUNA+dTevPkVr/6UMhUNaUibt9sxRdM+26XvFiYqWwWWsES93HrWfN1
        F/ef2FGxbvUP/lTbj18WSn00/HNU40nO5ly+/1/eh2YsnPVapf6/vMm0vs+7c2f/mbFK9OOD
        WzMuS2hXKrEUZyQaajEXFScCAP01jboaAwAA
X-CMS-MailID: 20220708174952uscas1p25f5532b41eb96fe2ddc7a1a06b1a78af
CMS-TYPE: 301P
X-CMS-RootMailID: 20220708174952uscas1p25f5532b41eb96fe2ddc7a1a06b1a78af
References: <20220708174943.87787-1-vincent.fu@samsung.com>
        <CGME20220708174952uscas1p25f5532b41eb96fe2ddc7a1a06b1a78af@uscas1p2.samsung.com>
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
