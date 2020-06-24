Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD236C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 00:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B97B20675
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 00:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fi+tt44d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Tu6yhU4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbgFXAeA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:34:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7694 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbgFXAeA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 20:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592958840; x=1624494840;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VFe+afEB5iG+BiIuf7N3tP09L3rTA9vQAlxAH20jnkE=;
  b=fi+tt44d7yH1mE3JDUh/zs3WHMmMv5phQyHzLDKsT7Ky8rWVNE22+WRi
   hu2EEdvH6so7H02as75mBGfc4G/uzBQ+EN1lkTJZcMDE0Y9+haW1DPn+F
   W9h0XOTZprPYG4ia7015bHwZVeaFgs/VkDW+7fQlMIb2cicoDUPtCv4nc
   rVY7PnBCh8cDSvMa/59HrSlPv2d00hYqCaXhkBWZWITPGMdFld3HzuqtP
   y/+8vCRc7YDRJibV+0bXocn+GZBLm4fnHVirRyXj/zBOn2UHXuvF1weZG
   8leOs/9V92uRXH4znn21KmRkBm8HgN8wlQA+jj/keANw9lZMxMz1tBPAY
   A==;
IronPort-SDR: fZf422GjZNBh0zeKX4GLSEwFwe7oG71jfUHnneMCJgjqzTaFes/BY3qUfkVjIzIgBob6QvJLtt
 fLejtUN5viX/rj47Q3wXpRSDyA35T63whX+I+BT/CyPOnMmZYl7sPoTzPcVx4CuzYv7UoS2QAN
 0biWg7uqK53saSOsbhSDDWJh70nyJtRLeOMmpLtoSyuZW965kTx/4WLeuZJ5pvgJ9unjnYr1Rm
 Zaxvjw3xzgin55X9/23lXGytdFOZkaQVL+QlkCFIXZ3Fk3Hk4mLil5g86+BzCtbTvf+/F7Nb+E
 nEU=
