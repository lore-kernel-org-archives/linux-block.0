Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896439448B
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344638; cv=fail; b=DNPpE4Aa0WPi8xtGSYhO5T0cMDG3/WNUF1XW2r07Kn1sbEo+hOcNCqvrhMn+/vCAAJsageftFS/ywgMZX/kdAVjymtXV7+FDMiTXm8HQHQKf+Iu6l56rUmXi1qV8QDZPEED9uxWBGEmFT4VteR1Vzh8rjU9sVmWBvNicXpWYiw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344638; c=relaxed/simple;
	bh=ZMGxQA4a8BGiAWTr7GVtNBmqmfGJiYKjQdpQaa8uO3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YD4iH4AbXpQWMbuEZgo4QibZHqT6wZ1F74lr6Fd4mDNuaEXb89WrSPSIuAWAsaVggZ9Sq8jD9DSCF+nZde8rTjL/YVqGUjfhCYcrGAaztSOjzDBN0NrQMycdZKBJFuo0oj5Sz/ilwhXA02sFAa3WzzFwAFPd5qyVqPFWUnltjFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGIfTkoa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AVV0gPDP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGIfTkoa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AVV0gPDP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G5LEf42136547;
	Thu, 16 Apr 2026 13:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pyCMRW0sQ2uhgr+bk8siTvdhJYk/KYGuHVRe1s4uf7w=; b=
	hGIfTkoac8mRjB7dXesg+jHB5BuGJkOTSlZpp+3k+f5JWXgZj2aWc0NNV9KWePBP
	kCSCQ1YMmsadvz03ZfoFTsAIVaJJu78ze7VuICpwJqH7WfoMtmpR3K1vZ0ioAwLI
	9qwgpDSt1liUqVCyTy9Iuokr5RgQ/EAuEGW6iXTO4x0MnMAaVYhTgihKUcejnepV
	78HzFGVhZX3/nUamGmDg5jaFPjw5KZMDmd2+VjIF6LufE48c9eOZgMoHXDxucw5G
	sGq9zPtpw6eVTjMJ0L7ZVmMHzhUI/hMRw1kHb7LPWVsgn7mscpQl2qQOmkwPbW8d
	D5KkcsVqGUeaSjC7M47sMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh8687hmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 13:03:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GCsWYZ010284;
	Thu, 16 Apr 2026 13:03:50 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh9jryaud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 13:03:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpF9DXhlJ1JE54kkScM5w6mPBsKlVMyg32dlfVable/OIPBaFQo3qy6gF7hb/mrLQNUhhM+nUhHJX4UJ+Bn70g7I3TMCLFU+0gzS9TAcTADth96BqbjQLfmZ0LJqGB6t2Uwwh7qhmTCRZL50HwRgqA1LL3ML99WbZJYagfvqLbyWkbFqqa2ukIYAC+NFlA2+Yoo9710Vg0UqSV4xMJPNzrU+nQLjVR+ezGDj+FfTvmqmpqIl5q8Jy/yN+Eop/1ocNdg6BMldooKF5X/5uoziZPru+a+CXVrED8iYG7mgYYIHIgZKYPZ4vwmk118uISANptqTwBv56g2WBW83KUl+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyCMRW0sQ2uhgr+bk8siTvdhJYk/KYGuHVRe1s4uf7w=;
 b=X+eQVvLUxhJ/G8JuosVILUQAwSoXHh1vnRORvrtCh1dDCqxnp4XznqDddfgXcyNYvz+JZNEQU0s1vz1g+4hk9Us0QbdybH0wBYgTy1VIoKTWuUlebLs8NE6PxUUv1aEUXcScP8xbdAQ/dDQbyL9FtvCHOdRGlUoS91lLNqrSIZWQajjiVaDa/LUyEbSBRoBV0dVvzzMZuFRaCPBao79GlN1LJtDS24LYsC+xCv/rPhj5pPnu9NBCggZPFA3dNivBHujXZ/Mq0iZkeql1otJ98m534bt+Q6AnhQYu2s1p0tjU2c5kcPuIhkOoafJu9XoZL0qrwtEAhIHjyWzb8lUVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyCMRW0sQ2uhgr+bk8siTvdhJYk/KYGuHVRe1s4uf7w=;
 b=AVV0gPDPF5g1wPfzF2H2gETPvFWXKU94LGbv16S6RNasNjQjY5vaub8DvH2wnJAYtFcbXrIVG450pv5vv5DUkq8IpPaTQJqtms8qWfkLW1s3B4QK2wYS1NT206LFSCEZdX5ak8hZqCl/z31w3HQfPrdBKucLakg5ZkLRu1RJlkM=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH0PR10MB4581.namprd10.prod.outlook.com
 (2603:10b6:510:42::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 13:03:46 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 13:03:46 +0000
Message-ID: <b00f7f6d-278f-457e-9151-7528ef7d61b4@oracle.com>
Date: Thu, 16 Apr 2026 14:03:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "nilay@linux.ibm.com" <nilay@linux.ibm.com>
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
 <aeDYE1BfumNvutvS@shinmob>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aeDYE1BfumNvutvS@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::15) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH0PR10MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: e6010dc0-0a12-46bb-daaf-08de9bb8983c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cM7eGRAQyC8kvxO4Qs0OvF8atXnUDgDxYETg8beifVbKk3Y/cqssgkWrySe+ZwagC8pfdl382Sfzkd7IxBeklaDczMlcV1nl+atwD+A+de24Bhu6OdL8L4C82sXsoS0sfn+qoLWnMsDun1DP6HyMRr5U3wpZcDayegvj1NSv+Sc0TpMgyG3J5FeoSk1LtFwCRZqA7IvlZu7KGTzkCVptZom+uk7UMjYPIJCkKXYOjmaPwF874d3Gxq6Y1lbIWCZ6n0GoIJhPPcdmpcUNTzWzJTPj2NoKLMKAnqX9UisbtWKFlDwBAPIgN+P4eX7FbfdQhgIzAH8cEM3TvxYFU2NSos/7OiN/7Huw/vSc55+JoXRx5qI76NZL8EqZqTgqMLrLTbKxDPt00nAw+Le2OPhoS0Ve3GERLmcUoKwaMVUb2xqKHI9allBZW79LNHk/Z125G45RWBqBEV9Er3jEO0iizzYAtvRTraaCIIz9L+o01f5j+b5HndSoKHsEbMfXlVEmXZI3T6Vn3K9PvpU4aG8X+iSDfuFjo76tq7QT0xNGK3maDUpFeshQnVMXlSepHgZE/wl5KsMUv2Pr8nCALCm2JmQ/YHZ0WkWO1ozmBw2yqFSnVeo1nyNEvpQJYfAXT3fasW39sQ8GCZnCUsu2Hv7stgs84MAWXsI8c698j4I1Ny58vk/7gt/QncQamLrZ8slo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0NERFJkUzBjVEpHaUJRbGFIZG5SdHpsVGdTZ0JoUjhLMnpDLzJnTmFjYk9D?=
 =?utf-8?B?enhrdHNKc2w4M3QvbGlIalU1dTRTSndPY1ZLYUljam5XVzlnVnR2NTkraHBS?=
 =?utf-8?B?RkV5ZDFaV2ZFRHVhNHZlUlh4dUZLTVdzRUJSbWRpVXlXemc5NU9iU2Q5dzdL?=
 =?utf-8?B?L0gwSjUxWHV6QWJrRWhlbE1hem9EMmFCOWh6MGpkQloxSW5RUFZtS0pDbmNs?=
 =?utf-8?B?Qk5GS1ZIdlk1N05HNzFLK3l2RzhuN0kvNHh1OGdKODN5UzdiTmFEQk1wWWhO?=
 =?utf-8?B?U3FPajhScThjeEhPTzMvakRkcS83VGtMUlV5alFNeXE3R3FFdGhnSWxOVkNi?=
 =?utf-8?B?a1JFck93aXNrZXlwY3NYOWxvdC9oRTRiOWRCbXNNd1Myek9vZDliVXVSZzZk?=
 =?utf-8?B?Y1VBQUpRRXZCYWxwSUlHUkdXY09XOWFFeUlmSDlMRVhXN3pLd2gycUM1M1VQ?=
 =?utf-8?B?dzlpU3RyOGYzN3J2YmxSRytjWllYbW1mcnVzeXNEeHBiNzJqZHZyZmp6dTdp?=
 =?utf-8?B?Q1Y3N1RSTmQ5Tk9rUldNRXJCTEQ5Q3duQllhbjBZRUxaYVFzSm9VV0J3dlpz?=
 =?utf-8?B?VzVsSkk0eVlaVDBQWmRyaDZvOTJUWGFIVHVIYm8wNVpHcjJJZjhPcFVUbmFT?=
 =?utf-8?B?ck1TNUg3MFk5dXR1a1Q1Sy9NQzFDV2tjOEtBL2NQRnByUVl0Ym9kVWdZNjVF?=
 =?utf-8?B?V2FETGhVampCc2xQUUV1YjFrWWtxS2pneHp0VXltMDBlV1lPREY5dUpYellk?=
 =?utf-8?B?eTlkUFJ4cmVBTFNyUjRlQ2lkY3FqTFpHYitiNzJVWGgrUnNNWXdKWU9CaUps?=
 =?utf-8?B?NHJ3YVR6TFZ6d1BHWG1QTWpnL3lZaENTeWFFUnViMUkxMmpXWTV6QVg5RDRX?=
 =?utf-8?B?Y1dLdlFWait2RmdlNlpBSm9nTGNjN1lHV1p6SHpXMVpsdE1WYkZsRXlqVmpN?=
 =?utf-8?B?dUNlclhKeHdGNmlBYmlTWVEvcXJYNGpaSHlBZzQxM255ZG82MDQ4Tmg3ZjBV?=
 =?utf-8?B?TVdRd2VIUGl1TTF4dVRaLzdDU25ZcFd6QWpOVkR1bEdZNjFvK0ZDcXptcnh0?=
 =?utf-8?B?Vm95dUJmWHFBVzd0YVJYdGhBNlByUWxpc2wyZVl4RWJQZU9ZQXRYL1RnTFFu?=
 =?utf-8?B?amdDNG53czZDaVhTUGdGcFBsdndoNkMxZWZjQkxtRW9EblhGb2xRelFTdXpI?=
 =?utf-8?B?alBwVFJSUFgxYTRaYUZKVTZ3cVBIbUJTU2Evb1FJTlAyQURnVEo0Wi8zUHA2?=
 =?utf-8?B?MnhGbG43bEZ6Z283eDAwTXJHeDk4Yy90VmRaMEtHRVVhUk5tQXNFRVRCbEpK?=
 =?utf-8?B?NkVVOGhhemx4eGpsY3h0UjlacDdaQm02UlRDMDh2TnFJQXV2S0RzZks1KzhQ?=
 =?utf-8?B?Y2pXbUVaVXBiaTdjWmFtWk9IZ0tvRnBXdFNwNElzdFdISjE5THZOUlM4NkFm?=
 =?utf-8?B?Nm9kUitISnZ0d1huc1RRbXdDQTJmbW9MeXJPRktmR3hLdnJtNU5VNGp1RUZX?=
 =?utf-8?B?Z0FqeXFSd25FU0hBcEdscjdQeSthRjJXaytoOUgxUFlZKzRLU2ZYdElmUjA3?=
 =?utf-8?B?ZU4zQmpHTmtxZElhaWRYKzM0L2FGL2FWaVh0Q0hGVm1qRnpWcEpFTnVSVGpw?=
 =?utf-8?B?b3kzSUJxMUxkMEhwaUNVT1Brejl2VE4rV0tlNUR4MndOMXpDNHNHMFBHU3FZ?=
 =?utf-8?B?MVlkbzR1Rjl0QStwcFFaK28rMkhSdkR4T3RFaTB6Tmo0NWNnWGJyL0w0NFFy?=
 =?utf-8?B?RisxWVc1M21vMnhlc1pmbWZoU3lpUmMvdVRYMm1SWmxucjl4N0RPOUdhRi81?=
 =?utf-8?B?dy9uV2g0WjlyQmRXWGp5ckhDeVg3ZkdQbml2bTNwK3JhUTRHWUZyVWx6dnN6?=
 =?utf-8?B?WTcyK0s3NVI3a3RQbXZhOTkrSWNiSVhiWDZ6dFlTUkRMUzJUa2dYdGVmQ08w?=
 =?utf-8?B?Yk1yQzY5emZSWEFYT2RubUZYRlhKajFkTzYwTVFRRHpkSHF4eExaYmlTWkpU?=
 =?utf-8?B?UysvUnA4ei9IOTRiNURIZ091L0swQ0kxZ20zeDFBSkNuRjRUM1lSbzdWZHFP?=
 =?utf-8?B?bVd6cFgwYnRtK3JMdWFqOWs4VWoya28zaklZcU5hbHlXcHYzVkhpMHRBTWs2?=
 =?utf-8?B?M2kyMmJiWnlGSGJVUWZnWkhGbUttZ25zVWFzekdaa1NOSmgzVlErc0dYNUMv?=
 =?utf-8?B?cFJHamFHTytCTHp6WkF6NjBrL09xbXZEN044c3FyaFlUY0dQNHJiQW5OZzdY?=
 =?utf-8?B?MTNJTUpaNlR1UW1xRVJ0bHRUUllwaWFNa0Q1VFNXS0dkRDV1UHVxaFIvVUZs?=
 =?utf-8?B?TWtPWjIzeXl5bDJwMDFkOG9ON1EwYnRtcU1zbmlOVnpVN3Y5T0d1Y2hhZFJS?=
 =?utf-8?Q?Yhs/BDci2XCnyWC4=3D?=
