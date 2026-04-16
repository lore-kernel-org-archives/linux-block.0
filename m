Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D42224B15
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339950; cv=fail; b=H6xU0LikkJ5UaWRx5/70+CTjfoTuENBdTxgwTXfXTVUi+m/LW1U7Qp6XHa6YOSqgrsnDuwavA/y0hHy0Pw//lifufTxiaBIablOISdXjcqzuuUhqlZCFxsRyV3EsvsRFPzePhwhbOt5DoyFQDoDT3/lISo0YGZXeJ5+CNn2xhL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339950; c=relaxed/simple;
	bh=1E8tgM0VMHXETwT++ChtXYvtngu4iVzkFXvKVesWC3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LqdexVT1bgS/5jXIWrlwQ0eSoMiiSC4IeADq9F1bGaPWLvItT/1faWwLYnmon/evOvw+nUMHVuNViZ/IbHHv3XGW7md7884rsjLAMbRJsbMbEY0thp7y64YKA+EdruoIv/aEdMn1Qihs+HBjk/fF1FUbP9ON/UQf98XzotdbUCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=getHSvgT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s36kWFOD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="getHSvgT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s36kWFOD"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6ZTmG2136605;
	Thu, 16 Apr 2026 11:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DgBGooI3rh7GC8qdpGvNtOBVhMpLZzhCzaqXguEpIbU=; b=
	getHSvgTTjstWdQsltckGZJlyXo71z9HxGpLU2397o91GskZakps7+HS7CXMuoHg
	iO3+3jp970gkSNFqFDvRYkIIIFEir6Ol1+Sgsn2M5bHUsyle573Skq5S1somDkZz
	l/3MP6SFmtg1q208Hlpw6CB7vm8+Mpf8IvdnxC2I6e68V0SruEUpXZhv5OXMgMlX
	se4mPwWzEnL76IPg1nmduUhgUhxs6FAJO8258fM3voApVNKnimQ8K9kxnPf7SE85
	oq8LqI0MYzsbaDre0jK+o+aD9HbusPp8PmLRKTkQYazesCm8nVKKSSbTXmDyDbGM
	jleze79lQ7/000ThGUAyyg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh8687csx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 11:45:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GBiPld040590;
	Thu, 16 Apr 2026 11:45:40 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqddqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 11:45:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/oY4dnMim6SXRW/LfwBu2ShqY8hP9vC+8BQw7fAJV2InTfIMd70Xb4zrtxXa+U61sEFW/itmpxCL7pDrl5xIZXCjTHaHumLgA4Bg/MWucmRvyVxpqGNjTXqzjt2DW3+qVTaH0SGCP5hjtkm4Myd28VLKRKnkjRk6Pql1e5C9UiLSKV+5ntfjKGPvfVuy06ROBSTPHxYO9HaRYlybB3DKXS9G24eOlwVsA5wjgnJ/7+g6mHZeWhVCBqRX5TRJe4KPj1QhGhq0/gMJaJmToLyoHtq7Tq9cvfbf6c9yLhm/PqcEMEdUi7Wocoj3XrUkmlmpfBjiPmTwqcky9+2A8k5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgBGooI3rh7GC8qdpGvNtOBVhMpLZzhCzaqXguEpIbU=;
 b=oTc3ZPx/WHZ74gBoWKMOuBL/9PPPJ9d9XNobYkfWUJ6lEQRRQNAHkVeaB7BzHsTlZXfBICLpybOIJda4qs42NYpt3e1BUz+4d4C5jGFKZs1xqyHW9FObOlBA/dU9TsD0DDmncLsgBslXmk4OJOceQ1onkXhWQeUl+StlQcwbfTku0H5sGevcQZA6i3EHI2CwekQvc4AywZ+2Yuy1qOAQkUB98dUadEYE4c7DQe8TFmsJ1unqhYHFp9cJ5RN3dsP2Fu543tVMgVil6A157Hi2/uCCZup0XRPRVR7jqlMaBVBNz8zJyYxzPBW9P1KpbOJNnUsDNJZPDVQLRs+JwMOnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgBGooI3rh7GC8qdpGvNtOBVhMpLZzhCzaqXguEpIbU=;
 b=s36kWFOD1X2FIMzBHQwb/DleYQHkCloBmx7ZAYDraTEsOcNQD1CHF419h4ecW3yQDf0KVEkzfShWjA3hAgmLOJC2oIlWjZ+dwKZXpwQumH6NvEI6me5b3umQJ4pMK9PDH7sy8HdqdXp4f9fCRTia8/EPegmQf72eOpw/d+AYwGw=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ0PR10MB5834.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 11:45:35 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 11:45:35 +0000
