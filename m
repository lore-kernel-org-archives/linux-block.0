Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A42620E7
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233198; cv=fail; b=GJ9mV1pn5L48CDGvOKWOSetbfU+2wtDlcqfJN3ItnJcegBmmCuHikhAYy0QbHizippm2q0mTK6mdFrFuJ/qbYwYE9x+7lvH/LpB1vWE23Gjl2oAgJmzgYRB8hKx8wUXRkjIekvHmVKOkAvFRuZFaUHBNLEWvY3MoikYoRbgJJuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233198; c=relaxed/simple;
	bh=OiXaO2IZtdDEVQvSTtwvUV8pEoiegEaDyPgeG1oCDQ4=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=Yd7Cg9iWuM1qmzFGb8IbYhujI1Uu8CGyixguCm2Uugg4Cm9yhC1iWsjmgVzAKWY6SepsHdUfGhDEnfJIMidzFQXFrAhrBSgapThBrVc/3+zNBAQ7CAMeHrBAdhqiF32N199jeV7laQFkC+8VTZvnR963rtujHL4midmfzLUE9js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eoZk/gBj; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eoZk/gBj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMK6WPp/dFavzGlYDPQyeZAozzRjQWrgag2DjV22JVJEVRlijiSbwcLf0UAUWJLFTTSS464sGBo7gmvLeRhmwqGUNZGnZsz/NGZLC3zeheZwO2E7ck12I7Iu5EHK/aefpVyYU3fkF8qofaaXvv159tTrhfH2XIe5oyDltdkOkgA7XBJf39pHtzTPY/Fhy6sTrkrreRuaHPH7/AxUBYUsAoRpAJZTUfs+c38BXDx4ASioS4VfTGI+GWmF8kFsYg3IVnWiF+gMdFjFIM/B7Zz9zODnhIFxKN/CWBT6Fj5u7hUGwyepwn/YumeAkJmJ9pqXqIMPGUSb1B/e7OLmZWrIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD4Dik6y6CW8b2sZrHsCngOInWQAEXBsyHJCUF0pAfQ=;
 b=zVK4ZI1vRCUHFjH5FJLlJQDSPrzFKiUFgUF+Jc6AzWn9GYQd9zJiDgW1YF9IemGYSFbZ6XyMepWB9I5OlGxiWCYQm6a6E4SNzGtwCHC2T20q5zpDJXz5L4EQaclvVpiwJ9QoLi+T+nxclSuloEiHoqjQTJYpXsai3lR/t8jLmh85wwL71l3cFigAtBodydJNN9dpcakeHFvQRSqY4hVn1riQM7L4q9Ikfu98pP6istGu/lvPdwlE4jSuqlULelPpe8FKNcLbMZEXkl5P5ywqjbeW65eZdVf7M7iNfgRGrRak2Fm8Nz47QDT8zxBe77AYJePENOcB2dJZNDAlEXIrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD4Dik6y6CW8b2sZrHsCngOInWQAEXBsyHJCUF0pAfQ=;
 b=eoZk/gBjXbKYKZEXtZOzbhLhIN+7G6HRZaHAUGznWVxi20Y+t9cBJHQTG/cJAQOfVgYn1y4HCIrHyBiwGLTsUGSPDj7eo/loNOPPvtk3CVZUAcLgGr6yjMzogbMHCJk6JGNfL7A2595CfLblUnWAq9EmhiVHuq9QC8RQNKf49Eo6lMlmOI7yGhdegJx6KVimAsIZgyznCqUUrZUJW9QBw0NkvH+THi+mXJF8sWXGjJkWFto+n0XjrRTmd1tmAaWJJYqqoxZB2A6SqQJQL1Y/4veskWV/rc4uoavS23lpL6HuCuq50vmr6yFXj/cME3WBvD33siHNXMcyF8AoVNjs4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 10:59:54 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 10:59:54 +0000
