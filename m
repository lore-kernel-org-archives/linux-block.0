Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9127EC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20D24A06
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 05:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o147KLlF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jaD60mRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFDFg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:36:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15094 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFDFg1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 01:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559626587; x=1591162587;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6GGAxD8Y0xCjGWKa1ZltfDQavVxEgbG19fD1P8e4GaE=;
  b=o147KLlF8lhEbobhlkV4MWn0gSybKN+KnZ7hqx6mKea6PeBMqjPk3IpA
   CEQITWlOpk2uSOogVJjRN62QpRhG6dVFIaVgOlkMLG5VvEq+nRf5EHD0P
   mtOLYDCTfxbyaSrXjNW7AQNzgjAHOZvN4RsZz/zLxqJKEo0R3/vsO022W
   duqbttkyRl2VQHQuiYKGzx5zEkmf6QoLdlFnDGJ8qkMS4am6JkTyLbZ/z
   F5wWAiJRzk00ioS8iKG9ZcxDkls2j2aX3+UXxCHmsCkeRIKk2z15lFgNJ
   cNMPnrQNB/r0X4SUKsWv1VQjFawdRc7YOVBR+/VGEpqwxfsJagOwsE7QE
   g==;
X-IronPort-AV: E=Sophos;i="5.60,549,1549900800"; 
   d="scan'208";a="114674130"
Received: from mail-co1nam03lp2059.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.59])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2019 13:36:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzegBP+TUMcl3ztpxafUM2PR6MZ951M0uUEvb6nhWaM=;
 b=jaD60mRek0rgtNEmv03RNMiE1g82db1wfYQeFYlHVk5PgTon/uvZMYme1NRaDR3mFWm9WZdRdRlpYf//UVFO8OCxJo+6erCzh22aGg+I80jwjKgT93D19C2hL0DQrL2wDZVuS9RMI3N5tE2JNg1VFDY9G0OKXfBWCauLBxZM8DI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4981.namprd04.prod.outlook.com (52.135.233.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Tue, 4 Jun 2019 05:36:12 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 05:36:12 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Lin Yi <teroincn@163.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "liujian6@iie.ac.cn" <liujian6@iie.ac.cn>,
        "csong@cs.ucr.edu" <csong@cs.ucr.edu>,
        "zhiyunq@cs.ucr.edu" <zhiyunq@cs.ucr.edu>,
        "yiqiuping@gmail.com" <yiqiuping@gmail.com>
Subject: Re: [PATCH 1/2] block :blk-sysfs :fix kobj refcount imbalance on the
 err return path
Thread-Topic: [PATCH 1/2] block :blk-sysfs :fix kobj refcount imbalance on the
 err return path
Thread-Index: AQHVGop5GZHPto8xr0Cneg9tyxfBTA==
Date:   Tue, 4 Jun 2019 05:36:12 +0000
Message-ID: <BYAPR04MB57490EC12E03BDB4FB0E711F86150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <cover.1559620437.git.teroincn@163.com>
 <0c46d61da0fbe9d245ceabd8cb86cdf12008ebec.1559620437.git.teroincn@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25859072-0b57-463d-9a10-08d6e8ae8e59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4981;
x-ms-traffictypediagnostic: BYAPR04MB4981:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB498145D3FE6C602533D402E386150@BYAPR04MB4981.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(39860400002)(376002)(366004)(189003)(199004)(4744005)(2501003)(6246003)(71190400001)(66066001)(6506007)(53546011)(186003)(74316002)(8676002)(52536014)(33656002)(26005)(81166006)(25786009)(8936002)(7736002)(54906003)(72206003)(81156014)(446003)(71200400001)(305945005)(486006)(229853002)(102836004)(5660300002)(99286004)(476003)(316002)(256004)(76116006)(86362001)(76176011)(7696005)(478600001)(110136005)(4326008)(6116002)(3846002)(6436002)(2201001)(14454004)(9686003)(2906002)(53936002)(55016002)(64756008)(66446008)(66476007)(68736007)(66946007)(73956011)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4981;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k5YkenrFZbgKggDFD9j1luMGjvcBaU+zk9Nh4DA9YAgzm4lXYmbu7amCaaaUj2kClGqunXxWEUxlTmWb973UJrcCD3WUU7v1JOxDgCVM0YZ95Gln0Dt1SOsuoCdJMqZbxLoQUxWvcoTHjVf5GMIfkSDYN6eZr5oj3BFlS4/MLqfYb2HHL9zSGQUdwKDI73fNdY56E5HNOhc2pIsTpxfGXwsQ0lPUwC1dfs9hifxO4XgJuaUhh7vVOYCnrg8ERo0JjFiCitD8+7hLvHXX+Up4mhtCL19t+Vl+7VGoG2u6hcbjy6P/TFIXuowC8haOLQ73sPKGxk6SA5wUqrN6Bwf8orUIE6pQId2qToLN+h+zuzFYFXAygTTyqjCuPq+nIzaVsvYD+8aLTgE7/7q/SUVxolvTldsoY+BfJukdG2Yk9jU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25859072-0b57-463d-9a10-08d6e8ae8e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 05:36:12.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4981
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 6/3/19 9:03 PM, Lin Yi wrote:=0A=
> kobject_add takes a refcount to the object dev->kobj, but forget to=0A=
> release it before return, lead to a memory leak.=0A=
> =0A=
> Signed-off-by: Lin Yi <teroincn@163.com>=0A=
> Fixes: 7bd1d5edd016 ("Merge branch 'x86-urgent-for-linus' of=0A=
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")=0A=
> Cc: stable@vger.kernel.org=0A=
> ---=0A=
>   block/blk-sysfs.c | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
> index 75b5281..539b7cb 100644=0A=
> --- a/block/blk-sysfs.c=0A=
> +++ b/block/blk-sysfs.c=0A=
> @@ -971,6 +971,7 @@ int blk_register_queue(struct gendisk *disk)=0A=
>   	ret =3D kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");=
=0A=
>   	if (ret < 0) {=0A=
>   		blk_trace_remove_sysfs(dev);=0A=
> +		kobject_put(&dev->kobj);=0A=
>   		goto unlock;=0A=
>   	}=0A=
>   =0A=
> =0A=
=0A=
