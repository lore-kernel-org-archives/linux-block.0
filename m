Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E517F4
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WdcaaJWR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fnuIwKdW"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8E10F
	for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 18:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699323916; x=1730859916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZQ0Q/rJjr+XBF5isQG3JT5/qf/DedKuXx4fKVU9b97g=;
  b=WdcaaJWRzrvZJIgb0HumqcD70KcSXsTH3OVeJD6TACDl/oPuCEEgMLWo
   8NeUXXMJ1ck/PNAQZV+diw4QfEy8/k85YGXTzZM7ARHVwNP12yiNbpC+e
   +CKMFi3x04DtOrnyPp4qdAbYDTJ/ZIC1uCN6A7QQVzC2Up7k+WGzUf9Iy
   JI6PMsRgBrwccBLo4suQPQpSu9f1/uhXheqWFS0dZrO/Kurc7/z+VEngZ
   zOGL7wQadnY2EDUQk5LhGdjUuhOdBG3R4ODgzXUCfW5JLN4Wl+G9pWYHd
   X/f8DSHX6ihFpb7XTVxC5vo0wx/fOTHREqGFiFUJ2ejUZQiugcTBATn+P
   A==;
X-CSE-ConnectionGUID: 4NINzEPNQ5OSvcP9JFgH9A==
X-CSE-MsgGUID: /f+I97WpSbCnX+uTGke1Qg==
X-IronPort-AV: E=Sophos;i="6.03,282,1694707200"; 
   d="scan'208";a="1508970"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2023 10:25:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3Kd29URFxDm0PifTmmWrGHkL9szz8rIZJcsjXNvN+PmaiTyJPd9vmOEVfOPkf70y9XVPrnLbGgeXAYwTVCkcm5Yc9S8kJv+UG3/KFl4eqqTpK5lV2ZE8IDb910qlNlvsDEYzO070qBEQH7Vw90tzJLqnRSJkdsF2YegdbnUSMvgOkuO/uEKvYfOFR2BdGNnfwb0qrlqW9457c5c/D/ZCUjQX21XKpweIXrimLl+6+1k2TzMWGXNMqVAx2OM3VBk83LwQeT3Ryi5b+e0t0PkdOwajlNgkAdr33EqkTszHCBnSAOl8oOBhs+podiVXKFSCcaRK336pwFFciWurqX9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ0Q/rJjr+XBF5isQG3JT5/qf/DedKuXx4fKVU9b97g=;
 b=lrXR2CSvJYWQmU/s5XehI3IabBt4+t47CPo9kVKn+ePFsJPLGCaHoalO9EUVcdanKCulTxcY9I3K2b7/ocshgKZEhws77cSsHw0/VccADyup/9Vb0MsBaJ+q55zVhiZr9v4Fp4gLR5bHS7FdGx92PfRpSU3W9G1qAWKtsnpcK3mIjp5B26DfQN+zq5g90qfFLGiNvIPTdQbvXkgFQnkrtH00+kLPgu2YB694qHSqIDz1e6msfdaBLeQlxuutmqO4ni+hLssdjJxHFou7plB8erHku2lEoM8UHLfJm/PgtT72nfFvuQDLmhEGjyVl4FJBXTKxJ3qcDhdTmAG/PFYGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ0Q/rJjr+XBF5isQG3JT5/qf/DedKuXx4fKVU9b97g=;
 b=fnuIwKdWFmOQB2d7CT5nD8bizHahTOBcRIcYzVjcct3Fo0c3Q+U5XJsMY45sIy7M078VZx/u/URPd9w3oL98nLH/AW4DMyIzA5MbvKYdl8FsKUrPfsTEYP/VB1qWCUk93Kcrn84IBOD1fhKWKOCi+kpTbclbzzo9gJWCocvoZBU=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by SA1PR04MB8466.namprd04.prod.outlook.com (2603:10b6:806:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Tue, 7 Nov
 2023 02:25:10 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::8da2:bd08:c49a:dc71]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::8da2:bd08:c49a:dc71%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 02:25:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH blktests] src/miniublk: fix logical block size setting
