Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349B262FDD
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461207; cv=fail; b=EDQyxmul7LLy4uB18993chz90SqdOGk9bhPG2lemaq+8vu6aP+n7Ol9FhIi0qAgdslFxxT5SNY02tpYlkogLYNRah6TdsKlDbMeadwFCJm8aFkRuGE+a/XYpJglALhRIYtCEsncagcCEyO0Sf/2Eu+13UuBoG+YW2L74H1du12U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461207; c=relaxed/simple;
	bh=WUrFY/U01oC8mUpCR5UQRUhRbGBkVbkRG9wfr9BFVPk=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=A6Op8NTgpdrLTkzC1wla/wlLgTZW/eS00ifSPkavssa7LAWPqVXe5OK5grjBAVDX3a+0sm6W18ChGz9Oc27Px8CYiTLP3jTBuh+W6RBVGJC/o+xFVmBCC0asZ/wOegOKt+efapwztDl/AWc7IPV280/WtrcH9ig1hNpRuvt9gRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuQRLtKg; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuQRLtKg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/2/rQhCQW7IQeqL72S4tV6q6xqje81h4EfNdRscKBgBO/jH+jiRpROpRTbgHe0z0RuUu6RcBpOmtYFiG3UGNv+aXEeGVluZFkAikC9Bhif1Zpe5ibaLf19c8armL/wMhgCTn18HQn9ZMr6Ge1o6eUvv0NJ9Uvzsr7kJk0xvsy1jje5OZB7IcnBzLJPoZgIEeJRHJ+Wd1ejN+3Umo2Nx4bivPmz4yIL8KRPuS+q+3wmhpgMLxIJWbTcEIURYas37qcDcCSFVBDJ2a1NUJwBptCp0sQbDzDwkAAjQwlCqeiXYdxSMyKfQbW+FzkjqLAsBcxc48Flet1DeF7SILVpdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T88kO5a+rHFnwa+wTuebr4TGys5u/pqp7fGOZmfM6Vw=;
 b=J6RRRxGCVuQlS//4As5pUhAZUzfz+MIFf4LU5NrhWpWMoUOVV8y1B5M7u8+8oeikVuF1+ZRWTzNY3ktn+fq4sEgY2ml2zNn9+WzTKF8U5/uFQzs8tugfQl++K0u7LJfMfpJZH4WJyjk2Vrj3rnPk6i6Wx2/RtGDsjKisZzkzMWn/neF+u/FaXWHrW5Ew5lb2vBajPi3NtsTvjbD770EIa9XheKrODlKQdCrMVnYrLnHRbA1zCE9ZgHQRSokmyT8FTL70/RbgrTKOdVU1zKCVNNJCNrLju9ysFa3mRO3DIjVNf49G7yFWV9gdqY5ZZAigboUqGjyPJE3T3zMFszAg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T88kO5a+rHFnwa+wTuebr4TGys5u/pqp7fGOZmfM6Vw=;
 b=fuQRLtKgxkCS9gjbqXbvFzHH3CdQW4f2tkxHcNvyxXH2JoJG7xQPIlqy+/FRaASuHTNm1aH/7O6Z+SCvqLcRbDQSimpZxykK0+PmpI44tXgmUAV5vaVAWUYzoDFGPtjRtlGWN8WKDUZcX1ypjH2wV8edETTnlETS/aLm4d+yP0fYzU+hO391d6IkJoy3OZunuIRPeMPGYII4ZGs27v28h2Ifk2xr903hLw71BZ/t/SJ6ltRSe0BAovM2JegSBGbUz04qYOHtfyo9IZkD9GSWRh6v2EAkykO9dPilZGTg36Czmp9E25KPjX+RLgUIvtF6fCW6g0HXiDJoxZhRNSP22Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 5 May
 2025 16:06:42 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 16:06:42 +0000
