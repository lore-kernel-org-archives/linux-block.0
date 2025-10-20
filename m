Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCB2F5A02
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964012; cv=fail; b=Sbef+91KU0g+c4rGcwN+HELMrTRGeLAKx+lQWUSqDg/IrGZ4gXwQNTpZIXfPNyuPib3NXGr21jT2dKWLFfczzb94Ve1Qsq9Htc8DXncl6u3Pa4lxsleUkDDFaDLto4yba2dYhLKOomAg2m61a1Arl+c27o6ESkldjGbtJYYnWdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964012; c=relaxed/simple;
	bh=BsMVz7tLTJmEuhDcdOGfAX2N3tbPaPvoyicFsm8sHLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FHhYBaePuTnat/cYWXBVSQmsUzgX+0hojIwrQLM+UxkhGDgzbSAEz3jIPXS0keiwrvwPtjT77ObpscC8zYTa/21aH1kRSk6e4E6zQHeV8Q03n2akBE1kc1rpe7DghNrNQgTLbv+m72D5sOadNpVk9LsNYpAIwjU0er1ayO7rNjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kj4Laz+M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=c2+cRPVQ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kj4Laz+M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c2+cRPVQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760964010; x=1792500010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BsMVz7tLTJmEuhDcdOGfAX2N3tbPaPvoyicFsm8sHLo=;
  b=Kj4Laz+MMQEkmLn2rC4/c2t0Fe7sRgKp+OxYmUI4aK7p7K8GQN3ub78R
   inOQ3Gcuyyzw8TkdjBH0T8Gk25Tj3IgICgKcfJvSd9v6LBvPNd6fuWChJ
   VmcIZ7IWu0HNK8XElj43iD8xX1ot8rKNsLbHe8V/GVQ/StV5a51xI/5EL
   gVX4tivB6xwsyCRFoYVAXSW+xAEiqOXkrZ1YDrSCfSJIHcFXvAD6L/OLP
   vEp6W45mA/fprhPRhIxqsHBDAI/FZ1dsf5lPUQAEwYvRgdGdd8RNuWDVd
   Fh2etJDXv4WyWSYp5z+cdhNa5oy5oTQI45sMUok2f0YzBIaG+PwgQJJay
   Q==;
X-CSE-ConnectionGUID: UlQH/nCcRO2RupQ+GgpBAQ==
X-CSE-MsgGUID: cATwaadzRPKoTnm6myESKQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="133467527"
Received: from mail-westus2azon11010071.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.71])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 20:40:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O35JwWTm9QvOxbyFodcBU9f2oaWUJfXlYqs2IE0V7GCfHBUl4xi9WxEMSVXYlMNO/PzGx3/uuV3ArmI9tXghhiwWhoafACiAgyE+AZh46ZRVlLhaJpW9Nyl8wyYyFHOSdNbA8KWW5SLNe5bW520KZYjBU3Opbs88Cesgk7lThULpNP3YeTf6bKFRM/U6mbvU6Yt9LeUE5sSShMC1ztQyuXPtGpFld+8MdaPEML/AGQqkrXJhhljYJmXzHliVtAsS3ype+TVEhwWzl6Nn8VLxfCgMFnWkjH/SiSaPNVnQe+OU3LNIa51T4r+QGCr/PWfwvPUp9YjanatIfhqb9Dd61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPMlUdXWjE8mX91UpxHe+JomBEaYtXqABzEIaRYEwZs=;
 b=Mtyr6NYcT8tQ8Y9AuRmB1BZdCV/+xPpbrDdmfZ2ut2fJ8JXPJ6VhCgXevlvoradBD/xx5tKvTR2zO2cVidOF9FGvSAKuy0rQLj/g/TbisSTMBrbQCWUxHBlPnTXud/vUNjb4gNicMKIl+pcvox+4I1AFnUnk7d0IEIzRbHZC0oCaVlQvOkrvvOoZpDxEB7nJUXULpGsBoJ49hp9nJnXrRMEG73DJFPVxCfH5FLyhKllddTPSho1YNiBuqbpDcE663keyutqTv267aHeIAk7tTwSgCooFP+LqcAxAUnaf6okXxyuOI8J0UtIAb820Cc5DkR7Hv31uQAC18iFMNxU9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPMlUdXWjE8mX91UpxHe+JomBEaYtXqABzEIaRYEwZs=;
 b=c2+cRPVQL9prGqTgkidtzPkQR3BJ8eL3pBpATqJ3y/ohd8v4RgQwg7J6ndJh1H+LYtvWUCCZrkFPaJcCo0kb63MoSZb0cB9uzXfdJFBr3t8kBv03WPVSK9vaIBGT1BESzRBoJmwxexm8rMFMD/ozFDOheQOMUFlOaXtjlW2pWus=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BL3PR04MB8057.namprd04.prod.outlook.com (2603:10b6:208:348::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:40:07 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9228.010; Mon, 20 Oct 2025
 12:40:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH blktests] create a test for direct io offsets
