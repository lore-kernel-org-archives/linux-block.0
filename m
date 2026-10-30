Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793326374;
	b=eyo+1oXuWJo2GXGUDwwAE2f1CejoGeV0Y7njE3BptUiek8rUoU9Jvnq1za2QnwtfaXvl
	 s2Qvn4351+PQOhAgAdSTT5fazmX+VXrT0b9h8NdBX4grAbFfYhBb5lm3IJ7Y1ARmNzGqm
	 ulQAEiFVLOo/obyNyOGHZCLU8O/uxPI8cO8NOYOe835HkMPN27GoTA7jSEMZeB6UsEDOG
	 o3iCMYsTR3381pll07Bxen21+LBdoZrWjMMsBcab39bACewj08zt+e5fCu1jSK7apwaPc
	 Cv3amReGVkgj5jlFp0JuQYTTPmYsLbb1+tcZWOsC+oBrRbVzsorC7VQrWbCViQ221dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326374;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kDSgAZVsZsRcdAMkJy/l5OZNPkfZtRsoxSpHAIni+vE=;
	b=hE+9shNqG72s9+Iom+IAkT/obwf4WRsGgyyf7Ap/wTsrGlql0Mlr2XLNUeneJ1UPxFAr
	 IawdSDH72HqLmOGhUSYIRJvjDvTgErh8iSmOWHt2yUyA2jEt4H3A1ptHVUb6DJbgqCAln
	 Ow+m3vMQRuUdGKHFUEoK5z8X12j2MipBJhJaoCIxxczfnKajdFIsCs/TuR4E1OGKgTsG4
	 a3ZmQkxKq0BSKOZxSCKAx/S1u3MrtUS6hgaz7fUFYTcFbX8ZOzOsYtdgLbzMGe9kGV8pw
	 VBjUcHg5OUrZ2D4E8DeWI58rwBl1e2v0zdhjnnQ0MJz+ntePzG0Z6cFz21Zb/VM2iPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=LdlK+9PU;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=RcZAEH+k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A15606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 02:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A15606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=LdlK+9PU;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=RcZAEH+k
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793326380; x=1824862380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nkRUHI3uCpQXyumDHyrWGKp5fgEh/UKfZT/ZSaB0Mh8=;
  b=LdlK+9PU+PkELWBXLcnrVSpEhM6ap9Hsxpa9bHaZ1GnPUUGJi346v+34
   i/kNuMYZ1hgHys8xiRehPgUorEniAunLYndLDTSNKhPIeQs8N28hxiGCN
   oaSKcFq3qO7R5P9TOClmzYzOWldIazPH6wxduHA3tcDd2PbgjjjXWt6Kr
   GE2j7ViDDEYs2Q1wEpcGSE89XRpIXDD2RcEVGjpg/pbiHiCqZvkz81CrN
   ZZlfDnf8mEO6fwMCV3Q/oR9qnzPodhBhOM4eRWagkfoihdoGfI1LveZuz
   6+4O774BQiBAySJAH01wvyWkwVxZ2rTvtAwieqYPDPyX51BukQVZH/n05
   w==;
X-CSE-ConnectionGUID: kEw5d+J5SF6lfF6jv+j/iQ==
X-CSE-MsgGUID: 3y3Nws96Q/uGN+bi5hKOyA==
X-IronPort-AV: E=Sophos;i="6.27,185,1786982400"; 
   d="scan'208";a="160337885"
