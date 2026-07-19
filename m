Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC053223323;
	Sun, 19 Jul 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464267; cv=fail; b=n9/rsUIIvTUYlrLYPRblDajIyokZi4vLrEJXzKeKqsQzTELYGMbYzjsLXFLNjSKs9JtaIeXJNyNTcs+YOLmlEw4y+3rV/A8lTl3iPwF27tKwr8FW8oNAsE3jKIk+jlLFFbmGmi9kaPULHabXXwMMIMwN297hgqjnHx/ww4OgR3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464267; c=relaxed/simple;
	bh=sex/f/03L/paxuEb6dFDMvmeOt7t+oh+9/8ZiCPcUwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QDJa0moL6idu3tkS6U48vISf04G6Eu/Dz7zp+8O6+2J5ytliieJ44lWZHjBkB42+zQKi+wt9lo+FPReZ+RCn0MYpvzhjwFNJtT464trMgtxrpMS1njJQIrY2YAC0UQNwwtXKJ0n68F+ROsL1yCjqU24hn1Sm9zinRIOA5G3X7h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NXgh2s60; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NXgh2s60"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JCRRoe1726669;
	Sun, 19 Jul 2026 05:30:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=IwUg44qYO4V1xWB+lDVYN/CgQUocouo13bKbjCApaDU=; b=
	NXgh2s60UoyBVB2aLVqDkBggZ74x03DW0zRRfCQpW0TIe7Ij77iQmue/Ihlwt5Go
	GfrRiQ6dbvRLfWwz0vXAmsHtX6JguGTVpT/HvfLKPYI5n7k6FuN2R9rBm1NAWjuf
	2HNLGdUX6P4AJlZ2WMd21zm+yFVy2EKipUDLKPMmrWG3z1NEQkUPJJVn5vZnyEd8
	1HbImXbBPsFeSfRc99Ahg8Y4gJ8hfYWISkeLpngci7fUPkxrDRXt2FIvyE+5zdl6
	XSyTTFTnpW5ESzely7SUyxHPBaPljK29yZyRdnFmR/MnX7XENCC5VbmMWncA5x7q
	v7Cy4oUVa2trQylQEKzWUw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg90crsn5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 05:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWxMRuUwIZchzY1vJSPV16NOQl7P5kgUonTmgT9ADDevubDuW1p6TyQDzPx9nZIoaVt0vieT7S9+vU0coVoyvXU2+tWExVTxXeN01QrOtKlzZCYL9U0SK1SS/FizDkhqSY5MPC74qoFrL91wx/XKvj6ath31swLysO1OpmmenKLapPxc2AthrUGM0JUE0koV+Jk95YhJkw6Z1eMnM5IQHxcuKfhkAXzy/b0+E2jeXMTzqu94aQFswTsN/rNKJc2Ikj/riA1yloV3MuOGUJHv8cocZ2aNybIYVWrHH4t0fXQLKnx2d50mxePg7qubkJNBGnUBkH+ZLS3BIVZdVdTwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwUg44qYO4V1xWB+lDVYN/CgQUocouo13bKbjCApaDU=;
 b=hM/q8/4+iFcuCKRECsSKE5ZtDl5H71vKMpewY6lWfpVLW3fUE08zyxz4odc/OZTapicAL+e1g0oyyy3T7fdhKa8oex9Xa3KbCLq6l13dDAcQvYeRUUdrM7lXWToT7BXG8BHy8C4+BqBeFQoPG4NNZqB439ggaMthgvTSQYDr7eZ2zJIisS7AbWgzGxTGU4DhrvfYdWe+PGyhf+3vcg6pJleHsVb3iQCTWEcURmiazoHMFKwqpP5TaNKvlJ9233DJ7G5UHXmDnlo0oAg7yshq7vhRHR0eRvxpuwzUg9Bb1mDUldhy04taaRUKoLPA9cjWoqtExtF3yTdZlnxwnwr8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 12:30:55 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 12:30:55 +0000
Message-ID: <049d7740-8fc1-43c0-ab53-fd96886733f2@windriver.com>
Date: Sun, 19 Jul 2026 20:30:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nbd: replace wait_for_reconnect with non-blocking
 retry