X-IronPort-AV: E=Sophos;i="5.75,273,1589212800"; 
   d="scan'208";a="145074251"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 08:33:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI0BVzOuQ0n4AaxaplriAi+usTxn1YiUzxw36eyhO/YyDvnB04gEFh/QWUIT/P2HXrSHn3P2CLU2cfXbz2raVwThe3Vtlh+WW1qjKIKKrqbp5JZpANblOqt58meYTjvpTzePrge+lgmhNJsD6vjQ2G/TniVHtwgsgHulkxtuGYjPWrJQqakQqXRrATvWZw13vKp7OVHvUOCJYzGqzY12ljy75vRGtkdd0vAiIH4xQvZN0slxE4DxcTkCxAOC2Am7thLt78Fd3bnqe248dwSIpG/Z7kwDyNtbF3zhCPTlF2JS0RIktq4Fd6Y9j+RC178kSfdKcllJBd00+qZr6vAaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmg+yIw9ZfZDhcnwmjUTjeRVm8tJ5CxnDgRKI4nQASw=;
 b=Pyap4/hsbeqPrSmxxrapTMRrbjA4YIEm2aTzBsF4v1r60nTY3KH7SyW7+f01Zyy1fhgemBUDRfxhHAOWKl6UtcI0jvKAZXVvdn60gyZuTyeAtnKbtPsG2u6ZwjKKHWsGSIlH+dB920+UR3TRqEogttIHGMbm/r7kwRJS1EvP0DOKz2gODn+fDT8mYxSj4D6S8DYunQITN+MdIDNJz3nUN6CdJSsHBBQlFO5YhDgymJeVelrpwsqLo8xFEY2JTfttdm/Cg6/Qowt20hJfIiN/8REZg/swX1jwdeW/pk9tMi71+VIwEaMYU5D/Bk8rnc6NGnD3qDNT4NzHJR+cZ2GPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmg+yIw9ZfZDhcnwmjUTjeRVm8tJ5CxnDgRKI4nQASw=;
 b=Tu6yhU4xhNma4a9BLl97nEY15z/LJFjFO/43OAwgo4tz5QFRsb087tkFQ+NmzkznsdIutQIObQcCFNp3EJ2qVMKHvufRzHt/jTiANBfBuCvfw2cNJ696ijM2Rm10mskfviksX7mwndt8/QCIM25b1BoCPlj6V8A6p/xO6Mznqi8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0343.namprd04.prod.outlook.com (2603:10b6:903:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 00:33:56 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 00:33:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "satyat@google.com" <satyat@google.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: add initial kdoc over the request_queue
Thread-Topic: [PATCH 1/2] block: add initial kdoc over the request_queue
Thread-Index: AQHWSaobgkrHkRgd/kyqGjQRHGO3LA==
Date:   Wed, 24 Jun 2020 00:33:56 +0000
Message-ID: <CY4PR04MB37514525E1A0D6176BFAB11BE7950@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200623220311.8033-1-mcgrof@kernel.org>
 <20200623220311.8033-2-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ea5e32b-81f0-4806-410e-08d817d6478b
x-ms-traffictypediagnostic: CY4PR04MB0343:
x-microsoft-antispam-prvs: <CY4PR04MB03435D30FD01284305E768FDE7950@CY4PR04MB0343.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3PwW/8gTRx5N0EIuUqvWqsyDHfnGN7Uf0A6jSZk/xholjLVil9R8SeiGSLQBVAJTXHV7TdKJq3GyDSNLkwWlX/XFESQ3bG5AgzA1/58ZFIFDLLTDxj77kJxY2uxfp+3UM5e8rgMSaHvTd5vKyxd1A3DcwmI7Qc32KyesDsEqFdUXo34Rwstf0wfGcgwQfL5Lm8+ZgAfS2FcX4kBP5ZOnY5L/ThC2Ai5ETbK2hLtN83oxuzxI/JKjq0+0g8EoR3TyyC6Bp9sPpNE9pMv97MAIJHoiKnsJq3oDE8QAltdZMvD3QTCX6SDLLoU7fwL1OXDQpXnA0RHPOHUZR4NEvqgFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(86362001)(5660300002)(8676002)(52536014)(8936002)(64756008)(66446008)(66946007)(66476007)(83380400001)(71200400001)(66556008)(76116006)(33656002)(91956017)(26005)(4326008)(53546011)(186003)(6506007)(9686003)(55016002)(2906002)(478600001)(110136005)(316002)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: y1cwYZtHytXVyMUu0w86Vm8t1BpT+F0EptwnnxC2LH69aVOUyA/g/lZaPLxP8V5fM21yhrQB3g1mvznc3Y2c/0YyY4fiaE2VYRiIVZrzbDLWl4EcrLtQQMS0nXTaBPPb1yFfGvKCxZ+FZoxlzSjJECJV1C3mOUkgfxlZiUilRHoUsPwch5ZSTIQAlAJChoS5+7sqtIGqtOoiRjTUfC7B3REKZyA5Kxt1eVe48ulKPW6LicTHeaqIwOGcnGmXuA4mOOLz9UOnAv6JiXZ2KfNGvFgQv2a1Qk9kysjtTFyiwB7kPHByHqeHEWwF4deCGesL61IXF1yBV+KdA0tbwx9ZeWoTyq3cXWzy9SqmMapiDz7vV1R3e0QAnETPEde1r1JFoREEDEXeFwGg+uDIK7TMGSJuTxNOOAbqa0efVWn/Wxwdicz0EGf2BnUuqa45OQYWyBQj277eI/8XLmDLgDJwCm+K8z7WqGv4O35Wi/bSJy/lSitNlAsb7HgYXkS7MhzJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea5e32b-81f0-4806-410e-08d817d6478b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 00:33:56.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GtN7x9tHBfdIGfsHpNYdUyyBVFb6zm1hM9WdbhbTBc6EdN+XUuK0BJFNgP3PejH63q+00XYl0YMTXrlayBI6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0343
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/24 7:03, Luis Chamberlain wrote:=0A=
> We start off with an initial description of the request_queue data=0A=
> structure, followed by describing the purpose of the debugfs_mutex=0A=
> debugfs_dir, and blk_trace.=0A=
> =0A=
> Suggested-by: Bart Van Assche <bvanassche@acm.org>=0A=
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>=0A=
> ---=0A=
>  include/linux/blkdev.h | 20 ++++++++++++++++++++=0A=
>  1 file changed, 20 insertions(+)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 70461b347169..ea319c2b0593 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -394,6 +394,26 @@ static inline int blkdev_zone_mgmt_ioctl(struct bloc=
k_device *bdev,=0A=
>  =0A=
>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
> +/**=0A=
> + * struct request_queue - block device driver request queue=0A=
> + * @debugfs_mutex: used to protect access to the @debugfs_dir=0A=
> + * @blk_trace: used by blktrace to keep track of setup / tracing=0A=
> + * @debugfs_dir: directory created to place debugfs information. This is=
 always=0A=
> + *	created for make_request and request-based block drivers upon=0A=
> + *	initialization. blktrace requires for this directory to be created,=
=0A=
=0A=
s/requires for/requires/ (may be, not sure of my English grammar on this on=
e :))=0A=
=0A=
> + *	and so it will be created on demand if its block driver type does not=
=0A=
> + *	create it opon initialization.=0A=
=0A=
s/opon/upon/=0A=
=0A=
> + *=0A=
> + * The request_queue is used to manage incoming block layer device drive=
r=0A=
> + * requests. We have three main type of block driver types which end up =
making=0A=
=0A=
We have three main types of block drivers which...=0A=
=0A=
> + * use of the request_queue:=0A=
> + *=0A=
> + *   o make_request block drivers (multiqueue)=0A=
> + *   o request-based block drivers=0A=
=0A=
Isn't this second one BIO based drivers, like device-mapper BIO targets ?=
=0A=
=0A=
> + *   o custom solutions such as scsi-generic=0A=
=0A=
The SG driver does not create a request queue, it uses the one of the scsi=
=0A=
device created by the scsi stack. Is this what you mean here ? Saying=0A=
scsi-generic kind of implies sg driver.=0A=
=0A=
> + *=0A=
> + * All partitions share the same request_queue data structure.=0A=
> + */=0A=
>  struct request_queue {=0A=
>  	struct request		*last_merge;=0A=
>  	struct elevator_queue	*elevator;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
