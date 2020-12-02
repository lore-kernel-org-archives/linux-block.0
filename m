Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32395C64E7A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 01:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3B6221F9
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 01:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgLBBlE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:41:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8136 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgLBBlD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 20:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606873744; x=1638409744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qd/JOJ0M+PKiGvaX4T5x6Nn0R65PzfuqxsVh6WPR5ww=;
  b=Lf6FPBVaQvQTAG6ErA74of5299HK2XhvthQpu+XmLmXaKBiwm3J1+vlf
   lM4iSAJK2n6gTM9u7FX8/rgJgfGtTsOqT60PdAemJkIQzFOh5uBO7D0yX
   /m2x8VczY5ScpJKxug24Rls0/ges3tVJLURom2Wt5jGj3HDjRqEzS/f2k
   wuPF7P6cfIX3tBEUt4bB2WlLUH7gKx8fylKLYnCyKiAXFPRM1KEywgFS2
   5tWJ9iqcKEToEnUAUePL4EonQVYQIH5p8aQP3Zb+DdW6KITH582ri1KmC
   ftXeA0SZ2c/i8pBqEHHLejK3Go8+ciaCUqBzJ2iiXCWncmtmNoHEQi+eF
   A==;
IronPort-SDR: ytMkYW9ERLf+ngH1MpLlrn2AqNuNahzzYgnMVQi6tsPoNH5GCI/GRQNVe4SkBAy+lheb39Da4N
 GJM9QwG2Z72iJFqxgMfgQ8ViHHCN/QhA1qtw/fwB81cAJsUFCTbCdTcWPvYQE4G4mFlcwmUlbD
 ruP7Lko0/I1r/3JySpF/qbjtKb5j6DkMH3GzWLAN0L5IEUEObSdKsdp+EWbvOSHVaskzNWPHlT
 /ScTd+XbcplhA+oXB5IhdFVRqjmnxGQbHVga4WX9RJfjR+iQ2R8hBtiflVnI3+yN1nTb2WhlCR
 ihU=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="257663988"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 09:47:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA6o1bCgeRjzPiPINneX/x3dvpfh2JbHxLIwIXaSctHIEMd/TdsjYWp9LN/+iz93qiIS0BtUgHQ0RPlqxoqwE2Km+gfuKtFsUzut3M3L3g9Kwkw0Lt9++tHgtpezqskG56gV2yY+JTus9fwoarEWDI+yKJ3GQn/ztJz4jUIng5LfA5xO7zIfyIJYtjfCxVBWhHcD+p5LwqfWntNm9QiBdmRkMpVRNVlLE+Z2jQJurcOIXXFyDDfbp0yJRfii+4huYV9zEP7m6roRuegpwjF0j5nzmyv+qRpqeAEzUT2E7kujd6hp0SIEv7+HSlvpx0NbvsqIgTtfNs26fl+jUoI5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olqlgd4YvEFuqbcKCF1YLvlsbXtxBsbdqHeMgLXSfCs=;
 b=IzESJLdHluqC5pc7hE1OZh02YLn5CpwEtGiDj8WyJKT85OIn60SXDxHVtGud6Q9ATdrJtoETiff94/tj+sqDY8daiH1rihawm266T4yISyPvlqCudx43FhOup8jGQcJy7Pn5aPgKGyNaHmLZtTttr6s0LCMFynQpqBE92ME/ntm32Tk0SD988N7+F5HngNCkpsWlM2peGHxFEzil+Jl9NhKhxtNQNZlJklVTNe5HXWkvR4Vxn4FaGyvGeuKb+Emx/0BDSM/Ukf3PDsGid005mjOkQixGGWKlsbITWaAJ9AsMWn8BW+VycJFig35g6nCHhuVc9lKGYPCuBJIVxvOwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olqlgd4YvEFuqbcKCF1YLvlsbXtxBsbdqHeMgLXSfCs=;
 b=vyYu4HItVxk7rGEU1wckKG49kKH5ZWBOflmgc47yabHUm/+BJHV1i5rfjzXiZewZATwnxSgeeF2u8lMzj9CQz4F15GoWBuHFyICfRmgd/09JiJZ/Gvj/OEkOIQUbFPJ92kbdt7rPueGPQUtXetyXykQvgtUEYp4IiWFJ00bXOtI=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5733.namprd04.prod.outlook.com (2603:10b6:a03:109::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Wed, 2 Dec
 2020 01:39:54 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95%3]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 01:39:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] common/rc: confirm pcie hotplug capabilities