Received: from mail-centralusazon11011027.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2026 10:12:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbTTGQZbgUUD6QfZlt5DqLPFpQg+K2F9cgAW/KcQ3WftcHhFLq5Wu0xad7fD54gZNQ1lfA1lea9mGKvn+aFUkeSnDxQ4+5DO9RuURVr1yH22tKZ9Dc+6MWroyRfZKDdIb2AMKUb1R5Ux8FgspbmKyVU6SszA5ANkoOHGMv88bXHsNscDIWH6jLJtXC+wZE1WzLpUG8Azm2+o2BxKd4mLlGa+w5j+edf+95xEE+7p0ZBAcgUlGPJG3DSAcgDs0eTrXlHVNIOQmvFiLgrhqRHdN+RwpZXcqZwam+aity+4CZju+mDg7Cw3n8gHlcYzf/fydWHDI9bRCHr11ZINt+4gUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDSgAZVsZsRcdAMkJy/l5OZNPkfZtRsoxSpHAIni+vE=;
 b=Imi92chbbZeP0cUcsV6bmnKG3bZxrX0m8cfxzwgQ28/avFq40dyt4VTviCPI3vdmtus9D3lVLh2MZOkc7R5ALrcAJT5kCnRqgjPcftKEOWhwafDI4PY5ced92Sjs3aQn2VcpdvHCIyHUfzcIgIdfS7WIbYKfRLsiUrAaeNsSvz7IhxMfkf3KbeLDrPaPdDlxUOeB2qnKrlWDyrbNXSE4qzoKhqHGt+qKctEkZwlvhq1j3oPLGUbwJIp20cSdDKMwvYW099m801rv9bq5i15YtHTZDXv/O/1Jyt2setjA627ulT8l1HRrSrFvkhTMBpG/RViuOdn5VSX5LfyyII/zXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDSgAZVsZsRcdAMkJy/l5OZNPkfZtRsoxSpHAIni+vE=;
 b=RcZAEH+kdOcYALpIwzC/LSCNUZ0/C+tcQtvLfjo+cdOBd9vyQ1Zqc/Q5U7kB2EuGsioKbOYXwN3mfFaiIn0g43MFoZh5fKhdAMSci0PrQ721a+ofjGvHIACWHSI561ZEDJYGk7zoM3b+v0lMGklhA/87cMVy4rTm5LaIhSe05vY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CY5PR04MB994595.namprd04.prod.outlook.com
 (2603:10b6:930:12c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 02:12:08 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 02:12:08 +0000
Date: Fri, 30 Oct 2026 11:12:02 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: John Garry <john.garry@linux.dev>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests v3 4/4] block/053: add a torn atomic write test
 for block devices
Message-ID: <auP5md9PBSJnZDND@shinmob>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
 <20261015-blkdev-fixes-tests-v3-4-b6ffa6410514@columbia.edu>
 <8fff4ba1-1b19-4974-bbd1-16686c8b5bd2@linux.dev>
 <5b4621c2-f707-4644-8aeb-d4d0956317c7@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b4621c2-f707-4644-8aeb-d4d0956317c7@columbia.edu>
