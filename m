Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33526FA57;
	Tue, 18 Feb 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898792; cv=fail; b=Vu1vcoBeGUGNs8qWN5drSRk6TGFq0P+NywWu3qXYHQ64pei4cbxTq5Cr0EWmBGbKWH8dy0K5CeoVXUjYjhujTIhQlEVEvQaZFAxk6+SuRE4uDraNPPPYYCS3bUdyrQ9KStfzvuf1CASR5R/Ua480r0SflxI1/geyazm9cAW5gEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898792; c=relaxed/simple;
	bh=R1CV6iCpn1TiaICQpwbfW+PKnwowM+o/5/TUOnHtCag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ER2HvAy9liyrBOPlyulirujZrHoWXdzq+YBVIASpVCuYT/NO3+faaVkVcWvOUAoPzIGtVIrFStG9TUrXI0e9aQ/bcgfwzYmbFnz4vNoQP4ySp4iRcv8scy2e+oumK8Ym9ctBLQUhdVbFynYg5YHMFUsNbr269/9hgEFtrSXKL/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FaB4Ps4t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RIkKjxVE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FaB4Ps4t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RIkKjxVE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMZb1023808;
	Tue, 18 Feb 2025 17:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0raaGZihnOLzmWhp0fq+tWUQ/johOicEptPzr8OOcFQ=; b=
	FaB4Ps4t6aGv4hXm1HGStv/dfActYDnEw7/pTL9507SnJ6cpIAiE74JnN7RqhMmL
	UMY9ktYVG7+xlZIyYy6M2lWq5xC39/K3e2+zZDeTN+dkkvjV6dRyBoeZFGfBhuM+
	hiO22/a8dOzjQdq/QnTeOYZfxa2+YhpJojN+7VxgcDxqcUEj4RR4Ji0DIqtK7DP9
	CXeiGwDF2oYJBwjFDpcKrmn4x5ZT330TG2IT0QOK7nwVLAO202YBygm+YqshXlNY
	PGNPKPNXUpXr+C+nME9TcVNOBGI0M8CQBJgfASb6M4LI642y8eP1QK+gEiZoYdcx
	i6QwIqnLJTB4aYnpMI1uOA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thbcf24n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:12:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGkV2c024801;
	Tue, 18 Feb 2025 17:12:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc9ak5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbLUjahWzvnCarMNnVqdCKQXOtsKXaG3/A9oYNoNEalHpW/Omcn5p55Rq9yKjlNT2ZUzbntZVxWtwbebHaefupKU7zAMj7QtC03QyfTZ8nVD9cPLLJ6JbkfiM5DxOtU3hGOvLzXKkN81+WI1v3lcayw2xgsToRwQiMlkTizuYsDiQoGn3C1C/2Prv4dw50L/1naykmX2sSO0evfda6A6Js9iCNi6C/IkTpbiQqvt6ktXBPmQzWNtO7UtM7C1eOKl/pPvUjjoKFrLyEaVkPTaRinG8NzlfZ+LrkOugCAUZPHITv0Rye3d21xC+5pEqZa9FJV6HKafc5KkwJN83eZfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0raaGZihnOLzmWhp0fq+tWUQ/johOicEptPzr8OOcFQ=;
 b=L8jqJthmhOi9XDG8/W6NOHef859OaUsucyhNe0T65mVjYiOMQP3PQmDg/YuNUFjzHxmTX4df7DZZZpZEwe/dDjTckeS08f7ThCMzs9VmRNmRdgXVL8cUEOvWZ1uKFEzplLg3twg9Wwh875kWyP9MGws66F13igEuS+vB1H0vaibb72uDLtblwrNk/QFlfe4NusEA4J6lbNWuC/YnL1mOsdFZ/uCXB7TpxkSDkmsGoeNP4inbnJRHQ39S2fI4NesBRlastMgIRUdbg6TUAGQOVY/0xFyQ9pK4fhrTgZ1Q1J4m/yYC4TyoLLhoxDuOpUgFqXQOvChyHxerBqrXQthTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0raaGZihnOLzmWhp0fq+tWUQ/johOicEptPzr8OOcFQ=;
 b=RIkKjxVEHOOnpC3mYhKxGsd0bR05SOt+6RmKXP6nI7F5ivp7QO86IWJ574bHvI9HxMKn44avNfvaj9gJtT5GpmN1V3NyJ1CZaLgfuWJ4ly+lET/N1r1yiWgdaflaE7qXKYydZwm5ksyF7U8r3WJXxEBjP5ddEcCQ8Wa+5im0DX0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:12:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 17:12:50 +0000
