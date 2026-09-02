Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EE37CD21
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347077; cv=fail; b=uvLIZxdXE4N9HKpyYQHpV+RkUqQGtXvZfvC98xoImT4glPW1+WoUspkWIlA91aENfHk8onmTTQMctogK3p4gPKDTwPOu1A+1ZptwHKoe1qlVSdKECarmWi0S8+KacKhj0G6TAyctqNQ43qi+rfoXMmeriQKdTvlMwIG8i96hCw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347077; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+egNc27pZrN5q6Hb89qO2rYv10Q9KBcizp7HsseyHOA4iCMT7eqonLW5eLAooVVta7b/FSPFJqgk/6wZgfdgOWLHFU9nC5zBSfDxIJUSCXlKMRezDWViaXoWKFWZIXnlxkUN5+H1JjuogEmOHPB3Q1eEBF3L2O9EFszXnQ8+xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cda2UEER; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=A0JXI2lx; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cda2UEER";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="A0JXI2lx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788347076; x=1819883076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=Cda2UEERERVtRE0D7lfFsVmKcSKKqIN549RGSzAb458rJspDVPKznfbO
   +wbw2ZFuqIOgSEczUGw4dUW3hvlLl+bZhnYlFMJ2oti33gMhnryuYcqdA
   xo06SEzUBTB9KjsoWZa8Df24LG7z/b3S0fA+qfNkjXt+at9U1q+27XP9Z
   ca+md2Ucysx0+OLdwXi2bT/aNeqpM9xdua2OryBLL28E4YDerOlpLWGUN
   A2HXczHBNCb96sZ2NnuOWU388qyPD7TCMbp2c6vatdM/LHzxSwegAi0MM
   M3K2W+0v+JRl6K9/J8OU0H2XFB4uvdTTtcCw8kU69RKBdV9tv7NEquK++
   A==;
X-CSE-ConnectionGUID: AowINBVdSSe2cQUPzartpA==
X-CSE-MsgGUID: qTQLWBrSTqCscgHvXQB6yQ==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; 
   d="scan'208";a="150574931"