X-Exchange-RoutingPolicyChecked:
	HJ42ZWXNhJ1pe+QCY5qTClpOCEu5NiLUGKpYAnBedwKFXVCbghdvmMR1yOWHOE3WAIPPGFYj4SfV6iVZHFgNYwTxglHP53gFnJOl3U+9rW4vENMrKv56fAf7HKWTyTRp3WnosFr2SYArSZpxektT0y4AP24fKp5sbyf6tIfJNMjAxu3GCKEcwgDDxdxAGT6j8D1XLzB6q7BLZEiRqM9w4glzsPdHgrbht9/62hKzV7UHAoItHc3qUdzuS71/dHuGwiD0o6AfD5pkoFwnhxTQcUjgFWQF2OvwX8AE4Ky4kupqm0CwVh7NJgtoomVA3GZPWIKFXSZoPhBIz/CQWTV20Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5US5RBlsjd1PF76zSoMrh1v5ghg61Dq3R45i9B1S/ejDu/0Eah8KJi3fKrq33KvGb4dkqph+wqK2b5Di1vuoVOZsSbWWjh/zCPgqILNCH31rWuXVMIH6nA8Sf4iifiUv7NLZ2ZufmMU+aQnM+yxxgfF83PNkifsyUp+yUp4DGb0U36apk+uIu8+LVdUt1/Z4jTHl8M/n+LWxpXxjA2yodGkhnIgDCNFikTaV5ZDKYVMRunxvizPwXJVa3AgI6cOA1wE3DrjEqIT9AI5l3l5Ca5YJxbq0ULukY4D2i06q5qfrTeEeL6eD2/w6xLqEf4LAMngfDmGaTI8L/GEBKtaLK+zD2C2V9ecbPpxVo9JephbYtftvsznmvtzR1iRFKhVCiwMpCLJo6j5rcMHs2cPtET90zkeitRGXdTFM7XqTTUnKPvSO70iaV1Sjl8ZzG29rjeN/GJEsRsOa8vMBvJymt62QNzwExcLTT2Kca3CC3CqG8wflmlhrN0Fg753oDmGpk0lS0a5/GBAF8EICrMhZuYf8TI3zb6JKUnP5u6gOlYIbPSwVmfYEucQUy0iT3AY2gC9q+58QAdUzX3h2ENx5z4jOhDOyva/hx9OaafKYILw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6010dc0-0a12-46bb-daaf-08de9bb8983c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 13:03:46.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rITQnwyKnsakWE09qiA+AaUlQmH9cbBP+X72B8ftGgNGyoMHjjiwU09Gi8KJ6+nf0usdxy/jwlArWdzzSmkZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604160123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNCBTYWx0ZWRfXxHktS5n93UZS
 cRt26SC2VrGhxZVK2qKvkTjBOm/QT61UZ7Kn3hBMfZe0av1YyUoxCZgsERckV1uN/NXir/9AJz9
 xHiHJQ+FxO26HWBp4Bi4+Gg+9cm88MOkVV0f6lMHVuIxKPn8meBev1+RWjBJab3kHFDRgYRdtb4
 UDc+NfqcMVC/LFN0Q8Pdmaw0dOULKPf8s9ZlgRzQDyTyT4G18os6VRvOkrHnLnpNQ35m0V/pxJr
 uW3lHaXdRxmIuCyJkm3D8JGl7nZfolmsbzQamj8ZoKDj2Iawjlc3zT3/NdA2+JxqjSlD5ZwxOoX
 /TNXoEYIC7+4K/dSOnEYXVnVAESHC5UwbGKQ7+OGKe0RgsWH7UESKJm3WkdDWNb71S4kl4+vqek
 niUTGj8C70YzUwyyZPMwyu7d5cKzVdjp3sbwXXIo2pbrohIPTqHYEoz9Hkl5Ug4O9NVSXWO1251
 /Wm2pwbKAE5Ln5CBqeA==
