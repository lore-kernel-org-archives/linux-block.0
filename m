Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC088F5D
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450836; cv=fail; b=BdRl77dq0NoGQNnEuqqEt+glIlaWkYGAqN9tnG59q5o+858o4WTEaZZjSuq4T/5zwKpkbK++evjSRHXiZJcNQdZxYYG6q2u9DHGFgzeHaC/fSryFueGgvzNIcJDvkxUBvB2IqZCRx87j3mGW6nxWIeM0VWNs3EzoBK6xUmopitw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450836; c=relaxed/simple;
	bh=6lJBrSz6MFwNtudp4j/kNuYarkcnhOGBAPh/qQQmcq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P4d7pyiSqulxrOVdbBQFR64ZXl8K+fXDA0940Bl8Uh8FEdiOrzR1TwDtW7e8mLaixWTt+TNl62DngtmIoHZ4cuVfRbknIEyMzGCX/e7lSy31lfDuY1V2BJ228jFcY/WS+UVpdiurUm4H7Y5e27WA3tJ/Az56RgxWbZX2G6RXMzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+dzWq8n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NVaOEhrw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+dzWq8n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NVaOEhrw"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEeKpt004445;
	Tue, 20 Feb 2024 17:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7k+ibctaTlDMZ4JXWwJ3ElN59Z9q5NZ4T741EXxs48I=;
 b=l+dzWq8nXqRPQyTLM9gejmfpqMZToEhlTCWqarhqVkkdZiRe0Mji5WWxmig/Ukgpcm3j
 NSC5W0pF7gGhhGPh7xh9kve+qMqQc8sLIB8wYIXAMJMrOvIj1RjR8vwHxDlqwY7I880C
 SchmDbQd6gDVbGFN7m0kTHYNePkvuDqDAUrCsmX+iA7GFBw8+4D7YsQMFi10473ppLVU
 YXUt54X+gl+ctBAT1l9BjkD46ikOB3EujAtJOP/JpbmLBNnwxWszNzl9cpkSje0zBrju
 LtbYAtn9mk5+rDO+VugBkufJh46/0OdFIh6SW8J70kp9rEnxQhHJXX/izgMbyhb/5F3K tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc7fgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 17:40:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KHZhT7038067;
	Tue, 20 Feb 2024 17:40:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87kvcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 17:40:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNxRnPvwCTCEpdZ2x8mN41PbNVaOdFqsHi7PkS+B4i9+O/aS7/qIN14yzYneyVhjlZo4w3uMMCxqEPkLlhyQt/x7u9wm9yhpvaBQWZpgVATLR2ZdutppJthEXxDS2NJaVzNWyENH87trhzodcsva2Wsp9jECimO/CyQ5PUlKq8J8d5MXoTs1ytxK0SP+70RaN5gE4ZzCpcjMohYm2D2l0THPkJ3Yd+RRrYGZeIJjYv0Gz8LaZ8y11yEYAxCzWXlHJWlrJCFfPbxDxto3bx4ZWqFv4T3lxKhaY/rHLWKF6DxMUFvbqB2M73b0q9ukbtB0hfxE7x45v1zWRH7Yv2W2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k+ibctaTlDMZ4JXWwJ3ElN59Z9q5NZ4T741EXxs48I=;
 b=e4QbkUxL04VpCr8MpFUs8pssQuCy9lsuIg2yok/sTqx5iPTqUUNRitdtnpAyrBQlh3ppMqRe5RygXFfKpNO5pTn7lYrgAQzIcDoJGt7GWIzuMjYb6hY6+SYTGF8QUGNzI36pS8+qLaVg07Kh5u4/bz41oszmXyVWjypN98M2apllxECd19OwsuTcjbuV0zqv7tQo+EE49OKbLydcT24ylsoe9JZk3+o6ajQVw05uOMfj9NIQs84mZ8DE7abQiZLzRrsl1uRHIJ1Jx1OvN86JSbuPc8AWV8Dv7LdYn0yGSLOtVX8uB6JXaFz13nJFOE9UZWfTXCy4IT4pAh28xCGTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k+ibctaTlDMZ4JXWwJ3ElN59Z9q5NZ4T741EXxs48I=;
 b=NVaOEhrwOJgq5uZhwFBy+BFN7xRKUFA84LDQLSNOtldpKyI562aDr7a0abz1aJob/bUS4Yw1z6fXIH+woNAzP4O0GliggUNBnWuSpKSrHwq4X4vhOSUDzrAPbomDN61itlZA9Mc2ut2U89JSUPzpxQoGn3hENHkv12Rn2f0QvFM=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 17:40:28 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 17:40:28 +0000
