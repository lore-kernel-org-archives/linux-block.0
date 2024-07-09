Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6315217D
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512843; cv=fail; b=Mol36LLdbBejY6CT+ED9jUSygnaafrHR0GOWkpB8h9CNFE1mWeXvJogCsfJ2nIpLxzkaiS7iYb/WfJEOPfZvR5w6kVBO81at9azoIeYHywwfCYobg3QqaSRaB+QG1TmBM0O/dWL0R0W76ONQNTc3daXWGLaaXcMU+QitC5si6go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512843; c=relaxed/simple;
	bh=iOQokv0eaakQXwUvPEB2v1zAjDU2mfb20/t31OlcWKs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0CqOwrIie+zc/3AYfcJ7TG/sjpIdfMvyKeb95GGXWWn9dNBIXK9PhXGCh33cSpuacuEI7cTvpfXORed2rP5yYsNFPX/jbLHMIb5deaV4HNKNapoCd234Jw+jwc24K9xzk2hIY+O7ht8wg9lxkHhqhRb2AViWhLRB9Xp6JEXOkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i0XbmIpC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GAJozShx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i0XbmIpC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GAJozShx"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tXxx001430;
	Tue, 9 Jul 2024 08:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=VJ1iWG333RKMysrtDkHKlIF92wx9vRmNf0hHGD7F/nM=; b=
	i0XbmIpCOAooPpYhZZpK3htEOXkmF37ZzfKtahID8sbIrx1TjtbLz5exFLd8YgDl
	cfIFOBbMBIzuRn1k/ixi8YOF1W/0kW7P2QvWGT/umUwtVbkUIvUO0qqLMA7ioIeR
	mf4ePcuQQ4oL8U1emBtDXP0jcnp88xyL1lh/jM8lPYlwoM6uujz4WQvu/zX4/fyq
	yV3CDvC/t0dctTtPWCbX2UnRPPcaFcFXreWmrnuBpdWg2UOhdjs9Kp4smcfzgKRN
	SgQiKQwVdZaWPYbosDdZySMPfQ+DFqCCwAFY6epDF0m+lTlH+jEK6Yu9PdULxgzi
	0bX/I6WQNwwIeWu3BjTuUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsur35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 08:13:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4697kOa1036244;
	Tue, 9 Jul 2024 08:13:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv0xjrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 08:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF6pFkVcY7KRhMZX6vqGIL2z8JN7snBV4xMg5AegxhHAk74dYvhjLXjfT7SxDm8bZBi4aSEUMkWzKyn0NT1mUgKrQ4kHvAgkX44/OiUrxOqTyVCAUM8opjpXEMMiQRrNYH/jyDXkowk+WSObLX4hMukZnpKe3MHofjBw7vOUNGeL8IPs2sK07A8T5T5lvgAqhkzgyvVEkVF7691H1zBlV4OwEYCsjhaM/RWwiVWJD8R27dQ5Krvmo4Paxqd37b0xeoPlCrrGsET4qXDGWPeaZAe3d3ibmauHUvrqdVvJxwL20v94IUXo+XBJKUbFAiWVbSMnqcZSwihE1vQAfuaWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ1iWG333RKMysrtDkHKlIF92wx9vRmNf0hHGD7F/nM=;
 b=bKb9gnSZyU9XS3oPDJ+/4aAJVeKuDvV0gasXQKJ3hjMYaR/JALK9w8kVF9wChi+IBaoPFDVngpGWtzocoluH5Cf1G1OMfiy3DteWyaGNrlCj4B36Ufhq3xcTqBaQcaI0MJuBQekDdgqsVIA2GIsCtRqVdbdL636ViHtMWryRXB5injck8NS3FaSypHuIfwiEzRnEfeKLJ8LNm6Vz8jlJXom4yh1CuJoiqotAFGQcqOhzKSpZAWWXzSJ9prrAs5rM9BxroDQhy6/nE0gbv83eoMbR5nSWxqkWgXlYesX+eeWfwLeR0NXkNVtQbubI5FwtkoATZV0MmnxMxLaZQ+dMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ1iWG333RKMysrtDkHKlIF92wx9vRmNf0hHGD7F/nM=;
 b=GAJozShxAurOVAOD4QlhA8Zd2p1arHs2ubLv6x08diLO5nt7IVu1oSIluWEw1+9v4uJUKtfSamSY+lRdI8cjpi73mMSNIJXTmdT4RhPZrVU+y7M3fhn6y5JZtDsA4GGql6yr6Y6clb0GdeF6YAkAm2PWl+faYsW+A+on7qXDWyQ=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:13:54 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:13:54 +0000
