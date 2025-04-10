Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1508BEA
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253777; cv=fail; b=gT5TNaL+OHwhfRRHn/BwKSG14bunmxnLpxQoouA8AbXKVtP1FpDjka3Yrm9aex0Oz3IcmvgU65ExX59Frh197ZTWRu1qhDBorf3AaV7tVa6n78Pota/QwjsbKdtCA2kKy0ShsDKXh0pp0Vb+uPi226re7kU04sGl2FbAVGS2cgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253777; c=relaxed/simple;
	bh=2jLVkyUfeo4q5S2e3PqICHC7EOHaeT/FNeeZqYw+xAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Njnd4ZnPpTInA+LqR1E3DnGH6alZ36G4Po3gzYIWNhX0rr2ajTmJAnVdEcDlzpqtmOrDdVbNl1E7kGkDq7iRKhLwoD4HM0GaAOR9sbdEwughTOsUeD5JcuGe2kpCqIn504BphzvPJcHO8fQ/Rvi1Cbkusvrzz2rMGG9rijE5X8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jLXw8wg0; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jLXw8wg0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjqcOYDpgp97HbIGdDPJkJ+ZBZAkRy2VtPGMQe9HtSZYI+69A/r4ThJ3KJnUUVVD5glaL8mOAwX5SbpW3tUohhCyP56ujH01v2Htg458B6BG5DShexi8WRC7fY3fpesmttxhrD0/rQmwBvAe4R9/VoXfAVAQewHh1CN/w+f+BwChQ5tmpWs8Fzs/Z9AHl3LPc8/QAloCQNDMMfS2KV7AqhWeZQhaPIi+nZcay4rx75sGxtC0msV6C1isKx/Qfgz9vdAKAFO+bNSZuIk2Q5f7JxGbxP0WlLLQm93d3HdY6W141j2LjfheA/isAWWmJnp5+xpLrN6ubiK9wQ+kxM6jIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECYRJ+JVqeq3D2XMhjP5oMEDIu8tVBbRmeG+A1Sg6zo=;
 b=FYAA0A6jZ3vXyVJ3qo0uS6S+GDPfK+fPBDKNOEJqtlj+F9taD9Nurzd1dOGcGwEa2Fz3Lqut62+zEDyEIHkA1ICyZ3/rUejxZoVwTBUqrynXXHLcG8mlza1O78PSfK3+W3F38hg3Aj+RWAxpBPDddboxaFc+gTMktGMmfD8T6tV+QLmgKunZ5WCUJUrjr5Dpqa+hFx6b+RLG5whv53wfPu49kNyJHfLgJK0bfNUq4oA+x2ktMt3OL668Pa/K9niuRmFQ+ij276dSQANYOW3Bm/3o5WLdZAwrVg74wBOwa7qZdbyUbCGDu5oKpXndaTw1h4xMLBwQJvWWTkinEO+zIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECYRJ+JVqeq3D2XMhjP5oMEDIu8tVBbRmeG+A1Sg6zo=;
 b=jLXw8wg0/YKjNbWp1t//XzpL3fNip/xPPXFsuHfIZkn8YvemW+f9gB9xrvgO/dQcX88lxFXJPw6jQzkBWvCWu7SYr188N0E4mWMwQYqHhuYGBi83iRdzvquy000My0rM917fNilFh8OEsZugMotiTFEBdmBuIw2RKjX8sfGzo3rzJFWRPTx/8gLwJ8cKcWAe5d/qrn2OWCGAYZknRz+f0bVOeGGRoAsI/wxXtJenqmMZzmoZ5uGjRvE+4T3PZqAEOoAkbyA7F/1mfhw01JUbvt3jv4PJb28I64Vw3I2ZI0OQxuhAgmHiHdPOw1jFCM9iuCOhl45RtfsmKTfM72JddQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 02:56:09 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 02:56:09 +0000
