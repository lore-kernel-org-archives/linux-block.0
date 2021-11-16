Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC9DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 11:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C602661AA3
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 11:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhKPLjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:39:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42612 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhKPLh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 06:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637062469; x=1668598469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tUVcTtWTrvheDll2X9VwhX4F+kZnOwpIAZMs1HZeIVE=;
  b=dfYGhRrIwWi1fEkZjiqKkDwlO2Dvi4EqE9rWmsfDmpb73rGmqQ9U8uQq
   4tIiwbOBgqExc510OlD4NnNU9LO6N/3Sdz60lsDsKhwMXafwyC5uVLG5w
   dk8opBDbev4SCLML//jjQFQ5JTlpJWIpGJzLCOvqYwFGHjGsITxGrEagr
   NS03aXWowIcMrf6zY3NqzpLpA/FSkZ2pEv7Ydb5V+Mwa7r8KPbN6Tb7Zz
   UAHJtnv8e/iP34IsI2dtCZXI3c0MNXbPkDqhnD5Sn2IPHgghm51c1f8f6
   LYRfd9UGyBykelDHZM8AVYpeOYE1mT5BFAjecJku7faSm3/hO8ge3sd/y
   w==;
IronPort-SDR: 4bZ8rfq412BAEX/E4l3RroV9jNdHP1nx8KX6RabTFhotCsAntlDHZRarhwcM+tK1HrpXjrAj9M
 NBHY8ipJfZdU45/07+/Dx9b9uaNXxeJFJe8MUVr55AQtnPc0PnJ00JI6zcfWr9bRykCZuHNbkv
 +BCwpYSV9XtDeCUl/RifsLa8n6/RIOcC26b9KQo0WouOFtK4fK4nrMok2rHwN4y0yH2lmo4mJC
 2UnzHjPldHHrrNjH3dgHYlwUynpRiwyjfGCdMwAv7eKQ10wreZPi1jFGj82tG5h5AvWsXcGyi8
 uKloCtsZVMcJe4Cr//76YpfI
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="139278837"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:34:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:34:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:34:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAPdb+bsxIPmdM4EoU5f/PbZU1P+kdVK9fgRU0VxQj2Z7QqQBOBpC8uyc4xcFW2hj0bhbiF+KNYKsnCZT0SlpdSC8DlAmjDGlsoyl9e109V+q3yqPgLsMZkZG+Aq4O9REy1fyxouhsb7CqxEgxLlZ3qPrX+SAbR9SODfjOIx242xDoz2ENmhCFv/CgHj4Q24Zd0/OGs19PqkV6goHmblvxsWXy/GDsD9HPDcMRoqtwW8T4H4sFmiy6XoCquq9s8XlERE+UedSIeI1jZXz+llQYe+fY7Eu1QarxJdk9QAmE2BADGQZNg7cQ/6G3J34jAnQ5PCXOeDGMw13zA5ApTt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL9TQnzytfPwCb/CAVTO9PNQBpv2l4mcFEB0R3FgDAM=;
 b=WsFzjqidNXKHtlHXVxDtcAu8lVRRUfraoB23RNoE+JubOpxKHwb1n7qPP4bswX0pGTHCo6S9z/ybtfPy+2+iIsk2EPTRGItOh7qgaox4QhuYEKGrGoUdXuc3fpJJ6XKFpxKx8mCqnyaMBp0HlLj+YgdeO4ZpJrzD+BZ+YYSmjSJ+hK0KfNnuFw3AWvF6R/NT9UW7zxkFJ9wiQypI4qaC+TGmx7qYJ9k4kh/bxkYA3dbd6S8/QfZf9MfbvYx0S+tDnsEkoYSsqOZby/RyDx4mjuQIKh16rmBBaEvb7pcBViq5MbeueN4ie/oi894uekS5RwDmZyXxvjvfav3x0maEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL9TQnzytfPwCb/CAVTO9PNQBpv2l4mcFEB0R3FgDAM=;
 b=S6sQxKqGjVSqWpcRC5bhL0QUjdWVFuw5zsLw8Sn8zX+cxybGRUT6SQy6JZLw1aZljrU0ZJ3g7s3J9nVMUSQn+FxCQFNLSSXAmGPr81bgnHUsGYvaR00xjlk68UykLMDVdAab0MrlaustN/DyBGKcoJVeNeVtPHXSk7sARq8D3IU=
