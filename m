Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB022C33CB1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 07:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9204F2187F
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 07:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ej7M5IxH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U6JZWtMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgAOH3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 02:29:17 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21629 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgAOH3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 02:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579073357; x=1610609357;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=soZFibgbYRYOIRmfL8l9Q6VKp/t7E/jNstDOhrskWd8=;
  b=Ej7M5IxHkHR07BAG4/ogcK2PlKGj4JLScYrD7/GrUUFAaghcA/aqd2nM
   L6kk/soW3W7lYXYB1BBICR93f2E0KCX+8Q5YrzYUak8h4eW+K49Kk3GUP
   5BW3mqPKzgL0Hf7dqOPJ0Ik/tu1nvrOtYXq68sXc1h6H2Jjvgr4mTJUi1
   LsyKnwLunOvFld/7dbEDD0PL4jkaVHNJQjjac0oPQkS7GZ21vbL/RxmPb
   do0kN9ldp3RvWL4VNuvsab1CCxIobOH5BAHXFYJX5yqZqGA/o762b21+l
   yaGgFDmEWF+2p+85pOkWpchgYwm8Wb1lXZX+90c4X9uU5EQoI5xL3whyk
   w==;
IronPort-SDR: 75y8TrB4oCW9PINMDmYo6b1HISQZIjhjZhzGBy0Cq0CNCWHqYUoLhFdU/xUucgPFk+jNgRGKM/
 2khwh3etMMu+d5XrDWIKI1wfXzTqnZjZ4Z4Cgjb1J9IzyA6/MNSe3flxp8Rr0bYv331Q4VShKw
 y2xguL5sjTJqzTYuWbo9dKPIYkK4PRlmSIJe5MYdLYAxexfte2b6LesTpOlljHkwnv4wMsnc4Y
 ICDlaKNwjmVrRKt7bBy+f/9+TS3a/dAOOCrKm9DOSphKdgbLMJyyCRzKOcuNVcEPmyFyVmHcma
 yMo=