Message-ID: <694fa4b0-452a-4c40-99df-350eb6862b27@oracle.com>
Date: Tue, 20 Feb 2024 09:40:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240216233053.2795930-1-alan.adamson@oracle.com>
 <ja3ocox727qncqiyf3z5xvbg4a7h5jjr5w7rwqekixqf53dutp@i4h4pllexdyi>
From: alan.adamson@oracle.com
In-Reply-To: <ja3ocox727qncqiyf3z5xvbg4a7h5jjr5w7rwqekixqf53dutp@i4h4pllexdyi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DS7PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: adcd55c4-d99c-422d-29b5-08dc323b06cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/xVWQhw0PsebpvGa+IR9Db17VlSCGm3kx5X/sBs5Fl8jBKqnUxq+ad8NqIwqkWufNzzbvtKIAlmj1fE006KMv1C39kbunxw8QmhIdleZk4P7EGhxEv3ZcWwODdvZLOhcxZdfovjY5o351lIDBYtghXf/lTFioAffVCfk7oVGgjuVyBdGDyPALYdvx8jTcqV2EPdDuVbxfm79GwoeSV4c7hgnYBdRBKIAx7GXvF/MbEtTHwc32Ce+Z9Ehw7XzCLHRt2YmBgGp2s+IhfOJO8ijJ04q4c4GTlDx8a4nd8L/ZkfZvFPXyLjp1niZ0+LbQn1LjxZ0SbQygFFbncF3cy9sLj9QkZQVblk1DGAqLNv1dnS4pybSYHVTdOsxkx1lkP24cPykRBirrvVe3ZlSjaXwrUfci2FqYesY6fYOAMu97rnZUEtSQZm5bNG3UGz5DwJ3Nh8x1nqjOMMggpMqN1SHFMJyo9xphRsbLsS9Pr23gHobyjmRpOlJGBe7OtcIqTy6NvODNwFiWo/LyXRtDF4tMpa6n69Qfnu6qYQCuWcrrpw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djZTQ3RtQWhNT2ltNTVORGpiN3NmTnZFU0dNbEN1Sm9Bb3N5Z1VlVHM4emRk?=
 =?utf-8?B?NngvRGlkTFdmU3ZJdWY4azVWbzMremtNcnFsMW9BM0lmdHE4QmdXcnQycS9N?=
 =?utf-8?B?bHl3ZGwvQkREUnlnT3d4TFkxSlVkRy9RZm13MzZiVWxGNGo0dzRmbXVmbVpK?=
 =?utf-8?B?SE8wc3ZwRDRnMDlmN2NUaWovT3BKNWUyWnVBTGZuUHp2ZmNKUkcrc0IyRmdW?=
 =?utf-8?B?LzNlUlk5WU83U2hNS0k1Si9TR2hlYzdpaWh2NElFTEhnakJla0hGL1VnTXBt?=
 =?utf-8?B?Y3RtV29XR0FsZWV3V2xrN3BkZU5LeW1tWFVRY01NdXFYOXBOZlFCVldTd29q?=
 =?utf-8?B?VzdnVGhkWHE3YVJCOEx5VkxXbmRnZTFmZnFNQ29KNVpYR1luZVY1VEx6SUpo?=
 =?utf-8?B?YlJqdWdMV2ptRG0vRkxqd003WG41MndWQktlVUdHNkYxcFlWV2h6aXFmUVBW?=
 =?utf-8?B?ZzF2YzdxMkNKbVBxS2VzWXlSbElJellXS2owVGlVYU1weXRYWFVjbG1QdjVx?=
 =?utf-8?B?YWdXM3pnbHBjeFVENWVENlptTWhscDhadXRtemhZekpTamhxMnB0TGUzVm9q?=
 =?utf-8?B?Yk5COGMxdEVWRWltQ0FGWmp0Uy9FdHBvNEc3dEMrWFkyRHRWd2k4QkMxN0s5?=
 =?utf-8?B?NmNlcEsxanRDdmFzUHBHbjdTbmU2WU5JekRsTC9TaUJZcWVsdTFxcldkNWFz?=
 =?utf-8?B?eVNYT1Q1Z3AwaDMwWDFBQklCMXdOSnZOMG1WaE5IVkFvMVBjT0ZhbDJNOVBT?=
 =?utf-8?B?UWovOGNHZGRBaDdSMUNId3hnckdyc205a2szMUZHOFVrUHhtcE1sY0dHdURR?=
 =?utf-8?B?L0xJNlNReFJEeEpxblR5MlIrVWVwbXhlSDNuRjNrSEY4MXdBTk50UUZMN1Qx?=
 =?utf-8?B?djBTSXdFWjdldi8xWk00VFpqTGljMGYxMDg5d09qSWg2SlNGTm9UWTlReGNR?=
 =?utf-8?B?QURldVlRbUtFd0ptdmxncHdHcFI1cWFZWkwxaGp3Y0hpKzhWOWZZK05XeC8w?=
 =?utf-8?B?RUZ3WGZzR3ljTERPd0ZQMVJNV3BrMy91eHFoNjNxamVLQjUyRURRc2RwNUh0?=
 =?utf-8?B?ekNRdTdoQWc1bXdpOU5qeE1tbVRUb3NhUk1GbkpyVjh4Tm01TlovNXovekhV?=
 =?utf-8?B?NnZBVzlyRlpUWDhkUmE2ZmZaS1AyTi84Y3gxc255R1V3UzFwckdONXpxNlhV?=
 =?utf-8?B?VUxtdmFnZ1pWMHR1UW1EaEpYSFd0c0hjaUVGY3BvYzF4UGlYdjAzR0FlWmJI?=
 =?utf-8?B?cXNrNEM1a1dIZWduNkdPcHRZNDROaGtHQjVwc1FiZVZWWUdtUG5zNDgzTkFR?=
 =?utf-8?B?VEdpbHY2emxucE1YWncrd0RSUmVmSEdIVXNrV0lNR0ZLUllXU0toT0dhNjJN?=
 =?utf-8?B?MGpGc1p0OEpwYno5TlhQWU1PV1RGMmxxdXdNSEFIazYxZGlVbENUSHhuVTBO?=
 =?utf-8?B?Tkd5bDRsaFRnL1RaSFBOa09vTFA0cW1kS0pObnA3UGEvM2x3amlOMENwZWVR?=
 =?utf-8?B?SFlNVlpIS2hDQTFkaE5aTjBZN0ZKSXFUU245N0J1NExnaGUycGRlMFFwK2hq?=
 =?utf-8?B?d084TGZTKzlKUnhnUFZyR0NzUWZrT3F2RnpaV3dKZkNtL1VDS1lhcWlKK0Rz?=
 =?utf-8?B?VEpGTHNYYksreVJRdmRTOUgvOVNYdXpyZitaeFl4ZWdwMHpGSm5HTFo3RCtx?=
 =?utf-8?B?YUkyemZyNkpRam1uNXZURlIzbE0zOVU2cyt3enp0RWJPRUNFSkNvRkZWbEdp?=
 =?utf-8?B?aW9CNEdkcnMxZGZDM0c0OTBVcUtVTHNvSDhhaXlHUmNjWkhEUTB0NTRBSmNY?=
 =?utf-8?B?cjJ5RVlzU1kzWFc5cFJOUkpLQXE0K0MwYkc2L0FET0VCU3JHSjRpVkhFRTlT?=
 =?utf-8?B?SjFtQlhWNjhYRmVTbVVVcFFRNHAxanhUOEJqdjhNc1JBZTNXbDVoWm91K1Zz?=
 =?utf-8?B?RDlvS1puWVVNY3dqTlpNZUsrRCtyTStTNHUydVZaQTFMNHNqUFZ6RzZUMVMw?=
 =?utf-8?B?S1BxTXN0QmNDL1hlVHBTaVlrUEJBUER2R1M0SG4zV3l4VDVBOWpETWcwKzRL?=
 =?utf-8?B?bVE4OXR1THNWOGpoOTdPaExsN1R0anVRWlpSd3ptL0FKZ0dsNTBQZTVUSGJi?=
 =?utf-8?Q?8bStIvleYhcYp0rMD7WK5uCxk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7cZHHI4Bk1sPH6RwWPvZ31D66GbIFNJZEVxE2vEDcfL+K7sTqoVkZiD2SIWR2/o/CMmrOsC7mE9JSU/XrBRsSBiZUE0itWbKxZETTE/+/w1Y2pGRLOA5ze+cUWdimREK1RZmifScBD1CRBYKkh+KoXtKzSanj/u0VrMEcMKpSoMDgLLI9LsqRACKGGVNPrzwJVDHlnEf9UIn7RoIeH2x32ZIQqhUNLIN5RiembKi3iXCcCEHyEZcFUmw/oikJgTIBfvbjrYSwJSOU8l6N7kXFjnT4rr2x6tHyncE3NRaut02DopKFB/yXNcpNPRK9c1IUtn6H8acYWsZKS0IRqN0qyFA+87X0gDiZFdknrFZAABl8FGdEsqciZzJfpH/u/eXEmEbjbICgzjI1jdr7KOZXeAH8jUlAFXp0MtyLFySFb6V/XgaS8vnvpa4mccCSIxkLVfMrzCxBE9fctq91S7XiyLcGM6QnouowQj0EtE8Oj8NKGL/aAfh0tjhtUmcJfrWeKgyomXXbVMig5kMsc59M5UKo86gWzlnrQDeL3CZ5KDdn8UFyf4M95T2MaR54mzziM7P9O2ToqFroafyryuqTAGMQMp6bT+c4VYJ7wkOOiA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcd55c4-d99c-422d-29b5-08dc323b06cd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:40:27.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2p0oO+sP2y9YQJyQ/Hy4LePaETyca0EWw7gx3TpEAvg2jhBPCve3FOzbBcvtTmfYt5gooJuMPUFChTFoh25rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200127
