Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170F1C3C0D;
	Mon, 10 Feb 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183102; cv=fail; b=PPokX+lHoHjTPg2mnkCfooSDfTFOvUqVaTso/LXLOj2lytUCZpzbC9xJTDDemCuCt9RnwM0PFTgheUT0IDEV/v95zuianuY21vw+IrT3wlBSvn5zWunsUYQc7QyrMNcuYmohqN2BaRlREfo28UOdbSBaZ88GnH9TM1MkDaUJAzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183102; c=relaxed/simple;
	bh=/r45SrGZNQ6+CQ95Y2Q0bN+OnzZyYVCG7F6NkPveyto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwxJ+KNBo118H3Cc06BpvBSourA0OIyhbQVxrL4xGJO7xxL3ILxq+4r338U72kKR9AD9ZS4bVnygZpPZ0B3Q2GZShSdUSIIORuQSl76oy5AKCECiNLeRf3JtMfSObhcf1vyZGfC75mF/OSV0Vqcc9J7zn7nRvGi29kp2UWGNuPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K9ZGxTCD; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K9ZGxTCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmuvhNRMBVYenGpfcD7vBp15JrEX6F4UXomFTDItksv8YwXqHlsCbLJCH7FHkmwnnlpd84lGLwG+2i16710SF+jPRwA8i5hmWSL5xdDb1iz5zhs0bM05eUpMCO3WSi7+77Dly+bRWiGI/hK+xwXG7jNoGXtM+P99KJgZUTwPmNH+YpIwUgq6UR4uORdK/IS03CKwLRIMtxDlSdiOx351tbgHZY8Rs5yBdEl0Q7atwX63QFW5Vvz0QLHDDsbleRlFm9TlSlk/jY0ffTh7OA0E1A22lLHlm+dteQmnIPOKpu4p0/qneRZsdBxjQBwyXlNwplO730LkDM9c5agyCduDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o3XJ7v+wRvVgY0Dh5HM4fu0nG4lN7XcdVCY+x+bhBk=;
 b=ocmEKGtvrlEb68iFWLPOu9Skmhi9IwR0E2h5tFl7dslnEfxFCw2e5a3rZhWdXUqMmHh+KpVyNH4f9Rnc3Q9ABRC0Un3WhUpMSCH/8ajQbAm0Md3SBn46OIQRgdXjxIwp/qM8abyQcqBch1tUYhsnFCdJLWeSdMPbntf5FvjxUG01vkm0QFpMIrH1UM1rwUS4FduYu/vV4fF0OMuQB5FEY3n2aSM1fo3Vd3/ZyiDwEJmE3h/cpi2JKd5YbtH/hm8iw5oEge/rcssdCQ8CvOIvThtz5hXEbbdtMsox8BAEXqJGbEAHDtmZ3mglyyes0oQUlgP3l7tEqM7l0szV399G4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o3XJ7v+wRvVgY0Dh5HM4fu0nG4lN7XcdVCY+x+bhBk=;
 b=K9ZGxTCD42RixSRRJRmDqAxHh7OBrfNfEgbVCzHfdxpwqgJZqXXVit5iPLXgeAqzhL5ZyOhBxBj98bUu0Iqj3ob3UFH6J8qimUUe8Hy1glqmurweNBQRhrszP+EjH1DfP4hWgfnjaNPd5Ny6l0wCWRDmHmWJvsPhhLkrBoHzEMwndeYPnyQzztajWHI3UVr6RAF25kUsQcPdebdMI2BTcMV22yW0jpWeN3pCt9vmILD8pPINwLRonMEoIYCqr2AkZUlMxZDMraN7QfCQ7MewOoXmrblwvLY7w1iuJ/X2ypiDo8ASiIpDoM32kusIr70QJ1QVsKNXQeOL0ICFPVYeMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 10:24:17 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:24:17 +0000
