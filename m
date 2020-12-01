Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D23C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 22:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1E420C56
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 22:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lIpdHi3d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dFEVVosB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLAWhc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:37:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10739 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLAWhc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 17:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606862250; x=1638398250;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qYvT7vsjF8Iy3WLfo5Xv6WLnGVS6Dw7Pc9cXlduwa7Y=;
  b=lIpdHi3dsMg4kPjzXMu2rIHC7voSdk6qoZwc7gwk9PonQ2k1BUFOYMUA
   /wxPfWQk0f/IKzH0+rZAO23Ge7gpnxDMPstJiztygUlsmn/jWrl1dzHrj
   AlAelJruiFHVYkJLiw3D5lbDlqGADzj7rSJWwUVupWVc6D5paT6Ud6rNr
   dleJHATPFUYa9gbLbEVyhaR/HAhQBXU1SsdKo4kRBuCa4vlrt3gJudBYY
   4sND4LyzeY85OhmCm2gvBVJrxZD7Cun7EclloIP/hlv7tpfJHD/IWhFrp
   K4jltVeKbUC8KhJFI5dlJQh7DFK6GX8D4YNadAgfpGn1UUHE3qLxLfmeG
   Q==;
IronPort-SDR: fnKTFa9hLgyX0u4uJ3Uj8TAOGw2owmK9TgqJFW654jIpfqJo6k2uzRaGiV8QWF5mVrx7xocDD4
 smsb1hegUjQ+7KnGC3L/1i3agslh3Hvvj3SCX9vL+MzWttV2/wtbgn1U+l4sN0vNJibMIRjEk3
 pE2wDl5eeJN0JS067j+9qOdDneOqlWnWH/GLfppk2WdqDmVntiyJA58sN+uYXaHqyj1gKmdQ8T
 6XaMu92jvh5jlsdlvhaHqIedssKkJltaHWiOJQ/YGCnN0+sugxOYNk8PSUCOYZ4FXg4hVUiEx5
 Owc=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="154030531"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 06:36:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl0wKS9Wya8jjN3refiRj/7YpLoOMakxXMJftNowZ+ruchOSaBBvKSSoLHvdFAgbFVInwFe5kAxOYRTqMOePl9ROMvyTFZ9k+buclZsJd1qE4EY5PosxCbLJVbX63lYN/WtmBUNK9V9ilz5YU/gCYr8T7x570Qm209RIlyv+isZaVQYrLEA2qKvqX9aA9aiS7KsLuCTHmCsvwIPunOTSAGatIHQX63RHs9ZxQ0hM1yJNJzXC4l+QZrxo3E2Mj8otkMkVhXy7peBm0v9t7QPk3fVI34x0ZaQ3BzdoewW/huKf8o9E1EkL4jQhX1EPhANN/rJCL90ocP5ZoN0Rsn2Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ46lCz4nFm47mL02/uNmNFRh3H7S266ZwFnAGgCAY0=;
 b=f/xCZDZZIzlPtVj5eyv/3efJSGsAecHMhnFwR6OAenk6WllpALY5yg8h1FO92R9+8QPpug7nkcVNqIZXRX30KKolQMJiRLn+heC8fhwgepo/gseUCqGARdPTXIaz1kvYp4gcWaX1J3dcwHF0ZFNztBnLMHKnvbywzA9APllxSvGVkf87aAFft3lvfT05xcPiieI0Ne7eW24uNxbMzqU6A5yzDq05WNKdWB1Pgfn52kO6+sHJtf5+vWbA9KNr9/Sxro72kTDIbLIVlNkz7bk43dDlnYT6rPgeFq19iHzusSqPcQ8AWb+ZgEymXfSn5zhfsZR3CiAb2XIj8naM8E4Cww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ46lCz4nFm47mL02/uNmNFRh3H7S266ZwFnAGgCAY0=;
 b=dFEVVosByhBEyvP4pUz7FZSineT1eAs+mOgYAXzjaH/wszr0P2LTINdYANix4MtOXFhGt78C6qhve3W8Lkc1zq5aDNSJk0augKEpsdAOZQo/Xn0V/lNfSjkQjEZirYymB6odpqccoxZUq4uzq5+G7dHnvtN7vxhGumOsL1HoypM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 22:36:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 22:36:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxskIz83/zqf400uhEmx/aulqvg==