Thread-Topic: [PATCH blktests] create a test for direct io offsets
Thread-Index: AQHcPUy+TG4J0xI2UEy14ngxq4EfE7TLAriA
Date: Mon, 20 Oct 2025 12:40:07 +0000
Message-ID: <bihyeax4gcwr3ayy64bkdaccnjuyv6gp5fz6wxgnmwuhjy6be5@rxakhphw5445>
References: <20251014205420.941424-1-kbusch@meta.com>
In-Reply-To: <20251014205420.941424-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BL3PR04MB8057:EE_
x-ms-office365-filtering-correlation-id: d961fd16-dd75-4e50-2335-08de0fd5ccdd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?I/9OCIbiccry7H+67kXClWamlPAi7OesuOXZuTn4ApSw7d5dw0VEQCUjSW7d?=
 =?us-ascii?Q?l2TyZCqX3gJ+qDhh4uJngsNng9jnezp0bKYvKVGI/9u/NBYZh2eOPpvWj8pP?=
 =?us-ascii?Q?H+n/zFmbuwODbJcdEPKxoXiRwCRerE8d8eHROoq/KyCjxudJB2Oze2k9B1Tn?=
 =?us-ascii?Q?Gl179IcsKM1PtI/IVaZ69RbMXN0ZKYdoKV6SfW7UbKqraD0AcsXR3XcVoomV?=
 =?us-ascii?Q?+LqEE2cBdUAEEGda0GKcTpVVaEXmRNXCvbkpxuaxVatS4g7hyVbu9i2Nby1H?=
 =?us-ascii?Q?BvufpS4WkuO2mb+u+pe73u6rpmArERFJXWiZw0kZNMm/cptURFO1Xf0EEsIe?=
 =?us-ascii?Q?yq0JBcluoFQylFjIF40F4rtMDxrdKOdOxFyds6j9eXkGBY4uity7Ye+XC9em?=
 =?us-ascii?Q?8lrYLill9INvwcTy6qssTAp0taRdzJawAIIqPYZqpcjP8CIlHcTYyaiH7jTQ?=
 =?us-ascii?Q?MRnoRR5eHu7idZopHT8cCuEqG8CckZCEq1ueqLF1pQgaFMoHpnJ3F5ZRCVhR?=
 =?us-ascii?Q?VPE6171jUbxxhQzlIwtYcF7VH8ULAz4EflESLpJJnEF0pxvqjZv7D4g4+jSk?=
 =?us-ascii?Q?huMyBhISMbWvJspYGoCN0E8M3fa2Ua30FBI2Zgqrg65hQdxJhEm23/+UIFXg?=
 =?us-ascii?Q?l6lYkHKqsnjqDbyaAZFY2hwgLJ20NA+gBpg1OvHAd4Y8fBcmt681AUbc3DOg?=
 =?us-ascii?Q?DQO6CKWM41nSXmb5hfTCBAYRTN5oNVROny3WrgeHJOTKLfd7JGxIyzarmGKx?=
 =?us-ascii?Q?tpwX8dmchSqBAaKgzJjZtjSBMXA32I5ZzXS0kyqliuPBfduw0VCxZ7hpPvRn?=
 =?us-ascii?Q?Sou0tmRfIjHjPita+Iuo1GVxpqYPY6iQ3mh/FB1zc+Z4RbaaXK43Z+rOXOTI?=
 =?us-ascii?Q?SIj2Aoj/GAgy5YX6ZmqK3ulJ4WvNha06zlavRChaApLmeIrOT4bWGGgP/ioT?=
 =?us-ascii?Q?EkHGsimWuOqEGlC1XEutuQtlKTA6O1kDzjAmljgDYtoT4FCWz+lpVThdVfcD?=
 =?us-ascii?Q?uUUnhV2D1gaa5y00ExQeW4dVJFf5pcQ2fC3aBZiIXuhfvWqadXSl/9UOzhz5?=
 =?us-ascii?Q?sRzOTmz2nC9oN+XqOmK5qkHkqMY27i0OhhhyxLBIO61p0OzTrT08X3SwRuAZ?=
 =?us-ascii?Q?ChYiJE2fsabm21wwMNlKCv2vNQFUDJhQ6IClWj82NlubMY6Kn55Hma7utpqL?=
 =?us-ascii?Q?ocTt+2B6DYt+4O+LDwpjea2G+wgK/RALxvzb21wxTRTa4jFHveu9ap/o073Y?=
 =?us-ascii?Q?9cjg06umOIp6LykVMzXx5fAGE4DwsOiM8xktjR5KH4l1KOclyXi6vAM8JDDo?=
 =?us-ascii?Q?XJXlPOjbQD5rpnUn4DrgFcUUt0ncNGyR1EkaLiCm0+ucRvywPThS2HD6Df5M?=
 =?us-ascii?Q?j0PpE8cLuvw6vMljfJ4tjVtfGDQiE+59XQ8NVdMwNhvk4FM/igthHrqyI1FO?=
 =?us-ascii?Q?dZ9MOQ//5p3nv/ZSQz6453ROOf4d3aUHrUaTbnWKkXYqovywDBPwe4iTrOLH?=
 =?us-ascii?Q?ys4G92DQVE1oMUxweMBxmH0kinrLBjf4UPCD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KjWPi1Y6QrBZpu+DiCcAcFPdd/tohtmUREaCWP/C2l5XWXGaOJvW3Qdi3pPh?=
 =?us-ascii?Q?Tk5MKbMkDYftFyw9o8zCaw1Zb5/S7bBK4um1Njve2EjYl9gBPFeNNGpakEYV?=
 =?us-ascii?Q?NVZIzMmzTY5/FRBCESV/x7yIFPmx/nESGdgy6U0XhmlxAtxUM6dnvml1oxNm?=
 =?us-ascii?Q?l9p6/GNUrVplsBw2IL+NnexXjXqKDYx4ZFS4Y46cmjUhnNHbPEut2ephCN2l?=
 =?us-ascii?Q?+CB3jCaEUxwD8j7xrlesC4wOlHHtrIl7xo9shM1V0xZoY26JtjKRvX+s0b64?=
 =?us-ascii?Q?nYLY6if9PvepfZL6IwuRUBwS9SoLg0DfAGLyy1TfOsFrgT87B1mCCiqIFBa6?=
 =?us-ascii?Q?1yrbpTuJRCW7M7+qKfQ4ifau4kDiav8wrFLrwrr3hS+iDPXc2oLxUerR04kX?=
 =?us-ascii?Q?+NFp04rLrX1vHwo98ffbZ/H1E1/0/9eunK2n+7K4CsdZSiqaB3YG7yGwMSS+?=
 =?us-ascii?Q?VA0BcbQXbeQdMJmUwyzGwGVeEUvJWr7T4rxmtyOJ2elaKZ/BTOdKdlnEzbKc?=
 =?us-ascii?Q?Cr1MOt5UUTzh0IsmDkthcMZ/X6Ok/PknoIXnAG29n2J6OFjmnf22SF66xzUp?=
 =?us-ascii?Q?69v5Z63NpyUZ7dbjWsEjqhyYMBCKqzr/xf4V0XhK1iZLxK8cMAAEY+Bg9TPz?=
 =?us-ascii?Q?r/C0BevnM4FzpAB9U/1OCCUX0XLa6YzMY2cPSTvSvW21WreQLaDpIRJSMwsB?=
 =?us-ascii?Q?dlJINA7fZCjjFIIyxPudBmGTlpRpX9+KKHNecl4twvGk391DvethoZ8QiOez?=
 =?us-ascii?Q?BjAsMJL6YrhTQDCb8uJDE8QzRBhIfCHH+f3sCoyiP+INDCgnK0wvrGwC4FSy?=
 =?us-ascii?Q?DQDDxTTHcCwCWrYS/lKRyen0UVc71U7SB4qxLA+v6gUbe+OXpse2Kqscv7s1?=
 =?us-ascii?Q?/vLlBvjJqQoIbkk1JEs669RPFJCDx0tsb3mfSGhZ9NhgsesEEwvgiaD02iyy?=
 =?us-ascii?Q?YD3fwLgd7fKpgXISBLcM7rZlOokKQra11+YxXchcOYm/CYyHr/8mpfiyhMaj?=
 =?us-ascii?Q?NtGuHiNWflrWLoS1eOeNAE2Aw3RHubJmJRRmuspc44+X+XFGodv8LritEQHv?=
 =?us-ascii?Q?MzMuKOCxkx+i4KlcQTuHFJN2/eW+hpK70+DBcj4O9AmhspTFigfivt988R/Q?=
 =?us-ascii?Q?tP/cOWWzW5M/vj9jSK0h19QL0TgnrqqizCFVpvja1/ES3BKH80iUimCKMqsg?=
 =?us-ascii?Q?/Mqb6/IGoj/ASYQFI4tofcMLGRV6gYMNyyrgo+/rc+sq1/5oBcmQGiXXw8N0?=
 =?us-ascii?Q?01Ah+MVFxq1w1H4Clcq9i05CBoRSs9Pmn7OvpweoLLesxxWB8sc6nqfi+x2Q?=
 =?us-ascii?Q?Q03V8D2u52WKEVuJA27kh/+yClsKSSNWVd5yKBK6GGanbd8hL0VhIw+BarDA?=
 =?us-ascii?Q?irklC8drHgAtFF/Ze0KdAePu1WbkzgHTwinCriGJNO6QMzG1RPWoNxA6N3JD?=
 =?us-ascii?Q?inA61kDaXf9YGdiMmhgcpw0K31gayoBDl9HU20L5kA6XkLjWPxJFZ+BFo6YT?=
 =?us-ascii?Q?bgxT0KnYKycy/R6X7qJy3qpgb2GUoCguEGVYTM7ADxuE98Txlym7ogY/7Q3e?=
 =?us-ascii?Q?dR97fjAXCA8o7Oj5Q/dLHbZyq1vJMIwLSXvpy+sjs5aOcZfTQU5WVZIXnI6s?=
 =?us-ascii?Q?adfI9eU8vEpUx/tPYVwyRv8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <775BD26DB959BF458D6C1CA8E4659C68@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xr7Mv90Fx7tu+QblW7+IY5ve0KptW+panVACoXznEIY+ahL9YnVVtBWQd6DDJ2pW2GSrEMnR+SWSy9hTvD6IUy5xrc8XoWJOojsONn3PGDqIXQGPw945TsxMLCm1sQxLikWznHXT7wqNGPWh4FGykTdnCOmM3y0xyeBJs6wWiJ3vtUbSSeyNrbS7gJCPE93uVcVd/bjbTgLykxj9zy5srxlGtvsuJkHGhgeNgfQVUvS0Pdtpw8naoW87saoZXD5del3iNGcgkDYwOJiyr4gg1wERErF7x4/z4rciBj37bbDskXwK6ky9bpjiNyfW2Z9mjAAtFim2h0JVlPn13r7HV7iDireG4NurFDolIOYRxwrP2HS970YuHsoFpdTnpT++HNQmhk3TZnSVv19dhUj+Y1jqmENnLv0R9BAtGs7NGZkeWMrAucYeo6WZ+pkaqgichuhSYWqyyrhJ2hnk6F1zKsX0m88Yr7Lcen8L96UaY+uovUINOA7YfjtBhLnFHDCh8bTETe4KSSAPy2WlIDWlxfznW85InwOQR0/Dv4k5ybyTQ88ZMMeERJMCM2DI8GJ1uKfHftB+g5AXIOsY1SS0XGQ7wdWSE6xpCM1c1JjVQItyGhA5LTh+p8N1ZgqgF90p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d961fd16-dd75-4e50-2335-08de0fd5ccdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 12:40:07.2339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTkaAnZYTQXXF0W9JYzNogb9/OxUlvCcCdtMebjpSdlXVGsv38nVe1faj1Wlpmpw3Jfub4MCwud0XQ02RiLSYSU6tAJpaKLBHinj57jTd4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8057

