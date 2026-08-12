Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04040D588
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530477; cv=fail; b=n/2GuJxGKtMA5R6LZ3XfmLSgzRIpSPs9thnGwRpX/hGd9PGzxL6Aom/2DLx5dn7lFQYJqQLAmxfgqruG9idB46lAN1O5KlJbmxZ/vkMsVWTwuHXA9vpK+b8bC98XEwOckHZps2th4WbqifFEGPkTGNEeTCdul2z9ihxc+mPsKic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530477; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=snqV1bXWT2mDJd5yxzEMy9rdh9BujrES89D6uzFCC6cJIL2KCNl93lkuJkpEK6TyiMdKzKZRbKpxzFFtbyNDpSDjM6/rJ7IvKlsogmLLxXMsDSdEivRwfzXI9Bk1zm6ZCQrCO6dlpZs5EFN4ou7iL1uOZtV5Ur50DSGps9klt7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AwlA0nJ4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yIBiE8pz; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AwlA0nJ4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yIBiE8pz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786530479; x=1818066479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=AwlA0nJ4OCSPEQScHzMrideOQaI+VExKhJdJWT2ifMs92ixg8CRW3mSC
   ivPxIok6uIDmfotc0KYU5zUzPbkHrvlkdvRtiawsM3hTDHIPYCqaJf2iW
   pA011fycl3xOCxHbadtRnsVd6HvdCqXWBHFm9NiOcZYnY2GIMuh5NI0dL
   somrsEMX2E2d+9Y1T6Gg1GehLAs5cr3xgz/u0rwxwkkePz1UL1uR0lQSM
   G1eYR6v0cZlblHTYFb7eK1cLx0odgTc7u2vzwMYeqQD7cz/NMzl+E0yzn
   sUglVrlYEqYemfXt8QsnKQCkFArkJ+Pj5uLNz7N/ysMTGpYzcW/3D2Jk9
   A==;
X-CSE-ConnectionGUID: 5iYjGZ3qSl6rZSnOGfV/sg==
X-CSE-MsgGUID: ebw4ceQmRral7Um94Birvg==
X-IronPort-AV: E=Sophos;i="6.25,219,1779120000"; 
   d="scan'208";a="153002852"
