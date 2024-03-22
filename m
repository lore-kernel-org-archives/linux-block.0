Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1210A35
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099604; cv=fail; b=HLVgdqMOH40VbPBPTwJzLj6oli2b59OAae1fOfN9RA2ETclLImB1oMqm228hQGzWAmbj3uU5T569dyIiYMUebS+qPCgqS/ndPeNBmulJ7+7v5/1/Cpv8rdKVh8OLULALwXI4mJwDbeKzGGycvBIehTrG+TPzAhrgky8MIM9loxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099604; c=relaxed/simple;
	bh=onYRb1GeyNDItzbVxYzm5P/vjl0kiGRqxmMliMJ60i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8hfjRufzyIxDqw0axUPWGDKpUFMtGnpPcrh7MNl1oxPUv4sNmdZbnpH26ScFPu5a8sGYm/nmL0J7jf/BZCdZIFBpdKwkm0u4l6m4xuNX38vrfRuG3nPHPx1bXtA/MsGR8+TrryTW/Ucs/5Jmiu3uW0TaFGq8x8I+zcbQWELon0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=APAGzUQW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UCDy4QBo; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="APAGzUQW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UCDy4QBo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711099602; x=1742635602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=onYRb1GeyNDItzbVxYzm5P/vjl0kiGRqxmMliMJ60i0=;
  b=APAGzUQWuDzdEZXFxlEAPS2f2jdVfWR8/DsTyr2mQnmlksr/AuLH0D95
   W/eYJrlfnOc5m5TZ3eJBGtc5wTbgRLfSqG91A3naNf8TeVhHauSKi1f+N
   YBWLVU61ceEivkUeyIQ6n9olN93QJ8uVRqtSCMVGVczh6DAFANROm4FDC
   7yopyr+jEatgmYl5HmcIPzyQoe39q0mOkbfBrbVGao1/zPnbd4W7LfZMC
   FLBhD8zs/1TSs28+SHIJiZAwR5K5xgfOUfZsmT2ni/wlcamtn04mko6er
   60cv1UaobqBz5NkSu70Xh/t1elskyEuzzeGrKn01yjwONndBFf1KWddG6
   g==;
X-CSE-ConnectionGUID: tA4j9jnbSbSUaXC3bUO/hQ==
X-CSE-MsgGUID: 0eCEFMJLQzGwGTWNl4VTdA==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="12233547"
Received: from mail-westus2azlp17014040.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:26:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8IiMyKXQFiMveG/vt7M87WaosZdOFckp+aUO++gJh8IIUfB78Z7uW5R/biSQuMuG0J4iJaOTAMWPV6ToFsl4NvzZYiyKC0hQV70NtRw1lgQoEfEgQgODE7HL+z7sJz8PECcKw9YCM19iI642TWGO8mQLDX3LBciW3XkBN6YkxiU6MCJ2eZ/1yrbQxvtFUYrc0KWbAJp/q9f2n4g4SCHw1ozK5qR2eXKD6yFWy6d68NY/EZcPxmBYhGy6A1AoVcagwe7ufgZR98D4re2QaVOv31CPVaUoeCNIuO7RCiIPfOdS7ncWI997sA8/GF5tHtFs1jYcfQU9VDcl/BuoHTgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onYRb1GeyNDItzbVxYzm5P/vjl0kiGRqxmMliMJ60i0=;
 b=dfHf9ZEUPf33OZmBV97RxSTJKSlP3Famo96tx+YqH2/rUQ61SC6VuMmUhKQ3JevWwNcLRYe9pKbbWqSYfr+CYEI3wQgNscOelueSiLN21tUzAKKgB7CxIiM+WS9VeK3Yyo8DsG0/9oo0lGv7lYAn4kGrmI/eEjzqR8j+k8RRghhVhUP+Seo+J5CcfYyY74tY1cgA7eo1JEo6ceZd7ZliUA5xA8S97nItA7jaDpi6frBzOhxq3npLvDoFh9JwgLB50bckmwvRMtMHsNJoT6Jqm/JiOxMtpkUQLHhrQBsFAj4EE9grXmvnzrZHH2auoNLq03ZRON4ROhc0Bog102Q41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onYRb1GeyNDItzbVxYzm5P/vjl0kiGRqxmMliMJ60i0=;
 b=UCDy4QBoFoCjtStTVr6fyxYrfijL4UYBOG6/jc7gySwJrkQRpK2gYs0f+mE97OYCzibHwsfAmU4ZDZhfTl8UC9l4vbbu84PnscojldKakIKcODq/4g/Ia5Ee5qWrwE8ZqMalBShlD9Wn6AF88lTkj2MuEYcPLG+uTLYGFPTZ310=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7278.namprd04.prod.outlook.com (2603:10b6:a03:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.37; Fri, 22 Mar
 2024 09:26:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:26:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 15/18] nvme: drop default subsysnqn argument
 from _nvme_{connect|disconnect}_subsys