Message-ID: <464bc3f5-aef2-4e6b-b7cb-035077d1e3f4@oracle.com>
Date: Tue, 18 Feb 2025 17:12:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: set bi_vcnt when cloning bio
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Oliver Mangold <oliver.mangold@pm.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
 <KP4HxjAbrINQTT05XxqLFD7bPj5ONsT3hTQJYUyXtoHBYc7-xFNDZUN3R8pWT-Cd1Q5fguKy97Oy8UJv5Nj1Cw==@protonmail.internalid>
 <f4f4fff4-5055-47f7-9f24-6b1780920f4d@oracle.com> <87r03vfpkm.fsf@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87r03vfpkm.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 585e2a5b-0caf-4576-83db-08dd503f794a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm5wbkdrbllXZHNQcVFPZzZWWnl4OVczOXF0MzRVanJQekV0eGpnNjZVVzR0?=
 =?utf-8?B?ZWRsUzRWYThqYU83OVVxN2xLQytnMGRTWEkwN1Qxc2hxZHB2ZUxJKzdjQ0VW?=
 =?utf-8?B?alhPNTJTbnA1Rk1sT0RpaTVhWTVZNVA5Wm9sSGxjcHVJQXJ6a3V5TE5sS0R5?=
 =?utf-8?B?RGpnWVBqQythcUprMFFRNGZveStqVU0vQjM1enNUZ1VjcGJyUldtUlhiSGIr?=
 =?utf-8?B?TmxKb0lsYUhvU0NQbWh1MUxoeUFUVFA4Q05OdldTS3hEN1NWYTduWko2azJv?=
 =?utf-8?B?cXVmRnNqb1hWZEFyanpuOFRHNVNhaW5iaGV0WVVmVnlsN2dZMDE4blIxMnlG?=
 =?utf-8?B?VG9TRWszbS9pbkdjbjF6U3dIN2xUeloxbHVXdE90SGpVZDVlemtNN2FxWG5G?=
 =?utf-8?B?a1FEdGs1WHVjVVZDV09INVJ1dGFJR08wYko4VTRId0Z5TE1qSUYrTEc0c0dw?=
 =?utf-8?B?M0hpSUoydms5TWJ0UEx2WnJ6U3JDbWxtWmszL3RwSUVqUGhkUUpYYVpiVTlR?=
 =?utf-8?B?b2Ntc1I3WE5QOE1VU1ExQWxlMUVvL2JFTXgwazhPYnNDdlM1Tjh5TFZPZXpV?=
 =?utf-8?B?L2l5TW9HZTFsTWNHVVFxK01kRFpBajVoN1M0c2V2cFRlbUg2VHBpZlFwdDBl?=
 =?utf-8?B?Y0tRd0lDQytjM3pBc3F5UHFzMkppT21YSG9IWDBCc29FZ2lMZVBBSEpGZTdU?=
 =?utf-8?B?cG9aK2dUUFdjMzNYUFdaS1hSdGlzMWR3Q2pReG80KzFQemlCNUJkeTYvdDZV?=
 =?utf-8?B?VERiN3NHWnRjb0ZHbGZKc1FpZndLZ3BuaDA3a1FISmY4VGdIRHBIT2JOZXll?=
 =?utf-8?B?ampVQTZITUlYQk95TExmL1djL3gyT2QwT0J5U0xHMHVnR3Z0cnNGdDBtSUJj?=
 =?utf-8?B?TWhnY1NKSm5vZTZNV2ppa2xZU2piZy9lWlBxRVJIL0lqak81a0pzQWVKeWg5?=
 =?utf-8?B?N2FTYXBHUi9YSC9ZS054dDdDUHh4K3YxU3hudGZIMGdqSm9TV3NQMGgvQ2J2?=
 =?utf-8?B?QWhnMlpESklxQzFXeE1yZWVnRHRiMEdGWGxLRThMZG1wdlNjUjQ3RkFndnh2?=
 =?utf-8?B?aGJGV3dVQWdyZ2N4dHdxKzhDcUZDUjREU2licjRPSG54V2RSSE12UEh3UnJX?=
 =?utf-8?B?YWQvN0c1Kzdpc0FJZVdvMmRXQUd5RzdPbzRhaFZIMHlKL3paRTVBTFB5b0VS?=
 =?utf-8?B?cEYrWDMzQTRTcEhJT3dGOGx1TVdPcUVhUXRUOUk5aVM0MCt3M2ZnNlpjRXRz?=
 =?utf-8?B?T2hhQS9RWkMyZjd4NENGNVdHWVdWZS9pQTZCRjVvS29OM1FjMHdWbExxSjNH?=
 =?utf-8?B?TzJ3M2VsR3doS3dVa2hSMFJBVmxvRStVQTJjZ0NYK2xjYmxpaHRBN2h0TkFE?=
 =?utf-8?B?d1VzY2x5TnlrdWdVaFhTanM2dkJyUHh5dVFYQ2hOL3RpSGRJMFlyNWxSc0pZ?=
 =?utf-8?B?UGI4YXZEM0VvTkNCYjVxeXdtWGlmTnF6WGs2ZXg2RHdOTldkeElpZ1A5cHR5?=
 =?utf-8?B?dXhxTENxU3E1cENSV294VmdrbklzV0UyQzhiTUZjaGxXZDlSdkhjTUtadG13?=
 =?utf-8?B?K3JKekNCU2VXUEFTWHViTHFsb2ZkVXZ2Ynl0dmhKRGIvelc4eVg0bGxVQTZL?=
 =?utf-8?B?ZW5yQlorQkhvcWM0ZXRzY0xTY0RvUFhueThOc1o1dFJ0WDBUU1ZqYlVQVnJF?=
 =?utf-8?B?Vm5IYk91bXZmYzNWc3BybWVRZTBQY3MxejZrMmdYU2R2TzE0T3hJSlExZTNN?=
 =?utf-8?B?NTFHVmhaOWRLZm1EV0w5N3NkaWFrYVJtSHF4ZWFDMzlWY0h6ZVJnRWJKS1J6?=
 =?utf-8?B?S1A2dmRuOXpKb28vWU02RW1obm5yMk1yVlByb0w3STNvc2tNbWFjR2xBdTBw?=
 =?utf-8?Q?Zf3+BGk9dKdSX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZThWWmNyOXY4d1VwcUk0MUNydWR0Ny96QXFDVC8rNitVMlkzT294UDRtelFC?=
 =?utf-8?B?NEpLZU5FL04xMmNZZjdDV0trMlppLzk0R2c5S3MxYXg0bEtwSTVRQWY2MEdQ?=
 =?utf-8?B?Wk9oSThoblk5TEV0WjJDa0wyWHltY0pxTldNQ2p5REQwTXdBdFFWVWxTUkNu?=
 =?utf-8?B?WDVTZkR6Z0ExdUZKRXVGR0NmWUF6Ni9tYUpodWxxWnRCckxkVW9MK0lDVFVa?=
 =?utf-8?B?bmNTZWpNV1ROeGxCWGpJYXdmMFZhSHl6SCt3WTJNRDVLVnQ0QzZHTC82OGtk?=
 =?utf-8?B?eGdpZmtDNWZ1T3pyVzNqVmJNdjdoV3d2ZVgvN0hCS2lXbTkydEUyTXF6QXlZ?=
 =?utf-8?B?Z2s0NUNmOSthYTZLMkFkSGR1WTJCNTlmLzhYTytEbjgwTEtiTXFJQnhHSEdP?=
 =?utf-8?B?cExGYzdCSmhXZlVyd1RybzB1dTRIR25LZjlodUNpZ1lhOXZpNHF4K1p4TE9E?=
 =?utf-8?B?eXRFSEFQcnNTblN1WnRkTWlMQXVpQXdKMFBMRkp6bE5FMHNpRHhwbDVaVDV5?=
 =?utf-8?B?Zm1mamJLL0NLMEUreUdxOEJiRTM2eEkwNFNYbTZSZlpid1lGUy90SWVMaDBL?=
 =?utf-8?B?L2VUWTN6SGhTa0lsNUNXUXlZU2ZlbUhjZ3BYTmxFUytkbEVDUW53TStsOXJS?=
 =?utf-8?B?Zjg4ZE90SXR5dEMvSnBsQVNaV2ZIdzRTUFl0bThiSUJkZm9XRkI4M2FqeGhR?=
 =?utf-8?B?Rnp5cFVlWXRaUFQ3RnlPT1Q4REJpZVczUGsrZHArYjVNK1BvdWZEUmx0Y2dq?=
 =?utf-8?B?M21Wb0xyMWhhK2lmR1pMakFRM2U4bzdud3JDZVVrMis4L3ErMzVNMXhKazNv?=
 =?utf-8?B?MElpNGdNRHpCT3BCQUgyeUxkZUJoMGVIMnRwVHN5UzUzUTVFRGNRdmdMMlFI?=
 =?utf-8?B?NFlqeHRqaWt0aWoyN0tnYUF5THZxZEM2cHpPUEVERjBra1B5VnMzR0lTY2ly?=
 =?utf-8?B?T1RIN3Z5SU1Bei80WkpYWWpuUHNpZ2RYanI4YUMzQ2pyNHM3ZkMyeGZXaVV3?=
 =?utf-8?B?bC9IdGJYd0lLemxRSGJ0YUxCTUZtZi80RGxYeTZBWTBsVkVybkpQYW01RUZS?=
 =?utf-8?B?UVFCSFdpVmJhWjlwRDg4cWV5QjlpR2hFY09CVjV0dkdSUENNNWtjM2xmQ3ZX?=
 =?utf-8?B?bkMzOU1BaUw4aTJhenFGL2svQ3Z5VUx6TjkwZHJBN3F1V2hIb2ZSYk5veUts?=
 =?utf-8?B?WnNwcWFzV0lHMjNBa001MUsrN1FpdzFWZFkyWmx2UHdjUE1xQXJTNGE2RGpV?=
 =?utf-8?B?Z0ZabWowUjlvcCs4ZWlXQmF5cU94ZkplU09mbFUydTM1Mjl4VlIzZ1ZqdGlG?=
 =?utf-8?B?TklZZHVZbE5rcGpSSVJIcGtaV2lJQXBLcUx3Y3owTWlMVWcyb3J5dXV5QVBj?=
 =?utf-8?B?Q2pNSXI1dWNTbmNmcUxWT2EwRTNVSjJadm9yWFd6cmZ6eXJmMHd6ZTMxaVhG?=
 =?utf-8?B?dWgrVW5CUzg2S2VKY05vZ0lCN1BBbUtpM2p3MmVucXdTL0ZHUUpqYnRvYmdR?=
 =?utf-8?B?Tk1PdmROSnN6NU9kMkJkNXJ4dXMxOWlLZ20yajdEbnJsaU0yM2t3R3pBWXpv?=
 =?utf-8?B?UlZsN3h4Si9pWnIxVHZMYk4xd2ppazBtRnB1RFFiY0thcG81RXBpQTREd3pN?=
 =?utf-8?B?em5wNW85aEE0am05SDhhVnU2MHh0NW5zeWRURnVkMUxsTzN4cUVPdzJYVG9B?=
 =?utf-8?B?WlNzcytmeVR2V3ZSWXZKOEx4eFBQaWFBNzlndmxxVVF6VG9vVk5CRjcrb251?=
 =?utf-8?B?dkdGb3lVenFPMVFtNFhQb2Z5ZXBMTWpFSk9obzJZV1NEcnJELzluWUptZEVW?=
 =?utf-8?B?Z1ZFbXFwTDNOcFF6WVVMOUxqUnNFMzRRS1pIZ2ttSnlmcVI1YU9TbTZJZ3Qx?=
 =?utf-8?B?akI5ZXZOQVhaVHNneTVrM3hoWXJvMlZ1aUhISWJoMVcrMFNjRGU1SGNIM1Np?=
 =?utf-8?B?VUNwblBYNkFwSVpjZnZHaHU0OXY1b0NaVHBGcXluajJCVW9BUWY2azBGU1dG?=
 =?utf-8?B?Y1FoekNqMFdGOWFjenY1Y2xjVW5hZXNvWGFhYW9HK0oybi82WTQwNWNZbmg5?=
 =?utf-8?B?ZnoxWEtlODR2N25PeDBacGRYNzlGa0ZQMjQ3VjlDM0pVMWJZaU5TUG1BVFZO?=
 =?utf-8?B?RXNLY2I1NnVOSHAvU0lIT2VXK1VpSWFyV3FJd0pMbWFRVHgveXVGcHc3OSs1?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EgGGVJ02D089ucVTRgqmLgSmHPbxsmwBy/uhtGjE3iwbSq7X+WHR0GrUbF/hrY+aKQpu2cnnBUa2f+rTmU6/DHkHK/MlLcvd+w9gAzc7wgFcx16VDA4p9nRUaSlJSzu5otgiFb+ID3DJzWHqOz8i36BhBhEV8t4hSGhm2dtVOqwig0yXTUl5dBv1N4zlqqfj3dml9GA/mFd47vtO0tar0QOtP18a7pURlG434Cyls8Zrmeuxe94yQERK1Oa/enkByd2h6c7BEHCkNqwm3w6j6wkMZgwMQvVz0vEbtEoQSJkuUNMRUmf/GqA205XosbXfF5WNceQGtFLwEoff0wrc7euvtEbvi7YodIyLpi5YYqbqbo8mOJE7NA6rPr53ThC8VrFKeZZTme7EMPrucSxLltWYzzp7gdpiKm2MKJdcUKCviiKWyampF6UMx0DFPS5djhiaXQn6BRzlyq1XQHjisbv/n8fEtDVjsPj0BezLKdnph1okWESsduFNFxIyby67ZsxbJtBp4yz6lFIURTV1Lg6+iAf7OYEVJUw3vixy3e3C7zqfF9yxM5K84/KxluWlCVPFLy4BM0LxZMP3B9Sg7Ou86ROvoz6DLzg8/NKCCMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585e2a5b-0caf-4576-83db-08dd503f794a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:12:50.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBphnayEocmmPm6nXsrkOWgtavuXYVxKomfjMXL6NymhaLacYnh9L5PpqRFEOg/HQQ+P7vvq2h8f3l9UJ1Z51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180122