Received: from mail-northcentralusazon11012035.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.35])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2026 18:26:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU0lF6PdDWWgMTVIApbOq8+MpqpQO/ZnZ4xxXLn9xSWMkXGYBJus0xtHvGwkhA9Es0aL99cCGG7wvoUrzMGlMAPC/r1xLpZh+neNSwx1p5RhgCNRE3xSwNKorGIPSaois/1dtrzWug97O1SszspZXfKNMmkRp7bN7i3C45gA2eDUREjIdLYap48UaL81/I4slchhhH+Cw1Eg5S5NQVTRVM87NjEnlbsJbyX/OvFp245hbFn59xBMbhYPqL9ZbnYB3SqYzJ9PC4NVt1WG4qmhDPkheaQ39/34dF8yCENmhneIQzNLqXtWzoR+djyN/tPn/7nb0afu6EhSLEokB1MD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=Y2H/S5IGrJcU8qMKU8ZpFQ6kzQJ7Esu1UFlSeebuoWgRYornE3OLGN4Q8EXojFjC2IB+zab7oj4cl7UCR2TJlvtRZJ3FcVc86UxpJ8cZxwYrgSkjlv8zqKqawk/OG2CoL1AgKw3rEmQfsMMCBVWSe54cpsFw1fBZjFt+j9wg9QPyKv9YTvoQS66WZ9b3HwnPmDUPZyVk5QfA43xE7vdXli/2YQmwNQdrIt88mYOXJYgJzFrc8mzdeZ2F3zN94hH6/pH4AHw9ROiVuWd+eEer7JG3lDm/A9gy3PTfhU5dfJcgzz1um07M2jg1uMoWTeL8OXyCZIvY5WI8dspwm10VAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=yIBiE8pzhdyQhTDLMox63meoAkXMDdECsoXtIAfq7S9NFjVZVSPJ7poQnK5nA6c2kH3pVwJUq4kzPho3tF0voQ5lFwZlkpVLtXNmm2REa/dFUMw2rANlGrY+8a31vbs3h/xsFPgSydqCViVkp3mVKs2fi6cMqoRy4gMSlXio+Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH7PR04MB8633.namprd04.prod.outlook.com (2603:10b6:510:245::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 10:26:44 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 10:26:44 +0000
Message-ID: <97a022d6-01b0-4220-ad87-9535f0257296@wdc.com>
Date: Wed, 12 Aug 2026 12:26:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] block: introduce disk_for_all_zone_wplugs()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-7-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260811105852.1245357-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|PH7PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f77d4d-1be1-4489-6bd1-08def85c3529
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Lf5JtfHTj0By1v+GkBJ6Zr6H2nEMkY3kJ8uU9B43pB7K1OswR7xSRgEFjNCM850TX8rr/Ln8XizV38R4P2A9EUfHxm1keV7dVmsOvrehPaIzM/06FfejhwLFDy38Wu1YTRKtlDVmph3xZ3QuXaf0Rw5Y9XxAQfmumoiE6b0uoZf7fCEE7dOrREFSBwCpzCvUNWg7Sr+kOtS4/1tsrbXdmapgbF7ZqNGBeO9SqIPQmsY29Ewwq5S2Xfx1VanPd2OSuYvN+q3r/26kXipd+lyJF9JFpmCZWUC9ZoyRbAjCu/Ng9b3OitoqXAb+e++DoqUaZCuS2F4pmcUfN9JN++TjREscDoSEWfjX+Yg7p2T4GZLa7klMD0AXp2aafjOyT0emVwhuhSxZ6CpOn4dpJEsOhn5Les4gJw6+s/LnD/HQMgvnTJNMPBgkI9PRoiiiW56KBlKRlgtjyzaX2fGqGQc3nUKJJ1fSVZpGadO9mjWTv/ki7nn3QdQskmTIndsYQ+sbBvGLAw2UUfmL1JpqxLJfImFWwxYStyrsBYp2i57ga4LCqJDN+L9yw/EPfp0Y4LHgusJVXFIo2n8BESYah+Bva0zPLVT2mQkGErSX8QLjqZZrTTeI+pbYZv1yQ5wUXq71/L1C5MEy1Z1HmbHzzDlBtqFpYOo+UFaEiAH9pCJv4nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWFkaTRzOHc2U3N1R29iSlp0dUxlZnNZM081enAwd3FMZWdKMEZOUUVuMVVu?=
 =?utf-8?B?elpKbXllTFU1eFhqQnRHT29yREdNeDlwaElrWisyWFdrSjJLTDBlMUJCNUtO?=
 =?utf-8?B?VHlVdU1NQzF2YS8rek9GWUJpRzNDcm5vL2xMOHVZNmlWRE4rZzZGYldrc08w?=
 =?utf-8?B?aFE1a1VTaFZjZHcrZ2lZQlpnbWQ4U0JHM012NTNxcXZlT3RzRmVVeUJUOUV6?=
 =?utf-8?B?b0VnTTAxVnNOSjAzMFF5aWF4R2FrSjZBN0hlR2YySG45SUhwaUtoUFVueFpN?=
 =?utf-8?B?Wk13cmpQNE9xbkpNNElqQVphY0xzdU0vREJoT0NIN01xMTRNdTRNWDk1S3h1?=
 =?utf-8?B?aHgwTmdHekc3R0dqK3lCMnNBZHdUUWxVRGNXd0pMa3pYemduUXVpbEo1QzEy?=
 =?utf-8?B?NnpYWncxKzR2YXNhd0dkMDRmZ00ycmlHMzdHc2l1RVEvMXFQSFoycm9RaHUx?=
 =?utf-8?B?K2Z3cTlnNlJNdFhIZ212QU5nTmFseFZic2wybDFkdHF5NEU4NisvYlJSbHA2?=
 =?utf-8?B?L3FIbjZjbkxxVjMvUUV5cC9BdzYrbmZTVXRxalg5REhUcWxWc0RrYWJvMERm?=
 =?utf-8?B?MjJ2WCs5VnZyVnlCNDdPbXYweUhXemlVNyswWlM4TjZxWWNTWEYrYk5uSVkv?=
 =?utf-8?B?ak9FOHhrcTVwQW1MYWx0bEpGelljam92MFNBRWVqdDExY2ZlUkFWYnpvV0dL?=
 =?utf-8?B?VjZnVjdzQjdIL01KazlyY0FQUmJYZnBvRkFDdmx4QksvdjBPY0s5OUUveHBs?=
 =?utf-8?B?VnVscUFUblNsVENDZ0liVm5HRG9RaG5BWWlIajdMbXcrQ2lmUm54cXFxS1g1?=
 =?utf-8?B?UTV5WkNUK2V5L1QvWHVjKzZwK2VuQUVmSUNMamg2VzU4SVJYcFhXQmZ3dXlz?=
 =?utf-8?B?LzdVRXY1SStZejBoaCs3TkwzZDBGd25sdzczMDBpMkNJRERHRVdDS1pRYzlF?=
 =?utf-8?B?ZW9iQm9QUEZIZjZQUGxsdm5Dc1cwWVRSTjdTbGJ0bWpjbHY2YXMxSEJvSWNO?=
 =?utf-8?B?eEQvdCtMYlUvblNZT25JZ2h1WTNUdWowQkNKWks4Vm4ycTRKTGRwMjlmL1da?=
 =?utf-8?B?YjlDQlh3SGdWUlYrS1NVSFhTanlVS1lhRXEyRy82Vy9zRTlVMnJYWXViaFR4?=
 =?utf-8?B?M05aNmtIaTdOYUhpd0RLYlJvYWhVbXFBUTkraUIyVlRWZW50bW5uVHUwbXRu?=
 =?utf-8?B?SzJYVU1rUW5ldi96V2h4WGplNnVpdFRuSGViNHVDa1VGdmQ4Z1NHY2xDbTMx?=
 =?utf-8?B?T2RReGErVTZ6TndGV2t5R3JFSXJ4ZmVST3FVeDkyanhTcmh3VnlaR25Qdk1n?=
 =?utf-8?B?V00yRFhOaHNTeUdNbFVmRVpqeldJS2UycTJyRGtwZ21aTUxwS0hyaFBJNCs0?=
 =?utf-8?B?czVyVm5CQTMzR1RRNnQwZ2RDOEU2QUszL1RjSXg5N3g5eis1SkJQT01ZU0s1?=
 =?utf-8?B?a0YzNUZFL3dmWEVLQnhSL2M2SnVBSkJuc3d2UXdLQmpMb2VFN2ZYMFA2ZGVQ?=
 =?utf-8?B?L3NlVVRtUTJWQWsvTmJISjBrYmdXK0JXN1R2MXFseXZUZkJWU0pjeklYRU0z?=
 =?utf-8?B?c3dFTE5HV2FCRVIydE51VDM4c3JhRGM4ZTBCYW4wQWFQMHZ3a051SWtpcDNr?=
 =?utf-8?B?Y2NmVzNDaWxYTVhiY1ZnRXVjQ2JBK3diNzdWSWI1WFhRSzNSUm90QmwxbDkv?=
 =?utf-8?B?MGZpRFJJY2U1d3RQczVkYWZvNWY0UVRNK0dMVytEcFA0K2ZQM2J2ZkIzeDZH?=
 =?utf-8?B?MG5sWVlmbWg0MU05a1hIKzFYSHM2aDJHR1VhRk9IY1I5VEdNKzBDaGhqdkpJ?=
 =?utf-8?B?SkFadGUweGxSczlybDcwRHpMbmR2SWVMa2JOdDhUWEFDeEZKSlN4MnB1WjVE?=
 =?utf-8?B?SEhXTlpRL1JTVk9RMEhiVlRubWRycm9XY1VPVWcyY3dKNFUyTDFOYzkrWlB3?=
 =?utf-8?B?S29Rb3FCa1dxa3IwMkRrT3pQYmJBYkttMFdGa1J1dmw1bUN2SXQ0UjV5OGJ0?=
 =?utf-8?B?UnRESlVPd2pQb083ME9ENDlTZmFQSm5TK2ZBUVgzNksxelRiemU2dTJKd29x?=
 =?utf-8?B?WlVIcHYySVc3SXlYemtjd3RBN1RkWXdra205MHp6NTlaa1F4WmRqZEx0dWVZ?=
 =?utf-8?B?ZW9GME8rMnE0Z2NyOHJob2ZEVU9FdmtHU0swQUpvb1pPemM4TVBhL0cza3lP?=
 =?utf-8?B?aGdmekN6c3M4b09oL1FDMTJPRC9UaVBvVmtDeEpTckcwcmV5dDJubkppTGhI?=
 =?utf-8?B?cVE2cVMxUFJPOWRCT2NmcjArZmRGaGdaL0p3WUYzSGF3Q1VrVWJVUU5JQkla?=
 =?utf-8?B?ejljWm5lNGVORXhIYjhka3hkaUNaOG9KR3RsR3hSanpyeVRHWVpxckZCWnJy?=
 =?utf-8?Q?Xj1p+TPKSG3dgVNJ4H58dAZcc3Bz2DaG0gtUEygiQ2TOv?=