Received: from CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5)
 by CH0PR11MB5491.namprd11.prod.outlook.com (2603:10b6:610:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 11:34:24 +0000
Received: from CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::9160:91de:807d:1c17]) by CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::9160:91de:807d:1c17%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 11:34:24 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <lee.jones@linaro.org>
CC:     <Pragash.Mangalapandian@microchip.com>,
        <Sundararaman.H@microchip.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        <LakshmiPraveen.Kopparthi@microchip.com>
Subject: RE: Reg: New MFD Driver for my PCIe Device
Thread-Topic: Reg: New MFD Driver for my PCIe Device
Thread-Index: AdfUin4YS96OXFqCSACYGDyaPGcVfAABemOAAABYXQAAAHdcgAABPKYAAY/rIZA=
Date:   Tue, 16 Nov 2021 11:34:24 +0000
Message-ID: <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com> <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com> <YYkR/szsDirtj1FP@kroah.com>
In-Reply-To: <YYkR/szsDirtj1FP@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63aa746c-8579-4abc-a0bf-08d9a8f50a72
x-ms-traffictypediagnostic: CH0PR11MB5491:
x-microsoft-antispam-prvs: <CH0PR11MB549125F09E2A8F578F7A283EE9999@CH0PR11MB5491.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmleWnmeHi8f7n6zROXFbFLLNRUl+YJX1dujmCY+hdHAgy4jSplSEVa2cuf8rm68soWSYuqO//bDUTnruMgJw21CKYZStl6S8aXLpH0C1zbucqUNRdfwah5wAPRJXSp9JVIBS8/1MrDhH9mnJKaQsCttzqTH9xTP45tcwVUhfhjIAL0QkOdoekivpmMLn9IkjjhnFHfnGBiaM1Uit+/CvPClNqmAJr744BvFfFcl/rBUDTvWPjEXpmk7I7rTRpAc5hwgfWxzDSg8JcFagcAUZY+w/xmyzm5nsfXRQlQaK86ZcwC09sWAlc2TMkF3PbCvfJbrgLsGGDA+jCk2fPxKNyOcvXjXpRuxWFNW9uzfZRe3Xj0JylV/A4NIJGPPhFWaxLkHmRjrkLCuatVmS0RrjW1YLXpjyvkXIdPJAP5vSBgniuN+CDJn+mPPjQ29CfIcTu9l9Tpex59fflLHhkfGoOXj7n62e/mjDR7AE5j9hfhju0rEmXn4pHuiv//I91ivGlvMuRvvx8QcLYXpgny30SscQfDmZpK5cIJUW0Svyq2Or80mzLZJRWNvGZaKagB6qidkcAAaVskp1uo5V/tIqmtH6GnnzaVj5PPapQijdvzOYy8h/qcRFhYN1Axwv3euXByh2OJgUloip62jwZ2fhRnDfsAmxcSMMF8v3qPivbmb6uo44qzc16maf+IUi2/nL+/LC+ianMRQ0h/o3uhqWbkz7BZPXZKgx2hhv/bja0g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(110136005)(5660300002)(107886003)(83380400001)(9686003)(6506007)(54906003)(71200400001)(508600001)(8936002)(38070700005)(966005)(53546011)(2906002)(186003)(122000001)(316002)(55016002)(26005)(7696005)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(4326008)(38100700002)(33656002)(52536014)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nCZD84C0rW6II/th/C7vE7HPbINXeUrez7Q3mzfyVSRd7yKS5KlsEv//Twaf?=
 =?us-ascii?Q?siyZah5akVCg0xuqB24MbUv84nVrbmqtJj1kXgDo6XE5OZGpn0ZakcdTfdZX?=
 =?us-ascii?Q?rALngSfLfUIhK2lVZFvqlcjM/f7r+gfiGvvUxfV3Sei3452+xP2wvorAi6fG?=
 =?us-ascii?Q?b41dsSgIe9VCj+VUgto2lcXigzj6hLK3SSuwFmDST+RFdB/C8XqLWTxUrOqP?=
 =?us-ascii?Q?fYp54FI6XjFwJ6Jt6QEc52haJ9+tFesSSXaZs5Jvg5q4Tf/vo9BrE5CCaAkf?=
 =?us-ascii?Q?67aWiKsYhZzkDGgOVjckJOYYu2E5GixJAVLgf/MMfZluHviJ2Cj05F/3Hg1u?=
 =?us-ascii?Q?ikXYE9GtFiLbSg17Sy8Zc6f4mGujhbU96INbYpvMhqQw7/89ruFcytq6mhfm?=
 =?us-ascii?Q?faa2g/Cpg4XJNo1HKjnBEE1etEqzGENQJfPSvdMTHxQ7MJ0aRrSOOjrcqlo6?=
 =?us-ascii?Q?0KLEQU0TS3xaumoYRamcfPeX/7Em1ZmIwb0WFULBDoGv91oiKwF/4OcCyb3b?=
 =?us-ascii?Q?kP3xt4OdfGTFQcksqivcAWG+eNvbJ8sI7v89mqNTi1byouQdHG0YOCRmiSqx?=
 =?us-ascii?Q?6Tm+yWjsT2As/CQFOfiuXgmPWee6wh4+bjuDYfnl4fOXx7lwSh8hhDoU7nfB?=
 =?us-ascii?Q?60sf1VceBq9rCTtVL8YSj8EX5F7k2pWBBPNLciRbpUPl2W7cIavREp5J+04j?=
 =?us-ascii?Q?/8y7biLmVechVKAJH67sOJ6AlSl5lPL+vOTwBXqWpoCjlfwEC47ZGLFGo8Iv?=
 =?us-ascii?Q?XXMihOOtxxEG8A1w91IaR2Ab/mH10Itnbr+JSR4jGlb/WHc0XeD5HOc6RTHQ?=
 =?us-ascii?Q?XfehsIM5ISbDD7UZR7KBoIoez3SjwPNHD0SvU0VbVYYmCLbB6O8OBb5E7juF?=
 =?us-ascii?Q?lIAvhFs3/u0MLAiLRBQS5UGd/zTaSHquvuqQKBG/sfniWr8UaW3BhX9qobL8?=
 =?us-ascii?Q?1kekTkXOc1cK6fmyQaMVhMNg6s5YAUqTSEnEN/mpM93i91RHW6rGK1ZPoI1W?=
 =?us-ascii?Q?WOdpPOdW171KGMawCNp3gMeCAcuxfL/tzDy79QTzm4DvpRxBg060YR51ove1?=
 =?us-ascii?Q?WaBun16aZetJNYCn+QiGyaLvnA8rNhkJ+bAF+kGrxt1XjPtbVfPtEcZgOMvU?=
 =?us-ascii?Q?pkjO+gvxwNCDyT53yIpINkhcF5ar/hQIQaWaqJHrT3zt1ipIQNXRdA3RBTsE?=
 =?us-ascii?Q?Zq1fG+wvae5oH3S7Xc69A8YSx8eeOGyclRW5zZbyVyVFvcWF4egc1c04YkRo?=
 =?us-ascii?Q?GQONwMgq4VC4jrBgbAVjiFBOg5nBcbNeYD1+pVcxqekCL+fbddej+4V/P9yD?=
 =?us-ascii?Q?It49NZAV6xMK81GQE1EQvbTp8POhR4mlbzjReB0ChuMck5Egrcg/GsgsUz6c?=
 =?us-ascii?Q?ger+3+nZrtVzmHngODwG5hVRx0HRBj2ktXQ9bpZoDfeLQfnkuf9HLVtZYuQt?=
 =?us-ascii?Q?civjXl2MYcYip6kXVRaPj33TNKIlkNWdhfSgeRmWSy025R32aPhJGXmwA6UV?=
 =?us-ascii?Q?ho4lzo8x+2xN2nXI9/c2FLPI2CqBJfVb0rbwXRu6BtQJPjJEVnn1gmXpOZKn?=
 =?us-ascii?Q?CVjMeoAliqNuHdCH3c43I28DN48yQLTi02+znYWmpf82BrR4fUO9/UOzCZqw?=
 =?us-ascii?Q?IkGTuUMQhSUyXLrXVpIBC7Af4UFSI9Wn0ZvwyU+igXSdSUlwCMiuO/UkwCEH?=
 =?us-ascii?Q?lJGA33OszHTOl6lOj4qYMou/73t0Vg0bcixFuFBOVfkAU3Ac?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa746c-8579-4abc-a0bf-08d9a8f50a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 11:34:24.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fHt3RHZzkf7n2CReBmTgYjaXVS3w6adujw1UqD5Lc8RmZ/dIdUuuuChNoirK6vEtXEahYicv11u7AqbnP3/FEXjSut6WR0bzbxnBYIpsjte23DB5AlrmTU4rHr+1sof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5491
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear Greg K-H & Lee Jones,

