Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AB1D9326;
	Fri, 13 Sep 2024 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236554; cv=fail; b=Ip8TPNjUutfNpuoNPzpKzFpCuiruMhKypy8zDYA3bdWbx4jxhJ9lvHN4g0ac7FdSqYwK2nlKgU23pDl4WKwhNM1EKu18n0/EWdg0YicqtskWTzf8q0Bkg2UcgnhTlMKY9HLRSsNJ/ArmSB5HwUhgVitLntOiCYzf+4mCv8tDJ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236554; c=relaxed/simple;
	bh=5PhwV/VlmlHboEXR/vJh7tQO0/7LH7DyG63P00x5kPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fL4mm4DWgIZrnB/6JLt91QahZkSgo+I+otrzqXY4U1vZlkqZWoYk35fKaFqtcu3CcAXFTjYXC4p+mndZw1hOrbvOZn6YY8cgO4olG7Xjp8G1zHB/MsGxDoQ+YsHiAr9G43OVjgSWu8C6INX1OZGOjrf2o8z5hqCGYh/gZrFvW3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PJN0x+lo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZLd67JZI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PJN0x+lo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZLd67JZI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YMkg012331;
	Fri, 13 Sep 2024 14:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=FW/byet1qgSEOgRNnYUF6Alb7Y2qk0Wb1mhEvnMUmxU=; b=
	PJN0x+lop0gANn7ybJB9E6DXuxyeiV2Jjbq+YeweFz7zmqK+J8VB3t3epLSkcGxx
	X03Qqh3tAatBmKzfi8QHPDoELDyB9kn6ybjwpJEYcSPfHhHKG0OTQcWZLZ1MmbGg
	t+cmql1dwW2iyj1eAWj3R7wYfEoQI6M3Yr9vHHszMAy4yZVNo4xqMjKPWTiZGXyk
	f6w/DS6Jk/A1eHrdIhsyngjSIXj3ds7NUyBxXNlvmExeuyxLwhTEQQSqGEw5HktK
	zo6YFrZLMA9S8jRgFzYzIpafgc7kIxliziM2m6GH4H2hyc0IenfP2r+NiNcq7M7i
	JB4nbJqCWGe8uoTBwsZF6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctnqdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:08:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DDEDHG019800;
	Fri, 13 Sep 2024 14:08:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9k82cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:08:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBLKFLxQQ6yQQuYUYbbOTxh3j6uyWLZTBdKkzQc6psnjd80eQOYjS2epVfrP3HvgihG+7W53drFdn5c8/h8Pbl2El2Qfc1yVh8D6fQ4mQj+MN4IB8NLxNxDbQmtDLNjJBgM68GlBaFUAKYBBmtTx4DiSbUE+CTQbEKQPix54LgxuYQbC80zUWZfJqdieoKGmd0YQ52xMyvXxbweVd7Vn0Xa4pa1pyAzUeWDShafOvjlbH634FT06izhjCLRgxrsu6cQCMDrAqEwPtuelWDWALi5XuAydS4JqeyMx3wH1h/FpqG/2xpPpWhrgGBPfQjpgHdHmSEGsK4hLSg18Bb1MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW/byet1qgSEOgRNnYUF6Alb7Y2qk0Wb1mhEvnMUmxU=;
 b=a31Ez+T7xU8dxxAzrcPVKxvo8VIvqJMFk+5QwQ4kViaklyS9/ioFeibLVULHbqg7z01ZdDVq+kok5ieB4/5XM1BtXVrWFtNwQA6bzHV4XyGgjemQOx4ZHzpDOrgKVtaMIln5GOTUdcseCuIisQuLerjwvxjD65KghtWtJ1i/PDay6uqsGndCBd3BpU/RZKeCg7nowaGXV3O9PCjds3nryW/1k0/6Yur3mg1Wma9tDaplvCFCWBhgHUv4NFZjE6tYvnZoGpQKYSlZTdJ9So7IglZ4WSuvphSywu83TLN6weVOoAVJxOU5kY/70ef6B8MiqRAZeIxdj57fVdZ0NP9X7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW/byet1qgSEOgRNnYUF6Alb7Y2qk0Wb1mhEvnMUmxU=;
 b=ZLd67JZIK2Llmc5yMhGmnv4yo7NKumIkYnsE+GGglFm3IVSwHzwhHCYJU+uyBgdM59LXezb2MtYRP7uqLK2zPn6jhQEIwpMuwhxzaJf0HuTp+YD1q9R58akyvyOAKH0sMw6isZbZReAITFxea0DCd3dLDzOL7NaAYcfcWVLsx4s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5951.namprd10.prod.outlook.com (2603:10b6:8:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Fri, 13 Sep
 2024 14:08:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 14:08:45 +0000
Message-ID: <6c8f80f9-bf7e-4d74-865a-86c9dd7025aa@oracle.com>
Date: Fri, 13 Sep 2024 15:08:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] block: trace: add block alignment information
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, gost.dev@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Dave Chinner <dchinner@redhat.com>, Daniel Gomez <d@kruces.com>
References: <20240912-add-blkalgn-block-trace-v1-1-335dd6eea557@samsung.com>
 <CGME20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997@eucas1p2.samsung.com>
 <a7f9079f-6f47-4a47-a327-98497bd33dfe@oracle.com>
 <20240913112626.mmr27xzxicyf37kh@AALNPWDAGOMEZ1.aal.scsc.local>
 <77f6fd38-e216-47cf-8ceb-930395614aca@oracle.com>
 <20240913135713.vzevruukayd3o7cj@AALNPWDAGOMEZ1.aal.scsc.local>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240913135713.vzevruukayd3o7cj@AALNPWDAGOMEZ1.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0024.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ab6c85-1981-49a7-7e70-08dcd3fd9483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGJvUEV5dlIydzVkNWhCclJGL1JCQlFWbHAvMFdIcVFkTjRJbEQvQytRV1lu?=
 =?utf-8?B?Q093RDAxVXhOWUtUTUJYNG1teHJkU3hxTkFVa2Zwa01TaldDcTRNcTg1Nlpa?=
 =?utf-8?B?eU41OURsLzVxZkNocnl3UUgvVjRYbDNyNU9IV0p2cEhyYXk4UzNkTjJERXdO?=
 =?utf-8?B?RXBSRnRMR0lHbXZWS2FOWERiMUFHNElWMEM5MjUxMnFEZVNYRTJ3QW8rck03?=
 =?utf-8?B?TXFPb2cxZVQrb3dKWThGbUFQa3FaTDZRdndITzZhb000M0hTMEZIODY0YkZI?=
 =?utf-8?B?czNzZjRnWWdYTHo5OWVEa2E0S2RWL3NBNEJMSUNnRmprUjM4azhTQUdUeVZW?=
 =?utf-8?B?bjlYNlEydUVGY1hRc0lYM2xCQi9JZ3JuR1h4elBMbCtOOXppYXBRNzFRSFNt?=
 =?utf-8?B?WDhJQktOVlcxTDlvZE5KSXlldzFSTDVJZmpELzJZaVNBZGJUZjRsUERZcllt?=
 =?utf-8?B?WHYyUVkySyszTXFlelF3OGVBMzRHQWkzb29ScEl1eUhIaWdweWgrbnNKUkQw?=
 =?utf-8?B?WERibys5d09RbE1CY2Z6aTZPbkZsQlViUHRqcHFkTGVQeENqa2tjellKQTVi?=
 =?utf-8?B?eUtCNlA1eWpMTTZ0WTBtWlRrV0d2R2Q5YzNUZ1cyTXZIdUs3OWtDWHBjblhX?=
 =?utf-8?B?YkZmbThxcFJZeWZKRS9ONHpWRExHYVJrZXFpMGNweE1NaVIycE1uNURUeHJG?=
 =?utf-8?B?QVVoVWd4WGpsUHlnRVBCSThqNVJnem9FKzVtV2kzRjNNZnBsVFhYWldPVm1K?=
 =?utf-8?B?TDgyTGY2OXZCV3pnaTdHRnBub3FxVVNMbUpoN2dsU1Y1Nlg5ZUpjUVJra3or?=
 =?utf-8?B?aTdlNFR4RlIrK1hHcjh6WEJ2TUo0UUdMK29TYVBBdlQwaU5ja2dlc2FmZFF6?=
 =?utf-8?B?VWxJTlVrMDFQT0owRnNpNFJ3czhKWEFNSnBPbjdzSjh2OVN2bWc1UEliRWl0?=
 =?utf-8?B?T2xhU1FlZ1RFL1VRM2ZHb3p3MDNrSE5LV0VHcEJvV0RaakJkeDE1elRQT1Fq?=
 =?utf-8?B?TGsrU2tZVEFMSzE0aTA0cjFGOENPRnJPMGZVMEkyKytRNjhLTFZvajBCYXJP?=
 =?utf-8?B?b0hHMEZnbXQvWnRZaHdkb1pUWm1NL21aTkFVM1FNcjNGQTJaZ05Jd3QwT0kv?=
 =?utf-8?B?eTJUaCt3aGZxcHlic3NiRE9LSWVLa3FnajZPKzd4ZFBXdFlsVlNVOHRRemtV?=
 =?utf-8?B?QURScjdNbGd3cUZTTHRYcTVkdVdFWWkwZytscXhQRUdIdVBFS0VFK0drQjZB?=
 =?utf-8?B?TTRRUXNvNVZyMFRPTjgwSEY0dG00ZnpEWXlwM1NPMDh2UTRCazEvVWpVUTlj?=
 =?utf-8?B?ZkE5NzhGUUVJeEFjQWp5S0dVTzJFOUhvVmR2RHlCLzFyd0MrYURNNXhMU0k2?=
 =?utf-8?B?NzE5ZkdtdjR0OFNnTGdhdGpuTUlnTmZodHZPME1SNW12aEVFaEt4MFhyNnln?=
 =?utf-8?B?K2F1VkhoeDBrZ0pIenZFSUFrR3BFRUEweHpmWE04N0crMGJ4bFJiVWRObDhj?=
 =?utf-8?B?ZW5PUWYrVkJJc2lnOEdYcmFzMlM1N3Z1Rkw3NndtQW5WSkxVTitnb2xad1d1?=
 =?utf-8?B?Y2l3VDlvZzlvT0I0RnlsS1BrYmhDeDFiVVV5TFRacmROS05XYTFDY3lGQlZv?=
 =?utf-8?B?WHk4VTd0R1dpUmNiMUxPUnVaUE8xTkdUUFVUWURsN0UzTUZSYUpGblRhckRE?=
 =?utf-8?B?RzRsUnV3MTNYRTROSG5uSFplWkJsdlgweXplTnVQMmNxb095SWZvWXN6Zzg5?=
 =?utf-8?B?WFp2eGlhSGphdkt3YVdzY2ZuK2N4R3hpM2cxOStyRnl0NmtZY24renRJa1B5?=
 =?utf-8?B?VnphaXRaaEp3YTFFVjZpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTM0aG42SG8zTXRGbnV2bUNjNUdsdXBsckIwVi9kZ3Rtb3FBMXZLWGk1ajMw?=
 =?utf-8?B?aDMzZnh6WDVIOGpRQ0U4cnVEWTg4MXFlSlF1YXRWSnhNUWtMZmszVE16Wjhj?=
 =?utf-8?B?Wnc0S1YweW0zWmkvQy9pZGVzc0YvYUdUUnJVeDQ5eGhQSmFteC9neURjRHIx?=
 =?utf-8?B?U1Q1akdhTnRDeWNRcjBpZ3pWWUVmYUdVUFFXcHdkS2gxTjJabWRKTkIyMjRD?=
 =?utf-8?B?eFFUZXBEb3MwMndXNlNNOFo3Y3JvYzdnRGRWeTZGV0hIdmYwZEMvRzBab0RL?=
 =?utf-8?B?YW1wUU1LRXVrZlNMZWp1K2R1SzhleGJkUE1zbnY1cjYyVjdIdzBRalZlVGJ4?=
 =?utf-8?B?azZRb3ZONDdLdGZnYTh4ZXhrNG9Ec1VEYVAyRTE3WHBCNVZIUDJmRmVRNWQ0?=
 =?utf-8?B?YytsUVNkSWFNeFRoUmVnSXRIcmpRS1BJTnV5TlpKTVlLbVZFUVU0OWJDbHUz?=
 =?utf-8?B?Umo1RjBnQUtZTUMvY0E0b1ZNZ2Mwdlg4dTlaQ1hjc1RRejJvWUlIZmUvMHBn?=
 =?utf-8?B?d2hvSHpqK2E1WWFmWDd0Q01zeE13ZTE1b1Z0dUd1S2R2T2hJY2VMejV1OHUr?=
 =?utf-8?B?RCtWZVUyUDdSdzJwM1Bsc2RJd3lWY0o4c0VYbkRuVXZEZ3NFOTIyMUV1SGQz?=
 =?utf-8?B?SDJvcEo4RHJaQkwvUlRBQThLMklhUEZVVmd6MHM5WXBoQ1F5bTN1U2JYSTBu?=
 =?utf-8?B?NjU4UUNXcGtxRkF3UUtuWVZITUJETDIwUzgxREw3S3lzR0tMSmtHb044M0JE?=
 =?utf-8?B?MWFuSFF3M2tWU0RuajVLY2d3NUNuSHB1bEZoTTRrTGZTczJKblNuYjRnV3Zw?=
 =?utf-8?B?T0M0eUtzOE5aR0ROUkJnczV5MzhyQnpKSmpKRXR1NUVmSytQMElqT2N4TnEy?=
 =?utf-8?B?d3JkZk1YeU8rU1JhYVhXcC9zZkV1UGM5Ym84cEwyRXFIUlY4cE9tTW1GUDVU?=
 =?utf-8?B?dDMrNFlkSkVuRWRkeWliSjBRVFhKWklZNDRObGVHd3J1WnNyTXlFVTRxVG9S?=
 =?utf-8?B?bURjTVZZam5vOEtxTm52VEpXRVdSQWdNaDB4ZnBjbzE3b1B4TzVIUWRWaXRX?=
 =?utf-8?B?TWIreUtZNWF5VGNiKzF4M0hBQ2pWN3A5d0tLNHkzOFZ2aXlteTg1a2JYN1hm?=
 =?utf-8?B?UVhoTGpIbWh6bGJrWS9mLzM3WURsWWtyckNERklJQjFEN3dNVGNONVRVNlE2?=
 =?utf-8?B?UUV0QXpub1hUWlFjc0w1OURiSUM5YUxKYlh4NFM0M01LWmF3eWtYWDViVTY2?=
 =?utf-8?B?UUZWbUlKUHhLemlzNkpkd2Q3ekpxREFrRGh1MDhncnRZMEpGTytUc0FUdFRD?=
 =?utf-8?B?a1lJcEtKaERLWFhqNXpjZTZWRjQ1MW0wS3JINWxTck4wRElneWNocE9KN0Z6?=
 =?utf-8?B?dmVIdDBsdmdSZTVucXZDMHROT09mYUZPQXlTdytKd2kzT1FjdnNwUk5GczJm?=
 =?utf-8?B?bEliVHAwbkdCeS9sK1dQQU0vNERPeFpoendNTTJlY2dyMC80Yy9IdUIrdHc3?=
 =?utf-8?B?NDluZFZqK1ArSzlVZFJudDFJL3hZdkt6bDhQZ0xadjlvclc1ZmlWbmUxYVhl?=
 =?utf-8?B?WXV2b2o1ZkVWSzNmcTNkNW9VWFY5VGtBb3Y0dDJzNnliNWd2dzd0eHNid3BG?=
 =?utf-8?B?Nm5NKzJCU1VLVFN0N1JiOXNNWE84VXovRXdsRERBbU8rSGwzOEtZV1BtWUNs?=
 =?utf-8?B?V3g5UlBMK0pCY3d1WWJZTE8zeDAzYnNiUXBUSlRYZXNTYUhqRFRTczN4eVVI?=
 =?utf-8?B?OWg5anVIMkhFU2U0SUZ4QmcvTW0yYnBCUStzQ3R1ZlZURnlCL292MytrZTlx?=
 =?utf-8?B?cm9EejRNUFhNS0FBcHRvcUs3amR1V3F0N0UzbGF6RlVYczlYT1ozYnk2MmRS?=
 =?utf-8?B?VTl5OEZQRGQwc3BvUWhqQW5sU1c3WmhNc1BjdEp3a2QwZ29XWnRwT0Z3alVW?=
 =?utf-8?B?WlU1NTQwcGNYMlQ1L3JJc0dDeHRpZ1FoMjRYL0JQbytFbEVRVUsvUmI2bDlB?=
 =?utf-8?B?UGY3RCtMVmRXdDZqRFlzQzdVRk9oek80QUNHZnh0YVBJYVZMNVFELzAvSk5X?=
 =?utf-8?B?cjA5OVV4YW54YWQyV1pDa3R2NVFYa1Jlb1dZSHB1MERqVllpZDN0d2xPMHls?=
 =?utf-8?Q?iizqjOHeSgkVfD4aOvwkyBnAi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DCO+9oy0OBSJQg8M3DWdsBrDEqdwUoFIz66YBrteqMcyBO+Tt8dh5CbJmpZzIEozrOcbF8iDhzxcSu//mVo3FwXD4fX2J5B4QrXi4Tk9szRLfqBPBmPD+Akoa0YH0of0WcEM/lfQ43mzs1vHNIq5bcRJRtFQszwUATf4/HJQv3wuBGc2uc4U69lHu46MKBL8wy7/Wmcngi6of0fUkSpXmXO/1q7pMFQQAWGuUEMxxqgNc+60bbdhHqa1iuJiNK2NFhhGsCT053/H4bcx168FWonl4bIkT7RNFYFxKuQSN41yPxS7SJJ0o//teSABntrnfK7E/JDGPyWbe/nab0mh8b32oTZ+4vof0SlSyndXqNkp5YWmGI/ysyIf5wDeft4jqBf0t9RQFJkWsTeaTYyozGQUgKULG4TDfazoA5OUITsBGk6DxrKkd4qWRsRfbgJUg9K/DbdkU2wEq5mW0m0oeqD/NKbK4VjwuePeIiV4tT9UgJLgZP5ybPY1fRA2mY2FE+bO+8L3b+oz3umZypNDZ1XWQEZrBzrpfNMiCu57ObO2pu7+ffuiVTAnEoZjH/w3MdyxBYCN6ldFZZlP8XgX8O3JjrwYN6nfOzlHmkX2drM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab6c85-1981-49a7-7e70-08dcd3fd9483
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 14:08:45.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeGMs93xvzBk59AB3LVq+NCw4QYdue5vNo0P9fZfzu7BasNJzSSwHmCZvmcHjphWAOIZaTB55zl8YBO3LRxOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=919 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130099
X-Proofpoint-GUID: lRlL4gT8sum57ZNBwckjCTg8I4cz9B8C
X-Proofpoint-ORIG-GUID: lRlL4gT8sum57ZNBwckjCTg8I4cz9B8C

On 13/09/2024 14:57, Daniel Gomez wrote:
>> I am just saying that the information already present in the block trace
>> point can be used to get this "alignment" info, right? And userspace can do
>> the work of reading those trace events to find this "alignment" info.
> So, maybe this is better to have integrated in blktrace tool?

Sure, or whatever tool which can process this information. I just don't 
see why the kernel should be burdened with this.

Thanks,
John
