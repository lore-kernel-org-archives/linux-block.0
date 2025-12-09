Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B13B8D44
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279891; cv=fail; b=kpGUH8XOZK84T5Tp0zVMeP5BmJoHqNgQ2n6heOmWIUvGIGN1P+qqru17boSyWOxS9Ijd3PgMs6ws/vjLvmjFTyWtHc0hr2WFBQskXXZ3oOhu+0Myyy2+dNnD7DdgILN+kDfiC2PTQiDsxX3Bd7JSmscPY61gbwLuxe9uoihhPro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279891; c=relaxed/simple;
	bh=26tmZHyaPs9UB+r1zU5AiXQUdy7HpmhH4KqRqtwiTxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIit1FhIqZeNBofqbOCG27sVuUIKglG+7r6uSLBIUfeBKYEb/FpXRpYsJ9K2zeJ4xcpauoRhPgcVtjKvRpF0FrK2Wx0BCVPxxNbEVjdbQUU0R81+9UGXZrGJi+X0T+HVeIAXEIGT5b3pcenIvQsHBoi+IX1tE2JILQpbnVb3Vck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mkUGXHHq; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkUGXHHq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRTenFzCm1BW7z+jCYPIutNYbZemhsUYRM6BYe/F+nM4g2WUlZ3SmF31ru/XUoT0Re/X+eA1LdV80KN8q7FNh9YfRJJifBJjrQyNv4IqyC+ePGPSxOWhoK724AoCfpJz3qIvFMyBccoXZ82Gl2cUEcxZfLZ3qMC1Uno6v0pHRI8y3bLpOw0LxCve1KrJ/2SYZ9sNuza3DBFCfQCWnW4Tmxd36uxGtstFli6d7skFkLiNAQ1CekAoLuh6GwrEcufpUyzka0GcUW40B/2dL3EzuRnxeORXcRwPK0cPlOSjNJw62PlpCPvidES6ZCbLyBDyF2a36g2ZiapGEF9xiX2tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfLw0VWF2K0vO9sdqtzPGK3u31fW7x0gQ9Fc/zrpEwk=;
 b=IuiQeDzRz9zw+Im6D65Or4RdEEBz4F52+JRoddz8aoa/S+aAHRBhLfiocbjSfn3L4TfoJ4O+aoGISW8LKvCqKWN8KslD1GwVKhzbCxtN+nuubynf4SYTcTOCJulA0UzIH/nP3S2OnyZ0scmoLw9l4CXh24+PzzqXDJoVk1uaK3GfvjdMb6Fgk1iiaxYN63FVpz2j1Xma3cSWzdf6Fv+SOwiICxUCDaAqRnWGBpg9Xuk86/2dFNpLb+ZBkW2lVuExbrg5hxh+pW+Hf8LWc+eKa/C2hO/JzWtE8cIh3YnVHDSaMOxLG6QaTiE4Jh3RNK7szQZImqpaSN7WJFFN19d0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfLw0VWF2K0vO9sdqtzPGK3u31fW7x0gQ9Fc/zrpEwk=;
 b=mkUGXHHquBp1cNW5O0bLIrqqDNkgsjBWlrXSKhJfThb71EaY8mR6Pnp+GJHI0TYdQYEnlxD0Fms8RcRXS3U9iBSCFnV5Pfv9ZnqWUPuigSiHR3o6ojuHjbrA1TvJMIaAmUEJ5S2HTrH8hWCMgfvX1pXYB01A9WA2KshP/yTPDZOQz1wTPwmpP20SOe3fexD6RAL/Ww1KIGAi3i39NIOtNMzT74yKflY0xyNzX/kId4VCPm0AMyrjf+//vikpU4LW3TdQF4QOfXiyrVj2jROC3gFnGfnE35plIAzXDBWOVXIHNMPR9I/8D8sEHJwW5XejfiAcCKQ9ZeWLieTgZ5HFTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 11:31:27 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 11:31:26 +0000
