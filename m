Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA5C433E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F3B64F4D
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhBDJR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:17:56 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24302 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhBDJRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 04:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612430240; x=1643966240;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ImSap7dwM6oQS/OVCrk1u/LpkOGhRVrSvPsEvBADKAM=;
  b=cJhQYk7kW/NxxYMAZhd+Zz5owhkWbx5vmXrD4Us4G3G+gt1k35zOdAp6
   kg8BRt/LP+IU7FdVRIjec5F2tHfCuajMv6LhcEGxHd9ybdrUNjHaTvsP4
   FXDDvedRVRly/fItM6MfYSEUVOY3U6lx2cqRM3Y3IZ9rCYvcwKkelaoFn
   wtjBUwaiUQy0dWdfJG2vITkQSjYKw7SsVBvllFmeYrhEoiofG3hNQz1my
   XCSdwJ12eSpOOgFka9jBb0z3cgQ6B+IbBpC/3+9TfkvnannLTjDnj8SFo
   72B9rJW6cslnij8UMT12gRh3zg00dcRse3Hp5bqCgxv29lE0eQKUEGrX1
   g==;
IronPort-SDR: VMGVzEeas6pFBkO2Cnn88ETVY0Pvz2bN+t7nT7jk3tvnKeBK+K5OoiFG5GTTHyndjO/t1Ua+Q/
 sHaXwYCZagArWxF98/TJy8PmgxSptYykquOjPcit9LA3W0GkQtXXeIXTlnriO+a8Enen6jfqT8
 gbJL1uzCLT7eenFA7C3SLdNa4UGpnyQ5MtOQ9uOiWzeviaAtM6hydmhzTO25zYCLrGtcg+ng9v
 vwWTzh54ntkNErTiZplY2wDHBGzXpVkZR+7EJifeZ9alb6ZWP3QBfeH39/lZrw1EXMfFnFMoKn
 RbY=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="160288237"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 17:16:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC1bcVgDJAPSYXvb/OBxNcsvZcdM9HSHwjM9mXNngFrzS8xiZmOFAAF59cbi0ckfrKdYZ2fsG1cnP3IqHNPsPC9nRppMTmCKyvpFCPbt2Pugri4kHNdmg+l0FmuHvzourFD1gNWoTNILO9CvcE9ZQ0v6On+KtuFVzuyzKz2/Bb3g9BzLcUuKC8sqPHxkUcrjgeO0YdHFL+k33MKX88YZWVgb59Vyk2uTBy48lcECXEJ+EKn5Z/gspIvwGoVw9kmhmvgZvkEO3CViNmvB9S+F+SfdyBKPTYn29TIJniSTpVYnqoQpA5nYdrjibbS6TtJ5+TyghWRMJPrEKhfWZ1/BFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImSap7dwM6oQS/OVCrk1u/LpkOGhRVrSvPsEvBADKAM=;
 b=C1ZdZMnX4F2whRRpQrdVAVN4pAxu9oWC8/EEDQuDwLqrS50KNOlh5bOB4ELw2FFm6twkI13sANyFnOdvkzTDnnNrZ0illQCGY+qQ8c/CRc84S/BgUUzCq3ZWihrX/FqpMVTRNJGVjOBBUDo0BpFBtqsiqbHgCuuSZI0vqSCpqrBn8v+J1GYtjkg/xA/sUj2OBBQuqxrYc8KAghlieJpLnnwKwaH0ZFDD5GY4f4/s7PYuuCOqfLmlbGPJw3l8GbUZ7BRVppOMxePMXjA8Riio0qeNp4m8i8wh3q7pLKdZiTR/96oXPQpzR2XjXr4GSvKQWgcuCl+4Fnn3KM8dEH/50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImSap7dwM6oQS/OVCrk1u/LpkOGhRVrSvPsEvBADKAM=;
 b=mWIHkkdCFKgxbYznyerUcRot2qETpcIBOqfckNezAtdPMabFL3amf1kDuCY//dUBs/5gowh+QXvaFCUhgUzV39M6zEaGB5RFN3OXMks7FP+LfJiUUux2RsxM+7Kd/vku86647jkb1shGTVWU1zIL5ZOOHIoN5ci5A6+NICqLo9o=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4852.namprd04.prod.outlook.com (2603:10b6:208:59::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Thu, 4 Feb
 2021 09:16:13 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 09:16:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Topic: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Index: AQHW+tJcQ7YrsFFCzEqcRekM9SFuAg==
