Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31BC4332F
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245030AbhK3Rph (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 12:45:37 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:5406 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245000AbhK3Rph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 12:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638294137; x=1669830137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Aj0iDteSL73mkv+QFTFEcTF0hPM4JHu/l59DOKChU3E=;
  b=CbblnmTjFpf0NThk5/WiE0dh45zfFj9Up7Sa0WgxlN07S/rYIEVVnthh
   3mj4i0JQPJkau5gkQSliQ5PfvOUCzd2vxs96Ndo5NGvhU94g/KMECUTo2
   MK3fgflvgAiaIpOozCxAccuV7R2cR/mktU0SDRFTBex4kwwfWtkYd+WS4
   B7TkzdCP2Ffx149aX09hzZ2ILdOIK4jrBj8VVcszXdeLOmP3uD4uspFsV
   Hq6KLdS4HNlsF5DgHzHHvZZF3j6GuzW0QuCW4zm9hZ+FI08YQcM49MCqt
   RQ9T39I5w1dY8VqVMhZXiuS63oLaxLg79oDie4leX3HJ5NIPz/Oa6Hm25
   A==;
IronPort-SDR: zl24utUqQkipDAA1pAN17tftVEU38Jj8afd7ygIT2Zov/4D+Cc6T+SgkdJOBHJX/Wq+MxHgnYL
 v4XW/jv4iwV4MYHnu2LM7wju338LwlQfAjfafSGPr8rVjqBNrbakhTJtL+d4TPo3VJ7V2b3i2O
 ytS2O7Kvv/sDcHPvMG8lfDve+go1rxNu1dMrxV1doBZJBtmLtYeB+3G71JavP5FUqCPFnOTrNJ
 RJVEhblfQGrMmO8f5Du16OVZ/ymRQyxROQX9+BccpgZe79oEe2q68wZCC+Wghva6m/gUSsXDyv
 qqC9yEvWBOuA0DT3OgxLza00
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="138162188"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2021 10:42:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 10:42:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 10:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIUEomj3XYpkF4dQyOA0ujDhk0teckPXGefMaiEt3CqD01fewVcT8Lf45P8jP7cH4bLf/sAxnK4bGov/jsW058/xt/tyk3YhyArDgQCJJL6A1clhhkYUK6iC/FgSURAkV7Td2tEITgw3vu6yfawDqJDfjaL07q9eZ1D2yjrMpU/6HLPCU+JRvHmZsPvlhUX5zYeCMwwNQ1RfY2wi1tm2n7i5ER+vnfcgXOMxRTznJagZKYbDp23h2suwCMF0J0EGSlG/EB/G4SHIC8w338yEa9T2f0599i2JlDzaSnYJxypC77QbzbMUqErlwUyp0Z7FnRTT92BOfz2YhdW89tDM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj0iDteSL73mkv+QFTFEcTF0hPM4JHu/l59DOKChU3E=;
 b=XKj1urTy+2GCiORwhznHPNAzgxWl+BUWpK4sQXZrBZUBM2nFcOJTdDW6b2JrIdols7pZpBZTscgI9aNKAOhxj4yn7//pPrI9N10spmZxUxJ7l24KQ0ilQkdybwhlgWTwrWPO3HVQGiXhwak+xFOryElocAOmoUmAXY5sQdlJDy/oQe2HVzMOKr62XFI7ytW1rixtcbisrEz6W96Ak1SjNC26+tVlgNjnaLcaRL88wNFWz6+85WTrVL1tZIpoD1I7EK2USjm1jqXhD02m5vASvbBEaKCRZXSCWh/YajUwhiPIU1ZlnsDTGUi4U/y9tjOvZdy1XvbSm5ulasbYOGKhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj0iDteSL73mkv+QFTFEcTF0hPM4JHu/l59DOKChU3E=;
 b=LsblCmVmALepedMCSD7y+ZY1AHAj8ptxQGVNIWBB/RJSbS0OMcU/CDmN1SNt+taZ49qqUqPMJGSxMxhI4vkghBzwIWz63MVDMPGT6oI0oX8tz09Ed+vwYN6EhZFdJFoZSnSwZlm2/jfMBxfcJa1EZyM0B1c/wOoOHTbdlEdhIRQ=
Received: from BL1PR11MB5381.namprd11.prod.outlook.com (2603:10b6:208:308::23)
 by BL0PR11MB2948.namprd11.prod.outlook.com (2603:10b6:208:75::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 17:42:14 +0000
Received: from BL1PR11MB5381.namprd11.prod.outlook.com
 ([fe80::6544:6ae1:e784:fa28]) by BL1PR11MB5381.namprd11.prod.outlook.com
 ([fe80::6544:6ae1:e784:fa28%3]) with mapi id 15.20.4690.027; Tue, 30 Nov 2021
 17:42:14 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <lee.jones@linaro.org>, <Pragash.Mangalapandian@microchip.com>,
        <Sundararaman.H@microchip.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        <LakshmiPraveen.Kopparthi@microchip.com>,
        <Ronnie.Kunin@microchip.com>
Subject: RE: Reg: New MFD Driver for my PCIe Device
Thread-Topic: Reg: New MFD Driver for my PCIe Device
Thread-Index: AdfUin4YS96OXFqCSACYGDyaPGcVfAABemOAAABYXQAAAHdcgAABPKYAAY/rIZAABzT1AACK+OwwAA0KDwAAzz9LUAFfu+2A
Date:   Tue, 30 Nov 2021 17:42:14 +0000
Message-ID: <BL1PR11MB538172ECC1F112D2F6E0D734E9679@BL1PR11MB5381.namprd11.prod.outlook.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com> <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com> <YYkR/szsDirtj1FP@kroah.com>
 <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZO+KktO3OhDEtlq@kroah.com>
 <CH0PR11MB5380439460BADE102D91C18AE99C9@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZe6TPrf4Drh7HpI@kroah.com>
 <CH0PR11MB5380DAC79E3D01C7D1D6008AE9609@CH0PR11MB5380.namprd11.prod.outlook.com>
In-Reply-To: <CH0PR11MB5380DAC79E3D01C7D1D6008AE9609@CH0PR11MB5380.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83fc3e53-f847-4d67-bdf9-08d9b428bf2d
x-ms-traffictypediagnostic: BL0PR11MB2948:
x-microsoft-antispam-prvs: <BL0PR11MB29487AAC394637392E216DAFE9679@BL0PR11MB2948.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgTPjF2ORI+is4D/wjqatT0T7K1ZQx5j7ZhzQhTMtokI7GSTg8ju2mphJ7BAB5/H5IbeEUwNk5TbvDBvN3c/aSMsJmY4DVG4FlsE8WE4Zf6EtuOKQb9tLc9gnlHlT1bEYwjHKqcjxd8CnDcA+vOcAsKhIz2QXNb51fGO9BlSQIgWIOdYfwpweinjMg0gUA1xeCNyeUpKbnTNp3BTpdz0ltIJsbHOGTHlJ6KliGbuZzXTjjvF/bSdKwlZgB4wEHeOaYyE7Bf6+qAtEdUdc54HNFaJK4Oc9eSHgqI6d8nNWyab/fuWqn4fMtj2kltsCBVtV9DpmHeT45wDShzBy2A84l73DF/xNNeWg42eoOGX1JFrKPx0mEFEEyTKeixH1gP4F7UX4gNj4wJ6IhKXCdKnEPNK0ceAcZb7/gwOHI85LtV/4nNaE2ZO6AY9e2fazCqQRRsK/tayu9gw4OOJA/zPPlqBGTQv1kgMUeQJvo5/c9atYeq96P+8SAaN6fiEW1yUaTkqbVttoGc77aCR9tQcLkRPK1Wk1pka2T2WsGEDsD4HLRI1ixmvTeOuZrxHLVB+ANovWBCYAIHr1T8kOyAyAZ7peN5ZzEwczNmbXv2D1MRLUlnW+akKmwlXQgdwKaad7td+LHf/6YYphnfHTgfvCOXF29SL28RcRDTzu4ja5nb8o5W19Y+U89XMlNAo6QpsQjb1wx5CeIh3o30wBT2Ypg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(26005)(8936002)(38100700002)(2906002)(5660300002)(8676002)(186003)(66556008)(66946007)(54906003)(38070700005)(83380400001)(33656002)(316002)(122000001)(66446008)(66476007)(6506007)(7696005)(55016003)(52536014)(107886003)(64756008)(76116006)(9686003)(53546011)(6916009)(4326008)(86362001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c0s6LfzjsiZ4plE8LUnyaIaSrRCDAPTSy2b6SWyeeDNkuff6n+RosTRctNnA?=
 =?us-ascii?Q?/cxHOVYtWi84umqZc+MDaUFtNd0TzXSAvRL6IeY8xCpgxk5/T75H/w7PZXfY?=
 =?us-ascii?Q?Wa20dlILZAN65f73JWXFw7RkEU5EFzI6QO60eRBM6jDjWOI4aIWmscASIwxi?=
 =?us-ascii?Q?ve7v4DxVB9YbAJ0BEvsA+oz3pyr6aP6nzCdTjaQzPPQsjyz512W9jtGEpl82?=
 =?us-ascii?Q?jAf0UziApLWV3wjVLWPftII29qRKIREzGlPhAjzON27Js04+jd0drBmdHeM1?=
 =?us-ascii?Q?9+04esRqtHGnH49i4e9Kw4Ob5NW0KiNKtbUyJ1irECXcyfTRvSj4GpYhKcsB?=
 =?us-ascii?Q?qjlPz7vEZyqWLTIU/HBMfPg2sDjLWt9v+L/8fStwrLlZRbIMEK1uC+u22/pS?=
 =?us-ascii?Q?T9TE27E3LuAKoVa6p69iMbH6fWMDRFGhl7hUWzTOXpmcM7xaakaNcrp7Pf6Y?=
 =?us-ascii?Q?w1lFlPQFhMZ8Zk2Zm1DvhCPH+cZsZXy8iK4X31a9OIULu79TTqcgY2OeweYx?=
 =?us-ascii?Q?0xYDvEGno643eyXnFKe1MB2o60IZsTtvuIuJArzvp8qud/jThey0Gh+dQis9?=
 =?us-ascii?Q?RxskQ1d1zO6XM3D4K3k3uKfQqOz5noiKz5s7g81DOpb3Zf9V3BLFgGs71JiM?=
 =?us-ascii?Q?GEgBwP10h4WtwLHbq7Ce+gSil9iwS/Q6dxuRKI8CZBZbpZ0hr+t/0Eq3YRAA?=
 =?us-ascii?Q?VdVTkszPltTNMm+9aCtr5Zyby+v7fUpiEtxDw3lsDS+efD3i3x+FzeYtBbBc?=
 =?us-ascii?Q?cp+quZFkJ4WHLnjx0Mn6z1YdX7oQOXOJ3Tpu2x1bT/sRVieix3PYcHOAVdu+?=
 =?us-ascii?Q?207iwX0R3fHEO79mqly3TfvDOUHF1FyBCNgMuzNOR/pw3VgWarOilDVc85H7?=
 =?us-ascii?Q?qiZ5hkFD5DEvmleJHASSLn+ovb4ohTx+5EUecFJI0/PTk0TwtrQeBFv84YjN?=
 =?us-ascii?Q?DD8eQBFvz09iQ9FNZZWaBbWa6OusxWViV8Srw3fOxJN9cQV9wbykRUrHgoTh?=
 =?us-ascii?Q?aUCf4c65YR5M05BJinnpp9/08SWy3aSQ9jz1CStD+WyplRKl/FGkkv8IL95m?=
 =?us-ascii?Q?asXAMZIoNamuwLeTRtcNgz0kHTd48nPn6INv+UJt6IRwluZFajH2sMG3UwHv?=
 =?us-ascii?Q?rKbRntHbFNmEOsgmD4hY89GmJWaIQ/IO3PNda11EwNrAuEBHpS6jaMDaE4od?=
 =?us-ascii?Q?yFZK3OhkOmTNXjPB+JWuduCCKOMEZ5Q/SGfoz/p5pTHBZQuFE8V501LRmSnb?=
 =?us-ascii?Q?FB3cCGJ5/KvGgDd014ypjzQ2ksxE+vOV1FUZjySkYtVHS8MUdzoalfa3+yba?=
 =?us-ascii?Q?4UcZDNgMcm3gSP4L/7gwuzxwrp2pRCt2qLeEHk9FBBCaXUIwzH2X99GNvY7h?=
 =?us-ascii?Q?wRejCh/2lbfsuveNrsAFnQhI96cWVoxhvdYvIP2rcoi0qAzETUqGb9xQERqy?=
 =?us-ascii?Q?zCpcNNJdJbPS5wawl0IuCjuVG+LklOr8MmLJ+J9QClrWY3cE+rHrIxr0Gjru?=
 =?us-ascii?Q?YHopvjSfSpZD/NW3e6NVTe9eUfEGV2rLI9/rCCdeeffXZuVlGpnlLpbCVi4s?=
 =?us-ascii?Q?GEUK4ZFSSxv5xeByL9xy1+94mQoUpFHXjGb7/eOjEwKrbhlSEn5A+C0hIz5P?=
 =?us-ascii?Q?b6NwjAI8kaeHi4xffX+6JfHga7p3wlEFMLpA2cfxegNpAYwwb8n6NQtRbNpn?=
 =?us-ascii?Q?FdhqmCI+Z5QSxzP2EKMidZf647A9wmH/TEndAhdwhgrx3Z3LFOdFYXmCFb5a?=
 =?us-ascii?Q?ZpFxl6qQsA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fc3e53-f847-4d67-bdf9-08d9b428bf2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 17:42:14.7498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZtR3PQbIgAcJpjjJ/BnouQBNfotsH1lww3XBOPSZipCNOPVj0GTyaOnNcmZmQK4D/PdgFcIBhRlaHBRzUSV7JGn4FpfbkM1oIjN/BGjmNwVLb8vDUCWc9HFMmVIDVCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2948
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear Greg KH,

In case you missed my last email below, I have tried to answer your questio=
ns in that email.
Please let me know if you have any further questions or concerns.
This will be help me to finalize the architecture for my driver.

Thank You.

Regards,
Kumar

> -----Original Message-----
> From: Kumaravel Thiagarajan - I21417
> Sent: Wednesday, November 24, 2021 12:03 AM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: lee.jones@linaro.org; Pragash Mangalapandian - I21326
> <Pragash.Mangalapandian@microchip.com>; Sundararaman Hariharaputran -
> I21286 <Sundararaman.H@microchip.com>; axboe@kernel.dk; linux-
> block@vger.kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com; linux-mtd@lists.infradead.org; Lakshmi Praveen Kopparthi
> - I17972 <LakshmiPraveen.Kopparthi@microchip.com>; Ronnie Kunin -
> C21729 <Ronnie.Kunin@microchip.com>
> Subject: RE: Reg: New MFD Driver for my PCIe Device
>=20
> Dear Greg KH,
>=20
> Please find my answers inline below and let me know if you have any
> questions or comments.
>=20
> Thank You.
>=20
> Regards,
> Kumaravel Thiagarajan
>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, November 19, 2021 8:23 PM
> > To: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>
> > Cc: lee.jones@linaro.org; Pragash Mangalapandian - I21326
> > <Pragash.Mangalapandian@microchip.com>; Sundararaman
> Hariharaputran -
> > I21286 <Sundararaman.H@microchip.com>; axboe@kernel.dk; linux-
> > block@vger.kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
> > vigneshr@ti.com; linux-mtd@lists.infradead.org; Lakshmi Praveen
> > Kopparthi
> > - I17972 <LakshmiPraveen.Kopparthi@microchip.com>; Ronnie Kunin -
> > C21729 <Ronnie.Kunin@microchip.com>
> > Subject: Re: Reg: New MFD Driver for my PCIe Device
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > On Fri, Nov 19, 2021 at 09:16:29AM +0000,
> > Kumaravel.Thiagarajan@microchip.com wrote:
> > > Dear Greg KH,
> > >
> > > I went through the documentation of aux bus and felt that it would
> > > be the
> > correct way to go as you said.
> > > I will migrate from MFD to aux bus.
> > >
> > > I have one more architectural question as below.
> > > I have written the driver such that it enumerates the OTP memory and
> > EEPROM memory as two separate block devices or disks each of size 8KB
> > and this enables me to use the linux dd command with "direct" option
> > to dump the configuration binary onto OTP or EEPROM devices.
> > > Also, this enables me to use the application like hexedit to view
> > > the OTP or
> > EEPROM devices in raw binary format.
> > > These devices are not based on mtd (memory technology device)
> > architecture as we don't have any erase functionality here.
> > > Can you please let me know a suitable location in kernel source tree
> > > for my
> > block or disk device driver?
> >
>=20
> > So they are a read-only block device?
> KT: No. These block devices are writeable too. I program these block devi=
ces
> using the linux dd command with the "direct" option.
>=20
> >
> > Why use a block device and not just the "normal" eeprom driver?
> KT: I thought the normal EEPROM driver can be used only for EEPROMs that
> are connected to I2C adapters for which there is a I2C Adapter driver
> available already. But my device has an inbuilt EEPROM controller hardwar=
e
> which is not like an I2C adapter.
>=20
> > Or a char device node and mmap the memory?
> KT: I am not sure if I clearly understand this. Are you suggesting to mma=
p the
> EEPROM memory? The EEPROM memory is not mapped into the address
> space directly. EEPROM and OTP controller registers are mapped into the
> address space of the processor and accessed by the kernel mode driver.
>=20
> >
> > Anyway, no idea where to put them, drivers/misc/ ?
> KT: Ok. I can use this location.
>=20
> >
> > thanks,
> >
> > greg k-h