Date:   Tue, 1 Dec 2020 22:36:23 +0000
Message-ID: <BYAPR04MB496540B5E36CD35606F2F16F86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB35989F591B47F3A8AD3E2AEA9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR04MB49656FC8CD2E8762C734122A86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <SN4PR0401MB359894FFC3A97AE587885CB79BF40@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6121d2c7-98a4-4ab1-211a-08d89649888f
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7261FB9B4F6BA438C735D31186F40@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QdfbDJDSA7c9CRWtPw0IgM1iTsfj/CZal9gDNMnXnq4vAB0+18j8HREIHFrwqOjyhNt7LPWMLK6xU8yTSLtZX89owqxv+ELux81j2WM8mvXw/G+mKqSdp2Uq1BEtt+owLhNnRgfzMOlaMtvLq0M5k6HFRSR59KHOzlunf404mfwZKI/S0cpnOQJ5FEwyuAzmEWtKwdiFk6zUSCVLHkvsq7VRf3DD8tY88vF8coQZCl0MXV/4bsmg3C5kwesq7kxNlM9lXLeryzy/upeRJW+l1kB0tReJzhTN/dN6ASsEG7ujIuGras2YMTMpA9xPUHNuDBYB33RRd6s8IonV9m98g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(66946007)(7696005)(6506007)(186003)(5660300002)(53546011)(478600001)(71200400001)(316002)(55016002)(64756008)(66476007)(26005)(8936002)(83380400001)(4326008)(52536014)(8676002)(76116006)(2906002)(110136005)(54906003)(9686003)(66556008)(33656002)(86362001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5+ziZzPzRuzYu3cYzaN8rIT9wx/bO/TvCUXEs6BpxA5BCR1xnumjLRfcUPE7?=
 =?us-ascii?Q?cgFUW7+RSlUKrBAGoPMuUAj9x3Q8DMeRXHzQxdaxwqrVxeHsEFJ8d0JHaW7F?=
 =?us-ascii?Q?Z00UHCR14m3XkDj1agZF7vHipssSl3X7zzF/PRnQBRy81yl4lag0A0gWhQm2?=
 =?us-ascii?Q?Mk9R2t7b4V0571/ePZ9oh8EVtbZifsD7h8K7ugn4QizXOUtwjFX8P89mHoCw?=
 =?us-ascii?Q?r6oRDZkRDb4OKuykyrhZCDNId/9CTk96YHSn1M4ggmaBvoWC3PEbedMyiINF?=
 =?us-ascii?Q?EJ96CLbxsQ8WJlETpIt3bmSl2FT/RPq9TTOGvxztHvD/hqoFIdYTn9lqu7a6?=
 =?us-ascii?Q?DOT5AsbynBGv1yYVpLLV8Ka6RkbSCKznRRrNyYGATquZ0HfTdL/EUylvXa6J?=
 =?us-ascii?Q?ugBrvjbGKt9rRpTlJCVLSfj8SZbZgv0O6XYEvc92RmwUtSS9B1+1937nip/+?=
 =?us-ascii?Q?cU7jlI13HEoL7ZuYFBja9whSmd8kB0CTh18fFYZ2czSEt5BB1QrG6s+bX2+k?=
 =?us-ascii?Q?j1QyYx+fUuGP/oi6E6HjDw6PzSgpCwNDd6Wi4NYRKpnp2ZltNoIUy4Lv53f3?=
 =?us-ascii?Q?rmt+A0OcbasEjCzdKGQGGSIBMS4RdNZjC4KZbQu7sGmaokwWsRisgi2qeeV+?=
 =?us-ascii?Q?8RE/nFkuhwtu0i0vBU7oZO99D9fJLh19KZOV/9JB5G08T9UIaSpvn/QdWIyf?=
 =?us-ascii?Q?8swi8dPtT5qJDmM3XwB1WOBGO98FbCwRFezqhxfihJDgblxb6NHKr9zKLVxc?=
 =?us-ascii?Q?r0+uAX+6iO2Kaabd0YT5P3szEWp5Zcl598YuNKN5YrcOBW/deHX/SBH4zDim?=
 =?us-ascii?Q?Q5XOuPzEab8ZUCiGPyhZHo/btt0JWHBjTtVLbGLDYybWCAGT0NFRh+K5DT27?=
 =?us-ascii?Q?A/w29Qh0gTBK83IAyjDZUf6+LVWHeuSV98uX2aBw2cPYFsKFWpgHtwFOYi0P?=
 =?us-ascii?Q?6MSO/4P0cpxClXTCbb+YrPsS8bLX5VY0skDNlhQ64GSfRT9O07jx+OORK6Sp?=
 =?us-ascii?Q?3Sb/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6121d2c7-98a4-4ab1-211a-08d89649888f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 22:36:23.9866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91NIpGJ4jg40s0MfEuMcayFnQnSXgBvwWEOiVJONVOvd2GKmDEBlBGhNUBeQtJ2Gi7a25btX8V9gQxdJEruBrCvyZPvGpajBErFIC1t/A70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 23:51, Johannes Thumshirn wrote:=0A=
>> Why add an extra function call overhead in the hot path for each I/O ?=
=0A=
> At least in my compilation (gcc 10.1) there's now extra function call ove=
rhead.=0A=
> __bio_iov_append_get_pages() get's fully inlined into bio_iov_iter_get_pa=
ges().=0A=
>=0A=
> $ make block/bio.s=0A=
>   CALL    scripts/checksyscalls.sh=0A=
>   CALL    scripts/atomic/check-atomics.sh=0A=
>   DESCEND  objtool=0A=
>   CC      block/bio.s=0A=
> $ grep __bio_iov_append_get_pages block/bio.s=0A=
> $ grep bio_iov_iter_get_pages block/bio.s=0A=
> __kstrtab_bio_iov_iter_get_pages:=0A=
>         .asciz  "bio_iov_iter_get_pages"=0A=
> __kstrtabns_bio_iov_iter_get_pages:=0A=
>         .section "___ksymtab_gpl+bio_iov_iter_get_pages", "a"=0A=
> __ksymtab_bio_iov_iter_get_pages:=0A=
>         .long   bio_iov_iter_get_pages- .=0A=
>         .long   __kstrtab_bio_iov_iter_get_pages- .=0A=
>         .long   __kstrtabns_bio_iov_iter_get_pages- .=0A=
>         .globl  bio_iov_iter_get_pages=0A=
>         .type   bio_iov_iter_get_pages, @function=0A=
> bio_iov_iter_get_pages:=0A=
>         .type   bio_iov_iter_get_pages.cold, @function=0A=
> bio_iov_iter_get_pages.cold:=0A=
>         .size   bio_iov_iter_get_pages, .-bio_iov_iter_get_pages=0A=
>         .size   bio_iov_iter_get_pages.cold, .-bio_iov_iter_get_pages.col=
d=0A=
>         .type   __UNIQUE_ID___addressable_bio_iov_iter_get_pages499, @obj=
ect=0A=
>         .size   __UNIQUE_ID___addressable_bio_iov_iter_get_pages499, 8=0A=
> __UNIQUE_ID___addressable_bio_iov_iter_get_pages499:=0A=
>         .quad   bio_iov_iter_get_pages=0A=
>=0A=
>=0A=
So it does on mine too, but it doesn't guarantee all the platforms.=0A=
=0A=