Message-ID: <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
Date: Mon, 10 Feb 2025 12:24:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, sagi
 <sagi@grimberg.me>, kbusch <kbusch@kernel.org>, sashal <sashal@kernel.org>,
 "chunguang.xu" <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e5e51f-714e-4eba-efe3-08dd49bd1303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REpSVnlWK0syM0IrM2JCYXAvTjhtZ0tkb3hDSEhzMGxmUnVpaEgrVSs1Njgv?=
 =?utf-8?B?OFdXZEVkZVo3VTJ1dTR2OUptelZUK1dyRzRqN1VUUTdkOTdCeTRSU2dhWk8w?=
 =?utf-8?B?TVFuY0JiTTBoL0xZN1V4LzZROFJwR1pBbXh5UEZIZUlIMThpdkcwa1NYQmUx?=
 =?utf-8?B?UEViK0xHS29JWXBrTjlFaTUwMVYzZHhZb0RFWEl6QWoyeDFWUm8wcytaaHJG?=
 =?utf-8?B?RDhQdWdiSnQ0b3d3TjZlWVVRVy9CWjEybk5Xa3g3cnRaZnRCNko1czVCQXZP?=
 =?utf-8?B?Zk5icHFZT1BMSzJMTXd1SlR1Nys4bityclhKSXF0aGlmd0NEbldSYkw0SW9q?=
 =?utf-8?B?UXE3M2NPc2UvNitBdkptdnRMU1JjUUFtVHF5dU03bjUwbVVUa3JxdnRWMEtL?=
 =?utf-8?B?S1J6NUJqMXhvUFFQeUZWREk2U3pHT0FUclQyc3dUcG4rb0JhZW13UHBDbjVi?=
 =?utf-8?B?enFJSlpGNUxTU0JjKzA3YlhZSEJpendWcjdhUllLUitvTno0c2Y1cWh6OG1q?=
 =?utf-8?B?OXVZZ3RTMlpONTJ1QWJVNVBoOXVNYWU3T1RaSXduWllpeCtnSFFFcE9MOVZj?=
 =?utf-8?B?NnowNVhNRytlNXNJV2VpbFlLbkkzMG5UYk8zcmkxcnRCc3NNV2JnUTBzTyts?=
 =?utf-8?B?MkpmTnQ5RW5OeFVGK3pWZ0Q5bGxxczZ5ZzZuVXJKSSs1VnNaYlJGTGlGZGhS?=
 =?utf-8?B?WDNvNDNUWXBLdkYwTFdaUklTUEExV2JCMURNSUdhWmwvQXVoSUVCVlZ0UUh6?=
 =?utf-8?B?SW8rcy9WeU1nZy91QWs2a1cyQXc4MWk2WWltRkhPeWtacUJlMEorNW92Z3Nk?=
 =?utf-8?B?NUM3dnBGM0FlODA3a01KeTF2NnF1YTVLMnBkb1VZM1haZWJXWkRsL01CQi9S?=
 =?utf-8?B?aUt3NW1WOHQzRkpUT2s0M1k3YllmV0Uva0I3Z1R6cW1kR3IzMjkvQzVZMlI1?=
 =?utf-8?B?RDBudGxDbVFIQWhWbVdvOHRNNEtNQnJxQW5teU9XSzRBY085cHcxNlJBdGRI?=
 =?utf-8?B?L2lBZWdwTlhFck1ZVHFOS29WQkFXU3ZqVFFxU2lsYVc3a2FNM1N4bFgyUFNR?=
 =?utf-8?B?VmVtSkRoTkJ3RVJGNURrdWNxMStweDJQbmY1Sjh5R3M1ZGZoNnBhb1hyUFl1?=
 =?utf-8?B?bDJGYm5SYldsZTNSS0Y0Y3A1Y05EcEFUU09MWFRuSVJoZEg2a1RLK0JONGY3?=
 =?utf-8?B?NVU0aXp1MGJHVVlmK3lSQ05Xa05BUktLb2VwOTgvU0hyY3NZejdoRGlRKzlD?=
 =?utf-8?B?L0F1VXVVTlNSVkhRWWh0dVVLYW9SY0F3Q1NrNTh4RXJWZGtQeWxOQTd6VGVu?=
 =?utf-8?B?d29rdjNNZTQ4ME5GelBmbFZ2Vkk2RCs1Z2tid3dIeEdoWTFnREptaWtjWStj?=
 =?utf-8?B?SW55K0h6Q2dWbFkyMHFnd3VIaGI1b2hieE9ScEhOcHJ2OC90anY4YzRtVmla?=
 =?utf-8?B?U3p2a3dTVXhTMXp1aXQrME9yRTZVRjZuVTVuTEVMVTJjcnBaZVZjaUptQnph?=
 =?utf-8?B?akZieEFpZXhDbWtBU3k0dHJCVm5xdlVycG04S0hKUUs1T1lWZkhBSHYxcFYx?=
 =?utf-8?B?WXNNajNNZUhPbVd2bTFQNExUU3lhSWpXSExMVFVoRThWeW5rRDR3UG5OUzBQ?=
 =?utf-8?B?Unp3SnBQN1FKcVRNaUYxUS8wdzdpTjIrb2lBYjllQUhPYWg3bEJkNng5Sk9i?=
 =?utf-8?B?Zm82QmtSVTRFdkhjZHdkcWJVdFhDVUcweXlsdGozY2toL0lTSUN1QVM0Mytn?=
 =?utf-8?B?S3NXQjhCOUwzaUQxcDliNXBWOU92dDBJUERoMG9IazNueDFjNEt5emJNM09Q?=
 =?utf-8?B?cHV2TkF1cnVWL2l3aVN1VzBSMFVzRGFWTjJDbE54Vm8zYjZhbml6cEd3N09i?=
 =?utf-8?Q?XfDK9hcUeVFPj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b214OXpTRUdIRmZUMUdYWjM5QTJxTVZSMnExLzlNSldyT0RSbFQrbGNzY2Ro?=
 =?utf-8?B?RG1SeXlacDcvK0syWURLZ1ZmKzRJU3ZSM0sxNFlYTTI3ZUhpcklVNmRhSklE?=
 =?utf-8?B?WkJzc2gxYVZHZ3JrRVB6M0FlRHh3blNHaDJzTXNzYy9rOFY2OXhFV25iWSta?=
 =?utf-8?B?Wjd6QitvNVFwVERDQ2JCdU9lZnh3TERDQVNIR2RvU0FFZUFSMWoyU2xjTTNt?=
 =?utf-8?B?d1BudEhKL0x5TmduTHFHbnovNXp3UEFKQ2ZtMVl0RTlyeTYwbDZYczZsWmVm?=
 =?utf-8?B?c1JxMDNsd25CL1BTbEtHWUZoOXhSZ0crM0pKVWdmWGhaYzd1a1c4aVNIR3dq?=
 =?utf-8?B?bmlSYm90VEpQZGkxcDBqUXc3aUpvdVErMDZOY0dZcUR6bWMyYk9ST0JabWhp?=
 =?utf-8?B?NWltQkdTYkx1d2h0NEZ0RUhZTnhPZkhUenFTcktodTMzL1JySTFQOTQ1Y3dT?=
 =?utf-8?B?TDlucjhFMG52aWk3VnJWd21jWXp1UkpNSnZNVGpRVlFndkZvdEhDd09yV2Qy?=
 =?utf-8?B?Z3JxcWFNbTk5MytOaDcvOEQyUWIvcW5pWXM1YTBxaDl5V0NwVmZMNEVwWjN3?=
 =?utf-8?B?MnhhMG9oSWV6L1BCYWE4Z3JCSXVENTM5cTF4OGF3bllwbUJNV3NObEd6WmVC?=
 =?utf-8?B?SjFZbnRTcjhVWUE4VThUYlhEaWszSy9vKzV3OTREKzBDdjhMbC8xdmhURVAx?=
 =?utf-8?B?TmZ1bmRvdm5kcENVcnJvdHQ3QmJpZ2NwTjdUbVA3L0lwSXl0UnVBYTVFRUtG?=
 =?utf-8?B?a0tIWFYwZkN6M1Mrb2w1QXArV0pFR0NPN2g1SzJZTTBxYkJLQVBkc3Z2Skpw?=
 =?utf-8?B?dmRxeU5MUHV0TXpRWUttV0wyOXp6citpcUVxam9udndBTnQ3NktleFF5UXZC?=
 =?utf-8?B?SXAwczRMWkVJb3ltTzUzVkdrakF3SWxralBNUFovajcwMm44RTVqUDU0ZTFx?=
 =?utf-8?B?Z1NFR1RoeUR3c2NJQWFQZzJxa1hPVE9GVXZndmJNQ0ZwNkhkd3ZjU2NXMG14?=
 =?utf-8?B?NE13cWd0YWI3bHFZWTloRnlhVDFtOFRpWkpPRzN5RmFORDdHMG5yYmlHNzNL?=
 =?utf-8?B?aE41SmJ6bGJPRlpwa0tENTB2aHZIOXcrQ0o2NzBCVWVUcjZQb0JHS3hzWStG?=
 =?utf-8?B?d2R1OGlLNlh1YnNrY0Y4aHBhcC9oWTVNZ1poVnVxM3ZFQ3RuOU5wczJBL3pG?=
 =?utf-8?B?V1JPWlJ2TXdUcDRKTVZXeDFFVURaQ1hSL1U2SGZrWDg3ZEhVQ0lnbXhHTmZu?=
 =?utf-8?B?b1M5STVmSDRuNXBWN3I1SlBwOFZINU81U1VUZWpGTFpBYk1GY0JCYk1JYlYv?=
 =?utf-8?B?ZTlXMGlGa3FSR0xnaHlhQnJ5Z2dDOW1QK29heHFxRDJJYW5uODRVYm5EbENY?=
 =?utf-8?B?ZkxVblQ3a2ZLOVEvY2RCOVZ1SWJ1MTZicjFyOTJwVU5qUFJkL0JGQUpJTWx5?=
 =?utf-8?B?QXoxcVZBRDZDc3BjVmxKWEpWdG5SOEkrK3hwVHEzYzR6TkU1QmpaRXZmMHNB?=
 =?utf-8?B?RVF1dk5ZazNuSEdLZXl3NHhUNUM4Z2huQVVWemlEWG1sVjlGeml2a2dRd0NZ?=
 =?utf-8?B?WUhWQ2IyT2lIaGQvYVVSSFZKT29CaTZRL2Mwbm9Mbk5UUHMrVFRYb2ErclpU?=
 =?utf-8?B?Q2ZWNFBsQzhZUFY5eUVJYnpIK3k0TUJkNEIzcVpSU2ZOVHlueEhDOUtXNVUz?=
 =?utf-8?B?NmhQUGJyaWFEK1gvS0ZGaUsyTHQ4WGhNRndLVTVVT05PdFVHU3Zzc2d4NFQ4?=
 =?utf-8?B?OFE5VjV0bEprbzlGekZnMVB3RGFielpMSko5OWVWNmZsRUJKbVh5d1M5S3Qw?=
 =?utf-8?B?bXRXbVdTZDgwM1E2Nmp4RkFObS9qY0xUTXFTd05vTzFNTGRUR1dDVUN1V3FW?=
 =?utf-8?B?dDYvWWhETzM5d1RPWlphTHdHUFRvMFlLck04V2VNVDVoTG91UDlNOW1uMDFN?=
 =?utf-8?B?dndVd0ZTdVI4OWZXbjI5NkUva29rMVFVZktwT2d1WXh1OTR0RmpXVkFiRGhV?=
 =?utf-8?B?ZzlNelFuSERXalM5dnFkblJUeWpDSHkwQjdDR2ptZzg1bmpmSEJ1REwzck5Y?=
 =?utf-8?B?U2tyQWVweHhUQVdlR2lDQTlLeFhFMk1oT1RLK2RpUTBRMmZ0VDV5S2NHSEIr?=
 =?utf-8?Q?wwxCBtiqdeYYlkwyEg2+KmDfe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e5e51f-714e-4eba-efe3-08dd49bd1303
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:24:17.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5ViP1qZlLm91I7zIagCEyar044KDGbk1jd1VWQEmGuOpjFifjOyrTgjH7U9XNv1Jjdssw/HluY1y/KCQyqWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933


