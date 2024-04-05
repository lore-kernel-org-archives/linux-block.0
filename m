Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694CB16EC1B
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330027; cv=fail; b=ftJgJZVj2KXiDQ29Jw8I1HmJ8JWxg4ZeffyCTFaEtA6GLbflmVFi3PEiLpQjvuPLKHM5XNYiFBGmhYcA+EibTCPLHe4sWMO4zBnOAeiFSP7rlEpq+Mi8TL8KgQSrZ7VuSR/xCn++CpAPJ4JMaYQFnHSIer5bpt7AaiNtcl/aZ3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330027; c=relaxed/simple;
	bh=SL6Q4So9wawRCalV0oQBG6lrVV/qqECnItIDVpPpiRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQqAxCAef0LK/2928WTRXbn9KxIN9Ky56f9OLI3ZWbGgdfkg1PA1/M2pTeQ1XY3wO1qw30hHY8TguC6wuNfmzsUXjVo9zF08YIDrpQI8/FkVWZue05h7MMHt6zYD5RC7vzGiI8KU1+ncwEZbntSzZklj49VJRZoYcVxTl0K7xZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K/pcNcX7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kzS2Zrkc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/pcNcX7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kzS2Zrkc"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435F3b0W009236;
	Fri, 5 Apr 2024 15:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RZWeAqMYkgcyJ3q4WwW/Hts2s77Jrej9D8LJO0Oof/E=;
 b=K/pcNcX7sEz4FOJJU4noxYvHQ15b04WFfHdeOJYBPTtlqae/m3o13CvW8pirFtUhD0bp
 1aHlDjAGTJ3NpJP/OPFn8QDBITksmGAItFZjrE9dfu4yhtSRzVD6ymjgfJBSSbaUqpn5
 /LmTDhuFlM2CmLylRTg24rEvxRzEckuuVaDtZMFOS6o4Mz69Iar552bU3M3LGik87Gtl
 9v1wqFo32UG8ZhlAn08QZDpFpqbszWKGioqp8GKFYvCLr+K7GBpeHB0FbRt81NuktGpO
 m1AMU4GbXK5Dhi8wxfHqIOyxFSqMRUjXF7YZLklol6dizomef42OyuKgJ2mFv3XJss7a vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emtks8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 15:13:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435Es2MM024299;
	Fri, 5 Apr 2024 15:13:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emp87ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 15:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkVgiV/Acc/yWwTjDVIaoU6Zvs4bGTHSKj9bj5c1a2iNXY/KZXEHc2XxYVPzeI1ClxTQEotpp6anAbGEeTOcGxghFXcnBzM0XQkOdSR1vFqDeLHui6myJCx5wep96DGzoKr3bY7U2EU6hHkPZ8MdDF7ukGMGJXHkgZh4rfEQii4gEuQCDCm3F1eeM+31ubsO7UqydK1uBpNxghIAxqTBdYwffPxiFDwswuhe5JUV7L6xP6wK6nwDLDMbMmH5z3wMQcEiTAWaRGrMJnrLIMF/IxG98zFpxkIG4VOgzXa6WEUSB2sY0DvERfMzjX4e+/Pw1sSNmMkRkeDzEYQpvQjboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZWeAqMYkgcyJ3q4WwW/Hts2s77Jrej9D8LJO0Oof/E=;
 b=JHjYzrpxXsaxiV4hvo04dVfv0jKaGAC/exm6R90t1NOjBOfB9xvAvv1b/PH5pbtdsEB+fvR4twceX2oCbADPzOjGKdHxTsdDNWlNPpcOFZF5wA9gcwlRVNUX9r4DzPQ3kWD14lmD2dE+YE+8OsZ1Fi+NPfBeS/TICosHF8AExHUAqb9z+asQCQ+v0Gky5IYcBlAcjwH2N1szcb1G8xjwIxiZwiqXeg880sBN9OypR5ViSvfORoq+JfN3c2BjrXa9kpUUVmNjqrEIEwC/bCa1IXauOz2GsrVayjel7uamrtG/iawFWDBybkPX4bG0uP8r7CJzoPOWcg3YqkjyJ+F8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZWeAqMYkgcyJ3q4WwW/Hts2s77Jrej9D8LJO0Oof/E=;
 b=kzS2Zrkc4c8mTXYtHZKnX+PtHqmh9xDeSN/VCSjJEgB82vE3qt4Xwd6XzcwGaJZEaUrFuJNeucay2OspbX912uUXr4HW/VlZeXYyBWwN3xJRXxkNoo/F3xR3J5dPDxy4y4pke9dMT4XwfLWXo0mEUccNh/isV3Xg2hlDvsQiuis=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 15:13:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 15:13:30 +0000
