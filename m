Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324D101E3
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248186; cv=fail; b=WfYY99EjZZswvfSBTNOBBTpZzTGPtDNjRFnaGVS+KqF+uRatILvN3Ru/P1L8Cq70DOahwjkbYuynS5jeMdbBQKFhIAv+YbmspGEb5XfAOE4wxLL5RTW2eCERjw10a/fpbC6SK3BkyEuZhYtG6EEcycN5gI4SwIVyPZleoadi7L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248186; c=relaxed/simple;
	bh=+dgxAGTA4EbjFQL1Vz37/MdIl+PBRzR4pOdkboMfmrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bjKCyxYwpubhmp7HP5tSm8OW4UkylhFjikP8Gyh6Mn0db4Tfn/RjU95uStVOrLfO3eaHbmK/MiBBJeFodFdEOZgqJ7x7HeukjCV2QMrhkaojikRFc/xSjIEyqXt3HdENRii7ujA864J9Z+Melf7aclCJfZF0eV6EYkP7ZgGB1vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LWgfrZP9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VxFZv9Iv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWgfrZP9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VxFZv9Iv"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4499jWxh022961;
	Thu, 9 May 2024 09:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=H5p/qhnq7jAiaPQwCgdzdWFC2apEz8lttV9t7/1oCos=;
 b=LWgfrZP9AgjicvV9FDqzPV4gf28MEVV0pPnX4O6EYc7cWiuNbZGBWRY3NAy9WCbm2jBE
 93GQ6RER0Fs9qFP4Ry2Iv26NKHVh8+CjnLxPtfsPVnHk520ZWdG9yDpDBuWWNKOHkmr3
 Obj6BZLzT0J/2yA+gQIWcRJIGztVX4tJGziMjoYSy08254PPufwKqY/LvwwK6uOlvkq0
 T9IcpKs2/wFhesblwO+CNDM0I3CqOayU+VYVpn8q5Ko3ggnOk1oARDVtvcfEt0KA/ZJz
 gwRScxmB7U2frVB1ogtYwPFzEQsEn1WnQEtM8af+LWjq10+eJl4mnYuiJb8Y1XpOw/Nf ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0usv019r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 09:49:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4498Ucxn019733;
	Thu, 9 May 2024 09:49:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfmvu01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 09:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO1NB1vlCSy34iiytAk9QMh47ZYEZk/5dxXVpYMtD0eoG1D4LJ0NpUONvdihqZSZsKOKHypcCCcrx72E9+rwLfQscjKV3wxB0GAuo8iwocv1U5vFny2X14BgwJVzdJYTdiD2Fnsk8P2rAWYU/Mc7ahlbfNjcYfyCwcOIfizJo6aCiKdNeJoDO/sh6atiQ2ambSFVkeQsRKHjcJ1OunCaKiZ2x6Nyx8e852GMIG4vH9FFKfYfwsFbNdXedSzi2qqmZ9UCC58rIr9goZVT6AlxZnojjr9rGTRzdBpLgd+5OAzkXJHnVwEJ/zj/sPo+F810OW3mNVV8yWZ2EH66EGAK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5p/qhnq7jAiaPQwCgdzdWFC2apEz8lttV9t7/1oCos=;
 b=SoYNEmDDSJ+UMHtmL/aoe++0uOkfGRVjbI43eTdj7p9SZaMozFJCoxUxsIKbaAg87Rl5hyVDEIIvtkIWJB794mJCQCp0XSNIGVEiAhmfus3espTx+KBqOVajxUbqWzr9tck/sOFG9Kej9PhzZYxKACjwvqKt/zW2MmROCQspj/xixNXPURTnlkoRO16zZ8pvTiWeQEeKIv8Gew16iAZNScc2Mbk3T+uwqI+j63WtYPXNw/5JJOtj9zYhfg1TTTxSq3wSyDSvCSaVJ04glRmn0x1/jj/bz58xpic2FX3GIW614KdNEQOWZtPBbjLAk1lEqWiXjN6VhkrRQjdF1GM+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5p/qhnq7jAiaPQwCgdzdWFC2apEz8lttV9t7/1oCos=;
 b=VxFZv9IvrCdq1KjyAzFK58eoYOYonpX3oYSz+di3UB554O3AVKrS2MMdee8CxtMq2uSpTp3EoyeCvHLGbFr5YeLdY/17ySMu/dt8/wAQ0QWt/Ql1pnmeAjF0V1r/9plEZf4oAGwbr5NTXrjBq9+tuEf3sXXE7nAmCc2fsp5hAXg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 09:49:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 09:49:37 +0000
