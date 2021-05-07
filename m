Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4FDC433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8236613C8
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEGGpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 02:45:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50495 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEGGpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 May 2021 02:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620369887; x=1651905887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IPLEbQ4uIAaK1UvGBdW/9+IZTRVd1dCLEsAfOVGeSOk=;
  b=YPwIWkUMuRJSgHC8ObRS89usoyzthjsttFK0ffYh4d7IMnLy0AXJYgyi
   5YPbfqnco+VVyacFtyFzYMvlm/KiJ4wtpQnCGK9F2ckHUGzHL6b7Q91cK
   w9XhkO+hcC+HGPz3FSIkNcwQwZhPEXj6RyC59WNwz83JSvSbDjgQ7Bhjq
   kAqMtKPQv7CBgvtEtsOwZahK1ArjO4mLkiUSfcrLeVGPpkjUlMxUham7b
   Q4bJ1OXjIfHWLxSrzxdxQ+wuOyLKG0f6EChzZvXws/EoGE1liziUNL3aU
   VQ14Xt1d//mXq/ZCGH1jqYb1DWK5McAHQ98Bb8Z7pmnS99ER5d3WGw5Yt
   w==;
IronPort-SDR: qH7yE7ekcs+PM6A4gJroeheron6JWWb6U+UnSKP9NN8J32HNhTdIWl8mrseiu4HsD/KyhTOQQU
 yIFheq/TrYmmP5H6CkFNIFT3t77xEIb56r+d1F+cYY9bX6fQP3oxvLD0wk0nruAspCLwxa7rpB
 oCGpNggWe7n6eZutMLpR/XjcsE6YvDo3f2mJLCnnLC373t2AeZjV78NwuEO4JGMwsPP6ol3q/y
 71K8xrSYDC11OMXC2IKmjdzBgqQcKCsld+lpWgVfs2zD5hEJ2SS4jJDdFSo71uKwPaXMSuW6q2
 TYk=
X-IronPort-AV: E=Sophos;i="5.82,279,1613404800"; 
   d="scan'208";a="171968025"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2021 14:44:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CubYOl4GsvH+XWMUBB5SEtypU3emjwsDiCs1WYGv30ZgZCz1CGEBAM23pPEG38Sg4291kk5NYG1TVjVGnpaE/KQ4MzT7tvfWLlAAQwhLw19VUcv/8H6CEtmzw1swIwAyOulAm6Ko7Gn7OkbBsUMiwm6mCYq5C52UiB5Grb4ng543Bf+CjVw5ZNNEudADaw6gqoRLNYktihSDVeFs5qmna4DhBn+2Z+kk9tdb0DuSm3iFDAuQSNRUPBnpa2d338+/UR3Ktyd3bCo9k4ubP32+9iBSMrDX3O9S/iQ3i5wig47mweaFGNabpVtr7ifCOQ1pwbXnokGyRqSCpDix64iX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2mqZeRMRtJd8U+KuToTwUdSG/tC0vbqCDWanmHuw8=;
 b=Q2ZDWMyDI7sxrAf9eLkYAzEtmPc9W81/fdbMWBf3Fe96xy9vdiia7jhXP8X6aHHkqkdlszthcON5KgI4huzWNl14IF6xx5kyMjrpc1+km7uEOlktFNb0sFcAVRFRmxQ3hv/RcKgTNZVL3kkr3gjxvX0oAIuGBz2oWqbhL5RSzSSYpCT0E8HmtfZRayHYkRVrPNvGmp5Y4WElPwH+JXDEbHSsE6tm9NGUpMXnrnEwLsch1zhbq/SKSG69J5LAS/3rtPEYX7Byhu6uasCmn7CHIQ8npo3+6Zac7ZtUddidp4EHHo3t6wQFYdAbab5+eNZ9XEHydLxBSVi7Uea9A7C9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2mqZeRMRtJd8U+KuToTwUdSG/tC0vbqCDWanmHuw8=;
 b=sn5LEHtgwZY9l4MbCQt2BbxNTXiqQkNN24Ce90gSWxCEf3/cIcu3NPUkMVq2q0ZAaPmQOQ3kY+BJAAWSMfgWPWC3ETvDukbdLkRMUFKzVNBkVkiVIqmc+tGj4AZWcSXKsbJGU4z+jAVW7Yt4QcUvG9z6afLjJFKb8kkJHTZ+6BI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB1099.namprd04.prod.outlook.com (2603:10b6:4:41::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 06:44:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 06:44:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/11] Initital support for new power/perf features for SD
 cards
