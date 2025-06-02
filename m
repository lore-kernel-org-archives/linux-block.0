Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3290211F;
	Mon,  2 Jun 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864837; cv=fail; b=jiE4zNxUTeLEOzYgkjX1h0Yhv0mQ/UTenF2EpsrYeYubCy+eZFAttQnyztB+fdvrBaujegunJFIs4gtcqL8Y1j081JQNroh5cJgOtT/CzRj9Vp41Umk9ZJ8a7knkKu//ephRS+liCqCO1CKms4qFGw4hN9g+ntrktXPjOgO5Dzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864837; c=relaxed/simple;
	bh=K/aMmn0MV2s93W+0+MykitPTek8YO9PvgKdgkn9adFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X5so91SopN6S2I9xW55pB4Q6orX8TPx3vkDqOxzPQUC3VwXcY9gE9LHhPQ22ZtS626E5o0X9u38Pct2EQ0W9Ru4Lg7lr8xg7U6DVd75vZ6O9cERp1+fQ7lq9Ph0FhoCVLXMNDoLo2ZqKPSpdwpr2NxGfvjrDwnWQZcKepKa2fF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TshV4p05; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tnF0C9dF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TshV4p05";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tnF0C9dF"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525u2o0009209;
	Mon, 2 Jun 2025 11:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P8IrLNMDhjK2EwWgf9Aj2jdbd8FhRGUgJ15hI9nfjIA=; b=
	TshV4p05bO02LkzYaNimyj+N9eaQie8lokTVQG4/S8nroRtRJYNLm5xuIitUI2P6
	WbW/yoynrCvdRv7TZl2dX1+Y8Ipqi6vnqYQLe3BhAmtib20GgZM4/Vv/PYyBEV5p
	O16qVHildZ9sZAc+Rf3oHXfldBaHbmGgWT8PICjT4tXHiGL5NEKv6t2xwJoafyXi
	GDwXeEGKFheKMhVTbCpVw+d7pqhAExFeLl72kD4DxxD21lTmGfqW8HxxYYF7qKdR
	xB9wpfDQrIMJp6pWyXH4z3BqufI51z3B7UWjwA+t6r1xazhYVj18T5paQss8kI8k
	1+ugZ+YE068zPJNGjHhbPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yscwae6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:46:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5529p8ke016137;
	Mon, 2 Jun 2025 11:46:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77vbym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX1vlW28Bsjpts96GM4p9Uk7z5fYxtl4CRWtR+vLM6MFWkEqeasCczoSnJmB5UzFYdixPQYUusC8rK4Xz0ML/pKmvzyAAlOc4S+VqTF+5PIxnfGPOsVz8BLrtnGxjV9oFAtBqTUZqu5NDNdWf4ul1R+vVnQ67kuAx4CVuiVZF8iw0t2BfAL06LV+n5wGhtmr2TSPD7MrVw5uY81rEKd2nF8EWKxFGdwdY1/swL+THand21hTYUxFM5myywC6HByXfmIjH5M3MYBiyHANH02GPsEIrWOF18+3lRDwP0LirwxFw2fEfTLosgMJu1ymKOmwqjZMlOskbw78d1uDoCDsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8IrLNMDhjK2EwWgf9Aj2jdbd8FhRGUgJ15hI9nfjIA=;
 b=pbihx+xNiWENCxo+qw3MJCwvWs8bjGuEDf1iUXUcJriEZT8yAOLkCCwzSvU+dxoU/aCSyJW3oObR8xFomF8BY7xyCjq0Vlvv5AuyGvVu4LuZ3Lgtu72KHEtuhuxHET8U6YmYoapNISbZoqYu32gET1BpU2XzZmi0zLCFB+jrYq8FBzphJ14rN3PwuXbzO5bDikBiDBtSILlGjTckGNuWs2P/p8WBXoZX8Qwr2ZjbWbA3UoxjqxCnLT5NiUxz3db1xiaTF6S1zgvHe2GPwC3LR/xQlsswTe/ziwVy4mx3JtunovNaqK0revu1q0/t6AJ9Aab1MuDogsTMwP1EBe3t3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8IrLNMDhjK2EwWgf9Aj2jdbd8FhRGUgJ15hI9nfjIA=;
 b=tnF0C9dFRHm/nOhKfDETCQe5mlR8KHr98AjE+VEyThgWkXMCeu+LZWSBJGONK1gZLWIEMtbFGESahkmw5disjbGvXHmzYO1gvgJVso6nYhc5WwxFKjVubKnDYUrYqjrn/wM51HBrPKv+JmfrBE+12yCIRzk5NG1ElguUnxaDBgc=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Mon, 2 Jun
 2025 11:46:56 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 11:46:56 +0000