Message-ID: <b311516f-d8f7-4f6d-af76-adfe11ed0e22@oracle.com>
Date: Fri, 5 Apr 2024 16:13:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240405143856.GA6008@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4584:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dyfSaTRYp6yzMKcobjBA1z2KE4nn1uVbQwO64nJlAnODhHVQDJrGDDCLgy+nE9sRvprKRbXjvh8EGeu/fk98kvUpCmvfPHz8mSqHTH+CQCzTWdxAJovc2H53Rg6atdPJWQYHK6GCkQrwFwUvbDZvQP1exFcPlvzwZBfqSInhCZSnvu9OpAp89pWS8SgZUbJEqUIr+9MCuAtkI1TgIvWZuWEO+BmSEUateEah/49z0afI81bFyQNaBpwO5wXwdZ//YX6Seg3/QM1tib7xsQC70gYRozpJrKL5bxGpx6F0xTL/icC9aF/K+Ii5fGyia96HEnhUSsbNojVU9S5ruYi/+00iaRSe4QapTx+DklNKjOhueB/wGYs0zSNcwHqOccvwpu17yvYtnpDbtATfT+YHrhVyYZJgqf0SHWYJQnJc4yYa+OhY+XACuN+nbsmssyvvD0B5q0kOVmyKmO4NH9a7kr1ihFBMoOWPRfQFnE8pjieKX+LZH4iXB/OElFXpNywDPVG++NITvUXa1j9cnwDx+7DnCL0k3z3lysDSPjCB5v+LuUuwtmhqdO82CrpDClzQZ/mn2lmLcrV8QUHZ+JJuUD2QzVnZJAWOXAAvTYPiWar2nTx2e4ECs7ScJ9oJt8INa9Lzx+rd8bbdcVKfC8IFuVUFtsB8Ea85tAc4HaB4FPs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDVBVWRZRTM4TXdYbkRNazloeFdDN0Q2ODZuSldkMG8vWjBpSVE5L3kySUN6?=
 =?utf-8?B?dE9sOU1hbjdLR1kyMnNsUWNhQmVYN0g5d0Q2bnp3V1U4cHNyaS9nQ1BRUmYx?=
 =?utf-8?B?Qy9qT29oVE9Rb0tlallnSFl4WTV0YnJoelJsTHBmdkZ2bXBVNDJWT05mRGtp?=
 =?utf-8?B?YWNiRjVGdFlwMks5eUZHM0FOZ0E2aWFBdklDZ3d4WFBJcDdMckZrL21sWSth?=
 =?utf-8?B?ekNWVG92R3lzc29aVjJVRzc2LzcvS1FPWjFESElZWmR1NENCMTBVbi9HNHJN?=
 =?utf-8?B?WmxaTG1UcFY4dXBqMmNacHVESWxlVExuYitONGRCSzR0azh4RUErTWw5VkVZ?=
 =?utf-8?B?M0xaZjJySHc5OFlWNSs4SURMM1hYcUp1Ni9wcFN2SVVqT3QrMmFjMi8yRGtZ?=
 =?utf-8?B?K05QcWFpTStuZWlXNFhyY0hOTWIxdk5PRWpOMGJlVEdYaUNORXM4YlFwSUlR?=
 =?utf-8?B?S1dOc0habnFGelhhd3hoWGR2cFMrbUd4RG1OWCtDWHVVeVg4TDFnSGZPaFZH?=
 =?utf-8?B?eVVMVUo0NUJPaUsxUkJqSU5hZ1FKM3BoL1VJZncrb2ZtNXg0VlpuK2F5YzNQ?=
 =?utf-8?B?RnpWRWV0K0xRQWZ5R3FTOFNnRjR5U2kxeklXQWFscy9welpXalRiM2ZoajlN?=
 =?utf-8?B?Wm1zWVVXTDhFZGsrSXkzLy9WZmdiTWdITkFKaXBQY25xNFBzV0lQQlB2T1kz?=
 =?utf-8?B?cG5oclJWajBNZ0c2MEw4MDZXb1hFNDlFQ2RZYnJrTllhU0ltZy9FK0N6WXlw?=
 =?utf-8?B?K0YzOEI5YUZZVnYzT2ZlS0VjTSs2bWpid3FnYU9lQ3d5eGJQeFZaQkZnRkk0?=
 =?utf-8?B?K3cxaGs0c2FYTmFOV0hiZXVVN3FTb3BJRUhLeTFqNVk3bG1jcTNkL29sTG9k?=
 =?utf-8?B?OWNBWkt1MC9xRkFRSURKMElVNXIzbHUram1qTHNPOTRKYi9zTm1pemtudU1h?=
 =?utf-8?B?bEtuY08wMnBSMkZHTHpxR21pWFBMM1k0SXFtc3hiVFlTbE5aOUx3UHhiODNm?=
 =?utf-8?B?dTlmdWFPMHB4amRaL0VRMFZ1SGRnTUF3TTJYeTRYRGwrNUliVDlKSFFLblJQ?=
 =?utf-8?B?djBqSFppSUpRb21TbzhFcFk5WkhHR2lObzkrbk4xa21uUnBQa2pBTU1HUllo?=
 =?utf-8?B?NHRFNnRFTk1rK1BRdEJlSHFyaE9KaVVUOTF2M21VTm53cFdaSXdYUUtXaUsz?=
 =?utf-8?B?YzV0ZmFhMWZhaFVKaHVXZ0lOVmxkc0JZa2Z6YnhyZXluN1BFQ0tvOUpLb1Nz?=
 =?utf-8?B?Y0xNYnR3Ylhqc3VmY3JZUjF3ZGdtWG4zT2crWWw1SzVtVWlvZDJ1NG9ic2s4?=
 =?utf-8?B?bkpyUkVQMXJrUW1yM1IxMmdPWENSRjNyREFnNVltTzZmL2g4dGs1bVlYNEZt?=
 =?utf-8?B?RWxkL0hlVTlYcDJ5VWpWS2NWWVJVY2M1bEJWUHRjVHc3Z3ZRbm0veWxpUE4y?=
 =?utf-8?B?RUl5dWlGeGc5OEVyam5kK0ZvQkhGalg0NityQXZIbHhLeHkvR0ZMSDZ1Z0RO?=
 =?utf-8?B?Q2ZlRndaRldobk5peU5NcllPcmdpcWR6cW1TMTJZaWIraDN5UDRQZ2FmRy9O?=
 =?utf-8?B?cU56SnovL1JGUmNiVmZ1eGd4U1pBeFczRnNoNDlsYUtDb3hDcjIvV3Nub21l?=
 =?utf-8?B?YUNuT085Rng5VlY4bmFOaENhaUdTUnc3Snh4bXB2UmE2L20xTkZ5cHlRa0pr?=
 =?utf-8?B?YmlMeS9VQTlEVU9LSUlFOFIxclJiNXFWc0htUm9nakRZOHJIWm1WZTRYWmt2?=
 =?utf-8?B?SHBNWTRFN3A1cmRidHExYzNiNklpdjZadEZ5VE1xZFJTaXJLamF0T01CNEtE?=
 =?utf-8?B?QmNNcURYbklRbWJkUk9hYnk4ZnA2L084NlE3Z2tWbDVNaUxQaGZFT1Z4bW5x?=
 =?utf-8?B?YUVOcGwwOHVRY0JsM2pTRDE4eEl5Q281bi9Ra2I2ZVpNbkxzbjc2b3QwR3VD?=
 =?utf-8?B?b2IzbDdhcDNWeTgrckRNQ09UbTNvazFla1p2L2tJZjJmdE0zVDVJdVplRnN1?=
 =?utf-8?B?cFEyYkM4c1hEYmMvUXBDeU1PclBOSE1TWHFPUUVhbVJiRUp2Z3V4dm53M3d4?=
 =?utf-8?B?a0U0OUhad1UyZ1YyQWd0VjRGR1R2cHZCTStVOG10Z2MrcTRFQXZJbmZheXEr?=
 =?utf-8?Q?HX2HeJYVvzGglgmr9avi9punk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IlR3uOY8g4H2WHkWIQSONxVcrA+uFSWhMSaCK1oBPwzaxeT4ZsDktXIZV+Q00nQzQ4skUt9IycRtkDDs0dGRN1ZDf6JIYXaIgKtu1sM0EcGZi/2bther+bf5NmeM9G0N6OK1m3/YcqFWUDgaUAdV7WYQZxZIeOLN9y4lJRSemsfMgQ+7y6F50DIAVHF27r7ySd/P4CcAG/lius4q/pqPg5U4xUYQlPnIzeKVR1eQ6Mv2O2DdJlkyHcv01zYt6IrqEY5jBDOWYt1Jh2FjdAXQX0Vv/14/dseiQK9nhju9xpd4CTFKtsNqIgmJ2V+68ma42H+3fiNf6XuRMBAxLk+chdSrIv2Yoh7qlHzH5M8cmVrqZKXtbwpEHqT4rmNa0Y+KCSDgl0h9Ykw2Lh2vGW4xb7ZXAz/5Ufo0XEnbiT9sbErJIAKtt3Qn8uE11MhRD1ax/fvb7+9VpyJ5HbCKMa2SAjozgWOfaJwiloneThVoGlXG09uRYDOeDAyGDKpHyVLDlvyJkHKVifrG01hf4Fxl9DZ4Ln5wizZQLukRpqEfI6gN2dn9gnvQgatSf0M0uFbu5NbRZ/Ko3758XTJv9J552lglEtOs8wKbJ+23K4RjOGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410be963-0346-456a-227c-08dc5582f3bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 15:13:30.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eJNBuPZaQsJrth36dy4TeQ6ooc/2iZZqpg62N5F9tH3a2aIm3nn9MZpf0JP+8VGoLO16/bWAqQZcMZfX6qTOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050109
X-Proofpoint-GUID: AiatG0Fp_ik-lQ34QX7-ECKMGUf3pmX-
X-Proofpoint-ORIG-GUID: AiatG0Fp_ik-lQ34QX7-ECKMGUf3pmX-

On 05/04/2024 15:38, Christoph Hellwig wrote:
> On Fri, Apr 05, 2024 at 01:31:10PM +0100, John Garry wrote:
>> Anyway, changing the code, below, for sparse when it seems somewhat
>> broken/unreliable may not be the best approach.
> Ok, let's skip this and I'll report a bug to the sparse maintainers
> (unless you want to do that, in which case I'll happily leave it to
> you).

I can look at this issue a bit more and report a bug if I can't find the 
real cause of the problem.