To: josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yun.zhou@windriver.com
References: <20260707102724.3838638-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260707102724.3838638-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0097.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::6) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca5798f-85bf-4c86-0e0f-08dee591943d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Dt8pWlkQkiuUpPnEAwdK5eWbkUXAzEiUqkM49TzgO91E2mu46foWjNPaN4c0Krawr2gyjtykJ93xKfULQUroDfWXfDAJ+NcnnmhVDhi1c8BLcSjk8WtkBe/XQ2/wYxFmv8ruWk2Q3cuj1xLY5ptszp76D0XlIfGklvQsxRQ6qDc6CsrRzmib65zBFBSNOlIEDsvEdsDkM51EuYru3SI/+T/trSzwfenpVxVMcmOzhOj+rQe35VFTCc2Qj+JOiXkwq6tqWaOf9qXbUFB6HJVDderoFBJgu8CInQZGkJ8gUoZhMmFPpX0CGIgRLUZ0bcM+ScIeWkTTojXhB0MvPApSzHobdMIx1QvTpMj68qR1ZVHNqdyfcJmPJENsbz8g3NH7s4BM9m0E8AXsp1lvg9chYtdsMC28g5nmdt9CB9oMzOabzr4nvb44zZW7ysTjf+4dfQNBbgOeN4GtIMHTBFo4SuhB/ijjsymfDOSF4LJbbhFEwihbtanUZ4jTBSE5HI7+JMihQyWUEC6Wsv+lqd6a579WCfn8rpyR6JX4pfP1G7i5/PpjIogkJfr0M/AUacV9/DNLDE75ITLU6T8LSkg5RZGSn6UKBaN5nfCjJ5H/bS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERxNURtTC9sbzdJeGF3T2t2MWxVc2JGMytzT1ZYMjM3ckdtQVdndENMZXA1?=
 =?utf-8?B?V0d1S1JVaUI1eU9pOHNuZlJnd2djREpZYkV4ZVBpQ3loTG1NZTl6MFpJbTVM?=
 =?utf-8?B?TnM0SDU2cFJxbHU4emFDNmg3T0ttOWJueWVDYkJVbUkrMVRxdVRTNFdPc29J?=
 =?utf-8?B?RUVBbWxrdTlBYlc2TnAyVXNsRm9mOTMzZS9haEtIR0JGZ0FVeHFUaTJza2Fx?=
 =?utf-8?B?VFJlQ2pDYzAyYnV2OE4vQlVwMEZzZG1kVXZxNEMrQVFxaW55RUNZcmlpRXBS?=
 =?utf-8?B?Mkg1UkVFdjZjUGFsR3kxNWJWbllWQmZpLzEvWHFiYnVqanpNelpEOE80aGtV?=
 =?utf-8?B?eWEwaHJVSVB3cGlwcWxURXlTZlU2UzJGMmFSOXF1YTF5TGlKb1QwL3NjazlK?=
 =?utf-8?B?NzBmd2I5ZjdHT2hPb2JReDlLc1NOVUJBOVl5RU1Mc202eVZzQmdaMStpSFEw?=
 =?utf-8?B?amlzWDBDbHpJNnU3cS9JeVMvTkRtSSthU3VWYnk0Rld2blpCLzdrY0ZvanFk?=
 =?utf-8?B?WDNBaWhKMFViVUVyOU92ZU14Z3I5U29kV1hNdVl3WFNleWZXb3NoYXQ0NDlr?=
 =?utf-8?B?UVVmYlRtblU3WGVLd3JHMU1ReVh0OTFza1NONDBsLzlFTXNUZU83dDZENVlP?=
 =?utf-8?B?RzEyV2F2VU8zODRGVFUwVE1RYVdMc2FHOUJqN2lJczlrMlJ6VUdxTnlUVEF2?=
 =?utf-8?B?eFMwQ2twYXdMSXBIbEd5OXJlbUg5UEtPUlZGaXE0UlVzOHpCN0pUSlJlV29W?=
 =?utf-8?B?dW9IL2pGSGszLzd6R0l5dDNBOHBUOFR6anlqcEpLMkhzbU5QNXBDdHpzdkxR?=
 =?utf-8?B?bmR1bVFGKzN6Tnc2aEJpTEtiTVBSRUJVWlBoSzhMUy93SU1iT3EyNU85b2ZT?=
 =?utf-8?B?Uk93UnJKcTN0UHFUSFBzLzltQUxUSExNa1VDcWVoNWkwNHhXb3llNXVjYXpJ?=
 =?utf-8?B?c0RiMnZ3Skx6QVlkK0RSSEJ0L0pkeEZ5Zk9WYUE3UnpBc2FvR3E5SGRmcmdX?=
 =?utf-8?B?Z3FuSGpoS0k2VFRrY0xpMFlvVzBkb253VE5vTTI1azBIcXBLUTB5WFBSZkcz?=
 =?utf-8?B?Nlordk56SHBZRStWdFpxejZRY0hGZU9sa2kxaDJDRlp5WmNlOXdiRUIvblBD?=
 =?utf-8?B?VXkvVzFCUmFsRlZOaURaM2hQZnFqSWM5Ty9kWlJRaWdUTGtFWEw2L2N2TWdz?=
 =?utf-8?B?eEVoSlkwYnpsc3R5YS9XRmlPekc4WXZFQiswUkZyeldYcTFlbWUvQkdSRTNq?=
 =?utf-8?B?WXVZV082Ym9WK2F1QkgrTkJlajlTYjdpU1BrWUlodG0rejZIQm5mQklVUk91?=
 =?utf-8?B?dXJhRnpFSkh2cE9JMGJsdHNZTmZUMjFBUmRvaVpXZy8zWDlRTmRVNm1wemU3?=
 =?utf-8?B?bzJjYS9pTHcwN25kdFliWi90RzhOQUhKZTJHbC9va0lyTEpSaE12YjU0OUls?=
 =?utf-8?B?VjVVTEFqMjdpVHR5a1ZnWDEySGx4YWFYVEVkbEhkMmNsZElaaXF0Y3A2N290?=
 =?utf-8?B?UXBnL3lFNmo3ejFPOElSQWtaWUlMbUphL1BpTW1DQlRBN1U0S0tiT0daaWRS?=
 =?utf-8?B?clBRRkNoaEluc2wvQkMycHBPWmgvN3RqeHVBci9zSWFkSVdqb1lSRHIzMTFz?=
 =?utf-8?B?ZnZ5WFhoYU1iYWRWU1hMdjRWMEx4Q29vQi91aHRPUFVLUEQ0YWdwMHQveDFv?=
 =?utf-8?B?blg1RURWbkh1ZGRPOENhSmlWQkd5MUo2UlRhdEs1c3htSHVjQzB3SEVDVUZI?=
 =?utf-8?B?SklvNDRpd0V1TkVEblNFdWtCN3F3NTlROWd3Y0hocmJWZ09tSFZta3ZFdis3?=
 =?utf-8?B?WW1TU1EvcDJMN1dreENBK0NxUW9VcDQzVEZ6bm05RTZIVTJLQ0l2UVVycE1w?=
 =?utf-8?B?QzhZZUxtOTJ5M0MwL3BmTURZYytuSml1WGEwS0xaY2NOVHFaU2pWbzFkQnd0?=
 =?utf-8?B?bjY0dTJUS0ZBRFFQVVVWaDlEd1pBSW9MOFlOVTdiNy85cGtGeVYzaXJjeTgz?=
 =?utf-8?B?d0FIUEJWbkQzeUtjV3ZZdmc2clNBbkNxaGRzSkgyemVnRDVCTC9yb3JyYm9B?=
 =?utf-8?B?L2J4REsvM1NQUlZZemxlRXFuaG1UdEFLVWt4Wnk0Rk5kTnk2dDNIYnBNYkk0?=
 =?utf-8?B?TkJyUmtqQ28zRVZWK3kvemFOa3FjbGh2eEJZZWRvTEp2QjNIVUlWczkxWkxm?=
 =?utf-8?B?TUVQWHNUOHRCanNpNnI0UmlJMTkvNjVBeVhidWc3Tm1VWUZnVjJvZ0dHSWFB?=
 =?utf-8?B?T3FHb0NBTlUzTjZIK3lGMncraUsyZ2JXU20xZllBUGJpRWFGK2lVeWcrTU5R?=
 =?utf-8?B?VWhpU0lsb01CbDJjZzdnNTkwMXBleUdZMVpPck5UaHZnYVBFSkx5Zz09?=