Thread-Topic: [PATCH] common/rc: confirm pcie hotplug capabilities
Thread-Index: AQHWw0KjUygrArfurUWhr3TmwnWjSqnjEYqA
Date:   Wed, 2 Dec 2020 01:39:54 +0000
Message-ID: <20201202013953.nnqidcpwac6l7pqz@shindev.dhcp.fujisawa.hgst.com>
References: <20201125154952.2871261-1-kbusch@kernel.org>
In-Reply-To: <20201125154952.2871261-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b41d565e-eaa1-40c8-7bb9-08d896632b79
x-ms-traffictypediagnostic: BYAPR04MB5733:
x-microsoft-antispam-prvs: <BYAPR04MB5733884CFF6104E79BBF84B0EDF30@BYAPR04MB5733.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyokZ6WNNm8b9++tMKAsOW5b23noPfWmiNjg+HJqSPATuP1xtAEca8sxeWPWn7JJNTQDSEjFJKG6DHPwfFGhj8H/cm1MGhRjO2LYeOmRwDM98V70jocBY8njkU59jtIJ7rp7SrWGiX+J0HnMboUIftjirS6V4H/g4Jl/TXo0bLvGuBxvAaoOz7l1SfUp/Sq68IVPsqcIhom6YrVNw3C8B3B+Z8TWTn8zautkKPvnyrXL5quixg940Bl1FH/M4W680WQahVDTIr9mTgCBH4QZ21lS9gPIBx225570tHe12LGfQHXq11wCavBNP9rQtBwQEC5KORk6vmT8reNsOqUSdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(6486002)(66946007)(54906003)(66446008)(478600001)(71200400001)(91956017)(76116006)(26005)(2906002)(66556008)(66476007)(186003)(44832011)(1076003)(6506007)(83380400001)(316002)(5660300002)(8676002)(64756008)(86362001)(8936002)(6916009)(4326008)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yVSQqqBIcUkf/ob0gzRnr4yZtFhsuZJd3Ggf7OrSIogNd0JaIlT1q46LhNZr?=
 =?us-ascii?Q?divv5PbMqIGUPo+e7N1UnOise7m2KD8gdkmlXN1JE+U7QOkWh421FnfP2Dck?=
 =?us-ascii?Q?N4bPD5GTl7RT/EYxawY6312IG/P24t+A/tFDr0TqmO/qPnlJhGkrQnFPBjr6?=
 =?us-ascii?Q?QWL0mIH/lRm0GpaUla4WGco95725EIuSRg17LT91sr6vU0ndMNRYAVjxtvBK?=
 =?us-ascii?Q?EDRKV1V2YomLLc3b7hOQsl6KAqrYqZaIYfevMnQbq5NkAa+mCvVovAtkSD4z?=
 =?us-ascii?Q?Cjc5RVpD5eFf8igpbciQM/99DDx58yHEXE9gtJlKAISMUtxZM17wwAiCQRYC?=
 =?us-ascii?Q?j4WLoDmIDXRv69jF5HFVoA4mfQJq/Drf3Uq2RCXLb/x/inkL50o8OHreIzmt?=
 =?us-ascii?Q?uy8tEPDaq0PKT0OtYh5wmwhUwFCI6xQe1kIS4IUzmyucFi8HnuiXFNrnB6+P?=
 =?us-ascii?Q?fQYkRQu8JLooNBLGOQBDwEpbYJd2TpFs3fFAFpcNHInv4F3kF2w/dy58EJ+6?=
 =?us-ascii?Q?FRFthOGrpmFYjLdir6qt8/ubP4HH3Bp7lXs2N8jnMFVdQZAw+uU28fzdDL+H?=
 =?us-ascii?Q?JLirMqe0Be09sst6YRmJ03Lz30v22jMHjbIkAYcKx0YmybU58dUVS0bDvKRi?=
 =?us-ascii?Q?iI9QCcjlGqPcBRjyP8YAe5RjaMS44eXDgBatQG7uJ3EbcGx34pqVPZbZH/8u?=
 =?us-ascii?Q?ziv4A1heOeMO9yysRfk09xew+Yj37YQK2L5PlFwZFtu07naQMvmco7zBhFuE?=
 =?us-ascii?Q?PtJ7lZ0W7z17xKTjaP51sERcXxrl+N4CWzx5865NyeYyXj1KyhBK6LpIoRal?=
 =?us-ascii?Q?fXo9A21ZhZvhKypSb0ib8tAZr5FkUdgnbo6qIl+aigp5GbHlxNplRpdn8FLO?=
 =?us-ascii?Q?fmsHyH4g+dADEh6R02T5tBwFEIeIh6hL7N6tuz++atkWmWWE9ATIoq3UYh6k?=
 =?us-ascii?Q?G2eglO+9+Oh9nWTG2YAZP6omTRfa1sal7GzTKAeAtcDo/olo+q+uFR2SQNKk?=
 =?us-ascii?Q?a3+q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D1FBC35EE2FF1429CF488649BE011E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d565e-eaa1-40c8-7bb9-08d896632b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 01:39:54.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESm05vHMkDr9PBH8pt/caBlaj7kzuds0UodPeKFYaWI8JT9cbZtV65rcAjICmd37hz3wwzTtLgGLI+EDvfrLF4AOujOsv8s5ZlTtPpt6ONQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5733
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 25, 2020 / 07:49, Keith Busch wrote:
> It turns out some PCIe slots report hotplug surprise but are not hotplug
> capable. Despite the contridiction, the spec seems to allow that.
>=20
> The linux pciehp driver needs hotplug capable to bind to the slot, and
> the block/019 test requires hotplug surprise to handle the unannounced
> link-down. Verify both bits in the slot capabilities register are set.
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/rc b/common/rc
> index 0d7a3cd..d396fb5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -269,7 +269,7 @@ _require_test_dev_in_hotplug_slot() {
> =20
>  	local slt_cap
>  	slt_cap=3D"$(setpci -s "${parent}" CAP_EXP+14.w)"
> -	if [[ $((0x${slt_cap} & 0x20)) -eq 0 ]]; then
> +	if [[ $((0x${slt_cap} & 0x60)) -ne 0x60 ]]; then
>  		SKIP_REASON=3D"$TEST_DEV is not in a hot pluggable slot"
>  		return 1
>  	fi
> --=20
> 2.24.1
>

Thank you Keith.

I saw some mother boards report "hotplug surprise" bit to PCIe slots with
SAS-HBA, but do not report "hotplug capable" bit. Without the fix, block/01=
9
was executed to the HDDs connected to the SAS-HBA, and the HDDs disappear a=
fter
the test case run (the test case emulates hotplug, but the PCIe slot is not
hotplug capable). I confirmed that this fix checks the both bits and skips
the test case for the HDDs.

Omar, please consider this fix to upstream.

Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
