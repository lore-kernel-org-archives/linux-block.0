Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA015C15F
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743753818; cv=fail; b=aLOCFumQm+XeZPyHY/L1AX/fYY0MuuB12V606kH+JcFd4B0c/Clugw14JbLCSFrb6kjoNAY6J+jR6ZWlcUtnQQk2pdYI0c4eFOuVQjvPfZdLRwA9t+b4YCTKDmT8nTKLz3GVFRRVgZLzYFSpG9xji9T9ytnyhEyzpSzv2ztBolc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743753818; c=relaxed/simple;
	bh=5qNbpwOobi32T/usqKSj9TJCyKca1FJaSef2J1rkJEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WC9wdELnV/XYhMJdO5x3uuvAyc5g65f+BiDDd47XJH4v08Artn9frBBj5vZy5e1Qj9lsA7hdS3+jqeqFiC1qPzDb9VI5ZFBzQkZx6r7TUcfI0BhvRHjB7OQAFsW5Bwpb1cjXKrCo3AzcYGwaxH1e51FrjUmt5xAfD7XPsLQpJbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JC0E3MAt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=po7uF+9/; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JC0E3MAt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="po7uF+9/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743753816; x=1775289816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5qNbpwOobi32T/usqKSj9TJCyKca1FJaSef2J1rkJEI=;
  b=JC0E3MAtCsy1TcxcZKcZ6hKm3OKz87zNautfTJltB5JPnUy+3Q4LDfXO
   PZcNUKHJRXbl3sXA8JRc7p72kZyP+DQq6B+J3SG/fqKy6W9lgp0vsPLq6
   SvRl8ROZiP1nGaS+/IY20HBEzTA/7xgs+nLFe+JoO2rFU8xjbdfIfN9Db
   FW/Ls6sEMzmim7Oh8syhhXuTDvGHmTac5nNqBFQbgShMiRaqT2n++GlmX
   QtibkIEA2WagWyGT1Ba67BtBxc7V4IIL1AFXdoPcWVX7T3DB2SnGprdIt
   dfI7djZI1GXxvbDaQ8S+zgZt8ywhVf53wYlV8R/JiP9kdtAXtieb49D4b
   Q==;
X-CSE-ConnectionGUID: Pm0sIZJwSDepiEd8uuWe4w==
X-CSE-MsgGUID: kaDyUOd/Suq+n2Lljih62A==
X-IronPort-AV: E=Sophos;i="6.15,187,1739808000"; 
   d="scan'208";a="74575110"
Received: from mail-northcentralusazlp17013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.58])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2025 16:03:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgYLEhnM14FPRpRaKAcuJhSchjw7z65MjpLxIM33emgXtaOKTR1ZAL8JBlWlNE/fEUyfmntkelDLUDr+m7jztc4w9/8P3Fsi0ApywloCGtE/AQPNpdCxbao3XxyrKR/J9ZvM7FcSZvl91B80qsF8+dwI/MEjEGEQ/Spvs/NHBrUAb1KByZVOm9RARXN2Vjk0Nhs+1clGiPJbCD81OKqNGF6QREFSwON3Evl1LieWM3XCUMlTmBzdbj9kfh1aXupUz8aYiUWMn7STMXJQz7zTXUNcW8M2DJKGp2GmPwwbruLHkojlhYmQYefIgXIYUHfshMtKwjlZ61k1Tyi6Zu2wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqIMnJnlGDCbP3eKuJlseRh9R2ELnn5tu/exjlxN+XY=;
 b=JpNSGOP5AQnLS9UWVIakPXoIIEUMTtYxa5cUOV4rOvxcgxMDLhHL7Lxe/Yina4C3s+m3kOQlTnevoiBeAil7QuC7WOKTDNhkXjBReW+e0aYBTlzLn2R5lHq5zo4rKox+2myNE9qOnafD7kRynLeNsQ8cL5z2lWiNHnmvFSEbkfd67F7epSs8IfZgN+bTkyM8ugUZ5AX6u08Zx1HHKdiyYXqPbujnZu3Dtm3PVdpM4yueJoGq744io7UUFgdtoaMQLKtrnYuJcOnjO/bb4AkKy7hcj1CfCFOlhQiXnV6KvNMaYo1RuVnsVEAD4a+wMHdl+eNDz4cWXpCeK2qQyIR52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqIMnJnlGDCbP3eKuJlseRh9R2ELnn5tu/exjlxN+XY=;
 b=po7uF+9/anauloFd93pX/VOzrn+kXUKJWGBLh/4X0yvveq2M1YpHxne/RkPpJxlHhD8EbxcN6INfBa/RjwawyAhr5+uWxGiUvGaCLJVGBqoDlvKFx9Ge0YfuU4DiygZCX2VZabyjIwASorybBBJCa3WdiFLyqKaV4kSgrTKG/LA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8025.namprd04.prod.outlook.com (2603:10b6:208:344::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 4 Apr
 2025 08:03:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Fri, 4 Apr 2025
 08:03:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/3] common/nvme: add debug nvmet path variable