Message-ID: <f04289cd-128a-492e-a692-6f760e2271e2@nvidia.com>
Date: Wed, 9 Apr 2025 19:56:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Does GUP page unpinning have to be done in the pinning context?
To: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, David Howells
 <dhowells@redhat.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, willy@infradead.org, linux-mm@kvack.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <939183.1743762009@warthog.procyon.org.uk>
 <67d4486b-658e-4f3f-9a67-8785616e6905@redhat.com>
 <dcb80dc4-a9f7-44d8-b88c-7221ea29deab@nvidia.com>
 <Z_NzBWIy-QvFBQZk@infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Z_NzBWIy-QvFBQZk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: f69dc21c-4ac8-4ee5-4d26-08dd77db3eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFFxWlQwRi92TXJXSkJjeDZQM084a0czN0ZYMmNzZS9IVlV6QzFhTWlWTmV0?=
 =?utf-8?B?WXQxQzFrVVhDTm9NZkZxb1R0SHFQMjF3djFKdzNWQldrckt3YzVadEdLa1JG?=
 =?utf-8?B?WllNOXJ5WFBhcHhRdUNYVnpaeTNzTU5lR3l6OEphV1U0MHplMWhkM214RWp3?=
 =?utf-8?B?ZXV0bEdqOGcwbXpDYlJReTFOdlBkWWFmdGdDZ05QRjBRUGxqSkY0bGxZWmhn?=
 =?utf-8?B?QTdYSnRlUmdsNHNOVzh3aUF2Q21MZ0d4U2sxeFFHeEU4bStKaVRqVUZDQ2NQ?=
 =?utf-8?B?RkhtMHFqWUVCSjdPbGVIWnd0YktUVURPdFpsdW1sUTZGcjNGd0FyOFB5U1JT?=
 =?utf-8?B?UVFhT0Z4MHVqT3h4cld3UXRMZWhFWHdPV3k1ZVhIOWFmUXR3S3NSTlFJbjI0?=
 =?utf-8?B?aVdIK0htV3IwSmI2TVZ3UjdseTdTQ3lHUXFYcFVCRXY5WEc3b3h5RHlING9a?=
 =?utf-8?B?ckh3YmZDMEVkU1RZdHRSVTI4bDB6UmhCWFNpb2tHckZIRHFOU3lRZUh0UmV0?=
 =?utf-8?B?TnNPTURpTDBGeVBRN3VwOFJBRzRMelphR0NZVndLZXYvTUE5MTBDWU42QnVB?=
 =?utf-8?B?SW8wUEZ4Mm5qVWtvbFBQZmk0WHRoNmIyakJnb1JxNU9ZZEdTR1Rvdnp3dEVz?=
 =?utf-8?B?VEU0TXZkdHRxOW11aUZkdlRmZnNnS0NPZW50OEhDOFowaS9Xa2JMTGpITDN5?=
 =?utf-8?B?QWFYWk4xNC9FaDRvdlQrWHc5djJIR2NtV081K0NqYjZJSUdxa0M3VWR4cTBH?=
 =?utf-8?B?OGtKMDZVQS9SQk5qbDh2TnZsUVh5ZWlJTmF3WHlNRG9CVVZFN04xcFBwYXVx?=
 =?utf-8?B?bVcyeHZCRnVWQ0xlSDIwQXZmaER0QW1Gb1BUdlRJOUwvZmxCTzNRYmZPcUps?=
 =?utf-8?B?UXh4ZTd5R3NZYkl0b0ZOZmEveEpKM1g4MExKTFJIRVlqcW1mSW1WV0FQV2I0?=
 =?utf-8?B?alNlc3FuN3dNWS9qK0I4ci82cnlTR1VoVDFRTWFEeGZ5TklOc3lCZC84azcv?=
 =?utf-8?B?SWo3OVN6N2JVa3ZFZzhlaTgvZ0hSL05IOEN1R2ZEaDhhWUNNR0lMdEZQZ1Vq?=
 =?utf-8?B?YStoRUZQV1RWSjZzYnJXM0pxUlZuY3FtSFRNZVZSa1hSRmIzb1lYbGtIMmxa?=
 =?utf-8?B?ODFjb0ZON3FTb0c4Uk9rVXNNK1MvZ3dnTmkvbk9jKy90M2FVQXRoaTl2MUIv?=
 =?utf-8?B?cEQ1NnBHVmc0emlJYTliYUpOSGlEaWg2bldDOXNtcE8rUEtCalBnVUNiTDhq?=
 =?utf-8?B?SGVHTVpjdzdMenJFWGkvT0VWb2VXVEcyUWFUNjl6TU1oTGFtK2RzdmlCcUg2?=
 =?utf-8?B?WHJ6VkdVUW9HeEQ2eW9jRjgvTmZZQUYyUTFwTm82bjBYOW8rd0FmSnprdUNW?=
 =?utf-8?B?RXdCbUd4ZFFCa0p5S2t1UUc5eWpWWEY1VFJ5N3J4c2NlcHloUjRXbXVyYWhL?=
 =?utf-8?B?Rmg3eFM3NGZmOG84OHBoOHJGSU8wMnhHY0xhZlo5Q1VEc1JQUDVUMWxjN0NU?=
 =?utf-8?B?MmlqWngvdWhWcUhYaytRVEpCN1kzakY1ekdKeE5KK05iUC9RQi9JMEdNL0V1?=
 =?utf-8?B?SmxaVHZwY3A3TVM2eUJnZUZyWE9jUmpwUlZtQ0paREw3YWZOVHZwdUgrL1Zo?=
 =?utf-8?B?ZWE3Q2Z6czRiejBUQlEvTHhrK1BNc2VjQ1RwbGQ2d2w3Q1AzSEdqaGI5dldZ?=
 =?utf-8?B?RStQbTV6MzBOcGkxTEpIUzNWUkNpdFh6UG9Wb3lpaEQ0Y2M2V00rbGE5S1U4?=
 =?utf-8?B?U1k5K2xjQlArQTJSUDlJcTdrN0hZYVhrelRUYTZlbXpIZlFQMmQ5WEdHb3Bs?=
 =?utf-8?B?NmlIbGtWcW1yQXF5eGdnc2F2VGRET1pGS1NSaFU5SjhIeEhvbm01ZU9uUmx3?=
 =?utf-8?Q?/gnuug7I0upao?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnV1Qm9tRDRnUWRJNVU4bEZOUjZqZVIzS2pHbHBiTWNNQlVIcnd1S0hEbmFo?=
 =?utf-8?B?VUlQRTBENiswdU5ibk9DWWR4citpSG1kV0VsTEdPTWNxOWxQakw1TDJlUEVM?=
 =?utf-8?B?c0FwWE1wMFkxY3RqeE9rQnhjUE45VFR1VkJvU3loejVXZEUxbXZaT2RLa3U1?=
 =?utf-8?B?dXMwemNkWmcvcnhyNlV0R2M2RVF1VGt0Y0thYmVHYWk4VVlsRDdzVDBmWlpp?=
 =?utf-8?B?bktEM1Z4Z09USzlYU0tiMkF5dFEyZzY1VkF1MG9jUmpvSzRxL3EvMlNIbzhh?=
 =?utf-8?B?bG1WVXBuanRVTUZMNCttTDZDTGpzVndwNk1vNXltZ0JLQ3l0bGFkd0NvanNx?=
 =?utf-8?B?YUcwQnp3L2kxNEFLelkvZVBpR0Nud3VGNjJyYWNZenhuOHJLVGNoMkI1bW9m?=
 =?utf-8?B?NkoveDFXTDlBRTgvWjBTaktHZ3lpa3dyeXlUdG93QXd4QTFQWUxjb0x0d0pn?=
 =?utf-8?B?RFdzczJCYmoySU9RblA3Y2tXdmdXclI1dktCN3hzV21ENExCTW9ReTJrZ2x2?=
 =?utf-8?B?MG9TNWFMbUdpQ2VPZDhNUlI4UzdrSGxOcE0rWjJPd2xNVG5VN085eHVXRFJW?=
 =?utf-8?B?OHNxS3ZRUDM1T2UwSTlsb05YZ2wrQ0tTQjQyWGhhZHpuYUEzZ1k2VWJEaXd2?=
 =?utf-8?B?QUJON0c1VFFyT2wxMzQ1VEtxOFluUFRUS1dVa2ZGY1h5UFgxZFhEOEN5SmIz?=
 =?utf-8?B?cVFpeWVYVmVqbnk5cm1SV2lxWjlqd1cvMXg5MEtQaDRtSk9qenl5QjhwRy9I?=
 =?utf-8?B?aytzQVZuUjdBZ1g5Qmw5SVFxWVBPdERQYjB0ZXpwaEVWWHdvNkl6Z0JhSmVh?=
 =?utf-8?B?Zk1Xb1M0RUs0L2ltbThYSkt3MkhaYWRUQVIxN1A3citsUHFUdXU0ZUxpS0sv?=
 =?utf-8?B?dCt0aDFGKzVJLzFpZGk4akxkNkZFL3A5d3hFMDA5WnVSSVBPb1kzUVhQLzRu?=
 =?utf-8?B?VjB1WXRwMFpxSnhBZzZ4YzNQd25Hd20wZWVocnllcFdVM05EVlYxU1p6MnF1?=
 =?utf-8?B?U3Ara3h6b1FDTm5malZvVDJyaHFoQWUwQlFjOVFKRnZMdkU4dWV5dEc4WE9u?=
 =?utf-8?B?b3lnd2RLL1lCT0gwWE1NYi9kWUFkSDhITW1ENGlYWlUzWDBRMktYU3F4WWp1?=
 =?utf-8?B?MVNKVmFqR29uK2w5YTRMSVhUbGlGMVowVU5UaFkwVllMVGZtajd5bWdldFBE?=
 =?utf-8?B?MGFqdDI4aTNLcmRIUi8wMm5JSTlDMHI1YVVXZmlvdW0rUVFHSWlJODYvNStj?=
 =?utf-8?B?dmM1Nk8zMEVlZFRPQWUyWmpLSVRtYk9OZ3RRLzMrYjFQUXRzSGswbml5YWF2?=
 =?utf-8?B?T2RwNkV6NjJ3ODNHTVpVQUR5dkxjTXYrbFRod1V2ckNNWWltYjNnRkJGaXA2?=
 =?utf-8?B?cWlyTmt0Z24zUlpBSXd1MFZTcDNxVmpFR3JzOG41RmxIZ0V5bzd0aDBvQkcz?=
 =?utf-8?B?NWhBQytyMlNyTFR6ZGJQbEpody96Vm5yUFNuQUdrYUhKaGVpZG5wR0F5YmVi?=
 =?utf-8?B?NW9HN2FQUXc2WkZiQThDZklRL09xRjBOb1h6Y0N2K1B1VjR0SkhQNGNvRnhN?=
 =?utf-8?B?eVJ6MWZBV003WVpsVDRXZUZHblNGSlZaaWFUa2xyT0U4cURqbm5peFNaYVV6?=
 =?utf-8?B?aklhQUVXNGtVa0YwZUpuck9nMjR0SHpyQ1R2Y3NBWkQwVnk4K3NINmNkVjdh?=
 =?utf-8?B?Nno4bFZxVWp2NHZqWVZnd1Y3VTR0MDZjRjUyakp1TzRCenBVR3RGNFBxUWlG?=
 =?utf-8?B?dHhwNmV5K1JyU2paeE5yVk03VnFTTHFxdnRhZHg2bXVvN2hDRlRBSU9OME55?=
 =?utf-8?B?Unh4bkt5bjh2cm4vcEFtclBkNWNlTDVTT09ZMDNDclNzMlEzdzdmS25SUzNX?=
 =?utf-8?B?T2xsK2U0OUVET1ZVS2wyckNzazl6RXNqUUJRRURGL0o0RTJwNkgzTnVTMEQv?=
 =?utf-8?B?YmJpUUJFeG9HT1Z0bzZEK2FndzloV013NS9rNnRZQnpIQk82citFTUplRWZv?=
 =?utf-8?B?NlZFWmkzZy8zK2hDMnpIWVlVN3VzeUxnUjJWWHY2WlNHTkR0d1FNbGU2S3Ev?=
 =?utf-8?B?VG1WdnRNOFM5N0llbXZadEJvY2tYV2JxcUM2VDNKeXJOakRJUlRFZUtHOUFo?=
 =?utf-8?Q?Kmk1aSgbBspaRj6iRevRo4eB/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69dc21c-4ac8-4ee5-4d26-08dd77db3eab
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 02:56:09.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hf+1wbSSkPYsWBnZs0JRwCw4yD3lfrNxKqEp/0E6TQgzUeZ7/+lkPOUsU+FTK3aQ8SIwHUcIkFttFtqzDTsrjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

On 4/6/25 11:39 PM, Christoph Hellwig wrote:
> On Fri, Apr 04, 2025 at 09:59:40AM -0700, John Hubbard wrote:
>>> gup_put_folio() seems to only rely on per-folio information (esp.
>>> node_stat_mod_folio).
>>>
>>> So there should not be such a context requirement.
>>
>> That is correct. The essence of gup/pup is that it operates on
>> struct pages, and doesn't have any "moral" connection to higher
>> layers or additional process context.
> 
> Hmm, indeed.  I misremembered why the block based direct I/O code is
> doing the process context offload, which is to call set_page_dirty to
> redirty pages where the dirty bit was cleared during direct I/O.
> 
> Which I think now that all block based file systems use FOLL_PIN
> shouldn't be needed anymore, because no one can clear the dirty bit
> while the folios are pinned?
> 

No one should clear the dirty bit while the pages are pinned, agreed.

This topic always worries me, because the original problem with
dirty pages is still unfixed: setting pages dirty upon unpinning
is both widely done (last time I checked), and yet broken, because
it doesn't do a mkdirty() call to set up writeback buffers.

The solution always seemed to point toward "get a file lease on that
range, before pinning", but it's a contentious design area to say
the least.


thanks,
-- 
John Hubbard