On Oct 14, 2025 / 13:54, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>

Thanks you for the patch. This test case looks valuable to me. Please find =
my
review comments in line and see if they make sense.

Did you run the new test case with SCSI/SATA devices? I ran the test on
v6.18-rc2 kernel for QEMU SATA and SCSI devices and observed failures.
The devices have virt_boundary=3D1, and it looks causing a failure. The SCS=
I
device has a large buffer size (192MiB) which looks larger than the limit
pwrite() and pread() can handle. This caused another failure, probably.

Nit: I suggest to add the prefix "block:" to the commit message title to cl=
arify
which group the new test case will belong to.

>=20
> Tests direct IO using various memory and length alignments against the
> device's queue limits.
>=20
> This should work on raw block devices, their partitions, or through
> files on mounted filesystems. Much of the code is dedicated to
> automatically finding the underlying block device's queue limits so that
> it can work in a variety of environments.

I wish the corresponding kernel side change is noted here. I guess the chan=
ge
is this one [1], isn't it? If so, I suggest to add the link in the commit
message.

[1] https://lore.kernel.org/linux-block/20250827141258.63501-1-kbusch@meta.=
com/

[...]

> diff --git a/src/dio-offsets.c b/src/dio-offsets.c
> new file mode 100644
> index 0000000..5961232
> --- /dev/null
> +++ b/src/dio-offsets.c
> @@ -0,0 +1,952 @@
> +// SPDX-License-Identifier: GPL-2.0