X-Proofpoint-GUID: kFAcOaGSAOOO3vmAcZIKLD0q8Q9aoirB
X-Proofpoint-ORIG-GUID: kFAcOaGSAOOO3vmAcZIKLD0q8Q9aoirB
X-Authority-Analysis: v=2.4 cv=JY6Ma0KV c=1 sm=1 tr=0 ts=69e0de37 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Y3i4mjkzfnfap4cgRC8A:9 a=QEXdDO2ut3YA:10

On 16/04/2026 13:50, Shinichiro Kawasaki wrote:
> On Apr 15, 2026 / 10:41, John Garry wrote:
>> For NVMe multipath, the delayed removal feature allows the multipath
>> gendisk to remain present when all available paths are gone. The purpose of
>> this feature is to ensure that we keep the gendisk for intermittent path
>> failures.
>>
>> The delayed removal works on a timer - when all paths are gone, a timer is
>> kicked off; once the timer expires and no paths have returned, the gendisk
>> is removed.
>>
>> When all paths are gone and the gendisk is still present, all reads and
>> writes to the disk are queued. If a path returns before the timer
>> expiration, the timer canceled and the queued IO is submitted;
>> otherwise they fail when the timer expires.
>>
>> This testcase covers two scenarios in separate parts:
>> a. test that IOs submitted after all paths are removed (and do not return)
>>     fail
>> b. test that IOs submitted between all paths removed and a path
>>     returning succeed
>>
>> During the period of the timer being active, it must be ensured that the
>> nvme-core module is not removed. Otherwise the driver may not be present
>> to handle the timeout expiry. The kernel ensures this by taking a
>> reference to the module. Ideally, we would try to remove the module during
>> this test to prove that this is not possible (and the kernel behaves as
>> expected), but that module will probably not be removable anyway due to
>> many references. To test this feature, check that the refcount of the
>> nvme-core module is incremented when the delayed timer is active.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> John, thanks for the patch. When I ran the new test case in my test environment,
> it failed. The reported refcount mismatch looks happening in the Part b.
> 
> nvme/068 (tr=loop) (NVMe multipath delayed removal test)     [failed]
>      runtime  38.579s  ...  38.770s
>      --- tests/nvme/068.out      2026-04-16 20:50:21.228000000 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev_tr_loop/nvme/068.out.bad     2026-04-16 21:30:36.215000000 +0900
>      @@ -1,3 +1,4 @@
>       Running nvme/068
>       pwrite: Input/output error
>      +module refcount not as original
>       Test complete
> 
> I have no idea why it fails. Do you have any guess about the failure cause?

