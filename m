Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEE0C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7C25715
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YpZH/gph";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fQ6k8uWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfEaCDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:03:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10915 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268214; x=1590804214;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8hidXlYi5kOFpjCLXGtprcmj9hMp7/GZmKP9clx8ej0=;
  b=YpZH/gphj5EQM5uuDu0rU1nPZaFb4Exbrq/ZxcSauSw/Fl2PQ3hGYrM9
   CtuoK7mrvqqfFpOi3oLEXPqY/KV2QwupoHEp4psglZygucqv1Mft0S+03
   ZNsl8jaBJFdmyPa4uKF2udEzPF7z0SvNfOmy979kuO7YoL5wXn5cfZzhg
   0gG2wZa+X+PHkjsaxm4PK2I8Rce3e7DYmqJN1481qhVK9ymly08Jg+Ctr
   bldIWwGm857uA0HMfRxJY9cgov5YmI+pHcPsuTw06OT8ll4wpQzpJasAZ
   3srSvVsPMEgdVXAIVSdif5JmfXyiRkZFA8e6OaRnE28dskQugBNApjmm4
   A==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="215702665"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:03:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/eqk6o6fukAJqQRL8ICI7ENkV8Kg+pMTZFoohh5WXo=;
 b=fQ6k8uWKSlyn7u3OFx8llV+CTxBb+rqkj7MQq1GoF7TsgyJIlOosRLNMvq8NofknHyUQFu9k9h/q+TLugihD4DpNOM7upj9/wUVu6G1h0wrCuQf99rgSb53Lyz9mV9RTPEgrIShdqaVctllB8HSdYhYvz34eFLPPKgGaA4dOMnc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5670.namprd04.prod.outlook.com (20.179.57.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:03:31 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:03:31 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 7/8] blk-mq: Fix spelling in a source code comment
Thread-Topic: [PATCH 7/8] blk-mq: Fix spelling in a source code comment
Thread-Index: AQHVF0P3IsrmTqzCb0W0hyJ5KaZdnA==
Date:   Fri, 31 May 2019 02:03:30 +0000
Message-ID: <BYAPR04MB5749C7CD5AE65440BFC4E1D886190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-8-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62bcb86a-5606-4e13-8732-08d6e56c2e0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5670;
x-ms-traffictypediagnostic: BYAPR04MB5670:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB56700322A5BB0C5DEAC8AE5486190@BYAPR04MB5670.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(4326008)(256004)(14454004)(478600001)(305945005)(7736002)(54906003)(110136005)(26005)(8676002)(8936002)(66066001)(486006)(9686003)(33656002)(71190400001)(81156014)(81166006)(71200400001)(186003)(55016002)(72206003)(316002)(25786009)(6436002)(66476007)(66556008)(66946007)(66446008)(64756008)(102836004)(76116006)(73956011)(3846002)(53546011)(6116002)(6506007)(5660300002)(53936002)(2906002)(76176011)(86362001)(74316002)(52536014)(68736007)(476003)(99286004)(7696005)(446003)(6246003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5670;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +gR6UFFOCLlE4tbLaznQ4tvHnlww8Za3hiQCNR5OcMbpUHnj+pHcxOA1X3D2/j8V1iRpKVUWtN2mnRXQTvwDLOXvTPWnDnViOBgYn9LILNUb4Fxla6ChRU82oIpBDnVAkTV5nXLvkgeTYIEgZrDOzErpUcBiIuLGe1k4+OdaZHpeg9/60g5upz2RPMcMXLWabNFyrUoETa2rlVe3HcqvDo78ji7PUQ27pHVOD+cSkUFWsg5smBTu+ap6ULsMS5f/LW0zekwYfM8lUdeDB6BpudndJyCgvn9ummvapEw0PQA3/m8yd9NXlIykRWz8t7OpFL9C8Eu0z2bIshM8z54aG3J4gI8joFQG8FAhmmOg9E3gTUy+y9uQ4kQ1xXSgDAL0y6DP5ZShb9oN4taOtuyG101QkTKEBGL7JOE0BKoEH7Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bcb86a-5606-4e13-8732-08d6e56c2e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:03:30.9891
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
> Change one occurrence of 'performace' into 'performance'.=0A=
> =0A=
> Cc: Max Gurtovoy <maxg@mellanox.com>=0A=
> Fixes: fe631457ff3e ("blk-mq: map all HWQ also in hyperthreaded system") =
# v4.13.=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/blk-mq-cpumap.c | 4 ++--=0A=
>   1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c=0A=
> index 48bebf00a5f3..0afa4dc48365 100644=0A=
> --- a/block/blk-mq-cpumap.c=0A=
> +++ b/block/blk-mq-cpumap.c=0A=
> @@ -42,8 +42,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)=0A=
>   		/*=0A=
>   		 * First do sequential mapping between CPUs and queues.=0A=
>   		 * In case we still have CPUs to map, and we have some number of=0A=
> -		 * threads per cores then map sibling threads to the same queue for=0A=
> -		 * performace optimizations.=0A=
> +		 * threads per cores then map sibling threads to the same queue=0A=
> +		 * for performance optimizations.=0A=
>   		 */=0A=
>   		if (cpu < nr_queues) {=0A=
>   			map[cpu] =3D cpu_to_queue_index(qmap, nr_queues, cpu);=0A=
> =0A=
=0A=
