Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFD2F30;
	Sat, 31 May 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748721516; cv=fail; b=CAljkf27DRh9Udb4TKWPvac4ZG0R8ollg2en34zGAn/XuKnnIcfkpjiZg/jXuLU2pK9SgEewD/vsN7vQs8n5e0Hmk9vAzv0WkKCNE5WpKxuyCthjgiyUcbtv1TqxXudYSoKNOhHPcLPsbvtcHiVcMHobL4g87LkyFPK1uoGzhbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748721516; c=relaxed/simple;
	bh=ax1DLoDhM1dF/UBm5cCRvV0semZDbAYWL/U74RIORm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m3WB4yVtngYyNKQaFQ7Qdf8oAOM+4kPSkctlJfVsbBmsrpUgJiWIxMdBgBJfnXox8ESJN17iI8lRWbBv1r+krSali4iugl+pvqSbmxB5PJfKy8MicAnFDOn1K9J8JS3frXWtWUr9KZNNWCxvF9r/ApF1Q6+0C3P/Yz1jtHKLMVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h30lTQoI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UkjB95z1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h30lTQoI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UkjB95z1"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54VJuWET029763;
	Sat, 31 May 2025 19:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wH8G35rgLtsJF0VS9HZruvHF9e4FJY57YesX9kqJqtM=; b=
	h30lTQoI5GuMUacNlP9uDLsPFwE9M3EMFDBdhjAnMM94CcukjH89l9YbJN8BlwQy
	cSGNwAuNwgQjWTu+iGx8fCkIXb1wAXokvSxQmrxSoGxKRmX2xFFOFKJ18j4ixd0k
	AAo7fhK5JASQQl1ugWsUR2C7iGHoOphgzCkmTK9VlFmxvm1hSxkFCElUcjqIZnb2
	AUQtKXgtioGcV0zzYrkdMYcvVUZxbibBtlwyq07W9HesOmqWbRQ1jpU/Z9Q/Jee5
	Jnmlgf10gAKIqPTUfdSCSx3UAo8ZSczTmNHjcEr/XbhJmpYRWEPmQxiXTQbiLV+X
	PMdiZiUUD2Oyslb4KotBbw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrc40j61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 May 2025 19:58:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54VFjrTg030676;
	Sat, 31 May 2025 19:58:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr76paqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 May 2025 19:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9ilUfkpEWl5jWZr8P5qRoh+K3RDfvhBDzqp32CAF8HNsVHOTrNyFuMDo0uN7L97TaQbIstWFzqzNzjC6TTIpB3/F8snYeCGRp4euFvhLY/o6w55H+gL7R0vCNbb7PqVsd9XCUGbY5VDkS3973U7s8WVKwcJf4cAVUf9nq8lucNb+VdCTmRy95sxYYI5k6EejZLJT4aBCZD/7KU06dIVfeXMmmyf1T8fxoTewARIaDPcDm0NqYTD4ENHwbd2D6Y5B4oYAigngIxDvExHVu0wInJO7btc2ikondxu9ikZLZfdful6tWTnqOdOLov20mII84W5USk1W2zvlB/dc+iyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH8G35rgLtsJF0VS9HZruvHF9e4FJY57YesX9kqJqtM=;
 b=U8HTgui5AY27U9SlKr23jOnyuzkxWpQVCNFKzSutX2Gz2tpCtyNLRpQvtEkiTg5IXAjdUK//azLyFnm4pks/JraAz6bdRr2FsEEYG9YRPmmYSEA+MrqXkUSFtnpA97dNi/0Sw4BBrO+mSjSVlklIKOLhWiyONp6tOI8jPwJVZOPkpFQxyfrVQQB30usSPOCo6wl5cvpgSHCgt648KBpgoXFTt0RBARxnkVSxLYfoY5Hs67fITsynbzodBmM4f/tO+45K3nNoQDu0Lix+RS/YSVnsqAR9LfiUsqW4W06z7H2oZL+/ZvHO2Z/vsMAgf9XbJCrn34NzWCOhqIMLmGg/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH8G35rgLtsJF0VS9HZruvHF9e4FJY57YesX9kqJqtM=;
 b=UkjB95z1yb+tNPkG3h+q76JLW8RBmlu285vJ6jCnRjZjwnHQBt+fFuv88Q+6u/8aWLsKa95ohYEVzQhWYK13haSWV1emfXNPhbOb3MO1CTfOkcvV2KvawL1oI1nh0DgatSkQSqbwQF3LCWAFYxFYmQ0KFqdJsz+mY6jLkr790hw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Sat, 31 May
 2025 19:57:59 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.035; Sat, 31 May 2025
 19:57:58 +0000
