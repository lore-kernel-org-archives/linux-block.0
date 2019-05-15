Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5036C04E53
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CE720818
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dVw5mkEl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R9Njh5su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfEOPuZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 11:50:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32088 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfEOPuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 11:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557935424; x=1589471424;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M4QEg4/r+U32QXpovzAyYxcSriumYctM3NFha3/dcGM=;
  b=dVw5mkEl5egJhDJVbtIiF+aCAeTnMKuS1xv7QVBFxO5r5mClSxHsrGLI
   V88JE85Ac0reQgXP968/yx0lQK6KhYwK01Eut3hM7QxhZXFf4O2p+1Zgn
   lK7vEFuC71QNKe3jK0LfJZfXy4bJ+vyllrnSeLHd/TO0UPHYuG5DTd0wf
   6kZRsd2tGU5OMpQgv1hKr9BkHXf0Sjp3ixojeXp+RaXKdSPeA+q+Grmck
   Yq4ls6axOwcy8/BYz+jjfkOm4wEuXrxu0H7RI0JHe+TK6lzmjcE5gjkYe
   vmAo9FapyKVFBTsQt015tX+DheP7lPbxQVhE5UIiQz63rNpdfV1NRuYq6
   A==;
X-IronPort-AV: E=Sophos;i="5.60,472,1549900800"; 
   d="scan'208";a="108339906"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2019 23:50:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhqKXj5fw6TcC3AgCBZWgGGReC72ByiwWWJx8oZgMRU=;
 b=R9Njh5suzNTrVgmCwWQ3Qu8E239xRI9fJKzEMCPQVHDPdzGCJmJZ4hxRicFezUEs2Dc/Oeb2yVxhqWNJl4lsmZ2JmLLh7oopOs8/oK+o/u9RnEDr45Tc5BjnoeW00qKVgUv09HQdg3yqRyQHsvhXx5zdXdbAB6Ia7n8jKlcPMXQ=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4079.namprd04.prod.outlook.com (52.135.82.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 15:50:21 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 15:50:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jackie Liu <liuyun01@kylinos.cn>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/bio-integrity: use struct_size() in kmalloc()
Thread-Topic: [PATCH] block/bio-integrity: use struct_size() in kmalloc()
Thread-Index: AQHVCv014WJjQIyFXEiQsTcxkmVgXg==
Date:   Wed, 15 May 2019 15:50:21 +0000
Message-ID: <SN6PR04MB4527E5E4327E1C87CA4C704C86090@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1557910339-2140-1-git-send-email-liuyun01@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7b32f84-6d35-4a8d-7da4-08d6d94d09bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4079;
x-ms-traffictypediagnostic: SN6PR04MB4079:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB40794E8ED6F31E7EEB2E2DE486090@SN6PR04MB4079.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(53936002)(6436002)(2906002)(73956011)(2501003)(110136005)(14454004)(316002)(99286004)(9686003)(229853002)(74316002)(4744005)(478600001)(86362001)(33656002)(55016002)(5660300002)(6246003)(8936002)(305945005)(446003)(81156014)(8676002)(81166006)(66066001)(476003)(52536014)(66446008)(64756008)(66556008)(7736002)(76116006)(91956017)(66476007)(68736007)(66946007)(72206003)(486006)(186003)(76176011)(26005)(7696005)(71190400001)(71200400001)(6116002)(3846002)(102836004)(4326008)(256004)(6506007)(53546011)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4079;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SgAGdmETD0mIsTmviKqR+r4vN3S0TBad1/sVSU872wGtUJDCuRe2nFvx4XWbSljWsGnFQ5wzXLJYT4lFxZS//4ID3Vz530dYfxfHMXwJg0HSPICt6fNqumAnKViMdD6pPPnKmmAichIGpfWhtuG8yf1OwODFQcgIM8CGrw383oG6YIpc8DNi298Bp31TLhn1Z3AK9/Dw4H/il/1o6re4hD5rDw6dqO87r0mqVrLS1+FX2Z3LoBu9IjjVvUnWBKrxbdLW6Kcy6BPQko2nUt0mgxCSZjzto5g9nSvXdoJmEIA6u5RocB77gbHRbc0NkqpVk7Xt9y0r/NCMwXluSOVOJE1I1GGt05FKrAnEaH4RZb1PO9giz40sxGMQTh6bUxpjGKKPikJgvC2QiYtI2XAYGWpdEcL6Z9CRGaPfOn0hsIs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b32f84-6d35-4a8d-7da4-08d6d94d09bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 15:50:21.7119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4079
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 05/15/2019 02:04 AM, Jackie Liu wrote:=0A=
> Use the new struct_size() helper to keep code simple.=0A=
>=0A=
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>=0A=
> ---=0A=
>   block/bio-integrity.c | 3 +--=0A=
>   1 file changed, 1 insertion(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c=0A=
> index 1b633a3526d4..5152009b5b59 100644=0A=
> --- a/block/bio-integrity.c=0A=
> +++ b/block/bio-integrity.c=0A=
> @@ -57,8 +57,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struc=
t bio *bio,=0A=
>   	unsigned inline_vecs;=0A=
>=0A=
>   	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {=0A=
> -		bip =3D kmalloc(sizeof(struct bio_integrity_payload) +=0A=
> -			      sizeof(struct bio_vec) * nr_vecs, gfp_mask);=0A=
> +		bip =3D kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);=
=0A=
>   		inline_vecs =3D nr_vecs;=0A=
>   	} else {=0A=
>   		bip =3D mempool_alloc(&bs->bio_integrity_pool, gfp_mask);=0A=
>=0A=
=0A=