Nit: GPL-2.0 is fine, but many of the blktests files have GPL-3.0+. If ther=
e is
     no strong reasoning, I suggest GPL-3.0+.

> +/*
> + * Copyright (c) 2025 Meta Platforms, Inc.  All Rights Reserved.
> + */

...

> +static void init_buffers()
> +{
> +	unsigned long lb_mask =3D logical_block_size - 1;
> +	int fd, ret;
> +
> +	buf_size =3D max_bytes * max_segments / 2;
> +	if (buf_size < logical_block_size * max_segments)
> +		err(EINVAL, "%s: logical block size is too big", __func__);
> +
> +	if (buf_size < logical_block_size * 1024 * 4)
> +		buf_size =3D logical_block_size * 1024 * 4;
> +
> +	if (buf_size & lb_mask)
> +		buf_size =3D (buf_size + lb_mask) & ~(lb_mask);
> +
> +        ret =3D posix_memalign((void **)&in_buf, pagesize, buf_size);
> +        if (ret)

Nit: Spaces are used for indent in the two lines above. There are about a
     dozen of other places where spaces are used for indent.

> +		err(EINVAL, "%s: failed to allocate in-buf", __func__);
> +
> +        ret =3D posix_memalign((void **)&out_buf, pagesize, buf_size);
> +        if (ret)
> +		err(EINVAL, "%s: failed to allocate out-buf", __func__);
> +
> +	fd =3D open("/dev/urandom", O_RDONLY);
> +	if (fd < 0)
> +		err(EINVAL, "%s: failed to open urandom", __func__);
> +
> +	ret =3D read(fd, out_buf, buf_size);
> +	if (ret < 0)
> +		err(EINVAL, "%s: failed to randomize output buffer", __func__);
> +
> +	close(fd);
> +}
> +
> +static void __compare(void *a, void *b, size_t size, const char *test)
> +{
> +	if (!memcmp(a, b, size))
> +		return;
> +	err(EIO, "%s: data corruption", test);
> +}
> +#define compare(a, b, size) __compare(a, b, size, __func__)
> +
> +/*
> + * Test using page aligned buffers, single source
> + *
> + * Total size is aligned to a logical block size and exceeds the max tra=
nsfer
> + * size as well as the max segments. This should test the kernel's split=
 bio
> + * construction and bio splitting for exceeding these limits.
> + */
> +static void test_full_size_aligned()
> +{
> +	int ret;
> +
> +	memset(in_buf, 0, buf_size);
> +	ret =3D pwrite(test_fd, out_buf, buf_size, 0);

As I noted before, when I tried with QEMU SAS drive, the buf_size is large
(192MiB) and pwrite returned the value smaller than that (128MiB). This
caused the compare() failure below. How about to check the return values
from pwrite() and pread(), and pass it to compare()?

> +	if (ret < 0)
> +		err(errno, "%s: failed to write buf", __func__);
> +
> +	ret =3D pread(test_fd, in_buf, buf_size, 0);
> +	if (ret < 0)
> +		err(errno, "%s: failed to read buf", __func__);
> +
> +	compare(out_buf, in_buf, buf_size);
> +}
> +