Thanks for your inputs and I need more of your help to understand things be=
tter.

I took this MFD route not just based on the recommendation from Linus Walle=
ij but also based on the kernel documentation @ /Documentation/driver-api/d=
river-model/platform.rst which states as below.

"Rarely, a platform_device will be connected through a segment of some othe=
r kind of bus; but its registers will still be directly addressable."

I visualized these two (GPIO controller & OTP/EEPROM controller) devices as=
 platform devices present on the same PCI function and these two devices ar=
e not detectable unless the base PCI function driver enumerates them and an=
yway their registers are directly addressable.
Hence, I thought that the platform driver architecture is inclusive of devi=
ces like this.

Please let me know your comments.

Also please let me know if I can talk to any of you over a webex call to ge=
t clarifications on my further doubts.

Thank You.

Regards,
Kumaravel Thiagarajan

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Monday, November 8, 2021 5:33 PM
To: Lee Jones <lee.jones@linaro.org>
Cc: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>; P=
ragash Mangalapandian - I21326 <Pragash.Mangalapandian@microchip.com>; Sund=
araraman Hariharaputran - I21286 <Sundararaman.H@microchip.com>; axboe@kern=
el.dk; linux-block@vger.kernel.org; miquel.raynal@bootlin.com; richard@nod.=
at; vigneshr@ti.com; linux-mtd@lists.infradead.org
Subject: Re: Reg: New MFD Driver for my PCIe Device