Thread-Topic: [PATCH blktests v1 15/18] nvme: drop default subsysnqn argument
 from _nvme_{connect|disconnect}_subsys
Thread-Index: AQHae3TU0L/tuTNQPEGWH1c6IGIr4bFDfyMA
Date: Fri, 22 Mar 2024 09:26:33 +0000
Message-ID: <h3k2jea3ahtokpb434la6qznhkug32skcxe7t3m6h7ewb2xj3q@igz73eacj3xo>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-16-dwagner@suse.de>
In-Reply-To: <20240321094727.6503-16-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7278:EE_
x-ms-office365-filtering-correlation-id: 5104cc9f-1a91-45da-112b-08dc4a522a70
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9cQ39TtAd0tXmDBKCVdTXT+gjFr7uZ4BVBv4Y75oyf1YjEnJ41+ELbJ8xqYv3eB3LcsuKLnZ9w4DeWnuMI1XL+/kBUneUifGYSMpqcehC9Tdsxj7aTd9LJ3dljO0xTykoKkF3oZSfLRSJ2Kv4EXR0ibVvvGXCk7rX/RU+aO9ozQW8dlY9nw9zm3NfiMPcxAX8NBufjqUaI55WeQfFEyC86TNFaAyla1PYV3WMiaUtCHq9V7KKBCZGda9DNRblt67dtWUViHHD1BUY7D5c9TaCPM0pvZ3nwDNt4FokT065eZunPbFW00Suur5UFmkG6x55T5waj/3qeMOXFJLx3ZksNJv1pK981hIfBe2MCBaUAmbaEGjJFKoMOIivLgA3iROHqYN+BTWBbkyZcG598/qdGU5ExKbduzDSs7ro69a9QhzGw9eeqJEYZ0pzPAjeuQQoBwQKjo5NnDFWftERg884QIflqgTm9s4sqa3o7nXUokwGVODEj86nMarsengi820vCMB4waYjFf/4TcRK8OFIzjsyZkPsU0vvCzc/4yezmMaNgG8UsinRvM5pnv/dvbthLz7R/geGC3SwFJp71U2ioBjR8NoS2QMXPBijvRB0lxx+4ZTZZmyTP7cT4kQxz0ukGSn1J08q/esSxSjXeY+CaocXAQnhNQE68mVRLnTKMVfhW2Uv+T++vJIJICVfyFR3NKeYOouCMiYWpYxsKDmTNJLEg1vcF1OIotu/90QyiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4zTW5ayPArXgPlBtd16R/TktHRMYKvzmCgD1hhdvAF91IYm+XMpmk7Kzvwvy?=
 =?us-ascii?Q?zHPal/df/ZwQ+TvnDbZBbhw2qKWT1nsMb2LCoLFUftUClw5Oo2OGyf5SZpXB?=
 =?us-ascii?Q?GNA+reHnTSma6meFeuB5ajTe1dBaG+WVmZsL4wuSJ1lj97EFysd8H3h8A+vS?=
 =?us-ascii?Q?Q7ZfSU9VSJSRVNNOkldOH9BJ4VeEwDms8OBPgag1OkJEfMop+CnAkpLULwRv?=
 =?us-ascii?Q?FGc2QgaVNwbVvIDUwhB32d7DcNmNLy+B+mwXyoPFi7hEEyGDKP3UZzMUJOcR?=
 =?us-ascii?Q?K4vOXDlGmbN7fQPnaSE5ZoX+mcLk2VLoroBOjTLCkM9Jc2qTx6NgHroLvgCt?=
 =?us-ascii?Q?Jj5pM7Lwe+opvjJeh334NJdznqkX7801Pi3XqNdsBBMvWdaXpINEjNS4eiNe?=
 =?us-ascii?Q?zOjFcv7ccDz9EGNPgklqiv4GU9tw3CRDCrGaGuTgR+SeOSkIT08qZi1RzE18?=
 =?us-ascii?Q?u/S4WK/mZeCrxXY3SJ56mJp3hLuqdDdU0Ux0t2pLyJeux2qXBGLQC6A1/4yF?=
 =?us-ascii?Q?mYW3T+bqGBHBDuH7X0EcNm4dcy3YFNL5dV/o326AEN5wZJZxhdlAHggU5ov3?=
 =?us-ascii?Q?U3x85/eK9klNv55Ghg5uYd1vAq5MIRlTXlbVcjWnzybnf/AlO406nMziDb4f?=
 =?us-ascii?Q?B1N0KP0wJjKLlwJRqXj18LiSCQ9Q7S62gsbs7Mvc4ukpl33J0owbHCbEfEyT?=
 =?us-ascii?Q?gbhFQTICohC+2HImKrUj3s42bTqFRyoBAzLuz60K75t4JTkNPhPdyn+b/zdD?=
 =?us-ascii?Q?Uqp8sUCDb5hiQm0MLHEY2rBs8VShHngEgpeP7PObL74sEXFUg2KB6HKu9iNS?=
 =?us-ascii?Q?zsgOEQTWXVQzIVb2ZaR+qQsn5BF6GMkd7NhpR9yIL+fW3P9VGDBPtfFqcwxp?=
 =?us-ascii?Q?YxyYqWuHTxs3rTuUWwJt52fveOsCuiNQAxl+tnZrKlmIgJwyriFShlkU+YQf?=
 =?us-ascii?Q?qodWwVrpFa7AeklRgvChhJ4wwAQZ1UzeOZT5K8T3X+zNfZL15rp7o+3WpuMo?=
 =?us-ascii?Q?xNbNAjYdsNZzXze89LRhgVhqBvvzc2IsvN22xFXBXgkGDV9xpfyVpEE64eZe?=
 =?us-ascii?Q?o3mdz2dLuweumxagd/YdXE9wC/WLd8c8rQ8zF+gNIqd3YcCc4WxpstAEMXiD?=
 =?us-ascii?Q?oq2vTT62jTtCwX5T+jJpqANwwZDH8Oad2qPU0aiJicn5h7DY1xakG9vQkRzV?=
 =?us-ascii?Q?m++H3jfHz8Yn4Kbok3jO9iU2szVhHKBbqTHrr1HbGuAQPrui5b6YRKEQX5g8?=
 =?us-ascii?Q?T7lYH/e3vym1hALHWePjc8kMvnQ8bpJfvpIL9MGEbjmBMRXZS4DB6R4uWZVk?=
 =?us-ascii?Q?gJqqm7yj03OKDLlzwIBiILVonMm6jYgSGtmk8Hi1cOEEcpzqzoP1TXq5jvzs?=
 =?us-ascii?Q?EFjFiLTgbp9Tif5/n69fIRpRIrHxVTpQpfij3giI4Waxl/T/ii91XrEzevWA?=
 =?us-ascii?Q?jcS4v7JAy8GO3Oemi+rws6rwhfMH/g9UDBDBcBKjfRBR+gDgItCWYwq+A29s?=
 =?us-ascii?Q?cP+364jsVTpbrvFEQamXl/ZUzL33kha3qDoJY5JzjiTCOefvV9h7cS3E/ram?=
 =?us-ascii?Q?xQgbIa9vnxofInhP+KjKCuf8336QftdW18JK84AnPgjVtscfFqHelNE63u5Y?=
 =?us-ascii?Q?+M2yq4bchF7AZu5BGNAqw9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCB7C85554D120408A6F045CAC8683FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hp/OSYWF1zWNld5wqlU7fB/lsi1nW0YxO0oGS83aftpwFQPsFZiatVmaNUuro6UAlMWAhEZYALMFVR07Bh9GTaR7DTRWswBrYkSxc/mFSECI3xV+zeh7fzADGWqiTabRKsk6K2hFZv91uTlv06Ts6q6ULOfoYNq4K6qP3NvGI1YRkhiRSkQn4mhgImPtOIwtl7byDteG+Mt1ZacuniNd4BDrUFgxAkA9nO6p3Gl+73hJN8LY+An9tNFaSuZXZosrGcCoIcSTKLWpWHPjW6YGUC3ThrjRJDrrhOAJWj5FmrCQvhjeGLglxuHxc5sKhsu1mZ4HAbwwTWz3CpcmJpLZv9FEc58ymj+vSfBajFzBgbJAWmxIVCdOo9mrR/GWj8009RKqvLGSiRfWfJKhGEO+Xy+Z64nhcZqhW0F+Dw17QWDtNTQPdLvGr+6q7ehp0+OKlQcv1HKa3l7UOLtF7Xs0ZJtmUz8F2Gpd6V9l2pBToaiVw1SNrD8GKET2TyWzeRhxBcZlGFo3BonzrFdIG7N71ZryndrhO9uT6UQQnHHXl/UW7rBtDSuFKjt1/y8xqr29oBHmPhrQIepNqYEAX3dwoOEEG1N2Ps7X6lh3NqOIj0rHNmgYLAE8Fe436CUh7CqQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5104cc9f-1a91-45da-112b-08dc4a522a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:26:33.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcdSrG9iSwAiXlOgexkMbjOOhFCsduDSzaJi4F9Re4HaDLyZRdtDkiBinSUi7aG2I0KTq7P7JTuYcWjHTkbidaWsaLYsMRQYsTyoCc2fneY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7278

On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> Remove the last positional argument for _nvme_connect_subsys which most
> test pass in the default subsysnqn anyway. There is little point in
> cluttering all the test textual noise.

Same comment as the previous patch. One _nvme_connect_subsys() call in
nvme/rc looks missing the modification.=
