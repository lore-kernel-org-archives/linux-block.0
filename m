Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49070C64ED8
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 11:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjB0LYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 06:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0LYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 06:24:33 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FB71E5D1
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 03:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677497072; x=1709033072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lXVoS3wS8iBj4FfzCMZcchm4gs8ntyangeQV6JOF7k0=;
  b=E0Q7Zc+ZFN6l1DT3MVYKDesBXaJnBVAzjQt9hwFC3fqb6u/0OePe5llm
   GmOO4PQbq2kVnRQqcJT4BpQR0NQJ1+9KLUEWazYQDFXObbGCyHMhDeeL4
   wHT6k12RVB1EBZhyhc3wLf4VA/pg1Q6rZn362V+EhdTIknaSzHX69p2PP
   gg0BzpAM7TOx3M3jvQ1mLiZDkcgVzm3YcyRyIz1WSnT6iR5QbwYqjpOfl
   G/78ZGRJ80yzG/+vdjBiNmIIC+XSnAG9XIIUyU8gDc3+Ng65X8HqGx00Y
   wjMpOiS1NuiDVKAhUukNh0V/vh1vxousPUIxwhxUxJ+Zgb7r779pKvPFR
   g==;
X-IronPort-AV: E=Sophos;i="5.97,331,1669046400"; 
   d="scan'208";a="328629726"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2023 19:24:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ovyk2lK/xsatxS92gSrutSrD41/7y2QM0PwaO74Uu5xv1xxUpKaA2/0X2YVyCzO3sKfjj+s/RuXJvGrZEL4kL7yfdibWhA7jRbxNQ2/uAGfFYXy+xKSiQv5fzNE2ejWfekxVpFrrj95olPp40ooHzX/PE5wmELa0CBVo30uKY//UHZ3olApcGeGOovyJrrDgMtYWhWwZdUi1F3tm0G7iCRYSfkjG9dAOpJd5etXQSPEAYbPDwayK5glflLUxRnwMNVPa+hmeHmtPGZZ8Nirhn85qXRTCFBzo26pmPzy4fEL3Fl16w/sIit0mXt33Pd/+OOnvELWmN/5P6hptuOQkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56TVo5PzbO3nndLEvh3Nv1raLybtXGSFdywTtqwYG5Y=;
 b=L2CWIvxDp0+1j0QYt7Wr8111EK7eezNNq9l8MiITsZ0g6Jm9sMjAZWMY1ldPx9LV8wxb9a4ruQsyfqi0MVSrNM+t9PdKHKjEqC6HLVLZuYUleyfZ2caXJOafJg3Vu7YIeEW104VuGgXI9cIbM//GIMY+XhQ/bmvnCicxkm30gveN0TwVEJ3LjjPMR61zwR5/jetbi0EFGHkxr0/7PBLCmjhW+sXJr7W5p9HLMitOYV5T1HnYnpz+Xd64AkEfC9Y/jCzysh/q+9y3KSCNK2bNNBBBxJ2aa6BwaArwdxVaqeh4PP1vuts2d6Soaea4DtpZjr7zfdZC9eacrdzi3SPubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56TVo5PzbO3nndLEvh3Nv1raLybtXGSFdywTtqwYG5Y=;
 b=awZqX3hDJUreo1A1sFCwimaLBcs6gECfAyTMQaZ8xwS6ZUw1FaWF/Ijxeb6DnBS+Xfs8D6B8muJf5sIV7zkn4XxNeCUVGikfP47W3AMfjSGonh9iQZVwX/MGNDy9jDF5P66r3Wn/J+T2tlxD+nUyVOnKYSqjciAK3AxVDp7NU1Y=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6158.namprd04.prod.outlook.com (2603:10b6:208:d9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Mon, 27 Feb 2023 11:24:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 11:24:04 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests v2 0/2] nvme: add test for unprivileged
 passthrough
Thread-Topic: [PATCH blktests v2 0/2] nvme: add test for unprivileged
 passthrough
