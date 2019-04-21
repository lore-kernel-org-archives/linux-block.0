Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B20FC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B25520652
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ntnf4XIU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hw47RXWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfDURjk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:39:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63688 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDURjk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 13:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555868380; x=1587404380;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=45Y1IhsSsae35xuLcBsfEN59p9ELFOdy5NOVTYyqEaU=;
  b=ntnf4XIUaM9YFYo00a0ZRjOmVXz4Cfh0ac6W3J2JmnzC9o5bwM56m2/z
   ELvnHUnwvXIfvXS/CAK1nDFah3EOc8NNydwcmJMH9+XehWXlRNfL3ICd3
   7gpVrk781j5L3wzs+gh/xn/Q8HrlSfIWATlG+ZuroySd/Ejorrgdc5rpH
   XQxVreWY5HHiVKxighq0cdHJvGE9lxmGDA92R6DPqNrnVEZsTh9KtjAnP
   bRy+qlZ6GVacGIIYG+M5x6DgPMxrtGSGL2v5Moa2nSwSYDZp7923j5/4A
   N/QzO6iXGktoNMNKILJYWTYlGytG6m9at9WawdLqDxLAj/nQSZ6czKsOu
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,378,1549900800"; 
   d="scan'208";a="111410908"
Received: from mail-co1nam03lp2056.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.56])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2019 01:39:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6hbR5qWaL+VhzYbumPrhN2fNqf9GXO2Fm5KTHT4ZQA=;
 b=hw47RXWE96rKDpKw1pkhndk32bIbl1AK/Y9xSVvIVA0V3DS5Bdud+a+mu0fCw5l8sX1lUxJBVzJ8jdnb7PKJtrZgrkonmIfrMBBJMfL6/ntmzM51i7JWLEHO1gbttUo6cTxykHe81U+6BbtVWKmdJQbGaRt8kYpxxp73FwGohP8=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4462.namprd04.prod.outlook.com (52.135.119.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 17:39:35 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 17:39:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, Greg Edwards <gedwards@ddn.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper
 function
Thread-Topic: [RFC PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper
 function
Thread-Index: AQHU9/XVqKB3+bQh5EuEtRIaXnrq0g==
Date:   Sun, 21 Apr 2019 17:39:35 +0000
Message-ID: <SN6PR04MB45274B06F05A56F1E07BF17586210@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190421035328.19322-1-marcos.souza.org@gmail.com>
 <20190421035328.19322-2-marcos.souza.org@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f43e16c1-d8e5-4bb1-1b8a-08d6c6805235
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4462;
x-ms-traffictypediagnostic: SN6PR04MB4462:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB44626CAE809C76E7434CEF6386210@SN6PR04MB4462.namprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(478600001)(6116002)(66066001)(3846002)(71200400001)(71190400001)(6246003)(2501003)(14454004)(4326008)(305945005)(97736004)(6506007)(186003)(102836004)(74316002)(7736002)(72206003)(26005)(53546011)(33656002)(86362001)(2906002)(446003)(25786009)(486006)(476003)(7416002)(5660300002)(110136005)(14444005)(99286004)(316002)(73956011)(66946007)(9686003)(55016002)(52536014)(68736007)(66446008)(6436002)(8936002)(7696005)(91956017)(8676002)(229853002)(76116006)(81156014)(81166006)(66556008)(256004)(76176011)(53936002)(64756008)(54906003)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4462;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5SyME2MCF8gqX6hvaonBUUrVsVOeQz2yd0Bh1ZF5enFJskbvmm0Al5vhBOaqAvj3oMZr6iEalCO9ud4vAfI1zzpDsLu+OC7oYMKJxW9tEnQ8tYZmzEPOTWulYRWiw7yxBcTkE50kt+IppNp5QRS4m0+ymwRScehOHQMGPxZjN4vJwSs9yN32StpNRMat3ny+4BKSBWkZpHVJVM9TzeW663w/2xgt5iKsp9rXyrp/dFktKNfqG+b97Djz55HlD55t19YYbIbaWsNC9s4E15ZEyAnyhXv4eTjEQV3SW0TVO4Vrr6uXtVlPt58lf9s5BskYZ4p8i9RlCVlLPzXhfmLc/PM30/DsnJwMXVtoyEp2BVKaQhHXBFM8snTmNoy735BhLukzDEf3d/tREH/vIG/+9GuqUqyjwB8v1pxKUPzoukg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43e16c1-d8e5-4bb1-1b8a-08d6c6805235
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 17:39:35.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4462
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good, with one small comment.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/20/2019 08:53 PM, Marcos Paulo de Souza wrote:=0A=
> This function takes an argument to specify the size of a block device,=0A=
> in bytes, and return the number of sectors of 512 bytes.=0A=
>=0A=
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>=0A=
> ---=0A=
>   include/linux/blkdev.h | 18 ++++++++++++++++++=0A=
>   1 file changed, 18 insertions(+)=0A=
>=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 317ab30d2904..7bf7b99161b7 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -871,6 +871,24 @@ static inline struct request_queue *bdev_get_queue(s=
truct block_device *bdev)=0A=
>   #define SECTOR_SIZE (1 << SECTOR_SHIFT)=0A=
>   #endif=0A=
>=0A=
> +/**=0A=
> + * size_to_sectors - Convert size in bytes to number of sectors of 512 b=
ytes=0A=
> + * @size: size in bytes to be converted to sectors=0A=
> + *=0A=
> + * Description:=0A=
> + * Kernel I/O operation are always made in "sectors". In order to set th=
e=0A=
> + * correct number of sectors for a given number of bytes, we need to gro=
up the=0A=
> + * number of bytes in "sectors of 512 bytes" by shifting the size value =
by 9,=0A=
> + * which is the same than dividing the size by 512. For example, for a c=
apacity=0A=
> + * of 32M (33554432 bytes), the number of sectors will be 65536.=0A=
I am not sure we need an example because description prior to the =0A=
example and the code is self explanatory.=0A=
> + *=0A=
> + * Returns the number of sectors by the given number of bytes.=0A=
> + */=0A=
> +static inline sector_t size_to_sectors(long long size)=0A=
> +{=0A=
> +	return size >> SECTOR_SHIFT;=0A=
> +}=0A=
> +=0A=
>   /*=0A=
>    * blk_rq_pos()			: the current sector=0A=
>    * blk_rq_bytes()		: bytes left in the entire request=0A=
>=0A=
=0A=