Message-ID: <eec84588-a9dc-4ac3-a3a3-6085cae86bae@oracle.com>
Date: Sun, 1 Jun 2025 01:27:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] virtio_blk: Fix disk deletion hang on device surprise
 removal
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "lirongqing@baidu.com" <lirongqing@baidu.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
References: <20250531053324.39513-1-parav@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250531053324.39513-1-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP3P284CA0134.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:6a::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ0PR10MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 677e10e4-0daa-46f8-6dda-08dda07d712c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0xSZGZTY0R6UXhja1FVVWhpRWF6djdZZGhBV0FzMGJKeEQ1bEI4VHpGNWFO?=
 =?utf-8?B?dXVZN3k3UTF1Y0JMWVRWbktQOERzTXozdkNUOGZNRi91b1RGTGxPTjZidWJ0?=
 =?utf-8?B?VkxGUUo2Vko4OHVZRWFwU3NVUHg3K2ZQdzgzUWVBUEk4eERXSmMzdE1paDF4?=
 =?utf-8?B?S0U3WnY4RzliMFcvcVBpTVl5R1hWdkZYYzMybjkxeE0zNGNEMno0Q1hnbnJw?=
 =?utf-8?B?ZTU4WnA3cm80Qm5zR2J3NU5aZVY4NCs1cWhpdU5xTjVsWjRtM01QM2xMbmQ3?=
 =?utf-8?B?ZnliMTJNekRKNk9IM3FMUllPcEJ1OW5kbCtSeDFKSWh3VmVkSlpOQ0NZUCtW?=
 =?utf-8?B?dVdRMENFMHkyZ1JxcHZPdXdueXZ1U2JNK3ZyY0hkeFQ1QzgwdHN6QWlkUVJL?=
 =?utf-8?B?cXlpa0lTTWFiTmlwRzJ1TncybTZ5WnBkRVRVWDkvYnJPbFZCYXd4SWViQnNT?=
 =?utf-8?B?VVBFaXNQOW40SkpjSDdpNE1FU2UzYWJTUHllL3d5OW4ydFp4TXc2YW8wbFZu?=
 =?utf-8?B?a3pHVEl0elVQV201NnVvM3Z0dEVpVzhnaEp4Zk5JMFhiUVhHVmpxSVM2RXhH?=
 =?utf-8?B?cm5CVm1Sc0o0Q3ZvbVVMWi9TY2phOWlJMXd4ZEN4Rkc0eFFQektkN0NsQ1Vk?=
 =?utf-8?B?WWViWloxRFplLzZ4Skl1UjcyaCtTQmd0RVYwVGVLcWR5NHdkU2lZNWF2emR5?=
 =?utf-8?B?b01kZm9oTjJlUmVpRHYrNUlHSCtYWEdNZ0d2dDdXWXJjTGNnVlBsRFluRUk0?=
 =?utf-8?B?VlpMS3VZWDFxOUlTTzZzMjBPdkY5SmZrZlZvS1VQaDkxVllXOCs1QmFDSzNM?=
 =?utf-8?B?UlpYSmpXeEZlVEJmMi9HK0NQKzJaMUlnNll0Q1c0SXhHemFhZ1gvSDJoUmdJ?=
 =?utf-8?B?Vlh5WkFtNHBPMm1wcGQrbHdEU2dkbEpPRXFkNmhacXZOZGtsbWdKb1FqQmJv?=
 =?utf-8?B?T0pWSE1VM2RlSGJBeGowR0FBZmZndGc4NEV6Y0RNZy84bWZCb2k0YXhLM3Jw?=
 =?utf-8?B?MnQ1Tjk3WXN1citBSi9kRUp2elpEbWVITU5yWXRhREZvdUwwT2crYmdkaGE4?=
 =?utf-8?B?Zm90MndPdUM5Q3BEdXoxZThhM0hPOXcwVThtcXdLUlRZYVdORW5Cem9IT0Rj?=
 =?utf-8?B?a2thYXVzOGJ0VEtYSUtOZlE4clNQNGk1bks5YUlSa0JFVzZML0twNmhURitS?=
 =?utf-8?B?Um43REkxcVZWODVvZDJ0M2I1dHRwZGFMZnJjV2NSdmJ5MnlIemRPQWJqckJz?=
 =?utf-8?B?M3ZjdlZIdzNYOXpMSXdsSTdJZTNsYlEzWml1U3VTUGlDSU81VWR3cG5NOVRR?=
 =?utf-8?B?OEhNUDJuUmJWOUZiRnEzVlF5VUt5TTcwR1dNYzRWdUVYOTZZQzRWL1Y3Zkx2?=
 =?utf-8?B?VUMxdHZJYnpzWUVUeDd4WVJsaVczRnp3STVmUmU5NENCSDA5cEtxcFV0cW1z?=
 =?utf-8?B?aGdKZTVhSE1sdkpuRE1sVUFtMTFZelR6MzZxL1JLNzRaMnRIaFdwZWFzVEFv?=
 =?utf-8?B?UEw2K3hxWW9Ca3NmVnY0aDZiWGdxZnJ4SXNvUHpzMlpsekZiOWV5UUgyNXk4?=
 =?utf-8?B?NlZLaUNFemVVd0I4Mm8vSHhRd2QyNzNjTklUN3JJMURGNCtWTGJ2YmpNZWp3?=
 =?utf-8?B?alZLc3k2ZTdBWkZwRDhDa21zcVNKbjBoTUNna0JXUlhIR1V3VVB6QkNTMWZK?=
 =?utf-8?B?UkUxZHQ3Skc4TWVxYUwyOWRVbWVFWTJ4bUlsUHNEQ3MxRk5YTjhGYVJWazNx?=
 =?utf-8?B?ZXk1a2haZUsrbkhZSmtEMTVLQU15aktDNUZidUlSMEQ0Sk5aT04yTDhtWity?=
 =?utf-8?B?TENtZUNBUnVTNXpvT3RaRmRORGdOMFdVSlJBV0pmYnowQTBZL3VpTVQ3OVVU?=
 =?utf-8?B?N1FJRWJSK2toOU4wdklBQlVZZkp1dFVNMXpmSmMwb1NRNEIvZDJnSU1UV2dY?=
 =?utf-8?Q?XAchHB8/0dw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alhFTW9YL1RhZUVHR2hody9icGl6aFBRNW42WGlzQW5DVGFWM0t5TmlsRjNs?=
 =?utf-8?B?elErTk1ZU2crMmYyR1RsaUtwZk96UTBqLzZnYVErTmkwTUM4VTlQMDdVbkda?=
 =?utf-8?B?TUVBZ242VDdSNGZlWXZOaTZUK283V21WdUJndTJQMVZpUDlmNkxXS1I5SEJu?=
 =?utf-8?B?WlE2Zm5nL3BoZFQyV2FqQUZBWGhUS01FNGQxcGk1M1ZZWUQ3aExGSzZCSk1J?=
 =?utf-8?B?RGRHb0ZZUVBNbFFJWDBHeHlXR2RZN0VEa2ZqUmF6emttZElYK2djRWs0N3du?=
 =?utf-8?B?TTFnNlBkTXZ5VnI3bXdSejNkUTVQVFEwQnpaTDhPaG1PYmFEdU9EU2xuS3pn?=
 =?utf-8?B?ck8xSWgrWjdzOEJ0VzVlamVITzJWMC8waGFaRTJyays2emdqUWIxZm1SNEpn?=
 =?utf-8?B?bzNRclU3OUxpT3E3ZDNuOE1hTUg4WXkxWi83RFhoc0ZQaTFRbUVJaUMvMkNz?=
 =?utf-8?B?ZFpvOGZOUXRpRlAxZWNTdTRzVTRxMElzTmxqZFo5TU5oUnlyN2VuUHR0VnBX?=
 =?utf-8?B?WDAxL0twdVlVZStqVzlhZVZoZFVhM0U2U0NOaWZRaDZCMThVSXlsVDNiYzhp?=
 =?utf-8?B?VXlpcVJwNFVhb2FmcU53blNRZHR5T0ZaSjNTZmtiUGdScEtjSzhjWGxnc0ZZ?=
 =?utf-8?B?Nml4STdBNHpXSUtPLy81UU9YRW1VOHZyMXBwRENzTS9WZTFGWGx6YjI4MHNr?=
 =?utf-8?B?VTdNQkVkVCtWTUZGSStjODVxeGlRS25yU0FCQXAyRVhyOXQ4VzZEYkFWcDdJ?=
 =?utf-8?B?eHk0OW5SMHVLYjR2VUJaNVNwRE5vUFFSQzdvdHVyUWlxeHJyNmVzd01EQ1Rh?=
 =?utf-8?B?SUdqZW1uY2FELzVDS1J4MGlOMC9Yb3hmUC92K3NXOUZGWERJbG12OXdrcEVa?=
 =?utf-8?B?NzU3eTNsTXRMa3llamFYcjg0Q3I0SlQvUmNCY2ppYXo0b0ltdXFrQy9heDY1?=
 =?utf-8?B?MThVRmQzMzk4K0xrNDNNU1FFZVB3L3hGS250Rllza2tsQ3ZBVkI5WWFpUDE5?=
 =?utf-8?B?TlVSRjh2eVlvRGZUZURqSGNXbVBkbFdiblU3S3dQUFZldlVDR3JrcVlvSU4r?=
 =?utf-8?B?ZTgzelN6OVhYTVd4dlBmcmllQVVYbjBra0F4R05RN21EVVdmTy9HVm5pUENL?=
 =?utf-8?B?dmtRc2RCejZtbHlzejlZRGZuUmpVaGVxVkdFd25BNFBFQVpweGJUK0dSRmNZ?=
 =?utf-8?B?bGMxL2NiSVdSV3pBeHBjUHVxelJoNG1TTDZiTzE5NEsxLzlEYVNpZFZaUERB?=
 =?utf-8?B?dTA1RFJpZUVXWUFHNERqK2tlZkRWZE9WTW9wWm9SUExlV3g4cHRJWlR3Q0pv?=
 =?utf-8?B?cEZyaFZHQWxONEVwZ3M5RjlpTm5rY2pSdW9QcXFrNUppYm5lWFF3cW4zNG1E?=
 =?utf-8?B?RG1YM0ZxelRmMHY5WFM5YlZmUnFJUWpJU25YaHY0UnVMMlg4MHZDYmVNRy8z?=
 =?utf-8?B?WEpiOCs1MERCUUd2VWhCLzVGVG5kYTIrUXhEYWlWLzVya2xyRlVoWmdlMklv?=
 =?utf-8?B?MHRMR3VMNkg0cTNKZFRBMnlGS0pZUHNpTEpYVmk3blVyd3BITThXeUd2dk5D?=
 =?utf-8?B?V1ozbzV0NHBsQlpMNGIvcXI2a2hSanptZW5nNkQxRVJOVXBPbzFrb1JCMXNv?=
 =?utf-8?B?NnFQNFZCU3dCdTVxbVZTdHhGTEhoZTVRM1ZTRnpPRGFjaHpjOEZ5TVFpOC9I?=
 =?utf-8?B?LzZ4NGh3QjV0ejZPM05pUjNSRHh2VjVEc3FZVHo2YThJeXpJaXR5T2FZN3lV?=
 =?utf-8?B?QUxXVUtDeSs0b0RWTzFBVjZ4c0Zsa2dnQ2FGR3huckEwa2wrNlNDaTBRell0?=
 =?utf-8?B?K0RYQ3BJTndLTWVhdHAxWnlwN3Q0ZUxHTnJBUmVHNG1iUVhGUlQwYm5QSFdK?=
 =?utf-8?B?amNhYWx6djgxN2RTK1NSN29aK0g0TTllVWUyUGJMK1h1WS80M0d0RzlhSnRw?=
 =?utf-8?B?aklmbHJLQ2RyQzBMNTF4VldSZmx3d1o1L0xCQmljTDl1aVdTSEFXeEV1UjhN?=
 =?utf-8?B?bjdxdC9md1hWT2VkMUh3bDlJVlBMU0VsNXlZdGpPdGJoZ1Y5cXA5VjBGMFZk?=
 =?utf-8?B?Nmd1a3IzM3NxaHJiSkpyS1ZVZUd6YytMMHVVbVp0KzA3WUZqSGtMcjVUSnNl?=
 =?utf-8?B?ZXhMZmFzeVUxQlJnbzNKcElGZm5tRUNMNjNTT3lGSW1BM09DaCtoMndJVm5o?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z9VUZSz4oO5nb6mBp7n2ANNCuE3wjJyHrFVVjkU48NfwSZUVUFHn/3egcJHljwzTJHRcgkb/9OUAftRjyvldxoRaaxwKAbmH3SRm1kdelaynd+jR82cAjntmpJsXLo0ZDoMxVIjWtxHcgIP2KBO3F6j71XAnaBvPXCN7wSLa6899hQWuBjqodduC6CiTTKBLcwJVhYwlMks5+T32YHLEEr7O1kyPiq0iy3KRjpbuxTo/gMM0tFFSlodmjTO0G+JBChuGr9HATdWfsPleLGml4EfgBN8fL6KPcnK0hOXVZTlwNlLjIyCDMaPbW7QPIfwpqqF+Wphf2S6PtlCghHPP0GVeFictunCsih8sRSNak84MiaKKl8kFpWwbJ6wovJSp0iu5QpCqq5g7NNnCU/ihBMEmCWX6EfIRevmbwTnH2ZKfgaxWLDckUSSK/LmrescHuymiTLvOxqzNfsKxeplqI3wenSakOaxG2M1Aoes33hw26OUVzK5xaD7KQR0fexgiAr7hY/7CT8B8F/vMwD8CLVkMSLiZOBwduuTGaUJurN3lT8pON0ro8BXNjSJl99If3QK9V6G1fcPci89DIQ4/aus81aGDG+DkQ+1QYFzsqkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677e10e4-0daa-46f8-6dda-08dda07d712c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2025 19:57:58.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3JAWYq9Hw0dij8CQoFyAc0lj8bTgiTppC+dIKyb2bsxrjDsKPeUJ0kgC2tBd02VxiGG2Q7uiIy8IwXqJt8INQvU4sXG1CtUQa2gjSwqAcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_09,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505310182