X-MS-Exchange-AntiSpam-MessageData-1: +pQfDtsN3X4OQdu4KBOf+ryN3oLzZggEcOc=
X-Exchange-RoutingPolicyChecked:
	LbUr/xN+Qw83UV+VkZ6UP5i9wm1TFoBxAPSI+Z2jgiHVqKPCjLMf4W7DR4/uwdMSMoll7Vc/3FjTe/eO/lZa8zEXFpcRckSHFwTkJwM6JMrKsy6Tee/CnOHZ39VXIvQeKlat9/iLhD4zdUIDZ+AQ3hUhRyENSWUsKNlN20kfeKOKxU4DvO1POs55RsdyOsyg6ZfFoJ3j9JcfTs3F8opxrbLMLRVO9tK3nVmGwAmz/2VkmgykoKa3UjsZMCF0LCtnQYmhwjqAdd9ydzrSez8TV4J0x0u58jPzn5vyaj3kPtWcE0v/FiOqmNZuLyEd8LK5TB54kKcijfxfr1NWkwwI/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FBwZYaxU2W7KLgT3uuq+f8f0X1A58Dt9UFvJwAwaQbqhF1MIzS1peLZxgAE2H50JrQ1DZsrfxuuomKElS9k3ZGGjjMTyHRz41W17qFg9N+I1sQg13w3XoKwJ40lgkfjEoq/0evXZw/VQdMbPu/YQBTjX01N4H2VO/QoqANe0pmz1FaRBpn9/wiUCz4rGF7PjLEH2BVkDdO1EbH+llbS7oBk4o5/w6tYzkQoc7NKWqigXH5Xpk0VxCXXpJHCyxc2jNHWL57RbiK4qOUbEblJxKJ8cB1BbxNJuREXBGfncG8WLXX+DFOEUgQbUNeaUo8MHLOeBCVt1HD5Lvi2d2e6Exgs6vP7WhPtO8JAka2L8PKOHXm8yzkjJ0znF/fga60cpH70gXohqeGdQtaFBpGxeJlTUiN/ZTYkYwe/EXeQo6INz6Tr0YQDCbgZQfzj0Sy8wtdIo+FFQNqpt9Cw4wQf9XwRvJKYuCK7atMzW87ela6BVpc1jiLeMiidVGBdw1WNqglgHHICUb/QWWHYelRlkh0u+IL57Q8ZPCMYhnVxcWq0dYBJzAjNTs9g81pAt/us5uw1cmu31jztlMLnlT7BzJx2aejhn74IPYdd03fHYdJxysV9e1cL55a38A5mbU8yX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f77d4d-1be1-4489-6bd1-08def85c3529
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 10:26:44.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L8Vsysb5/fiktcadcbj0XCyZMUnSrDXuIzSKpvS7gPeJ2yQY8wrDquaV9FdxK3hSPQBIa33IlHux37Le78aur0WYZZ+L5kQQLNvZwfZ/Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8633

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


