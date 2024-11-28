Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C81322B
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768516; cv=fail; b=ILVIcH0Lr53vane4bV6fc6k+ZO5sCodl3yIj6NE/emEIhNpwEZ/RHNmCtjnXRxIo47fomVSKK8oTqSDIOP+ghr5S1xA2843T2sMPhrferCItux2ZQ96143r4seL0jr8LMnqib8Gi/oyY0IC61yVSzQpSWGbR3YbafpC3NbqIrZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768516; c=relaxed/simple;
	bh=teRsDFRX6RSwaWE+Q6Ml/C4KHltGa//2QZx5PW/8o6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jdr10jEcvu0/Ii8R7TCYdy/URg6AJQzFlySz1k1Mxa3ykhQ0jZ3J7MHb/elrBj+4orpGM3lZF0SX8P1CQMA+1vNbVxVoeeg0m0v+yzLn9bMns+GKFkKFft/l4vh+hszMXnbCsYIQLOo8rrcJfYKl5tt9aipLnyWSjKNfcf5H6HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oNpZdnoP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZfyUGvmi; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oNpZdnoP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZfyUGvmi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732768514; x=1764304514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=teRsDFRX6RSwaWE+Q6Ml/C4KHltGa//2QZx5PW/8o6I=;
  b=oNpZdnoP+O4kJeryKJDbAVk0EM4LNBOgLlSA74ZxScz0um5ZJi+Bi6dM
   sfChMFT/+0FPH5yBiSHd5KTNk2Bif1062Qlr2UyjdKn5jZvxhVMtPuUHX
   Bcdy1a6DVgKqsEZd7G8GyxJ/YImVypX00q+Mndo2L9dyz5W8f6AREQCqu
   3dWPRa4qOe410K7S0MvZI5tQxiVybxdFG8OIKz6aveCmOApG8ZDKF0Tto
   9M/H+Q1dhH6r/KwsvhKfbKAkSNHCFtfoqtrpBH5Rrqn/81KzZ2f2l3Hvf
   OyNlIwrmzjFQ7UCOCsPBVgegB8emtONELZzFXwXJkdV1pRQkx0G3fMJEh
   w==;
X-CSE-ConnectionGUID: Ex1V1/7MTbaX3tFeWa/JRQ==
X-CSE-MsgGUID: 5xoL4IidSfW9rbkB9FaXVA==
X-IronPort-AV: E=Sophos;i="6.12,191,1728921600"; 
   d="scan'208";a="32455657"
