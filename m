Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0161AA1E0;
	Tue, 18 Feb 2025 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875260; cv=fail; b=KGrzQ1+MN7bRj3FolRP1qFSAyh6p/4d6xTUSPPIKoZPpiAPvL/KXUK1KmZZba9F2R7Kfyc2DjuDokx+M6Vd3D+6cG0SlWZ68qvHxCqJkHyoPizAYxFTlBuitOT1lig3J3r/2+MyslY9YUeZMfx9MRF0MgDhsTx76nwcc39IyJVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875260; c=relaxed/simple;
	bh=FMLJbzyeFMJhpqRqOvGwlTcvcgS9+nRB11dFYYUWrNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XKhsnlRxlzXRdgUsgttcg+8bZupmiLVA83Q7BG5z5mGnramjJOYp7v/49ISKiJwhqlRZWBi7brbHEmpT88Kh0C+5V3NOprZLRga7hFIp0/Muy2XED9NFCCS8PAaT67zZmMxRHklLV2RR+IyXQNQbP10iIai0tXRXijr7GLapYFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqc0k68Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aq5qkDn5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqc0k68Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aq5qkDn5"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7OMsj030394;
	Tue, 18 Feb 2025 10:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0zYg4KT1zxZIaXOjngYyia8tyt5zhF9PnuWUn/ShCEk=; b=
	kqc0k68ZXnspvQaZCXKiKQJsMANq4h0JJIvbnOcI6xRQUrjeLq6Aks8Soq9PqtUU
	oUlUm0nPwVABZmMbQyriv2p3gMxhmFBcTbQ1sLtalnAbAps2UUZNNWbKO3Tj8WZC
	+xTBpyP02/PqebPCPTAa5+/VoGddMwb85YI7JdZg5xtTBWION75SVwN/2p3qiFmw
	NzFZqXTXpayE7eVq/RqeoDkntpjhFpdLNW43uVM7mMTz8NiGtpkJM3Mec2ibVJ4h
	RYuNo+b6eyBvL+TVG/TSJr1i+zRX8eg/x2w2eNY9z0Y+ZSlUPedaKzHWLSLXvum6
	eRvB/sj8kS5G/sIQWsED8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tqxh5ue3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 10:40:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51I8g4te038813;
	Tue, 18 Feb 2025 10:40:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thca552k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 10:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE7L7PpVACtLc+k8ysWGfFboN6wAyO2HQ3ZX/+jUHMjmt1QJXGGpTWOo3n2F+mcIZGnqCwYdKnvShXbR6Jicyc0IrfwVo8hegx7A1U+v3i9rdAdoVBETLkR40005GJaz9sOPIZnXBWB6pOIb44Qx1r337upQUPQ6TCMs0ijIdTmhy4oSch1luw8VTSrzDw5L5APM1xAuKNonwIc287IwRhJD0TdjKRhCj7wgrya9jZjpGeXf8Bj7mTjkXGoMzbQsnKJjpq2Rp9tHcvhgaAhhVKMDJaSAlRhcp2c2lZvGgnvlE5tu5cPETFvaw1u7gWPXaSbLRCkwMs6K/ErT/Y6iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zYg4KT1zxZIaXOjngYyia8tyt5zhF9PnuWUn/ShCEk=;
 b=YqZFI2XXh3b2pJrnjGST7WtHxc/oJ4gUA+BYCQq/74cA0BLL33FCgpcV/bBtINOPjcQKOTsQEEfL5GaypAbdxoGjdwiP8Fp6y7eeW+34h5WvHfuXcGrP7F7CIcPZQrtBsJSfu6CuyRXY+g9wod+GjnEH5BFO1fawT6joQ21E9Q27i44MLV/UogCf9scvc3X+B9dUxa0GkxcfStNt5yVifXAkhij5EeyyJSVOJbB0/4smiuMbcuU6kwOIPpjlFgSVwOPxa9ngfIOzyUdY59/p3lJ6QG+NjODlvQhKnab0ugXU2pGoayIm6AtDCyuLWzxFKFTW1ptWt8cKWAdxv/jbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zYg4KT1zxZIaXOjngYyia8tyt5zhF9PnuWUn/ShCEk=;
 b=aq5qkDn5kg96OoGuDshIUBgi9AzjCeo5ew9bwIVA+/r7ap5M5Jy2T08/MzHoME2cshkFS8Qy3uLeepfvyw3cW0BtqeYqNAJgT0HnsAmwC1EKX+gE54zdSguPAq3lw5gs2DSI3/udS5HJ4hOwgj5SQrM2UdhDoETJsyY2xvZiggo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7275.namprd10.prod.outlook.com (2603:10b6:208:3de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 10:40:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 10:40:38 +0000
Message-ID: <f4f4fff4-5055-47f7-9f24-6b1780920f4d@oracle.com>
Date: Tue, 18 Feb 2025 10:40:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: set bi_vcnt when cloning bio
To: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Oliver Mangold <oliver.mangold@pm.me>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0435.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2ccf0a-07ac-49ac-a961-08dd5008aeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGN5WXdwZVlGMDhVdWJwY29ZSTFGaUtEK2RJY1NDNDZMaGp1T3JkMFJSVytj?=
 =?utf-8?B?S3U0YXJ5Z0Q3TWVlc2QxQWtlb1NGVktKL1NhaFFGUFdWNFkyM0U3NE81V0R4?=
 =?utf-8?B?dHRHTmJ6ek9CSGZ6cDJQS2kwMUFTQkQ2TWs5UVU3aExwWnBjeGZRNWxzZEFx?=
 =?utf-8?B?Q2hzZm9OMTNGZlB4T3BwaEZsQlVVMjVScW1KelNiS3JtdlVUVCtTcXMySzcv?=
 =?utf-8?B?cmFHbmViUkNZZmpqZC8vZVI2ZDNaTmNZdHJGSDk5dHE0ek1PYXdDNHZIVlBQ?=
 =?utf-8?B?ay91bllrS092Znd6dytuZXUyenBoUjUvdTRPbXc3WThabXhjS1pDV2xlVkI5?=
 =?utf-8?B?aFFqampZTXJ2NUhCU1JsNDk3amY5U3dmamM1WXVnckpZcThsNHdnd1d2ZHFS?=
 =?utf-8?B?Y1dTbHUyV3RTVURwVW00VXpOTit2VVR2cDF5YXdDMVlCa2xQMDhuWEN4Y2JJ?=
 =?utf-8?B?MUVac3liR29WeVRYRGw2aFdEK2ZObit2MnJGVU1QWWlERTZla3JtQ0RPTXZD?=
 =?utf-8?B?VXU3YUYyN2RyZWFTYVBUUnBxdm1mbENFZEIxdVRrMEhmYlY5ZUxDaFBYVksx?=
 =?utf-8?B?N3JudklCaHZTYW5ZR1V1WStRKzk0dUJCSWVRL1VJdmtuVGRXbE5ldlRoMlp5?=
 =?utf-8?B?d1hqc3hoeW53Ty8vWUlrSGZGdkUxclJkeGx0ZEtoOTJDbDZHQUdEbmQzWUhS?=
 =?utf-8?B?eW5xbStLeXNIVU8vTU5XT3lYNk0vejgwM3NJdmFnYW13WCtXRy9kWEhvNFlG?=
 =?utf-8?B?MkhrbXdEVk5BZ1ZJRitOSXkyUElVd1RMeTkzZERRYmEwUWFjcmVNb2lFVFBa?=
 =?utf-8?B?Q29FMG1pUTF3d2p3OFU0aCtqUVBnSXN2c0FLMndWVmVIRkpreFZUbmVhTzhX?=
 =?utf-8?B?MzBNWWlnTWxWQlZ1N0s1N0x6eUlnd0dSdFdBYkgrTE5udTBPbzJoVWlySTlG?=
 =?utf-8?B?VmRJZ3B5RHF4bE9FUWVES2grZ3B1bjg0TUc5eS91aXhRV3JTaGdRRkNRRlFy?=
 =?utf-8?B?V1o1Y09YYlJxZld6UzNUZEVWUzlVcTlZMW9CbmN3bXFVU1JlZFhvVXFrYk1n?=
 =?utf-8?B?WllMakF5K3cwK1NHYTQzQzFsV1VHa0VzekR1bHMwQ3VYazBVU3gwcWRDMnBX?=
 =?utf-8?B?Q3p0ZDBaR3RSMjNvOHFqeVd4VXE4M2ZyU3F5eXpjNk1LYjhLb0YyWDhjNklP?=
 =?utf-8?B?M1g1Si8ya2p6ZHVEc3NOdGlFUDBpUWZFL05rRTZRdGdZZkRuNmppZHgwcEZu?=
 =?utf-8?B?STJuaTc1THlLTnNpTHc1dFNCTnllSkVLMHFuZEpJcUlYWG5pVjVEbEVxb2RK?=
 =?utf-8?B?U0FLc0E5ZlBrTDdBMkk0L2pyTFJxUS9BR2N4Z0ZJMlFEOU9POE1tWGNTUlhj?=
 =?utf-8?B?djRoMDIxZ1laK0UxdWZHQm50Q0RlRlltd0M2RFlPZmRrQzBvd2JLMUlJOFFG?=
 =?utf-8?B?bnVxT3ZQTXdPRXJjSnF0aDlpVDVzRDhtQ0ZYeWp0TnYvb0p4N2IycGc5ZGJL?=
 =?utf-8?B?Q2tRL2FPZjV4bU02anpjSXpHOFg5b3E4Y2VUc211akcwdjZyRkhLSjVDdEFq?=
 =?utf-8?B?SEZVVVQxem9aQzZidnJlR0toOXRIQ1JoaWJnRW5Xc3A0blVBeDNURXhkck51?=
 =?utf-8?B?UG9MZzRtV054L0N6OHZuTGp3aElHZW1FeTJCMExlVXRwWEg0cUtZT3FzTnFo?=
 =?utf-8?B?ajg1MCtuZUoveXJGU3lqRk1HcThCZ2hlWmhTUk4wRUs4SGRYcWdPMkhrKzNx?=
 =?utf-8?B?VVRLSmhMMm9pK242L0NUQ0pHMWtrbDJ4VGk5WVoveTBsZlRXaUpUbElVaVJJ?=
 =?utf-8?B?akd3NGJkb0NCUnc2UGFYMDJIWW5SdmxQM3BvLzBwZWlRYUNpV2FZbCtZdXNU?=
 =?utf-8?Q?GPFL/F6+yMHXE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHJsNEdpQzlqcHVTSmRFVDc0dzY2WE52Yzl3ci96UnVmU3NNd1Q5R3RkTzJ5?=
 =?utf-8?B?aFBJN2NMSUR5TmxhS3NWcGZwUksxay9ldWViV3ZWTWRtZHRGZHhCY0Y1SXpY?=
 =?utf-8?B?ZlozUWgwbndZNmlYTjZJUEdOdjhEaEwvTDJQMGxsNzJTUHd2OXY2SDBLRzdY?=
 =?utf-8?B?cXRpYkd3ajJjSmFvcmdwMm5sUU1GcjYrdjY5WXVpQXRaZXlkNmNnUzhEMjNr?=
 =?utf-8?B?azBsbk5DT0V6UXYvSEptOFZYVVpuYWVycVpkbEJkUVpZL3pkc1Brbjd2eHM2?=
 =?utf-8?B?QjFIMnVJRmZqR3o3NUhKV0JPK1k3WjFLLzF4d09jMlZoUFdmNTE1NW1lYm4x?=
 =?utf-8?B?dGViYlRHd3M4eVVJNm1UMStBaEFQYnJ1VzU5TkpRTkg2NS9ycUlVeXl2aFJ0?=
 =?utf-8?B?WUhXOVpMcTNnT1lOK2NJbTFQVGdyclJ1cHl1b3Nzelk4SDRrZWpaNVRiWEVD?=
 =?utf-8?B?VTlPaXB3WS90Q3B3TldlMm5GT1Jwc25qaFZ2aElqNFR5NlRzN1RnMDYrQVFv?=
 =?utf-8?B?c25BbEhYTW1kQ0F6Z05aZW45dFVKdXN2S0p5QUJ3OHNIMGJVaDNHSkJSbTNq?=
 =?utf-8?B?cDh5YW5LWnRFMG9iUnB4bXZLQzlveThoVkxwZXlTeHpqUUs5SnlROEN6TkdF?=
 =?utf-8?B?WjY2MHU1Zlo2bjVFUjB3enpXV1VYTSs2Z0Q1eFltMTYydXJOM1dIUlNBVEor?=
 =?utf-8?B?bUkwcEJOL081K3pLR05LVzlhdll4T3V5djBCRjAvVm1zR1kvZFh5VitYamFE?=
 =?utf-8?B?TGtLakVCMUc1V0pFRW9nWWowNHdoUGdCTTh5VUVvZGFTQnhyVHljUGZmbkNw?=
 =?utf-8?B?MEtsemRLbWU5cFNmaFdmNUZkMWVEdUVJWEVEd0lkNFIzc3c0RVNoSm44WjZh?=
 =?utf-8?B?T3RGMlJoQWFJSC9Id04yLzgxNmp6a3FDWUQ5NUM2MU1vY3pTRmpVWDhZVXRF?=
 =?utf-8?B?R1l4WmM2dXNYeFg5VDIyWmVvbUdTYVF2UG1GV3lvQ2dObjh4U0ZGMXlOc0hh?=
 =?utf-8?B?K1JLdUc4K0FGK1ZGQUdLQ3FMaHFZd1djSndrZGduNmFiZkxoR2VOKzlDb3p0?=
 =?utf-8?B?WGRzNTU3ZFRuZWE2bGYrbU5hYXNGK2FrcUpUOVh6d25VTWFYUmI4YURSTE9B?=
 =?utf-8?B?NlJyQTFicHo0eVc3RmlDbHEvQXh6eEw0dW5uMzRFZjR5d1pjSkMxb3hTdlBW?=
 =?utf-8?B?aVY1cks5V2tYS3dDdDdRbWM0ZmRIK3cxekxuTVJpcWhKeVdWTUhSZmdtd1Vr?=
 =?utf-8?B?eUpKa0U1VEsvaTNNN3Q0Q210TDVPQkRBa3RlZEJQV01BYTBJL0lOblM1UkQ0?=
 =?utf-8?B?U1lnbFI3MStEQmpxczNxcHh3VU1lWnhWRXdJR1ExS2pHMDM1Z2wyc1VCOVVs?=
 =?utf-8?B?MXpKZVNCOVRMaFMrRzlqQi90MnhQSnJySGUrSFJZOW1zVDh5dzRZbnpCdU0v?=
 =?utf-8?B?cURIQlEzbHh2aHZEblRKaEdJNlpmTi9YQkNOc0lQQ3VpdzBJZ0N3SHlVcHNM?=
 =?utf-8?B?b1grSWNjcVQrT1hZQ3EzTHBRUlBKbWJyWTgrcUFZMmxtNEIxMlFXbEM2bUhm?=
 =?utf-8?B?UXQ4cEJ5MG5UcjBIMDd5TTdyR1g2MmdKOGRTZFNMYWhmNDN6Zlo5RWF1VXMy?=
 =?utf-8?B?V1J0Sk9kZ0lMdmlFT09FbVpnWXZQZGhaRlJQTGM4L2x1aUJwZ044c0kxWUJl?=
 =?utf-8?B?cWJFY0FteEcyd2hLRkc3R3pDSkRZZUJ5Y0hsa1lMNnVSb05LUm9pTzBMV0NX?=
 =?utf-8?B?dWdpTmxZbDVnYTduMHBYZU1SYS9rMDJKNXVWZlNXY1RJNkpkL1NjNjQyUmRK?=
 =?utf-8?B?MlQwUU9wOXUzU01pb3M4ZlZHSWVGUmtIWmpXU2NhOEpPLzZUVzFQUHRxc1FS?=
 =?utf-8?B?T1dBaDc5N3NnOXFiWGU2aXh1eDhDa09LNVk2bFJzTTdGL0J4S1IxYmt3aWFk?=
 =?utf-8?B?UklzOWdwWnRnN05qWWJJSkR2VW1saW9iZWVIR0Z0R1ltd3pXODJrZi9vSXZI?=
 =?utf-8?B?dU12YnRqc2k0ZVlGTEpCREFMbEFNVWhaVSttVWZzSUdtRUZlQXlNdUN6RjRE?=
 =?utf-8?B?VWhkandvbXV1YWhsY254bWxHU1JQNExaOFJWNkh0bWw2YmNyZmdxQzlRbHNK?=
 =?utf-8?Q?BUj5sHo/kVw4NA/1+VaCbtlLt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/+M+3bGqaIndzMvbBIUaFFmByzX8y4mmjilHJPz2hzcu4LaDl4urLZlTjgJFIlg96VDlgd0KLZDWTRslfriV4CCDpOvIJ79mEejuBL3rjOnKfx2yApbdfrr4N6+neA28D7TUkfR6GQZ1/Nf8WVSm7fU+Lxw4+CkNaI0XDHu5HD4TTAKEFJ2klV6BVwrvwKLn9Qt4kKMiKLBbjgY/rcWeH0YysGwQs7HQ3KrP51oxvAsIlLT2pj2Y2rXQFuePYQnxoiS+s5t175vu3KRWY5nKtKl0cpg5Mk1aw4mL6eF0C+cgV7zelYJZH8hsl4LoclUpNVkcnPLqOYN93OYgg8FADYLMDsZgIds2O5knHyrPc4L+wd68NsS1dJmxyeDAsYaOHfcVAmG2fTDaf0hKhqKwKkM7VF7U5Yz5bmt32v8IauimPV4GeAj7PY6x9BpxsJ4g9jJFEXQD7UeWkJ5/7X8memHKIbA0aApdW92xKrmK+xP6p/vBe0wL4QH9EzCIooHgyRUTKBDqUTrz7iz838Rhsgt1Sp8SmqgduAeVgTtNyQqipUxmEBKBHiTdcKJqY1wGqHk/FFQVA3JS+ly23twKTjqQJcWr5qkPpzlhnw3O+Pw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2ccf0a-07ac-49ac-a961-08dd5008aeca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:40:38.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FrYfnip4VKXHW0EBmBz7A8fuKhqES/ASCNpglIdjLKljm4NaBTEAEcljzaRv2KO7ql8Lp/erNVdadB3o+PIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180083
X-Proofpoint-ORIG-GUID: 2dS-NgCH9zlR1uoKIykXDB6u_-HwVZuS
X-Proofpoint-GUID: 2dS-NgCH9zlR1uoKIykXDB6u_-HwVZuS

On 15/02/2025 10:58, Andreas Hindborg wrote:
> When cloning a bio, the `bio.bi_vcnt` field is not cloned. This is a
> problem if users want to perform bounds checks on the `bio.bi_io_vec`
> field.

Is this fixing a potential problem? Or fixing a real issue?

Thanks,
John

> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>   block/bio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index f0c416e5931d9..334eedf312803 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -870,6 +870,7 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
>   		return NULL;
>   	}
>   	bio->bi_io_vec = bio_src->bi_io_vec;
> +	bio->bi_vcnt = bio_src->bi_vcnt;
>   
>   	return bio;
>   }
> 
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250215-clone-bi_vcnt-f3f770988894
> 
> Best regards,

