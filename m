Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5A27CB06
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227846; cv=fail; b=hIrDLu6B/R/DRhMedxAe+jAIzPhmweDceoq4qGAvNMLZ+RfaC58YFYIzjnaDKnWeSztfneTaXEODQ0eRELaTQQdbsjnUoxujSGM8YGdewR+5IyyXHdGRdKUvTFnJyqcWtUH7jU9pAxDTcWpaswMAAdMCFl8G4ZnF0X6hX1Tzcc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227846; c=relaxed/simple;
	bh=1YWsT3uX/DRq4aJFofEcDMiXKSgDSLHeM7QU7DQr/co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZaqehVTqOotabhwih48fPwdeZjbA7P66C4QKXpUgfuk8lfytRbA0nV9COR4VocfYE7gRrsJkhWW7gY86fixuN9CYUP8kIdyuUBa4l7NStwDVEk1Wxl47SezeX1/g2MpPueoq7cxOzL3079xXin4XaUI0Ledjn5J5qpLvzSI+3/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kaH4lz9K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Z5lguo5Z; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kaH4lz9K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z5lguo5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752227844; x=1783763844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1YWsT3uX/DRq4aJFofEcDMiXKSgDSLHeM7QU7DQr/co=;
  b=kaH4lz9K0Q5MuzBwUGkp3ndsWLlqG8EvKWGYRi2rCnhZJgNbzQiAusKf
   PEshBX5Onjx1OBsF8JPrTP+NVEb+xuvcmVfhh2+UhKVpgf0UzPvnEZ258
   N30OmeKU5ZnCiY9EPo0TA4kldT3qZfVVrqnmMrRNJX2xS3FLFokLxR4hN
   vibX90ZMnL1Z+pMuwOT0NPpjT7SDnI4/k880dJNDpxQP2M/UdZw5COMC+
   HRJ0A8IATvhSdCYjEcVT2TBUAHivvHW6hQ9a11jCtkL6QWLE8U9+P6tBi
   u3RqoaJ2upeh1pmPWa8eq2DAYKPNl4QbrNF/o4en8V/+2Bk1b0MM4/jvB
   Q==;