Received: from mail-mw2nam04lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2024 12:35:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jc02Jb/CS2UaZkIx7mRoUZalEszkoPnsEyljZ1PWbPtOAXKJCXfQBhJHR1WPD4F4ySBsW4BsgxAjZh1E00w7cWwK7KviQenJBC3Owv7G1iIEpdEJCkva8nVtooFaZ8lVVVqpknGfdlStYztmYOBRc4trEgEH/7Sk/jfheF/Nza+uZm2ZySBLm6884UX+Wzrwrm1jMk64aUlt21+5EZIoyXBi3H8F+u2xyiI3U3fSUsTIN/XNf72crEn8t5OwDEn1OFudrIpO+PPNt3tN9M2IveI8Mx1MEJ9OXcF2kKXKaiWNpTsFCJyfWn+IMIuPEXOQZej0HTOhryBLS3FHl4sr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocTEr1mRddmYBKpc5B+ilWchovsmH7M1e/YaKFeXUBo=;
 b=QnAlc5SKJo5ElZNKcap8oVJMhib8VhoWU3kyvIor1JQ7ZJxtd7IAMkbO4Ged1uNzTonblatyNiSPj9MKltbFs9W3CmrVRMYsFVwVK7urM94vDMWRTomYrz074B2LREyKcvhQ2GY/Q2aS28+KkxlfCWmF9XfLhBGAC34cfUHb1tLG+DjUkgGarSAER6xicPuyVgA6BsqP/6j/T9n8urdszL3eEEuZScp5bpbTqGe6NMRcFve1QhQtBVH9zUyUk22Ldq63bMclofi7mlijgJcFnIzjaGt4I4M6pTjP3j+guq7xzwHXTtpjxx9vK60lbfL7K38YFYDxc+/E+d2SDSNvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocTEr1mRddmYBKpc5B+ilWchovsmH7M1e/YaKFeXUBo=;
 b=ZfyUGvmiQR8dWKMX8BoQkGZp4qVeWUvhnZq6MTwjGTPxwn/JDTjoY2D4A8B/SKeN3iiOWOJIU4+bNQwOZKZq5JthwVTH6bdWbiuR66nW1DdTG+1ia/rU/nrnBwgm+72oM9lx5NuZx2FtVF87pABRUlFUR2XmPCCCz0HtLzzpUeU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6520.namprd04.prod.outlook.com (2603:10b6:a03:1c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 04:35:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 04:35:10 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Thread-Topic: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Thread-Index: AQHbP36KN6TETA+Mc0uPsWK/xFq83bLMHtEA
Date: Thu, 28 Nov 2024 04:35:09 +0000
Message-ID: <rtnz2aj5j7ptncbgbmiwdg2rzppxvi23nuaqujaf5t46raic3z@u46lv2t4wpqq>
References: <20241125211048.1694246-1-bvanassche@acm.org>
In-Reply-To: <20241125211048.1694246-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6520:EE_
x-ms-office365-filtering-correlation-id: 98f195ef-1f2e-44cc-7e2c-08dd0f660ae1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nYbfhCnUVgfIy/LGzqG3SbN/bxpqvSQZLBQXXRcXUth4N+bM7I4EiL42OYoH?=
 =?us-ascii?Q?KJYzB4pItkW06ynle/9zKZEt9K92iYs+Jc4XnyJak0nKtH63H71NvUfh4KL3?=
 =?us-ascii?Q?Dk8l5ghoxLBn5Vh/YWYp2Oy+HUCLYztq3WEMfzlxZOn3WpdZLSxA7GGaqgWr?=
 =?us-ascii?Q?PdvK2nmWVNpX4+bToGH7xgkkeHwfF9MSqZWj+c+IymtC+UFGaDni6G2L86v3?=
 =?us-ascii?Q?hCOgjxC6sD3173lgQUd4czsddvuRY2UnFakZbFK4xzdrDAAGzE+m4R+za3r4?=
 =?us-ascii?Q?6xKr3I3/YFqEwCWVl2asbr2Wg86EKLkcxX73JykvNo8s0UgOOPdtrz3oBPSt?=
 =?us-ascii?Q?iEpi9E/XQEHIaY1UUmLOljr7eAxhElX1glLvPF0kIWmFRqNh4tOFNT8gqoMr?=
 =?us-ascii?Q?MuGabivbfQNz/8BWCibOmkC2svozbuQ0/V0MxaaLonFcYOJ1NVontXEL4u43?=
 =?us-ascii?Q?3+GsDD9EnwtHaQIwhdcSTYj4+0g/b9ZhrlXIJlRdhp51UH+hXtKOa6ReavrS?=
 =?us-ascii?Q?5L/BlittIIwuLL/pwGCyN2iU+HeGh3WoNQBJB4OKZwNFRVAxHH3BscxzrFtP?=
 =?us-ascii?Q?fxiIL0cxL0UBYTbn5FoFCP3uKrDLYjCT8aglK8yEvKQXAaT/nSL/3XHbHYjG?=
 =?us-ascii?Q?5hNZofUfsNCtk3GF5Je0veXgK532+JptBWxkteQMZqtTyrdQvY9NVzaviCbo?=
 =?us-ascii?Q?FsKua6Xq/UnSDrnWb+jtT7WY0uw7B75WOFiH2KGAfhVvf8VGoYD6yO92Gg+V?=
 =?us-ascii?Q?TCeQebyxkrk/Plcc7K6bbMIbfl8XHZAoX3gkcNV+LqtL8qxJ9qrKUOTrilhK?=
 =?us-ascii?Q?hCikduDxyapB+0KpRph9jVDa/y40KkBlx/BVRq2RbO9CZYlO4OdbqgfkW0Xo?=
 =?us-ascii?Q?No7+ADFl6mnPaNl3vwCt+mV2DvVg+NhFHXG5JAubCYOkmXsl0z2eyWr4Sd7K?=
 =?us-ascii?Q?DLTxqkaWeHqyrIHgV1Su8Fh8XWBwA53GXWH0nxYesrxh3MSdpZrPxwBTBBmm?=
 =?us-ascii?Q?rgiQxsNWXVvMaIbiAWhqtJIS778UFBOjhNK8bpUt+t/Erx8aXS+BWykITk7U?=
 =?us-ascii?Q?n/ulCzB3vRjE3KfLZcyz5SIS+B+mCArrdEZXnoL8kQB3bhHuMMy/WkgllPAc?=
 =?us-ascii?Q?C2Htr3D/JoTZLHZLeFtYmzl10+emE2CKDnEiqJk6bl7P8BDJvatz9fyZ0lbr?=
 =?us-ascii?Q?YubKf3iS/n37mVh+glSRCsjEid6xttewcv9EkgYM94HEztRdlj4uKV0+0w0C?=
 =?us-ascii?Q?peFdJ0QXoaMCg5l8TGJk1nMop0Bi91pGe+kKezR9zO5WeY08MkzJUxf5r19R?=
 =?us-ascii?Q?y2h7r27oT2p1B/LrlEDqg9jla5azGd2P10kH9Nn5cMqZr7erRF/YdnET4rC7?=
 =?us-ascii?Q?i9BEMWRD+OAg4dlzb0jASbBK16qne2J7chQcvovplLkYkNq2CA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TaCuGHQyHNYNryRLDM+x/Hnc1bV1TgMDgA6zVMn5G7yeLGGShgULPeNyRFgu?=
 =?us-ascii?Q?XqPZRlLYRYVedzSdNQJ9GHxunqMYpVV6Xwc0onvIu8T5edog7k1M+ClnD2ep?=
 =?us-ascii?Q?qqvwgyusy5ZNdclbADbLJks6+y2+DZlz7UkG0NlbMbx3A6pdqcAL0DmFeSWF?=
 =?us-ascii?Q?jZIeFXF9WYSwcCK526od/gWT6H1OY1WjozNl8PBGlLpq72cSEkJdqA73BvQY?=
 =?us-ascii?Q?2RYyZmcfnEwnz4xZhOI3OCV5wn6xkc3OJqpYAyL9OOFdtVT2TikAdaEueumI?=
 =?us-ascii?Q?pQOvHCB0ScrOUGlBeOZrgfBMadZDslgDVOMcsMEqTf2WTAm8YwYGqcXECWtN?=
 =?us-ascii?Q?iasTcbTPOgrsTF7VO0Z/itPEhUcidfZDBRTkR+1US4ETARlvi9Fp4bBnoaRe?=
 =?us-ascii?Q?a7mRBnUXY4HKRXXW5olp7i+cPLMkTEWs9gJF+uX0TidSWeJ1qTo84zlahyE/?=
 =?us-ascii?Q?Bb5utcmUHqT1E5wXqC1Kayz2Gx/e/j0BQFnzYanF+4SmPkRaitQIlpNiDtdj?=
 =?us-ascii?Q?3OSm23hkxSkk5OK9xLLUXbZ3EAwhuyA7VbHgxuf1uh0Mief1vOM5nYHdzKB4?=
 =?us-ascii?Q?9k/jc/btrk7Q03v/2FZ7YDiiVstQkGccKT9Uun2SYkbxkIUPTsz/2yR7UlXy?=
 =?us-ascii?Q?RVt8JGBL3pMMCGcTrQN0LlLiqTJitw/VZ/Fljq3p+C+rcvqAm+dvSGYHqfth?=
 =?us-ascii?Q?+q9iafTUEhX2ej0g4wkSeUHU6V4QcDUS9irtXMRdeYVjCVON3luWlcXrIyKk?=
 =?us-ascii?Q?aI4DR/DcGe55eC3QXGOTwP7S94EbF/kSbyHZgpBF2wsSvg32MM+7yuhY6g1n?=
 =?us-ascii?Q?fDenBSybbdjbHW5x8YST25NBMzdmTqrYVVToXu0MaF6KJJY1TUU++IVbvf/8?=
 =?us-ascii?Q?rOi96aZc5Lv8mbcgywGkWTAisZj6okKtrb/F3R0kMm5EZj1jBBDFOKiktEZX?=
 =?us-ascii?Q?iHCgP6pvjtNbTU1urVjFtB3+hO5RbK/jeCy5pwRs5F6JQPy5qdI52BJ/YuVR?=
 =?us-ascii?Q?pq7/ssV8lpP5XvEqhiJ56fGd6vecAa5at7fj360xu6YHg7OcNmo4JRjBHAtn?=
 =?us-ascii?Q?klFXIFbQOYCjU/I3zHlFetV4ssdVGiv2Nvs5iCYRAQbH4hKbi42rU6o7cvFj?=
 =?us-ascii?Q?Hah1PIyF7R9bob1q3AnrrYzmQV1tyNTE0YQhM/0ZjbDgiIcY/OutMkQ8EvHt?=
 =?us-ascii?Q?rJXffpnncuTAPZdevMiAfGzqLjcr+70YmDx0gVgk3tZaNRxVhX2KDDj3iFPU?=
 =?us-ascii?Q?EDy520T0rIfMzgpL6PzHbCP+gS/8YpMc4Ipys6JbNA9B1tebjIc0cmHoc77z?=
 =?us-ascii?Q?6J5iEznbo/qxmjuU/0yilrP5vW0bzmiwN7Yv8h+AOWIOr0pz7O5q+MIYyw1g?=
 =?us-ascii?Q?SpxXpxvFHqRzwGDl9suD44+OYveEb9Eebubq7Z1SpJR47p3ljiEwxelXwNHM?=
 =?us-ascii?Q?lx/UyjKmjz1Ns2Dg+GmajFkeX+T5D7sBcHzZAK/zsL+F/qByCzgGisJvyT+g?=
 =?us-ascii?Q?m3iclbtWaXGkwBUL/AVAf2I2uFZfrNBsSmICQHG+KkxHmOwE/oKn5+tvChzA?=
 =?us-ascii?Q?DDMCl320LcyKj/y9aThKAloU/mP45GWywDDpVoGhLZsqPc6bIElYSlEdOg9l?=
 =?us-ascii?Q?K6iyVjp2Jb22IBpjyCCxl78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B7EEEAACC83974696567295A1C030D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n9MibW/gU0eAHerqOx7QWqHGmM7V/tVMh4qATzVcC1ALz2s/BikmCmX1MRDwHvtELH62ovgmQudNnv0gBtEQgyhKOYmfRl4Jfj+1PdP3Vpt+pJiLSGQ6O+fGtsAISWZqGW3uwomhtZMvFC6vpS1rpEY7cW06FrDglz3maAB9cGwZZIer68pYxbHH9yXeUm1JMuLMEGkXhXWE8kooc4oe1iiL/P09fMtTMf42LyZptQcVRfE4buUldbfg2UcBdyMi6d9HT6wJaqb0wMWWfrPpjXt5rHLc0+ZOUNjMJoayuKijPLbPHV4ibPIb7fuFcjZ38RK0Mfee6FVBE/EcOd8xAlLZXgrdIs/+czA1X5yrgVUU5WJqMiJICya+rGfDf29ihKSi7tDMf7URzh+Rm0KEswSVURk2RrVApRvQbpclHP09walZxecDeraLZ3J7+d2GngTY/0EpyJ0vLTKoSL0SjrQY5Osyk+Hedt8YENXYENCIDKJsBO2bOA5we+7pD+0rxyZm1flda77ios0JtOt7+6C/VyltOnPJKbTOpIHss4itWnTepIfv0H07PbzsnZE113ZU+jpbQSETngmFPEV+C/OjKsl4dC34ePn8A4OMcr3NlgpcxpNOkhxAxvuOt1cG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f195ef-1f2e-44cc-7e2c-08dd0f660ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 04:35:09.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUbxAm19i8pYYLaCn/icdIvbGZXVrHAqnh2H3UNXnT+c81n2P6T8tBWkeUJQ39imcKtwl47n4EPILze0YCvjOZ0hDVq0zGarJt8cphmRvS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6520

Bart, thanks for the patch. Please find my comments in line.

On Nov 25, 2024 / 13:10, Bart Van Assche wrote:
> Test concurrent requeuing of zoned writes and request queue freezing. Whi=
le
> test test passes with kernel 6.9, it triggers a hang with kernels 6.10 an=
d

I guess you mean, s/test test passes/the test passes/

> later. This shows that this hang is a regression introduced by the zone
> write plugging code.
>=20
> sysrq: Show Blocked State
> task:(udev-worker)   state:D stack:0     pid:75392 tgid:75392 ppid:2178  =
 flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x3e8/0x1410
>  schedule+0x27/0xf0
>  blk_mq_freeze_queue_wait+0x6f/0xa0
>  queue_attr_store+0x60/0xc0
>  kernfs_fop_write_iter+0x13e/0x1f0
>  vfs_write+0x25b/0x420
>  ksys_write+0x65/0xe0
>  do_syscall_64+0x82/0x160
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/zbd/012     | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/zbd/012.out |  2 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 tests/zbd/012
>  create mode 100644 tests/zbd/012.out
>=20
> diff --git a/tests/zbd/012 b/tests/zbd/012
> new file mode 100644

For the consistency, the test script should be executable. I expect the fil=
e
mode 100755 here.

> index 000000000000..0551d01011af
> --- /dev/null
> +++ b/tests/zbd/012
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

The other blktests files have GPL-2.0+ or GPL-3.0+. Unless you have specifi=
c
reason, I suggest one of the two instead of GPL-2.0.

> +# Copyright (C) 2024 Google LLC

I would like have a short description here in same manner as the commit mes=
sage.
How about this?

# Test concurrent requeuing of zoned writes and request queue freezing. It
# triggers a hang caused by the regression introduced by the zone write
# plugging.

> +
> +. tests/scsi/rc

s/scsi/zbd/

> +. common/scsi_debug
> +
> +DESCRIPTION=3D"test requeuing of zoned writes and queue freezing"
> +QUICK=3D1

The test case uses the TIMEOUT value to control its runtime. So the QUICK=
=3D1
should not be set, and TIMED=3D1 should be set.

> +
> +requires() {
> +	_have_fio_zbd_zonemode
> +}
> +
> +toggle_iosched() {

Nit: I suggest to add "local iosched" here.

> +	while true; do
> +		for iosched in none mq-deadline; do
> +			echo "${iosched}" > "/sys/class/block/$(basename "$zdev")/queue/sched=
uler"
> +			sleep .1
> +		done
> +	done
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local qd=3D1
> +	local scsi_debug_params=3D(
> +		delay=3D0
> +		dev_size_mb=3D1024
> +		every_nth=3D$((2 * qd))
> +		max_queue=3D"${qd}"
> +		opts=3D0x8000          # SDEBUG_OPT_HOST_BUSY
> +		sector_size=3D4096
> +		statistics=3D1
> +		zbc=3Dhost-managed
> +		zone_nr_conv=3D0
> +		zone_size_mb=3D4
> +	)
> +	_init_scsi_debug "${scsi_debug_params[@]}" &&
> +	local zdev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
> +	ls -ld "${zdev}" >>"${FULL}" &&
> +	{ toggle_iosched & } &&
> +	toggle_iosched_pid=3D$! &&
> +	local fio_args=3D(
> +		--direct=3D1
> +		--filename=3D"${zdev}"
> +		--iodepth=3D"${qd}"
> +		--ioengine=3Dio_uring
> +		--ioscheduler=3Dnone
> +		--name=3Dpipeline-zoned-writes
> +		--output=3D"${RESULTS_DIR}/fio-output-zbd-092.txt"

I think the separated fio output file is rather difficult to find. Also,
_run_fio sets --output-format=3Dterse, which is rather difficult to underst=
and.
I suggest to not set the --output option here and to use "fio" instead of
"_run_fio". This way, the default fio output will be recorded in $FULL.

> +		--runtime=3D"${TIMEOUT:-30}"
> +		--rw=3Drandwrite
> +		--time_based
> +		--zonemode=3Dzbd
> +	) &&
> +	_run_fio "${fio_args[@]}" >>"${FULL}" 2>&1 ||
> +	fail=3Dtrue
> +
> +	kill "${toggle_iosched_pid}" 2>&1
> +	_exit_scsi_debug
> +
> +	if [ -z "$fail" ]; then
> +		echo "Test complete"
> +	else
> +		echo "Test failed"
> +		return 1
> +	fi
> +}
> diff --git a/tests/zbd/012.out b/tests/zbd/012.out
> new file mode 100644
> index 000000000000..8ff654950c5f
> --- /dev/null
> +++ b/tests/zbd/012.out
> @@ -0,0 +1,2 @@
> +Running zbd/012
> +Test complete=
