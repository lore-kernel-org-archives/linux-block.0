Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4622D9ED
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169682; cv=fail; b=ZMMNvNKh1akflyjuBGvwkPx77kw0vQX0e0UCd/pMFdbmEwW2/Vcm1f8P3D/PV/O4gT89En3Lt6RJpqc/xKlcTzKf63QqmHu4e/1r5bBuhyVVf65/G5c6Ysa+jHygVjTWRcqn49ccUl7IwSgjw6kwj0vLwBNPVEy+no6o/XBDOcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169682; c=relaxed/simple;
	bh=NLDV9WBTKvUelQuNMP2ejkPeC6Ejdhfz3Cjlgqq1Xzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/58vW0DQqtRJw1o9vTFcSkeDukdImST58lKXIG8Ipi9WkKfiJ7Clm07LSGdl6wcdYK1p/UMJ9mDDHA7SFG4uRNzqKBqibZ3pdDsTgE2OmZANn9W6NHlKCl23K99hBKRP6qvnSkjdFmqmTGQj2460JKyu9NOuipeHmnGXhXPBH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Jz4cGdcW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DR9RPR2j; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jz4cGdcW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DR9RPR2j"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758169680; x=1789705680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NLDV9WBTKvUelQuNMP2ejkPeC6Ejdhfz3Cjlgqq1Xzg=;
  b=Jz4cGdcWfdgY46BMhQ2fXjxRqd8G1nKPuJYYRNG/3gMnU5yEEPJbn8z7
   OJhkbNxvPWkeP+2K0ze2rqwQHq8e18qnKAoDGZaOocam5QFCHckN8oHfC
   rfZRR58/wBjlbF1AcLsXstf7/vzpZNqcqfw9Md4I6Z7n1SstMJ3n3Y1p5
   P2g1j6SdfZAmUwXJgjXBi31tn7ITNEW150r3tGrRb670zHRr0xcBf3j1i
   3q/MdCtzJSKVs2tdKtxigZOIvHrpawnQf/iElgz+I+JVJOx4rtmqKJndT
   1JEKcLhokylGgAZppYYHqIk3xy3dS2RJH6yfLLfVMp0wrsdf/3hTdKzL0
   Q==;
X-CSE-ConnectionGUID: ysxiAoOKSaeNznGaztBBRw==
X-CSE-MsgGUID: RFa1L5NERISdWDMJ7z5dgw==
X-IronPort-AV: E=Sophos;i="6.18,274,1751212800"; 
   d="scan'208";a="120430316"
Received: from mail-westcentralusazon11010022.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.22])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 12:27:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGu2fU6dqPZeqaioyLcMyIocQcZh/tfunxrUyhAyxcI5tUqHvzxlkq7eOeixYgXUzadYne30DjieSZj+xPJcGwcBqB6MHxMee3yV++tbFEergIWFe8PgLpKty8zHr91JIMPRoM5uPsfQE2jOrab+M6e4JVI4yGhY87RdaAkTv1dJCm/aFxzLoSieUEGbwaok6oICR2gE/BYdDVtLXuXB6PkBbUKv4dsahcatLUIdbep067VGwOqbrexSVVJ64lqQPI8JpyRpOZHzgmGjnB4v/wBE7wsoefjv1AeufoKvMxIzye40O7TXdMA/x+9/ijBCuIOQrXNJT0UMNiJWrNy9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmfDJybb+miuZo7vn+ShHh87e24u92HjgZ+h3ywRz7M=;
 b=XXfKsz6MRMpzKHITKyNnuEEQRINPysjMOgVgsWrlaq5pdBT0oMnAPTAZe0+h4KQp8rDVLGrzjFRapDTd4U0fcILMwYJNB7YZDo2+YAYKA/8RhaSjh0WY0WBd4TSnzhZf2f1OdhzOaZ5uFXezgq2aiE2t2/+lNu/es3TQ3RdwJjeEhCbyuosdSMTajfMpAiAflJlEAxt8zQ0fqB+QAuZee1FgOEmYGqZXe0BJ51y3fmP5OTpolhQKrY3BBr3zj2R45OYBfbIOQ0A1VhysSQYN3GK6gYHC1/JVbfBzZjoAurPBAFjmFcUwcWQvmh4c/Jat5qv8xje0nCzoIi+XxipB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmfDJybb+miuZo7vn+ShHh87e24u92HjgZ+h3ywRz7M=;
 b=DR9RPR2jC4babD/GNo53Ahuqz/gXnxRqqksR5+R+U0S6vxXhWHTMVgup/Q0T0kyFlmLY5NVcv9XmamByfNwkhhxtLEpQbXuerF9nN/5oAaRPzvPFc29Ul5YZuBXSIzELHmSfaQZK3zXGA4df/Lqh5wwKmMUlpKH+muKOJU37cuQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB8323.namprd04.prod.outlook.com (2603:10b6:510:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 04:27:51 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 04:27:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 4/7] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Topic: [PATCH blktests 4/7] md/003: add NVMe atomic write tests for
 stacked devices