[You don't often get email from gregkh@linuxfoundation.org. Learn why this =
is important at http://aka.ms/LearnAboutSenderIdentification.]

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Mon, Nov 08, 2021 at 11:27:45AM +0000, Lee Jones wrote:
> On Mon, 08 Nov 2021, Greg KH wrote:
> > On Mon, Nov 08, 2021 at 11:04:31AM +0000, Lee Jones wrote:
> > > On Mon, 08 Nov 2021, Kumaravel.Thiagarajan@microchip.com wrote:
> > >
> > > > Dear Lee Jones,
> > > >
> > > > I am Kumaravel Thiagarajan from Microchip, India and I am new to Li=
nux Kernel development.
> > > >
> > > > I am currently working on linux kernel driver for one of our PCIe b=
ased devices whose BAR 0 maps interface registers for a gpio controller, an=
 OTP memory device controller and an EEPROM device controller into the host=
 processor's memory space.
> > > >
> > > > Based on earlier inputs from Linus Walleij, I have developed this a=
s a multi-function device driver - First MFD driver (drivers/mfd) gets load=
ed for the PCIe device and then it spawns two child devices for OTP/EEPROM =
and GPIO separately.
> > >
> > > You may wish to speak with Greg about your architectural decisions.
> > >
> > > He usually dislikes the creation of platform devices from PCI ones.
> >
> > Yes, that is NOT ok.
> >
> > Platform devices are only for devices that are actually on a=20
> > platform (i.e. described by DT or other firmware types).
>
> This is probably a bit of an over-simplification.  Lots of legitimate=20
> platform devices are actually described by DT et al.

We are in violent agreement here, that is what I was trying to say :)

> However, it is true that devices which reside on definite buses; PCI,=20
> USB, PCMIA, SCSI, Thunderbolt, etc should not spawn their children off=20
> as platform devices.

Agreed, that is not ok, as those are not what the platform device code was =
designed for.

thanks,

greg k-h
