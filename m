Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC938DE0
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043292; cv=fail; b=KS0aoeeG1WC+bB8UnPRCwJMzHJt6zvI0S7lXmDgsm+rxUrFWlTQzIpFSkXp4BPQ9hsxQRoBkao35WkMNRPHYEbEAprMGjzpgyRyyRwJ4QC7pzwmfkps7ncE8scEATiT+7ayBV0z2kAnUHz3q4VlfCMmY1zql3ER9j6Q6FgzpTIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043292; c=relaxed/simple;
	bh=k0rRo+kFfHrf0sgBrpOD0i5YyweHJf8mq0jolF3jvWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U979LjLmBcI6LaobYkoLqk5A8wbLz0ElEiHUg74hznwax9H9yzo5wrPvUZ+hhdpoB3La6c/EIjXEGj2nWStyx6PhpiKNzgIBFXUrPDfoEyBGTRJrtd4Wu5nRQbRvVgJU1VI3mBkinK/mb4n2qPICrxl/4E5k33yVl3kLQFCgeic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oVhXeJDo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Y7dmQWNu; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oVhXeJDo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y7dmQWNu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731043289; x=1762579289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k0rRo+kFfHrf0sgBrpOD0i5YyweHJf8mq0jolF3jvWs=;
  b=oVhXeJDop+LGKENMro79A7PO8tIqmImJwhdZpXViEiQSbo0mnbfImMEv
   +JsfOEx6foLC8/gAH6f4x6K0a/pN5sweGzZWb5f4JStQXeMPA7G576PBd
   BDvKgpwMADVv6vQinGnuAdIdTEKxqlfUfyMAf2MS/YabzXNr+2qhFD0u6
   D7UOUEiWNatxa1gtVphBo+57zdg51aS/PgST/2FIgJLTlN8yt8wGM0/CH
   MAraek4kCFbKn6xKbEfjzWT18K5zLf9AyYRVunfd2JO3APYn8UH4c8w+Q
   r31HFpm5jukX8pgM5w+jGXPz18siOaE2xDg+CgzRWtE3FqMEqe2Ixvy0h
   g==;
X-CSE-ConnectionGUID: Ty2me9XIQ/a8mB6H9ihB7Q==
X-CSE-MsgGUID: /fCGIR1yS2SdYW5Sd1aQnQ==
X-IronPort-AV: E=Sophos;i="6.12,137,1728921600"; 
   d="scan'208";a="31954438"
