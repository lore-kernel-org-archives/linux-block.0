Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9B1CDFD7
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033683; cv=fail; b=P3d5or+OajqsJc/X9FReJHwQjEL2Zs/klTxzcjbNxKvlmd8fuhP8UISsXU+nI3CLw5ZbPA9dhcqo9F/pR/CIEaKtwyzHK2euX1/yclThAkbxyCaqsWtwPBfzIRq3nSvahJdwQxwah6bnQzOfvaT9uDhCd5uHbfd9XRpYsKcnrNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033683; c=relaxed/simple;
	bh=SqDEmBHhz4y/hv6NlorimzyZ+9wmVcwdpGR2CzTNTdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uT/YQCWRGSXcj3kOcTs4BSce3PvvvvnF4Rnd+qwF+ST+PXAaEeB9TKYcXygEjXOqLMOwenacxbxWQGJ9KTYDiBVAp842uKfvJPbz6k/18pbFFkvzz2khg7qisGfI3HJUGrhcb4tCMiLoXq5zWg7bIjfznf3KLF8llFF2yz3qrAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vl0RC7KC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hwrxsz9a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vl0RC7KC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hwrxsz9a"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGMYLH009512;
	Tue, 19 Nov 2024 16:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rWkLoOTPGOD/6pE/KSocONQyzg4tENzrYCIo8KTlQRw=; b=
	Vl0RC7KCOpePaeDytR5FUKJTeu5pir9QUm+HkbEITqLGtEC7Ljk/kG9F8Lopmryu
	qhwvxfOv8+3MRJDlzRpivaqlI3v6qnWPXSVLJ+5l3zKI67Rtz2A/TBZtTaqdaHHd
	q+bcIOh6y0euscLG9hq9PYURkEEX08SxFHiTy33H06hWXw7AjiesD4QzF9OyZv70
	BhhMtSsQLvXfQ5EuDmsh8qDKLzymeY+03OwEt5YbinTaiE6ZmBwHK7xW0vW1CiLq
	tLO95zMtjw/lJLScxNeNxEPeYvQj9Tlt6KNLMOP0yv84GM+9sdU4aB54K2rX+C4l
	Tkwoe0JnyyJ6shF88/EWxA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc5da3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:27:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFZ870023230;
	Tue, 19 Nov 2024 16:27:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu95y2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjWymzJMb30rTOQ6v1b6KP8BpDYfyZOkXAB4+JFVd5JFSBlEVrYINGTWSkkoKn1mEfTcNh9+OYdcq4mqiBpZOrf06O+kL7oiC91hXOFHsgy3HsZ5VKHtrC+n+IbbeleeXX3DlccM9kPamVu7q5CbAxYMUZjaSPPMLiE41IbQnwSSQb0OTdazGvXoUmONZ4zT9Gbk2cTZl+gu+ykswthZm3amXIqLqMhyzZqrqHxlaN/d2PcXvr1bt03SEXuDlOT7vYvbsCQuElYU6sXCHyEie4Q8f5Je+vfcCbyBqHrMqefq6VSCh15KmM3jpJt3n6Frf4LdJLEeUE26xIH/a+mIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWkLoOTPGOD/6pE/KSocONQyzg4tENzrYCIo8KTlQRw=;
 b=jmbRHNUQug8LdG0AHZt6RqvaRGsdRXlCeRgZCuZsRXJoim4jGebW/Q52pYnm7ls8nyGuptmAMKwuiNpJPDLT8A4jApC+ATP8GE2UWWJNSz3WSzBQcYf0a7c8MUaMhBGpv8712T8O1FIMSA0ffQYYHZNJZtZmwj6ZRqXNRWiAvbGGGF+10AZLLCokjpHhlBveJEDhczXbUG9fAP9a/P0VKS3vaTjF1R1Q3JemvP/B832zdGuY5Pbve/rON7GV+nFhM+WmuM1qosXzNzHrk9IcJgmRuQsGz5+Ovt0Mjzlmf98TH30cwYn0jpgXweKs4pWjqHY/2A6cvcJQjLGLH7/hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWkLoOTPGOD/6pE/KSocONQyzg4tENzrYCIo8KTlQRw=;
 b=Hwrxsz9aVZFlAGwCqh9mOU94g64qp3tb7Vcl5xBwRAlbI7n3A98qfkL116ELKuincxGF5rcPREcAAqcBmSgAx9CFFOgtQYzUCwTFj/iTJFV0VdxqbRwoHAedY/qg6Wdk14DpvyAp9uyaKRa4rnHl8141DeHWtm0bIXwtCJbsBtw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH4PR10MB8052.namprd10.prod.outlook.com (2603:10b6:610:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 16:27:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:27:53 +0000
Message-ID: <3bf5ed0b-3717-4a60-a4bf-4248cb49890a@oracle.com>
Date: Tue, 19 Nov 2024 16:27:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] block: return unsigned int from bdev_io_opt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241119160932.1327864-1-hch@lst.de>
 <20241119160932.1327864-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119160932.1327864-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH4PR10MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e59d6e-011e-4805-6d9b-08dd08b71e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1grQUhRc2hTbUE5VjZCMkRBQ0t3U0FpY2cvQWxwWS9Qa2Z0Q1I4Vi8vVFlm?=
 =?utf-8?B?YUJPSDRDK0dzOHkydmpvbDRVVHREbFhjVld5Sm9nQ2ZNR1g4dDJVTUp1M0RK?=
 =?utf-8?B?Z1hyQjd3bERKbW5xazlpUzMwUE9VMnNkT0FCRkFNbyttbEVkSXlucDdnMUhl?=
 =?utf-8?B?bmR2M3RaYmF5eEhOaHd0ZjBHQnBWMUMwUkVpZVQzaDZhL1pnNmF3OFgwTmIy?=
 =?utf-8?B?dFM2TUc0NVlBc3R3a0UraUFaOVZWN2E0U3owblRPNE9SY1lETmRmQjRWeCsx?=
 =?utf-8?B?TnJpT1cwb01KY1A3T3VnSmF1YlVaeWVYTXYwMTArMWtKUnZ1TGtMTGdNTVdj?=
 =?utf-8?B?cUR0dEVYRWcwQ05OQkpXS3Yyb2pKSWhEcjN0TEgxQ0lucitqblZ3UzIwTDl0?=
 =?utf-8?B?cXFIcDE2Zk5mTjJLUGF1ZnJDaHRFa3ZlblM2OEtKeWJFb1hqTTJKd1RFb3lv?=
 =?utf-8?B?RXVmQWRyRmxwRjhUYnBqU1ZBZ3ppaEI5Y0RjNGVRTVRsWm9pSjJxR1NFSWk3?=
 =?utf-8?B?bytRSmErT2Rsc2YxeWVITzhqcS8xREFoSCtySzd2QmdCYjRIMXZObU9BODA5?=
 =?utf-8?B?TDNJVWd5dHVacnc5dTNrWndiQll5amRKV2tVNW9LL1QvT0V2L3lSSDMzOFg4?=
 =?utf-8?B?ckZDdFZ6alFFY2RCQkE1eWtNMld4MXpSaWxwbjVYMHRiK0F3ano5QmFlZXRy?=
 =?utf-8?B?S0lvR29UUmJzVjMwb2Y0Njl1VS8yTnBuYUp4UURjOW9YK3dTckxaNHRVeFJl?=
 =?utf-8?B?c2FpYmV2WXZ6WlNoZGRHeE93aTIzUWJkOStLT3NDQStMTDNGYVNmbkVCamdx?=
 =?utf-8?B?dHNGU2kvcU1vNWtWY3MrWm5KcytSUGsvdHpyQWpPeG9PaHBPREp2QUFXOUZM?=
 =?utf-8?B?WTRhdmJ3c1NTMjdxVFhwa1ZheVF3K2ZDQnJucDV5YitkNUEzL1JHQW5HUmRY?=
 =?utf-8?B?ajNQY1I4TTlob2kzaDN4a2pTNlB3TlZQNkFpNTNrcTA3emMxRTlkWXNTMGF5?=
 =?utf-8?B?NXovenIwNWRkdkZKZnlrVkc0SkZYbGEvc2ZzZ2JLcjVjdlREeS9jRDdTQnpV?=
 =?utf-8?B?UVF5NTNyRGNTQVU2RzY5WHJzK3FHTVltUnVENFpULzFuVFZyVjlwZ3VtVFhY?=
 =?utf-8?B?TEU2Rk9MRVlHam1tbm1SZDliVzA3ZVNxaVczL21ISTBtOUsxRlJZdkpINDIv?=
 =?utf-8?B?eUptR09pM1lDUVo1dzhPdXpuRGNBQXBjZWt3Z1dQNlpJUlV3L1FMVVBPLzFN?=
 =?utf-8?B?UWtEbmxPaXJjMXJSNFI5R1loTTVJdGxMek05ZzgyZFk0aVFJelVvY0JGaGcy?=
 =?utf-8?B?VUFVUkhONVZDY3lwUHR3N0JVcVF6cTR2amwybUpicjF2L1Q5UzJ3Y1VZRnd2?=
 =?utf-8?B?UGhYaldERlNpTEh3akl5STlSU3I5ek9SSnFSL2UvRldsMVpzSkFaM3U1OWdG?=
 =?utf-8?B?TUEwUHBrOThJMVNpbkxRN05VeEV1S3p0dEdlcnZXZTVlbHZKeEgybERpR3I3?=
 =?utf-8?B?VzJ5bjNZQllieUdZLzFBb3hMYUpuRHBZL2hMdElWN0Z5SzI5dVlJaW9BM0xl?=
 =?utf-8?B?ODcyKytVKzUzRHlzZS94b0RTNk1pYjVGQzZaYUQzaHUzSFk0V0xzME81ejVU?=
 =?utf-8?B?TFJ3dXR3TTZuSXBIZWVQQkx5Wm5HblJ1TnRIQ0RMcHhBekRBQTFmYmoyaU5U?=
 =?utf-8?B?WmFHV25PbWRzRGIwaWd6bE5lVkNqNVh5V2ZJK2NsejZhUmdyOHFEaXkzU0lZ?=
 =?utf-8?Q?gcLfII4iTI3BaO2Gy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azJrcmRPUkJpTGhtMHVHUmpaR0pIeEs2dldmL0RTL2I3WTZvVW44eUZPUnVl?=
 =?utf-8?B?NUhNZjJZZDZwRGZHQTVCdjMrY0diQUVQbUdQQWJzdmZOVENDTHRrVVZxRlNo?=
 =?utf-8?B?WW4yYnVpSlZrTkdRT1dtRWFwZGxVOXUvQlh3KzgzOThuZDVmNG1kcWJuUXpK?=
 =?utf-8?B?Qm5NN2FlekEyZjExTWRaa1lkbXE5VlZ1Wjl2TFdJVnpRVlRmZ1p5dVdPdkZx?=
 =?utf-8?B?dnJtQzZ2d3lqS0svM3FmSzcwWXZBL2wrMVRqS3hBK1FJSFNib2JEMkJKZnNn?=
 =?utf-8?B?dmFGaTZNYzZDQVExUXVDMURmMG4yM1ErY3FrZ2R1OWVYYkw0UHlNSEVlQXNS?=
 =?utf-8?B?RFNabjA1UlZHTlNsVDliVzRXL0N0VWtTa2VtcVcxZTNKUE01S0U2eUpDTTk5?=
 =?utf-8?B?c29aVnd6ZUdobFQ2enZTcDZqTGRrVjhFbEJtQTlsNmszS0NJdnRUamR6WGk3?=
 =?utf-8?B?RCtnSnRVUXUxVlBTNnhlYmdoaVFZOUc4Z3BsR2lybHZ4OGRubUlUbHkyLysr?=
 =?utf-8?B?Wm9JYy9wS0wvakVHejNDblF5S01qbCtOYXltZ1RROVozK1VVeEdOM3pOeFp1?=
 =?utf-8?B?eWhGemUrc1VsY0VsMGt3MHhEU0lZcEJQTXJHUnVKTGpJZC80SDliWE5TbUZM?=
 =?utf-8?B?bThFYmIrZ2MrbmIzM1R6Vi9GTG1mcUNuay9LTkFPb1g3TWtpaW1WNWlNM04v?=
 =?utf-8?B?YzFoN0g1U3VPMXFyMG5OM2FMa05tZ0R2S3BSckFtTUc5Zkl5eFo3MjhFVDZz?=
 =?utf-8?B?QnVYTFA5Y3U1R3pFVTcxVU54UStucUoySHRGS2tYZXMxbkxCaXZTQmZuYkZi?=
 =?utf-8?B?UjBRVTZwQWNtRjBscFE0NVU5Y3RGUUF5bCtvMXhJZ1RORDNna05WbFoyemNU?=
 =?utf-8?B?QnpsNzZZbEYyVXFlM2ZmeUVCajBrUGVLclVVdGJYalBOV1lydlR6OWg4UjZP?=
 =?utf-8?B?NSt2U3FIRytjMVhUaHRuUjBJSWJjMVFQL3VscEtIeUVseDZ0N0s2dEczSFBX?=
 =?utf-8?B?UzdJM0ZDY21iZjdNSHUzNDRNTmE0a0JzODAzYk45cnpuTzYzQUx3Qkg4Uno4?=
 =?utf-8?B?VUJUL3BzSXJBaExENHQzdkIyRkUzOUw1OXpKMm1RSkZvVEdhZ3N1YUd5VnRC?=
 =?utf-8?B?T3l6YXM5U0hiQkQwVGZ5d2pZRWNyR1lRYXN3V1JRWTNLY2lXaDQ0bG9PdFpv?=
 =?utf-8?B?OEc4MkFPRnR3QkpRRXdHSm1xaUxtUDYxWFIyMVBObGw0ZlJVRjRieFk5OGtI?=
 =?utf-8?B?Q0tMY0tsNjB2NDZWNnJGaGVuTlc3Yy9KOUcrbHI4Nk5aRStLOHBob05CcCtG?=
 =?utf-8?B?Wk9xMGYzZStKZEhTeUFZRG5idGhPb3FmK2V1cnNxTTlwaTZUMlZnS0FJUW5o?=
 =?utf-8?B?VmV1OGVTMDBPNFZKQ2I3d3g4WlJDNzJONzBlV1FaQUp2MVpSWXJ0cFoyTnIz?=
 =?utf-8?B?cmJKcWhGNzU0TXZReVByczdCcHhHNHV4bVEwZkszUWY2SmpNbHlsNi9GTXdo?=
 =?utf-8?B?bVlXbTIxS3VDVTAyRTAyeFNXeG4vOWZYZzV0T0R2QUxNeExYQ0Q2eTNzZ0FJ?=
 =?utf-8?B?dis2OUN5TXNZRGtNUGVZWnhzVDA1dFAreTMyWjJVb3l0YjZQeHRRckZVVzha?=
 =?utf-8?B?dzhibnhmWkJva1poN1dOdGxTZXpHMGhhSXNIbExMZmJRbXZZMU5JcC9mMjlj?=
 =?utf-8?B?Vm56NWs0dGxCVnZDa2VsRStoZjBIT3I0dzdwTzh5MHpHdnJCOHhGZmk0SXpR?=
 =?utf-8?B?T1ZTL1BpN3NrS1hFejQvR2swUEVyT29qMDFPbm5EVWU4WnhiV1h1M3g1NDBM?=
 =?utf-8?B?K0NZNHNpdHczbWpUN2R3RWtydDNzWXZkU1FYUFRaM1dqSFZJSGZ2YmdrZTEz?=
 =?utf-8?B?WHdicmh5RkxmbndUU1RXQ2tPLzg1VEZyVWtiTEpMWjRlbUN3U0RWMy84Nmk0?=
 =?utf-8?B?TWVKNm9FRnkxbkdGM2o5emg2YTU5bjdDR0VhOWZHT2huNnZuNEFremxLeXJY?=
 =?utf-8?B?SCthTDR2V2p4ODZSZ09rb09XYTc0cHR4SHdidkFndU51YkhMN3hzQ3FOZjht?=
 =?utf-8?B?Rkt4QkpZL2U4M0xzWWVSTlBHQ2RsWVdldUZVL0lrRXNSY0JiK2w2YzFiY2Jy?=
 =?utf-8?Q?0EQgoxMMAgmIKbQWEW04bw1jn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9yKcZHo9uX2aTt0msxfCTJLPBdK/LsHUAfn9s8beTpoMcgnsK17N56yYyHnPMib4jGi/dNd85BBVRb/McHI9TKoDeK24ztITLfF/dQRAzS7jRHr8ODnq9N/Ixi/pxuCxa/3miQXLx3Ww1pKpdlCbsU83aqmbN75mkbqf4c8UHvYRQIjDc3gnj0Z9xasZFOLigTqlsRYEHRo5hr174RKOb+9Symbnt0yqhC3kyigDyAbAIfGIZCD26ofnIPSD5AVLJUneE3rxWJkA8Jl0DPf7Mij/a1UOLG57A6iUXT0aqkkIbjl5tJ/kWvotB2Og021xUa3ttABGOd1ghKRDPmqZepVii2PtTJOL8Fgsk+D+9k4+bnadbVyf07HTyKqBFuENw6sweVbYopXHDa0gjPQ/JZ6jWxEN6KFKjUMdkA4xaLlcXxhP0rLfTFHWuaqd0G/rk+Hgg2zqum1ZU28RgJnSS0xRlVig2EAc15n7HWxdgVuuLvJ6Dr19dJDx9tNkDRV+vc8cVMA/NV63+2dABN5oNEB6lD3YAm2v7AGKXzwOt6WR9Syv817u8qUCQfxSvdPOcYQDJcTGRqOgq+DJCd4DUvhXpPfMLuyyJ3kjUuYz9+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e59d6e-011e-4805-6d9b-08dd08b71e02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:27:53.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcX8HsdggvCtFlNl1+00AZbCr4zIL5Gjw8vYQLJMjk9i7KMPUXHu7xka7nBeToIG/5bRwJgwgjee/No8y6+Vjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190122
X-Proofpoint-GUID: 9vjunm35JZuSKsVOWHRK-5RNMTZHA28U
X-Proofpoint-ORIG-GUID: 9vjunm35JZuSKsVOWHRK-5RNMTZHA28U

On 19/11/2024 16:09, Christoph Hellwig wrote:
> The underlying limit is defined as an unsigned int, so return that from
> bdev_io_opt as well.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>
