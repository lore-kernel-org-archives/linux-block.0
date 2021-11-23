Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F64CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhKWSgc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:36:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25148 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbhKWSgb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637692403; x=1669228403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wito7AFKrkAsZcFGEujyqlIKL+R68cfr/d7pC9+Wtbo=;
  b=1UfLcLuCtenjUt17HZRqrVRim99tdPI1Koc9Q50xebBvgyb1EYoDKzqz
   2SAQ4ICXWswIcaDQQfAmfesQAX/+Wl/12aXd2IzzTCoJ044RB7GebVcp2
   a5se6czXPr+VlKzetFoYrHXHrXcgO2G/WACavVk+MfHHTioaa1+0mzVkN
   3nwWx7Tz8epfwt5UtdVp+dhhwa4NmWvZLZWVKra/nqOJrp+bj9q4baa1B
   ADYpLFjoHd4pwfmpfBAfHfwgTHGS2FTuUFt4BgVD+ACR8EC/OO0Ti03bB
   QYIzMfyrREikr4bFJ7OqEQsoQ7DPU3V1CLrpSfzGO6rUsU1jzp44DbSL0
   Q==;
IronPort-SDR: Q3ZkuZNUALOn6/7CgFt9Uf+ivycMkTX7DYN8eECABvklHLTQi4e1IoiWnSq/ULU/H40i9fOFpC
 6VtTK5fJmyEoil2oDpMuham4CtoH4CJYaYSCFEaHtRU9O2/i0VxQVH/9sQw3Yc62UVnRbRpzLc
 NIHL+gND1fkjMWXNAhcBTjZ677wL8NOn5ZYkBQV1stQ1J8jwpBbqobco2J37UdyG19AThHLXhp
 pvwIyXtTKalg8fKGcbFWfmi2f3zRCAD/r3OSmBGXZAg1VmMsBlUOnBLmtCxxcFzgLVsa4PO9wV
 g19+QRvEZ6xsP2889rBJE0up
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="137502879"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2021 11:33:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 11:33:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 11:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgRGFsSEl4GMSbWeAnOfIFmYTnatFeNA3UsXwA72MaJFWaGD03vvetvNT/eIUmdPXmHZeoguXRjr2OtBda7643us4wa6Pz9q3AgeN99O6oR0dC5NchdA/rbe8uKD9l9zjLRGtz9BcDPeYvTJ/Nuzus80htRTMRc1QVpy+lWKFa7Vmg5WQcmNqUL8Jkt0kHxePR/DJCeqbWtdND5BXteK0eL7H/RApLfRea5yUAzzTBU4Bf4STzhhBo1Hbcmr3hQK3z5DZ7WDzd5bPMGb0VCJ28c5K/aWUsjb7fyi3TPKZVN/36ToJoEfF7z6e64iuIBcNxNBiN/5Ca+YvMmuTuL+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wito7AFKrkAsZcFGEujyqlIKL+R68cfr/d7pC9+Wtbo=;
 b=k9uu0HVzCnvd6Flfr8Odms82O6iNmYY1K5qDdsxdueoHRulRUKAiAL5iD9GSW8JfgFCVXn27nrkBrKz1t1c4Txca8PfGNlqyAE4Etphon892848jPzJNOyslSyOhUAx6JBn7vwn1rhHEDzW+c7attZXIWWkB9108C622E8Hn7fWsbqvIkK7Dnqay4J4D0bFPC2QmfmswAuhC+aorJ6SMxFw5EJ3n5q958wsSNu6/pXo4PzEBzd7jfBPUH08LSd06/OLQCHoSLjJaUJfnuQg8NAdugNw4Y76zIZzW41OSLzWJVaZHBOJxPJ+xiSQiDISYYc+hIQF+Al+VHb5kF0tB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wito7AFKrkAsZcFGEujyqlIKL+R68cfr/d7pC9+Wtbo=;
 b=GioKsrMnQT0S+a+4M+hvJHspWM8y366qYV3fj1g1EQnwjTVJO6DvSvFMtk2kCfqmuwFUt1BQc/0w31gpgJyCNr9xVzrztSugwKNfkq15esw1zPcQie0ifkFxuA81CRnlt0zw5mNoldl6z4EF6hE52cmiUc4qVDoWEUHkQARjVr0=