Thread-Index: AQHZQC95ye+eMiEgFUKCkwYKThw3f67iYrKAgABY7QA=
Date:   Mon, 27 Feb 2023 11:24:04 +0000
Message-ID: <20230227112404.gzvugrzc7drqhomz@shindev>
References: <CGME20230214044749epcas5p4ac6bf441e046e3642b1633fd9cf7a72b@epcas5p4.samsung.com>
 <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
 <20230227060547.GA25049@green5>
In-Reply-To: <20230227060547.GA25049@green5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6158:EE_
x-ms-office365-filtering-correlation-id: 4d7dc20a-8e25-4ca2-5282-08db18b52264
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbp18j/uW4OCZLTQMN9Z/yRuLzKlouSTf5LwRmqWLKpGnmdY7OWUlNzLfKBlg7IXywqa3S4aUfqWN8LAhlSQx9YrW3EPm73oZ6i13anEkNjE7dXVS4jLuAvF3taq66RyNxsw4MOwz1JNNsDJdv554SShSo50aw6f/48Uv6EN1D08uAalfzmqhF20M+3M5Eb+gDD8c5/GemYZ2WqiyrvwDBbBZvUi3aA9Q/SlKqEafwZLR8TxP461qXpgJ9geOCGX9LEu+Q9seWiJiPP4UwjjfO5xZtvZFjUe53PAd9RkK+cpSSF813tt+Nv2uEFxw4gCjV8QxNPXGNYDpzIfwS/SiFsPGs/smNoACLUCKe8rOTN2m92KIWyT6ziIRYTvXeOk/0mz4Xr4dUgQuhPApOkv2BsQ5J2tSkSUgrpqVewvLsUWHDRIy9dMeDaJ4WYXCz8Abc3ZfXl2Pc1UoOxOoyK64VLfjXnaW7pYotTjkni/kxsffo0hDhcdZqP+nlI1VMuJmpirKAJKlEfC8CA6qqGgVaZEYUBMHqqR2A+A8rARKKOLHcbp4tRDo7l9rs7K5cEGQwIW93RY5xBEQLx2mjW56UTeFdEaFAg6AUJOwh9skDER8P7EQMI1pnkc7mvXMzGMtW62b3VvlIdhrnTaQGLJSUFE9ETfAZwJ13YA4oEvOCykCdqC906s/SymdRxRb9coyESX24BjvZYinqAENgGbHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(316002)(54906003)(83380400001)(33716001)(86362001)(6486002)(9686003)(2906002)(478600001)(5660300002)(6916009)(66446008)(41300700001)(66946007)(4326008)(6512007)(66556008)(8676002)(76116006)(8936002)(6506007)(186003)(64756008)(26005)(71200400001)(66476007)(1076003)(44832011)(38100700002)(91956017)(82960400001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8iqA7xcEEVwiXKsaeaF72aALGNdizh19fV/0af5YrviuTR0bNlTG5T9mblK9?=
 =?us-ascii?Q?Yd2o29v/KP4idXFDuWftxhJ4J+gEKn1K8OzpEhJeuAEOM10ie+FHi/NukbyJ?=
 =?us-ascii?Q?oOw1JQygnM3cndPaBro1XECY1ifWFOqmMmU2OlTCS5N9KgeFkcHBOWW6Hr/I?=
 =?us-ascii?Q?4B3ATKQG0wIqbexBuWad/zzOo1t0gxjvLAgYYmCPM5Ag8q7ZeE+ltHXYd3mz?=
 =?us-ascii?Q?PFK9Kjt+78LpW47UppYMLTd1T0suMNgd042vcoPVvPLX8wyvWhOBNDE8xUZa?=
 =?us-ascii?Q?rJQOpnNjgqIzs1DuBN3vORDX7h8cV2GAcvIqW/cldq2iGgyfPVOH9mPimqHs?=
 =?us-ascii?Q?FpEC6nXRFIrQXqVLmIverDbwnVq6Tw2mXTACqZyhf91/MgFIvAjcaoVBjumF?=
 =?us-ascii?Q?oRlYKtilvFbMaGKiZII+G+o5sHn8AaeHdMrj3OXPesTLm6lNBGjuRE4v8O5Y?=
 =?us-ascii?Q?8WOuMyu6oMU96KjGxNQgG9svc31uxC0NVeV7S71E0rnP6qbW2c8DGoyKm2/n?=
 =?us-ascii?Q?Qh3gyCG0cNqp2EhbtqdPRWZqknWOwA+pDoFMEezaV8yuIdNRgWEauBBSnvoj?=
 =?us-ascii?Q?kO6LeknvKJqZIZLmwh5xelWvJisTAT6nDZoSHAv0ztDInj0MGj65tZxhflKf?=
 =?us-ascii?Q?OzgPnHgXwoXUUElPwpLIFiW9tdJ3/WaRSwvum4xlO4tKLDGHG28pqruFw/hq?=
 =?us-ascii?Q?7TygJhlCc18zWZOcbRHRCadN0s8xlAuMbIxQXDGUEeD/HGBSy2YQ27h3cl8r?=
 =?us-ascii?Q?o0IKmNurxzaPhsUIlqDDcJLknF37O24OjnBIvDAYyah9FKMcsEC+uIS7z+Xh?=
 =?us-ascii?Q?GeheZKKW2rSiR/8SmHR7UfgTxKaaQFGHhCdwipwzishVY6enApMlsU7+AWOD?=
 =?us-ascii?Q?zJTRtxJRm1K2f8/DIllavZzem6QEPPD+bLGu6uiUZYdUW+pJwnn9dj8ETKVC?=
 =?us-ascii?Q?Ej2q9lTau8h24J725CnYgKhnvAVq/o/ez+O5NODPddMJ0yBKm3RDfBztGVbG?=
 =?us-ascii?Q?V/4WxzjB0D/BO1PIhZFoH2qmYndPbNcdIp815Hyel6pQl0xiW+QBXm45vy9i?=
 =?us-ascii?Q?UCq1V+p8LNabxUTejEI24tWe07A8+cgX1HCQbvSgZiUbCP1wsHgvIh2eXixP?=
 =?us-ascii?Q?6yXK1fh6YN6AZt0Mj0wOpnBPFvXlPWKiPOL5hH90Xw8IWyd3ogmRFD+uZVNi?=
 =?us-ascii?Q?h00Pkd6+SPDAcFH9Ltkue5x7CXMtuPXbUrAgcDCuyzh/qXHDkyzdWgvi6E+G?=
 =?us-ascii?Q?myTe4uZkuaV2IrjqVrnOelquDL813DemOUNLLelK+BzCXp1dTIlAT2wxqCj1?=
 =?us-ascii?Q?5QUeE+CVMEO4UCDWaP03kPVWmozNSQYQ6AD+x3Xhk+nvMruWK/F9rYoGdvqa?=
 =?us-ascii?Q?Do9BP+9KUwt061xWjz9z5OUg/9lp/PIHHNueg0H4NNXDfX61JhGmPue0AF2S?=
 =?us-ascii?Q?Rsb+pecQw1j9vW/oiOYZUaMhZJZh2QWZEFI2R2uHIgDMHm3lFjCHVojzMLv3?=
 =?us-ascii?Q?6cA2ILuveO0JMpQZUYxX7hRl9DgnXIdPIgMKcm/eIqo+wHkV/MZ/KusaJm+d?=
 =?us-ascii?Q?Erc+DEHpyAeL7aV+fwu+c25SL35PrhvbikHc18Nb15QttswKgXblZJTiWkot?=
 =?us-ascii?Q?6EqQVEBo5lxWp0AVUHtWo+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BD1CD407D76EF48A093A69F2C9341DF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dmKXqTMhTG1jjeOrnzUNVwq/W+STi3ENk5d2nPR4Y2A2v18VL9PO+sFrxSmoD4iNmlTMPMUTAf0ZfTqfpxD2LXourPJmkrcikCzUXxDLtOoLvtdUUlOkLnEd3oGhw9e0WCTvuJdIDowqpM8/iTGFWd7XprnwZXzUIwHtZqJjMHm0Poz2upOKUKD0Ka42c6eV94NZ/jpVP8BCgBKP3NWgJwtpZlD5IDFhauKDnTdwbApLh7je4cuvqSc+vhS3kMtWxR94dxl5e6Wc8Ydiq78ap6kr1pcxU7dTLZoYwPxUYxcft4Ttv1nnrCP5T49Yqc869ygeIKWiPKr9Aux3xIv2Ow3W6k9r6O6JbcANTJerSlPigmQ+YV3RrQUZi44XGvwHY881SeBxrh8NfijgeQYoU721SqAbZfOPa0yBYKbTfEy19CpKzblMhtPqaux5vRj0WZAjS0nMbLU9PUBV+p4lJUP7vj6vRxhzqPhgLihaAbvMNF06fUIr+hSei0WVgIuN9REcQvZ2wPgQzyijNgP6SL8z2NEW2I8dESfd3xsuMArqGR3GhTvyMdMOOG5BvW0g3xnG4PZ7COQYUJP3Tss1g//8Hp0kRwpOtjMZjUrHTolvryKBtcc7vPnFE3m9cm//CNNxesJUPOPQQ9jluZd6xBtM6tuiRHA3EzhZHadsPhJFh9jBvEO+I8BiwkigKsKtok8AQj1Dgo2dlsmKv2LoB2bJAovXQfxcanRR3av6S0v7BVgBh53NgFZoZvzLCkwI2yJOcOkQ1jSe2ers5qCH2EYqZGNalcn9lccdCfGOspXan9r/xrxMC+r/ipuOhKcfOsKcB2b56H/RrsVZrR6YjvwfDndpSgG216BfDNV4jOxF2G2iqKoapJh5y7UUP6dJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7dc20a-8e25-4ca2-5282-08db18b52264
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 11:24:04.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtBHxIiudP9B8ADcTu+LQwwaqLIRZnsXEJXmcBRAotCO4N4LDyPrCCy4NeqOP0H+EaF9AIzf4v2+gcgG+PD4/GLg3X5TBhBPqNYFsD+L2zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6158
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 27, 2023 / 11:35, Kanchan Joshi wrote:
> On Tue, Feb 14, 2023 at 01:47:37PM +0900, Shin'ichiro Kawasaki wrote:
> > Per suggestion by Kanchan, add a new test case to test unprivileged pas=
sthrough
> > of NVME character devices. The first patch adds a feature to run comman=
ds with
> > normal user privilege. The second patch adds the test case using the fe=
ature.
> >=20
> > Changes from v2:
> > * Added the first patch to add normal user privilege support to blktest=
s
> > * Adjusted the test case to the functions for normal user privilege sup=
port
>=20
> Thanks, this looks way better. And works fine in my setup.
> If required,
> Tested-by: Kanchan Joshi <joshi.k@samsung.com>

Thanks for the confirmation. Sounds good.

I found two more minor points to improve:

1) tests/nvme/046 does not have executable mode bit. I will add it when I a=
pply
   the patch.

2) I ran the test case with kernel version v6.1 and it failed. Does the tes=
t
   case require kernel version 6.2 or higher? If that is the case, one more=
 line
   change will be required as follows. If you are ok with the change, I can=
 fold
   this change in when I apply the patches.

diff --git a/tests/nvme/046 b/tests/nvme/046
index 5689a2b..b37b9e9 100644
--- a/tests/nvme/046
+++ b/tests/nvme/046
@@ -11,6 +11,7 @@ QUICK=3D1
 requires() {
 	_nvme_requires
 	_require_normal_user
+	_have_kver 6 2
 }
=20
 test_device() {


--=20
Shin'ichiro Kawasaki=
