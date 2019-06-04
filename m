Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CAC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 05:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421BF241D0
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 05:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YltHX7MS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ol9+dMkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFDFdx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:33:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47088 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFDFdx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 01:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559626433; x=1591162433;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+1Zc+UXlRdf7glF1UNNa9ymBNZ8pG+vqB4AZQjQyfD8=;
  b=YltHX7MS8aHTkEZaSPEm5yLVDY4P5tOuPTPohNtBxf9zKiyMI8dBmRbB
   uaAL2hDjzhKQEmGBKVOk7FDaxgbjUhDGWUhrSRM0st/eqwtZLsUh1JuuC
   FIyu4I6aNbFvrZtJABymKfDp4C5ptlIY2mxcDWK80JuIDaQPLS/LXV2A3
   6w+7jFvEqQCsxG365q4Po/Gtc267nr44E3BzKCgL/NnDGlHrj0YBcVJMi
   7tF0FWjH/5ZeAzgtqeSsgNzBsoHZLyW/jVLyfz8K1j8hu4Zz+oU+wxCOV
   SoTdzOcBoi+Thn95tksnyggCLwlmuK490d7zuoIkHKb4izdT9REy8BKGw
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,549,1549900800"; 
   d="scan'208";a="111407025"
Received: from mail-sn1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.54])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2019 13:33:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zTPDrfSXTOMvgAXXzDH79aewavvlsT+S6wzjhHscFQ=;
 b=Ol9+dMkrpYWIk/1m2yg4ag5uFR2t1bpZSfX5yqjl0FI454BcUZSJidYiXI7IlMWsQ2bZ4ax0nRkxs4BJh8sZKLvlrWKKS+KEpzDtyFU9VPfSqAGCQMr63kGmQDGkZ7B8JvUvkkJ8THq1rutcpJyH7GEnO7UGHQcSdaTE4aekyFY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5015.namprd04.prod.outlook.com (52.135.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 4 Jun 2019 05:33:49 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 05:33:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Lin Yi <teroincn@163.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "liujian6@iie.ac.cn" <liujian6@iie.ac.cn>,
        "csong@cs.ucr.edu" <csong@cs.ucr.edu>,
        "zhiyunq@cs.ucr.edu" <zhiyunq@cs.ucr.edu>,
        "yiqiuping@gmail.com" <yiqiuping@gmail.com>
Subject: Re: [PATCH 2/2] block :blk-mq-sysfs :fix kobj refcount imbalance on
 err return path
Thread-Topic: [PATCH 2/2] block :blk-mq-sysfs :fix kobj refcount imbalance on
 err return path
Thread-Index: AQHVGoq7WoH0FASrnkqo69Dinxfcyw==
Date:   Tue, 4 Jun 2019 05:33:49 +0000
Message-ID: <BYAPR04MB5749C8264F818DEF958DA48F86150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <cover.1559620437.git.teroincn@163.com>
 <249f0ba61c63520ef1608503c3be16daebf5a30f.1559620437.git.teroincn@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 300a017e-406e-4626-9fab-08d6e8ae38ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5015;
x-ms-traffictypediagnostic: BYAPR04MB5015:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB50154973638797E9B873237086150@BYAPR04MB5015.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(68736007)(486006)(14454004)(26005)(186003)(229853002)(446003)(478600001)(72206003)(2906002)(86362001)(52536014)(6116002)(4744005)(5660300002)(2201001)(66066001)(316002)(2501003)(14444005)(256004)(76116006)(66446008)(64756008)(66556008)(74316002)(66476007)(66946007)(73956011)(4326008)(25786009)(6246003)(6436002)(9686003)(55016002)(7696005)(53936002)(76176011)(6506007)(53546011)(102836004)(476003)(71200400001)(71190400001)(3846002)(33656002)(81156014)(8676002)(110136005)(54906003)(8936002)(99286004)(7736002)(81166006)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5015;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W6kcp7skJxl/PFK4LGDafoJcAKb7vYuQiPSw6aVjK12rg/bYJD+lRSkiF6Ts2zUUI5KnnH/mlsuN0+n8pKwVjwVn9Z2JjZb9aFHTSevRb5dtObF9iC6hH7BBQ5Zka2vPtQlylJp2dC5v4IvTFeG1PzCGgxUCNd8tRInbHBoCeJZKGPtic0cQaZtCZ1YKOyfg9i2pLtltcB/ertful8aN9ZPC2zi7YJh2skzBxEDeolUKFMxwU8AE3rdKZwR+vlo3b9oBDSVxUnsy6O7mKKy7unCATwBvukQsX4jZ0p3SqYw7FebxvJvGPHy7J5KUCO0e5WXaTLnPX/KmFOBUucfYqet7Xg3EitrZhaKxaib6QnqvCL99lery9SnvZNT3z+hJctUifqk22D0ZXtB+RCh37X7E3bYO5dL+YyuYYF8aieQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300a017e-406e-4626-9fab-08d6e8ae38ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 05:33:49.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 6/3/19 9:05 PM, Lin Yi wrote:=0A=
> kobject_add takes a refcount to the object dev->kobj, but forget to=0A=
> release it before return, lead to a memory leak.=0A=
> =0A=
> Signed-off-by: Lin Yi <teroincn@163.com>=0A=
> Fixes: 7bd1d5edd016 ("Merge branch 'x86-urgent-for-linus' of=0A=
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")=0A=
> Cc: stable@vger.kernel.org=0A=
> ---=0A=
>   block/blk-mq-sysfs.c | 4 +++-=0A=
>   1 file changed, 3 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c=0A=
> index d6e1a9b..7499a47 100644=0A=
> --- a/block/blk-mq-sysfs.c=0A=
> +++ b/block/blk-mq-sysfs.c=0A=
> @@ -323,8 +323,10 @@ int __blk_mq_register_dev(struct device *dev, struct=
 request_queue *q)=0A=
>   	lockdep_assert_held(&q->sysfs_lock);=0A=
>   =0A=
>   	ret =3D kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");=
=0A=
> -	if (ret < 0)=0A=
> +	if (ret < 0) {=0A=
> +		kobject_put(&dev->kobj);=0A=
>   		goto out;=0A=
> +	}=0A=
>   =0A=
>   	kobject_uevent(q->mq_kobj, KOBJ_ADD);=0A=
>   =0A=
> =0A=
=0A=