Received: from mail-southcentralusazon11012057.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.57])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2026 19:04:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lU1o9zQ3ck00VbVDhHpYPz1Tu7QMYr3QqfE7F/zFmSjPMWg1Tee/tMost0pTKZ30Bj6Ngp3jij7NsT7Y/Tsy9f0qBj8n7VHjuMFptgu514EHNm8v4MNQ7ECh+s8ksD/+1YZ+cmFcVriXGXOcgdkjmzl0Pckm3Xy5elPZCMzflpYm4z8MlubPhbnbTSAnWULNfsWzWEdM9JiLBZ0xiKQef/fMX5Qkwwnmhvw3PL54caRD3PhKhvBhG0Rg8qEQ9WTmDroiihh8Fvdm6zENUD7pIzRbOfNE8afzENGsaBVxWp87coO5B09DCWqWshYxma3PqGtCQqK4e18UntQ7hWQRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=clDd0uI1rwSSz1K1B3au9qRkdZEXsxH78axYfPJvlyQr3pDaIYjgS7s3XT8JMKm6pRP2RCaK5IeHVfVYPq8Pbv40D6InMcj8v3OuPFhqZpy2qeS0uPj7HRprKbFik+5ZBNSfP5zYZvkeATeLn5esMft4ubXill+fWqshooJfM0UsrfjESWTpONEjXDMWsqupd03XQU5ncHS6vZxIBdW2VIkPhL+87Be+FJuMBLP2IsDm9+GsYZFZ8w3xyMpnJak12uzZbzjezOB0KQJPRCTLu1Z4jOdbLLy0WAMqpv3LARi2fR3xnvCo56M9ZgTtRld90qgXCFJI0I+7v1biOgzoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=A0JXI2lx3fHBJaOMG2plhEzvWMHHYAfAzWpoFKyFH7OKsGt6o3/xjDLjdhBvJtt9gmkjWhRKuHK/JkZdMkM9HPV6ujC51NIxLpJOR5nzdw/uHdWHyfLXhZWgoxdqx7rKvfi0TNOEQ/HRs9bTpL6ROZxR/Me9odSbHucmhb8dKAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by MN6PR04MB9360.namprd04.prod.outlook.com (2603:10b6:208:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 11:04:31 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 11:04:30 +0000
Message-ID: <aaf9e380-79da-4ec1-a8ef-59387eaf820d@wdc.com>
Date: Wed, 2 Sep 2026 13:04:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/12] block: allow read-only and offline conventional
 zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260831034109.744039-1-dlemoal@kernel.org>
 <20260831034109.744039-12-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260831034109.744039-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|MN6PR04MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de140db-b25a-4e9e-4bf4-08df08e1f6a9
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|23010399003|10070799003|10067099003|56012099006|18002099003|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B1zPhMh7i0nLVMIGnXITBEjPW37FRy0tPE2pYMuSFiPD3EB9B0Tg6B3GYJ0x3mGDcI2I72rD/VwzT7HJu8wKrNmnlf0VGGK/kVZCHu049FDGP+EbX7iTBHlYmGUm26PZ/4dDdyJrN6ErW4H4biBlm++FN8mzSVo0asGEhXnRidlddBXWy39dcohF4OzfIbWDfW3WgVhP4jl7rAhEs77N98FiRhOimNqUgvTPDeYFPdTsuhVKhmlNl3ZNFeDkSxkY2cfKML5D1oe3LtjD66QEaqdjsY8LLSlp2IB6pW5F2rfA7DMpo+UTU0fho7IB5BYXlJd1tSaPV7tg1L6qUcnFmpiwDj7rzJ9fbSPWYj0/7f6OQQCJGFISj+xGwWYo9mE3eJuN7FC+5UpM78vdUYeoyRDJnt5jyvmxyHLipIzmWY3C/GzHRi1l4us2TrlsnmOnf/ADet6dh07gc5K4siXu1OlnhcGOVpnqc3R6uN4mm+6RZ3Tj50Trzhj41XMKmUXB6QdqtZVVGcntG7TD+veZpW00rZEc0zpJwlgVmiFOj+0Xh9xoU/XJY2r2L3GJf/Aodc88aSTEsgG14YeSxKDMXKjHMu5+NY6cKkAVicEAtIz3AwHA6XBHrgA2OsdqD4AB35BYU5PJtk6qX9gyhJgxtpytexlp86hZ7I7npxwMYpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(23010399003)(10070799003)(10067099003)(56012099006)(18002099003)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGtGNSswMTc3SWo0M29MV1V4OE9haENKU0NMLzFZZDd4QnArZTJtQ1MyL0hX?=
 =?utf-8?B?ZWZvOGl1QU1ENU50NDRUQkhaV2VKTEVWYUduNWRFaFBsS2syY0RDUGN1blFT?=
 =?utf-8?B?OWdmMTNwbFdub2lvQjN2SUNkOFF4WGN0ZkJRR1BkdllUY0dtUjRQVXc2UXBx?=
 =?utf-8?B?S08xR2xBR3dpRWo2eVhoOTJGZFdCMVh5NXEvZGJvMHpzVGVDbGNBTm1EUFNt?=
 =?utf-8?B?NkttQVZ2V1hkMUlHZi9kRklPb05jd3BoNjJzMTlTVmVpMytLZldJQTNDRWgr?=
 =?utf-8?B?VUw3Y1Fyckx6ZTh3cU9wV0VIWlFzbEZ1MlhCeXlEVXZPRVZaUS9CSy81eEVQ?=
 =?utf-8?B?cDVhOXl0bjNlRkJaWlRVazdGVmxoVzJibmJzQmd0Qkt4VHdlblJGTE5rNXhs?=
 =?utf-8?B?TjYvNUZLY1NWY01BNVZ4QU1PMnRYcmNRemY1M1NUUUhVUnZhS05zNXBvWDRn?=
 =?utf-8?B?aWgrWWE2T0lnTWkwZEtmUmIxaHNUTllpWFFCeEx4RUw2NCsyd3R0NTRUODhL?=
 =?utf-8?B?K1UwWmp0Q3I4RVhMTDdGMStOTDFvVzJ2dHRWS2RqM0orYWNWOSsxNzA2L3VP?=
 =?utf-8?B?NXl0QWJyWFN4Sk5MUWJDSU9aRHFGellpMUlyM09iOGFQV3FSYW0yUnpwMVVn?=
 =?utf-8?B?UnNwckFvVEFXQ09XSmhhNmthV2RNUExyVWt6bXRIOHFZZXV6MFZJWFdaTDln?=
 =?utf-8?B?THZTWFNaUzEzcGlldWdWM1JhOENSckNubVBlZ1JyS0VRTEp2MUlSZzBaMkVC?=
 =?utf-8?B?dktxYUhZL2VIcVJBY3o4dU5BdkxCQ3pwNkUxV1FERnNSd0JSekM3MXhiS1ha?=
 =?utf-8?B?NWNFdG1xUFFyWXMwTkk1d1JoWTR1MFR5OUc0dGw0ZjdpdzlSc1ZMQjVOV0hl?=
 =?utf-8?B?RTV6VTZXTXVxVTFvUk1tWmE4R1ZGc3ljYk9UTFJaWmpSM094TmpUbWd1eVF4?=
 =?utf-8?B?MDdQZWp5cHViT2RtNEIvZHpFWlpoRTIxU3p1U0F3S1h4VS80bnNoWkIrVUZJ?=
 =?utf-8?B?QlhzWDJKbTk5VVZTd2FBaTBaV2VOcGdCVmNrNThvWCtWUUo3YWdCWlpna2Yx?=
 =?utf-8?B?YUV0NUcvdVFHL0I3RXluZkc0M045TWNMbldpTmZnc2hIWGExVFhUNWJsQkh2?=
 =?utf-8?B?VkpuMjBXS1V5RitsS1FvQ0h3RlNJZWRXMzhjdm9qci8rVXR5UmoyTTcrSFln?=
 =?utf-8?B?akZxbzU2NEVrdEZOTFNhVVc5UnAzZmQ5K0xZN0lUcGNpLzNtSGZuSlRSRDh1?=
 =?utf-8?B?SDVlUmxYdFJnUW5jNmlZSFFnUHk2bWVmMTFGV2RYU3d2RFQ4N3BQeEo5QlZz?=
 =?utf-8?B?RXZqTjdTSjV0VjltNmZBUThBMGsrcklJMENqTjhXK3Y2QTI0c2lyeFlWT3J5?=
 =?utf-8?B?UnVsZFFkUThIOElybHNsbmdhZldaKzM2NWNCQm96bzJIemwrNTVqNlY0VEZO?=
 =?utf-8?B?cE45dDJMNmJ5Y1pscllycWxyTlhNQXVjazdXc3NvNjdiV0hQbWd3TjRrT3Jo?=
 =?utf-8?B?aHZQMHRWVGtlR3VEalR5ZnUrQmRXQ2RWelhteDVENHl0S3R3bjRIbWx6bmZ6?=
 =?utf-8?B?Zk84VHl1YkNwTldtemlhWXRGSEh5bG5NcEplcUxIQ3h6RG8weTNhSjlpUE5t?=
 =?utf-8?B?UHo0L2F5UGtFa0QxYS9sdFowR1hrS29LWHpPMjRmMldBOWkrTzBwNFJack9k?=
 =?utf-8?B?S1k3Wk5pUEJHZkpKV0dST1V3dnF4c2pwN09TeXFkblQ5VDYxUmlXdVY0dEkw?=
 =?utf-8?B?K04xb0ltbzQzamlVWVoySWMvdkhzR0U5d05XdG13NnlPZUtlSTAwT3RGRU9m?=
 =?utf-8?B?UnhSOGdaWTVuRUQxM1NzTktDdDZidXI3VTJtS2JjWkRUaHhrU0gyU1ZpRG0r?=
 =?utf-8?B?M1BMdC9aUG5tVHpxUHEvODEyQTVoRTUzc2JITTdnb01PNjkyN3JKMnRLdEhP?=
 =?utf-8?B?MkpvS2ZrRm1UaWRhRU5DWVhPMUFHL3R6M2dEZWFrYUdSK0N0YlhDV2QyaEV5?=
 =?utf-8?B?dGVLZ1BidUt6OUIwN0lJUHNJNEpLS2MzZURkK2RreUJ5cy9tYlpCb29BMVZN?=
 =?utf-8?B?Z2FrU3ExeFNmejg1dnVJMzRuTXB6bWxXYS8yQkpzTTRKVDlQSUZ1WkUxOFJI?=
 =?utf-8?B?MDVxNkhVT3J2SEJidUpzSGZQM3lwbzZRRWFuUTY1TDFIK0VpUUtxWmttc1B2?=
 =?utf-8?B?OFh6N0h4dU1TYWs3UkFxT2RnZHF0czlMdUpiaXZENXlET3BhNHNSTzgzdUVs?=
 =?utf-8?B?Qm9CeCt2enRMc0FmRVgyYVJGNUh3RUVJT3RKZ2JFRWJTSHJFVXJEdVVSaDYv?=
 =?utf-8?B?RkxCVXcvbFpMdjZsQUhudkgwQjZCV3h0R0tRR3JQOHZPeCthMFhVdGovT0Jx?=
 =?utf-8?Q?ywEZBKv1P5Ds5E8eGH9mbEmqMnQXgoW9Xx6oA3eOyz51R?=
