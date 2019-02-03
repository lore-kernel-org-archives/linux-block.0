Return-Path: <SRS0=MuI/=QK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4785C169C4
	for <linux-block@archiver.kernel.org>; Sun,  3 Feb 2019 12:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B1A2083B
	for <linux-block@archiver.kernel.org>; Sun,  3 Feb 2019 12:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eVSYchnn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VOkiyOuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBCMJq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:09:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21837 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfBCMJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Feb 2019 07:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549195785; x=1580731785;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QYiptp1AnZMJotf9FZ7aTOql6AfJWysqNj5wpYacu1Y=;
  b=eVSYchnnCmlZviu0c5CK6HyRGqXZ7616Zl0F5ioS32q3ZgT832Vvd3fj
   gelIDdiJikK64zRTSlXhqncVg0HragAmFH+qloVmZXfdL0AB+vz9RQLoQ
   1CsO8Y7DMIwKk8Fg3sgrlaCH9AfcErab1aaFwjjoOVj8e8tV2LFe5fGWi
   EXg82tK9dmOxeQDsa5BGu4zX36gB04YK5nuXk8i+ovbVErrhnaKpoEQcN
   wSmdqN2EQJhcQVbuC6SKH61vKFyUhOnonGY5C7YeBcriTt9pZZDkISyV+
   wdRwilVcGEYmP2D7Gvyky2EGY2wfkzq1k6OWGaVdzond8RPPL5o761Hnb
   w==;
X-IronPort-AV: E=Sophos;i="5.56,556,1539619200"; 
   d="scan'208";a="205498059"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2019 20:09:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPXZZHrFGfk2rMoHm7qNAZSoDg6mBp5S/n+ftpl59LU=;
 b=VOkiyOuvMaF3VvYf/IgBx1QNBZG0Ur5TOEoRVIjwHnkYv/Fg7Ra7cEn/gEticNhqYp2jNpv1Cv1cmiwV8KldDBoGjzjFEWlvvTvntaiNRqsfc6T5hgWmuUmaHJJs7jSCUWjfKQGKd8qv1po40FtU+rAuz8hX7jcgLrYaPw/hzmE=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5976.namprd04.prod.outlook.com (20.178.232.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Sun, 3 Feb 2019 12:09:41 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb%3]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 12:09:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nullb: Prevent use of legacy request queue mode