X-CSE-ConnectionGUID: 9PCi6EEaSPOZPsOgAN6zCw==
X-CSE-MsgGUID: x6XvD1UFQ/O6VnIF4bk66w==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="92787877"
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.66])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 17:57:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlf+hHERvnRjAgcQQGmIT9w/eQGoJyPiFIe417J/qcf0uMH9sTSVB8Z8FPD1swS6qoV0Pk1nsGTClfLK1sK0uo759MDDVlk0AmxTc9Vh8TCeyr5ZfrEJDCXPKN7MdLbbGnfoP6F8ddmGvNhFGTaTNfLoeW7a9jJaHG8FsQ2ouWs47QsTuynls4FBOhKrR5lZk5qK+mFywZBwKzbFFRB19hYBBA3NfWOOH44yPM5CMPt2Zlde2SqqgonkfWS56W+Z7NLiZ8MmWTDmZdGQ8WwQEIiXvA3uMyCRA9zDmGVI8oJhu7XB/5OENmSWFSi8DtsrO3VUJsqIKWDdmYAyhLLWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YWsT3uX/DRq4aJFofEcDMiXKSgDSLHeM7QU7DQr/co=;
 b=g8DuDX74WQRWpQjGVanlYItOMADvs+7q66uZsUkQBsnwd0D4Sj/05mcrd+Qeybupr4cImQG/fdgrjH3cH+p3oWrsAnQcbfDRAglukj/LJtfM6P2BUzHP6eyuAy4KDgN2CBqZx9Z8qVVROWRJe8MMcV/UC9kY2+8vDALMS+99c2VFIJxYMffgDuVTE4+4cENf5Lf/p6htvm24CM1SRfIXPTcw28+bBbe9emRaquR2bh8UkLAQA9DkAla42w0oLCbn6UmZngdrk/FDsj1/js8AQqOb7I4R1y+MF0WcsLXScHIU3CGL/0FXiFOAQUta8yrVJoxmhL99aw0p3u+wXM/oQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YWsT3uX/DRq4aJFofEcDMiXKSgDSLHeM7QU7DQr/co=;
 b=Z5lguo5ZwfNve4g10vqx52dEGRq8HNIDvL+TBgkpr4cuDSfHOQC3GiX0+u+neUSN1jrwydTrGD9EvslOt2A+31jQYFMoUEIm5vfraKB26aN1aChG8aG7NIEGU4pXAwZXIx7vfRfjNlT1id5d9otBP2HXlK4o+t3wMc3ssTvBqzM=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA2PR04MB7641.namprd04.prod.outlook.com (2603:10b6:806:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:57:16 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 09:57:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, John Garry
	<john.g.garry@oracle.com>
Subject: Re: [PATCH blktests v3] md/002: add atomic write tests for md/stacked
 devices
Thread-Topic: [PATCH blktests v3] md/002: add atomic write tests for
 md/stacked devices
Thread-Index: AQHb8VbmPw/IeGl7TUa1W8aWWsKUW7QroFkAgAERVYA=
Date: Fri, 11 Jul 2025 09:57:16 +0000
Message-ID: <tpvusnewsrqyiiqivss3xpax57n5juifzfezazidvfhg7h4iih@zdedjooeyxxc>
References: <20250710045537.70498-1-shinichiro.kawasaki@wdc.com>
 <1c2ce026-2ba7-417e-bafc-f6bebfd79ad3@oracle.com>
In-Reply-To: <1c2ce026-2ba7-417e-bafc-f6bebfd79ad3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA2PR04MB7641:EE_
x-ms-office365-filtering-correlation-id: baa4b7ad-ee15-45a8-522d-08ddc061513d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|7053199007|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DEcE8Ahmfip6twzimg2LPbVTHH50bhqeYIzqGWa+6nRspnuq+0aZB4oGek?=
 =?iso-8859-1?Q?CPtOqQBODsT/KeCCF8dutkJt/xHoHhxQ4/U5XdH2LmmHKUAzjoKS2kXWod?=
 =?iso-8859-1?Q?oRKToJReXaGpGRGGTkPQnFszpsn7dk4ES+BGSZ/YTKgdCMA2K2ncVEA0xg?=
 =?iso-8859-1?Q?EDn/6uyg1pFDfipkjaAHyEop0IzqanUPp9h/KdDkDUnL4lyW4j2XXPtkfK?=
 =?iso-8859-1?Q?zjMyJ5N20gUOZlJxvaozZw0v67fdWwWyNC5vKjGEWwRMfhswcZSTtQLtuQ?=
 =?iso-8859-1?Q?6ges6R21hePFkGkBMFZU1VlHPPGU8WfU/UfkaUBssAMOajyjSGw99oYcwc?=
 =?iso-8859-1?Q?YvtzbyGV7hdHVdE1QV779ev/D3kB3VonFt3G6v4wOuzd6FmKNy4CH00OjZ?=
 =?iso-8859-1?Q?Q0B30o4VrikXlKqQwmStSRrb9oJ8CuXMRkispWh2P9JgY5/Sjzy6tQCaUo?=
 =?iso-8859-1?Q?DNVVxEGQjMGkBa/pJi/5HmNYLMVk8Ek93pfz4eRgjkqk5h6ath4JaKUSkZ?=
 =?iso-8859-1?Q?2c+/S0j9OSg3BmEHw6qr2wPnIm0vGrlowx561Z4iZR7zplIoAYKP7A/z82?=
 =?iso-8859-1?Q?8zOg0pfNGTM+ET2rLL/QPl5S9go0kyYmyUpLePlK11EcLG6/bFS+YQh4vh?=
 =?iso-8859-1?Q?l9C9Qn3sgGvuOKvxxEa5Ott3JUz2/LM4vZSRm4qmevfxgoksqn8b89AgL/?=
 =?iso-8859-1?Q?fZ7flSiwyzNiExU9pdVO+ADfCXBApllbRTfEk1yC7EuJYkj08vwxpSfyWy?=
 =?iso-8859-1?Q?VOGCJubw12F/Dl34MaHBjtysnc+DRvIx6D221uTpIweGSSjv3vKNzsrx6s?=
 =?iso-8859-1?Q?ztviHRftQqb4yiAFa8qTE7CRnOO0tgcTIUT4uPO0QtyGjpEdgmj0YiywpM?=
 =?iso-8859-1?Q?6I0I55sZdRggfvOgBT1HudLiLevv/41s02U+8oYRoMBc5wtQY1KODG1YH6?=
 =?iso-8859-1?Q?atQRY0eY4SxIz+1YuPXAEeV2ZhX7heFS5Rkm4U50vB3+uZ651KS6lsvuZ6?=
 =?iso-8859-1?Q?uTFVrmw8ghMAnnGovcIna/WBv0/ANN7m3EchvIoVhsKTreF3ET5/K4Gf8a?=
 =?iso-8859-1?Q?raa7Yf/iKTCvohP6Mo2AdTrvhEeO6GyGklW7THkAHi896NHhNv8+BSbkBv?=
 =?iso-8859-1?Q?7uIh3DQVJVmgA0wtPyI13FxW4lZ9MRD3nVaAOzLKkZmYt5GBYWWlujGiWo?=
 =?iso-8859-1?Q?HEvIwDjbOKbMad8zKW4qRzJuV7rMwHuMfonaxu7vK4p7ayG+7/wU7J7Dx9?=
 =?iso-8859-1?Q?G7VaD4oyTNhca52mywf7G65fy4b1Tz5NnwauZZpg5TxTyZ68Tgz0hfllND?=
 =?iso-8859-1?Q?IZ2O3t1uswbVurJj6XH16eoFcfT2h1VZDG7QydPXpmeTMhw92Yz82d3J52?=
 =?iso-8859-1?Q?PMs3mk2NC8Jyfu+4Ee/SnuGf0S7GZ/o4C9jhd5MXySmyimUitDuxkL/R4Z?=
 =?iso-8859-1?Q?H1ObXN/n8sb4H+KNHAo04eDUwpVeCeDsFhCsU32KS0yMQGX/2S+fpmOHw3?=
 =?iso-8859-1?Q?JIGFA+JqMK0+dBHYKEK/Jnzy9ldV8g8ddWKHxquFhGCR+oBUiGqxR2DrWO?=
 =?iso-8859-1?Q?vU/XBMZ5LyXAU9zHray5DsbBOtY8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(7053199007)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pFxVuIMT9i7+wJg7pPqtTwdO48HaqkovSbmcbmwomLXAppEEJ7B3su0fSG?=
 =?iso-8859-1?Q?oNM8CW4X0muOCh9NyL+z4ZbxEqLiyhHWKOSmpEUxzHtGgQGwPRIe0UZM3l?=
 =?iso-8859-1?Q?/Om5fvk9fS3KWi1wH5lH52Vi23rtHcXAtLKDZifz5BQVQ8lP2ST8tEJiV4?=
 =?iso-8859-1?Q?BGq4cHNuJ+/AVKvkPg3eeQnvE+UF5mo8x9llkv4gbyu8TNRnH23L69K2We?=
 =?iso-8859-1?Q?vqjE6iAEZ7YMndDbnMSY6e8suiVvgDia23+VMRWhjM1o1NnT7mSpAx//Cr?=
 =?iso-8859-1?Q?3hFCLknofRHNNG2nwAmuG1bhozvbaj3NXDp75et1gwLdiQt4RK3YYBH3Kt?=
 =?iso-8859-1?Q?9Z5AQxymAB0VWZMSmV0MtJL15vMO1HjZv8XpCt4JhaAlFp7HSazvIvU09h?=
 =?iso-8859-1?Q?kTWo/aS7wQ/TmgPG4XnApkW7XQyjqtgSZpk3HV1V8dzS3VhmS30+c1fJ4Z?=
 =?iso-8859-1?Q?AhVekdt18qwesRmUVXf+HTF4TK5HiK5h3qzKbY75H9+72wiXu4XtjKYSPl?=
 =?iso-8859-1?Q?21qKsEFptuAA7ee+qrwYsBz2qlQE7EOjbJiXW0J0EBSv811GeRjkchtNG2?=
 =?iso-8859-1?Q?DtIII3YPxdyZTBrhzCg0ssOabb+dmgv5XHCzv4lUetQqpIoyC6bVvnPryk?=
 =?iso-8859-1?Q?S4Yr/5NJvv5dBIWo86xIOiMBKmc2csvLsF0K7xynT/iAP0T5g3jkYTkpfK?=
 =?iso-8859-1?Q?u6DHRi0NaWOkBc2vuZfDB7e4aXljx3565hgzowjdPLrE8oD0hJtIvtpSJa?=
 =?iso-8859-1?Q?IvojEiLlwLNjLU3R5bMf+6I6+ZVhoD3L/gk/94OREKztCv2Cf1eQXqYlx7?=
 =?iso-8859-1?Q?OModmMFHP+jlmZl+sYmmzvPen47SjirZ+bAiJvBRgTT0+TRNnWAAkeJFvh?=
 =?iso-8859-1?Q?C0yaQqXCCTlT41WdzJ6Uz1OjIFb/ety2oBGrNxi7TkjdZ5my19F+FpWhIl?=
 =?iso-8859-1?Q?4RpoldIHaDxef37Di0L0eOURc5z17CuSZJSSm9+q/mNsGvReI/dFy/MpIL?=
 =?iso-8859-1?Q?T9f9Yif//O2Ltqu2LnJ362Dqv3hD2tHwkRiGxq6CctMlzhK5nOFVSfcPFZ?=
 =?iso-8859-1?Q?Mwe/FIdxhLiYrNfQH4GwM8g3fyIhYjnRa+8+nX1Kfxg5fmL8O0Tt3ko+cK?=
 =?iso-8859-1?Q?elSuArjtQlJEkSTfINyruLSKKxrH4nxfvSDDHUAqEfimZlB8c5prqzsybg?=
 =?iso-8859-1?Q?cA9tLVUDbYtgf5gg3leuOxq1ueLIdL2IrVtSIR1u9pLwNMSpLr3ll0WrxH?=
 =?iso-8859-1?Q?xiHznxPtvqDFwtBSML1lhGz9WSyHccH4yHnSLFD6Nm0OW8YHNpDlAzVrPg?=
 =?iso-8859-1?Q?ZHddHYjk0R3r2RFKg/W0//fWqqMmjgi2vhd1jkCP0M6HOU3S7x/e03uiWT?=
 =?iso-8859-1?Q?8etreilw5CXibRf0NGjNSk0ET3JMRpN9QLX+MSFTXKHXp2JWmPD66NSkNr?=
 =?iso-8859-1?Q?DR3CtlC86I7lqZD4DfELmrd8MKdK/Xa38FKwvL7H44n5fhHyGkFWLh0Aky?=
 =?iso-8859-1?Q?35AwmD7wi4KZmHTI162sO2vSmaK8bv1HGIEvzx9Rgjrl9FmynfmUo4uw2P?=
 =?iso-8859-1?Q?wMHzrgGGvavuaCdrFFP1C1IFaUKOmHmvXhQDXpDm3+snBnYoGg6MlUF7iG?=
 =?iso-8859-1?Q?cbX8kUXhiULFJGcnIUZawGz+hWD1DaUpPnsynuPpWsrXqJBCkR/9h3wg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <08E1DCE566696F41B7AFDC5F65F7C09C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DnYlg3JjMAwvUJyhfmu/WFdlsf1l5x+PzV046Efm9odkVhZxTmztVZ1Hf7/02/nrPr8kS4P/TJSmuWI15HypIIvepy+tE/2+ibF+F2yUaiSAnzhQZoujcjoYyijB6rE/2QKM5/01a24CdcoTkNhJv5GR0+dFMThX75rDtPwBZyNDtoQwlBrI1euV8hrnfm0ru9aQLCjFpZYDOFujwBXM8hXgMEsGyK2RfDw8qREqsSSssQaZVFf3yXkRpWEhDMG1Zlze+Oo9xP7la00lZiPrZAVJA7CA3fEQM3TrNJ2vtGIaHFD7SWLXvdqEE6mku7pdPiLkytXNxXms0E3ehPP/k/PBGCHw66ViAsXFxVp6NgZSdgEmYdw8MeWQ88BE6eZU0L9HMyloKD2OwP+3Gkv2AesK06Tz3CHqRzGqP/VpGOCShvEK5bj8Pb5VC9LiuBB0/zqlQ2SAGybYaLHIhNa+P2ExLz8QsZqSJSMVwEYSozkSZkqyW3OSUKD3L4IMA3EUvYZbFIxVTk9msoynUH3ngoVnulSK8PM3b/nFIc3DajeNftJZpNL0/XGIGZmGV65CC+sItjicaHnDiShVOwuVv4AYxmEtzMPT1/c5CXiHlpaGL23uBWPnDAyKXEVTYkc2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa4b7ad-ee15-45a8-522d-08ddc061513d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 09:57:16.3254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wf9dk/lX+7KKOB8APqjIT28tJjq4UnkBtS54A4XzRTAenNQhl8qDkR8z8hIEsaubBLCC1sDz4+JmHmMd0CE5Y2X0W+eQ94j9TpUg4akODNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7641

On Jul 10, 2025 / 10:38, alan.adamson@oracle.com wrote:
...
> Oops, md_chunk_size is in kbs.=A0 Should be in bytes.
>=20
>=20
> diff --git a/tests/md/002 b/tests/md/002
> index 79c0d15..79f260b 100755
> --- a/tests/md/002
> +++ b/tests/md/002
> @@ -29,6 +29,7 @@ test() {
> =A0=A0=A0=A0=A0=A0=A0 local md_sysfs_max_hw_sectors_kb
> =A0=A0=A0=A0=A0=A0=A0 local md_max_hw_bytes
> =A0=A0=A0=A0=A0=A0=A0 local md_chunk_size
> +=A0=A0=A0=A0=A0=A0 local md_chunk_size_bytes
> =A0=A0=A0=A0=A0=A0=A0 local md_sysfs_logical_block_size
> =A0=A0=A0=A0=A0=A0=A0 local md_sysfs_atomic_max_bytes
> =A0=A0=A0=A0=A0=A0=A0 local md_sysfs_atomic_unit_max_bytes
> @@ -226,13 +227,14 @@ test() {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_=
dev=3D$(readlink /dev/md/blktests_md | sed
> 's|\.\./||')
> md_dev_sysfs=3D"/sys/devices/virtual/block/${md_dev}"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_=
sysfs_atomic_unit_max_bytes=3D$(<
> "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_ch=
unk_size_bytes=3D$(( "$md_chunk_size" * 1024))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tes=
t_desc=3D"TEST 12 RAID $raid_level - Verify chunk
> size "
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ =
"$md_chunk_size" -le
> "$md_sysfs_atomic_unit_max_bytes" ] && \
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 (( md_sysfs_atomic_unit_max_bytes %
> md_chunk_size =3D=3D 0 ))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ =
"$md_chunk_size_bytes" -le
> "$md_sysfs_atomic_unit_max_bytes" ] && \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 (( md_sysfs_atomic_unit_max_bytes %
> md_chunk_size_bytes =3D=3D 0 ))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the=
n
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 echo "$test_desc - pass"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 els=
e
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 echo "$test_desc - fail $md_chunk_size -
> $md_sysfs_atomic_unit_max_bytes"
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 echo "$test_desc - fail $md_chunk_size_bytes
> - $md_sysfs_atomic_unit_max_bytes"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mda=
dm --quiet --stop /dev/md/blktests_md
>=20

Nice catch, I will reflect this fix and send out v4 soon.=