Message-ID: <9a10100c-9d76-4522-9f6c-d0a6ad32ca81@nvidia.com>
Date: Mon, 5 May 2025 19:06:37 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
From: Jared Holzman <jholzman@nvidia.com>
Subject: Port to 6.14-stable - ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Organization: NVIDIA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a1c80a-9e00-487f-d3c2-08dd8beed33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODBNQnFGTno0b3RzbjlkOEVZMTVjRS96Ui9EYUJOZS9YZ3FJaFc2SjVkelJB?=
 =?utf-8?B?eTRNK0R1UjU1VThLT0dPT0MvODdqbHZwR2IvTmM2V1dZaUhtZGFSN1lCeEdy?=
 =?utf-8?B?d2svMTVKamZrWko4VHZ4TzVhK3FhU1NBaUk5N2k3UkFEVE1UU3k0WVlVR2JP?=
 =?utf-8?B?clkveXpyT3BSYkIrY3gvWWdtTlMxdG1zODAwYUtiY2ltSm1qd3paTjZHemlW?=
 =?utf-8?B?ODYvbGJsaGlIQWFseGhBZUhXR2I1TEhMNVpRQlpFSHJ2bXVWOWpUZnNEN2lv?=
 =?utf-8?B?UjE4Y1Y5cEtRM1pLR1MxUDlrbjNEcUFxMkFESDNsaHFpelJoL2Izb1R5NUg1?=
 =?utf-8?B?U3NBbjE1UVUxNkdFeTl4RFNqZllsWDB4YXpZcFVUbFdEdE9mUTZ3MGw0dTdN?=
 =?utf-8?B?a0o2enBRYXpvckkwL1IxUU9OMVNwd0xTQnVXc04yRmcyYkljcXVPVXZCYVZT?=
 =?utf-8?B?elpwRTdyamFyNHlYbjJKV0tCMnZlZnFoaThza1JPa0V1TkJpKzFVQnUxMEpl?=
 =?utf-8?B?NzZzZHZNczRRaFd5UTlBb3VLdk5tL3BNVDV6WTN5RnVSZEJoVEZWNE1rTmRF?=
 =?utf-8?B?elF1c3dWTWF2anhVc2g0VUcycUxSREJPMzNjeGZLV2VITHJTQmU5NWhORkJW?=
 =?utf-8?B?aFVkdzMvcVV5TnYwUmtYamxlRkYxZW1lNTlIWDN0Rkx3TlI4UXFkOWkzQi95?=
 =?utf-8?B?WHlnNW0xUHVUQUJVUFRKUmRVeDFnUnFlSEt6bm0rYUtXV09hMksyZ2Ywc3N2?=
 =?utf-8?B?elhMUSswTkVralczRzNyRGFxeDBTZm5pMXlrWndML2FOZHVxOXQ0QkM0MmR4?=
 =?utf-8?B?SkkvekRFYlNXWDg0SWdTQ3pNV0lQSExVMDUrajVRUGJpMDVlNjJtVFNEVit2?=
 =?utf-8?B?dE92YzdpWXdwb3Y5TmdycVFhSHRJZDVnTUdRSWQzVXVTRTRMa01KZEpxYUpO?=
 =?utf-8?B?d0x1S0dtclcwSStWZlVHaUI4dkVHUW5zS29kdEhKaU1va29FbExwMHB6Unhp?=
 =?utf-8?B?VGpiOXlhRmg4bmsycUJGays2Q2dPWUxjL2JLZ0dWdmRmelpYbUZvNWkxL2dk?=
 =?utf-8?B?MnI1VjY5U05rS2h5NDl0VWpuay8yNkpwU1BSYVhpRVA1eGQ3Rzd6VlAyeDE1?=
 =?utf-8?B?cnJueUVVZFZ4c0VNOXJreWd0dXJTVi9YTEtrUTNNSTdMK1plOHZyZUYrZ3d4?=
 =?utf-8?B?R0JxMlFGTzFZM1dUMnMyZGVFUm5zZDJLY09tU0VJS29XS2NNY2ZsRW5oQmcw?=
 =?utf-8?B?elBFbjk4UXVyOGFaWkRZamZlYTlHSlBhNVNIbXFsRGNxVVpXbkY1RzhlQkVl?=
 =?utf-8?B?Y2RmQ2ZPTmVYRXppQkovWmRBZmhpS2x5aE5UcHorMVRwR3ZOS3dhUk80Z1Vu?=
 =?utf-8?B?SkxCVU5pRFVUUWxGWVdQZU4yVzIxaUdTVEx2NFNzczNZWlZGd2c1Q0R0NDNi?=
 =?utf-8?B?U0dIV3ZKdW1ydndIZmg3V2FYNlpYNTA5T094dUQrMTV4a05mb0JESnZtZkR6?=
 =?utf-8?B?U05IaE9tczdnMnlYQUMvNkR0c1pmMDJUOTRLUnZPNk5Xd0JRTVNvazVIY3Vw?=
 =?utf-8?B?NEdLNiswZG9sSG1uM3MwUnZLK2o4Nm5RVkd6MHdpT1ZUS0dhR2R4dUJ2bERn?=
 =?utf-8?B?Sk1HWDFGVGZCMkkyUHhlS2tPOFdPeUZmSHQxZzFxUzQ3WlJQRnlVTTNzbzBz?=
 =?utf-8?B?Z0FIaFpPc09rNTZjR0M4ZncxM0kyWUlyM3o4QXZTS0MxUitvcU5xYXVucDc5?=
 =?utf-8?B?aWQ1U0FpQnNwcHdtNGExS01WODdqZVduNUswSFZ1Rzk5R3l3MHJ1Q0p3cU8x?=
 =?utf-8?B?Vi9LN1lLRVgxdTlBeTZjNFF6TlFDaGMxZ2lVeUs1dExMdVl1YXhXMUVUZC9t?=
 =?utf-8?B?UXIvTWRQNVpsdzRlbk5yNlYwU0Z0cGZ5bThJYzk2MHNtbXd4YXNiZFdHSjVB?=
 =?utf-8?Q?qqHups7T2OI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmhSZ0U2MTZIUFg3bzUyR0llaGNnWnp2SldNWjNsc1E5YVB6ck0wTDJmV2tG?=
 =?utf-8?B?UERJZ2w4aEp4T1poQVFxdTdRQVVGRFVOOThxNGhlSS9qUmpnaGUwRFF4Ukp5?=
 =?utf-8?B?S0k1aXhKWG9hVFJWRlE4dm14Y0ZaNHk2SkpWekZOUlBTTmdyVlZFd0doVnBF?=
 =?utf-8?B?cjZOc2w4d0xHTXg2Mkord01sYmdKdFBRcGQ5dk0wUHE2S2s4WkliQy90SzRX?=
 =?utf-8?B?ZE5SWURGZHd3UzAvaWF6ZUpjYU9BNkpmdzBzS3c1NXZMNGNqYjJEemJMWUVR?=
 =?utf-8?B?NU0vQmlkRWZ0V2J5N0lGNVJQaHc3T0JDdExJQXNsTXlXWHZnd29VTzIyWStJ?=
 =?utf-8?B?REVvSmp5blNmTEkwMjFaOFBVcWRKQWhpSEtSRHNwY1NUbEVaOXZxNjZ4c0Iw?=
 =?utf-8?B?TDI4VW5aN2pFM2NscFFBZWNsYXlPSldSUktWTXhMdVFkelhmWmhqeG55aENV?=
 =?utf-8?B?a2tYMWxSSE45Z3k3T0hqMnhPcU9UbVZpWnVQeitXeEI1c0lNa3laQkZGZEc3?=
 =?utf-8?B?S25pVVh4TWRkb0hnbHNraU5lRmUyalVHSXBFakZJQTdiSFdGb3I2QnYzcUZr?=
 =?utf-8?B?MlJMZER4RlU3cFlVNnpVeHozakFPWnZGakEwOUVZcEZPMjdrS2x0dWpxdWZk?=
 =?utf-8?B?N3dXUE9FMjdYdFBiK2U0dHdzdER4K3pDaTdPOGt2YjFWTmgwMlZSaWF3a29j?=
 =?utf-8?B?RENhM25GcnhTUzM3b2tpKzZBQTFnNVA4VjZpQmZRdnNMOW84UExkeFdEMjVC?=
 =?utf-8?B?TU94WXd4cWNtNG50L2xtR2puQ0RhNGdWdlIrVDFrMXFaUXRGTmltQVFFZXV6?=
 =?utf-8?B?OGdoWWxWOVFWdVhzaVZ3cmx4N1Y0bTQzb1lVTzg2Tk8zbWtaTlJyN1ZjaVhW?=
 =?utf-8?B?R1IrZVFVNUp1VVprNHRDcmlsNHFoZGx0S3RJcW95Sm9WUEkwU05vV3dBcGJu?=
 =?utf-8?B?K2ZpZzNoZUhYQmJkak54QjBYTkpKREo2c1NFV2kva0pnbGNISkJ2U2pqUTYy?=
 =?utf-8?B?VVhpbys5SkFvalNLd3ZwZUI1T3dyUmc3Q1JTTCsxbDdPQ3JYeFhrNisyUkVm?=
 =?utf-8?B?QzhlbU92ME9yTXZtTUVoVjN6eGhldXAxNFdvZmVwUCtOZ3lHU1FzTDVyZjZH?=
 =?utf-8?B?UVlEQzZJcnAxT3dZR09WQ2hVUjZMNko2SkI1Tkd3Z0xQSk8rd2hTZnN2SXRL?=
 =?utf-8?B?WlhqZFJyT2o3VGRxTUs1S1FiRGgrcnAwYnpSM1crWnFuYXRUWnhGTnc4ZnAv?=
 =?utf-8?B?amlMS3MzVGRiYldmNmdvTUsxRXpVTWlxaUxpOVBZMWdnSndKb2pUOEROc1Yy?=
 =?utf-8?B?MGR4U0RkTTNIdmdXelZaZGE0M01yK2l0K1pCZTFIc3dmUUlxSHRVWnZYN1Z1?=
 =?utf-8?B?SnNjSkd5V0hEdk84MnR1aUV6SzZhZG9rQVg1Y29hUDd2YWltTnhGOTdOa3Vp?=
 =?utf-8?B?NzlMam03VVdnRzhodTkvaE5WT1dsclgyN2h6MGlYV0YxczlKK1BuendYenl4?=
 =?utf-8?B?dW1BWlFpaWtxTkVxaXd3cExYRm5oVTlDV0Fod2RNVStzVXphUWU3NG95bVZk?=
 =?utf-8?B?ZVVRNFhiYmo3bUNaaVUyc05IZmxVeDZ4VVNNZnovTGk0bEgxbis3dFFkUDJp?=
 =?utf-8?B?S0lLZHljSEYrbElDWGsreXlsTDBaN3d2RW5RVGp1L2tjN3JnbTNUYXR3T0NH?=
 =?utf-8?B?NjYxRGUrZmV2L2pQUlcvemNBR2VLNzJ3WFFaZkluWU5wVHhEb09OZVFpOW9R?=
 =?utf-8?B?c2VaKzNKL0pJZWM3YTVxd0ttUSt1a3I0OG4zKzgrZXQ4NVVZYXNUVVlVWjVq?=
 =?utf-8?B?b0lKZWovd2ROSHhrV1VsWTBpRU1JODg3cFpsRDljZHFiaGQ3RUFvN3NYdUVO?=
 =?utf-8?B?bDM5aWhUejNZczI3c09NNFdPcktPTXZ6a011ZW80blZwSnZuQ3lSSWx3WnYw?=
 =?utf-8?B?RW9OYXlob0MvckhDaGpkK1FDZk9ndmJVYlJ0REJuNE5TYWRlVzVpYlNFdlJv?=
 =?utf-8?B?QUw4RVpndjF6ZkxPdnMzcGEremhBS0pkYnJHaXRmZnl6cFhYMGxJRzNreHJa?=
 =?utf-8?B?R3hmSmk5aDhQdFRoVWVvUWxlRDM2d3R6VHlya0o0U29NK0FSWEpacktFYVJP?=
 =?utf-8?Q?r8h09KEu0KNA2J3Nng7qkaXqu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a1c80a-9e00-487f-d3c2-08dd8beed33b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:06:42.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDdoe6F6Tu89CGOoKTM70G77tBdaCG6xXcCeJqY+25gwO3ahG7+dh84uokEbCQK6CrruHzO+OtUp+MMQDZBWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Hi Ming,