Thread-Topic: [PATCH 00/11] Initital support for new power/perf features for
 SD cards
Thread-Index: AQHXQQBOKEq1MDIHq0a/+nwcAnQMT6rXlefQ
Date:   Fri, 7 May 2021 06:44:46 +0000
Message-ID: <DM6PR04MB65750A91FDC869FD3ABFE27AFC579@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d5f18ed-ca5f-44a5-fb27-08d911239a78
x-ms-traffictypediagnostic: DM5PR04MB1099:
x-microsoft-antispam-prvs: <DM5PR04MB1099FF80DB6F55A7E6B74565FC579@DM5PR04MB1099.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dgjdTmosKu3eaVBqreS4HVVSBJkXLBiPhdO9sSz7yURW8tgeppCrbjFUq3Wg/gPi7I16bwbPSmCg8OkHj3tXZjZGRyQ6VMYvC7GLNBbS/B7PQUPMgPm5T1wJb9qmQlVEacexyeFOan+gTBjuJwXiF2hBa8+PPcic304XbQ9WOj1n/PS/7DSsVCAd/PdeiZi4ekRxFVwWntArJS+XPEn9kXq9hWQSR3qgJXb4xHHFHtddYotcIQQ4lrs6z/ZDpYVgxWI957tkvgomW+hG58tz69RAtG46uZr5UTCyZ4VsOX2vDrpBnZdUcMImgfO7fOWIdZtCXz8v5U1f5q3neNzx4i5bFVDsFHKtdNcDZkegrbAZxHMqbvu8ajm0VQ8QCraD+Tbs/ea0cCotxleOMpVae4vovEepeCsp3iOwWYWS4KFmvLZK4C8YwUSKm3w3Ta2bneFeOnsf0E27BX4gN5eK/QU+5aQsLePb5yy9eFx15y9tOYwIPDVH3OI7D+uw8jiDNUeInR+iuzR/cEEhynquGWIUcVdnlr18leUROyEoCR31VBZhSM190KqRJDt/ezDsN0Vf1WsvAp1ijg3QNCqmri3vgUJzT27Pqv13AztcAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(478600001)(8936002)(66946007)(38100700002)(316002)(110136005)(55016002)(7696005)(66556008)(64756008)(52536014)(66446008)(86362001)(8676002)(66476007)(76116006)(33656002)(9686003)(5660300002)(2906002)(26005)(186003)(4326008)(71200400001)(122000001)(6506007)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VD9qJ7iPkKte3Skm0fk7QcXfjb+CvnA0LvALkfxA1TmFIpHFJq1ujZMyHYHK?=
 =?us-ascii?Q?BTI6kTfiR0DvgmK95ZakTL2+TJzz5MxMUozW4RRKZkzs1OyrJPDjQBX+CsOW?=
 =?us-ascii?Q?014UomOmZAorekQrKRQhjr8aOYUL5evwFqLnzgGButZNuxnWCq/w6m6/1Lrb?=
 =?us-ascii?Q?eGN6xwgE8JPnEz8Br6NyVX80BNkBcPDCXKKZ/+azZbFA0jI3n6tKzPXSAiIY?=
 =?us-ascii?Q?w3rWiuYUPbH3cBNi+moMKYziPpzO7ay61bomEwo/P/sx+IAddjNnrbOjIY62?=
 =?us-ascii?Q?AJFW9N4W3n5o5ON68zfjASQVIl894qgdDHFCK2hxQ/1oZAaHge1vndXCepYW?=
 =?us-ascii?Q?d/DPgTLO2NJF/yyDdrUj5h4BItjQEIiAAHYyxwrbKfoGyPkKCuqRnkXLLKjE?=
 =?us-ascii?Q?UvnyA/qpO7180xi0g/mbUqTasi0cbOVamsdVCBr1CtXNk/rJyKNBlWd2yThh?=
 =?us-ascii?Q?zxx1jIDXmaUlWTWsQ4kOP8SzAli9jYJZNyScCquaxCQIQozUKHltziGQPJtX?=
 =?us-ascii?Q?+1fTMJNpkz8zkgDQnJBlWJajuqWg7TSmvsMWPwXeerjqkMCuOOmkBOyvszJT?=
 =?us-ascii?Q?6Bvm+OAaqXr5cn0BqhxuyEKCcxwLndqu3yV+IEZILx6FWJHEBOps72Bl1pQN?=
 =?us-ascii?Q?Stq+FPOEuDEgnFxH+rUFY20O3W1vHybDYXw5mh0isHRbZTKXItmQSl7k8qp0?=
 =?us-ascii?Q?rhj9SvRbx+vPjAPNEB19d7si7v4G+Zl3CySQ9pCe3ci/nLABwNyGZOq80D0X?=
 =?us-ascii?Q?0feWa/MJZo7hd5qhKd1q/kQEq4AVflZNnokewAbLJRb7a3pV0tvy/uZcm8aN?=
 =?us-ascii?Q?q8rAoyWRgoTZskKHE1BTbwUoBu3cEZ7r8JxkjOFivU68/YZNYpVfpkmqyfvU?=
 =?us-ascii?Q?H0UF0hXI9VvAROWB43l+G7kuhDXoMFYZftpnSn5Vu0LfPicMcVbzvPiuyHyA?=
 =?us-ascii?Q?t2olkEjrzUf/nry4zj/EYyTPJGXPGx3DZE3CzXqHV6rjofUdtavW0HDp/Zwi?=
 =?us-ascii?Q?htZS1JUDnnug5NSNrXno5JCggPk/Ix2m3T9nbu4YNrqdO0st/+HF/rwGwC24?=
 =?us-ascii?Q?S/u8KWyVh4H86knKNJmwvVSj/NasJZNnn14xcuMvnws8SikGFTXBc/smvkRL?=
 =?us-ascii?Q?6jjRl8na2dqNr6X+bWvQDiOn26WT7oUyg4EUMRCu8L05M7Ssa9WcVQW/ATOA?=
 =?us-ascii?Q?uFTpRrskqoLARaPemqTEwj+ZrG+1UevlbJrAI4RVwTknnEFPDsgc9YEi/19S?=
 =?us-ascii?Q?Ggi9TrMMtaU46tVFQTTim/kR1NeGh4CTAtQ/aks++iz2hFiMekqIchYTwn1+?=
 =?us-ascii?Q?/AE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5f18ed-ca5f-44a5-fb27-08d911239a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 06:44:46.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35p4Ls+1wfi2x+cH6ilCokZLo6VJOeP9EEUdoK7rr93oKgKjPj+mrJYT4rYKq81VBNgYeDAEXKSzM1YRtbfFhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1099
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>=20
> In the SD spec v4.x the SD function extension registers were introduced,
> together with a new set of commands (CMD48/49 and CMD58/59) to read
> and write
> to them.
>=20
> Moreover, in v4.x a new standard function for power management features
> were
> added, while in v6.x a new standard function for performance
> enhancements
> features were added.
>=20
> This series implement the basics to add support for these new features (a=
nd
> includes some additional preparations in patch 1->7), by adding support f=
or
> reading and parsing these new SD registers. In the final patch we add
> support
> for the SD poweroff notification feature, which also add a function to wr=
ite
> to
> these registers.
>=20
> Note that, there are no HW updates need for the host to support
> reading/parsing
> of the these new SD registers. This has been tested with a 64GB Sandisk
> Extreme
> PRO UHS-I A2 card.
>=20
> Tests and reviews are of course greatly appreciated!
Echoing an internal discussion about this series:
"...=20
That is very good that there will be a support of the extension registers o=
f SD spec .   It may allow existing and future features to be very easily s=
upported by hosts (like existing power off control and future TCG/RPMB rela=
ted spec which is currently under definition and is going to use those regi=
sters as well..).
..."
Therefore for entire series: Acked-by: Avri Altman <avri.altman@wdc.com>