X-ClientProxiedBy: TYCP286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CY5PR04MB994595:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cd30ee-d420-4432-5cdd-08df362b335d
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|19092799006|366016|11063799006|4143699003|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L0WWMlzSXdV+2JoWYoYkol5pic5YR9iZ/GyeiaFaeHXshl7FzvizHxKE6rncuHxvwlQvsmSfjnQt79TLeEOdqZ81paR4gVB1x+LF9UtZ8DLZ89PdopieabuEnfmAT0k1rtTCh3D/f6yZOA6theanDXZlhz3e5oCCWRIR01rVZzz8HhODqvANB9MIugav0etPz/zMOE/8C7cwlhalJQVP/4NYbncMVislEFLEtAP8hoDFLmkdY0TSNBckg1DFZ2eHv3hUGGfReERL1+m7qjOddNLW3rTew2rvw++Xyvhg5QrNvZ6RiN+FijKXdPVUxKkkIxl/UuoLykpVCodCStNrPaiVLh/yb7CB0KH0LRRSDwLMi/j1oOZEy0bTs/sx9GcNXBqgWRvUQIzPGSmnikfBq4OxqLKDBBqUwBVHGv9fnckTJjRcZxhZA61r3o5xaDb9see9qaYKYZd0QCa2xiUMaSfaJF6IuV3sTddBqHW0aysovVKz9l9FlIG3+qyD/d3h6MTYJRchUEEa52Z28MdhQ0wGPZ6fittV6xEmCk7ZV7E0kJ9gXJ/w/tPXFGAME3mDwdxEbbVPYu2T3gGOuV/8yQIfL6FWQoFxkpXSe7LrZh2aprONZO6PmQf9iGkQG4g4QHAJERGhBM1XthBNcbWuR//SDmp0j/kQ7lZJ/rG5WoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(366016)(11063799006)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?89FgqU6zbTlruSt+BiJN095GKWed8DPmL7VX82m2HPPqnvx5vYV3zo4FjPKS?=
 =?us-ascii?Q?i4vicqh4X6OuDRIi75QuSsWg7UCaMf8eiu+eADCrlELOWExa7dS1U7BLvTaw?=
 =?us-ascii?Q?DXdy1CmuIJQOTasAi6dcq/FvIImeFuFKlkwed46pQnWGrx2ELnG+Eo29mPEY?=
 =?us-ascii?Q?MTteJ1z/OM60dCwhaUgo3tXyss61nKt+8ArOj2CSYcuZb9+AC3+lNR1TBBbh?=
 =?us-ascii?Q?dfvhijVJ+knrgGx6Nean7B0JdwpDAtrtUdDeOrK4VeBmo0F5zBwYPtmsF8HY?=
 =?us-ascii?Q?uqeZOjPWu4urvx7mk44DLwH0WPu3w2En725VEoWf9/lSnLuJSufxNf3Eyu6l?=
 =?us-ascii?Q?jTmJYwmgfMp8nug/5MX5BNs/hWWyYS0y3r9c/gjDz4Vbc3YdI0G7Srv9TZHX?=
 =?us-ascii?Q?xP9ZT4nIaTZpJ994R4AssGH4q9nn8Vs8Xk9gz/E9R8kh5sx4fP+1F95xF+qC?=
 =?us-ascii?Q?SEfyz99NQ7la7t/i7VYXJSmFbRfS48/a5wU6Xe83gs6SB7ph60sf9aG7i68L?=
 =?us-ascii?Q?v/WDFrvNe7PmCQ7xf0twvyw6hkLsZRQWEjl5mVrRV0U0fRP70tZeMXUv2Qoc?=
 =?us-ascii?Q?vK2Q5SjszUr11QrmdnnVEuE7Omz3eLUzvTGdSs1mFLt4xkR9RQVDIdVKGuMf?=
 =?us-ascii?Q?hRX5ypDlx62r8/njkHpQL6axZYCciLwBDza1/M0K9gl2+uxhGzvxOXsSVQkz?=
 =?us-ascii?Q?jDJ+KvWjMDIPlql+YxWysY34OdGhAiBfSe7fxElA0GMA6cOTXyRrPLBQqoYM?=
 =?us-ascii?Q?a0eFU55Knci8SCo1agsp8QjKAeKjo422DLSsUqwDWqfkGD5XX4JIICGS72t1?=
 =?us-ascii?Q?dbX3OGd88RiV+5jEBCm29y+v+j/f9UfguY0xjLqnDKS0Xs8VH2GT4vykrsb7?=
 =?us-ascii?Q?k7qsFgbIOoq04W+W56QXxY7twTOljRDj+ZkwAaUTSaMxn+ufHdzAeI1FVtas?=
 =?us-ascii?Q?pfy9iVck6yEUt9Y1mhNeQgFGiv9YYdQK68HZQLYv0MiFwT1xQrhdpYXlKCVl?=
 =?us-ascii?Q?R0n/G9iA8B2CAuig5wdT111FPmMsT+r8U6THu9/PtfaVMrEerkmj4P7+dnw0?=
 =?us-ascii?Q?FTnpGlYdt/3KJ2n6BUE+374z75CSnpHwI10iwKUYqa1TglxUucJTzCeaYmst?=
 =?us-ascii?Q?ScxFAWzhX/uxS5mZXkl0HaagYtmiTelRtAvcYhlghBusvnY8OwdvK71HzDkp?=
 =?us-ascii?Q?xyM1j5eD2ASkrxJR6k9oSl0/33UrM4uhNIFqlSb8nnTyTLiUOUiLDo/z8CDU?=
 =?us-ascii?Q?84RZuvEzWP8k7PaStoXYp96/Qh1HILI1ppmVsC1LgqHep1wqKRn0yAgw2W8g?=
 =?us-ascii?Q?jLbsZTZJN+eh5HbCOEoMqutNCAwV+Ebn/kroFzanNn/6F6tnLo9AlQMLyUZF?=
 =?us-ascii?Q?QUcrSgLmcoU9x8IClEzfvMgb5FLIJd1tFADpY6lsBeB0mTuGL3HycxrO7UpE?=
 =?us-ascii?Q?YCs+x7CpNyxvViOqDKrNlVy8SIFZ/BSVZXc4JXwjHgQE+OfrL3f24aJjNZjP?=
 =?us-ascii?Q?nUuJ5XTskrTUmzNqhWgodqCa5X0EPlCh/TeD+SNd+Qyv3SNVgwa+SQ7L3JRT?=
 =?us-ascii?Q?eSlqx0AWXp/II550fk8nZvX8XP4Ah0GfMzZa+9W8QJAxJ4DdKui+FVLc+TWt?=
 =?us-ascii?Q?G5VE43aZXGcgciQuKt4g/vP0+w2h2Te3uo0L/LLcmpvqvG/4iT7q3mWeuaMw?=
 =?us-ascii?Q?J+WsTGsSsAW8y47rkm4jC9orwBUMLzRZBfFP7+w7DgWDeuluc6eV5kY9COfq?=
 =?us-ascii?Q?Y+04Nb5Dq4kFmlwgynDOqA0/YkIiS8E=3D?=
