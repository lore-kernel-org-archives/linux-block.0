Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FC155342
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454822; cv=fail; b=XQnC92hfjiVwhUzrgtR+rSqB/rM3rReAbB7F3BSI5ZxO+CNXFYSjqbBqXNzY+RCAL9KdzNnNGXiJY0pnGQ23w4uCUogsmyFQqO3f2Q8r8W0NE32wNDn7dup10hab4JnzGsDweC++Q+l0e/K+9haMiOANxTlzbn7Cr0K49+ujnfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454822; c=relaxed/simple;
	bh=WEEHzrLYxnUhzMT8I2cqHCxF7rWwKKj47eeuRuzEPh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tvF0aLBAB1BgwXNdEQaIcK7RT/NK0aJkwgaZqF8AQJRDyCTyA3vMCJhusIBrmVyaFErS7E52TPKvkrynH671fWdhb8aWzjDc/GcolD8v58zQy7MdHVftsFSQ5uRbQuZ64SbHwXRUjdp8n6BGumPiPNH57OZmREJXt57IouIhYGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FtgdU7LG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LuOuKkmD; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FtgdU7LG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LuOuKkmD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749454820; x=1780990820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WEEHzrLYxnUhzMT8I2cqHCxF7rWwKKj47eeuRuzEPh0=;
  b=FtgdU7LGERADFUcvYz48tnhJQTQQNbIZ0wfOmn88sOm+tq9rt5TpHver
   nMd/tc75FlNBETqfr7mG8Hx8REebcUOInofscye8ZywZ4IGciGzbCisEJ
   yl06TMjMbpv1wgXF6/e9kX2y8vIJhTs2TgGVU7ctcJkDdX/xmQw/BIAPR
   alrVRQ7OwqY9ChDgXDw1CMbxRHk1aZkxoFh92dnRHYaMNfGUECcn1VsCB
   hQh+yfejLr2CRnFHgItogyh08PQ+vToou6yoG+wYrGL2+pMfb04ZO3Tsr
   i7SMjWMOQmnOCt2geAnoaQnBak6Ot7r2bSaXYaK6D/WSOy/tVOvR2dP50
   Q==;
X-CSE-ConnectionGUID: zdSO4pnTRyuQs63wr8ZjyQ==
X-CSE-MsgGUID: QUW3EPQwQySD/OiwKT1ZVw==
X-IronPort-AV: E=Sophos;i="6.16,222,1744041600"; 
   d="scan'208";a="90226093"