Message-ID: <e4bca734-f914-4e4b-9b23-7d382ac47442@oracle.com>
Date: Mon, 2 Jun 2025 17:16:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org
Cc: stable@vger.kernel.org, lirongqing@baidu.com, kch@nvidia.com,
        xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, jasowang@redhat.com,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
References: <20250602024358.57114-1-parav@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250602024358.57114-1-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: cc09f1da-0eee-4530-ec7d-08dda1cb2d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V09WejU0elkxbWpTdDlDc2pKa1AyS29PSFE5bzgzeWNZS2dHNHFnSDRYTk1Z?=
 =?utf-8?B?bXNYUzNsYmQ3eFFMaVJrYWVFanEzcFJZT0cxSlU1bHhCUzQ1Vjkyb1BCdFB5?=
 =?utf-8?B?c3RKcERYZWxCMWkxVEFFeW9YWEZMcU5pV3habFlDZ2tqQjlSSDhsWGhTekIw?=
 =?utf-8?B?a1VGNVlVWUp1Ymdxa2U5NVJpWmlwSzZ2QVNQVTlBMmpiV0xvTThSVjV2ZmpY?=
 =?utf-8?B?ZHl0YVN1Uld6cTMwNWhNMUVjck5zcFZVWUU5Lzl5V1dmTmQ1OGpLcjNlTm04?=
 =?utf-8?B?ZVpQWXpxS2lPVUR1bTUxbDdYZG91K2VCUjVjcmlxZmlaVzVOTjlJS1A2RlBU?=
 =?utf-8?B?ZGNuZmJValVZT0I3QVg4TXdOSGRmZjZjKzg0bFJ3bVV0ZkQybXJuRWtiTDRB?=
 =?utf-8?B?bGpydVhzOE1lMUNzQWN0MDYvbEtzYThJbENlTDZXNWJyaDJCSHhNUTI5TGd3?=
 =?utf-8?B?dURBS1dnTnBpM0ZYR0xMZ0Z5T3c0dVNyMVErcmg4L0hISzJDQVRNWlZTb3JB?=
 =?utf-8?B?WDZXaTFTNTBscUJQWkFiaXJPSmZ5czdvOWwyczY5dWxGRDE1Y3grZHUwbjAx?=
 =?utf-8?B?ZEl4R0RhNDZjY2hmUWZsYnpXblprQTl0amFIdU9aYU11bWlVdGR3L0R3TGtE?=
 =?utf-8?B?OS9IRk5pU05IYUozZ0kwa0tnRGVYRUhmbGhYNnBsQ2Z4eDUrdnNGWVpFdU1V?=
 =?utf-8?B?K0cyeHQ5Sm8rU21iUHY3czhGUklQVmhRWVlXVHB2Yjk1c1psK25FK2dyaGtq?=
 =?utf-8?B?WHhadjF1aS90N0pZRkxKVHB5VUVNSGc2RkVQZnllbXkxdmhGM05ldm45STFa?=
 =?utf-8?B?RWZpMUd3b2R5aUVVajNCaG0yMFhucWlYdkF4aGUxTlVlZURhb1k4M3FzZDM5?=
 =?utf-8?B?NElJYkFkY2hHbmdMajFsVk9Qay8yQW04T0h1NG1xNlNYN1N3cGtHanFBUmpw?=
 =?utf-8?B?TUJMU1QwRFFzOHF0SkRuYnk0empEUHBRMHBJcDdldTdZTWkwWmVwTlV2QmpI?=
 =?utf-8?B?Y24zOUJHSzBnUktWOE4vSml6L08wOXR5cGhRbDIxM2VqZnNTZEt5QXBkblZK?=
 =?utf-8?B?RWNaYzcxVjZFSG1JRXN6bXFxSWpXY0gyZXpudTkwY1JOZVVIbVZJa3k4NEt2?=
 =?utf-8?B?ZlVhQnRYdllzdFpaWGxpTUN3blJvV294N2xsaHdSdllpdjJyMzArb3VxSXBv?=
 =?utf-8?B?TUZ2b25wclpiS1FvM0FjQkd2SXZkQ1ZGY0dRay82NFJFd3p6K3picmdGUXJp?=
 =?utf-8?B?MUJpVlFUVUZuYzUxY1VqVUVRUWtVdFZDYktuTllUemlpYlBlbE5hUlhlcmJ0?=
 =?utf-8?B?VW9tRk5KWERVVkJQTnYwVkorQ2crT054ckxLeThXYlBPU21lY01QL2VleDBQ?=
 =?utf-8?B?aXV4N3BLM3dSd1FBYW5XdERsZkRWall0OWI4NzZoSkZwZ2lpbm02VUxaZUgw?=
 =?utf-8?B?bE9KMUUzNG0rWXdheCt6UFRCYzF3TEZvY3dud1BrQk02Ui9KNHl6ZHVvTUJW?=
 =?utf-8?B?NHJIMnNKcUxORS81SXBqVU9WY0hFNzE5L1hTRkxITjQvR1NielVERU1mbGQ4?=
 =?utf-8?B?WXNUc3FUdGpOeDM1alZ1Vzh3cnp6N3hRTnVXUEkwbU1vdHN6WVBKYy91NE9h?=
 =?utf-8?B?L1NsNzVBOTRUOGpUZXYrbzRnL0cyUXdyaDYzQ0YvME81TDJSZXBWbEN4TzRw?=
 =?utf-8?B?aVV3UGJHeHVxOXd5dTNmNlc0dGpiRHZyaDl4ZlRwanE1MTMvTVo2THFZYWM2?=
 =?utf-8?B?bHFsdGxwMU9ydFJWQ0Y2aFpQRmhYaGNCWWE2N0VrY2h0ais4bFVrLzVNZUF4?=
 =?utf-8?Q?g28U52evi3au2h5edvQnaAJWJqHehFqssg3xQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGRHNGVuM1hnYkZ6UmhEQ0QyMHhFZHpLU0JrWU1OdlNEQmpTYmN1M2JGekRD?=
 =?utf-8?B?RVJaTUxzSklBckU0a05NNnJzcnBTSEZzS3ZmcWU2NWxFRWpXYWNTOE5ac2hW?=
 =?utf-8?B?OWdFNTA5YUF1WVY3eVljMjZ1QjNOa3ZtdGtpK0Q4RWRGbER4aTZkdXplbzlw?=
 =?utf-8?B?bUg0azRiZzNCWVNWdzcwdGxpdGY1eWd0Q1dJNTFnV0N1ckFCRFB2ckxOcXBV?=
 =?utf-8?B?SndqQkVrZkY5TEZzUWhkWWlpTkFZclVyT2FRdmdsZXBtdCtQOFVNMU4yc1A5?=
 =?utf-8?B?ck9zTkhndkZWT2R3M25teEw1TWxBSVVPbzdCVlJyRStIa0ZqY1VJMjkvY1VC?=
 =?utf-8?B?czBGSHJQbmd2Y0JYQytib2VjWWk4MUtvVkZCWEliNjcwU09kU1c3WTFWRFZz?=
 =?utf-8?B?MThxRTNaNUt5OUhhRk12YW42b3VRa041Y0oyRUFtN0NyU1NCTWRnU1lQRzdt?=
 =?utf-8?B?SkZVOU1vVGJrSjAxOFQxOUYyVjh0VlpqM3dXVkZybjBpZ1hRWUx6ZkF4YVIx?=
 =?utf-8?B?UzZVQ1owKzhIemJDVlZnWU54U3BJVUdhZmFMUnN5Y002YXJqZXlaUTh4YSti?=
 =?utf-8?B?YzRncDRjc3lIelhKaEFnMzNWSnhnWkc2M3dHNmk3R3V6czhrQThUM1U1am52?=
 =?utf-8?B?OGRsNnpUeXQreUdzNFJCeFlPckJYcnVlTmh4NkxKTDZMVVNSMmlNS2VuY2hu?=
 =?utf-8?B?YW0yUmRFM2FRQVpqKzJGRUtTUThsclZvTFk0bExicjhSSGU0dVFZZSt3RDFj?=
 =?utf-8?B?Z2Z2clRha2RwcmVhSUVZVkhuRUdKQ3BKck9uYVhmd21NMFdPRjk0MlBTQk1Z?=
 =?utf-8?B?SWVhdmkvUmZOdzFtTldyTUN5a3ByNTRSdWpoM0MvU1lGdkdsV1B5dDhhRy8x?=
 =?utf-8?B?VDhpZnQrL0lUeUM5K2gyamVic3pyc3JyY25yTzZXakMzOFFLOGhSbXZ1U0ZN?=
 =?utf-8?B?Zm5TMGhWUHMzbTJoWXB6Tnp6OEkxQ2JpR0NZVVJiVENRVmFJcHZvV0owcEpD?=
 =?utf-8?B?MENNMW13L3Y4TUVmRk9mOUk5NnNaUmNTYWNraC9ZNjRwNDJKVTh5SHV2WjFP?=
 =?utf-8?B?NWgvU0VnRFhFWVZtVUJTU1M4aGkyblNaVms3TVlMMHd4WTRMTmhNdzduLzM4?=
 =?utf-8?B?SHlmT2NUOFptQmVTZmlGb3RjR1RQNUc1ZVpiT2lnVDhsT01MeC8vU2F0MEhG?=
 =?utf-8?B?N2tmdmF5ZFFJbU9NWTNjU043SGE2RWtSZFc4aTd4dnFCRmNPajF3cHBSVDhQ?=
 =?utf-8?B?d2FzeTdCbGJGWG1ZN1dOejgvRU4zNU9Xek15MEJ6VkoreFlRcWZESVlkbFdQ?=
 =?utf-8?B?Titxc0c3Sy8zMWUrbk1GUHhrMDZUZWJmTTBwNDNiaEhEOFdoajBod0hrdGU0?=
 =?utf-8?B?UDNLVUxMRDJ4d0xTandHMkdhR3VoaXd3aHppb3g5clFNMWc0RmVtamVDRUZr?=
 =?utf-8?B?OHluV1VOY0UyR0N5ZWxDUFhpUnFzWExwdENONmJFSURWU3hxL3ZQWDQvS2M3?=
 =?utf-8?B?V0p5eHJBNHJVYlQ1M3lvSStLVWdJTnRKN000THRzdUo2dUlQb1pkenJlKy93?=
 =?utf-8?B?TmpOZnVCb0RNOXhkVEZKRitxSHpsaWRpUTYyREFlRVF3Zm8vcmVKY08reWU4?=
 =?utf-8?B?YVJLVVVsWWlQY2hRYjNNOTdDY2hqWVUyWHo2RU5kN3pnekRvWkMxQVR5NUVW?=
 =?utf-8?B?TFlTRkcvZFVISHZ3cU8zS1UxaTdlcUJVQmxGVWUvSEpadW8rL3hLUm5GRzgw?=
 =?utf-8?B?KzZWZ2tvMjJzaGtUY2JKSHJLaWp3MXY2WkJGQkhKaXJNa3pLbGdhdFBmelVQ?=
 =?utf-8?B?NmxsWVZGRUF6d2QybEUxdW1USUVKck9TVlR2d3BoSGtpRDBlZ3VlMi9BMTdL?=
 =?utf-8?B?eVBIWlQyY1B1MlNHUnZyRjRHNUNGaWgxWDF0UFlxVVZBTUV3bXBpWEw5K1BD?=
 =?utf-8?B?OTV0UjNSelZMWHdQUnlJbW1XWmR5QmgzaitIQjltQytvamptLzhPa1VmR2pD?=
 =?utf-8?B?WGl2cTBBdy9JdTF2SEluaVJiQUxMNmhuREN2YkNlVW1JQnl1UCt4M3duUVJK?=
 =?utf-8?B?L0NVSGtJS0tuRkVqZlkyVk90WGMzVzZUa1RZcFFZRHdmcmk5cVJaVldKODdm?=
 =?utf-8?B?d0JvS1VDOENXWURMNlFxQWJUN2MrOXl2SVAvZUlsUFR4WW4wMHEyUVdiN1RV?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RJYCXP8Htq7+GLIkpT9xed0+evenjbL/65Eb+cxaCP6Dt0w4cnw1SLoB1AjfeXDMtxGcO8Mq0bkdqFXK2FHrH06Kq0iscMtbTCN8pjW+09xXqwRDWBmvioHeuoZutFjhQI89RUHZrYxL/HwUYPPI3IM3kljNxOK+yP6lyRbr3mGtipOea/0Ivn9hr9RfEkbHHpj4FbUkXPnR/ojqWwERZRp+1SLGzC4j1EtKKHXOjQxpJubpjyFFQYDbA28s4Aflfxsw6MMhnzOupTqFkqBD2JVBwU7DdDLnMq89G3Hcu3K7irwwIlZ2K/0XWBe9nAmqJYSp2JeJumhRsd/2o0BjTRmNOdA5BvmnvmtPWohialaahzIhSfZAlqvvmJpBVhM8V/DKInsE2E710Kkb7WYjK/q8av3u/kfhRrXcpUe9daiDGKz/UwHBT9UP6Kh20I96I0oLz/OPAbyRXFwuXkWYO/NVmRPan5u/O8IcT/bAaTtbJYw8DwwE/ovO8NyIrIswaG4rCjqsGhDO/DkwBbbNGz7ASnTx9dFC8N9dZYioY/wVJ5CJMWaFsnlQR/OFWKG0U0zyXVxrSPzW8Dde1UtNjn9r3Lw4dDKgzE4EJzfIsnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc09f1da-0eee-4530-ec7d-08dda1cb2d0a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:46:56.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oJIzfDhOQNXu1Upy7bqZi7LaQ1qKPXKCaiFkwBjVG29V00Q3DMHXYvbfJ/mWt6ONjZkwalfGLqDxoa1tj93GoN+nEVas3XARXGhaB0Y1/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020101
