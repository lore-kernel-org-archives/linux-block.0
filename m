Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F571C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3812461244
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbhESHjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 03:39:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31120 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhESHjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621409916; x=1652945916;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CKuyvZMaZ7QgpC/yzitwAfHPwy8edZhU+NPOR5fhbCgdF32EsW+0LcoZ
   ogs+JecFwBrAKRJWIxu/GR3ypRlMLpKnvnr18+PbCUi/VRH8epdHYy11O
   fYg/xzteO4gA4UXCso/vLqD19SmzFd2dPh048qEmJrk8GwusYXJ2NxbMe
   O088hvim5QGE4rX7sLNkP05zLqCJZz1z7D88CZCUAGGZntfi8EaoSu06W
   sDfsUu7hLFWt/V78JK0BS2deWVamoeH+UGMy9VQx/1R9I6GBCshbAIEHr
   W9jdJVgpEfBASDlEm9X+dpU/0+lP3o4vuNGZPBXuSyd1aWdSWOvEW1McA
   g==;
IronPort-SDR: Ci/vz2szrqUqETcbiIKJC8z40VSuN0KiiP/vPizigWkTBRnw5yv0tL7dco9BZIdsAevtpBfrYI
 bXCeVMDOS+7OC7AVNvRhkXtpDYjJXqGhMDyknRl4dFZDLGu8TPh3FcTUJw3iPQed6HjA5O+dqt
 cHGbhd++qBCx7bbg4AZvGRsJ0y9ymwW7wj8T0lnPJWuP8EFwKivvMOIu5LMPmO3xS5Ty+V4puh
 5CScc8SAzaZsvgwsc/A+nzUvKWga7GBCiC5VBut/b3ErlWslHzIcNCefzP3ZdUoGUXqSV/88J8
 8SI=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="169221457"