I'm attempting to back port the fix for this issue to the 6.14-stable branch.

Greg Kroah-Hartman has already applied d6aa0c178bf8 - "ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA",
but was unable to apply f40139fde527 cleanly.

I created the patch below. It applies and compiles, but when I rerun the scenario I get several hung tasks waiting on the ub->mutex
which is being held by the following task:

jared@nvme195:~$ sudo cat /proc/230/stack
[<0>] msleep+0x2b/0x50
[<0>] ublk_wait_tagset_rqs_idle+0x3d/0xa0 [ublk_drv]
[<0>] ublk_nosrv_work+0x189/0x1b0 [ublk_drv]
[<0>] process_one_work+0x17b/0x3d0
[<0>] worker_thread+0x2de/0x410
[<0>] kthread+0xfe/0x230
[<0>] ret_from_fork+0x47/0x70
[<0>] ret_from_fork_asm+0x1a/0x30

I presume that 6.14-stable is missing a commit that calls __blk_mq_end_request for the reqs that are not cancelled by ublk_cancel_cmd

Can see a small tweak that would solve this without having to back-port all the ublk changes from 6.15 to 6.14-stable?

Thanks for the help.

Regards,

Jared

---
 drivers/block/ublk_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ab06a7a064fb..7d937168b245 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1595,14 +1595,31 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	return !was_canceled;
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
+static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		unsigned int issue_flags)
 {
+	struct ublk_io *io = &ubq->ios[tag];
+	struct ublk_device *ub = ubq->dev;
+	struct request *req;
 	bool done;
 
 	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 		return;
 
+	/*
+	 * Don't try to cancel this command if the request is started for
+	 * avoiding race between io_uring_cmd_done() and
+	 * io_uring_cmd_complete_in_task().
+	 *
+	 * Either the started request will be aborted via __ublk_abort_rq(),
+	 * then this uring_cmd is canceled next time, or it will be done in
+	 * task work function ublk_dispatch_req() because io_uring guarantees
+	 * that ublk_dispatch_req() is always called
+	 */
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (req && blk_mq_request_started(req))
+		return;
+
 	spin_lock(&ubq->cancel_lock);
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done)
@@ -1625,7 +1642,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct task_struct *task;
 	struct ublk_device *ub;
 	bool need_schedule;
-	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1640,9 +1656,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ub = ubq->dev;
 	need_schedule = ublk_abort_requests(ub, ubq);
 
-	io = &ubq->ios[pdu->tag];
-	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, io, issue_flags);
+	WARN_ON_ONCE(ubq->ios[pdu->tag].cmd != cmd);
+	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 
 	if (need_schedule) {
 		schedule_work(&ub->nosrv_work);
@@ -1659,7 +1674,7 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++)
-		ublk_cancel_cmd(ubq, &ubq->ios[i], IO_URING_F_UNLOCKED);
+		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
-- 
2.43.0


