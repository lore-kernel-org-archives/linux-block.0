Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A562EC564
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501498; cv=fail; b=pm4SeB6KIfahNOBtvmBj8DQvGkdwfbAyNKUuP/CxQe9C5LIraVxl/XWe3YZ7laN5YVtHvqLU/qSaaUDZGZz1O0fE7um3QM8USLdGSBV5qLjvWAkNGVJLwOHXTA171vHIXbamUqFCgtiZY3oKSgT/i9fCt6nVTFk9qr2NBnIGs5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501498; c=relaxed/simple;
	bh=1g/EI3YjYgXva6iWgqkGumWsmMfskTYQ5zVM+VjmgQM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t2B83e55ShgrPW9vjuWYR8jb9wf/+b5R7hhEsFCCyoZOeOakpfcUbrWjV5gPwdzEmimjiky2mAkg0WPJMPKO/Mfm4TS9UroFf79RNRZequUgcyOxsyF0YonpqZBN2rRJ6flqxgTS3x6ME+/alNUE4DJQxS2dqlSin3aqpJXMwG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OlsttRTz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BVFBUp+m; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OlsttRTz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BVFBUp+m"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760501496; x=1792037496;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=1g/EI3YjYgXva6iWgqkGumWsmMfskTYQ5zVM+VjmgQM=;
  b=OlsttRTz58ZgnVbAagFRoRnQGYMKptleccUo6st+BRGR4WW28kx2Tp25
   IA0zsuuW2JhkqWM4MFPMrQdtLr53jY0cDbLUT/2dqrgS2Lb4H1SFkvlv1
   Ef62ImB7J4We/wa3TWspj4iqWPMfxYcvtPuPidCApNpCysn0UUa4geCWi
   vtuvvqhRNlmkHsMqt49K0Y2wRmNDisTlpdkVeKY/PysG3X3eE9Nza6TfH
   gR/bS8N16YdjTNlY8tav4K5YiDVQ0OVnxsK0/sCBGq+rPOOyufBZ/HhTs
   HwdQqmH842RACDXlR1tMzRa1RnDW++fMiPxmlsfo1/2IXhIcHFrD9NsY4
   Q==;
X-CSE-ConnectionGUID: mglJ90ndSPuXR+RBjwvoVg==
X-CSE-MsgGUID: cqszwvovSuqERS4HvHP7pQ==
X-IronPort-AV: E=Sophos;i="6.19,230,1754928000"; 
   d="scan'208";a="132917523"