Message-ID: <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
Date: Thu, 9 May 2024 10:49:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
 <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
 <20240405171330.GA16914@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240405171330.GA16914@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 207fffbd-addf-4ae7-9f78-08dc700d5660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MWZRdmFGWmhSYS9DRkJaSk9qQnVOL0RlSEZ1WVRKWE5TS3lZVjlwbUVxUWFz?=
 =?utf-8?B?cTBab2JlbmtQejMwNUFWdFhzTkZvZTlOWEQwWmVMbEIyVE9QYVJCUWxLRmhL?=
 =?utf-8?B?U2ZEU2x2QlRFNFRJN1RXUERpNk5SSDBKUml1U2ZJRFJRWENZU2hSdlUwSWpm?=
 =?utf-8?B?UlFWa3FlbHBWdXF2VmxSa2kzUGlLd2QvcU9ZOHAwRm9WbER1QjA1NlN0c3FB?=
 =?utf-8?B?c1Jxa25lZE1SMy9pdlNOL3kyU2ZMKyt1NmtBOS93STNlYVZUWXJWaEZmN0VF?=
 =?utf-8?B?R2hPNjhad1hHUFBsVys4aEIvWHk3YWVQK0xQUk03VVN4OHNaK3E0K1ZCK0xD?=
 =?utf-8?B?SjhmSWFwTElEUFkyb2NvYlo1eS8zZ1RxdmVteURnVEZIaytsYVkzaThta3Zh?=
 =?utf-8?B?RHl3N25LQzUxWG95Zm42aURHaVJmMzZNMVdXRkxDQmhUQnFDT0Q1TVRmVENK?=
 =?utf-8?B?NWJmU3U1N3NRWWVKQ2U0SjVSTWd5bndDRytpR25TY3RFQ2doNXlVZDQ1Kzcw?=
 =?utf-8?B?SHZ0T09HRDFweXNiWlE3a2pXY2JSZ2pYQzdzYU5zTGI5S080TzhpUGVqcFc5?=
 =?utf-8?B?aHNMK2U2MkhFdzlHS3YxdXdyZTZhL0hVOVNtSHZGbCtRVjhrZmE0TStham9W?=
 =?utf-8?B?OFVtbFY3anJDS29KY1lVanhlanRKbWpiZStRUUpobmN0NDVsZzJuQSt0d2Iz?=
 =?utf-8?B?ck1vTVZhZnhTRU5CZXJ3YmZzMzk2U0lpMkZHOTllWEdveGFHRFpSNHlOYmIw?=
 =?utf-8?B?bFp6NlF1dFlkNlRKejVrRVlpenpRcUhENnQ4T09kQUhlRFo4TC9jOEszWGhI?=
 =?utf-8?B?Q0JhMW5BM09pRUh6R1JpVU5URGFXVS9mTmNsNUhrdlR6MElzL0NRSTBSTmVG?=
 =?utf-8?B?QnYyMWMxSWtHVnkxdCtxemRDMlFudW5zL2VlTEhFbG5LYnJDd0RQUHlFdlNX?=
 =?utf-8?B?M1Nvdy8xdVg0c1V5dk9DUTRpcjZMbWY0Tmh6QjNwR1FQcGY1REEzQVU4a1h4?=
 =?utf-8?B?U21hZGlwMkFCODQ4Uk92d1ROcTVJWWtHMnkrbHgvb1VLVUx4RDQrN1I1Ym9H?=
 =?utf-8?B?alYyazdqUWp1ZHFrUkg2WU81eXhBSTJXblcwaVZtSFdlYU9wWDNhb0ducnRO?=
 =?utf-8?B?aDdDWTlZVm5abmQzb1Z1d1puOGo0RjhOb0JOVGxpRmZtVkFNd1UyeFJvRTd4?=
 =?utf-8?B?endUUEdFbUpUWEVpY1RlUlQ2Qlp4d25yUEs5dVZPdFJmaE5uVlN0RndrVEEz?=
 =?utf-8?B?ckFZQ3NwSERxZkNENW4rbkdoM1FpQllKeElSSFltUUt1TW9CUDRmd1hnYTI2?=
 =?utf-8?B?Z2p6VjNsclVZUVZVSDQ4cjF1Mmt4Ynl6RndBRVJidmRTNExmQTlhcmFXRTdV?=
 =?utf-8?B?bXdPRWVpL1lScW9QMWZabno2N2VIWTlnWkxpOHVSNjVpaFdhZFFmRWNqeTl5?=
 =?utf-8?B?Rzd4dkFUYmdQUmFqN3N3VjVKcEdnT2kvWlFGVVlUdmdad1lWajVFUjd4U2dZ?=
 =?utf-8?B?QzFJZkMyN1crVkVDOEQwNHAzZ2U4VDAvTUFMTStaeEtHT0hTOHJWZlVGQTA1?=
 =?utf-8?B?RkQ3Z3dKQk1ZaFR6Q3dUUVYzMmRZbm1WMzVqNWIxTlQ2anh5dXJGMU9EOHJ1?=
 =?utf-8?B?ZVRYbVkrU0JUTjJFUVVzNi9sT2R6K1c1djZ4eWQ1YXdFNU1qcHJ3eFdwdDE3?=
 =?utf-8?B?QW0wNDJPNHdCTDNhVFlSUzRmbG14emwwZ0J0bHN4bTdBdE5UL0JYS25nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?citRL3R4aHhoZUdybFdiN0lJSDNMSUpCWnFJeDFYSnRsT2MwTDNyRjlKSmk3?=
 =?utf-8?B?SUpLZWhIQUNrQXdnVVhaT1RmVjVuVFZSeStSTkc1aHJncThCdzdNeHRUVXZ6?=
 =?utf-8?B?SWFvcFdlN2NMK2R0R25CWHJycDdHK1ZCMzBZa2tSNDVuQVd1eVRmMXEzT0kv?=
 =?utf-8?B?cis2WHJISTJ4Y2JTNjJ2MG5oY0ViZG5qanlDZDkzcVBMRTdqZjFjb0FOVklV?=
 =?utf-8?B?Ylo2RjlVaWsyQTVjS1lUcXFIak10SkVDdXhsQnhHVWw1RmVMTC9mRVNBVTB2?=
 =?utf-8?B?TzgxQmw1RGg3RkFSbmNWc1hzNlIrOC9BUDBxU1hIWDFFUE1FdG1GcmtEWXUw?=
 =?utf-8?B?enZ0NWI3QkhHWXhhNUh2M2w3TlpWdktqYStiZWl6UEt3alA5Mnoyc3VKUC84?=
 =?utf-8?B?dmJiUElZTUZUc2gxaFRzaHBpMDBybmFrU2swK1NMTHcyaG1CMlNObjVINitN?=
 =?utf-8?B?dCtwVWdyRE1TU0JHclVXVGlHWFZacytoV2hMa25vSnpzTGovMnRVR1BPVDgv?=
 =?utf-8?B?M2NyM1dzN3lTeVR3aGMzcC9kRW13SStveXJYR3dUb1dCREJEWG9xUEIzOVVX?=
 =?utf-8?B?cVl2SzR0UmluRmY0Y1JrLy9SbGJxNVg5Sitnb2FFY1lmMWZnUnBtSUNGQjh2?=
 =?utf-8?B?SjBPTk5UVFZVZHhWcjNmakRjUkE5Ny9oenZkcEpwTW9qTGVWREE1b2lhOEJw?=
 =?utf-8?B?d0ZERDh4MHVpZG1LNjBRQVVrbE93bE1VVmkvNXpVV3dtK1JxRWQ1NEU5T1J6?=
 =?utf-8?B?bzBtZEVlNTBPNW1tZDA5WmNoUGs4WWFUSUxzcTdNNkJRMXpIdWkwTmdkN1FG?=
 =?utf-8?B?aGx0TUxORWRmVjE3M0NqSll1SmtuYlp5YVZBd21pTUlLcGNNY0Q4bjlGL0lu?=
 =?utf-8?B?RUFSdzYwUmc4ajBGN2w5d01uaDdkQSt1NUI2VmtOTjJhYjVnd3F1Z3hhNlR4?=
 =?utf-8?B?dGlCL1dMelJnU3p0b1piM2FQK2NwcmRibHI1VzM5RmRPL3NsdDBDdkw0b1gx?=
 =?utf-8?B?c3NyWmFqeVhnb2dJejlucUw1MUZqU2JVNjcwODFtTjlQUW95K1RZNmhKbTRU?=
 =?utf-8?B?WCtjQ3ZESUU0akU0UEowUFpYS2pyZDRBZFdQeTFtMmhZcmE4WW1rcURaZkhX?=
 =?utf-8?B?bGwyU2NTc3FrWUthY0U0Q1BvVGx5M2x3dkJpSkEvNzlhT1JUcUVtcGVxWnBa?=
 =?utf-8?B?WlVRZlRFdEZ6Uk5Cei84R0xiTjE0cVJkdllvRllIaStxdFBhMzRzL1p6YlFW?=
 =?utf-8?B?ZGVHSE9tMmJZQUoxWkhCTTJERWtOVWZwUkxwVXhma25mTjJqTDZDZkJyTzUv?=
 =?utf-8?B?dklTTXlNUWhWQnh0SkhjeWpZSjNzVk5HNmtTM1BLcDVCdGFmMnNnQWNpSHdQ?=
 =?utf-8?B?UDRKY3JZWGRoS0VVdUIyTjAwc0twS01QbFZsZS9aZllnamNMNWZsK0ZFTGxU?=
 =?utf-8?B?RGdVcHdDVGp1bDg5L01qV1pBZlR2UFFoTnIwQ2F5aEVKa0NsU2xnNUtxVGVp?=
 =?utf-8?B?dU5KNDVqd3QwbUJmMjQ5MGRuMml6cW1hT2xhdHJIVkM3VEFPQjIxeDRjVE1M?=
 =?utf-8?B?QjZpbnFhRWhGWkVnSHZZbHl4RStHbGw2OHI3aU8yVWxWMFJqWjZlaUZ5cXRs?=
 =?utf-8?B?NExBR1hNOC8rTGFEQStub3hXMEtJU3NsekNCZ1psYmF5L09HcHU3cU5tSWJU?=
 =?utf-8?B?U0V4czJXdnZMS0RrT3NGWS9tdSt4RURiUCtUMDlVdW1wNExFamlHdWtiTFBt?=
 =?utf-8?B?TXVzaWltcTVjdTlGSS96TlVNMDdhQ1RVS1htVGZpVk5VQi9RVm8xaDZnK2Zp?=
 =?utf-8?B?OXZpZWRvZmRIY1pjNlVPa2dVbmR1TmdNeXdqUHZjV0Q4dlBIVjlKMXZSNUFM?=
 =?utf-8?B?ZlhtRjJJb01jOWRpcHNjUlp0SnJRNVhRdUtqRXlXNEN5NE5kL2o0aURDeTkr?=
 =?utf-8?B?VklHYnZCRlB2SDJIcE1lVHhLWVMzZ2xCbUtRTDdacVhxTTVHNFpxaXhNa1VX?=
 =?utf-8?B?eUlydkt3Wm5sRWd3b0Q4ODZvbjJ0T0VHTjlBOVdUNmpFcE5RZ1U4MXVNZlFH?=
 =?utf-8?B?Y3g2aHlXUnZFQTFmMHpTNEZzMFBnNmFIdGRyNHc0K0NKUjdUU092VTN6eTB1?=
 =?utf-8?B?SFA5MjJFc3llWjR0RisySU5IZFFvSnNXTmoyYm1YUlZYYVU4UXZIQ3BkbGth?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CkYUZHpwgO8mvckLg0joWrmK5vmqBf5DVxZX5zAP79Kov07oKBaDBY3tNoP5dOzVRrXzdWu7e/42GubDXILDKpRuJojYrsQLLHUeVEkd64F9/DazVlt/sbvLAqNiyhZEQdyFzil3hjjvIbaO/6ETfgqPr/JQ+GzMPaOyaW9Fy3ysZVOR1Th7tis8Q50lE6TgyRd1tmXF2nx/7Ix7t1AojcqTQmFqJ2xN3PCL7GDDCJHOPhNJdnLCDp/zFNSMz/9px93N+Z9OmNlS5LmDzuIhrJrcK0toqEFYi6obQ0WrKtyVNIifzXZlW3ZU6H3dWBZNpG0RD3kc0czlPQr2M5/6amcr78P1h957wVmJ378uLHfpM7TL8G20KsUsC9m6+Im9Ct4jhwcYjk+S+GVjI7el3ptimq7tWFOWgdRoTEz3zi2Wf7sBx46E+V+LJlZ9Uwyk/26FMdkbA+I2Y49u1aOL84581DHtO5CDMhoa8k18nNGd4NlufZuQLQFWs0OGJapCKrfi8CFUffMuqDAql9Ux6ErBGUuEnb4EKFHTYwrYvlLkFYAtRD8a17Ifaz5lrz2XgqxfRYn3hyo8Tbelj/UvSI9xPvMqTW5WHUuTkcIKSlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207fffbd-addf-4ae7-9f78-08dc700d5660
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:49:37.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDFWOQIqCfPiNYJ0HgO8yDms+iuv+e/S17ou8CkDLfAgYUKJ2J7GSER64Sj3J0qOO5KRAhXtgvLXEYPyMvucxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_05,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=979 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090063
X-Proofpoint-ORIG-GUID: 2OoafPIVy4IPe49Uz8dfgx6g0Tf-JJm7
X-Proofpoint-GUID: 2OoafPIVy4IPe49Uz8dfgx6g0Tf-JJm7

On 05/04/2024 18:13, Christoph Hellwig wrote:
> On Fri, Apr 05, 2024 at 05:43:24PM +0100, John Garry wrote:
>> This actually looks like a kernel issue - that being that the mutex API is
>> not annotated for lock checking.
> 
> Oh.  Yeah, that would explain the weird behavior.
> 
>> I would need to investigate further for any progress in adding that lock
>> checking to the mutex API, but it did not look promising from that
>> patchset. For now I suppose you can either:
>> a. remove current annotation.
> 
> I can send a patch for that.
> 

A reminder on this one.

I can send a patch if you like.

>> b. change to a spinlock - I don't think that anything requiring scheduling
>> is happening when updating the limits, but would need to audit to be sure.
> 
> With SCSI we'll hold it over the new ->device_configure, which must
> be able to sleep.