Message-ID: <2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com>
Date: Mon, 21 Apr 2025 13:59:50 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v6] ublk: Add UBLK_U_CMD_UPDATE_SIZE
Reply-To: Jared Holzman <jholzman@nvidia.com>
References: <20250421105708.512852-1-jholzman@nvidia.com>
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Organization: NVIDIA
In-Reply-To: <20250421105708.512852-1-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad55fc3-9ec3-48b5-0790-08dd80c3a5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXVZdkQ0ak9xRzV0bTRLd0N3cjk3SkQxWjBJY05EVVVxdzJlU0xDNWUzL0Jz?=
 =?utf-8?B?c3ZPemNkTytmemhkbTlvMGZLQS9Wd0RQOHBRMGpYMVMzcUVFUGl4RzdJdlJB?=
 =?utf-8?B?TWczay8xVmFHZFpDM3NHTVNSbWVFUmRIdUNBQ1QvMnk3dUZKcVJqTGM2cHdv?=
 =?utf-8?B?RTFKck5RL3l5RTFyc3JETFQ0UkMrdEsxMXNXNTVZQWdsQk4rN0FkRDJQRndV?=
 =?utf-8?B?ZGJSdUYvTFprazhyV3AyWGZENG43TTFmc3JnN0pkOVkvdWhjUm9ONnpNKy94?=
 =?utf-8?B?L3E4QXNlVHhkeERIRStacENTRlBCc2NaOVd1QjhENXJsZUVoSWlzdnY5eFMv?=
 =?utf-8?B?MVpDTU0xa2JSVnM5clgxZ3VKbHRzNlRjeWp6Z3ZmR0NiK1MzbngyaTlVNWRQ?=
 =?utf-8?B?UVBmdDNhNTY4TXhJK0p2QmlVT3Q4NXMxTzg3UU5Ecit5UTEza3U4REJuU3RK?=
 =?utf-8?B?ZzRQei8wU0U1ZDE0dnNSbHlTUnRWdEdWVW1RU0FzQVNISVVlSEFMMzkxTmlk?=
 =?utf-8?B?dEtJRFlTdmQ4MklsQysrWENJZExEcVVPRCtPMXVtRnVOZzdGVjUwSTNmSGI2?=
 =?utf-8?B?RVg0OHJ6YW5QZDhDYlpyOUFtSzJZUksxd21wcVdMNEovU3F4VGd4ZTFBSzlY?=
 =?utf-8?B?TG1xWjgvTVdwcjFHQndmeFlYK1l0T0dSK29RbURpaWpkYjVvUnU1MlR1ZG1O?=
 =?utf-8?B?SnZsVUNtOVJ6MTJGaThDMXFiRnhkT2xCMlpCeVVSUE9OY21WYlJsWk41amhj?=
 =?utf-8?B?NldZc3dpSUhqaFQvb1FMU1ZTOEVmd2dnK3Qrd3h6NjIySGNBclo0aDV4M1VY?=
 =?utf-8?B?bmNxbDRDY09GbnQ4RTZrOVYvVG5ZRVhIUjdnTStYeVRvWFdCSGpjSDQwWVFy?=
 =?utf-8?B?QmhPWkpDNWJEbFI5blBpa1UxV2NhdWhOUWxtcGtwdFZNTmJMcW45WEkxSDEx?=
 =?utf-8?B?NmNGRXVYS3RRSmpJMTNNbjRtc0VrZWVoQjByd2ZSNTBHSmVlZW9CYlJGK3BE?=
 =?utf-8?B?SlRDVXpMMHQ5TEhwWjN0aVBhSWVWSnVYVzRXMWFxSFhCT2c4L2RTNlhjWFli?=
 =?utf-8?B?OEZWVnpuWXhoVSttdUgrK2g0V25PSnZ4a2ZaZy9SSmNMRkdxVmhYVGJRRXJo?=
 =?utf-8?B?dXpTUFNYOVd4cWRoWkVKRUNON2ZnVGFEZVpxTHBMMThHc0c3a2Y4NGYyQmNy?=
 =?utf-8?B?bDR6UXRqZ0diTW5ITnNEUEx3aWdsRWtLamdjdUxJQ25ZS0tCdkx5aVBWRm9a?=
 =?utf-8?B?eEVEeFJkZi9yVXl4eXdqUTY5U3NWZ2pQQ0NLN1lMdkxscjBzRnZ6NExBdlpR?=
 =?utf-8?B?YUF5Z2dPenV1endSY2taRVRhRkt1REFQSnhVUXUwem9SVWwvbTVlQ05QUEJU?=
 =?utf-8?B?a0JNaTJrQmlpVlFtSDE4TEFidUdxcFVvVTBoekZiVGwvTkZSam8ySmVpL3NC?=
 =?utf-8?B?REYycEp5WFNJVWUrM0x5Uzl0SlM1VmZ6cmdCZjFCdmFqbksrT2YrRHl0Z2Qw?=
 =?utf-8?B?TTVCQ2x6NFFBRllBTndqNlFoNnpqRTFZV08rekRGYjVuL0cwcUJkRDNIeFVh?=
 =?utf-8?B?L3lvRm96OEFaM1JOVHgwV1gyQm1jR0FwNFFYV05yZ05yOEV3QUk0OEZtaVZ4?=
 =?utf-8?B?cDROT0dmZnA2eUF6ZXJSeFpRWjdodmxCbGd0b3RoZ3BVNEhCczZJWExhNjF4?=
 =?utf-8?B?YlpRU2pTMnc1ZnhnRy9ZS2NNQlo5UW1HeVJ2NDBlNVQvK0l0NU9zM2dDdTk5?=
 =?utf-8?B?UW1Sa1ZtYVRZdHlWZUZ3Uld3TzNFZkk2S1lnWUR2NE5zRnJBdmZ1Z1ZoT2hE?=
 =?utf-8?B?SUt2Y0lJcUZWR3F6QUFaaGg3SE9GWmZMTjVOWC9Pc1dlYkpRZjBCRHdSaFUx?=
 =?utf-8?B?c1ZVU1NPZlplZUZqQnpEKzFhT2p0d3JMNzFTanpHbzhHVmY1NVRvREt1Uloy?=
 =?utf-8?Q?Qk+5LHR1q18=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05abS9vU1BvQkk3aEFjY0pOTlVJVFN4dEFseE5SV3JGaC9yZHdsa2dUdnNO?=
 =?utf-8?B?ZlgzU3pURFF4OXdOak81OUU4bkZtU3RzblEydHVjWWFHTUJLS1VkR3V1VFBq?=
 =?utf-8?B?V1Zxem05aFp4MERkakk2amI3R0QxbERGMk9NNitSMjhYNWdYemw5YzdaKzIr?=
 =?utf-8?B?SGpXQVJnL3kwMmVUQjI2ei9HQ2xTMlFKeUF0YTZlVDhhYVZ6SEV6LzZITFpl?=
 =?utf-8?B?T1J6dC9xZW40S1pDWWw2dlBhSXhBV1RmaEZLeThCNEY3OEl1U1pFKzM1emxa?=
 =?utf-8?B?V2hnc2lVOFNPOHJVSFBTNW93cFJTVGtoL0t3Z2JKZnErbm5Xc2ZGdG9sSHB5?=
 =?utf-8?B?dGJUaXZiaHBYREphQWduOFhUSXowR0N0K3NiSzV6WmgrbkxGY1VWeXQxd3d4?=
 =?utf-8?B?SVZ0T0IzVVd6WW00NHIzUEVHY2llZzFOcWQ2WDh1dVpncHpYaVRxV0xUMkdz?=
 =?utf-8?B?RU9jbVY5QmllZVdHMzJMcGVacGt4ZUliYTgxTGNCZmkrRVBuNUZxQ3hibWFU?=
 =?utf-8?B?SENyT2VCbTkvYVRWTnhCKzRSd3dnZnRRU0xKQjFiWDRBZW5ZbVJtNm9NZTBG?=
 =?utf-8?B?RWdUT2RmZ3JFZWdsU2NtUHBQblgwZHhoWEhKT3JsTHFIMmpUbmJQZVdHcTFL?=
 =?utf-8?B?M3RaVDFxeGJwem1XUDkwMGJBcmFWajZvNkdzbVhFNzZkM25XQTdMV3BPY0ZS?=
 =?utf-8?B?QVoxV1hmcDVFWTNtM0E1TUs5dVlBRUs4ei80NmV6N3c5aDZjQzJNWFg5ajdx?=
 =?utf-8?B?K2JGUTBkUGhrQnl6SEZ2bXB5NDIwTGZZYnltUlhXaERMZW9keFpEQ3R3ZlFr?=
 =?utf-8?B?ZzdrZkJxQVRPVVA4RG1WNjMxSCtQWm5ELzBEaFB6aWo3dU4zdERLaWh1RG1Z?=
 =?utf-8?B?bTBoa1dVR1I5Y3VFVVdnRmhNK1hIR2xhY1poRlZiaWZzOXVteHoxMmxvTS95?=
 =?utf-8?B?dW91VC9pRFZwUUFucVdGQkNsL3RCWkdsQW1TditpNmZJbHg1dkkrRmo5STk2?=
 =?utf-8?B?TXdqSE1PY1RwZVJoc21OYm1rSStYQzhmNjhBbllCV3RFZEFkYUZibkRwMEkw?=
 =?utf-8?B?L2FRd1M2Y3llejZiQUZrdG92S1lTQkNnUkdNZ1I5K2k1OUpZL0lxOUR6ZW9Z?=
 =?utf-8?B?NVRlQ1hIaHRsTkM5RzNWQi91L3l4SWNEK1BaN2NUenAxdUFTZjBadFBLYnNM?=
 =?utf-8?B?MjU0Lys0YldabnAvV3V3RnpFZTVCb1dpTlJpb05lbUlFYjlqNE5ZNHNWemJp?=
 =?utf-8?B?Z2tIYlhKbG5IM2lhajVKY0NZbXZXc1F0NGZKZzBJN0RpUnlQS1pOZnlTMEFl?=
 =?utf-8?B?ZlZ2a25YcEw5Q1pQRHpUWmhtZktQUlVGWnVTUUNGaWl0K2dQWkZJZ0dFdDFn?=
 =?utf-8?B?d2VHK3F6NG4rTEpXVVc5enArcVpxcCtoekdPWkw3OXdNenV0bW05ZnBseE1M?=
 =?utf-8?B?ZWZIOUVianpYcDVQSHRCTktiOFpscUd3SlpVVzA1ZGZRT2VKbHRYSGNGMUo4?=
 =?utf-8?B?TWNwa3QxdFFaT3hDODZmM3IzWEFjMlMvcW1YbERrN2dlMjJuYTZiaEs2ZkdQ?=
 =?utf-8?B?WGQ1VndvNmFSSno3OEJoV24wLzZLTkliRzhvVEpNcTV1YUZqRDZ1VmxjamUv?=
 =?utf-8?B?TzhpQ0h1ZFgySGJLdFQ3cmFwLzJQbzlOUStmVW5NQlBqeDB3OEpiY05lbWh1?=
 =?utf-8?B?cDgraVRvaFZvN3NSV1NBall3VE1QWFhQaHFlQjIzdlhWUXc1VTdhL3hHUjI0?=
 =?utf-8?B?dE1LSWxEOUdVNzhETG5YTnVxazNNNmpwK2dzRXNHZ2Nta3JnSEN3RUM2LzVp?=
 =?utf-8?B?UGloZjZnSVZ6SXJHYnRQZmg0OWF1YlVmazZWSkNyYW9kbkNJNGU2TzhFdmFI?=
 =?utf-8?B?cmRJRTZWbnc1Nmo2ekNYVlVYeDdPU3ozbS9qWExmMFJOZmxmQlRsZUJQOThx?=
 =?utf-8?B?bTZROElNeHNVYjZvZWgzc0pZSWsvTFlHWFZhUmYyb2RVZ1FnSy94UVovVGFT?=
 =?utf-8?B?MXp0dTlNKzNrZXVYNlVCekF2Qm5IdHBNdGNodlh3SkpjLzBmbUpLd3RTbVF1?=
 =?utf-8?B?VTJFSHcrY0xScW9hUVo4OFhBRUNvcm13OVpjZWo4amF2K28raXQvU3dnZnJi?=
 =?utf-8?Q?Jlz65zmWbSeHX6JOLvDzFIoSd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad55fc3-9ec3-48b5-0790-08dd80c3a5ad
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 10:59:54.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVa9l9SzIiw/Vu19pJ3Vuiy9fBzaxCOClKFAc15rf1klO7j1JIZG5YEFao5aOov2auopmhL/jsdMyMeU2qkkZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500