Thread-Topic: [PATCH blktests 1/3] common/nvme: add debug nvmet path variable
Thread-Index: AQHbl/IEQSpI/MfovkC2+uPnulyTvLOTQDkA
Date: Fri, 4 Apr 2025 08:03:33 +0000
Message-ID: <z6rsq3dla6hefacworxfugmb5mzw4xuqr63a5qnfaigzmceieu@gqdsgiwsr262>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-1-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-1-01e01142cf2b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8025:EE_
x-ms-office365-filtering-correlation-id: 42a37842-721d-4e83-9c2c-08dd734f3218
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3w26qBvpU9Cj2SdBlEZvqNLmdEXjJpIN8Aq9Yp4nvVhx7dFdvFHwWhBik2b/?=
 =?us-ascii?Q?NpwD0qgRux8bsvxbOIX/sULVSQz0NHfeS0OCVaPrBJ4wWZ91Q8pTvbAvBU/a?=
 =?us-ascii?Q?VmcLs8fEutwAiZr6yUb7RvEqdtA0mtl8yitkVg4PduvmVwmD8xlE2einEnpk?=
 =?us-ascii?Q?aS/dTno0dOx+vF9QTaFpA9mR/UdkhKBKQp5ambrVy6w2i5uWT7OSXa/Hncm7?=
 =?us-ascii?Q?glmdIH9bJ/LYBDYb/bNAH2D0KH8XdKi+W9hdh2UJuDs40IvFtoAXL1wUFzwg?=
 =?us-ascii?Q?4lthpas0814rDd+6Un6J1I4Uatqt+soMxA6rqE10w5aijPdfHDjRTjPZwlPp?=
 =?us-ascii?Q?LaKEBb2XGfSWd+vXUXVH2nOVpXMun6ewJTo5fn08xyfj+RfD3Xga9VsFfl6Q?=
 =?us-ascii?Q?RNqrHlcY1ameuY6I5by5yvwcHsMKXjL3CeWeFrrnCVIaesBB5OSaHBkfZKpt?=
 =?us-ascii?Q?tOftBX1xaoNkfulM6KQ8A91ywTvCt+uQ3JQDIzWMSVvUlYjIc6v+v+s30iei?=
 =?us-ascii?Q?tThryKLu8f11ym9BnxNjIuXH45Lwd2WFB2aAiRxBUf+bN3Xvia0vlvMDZKRH?=
 =?us-ascii?Q?HK0YlCXuDon94GXeNpIZE7/rDTynZygIB3+urpDLgTsx0+1BP/4yI2WBJkvv?=
 =?us-ascii?Q?6UXuz27Y+FkoVvWappU6TFRTA1ipxxJ+85YYi8PkXQIbuEncmuEPwlbrw0c3?=
 =?us-ascii?Q?z/kvGBaZpA5nyxz5iRzkL+Mkat6VLGdFGjMwyrYDKtM/hWnl3T8Uz20LPsto?=
 =?us-ascii?Q?CGjztNtW0skvgDTVbUm9QfLHUdPOeDXWyLVWRzWOhE3CWEv7Ypw/sdxrXu2A?=
 =?us-ascii?Q?Hs7PaVB1BXrQSWwVuKUGAhrSk4E+/9Z8GLFC33NgJ4+St/jmiQ47XdurrUxA?=
 =?us-ascii?Q?AV16+mUL9sHjBdua32R8WZZQyN1ExQAUKCN05LE/Iy2AEVL9G0IdZWcznA9S?=
 =?us-ascii?Q?2XpwbMjvfay8DEK3p3ymCKVD3c76ZdeIRbsN6iWmjcD9xpn8+oYkcRRZ/I/0?=
 =?us-ascii?Q?YncIHzrSp8fpTWn/uYoQnjR6wTbZH9wyRABb2ZZT61kBlSfRVomP3bdTlGD6?=
 =?us-ascii?Q?naiH3xghA52dbvlR7QYV9+dHs8rgoGE44EIRCNJKagS2WiYxaqPhbsSDDmRD?=
 =?us-ascii?Q?+1bcVmTYjY00o1kQlzp4ftjt8Q3VgdV3JnkI5Y3WHT7O5PfukVYC3jcUkUTR?=
 =?us-ascii?Q?LXR5tOAGEsLmmP1d2p1UOb5Ide7ZvMal0yWFCKu0PbaSSeQw06P0JfAeXo8k?=
 =?us-ascii?Q?XTKBrqxU2tHwtBaKjPwO6xhLEZlaK6KLqJLDx7MGkzwzRYmdjZDnEb6GGp74?=
 =?us-ascii?Q?KQ4rJCh/n36ZRqnECJNgWU6hudEaHGtMCApMibyQkzi2aNHg3IB6gcKL4ym0?=
 =?us-ascii?Q?N5ptaMsKzGZirit4yFevqmHrrpTzpAwzkj7JLSObmr3W8lZJ0q03gk/F0Izy?=
 =?us-ascii?Q?rDNM0RC+QOlQHObj1AhfeWQSOjVDcdh8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?689wtNpcEgmdpNzUPLCjA0DNRjW0IJqmWww6rjNJ4z8N1BfPNm8hHM5v4nP7?=
 =?us-ascii?Q?gfp2xlCEpAsFxom2cJQeG6K/ZCcOMG9xTyq2wxFqiVMUqL7gp7seLrg+42Ak?=
 =?us-ascii?Q?NfFB/i/ZriRRlutAUXG2iN8tcu1SzNeLjuS5ZMhXxktb58VoIdYiYS0XIXi0?=
 =?us-ascii?Q?DQDTt10a01/9uOIA3obLOBqnxHI8rNOHVcEh09LEi2n9RVapYnDpvTxCZRcU?=
 =?us-ascii?Q?fCPIqpaOeTJqgdtxvcn76mSU2Os4WQayZK23NaCYPh+fIA6nyt8Bqn2pe3ko?=
 =?us-ascii?Q?Nd7HRHh+nn777/1ZjB68dnPQBWc5PRCl+ve8OIxYxb5KfRzLjPmR3unoQJ3+?=
 =?us-ascii?Q?QGgyVdaeGVo/mm3FqYD9GJltwanlT/rMdRhf7qciy5vJ7Sy5Iz6YPGXxN13Z?=
 =?us-ascii?Q?OwDHA2AmTYohZIpPZUVilrrKsJq7cOscWy7s/cXJK/TJ5RXCwBbnoEB4XTKY?=
 =?us-ascii?Q?/w/H9pXk7rcedA16dsj9Uiuu7ZFRiJMXsZ9874jkXVGos3GtSpwubvYDKJ9K?=
 =?us-ascii?Q?KpunWrFw8QzPS08bUD/S9oBbkFkNMh5Kcwb6Q3/wjij1kcw8XfYFFdYIsaz0?=
 =?us-ascii?Q?LnZlETYhQygf/8Y3oatnpju/F8QULe6Z1Zv183RzwIywWGcSeC/2mA58E+mk?=
 =?us-ascii?Q?oWj8BiScJ7c+tSX0Z/nNeouZcmKyH740vPBXHzPXSUiX8X4NL3EygBzFu+5Y?=
 =?us-ascii?Q?Ozd4uUfs+DRKxJaVLAd4TxFLH3CbXLu1x3nyyQ5pIpP+oVtm/ya1jmOKaO8k?=
 =?us-ascii?Q?lS8hMXi7StU/GgK7kLKZV6cb7smhjPvWqSfsZePaeGCrv38GPvAxRUbE2wH6?=
 =?us-ascii?Q?knNWW4QpKA5Kdd4GZpd2OjNxNsGlBBj9dhNUVSPrB0LYol0hCn6drG0yD2ke?=
 =?us-ascii?Q?k7Pt9nKTPeEpY5tQbyl2ZGlBpY7G/rXtTNJHu83Klg6lz/ugLT6NQtBqRFmW?=
 =?us-ascii?Q?tOHCWJKL5a4gGDVJq2b98rTjY1pd96QI6osC/66lvmCV6T+LzPdMBMruTHmn?=
 =?us-ascii?Q?bqquOH4DE1jBW6xkNurXyPLOiKKmUBRKTPFZGahrYskt3lEPNgx4EjccgZYb?=
 =?us-ascii?Q?llWHEc2+DolcNdQq1ND/yUGRqB14GSrL0y0KD2tNP0qKOhHr8vUoeKY6/SsK?=
 =?us-ascii?Q?/RPqmpQT6jEm9euQCqboeqNqQIzAQbtsrUEq9FiwIcJzJRFAzjTzIOxTPqI9?=
 =?us-ascii?Q?REy8aDY6WH2YER2EBBYTABjBUvFFiBccv/IaVmj2uTNgMU0emodGBF6WdeV0?=
 =?us-ascii?Q?J3pUOW7pgboazzDgGPA7Rf20fWV5X5EJEkulGy1Ttpa6vlD8Lz3LUr8zUYS1?=
 =?us-ascii?Q?arYeL5ooRVD1IAqcAkw2gWyq30iH4N5/Aiix2IvvMdgGASyRK4FTAkZ5toA9?=
 =?us-ascii?Q?gqNdqFPHJxaCjzEZxxoZl1M1Tna/E6HRmevkSouDsgoSW08+v1xNT2d7hXtO?=
 =?us-ascii?Q?+UyPBZnzWXTi2AopmoE+9R6ksWHhCanXcVYxToizbj4DreBzU/WicFXdWWT4?=
 =?us-ascii?Q?k6uzYUUW65HIXmIkpFjD/z5cmnTNF6RTK0yf/VhcN+PhVgGa2x/HStlqEqzN?=
 =?us-ascii?Q?GMjQw95/Wis29urmAAAvftE6FG5byIXxjYL4HN8dq31QFaRJ4z2x4eKeRL+2?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <905A9C30190B654E9407350952C2BDB7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rSlYc89UQeIdYyEJOBgwktdvp1Fzdelc0RkdVvyiv/3s/h9TUerroN+P7k6zU31qW46bhqHawJnCE5MeIqiz2zGPHCaLBQ+V5jV8NXGPcFcIFrHOGpMw9x5XyJX8gNZFe4iu2LthuxXibXbdxDVMg9AsCi2OyTF7BhcwzcSRcB6u+PiJovjvtWZqBZqbvpurzz/RZn0Pha0YND0jrL0TzaACtFddfnnYjpO1F/Sn7Fip0wp6UEG5OyCkL8+rtTNzWmlKKEHhk8n2Snr6p/JDMq0KQE9KlZFv2kIq0Jc2MDZ2qyIkCkoELKzXwZEQFLVqqr1jT0gLU8koxbl+BQUXB+2vAuXLTCSZG6T28w1zePmGnMUxwLiHNnsfRZttZrPnd5GvokjKHGGg/qcp0WxANMcLNC4cjRH1P9Hm+Fzw8JJq0FuVxJjRv2sCFzOD9EIK/0gEXIklwF+Idiaus/oUXZ06/VXvcUgtknJg5FBVFGLhbt0Cu7RFRWyFrBxgxrmytBxRry3aeDeNzPAX8N606L5quMORrJRuoN9UxCQcCBnq8QhRp+9RkblmdyvAjgGmSQtRaTlzH7dQLg56abB0ph2KcYwywap5yyeRFVgr+IoHayq6lbWxASu7zj0cf3kb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a37842-721d-4e83-9c2c-08dd734f3218
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 08:03:33.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+yLxn1v7FTocXAHDplhJxQ2vRFGcLyXlSGzH7iCQ8DYVuB95bVoduq86Ov0f7O2CDx9BWVIQ4yRntCHo/53oYRf+sF0zKMo6wqwdBSD95w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8025

On Mar 18, 2025 / 11:38, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  common/nvme | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/common/nvme b/common/nvme
> index 3761329d39e3763136f60a4751ad15de347f6e9b..a3176ecff2e5fbc0fbe09460c=
21e9f50c68d3bce 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -26,6 +26,7 @@ nvmet_blkdev_type=3D${nvmet_blkdev_type:-"device"}
>  NVMET_BLKDEV_TYPES=3D${NVMET_BLKDEV_TYPES:-"device file"}
>  nvme_target_control=3D"${NVME_TARGET_CONTROL:-}"
>  NVMET_CFS=3D"/sys/kernel/config/nvmet/"
> +NVMET_DFS=3D"/sys/kernel/debug/nvmet/"

This causes the shellcheck warning SC2034.

  common/nvme:29:1: warning: NVMET_DFS appears unused. Verify use (or expor=
t if used externally). [SC2034]

I suggest to annotate "# shellcheck disable=3DSC2034" above the added line.=