...

> +
> +/*
> + * Total size is a logical block size multiple, but none of the vectors =
are.
> + *
> + * Total vectors will be less than the max. The vectors will be dma alig=
ned. If
> + * a virtual boundary exists, this should fail, otherwise it should succ=
ceed on
> + * kernels 6.18 and newer.
> + */
> +static void test_unaligned_vectors()
> +{
> +	const int vecs =3D 4;
> +
> +	bool should_fail =3D true;
> +	struct iovec iov[vecs];
> +	int i, ret, offset;
> +
> +	if ((kernel_major > 6 || (kernel_major =3D=3D 6 && kernel_minor >=3D 18=
)) &&
> +	    virt_boundary <=3D 1)
> +		should_fail =3D false;
> +
> +	memset(in_buf, 0, buf_size);
> +	for (i =3D 0; i < vecs; i++) {
> +		offset =3D logical_block_size * i * 8;
> +		iov[i].iov_base =3D out_buf + offset;
> +		iov[i].iov_len =3D logical_block_size / 2;
> +	}
> +
> +        ret =3D pwritev(test_fd, iov, vecs, 0);
> +        if (ret < 0) {
> +		if (should_fail)
> +			return;
> +		err(errno, "%s: failed to write buf", __func__);

When I ran the test with QEMU SATA drive, it failed here. The drive
had virt_boundary=3D1. I'm not sure if it means test side bug or kernel sid=
e bug.

> +	}
> +
> +	if (should_fail)
> +		err(ENOTSUP, "%s: write buf unexpectedly succeeded ret:%d",
> +			__func__, ret);
> +
> +	for (i =3D 0; i < vecs; i++) {
> +		offset =3D logical_block_size * i * 8;
> +		iov[i].iov_base =3D in_buf + offset;
> +		iov[i].iov_len =3D logical_block_size / 2;
> +	}
> +
> +        ret =3D preadv(test_fd, iov, vecs, 0);
> +        if (ret < 0)
> +		err(errno, "%s: failed to read buf", __func__);
> +
> +	for (i =3D 0; i < vecs; i++) {
> +		offset =3D logical_block_size * i * 8;
> +		compare(in_buf + offset, out_buf + offset, logical_block_size / 2);
> +	}
> +}