Received: from mail-co1nam11on2081.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.81])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2025 15:40:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4Zw9JX+mJheAS82zfm6RVaV8K6fcaJlFnPZBHPlj0iBrjCULFC6VcIFmBdaZcLm19lgZR9aFP+0/vVJIvm3KFD5PbWGCgmAxrnMzQd1Nc0E/wTrfRda9U0RddmWpVPN+7W5H05p6WV+5XHSRbXbqztTK547W6iMYrQ2Pd7+xVz7Hzn6I76zmGkZ83zq1Nd16g+eeSyl6n7q/sdTbBWDqSLyMhFPFmDLxkFxnuWIDQBkmnK2hB7F1UgU61L9C70Dzlv6/eRaQXu5K+cYqjIeT2J3LhblJ623Ic2IdSOF2RlZe09Pa0TF59MuDKY/YG+4xzZLpdXdBbv2Cq++ZcuvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEEHzrLYxnUhzMT8I2cqHCxF7rWwKKj47eeuRuzEPh0=;
 b=i8hwyvlsQqz6Id+GtAXJEZWPJl/BgFYpWG8mt/8LOB/1UCOw6RkGFgfWZESbTRCSfNkTbxA/CRNcTTbfs/FEqiOPGxBumFu46j6KJi6SpuMk2JRWrlZEfqOx/qeg5FanthB0ahvhavFAVkcRJUHSHgw5m2Dv5OBOvFP555qhv+E/S6K1CDPTBJYq84vxc/fWPb+/eBrZTQe6oxlEqcynZgpiuMh6q2/tckB2kmBwTcMJcrwB81bnuoXz15N0yrPLoI+Vy2kMd1vPB5Fa/ygykdNKQF5ItOBe4WP5N/XHouGhjqWfpOJU6aCTXJAgxmH8IhoFAmgHUgS4kzKlGQQxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEEHzrLYxnUhzMT8I2cqHCxF7rWwKKj47eeuRuzEPh0=;
 b=LuOuKkmDUiLwXIfba/EbYDHXC9UHJkQFcUgDbU28rBxJwVhJ3goyk5XiyuCL+0YnC5Jm1hZJ1e5Z82v5e0J+7imFkjfh8dcLeUuZ4W35cdSeeGLO3AYJvmjUIykdMMsI/S3FQBRTwar7TNQbauWABZxQN4BHtFCtxju32ztWfN0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH8PR04MB8615.namprd04.prod.outlook.com (2603:10b6:510:25b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 07:40:09 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 07:40:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Anuj gupta <anuj1072538@gmail.com>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
Thread-Topic: [PATCH blktests] block tests: nvme metadata passthrough
Thread-Index: AQHb1no8Tf5n41CazEGiDdJRWjmp2LP3qcEAgAIHv4CAAMT6gA==
Date: Mon, 9 Jun 2025 07:40:09 +0000
Message-ID: <ghrdccaxngioldq3epwmidp6hpfbepytdigbptxudbp7wq7fw6@rminww2nryfi>
References: <20250606003015.3203624-1-kbusch@meta.com>
 <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
 <CACzX3AsFG-aORqNM0oV8TCqotCvnR3fdQD9QvzLHpWFWeYVo_Q@mail.gmail.com>
In-Reply-To:
 <CACzX3AsFG-aORqNM0oV8TCqotCvnR3fdQD9QvzLHpWFWeYVo_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH8PR04MB8615:EE_
x-ms-office365-filtering-correlation-id: 233cd49b-dc60-4e53-e288-08dda728dc8e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEdLcW5LTXZQKzlzWnBOWmFUdkZDOXozdkFrR0dxdWV2QlFxaytPZXFWRzVS?=
 =?utf-8?B?dUVvTUVUSFpaRjNtN1NyZ05sWnJ5akhaQVkxNHkxTURmMFNkRkxVWXpKNW85?=
 =?utf-8?B?RXhHN2pVUUJVcFBWZkdsYkIvcnVkbSs0azA1NVBDbFFwNDNkS0pGeHpNWVAw?=
 =?utf-8?B?Zm9TNEZYcjBzSmU1M0lBbjZGQU1CMlBvOVFydmUvZE5BdzBuWXEwWmdZVitQ?=
 =?utf-8?B?QURwQVUybU1GdHVqWG9PNU1UVmJzRzVJV2w2SVh0RjZqU1ZLbTFFK3FhQkY5?=
 =?utf-8?B?NGVYOEU2SFJjczZIOXJVbmJ6WEVrTStOckxKT3QrbG5pa1UwQ1JVYVR6M2pU?=
 =?utf-8?B?aDJUK3o4M2tpMDB3L2IrT3E3b0NubVIxL3R5alozVkxkNmtaRmJDOUd6SDFP?=
 =?utf-8?B?enIrVHdncHJBSXk3a0RwaklYT3krdWltNlpYODIyQU11TFRDRDh0b0FsUUwv?=
 =?utf-8?B?SkFqNHYxUWhlWC91ZnQwSS9mOCtlQUxPNnQxbUNuUXJwQ2QwaUZhbExHbnJN?=
 =?utf-8?B?YytvV0tZTHJPdjcxVjJHd1BVaEVHVGI2T3ZiVUR0eFkvQVN4aTdlS0N3UGJM?=
 =?utf-8?B?TEpBOU8wWllMTTA5TkJJcHorUkd3ZmxaSGpUTGRFRDBRY0xjbVZtblFYN3RV?=
 =?utf-8?B?M1RFcGlmcmtMdWU1MDY2R2U5NFBaN2l5emRXY0hpcG1BMXJPSnczRjVwODZI?=
 =?utf-8?B?S2JieDQwbktOVDhNRldFYVlzQ0pIRng5UzZZVlN1eWExRythR2NSZHNCQzdw?=
 =?utf-8?B?KzFTWlFack50ZGhHZ0ZENktsZTVNdW9zZEJONFNYL0hKL2xFTDBVWk52SVhR?=
 =?utf-8?B?eVRBbFlESEtnYWU3K2VGcEtXQkcrb3BuME9VKzFETmY1S1VVcTYxMFBkMGcv?=
 =?utf-8?B?dWNyM0hBci9ZRDE3S2FRblpZdVllbHpyaEpVekllbWtVQk9obFgwell2Qmlm?=
 =?utf-8?B?Um9iaXZGSm1JL1VzT0dwOWU1TCtIOGsyb1pNOW5JYW91eFNKd09mbm5CYkgx?=
 =?utf-8?B?L0FKdmhUQVQvUnpiTm9UMFpjNDJuTkt3UmhrcjJXOHhJdDdMdWkzLzBMMmY0?=
 =?utf-8?B?dE5mV2VzN3BXcTlHNVczZTE4ckNYQmxya2ViNUYzSHBoTi9oN0g0YkRRTGxX?=
 =?utf-8?B?Ukh3K0pwdGIxeVN4R1lOZ2dmRFBkMEpFYTJ3RE03NjZqN0pwRVJUYVZyRzlu?=
 =?utf-8?B?S05ocmNRV0wrRlpkYm5FS2dHSWZleENvbHpXVTJqejRLaW80NEcxZDhVbnlw?=
 =?utf-8?B?UEQrcmxCRUMwcUxDTEdNbGhsMHpVZFFTRktwQlNlQUR3UlR5MkJITS80b2sr?=
 =?utf-8?B?bFk1Q0tRMHIyZWZ2Qm13QnUzSytLRWs2eFljakN5RXg3NjJqN1FFaUY2TlQv?=
 =?utf-8?B?V3lTa21Deml4dUVlYzUwdHRTZ2pQSFk2ejNJODhUd295Slk5RjlnRHhwTERE?=
 =?utf-8?B?MUh3UXVnL0RLN3lweWRZMlhXcG1ZUGR1eWlGZThxdFU2bWpLOEM1TGRuYUEv?=
 =?utf-8?B?c0I3Z081VkRydmJLUFRuYXdzdjBmaXRybTNDT2phYSsyUFIxVnh3ckszQzk4?=
 =?utf-8?B?VFhoM2N1cUdjUGNteUFzTXRiRE1Hd05nUStpdGZyWU4yb2hHNXdIMFk2NE1m?=
 =?utf-8?B?OG44RFdQSlJ4bkZlTHFWMWg3Zng4QmhkWlZhYWFLWmpZcUE0aW5HNVcxMlNu?=
 =?utf-8?B?aWtUUWRIdGxrdDVxTjJBcGxwVnZQY0txRUpSck0rQm41WElPdnhLU2hUaS93?=
 =?utf-8?B?ODFwY2w0QVpocXJ5UnBxTStsOWF1SVJrM0ZBWEdFcW1pTjlRNGljdXZnV0hO?=
 =?utf-8?B?NUM4UnJTckhBVW51L3NnYnl3b1UvTTY5R0RTcmZyY1dpR0ZwaU9jNXJMdXVY?=
 =?utf-8?B?Z051Y1NvNFptcDBuaDY3d1FZQTRINzBpbnJRa0lBZ3BJc3k2NW5iTEV0QVVj?=
 =?utf-8?B?dTdKRFMwK0VFMkJ6MEhWeTEra3Y5S21iWm9KWEUyZmIvR1d0SEhTZ2YrQXVJ?=
 =?utf-8?Q?zS99cdMs6g8s3l4gsotiogPVC15GuY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anRuWi9NaVVTaEx3K0pPdDJLQXo0UGZLYXZudXRDbHVGZVZIYitzWGFLTVhv?=
 =?utf-8?B?VU1Td0o5WmlqT2JlZnVVNndsekU1UlhYUFptNGE0aTNpWnFKR2tYNVhsQ1Zv?=
 =?utf-8?B?YUt6RC9wZzJrdW1DMjZTMDNqci9iWW1jL1Q5NTcrYWFLTVdPeGIxNW1BbjZu?=
 =?utf-8?B?RCtNS3NJZ3BvUEp3YnZMdWhFUGwyNUNISDN5ekdzeEM0dWxFQUEvMGZIQnJ5?=
 =?utf-8?B?S3JqaTE1Z0ZiR2RVNlFka051N3FnUU9ma1IzYlpCTFZlZzNHSDRlL2xVOXhn?=
 =?utf-8?B?U3g3c1JJY2k0Smw3WXYxRGMvOUZkWWw5N25uZC9QZUMzRW5VM2gwekwzNWcr?=
 =?utf-8?B?dUxqQ3Y3L3kyWlEyUlJkeHVISC9DMUtqbHZ6cU1oTHc4c0xRVTlTTmNrcVVx?=
 =?utf-8?B?ZDJZZ3FKM0VnS2IwU081SkQxK1Z1NW1FSnpBTDhPdzgzZkhxSjJ4eG1xZlVH?=
 =?utf-8?B?T3FHc04yOENPbVBQaks3RUc0SVRiTXJ1YTMxMEp3NnBIdnZJVHo0ci9rQ1cz?=
 =?utf-8?B?b2hRd1RSM0c1aFQranBScHBjQktuRHdWZnpZSzhtQ295V0lFVUFQQjh0SWFY?=
 =?utf-8?B?WGtQQTQzUEVza2dhODdlSkNhUHhtanc3TTk2enV0dldZak5JeVdQYS9JaTc4?=
 =?utf-8?B?Tm1vZHRwek9OUnIxYWFWOVpNOWJNQTZLTlA5eUNxVzJCQndTcHFBa1JyeHdS?=
 =?utf-8?B?NzdUalVzQ09KRHV1SHkzTmFXd1NKODFMdzVLSE1QN2V6RGNvcnJXUURqb2dr?=
 =?utf-8?B?bFk1ZkRmODZTSXdmMVdmTE5FY1BaQ3JHWVFKUXZ0MmI1VjM5OFBPSEwxTVdY?=
 =?utf-8?B?Q0RzekxJYXp0MHBsKzJrWUNOSE5GeWVabUdWSjIxVWxZNTJhdWpMODRJMm1i?=
 =?utf-8?B?MlM1S2hRYzVoUTYvaU44UnZIeTdxUGRQNm5Sb2RqR3ZDSkdtay9IZEdldnI1?=
 =?utf-8?B?WTlJam1FWER5NjlRemdBdEFFckQ2Z2FEWm9uVDludEF5T2tOY1ZhQ3BkNm1H?=
 =?utf-8?B?N2xtTnJLRjA5TFo2Y2RWdmZsOXY1YVZ4MzVDdTY3QzV2UUxtK1RSOVhrcjVD?=
 =?utf-8?B?Y2hWbXRLS29LT2lMU0s4STJOcG4rTW1PSDFtSTFsdUhlN28xMEFoSVpuUStx?=
 =?utf-8?B?eEJHUm9hK3Q1ejhwRElWTTd2NmkybHVOZ01DME1zNG52S2xoTTAvZHVERnpy?=
 =?utf-8?B?cm93MmxjQzFWVVVKa1laOG1CdVdHaSswbzBadldUV3pxb3FiY2FzVmdGb1hZ?=
 =?utf-8?B?S09WZjZZTzlWcDc4b3MxYndSNUcxNnIzSWRDTnFnZDR2MEh1Y0FqcTF4QTB0?=
 =?utf-8?B?K3ZhUHpxZlpvS0hpeE5qY1dWSHYyUzBJS2FudDBOTWt2TmJxN3hyY0dLUk9C?=
 =?utf-8?B?Q0pKeUZISlZ1aWdjLzZYbjdEYWNwb09QYVhHQVZuTGNqcVB3ZDBRZGU0cm5q?=
 =?utf-8?B?RjIrWXBTakhrdldkRzh2U0ZlU3lzWUc3bTdPTlNqU2VRMkVIWEg0eWorS1Fq?=
 =?utf-8?B?VHlMcGw2YU5SSkFHcjRlZFE0NGRQc0JPRC9UeWMzT2REZ1FibDdRdTk4cTB4?=
 =?utf-8?B?SWxVc3g1ME1MVkpZSE1ReWlzUkM3SVorRm9yOGlyZ1FzeVNMN1dubW4vZ2Ri?=
 =?utf-8?B?QUtPRmNmVktwWmhlSzZNZUtWaXBJVlFEdlJDdllLbXNrbDM3dktaSm5MUlVZ?=
 =?utf-8?B?YUw3eEhFaHhMVHZMOXVVelM4RGZTWFdmNDhGWGlXRVhLcUtBT3ZDU3FFcDM2?=
 =?utf-8?B?eWFTaTRvQ0V4aHhBNjY0VkZkN1UzbmIwUHlFOTRieEsxNEdPdW1iSUZuekV4?=
 =?utf-8?B?UWppLzRHTE43eElFdzlBb0luNnNEWlQwMThubEpKS0IvZXY5aE8rOXp3d0pz?=
 =?utf-8?B?SGNKa0RWcEFhNkVZc0pVYzlFSFE1NHB5VzZOMU9YL2pBSHhraHpFNHZJRjFI?=
 =?utf-8?B?b3p4UmNkWENhRlZxY296N0kxZktxYUcxUlR0NjVNd29tQWxJbi9LbGtpVVFN?=
 =?utf-8?B?eTh6Y2JRS2hFZHdNaWNVdTl6ckRUeFo4eU1aMSt3dmVrdXIxNnVjNXBDWm5k?=
 =?utf-8?B?ZUhnTkFvcUl0bzFrMElhWG1jZE0weUlpbVZNb0V4K0MvbVZzRHcyeHU4WWRB?=
 =?utf-8?B?WnB4aTdkeWhjakN1eXNCZWZJaEVVMTZIYjgybFpKMDh1REdTejF2ME12QitG?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F0F95B8BCD9CE49A2FB3753FECABDE5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rxmSh0r5DKF6YbWBnd/I/6T9wFMqALK9WDMmhAMRy8zC5iQnacJUoEQXoY/4l8cYetqMWdyCspWSkJC5qZMcbtYlBCr0VcCUOiVLalHTeW+zLxyiW/dOguCL8UfScRMUF0WWLpQKJokjsbONYJ27Ij0svEt81V2I5+hM76bo1DTuRsFCSJQvdohhOmxTSCVRMY/awVfp9pdPzL+okXlSArzSIEbSA1Uoa3yu8oRauCQ9AUeRPGvbztB01dUpzNR+jrn2yuKLWTLMUO4psOD/zUl9sJGGhK9Z4dYYk+rA9Y1IyfcqZbXbBAWbaBo915l82U9oW8mJV/bDjJL81CzFIjw82JAaaC8jsNbgeCdBOfJOIrCsQFxEyzycUYVZf1qOYB/i+pClAMAfulX8P7UFN80QyeE08rFEph3kcHN67HWgUFg7qFleC7XxNGmUkVyRxOJ0aff4WSGF1Q0jgACgm+eNn6iODk/oFFesIoYlO+iIsMfHjX00VXyzrHh79UQ9lvvUJNvqq1A/GeyCNKLSA4ir8AVmd3BDCwZdik6A2eK8oqh93pHm7ctAJkj/HpAcWwZHOMFneX11Yw4Z7tJLTxRRaKW3EhHeQ0T9t6nT+wpKvxztuIY+Ll7bD+BuZftn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233cd49b-dc60-4e53-e288-08dda728dc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 07:40:09.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3dcKhnxzUYjU1w8zUbS2jgt6wqF1rYwqFVRzmlhJdCBFHxjc1cH2AgcECI4zVB8QZJ206o12T/pwIjKPpKU7IlIF8jySLxgaPsuJLc+K9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8615

T24gSnVuIDA5LCAyMDI1IC8gMDE6MjUsIEFudWogZ3VwdGEgd3JvdGU6DQo+IE9uIFNhdCwgSnVu
IDcsIDIwMjUgYXQgNjoyNeKAr1BNIFNoaW5pY2hpcm8gS2F3YXNha2kNCj4gPHNoaW5pY2hpcm8u
a2F3YXNha2lAd2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBKdW4gMDUsIDIwMjUgLyAxNzoz
MCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+ID4gPiBGcm9tOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+DQo+ID4gPg0KPiA+ID4gR2V0IG1vcmUgY292ZXJhZ2Ugb24gbnZtZSBtZXRhZGF0
YSBwYXNzdGhyb3VnaC4gU3BlY2lmaWNhbGx5IGluIHRoaXMNCj4gPiA+IHRlc3QsIHJlYWQtb25s
eSBtZXRhZGF0YSBpcyB0YXJnZXRlZCBhcyB0aGlzIGhhZCBiZWVuIGEgZ2FwIGluIHByZXZpb3Vz
DQo+ID4gPiB0ZXN0IGNvdmVyYWdlZC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLiBJ
IHJhbiB0aGUgdGVzdCBjYXNlIG9uIHRoZSBrZXJuZWwgdjYuMTUsIGFuZCBpdCBwYXNzZWQuDQo+
ID4gSXMgdGhpcyBwYXNzIHJlc3VsdCBleHBlY3RlZD8gSSBndWVzcyB0aGlzIHRlc3QgY2FzZSBp
bnRlbmRzIHRvIGV4dGVuZCB0ZXN0DQo+ID4gY292ZXJhZ2UsIGFuZCBkb2VzIG5vdCBpbnRlbmQg
dG8gcmVjcmVhdGUgdGhlIGZhaWx1cmUgcmVwb3J0ZWQgaW4gdGhlIExpbmsuDQo+ID4gU28sIEkn
bSBndWVzc2luZyB0aGUgdGVzdCBjYXNlIHNob3VsZCBwYXNzIHdpdGggdjYuMTUga2VybmVsLg0K
PiANCj4gQXMgS2VpdGggbWVudGlvbmVkIGluIHRoYXQgdGhyZWFkIFsxXSwgdGhpcyB0ZXN0IGNh
biBjYXRjaCB0aGUgaXNzdWUNCj4gb25seSBpbiB0aGUgbW9yZSB1bnVzdWFsIG9yIGNvcm5lci1j
YXNlIGNvbmZpZ3VyYXRpb25zLg0KPiANCj4gQWRkaXRpb25hbGx5LCBpZiB5b3VyIE5WTWUgZGV2
aWNlIGlzIG5vdCBmb3JtYXR0ZWQgd2l0aCBwcm90ZWN0aW9uDQo+IGluZm9ybWF0aW9uLCB0aGUg
dGVzdCB3aWxsIGV4aXQgZWFybHkgYW5kIHJlcG9ydCBzdWNjZXNzLCBhcyB0aGUNCj4gaW50ZWdy
aXR5IHBhdGggd29uJ3QgYmUgZXhlcmNpc2VkIGluIHRoYXQgY2FzZS4NCj4gDQo+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay9hRC1KOW16cV9iSmUyNnJEQGtidXNjaC1t
YnAvDQoNCkkgc2VlLCB0aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4gVGhlbiBJIHdpc2ggdGhl
IGV4cGVjdGVkIGRldmljZSBjb25kaXRpb25zIHRvDQpiZSBkZXNjcmliZWQgaW4gdGhlIHRlc3Qg
Y2FzZSBjb21tZW50LiBFdmVuIGlmIGJsa3Rlc3RzIGNhbiBub3QgcHJlcGFyZSBkZXZpY2VzDQp3
aXRoIHRoZSBjb25kaXRpb24gYXV0b21hdGljYWxseSwgSSB0aGluayBpdCdzIHdvcnRoIGRvY3Vt
ZW50aW5nLg0KDQpJbiBkYWlseSBibGt0ZXN0cyBydW4sIEkgdXNlIGEgbm9ybWFsIFFFTVUgbnZt
ZSBkZXZpY2UsIGJ1dCBydW5uaW5nIHRoZSB0ZXN0DQpjYXNlIHdpdGggdGhpcyBkZXZpY2UgZG9l
cyBub3QgZXh0ZW5kIHRoZSB0ZXN0IGNvdmVyYWdlIG11Y2gsIHByb2JhYmx5Lg0KQ2FuIHdlIHBy
ZXBhcmUgdGhlIGJlc3QgZGV2aWNlIGZvciB0aGUgbmV3IHRlc3QgY2FzZSB1c2luZyBRRU1VPyBJ
IGhvcGUgdGhhdA0Kc29tZSBRRU1VIGJvb3Qgb3B0aW9ucyBhbmQvb3IgbnZtZSBmb3JtYXQgY29t
bWFuZHMgY2FuIHByZXBhcmUgaXQu
