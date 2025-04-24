Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54814E2E2
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528846; cv=fail; b=HdBA+RsrCNjXdsq0zc3gec6H5Rz3Th2LAovUepB9biKefh4JDxEgGcvu+d8gV0T89AXC0gC9iJownPsAspYl3MjRKcnZ9egosgsX4jScnNzP3HO8vPx4oJW6pQQ1xIpDLmgLWacJKpNAXd/6EvSM9PJoPsWyeD6R+PYnfsuVsiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528846; c=relaxed/simple;
	bh=MTSEKFzI3ZD7tpnWlLJqTG7W7KaBlvD17VKeprwBLBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLS/0w7Wy2zuoTH/b3NSTXMKiSdV4+OsYa5FTh6dgWieaB+DNvOKPt1C1QAd9czFcOnUf8jBVnTiY3Tzq0CTdIip4Y/FToOctb+QF2nP4WHYMMNouGTR+v12lYfdIfi95fvYLVSe3EhP542bHqv0VLhtq8Sm9YBvXKAaKr3OZio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NXwppX1z; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NXwppX1z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl6RLmHm3pkB8Rq1poJekIhB4TKXtY0LEuYxhF/Ip1CUcO9YhsFGtDhsbvBeF7ISAqTbNCMG0g43VSW7Iu+Nhgnub+BhHsGeG2KEL9yK3bb9j9KcDfnt75Nybg5Jq50e/0piCfdi/vyrX2RGzcYJ/E4wI2L3AAn3Rq49R2LudC/YUBeC6Q7uj52x2D9APAvrKvyLBn5KGzaF9Eh7VDDq1oaVlbqSSkONPcO5flx2mBb0K5M2y/aN98SiSKbB2WyEUvfP9LcwP14YF14egbrIr9D1/XorBzh/hNFGOCko/HIoJb+t02g2hmjNMNNJ91Aqz3vV4x623BgbPUv/JyREyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hNympIH2R1PxLy6DiRMbFlMToZB4s2NHSJvD+a07vU=;
 b=JXUKf97o4aGEZLPiumwkq8ofvXcWA42cC9O3eOOJUyV6oAw+VsW5Q0JMsnAuz2nt/cGh+ZOYvvHLjWEU4QmX6a2Bl70S6I98yFrxhuu5FgX8B9l/sJn4zSJv7Zcc4NxRaR0CP7ECc8VKVdwLpYhBbYarGU6tWj5WO0yPn1GGR2ZSE6i2FIR6oaR7U6X6nw/Ug2FyHiIs2XFVoRNFyLbJWe9ALkRfoLeo0jl8MTCuebA3M4NqFRRoEkseB0S+/peJC/pk3uBeXhvvVnVTNDM+7KJVitBhPvu0K+jssT/SYXN3iVfWywrvBhFGuIPrcxdH31MZwimO6duiS6lnAD4ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hNympIH2R1PxLy6DiRMbFlMToZB4s2NHSJvD+a07vU=;
 b=NXwppX1zI1EcO3C0sSLSYCm7RM9ufck84R4D/jg70zgelk8zFzoPnWUqgPVDV1fVFBlvEbIzDngAAKejDPvknHreOpkiYuXv1tVfUsaYHSOKxAE1aoralwC/pNPl6LN8osMPWiIrPh4/a+ejLJjjufd+Rk32aClxr5E+30eNn3kQQHdV774BGy4HcYzk4TDBHcyabWWsZ/vvzcLI0QYfrryuyfizEY1R43jl2fyDK1swx98jZRRfnB6qFQz8biPc0dR6kRLt4BgXWJZkaAxN4tIMGwDJgZ0n/3DXE9ykJmQRhBuiuutWe64XwwL0lNzLic0kL/F7pmf6sny+Zb0d3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 21:07:20 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 21:07:20 +0000
Message-ID: <5dca544d-5d23-4269-b447-6fbcda5de56e@nvidia.com>
Date: Fri, 25 Apr 2025 00:07:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: ublk: RFC fetch_req_multishot
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ofer Oshri <ofer@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, Yoav Cohen <yoav@nvidia.com>,
 Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi <omril@nvidia.com>