...

> +/* ./$prog-name file */
> +int main(int argc, char **argv)
> +{
> +        if (argc < 2)
> +                errx(EINVAL, "expect argments: file");
> +
> +	init_args(argv);
> +	init_buffers();
> +	run_tests();
> +	close(test_fd);
> +	free(out_buf);
> +	free(in_buf);
> +
> +	return 0;
> +}
> +

Nit: When I applied the patch, the empty line above at the end of the new f=
ile
was reported as a warning.

> diff --git a/tests/block/042 b/tests/block/042
> new file mode 100644

Nit: I suggest the file mode 755 for the test scritps.

> index 0000000..9c05643
> --- /dev/null
> +++ b/tests/block/042
> @@ -0,0 +1,20 @@
> +#!/bin/bash

Even though this is a tiny script, I suggest to add a SPDX License Identifi=
re,
and your copyright here. Also, I suggest to add a short description here,
copying from the commit message, like,

# Tests direct IO using various memory and length alignments against the
# device's queue limits.

> +
> +. tests/block/rc
> +
> +DESCRIPTION=3D"Test unusual direct-io offsets"
> +QUICK=3D1
> +
> +device_requires() {
> +        _require_test_dev_sysfs

_require_test_dev_sysfs() should have an argument to specify a sysfs
attirbute file. Did you miss it?  Otherwise, device_requires() can be dropp=
ed.
Also, spaces are used for indent in the line above.

> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! src/dio-offsets ${TEST_DEV}; then

The line above caused a shellcheck warning. Please double quote the referen=
ce to
TEST_DEV.

Thanks!=