Message-ID: <cdad65b5-8ba5-46f9-aee1-8a5b5467be4c@oracle.com>
Date: Thu, 16 Apr 2026 12:45:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
To: Nilay Shroff <nilay@linux.ibm.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
 <c1e9d3b5-c236-4e5c-8cf2-90df5e32005b@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c1e9d3b5-c236-4e5c-8cf2-90df5e32005b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ0PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: ab47238e-e05b-4c43-2f85-08de9badabd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X3clxkHgnxBOY8Xr3zUQ69ZVuD89hQQfp6ldLsZlX7iAZW6NsinpgaYkNoDR/cGefajdnK5RcVhgoJUzEy+CjxBzb1pF4UCZ4fmw/vSVp2aYUs/kIZLaBurvqeWgrq37bMFmkYEfIWF19oYsaS41xIXsJieHSdj9TbrfbOQzboDdmYVuox/VAivCBTaBrEaqZW9jqku+gy93kQ4Z/Mc/jzjaZG7sg0XwsqGzOgFS7QIokL7gbxhA618WBslxQM0sl4kbuPbd5LKF4qzOlnxzG4MMZSN3G8Oq+pm4Pw2XXmp7xFrZk6zV7PW9y6qUzjCIgek7eZgGuaC5qDOzewnUURqFaybqS2RhEVR336uANHsurKTJ8yRpOjNlzBNsvUWGH6fSHimvRAzLkt+/vvdNc/7mCXj9ItTj+Vo3NbHGPx64jDVyJgYM+1xrZAFpa8i6HshA4drTq/0E8RhxuqiY5zppw2pusy8bcEOnt8Kz0u9Xukxif6VKrs9siXhJ9M3xdb2JSMxKptlOfr4JGoj2cNz76HWXHguKZ3YtBOncJXXp1p31j5iieyJoPSGGSVrgbw4uodluU98ioGQMOHJtJplXWjVepc6kqLHLhFQjjOqYyznBiGXCuvUdHgqBGHKdAiHHDofgC6EjshbLH1/ySyRYWZ1Ig1bbVoUmo0e1GzESxjlR49lGHFBCOkCZjcHLGKoPSjJmgnJcgEtqu17Vg/w+y7dYyNoY5hD66m+X0ss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFVSVF0RmJ0S2hyMkR3L0dUNjYydnhtYi9VTk5iNTdIdlJsdmtYTnJxUUJw?=
 =?utf-8?B?VS9JemU0cWxKcDJXSjJ0UmE3SElOd3JrcjAxNTFaOTE0QXc0T0V4MElXMkZM?=
 =?utf-8?B?NlpJallpVXh5MjRGWmJZYW5oeEpBd3VoWjhpM1hxeXJKMmZLN0Zqb2lUZ3l3?=
 =?utf-8?B?L3J6S3IwRmNUZjB4UjR1SHRWR3JGbXlCSFErQjNVRWNBY2k0TGJ2T0ExRldN?=
 =?utf-8?B?Q0FpZTdmSnFqYWpjcHV6bmpmV0RYQWh4ck9hK2d2UVhFVFVJUEFOSEJjQ0V3?=
 =?utf-8?B?L0RpeGUvSFV4WEJSZnNHcWZZOVFFOWl4ZTNCZDBQSGZPL0JzNlY2bk1xQ1BK?=
 =?utf-8?B?Um85WWhsa0NGLzRqNm9GODJ1aG80VDJoQ2piNVdSOXhzcC8rZ0xuazlFY3Na?=
 =?utf-8?B?UFVna2xEays2a1d2ZVcrLytsYXIvRGRvMWh2N00wU3RUM1RtaW5wcVBYS0ho?=
 =?utf-8?B?VU1qUE5xTWFTK0RDSkp5M0E1VWlIN0YyMHhxc1p0OFpCUkJNeUg0SmVsMmlq?=
 =?utf-8?B?OE5CTGNkRDUrT0FxSi9xVTBsNndHWDRQLzZzSGdNN2xxaUMyU3VEQU91RElT?=
 =?utf-8?B?bEJxOTliYUdhQWZXSmxObHJJbHpJNHp2cG5vOTRZaUpGUGFsaVliQTdZbmJN?=
 =?utf-8?B?YnQvNFZhbmF5MWxiZHBjNVN4cHVsZnE4R0E5d0tQTDk3VFlSMWwvVkwxa2hi?=
 =?utf-8?B?NTFnQmFpMDhOUzBZSi9FQVMrNVVhWmRjSVh6bzU1d2U5ZXRETndTbjdVWmln?=
 =?utf-8?B?WmNiZnA1NVBNZVlpZXpkODNiTkNCOU10RVErekJ0QWVBVkhCQ3hERk9BdS9n?=
 =?utf-8?B?cHRCMHRicGpBL1ErTXBtL3JmeENrR0VwQmN4dmhaVUVUeEx1djQ2SFZ2N3cw?=
 =?utf-8?B?eE5yK2dweHFoT3NFZFhFTnFuNFRSWld0VHUzUXJpL2dUOHk0MG9LbmdwdDk2?=
 =?utf-8?B?aTJVRUZScGtISEtnaG1jajMxTEhvTjdxTFV4WWdnSnJqLzVVYy9vdk43N1BZ?=
 =?utf-8?B?VnIveExhamVQdkQ5UUZaOUZZWm5IS24rQyt4YVFKZnZobCswb2Y5dWQ0dHJ5?=
 =?utf-8?B?dEZCOTFEbVU2WFhMeUJCWDlBN2V4ZFY5Q1FsWWhzQ0NBYk9rcnliSnM2Q3R0?=
 =?utf-8?B?RVBBZDQ5RVRvazRCNXNQZGhXbCthek1hTzIvRHRmMUg5cmpjYnp6U3prNGNU?=
 =?utf-8?B?UGxOenBLRVBPRVpOVHQvTWlvWDU4bE5reFJoQ0dhNXkrWEp5NEREWkc1b1B4?=
 =?utf-8?B?SXZYdE1QT2Zhc2xVMWlEeWRiVTMzZ01FcmdsUzdnUG5kWVNHdnJiYmNrQlpI?=
 =?utf-8?B?bXZKdktuZlJjdExGOWp1eWN4Sk1XQStJYjZ2ZXQ3SzVvYU9EUGNMS0RycGcw?=
 =?utf-8?B?UTIzUCthWDNoUUVCZEFoVXRmaU9jaFZNM3VkNUMwcENDc1lmRlE3QUEveXhF?=
 =?utf-8?B?TU43L1pUZldSMXdveDROOW5uckxVR292Y1VscE0xeHdkMk41aG9NeWRYVis5?=
 =?utf-8?B?VXZPTnl5NWh3NjVxZFBCSnRCZmQvSll3N1NCbzBtUkNLcUl0ZWVWbGFHd0d2?=
 =?utf-8?B?VDV0SDg1aS9leS9RSjFPRjIxU3k2ZEVuKzcyb0FrK2xHbDN2TjRHVVJ1czQv?=
 =?utf-8?B?ai8wb3FoK0x0T1psWUlIYWd5STBRU2tOUUI5S0RncVNsMHhUNS9qaGxWSmw0?=
 =?utf-8?B?a3ZURytMU09OVTE4cjMrT3BqUEs5dXQ1SGtOV2Uwc2pVU2dwd09uYWpFRDRa?=
 =?utf-8?B?UVpkQTFsSUsva01ENVRQdjdyUHJqQWtqdHFmUjh6Z0xzN1h4Rys5TnFBdTNr?=
 =?utf-8?B?aW5tV0lDZU1FZEVLOEs1dGNUZUxPcnpScm1acVB2dkZmRExlZDR0MGFhVXcr?=
 =?utf-8?B?Z1RkSTJRS0F4T3Q5VWtURG5LNjgydUlHQ1lRbmRuQTBDZ2JLOWlPZkNTdjZD?=
 =?utf-8?B?OGJPODllaEdpaWsyUmtiUlNJdFFPSDJGbE5CclludlZrN2VaeWNnbmM1STRU?=
 =?utf-8?B?RFM5RWljOHl6QkxtU1Z0QWtPMTlZRXNHQ1Y2RmxuTFBGTmtub2dKYThmNXFK?=
 =?utf-8?B?SW9iTkhydjA2RDhCL093VitQYVYxZzY3WGcyRUpYZkRTTnNGUEg4ZTBJY2tn?=
 =?utf-8?B?VnRRajN4VlhGenUvWmZIZmpyazdzNlJrNkRyN1dYdUQ5N2ZUNTNmT1R5eU1u?=
 =?utf-8?B?citMK3M2TEszY2VCMnhVMDkwN2puM005UHYya3BUZVpoTzdHNXphcU1aZlk3?=
 =?utf-8?B?d1h1SytPZ3cxRHFxcHRRZXlPQVIzcGYwRy94Zmd6bGZyVWlyaWUrTzFWODV0?=
 =?utf-8?B?WTFUYzNidnVOcVhkTVh0Y3FKeUptcVBURnIrU3cxc0U3bVBweDhKeWlhMXJj?=
 =?utf-8?Q?59R4bxBfQH4SYOio=3D?=