X-MS-Exchange-AntiSpam-MessageData-1: 7AMnkAwfiIykvCzUw+kgH9bBPjN/fZHzxg8=
X-Exchange-RoutingPolicyChecked:
	DE/MyEKWSrA1McoNExvSxLn2aZuhmjeGyz5s4DQR7gzXcQ6C/o8wiKmO3B25cwAXZVDZvqqQ1K/Yk5RJB+3TIhH2V6Wu9qZZxG8a37nQPzTkeqn9bRCK+Wh9aJbfy30BsaV3ENdz5x4gsn+7V/NzGdQnWaWYGGcnWl9ER5tsBhAeMc9UDY62WTwVB6OBkd6J7da4s8VGZ7C9bWalkS1qC0nBZ0y0nLvxIudIuoVehltu37xKQqhVwpbXJ+loSQoG+5mjUZYIH4EacoTdTrEz0wWhWJbTKr9hRsreES9qBjcyfNmweuKuawizrhNxWZ8San2oAjvt+mQN44biEAUEsw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fZ96HI/0njgsY55AWmFm/rjgxjoA/B1ynNb3co05TqTRPHqQONaqLhOHOhSVc8AI/oxJSu+KODVIBCiU43grxAB0nvF4n5M7EMa/JHlmR7xWZnphwkrgpkJHiZ6QAuZZIMBm2q9lAgrnRk6rTXYUUqpg6kpAS1y4k0AqUd4iuPtrVooPW2xxtTkaevy6DCqakmY8/2qxSc2Zm2NPeYNz2uOWt62C+Bh3A+GQJkmDfL+EvV3c0WKCrmLD6QQ9UYm2m/rhEqm5so5lpXt9eJbU7iNt4YD1W1QyKfDPdavjVD8q7LPVnUYLyxkgFMYh3uD2PkGwT2gIOm5ZPw3eBYE6Kg8V6HZdc7+52hSQ6xai1A8OxVRBp+No1EQHG45GSlC1ein+0N8V35b4l8CGJtJ2gYOl/d3O6L0izX3NshYnhO1BAtOx7U2g19ALqlaIu4tDonzCcMw16l4KI804sdIZjmcG1pApiRextl1wC+8go53YSnLjAGsXRNR6L7GQUNS/G9kEzOW9Gy5FLCwvXFW2bhy6i/0+6X8Gmn98ZJPmZrj7y0DlQvZRHYqzSmLAPo1rKNkOUhwjAuaFdds8T4S2QTHssVoDzVRNLZD68ancPjhdDJuZQDTUgzvxTdSnVjAt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de140db-b25a-4e9e-4bf4-08df08e1f6a9
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 11:04:30.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZjopEcTDhTv4iskBTwfr5YKECsR5T8Q084oWvjZmkENoH+CDkw283OwAxyQsx/QqcriDnawpU1+Z9yv0Wr4MbaR+o1pfCS3FUMj6ywP9ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9360

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