X-Exchange-RoutingPolicyChecked:
	dqf9H0H3QP/PosLHLAn5o2e+WCOr0DwKwDdquTtT/PVEsfeW8dCa3ijzVwbOED2euzaYhZk94aAbomXOMEPB9DbfeldAQYv4EVSykgkSXV6vbTWvVDQ6Eub14W2+EZf/8+oFI7040fV/LXZhW3gvZhmeTg40LbnpLl3E43+kyu7ozLIZI6Vo83s2kae20sUwBN0qXqHUijdRdHFxbeKFf2M723HVRvB7a854kXjEWAeKYuiPdoga2YkVhRbmulrly1zzlS/o4undpP7RZv8hnbymoXmJSQAR08EOFMmo0H6O/Qf8ncMsqMsd/BfV31YPIv0ExEM+j9+TVHDMc6u2sw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca5798f-85bf-4c86-0e0f-08dee591943d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 12:30:55.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRP3EKLJetGg5GFHuj7Jn37LAALePtFKjP1LkAQmYVuzkOE4AE8xkXJVJshd7IdWFMBkMY/OxyZkNFetOirINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-Proofpoint-ORIG-GUID: k0Zaa7w8SsixhVPLYxHsH_QrNscaVzlk
X-Proofpoint-GUID: k0Zaa7w8SsixhVPLYxHsH_QrNscaVzlk
X-Authority-Analysis: v=2.4 cv=AOkSgtoa c=1 sm=1 tr=0 ts=6a5cc383 cx=c_pps
 a=3ImmgSqUqdqu0AlmHxYeZg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=ey1nZNZGkJtkNaXn9fcA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzNiBTYWx0ZWRfX6Rrl9EvTWURn
 NcLGQcXHpUIlqZ/0NZfl+JwqQ8k7/j2o8Pvpsap4AXvbArSueF6WUwYyGR28QDLZVtsA4mW4fFK
 ffHNl1IRpSOBTPEoP14RdRcworxiQbogogTRi7VVKuNLW7y7umj0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzNiBTYWx0ZWRfX9j7LNnQqaC5I
 mpALkI3B8V/o/hj3vfx5Q2TeHhHQKp8e5X+ZGaKL9jFV57zFIiuccSkyuYtZvnoVc7Z8Q/jyHL5
 1QV2ejXk9PFEo1BNVUYwCCfSSUMiXAD0z47ZA3XhiWoj/lJQscV9d+lzQEgda2sPC2tEc545NAg
 C07mjuDEqqk3GQkgsUXybh9bkQh4+ffA1Z7ga67mJmSivz4V0eWGRjUnTWuM/Xq53BDfIYWeqig
 XiU7GHXcKUnVpBxXmCbaSs+Hx59pCyD+7IB3bY+l3NiQulDWz7QpASpOX03a9mAgkpPra4DZvhH
 DXKenIwo9ZkoMXXvrRFQga3ixnA/H1wq3OPI/jn2r0OosvU0jlkrMw1+BJnNX6nL2LcR2MoqcCl
 Z9OQNMiB3mJx15FAfe5U/y7Xbf+Ki3kyZN4m7X0O+H1XXupt0KQaSl4tXyUwH1uPSviZIffawzd
 JDoMnk6teBXntTu+MiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190136