Thread-Topic: [PATCH blktests] src/miniublk: fix logical block size setting
Thread-Index: AQHaDxkP5tfiJyaPwEiUXccbnlwV4bBuJP0A
Date: Tue, 7 Nov 2023 02:24:57 +0000
Message-ID: <gq3km3vdrzqgjn3kvihmkcrrqq6ra4palxtpztigiys44sbla7@vqtm3zmbvaby>
References: <20231104121742.178081-1-akinobu.mita@gmail.com>
In-Reply-To: <20231104121742.178081-1-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|SA1PR04MB8466:EE_
x-ms-office365-filtering-correlation-id: e6693eb8-57df-4517-3aa8-08dbdf38bfe8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 25MsWQBkJNoyZEu1BDGUAokk1QUns1AgD+2X5XEDkLz4ONKxhBU2fpZW7MczR9kZst76laMK+RFwjn1XsYL4NQ7sPkFgqzmYfEb/k5Uror6OK9CICZSmmlB0omJd/xSDiFIfEHzxgJ81CIIsZhKH7CPbRo80E4dDTUiLmvCEN0TZ2RkA8a+Cmp33XylaxF7J2gwE/h38KMIRBruA4bQRkKmn/BPz7DAEHKd/8FLmURGfAISIfbmCi9kHaFxUvEVF+Gfi1zf4vCCRzAfBB7pUM/YQRq66jgCNnkKiWQsZQ1je0Vj3vXoyjWJ/b8EFHGZ+5RAX2IVAFStdQA4DUSwfIBQTZB5ZalwziDbLHwoJZcjTdqus2sLzfA3uINrM82dseERoPBzJBHwJSh5+PFdhwbfq1UUm/Hr8XPJDxe/z8rkQdOVzXYObNPFbAuV1Lk5hawTRMtLM4vxdyb1TCTa6nRR3IskXP1MpTMXFL0DKZp0l1H5BBIVNMmLuHUtnVjjEkFxh5Uq5k8Xr5zPscksALWtj2H87PBkzzG5QxJivO4s4c1wcNsc00bTZzUgqUeTcRu285EngYjCNxmUaxD0hkHxyar4muK8UyJDKjeyIwUh+rdHemmmUT9jQanu0y99R
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(83380400001)(38100700002)(8936002)(41300700001)(71200400001)(122000001)(6486002)(5660300002)(44832011)(86362001)(82960400001)(6512007)(478600001)(8676002)(2906002)(4326008)(4744005)(6666004)(6506007)(91956017)(316002)(66946007)(66446008)(66556008)(54906003)(76116006)(64756008)(6916009)(9686003)(66476007)(26005)(38070700009)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?llyPNKit8punjxqbjINpKSnz+q4KbSvesOSfOtgjj1VZLgZ3QbznlJfHzWrW?=
 =?us-ascii?Q?bhAJzfjo8BLmrk7zL0E7SHIGe4EzYK4DPw24wQkiSZ/RUKIJ8zdRKY7/DNug?=
 =?us-ascii?Q?DAB1PckiVrLYyfkA9WvUxK7jLK/oYxksMLbkhX14LBEXDD+saNhGrQlRzZcv?=
 =?us-ascii?Q?jrmPa2UpZRLURSPx9oekncQfK0gd5I1Yqqwm1eX4cGN5iabiqWpseSHEgq5c?=
 =?us-ascii?Q?fWXKBAz0tYFeM3viV0F0yA38fLb64ZNxst/VDg6ek4eMxKr24NzNL3KReyna?=
 =?us-ascii?Q?8k+RXOzKF0/mS0eaGARyShoL+4IQ46cex865XJq18E6ubi86+QE7PGHhHP/M?=
 =?us-ascii?Q?NqhYT03Czdj7jLd9UcRohKsPIGPWG8cwbPi0ZqebuzfXrNVmjb2GxWMwO9Qv?=
 =?us-ascii?Q?E9p680GBpDulOqSaITkcx1DyxVPQIMczIfrfMGWsrBGSwkF84N4reHZI4ifS?=
 =?us-ascii?Q?T11jiC+Jx298Xl3nIG2YULQ8clv4RgfUFsSTG4Qv4umwHQaikQmwjazcHYVO?=
 =?us-ascii?Q?HDRJX9x6cmUux1TIN+L4r1KPtI4T6o/u8aKZDb9vwFG/VUqAm+mPNJYLWLVr?=
 =?us-ascii?Q?Oi6ywgqxGDpLwZe/eAXnMbnzz5Wmes778efTGrUiA9tm2XoeIPVahvIIIMKz?=
 =?us-ascii?Q?ZKU1ekyWEHAVkc+7XP6Q8EOFx446Px74QtmXXBS2D7v6Yp3ugxdNDeKsnyU9?=
 =?us-ascii?Q?e+7HvTmHKPDOOgrqu/LxOsMtbcY3O7yP9gdZ8ud5x7CFW94bnPZ49qXcDmjq?=
 =?us-ascii?Q?yTeJjjGDAg1szCAKtGcUhKK/QPdU+WK7XJEgvqQ6MirYO2LFNL++6UezwnS6?=
 =?us-ascii?Q?3Bzo5RIBpY+SOfGW23koaA7Ii1v9uJ+m9pmjEFl+aUUL6BP8Ty0VWQZTcj7F?=
 =?us-ascii?Q?PSO+AbitLaAaYwk/0SUNYoBg/uEMWNtH9CjOjTB1cU0+Diokq4v984j/nYUX?=
 =?us-ascii?Q?tjCSbWAO9XFFTcShSwr9Tjog8O/xchR/UF4uI/v3ywQZh2rBjDtrvxkL4VyJ?=
 =?us-ascii?Q?MJoI4mFz49FVuyj2xnLeveDtFelwX7HwR9LVudcP9oUPotpVq7bYP6PAMiE1?=
 =?us-ascii?Q?D83M6AKNykfbiv9slcZN951exRRB2fILTPwrN8WFCtrU7y1NtGrhxRVb5ANs?=
 =?us-ascii?Q?MzbsTlWNwfBMNWlxE3UAEoNM82hmqu4HkUG4s+GXSoN+q9LKOBdrJnOmh1i4?=
 =?us-ascii?Q?MLWAu3YDrtG0K3JYfOz/qDbyxAf2J0J3Bch/ix80qQSi31Dc3DyVAgcG694U?=
 =?us-ascii?Q?Ga27+ms9bN2MeOB+r0yM2TYyeTL39c+GPTLEm/sPntKd2Rgc8Fq0z/aclkaI?=
 =?us-ascii?Q?ORLitYhHOnoCc1xX1mDdLT6kLTqGaiWoO5k2dGvceCRF/hRZt6U7AvhPPv7C?=
 =?us-ascii?Q?ldD9lAlsIULm/bzdJ3bC4qzg1md7BtsAst2qsiizL9D9o8vJoYdBRIvF5Omk?=
 =?us-ascii?Q?Y/zd20EjCepSLo4+hbFs+QmnOL/FLBvQ87SC7A/Tos+DImlm6xFPrOCpzRH5?=
 =?us-ascii?Q?9TdlNzgtkFRFBsMRjN+MF1FCEtdc4XlXxDN+qty2wpbKlaOeTr/g/Z8GDtXi?=
 =?us-ascii?Q?1dZV+IDHg04dTB9NyeNYs0FE/iWV5QFWiCyBnn6ngjTUE1OWHDJqVOLJUpyV?=
 =?us-ascii?Q?RPfQo2hH39P1lLnRenADrNY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89E01A3BF377AC45A09C3B10C0295FB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sqBLXzSdA58RUpugpCmT2MP4C+XG9b9R6lz3H/XcmxGdXCOOBuptu/wvn9KfU8HD6fU587sLzBOLoMsBxVqkUC7/NvE1lRFjNGhsjowWqihyG7HcMwXR9Gg1YLBe1VDEa9o9ryRY14npPzt15t4ULdVaaX/YKI8emGncNrXRjyuFNYVuSXrOxm1UBqAL4slZ1PTK6dznNBqWLBvMqqv5s6UXQj+LffTGPmN9zbHZhwXOqVeWL7NVIyVE8U2SfcpKQEZo5CgPZhXXMWCe1OpIRBDssV2Mo5vvVttC3qsSZ3DeIhGjELFzGJnYKitZ2lPpE4RrRks+kNv0GqBpFWPDjhr1gHeNDmTvkxi2/mpU/uVbeRWiHS4WhJyXLSxAACdubF0A/aNk7k1s2v1u/2z2oonAUYlGwwZ9Ifgcc/mFn32+uAoDUl371toecj56LyIaRRdbIZjqsfRNwk/FM8fBMFjy47cl8DAcQNtjqhHYt4Z6spFkA1ocUFJ9h3HP8mIPevGs/Y8dpdFVWTK9agxTRgi8HpKXOWE2AzbM507/A15YV+vwY58zkgVM6ltZGCwi2cG+FoEycVE3P9nF5JSWbxKy1IbpR4WWq8r/YuPLycEHPCENyvXDjZbTTIsIqVA2K4NFkjLHq1DFWPC8Kq8H4aQ/X4ggzGIDQ263ysPAB7jNPDawaH3UpKTaJrL8+44nlzoFMfk14iRcpX+HcfPP1iTOm8u+aPoa5kNanSG7g0aPKdKynNzSaAlJT5/ukFHIeMXCHI/Oe1AafMc2zohP3IqZq4GsUXWk6ZxM2TK+uYbDVyrnAahkpN5NL6Ih4yMI3K1uerRDN/dUu02sOD99Og==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6693eb8-57df-4517-3aa8-08dbdf38bfe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 02:25:01.1620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utdfZ8oVzrPsHC5BYjKmEZmZm/jCIAfEDI1tXjhxBhY85crc3f2zPm+WFYpVvxt/2WdgyS3Tt0h4RFjuvZOmBpP9JorvsSI6YqvwMZgPA+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8466

On Nov 04, 2023 / 21:17, Akinobu Mita wrote:
> The miniublk always sets the logical block size to 512 bytes when setting
> a regular file-backed loop target.
> A test fails if the regular file is on a filesystem built on a block
> device with a logical block size of 4KB.
>=20
> $ cd blktests
> $ modprobe -r scsi_debug
> $ modprobe scsi_debug sector_size=3D4096 dev_size_mb=3D2048
> $ mkfs.ext4 /dev/sdX
> $ mount /dev/sdX results/
> $ ./check ublk/003
>=20
> The logical block size of the ublk block device is set to 512 bytes,
> so a request that is not 4KB aligned may occur, and the miniublk will
> attempt to process it with direct IO and fail.
>=20
> The original ublk program already fixed this problem by determining
> the logical block size to set based on the block device to which the
> target regular file belongs.
>=20
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

I've applied it. Thanks!=
