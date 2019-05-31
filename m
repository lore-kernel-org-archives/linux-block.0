Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53ACC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8521125715
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AAA1g8EP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kdXHhXAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEaCES (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:04:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10958 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCER (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268257; x=1590804257;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zT/9XQdZGtBjPH2JHPq+w/uFi0y8/x1J/52VxKihfLk=;
  b=AAA1g8EPEgjSNhVCFEgdVi6fv+yjKimgJ0pirLLeQ9wDoBa9GYay8Y0P
   mvKtPLYOKKtscCd60CkTqR5kAHr1Qu8fFrQA77488lw2QqzWZAKxdxpx1
   RNgTqH1DZb1pKXSxlt00JZ6hlZ+K5lksA3fQwiuOGJwJb5/ZNJsz2VN+S
   QTvweS9reChzmi/xoatHXZGXGSr08lmFvE3V4I1gdWu7Ux9rmd8hyyvbz
   hFuAwluBCwhvLj9PaQFdy+LkpYj9STObzLVcxa9zxgiZhLK48oVzr3gI1
   wKmG+AMS5O1m9FcPti/rCC5LOAjUR3he/kKXoRjFKvuLpBUG7Tfpn8xUs
   g==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="215702744"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:04:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We84O8y2R8khIfgHFmu0CzfNC58++M4Bo0Q9ZAMt9Qo=;
 b=kdXHhXAYCiCvxZJirsKtwQ1b5QoRhldXaSmzgOEiIqqxy65tymNCH8LfU7zsL+KuWggmUyITOaKOTCg0y5dXEs+X21Bo8t5jR0r42JKNTv/4NbapnWl68GfVmJbZGTOHPQeBUPW8p0uzPLT2/8Q1OmjvDO0OZoL8N1CoDsSBrXs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5670.namprd04.prod.outlook.com (20.179.57.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:04:14 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:04:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 8/8] blk-mq: Document the blk_mq_hw_queue_to_node()
 arguments
Thread-Topic: [PATCH 8/8] blk-mq: Document the blk_mq_hw_queue_to_node()
 arguments
Thread-Index: AQHVF0P2ySxmikNy50ukt9BQwejo8g==
Date:   Fri, 31 May 2019 02:04:14 +0000
Message-ID: <BYAPR04MB5749B9F1F07249B8650FD48586190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-9-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce69330a-7210-455d-f82e-08d6e56c480d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5670;
x-ms-traffictypediagnostic: BYAPR04MB5670:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB567019F5E06FE6838CA9C00086190@BYAPR04MB5670.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(5660300002)(6116002)(53546011)(3846002)(4744005)(6506007)(64756008)(66446008)(66946007)(66556008)(66476007)(6436002)(76116006)(73956011)(102836004)(446003)(99286004)(476003)(68736007)(7696005)(229853002)(6246003)(76176011)(2906002)(53936002)(86362001)(74316002)(52536014)(305945005)(110136005)(26005)(54906003)(7736002)(4326008)(14454004)(478600001)(256004)(55016002)(186003)(8676002)(25786009)(316002)(72206003)(9686003)(33656002)(14444005)(8936002)(486006)(66066001)(71200400001)(81166006)(81156014)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5670;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TltzPcGIYdlbrNOuocC2W0NIv6/mDq9R1HbAQU5jIl5dpGkYnt0OIk3pDGIxibkTqWiLzLgQeG8H5NHU784iZl6r6sGKApJ4i/TsZkTo3BsDkp8WKd5q3/Q0D1LkbNdhaWorgXPIl1AYL5jhJ0ksJHnEoCP9znBly1l23x0d9+wMMagWgMLZqPMqhK+mFeWwrq4z3flFiDqGD4jWnug9Xzrbif9zr8IEQnriBxkHFEdI+jPm8BMbmYgqo5oTsaQGXVFQzGaJDWJ878z6UCeoMIlkoSjwRrni6mcf0Z9qJ+ZkmTDOswWbpxWYDn/i7qM359k6tsOZAE5MAZP6zJhSWieSn3N6IJOWH71t2a+29fC2Kt7ry6DV6HpOHjWG03r3TStGzlD1MgRdng2BmOpsYmtURjHBYWxxADlwR8o5ebc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce69330a-7210-455d-f82e-08d6e56c480d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:04:14.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5670
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chiatanya.kulkarni@wdc.com>=0A=
=0A=
On 5/30/19 5:01 PM, Bart Van Assche wrote:=0A=
> Document the meaning of the blk_mq_hw_queue_to_node() arguments.=0A=
> =0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/blk-mq-cpumap.c | 6 +++++-=0A=
>   1 file changed, 5 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c=0A=
> index 0afa4dc48365..f945621a0e8f 100644=0A=
> --- a/block/blk-mq-cpumap.c=0A=
> +++ b/block/blk-mq-cpumap.c=0A=
> @@ -60,7 +60,11 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)=
=0A=
>   }=0A=
>   EXPORT_SYMBOL_GPL(blk_mq_map_queues);=0A=
>   =0A=
> -/*=0A=
> +/**=0A=
> + * blk_mq_hw_queue_to_node - Look up the memory node for a hardware queu=
e index=0A=
> + * @qmap: CPU to hardware queue map.=0A=
> + * @index: hardware queue index.=0A=
> + *=0A=
>    * We have no quick way of doing reverse lookups. This is only used at=
=0A=
>    * queue init time, so runtime isn't important.=0A=
>    */=0A=
> =0A=
=0A=
