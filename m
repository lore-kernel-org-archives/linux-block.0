Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6095BC282E1
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 01:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E71217D9
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 01:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JcpDVz5h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ku3Yr2m9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbfEXBQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 21:16:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388858AbfEXBQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 21:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558660607; x=1590196607;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IeB974Ya9iwJtPASvIx+Vj9cSETsx1ZE1Eb7TH9xYi8=;
  b=JcpDVz5ha1KaAf4km8TTuLxYLJw75/tVD+L68cvAUgz/CXNLKTrQx3vS
   uSmjiV8rceXM/FnbeuK4OIi90c4JaN8FbddohYlQ9Ep14rD6X1JHm82Jd
   yIhGAVDW+FtvNL2V/AFPgMXWGyOosSBxDtA1xMZgT48nRLAsUUjlhVzDG
   /lkXdt80xaz19rXxRusNtyWq8AhTJWlE2Kb5LwMe1TFIWxlNfKJixM3+N
   om0fGXvVSS9LXZlBMFF11puvaQHpRTtn+a8o3QsJOApCX2NOPhJi71JJF
   cDos9APk8vaP7ehzmc1FNfwBhG0JK3iTbIf+SPAwkeOcjBaGQzOn1pWP3
   A==;
X-IronPort-AV: E=Sophos;i="5.60,505,1549900800"; 
   d="scan'208";a="113932308"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 09:16:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCO+4yBvjt5QGQyjBoBl6gpKrh8EJynOBtge2hhm7Pc=;
 b=ku3Yr2m98gZnnmpXq2VNobMWkYIpqq01XRC3/M0LAJTDdZV0e7fAeGLrQkt317zXCaApXlL4Cjwu9GyreW2y25euCahELpZtbBW4ypVdDynbmdxssIMVCZ+mFC0EMLmzFr5ESQx/Uqi/tYzpUlbiPlSKK5o/50/2cFlfMFLcYaI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6183.namprd04.prod.outlook.com (20.178.235.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 24 May 2019 01:16:44 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1922.013; Fri, 24 May 2019
 01:16:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     John Pittman <jpittman@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "djeffery@redhat.com" <djeffery@redhat.com>
Subject: Re: [PATCH] block: print offending values when cloned rq limits are
 exceeded
Thread-Topic: [PATCH] block: print offending values when cloned rq limits are
 exceeded
Thread-Index: AQHVEbFzUNDIy+caP02hj5K05Bz0IQ==
Date:   Fri, 24 May 2019 01:16:43 +0000
Message-ID: <BYAPR04MB5749B68BB9E3BD3B19F006D986020@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190523214939.30277-1-jpittman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03a2dee0-ee2f-4bb4-5da9-08d6dfe57bfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6183;
x-ms-traffictypediagnostic: BYAPR04MB6183:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6183EC04E338646D65D0582186020@BYAPR04MB6183.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39860400002)(346002)(396003)(189003)(199004)(446003)(229853002)(186003)(26005)(7696005)(53546011)(25786009)(6506007)(76176011)(102836004)(74316002)(14454004)(8936002)(52536014)(8676002)(2906002)(54906003)(99286004)(72206003)(81166006)(6436002)(66066001)(486006)(3846002)(6116002)(476003)(86362001)(4326008)(81156014)(33656002)(73956011)(68736007)(9686003)(76116006)(66946007)(110136005)(53936002)(6246003)(2501003)(478600001)(14444005)(256004)(55016002)(305945005)(7736002)(5660300002)(66476007)(66556008)(66446008)(64756008)(316002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6183;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A5b2IyJ2C6G2rjUhCanM5zWyYbvRKxHqMJtC9E/oi00LMz4uBWdgGTkGkij9H5pyYxMP8PdfDR15uqnEmW+pQUqDgStT6zGpXCvf1Iq2olzNKYJEhkpldJm11st0IDBMVPEAisIQZZ+wLMIcCyvDpU/NgM4YOsuUmdQjKBwbhzkytKKIv6YzotB/qjqWRyPylO4KwMLzpXcrPnck6+xUNkjhAwK4qeg4JVgj5uU3H51d5qQcT2o4CvHAsdP5MgxFfrbDQmLCsu/PilzQsqxd3e1cxsfgZjUuie9q+1nvfof+yZG2CXAuAyACGNjYHQJxMiM78yL2u1Z/SKHCJqiws+7za+UXFhpNlpkuQ445TyIJPf5kbODxOyD4cQEA0v0jtZfBRanL2suzuvz0RP3YiHPulYtvykdSNkePf8IESng=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a2dee0-ee2f-4bb4-5da9-08d6dfe57bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 01:16:43.7951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6183
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think it will be useful to print the information along with the error.=0A=
=0A=
Do we want to address the checkpatch warnings ?=0A=
=0A=
WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then =0A=
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...=0A=
#20: FILE: block/blk-core.c:1202:=0A=
+		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",=0A=
=0A=
WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then =0A=
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...=0A=
#31: FILE: block/blk-core.c:1216:=0A=
+		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",=0A=
=0A=
In either case,=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> .=0A=
=0A=
On 5/23/19 2:49 PM, John Pittman wrote:=0A=
> While troubleshooting issues where cloned request limits have been=0A=
> exceeded, it is often beneficial to know the actual values that=0A=
> have been breached.  Print these values, assisting in ease of=0A=
> identification of root cause of the breach.=0A=
> =0A=
> Signed-off-by: John Pittman <jpittman@redhat.com>=0A=
> ---=0A=
>   block/blk-core.c | 7 +++++--=0A=
>   1 file changed, 5 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 419d600e6637..af62150bb1ba 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1199,7 +1199,9 @@ static int blk_cloned_rq_check_limits(struct reques=
t_queue *q,=0A=
>   				      struct request *rq)=0A=
>   {=0A=
>   	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {=
=0A=
> -		printk(KERN_ERR "%s: over max size limit.\n", __func__);=0A=
> +		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",=0A=
> +			__func__, blk_rq_sectors(rq),=0A=
> +			blk_queue_get_max_sectors(q, req_op(rq)));=0A=
>   		return -EIO;=0A=
>   	}=0A=
>   =0A=
> @@ -1211,7 +1213,8 @@ static int blk_cloned_rq_check_limits(struct reques=
t_queue *q,=0A=
>   	 */=0A=
>   	blk_recalc_rq_segments(rq);=0A=
>   	if (rq->nr_phys_segments > queue_max_segments(q)) {=0A=
> -		printk(KERN_ERR "%s: over max segments limit.\n", __func__);=0A=
> +		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",=0A=
> +			__func__, rq->nr_phys_segments, queue_max_segments(q));=0A=
>   		return -EIO;=0A=
>   	}=0A=
>   =0A=
> =0A=
=0A=