Thread-Topic: [PATCH v2] nullb: Prevent use of legacy request queue mode
Thread-Index: AQHUtt8Cej1AUD/ZjEeYKLrOrqfe6Q==
Date:   Sun, 3 Feb 2019 12:09:41 +0000
Message-ID: <BYAPR04MB5816B22B602D488F1F0E8193E76C0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190128075634.25748-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [2001:67c:1810:f055:140b:63cf:3f2a:bc59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5976;6:2pVVUGZjCZrVPvn8kn2hbb+Tm5ifQdIoG2hTSvBsRxDGw8qR9E2AdFvnYGMnvlXIT6N+NMBAzsTvTl2cXupAaqUEa5Stoi6eH2z8Yr82fAq+GVasZLgSs3xlzWpDF37Zv2sz3z/OuKX9n69G+viOM/br/Xzs9ObYehuoHK20wP67G8mDBIRmHriHldUc3rj1U8RoLDc+PsylHx0Gqp45GNdxquMwDlzbgRbne4qqsZ0dLbPEzjl3rP6tEBubfnDVBlUjKqf80ArSHaHcPpffcU6pmeW86k+ZlUo4iWwXZIrOV+84eVaSDsj1/H/DjjeJgnmB/er408LHF0t6Wm+BNth+opzIGsyuUeqOKwS5J8ajBBJ6nht39hnrhSsz1zs6xd8vecwbxOHmCe8k76s8vWS/QeCUxVhYi7ZpL5inawD6YX82ciRNJFWW4ua5FMbLnbR7z4d7dMOo8GIl/w9V+g==;5:z/uHrE+HSCQteDfvuYvVt6Hg6wfdjWhgbNaJMjhZqz9Fy6NFHFWqkSnKXEBP1D192jCn/NQrrk4McMvCCY2Z6VqSz+zUTZ+ngxp5ZcdGU1kJg5uhrr8Z7nlAwp8Vuh89vmDPJ4sIS7qXcgQ7nI0DGat58pEezlcsaJapE8He40YuZSni0yPPV0TRghizBrSz/35w9NOhawCTNskX6hJb2A==;7:JpTS8CuqEPkqvebXp3Bxh14TwPeGDK6DuTFNu3GpVGVDX1pIonplsZ+r07tC2gAti3kN3Nb/KcO8k25SIpN48+qVgI5ui731S5GnFm5OyzNT9O8GB2Ibyx750UFbjSFmj9ssQYZAUY0sVPgB2Yc0dw==
x-ms-office365-filtering-correlation-id: 65b78833-d61c-4369-7737-08d689d07a67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5976;
x-ms-traffictypediagnostic: BYAPR04MB5976:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5976EABEAAA926A581C85CBFE76C0@BYAPR04MB5976.namprd04.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(8676002)(316002)(55016002)(110136005)(81156014)(81166006)(7736002)(6506007)(305945005)(6116002)(2501003)(71190400001)(7696005)(186003)(76176011)(53546011)(71200400001)(106356001)(446003)(6436002)(46003)(54906003)(105586002)(4326008)(25786009)(97736004)(6246003)(229853002)(486006)(72206003)(14454004)(53936002)(478600001)(33656002)(476003)(8936002)(9686003)(102836004)(14444005)(99286004)(86362001)(68736007)(256004)(2906002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5976;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4yGV/Hs8MVsUdRUx/CeCcDFl2ZpTJ50OQXAzL0L5DZtvleSPbn3qHxFpvABPZiTGzFfWOHhFzN+eNci2LrhbwGMC6w2/+tAyQcX1BHY+2NSgbhc+emtyZOG+qVw6z1IXFVoAxQ60KB6utE7bHRRxugfQRDPFCzhttlDfeL04otugOjdwuEpi8M+ldv/CQOD9zI4KapSJ2EH5OsRQRADF27uMIuHJ4/RrbcbWzUiRm+p3miOW1JCW/o3+1XSSEprxfmir7NG59Th2CgX7RqBhY8U+kpKBTdJL9/Wp5hb6XhHfGTn9YNSrUxVztZbatpY/NbUONekaW8UbLC99mr9cew7d18ivszrA+phxN54euua7YoG3XXWj1N5EgZGWCjiFs3vlVkdH7oJXA8C+pp9KX6qLJ6TZ+pv2pBJYsOWq2ZU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b78833-d61c-4369-7737-08d689d07a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 12:09:41.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5976
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
Any comment on this patch ?=0A=
Note: I tagged the patch with=0A=
=0A=
Fixes: 49f6613632f9 ("nullb: remove leftover legacy request code")=0A=
=0A=
but it the correct tag should probably be:=0A=
=0A=
Fixes: e50b1e327aeb ("null_blk: remove legacy IO path")=0A=
=0A=
=0A=
On 2019/01/28 8:56, Damien Le Moal wrote:=0A=
> When null_blk queue mode is specified together with modprobe/insmod, a=0A=
> check to prevent setting the nullb device queue mode to 1 (NULL_Q_RQ) is=
=0A=
> done. However, the same check is not performed when setting up a nullb=0A=
> device through configfs, resulting in a oops (NULL pointer dereference=0A=
> for the device request queue).=0A=
> =0A=
> Fix this problem by checking for an invalid queue mode value in=0A=
> null_validate_conf(), propagating -EINVAL to null_add_dev() if the queue=
=0A=
> mode is NULL_Q_RQ. While at it, also fix the propagation to user space=0A=
> of null_add_dev() return value when a nullb device is created through=0A=
> configfs power attribute.=0A=
> =0A=
> Finally, remove the "1=3Drq" value from the list of possible values for=
=0A=
> the queue_mode attribute/module argument to make it clear that this is=0A=
> no longer a valid setting.=0A=
> =0A=
> Fixes: 49f6613632f9 ("nullb: remove leftover legacy request code")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
> =0A=
> Changes from v1:=0A=
> * Removed reference to rq mode from queue_mode description=0A=
> =0A=
>  drivers/block/null_blk_main.c | 24 ++++++++++++++++++------=0A=
>  1 file changed, 18 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 62c9654b9ce8..155dcef3b21a 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -130,7 +130,7 @@ static const struct kernel_param_ops null_queue_mode_=
param_ops =3D {=0A=
>  };=0A=
>  =0A=
>  device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0=
444);=0A=
> -MODULE_PARM_DESC(queue_mode, "Block interface to use (0=3Dbio,1=3Drq,2=
=3Dmultiqueue)");=0A=
> +MODULE_PARM_DESC(queue_mode, "Block interface to use (0=3Dbio,2=3Dmultiq=
ueue)");=0A=
>  =0A=
>  static int g_gb =3D 250;=0A=
>  module_param_named(gb, g_gb, int, 0444);=0A=
> @@ -318,9 +318,10 @@ static ssize_t nullb_device_power_store(struct confi=
g_item *item,=0A=
>  	if (!dev->power && newp) {=0A=
>  		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))=0A=
>  			return count;=0A=
> -		if (null_add_dev(dev)) {=0A=
> +		ret =3D null_add_dev(dev);=0A=
> +		if (ret) {=0A=
>  			clear_bit(NULLB_DEV_FL_UP, &dev->flags);=0A=
> -			return -ENOMEM;=0A=
> +			return ret;=0A=
>  		}=0A=
>  =0A=
>  		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);=0A=
> @@ -1561,8 +1562,13 @@ static int null_init_tag_set(struct nullb *nullb, =
struct blk_mq_tag_set *set)=0A=
>  	return blk_mq_alloc_tag_set(set);=0A=
>  }=0A=
>  =0A=
> -static void null_validate_conf(struct nullb_device *dev)=0A=
> +static int null_validate_conf(struct nullb_device *dev)=0A=
>  {=0A=
> +	if (dev->queue_mode =3D=3D NULL_Q_RQ) {=0A=
> +		pr_err("null_blk: legacy IO path no longer available\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
>  	dev->blocksize =3D round_down(dev->blocksize, 512);=0A=
>  	dev->blocksize =3D clamp_t(unsigned int, dev->blocksize, 512, 4096);=0A=
>  =0A=
> @@ -1588,6 +1594,8 @@ static void null_validate_conf(struct nullb_device =
*dev)=0A=
>  	/* can not stop a queue */=0A=
>  	if (dev->queue_mode =3D=3D NULL_Q_BIO)=0A=
>  		dev->mbps =3D 0;=0A=
> +=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=0A=
> @@ -1620,7 +1628,9 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>  	struct nullb *nullb;=0A=
>  	int rv;=0A=
>  =0A=
> -	null_validate_conf(dev);=0A=
> +	rv =3D null_validate_conf(dev);=0A=
> +	if (rv)=0A=
> +		goto out;=0A=
>  =0A=
>  	nullb =3D kzalloc_node(sizeof(*nullb), GFP_KERNEL, dev->home_node);=0A=
>  	if (!nullb) {=0A=
> @@ -1648,8 +1658,10 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>  		if (rv)=0A=
>  			goto out_cleanup_queues;=0A=
>  =0A=
> -		if (!null_setup_fault())=0A=
> +		if (!null_setup_fault()) {=0A=
> +			rv =3D -EINVAL;=0A=
>  			goto out_cleanup_queues;=0A=
> +		}=0A=
>  =0A=
>  		nullb->tag_set->timeout =3D 5 * HZ;=0A=
>  		nullb->q =3D blk_mq_init_queue(nullb->tag_set);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