On 10/02/2025 12:01, Maurizio Lombardi wrote:
> On Mon Feb 10, 2025 at 8:41 AM CET, zhang.guanghui@cestc.cn wrote:
>> Hello
>>
>>
> I guess you have to fix your mail client.
>
>>      When using the nvme-tcp driver in a storage cluster, the driver may trigger a null pointer causing the host to crash several times.
>> By analyzing the vmcore, we know the direct cause is that  the request->mq_hctx was used after free.
>>
>>
>> CPU1                                                                   CPU2
>>
>> nvme_tcp_poll                                                          nvme_tcp_try_send  --failed to send reqrest 13
> This simply looks like a race condition between nvme_tcp_poll() and nvme_tcp_try_send()
> Personally, I would try to fix it inside the nvme-tcp driver without
> touching the core functions.
>
> Maybe nvme_tcp_poll should just ensure that io_work completes before
> calling nvme_tcp_try_recv(), the POLLING flag should then prevent io_work
> from getting rescheduled by the nvme_tcp_data_ready() callback.
>
>
> Maurizio

It seems to me that the HOST_PATH_ERROR handling can be improved in 
nvme-tcp.

In nvme-rdma we use nvme_host_path_error(rq) and nvme_cleanup_cmd(rq) in 
case we fail to submit a command..

can you try to replacing nvme_tcp_end_request(blk_mq_rq_from_pdu(req), 
NVME_SC_HOST_PATH_ERROR); call with the similar logic we use in 
nvme-rdma for host path error handling ?