From: Omri Mann <omri@nvidia.com>

Currently ublk only allows the size of the ublkb block device to be
set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.

This does not provide support for extendable user-space block devices
without having to stop and restart the underlying ublkb block device
causing IO interruption.

This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
ublk block device to be resized on-the-fly.

Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support.

Signed-off-by: Omri Mann <omri@nvidia.com>
---
 drivers/block/ublk_drv.c      | 19 ++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  8 ++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2de7b2bd409d..03653bd7a1df 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -50,6 +50,7 @@
 
 /* private ioctl command mirror */
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
+#define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
 
 #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -64,7 +65,8 @@
 		| UBLK_F_CMD_IOCTL_ENCODE \
 		| UBLK_F_USER_COPY \
 		| UBLK_F_ZONED \
-		| UBLK_F_USER_RECOVERY_FAIL_IO)
+		| UBLK_F_USER_RECOVERY_FAIL_IO \
+		| UBLK_F_UPDATE_SIZE)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -3075,6 +3077,16 @@ static int ublk_ctrl_get_features(const struct ublksrv_ctrl_cmd *header)
 	return 0;
 }
 
+static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
+{
+	struct ublk_param_basic *p = &ub->params.basic;
+	u64 new_size = header->data[0];
+
+	mutex_lock(&ub->mutex);
+	p->dev_sectors = new_size;
+	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+	mutex_unlock(&ub->mutex);
+}
 /*
  * All control commands are sent via /dev/ublk-control, so we have to check
  * the destination device's permission
@@ -3160,6 +3172,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_SET_PARAMS:
 	case UBLK_CMD_START_USER_RECOVERY:
 	case UBLK_CMD_END_USER_RECOVERY:
+	case UBLK_CMD_UPDATE_SIZE:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -3251,6 +3264,10 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_END_USER_RECOVERY:
 		ret = ublk_ctrl_end_recovery(ub, header);
 		break;
+	case UBLK_CMD_UPDATE_SIZE:
+		ublk_ctrl_set_size(ub, header);
+		ret = 0;
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 583b86681c93..be5c6c6b16e0 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -51,6 +51,8 @@
 	_IOR('u', 0x13, struct ublksrv_ctrl_cmd)
 #define UBLK_U_CMD_DEL_DEV_ASYNC	\
 	_IOR('u', 0x14, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_UPDATE_SIZE		\
+	_IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
 
 /*
  * 64bits are enough now, and it should be easy to extend in case of
@@ -211,6 +213,12 @@
  */
 #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
 
+/*
+ * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
+ * New size is passed in cmd->data[0] and is in units of sectors
+ */
+#define UBLK_F_UPDATE_SIZE		 (1ULL << 10)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.43.0

