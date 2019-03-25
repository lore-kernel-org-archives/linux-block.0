Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C240EC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832162087F
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TaVRGuJR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mfZlKauX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfCYFKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:10:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45349 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCYFKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553490623; x=1585026623;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LCtk6adIZ1bumGj1iF0vPN6aPxxRKzPRuvhkDKIMUdc=;
  b=TaVRGuJRt8OIePkrczjy+xzNoia4iOrHz8mOrqKEViG4RPAU3iC6fTmh
   ua4M61uVdPswk6gzdUAnpeDxFVfY5BnKL1aysIJqo002EWvhC2kYfa49v
   /BwIaJ+oJFmwCIiaPfPI14Y5AR5r0p3l5nL2WAjxVvW0JpO9tmfvYAYWe
   357w0VyT3MqhaSOhyq6yg+FvPXv87AhCIG/cjcc2RYRe1Km+URjiLAGdB
   y4Sd50CRI5VqcHEeXm/XfrCB00d1Pf4ApXqxCADOpal/QAoVQ/oAhuw0/
   8lSmrfRlihzFYdsQG/yBtC7GM1fArgxZcGqoVhVewNC+XU++HeMa1J8ut
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105485582"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:10:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+/qztYzUaCicFaAiZOdq1shsvBlBseMYe5tgrcqFDQ=;
 b=mfZlKauXzydAVTHfTLCe4sSEZ8oVyJtziW0DWrvntHLYGlxY5TzO1tYwnXTKF4KFxrQQe7YW1u/8bhufaFWAMNRvQsxERuUHrriv7FM0By1LEamXLQDMwj+C2mEznWIeCfmwWEwdnEc4H47y8QyOCmvoD3+pbozrKDyX0yqxFg4=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4685.namprd04.prod.outlook.com (52.135.122.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 05:10:20 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:10:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 02/15] block: add a rq_integrity_vec helper
Thread-Topic: [PATCH 02/15] block: add a rq_integrity_vec helper
Thread-Index: AQHU4Dtig9Db1SixgE2Ks2uhDtxK8w==
Date:   Mon, 25 Mar 2019 05:10:20 +0000
Message-ID: <SN6PR04MB4527A9C0E360C5991F9E00A6865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [65.123.219.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe3aee37-0283-46d5-9ac6-08d6b0e02d81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4685;
x-ms-traffictypediagnostic: SN6PR04MB4685:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB46850EC44F03AA20BA7DD823865E0@SN6PR04MB4685.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(71200400001)(52536014)(9686003)(74316002)(478600001)(55016002)(71190400001)(14454004)(25786009)(6116002)(86362001)(3846002)(2906002)(53936002)(4326008)(99286004)(6246003)(72206003)(305945005)(446003)(33656002)(7736002)(486006)(476003)(186003)(6506007)(316002)(53546011)(97736004)(68736007)(66066001)(7696005)(110136005)(54906003)(106356001)(6436002)(102836004)(26005)(256004)(76176011)(81166006)(14444005)(105586002)(229853002)(8936002)(8676002)(81156014)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4685;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bHbmTMUdrCHliGMr9CYma+dLlIF5rw9sRag4/W0e8PWF0Rct9FPEK9kGAW8zwOh6R93cK4f4lNdpO11t0Jtzp5L4u2QFVA0bMeADScBUuhluIQyHXweHeWMsKGm809LUN17Qh1c1u7dQy9LB8G0iAkg8o78Xmp2q2Nf9uGlsmFBDNeg6/VrsQ19a/1bZTKtUW6nql/Kme/KWXw9zeg6mRVYZoCZBzuKI58H2NgVv4N+aWxJ382zqouho7OO42PByovSehlRhg9Kmykxj37yo8Igp28cMPKXNf4Y1Io/xeJ75bpQXxUvNKAN+kPu+/UgomVVd8sXFvvqf4e4MUhXp8JJBgO0mYi8bUy5mnLBG6fBjruTwwyqeRK+Avu0Fz5YL3844nF/7FD2EYzpg7GiA02AdOKvb6pq/dzw06/jz1+Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3aee37-0283-46d5-9ac6-08d6b0e02d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:10:20.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4685
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 4:11 PM, Christoph Hellwig wrote:=0A=
> This provides a nice little shortcut to get the integrity data for=0A=
> drivers like NVMe that only support a single integrity segment.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   include/linux/blkdev.h | 15 +++++++++++++++=0A=
>   1 file changed, 15 insertions(+)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 255e20313cde..f9a072610d28 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1552,6 +1552,16 @@ static inline unsigned int bio_integrity_bytes(str=
uct blk_integrity *bi,=0A=
>   	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;=0A=
>   }=0A=
>   =0A=
> +/*=0A=
> + * Return the first bvec that contains integrity data.  In general only=
=0A=
> + * drivers that are limited to a single integrity segment should use thi=
s=0A=
> + * helper.=0A=
> + */=0A=
> +static inline struct bio_vec *rq_integrity_vec(struct request *rq)=0A=
> +{=0A=
Wrt comment, should we add a check here to make sure underlaying driver=0A=
has limited single integrity segment ?=0A=
> +	return rq->bio->bi_integrity->bip_vec;=0A=
> +}=0A=
> +=0A=
>   #else /* CONFIG_BLK_DEV_INTEGRITY */=0A=
>   =0A=
>   struct bio;=0A=
> @@ -1626,6 +1636,11 @@ static inline unsigned int bio_integrity_bytes(str=
uct blk_integrity *bi,=0A=
>   	return 0;=0A=
>   }=0A=
>   =0A=
> +static inline struct bio_vec *rq_integrity_vec(struct request *rq)=0A=
> +{=0A=
> +	return NULL;=0A=
> +}=0A=
> +=0A=
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */=0A=
>   =0A=
>   struct block_device_operations {=0A=
> =0A=
=0A=
Otherwise looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
