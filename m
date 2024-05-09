Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983D158D6D;
	Thu,  9 May 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261475; cv=fail; b=NIxVWt9DP/GzuKuMkl+zIjYjjxagfelb8yQ4OvH1BoP2QVISX6spLDkiCBmzrgTxKC/EePk/t+KGPu7aXdTCB9Ca02lc/Y2iNRUUTIlQMyxUoTyB4996WiOe0ZCxCffvkd3Okt/aaR5iJKUuzO0hgzKjOTfN03S4+IvYqumA+Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261475; c=relaxed/simple;
	bh=6g+NyDFgSsfR41OtSjsnJe101MjlKy1NPG98IJ0+WDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2oKdhI0G0xgRSF7gqflA4zXJ5gg28mlFQEww5RzCiTWOQ+4JHuSDegcVFzeXNAzZDHNjPu7VgmM9wXj9B+nQJ+NoKNKDT3b39lzK0vmxO5dSdn734w72/ttRUsfQvgu5/rmPnkqvOUCKRz7+Xj0MzEpW8edRZH9szsZk8KCB+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K3dr5K/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TrYrG6Af; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K3dr5K/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TrYrG6Af"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449BlDT3024320;
	Thu, 9 May 2024 13:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/47xoXPQ8R3L9rpeNyCv/Izl6J6hV8Hx7M+Ld5VYkYk=;
 b=K3dr5K/GwDifJBns2EqVa1vP7/xnG87AJdrARM8wP/tyvK9MIGXwTaraS7r2s1kFNmjZ
 VwOHbbeb57FETWxwdM2dXsHG33emWN0889a7AcOdRiu/7UcNqhtF8iaLAcZ1iQJET2EX
 JQ9613Nhkgjx/4CyMw+ez7D6GFcgD/Qi3yMDgK/6qOSlFkgPnKk0wOMi9J7Eu1ZmPNba
 dQjlvagObnhUZyueqBSLpjKz6++EilisEEAhhG0dMB9IlIKfHXJTvPea9lr+STY5tYLh
 TUFsecE/GeEkYcwerrxmHB/jV7rmUBRfb1c5MF6YLKcDSCNq/XiCKMMLt5u2sNiOXEU0 BA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0wwtg7bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 13:30:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449CUiRm024276;
	Thu, 9 May 2024 13:29:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpt3m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 13:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC6LtJhCOj3DHzn2gelehDwEWnLZL8qY2h6O1hq1Ea06aZH1Tn6J/zAu1GvwGwTsM1+1J4+9nvfsm1Lv3Y49SecjRnxzn2nKxSGvGBAQgiRJdATQeft6De073FwHO5MuLB8+a/6drkrVVC7YnbKuobPr5mXQpvKHn/Dshcwmo97Rk7m3nZ+0QvltDGgkUs2oOcNo4Wfb6Md4SZPcPrmrSNIow4xeabTDMY/lPJFOkKMez6Ygw1sMK3g8qyLNO0s49HYvOuscqEBRmDHpxhDNx/bQd5qat1HZuG7oxFPG09ZOOP3vR/M6lnMD7pPhtuEZYpce/5uceTNQaKgR7tXv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/47xoXPQ8R3L9rpeNyCv/Izl6J6hV8Hx7M+Ld5VYkYk=;
 b=Y+ybgYckTdyRquGewJ9D+y+eBZR3QcHF4BPXBx0Rq4rKVmRdjG3BNaIxUKPZ1/K6rJcxKVnCWZd46Ok3PRsMRHj+H859LzOoA7NGOqGRYu2rISSU3qGIaJXPMTX7VEZYGnG5rCbckH3AyJYhMSZ65cAwCtU9iuUgRULB33wOJk4ayJcSfsEw6zDk0m2LH6WLi/OJxWZ0RyB0WB4gMYZDpLAd+7aidvbgObtl998gZotaAPUuZd1G59f949H89GVRlXRAnYo7GpwyOQze/NfduLZEyZGJFymZyZwQKf8TMvIQG86cMz9iPqW+/Y7HtWB8CmkS0EF9vqWM2pQQTB0LUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/47xoXPQ8R3L9rpeNyCv/Izl6J6hV8Hx7M+Ld5VYkYk=;
 b=TrYrG6AfW+hJJMazg4kAvzwiyhZJ8RXjztilSCoEu9BKNA0knit7OblCHwA/WDwEYqYEibJtvdHqlDqjlRmYmXnuwaPjYgAo3OX6IlvNvuHq5Oa2HjDLaf8fJjwDSFeCE5+h66onHsqZ0ZScpG+4dMgIqdfg0hUI5QbRsJx8J5g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7392.namprd10.prod.outlook.com (2603:10b6:8:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 13:29:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 13:29:32 +0000
Message-ID: <697ccebb-ffbc-4bb3-81ed-a7fab6f5a679@oracle.com>
Date: Thu, 9 May 2024 14:29:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bdev: make blockdev_mnt static
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>, brauner@kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
References: <20240227081958.89092-1-jiapeng.chong@linux.alibaba.com>
 <2dea08f3-03c8-46aa-af57-45cbd9556df4@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2dea08f3-03c8-46aa-af57-45cbd9556df4@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db8add2-ff3f-4cdf-48c2-08dc702c0f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eVlyNE1Rd3Rpbk1EdXFBdEU5Tmh2RjJ5NGU3U2tITDhSZXlOVTQwZklxd1Ns?=
 =?utf-8?B?ZzUydnRFMkY3dEI2V2Zub2xIQlpxME5rZ0U1THIvdCtBTENZVEJ2QzgzQ0dm?=
 =?utf-8?B?SklEUUNzT0NNS3JMMFQydmh6bWZuOEcrZlZrbkhWcjQwQ1VETEFhU0V6SG9S?=
 =?utf-8?B?SWdSRWdBUkk3dWlrSVhpUm1Ca2ZpM2xva3JsMmtuaUExNnlEa0tXVG95T0M5?=
 =?utf-8?B?dmZTZTRSU1g1R2NTeVFvbzY4NVBQU2pYRGVvblZWTWpTcldjRFYwNWJBTk80?=
 =?utf-8?B?S3FKRkxremR4STFQM1NRemRibndNZU1rLzYyT011L3NFbHlwbTBEbTU5VEE5?=
 =?utf-8?B?QnJib1pJeFEwbGROSWtPaitqaWRUcjdIODlyVENDa2Q0MWhic1VGVHNZTEs1?=
 =?utf-8?B?NHpIL0wzSS9ZYU55RU9YeFJJTVJFcDAwejNzVm4waDRIQ3BlUFdic0F4bVlL?=
 =?utf-8?B?Y3VIUjF5eXVXQ2t6WkZIeG03ZWg3WFNWZWd2M2o2aUNYdTA5YityakxUaDNX?=
 =?utf-8?B?YVJPTjd1NldabVpmMzI2WVhvL1Jnak5QeEVCVExycnZKcnVXOW9KbVhMamo3?=
 =?utf-8?B?L0RLc3B0T05MSS9CcGo0UERWYlJZNUZUSGttakRoa1hwbkJvdGIxYm5JNEVl?=
 =?utf-8?B?cFQzZTZ5elJvSEZRUVhjRHYxdkxXWVAwZkZ5YlBPSXpUd0tTVHcxb2lSS0dX?=
 =?utf-8?B?alhNaHp1MGpLWGxJRi9zaE5OZTJWaXZhMUJPTEgxOWg2QnMxVUcwUzcvV0w0?=
 =?utf-8?B?ZGV4WG5tYlA5RWc2S1ZuN09QeklFUDBvTUROeXdJVDZUcG9aeHkybHpnMUNG?=
 =?utf-8?B?TDlmdFY2VFBBK2VoSjFKdWE4Z1ppNXNqMysycVJaWll6RHBmOHg3VEI5a3Zm?=
 =?utf-8?B?a09IZnJLMXpldFpCTTBack53eXdZZTBQOHlvbmxCQWh2c3J2bnd3UUhjdXh6?=
 =?utf-8?B?U2hqYTNmWTR6R0dMVjlKTFFlZWVyYng3ZDZmbTNKanlERDlqbktmUFE2MU1p?=
 =?utf-8?B?NXhuanNnS29zcTUrSmV0SzQ2bUp5M1dQYTdjakFXYWt6c2xOZHhBMTBsZFlu?=
 =?utf-8?B?RGpucnhkaWtVcFpvSWdXWjFDdy9MS1M0K21Qdzl5TEY3Y3RaQXUzUEZzbkxN?=
 =?utf-8?B?QTFDSHE1Qi9UaHdXTlBOdmNobWYwM1Y2Z1duZEpqOTd0ZGp4Z0ExSmI4UlhE?=
 =?utf-8?B?YkhLOWxReW1uMGZWUFMzQW52SWtRVE9wbkV1ZjR1cGMyVXM0Y3Q1bEFNKzlU?=
 =?utf-8?B?YkZYQjdWQUZHRGZaaDVvNCtIRzZ3R0cwczRoWVIzRTNBSUUycVRuaFI1Tmtn?=
 =?utf-8?B?YmdOYzNLMW96MnY5L3k2amxaWmQ2emhhaVI0dnlwZ0FkS2d4S2ZaZDFybHF2?=
 =?utf-8?B?Q3dXdm01bkdoWmdWMXFMbVJ3ODRxZ0Zob3F5cnIzekcyem05dGNQOGZqazNH?=
 =?utf-8?B?UDBOcGg2T0Jncm5OeVF3eEFCRC9paE1oUHI1Vi9pYmxBdDVKazZTUzhCRUVL?=
 =?utf-8?B?VjBJdElQcitNc2YvU05LSmN5UkJvMnhFRWZXRnVWSGZZVkhnWXVoNWwzQzhm?=
 =?utf-8?B?cUhJNkxmbm1qZmc4dTk4YnYzaW9XY25SSllodmc3MmIyLzhiUkY5SkVPVUla?=
 =?utf-8?B?c0srcWhlODdFNStTVlQ5dE1xTXZZazJmV2tYNERxTUJNQ1Rud01GaDIxQ3NZ?=
 =?utf-8?B?RDdBZndkeko0VkpQWHZjamw0cHFaUHIxYmlwVkRHK2U2WkdYeWdVb1NBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjdvejVKTUs0dlZzeEUweXg0NmttTW55V2ljS1FBVU9PSkFkWGphN09TY1Zh?=
 =?utf-8?B?anZidU8zRXk5bjJwdnE0ZGl2YmUwTW5lWXh2RlRFSnU0MWhYeElGWGQvQ2Zw?=
 =?utf-8?B?cFdkalR4SklrWmVSMU0zQ09vNEZIUlNVdGtoWFlOaHNINkZxWXozeTBQOWhH?=
 =?utf-8?B?TEN4YnpWcFAxcmZtNUNLRkN0Y1pnV0pkc3FGT0QwaEJ4K3NSV2o0dmdoeHhH?=
 =?utf-8?B?NUZjd2FNR1BueWRQTi92cmpiWGJDM3dFaTBHTE1yT0FEUE5landvYXVTZHdD?=
 =?utf-8?B?cGNtZkdUdWVMY0JHcDVqdHZxTnN1Um1LM0NkRDhRMW53L0g1TXVQUk9CMjdS?=
 =?utf-8?B?bnFQSi9OWDVCNWFRckVVb2c2VTM3MUlkeE5qSzZESU9UV2NZY09OVWVrMHFt?=
 =?utf-8?B?MkFuRHVzOGUwc3hHT0hINnJBTzBDZjcvSHBBVXcxTUtIOFV3NVR6b0phM3o4?=
 =?utf-8?B?WWlKb0t1UzkzalpSNmJmQ1pSc1dLS0RDano0TzE2L1VVSUxzNytVaTFSSXFm?=
 =?utf-8?B?UkVWQ1R0SW15YXZEUUpFRWtpUE9PeDV3YzJRTlFPdTdVM24yY3o2cXhPTHZM?=
 =?utf-8?B?ajl0UGdoZ2ZMMXYyWCtzQUNzbS9QZWdORThUTVN3RHJTdGxQbGxaTU5NMG5p?=
 =?utf-8?B?bmo4QldVcHhBcUZnWlk3TWJMZWxoQVRPZEZGU3lXNWVuTjNDTGpwSkVFUzFO?=
 =?utf-8?B?VmdiM0s4YWR2aFZuYWZTYWFhdjRRdHlCa0k4djZuRTBMTUo3SmJwZDdsRVpP?=
 =?utf-8?B?TWZTKzFNbk1BNElBTmQ5QUJwR2t1aUNTV3JWNVVlbmlPVGgxeVZ0bENNT0U5?=
 =?utf-8?B?UHl2OWdTR21FVmU1ZzZOczBrdndRemRZNFdUMW9GQ0RjeHk5c1dMcGlkN09a?=
 =?utf-8?B?amY3ckJaMUU0cVo1ZEtJV056MW1odVQ2VlF3R2F6WUFhRmZKV0ZHbXNtRkx2?=
 =?utf-8?B?SUFXOWpKSUdGaDNoak85eUhzank2eDVaeVZSd054U2Rlc3owVUxvUzRrVFlL?=
 =?utf-8?B?b1JpSWc2elJObGdTSzlXd0xhaU9oMFFYajlWRElSbGc4UklqSFJyUzFub2Vi?=
 =?utf-8?B?YTNtK01CNWtWRXFKanRXU3cyNmo5L0VyV3hpaS93MS92dHh1YnFIYW1TNDlF?=
 =?utf-8?B?REtyVXJvNk5HeVd6Lzl0ajVYdVNwK1N1Rkp5T0lpbERlUnlhaWpOUkhtb0cw?=
 =?utf-8?B?dUVHSzJiOXFqYmY5OHRMZTk0d083blhhU2RKZWhpMlUvaHFLV1BTc05NVXRW?=
 =?utf-8?B?KzdselVXTzdpdFY3QUltT3RNMnpLZDVJeTBKMVBudVgyZmgwdldCOGlUOTNw?=
 =?utf-8?B?d3R2VE5LejlhSUtVUmIyU3E2b3hjaTJYc1YxSGt1NndvYUlwMDg2ZmpESGhL?=
 =?utf-8?B?aU1jeVZkTHpMWTNSY1Jta1ZSazJUQkdoUTg1MlpLYXViNVY3d2d0T1Z4QXFU?=
 =?utf-8?B?N1pyT2l3aE04Tk1Icm1OdGJMbHk4S0dCUWQwcytNNjBUYkhET1BMTEN2UUR0?=
 =?utf-8?B?YlRGL1NiY0pQV1BKT3U3L1BsMEJoTUh4RUxnV2RiRXBCak83QWRSQmJleDND?=
 =?utf-8?B?VlJDWW1DOVB5WWxtQWlWN3Vpdzh5cXFmWTdwdEV2by9JcGZQRFFoeGtmLzBI?=
 =?utf-8?B?UVRRd3hnSW9zenIrZExnQWxmbzQ2U1JHdlJMUDBsakxLQnVnZExhNHVIdmhu?=
 =?utf-8?B?cHVsRXdmellUL3I2aERSb09LQkhJSjNjVzZycjBnKzc3a09BSjBGbm5FcDF4?=
 =?utf-8?B?WjYyWjBWcEpDQSsyd3ljcUttdllqR3dod3llK3dSMkdIa29yM0tUeVVWNC9V?=
 =?utf-8?B?Znljakljb2UybGZOMVl4dVBpMUo4MDlvbGpJckYwdXJuRlZYenhublhSaEJD?=
 =?utf-8?B?YjZLQkJ5Z01pSkdNbldIL0o4T0RrbkphaXE5NkNPc3ZGKy82MU9OY1NxZWpr?=
 =?utf-8?B?YkVLOW1ySkd5eWlsTzdxeDlaSTlZdkVXQ25PT1FENTNOTS9pSjZUMVBnMWM1?=
 =?utf-8?B?VC92dmFhQkhWSFlwL25hYXdaWXREcjlQb2hYYVVHb1J0Q08yekhickZaN0I3?=
 =?utf-8?B?WjVRQnIzWUxrV0NLQjZyQ095NG84UnJ2UkRHTUpYdy90NG1IQXBPWnNsd2s2?=
 =?utf-8?B?eHdUSnMxa0JrbHI3YlZJWWtDNVU3QWk4b0VFWnVVR2pkY3RvMlE0QWU2ZzJK?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oBwLIKXzZVJMYYErDykxhpmmLWqYLs8rmfCf1t/rHpUyZUpKpjiBTYQff6G6t49ZlMO9uH6iy1hiMAQQbaopdVUbKe4FzB3d5J5MWtI1ipvgyf2s/d6695DeAk21GOxZFEoxD88EH7Q6PLOBhb0rEJYTKKB6hrdsGMBmhB4XSso3uZ3+Wmr2ECK/nnLJQcLD4CHeFYOJz9/doIFReinkO9lpT3yaVj26ncj/jRB2L3yGXcBG1qQLtB1VtvpuleZ6BTcm5nJdg4e40AVb2sB/Qc19lQO2GsTl5JJHwxkUwFf7et5PwbPBYUD/nPOOZtuZzPXm3oxrfM2KaSWZi9pIvlxjjgCYhjjnDzM18MAcKAtUx4FLwu8lLCj70MCI5XgB1g3O+8U7ajao8tnmQdmT4xJZnfr4SkrLaw8eB+SBlA08mfG3AJ+KoaHXb/LqKtjaDYPCekPypFl5PxBCkOMKUfpCUuwJrZct196bT1j97YUMVE9KBIFD1TiznrLud95N0GJEQDWEPA6U7RZtVNJXeLMJyoLiFT587vbgOFvwvlQoq8H1HVtgqRD98KA5dIZSMVb79cj7Oig28P7dN9JIGOBBdrU8wqhL8zQ78CdJpXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db8add2-ff3f-4cdf-48c2-08dc702c0f7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 13:29:32.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6H5if+B2F+fAYgcEXdgSZubE+RoRtHBbry2u/aVJGm7YB98v15uOrSYX5SFnd5GvfD+/SkXrhHkI7hdQ3vIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090091
X-Proofpoint-ORIG-GUID: 92AyuXaGra4f2nUYaf6t60gGMjDVBTbo
X-Proofpoint-GUID: 92AyuXaGra4f2nUYaf6t60gGMjDVBTbo

+

On 28/02/2024 14:21, Jens Axboe wrote:
> On 2/27/24 1:19 AM, Jiapeng Chong wrote:
>> The blockdev_mnt are not used outside the file bdev.c, so the modification
>> is defined as static.
>>
>> block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared. Should it be static?
> 
> What is this against?
> 

Please note I see this issue on your 6.9 block branch today @

fd379c13fc0 (HEAD, block/block-6.9) block: set default max segment
size in case of virt_boundary

And I think that it fixes 8f3a608827d1, so

Fixes: 8f3a608827d1 ("bdev: open block device as files")
Tested-by: John Garry <john.g.garry@oracle.com>