X-Proofpoint-GUID: UFP66eeXA4Fu9NVOknL1ANB0Njuvm6cx
X-Proofpoint-ORIG-GUID: UFP66eeXA4Fu9NVOknL1ANB0Njuvm6cx

> I also ran nvme/039 on the kernel v6.7 and observed a different failure symptom
> below. Old kernels do not have the sysfs attribute passthru_err_log_enabled,
> hence the failure.
>
> ---------------------------------------------------------------------
> nvme/039 => nvme0n1 (test error logging)                     [failed]
>      runtime  5.570s  ...  5.308s
>      --- tests/nvme/039.out      2024-02-19 15:59:12.143488379 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2024-02-19 16:23:02.669330853 +0900
>      @@ -1,7 +1,15 @@
>       Running nvme/039
>      +cat: /sys/class/nvme/nvme0/passthru_err_log_enabled: No such file or directory
>      +cat: /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled: No such file or directory
>      +tests/nvme/rc: line 1017: /sys/class/nvme/nvme0/passthru_err_log_enabled: Permission denied
>      +tests/nvme/rc: line 1022: /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled: Permission denied
>        Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
>        Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>      ...
>      (Run 'diff -u tests/nvme/039.out /home/shpin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad' to see the entire diff)
> ---------------------------------------------------------------------
>
> Then the added tests should be executed only when the kernel has the sysfs
> attribute. If such control is introduced in the test case, the output of the
> test case will have variations and can not be compared with static 039.out
> file. Check for the added tests must be done by the test case in a different
> way.
>
> Another idea is to create another test case dedicated for the added tests.
> It will allow comparison with static out file. It also allow to use
> _require_test_dev_sysfs() helper function in device_requires() to check the
> sysfs attribute (ref: block/005). On the other hand, this approach will need to
> move more functions from nvme/039 to nvme/rc.
>
> Which way looks the better for you?

I would prefer to keep all the error logging tests within 039. I'll need 
to fake out the new test output if it is a pre-6.8 kernel.

Thanks,

Alan