X-Exchange-RoutingPolicyChecked:
	ufCrdHHUBiVOtZ1IbtQnrGDmmGEBSYS4lAikjTdQwGWPMp2XI+oWog95eyxz0yHxl/rdbwc6oxYL1UK61FKQb/423myPSwrQ6U1MN5wb6Wufm7ZMZnHuZXBVK8lEqQkYLGIGmDB6m/GYTO0M8Ch4P5i7253vT1Qb8mwnm5LYa8QKecLnWf1u8mQxK2MCCFr6y59ykCRzz7jpvc1wQGZiyc7lh4OMKOLnv9lkq1/jCgqlK7TemvSgo4impIC49KBLmNhzNMWuRxlQuAFLXblKobRJjMZta0aoLFNLMvOr3PRfMwFDh6G/txC1wu2WeTZxTcK9bxYY3lUs4Cw5MwfN8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wfYrSngdH+qof2Dbn0g8S1JNGN0Z7AEjOOWuSrjVGN+72QhRFfsgibqDX6Wum5O6zIn+RWj3UcYr3r8e6JykxlLaJZ14KUeULYGZVD9y8xwrxng/6XKT6JadlfZI+WLN/fVG1QkHjg0DqkOfweFtAY2yRQXBlBGdXrYYv7ZYPMX7TBWJHdF7Cfr9ejY2S/LgxpBt0eLT3qgBjrLpC2LRx93T64vl7BDYpijDgqhNTxgS33Omh6EhFJfNAnuF+aArqU354j5KxQ+NrBajuQkG4mHHZx1eDAtVqznS/bWcHWmvuRSNBLeFjhe1QyvBcBv/yh6FFi2JeeLYVCHHinzL8Dr+bjAKChiiqS5UxYUW/Y23CSYbWDn6uPhUi7KlpM4tohKv+OvLlUOe1+9FXsXoFTB9VZn+Gcjp/A+iEmr/WvissbPxZvdo/7402FnlStx2GxNl1kSxyo9wzJnC431PiaL5XRPQQu40MEhe6VcPimDcNgED/dXsu+M73KrFRK7Khl2OnH7krBkKf5kJp+m1BF11KePeOy8HVKi4dQ/DtDD2WiXkPJSGiTzSzrznOp+3dWjizdPwL7Pl4dHnegHBILSE0CL6qJC8HmWuPjnmm2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab47238e-e05b-4c43-2f85-08de9badabd8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:45:35.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sNaWqPi183GEVwAqFihlKGtD4TKCpclZ74PeCe00emKJ/3z/pAF8ET4/Dko7Zba8CW3qUfSWBBIuTgjySTZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604160111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMiBTYWx0ZWRfX9uGMpJF0j394
 aiYpkHeOSAex3RftoFLwzSLsBQ5hpQF8XKrQT+wjq0NhD/16djVXuqlqpYStcq1k+VIAidWRtnJ
 a9AwhOIkMikTf/AEGUFJ6deF6fcc61/nibKfg+CbpcwmZSrjUQW/GgSuBVtmHN7bFpkdVluWL3z
 ZEpwTgMRldO+YP70YPb54h71GfUWDZjt9jrFwy+SU+mgUHZixXNkeJJSwb8k+bt7xfL8FuOwBb/
 R1lTC4ad/OU2rISaRoYL9pUC+BDgGYREnH7BZFGfIDG56BfnqqijfkI8j/uYlVkIj24d32OgUZP
 cE8VkfTcEYX8vEmPqeq+LUSW4P3P8505UJoF6EZnYHY0jjZcNwxuejjMbQnGO3QTcLbQPsDCdG6
 ZsxRHaa24nkm0khkVQNqyKedFqmBEv4IRxJlD/+PVEd5MwElfShWaQIz6BbhyvQhx7593sqQhp/
 Qn2SjIRIDp4iDuEfwGEiU0l3JDJpRr0iqaeRjo0Q=
