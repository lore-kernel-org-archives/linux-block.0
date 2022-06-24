Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255CAC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 12:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiFXMSX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiFXMSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 08:18:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973751FA76
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656073062; x=1687609062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RQEuRNa7jl4cOUZo/na6K/4ZVWzDO/fSypCT6LI2fHs=;
  b=iogN/QbldSGjvbb/yykHP2snSB0R7Wk2Dq/G74bU6GU/d69Os1EeMx5i
   CeqN5BJXRNZU7LtJNzvC6ZpAC7JFzd00Zp/89tXbbd2dr2pgKzhIgcVlR
   zB9cM7vSiN5tUuIWWbf31uBsBYIWEeFk3+XKjH0H01oB+m/2R+6d/lpbJ
   lZLQ/KUSjwpZOYvJ+bA9BEoGEbDlhSnR1b0YUs6fDFDl27NaELThGh//X
   GOz6O98od+i22LvP0E4BxlqnQZ0HO2Mhwuz/bNmh03Is3DUnYn2UYb13a
   mWka1eZa3IxuE9B0OoLkwoPlCU7FzuR+3FtcYxiao5RZJI1ZRUaKAUaRQ
   A==;
X-IronPort-AV: E=Sophos;i="5.92,218,1650902400"; 
   d="scan'208";a="202698353"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 20:17:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM1S4eomctG0epOYP0634xCdWX0atSnbvFpvcXV7OLxRMiAmW9apsiOtxmh0gC5o/NuZuECjVg2D109bBOKR5lQqAI1z0Xxe6kOrMth2KmHAPd7f4wDPLu4W1U+VAI8BXVFc1fWka+yyFWsSadgK6xEFnCr5zVMSvpBomvoJpOMa0VbM4e+sY8iN9t9YVWFpqMWV1X1Ca7wvJCUwm3a41BeSy1uYa9M+pJj+C8EFWRmHt5plk0SgSAQ6TAvEj3CZ/VY3C6EF3zjXYki6geTUXbe9beT9lIVKZG5yUhk0RMYxJrdA0iZNx/OcOv2+yBM1jtnMA/Rp8A96qu7d1CVrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VliMg9yvIIwEJtSq+mpqTh1KUurh6EcJOzNufPpH2K0=;
 b=Nm0K4IWNt3LhNONjlhvwOJkdYq0hpdn5YLZOSOz/Y1WnbgsOMMM8ZBOIiuTi25yc+zfuuBU9onOq1f4svGZufJw4fAIjeMdTuWCpW9Q8bKF/dvOHdl4g6/tZCF+ozqF5lXABoSakQyrWFHJTi8mc4q0OZEBCLfbwA0J7cYH1F3aWgtTmBvmFFBxRRTAq7t4ieE+JOb7WHxdhoqeQKaQTW8e7EmQSC8MC97djd+Zl4WjfG8gljI7kpfJFvosjkk4tl5i1S+WURKDz6xFhqVWcXrDJoPuT/FFUgMNE33H1388rPVl7hTESUgcSQaqCNjTHwmalp+aeZVVnCeRV5UmCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VliMg9yvIIwEJtSq+mpqTh1KUurh6EcJOzNufPpH2K0=;
 b=c/wQnUc+um9/oefFG/MmxeVlvs5GFoFC9gTPW1XNykF62U676OYrT45XP4tGg4Nu30GWCbE0eC5zD+wfZZtQyafb/XIeNE5gV/2z8ZMlYR9s6Z1rRu27t+WNB3DDFFShhW++xdfcP7vez/M+VJr7t2B/JezhjuLnSiW7+YMgExY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5874.namprd04.prod.outlook.com (2603:10b6:408:a6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Fri, 24 Jun 2022 12:17:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 12:17:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "Li, Zhijian" <lizhijian@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: Re: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Topic: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Index: AQHYh58XRETCr2SsZE2RADrDB0f1D61eN1SAgAAbsgCAACaEgA==
Date:   Fri, 24 Jun 2022 12:17:38 +0000
Message-ID: <20220624121737.iqo35ocrtttqjzzr@shindev>
References: <20220624082039.5x2cl26q7v6rnm5n@shindev>
 <3e731962-6bf1-e45d-0b57-04a41c96dd96@fujitsu.com>
In-Reply-To: <3e731962-6bf1-e45d-0b57-04a41c96dd96@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49e469ee-5d2a-48f5-cedf-08da55db87c3
x-ms-traffictypediagnostic: BN8PR04MB5874:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nl8Hv5NvLuiTvrlve+GLdx1IJzzLqyexuONC+Jzl+ag+m8dqtJtVsA9D8/E9hWeFp0Yp9cHc4SkjiyUqTzuapMS5TKjpVh7+kREIjbmhb3Ts2lCBlQyIPzIh41HuYvKfqxEAcWxMswxtqXGwMLV6mQuVtMGxOgpghKei+QfbGg1z6zZkOFcA2i73eav2bzWeiWuE88coBDPRx50WIywAeN5NI017W1/t8tpyXHyhc/W++bL+qEJGKBGvlvbxzhpWBfG7lvBM4BNdpS6OsNZbP2+Vkxq/vC347NeFG3VVRhy80yooj0e1HcVNXcRv2eaFrJ1FMBjtUJJB+6NWbvcUFuyF5xdiQ+lHvK5vR+mp2qQv0O6rYyp1NqFcEx30f5sSTWGiBmmlxy8Vu7KdDvC+hWNyAc2BUtUJ7WrB5gDVZorwoSatHU7DCiqYen/e3Vw7l4eS3b67YI6Vy1mZs4NgBruyoOjZ+AMEPqvYhJZ6WaK/7FZo7P7b/EchAwHYppr7wJtEgnJp9b1ld6mjUHPYGrEWuYon2zpJIdH48JpINCsQSb8kKm+FIq8AIzxeKpTRb+KFwsKY+1AVNd/2qgS4pAssBB4/6sZQghOnfG0bud+SaOIysM0aWIZhLzOnVHQBrJqLDAY/AqtrviEEZDz5Svu5Uc6vUPI7gIRtVxYKfQn1BkB9yRVJSaWtNqhvJAavY1filcuWnEUSI/HDepbyTw5H6OaZqkV0R/3f5nbrcYH7VUHAMa2GqHDsHYQtHxfQz2iOm2iNl4Azy4dokHQRVguvK2Jzc+bSV9YsWp4rx/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(136003)(346002)(396003)(366004)(376002)(41300700001)(91956017)(66446008)(64756008)(82960400001)(86362001)(66946007)(8936002)(8676002)(4326008)(76116006)(66476007)(9686003)(1076003)(71200400001)(26005)(316002)(66556008)(6506007)(6916009)(6512007)(54906003)(122000001)(38100700002)(186003)(478600001)(38070700005)(5660300002)(33716001)(2906002)(44832011)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEfCDS1yxomXPlSLqX/j1W45DGoGZAvJ3vxqi1ffouzAr17pXqvjqPXzpq5o?=
 =?us-ascii?Q?eb57FqgaE/7ucfX3ZQBqOzf70rSm29NkHJxe6CVCkS+FvxSa9c4lMsSY2qfC?=
 =?us-ascii?Q?/qBJgtLORtPA4DSj18U3WEFE7bLf0+9plejqZQtR8Y+6zChT1XnOMbxvvrlH?=
 =?us-ascii?Q?WN8NjffBwuoPfKg2YJ6SK6yozNTJNr4HOKo5yOE3BafhLZApVMWQNPGEwMaW?=
 =?us-ascii?Q?lhbo4Xc10RfSCVGRUBbLhMjFiimlffZBLBo+lhdy70yuZr1YDcQd8dsd80+h?=
 =?us-ascii?Q?4PhuwaWEVhD/QbNRAv3hNxu7wTdI7dM4z8WHomO5Hy3k2MZAiqpS5QLmdm5H?=
 =?us-ascii?Q?RhyWGWSoJ2GLKdVvJp/oRgAl88TMC4I+lLLMX9VsJwzEanKDRC8yCITevT7D?=
 =?us-ascii?Q?0VdNRkHABR8FU9ZWE+9mxXOQV+72CcqEt/mRUhbvM0ClKJTFka0U/910u7Ka?=
 =?us-ascii?Q?lKtLb5oLHlhbvYoXxcV3T/I4AzVMxEQmu7rjbizlTRqiP8PwPNz66fP0pYWL?=
 =?us-ascii?Q?ccQA7OzlW0jUIGTMgjdFUY7YNNXeHtihv2Hl/gSGeHV8z3jDLuzg3O4tRiLx?=
 =?us-ascii?Q?H7ZwEvL1yXRSem//vMMKC8/DVW5AhdYsTIc/xHU3SsOtWvJOR2qOdVUmZKyd?=
 =?us-ascii?Q?xdfjmyJ92U1KHY0w2S7JKqQizbWJw9AeusgDIOrjMuJn25gctZ0/2c4x2vHP?=
 =?us-ascii?Q?2JxUckB9saKwkrzs2jX5ozRmqJBtUaIFtAKmdO671s9q+lwQl9ebJnanOwst?=
 =?us-ascii?Q?I4VRTquelYO3EK0zdH6c/sYIQfEIgY1EZJ+izR7QLGVOEC61NvLINhMfcOaU?=
 =?us-ascii?Q?wHmkRZ0ZAB6h7p3wtE7Xa5qUVGYUsF1Uyo/xTa807cXm4Sx0vqJwxYBxsDi4?=
 =?us-ascii?Q?NpFYek/KI1Ci2fTN2I/Gr+6ppp089AXjHz6aQOCxwRn87jMmFfwTeA+A5zo4?=
 =?us-ascii?Q?M1T1CGXLef2uFka003sCRCLnb/coP0OixyTLFDsR1FRzjki60eWKyCvEQ1lJ?=
 =?us-ascii?Q?OrD10qM04B3mb7buzdZBmC9/7lQNoi5rL0XqXUw7MZS+oG9yzhkPS6YorrAM?=
 =?us-ascii?Q?Vh4KLpTjOcd8TcqZO+w+i+C+9jCLbZutrwt6vsQ3ECrThapoqzFUOA2g1x93?=
 =?us-ascii?Q?mg5EYmsvn1IC+ch15Y3OS9V3WedprqJOySzP6M/fXqnr1HVhelnE5FxX77Pm?=
 =?us-ascii?Q?IboZBCCoeBnTqSB4+YfUEUa7vrfGaYM8koDy0gGf//EdzmbJWmfYJp40mDIo?=
 =?us-ascii?Q?TJ6Rcigs5gaCagEwr62XzKlurewmtl6IAPWFqqol3qjvM+47Cm2txfG6AExL?=
 =?us-ascii?Q?AAtIpQMFmQwEZlNP3vTOF3MJH3yrtB4n2WlQgUVSQNY/0oxJ9onrGlrRnTum?=
 =?us-ascii?Q?YsO2a8+fZelEt3O9KWHEcWNkoRcWYgaRFbpcX9qoIDgSvbeCVbhlRvZQT5HU?=
 =?us-ascii?Q?NidJbLHqCWlxnP4HQPdR4wGjsi7EpNrJYoB/NGZ/E0p0QR4gmx9OGgrhohod?=
 =?us-ascii?Q?sgci+x7rvQCxct2U4sRcajpr5cD33OT4u4UXOOPwExfdDMWgo4zcmOON1nU1?=
 =?us-ascii?Q?awkOjYencL05d+XhS61xAm578VaCX/6x/IjwKSFlDh9D8ZYlROVdxV0g6BWE?=
 =?us-ascii?Q?SA4Y3s7a9E+qSfHwDxYplF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <634A0776B6D44141A7913A8D77CD5DFC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e469ee-5d2a-48f5-cedf-08da55db87c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 12:17:38.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmNzxuCs7rEIy++OX4XqQjxe2Orx27faK5D/fYsHOiU+Jet1teJz2Chb/rmq9qFdwdjyjDj/R8pm9QEA4Uztv7/KvX6VvO9IQODkWL0p/a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5874
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 24, 2022 / 17:59, Li, Zhijian wrote:
> > On Jun 24, 2022 / 15:50, Xiao Yang wrote:
> > > In _have_kernel_option(), SKIP_REASON =3D "kernel option NVME_MULTIPA=
TH
> > > has not been enabled" is expected but all nvmeof-mp tests are skipped
> > > due to the SKIP_REASON. For example: >
> > ----------------------------------------------------- > ./check
> > nvmeof-mp/001 > nvmeof-mp/*** [not run] > kernel option NVME_MULTIPATH
> > has not been enabled >
> > ----------------------------------------------------- > > Avoid the
> > issue by unsetting the SKIP_REASON. > > Signed-off-by: Xiao Yang
> > <yangx.jy@fujitsu.com>
> > Good catch. Thanks!
> >=20
> > This issue was triggered by the commit 7ae143852f6c ("common/rc: don't =
unset
> > previous SKIP_REASON in _have_kernel_option()"). So let's add a "Fixes"=
 tag to
> > note it.
> >=20
> > > --- > tests/nvmeof-mp/rc | 5 +++++ > 1 file changed, 5 insertions(+) =
>
> > > diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc > index
> > dcb2e3c..9c91f8c 100755 > --- a/tests/nvmeof-mp/rc > +++
> > b/tests/nvmeof-mp/rc > @@ -24,6 +24,11 @@ and multipathing has been
> > enabled in the nvme_core kernel module" > return > fi > > + # In
> > _have_kernel_option(), SKIP_REASON =3D "kernel option > + # NVME_MULTIP=
ATH
> > has not been enabled" is expected so > + # avoid skipping tests by
> > unsetting the SKIP_REASON
> > Can we have shorter comment? Like:
> >=20
> >          # Avoid test skip due to SKIP_REASON set by _have_kernel_optio=
n().
> >=20
> > > +	unset SKIP_REASON
>=20
> Well, IMO it's not always correct to unsetSKIP_REASON, for example, if th=
e
> OS didn't have kernel config file, we should report the test as 'not run'

Actually, this group_requires() in tests/nvmeof-mp/rc has another
_have_kernel_option() call for DM_UEVENT. It will catch and report the "no
kernel config "case. So, I think it is ok to apply Xiao's solution to fix
the current issue.

I think Li's point is still valid, but let's take action for it later. One =
more
point I want to mention is that "unset SKIP_REASON" is not a good practice.=
 To
seek for the best shape, I can think of following changes:

1) Introduce _check_kernel_option(), which checks the specified kernel opti=
on
   is defined, but does not set SKIP_RESAON. Using this, "unset SKIP_REASON=
" of
   group_requires() in tests/nvme-of/rc (and tests/nvme/039) can be avoided=
.

2) Introduce _have_kernel_config_file() which sets SKIP_REASON when neither
   /boot/config* nor /proc/config.gz is available. It can be called from th=
e
   group_requires() in tests/nvme-of/rc before _check_kernel_option() to en=
sure
   the kernel option check is valid.

--=20
Shin'ichiro Kawasaki=