X-Proofpoint-GUID: H6J6PFSOewjYXQ3uRtFpyEMQ9Svxc-JF
X-Proofpoint-ORIG-GUID: H6J6PFSOewjYXQ3uRtFpyEMQ9Svxc-JF

On 18/02/2025 11:40, Andreas Hindborg wrote:
> "John Garry" <john.g.garry@oracle.com> writes:
> 
>> On 15/02/2025 10:58, Andreas Hindborg wrote:
>>> When cloning a bio, the `bio.bi_vcnt` field is not cloned. This is a
>>> problem if users want to perform bounds checks on the `bio.bi_io_vec`
>>> field.
>>
>> Is this fixing a potential problem? Or fixing a real issue?
> 
> It is fixing a problem I ran into in rnull, the rust null block
> implementation. When running with debug assertions enabled, a bound
> check on `bi_io_vec` fails for split bio, because `bio_vcnt` becomes
> zero in the cloned bio.
> 
> I can work around this by not using a slice type to represent
> `bi_io_vec` in rust, not a big deal.
> 
> But I am genuinely curious if there is a reason for not setting
> `bi_vcnt` during a clone.

I think that it came from commit 59d276fe0 (with the addition of 
bio_clone_fast()), where we assume that the cloned bio is not having the 
bio_vec touched and so does not need to know bi_vcnt (or bi_max_vecs). 
And it is inefficient to needlessly set bi_vcnt then.

> As far as I can tell, it should be safe to
> set. `bi_vcnt` being zero does not seem to have any effect other than to
> puzzle developers debugging the code.
> 
> Maybe I missed something?
> 
> 
Thanks,
John