Received: from CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5)
 by CH0PR11MB5220.namprd11.prod.outlook.com (2603:10b6:610:e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 18:33:11 +0000
Received: from CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::9160:91de:807d:1c17]) by CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::9160:91de:807d:1c17%9]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 18:33:11 +0000
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
Thread-Index: AdfUin4YS96OXFqCSACYGDyaPGcVfAABemOAAABYXQAAAHdcgAABPKYAAY/rIZAABzT1AACK+OwwAA0KDwAAzz9LUA==
Date:   Tue, 23 Nov 2021 18:33:11 +0000
Message-ID: <CH0PR11MB5380DAC79E3D01C7D1D6008AE9609@CH0PR11MB5380.namprd11.prod.outlook.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com> <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com> <YYkR/szsDirtj1FP@kroah.com>
 <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZO+KktO3OhDEtlq@kroah.com>
 <CH0PR11MB5380439460BADE102D91C18AE99C9@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZe6TPrf4Drh7HpI@kroah.com>
In-Reply-To: <YZe6TPrf4Drh7HpI@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21c7d85f-fe19-44ec-ce39-08d9aeafb403
x-ms-traffictypediagnostic: CH0PR11MB5220:
x-microsoft-antispam-prvs: <CH0PR11MB522007486634FDB98C3B106CE9609@CH0PR11MB5220.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMpDvngIH9eXvvCkXxSSxidbrmPQ0Eg+VEx5j9BdAfapsrFwMW84p06cWlyIYGEz9zvxJBNYlmaJlvNQsIzW60As0p5IbuyBx0sQXHYevJNIyt1WnIPMD+EkzYNSwN4tLYfCBd5vjVpw1H6k7PDHvLNlN9/ZaM6YlJQbIkawc6GC44nYY+sXIswx24gLTC+kRcL4dDkNx2jMI27TjCFO5axYxLkAWmV/ioXdp8xIi/pLr1OmDqHpQIfmT7oCN4uHkFhdR54PjDy7yRaeiNzV6ZuG9cSYYLH1jMqFX6/Fe6bQM1aDEWX7DGa1P2yKi0EduaKU6OIDlldaE74JR7SunHLIwYfaBmiZLPECJvVZ53/ZugTg07+asyLMmv2QWQGQpHP4+ger9rfhWfLvUPqaLx5FbUF4QYy2eb8ll9UEpQfH3t3UypnaGWQGYp4SAN+x7ujC5MeYOUQJ2Jbu6XgEflkoBQHuJCUuecIBHj5f/4gM+DwrDFLQ4dTpJzBxE7Qp5NqHBwC4XXZ9flC0+5CGKAbLqSXo9MecZssuEZ4VTeeMrcvnHq4CB/l2AeElLMSzRxdzkDLhsJKECP7MhMqBx7uqC42BHrHCSMO/NzYEogNkLyhok1DGo4pU2pyDbFUU0Xf4kG4LR/lDK59FSCUdq9mhGC4xD0A8oWCaC3bSh1dBeG2i3duqVlbmB7ReI8VvG1a+3D9KZTZubvBd99AIGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(186003)(5660300002)(38100700002)(55016003)(66556008)(66946007)(64756008)(122000001)(66476007)(66446008)(76116006)(26005)(7696005)(6916009)(33656002)(52536014)(9686003)(38070700005)(53546011)(6506007)(71200400001)(54906003)(316002)(4326008)(508600001)(83380400001)(2906002)(86362001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2/Y7V1Yb5G2TlCiXdK9RDEmQTF3TshAgRK2uXe2eiTvngPzkC6Q5mTGITCP?=
 =?us-ascii?Q?f7ZQwkvDUP1b02PuPq6ba7/g0YIo260ojVcVGHQRKidexY6b07cDjbP7fG69?=
 =?us-ascii?Q?r6y0bptFKEBXDt6yecArC2YdzodVngo1IvU6Rodjl5zyJN8BAYRX8GihpwpT?=
 =?us-ascii?Q?/x4/xuvxFD4YjZUwvZtOA7LqLaoXpGF7EW2/CViPyVysYcl65yFozc922Y8m?=
 =?us-ascii?Q?3zJlxBoCU2eMrv8EoaPtym8NrPYWgoVn3aXkDhctMa/oKlCdA6geTqtAlIUu?=
 =?us-ascii?Q?22PdJdplKdRNECx7BMJhQQ4knNEC3XcpE6WZe7ZgZMQWD51IkK/2NR2lUf9p?=
 =?us-ascii?Q?3diaHAt8L6UeFUgbfN3JCKxvj3uRPpzt04NTkXN6Jcwbn7LXnWl3aCJPXuyJ?=
 =?us-ascii?Q?gAyP+AVKCXYS9C6P5v2snzOkialGbVdP6FaRehebitXXYI5ZfII/ohv1InWx?=
 =?us-ascii?Q?p+EYOxt9zE/RUvC87fuJR8JntlX94Z0M/TbSsPw046erGj4Pfm5t1r8Hj+ct?=
 =?us-ascii?Q?65E74uENdvrbyV6XfLVt2eSN+QxJq6Ip0iKipvqn+xNVDmUxW7gYatudWh8G?=
 =?us-ascii?Q?emLWz+fhDAHodrjbBz/RMGoTX/abDhkP4AsR+KCE1h4uuDWNkP53EsoJ5Vmh?=
 =?us-ascii?Q?pfPB5GhNuVPvcs8VTfgdkRDeazwt3mY5fl2nW7LxRhv4RQRsyvpu8rjlHRz+?=
 =?us-ascii?Q?ZXFbYwZq8Xq0Oo9McMIM9Z900ounQwDZaNi+EZWA7W6u+jE6U8m5lpdjFNSS?=
 =?us-ascii?Q?jwkGEiKNsB+wvdkW3XWXdAL6DTixHhkyP8DMXs7KLbI1eX7DwOQLubbjQuw7?=
 =?us-ascii?Q?Ga5O9wjBUGfsCRb9F1o0O9A41cVON1ATVAQRe/mUpC+4fiS0Y6ODuqSuuXXD?=
 =?us-ascii?Q?trTGxsdtQ9uwfiguSbYARrO/C3bsxoKoOZYRnnqzdl5NBdzfcRBAM0ZjRn2/?=
 =?us-ascii?Q?hS9tphLeJHQliUKNOymqq11U0qQQ+ScGS8vIX9oUTx8913r2tcgCqAqqYMCJ?=
 =?us-ascii?Q?iXc9ppuR+MFCinmEKtfVZ9PDBoo7ZtQKsF0gfJDwE0HlPELcNnlDk/68g8sy?=
 =?us-ascii?Q?UI0dwUN+cfxyG2dq1RmPrtI/NWy8qLFEMSIH76sUDduMzEqlqoOWcnfwxWgE?=
 =?us-ascii?Q?JgJVE1ZH+Ia9EE34oUJVwJKVc/oij8cFNPGK+MOp96OQ5SK5xaB5TL8GE/WW?=
 =?us-ascii?Q?wCmMeWY8c1eKS5hNsHD9WEQFn3kHZZ3b4+OhjtyobuGlCWeTqhRPyvcZ5YvF?=
 =?us-ascii?Q?r6DeF1Sjcnm8bKR10CMtWRDr/v9dRniZlgcsswnX8fPC95Y5rgUfK2LmlwYj?=
 =?us-ascii?Q?aUc9R+hQF/J7e3RKtHFtrjG5uORe2fQXFkfjwsrpskN+/fvrUXUXvnhPtL9y?=
 =?us-ascii?Q?QiWCN4VG5mlnvaR2q9VpTIe0k5q3ERCSnXYX+rjzw6aIgT80WF37NY0COftc?=
 =?us-ascii?Q?/JmnAP5wkx2xKITn4bh1yP6jNxLl9OMRaNF1Ovy1KZ0hYTlodfliW071YepT?=
 =?us-ascii?Q?suAZ1G9QpILWHmP+J6X7lkU/KYbSseQ+Qi3b9nHRGWbapbSujISQhMY9qCo/?=
 =?us-ascii?Q?3elG6hzrrC0m7A8AFCu4sn5NZ5e3qgcuMJUO3UxdGe9gEaavh+hR+ffHyTZp?=
 =?us-ascii?Q?jb0qMJ2N9CiCgA/iG64y9KzhNXpYLM3153ni0ODpoWpms+5Zk/Svh9Gmcl0B?=
 =?us-ascii?Q?zApJnC6MXumWkFjla1wGOQFMc9txh5q5ZIHWIsf12W8qKm6kaGa1Rz24HQ3W?=
 =?us-ascii?Q?lR65ZDjg5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c7d85f-fe19-44ec-ce39-08d9aeafb403
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 18:33:11.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGC7jQpMn20o7fcb702YG/3IZbG/tNDEDgtT/N/yAIiN/9yHw1sj6IDNge4FreQun0lxZToOYuMA/8SiyKwGEJLHoRUT00ccesuiIRgDl4QJXSmXIoA68OOSaTDTDCuO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5220
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear Greg KH,

Please find my answers inline below and let me know if you have any questio=
ns or comments.

Thank You.

Regards,
Kumaravel Thiagarajan

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, November 19, 2021 8:23 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: lee.jones@linaro.org; Pragash Mangalapandian - I21326
> <Pragash.Mangalapandian@microchip.com>; Sundararaman Hariharaputran -
> I21286 <Sundararaman.H@microchip.com>; axboe@kernel.dk; linux-
> block@vger.kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com; linux-mtd@lists.infradead.org; Lakshmi Praveen Kopparthi
> - I17972 <LakshmiPraveen.Kopparthi@microchip.com>; Ronnie Kunin -
> C21729 <Ronnie.Kunin@microchip.com>
> Subject: Re: Reg: New MFD Driver for my PCIe Device
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Fri, Nov 19, 2021 at 09:16:29AM +0000,
> Kumaravel.Thiagarajan@microchip.com wrote:
> > Dear Greg KH,
> >
> > I went through the documentation of aux bus and felt that it would be t=
he
> correct way to go as you said.
> > I will migrate from MFD to aux bus.
> >
> > I have one more architectural question as below.
> > I have written the driver such that it enumerates the OTP memory and
> EEPROM memory as two separate block devices or disks each of size 8KB and
> this enables me to use the linux dd command with "direct" option to dump
> the configuration binary onto OTP or EEPROM devices.
> > Also, this enables me to use the application like hexedit to view the O=
TP or
> EEPROM devices in raw binary format.
> > These devices are not based on mtd (memory technology device)
> architecture as we don't have any erase functionality here.
> > Can you please let me know a suitable location in kernel source tree fo=
r my
> block or disk device driver?
>=20

> So they are a read-only block device?
KT: No. These block devices are writeable too. I program these block device=
s using the linux dd command with the "direct" option.

>=20
> Why use a block device and not just the "normal" eeprom driver?
KT: I thought the normal EEPROM driver can be used only for EEPROMs that ar=
e connected to I2C adapters for which there is a I2C Adapter driver availab=
le already. But my device has an inbuilt EEPROM controller hardware which i=
s not like an I2C adapter.

> Or a char device node and mmap the memory?
KT: I am not sure if I clearly understand this. Are you suggesting to mmap =
the EEPROM memory? The EEPROM memory is not mapped into the address space d=
irectly. EEPROM and OTP controller registers are mapped into the address sp=
ace of the processor and accessed by the kernel mode driver.

>=20
> Anyway, no idea where to put them, drivers/misc/ ?
KT: Ok. I can use this location.

>=20
> thanks,
>=20
> greg k-h