X-Proofpoint-GUID: cDUNN9ep_Z_Ay50BAqtr5kTdZIgpxLKm
X-Proofpoint-ORIG-GUID: cDUNN9ep_Z_Ay50BAqtr5kTdZIgpxLKm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMSBTYWx0ZWRfX8Lz9HI79QKwE AA1N5ZzPsF86k4ZBQK8mENJPKgqE8a8PikRLhTyPt0EOO4uC/YIC/keTxU6cc3xA7wLFTC2TX/W 9VTenVhWWzuI+UxW79J5r/1ZZHHBZ9gLfSdSC3lhzcjUE6FZnOjG6BsqzLBTGqY3PWnIqagPa/g
 zjCMYTgE/gp2W0cHUx87B4dfze+azdgdg7ANPgPhUq0xOJscmrzWcNa1mxhrIuIf43TiOdppoNH HFo811p510fjMD7rGED8efr+xlrmGyrTzTOIu0w7G4rLP0idX9Q6dX+doZhOb6PcSbiAvTSyNVD vEJ3Y5YI4+5kbMZ69+QrmIGRPLARR4WXdm0drQ+tadZcg4PX0HVmazaqwsI1nj9d9h9CM9GinjU
 AapXr9fUN8/U0q64q7+1yPpoVbIP7C+VZZJoeua3eoc5yUdEBB5jb3srC75E+NNLyAG1r7Yv