X-Proofpoint-GUID: xN_RTGHMh3SAFObVWqZwz7Brl0wjrSyc
X-Proofpoint-ORIG-GUID: xN_RTGHMh3SAFObVWqZwz7Brl0wjrSyc
X-Authority-Analysis: v=2.4 cv=JY6Ma0KV c=1 sm=1 tr=0 ts=69e0cbe5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yjXhhM6PA4PmiKZjOUoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13825

On 16/04/2026 12:18, Nilay Shroff wrote:
> 
>> diff --git a/tests/nvme/068 b/tests/nvme/068
>> new file mode 100644
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
> Should we also reference the commit 62188639ec16 ("nvme-multipath:
> introduce delayed removal of the multipath head node") which introduced
> this feature in the kernel?
> 

Sure, if you think that it is useful.

We could also introduce at some point the _fixed_by_kernel_commit (like 
xfstests), but I am not sure if it has value for blktests

>> +. tests/nvme/rc
>> +. common/xfs
>> +
>> +DESCRIPTION="NVMe multipath delayed removal test"
>> +QUICK=1
>> +
>> +requires() {
>> +    _nvme_requires
>> +    _have_loop
>> +    _have_module_param_value nvme_core multipath Y
>> +    _require_nvme_trtype_is_fabrics
>> +}
>> +
>> +set_conditions() {
>> +    _set_nvme_trtype "$@"
>> +}
>> +
>> +_delayed_nvme_reconnect_ctrl() {
>> +    sleep 5
>> +    _nvme_connect_subsys
>> +}
>> +
>> +test() {
>> +    echo "Running ${TEST_NAME}"
>> +
>> +    _setup_nvmet
>> +
>> +    local nvmedev
>> +    local ns
>> +    local bytes_written
>> +    local refcnt_orig
>> +    local refcnt
>> +    _nvmet_target_setup
>> +
>> +    _nvme_connect_subsys
>> +
>> +    # Part a: Prove that writes fail when no path returns. Any reads or
>> +    #      writes are queued during the delayed removal period. If no
>> +    #      paths return before the timer expires, then those IOs should
>> +    #      fail.
>> +    #      During the delayed removal period, ensure that the module
>> +    #      refcnt is incremented, to prove that we cannot remove the
>> +    #      driver during this period.
>> +    nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
>> +    ns=$(_find_nvme_ns "${def_subsys_uuid}")
>> +    refcnt=$(_module_use_count nvme_core)
> 
> Should the refcount be stored in $refcnt_orig instead of $refcnt?

Yeah, that's a small bug, as I needlessly store it twice:

+	refcnt=$(_module_use_count nvme_core)
+	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
+	refcnt_orig=$(_module_use_count nvme_core)

> 
>> +    echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
>> +    refcnt_orig=$(_module_use_count nvme_core)
> 
> We may not need to again store refcnt here if we store it
> before enabling delayed_removal_sec above.
> 
> Other than above trivial comments, this looks good to me.
> 

Cheers,
John