Thread-Index: AQHcI8vHFYxBm8bZnU6MID/oNvvTorSYYZaA
Date: Thu, 18 Sep 2025 04:27:51 +0000
Message-ID: <jp7exzjz55humms5qayfgvy6eu2eiu6kwpqs6la34cq76nu2ii@n5bgakd4ll2v>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <20250912095729.2281934-5-john.g.garry@oracle.com>
In-Reply-To: <20250912095729.2281934-5-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB8323:EE_
x-ms-office365-filtering-correlation-id: fd7e51b9-57b1-4cf2-e1b0-08ddf66bbada
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Tp4TVpE0BLhvazlj278VRKTOfMVlc8r/OXTcEHS/Nou0x55apnKxrLYeQn4g?=
 =?us-ascii?Q?mNcz+f+GKHS6WcisfeiW+LksM080baTIZLn3MnQXZGAAG3eNIupJNcNy3UMb?=
 =?us-ascii?Q?WurEep+VPkiCKmPVt6sXH/9Xi3zJKhUTsXQLUEurXgjgIc3ycuoCLr02pERs?=
 =?us-ascii?Q?GFqjDvobFPGhEvPMDNE7kjJev2T5o3wOAfaeQZR1HXuYhvhQIJjw6mIuLanp?=
 =?us-ascii?Q?AWoIcv1KDBoOGmYstudHnGu56bHPgpbcE8Ub6hZ5oWwi4waZyIvdHza368J8?=
 =?us-ascii?Q?WnAbxmHfd9u2r4tVluBBInGVLT6V02hIEPYxyB1Igr+y0xfwc4gwSGJViiXL?=
 =?us-ascii?Q?r9e/vMH6VHnIMnGE8+kh1gbjPukc/CG+7PPh4JIVsSouXTn+UavsGXKJryHg?=
 =?us-ascii?Q?0XfZHK/waFVi6jK0YkNZuTpF5ZZQTs3I9QUdc4eqyV4yvctAxGxtAGe5n+9g?=
 =?us-ascii?Q?N7c4stdJXdINclv3CdfjE1J+HUTsiRQT/A+Wp4YrPLme1CPmxHHxP4t5seRH?=
 =?us-ascii?Q?2K9M1N0OdkKEThuJdU9y7VphH8KM6dLHJepVFg3Vw6zQLEwJC+vNeeLbzclM?=
 =?us-ascii?Q?xZB4ev5t/LRTk6TPC0wnJD34YNXLsGwesSDkg+jubrWxCtwI7KpOcWe5cMRR?=
 =?us-ascii?Q?2jL3EqQCbqU7BqrfGpxpswTIEgupzOA5FXz0XHbSwDtQ+aVXsIPYIPsby+B9?=
 =?us-ascii?Q?JuO3ACwhmvEB5rLypp56WQfu4GAo8A8RCfvkKaQTL9Cf74/QurSnja96LNq6?=
 =?us-ascii?Q?0zL+Bze8A55BlaQQblRk2QE3IaATC5MArVyyZIqQjZ8Qd7571I9j3e8MAdAz?=
 =?us-ascii?Q?XQ/OcB4TDNkRMnnH19cupHDIFIAXRJkO7VoTduu80YPfc+d6TgLAaMfoe+WH?=
 =?us-ascii?Q?rIjKuKCrDzgQa8bkCLgKCvD9TXA5b3hVuwqewN/hO7prYSVA9BVECBPs9Tzc?=
 =?us-ascii?Q?yBjzlqZtLaGFPO3+XGI7KEqGMhwssKk8DHTqZLUK52orlXNQp1ilLQ5v0TBr?=
 =?us-ascii?Q?1nj6CdQueHaIMkDO0a6uJA2Yy8++UxjHgD3J3LK5PtyNsuSdzJgLOfZ8IbY1?=
 =?us-ascii?Q?cPRSXk619dQ4MzXOlVvxra0qJHfROgxKgjRaM5+wLRreWpjsRGVChqWEE/IW?=
 =?us-ascii?Q?iRm4K/x3xDRwyvNoZDx1RlfDmTY1k02qzrvR0MP6iA8G+QXu0D4XWrKN5mM3?=
 =?us-ascii?Q?T31wmRBMrF+iDdRle5smZ02dxFgN4wpwFFPhrexs/8xCDMiCxPmhMoQHLkco?=
 =?us-ascii?Q?qQ/YenZuCET4gf8f7+SRc5OREChl++8dia1agZyQGPhQqt9AzPwJfZyot5lZ?=
 =?us-ascii?Q?J4ynRtaFiWaVPiv2il/szcAUw2ZLrpUJxFdowtBehlm3gr67jjLyZ5BV39yh?=
 =?us-ascii?Q?/SWkYqK0dexVbFFTPVKQdQ5l5z5dBV5GEP46x1xkjk99zCg9lnh5pzw1A/bW?=
 =?us-ascii?Q?TCSxIiYBloohC+6QJZA/WNDJMgi8aTPCo2J4pUZ934zq07YTAOZogg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Amdh0UeCvWTL0Di/WLkN6OPNhXqiMxinIqPj9P5UYUPQY7lK0pTsMtVWR7Hn?=
 =?us-ascii?Q?g3Phxx6eDO39SFSD6TCyMSep5auenGVmLDlN6qUEpRi2qvy1n7N6NuD+cL4o?=
 =?us-ascii?Q?szM9a/DPLJbAjbmAj0heMi4UIco9md9P29phJ9g66NaE+PU/Qx0FpymhEXOo?=
 =?us-ascii?Q?ecfW7fX7wowirmyVEuWc2R2UMfqeWC49kmzoiXKFgHp962645chz8NWAs7wm?=
 =?us-ascii?Q?IHO97rQVaq4ewjkuXzjcGSF20nkqDPBkS+iWuURi4Xn52Bt5YXDWk6LuSwsV?=
 =?us-ascii?Q?W8oECJdoGFXdG5H+fvJQvkhy0P1P/Gsli+TEJ0zzsOdnlIJsrbMHjOWSAOze?=
 =?us-ascii?Q?Y/Rts2p5BhgqqsNdkL+v4DnSujQL8UkavedpBCPYU8JFSssX/90kRdqpWOuD?=
 =?us-ascii?Q?bajP5HUO3H+gY3BYyXLKlJ19oAHbzVw1KGGD4DHzI4PDRU9/oGMWAl3NUjT1?=
 =?us-ascii?Q?d8cxlwvcPky84Mmw36lc3Va33GlrkQgy+JZwpfjCetSmzKzQRhYj3w++/3Fp?=
 =?us-ascii?Q?Hmw8GJxS9VzLNrWXmrNs3tW3yON08gnmEEGGpcPSrWwpzEzVoCLQc0DTLMSi?=
 =?us-ascii?Q?AqRIbGCCESpCivRbBoBLOuxMsmbnnRxyntxoGjAHNWQF+Ak3+P2tHKXdgCIF?=
 =?us-ascii?Q?FqQbhd9uTkQhqA5uOGBtqU/iGz6XN6li3QCbXPsVBSaOGJfTSfZokH2sjeGi?=
 =?us-ascii?Q?VXF9NPXyubZxWOhLlEwZlqVKgIF1mDr5L9z4rR4k9Sm+Q8MR3721zWSaRtAf?=
 =?us-ascii?Q?0xGtC+7Jkechk5tCBnljFNiENdhKiBJANraoOG9cTrNThRP1g6zuYDSElUWK?=
 =?us-ascii?Q?Iko1T5Kqe/8dVyNYNQFsMJc6MT33Zo+yqurs/6Y6HmiZS/2U0be6ODKcZSVM?=
 =?us-ascii?Q?wQVHgcVnQwLfNlBpp7NfdfRqtwpuciW47lgQp4aKJfkjfsUvW4Sx49DA9KVq?=
 =?us-ascii?Q?qpuScaZPOkFs0r/T54khlD2o/olf4pVtLYMRnQPYD96AL56cBSkjJWIIG09V?=
 =?us-ascii?Q?NfXHb73HE+k/4L+/QPh+pzl27N8/cw145NeR684jH4D8/2S3vZioTd+VRfAo?=
 =?us-ascii?Q?cjdNZU4nUZpXuOPjUDIfZDk/+gGCgtLpI/XcENoJoavZGZpyT5bgx/w9zze+?=
 =?us-ascii?Q?w/B76Z3Fr6oiLlLtzl961gtoPDnsccZIDP35zZtYC2fBi/BBw7ju3GQfq/8p?=
 =?us-ascii?Q?YqddUqU58941OJOEO14QxovnkUHnSBTOZuV7tF03ftA/mQ28Yqp5OOo1Jm0v?=
 =?us-ascii?Q?uR3quHWhPobQqyO0waQnMiYVHBbh3VWbNjCYda+SmKiwKpu4fTxp093xCVTv?=
 =?us-ascii?Q?vLdYCXqTNKNwLCoqeicN/wQSz6iI7vCKMkGEG9mtxYlqhM34LQAnF9tniH4e?=
 =?us-ascii?Q?49jsNS565U4kW+vHYyaizUNKpRAOOsu9TOKITSiUmyjoQhWAaCuasaVb/n3z?=
 =?us-ascii?Q?gb+PlAl9qTKgcuZv0pQ9ybhfGhhsMMUaOGdr3WVMYTgxSTQ+a6z0vdXk7XGa?=
 =?us-ascii?Q?+0o6uFpRHFT+b897EViKjIv/PRNspSXdO6DAWkw+OqDkmS37K98L6REeNyKK?=
 =?us-ascii?Q?J4O5mO9TvWuoRRzJYXxFbUVKhf0DKILoGlrb64vRY0tf3P1cKfcQdT08j8Fp?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B0687EBAA0C32418F3173FC92093282@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z58fk5ePcWuOikK2YtjLo5MZ0KwIhVcDXW0UVglWFZNigP0WtVURIGt1krgUbJnw3JZxV17nj5LtwzHQlOFtQlYm8WnaFbiUzSD2w7lmct2GPVjcorzK7gPtdNwRF7ShKQbAvc8dK+IQefhI3JEruc4GYLFVsB+AOF4uQGCEHvqkpRWVtulV2w4wzwb6aLcs+dNHHacPT/BUrpNswgpBEMOwJ+jiLt+nFjDihmZ+rjZWkErz5F0jF333YY/Icc8DhZwnrrR51tnANTCOqkeuu7RLmxUzR0GC+kX1yB0QI0fy2HguJ9AzNsSxfXLcLu6IskdvOIJG05ORGxQG4AaG/t3WrSsKXqiBv4yrFWoDQjEaunNq1bqw3cL4FY7Wza5gAS2rOnzb247qjEVB4IsoEndZBbeQkIeCsxGaIyD24EN19Qvu85+5S+vUVrzgS5Gl9spBfqzGWzTzhNKRdGFIcjHTPmBVyXzexvrKp9NSzGR5FwJhy6Klu9AhmlBf4rvg5DuRIU0ABu4zRCwDsFuPlXsud9l3DZqVqAv9hhP6i3F98deUX92UYCoZxuJFRgyrvCUVUM80NtXiTVr2UgHHWYPMmwsVuu7T8N9Q1ukd1vhmbwL+zYqLWJ7RMryS+BZD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7e51b9-57b1-4cf2-e1b0-08ddf66bbada
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 04:27:51.3122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /B36xdM+vcNJQM9b0aKVjIFzT4htrqJrzFqAdwbnnnjAU3TnRORtBqkiqBrjFQaywanZVijZotcDK2YBcf1bt9z1AQ6M7fvX2ZkcXlIDtIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8323