X-Authority-Analysis: v=2.4 cv=N+QpF39B c=1 sm=1 tr=0 ts=683d8f33 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=zuLzuavZAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=5XQ0uExd_NRSoit-TZwA:9 a=QEXdDO2ut3YA:10



On 02-06-2025 08:14, Parav Pandit wrote:
> When the PCI device is surprise removed, requests may not complete
> the device as the VQ is marked as broken. Due to this, the disk
> deletion hangs.
> 
> Fix it by aborting the requests when the VQ is broken.
> 
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however
> when the driver knows about unresponsive block device, swiftly clearing
> them enables users and upper layers to react quickly.
> 
> Verified with multiple device unplug iterations with pending requests in
> virtio used ring and some pending with the device.
> 
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc:stable@vger.kernel.org
> Reported-by: Li RongQing<lirongqing@baidu.com>
> Closes:https://urldefense.com/v3/__https://lore.kernel.org/virtualization/ 
> c45dd68698cd47238c55fb73ca9b4741@baidu.com/__;!!ACWV5N9M2RV99hQ! 
> OKusQ3sGH7nkVTy9MUDtaIS17UDtjabP3Lby9jTBdT3Ur38XLl2_DOFo0eVzx_dNeh16lD3Ss6ItE9eG$ 
> Reviewed-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin<israelr@nvidia.com>
> Signed-off-by: Parav Pandit<parav@nvidia.com>

look good to me.

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks,
Alok