I posted a fix for this here:
https://lore.kernel.org/linux-nvme/20260416051459.GA14802@lst.de/T/#m17eb549aba102198009a37621cb45775841639d9

I should have mentioned this when posting this patch.

About this specific part of the test (checking module refcnt), I was 
wondering if we should be testing kernel internals like this. But, since 
it found a problem, I suppose that makes it ok :)

> 
> Also, please find my review comments in line.

ok

> 
>>
>> diff --git a/common/rc b/common/rc
>> index 5350057..6eae0e2 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -117,6 +117,16 @@ _module_not_in_use() {
>>   	fi
>>   }
>>   
>> +_module_use_count() {
>> +	local refcnt
>> +	if [ -f "/sys/module/$1/refcnt" ]; then
>> +		refcnt="$(cat /sys/module/"$1"/refcnt)"
>> +		echo $refcnt
> 
> To suppress Shellcheck warning, please add quotation marks: "$refcnt".

ok

> 
>> +		return
>> +	fi
>> +	echo ""
>> +}
>> +
>>   _have_module_param() {
>>   	 _have_driver "$1" || return
>>   
>> diff --git a/tests/nvme/068 b/tests/nvme/068
>> new file mode 100644
> 
> File mode 755 is recommended for consistency.
> 

ok

>> index 0000000..e06fd6b
>> --- /dev/null
>> +++ b/tests/nvme/068
>> @@ -0,0 +1,118 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2026 John Garry
>> +#
>> +# Test NVMe multipath delayed removal works as expected
>> +
>> +. tests/nvme/rc
>> +. common/xfs
>> +
>> +DESCRIPTION="NVMe multipath delayed removal test"
>> +QUICK=1
> 
> It is guided to set QUICK=1 for the test cases which completes
> "in ~30 seconds or less". In my environment, this test case took 38
> seconds, so I'm not so sure if this test case is quick. How long
> does it take in your environment?

I think that I will drop this, as the test time run should be > 30 with 
the delays, below

> 
>> +
>> +requires() {
>> +	_nvme_requires
>> +	_have_loop
>> +	_have_module_param_value nvme_core multipath Y
>> +	_require_nvme_trtype_is_fabrics
>> +}
>> +
>> +set_conditions() {
>> +	_set_nvme_trtype "$@"
>> +}
>> +
>> +_delayed_nvme_reconnect_ctrl() {
>> +	sleep 5
>> +	_nvme_connect_subsys
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	local nvmedev
>> +	local ns
>> +	local bytes_written
>> +	local refcnt_orig
>> +	local refcnt
>> +	_nvmet_target_setup
>> +
>> +	_nvme_connect_subsys
>> +
>> +	# Part a: Prove that writes fail when no path returns. Any reads or
>> +	#	  writes are queued during the delayed removal period. If no
>> +	#	  paths return before the timer expires, then those IOs should
>> +	#	  fail.
>> +	#	  During the delayed removal period, ensure that the module
>> +	#	  refcnt is incremented, to prove that we cannot remove the
>> +	#	  driver during this period.
>> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
>> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
>> +	refcnt=$(_module_use_count nvme_core)
>> +	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
> 
> Shellcheck complains about the line above. I think it can be modified as below:
> 
> 	echo 10 > "/sys/block/${ns}/delayed_removal_secs"

ok, I'll check that

> 
>> +	refcnt_orig=$(_module_use_count nvme_core)
>> +	_nvme_disconnect_ctrl "${nvmedev}"
>> +	sleep 1
>> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
>> +	if [[ "${ns}" = "" ]]; then
>> +		echo "could not find ns after disconnect"
>> +	fi
>> +	refcnt=$(_module_use_count nvme_core)
>> +	if [ "$refcnt" != "" ] && [ "$refcnt" -le "$refcnt_orig" ]; then
>> +		echo "module refcount did not increase"
>> +	fi
>> +	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
>> +	if [ "$bytes_written" == 4096 ]; then
>> +		echo "wrote successfully after disconnect"
>> +	fi
>> +	sleep 10
>> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
>> +	if [[ !"${ns}" = "" ]]; then
> 
> Shellcheck warns the line above. I guess it can be as follows:
> 
> 	if [[ "${ns}" != "" ]]; then

ok, I'll check that

> 
>> +		echo "found ns after delayed removal"
>> +	fi
>> +	refcnt=$(_module_use_count nvme_core)
>> +	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
>> +		echo "module refcount not as original"
>> +	fi
>> +
>> +	# Part b: Ensure writes for an intermittent disconnect are successful.
>> +	#	  During an intermittent disconnect, any reads or writes
>> +	#	  queued should succeed after a path returns.
>> +	#	  Also ensure module refcount behaviour is as expected, as
>> +	#	  above.
>> +	_nvme_connect_subsys
>> +
>> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
>> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
>> +	refcnt_orig=$(_module_use_count nvme_core)
>> +	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
> 
> Again, the line above can be modified as follows for Shellcheck.
> 

sure

> 	echo 10 > "/sys/block/${ns}/delayed_removal_secs"

Thanks,
John

