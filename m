Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD5158214;
	Fri,  4 Oct 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052408; cv=fail; b=mZlVPR0lR+IzNaB+2CxvQSOsftJxrO+vF5MGkVdu2BUCZVfnCM0UJa/Wi070qVkIaMVdPN1CCulDUwgRKP9U6A+lGx2A8mcC6jwF+vsK5fEAz4yjxuTLhc6YmqL29Ub/Jlt0V3RYTz+RP1pNBp5mcTnABnOT6S1PeghKXByuYiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052408; c=relaxed/simple;
	bh=On3Iu5ttsT3V9YilKsTYZAZY7WEa/GaLa9SF2HUJcBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hiDGsMJA//M6M+eKfa7rZMO+JT09n4QeBl2q/sdCsFFTNQQHdsyrS0GwaLD92OVNquJHLlP3JXGWlP0UjRGhav+HBz1XQsvSez/azCztmtGaPz/TdGnCCHVuktW626hJeNAm1lKDO1DICQFDmCELMlrM0snE6qh6HdZcAOtaTEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fhc8ewe+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o+pe5to4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fhc8ewe+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o+pe5to4"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494E04xi023777;
	Fri, 4 Oct 2024 14:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ZS3/TBJvSg5VqbgeRLiLFYwXzr1WtoNbI3+omCv3SjI=; b=
	Fhc8ewe+vcUzVXhpe4NdrVqN8rccr1NgDfJ7Y4NQ34KJdh+AGwPrM8Mi8cnwxsEP
	v6BXnfAc3LOmzoy2hGzhAfrAnptXUqAzAMDRI09Pwd0UZPo2NaoM27Ok1ecwHWou
	tM01tjPiikWABzXXtH154ZBEJHuanZja/frxcLdwRLeKWVwoxmtU1Trt0xsdV8gW
	tvqFaY97If2xlO89rMxQBIe4m479aNXNJimjgEgJWqD8VVNU+VFhmKyqOT5Ml9O0
	DJHvf8F5escKCTPgWNftB6Qnsfb36P1qNhlDgwdtbjPrlYNVitcO1LNvHwMpa4aF
	zm13hQyY7yH4pib1nJevXg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204gsq05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:33:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494DfJEq037899;
	Fri, 4 Oct 2024 14:33:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057c7fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTUxQnCiF+3bnh3ADDspptRnuuKba1oCfAN9Fq1GwAGq+VVSrwR+IBemgjaUmqKk9tjIpz+7ZIz4DxqhUsKs/MnjrpETXMt1bPmkrRxHPAN4leCMgDUrXN5/udZM+L6TaUCSPzANDxge6pxB84TW803ylFrxTa1mXlu76/oGrOx8pM6wAQ/Ih1gz43hdg+mRizVfgAp2DSnUglKZ45CCMhB8dkJ8TnWbMxpmsoG6oTwjFAfjmP+afR9RxMnOeEcUHrAoVpxE4S1L96fGAix/hpYk5o/6MLNj5pFmbtAbhoGy6r6Hy1ZzvDue/HJqNZBosdLCACVakCnN4OYmUwJLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZS3/TBJvSg5VqbgeRLiLFYwXzr1WtoNbI3+omCv3SjI=;
 b=Jz/jUnMreCfN8wVlDRpTG4IcWJoA0BpyBBWZoRtQKHAFnbsWy7davl+YtcWyx7cYeb5rppVHriDIqqJntjqpcVpPo871qSDslEF3PEZWF/ZZN6PLeZNa6rA8z3cELW3eZLRtJ+z64t20awM9Dpe3XplNbQf6yHGW3lKaUNth1OCT5BMjPQAO52pn5msXp7gS1fiOQecstR5G1abEY9OjWPua47GPqDAG7FGm5/S955YVhquy50XnF/AsR23OWEtmjjQY96ilIpFqKRUrAJrdER8yMCvxBvJm783+KkPrZTgEuqgFOMoq2322pzttO667W0CaFJHMBPUMbKlcXzdatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS3/TBJvSg5VqbgeRLiLFYwXzr1WtoNbI3+omCv3SjI=;
 b=o+pe5to4SVI/fJAtl0gbMoeEFaNoThONCC05FYI6ofEZSzgS/c7/ghNmxFhifd45cx3Pn4Mz9iJaam+oFrNTIw/UKCSP63XiGetsoBt+6P8HuuYv0hCv+/GLhLLYbxOKRk+ReNXxziLnL4qob8VPnqsLH+trhM8CaRFMXO49EiU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB4875.namprd10.prod.outlook.com (2603:10b6:610:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 14:33:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 14:33:03 +0000
Message-ID: <6a0ec577-fba1-44b3-87d8-3a202df19d8c@oracle.com>
Date: Fri, 4 Oct 2024 15:33:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
To: SurajSonawane2415 <surajsonawane0215@gmail.com>, hch@infradead.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241004141037.43277-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 161f525f-de59-4425-a264-08dce4817403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlpGTWZ2TVlDWWI2V2ViWFpHZEkzZDQ4U2RSQzVDNFpWY0JOeitOZVhzWGxU?=
 =?utf-8?B?UmhrWS8vbnExMjgrY1M1SHRVTEczVG95Smd3TTB0alFGSTNqWWJTSUhaalV1?=
 =?utf-8?B?d293Kzh2RDhsT2RhU2kxNlY3ZWwwOW82akpyQWYwZkY0Vm5FbU9iVkc0MGta?=
 =?utf-8?B?VEMwSVpmdnBQMG1qTC9KaXZvLzBPdGhvMVhYaW0za2RSd1VQNk43VTh2V2tS?=
 =?utf-8?B?dnh5akdCTjZVOXg0NG9PQWFzRVlvRXZ0d3c3Lzk0Z2N1Z09jNkVlOFhRc2VL?=
 =?utf-8?B?dit2NEIxVFVqeklsTXFHRHhMM2VybmhIRitqbE92RGswOStOdmxhWjlIL2pv?=
 =?utf-8?B?dXFjQUY0bDcrYXJWalF0L0QrbksrbEJWSkJwZjFCdEE4Zjk0MENneml1c2Ni?=
 =?utf-8?B?M0thRGh3MlZlSnRpdUVzVzRsemVGamQ5OVZKckdxNERlckN0Wm1RaE1nbW5x?=
 =?utf-8?B?QW41c0x6Z3c3Syt0Yy93ckZSY3lVNmVoL2paOGhsc0V5VUdqck9pVnNOTGNY?=
 =?utf-8?B?MndTNzM3bWsxSzUzbEM2ZEVvMEFweFI4OXE1V0ROVGFjRUpFc09hdG1VOUFL?=
 =?utf-8?B?YVp1M0I1SlBNVXF6cE12b0FlMU44N2lJTkp4QXlPNk5ZRmlvNnBnZkR1SFYy?=
 =?utf-8?B?TkllSWRZTlhIZVhUQ3lhdlBHanpJK1IwejRNOGVHSW5KMW9kN1MwREdiT1J0?=
 =?utf-8?B?VTBITURFWG5aRHVQVVlxVEUvdWxUNWQrSEZOSVErQkFuL0UwTjBOY012RmRH?=
 =?utf-8?B?U2gxUytNTG5NZDduTDdyZW9Va2xmaFBFZmljWENrSFBUVDMzYmNKblp6OHla?=
 =?utf-8?B?bk1pSUYyMTZtTnFvVkVkZ1dqUUIyMVJUaENrU2c4c1BDa1o5ZjRnV2RGUVJ2?=
 =?utf-8?B?SzZVU05SVGd4bDZiZEVwY0QrcUFiR1pQa2hKY09vaCtoUkVNMmpQU2NVWWEy?=
 =?utf-8?B?TkJyaURCSXVoaG9OeXB1SlFxVFFFcXl6UHNrbEN2MEdtMzZ0eFdyVmdIWUlD?=
 =?utf-8?B?ZzJmdWtNY0hnQ2ErUWlwTjlmMENPK0lGNE5SWVNtNXJzMHZXNit6QXA3c0hZ?=
 =?utf-8?B?SzN3VU1ibXdjVkFhZXRLbm5qeVFma0pjSm5vWERoRU9xcFRmYjh3TE9JanpP?=
 =?utf-8?B?am83SjdsT3dZOHJacmc2R1NwOWFnYlN1VUNYSGJWSWxZQXNkOVR6UEFFckEx?=
 =?utf-8?B?UnprdmRwazdnbW11Uit4aW40Vno2SmVDK3ZqVGpxNFFKai9KUGl3VytZMmtF?=
 =?utf-8?B?NU1ZMVpDc2ZSSG5KSWZxcnhpRGxMU3BpTHdpZGltMDE5RmdXR1pXaDNxd3U5?=
 =?utf-8?B?bXBUWU9uV3hPV2RFMDRHaDJXRVJET2o5L24rVHA0UWpvU093b2JyQVBjd0Yz?=
 =?utf-8?B?OEg1d3loMlpWSUZLTEI1dXo2RDBVWkxYc2ZyNzRLWlNvVTNocjYydVdUWWpx?=
 =?utf-8?B?Z21SWDFkVVFXa3BBcHhPczJ5RjdGSE02RTdXMjNqZkNWbWtCRHlhUWh0SkhM?=
 =?utf-8?B?a2VTMVdsWEh2WWF2a2FBc1FUTXJ3Tms5ODBPeFI4Q2xnZHY2QjVsekRxdGNW?=
 =?utf-8?B?cE9LVzE5aHFxcnhiY0lvSHU3NDhVaVZ2TW9rOC9Mc2N2UFpNNlNCS1JYakNu?=
 =?utf-8?B?MlYvZnFTSFlCc1lqQmRLa2ppZ2ZXR2RVUmNielJmQ0hxVjk2Y1hmRHNIcmNU?=
 =?utf-8?B?Y21EUi9uc2dUcVhFRWV1a01ySHd2azZaVzlNODdkc3QxM2htQ0E5UCt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFRkLzdWWFpPTkxidGNiVmlUQ2xpSGhmNEdVYzBHQitKK1JGdHlPMEdmMkpB?=
 =?utf-8?B?QU84SXpFWThSbUJ0Wk0yQjZTS3ZIck1EVDBaN0pkUDVuTGZZc0pab2UyMnhT?=
 =?utf-8?B?UmNHUFJEd0dPbU1RY0lBUlk4SmozcmVIZ3RxM1JwVkZwejNIcXQ3Y0FGSXZi?=
 =?utf-8?B?MHFOYnUzZTFqUVJTSXlTdlpPSVlxengvMUtrcXB3RHBXZnJ0ZHFHOWNqcTli?=
 =?utf-8?B?cFVGcW0wbDh5aU5hQmdVQ2ZYcktwR2xaek5VUGVsNW1DSEQyNTF4SHhZaFFK?=
 =?utf-8?B?SnkvY096WHR4cEZGMEJqbTlTMnU4ZjY4VUZadlB6TnpQU3hpQ2pvdllMNUYr?=
 =?utf-8?B?MnZwbmxwRFhLeDV2bi9wQWNneE40a2FveTJRdmw4ekxkazlpMUFuUHBNMzBu?=
 =?utf-8?B?dlM0eDQ0T3IvM29hR1dnNG9LMVdCMzJQZjIyR1V2OGMzd3pIWXNGNGg4cy9y?=
 =?utf-8?B?dU80OXhmejRmeno0Tm9IczlhVHNSTDdvU3VXaGNEa1NwTWNkRWZiaDRQN25L?=
 =?utf-8?B?cXk3U3JvK0RyczU4ZGgyRTJBZEF2Q2IrR1NWQzkrMEhCanpKcklQb0VKU3VQ?=
 =?utf-8?B?WC8zK2MzczVMMHpQcmpuRStsaFJuYWNhbE9UbzR6bVU3S0ZOc3BwdDcrcXlK?=
 =?utf-8?B?TjZnck1MUStOTktRQW5iVU1ZY2s0cHI3cGhPU2Q5S0gyS3hoeHg0U0I0cTAw?=
 =?utf-8?B?aEY0NC9WVDRZdzFsUUVScFNWYlJXYU56a29PV1Y2UFcrZ09PVVQ5SFByNG80?=
 =?utf-8?B?OVJnZUFJa2MybGYxU3ZmMnBSQmhtUFdRbmpuYmJpZlFsNEljNEJyMFZYV28y?=
 =?utf-8?B?WmVYdUk4ZVVWc0R6dFlmOGJjK1VBckY1RFFmR0NVQWxtZk1ITHVOOE55a3JT?=
 =?utf-8?B?OExySi9NNkFrRlZLSFNVc0U1ZkNBK2hzd0lrMmxYb201Z09vdEh1VHk0Rms3?=
 =?utf-8?B?ZWZrUjAzWGgycjZYVEh1WWU0WG5OMDR3bFVSUVJVNXZ6bzdCMGgrcU5wOUww?=
 =?utf-8?B?aEpvYnZ4L2xkRHdHM1JaZEIxQ0hETW1UNXREd01QeGlGS3NwN1NPeElVS0FM?=
 =?utf-8?B?U0RIVkJYT3hUcWZoVEg0SG04YnlGT0NPS3VvZ3U3Z0hKSnhhbk5xcVVRUitQ?=
 =?utf-8?B?OXdBVDJObWs5RDZtbTBGRGNJNXU4RzF2WXZUc3VETG5LZnhNOHcwa0NrNXIr?=
 =?utf-8?B?dyt5ZmdRa0lhRmY0VUxWTFh4MHByeGM5dzhrTXE4b2hmaXNnVU5SOUNaTnJa?=
 =?utf-8?B?QnplSkUvcVBYTlkzVHFVNGJxRGM4Sm5uYW0rUWRjSDNsb2JIS2JvVDZ3L0tJ?=
 =?utf-8?B?RlpreW12ZEN2RytBelYzandCbTFEUXNWRFR5M1J3Rm9aKytlZjRza0xEd1Zj?=
 =?utf-8?B?T1JjVHdoOVUzTU5Ic3Q2TlcwUjMyZUJ1M3EyUzZrcVZadEFiRTgvWldicmJ2?=
 =?utf-8?B?UEswaFFtY0xNN1ROWXF4MWRNVjZVQzF3TDhmblc4OHVpVG5TbG5STUVCaXFp?=
 =?utf-8?B?VEZ2bGhaK0s1TUdhanErRVBsQ0dMZ1VlUlhKQVUvdVowa3YyeWNKdExMV3Iw?=
 =?utf-8?B?WlRLRWFrL2U2THpBRmlUK2hRRWNtOXhIZjVrUmk3eThqNGJYVC92aStaQjU0?=
 =?utf-8?B?WjU2bk5mOEY0cW9YeFByUDBlZnNzeHg5anpuS2lCcEdQTW9NRTBDUW1OQ1o3?=
 =?utf-8?B?bWEwM0tXRng2Mkp4N2FzaGFTNGN3VWlsWTh3clVySldJNXZOaTU3OXVBNFVh?=
 =?utf-8?B?SjlxaXFqa2IvWGFjbWk0RnZJblRYZUxhUDB3aXg0SzNCQ3ZTR0JKQWlkODZ6?=
 =?utf-8?B?Qkhpa2VyTWc3QVJycW5xb29nOVZiRHVZS1R1MzhyWUR5Z052cnVOeDhtZ2tw?=
 =?utf-8?B?emNRUk4za2ZjY21JeUNFTjVMVXAvUHcrTHRoNlVwMkwzNDQ4SjhTRDhQNXp5?=
 =?utf-8?B?RlVPVHZXOGIvM2VydlJndk1LVXQraVgrc0pETTBLb3JEeVAvc2M0Z3M5bTNT?=
 =?utf-8?B?UHNYVnBHSE03bFF0OWpyRklqUE0zamdrU0NHdkZ5cjU2dFZFRkdqcytRQWZY?=
 =?utf-8?B?Z2dqalBtazFBTXNTekcxTHV6S0MwWVdhZFVtMklCTmhabEZ6V2NxSVpSeGNK?=
 =?utf-8?B?WFg5REpaOWw1K3l4ckdWQXRlcEJCNFlaNmFFUDQ1UWh1TUkvY29yQlRDNktI?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QDh4sgFWrV6H4eA68G6sdM6N+tUAFUUFBiOdcyG11Jb1/qh+p0NuPqZ9mgIbX45yrsitwQKSt6LudJZjUAcuw5sSMfRi4aI0PaJ+TRasD10PD8Z5/hUmpMd6NH8MXXQvqjG/C9daYUzIHPApOAFbelMPZRvzHVYJ7XLxdFP0J4ZG6q7BGEbjkIa+lfLtFzXOg/r4eBxostjyg9h/6Giu1vt88/e4GqkYkHDJxY1y2YbhMMDAsABq0EDG3Is7I7U6BZYNWbAS32SppeQFNzWqCiDYm+GuW9HMjHD/H9ss6Ds+spQJ67SWAijfd0hDyufkE2spuiIlXpHNi1XeppJOCII9ytylzeLW3uxGk0ImgljKgVLqeId6+QuUY1s/oIEgpxW694FhAQ3/L4eCKTiSSZcFTVVrNOqVPbgga6GQNcE9RdS2yDrscQIa1DUTo7Wm88NFtWlEgQlhC2sFAJS7lc3NR7gVb1aMgjZMJdMvSeSZA2vuK3uoSI3RWzF3cJy6j5z4CAG8ttrSc0jPBcrZMNi5W1DX8DppuUyOBgVTOpM2cK1HttOdUN9rmj3zNQouzwMGxtm2rPFDa5lQCiDxZYrEO7cjIKT+qtZ3Y4Tmdt4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f525f-de59-4425-a264-08dce4817403
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:33:03.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzmAwbcIE++t8wrNodVrDBuSAAKT9rCjffhdX92lzJXsCB2o1lGHPjOLOeA5yHil0/pfArsF0uQkk+KlrqKiDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040101
X-Proofpoint-GUID: k1i8-br-3HfcB7D4Kr_xXYcBl7-K9Yrr
X-Proofpoint-ORIG-GUID: k1i8-br-3HfcB7D4Kr_xXYcBl7-K9Yrr

On 04/10/2024 15:10, SurajSonawane2415 wrote:
> Explaination of how bio could be used uninitialized in this function:
> 
> In the function blk_rq_prep_clone, the variable bio is declared but can remain uninitialized
> if the allocation with bio_alloc_clone fails. This can lead to undefined behavior when the
> function attempts to free bio in the error handling section using bio_put(bio).
> By initializing bio to NULL at declaration, we ensure that the cleanup code will only
> interact with bio if it has been successfully allocated.
> 
>

What about if rq_src->bio is NULL for blk_rq_prep_clone() -> 
__rq_for_each_bio(,rq_src):

#define __rq_for_each_bio(_bio, rq)	\
	if ((rq->bio))			\
		for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)

Then I don't think bio it get init'ed. Whether this is possible 
(rq_src->bio is NULL) is another question.