X-Proofpoint-GUID: SSknhC537urzjS22t9Uqrtc_LtI7fUPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDE4MyBTYWx0ZWRfX5IasopQCRFse nOQ+Kr52MAcmKfr9R4jLwY690LJ0SLEq/aGvMonbiVoBj7QYbR5J5PvNEtn7/FIwJ4Y+ijYWtdw tYNLJMzFkIYM+NxddzCcDBI3ke2umWBc/65GzKuFqGlpFLZER6nTFvfATqpM4hnF9gHu4p328gx
 qDMEOe61YyKXqsZm9IVXRuDst/uWNa47yJE7BkAb38sLdJZVXzOk5fyR7Yp5r/Cbyy7MW2p1hWK /+UUNnN9FpWHnxUSL4qfYQBKi2Gu9KNcCPfXowzbg0KRC3KcshPdUMhDdwCQMVlaxftklP9PZ58 ZjsRPAf7l9W0/JGp+Ou6C6J8U1Kulv3Mtw3K2ts7dJ3tOcD6BWaSCluQnflxzeZLigQhLFQcNfT
 78vHmylkDm2WKbXjbpN36DGUoZkELgeUY+hrBt1Eic+nkS8MR6F0ObIXU2dgqTrtku1J3d27
X-Proofpoint-ORIG-GUID: SSknhC537urzjS22t9Uqrtc_LtI7fUPz
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=683b5f53 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=swUYPa_3ccpdDoGOLC8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714



On 31-05-2025 11:03, Parav Pandit wrote:
> +	if (!virtqueue_is_broken(vblk->vqs[0].vq))

is it call, if the virtqueue is not broken ?

> +		virtblk_cleanup_broken_device(vblk);
> +
>   	del_gendisk(vblk->disk);
>   	blk_mq_free_tag_set(&vblk->tag_set);


Thanks,
Alok