Received: from mail-westcentralusazlp17010002.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.2])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2024 13:21:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDS+aU8tl8Zart5erJjSfSAHJSBxVsV8a0OEkg0hYH7+98lq4LmzsbptB/esqvb4q0/7T9p0oz/uKVo0IEGxy1SrqaAUB5ekd2S3BRhKehH9FuWnPTBB46P5mPbE+4UQz33GsweUaNoHYYy9pwF3n4OoUcEvseWtxE0ui4apkIYrmNPov0PMkXSPB7bGRxLMG7alOguD7L0/W34CGkOI0Bo0VuBxrcvXZu03VpPI1YhtybUFlI1GgDYGehvkDIXjfvagjb19LqmfDfk9Dca1cZ61KTtyIApr9JieFzm6ZPNYduQIu1kDgpdslhpJuq7BEOM2GC05h5RtbMjBAeQX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnZD4D7Pt+nfUdYGWJHNYrHd3TK2aD1EFwEqDYPLdfQ=;
 b=uIfOZ96tPQLtqxGiWjjtTfLVJEROYN2KHqE25WBPkOafl4maTTjrPfRl2ThNc2dLkCPFwn5st6x+WkgfzyMmZyLBv77zMKpjMP+FmwpQEtS2vKK3/d2l7ObZgVBMlnvmdzrbRXtv+L5VE5WrTAKYSGtHqggz8kZDAVl9UWhS3dIHWamSfBYm6jd9BigtpO5QqxOyy2JYBpDWfcx0NClRrP+eW9UCtf6IeG7hgROneP+MXXmQJXru06pnSmkG0gDGmmmoCjRgRfByO/ZeifekyyxsQisqy5X4H8HyHRyvcXJl5f/oD+hrbEY4J+X9kQYLdcTp4+HX1OUdCMTWOcODcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnZD4D7Pt+nfUdYGWJHNYrHd3TK2aD1EFwEqDYPLdfQ=;
 b=Y7dmQWNuLmO6eae85/hmz0pOnoCHhICbQHQEwfirfWVv4OFTaSaYHtLOze1aqbhw6aMNNPrOelrB/dpe/zQVIQRddLhkV00FgOUg1H0S8qh0E+U7XR1Iib04nwALtl2ab7OJvkvF25m9tyHaOcdsj0j4e7cMNojrRdyS3DFuqI4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7833.namprd04.prod.outlook.com (2603:10b6:510:e2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Fri, 8 Nov 2024 05:21:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 05:21:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Topic: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Index: AQHbLu/o7uVXkmU4Vkas0lacIZBpRLKs3jWA
Date: Fri, 8 Nov 2024 05:21:20 +0000
Message-ID: <32ge2scpracxiqw7hcqeb4xnfowofw2cjods5rr3ckecgpxxdj@fqny5zqdcelw>
References: <20241104192907.21358-1-kch@nvidia.com>
In-Reply-To: <20241104192907.21358-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7833:EE_
x-ms-office365-filtering-correlation-id: ce2fbec9-e6bd-45b4-acf4-08dcffb52e08
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6VA9gEqjjRgOFR2LSjUABvJpAgakmrDoh7bRYAiJYlfkXjcggAVqVVpQcKWw?=
 =?us-ascii?Q?TxGTT5p6qUSaaECke9s6EoIlq36uVdC26wjeDGLcNpAXnMwiL5iTxDKDVdXR?=
 =?us-ascii?Q?YKSkiHkiNj7ACjkzu+vB5qwPYp5uuABqpyCa91u8y/t8lqajZ5EARdt4+SBA?=
 =?us-ascii?Q?SHMZ/Ps7Y6y4Ls6tG6huZPvv8TgoGdz13PWTSvmaaH5NQge2UARcTyVecjnQ?=
 =?us-ascii?Q?DnSBJAwNkTk+85YFPFLlRWH/7CfW1n9cQ/YsH1LYluC6fS9KsZQewArcWs12?=
 =?us-ascii?Q?9Br/pDl/7FJyrAgxOXsAI6yT5oUvSKI2AHqCJDh4V5Cua6UrTLWWUrvStKOr?=
 =?us-ascii?Q?HG6dI54iiWO3JpNZ92CcUnJE40DPJnoUjjQt0wDFS1vLvIpARZ68JLEhEr3J?=
 =?us-ascii?Q?cCoippUIpQlzEjDB/Gp4C5DIi23FIDW8QrmOg0sZwGEH/NG3A43nKA4E+jXn?=
 =?us-ascii?Q?D+ikklKJIT29DeXDmwEtMNn90Nypeztu+XtckxKtfndtDz0b7yGBE0hYj63H?=
 =?us-ascii?Q?ylmS/4Tfix9w49GW37Qeo+wAe4fFsP745+GBBeOnpHCBX1YpRTeXAuJapd6e?=
 =?us-ascii?Q?n1KKCq9DCxqtA9/naTa+izWky2/IXCRiKZXzoc33DtraFfZNz5x0dZgJt/aN?=
 =?us-ascii?Q?DFUrOX6vCCvKb0jRudF9Rm933qMb4vXLiZa1PLyC1k/jKUVIZtbq5RQeTe5F?=
 =?us-ascii?Q?suDok1CNvhJmpDWI5KeXR7rfNNQBnocVj2fWiusTNJNi0sdLWj2UxcvzbAno?=
 =?us-ascii?Q?TbE6Xqd1ZRCV+7lb8YcbukKfnlQ0EFn1F4jTJc94Il7ZV7KY3Mh8+8Hb9FTK?=
 =?us-ascii?Q?wfaljDcQJzxmJihOKKrQGwtUHBGUp17Iivpkl++hyv9ydQjBu4YuLy2lhlZO?=
 =?us-ascii?Q?qOpYUD+taRx8nIkKpfWJCbfkLFmohar4RVFW4wkuWyiXAFVM061iEX5HRoUz?=
 =?us-ascii?Q?9V6xu3WCAoXjmOVOarI5UR2/lxeFwlbrOrL2tmiWnL6G0GSkQ3Ehq9vRWVOi?=
 =?us-ascii?Q?L6dPT18/sNU3lenrO4GmJZblznXTAwBo1cSmTLHl6MyIaNDx3kgxkZlIs/rP?=
 =?us-ascii?Q?6EkCWiPDxEq7Iab56QhFB4XndfMCiPdfYAz6g5f0MbqSUfUEWVblrCRmhs7S?=
 =?us-ascii?Q?P6N+UHFiie6RsiCDCibu0qXiWI0ZTZOs931eM+3gYVurUM3NaUFaRUtibduU?=
 =?us-ascii?Q?Dpg5WLFCnUhiPO8iFiq5V+wK5J+SE/5mkapTjWvE2NKeOFnhQo8aukft3dC+?=
 =?us-ascii?Q?mgdk3ZNL4CVZ9oTGUK0oXELk9bdiL7Lrfw5cLKUUQVNERyq3Mn1BhQjMtjvg?=
 =?us-ascii?Q?9k1enapU2xtconHmD6RkLgVY4G4B8wH7QJEiYcHNWau+cUrcHZcRXXRXSzVI?=
 =?us-ascii?Q?hGY/JEo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l6jB6zOcDw4QgWj/DA7tMb3ZoDcAMuji4ZZJqUpl4W7uk+oKZY0d7SjW2/Dq?=
 =?us-ascii?Q?DeFeSssgFZ3BIJEBPZbsGCUkPpdADy+OXlu5+tpEk8uM5Obc2AtB06AleZ7k?=
 =?us-ascii?Q?Ftfqc1TyO0HXWYiXMFgRpiggHoairiRrdUZgAdLyykA1Jvbdl77faT+jTWtU?=
 =?us-ascii?Q?vW4PIB4u6NyReKYNPJ1aVuG5noIo7e1Z5M2WKc4U0f29AL8neithlRq0426b?=
 =?us-ascii?Q?BbxbfN1dPlFRLdiDMcX8hWtmOzhGUnc14tXI+RK0HHJuhzG0zB9MI8NJE99O?=
 =?us-ascii?Q?i5SDS/2/XPFJbOmVPiA2apjgnc0EHRLjLXZGsgautZE9lUx/nE54GerwUlrl?=
 =?us-ascii?Q?GoXyPItSavvzYkuWD5xGrK5dUaY9jqpQ+AZOMON61hOhAlIuPezbAAXEqcPm?=
 =?us-ascii?Q?oTvUkltuWzrUXKUaKgzVFlJW6e+OXZetJFEvJbm/OVCI6EzfNYoEp9NTDXDp?=
 =?us-ascii?Q?rJTU3Ms45ZMz0VTxlKi6xmE9KIkqFcOVPAjKk2RZdgd0+FzFornBYsVWZsPv?=
 =?us-ascii?Q?KRg1Vm4jn/eYRydqZVHL+Kf3Fq23TAXiL4wwvQjeHtIA0bUs/UBRKfoAar0N?=
 =?us-ascii?Q?BladPjuvrbRJK5tfFqGDtxJ4Aovx106AEngjvanYHOVCxAdENZHvMiCI0OyB?=
 =?us-ascii?Q?aPQQyE8Y1NuZ+rhkViz5HYDcEhJ7mKlCOUTGQOXKhoJAtxob53X7Kbuj98Z3?=
 =?us-ascii?Q?6pAGCQS3Bb1foOpELgkVnBzVy+Ea5X3XyVIaukcIylBg+AMnSgQi1WisQ8l8?=
 =?us-ascii?Q?t/TtHSlPgPHt8IEFmK+D34e6dqtDCE69+5dK1tDBYE3dOJioIXxRQCMSDcha?=
 =?us-ascii?Q?OpuIhiL+z+ERUL87hXOtcO4e8KxhqncpAVft/ibuGyrJCW2qBlfSw0iBYAJX?=
 =?us-ascii?Q?dhOaxhd3G2ltX0+07KKjduOlZNvjDzrzNTGGfeINR2F/4CEjnA/i1ZD27gR4?=
 =?us-ascii?Q?U2FLs8g4hWYkrAJbvBwQILLutbYfRnrkKFhe5OnVvGuaY3kfNvB/2oWlzrSX?=
 =?us-ascii?Q?nShI3wKQDMlt6EhChcCyAA7tSjh6nitb0eluUJz9h+AbbY8ZyvA3kVSD7QA+?=
 =?us-ascii?Q?xtUifJxz/7eji5ejnQRAdjDh8z0CoYNKa7Rg/QY2eJXtTxKYajpIrbdKp5Xb?=
 =?us-ascii?Q?oRpxMDQVKRPvCIXBFWC1Z6zHTI9QseA7Cn/moPlTJl4l2VRGYABmtOo5viHk?=
 =?us-ascii?Q?q+BTON9X6NNjioDBvdWkN+ssNFAtdk8IPGfpZFkbDuR0dd5RoiKP9aYJJaqB?=
 =?us-ascii?Q?ohOKF0RI2mUZ6uenbIJyBk47/5++JneGru5uYXDb4BfptxOchmB61XgObODw?=
 =?us-ascii?Q?4qhDVoyTO53cJfGDy8adrIgjtqO34kD4ZqKt5CUPZxIKelHKvD3Foquvnw14?=
 =?us-ascii?Q?+FMLdE0V93riRQrz4C1+H/CLcmhRrZVStCyniXAbOO37G5W9/hkEY0nGDfRJ?=
 =?us-ascii?Q?WgC2g73FoNCjdAQQUG6uZh3pe1ovGLl7nCPcF6YbZwncYORFy8ufRWN0MJA+?=
 =?us-ascii?Q?cmaH4K2ZR1sYyqND3VZaA0KtFPC4F3mhgQw883+4Qm9Dwpc+mRMDb7yNdZ5X?=
 =?us-ascii?Q?exIPXBOFXYgxMOKLPa9ea2aWkznqoZxg6RNyPwwB9wbXM7x5uXykz4AXddjC?=
 =?us-ascii?Q?xkMD6pVazF14wtFjm1E2UJs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6FD3898A14F964F8854355B80F3BE82@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QzqwdZgzlZ+I0AEKHZHHhlv4x3m01fGBYD6eISHfrxv0H5nCXpnH7somsjhX3bWesQNvfx2/YNGdYUv5bY2s37FoVzWNBvV/GI6zQP2wu4c8X7RnkfnjV7yBX3ioht1bvnwhSNNPCl7oETYijaNG5/KxaxysuKNRhDDcOKjNb5wc52nmCHJj3+Kp2H8yOyk6Xr52r1VtXGi+dWr45lBAQgvzI+KZCd90BYHugoetSvOdWSlxdf+ir+dflfgr7VJ0PPkd3PJi8Ys8RNJuW1KIxD4GZNk1FAz4PdH3gUsX8yzHuS1CAQrUPT+3WIrMEXT4Q/hrw8BsHgVonNmNHCqZCR3C6ZS/q3cqJG0Tk+ayf3fXafwVsdkjgPXmXq8+HFfqssMIDVDEiKL42KgLbDDAWu0Ly3EWFT3hgDUukPB9bMuYKJqNzpU69XgjXanGac9L/N3Sc8vZvmr2ohFQHcN2B9Txw2DcqLeA8JyXpgg6K9sIUVrd2XV482sequxviM0x5h7yu74GF6L02GjQTyFwvuzBNLqdnNgomBYrNP0JYv3zZWCovm8RsqSzb+cVsC8SwE+Py8EKy3efail0+EAiPtMua4ZXZyEIvunSxLgTqfOP0EzvCFP7RLVYe9Z1V2tR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2fbec9-e6bd-45b4-acf4-08dcffb52e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 05:21:20.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 330+Jc8Nd3EYvNMeKj0CXsg0k/3OtFkErK0rjc9Y762Xt++Q12K8Tl6zvcvufHzaAHEE3bAu/xi26MV5DI8zpD9yjrmXim5zI4wuJmnFSRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7833

On Nov 04, 2024 / 11:29, Chaitanya Kulkarni wrote:
> Add a test that randomly sets the cpumask from available CPUs for
> the nvmet-wq while running the fio workload. This patch has been
> tested on nvme-loop and nvme-tcp transport.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks. As I noted in another mail, this test case generates a kernel
INFO message, and it looks like catching a new bug. So I think this
test case worth adding. Please find my review comments in line.

> ---
>  tests/nvme/055     | 99 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/055.out |  3 ++
>  2 files changed, 102 insertions(+)
>  create mode 100755 tests/nvme/055
>  create mode 100644 tests/nvme/055.out
>=20
> diff --git a/tests/nvme/055 b/tests/nvme/055
> new file mode 100755
> index 0000000..9fe27a3
> --- /dev/null
> +++ b/tests/nvme/055
> @@ -0,0 +1,99 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2024 Chaitanya Kulkarni
> +#
> +# Test nvmet-wq cpumask sysfs attribute with NVMe-oF and fio workload
> +#
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"Test nvmet-wq cpumask sysfs attribute with fio on NVMe-oF=
 device"
> +TIMED=3D1
> +
> +requires() {
> +	_nvme_requires
> +	 _have_fio && _have_loop

Nit, a unneccesaary space.

> +	_require_nvme_trtype_is_fabrics
> +}

I suggest to add set_conditions() here as below. Without it, the test case =
is
skipped when users do not se NVMET_TRTYPES variable. If we add set_conditio=
ns(),
_have_loop call in requires() can be removed.

set_conditions() {
       _set_nvme_trtype "$@"
}

> +
> +cleanup_setup() {
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup
> +}
> +
> +test() {
> +	local cpumask_path=3D"/sys/devices/virtual/workqueue/nvmet-wq/cpumask"
> +	local original_cpumask
> +	local min_cpus
> +	local max_cpus
> +	local numbers
> +	local idx
> +	local ns
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +	_nvmet_target_setup
> +	_nvme_connect_subsys
> +
> +	if [ ! -f "$cpumask_path" ]; then
> +		SKIP_REASONS+=3D("nvmet_wq cpumask sysfs attribute not found.")
> +		cleanup_setup
> +		return 1
> +	fi
> +
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +
> +	original_cpumask=3D$(cat "$cpumask_path")
> +
> +	num_cpus=3D$(nproc)
> +	max_cpus=3D$(( num_cpus < 20 ? num_cpus : 20 ))
> +	min_cpus=3D0
> +	#shellcheck disable=3DSC2207
> +	numbers=3D($(seq $min_cpus $max_cpus))

Nit: the shellcheck error can be vaoided with this:

        read -a numbers -d '' < <(seq $min_cpus $max_cpus)

> +
> +	_run_fio_rand_io --filename=3D"/dev/${ns}" --time_based --runtime=3D130=
s \

The --time_based and --runtime=3D130s options are not required, because fio=
 helper
bash functions will add them.

Instead, let's add this line before the fio command.

         : ${TIMEOUT:=3D60}

The fio helper functions will refect this TIMEOUT value to the --runtime
option. This will allow users to control runtime cost as TIMED=3D1 indicate=
s.

> +			 --iodepth=3D8 --size=3D"${NVME_IMG_SIZE}" &> "$FULL" &
> +
> +	# Let the fio settle down else we will break in the loop for fio check
> +	sleep 1
> +	for ((i =3D 0; i < max_cpus; i++)); do
> +		if ! pgrep -x fio &> /dev/null ; then

pgrep command is not in the GNU coreutils. I suggest to keep the fio proces=
s id
in a variable and check with "kill -0" command. The test case block/005 doe=
s it.

> +			break
> +		fi
> +
> +		if [[ ${#numbers[@]} -eq 0 ]]; then
> +			break
> +		fi
> +
> +		idx=3D$((RANDOM % ${#numbers[@]}))
> +
> +		#shellcheck disable=3DSC2004
> +		cpu_mask=3D$(printf "%X" $((1 << ${numbers[idx]})))
> +		echo "$cpu_mask" > "$cpumask_path"

When I ran this test case, I observed an error at this line:

    echo: write error: Value too large for defined data type

I think the cpu_mask calculation is wrong, and it should be like this:

               cpu_mask=3D0
               for ((n =3D 0; n < numbers[idx]; n++)); do
                       cpu_mask=3D$((cpu_mask + (1 << n)))
               done
               cpu_mask=3D$(printf "%X" $((cpu_mask)))


> +		if [[ $(cat "$cpumask_path") =3D~ ^[0,]*${cpu_mask}\n$ ]]; then
> +			echo "Test Failed: cpumask was not set correctly "
> +			echo "Expected ${cpu_mask} found $(cat "$cpumask_path")"
> +			cleanup_setup
> +			return 1
> +		fi
> +		sleep 3
> +		# Remove the selected number
> +		numbers=3D("${numbers[@]:0:$idx}" "${numbers[@]:$((idx + 1))}")
> +	done
> +
> +	killall fio &> /dev/null

killall is not in GNU coreutils either (blktests already uses it at other
places though...)   Does "kill -9" work instead?

> +
> +	# Restore original cpumask
> +	echo "$original_cpumask" > "$cpumask_path"
> +	restored_cpumask=3D$(cat "$cpumask_path")
> +
> +	if [[ "$restored_cpumask" !=3D "$original_cpumask" ]]; then
> +		echo "Failed to restore original cpumask."
> +		cleanup_setup
> +		return 1
> +	fi
> +
> +	cleanup_setup
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/055.out b/tests/nvme/055.out
> new file mode 100644
> index 0000000..427dfee
> --- /dev/null
> +++ b/tests/nvme/055.out
> @@ -0,0 +1,3 @@
> +Running nvme/055
> +disconnected 1 controller(s)
> +Test complete
> --=20
> 2.40.0
> =
