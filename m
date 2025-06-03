Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC3146A66
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953046; cv=fail; b=EEyU4LH6OgjG5BjXhmHiLa94KjXh5d2MEwFByMBRxdySQs+zQ7bdOric/dEQnZ/efQvlMRPpgn+fqxKuAXcQes6ariAiEBqNrksZ+gaUo4yiwmDwjW7fZSSvHnm6pHsSKNyoD7GJ/awAkm+2TkrMwIkjia7a+siS6YH9b0Du51g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953046; c=relaxed/simple;
	bh=tDXiQ0/2Ff0mHoWuS1eObWylYqdj0Xr/L5gDko8QJXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/mPmSmrkAFm8jI60vbhi3PPSMgwpOoJhWz0odhE4tXz9QpcaC8uWUTXox3SP7SrlppssccTy7cbN2a8MuWyoH7nlCRC18jr0wHnsamJDX7bajrx0P82pM0JpwuM/1nZgYWlV3eIzwyueybFz+9uFnMqfZ4GO8StnHaYeXXEzMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FF+i18kd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WwYUoDgB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FF+i18kd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WwYUoDgB"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AEmCt012363;
	Tue, 3 Jun 2025 12:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vdn0x4tHvWL0sYTfLMGJCXz884AcqXfRJPbOtyudFDg=; b=
	FF+i18kdPVWlxPTp5wnufakZGDg7/9e49sSSQmpuw/6UmK7ZM822lr2WEBLCGwcJ
	KMb+R901kgtveG4BZgpIsYaiRgr7gUsaBz/pNyCQmHBdu1lPBId6FmCIBSKfy/8G
	N8yj1xnixhuGVIGfmQkUawA/Z5E2TNstZEqTRmiJr0E11WhO4L9GGAnUDokd+L9f
	/ze5JNkM7Ls7i8Ohbs2Zh5WBgPcm9LwRkxz3JgQV/cAtoPJBdgg8RXQnAfs1Rk0w
	rIFjLorK/aaCErTBUIJGbHKmoQfHLtVzgIA5pHFZjN+3G4EEZEdkNU2sxGdkgi2N
	nsnIIxkmpQFhXNMZjlUzHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8k9qq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 12:17:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 553A247g038592;
	Tue, 3 Jun 2025 12:17:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7985m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 12:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5PlBSRnSvpZIxoMNpZzK1jn0EJ7HLjPRpR8Amle5G6Py8QpzbSxHMFjTN1LpPS7SrqKpJ9s5q97XXNVY+vYLWg8iXHjQmc9KyCSxIgl0X0HO6qBSFl+4gfNamTloi8CzPToV9qGdvWeBFuN6XpMzvSDyXGuO4WoHL0vVDRgQVkAuqHEjc1+7cDGwME3/g2ToTKk2GquORJNblhT9RKHpTYCfVfIfsM5RJdXIVkcbCypbwEgHy8qwSgML0kD4N5IP4W++IScLwStNZnpv4+/X7T8M5RMGnLTfiKRdOV/G1stdaMe//PF5dO6bF52J1frdlZT5qo9pU7Cl2ReEZ85zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdn0x4tHvWL0sYTfLMGJCXz884AcqXfRJPbOtyudFDg=;
 b=JYfA5l3N6nK8NeuvWMe5mx0UbHBcuraLHh3d5ar0Ny/8gsFZbTVdyuU1DZes83gW7A7eW1TP6L0GS2t7sc4YlMDOtiawPYA6RmJtMVtuIu0Ia3t+sKow2eS9IMWFbMQFazCAPtEtrfiisokeepctiI7CfJ2WmvWa9O8iEiACgGCc2b/NpJO9gOv/wL0HlTzXH9DA35MwvWyB8xeIMAzFfv1e3IZRz5kUK2+OCAl265YK9GUlMGl6yObnHBVAO1BjVU0hsNYYwdTuozSD+8BRXURdwjUKJL9cpUv7XB5ST9fdgL7yaOs/h7vr/RHTIhcaPhpbzgzLiWcsWRcI/LSvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdn0x4tHvWL0sYTfLMGJCXz884AcqXfRJPbOtyudFDg=;
 b=WwYUoDgBwb6ztsU4k7tqdPMjSR4WB0up7D06WczQ2PmfHcN1bNtylawuXYfypkvUPAbB3eMA1vYAVETtaBP8Frwmx+PI0PGddzQEia+sTbGiQBX+AyHrXGcN8f9K+0j6z1SsPrmMxNtV4tbL8cY/JhqoL/07VINjMlKe63Rd03s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5021.namprd10.prod.outlook.com (2603:10b6:5:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 3 Jun
 2025 12:17:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8746.041; Tue, 3 Jun 2025
 12:17:13 +0000
Message-ID: <07cfb3a1-c410-4544-ae4d-5808114e02d7@oracle.com>
Date: Tue, 3 Jun 2025 13:17:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix atomic write limits for stacked devices
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, martin.petersen@oracle.com, axboe@kernel.dk,
        ojaswin@linux.ibm.com, gjoyce@ibm.com
References: <20250603112804.1917861-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250603112804.1917861-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 6064948c-2a14-43d3-a6b7-08dda2989259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVgxVVlwQnBuMy84TFBuRGE0YUl0NnlaaTQ1ejE2R3NKa3FFeTBMbEpYUThD?=
 =?utf-8?B?WmZJQVZGelZPbjVYcUxORi9OTEZkNjJNbFVZV1NmNnRHK1R0L3Q3Vnp3LzFx?=
 =?utf-8?B?V04wQllvdjNucXhNdnVZZGJXcHhtMWUxQXlDTXF1Q29qM0VRVnR1MEtiVmgy?=
 =?utf-8?B?N2VXMjBHaWE1UXpDbjFEZmVrcTNGYlZ2aFhTLzBVY0xHQUp1Y2RGaHFZN2Jj?=
 =?utf-8?B?Ri8yNzk4Q1RyWG9PekM5MWhTRXNkTHFHMklIQ2l1R0ZWSmxaVngvYUdyQzRv?=
 =?utf-8?B?TmVDNmtWUmNKOCtDaHFJRGd3cHF4eWhRT3VVb3p6RWFmRVlZNUxWVnlHQUhu?=
 =?utf-8?B?TkJsWktGb09vYkdNYmZCUEZ6Wk01RDVrbksvZVRsdkorVHliSHh3MDV5WTFL?=
 =?utf-8?B?Q0JzRzA3MmJsWTM5VXZsb3Ria1RJYXNlZzN4dFN0UktKSXM4b0ZGNk5XS1JJ?=
 =?utf-8?B?YnNZZjlRVVB3UnlOZnNkVWlJWGpKeDJlbVkrMFV6L3pOQmpSVm1tOE5iWHYz?=
 =?utf-8?B?MkNJT0FsVlRPbDU0L2NkdkovT2xCZnZuR1lnV3VpRERKLzh5NVFrREFyMDFx?=
 =?utf-8?B?RjBSL0pIZFhlMXAzMDY4Rzh1Ri80V0NqK1gzNDFMSks0UFpSd0orT2tjK0pm?=
 =?utf-8?B?SldEaVpCK24xQVBnVlZqUlpWK3drMHNLSFBrTDg1eDE1UExYY2pLLysvVUVl?=
 =?utf-8?B?N3lGQ09aQlp4V2RqNUREbG5qZUVsMWxQOC9hZXVqNHBWM0NHeUZyQVR3Smh6?=
 =?utf-8?B?OExBby9PYmh0aFlXNWwxMitDVlJaQnlZd0ZtNWZ2REVzYm9LREdJZFZRckZi?=
 =?utf-8?B?cEtJZTNvdnFycWk4UlRvRFNDYklCelFIZFZWT2tuNHdsRkxQMmlZUEpoYTJR?=
 =?utf-8?B?RG84aW1ORUF3OGU3bCtpSFJQU0Q2V3RtWCtYb2dHdHUzS0s0WWc3T3pudDha?=
 =?utf-8?B?dXBlTFEvL1BJaldneitVR1FqdGVZMnM3Y0dpSzByM3hXVnI0cnZBODM0WS9U?=
 =?utf-8?B?QlA1RXNyclRPSWVBUFc5VnlrbFVnOTV6UGY4QkRvYXpYR3gvVnh3NVRtSFk2?=
 =?utf-8?B?V25ZZE0vMTVIOWFEbVVPSG96M1dnanZWVmFWM0ZBZWdwNGFDZ3J4bTFQaTRt?=
 =?utf-8?B?WmNwMWI3NlZRZ00yYjNGMVcvcjVta0cwWXFPWUo1SW5DYzNnQmxoeG1OWlE4?=
 =?utf-8?B?L0Q2RlRvVmp0eDNjYk96ZVlEa3lhYW81bys2TUt1azlENWNDZmJhTGh4NWJu?=
 =?utf-8?B?SERtNjJjK2o0YnpjN0MySlgyelRpVDhqTnA4U3RFbUhJaE5xeDdyQ0pndkg2?=
 =?utf-8?B?d3l2N0k4cXhOckhpOWkwT3VkbmlsZ3JEejNweldGM2FwTUFGR21zRXlpMzBJ?=
 =?utf-8?B?ZldoNzVqM0paMnp5OWJZSGgxaHp1YmNYclF5a0tsaUJmMmpWTnc3RGRLMGZI?=
 =?utf-8?B?SFV4U3YwNEN1WFR3UThqSXo3NDhQTVBheGt4dlRQb2NwV2pYRWFmaU5ydzNY?=
 =?utf-8?B?dkExUFVuY2xRNGNrc3habE0vRzBrRWxoQ2ViRWZMcXZNbHFrWmFZTmxjWENR?=
 =?utf-8?B?VWpZNlJOdnBaMzRZZERpTTVGWmYxaVBYdHhlZzNpR2wwVmRZdXN1SWhtOGts?=
 =?utf-8?B?eUt0QzJkc3A3dVBwMDNEZmVKcnhRNXplcVpQclozNDF1bHkyZGhSMU5aN1NV?=
 =?utf-8?B?cFFEb2VnMkFtZ3pUdmVQazh3aERMZTNiSWNYVVl0aXNTOHF4MTZDU0VpY3VE?=
 =?utf-8?B?bmUwamN5c2tuS3JZaGJ0RkJxc0ZtTWZCSUsvNXVVdloxZ3QvRWxaR2R3TVNz?=
 =?utf-8?B?aVFzZ2RNcVUwRDN4bFl0bUpIS0E4ZUZRUVRPYVNMTWlubFBrbC9kbXNCLyti?=
 =?utf-8?B?REdqK1VSM3FNZ1JrcVpLN3ZuU3FrcERqWWdOSFM3VmsySXc0aXBmalJ2ejNn?=
 =?utf-8?Q?lngQkMqkKDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWpxZVZJby9CUjNyMjhLL2p4QlMvMGx0Nnp3N25uOHByRWk5KzMxYjJ3dFVR?=
 =?utf-8?B?NWRFUkNlZ3kxWVZTQzdnMjY0VWpOREVyclk2a2I1YWR0REwzRGUxc2xZMFJl?=
 =?utf-8?B?MW94RU9pV2w2LzJ6OGJ5Z1plWWROZnozZDNFYXYrZ2lhWVV4S3NPYTRYSUxJ?=
 =?utf-8?B?SWswL1JJQXhDWjVFNmRrbGg5RWNZQ0oyVm1lT2dEU1lEU0dYYVV0RW8xaVJV?=
 =?utf-8?B?emZLQitMaWd4MVpyMW9aL0d6dGU1RVMwV3IyQVBuUVlVbzlNMWFqY0tZZkZ5?=
 =?utf-8?B?bEFZUGVKNVhnNDNkS0M0UGlsQnpEVjk3dTlvWVY4dW9zVUZNSC83aFhOOGlh?=
 =?utf-8?B?NDZlZUNiMUoxNlFhYmZpL0I4RjQ5RCtWRjlMVWtrc2p4QmZMSTlKZ256UE5X?=
 =?utf-8?B?Mk5lWkNuRktoejlSNkZyN0MwR2F4eDZuSnh1dmcvNVc4ZjZ3V3pMTHRyYmZv?=
 =?utf-8?B?UDMxWlRaeXV2aGtaOGVtOUxQRnQrN1Z2T3EvT0xoNUsySDhkd0tKeFo2cGlM?=
 =?utf-8?B?WHlXWFUrSXdJbXlEMy9Tb2FDZExqNndqMmZteWJ3VXhzM3R0ejlMQUF1d0Rq?=
 =?utf-8?B?RDFzWVlpMzBoZTVuVVhCUlBSODcwZXJtNW9rM3NkQkpjaUkvWUZJVlp1Q3VE?=
 =?utf-8?B?Y0QwUzZJbFhSSTlRVU5HWFVEY3doY1lHbWJhTUxVMEs0UXYzU3p0SHo5SmZG?=
 =?utf-8?B?TjdGSVc4ZkVjWkFpMVl4bE9CdGJFQ2RraEFJdmJHcUxoTzdUcytLSHk0WTNQ?=
 =?utf-8?B?SEZjc0ptVEdiS2JITjVOd1RuU2hRVnc2M0FnNGxadnhCS2k0Y1IzdWxFcnlJ?=
 =?utf-8?B?akdoMUZuMC9meFlIMm9ZdUNyekRwRVNYKzQrREk5b09XZkt4NDZuRnllN2U4?=
 =?utf-8?B?NzRKaEVsQURGS0h3ZzM3YWc0UWE1anBiS0crT3FnS3o5M21iczc1cGJpdHZo?=
 =?utf-8?B?N0l6Zm52ejNsNGZtV0NZVEZWOWdaeFJUR0xlSFQrZlIyUUs3WWd3RHF4ZHh4?=
 =?utf-8?B?a1JudWMzRjY1NjV0ci8rcEZZcjNSS2lxejkzdy90Z3dYbGc4R1d0VGgzQzA1?=
 =?utf-8?B?cWpqMzF3M1RYUmhTelR5Q3crOFYrcU9ZSnVSMmp6b3BoZ3J2L01JbXQxb2I1?=
 =?utf-8?B?eVBwblc5S1FkNStVM2szUDRNV0h3bFYyQVBhKzlEbzQ2bkRXUE5LaUJ6MUdP?=
 =?utf-8?B?OFR2N2dnT2ZCeEswZGo5Z2F2WmM5bWROeEs0K1M3U2dXOHVqamRqUmRRYTVn?=
 =?utf-8?B?YktZNjBQckZKRi9SV3JhNW9zUmUxc2lUMlJxMW1TUnVrdndLb3I5d0E2YlQ2?=
 =?utf-8?B?SHd4aDR5R3F5WTZqZmdwRTdoN3lFOG5iT0F3RXkvaWVadUI2QmhmZGRqNFVV?=
 =?utf-8?B?TkJiZXg4WkdrSEloREZUbnVXckJoYUszazdMd25EalQycDlhYmlRc01xMlVo?=
 =?utf-8?B?RTZMQ3JSSGlDUjdkcTA3TnN6MjA0RW5PSGZJOVdrVENnenFCTlJwRE44bWJz?=
 =?utf-8?B?dFV5VFhtREdKVzBjMEltNGltSjRXS0p5czF1a1dXS0ZNYmFDY0ppWExrSU5B?=
 =?utf-8?B?M2htNGR1V2ZsRjlIV0JTdXE3M2JnVVl0dXFpemhRcytyeWFSNlY1YitYTlVH?=
 =?utf-8?B?NXJRZTh2ZG9uajBPZk1ubkM3Sjl4bng2NnhRUVdoOWJIVFNiSEwzVjAwUnFy?=
 =?utf-8?B?MG1zTzhWY096bUhjNDZGOVh3czJ4NWRWKy9rWGFkZURFd1RXOTN6am4xVUFi?=
 =?utf-8?B?ZnlrdzVPV2dBVTNMSjM3UmVXWExQZkg3SS9zMVIySXdBZHRVcEJ1UmY4OUZy?=
 =?utf-8?B?TENOMUt0OTQ5SG84alpYUGhIemFyeTJsai9nRUtrdythdHdVTm1URTloS2tM?=
 =?utf-8?B?d2pGVjQ5a1hyVldtRWUxNHpOcEVnQmVqSE1EOG9LWnJCTXZMRTJLei9ZUkdB?=
 =?utf-8?B?RnVVblhxSlNjNW5PK2RJbkh4V2FwRFVqZlR6OVlOUUVyK1BodVNBZE15NUEx?=
 =?utf-8?B?N0pjQWtiMUZKWHpPSFU1S3lMbFUzUXZ2QXZFY0Y4aGJrTnppb1pyNDhLak85?=
 =?utf-8?B?Q3pKcGZKOE5aUmovSUhTdzBsM0dWK1FCQ1RVRDZoNUxtZXNsTVFPTlNzbmJw?=
 =?utf-8?Q?gM9coobSPcFntIVnSLApwYimR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DrjVEa1KRxPPBWeLMSQJQLysNBw+V7vej8mYQptipwOq1ht2ojcdudzLxIWz8p0kw/GhpmXytN7RSQiM54TLEF3z6GASfc+3bcS27lJevpo3gA+nknFFYVZEpnV3BFyNANKby6N/UtPwuwK/ou3hpEtiuANNDP5nEgDH53U2Xx4nN9SOhgXtXeJ3+JTCNyZ6My4fZM57wclkBnfW1tbI0RrP26r9N7VmQx7VupumF+YWhH1HrQRs26w9849OisJRMFkdfHIZV2R9h0/EsOqOqI8AyFfw073/sNO3i5fKfLRNXwdru+fN5IJhgbD4ogub6pqfoDa6tAHbuziw7z4lfDctDj9Aj6tFGBFA7ls+7lZ3yTrTfoevF1NzNbkknyQ+Xhjd3psBdMyI5yFJyMdbviMaQbZPBU67FStdtmAlIfrDsrn8SX7GSJAHhW/+ctMnOJaTTeez2kF8h8znNdmVENE+wdL3w/Co3w5qicoguRO/t2zVTMs+NXw90C/yt2unP32leRYpHTpkx/Kf04ITyzbkSyKL0AXGdxXx9ZVQ+5lR7ah4HEUrs1WKb8pb4wrSX+QrhskaWFbnD2Nx2ToeSixg1Ht/3w2PsO1tePgYHIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6064948c-2a14-43d3-a6b7-08dda2989259
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:17:13.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlobZIYF0uS3z86d64T0PSVvHwgLkX6VzHqJAkdwrxCkPc+5lUlvN48cwLJ0KICLeRHuoMD1NcIOb3joCgxB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030107
X-Proofpoint-GUID: V2rLkI0M-7YkiC4KEwg2smu8i_CuAE37
X-Proofpoint-ORIG-GUID: V2rLkI0M-7YkiC4KEwg2smu8i_CuAE37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNyBTYWx0ZWRfX1n42UolUuLEj OmQUkZZfJ/ayO6ZoWirfHiaOUbU42pYVc5wEJFQrBxJaxGqLTdV/rYRjtAMWd8z1E7ERFCtCn+p 7mB0Rz+V4jXz3Kato/lqa2M6002MnXfbJOi+FW7x+Pk3fSP51Pnw+wxre6YG14JtDCGOAfhoB7I
 EjkV5oaTXkrriYxeLLpdqxdwpaUsFdrXUQyWtGoFGG0acT3TmLLoi9ybFvq14g9HH4r4RR26Xpr sXjKgBuQfrTP/P0yYVB/NP5ugqs5B0iWV81ZSzojeek8xX7AxOSqZO4KcQODWwMR2GLPgYUAQU+ O1pSZjoQ2q4hY79V1WZYIIUFUeeHTiCi+DVyCalquoxYEUlsANGMb/FZ/85WR5FTE8xnb7Wo3Bg
 BFgbOs7WGNUW4XWI4fI/zClQBlLznVIV3lRIu9T6LKtvpqju4CfyHkSOnATfXnWxo1CjSZSG
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=683ee7cd cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=zfRAjShRL0JoxvIHp9sA:9 a=QEXdDO2ut3YA:10

On 03/06/2025 12:27, Nilay Shroff wrote:
> The current logic applies the bottom device's atomic write limits to
> the stacked (top) device only if the top device does not support chunk
> sectors. However, this approach is too restrictive.

Note that the assumption is that md raid0/10 or dm-stripe chunk size is 
in io_min. It's not ideal, but that's the field which always holds 
chunk_sectors for those drivers.

max_hw_sectors would seem to be more appropriate to me...

> 
> We should also propagate the bottom device's atomic write limits to the
> stacked device if atomic_write_hw_unit_{min,max} of the bottom device
> are aligned with the top device's chunk size (io_min). Failing to do so
> may unnecessarily reduce the stacked device's atomic write limits to
> values much smaller than what the hardware can actually support.
> 
> For example, on an NVMe disk with the following controller capability:
> $ nvme id-ctrl /dev/nvme1  | grep awupf
> awupf     : 63
> 
> Without the patch applied,
> 
> The bottom device (nvme1c1n1) atomic queue limits:
> $ /sys/block/nvme1c1n1/queue/atomic_write_boundary_bytes:0
> $ /sys/block/nvme1c1n1/queue/atomic_write_max_bytes:262144
> $ /sys/block/nvme1c1n1/queue/atomic_write_unit_max_bytes:262144
> $ /sys/block/nvme1c1n1/queue/atomic_write_unit_min_bytes:4096
> 
> The top device (nvme1n1) atomic queue limits:
> $ /sys/block/nvme1n1/queue/atomic_write_boundary_bytes:0
> $ /sys/block/nvme1n1/queue/atomic_write_max_bytes:4096
> $ /sys/block/nvme1n1/queue/atomic_write_unit_max_bytes:4096
> $ /sys/block/nvme1n1/queue/atomic_write_unit_min_bytes:4096
> 
> With this patch applied,
> 
> The top device (nvme1n1) atomic queue limits:
> /sys/block/nvme1n1/queue/atomic_write_boundary_bytes:0
> /sys/block/nvme1n1/queue/atomic_write_max_bytes:262144
> /sys/block/nvme1n1/queue/atomic_write_unit_max_bytes:262144
> /sys/block/nvme1n1/queue/atomic_write_unit_min_bytes:4096
> 
> This change ensures that the stacked device retains optimal atomic write
> capability when alignment permits, improving overall performance and
> correctness.
> 
> Reported-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Fixes: d7f36dc446e8 ("block: Support atomic writes limits for stacked devices")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-settings.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a000daafbfb4..35c1354dd5ae 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
>   	    !blk_stack_atomic_writes_boundary_head(t, b))
>   		return false;
>   
> -	if (t->io_min <= SECTOR_SIZE) {
> -		/* No chunk sectors, so use bottom device values directly */
> +	if (t->io_min <= SECTOR_SIZE ||
> +	    (!(t->atomic_write_hw_unit_max % t->io_min) &&
> +	     !(t->atomic_write_hw_unit_min % t->io_min))) {

So will this now break md raid0/10 or dm stripe when t->io_min is set (> 
SECTOR_SIZE)? I mean, for md raid0/10 or dm-stripe, we should be taking 
the chunk size into account there and we now don't seem to be doing so now.

What is the value of top device io_min and physical_block_size in your 
example?

> +		/*
> +		 * If there are no chunk sectors, or if b->atomic_write_hw_unit
> +		 * _{min, max} are aligned to the chunk size (t->io_min), then
> +		 * use the bottom device's values directly.
> +		 */
>   		t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
>   		t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
>   		t->atomic_write_hw_max = b->atomic_write_hw_max;