Message-ID: <f6b5a463-0bf7-4554-a599-bfa98ec48872@oracle.com>
Date: Tue, 9 Jul 2024 09:13:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove QUEUE_FLAG_STOPPED
From: John Garry <john.g.garry@oracle.com>
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20240703051834.1771374-1-hch@lst.de>
 <41cc6c36-d1ba-4010-9334-55e061eae5b5@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <41cc6c36-d1ba-4010-9334-55e061eae5b5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::35) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: c571a8fc-4d7a-4da2-53a7-08dc9fef12e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MG1IbFN0a0FUODdhSHIwOFl4VjlqSkV1Z2ZMWHFSc3dQT2FabHJlZzR0a3lP?=
 =?utf-8?B?MmhTclo1OU4yZDFNU25KNHF3eldLU0N2U1VadEJkd0ZBK2hkVGVTZ29FUSta?=
 =?utf-8?B?VnhVMUQ0Uk8xcDBBYnUvbGp3bW5DTXllSHFLcVFwTHhSaEI4SnZpSWhjRmVD?=
 =?utf-8?B?ZFJBaFNiM2E3Sm4vUitxcHpwa2gySERZT1ZsTHlSOUcrYTJjZjFsUFVmTTZC?=
 =?utf-8?B?NkhVVDhQUlI2dXh0Znp0UithUGE2REw1ZTRNVmhDNk1udjZVQVhIMTFjZWd2?=
 =?utf-8?B?azNtekxuM1FUNWZkU0pUQk05c0VtWG1DVi9pQk1kRE9JVU5XS0x5eitIa1dU?=
 =?utf-8?B?aXh0TWVrSXIxalNnaXkwcFJMWVk2WmpGZFhCV3V4T0NZTzBjSnM1Rm9mb0xB?=
 =?utf-8?B?SjBzZkd3U1lSbS9rTlFDdFJFdXpCWFFUTXdpWEFGQmtUc1VBWGEralM2b2FE?=
 =?utf-8?B?R2NBVVJvTnNXR0VXTjhPL0FmZVpUd1Z0L0RjQUc1eFhQTWo1K2NjWFVrTFQy?=
 =?utf-8?B?VStIMWRKUmxnRVhYM2dTL3pOV1F0RW9LbUhWeUY0NTJtRURKVnN6dGNxM2ZP?=
 =?utf-8?B?M2pHWUNtbEowaVhQRUNYcVM0Zmo1NmRXTU9rS2kwZmpoQnRBNm9GVisyRjBz?=
 =?utf-8?B?cDBXZU0wLys3YWtWK1BzeFFnaFNGV1RMU2NtRXZSVmxLcjkvTXhXSjRzaWJU?=
 =?utf-8?B?a2lGK28rYjJuT0p4U09NNmVDTjVKLy94U0FkbE5vZHUxNGo5R2RZVHdwVWVj?=
 =?utf-8?B?bzBxdzc5T2VWblhkNkxpT0VwTXQvSW56VDdvRnBBNzZpSFRNTUs5a1FMdmFr?=
 =?utf-8?B?NW9hTzV2OVZtN0V2Y0k4b0Zucmsrb3dLRk50N1BBWVZYRlRmbkJ2QURjVlZT?=
 =?utf-8?B?SDlRTE9uZlhnT2VyLzFybTNNZXJvd21VaDN2N1A2TTRaMnk0ZzkvcWZBRTdo?=
 =?utf-8?B?KzBlZkJwSk04aU1iN2l3MmFxWHBmSU5vdWlyZmlVNkpsV3AycVIrdVVtZHhD?=
 =?utf-8?B?dWh4dWw2QWNQeUxhdzVrZm1oR0JtZjFTVjdZa0tMdmRqdUpFbDFtWUE3M1Ri?=
 =?utf-8?B?ZzJJd2E4OHBOK29wWVBiNlUxSU43S09lSkFnZlkwdjgxL0RMMEJjVElYYnFD?=
 =?utf-8?B?R2pNTjdTUnZFcVFSK2UreEpQeWRMMVlDdm84T0g0bTBHR2FlcHEyd0h6Vk8v?=
 =?utf-8?B?Y3BwRWhsNkxLTzk3SkFReHlLK0lUM1hwRTJBdUxoZFRoQmw2dnkyWGRMZjhi?=
 =?utf-8?B?S1lhQSs5TmJIa3Y4U21wS2tTazlQWWRPWkZDSmpxSEVrVDh1bzFuRFMwdHd4?=
 =?utf-8?B?Y1doU1E5NnI0cmVhWjM5V1JnVjlqTEk3MTVrWHk3dmdpd2tPdi9BdGxTVVlJ?=
 =?utf-8?B?Q01rZ1ZlNHpqblNqUy8rN1g2MFU3b1dnOFY2d0piZzhMdlB5eTVkalVWMzRF?=
 =?utf-8?B?ajF5ZFFqTnpHT2FGeE1Kbnp6NCtQUmlybDYwMGRYbGgvQnNTTG03V3B5cSt0?=
 =?utf-8?B?K21QdnR0NDFNdU1vWHRuaHVDNTh3M1FlWWk1N0s1VHd5cmJoYzBrRjU3Wk4z?=
 =?utf-8?B?WklmcTN0eGNhM2tWZXVXeEgxSzRHcEtaYVBNeWpScUNieSsyL0c1OE43ZUJS?=
 =?utf-8?B?d09Ya01pUmh3QnJMSmRzdDkvR1EwdGxBWXhFWjZoYXNDcytGeWp0em8zWkxS?=
 =?utf-8?B?TW56ZitJMVByK0xEUVpZeGdUZ2pWN25FWE05WmQ5VWxRdDJNWkcxUy8yMFBh?=
 =?utf-8?B?SW5HNFNRVmo1MzJFS2g0NGFpS3FFN3NkRmJjNEhsU3p4VGxyeTZuZ3BYZWdK?=
 =?utf-8?B?aCtUSS81aC9YTmlYdEJLUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1QraDQvMkNKWDZxMmNKQS9ndU92QVN1SlVsMVN3djV4aGF6dGZhZW4vaEpC?=
 =?utf-8?B?Mk5NbVVQREgzUXNlWFJMek9DN1VvUnVmejVQclNqeFFhQ215UnpsWDkxaDZQ?=
 =?utf-8?B?Z0toZ0dTajZnaEFqZUttUDhVQkhPZW4wSlRrRDYxQ1ZYT0JtRTc5S3VsbEJY?=
 =?utf-8?B?RmJFNlI2L0Q3YzJlOGdKcEJnRmNtUjVRa2MwWU41bllaY1orb3hVUkdweTd0?=
 =?utf-8?B?dmxVbmNzaU9NMmVmbWVWU3kyWlB3S3dselJmdXkzenptcEtKWFpPRldyWHRk?=
 =?utf-8?B?dDNGUE84RlE4QTNSZE5wSDF3UE5UVkI5djhIQU82aUxiaThOMGxEY3FDQzZH?=
 =?utf-8?B?MzdwK2Y1ZzYveWR2MUtUZFp6L21ZRHVMVWUvYmkrZXduckN1YlM3S1lxS1lB?=
 =?utf-8?B?R3N3ZWpsTGF5OHJkS09mM2FqSTlNTHEwM0xNUklIOVhQMkEwbnlpWnJYZDBW?=
 =?utf-8?B?dDJzWHgvaFV2TDFxK2pQZ3ZrQWNmd29FL3B2UVhyTVZ3N3IyemdHU3pZays3?=
 =?utf-8?B?OU1XVWpSUHl5SjRhT0F1N25zTTRydk9La0JVYTBqbU1Ib3lIdmVwb2dQZDQ5?=
 =?utf-8?B?T2ppWU1TTkVyNW5vb1ZyRU1RZ2JzR2JyR1V2eFJZeWhXbnRrMXlmRTlObmt3?=
 =?utf-8?B?SlpGQllURUp5MERtTndBWHAyWXVZVXJmUnBKbngyUHE2cDJQUjN1M2VYLy9H?=
 =?utf-8?B?TlJ0YmlnMzVlaU9vc2c0Nkd6UUswVGlMZlA0elo5YnZIWTlFcEZCNjJTL1BY?=
 =?utf-8?B?SVBuMlF4VHlkWTlpR0dleFozOWdLZWxNMW50RGNPM0VFbXBoZk53RUd1RVN2?=
 =?utf-8?B?UDVBV3hPWkxVWTNiSEc5cUVmaHZSVkZwSWU3RlY1eGh2NDhGa2FKd0c1OVVm?=
 =?utf-8?B?SnYxMzJYSi92UHlPaEJiSWRieXFBWDlXenRtVW5qTnhHenZXMkMyTUNOa1JL?=
 =?utf-8?B?ZitQUnhwV2dlaEJoaUhXMW9kN0FvcERSZW1MVTNJeDJ4SVRzR3I4cVhMZW5W?=
 =?utf-8?B?V1I5cDROcldhTTN1dzlNZStJVmU2eHpCQ09GT2JLczBnajFiZW95bUliUjVF?=
 =?utf-8?B?c21EWmliTWZnQ0dOM25wV1pXQ1ViUEhWM0VlY2xjajIwZXdEQjVHTjN6ZmIy?=
 =?utf-8?B?dVNRQjJJN0dOTGZNR2JiNHZSSDA0SVFwbUh4eHNEU29pMlhoMVdVN1hNSXc1?=
 =?utf-8?B?cjFmbXp2WjlrOGtFd3hKY282dmJFZisvanF0eHdFenVjQVRsVnd4czlEaVQ5?=
 =?utf-8?B?MGs3Y3NNaUE0dFg5RkphQzZpWCtZTDJ1K2VQcCtrQUNtUXRDY2tCMUtSM1FH?=
 =?utf-8?B?NHRIYmd3d3ZZdXpsdWQ1TEtvODRhYU9DSFNwdlR1WXFNUHlMSms5NW1qSDJ3?=
 =?utf-8?B?QjcvUkFscktObi80SXg3VWpPalZUM0lKcTF3ckdBY3hpTTZ3MlhrWjF3N1gz?=
 =?utf-8?B?ZWVrcXBHSVhXSmx3UXVvNmNEZElySTFuY3luZm96YjFmYVN6Y0JtKzdpL2l6?=
 =?utf-8?B?UG8reWY5ZitXU3N4ZUJPY0YyUVhQdXBFTEhVbVViaXNxdjZuOGM2ZWJiaXpk?=
 =?utf-8?B?VENFNTZWSzcwZzlsWDh0bzdGSkI4aE1UVlBZNjZiUmhIay9jR21PSGdPV2NC?=
 =?utf-8?B?Q0FnbjBabnhLTDVGSnV0VURYNHQvaHpGaU1iYlQ4a0oyTStqK24yOUpDbndo?=
 =?utf-8?B?d2o5NlZGWUdtL0RLMWQycXBNVis0MGtBVDhlanhKM2JJTG9wWE1PTHZ0eHVw?=
 =?utf-8?B?VHpQSitGRTVMYVRrbUszVGV3V08yQWg3WTVuL0l6Uzl5NmhxenlZb1JDNW4w?=
 =?utf-8?B?VnRPN1dCeHJjUzhMMFg0YWZkNDcxVTNIb3laUlR3Z1J6bDJlTUtVQ1dmZG4x?=
 =?utf-8?B?d0tSb092dTgvbUE3RU9DUTlrbnNFUE5qT25xckdFbjRuYmUrSDBlRThaOWgz?=
 =?utf-8?B?b1BNbktZOFRBTGdBZDNPMFhFQXZKMlhwQ2hqNnVpeVlHV0xJZFJZVVppbm1R?=
 =?utf-8?B?cks2QTFveXJWNkV3Q3V0dU5xTkNWSWJFNDFKdlB6NkhvbmpKcllkZVZabGww?=
 =?utf-8?B?amd6UU82eXV3MWd1VEdZNi9YTmhUb0VSYWtHUEsrcDVCNkFFQ1NOeEEwbUFs?=
 =?utf-8?B?d3BVU1d2UXhBaDIvN1VhTzl6UjJkZHFLSWl4KzRWZlZiVzlZd0pTenZpZGdJ?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8egFavTwZU472tFbuNJInVwdU/BSvT3E6tPHEQhpDOpJrgTOhCB+WAKg04Wa55T5CzDan2sRFlnEtbde1kQehJ3NYZfFxXt02gMbYSZAwhEavh8zz4j52bH+tykzqPQMiNF3q2unvlb1DeGK1Orz+N25WciBxGWuUoi5aLhR3eSXSQWDi4/PJB6S9XBYcJUaZowDhz4zSIJJ+LJkvElHZstcmc173BlssGam2hXc17GbXjFUPF/9Roy2DjcwjeytQ+2d4TyHKGc8z1S1polqs2ruoY7AvZTKL5dO617qMaSaDpNtnOXgF6War86LrX1HABY947pTgcDkdJGHs20jWWVKSPgP3yZFxiPOpGXwTTW+/q/DdHR4NDUa8sYnKSI2vlQyYNYezhawLk/EIE2yG0jByLfCpbXdirsrfI+xAWDt2zl7GWGs6AZXpSWEV7k1lwwFnc0YL1dreYcIM53ofaCr6Nq2ctk0vke5HfSzjdpjpPPZ71VzhXcqQWsXVksAbW/5wLz7X6YqtMyx88ttsI9YEYQHSyWhDo3o4aj7SQnFSRtvhdW39rmKxoxzzwyH+z5rSYQmdoiELXS3fTwRDniO4yUBUsyuuJKnGZ3OhAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c571a8fc-4d7a-4da2-53a7-08dc9fef12e5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:13:54.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qBlbo6XJHJjNOhxf6xSPLmV0Xo2RC0Aubl+/GNCjMq6Wb0hJ3tv3smfRIk2/+bwPEe5xicEThT9GBR80ANpWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090053