Message-ID: <6649eb8e-ae68-460d-95db-deece134e9d1@nvidia.com>
Date: Tue, 9 Dec 2025 13:31:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-pci: set virt boundary according to capability
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 kch@nvidia.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20251208222620.13882-1-mgurtovoy@nvidia.com>
 <20251209064015.GC27728@lst.de>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20251209064015.GC27728@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: c6035dbc-1816-48a2-2599-08de37167d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlhSaTBPQ01tWlFXakRBSGNMU3BuNnNGVGtBNFo5dHlIZXFMaFM0SE5jU21I?=
 =?utf-8?B?SFJrS0dEaWw4SHRqak1sUTdnT1BaRFJUL2tuMXZ6MVd2ZHM0RGtqZzNPWGNB?=
 =?utf-8?B?SUhYa29zMmc3a2VRbGVCMnl3K1ZEMjIxR1hxYzRWUU9Cb0FTZ3dXdVVPMGsv?=
 =?utf-8?B?eVJPVHRrTWxKd2Y5YTAxbEI1VmRtaWE1QzZnb3YzeGdwRTRleVJQNmx5cndo?=
 =?utf-8?B?S1VBNlNuVm5lZ3J3M0xkK01Kb1ViTzZ0ZXFzb0ZOR2JzM3JndjRLUGFIenBx?=
 =?utf-8?B?SWdza1d1emU3Y1hYVThEYWtKV3hnQ2F5UGd4aGF1dGs0MVBSMHBiK2xvUndx?=
 =?utf-8?B?YUpLUXZ1MHJCWHRQTjJsaVhGWlNBZTAzY1NUYjY2UnBpWlpUVkFyRzBCY1ZO?=
 =?utf-8?B?V1pMTXAvQWZPbE1zTC9GWkdLQmhkWlBQeVprR2dYZE0vRkNvN204TXJEeDlQ?=
 =?utf-8?B?czdkekp5cnNxcW1oQ0xtQlFqdWpwVnVBZWQwTlZ1SzlSTXpmR1p6YWdaQXhE?=
 =?utf-8?B?WFZaSk1nOGRhNVpURUR5anFKMTRuTzRBTnVucnJNQzNQNnNieDRWYjN6dUdy?=
 =?utf-8?B?V01BTmx3VEZuR0lpdW1TYWlPWUl1VU5ZRGJTRTNGTUxkVHpCTmNoSlFZYUwv?=
 =?utf-8?B?ZzZ6ejI5Q21FR1hWN3hZbzZpdndoSlN4dG15Tjdsdkd3K3gwR1F5KzRLOFE5?=
 =?utf-8?B?NzBLOXpGaFo5THhKcXl1ODhZNmNiKyswaFJid3pBaUc3OFlUTDg3MEI2Y2pC?=
 =?utf-8?B?OUhaT3M2UldRQWRORFZVQU9sYWE0ei9JZFVrcDl2d0d4TnRmdUVINTNRN3dW?=
 =?utf-8?B?QTk3K1NTa2JKaDJMeDJ3Y2Y4OGQ3OUtzMFZ4cjFDLzdZRUx1ekdTb0gyRjZi?=
 =?utf-8?B?MFZVVU1aY0NoaTBjWXF0M3NuMVRZeERHOHpDTFlqcGt6YlJDVk01NWxVUXRn?=
 =?utf-8?B?UEpPSSsxUlZKN09Ha1pFcUlxbHhvcHVJeUcydkh3R2NiNUV5MkhhcnRvdGxE?=
 =?utf-8?B?RUcrNFM5S2Qwa0lnb3dwUmNCTGFJM3ZmVFpkNFRQeGVNQ1QrWUFXcU9MS2Ni?=
 =?utf-8?B?R05EbWRkNDlkdVlwb2pRMzRPL1hqMGZmbWkrUTFhVU04VkdkbmJzczl6dEZw?=
 =?utf-8?B?TTRwelAwb2ZMdWVVMUY1Zkx6SjA2dTJZK2ZaU3NhSHRua2p6UzRnem5DUkUr?=
 =?utf-8?B?NkxMcGJjdmxERU5CYzFjZjdMSnd1d0JKUm0rbXZNV0hQT1Nocm82OExOYVZn?=
 =?utf-8?B?YWJKVzhyVFZkaHdYNFVtM2xnbjFKeUJENzY4WjRvTjJoeWVHS0tKK3o4alQr?=
 =?utf-8?B?ZDVrQlJPMTYrSVVSNnpNQzByT01rT3BwSWxsem5zMDBsQjgwdVd1c0Q3NG9P?=
 =?utf-8?B?Z3hLajFubElZeFlpNGpCNDlXbTAvSytMT2lIamVKWWlVaEV2SjBNQk1JQnU3?=
 =?utf-8?B?UXU2YWR5dDNGY2hOSlU5RnlCOHFVS3J3UGQ0Nm94MUYxaDg2akh0MjBJaFIv?=
 =?utf-8?B?V3EyMURkYk9Xb1RIeThyK0JhK2trTWU3YWd2UDA1VGxzamVVdWpFeTNpWXR0?=
 =?utf-8?B?Qjk1K3lORG1tWE5DYmh1WlREcGMxa0hCMVQ5a2pRcTRRL1JRLzlzTGU1QkVG?=
 =?utf-8?B?WWZXdHlDQUwvQlJwWkY5TEFnOTlOazhKTTZ2WjJzNzFPQTRkaitYN0xnNnlT?=
 =?utf-8?B?cXBBUnBYbG4zL0xYaFQ2T2VUemswcWErMGlCd0RwRzFib2xJK1BlcjlIME1a?=
 =?utf-8?B?UzJuWnFvTEVuU2JkZS94WlFweS9CZTV0cXdSM0NRZ0hxS0d4aDdpbng1VDIx?=
 =?utf-8?B?OTBMRGZwTXhFcmhEUkVWOFBYSGJpZWU5ZkhNYk9vRVRvdlhLNzNEUjE1WFR4?=
 =?utf-8?B?Y0RUYjJ2TzIzRXpmTUxpZTNQV2JZT1hkOG54T0NkUEhWYVYyNFg2K3pjbFlZ?=
 =?utf-8?Q?6/QEYrN9HypMaf97MjNGzoHhHIq/NK3N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWpDaUxCb3d3NG5PaUVPbzFSQWtMRDdVZ2dXNDQxamIxZFQzN0JWWjdWc05C?=
 =?utf-8?B?OUR1ZFRIQXo1TFVlV2JHU2cxRVRPK3hNamg2SEQzM1JqcXBhbmxtdys2TDd3?=
 =?utf-8?B?OXJCTkdvQlFNaWI1RjdBSmxRUmc0cytEMWs3eFNsTEw4RnpqazIzL0hTQXdO?=
 =?utf-8?B?bjN6R0RmQnBwb2VoQVpsbDNpeWlIR2QwR2tNOFlZR0g5elVSbUpPUTNYNGN4?=
 =?utf-8?B?TVFHWnBKRkV2UjkxVUY0QVdxdXNjQXVmUGwyNm1KNVhNZndYR0gzRGpoWUpV?=
 =?utf-8?B?b2piNW1nOWlSSU5qR1lFcDJHQW5CYWdhUmhQd1MyT0ZsR3M3Ym1GUmxBTHpy?=
 =?utf-8?B?R2VSdjQ1SmhlRW9SUkhFRktaQzJWWjZjOXJvUEpqWkhKUFV5RHdveWhmalA3?=
 =?utf-8?B?SHJFRFVsbXlHZlRPeURiVHpuV2FvVDM4L0d2RVBQMWNjSWwxMzk2YTlpTUNY?=
 =?utf-8?B?dUMrU2J4K3FRTU01V0tORWU4c0k3dzZtdkJHL0hVb2d6SVNlQjhzR2dDT0VT?=
 =?utf-8?B?bGZ3eHUyL2VzRWo2Rm5RcTdUYXNwZWlYSlpyNCtHdkpXUkNZc0w5RHB6RFdC?=
 =?utf-8?B?cEdnd1JqL09mK2lZUzF0eTRJcW1NendLOTRJbThKWVpBUVNOMVUyVGZ2M3FL?=
 =?utf-8?B?Z2UyNFR2alllb05rUVdtNjhHMVlBM0IyZDRkZUFVWXdjbzJEemZpcWJrWkV4?=
 =?utf-8?B?VXVyLzAzUmptSkVtaTBIVlBKYlNvNnBMbDl2Y2x6VHViSTFQdGQ4WGRTemYz?=
 =?utf-8?B?OWFwV0ZKQ0tHSzJwdGNVZGxpU0dEam5wZ3d1ZlJ6ZXZMSi9OY04yNitDSCsx?=
 =?utf-8?B?VU5wMVJNdmFwTy9ueHVpQWo3OHZQZVFYV0luN0R2Uk00K2RhUk9VU3cyV29l?=
 =?utf-8?B?RkdOUG9RQ3BtMVVwbFh2OXk3bnZwWFJqM2tzbHg4a1QxRnpnSmNUQXNqNUJT?=
 =?utf-8?B?eVZYZDkzeWZPODVuTG9SNlNhUVBoVW9NMkM2SU5WN3NYbkRaTGpYc2pWaVBN?=
 =?utf-8?B?VDNVekZGVzBicENBMU5pU1dsNG9yUWFIU3VVZmJzNVM5U2tLOEpOcjNxZEdz?=
 =?utf-8?B?dUtYYnpkRERCbFlCMmp0eTgxdFJTSTA5clpsTndFSnhHSDRXTC9vN1I1OTlu?=
 =?utf-8?B?Z1NQVE5PREVuazB5b1VDbmNsWU5ENTYxZTdVcW4rTlBMbExwSmVmRDJRdkdv?=
 =?utf-8?B?OERqSUJ0bUIxQzdSM0pZV2NLcUo1Z3Y0VllBVHNOU0lOYjFNdGJZaHlPQmdv?=
 =?utf-8?B?UVpBNzBmZzA4M2VscnBwekRxbytSZ3FBWEptanpsU0FaY3VkNFVaZGZORG1h?=
 =?utf-8?B?eWgvVThBem1GQjNqQUdWMTVIS0ZBb0RMQ28wdDhFOGxxM3QxV0NZU0ZlaHEr?=
 =?utf-8?B?TkJMOENGMXJDMkRCbEhENWI4OEllTi9HakkrN3NwbzZzOGRvMHlzTG1vSlM1?=
 =?utf-8?B?Q0I0eGJiY2poSFM4c0VnMytydlVtbVliYjFaUjJHWW05YWV4WG0xSDBSM0h1?=
 =?utf-8?B?eGs0dTZjZ29HQ2NsZjNZNU9rV0ZRR29ZSTNLSDgrUTFTRnQ5SHVTTWlmMWlX?=
 =?utf-8?B?T3dCVjlNYWpuRjN5WFZUSXBmT1NKWWZJdXJPb2hzVWZzcjhPdWFXOHFIUm4w?=
 =?utf-8?B?cnM4TzIyUmkvYkpFdXMvZzgxT1VUaHY4RVNQbVIxN3BMSTRtSHRzL1MxZHo5?=
 =?utf-8?B?MGtZTG1sOWhxNkp2c3k2eTdtL25nZjYxbmx3Mjh0cXlSWFNLRGdSUE9yb0FO?=
 =?utf-8?B?K1RuTFVjanFrajBGY3A1RzdCS1p0enI2V2hQQ002c1ZhemwyRmZuNWhlN0VE?=
 =?utf-8?B?UGtuMWRtdllScDdTZmV2RVIyZEN5bUM4NE1kSWpJWm5aaWFjNk9lc2JTRExC?=
 =?utf-8?B?TWtYVWZXMDJNYXV6N3R5dWpSWlZYSlZQMmdZeUE3dlF1UUFxZW1DY0xIQ0lI?=
 =?utf-8?B?d2xIcDBGZzNVZCtNZjNnTlVQMXBmSUFZdTlacUlEYTY5TnA1am11R084N043?=
 =?utf-8?B?anhKY3pKSEljY3RuVE1wU1ZiY3pwc2kzWDROY0IvK0QzR0RuWHptaVJrUGNS?=
 =?utf-8?B?N1U5UEwvbEk2ak1XaFJiNWVJRHNjem9DdGFQeWJodEdtZTZHSWlTWGtXWE1B?=
 =?utf-8?Q?fKspUIp2OM03iTj2/lnD2TFQh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6035dbc-1816-48a2-2599-08de37167d5d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 11:31:26.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYBEeutFJGbgcT/9gzLqCRNvzqQfP6JzFsb82iawvcbEP6koPt7LU/T7OcuO5NzuTDAdQSpFf4odTtFFIstWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201


On 09/12/2025 8:40, Christoph Hellwig wrote:
> On Tue, Dec 09, 2025 at 12:26:20AM +0200, Max Gurtovoy wrote:
>> Some controllers advertise DWORD alignment for SGLs, so configure the
>> virtual boundary correctly for those devices.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index e5ca8301bb8b..eacc89cd25eb 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3326,7 +3326,9 @@ static unsigned long nvme_pci_get_virt_boundary(struct nvme_ctrl *ctrl,
>>   {
>>   	if (!nvme_ctrl_sgl_supported(ctrl) || is_admin)
>>   		return NVME_CTRL_PAGE_SIZE - 1;
>> -	return 0;
>> +	else if (ctrl->sgls & NVME_CTRL_SGLS_BYTE_ALIGNED)
>> +		return 0;
>> +	return 3;
> I don't think this is correct.  NVME_CTRL_SGLS_BYTE_ALIGNED requires
> each SGL to be aligned, but is not a virt boundary.  The dma_alignment
> value in the queue_limits already takes care of that.

I see. The virt boundary handles the gaps.

Should we modify:

dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);

and

lim->dma_alignment = 3;

to ease the restriction for capable devices with 
NVME_CTRL_SGLS_BYTE_ALIGNED support ?

>