Received: from mail-mw2nam08lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 15:38:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dREzwQgIuUb3EULlwZWaTGRikJh028wplYWNvlYGgDLjKYwdt+cxWMoByB/JKwdNli8A585Dz9EFOUvCyhJrrbwUrSciQrGNVBeVgCSNm/UoyxjF6nNKPQwhF1dqCQPTDcbOvRDA9WrE5WKMGZ0am4aEEC+IZCW8Z78xF181Be08WDgYNsznfJK6IWv+J8O8l/2fUSwJoia1GReaxXd2Q+/an7ZfimhIU1WZlUuXabcjQqEMDrnxWUNVKJ1Hn7Z5T6wnDRiytUWe0pMAXtTACyle+GvVMW6l2357LjIi6kuAdz1gPonioePULQ7kCBqe3IfX9A7EX1ik+AZHiXoB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YJEe06pYIvG98Vk9AXBHNJKcUrmuRl8rBpLiGauGScej8zgWyVND/hhqxfuHwEzTxQDiJmBZmMmE5Ja65+tpQX9APpbUJU1du1RcrEgygUD0ox6LpNJxRqMfr80XBu8/R3lRcNk07XquZG0A76iUI/Zmp4XiQEstmbsnrnj4su8sYUwhlQSettoTWU5Ipugsya2/cCsuiL4YIZG4kPPPswS5EahB3I4NlLVWkdB9ovcu0VU3jxfeuWVqJ/QRSJY9UBeOJDXzFMBXGS/KU6cLZ98w25GXkaRWpNqpDn+Qny6VdsrSplS0nG3uoYzxFKIOul5pkLDPQtIVm/VqN6Oprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=b44f/8uhTOAorf2eSmhWCdV2zjuMzgaI57FWGbsaay51XeeLDWe9TU2TRG+wqDBABp0ynrVLrb1NXhnNP7EaH5gPrg+OC3iu2UVuS0SsDaacKYfqjEA4KppIyh4vVqIOpw3SzoSAqY96Xx0feEYJZQaicC/46+XqgG4DZximluw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7478.namprd04.prod.outlook.com (2603:10b6:510:4e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:38:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:38:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 06/11] dm: move zone related code to dm-zone.c
Thread-Topic: [PATCH 06/11] dm: move zone related code to dm-zone.c
Thread-Index: AQHXTFp2pvRcCsEC9EaH6f4I5txWSA==
Date:   Wed, 19 May 2021 07:38:34 +0000
Message-ID: <PH0PR04MB74164B53E7862284237A47C39B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-7-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dc2661d-fa3f-4355-df8a-08d91a991bbb
x-ms-traffictypediagnostic: PH0PR04MB7478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7478E756B6C235ADC9EC89489B2B9@PH0PR04MB7478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KGvrMkWmCwnSLcfQx1nFeLXdRqvvQjeG0JWJg+9gtIrFDFRLUTH91U2o3ZgpOmiKcbzqUZItsAzg+4ktr3kEeJiQjrrP+hT6h9ZaZKWcWf13/TrpbHolCaTMhp90B+6xE8oX2QTlMR8qHpkv6DrBjSWs3/rHEEdQOobuFUN8HmD3B5IqN0VXQ0vmn6ZZjqgn2ytDSeGyI9c+NO4X/T9gZPVTEU8W2eFwkyagsGYkoddWu6Hc1rUbch+9ArudzymcBf2S3UfdYPJdV1Ge+8Uvdo2400nfO++hXwerJGiOkvoaQmvtLam+/eVM41icQPZxAS1EfOO32/Vxqan46B9cwxFAg0H/tY0W8bbXHAGtaiSJ3vH0LjdmCO3p7NLZEU8GaDqhOrdQX7PyC6yDjseB1+mPWwqODNWTALJyS4ePMk7lHfQ93jMpKf1XAAyyAdB7tw67NnKG9KA9L0a5DRTWgU9IOtZ81ptfr+Dd8YHfpTk6qKDwETJdJOZ9K93timp3zAkSj+B1VPVcGYivRiMRnVclZh/wyNUbuMCD5wkjdyDsEkKExRvtkVUJwCgnyWWMnv8a6rnFtuGN6JesyAsUj6oye7BilKD1UOkqY2Wpa0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(9686003)(8936002)(8676002)(52536014)(55016002)(478600001)(5660300002)(64756008)(558084003)(33656002)(71200400001)(38100700002)(122000001)(66476007)(66556008)(66446008)(91956017)(76116006)(66946007)(186003)(6506007)(86362001)(7696005)(110136005)(316002)(2906002)(19618925003)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1VEY/6nMxTtpX4NzquYpixov+uc5vawSquVPFKPkarY6u8nWq4XARxf+Loxq?=
 =?us-ascii?Q?p1NUPzyGBgSRhxI9UDunm2/V3RUSuGg/lxV3jgeBd4pjSwSr42RQMZs/jGC5?=
 =?us-ascii?Q?HZt3PvoUfzgmbodZbWKEUJL2kcGYE/RMxAjaFnLxPFpL+Wsdm+1ZD33bMGd8?=
 =?us-ascii?Q?G7va/VqwLzwS2wwKFbStJ9cLV5uyZBMwL4puZEvqGnvOlhb8BjxSWEqd5IWL?=
 =?us-ascii?Q?yKkMPS6GUMQ5I+Z1KF9g1otdpWc88rg9HHpcfbd30UF8zzprsYLGRs3aV+qf?=
 =?us-ascii?Q?WnN4JLdHTFTkVEGGXahDzhnwv6W+oFbNNrBU+dUaW+3DqcBOCwB4aiKpSDW5?=
 =?us-ascii?Q?YVfhpA5QvCsBVBTcX+uM5BxA+c69st7lfiCuSe08M71UykGRaWtC2ypV1fI8?=
 =?us-ascii?Q?gZ2O+Q9rDpY5rGg+ObzgWdB8r6nBGK7E/1qtUD8sGHSUhoZXXm2Cr47LdKLV?=
 =?us-ascii?Q?QKuVQd4HOWB6c1iMIev8pm8+BnxEgSMP1dBE7C14bWcfC+VL20779lXOOqo+?=
 =?us-ascii?Q?eWtWxg0qmccOjY0IqUJPZDQiJba8075iIQAn15aYH4kVsafaNHulVnyu/eRW?=
 =?us-ascii?Q?gzVo3WDYtTyXBRyqX7cFUqJdxTb4ZxC6AGgaVg1ceos18VCv20P8xVj/0xQR?=
 =?us-ascii?Q?zdkFlKOMFlqZN8ikicV3X+fb5b8hHd2UwtitPaCK1cccqrUdZ9gvUr1laHLS?=
 =?us-ascii?Q?ilosghIU9x2XPr/lxG2R0td8eYfNTzxPnCdYBg+DwkvAiSMVt4BimpKC4tAv?=
 =?us-ascii?Q?gugBLeoIVYRbIkYhcwOSvRRkss6ZwH0A0gblD4Sp8gIhre+jkoMpjz38eKMg?=
 =?us-ascii?Q?6zybJcYuNcnwbIjWjostqKQX9/EGZRwm0bdYSF8xoj8elVqQnq97Y1I7ys/C?=
 =?us-ascii?Q?Hz+9fkPLirGmIXt6ntVoowWok8VST/gFx38RfDlg0Bh6kzCJpbP4fKV1rmYO?=
 =?us-ascii?Q?vW9Jr5/F/kC8mWV1Ymu+WvEYeKg9PxUSFaYj3jA5lfPWlbsJjfcS4RZ+LCkq?=
 =?us-ascii?Q?SIlkwdp85HNYdOj/wWqRK4G+l3q/NlwazjpAFTgHYfCxuR4+qekr+p42l28t?=
 =?us-ascii?Q?mIG0MYpn/yvU+FWhDdqepJ7n1bt7uLFQvROONOn1hi+3thHDjmb8rGfILvgA?=
 =?us-ascii?Q?aRmN/aMjgQebO1ON0fEQkdMVjxMOudhHi8WmnecMGutApL+6QV2pfLo+okma?=
 =?us-ascii?Q?WC8lbZXIDVJJF06Nr0J19OyG2dYRixtIYJl5du5fZ8yxjH8T9pflMZx8o7FJ?=
 =?us-ascii?Q?g86lU7MnzwUk/EqLZTRevG1eUNGqDtwpSYZeZ1UKvwvdntpGebAfaX9Ohnrm?=
 =?us-ascii?Q?NbClASh3Uwd6FlDEFZMaDdywF4l4QSwNIhMlghIwPR7FA6PU0ePQH3fqU2Rn?=
 =?us-ascii?Q?uT2W4Rfwu6M0Cea1vYVrFD3P6N2dH6dTvDi7oLkhfsoKGmP0kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc2661d-fa3f-4355-df8a-08d91a991bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:38:34.5290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nNme4QfYheGXBTc8By8scaoxstlt//y4EFTHGiHYmJBJmAkj3M5iDEOFW9CrdPtbRTDnjtl3hGnKfRC0cRHJdlr2CEdcr+tZt0onLYeLuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7478
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