On Sep 12, 2025 / 09:57, John Garry wrote:
> md/002 only tests SCSI via scsi_debug.
>=20
> It is also useful to test NVMe, so add a specific test for that.
>=20
> The results for 002 and 003 should be the same, so link them.
>=20
> _md_atomics_test requires 4x devices with atomics support, so check for
> that.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
[...]
> diff --git a/tests/md/003 b/tests/md/003
> new file mode 100755
> index 0000000..8128f8d
> --- /dev/null
> +++ b/tests/md/003
> @@ -0,0 +1,51 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Oracle and/or its affiliates
> +#
> +# Test NMVe Atomic Writes with MD devices
> +
> +. tests/nvme/rc

It is not recommended to introduce dependencies across tests/* groups. If y=
ou
need some nvme related helper functions, they should be placed not in
tests/nvme/rc but in common/nvme.

IIUC, tests/nvme/rc is required to call _nvme_requries() in requries(), but=
 I
think _nvme_requires() is too much for this test case. I gueess it is enoug=
h to
call _require_test_dev_is_nvme() from device_requires() in md/003. To do th=
at, I
suggest to add another preparation patch which moves _require_test_dev_is_n=
vme()
from tests/nvme/rc to common/nvme. (This comment assumes the test_device_ar=
ray()
support series.)

> +. common/xfs
> +
> +DESCRIPTION=3D"test md atomic writes for NVMe drives"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +}
> +
> +test() {
> +	local ns
> +	local testdev_count=3D0
> +	declare -A NVME_TEST_DEVS
> +	declare -A NVME_TEST_DEVS_NAME
> +	declare -A NVME_TEST_DEVS_SYSFS
> +
> +	echo "Running md_atomics_test"
> +
> +	for i in "${!TEST_DEV_SYSFS_DIRS[@]}"; do
> +		TEST_DEV=3D${TEST_DEV_SYSFS_DIRS[$i]}
> +		if readlink -f "$TEST_DEV" | grep -q nvme; then

If _require_test_dev_is_nvme() is called from device_requires(), the check
above will not be required.

> +			NVME_TEST_DEVS["$testdev_count"]=3D"$i";
> +			NVME_TEST_DEVS_SYSFS["$testdev_count"]=3D"$TEST_DEV";
> +			NVME_TEST_DEVS_NAME["$testdev_count"]=3D"$(awk '{print substr($1,6)  =
 }' <<< $i)"
> +			let testdev_count=3Dtestdev_count+1;
> +		fi
> +	done
> +
> +	for ((i =3D 0; i < ${#NVME_TEST_DEVS[@]}; ++i)); do
> +		TEST_DEV_SYSFS=3D"${NVME_TEST_DEVS_SYSFS[$i]}"
> +		TEST_DEV=3D"${NVME_TEST_DEVS[$i]}"
> +		_require_device_support_atomic_writes
> +	done
> +
> +	if [[ $testdev_count -lt 4 ]]; then
> +		SKIP_REASONS+=3D("requires at least 4 NVMe devices")
> +		return 1
> +	fi
> +
> +	_md_atomics_test "${NVME_TEST_DEVS_NAME[0]}" "${NVME_TEST_DEVS_NAME[1]}=
" \
> +			"${NVME_TEST_DEVS_NAME[2]}" "${NVME_TEST_DEVS_NAME[3]}"
> +
> +	echo "Test complete"
> +}=