X-Proofpoint-GUID: x1N-KPZ92__CGYm_ZxQw1ILs8hJO1w0s
X-Proofpoint-ORIG-GUID: x1N-KPZ92__CGYm_ZxQw1ILs8hJO1w0s

On 03/07/2024 12:55, John Garry wrote:
> On 03/07/2024 06:18, Christoph Hellwig wrote:
>> QUEUE_FLAG_STOPPED is entirely unused.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-mq-debugfs.c | 1 -
>>   include/linux/blkdev.h | 2 --
>>   2 files changed, 3 deletions(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 344f9e503bdb32..03d0409e5018c4 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -79,7 +79,6 @@ static int queue_pm_only_show(void *data, struct 
>> seq_file *m)
>>   #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
>>   static const char *const blk_queue_flag_name[] = {
>> -    QUEUE_FLAG_NAME(STOPPED),
>>       QUEUE_FLAG_NAME(DYING),
>>       QUEUE_FLAG_NAME(NOMERGES),
>>       QUEUE_FLAG_NAME(SAME_COMP),
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 4d0d4b83bc740f..26fb272ec5d3bf 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -590,7 +590,6 @@ struct request_queue {
>>   };
>>   /* Keep blk_queue_flag_name[] in sync with the definitions below */
>> -#define QUEUE_FLAG_STOPPED    0    /* queue is stopped */
>>   #define QUEUE_FLAG_DYING    1    /* queue being torn down */
> 
> I suppose that these should be renumbered, as I think that 
> QUEUE_FLAG_DYING now needs to be index 0 in blk_queue_flag_name[], right?

BTW, we seem to be missing an entry for QUEUE_FLAG_HW_WC in 
blk_queue_flag_name[]

Keeping these in sync needs to be enforced in software.

Maybe have QUEUE_FLAG_ as an enum and have a build bug to enforce array 
size of blk_queue_flag_name matches the "max" in enum QUEUE_FLAG_ . 
That's a simple way, but does not enforce correct ordering.

> 
>>   #define QUEUE_FLAG_NOMERGES     3    /* disable merge attempts */
>>   #define QUEUE_FLAG_SAME_COMP    4    /* complete on same CPU-group */
>> @@ -610,7 +609,6 @@ struct request_queue {
>>   void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
>>   void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
>> -#define blk_queue_stopped(q)    test_bit(QUEUE_FLAG_STOPPED, 
>> &(q)->queue_flags)
>>   #define blk_queue_dying(q)    test_bit(QUEUE_FLAG_DYING, 
>> &(q)->queue_flags)
>>   #define blk_queue_init_done(q)    test_bit(QUEUE_FLAG_INIT_DONE, 
>> &(q)->queue_flags)
>>   #define blk_queue_nomerges(q)    test_bit(QUEUE_FLAG_NOMERGES, 
>> &(q)->queue_flags)
> 
> 