X-IronPort-AV: E=Sophos;i="5.70,321,1574092800"; 
   d="scan'208";a="235319192"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2020 15:29:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItVqG3t7TI4CIa79mdYxCrN+6AM+PM1OTtBxDbK83LCNRfnkJ7CEdl6DnB2nSTk7zSwxejy4CDQFqMcXg3QzrWeP3w8MsICnuGAHJDvQw33ZI98rOlQe15eFHPEtsfdS9OOic6j5HAO02GA+uYKGGqaxxagTJguWKSPT2aP4RxzE0VkJrQ+FDmNm3IjuY0Y6HCir3uisFYc6V2tT0jZDhV+L8sTF/UkqidAqcftW4RzmwJBsw4ONndKK8FG+njd35mc4nwIjS8Z9CGUg7RQjpoIBWzYzwHX7ii9v6KzOsyZyNpWZZChcEKborVhTYPn8h4BokgjreGstC+Pks9Os2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yer36vDH5fw/qOTHfCzhT+ZtQ9EgNWIRstWqG9yRPmk=;
 b=ekPmnI0LpMB0CrbnevzdMewMG+rQs7SkBPZzmEkdtOqJmqpHM7Coqp66GgVy+0ESl/5S6Wy2qqP0Oc0PDba0H9VK/8MYYWpB0dRDIP5ftaWTnopNect2aVJQRtXDMj3RwpIiv2TtIePYGyEzReBV015G0Kxmc9VNTvhp8SMhanH+wZut5hx945ClAX1r0az+aZOlAeKOouGgy1tLdiK1f+iIMpDvtj4SY+Nn9tBdevdmQ00vzuCa4vQ7evBu0zBn1FFGWEzsAMUksmQn/wD7VlFsT9oBNUvO59J+LTvt4sw1XDrweP0lmHzzIkVFW1FOSgfHF7BTtVCXNy6dPYbCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yer36vDH5fw/qOTHfCzhT+ZtQ9EgNWIRstWqG9yRPmk=;
 b=U6JZWtMZyXFEEXoKFJL7473ipMPAHdq3HpXsA5HCw94sO7jA66aHTKOxsP6EpRPevvVSdjCyyaxfXM5rfVL4+7rM/I8z5/dS9z+gAaxddVUSC7lGZeGDjQvDKy5sd7pmm0Pe2HzSD9nqZE/D8ROkr0W2waeAv1a1oNDXe586cio=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5687.namprd04.prod.outlook.com (20.179.59.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 07:29:16 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 07:29:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Fix zone write handling
Thread-Topic: [PATCH] null_blk: Fix zone write handling
Thread-Index: AQHVxqo3UcNzV3ADyU6cwEKyJH2hUQ==
Date:   Wed, 15 Jan 2020 07:29:15 +0000
Message-ID: <BYAPR04MB58169D42D5D2C23AB20AF0CCE7370@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200109050355.585524-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.180.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a12958e0-9786-4970-423e-08d7998ca047
x-ms-traffictypediagnostic: BYAPR04MB5687:
x-microsoft-antispam-prvs: <BYAPR04MB5687CF79AE1050C16E31BCA9E7370@BYAPR04MB5687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(8936002)(6506007)(53546011)(26005)(186003)(81156014)(81166006)(8676002)(7696005)(478600001)(2906002)(66946007)(66446008)(64756008)(66556008)(66476007)(86362001)(316002)(110136005)(76116006)(91956017)(52536014)(33656002)(9686003)(55016002)(5660300002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5687;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0mM+uOMW6AUE9L41nBqefIK/7UvbENH55hLrB6lvMMXgryRl5eFnjx2cm4fjlijWLigxi4jdZol6aba9cNw1xSLU9ZIzJUA+Y6AVMbRvM1oiDUIeJQcuayEEAuh6KyRQsrrmx6saP5jJEKR0WlYNQkF2okK7A/7daYBLQ0dVmIEvqX8qYDZDLShE8wuX6m4oiSN/kdGSPtI2Gsfj9qo1Kr4bCfNyM9pQgVTXTOCxMGcMNg06zQjJBIXAPzY5P84Ksm75qy8MeJEpppJSWLvre90tchH3qy/DrOFdWzLt2YudPrZ9d7h9j7f5UFAHO4Lgw1Hki/38oPsd9orYv4WWCopAc897M2Q9JYmSuMy79lGz3bVZtHX7QKXyuwaV9L3Ypt9nMkD1R5mYdzkxU73JzvSFmx40052zax75QvZT/nITRHFLFF2uWnEXuOFJ+Eik
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12958e0-9786-4970-423e-08d7998ca047
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 07:29:15.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIVkRR5hyeAhlxtVLOcruCk0EqZX8I2kFF80IXz1JzBVOSn1NLbsfdR3AzFF5t0siCfV9lfYdJAxX61HCp+1xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5687
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
Ping ?=0A=
=0A=
On 2020/01/09 14:04, Damien Le Moal wrote:=0A=
> null_zone_write() only allows writing empty and implicitly opened zones.=
=0A=
> Writing to closed and explicitly opened zones must also be allowed and=0A=
> the zone condition must be transitioned to implicit open if the zone=0A=
> is not explicitly opened already.=0A=
> =0A=
> Fixes: da644b2cc1a4 ("null_blk: add zone open, close, and finish support"=
)=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  drivers/block/null_blk_zoned.c | 4 +++-=0A=
>  1 file changed, 3 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index 5cf49d9db95e..ed34785dd64b 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -129,11 +129,13 @@ static blk_status_t null_zone_write(struct nullb_cm=
d *cmd, sector_t sector,=0A=
>  		return BLK_STS_IOERR;=0A=
>  	case BLK_ZONE_COND_EMPTY:=0A=
>  	case BLK_ZONE_COND_IMP_OPEN:=0A=
> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
>  		/* Writes must be at the write pointer position */=0A=
>  		if (sector !=3D zone->wp)=0A=
>  			return BLK_STS_IOERR;=0A=
>  =0A=
> -		if (zone->cond =3D=3D BLK_ZONE_COND_EMPTY)=0A=
> +		if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
>  			zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
>  =0A=
>  		zone->wp +=3D nr_sectors;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