Friendly ping.

On 7/7/2026 6:27 PM, Yun Zhou wrote:
> wait_for_reconnect() sleeps in the block dispatch path holding the
> SRCU read lock.  This blocks blk_mq_quiesce_queue() (which needs
> synchronize_srcu) for the entire dead_conn_timeout duration, triggering
> hung task warnings.
> 
> Replace it with a non-blocking nbd_reconnect_possible() check that
> returns BLK_STS_DEV_RESOURCE to keep the request on the dispatch list,
> with a 1-second delayed queue run to re-evaluate.  Once the timeout
> expires or the device is disconnected, fail the I/O immediately.
> 
> Fixes: 560bc4b39952 ("nbd: handle dead connections")
> Reported-by: syzbot+30c16035531e3248dcbc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   drivers/block/nbd.c | 61 +++++++++++++++++++++++++++------------------
>   1 file changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 70a04d541ea4..43aa4121f0c5 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -94,11 +94,11 @@ struct nbd_config {
>   	u32 flags;
>   	unsigned long runtime_flags;
>   	u64 dead_conn_timeout;
> +	unsigned long dead_conn_start; /* jiffies, 0 = not waiting */
>   
>   	struct nbd_sock **socks;
>   	int num_connections;
>   	atomic_t live_connections;
> -	wait_queue_head_t conn_wait;
>   
>   	atomic_t recv_threads;
>   	wait_queue_head_t recv_wq;
> @@ -1124,20 +1124,25 @@ static int find_fallback(struct nbd_device *nbd, int index)
>   	return new_index;
>   }
>   
> -static int wait_for_reconnect(struct nbd_device *nbd)
> +static bool nbd_reconnect_possible(struct nbd_device *nbd)
>   {
>   	struct nbd_config *config = nbd->config;
> +
>   	if (!config->dead_conn_timeout)
> -		return 0;
> +		return false;
> +	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
> +		return false;
>   
> -	if (!wait_event_timeout(config->conn_wait,
> -				test_bit(NBD_RT_DISCONNECTED,
> -					 &config->runtime_flags) ||
> -				atomic_read(&config->live_connections) > 0,
> -				config->dead_conn_timeout))
> -		return 0;
> +	/* Record when all connections first went dead */
> +	if (!READ_ONCE(config->dead_conn_start))
> +		WRITE_ONCE(config->dead_conn_start, jiffies ? : 1);
> +
> +	/* Check if we've exceeded the reconnect timeout */
> +	if (time_after(jiffies, READ_ONCE(config->dead_conn_start) +
> +		       (unsigned long)config->dead_conn_timeout))
> +		return false;
>   
> -	return !test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
> +	return true;
>   }
>   
>   static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
> @@ -1168,23 +1173,24 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>   	nsock = config->socks[index];
>   	mutex_lock(&nsock->tx_lock);
>   	if (nsock->dead) {
> -		int old_index = index;
>   		index = find_fallback(nbd, index);
>   		mutex_unlock(&nsock->tx_lock);
>   		if (index < 0) {
> -			if (wait_for_reconnect(nbd)) {
> -				index = old_index;
> -				goto again;
> +			if (!nbd_reconnect_possible(nbd)) {
> +				sock_shutdown(nbd);
> +				nbd_config_put(nbd);
> +				return BLK_STS_IOERR;
>   			}
> -			/* All the sockets should already be down at this point,
> -			 * we just want to make sure that DISCONNECTED is set so
> -			 * any requests that come in that were queue'ed waiting
> -			 * for the reconnect timer don't trigger the timer again
> -			 * and instead just error out.
> +			/*
> +			 * All connections are dead but reconnect timeout
> +			 * has not expired.  Return BLK_STS_DEV_RESOURCE
> +			 * so the request stays on the dispatch list, and
> +			 * schedule a delayed queue run after 1 second to
> +			 * re-evaluate.
>   			 */
> -			sock_shutdown(nbd);
> +			blk_mq_delay_run_hw_queues(nbd->disk->queue, 1000);
>   			nbd_config_put(nbd);
> -			return BLK_STS_IOERR;
> +			return BLK_STS_DEV_RESOURCE;
>   		}
>   		goto again;
>   	}
> @@ -1437,7 +1443,9 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>   		queue_work(nbd->recv_workq, &args->work);
>   
>   		atomic_inc(&config->live_connections);
> -		wake_up(&config->conn_wait);
> +		/* Reconnected -- stop waiting for dead_conn_timeout */
> +		WRITE_ONCE(config->dead_conn_start, 0);
> +		blk_mq_run_hw_queues(nbd->disk->queue, true);
>   		return 0;
>   	}
>   	sk_clear_memalloc(sock->sk);
> @@ -1499,6 +1507,13 @@ static int nbd_disconnect(struct nbd_device *nbd)
>   	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
>   	set_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
>   	set_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags);
> +	/*
> +	 * If all connections are already dead, no sock_shutdown callback
> +	 * will fire to set NBD_RT_DISCONNECTED.  Set it here so
> +	 * nbd_reconnect_possible() stops waiting immediately.
> +	 */
> +	if (atomic_read(&config->live_connections) == 0)
> +		set_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
>   	send_disconnects(nbd);
>   	return 0;
>   }
> @@ -1766,7 +1781,6 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
>   
>   	atomic_set(&config->recv_threads, 0);
>   	init_waitqueue_head(&config->recv_wq);
> -	init_waitqueue_head(&config->conn_wait);
>   	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
>   	atomic_set(&config->live_connections, 0);
>   
> @@ -2337,7 +2351,6 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
>   	mutex_lock(&nbd->config_lock);
>   	nbd_disconnect(nbd);
>   	sock_shutdown(nbd);
> -	wake_up(&nbd->config->conn_wait);
>   	/*
>   	 * Clear NBD_RT_BOUND before releasing config_lock so that
>   	 * nbd_genl_reconfigure() won't queue new recv_work between

