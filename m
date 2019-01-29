Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A43C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B547B20856
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DWwXVWot";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ELSWW2Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfA2BtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:49:11 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21173 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfA2BtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548726550; x=1580262550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cl/wUtFx1qN68Tens0llbAWylDfPnj3AZ9XZPc+KwB4=;
  b=DWwXVWoth0s1eyXCetj8XhIZpA1Dz0kVLMFTKZlqXPX8SJFq+8ZZDwiL
   soZJ0zGxA8asUXHbA78LD3Letc2X6G4rpXaLbfOQU+Pbrz4QFH8UEBT8N
   9ZMyto8E90uTf9MbfYavrMB/HSdcRPI/RLShM4jnH2Tm/cIv1of68LpY0
   YB3Zv46AvF6awVABwT1HHSk5JMjp0fF6vKECEB8GARfHaMR1cBcu8tskd
   dDBCKSqBJflW/fKSNriRmBC4Ygf/G754EvYwK4Y6cHEGLaDC4Wbok5eY0
   KSgJRJjTIkr2NaRNYJ4oxjlzoF9V+ulXGn7MVy6+lu94n3R1b4PbnqBXM
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,535,1539619200"; 
   d="scan'208";a="101751870"
Received: from mail-by2nam03lp2053.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.53])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2019 09:49:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKGSPrg39kujSmS7yGpxt803G7hzng9+ZDA9PQ042ig=;
 b=ELSWW2OoRPg+4GQZ5HozvUrRYkDulNG9ALdNJMhzRmtRJm/riAYFesyh2OGoXsPTl1yJ3ewtmQYIqiY6i3EgRFUnIIXVorKh8TzoU+aIT2rn18fteHhRS+EQzh6zdG2HwcpAJydDNL/okmYnSQSmUPJ8eg+qyXKM3tOJ4Bu8t5w=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4343.namprd04.prod.outlook.com (20.176.251.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 29 Jan 2019 01:49:09 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 01:49:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nullb: Prevent use of legacy request queue mode
Thread-Topic: [PATCH] nullb: Prevent use of legacy request queue mode
Thread-Index: AQHUttA8QDYoLdpkQk+lxN7tBIzUO6XFebK9
Date:   Tue, 29 Jan 2019 01:49:09 +0000
Message-ID: <BYAPR04MB45026E7B9ACEC42E2773B4A586970@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190128061048.20778-1-damien.lemoal@wdc.com>
In-Reply-To: <20190128061048.20778-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [129.253.54.74]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4343;6:8S71B1WEcqEfB+UZpEtfLBxob00iBZ2QKQxDls580rsWS+KbYR856xosz86FOoCH3+dvbkBIfJamGfFiimF5LddAoqQfqX8wnao49sCtqUfL52uJriB1+D8AzBqhtCqL8KNodZ2kVYVvBJwlEyLAuEXy+KqNqgCikmoegXXuE0/1xz44yontEte6VvyZ+biXjjo+0N7kCePR67t+P+6wnTfJwdju9G3ufF18jeyUsKVIIzOlAeNPe7ElGZiZp8lwDfB+k6/AFWVvDzJO4JA0cUw9ka7ZQKU/WsKXIBA8gCFOg+ij8vnEaneVQpgqmoDPEGPDpPVavUWehq5URO7GZsk8Pap3Edlhq+Kc4AQy0gB8p9fnoq5X8zEjUFYubslGcammdV1XUyVKQ7zZglsXC2RyuQJok3Fmadtuy9sFsQrZD0ZB/p81WUcFO7ov1toPbidwVt4bij3sRmUsprmQLw==;5:y5F7dlpIuIYMOxUbsE9wt8mgc8SyuVTI2MECJOoI3qf9zp1gwb8FCghRH9dHtrFjC5Oi9R+MNytTLoGKVlvwLkW3BVOlHq2NLwAmFT198HISfqPkygHA+jtjYWF9S7qODNVFqUdnPJqEXIvQoHxNmjajzUDlVSK52otIALEJ+jiJgHgxRavJ8GuIzaNHYSTf7S0j112btzHCcVgVOHDxJg==;7:JQKifqOAmuGZtgLGnk3ha2iZaPJuBGnYFOJtpMwjBZ4BatipNkW97VgAcTDRBRRp/BuWKL1ATg5F3zJrrrQIqx3MHb7JuaLAVo2z0Xuyu+ZTWoQS/t5Q1b7dfBmVm7tMiin12Rh+V+MEC/qgKAL71g==
x-ms-office365-filtering-correlation-id: 57df6c0a-3c1a-42a7-8175-08d6858bf5fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4343;
x-ms-traffictypediagnostic: BYAPR04MB4343:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB434331D10FE3A38F84CA83C686970@BYAPR04MB4343.namprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(6506007)(446003)(53546011)(76176011)(102836004)(74316002)(316002)(11346002)(54906003)(110136005)(106356001)(55016002)(6436002)(7696005)(7736002)(478600001)(72206003)(305945005)(6116002)(186003)(99286004)(2501003)(26005)(71190400001)(476003)(33656002)(3846002)(71200400001)(486006)(256004)(14444005)(66066001)(81156014)(105586002)(81166006)(53936002)(6246003)(14454004)(68736007)(9686003)(97736004)(86362001)(8936002)(25786009)(4326008)(8676002)(229853002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4343;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZBGiGWIZD/HuIXLd6zns8kdWl6QcfFb7d6HKHBF/34A8PZWRwi1/Q2lTSk51jUQy6+a824XOySXsVs0u5Fy920CYcu5vHjsr4Iih+Q+QxolWVOppAT93pp8YTmKfSu1RS11Gs9COzuA8pcxtsj13E6T6lWtfbONU+EiSPlrLcCDee6u1A1w+RgYKSg3K5f661eOsvpR09Mx0/ymRrfFeKfG0ojBm+cj2Y/3zgh97U/8cZ49zkWeImwc8+vh9qRKgC70HUCGHWtX+rnZh8H9lU3ogkptucQyT1vGxe5VdHSP8rtp6A4aGmYZ0TCZXzjlkU33pPW87YmOip4NhcR1d3jclMtrFuMQ7z1lpWF/EI/V+CUoZpyfOZOnD3IQYt37ncHeTkZThipVietuWCIrefCgCdx7dM4KUvGl5yvfkjEo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57df6c0a-3c1a-42a7-8175-08d6858bf5fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 01:49:09.1062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4343
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Damien Le Moal <damien.lemoal@wdc.com>
Sent: Sunday, January 27, 2019 10:10 PM
To: linux-block@vger.kernel.org; Jens Axboe
Cc: Matias Bjorling; Christoph Hellwig
Subject: [PATCH] nullb: Prevent use of legacy request queue mode
=A0=20
=20
When null_blk queue mode is specified together with modprobe/insmod, a
check to prevent setting the nullb device queue mode to 1 (NULL_Q_RQ) is
done. However, the same check is not performed when setting up a nullb
device through configfs, resulting in a oops (NULL pointer dereference
for the device request queue).

Fix this problem by checking for an invalid queue mode value in
null_validate_conf(), propagating -EINVAL to null_add_dev() if the queue
mode is NULL_Q_RQ. While at it, also fix the propagation to user space
of null_add_dev() return value when a nullb device is created through
configfs power attribute.

Fixes: 49f6613632f9 ("nullb: remove leftover legacy request code")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
=A0drivers/block/null_blk_main.c | 22 +++++++++++++++++-----
=A01 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..5570d0da59b4 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -318,9 +318,10 @@ static ssize_t nullb_device_power_store(struct config_=
item *item,
=A0=A0=A0=A0=A0=A0=A0=A0 if (!dev->power && newp) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (test_and_set_bit(NULLB=
_DEV_FL_UP, &dev->flags))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn count;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (null_add_dev(dev)) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D null_add_dev(dev);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cl=
ear_bit(NULLB_DEV_FL_UP, &dev->flags);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
-ENOMEM;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit(NULLB_DEV_FL_CONFI=
GURED, &dev->flags);
@@ -1561,8 +1562,13 @@ static int null_init_tag_set(struct nullb *nullb, st=
ruct blk_mq_tag_set *set)
=A0=A0=A0=A0=A0=A0=A0=A0 return blk_mq_alloc_tag_set(set);
=A0}
=A0
-static void null_validate_conf(struct nullb_device *dev)
+static int null_validate_conf(struct nullb_device *dev)
=A0{
+=A0=A0=A0=A0=A0=A0 if (dev->queue_mode =3D=3D NULL_Q_RQ) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("null_blk: legacy IO pat=
h no longer available\n");
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
+=A0=A0=A0=A0=A0=A0 }
+
=A0=A0=A0=A0=A0=A0=A0=A0 dev->blocksize =3D round_down(dev->blocksize, 512)=
;
=A0=A0=A0=A0=A0=A0=A0=A0 dev->blocksize =3D clamp_t(unsigned int, dev->bloc=
ksize, 512, 4096);
=A0
@@ -1588,6 +1594,8 @@ static void null_validate_conf(struct nullb_device *d=
ev)
=A0=A0=A0=A0=A0=A0=A0=A0 /* can not stop a queue */
=A0=A0=A0=A0=A0=A0=A0=A0 if (dev->queue_mode =3D=3D NULL_Q_BIO)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->mbps =3D 0;
+
+=A0=A0=A0=A0=A0=A0 return 0;
=A0}
=A0
=A0#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
@@ -1620,7 +1628,9 @@ static int null_add_dev(struct nullb_device *dev)
=A0=A0=A0=A0=A0=A0=A0=A0 struct nullb *nullb;
=A0=A0=A0=A0=A0=A0=A0=A0 int rv;
=A0
-=A0=A0=A0=A0=A0=A0 null_validate_conf(dev);
+=A0=A0=A0=A0=A0=A0 rv =3D null_validate_conf(dev);
+=A0=A0=A0=A0=A0=A0 if (rv)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 nullb =3D kzalloc_node(sizeof(*nullb), GFP_KERNEL,=
 dev->home_node);
=A0=A0=A0=A0=A0=A0=A0=A0 if (!nullb) {
@@ -1648,8 +1658,10 @@ static int null_add_dev(struct nullb_device *dev)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rv)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to out_cleanup_queues;
=A0
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!null_setup_fault())
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!null_setup_fault()) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv =3D =
-EINVAL;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to out_cleanup_queues;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nullb->tag_set->timeout =
=3D 5 * HZ;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nullb->q =3D blk_mq_init_q=
ueue(nullb->tag_set);
--=20
2.20.1

    =