References: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com>
 <IA1PR12MB60672D37508D641368D211B8B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZqUQ+n5tr=XG+sJWR_q55fzNSzLHvUZXkysOw=c+vfVGg@mail.gmail.com>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <CADUfDZqUQ+n5tr=XG+sJWR_q55fzNSzLHvUZXkysOw=c+vfVGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: b5140e84-9c59-479c-6ff4-08dd83740044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTRBRzVaaHZIM0NBRWk5Yi94dHdWTGVieGVLTkNNZ0dBaGVUKzBMajJ1VVkr?=
 =?utf-8?B?V0hRSTBmUW84WHUvQTdwbm91V3Zna0FaT2IvUndWcjh1MzJZVDdHdGlJNjVk?=
 =?utf-8?B?djVXNm9ObFZ0M095RlhURTloL2dSVHRKVk1aWjBJK3diRjJzZzIyQWpLQ0Na?=
 =?utf-8?B?RnQxNVN0eTd6VnZJeWR6akdzZUJlKzRyaU85QWV2SmZ1dVMzNkNSQ2o1dDcv?=
 =?utf-8?B?THFHY1l6ajZpMHB3VDJqbjBFblVFeU5YeTV4SGNPK1A2anpEZUFpZTNXWTNO?=
 =?utf-8?B?MVRHL3lQdC9LT2FYQVROWGVwMm9KMmhCeFMrb3crN1lBT1FvRzZsSXBrc3lp?=
 =?utf-8?B?Y3pGOTRtWjlxN08zYUJNbHo1Y3JXYmtIUmFWdE1jbGg3WWFvRVVxZTE3QmRH?=
 =?utf-8?B?TzVHY0xEb1k2QlgwM01mQjRXa0hnL3V5MEw5bVBrajFWQlQrWjNQYThrWXdo?=
 =?utf-8?B?eGoxQmo0Sy9xMVh4c1VLYUNIWjNpVzQ5NCt6MEZxZjBBdWRZY2RrVlFiUVBs?=
 =?utf-8?B?bk9QS1BqUWIwQ1NvbStxVGVqTzYrZDdYSFRXRUJJa2gwZm9BdW1mdWNML2FV?=
 =?utf-8?B?aHUxeG0rVFNnK3pvT0lZUkNYcyt6SnpDOXlwWGwyS2NyMnVaYXd5UHYxMURR?=
 =?utf-8?B?VmhWUVBMdzd4NmNKVUhVYjcxNUhvNXBkRkxhSkFXTGlyaytIcDgzOGNoSGQ4?=
 =?utf-8?B?OFZMMGVYU0ZYYkZ1aW9JakROamJsNVdtRmZXUXQzc0JHVS96VS9jcEJtQ0Rv?=
 =?utf-8?B?T1FlTW1NZkU4RGJqOHQxclJOZG5ITXFyMjl2L1N2ZUxrdHJnQUJjNW9lUnlU?=
 =?utf-8?B?UUgyaHZ4cnhkUXdZZ2NpTEQxNzRjN1Z2ZlFoc0g0cThFQjB1MzB3S0tyTkZ5?=
 =?utf-8?B?Sm5yNmo4YjA1VnEzbnVraWN0V29iNFpWWlI0T1F1TEJKanpkYk0vaXlFQTM0?=
 =?utf-8?B?Uk9idDVGaE9nYXkvZG92ZFpqYVFWRzZlOXdTTkNySWdpMGJyTUFuTnNGeDZ0?=
 =?utf-8?B?UmVJWkEwU09rSmNWZDJsWGhaUXhacTc3M0NyN1p1eHdXaEUvZDE2VWc0ZkNo?=
 =?utf-8?B?eExLOTdmcUxMTHVXMjhSMnE4Yll2Mlh1VDZTb3N5QjNndGtOeU1lM1NyOHM3?=
 =?utf-8?B?N0t5bzBaVEN2UmNWVVBlZHducUpKc3RNcDRDT1NKbVdTVXQ3Zi96MU0wQkx2?=
 =?utf-8?B?Mk1IUDJvclZIckVudHlBbUlSS0FwZEhOZkpXS2h5Lzc5aG5ZTUJxN3VDZWxM?=
 =?utf-8?B?TDJCYTNpSjlrVWdNZklTWUVaSlcrNzNaeHd1bElkTUw3eFZvTm11WUgzcTZv?=
 =?utf-8?B?VXc3SGUxeTVTNGw5Y2o5aml0eFA1K0lGY2RMMTZkK0hlQTdvTlNxM1F0N3c4?=
 =?utf-8?B?dHUybGFwM3U2bEZwM0d2RzNRMjZrdDFNaTFhVFZJaGU0SllzRnFseWlUb3Ay?=
 =?utf-8?B?VU5XMUc2N0pvZFZGY214TDZHQ0FGYmVZekJYZHJLYlkvZ0ltbEV4TmZyVHQy?=
 =?utf-8?B?YkdHMzJDeDczQlJ3Q0h5cnlTaXB5am1pYXFkdDNPMFpaaVlJTTJuSUNSNjFz?=
 =?utf-8?B?bkM2MzlSYnlXeE90dVFiYS9NT0xFYzErbnpnRTFsMndDOGVOdHQ5K2ZUbFNI?=
 =?utf-8?B?bXljdzZ2UGtoS2tvZGVRenFURERjdEJQZVlHektKQ2g0SlBCWmx3TE9CRTlL?=
 =?utf-8?B?SVp3eE1IUmNGV0dlWjJDQ3owdHlIekttUUw2YWJYNVlad2VZMUVLMm1yYWhI?=
 =?utf-8?B?ZzBVZVgwNTNTS3VoekEvZEh1anVKbXJURTIwbHpGd3d3NEJrRy9HM3h3VVc1?=
 =?utf-8?B?SGx6dnpqcXZjZmEzTkdwazRwRzZobFVYM2pLbWY0SzZjUnR5MFlQRG04VjZ2?=
 =?utf-8?B?aVEzTHFRSzdOMTBVZ25qUFBCeTMvTVU1anZrclpYMzR0dlpIc1RvREpReHFu?=
 =?utf-8?Q?9ftWi49HyY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDlVRmRueHFid2V1NSsrdUtTOUh1cGtnUDBoSEVxTkdVamM5YTZzaFljQzNQ?=
 =?utf-8?B?M3JsS29NV1FOMjZ6bHd5bENvZnd1aUdJYTBsYnRkbWlFWldiZWpzaDYraURC?=
 =?utf-8?B?SkQvSnVjOWc2UkF6YnNHYUNUWmdPaDVyZ1VuVlJVaGNkSWZ5VTZUREwzZlhD?=
 =?utf-8?B?NzFsTXdQT0pmbFNuU3NGYk1ja05JMDBHVUxBREcvZ0Q2MWcycG9tOHF4K3Nz?=
 =?utf-8?B?TndKd1M1TndUNkZuWktlZGdzR0x0cjlSVVozTG1GWUxOU0FZWUZpQ3YzRUlY?=
 =?utf-8?B?Q05tSlQvWlI2dlY3WUkwRGJjcUlVaEZpNjBLbUU2TXdZZDNSYXA0YmdId2NN?=
 =?utf-8?B?dUVldVBYRndINlFtMXZ4MkRsTTgzcFZKc0dPV1BEWkNIM01sMit0cUdVSUhL?=
 =?utf-8?B?cWliNmFJVmdhakVnUU9IZ2xyTXpxVWNMMlg4ZzNjVUszUEVqZG1DQUFSMlR5?=
 =?utf-8?B?dFlKenhvczZ3WWtsQmZ4RmZqeHQxeElZQjZweDFiSlVsZmRJajRxc2RhanlK?=
 =?utf-8?B?bXdZU05oczR3K0JWRkM0Sjg0S2tVLzBReGdrc0VqRnJHTWVoZUt4ZGxxZXBS?=
 =?utf-8?B?VERHZFYzK3BtUWRoT2srRUxzT3ZReDcxZS9iUk9Jdit4RjJoVngwUmJ6Q215?=
 =?utf-8?B?SE5wUHhLNGFkSDRTbzFNaWZtSEtqZjZQd1BocEhHY01FcytOKzlNZ3V2OVZR?=
 =?utf-8?B?L2tWRm9WazJWYkFROEkrTFZOOCs1YU5Xd003S0tWbklxZFFONG1WclRuc0RW?=
 =?utf-8?B?aldDSkxZa1BqRVd6MEdiYmxDU0ZScUFELzFXdC9VdE15NURTdGtTbmhFV2ZT?=
 =?utf-8?B?V3ZsVUt0U0hkeEpsTEpBWml5dTZ2SnRyQjk4TWpJYVRtZ2J2QjBXL0dpRU4r?=
 =?utf-8?B?Y2J0TUVKcHdqclNPWjZtaWg4bHdJK1BYdnB3SXI0V3JjVFBDUW5teGhFQUhJ?=
 =?utf-8?B?eERuZGl3THUyMTY5b1YwMVkvbzhBN2hiK1hSNVJBaG5mcG5RTzdUaVdJSjFY?=
 =?utf-8?B?OHRlQXphYVUyem02ZWdsVzZpajlnbW1RTlZTSWZHOHhha3prWk9WWUI2Y0FH?=
 =?utf-8?B?UFp1Q254WjJwUTJOWS90MTNKUFdZdlRReFVyTjNRU1hlZDBWcTlIdGpEYWdT?=
 =?utf-8?B?NXliaVRrYTFvK3RiekRzTXc4QTJIVnVWaEZXNGNqQ3JoN0hQQmJiblJtcHVn?=
 =?utf-8?B?UW9yTytWVDloN1NvSm5oazFEWitqSUtPTHVzSURaMXM3U3p0UStOa1R6amI1?=
 =?utf-8?B?WEM1OTFwa1dxSEIzZzh1MjBQdklnY1V6cGVXOGVBUHgwNUdJSzkwODZKWVlU?=
 =?utf-8?B?SXkyaVdPNE5wS0dHUFAxcTRKVUZlZm5BWVp2SXNyaHFEb3FjaXBMRTMxRjJr?=
 =?utf-8?B?dzhKQWhkdE16TzlrNDg0aXVsUGlhc3dYR01qT1Ara1pjYVdoMHZlR2dUVHRM?=
 =?utf-8?B?cmNGcUR3dC9WTTRVYXc5R0tNZnh6WGpzQ245aXJJK3ZvMVpuQWZUYVRKTmRo?=
 =?utf-8?B?UkZCUjJlUUVwUFhSeXJwL0FIWmVhbGJVMGo1eTEwVjBGeHRzanVaOXdSNGdL?=
 =?utf-8?B?QUhvUjh6MVNtbE9Sd09pVE50OFhjUU9mYm8xNEh2R1V3MzV0MUFsOFJTQnd2?=
 =?utf-8?B?aW5hTDkwZnJoM0FQZ1VtSjgxbFFhb2hxTlR0eEozY1BoUGk1dzQwcGtOM1FN?=
 =?utf-8?B?TCs2Ry9WWUJtc00xME0zVmd2YUw2YTU0UkhaK2g3Y0R4eG8wSmR5M2hsdDRZ?=
 =?utf-8?B?Z0NIMXBzVEdzZnBSenZBeE4rcUc0MDVBZ0xwVGhOeXBxbEhsaS9MSGUyc0h5?=
 =?utf-8?B?Q0V4enNMUnJFQjA0VHhrK2NLYmVicWZuNHRzN3JBWVFOK2RrWWpOS3dJaXBJ?=
 =?utf-8?B?TWYrWGNnbzJyWU13RllzWEVnRGQ3aVRFNjVmTkxrQm9nK2FzQThvVGhqUTdw?=
 =?utf-8?B?bmk2aGs2MXlkRFNOVm45N1BNUy9vVFdoLzdUQnIrOXA1dWNYdndHc3pBN1N2?=
 =?utf-8?B?akxsYVBYa1FyMmNQcFFBVFpHaUYwa2JDWm5rRWtaNWs2N0VCVW80dWVVOW9r?=
 =?utf-8?B?c20xdFhMdXNpQXVZMFIyWU54cmpyV2VLNTF1V2xlSDlkbzM2UnJMVWZnTmFB?=
 =?utf-8?B?TmMvejJsZFNLOGFPREx4K3hQQjUrRTEvMlVTamZTR1dLMzVXYXZoN3hKcHk1?=
 =?utf-8?Q?kezlT19MBwrHFIw6e/aXpG9WBoqZB3Uue48j80E6bjBf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5140e84-9c59-479c-6ff4-08dd83740044
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:07:20.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktLwcI1/VXAgLCEJcNT0YdvoNYHTvZ5PX+58ZvwXlJ4yc0ijcZbHrvMzBFJ4vTiH8Texjrm2ktODPqbSUoF99A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086