Received: from mail-eastusazon11011027.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.27])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 12:11:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUTDn70XI7JbvsXsmRfcg+w3mA41TmpfBNgsbgXHEMOJa2uckYOZsbDCiYAHjxYHMYGRpdgY3XK1ANcfuiTvU2wgRwxedGJ1dfQWkwYA7Rg33kaEgRAX2qF80pHwb0fZ+qdUrc0NTqCWkyZYSy9OXtr+ENngvvaFjbycYwl2DiWkt5nN56p+ux2EzdwD0f0gbJbcC26Q+7f05WCVna2ewiJH+44nhPj3yCD7ZuHcvohBIwzCnRxYT1mhON5mNNYEPbELqIp+3HOdUP75Rw8nzjZKO/m87rE9+Ml5yhxF9XjBj3Se70BabIegWNMauAgZj0PjjfI2mewvCca0TWP2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BVQ2/ewzbJPIJswP+RuVPUeu9a+fKLnSNTOHM8Sabw=;
 b=GS8PF2YoU3V6UtP6tYwVEdsMcg614hNnoG5d0liC3jY8sde0BwXin9uXjJJNcEsoFy/9/O6R0vyArzLgu8MBGG5ghbd9mnXrbDb89Q2sKR2qaGLXLF6UXHuBXPTKZZrqTrMPEj7ab5mQ633BIRv8hGGkJ1Pek2kbJOdijCzIPBy/bcRVyJ1WApEWnzIaTIpG5hNwixGZSr6JeyBfzaK+PwzidX6CtAeUVhfSoQK1fsEy5zshhTLoJpKfdap47tq4M8FCZerW/FJ5z1gHFamC8KX5w47JcmlMS6g5pvgmqUpj4rLGFWbuoIW25KnFVXOTJ1B6JA0+KWi6xZ5qPC4rqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BVQ2/ewzbJPIJswP+RuVPUeu9a+fKLnSNTOHM8Sabw=;
 b=BVFBUp+mWjHPrTjl9vY1vXg5EsBqUkgonMQ7X1M5zcdAL1La6G8601eeVT33D04kVskY5I1ILeKsvSXTPnKX2VK4BpdviP8E2AY1sGW7iTK8+3/u5XpUQDfebbgm4ISiMA0PZdLdpWBoAIs6HqxBhrLYdqgl1FjRnGcQOGiWaIQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY1PR04MB8701.namprd04.prod.outlook.com (2603:10b6:a03:524::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 04:11:28 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 04:11:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Subject: [ANNOUNCE] blktests CI trial start
Thread-Topic: [ANNOUNCE] blktests CI trial start
Thread-Index: AQHcPYnH2hZei/96okebEP1LzX5nrA==
Date: Wed, 15 Oct 2025 04:11:27 +0000
Message-ID: <pxwm43grh4cxxjh5m2rpdknwjubf5gf6x3wfnqkg5lwtp7fua4@yjbyefua2e33>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY1PR04MB8701:EE_
x-ms-office365-filtering-correlation-id: 0f6efdf9-68ab-48b4-0d65-08de0ba0e9dd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VXBfelkcS7ea08LEDtEBbDKkA6oB4lKSy3JQyiwX5CVTh6U4PuAjcW8bH1tX?=
 =?us-ascii?Q?vWUgNGQ8OYC4dENCfw8WbSpQaQdd9QRfjMIci2fD6R0dH9C3Nhi1M23dYtek?=
 =?us-ascii?Q?w/D4XyeqspVbCUSJI9n8EUVzmzHMXR6/JRzl5miyZTNbDaFkI+ucnWgAblty?=
 =?us-ascii?Q?VcJGS3qPk1g2hPw6fPk0aFElI7HN1JOT2gu22pD53ESg3ueOwB9uFaOD029T?=
 =?us-ascii?Q?o4D12OxhYe5z30wb7A/yXTNzZF2+bThxyc068nJeQzwwqj/DXzJ9fyJIYM7b?=
 =?us-ascii?Q?2+rmrDIsHsySdtTZZUuGVQ0aziVAtGvaCh6zpg2xEs17g0G76czkXi2Bkwot?=
 =?us-ascii?Q?0XPYKOlph7kNi35MSn/iAd8AZCNlest437gtHJOYEj7FNzWOuHMi3JRqk7Nd?=
 =?us-ascii?Q?ClHYXdHTdrO3d5AR0r3SbHH4dZAA4Pey2HmY8Uo1zMYR7pkycs/B/xR2qC26?=
 =?us-ascii?Q?W1D9b0Oxyh2rhcTGkiVCuWp04nkqLoTxGYW2/F0PfEj0pWwOtLx4aEH6iGnE?=
 =?us-ascii?Q?fyPUxxe1I48OSwGOJnutghwXUysf0w3xGt79o5UcbVpNsz1U7LbyNY52Uv2u?=
 =?us-ascii?Q?MPUWLU8Wj05Uzr/VkmI7CPat5r6ZNTvtvpj/rSeAPQ+vdx909ipZRrIKmyJW?=
 =?us-ascii?Q?cCyw2roO6xBbzghjOgnew4o6Nf5IRrSky46itPb1BXIyj/Wa2TALZvD3AqEZ?=
 =?us-ascii?Q?JFekqU+vQaPuCiLk2R7dqF1X1bUkYSKMyIvGKsXDc5rGFa3kRY06zc/Pz4Qw?=
 =?us-ascii?Q?JNgtGgnLRGGnheDEbP7fv3zl5ULf3ZbguXz0caUW7HdOk8zLESpbtkSr1YLU?=
 =?us-ascii?Q?0la5dZpJI08coaMkBHXP6A3kwEWFTuXwpwxpLtTGe/7jt0dM1CPhBpXZraR+?=
 =?us-ascii?Q?R4j340Su1n7+yeB3utNjRC2eYxDUCmkbEwyo7OAcbTLAz6eM2upHAiSkN3lL?=
 =?us-ascii?Q?1FsI8SWGt1Iopp79H8yEW0KRO/qSQOkFwX3flVJcQBKbe21stAt8b+VftWxw?=
 =?us-ascii?Q?pvZoHExyL+UJYhkMpyYFrTppVPeI7ZTryuFyRxciWdMonlPOX6zwM6XqRTNW?=
 =?us-ascii?Q?7YFbQeuQ0IMvih0JsvXIi28GGQ6YqGpZYfaKaeoWpaK6WcbiSIXRHQuBY8z4?=
 =?us-ascii?Q?ZrGDINah+GyXQsWhJGxOOwZypypKd2YCA/CVHgSFmDY6gQztOHK5KxC02RYT?=
 =?us-ascii?Q?XwfUxjijnG8ppnCAj4c/vYoDHKWE8M2j2EDHdaMU8o5nDnBNfRHYG72ZX2LC?=
 =?us-ascii?Q?tnomXmwAY/UhmakS9SOFhUbSD02MeVfiXgCJbRvIyNwUs9QHeIw7ajSqLvff?=
 =?us-ascii?Q?YCe8wtPO8UKl/Eapy+9u0jJvSppPFQmfZjWdav4iYVqbvGC+zjmdVKWd75RF?=
 =?us-ascii?Q?PvjVnBnNX9k6DEyI0AQflSG6pe7bJHnJIsS1ZxQJGWN/5xe1Pum4STSi46lC?=
 =?us-ascii?Q?sob+ukXJP/DEHzj23y2Bq1d00hlhft4hJQUO1gP+bDBDJXvLmnnXtcjc0lRz?=
 =?us-ascii?Q?VSP2mB1OdpegJg8Qvv6FeLUMOJI/s9ll+bYGeB0kS9j6g2A3Le4KLMxjRQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9HQxit7RFF6+QQFBACfPyj3uD+scJeBq/AZ/Ge0t6XkRrkI+7o2l21LRxLvC?=
 =?us-ascii?Q?Lc6I7PEKZlYg37jXl57HHvXr5t2d2fs7Gq5Og2J3jF58phbcJur7UnsVxtOk?=
 =?us-ascii?Q?Y7ykvChr19eeCuQ+BOurzNyIVvLeyfVp6A/+u3ed2EXLKXJ+zVgguyCAw6zP?=
 =?us-ascii?Q?NSOCfZvBpAA3woU3O2Sn4i4K5u3MYnJbFp171BDS+Rxe8xWZcMZWYpOvbZRc?=
 =?us-ascii?Q?ZIbJEWXqU5gbTqW0/Bkj0oxgLL4TqNKvnjiETjPDL6XYTmz5mmM5NoUstBoY?=
 =?us-ascii?Q?ndcWzNsbAtyi+op8tY9WgVEwfcq5D+UdgUlwccgM17fQln188iKIwLBr7+j3?=
 =?us-ascii?Q?bQTGP3Znv1gLyDzVBls9IE9SaH8wnBwze9tEf+g2mm1jOEmUBLAjyJbxOepI?=
 =?us-ascii?Q?hlwAdEn94QdNy1SdZCxNwssc00CGo+3pjdAUPOIkvBYgcSaJLECgup/gYCCT?=
 =?us-ascii?Q?l64R6U1phLjes8OpdqT154oV+SfmpFem/sbFDvQFHqf+EbI/8ZrIO7dvU5DO?=
 =?us-ascii?Q?1ONI5uidYPmhm6uB4Qy0G5Mq1YRKhWwVSu7OqvGtb66LN6FzMFlkHsvehyJk?=
 =?us-ascii?Q?On8cKq/vtzbnKbKuIpEdNmmGd5UHiNK5+wyK7gXlFoEAN9uI0FHVsw3vG0tT?=
 =?us-ascii?Q?drPnjkYEWzSr5/XaSGE5Acd9NYDmwmrvi7JnbDaG4USa9stkH2+uekZuxlqK?=
 =?us-ascii?Q?ClpJNvUr1RCbgGAnfDyjR5VKsvxT8S6GLp2QscLue/xig6TGtaprSpHRXylT?=
 =?us-ascii?Q?hq2I6Y0UQBDygqOmkKTOMArLMT8T+b2hp3wb7PJWA4T+I7hYoX9+tJ6/KSC0?=
 =?us-ascii?Q?M+jXT/sGNlyDIVGIBmaZetDq9zmlMPqP3q/m+hecHqesL8bxd8lO8KR5FgMq?=
 =?us-ascii?Q?d+USjbziIpJpoadOOH737OZyQ2XQoSefm0BREm1Z3DQptfkK2zK1YfbZNt2H?=
 =?us-ascii?Q?dezCcH8aPrvgcNCv8XJC8jnN58/swAgVD98mhGgUEBONe8akOzJz65+51JyX?=
 =?us-ascii?Q?6O060dqkXMHgwoUTulr54utJ1CqGpYD7ZJ8ZR5MhEs7uGbfVEjrEwiXaeqyp?=
 =?us-ascii?Q?3H5HFmkEM9h9xATISSASm+FOriYZ+13oT6RND8n+5p1QcD6r9ce3Mngghimu?=
 =?us-ascii?Q?lhx0ge8F9gL2qna9clk+2Vith3Gy2M5QtVBrfptrBlG0Mv/RP6SVYFVXh4wY?=
 =?us-ascii?Q?4xpGq2v14yndRqURcqmTlep69vywZcwWjey3Ws3yJ9jM6oLkEz2+Hdt4gQu0?=
 =?us-ascii?Q?lkQ8YDIpip2YY0U+Y+jY5pT/I1QOgDS548BIc9V21SUfcFfAxQxB/JveAmPB?=
 =?us-ascii?Q?H1kXIxVcT277+HVya1t4ocYfbVMnMxrhVuRus7vN5BEUtu9zoUSD96268tkj?=
 =?us-ascii?Q?TzdYTDFNWzC0xGKpUAxOlM9Te6nSfzwzNnpp2FdHIyM2R7lENoxp7VWdObLe?=
 =?us-ascii?Q?QvEAS8WiC2ttwkneMZw6a4poL2fSp9lAHrV0+FNK7OGNkyt3P6+3ZfB1owCi?=
 =?us-ascii?Q?/ljdrXf1EQ72GeB4w1nhpdznGKRu+V9NHsAxXcfakTq8fw5a4uJv8tboeVI4?=
 =?us-ascii?Q?tT5Br9POk4vYu7QKgB2h67sGijBZ8npcNM6VV/6KwzWwN/hegZBrawfnM2Gk?=
 =?us-ascii?Q?WsY3M/sI8GrHMHf/8DqmIXQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC542CFC71049040A40789E9B28B6F03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3OHsmkbpFkQVmbEZ4h4yMuceUek9T1K1bjaPpim7yUbk1CjDfYeqYmF1lRTgbaHwyWTv92oPpKYg2DOEBnDcrbSDSZIJsv5c+V5FuvhmSPYEs63Vk9mCFVdVgou/yLMqqEcSvdIqgU17Pz5cDR71v5+8LtXR7cSki3Tl3HQ3wQ78OYMJI3EAM4zQ0ROlUT2o2s+OXPuzbeuJ+jTtuHG9NZ5LSU0XRzW9M2sES5pCreQCIU7k/gy4Y2dDY/hhQlUFfF8bwIpAFpXdo4zMrxvDfrrX+6gGEKONVp2AcSHd7auhiRChBNjrrCZu+HX8ihQaHjQoSNejY3EZzkjx2yjkD9Xn20Szua0nNpNKqWhAgEXLkMoGJeixhEi5C+QsmRuoxggC3yXJXHhaXwL8B4dCW7yL8pNd8t1mjuVAClEEweeOX49Ukg9mfDDOjSVQiO/E7yaBgFH9eeUCyaXUMPIW7FWvYOWYkpL1SBVQsByrdB9WBFY2SylEIF6gU/AcN1nCPtGkNDPwX05uQd8PpN96ofrubTgljObKEKnBhrKYFbSQX9cYzLKJ8e8f37yPhqw7aCh8rD/qtBU2UqsM7+DjBrK6ZPqrrfBXqmq295ZNWoe5b5qDwtX7VInC+ut6g4cz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6efdf9-68ab-48b4-0d65-08de0ba0e9dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 04:11:27.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T26hJakrwKwU9F/NKcdyzMOlLwNB15RPrSxgefn444ydoE5UfrYl3HKavsGabYwbBjskNDgrqMjA7BL+Yrh6pIcmgLgj4grjTMJk4QM1VGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8701

Hello all,

Following the discussion at LSFMMBPF/2025, blktests CI system set up work i=
s
ongoing. Starting this week, it begins sending automated blktests run repor=
ts to
the linux-block mailing list. When you post patches to linux-block, you wil=
l
receive reports like this [1]. Please do not be surprised when you see them=
.

The reports include a list of failed test cases, regardless of whether thes=
e
failures are already known. For example, it is known that the latest kernel=
 has
a failure at nvme/005 [2], and this failure is included in the CI reports.
Unfortunately, this particular failure has already caused a confusion [3]. =
I
will explore ways to minimize or prevent the confusion in the future.

Please note that the CI system is still under development and improvement. =
As
such, the reporting service operates on a "best-effort" basis. There may be
cases when reports are not generated for your patches due to issues such as
kernel hangs during blktests runs, server maintenance or other technical
difficulties.

We hope this CI will contribute positively to the block subsystem developme=
nt.
Your cooperation and understanding are greatly appreciated.

P.S. We use Kubernates to manage the testnodes, and GitHub actions to defin=
e and
     control the test conditions. If you are interested in, the Kubernates
     scripts and the GitHub action scripts are available on GitHub [4][5].

[1] https://lore.kernel.org/linux-block/bc165392fe16366c431922bb4d76119f959=
7dfd4efdb14c1f169eeacabef0e3e@mailrelay.wdc.com/
[2] https://lore.kernel.org/linux-block/3bbujxlhhzxufnihiyhssmknscdcqt7igyv=
zbhwf3sxdgbruma@kw5cf6u5npan/
[3] https://lore.kernel.org/linux-block/408ef850-e0ff-43db-8827-7c756cc7490=
a@wdc.com/
[4] https://github.com/linux-blktests/blktests-ci
[5] https://github.com/linux-blktests/blktests-kpd-ci=
