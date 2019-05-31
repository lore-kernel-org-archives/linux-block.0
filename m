Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3AEC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EABC2600A
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YCEUedZs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FbavtRz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfEaCAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:00:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35876 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfEaCAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559268019; x=1590804019;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hAgpeqpmpmE11tLZizBJKXlfMptMRzijhrChPXzHN04=;
  b=YCEUedZs5qAb/Ygb34sm9jhiNcur2e477v8ygGe9c7KdXyOIp44kdl6k
   NPRaTXlkHnHeyzSWKi5qS1Z2GSB4vfEZAZofOPQQF5XxotE+zAy31Gkau
   w7BPRczGGMKOR1n6JaIDo+GmYsj9ZJlabV63MP4BF+1IMRpFt9nbTUH/x
   VhOrvjNmtlfDBTZ9DuavCOiHoFLgzwUCg/NdTyTel0SRX3D4PdRQFY4g9
   i5c3TlqExwSVnqFunsjXgmTAoAwZyovMqHFZG8YWW8NMJzL72Uq1r5ZmV
   QJoDMaLCngjt+7lcNePLWq1rW+5bBChTXUv76xhMM9cRpqZnuk5DaQP7U
   w==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="114412580"
Received: from mail-bn3nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.54])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 10:00:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p992UdGXt6ChPRg6BaJ3fFWYiZANH4lLmpWpmKvqsq8=;
 b=FbavtRz6Kp6jzJjhy7OJE1fY2jaEjgNMtJ3aFzdflUMzwRL6+NAHfa8S3bibCHo4lSuPzDjdPt0z2PRw73g7JfgM9au0SxXT7NqnqO42lw8YrhIoh38dfoJaANiK6x7LtpZvAvJO0FVCADPtzCLxyjxg075XxpzcBWHxMsoiAxM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5909.namprd04.prod.outlook.com (20.179.59.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:00:16 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 02:00:16 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/8] block/partitions/ldm: Convert a kernel-doc header
 into a non-kernel-doc header
Thread-Topic: [PATCH 1/8] block/partitions/ldm: Convert a kernel-doc header
 into a non-kernel-doc header
Thread-Index: AQHVF0P1Dqu+L2cF7kuXXyeGtnuvgA==
Date:   Fri, 31 May 2019 02:00:15 +0000
Message-ID: <BYAPR04MB57495E48D0CBE8A885B5863886190@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531000053.64053-1-bvanassche@acm.org>
 <20190531000053.64053-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dab7e47-a0bc-41d2-1949-08d6e56bb9c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5909;
x-ms-traffictypediagnostic: BYAPR04MB5909:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB59093D30A389C617BBE1C7D286190@BYAPR04MB5909.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(396003)(39860400002)(199004)(189003)(71190400001)(8936002)(6246003)(71200400001)(4326008)(72206003)(25786009)(7696005)(66946007)(316002)(33656002)(478600001)(73956011)(54906003)(14454004)(76116006)(64756008)(66556008)(66476007)(66446008)(102836004)(68736007)(53546011)(186003)(76176011)(110136005)(26005)(99286004)(6506007)(446003)(256004)(14444005)(2906002)(66066001)(486006)(476003)(229853002)(305945005)(4744005)(6436002)(52536014)(81166006)(5660300002)(81156014)(8676002)(7736002)(55016002)(86362001)(9686003)(53936002)(74316002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5909;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YHczbN08uEVBIo6yz+5ovZ6pkQOPQ06+ZX+vHm/nO5P0Ag9GnadguBjTprbJo5o27A726t5MNMfprMobCttjPnMsksjLp7ArX6ZeepnRP5psfx0RWv6lSIguE+XPJ44Ocxe+bSX6pq1ZEuMEj0ClUoBLyapP4jYu7/K8ygRdMimD8Wjzk2cTs5ulVwjPD73szmxzQOiJaPNcczlc7TRVTW4b8Oi0AqSTqJpMnP2hCGVQGNq6hcKoCudPLJG6nHQlNAxoD4IXKB01iDSNK/2Nz/EKDnnPz3jm1DpkO7cXA4D6OyGXvxdKej/XI9t3t+aAqgE42huh28WW8JyrsuYDBSDxQ+8ikbsIN+k9Qoh3YztW/0hVVhAE1mzobLqepoSN6+U4+hhvV/2nrMdi68A9PK5425erW8W5iHFQdvANDVk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dab7e47-a0bc-41d2-1949-08d6e56bb9c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:00:15.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5909
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chiatanya.kulkarni@wdc.com>=0A=
=0A=
On 5/30/19 5:01 PM, Bart Van Assche wrote:=0A=
> This patch avoids that the kernel-doc tool warns about this function=0A=
> header when building with W=3D1.=0A=
> =0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/partitions/ldm.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c=0A=
> index 6db573f33219..fe5d970e2e60 100644=0A=
> --- a/block/partitions/ldm.c=0A=
> +++ b/block/partitions/ldm.c=0A=
> @@ -19,7 +19,7 @@=0A=
>   #include "check.h"=0A=
>   #include "msdos.h"=0A=
>   =0A=
> -/**=0A=
> +/*=0A=
>    * ldm_debug/info/error/crit - Output an error message=0A=
>    * @f:    A printf format string containing the message=0A=
>    * @...:  Variables to substitute into @f=0A=
> =0A=
=0A=