X-Exchange-RoutingPolicyChecked:
	V1waTN/g81F4+jXyyRTbSxzJnt5erywv/uZxxpTlmXxhiMMeKLgmCIYNg3vTNGwuzIlycC+rshDz4/414s7kva2AOLMtybXA4s70iDnBs2ByLZF5Kfy67j80A2QieBj/eTdaoPElZFrAa5S11shioJnCz4mI9+o9Ohh9awME34s/1fti4JIRzOjFTjvMknfD7WhSDcvy0EGcumigV+hJy+dYI+V80yDk6IFAYXYpO7qpwD2cDjkIZaqLvZ9CPTZZk1cjanQnj79TEDnFAx5L9zZr1gxA4nnWdrSt8fPUQYEyMKUc7I+EMDMyHu/vyOoaR59tYKu+F7tj4JilFKv53w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tiwO9c1kX91MSMtP55JUXv+usKB2jFIN7Mxa1kUMI5PoIy49trtPfGy2Cr3ouLiIb9cC2CBL5nGp9PSx/qw/vV5Tet6FBvz5NHUUpqB9yxKJIlLXbM0p1SS4SNe4Cm6Gdttk8QtXHnrF26tQHTIg3LYsFEKbKinigTQSN45Ol42KTxDG0wE+nBuJmBPbkb76T6CrAX88u791mvaCoLFs/pkTtsi1uTGy6wZXJ1kcpRoWY1c2xSTDDlFZUNNlyBDQAfe164yrx1J6n8c4uygs5Hma7RbVcFoTbgE5eJViOdl+j8qtAFtvJWrOs36vOYj+3649w6AuOdxo8VYLV4AOgM7OoqUxMe1XrfPHz+9QxmOk7d9nE6fAujqRYg3/CfN1bAxp4qVp3Nwo4/5iGEqeCSMXCB18K4AoSnJPGSYlRjhwzjlx0pJcSxNC7f8ikTjGNdjC8idqw4/i0XNCCr9d1+6/LghD2DB8hJE7y7LziCQRLBUzGyMuGb0eUvSXs/qtgJ4ux+0Cv3LZZrDP3yYEYyjsxMFyfrvEJTrmH28wYfypv8EWFPQ4RnsKg7qdaL3pEvxGo0FUOfSfqfqelBG0JjZbPHe0KV5k0jhyHbAr1ziV0bMk+1cd2oqDtsAqeV3T
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cd30ee-d420-4432-5cdd-08df362b335d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:12:08.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InmUMm2I9VmXdq/scRi7pzIsAf0g60t2MARZXcCcaTTUwHjnqvyBG3VVwVsC2AyIsuweLBK/fos9IGNtefbqRy4RCvbMKTkOYnIjEsbNlsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR04MB994595

On Oct 30, 2026 / 01:15, Tal Zussman wrote:
> On 10/16/26 4:53 AM, John Garry wrote:
> > 
> > thanks, just some more comments
> > 
> 
> Thanks, I'll address all of the below.
> 
> ...
> 
> >> +#ifndef RWF_ATOMIC
> >> +#define RWF_ATOMIC	0x00000040
> >> +#endif
> >> +
> >> +#ifndef STATX_WRITE_ATOMIC
> >> +#define STATX_WRITE_ATOMIC	0x00010000U
> >> +#endif
> >> +#ifndef STATX_ATTR_WRITE_ATOMIC
> >> +#define STATX_ATTR_WRITE_ATOMIC	0x00400000
> >> +#endif
> >> +
> > 
> > Do we still really need these? Surely a test machine will be installing
> > the latest headers along with the new kernel, no?
> > 
> I would assume so, but src/metadata.c and src/metadata-iopoll.c also redefine
> various structs/flags from kernel headers, so it seems like that may not be
> the case.
> 
> Shin'ichiro, any guidance?

First of all, blktests targets not only the latest kernels but also older stable
kernels. I expect the make command for blktests can build src/* binaries without
failures regardless of the kernel header versions installed.

The #ifndef approach above can avoid the build failure with old headers, so I
think it is acceptable. The other approach is to check the relevant C macro
definitions in src/Makefile as it does for UBLK_U_CMD_START_DEV. This is more
ideal since the unnecessary binary is not built for older kernels, but it will
add some complexity in the Makefile. Either way is fine for me.