Date:   Thu, 4 Feb 2021 09:16:13 +0000
Message-ID: <BL0PR04MB65145DD0F6889359E6321985E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <20210204084343.207847-3-damien.lemoal@wdc.com>
 <SN4PR0401MB359853B6F1875CF1233A495D9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514F0C5971F11B5BC548202E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
 <SN4PR0401MB359820BA20257B72EDFBA3499BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61dd:3796:e34d:42c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b85cb877-5633-426d-b035-08d8c8ed84bd
x-ms-traffictypediagnostic: BL0PR04MB4852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4852E8D8BBCB7AC422E621A2E7B39@BL0PR04MB4852.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7OFwc8rOD9ha2+NAeEGz3sWEoVg/NQJx4jfsvBd1+TAzbtgOdHqShI7KnC3cD3nFD48WVwf+NqnTUge+mN9Gj5pIP48l/TiHslr/wFqPHBS65i8KMgyGQXdZqT2EWMRM0Cm9CF9BXQg9ayiyxI5DwAw+AaW17jJBrCXuMDKkX1Jm55M/4cqhVKP2vWroknVxc7vUxclwBe5xYZT+xKjqB4BNVJMI2eb4uosmy9nDx/2cf2DGxFnlKRtNirSba780lbVf2EF9jJExj6QjU4/Mo0MW4V3zKkjAVmHODy2EbjBVtF19q0jOArrYnmr8lgxkO2tR37E/FzvWc2ETYq8PkUygDCpxULRlwRhpXQrlDbbSNCTBAP5gRkiHPtkEe3NKfr1Arst4XFQfuVm3KaY4H7EpWeORqp64rEmX5d1hoq46rbvzQM6npXbGUVM7ZUPvNo1+tVgC2FLrga8EPVXkgW+4OrBSpsSP5LnLXdxme/rtjf7ykwawow159ume7RG4122CqoEEWzyluPub8R7OXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(316002)(4744005)(110136005)(8676002)(8936002)(2906002)(478600001)(52536014)(66946007)(66476007)(66556008)(64756008)(66446008)(7696005)(71200400001)(4326008)(55016002)(86362001)(33656002)(91956017)(76116006)(6506007)(53546011)(5660300002)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bu66MQPh8c0FKOzM441yuUB/6k4PcWWW/x77vvX5Q65v7RuqpY8vEsi4PA/Z?=
 =?us-ascii?Q?LD+X5LQphk/RQFih/WgSg7Zxt/MoLSBjf6c5LIfDbgQfy1R0YJaIRIgssBpu?=
 =?us-ascii?Q?cVCG/To7Ew/KO9309OmnoDUtPIwjykWrnfhmvydS3AbqbvGCKTOXTpWozP7C?=
 =?us-ascii?Q?MZ3hdV5298+poSXVNePUc/f3R1GAZLiZo9bJmaRwJ71peN1h2HRSL3SQMbrm?=
 =?us-ascii?Q?tzfMr5nxLAKn4y3XMNi7iZDo3nE3fcS5Q2nf/kIbGFOtQJODN07deWTDz/Hs?=
 =?us-ascii?Q?hInzQnFcWWFpla0klKRbnQiCvJ88GIOlL8+j3YyCwJcEepifnX2unTqw24E8?=
 =?us-ascii?Q?ca5KmqVO4She9Q0kIwWqiWp6bKtUiHHQt4SeJGLSV3i4bnWrnEfP0MsARuYa?=
 =?us-ascii?Q?72oaomyStDSocB6WGVRGO6ssyL6h9y9Hf4atD2t+Ry7zFPKPMtI8Z17WCMWK?=
 =?us-ascii?Q?pi8gIp1T32svoHgdQyN04I4slh2hFRC/+i67JtnTsdlVnmgfBqKLX4dKeEcW?=
 =?us-ascii?Q?iHO+PnYq1/a1i9xDQ1yrwLjh8ihZZTzPqg5dhkbfKmMHQw4RQPq41ATycNZV?=
 =?us-ascii?Q?cNGNws3eW3jScbgG4Y67ttqfvkk+a0O1gF1qXgHl383u03BVJ2EqCLrP9Fr2?=
 =?us-ascii?Q?pSGVxM8yKZoQ4XN6YfMXFbZ878g110cZlrKTl5U51HIk3OENynq5MyBabqas?=
 =?us-ascii?Q?71HyQyGLxwIeJBumZb00kA2tR0YvYf+z7UWEctJ3kvVjv8GKAOwQJ58AIIQI?=
 =?us-ascii?Q?q+TWOMZ8by5cOPzb/xisYZnTe8ZyFkfJHZN+sk9mfnXGaSp11T0vf5TXxEWi?=
 =?us-ascii?Q?ZsCYs0Vz1QEjb33MiBnJ3zTaTgM8JRlCs/W+HMz/ci6bjDB4pj9vQEySqNCp?=
 =?us-ascii?Q?PXKYMMQpK3b+mLADI3cyU2SCPsPzW18fe92DSeNkewhdb0YdfvsTUVVBUGL8?=
 =?us-ascii?Q?55ZUA/aUw0NohF+hZ8r0I/hCau1yPIcpMVyuWXyRr2YSoK63/xNi5KyHgOHQ?=
 =?us-ascii?Q?Yr7AL3Br7UewuNPe+zvT6k0443+9Lgbm0wJ4RSnjas0OeocDVtaeEprYX6ky?=
 =?us-ascii?Q?0q5GXW4lWhH434ZEbQ3Z7BKOdY1qV82744fTw2FL+iMUiMoZShLVjlBFK7Qf?=
 =?us-ascii?Q?ZXfqRhgHvjE2sqx2ss+rnmHLeBhaH/e7lOR4o0pZJFQBjKDvO6042dF6m1BI?=
 =?us-ascii?Q?ERtJKteYyIDmRTfUeK1hcM3pAUJgEEa6+dXaRuO14vNQd6Ox/Ay5bRJV8ITR?=
 =?us-ascii?Q?DUzgrOrh843jtZbF8dvHQ8gAOUgzUb4r21sM7A4CxF+QVBfooWmKhpQYylIk?=
 =?us-ascii?Q?fnTgXPbX+I5NXrRoARmCxMwPotm7F3PTvIrbQ99RB/bmdokmwFzVXPmW1fjE?=
 =?us-ascii?Q?Fw6ncPAT0hoAhmwT3WbDvgc8gv3fCGgkwo6OC31KEn6Lhoq/jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85cb877-5633-426d-b035-08d8c8ed84bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:16:13.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abrzUpIXC5zPyw+L0/RaitpWwz3hFBCAwISR0xnuwdGiHl6IcZRcJy5VfhrrPIFRh7YnNnDWikvvmihOU4SBQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4852
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/04 18:14, Johannes Thumshirn wrote:=0A=
> On 04/02/2021 10:03, Damien Le Moal wrote:=0A=
>> On 2021/02/04 18:01, Johannes Thumshirn wrote:=0A=
>>> Given that #1 in this series is accepted,=0A=
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>=0A=
>> Do you mean "if #1 in this series is accepted" ?=0A=
>> I have not received patch #1... I wonder if it hit the list ? Did you ge=
t it ?=0A=
>>=0A=
> =0A=
> Me neither, seems like vger is acting funny again=0A=
=0A=
Or Exchange is again acting up. It does not show up in lore... Resending.=
=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