On 24/04/2025 22:07, Caleb Sander Mateos wrote:
> On Thu, Apr 24, 2025 at 11:58 AM Ofer Oshri <ofer@nvidia.com> wrote:
>>
>>
>>
>> ________________________________
>> From: Caleb Sander Mateos <csander@purestorage.com>
>> Sent: Thursday, April 24, 2025 9:28 PM
>> To: Ofer Oshri <ofer@nvidia.com>
>> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; ming.lei@redhat.com <ming.lei@redhat.com>; axboe@kernel.dk <axboe@kernel.dk>; Jared Holzman <jholzman@nvidia.com>; Yoav Cohen <yoav@nvidia.com>; Guy Eisenberg <geisenberg@nvidia.com>; Omri Levi <omril@nvidia.com>
>> Subject: Re: ublk: RFC fetch_req_multishot
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On Thu, Apr 24, 2025 at 11:19 AM Ofer Oshri <ofer@nvidia.com> wrote:
>>>
>>> Hi,
>>>
>>> Our code uses a single io_uring per core, which is shared among all block devices - meaning each block device on a core uses the same io_uring.
>>>
>>> Let’s say the size of the io_uring is N. Each block device submits M UBLK_U_IO_FETCH_REQ requests. As a result, with the current implementation, we can only support up to P block devices, where P = N / M. This means that when we attempt to support block device P+1, it will fail due to io_uring exhaustion.
>>
>> What do you mean by "size of the io_uring", the submission queue size?
>> Why can't you submit all P * M UBLK_U_IO_FETCH_REQ operations in
>> batches of N?
>>
>> Best,
>> Caleb
>>
>> N is the size of the submission queue, and P is not fixed and unknown at the time of ring initialization....
> 
> I don't think it matters whether P (the number of ublk devices) is
> known ahead of time or changes dynamically. My point is that you can
> submit the UBLK_U_IO_FETCH_REQ operations in batches of N to avoid
> exceeding the io_uring SQ depth. (If there are other operations
> potentially interleaved with the UBLK_U_IO_FETCH_REQ ones, then just
> submit each time the io_uring SQ fills up.) Any values of P, M, and N
> should work. Perhaps I'm misunderstanding you, because I don't know
> what "io_uring exhaustion" refers to.
> 
> Multishot ublk io_uring operations don't seem like a trivial feature
> to implement. Currently, incoming ublk requests are posted to the ublk
> server using io_uring's "task work" mechanism, which inserts the
> io_uring operation into an intrusive linked list. If you wanted a
> single ublk io_uring operation to post multiple completions, it would
> need to allocate some structure for each incoming request to insert
> into the task work list. There is also an assumption that the ublk
> io_uring operations correspond 1-1 with the blk-mq requests for the
> ublk device, which would be broken by multishot ublk io_uring
> operations.
> 
> Best,
> Caleb

Hi Caleb,

I think what Ofer is trying to say is that we have a scaling issue. 

Our deployment could consist of 100s of ublk devices, not all of which will be dispatching IO at the same time. If we were to submit the maximum number of IO requests that our application can handle for every ublk device we need to deploy, the memory requirements would be excessive.

For this reason, we would prefer to have a global pool of IO requests that can be registered with the ublk-control device that each of the ublk devices registered to it can use.

We understand this is a complex undertaking and would be willing to do the work ourselves, but before we start we want to know if the requirement is reasonable enough for our changes to be accepted upstream.

Regards,

Jared

