Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00B1CDFD7
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033754; cv=fail; b=g/8FqFzEVDPNWW2tyg4U7kmUAZSCVMfB+kvWx0g6ejJQ3RzmugZZEk8bQ9LH9TZi9aHxSFOGlARHc5MxXyaJ094MzaXvt6/bsE0QEyVZ6iCqciBDwIau9UL8afGWddDgeVnpDcrJ0BWh/6osvZNhrQmAYtFcpg52I+90IlvDHEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033754; c=relaxed/simple;
	bh=0vnsT27ysUd9CG+rRLVDiN6eMtPqtF4Iti5IFcJ01aE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j5cGFcwFCETg1//2YwJxGC8jD29djZ+2JPRitU7qwjv5sZpSsf8Q22HNk4gd2poxjq1AniXkXAnX4VJMyhxcJUH3YTJcybLdQewqkjQQ4m88Viuoxn5yfV9vDEis0j7X4DWsRGXyCK2GPrefR3kf4CRKzjRXN2+qDkDccSK0ezE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bae4kW6z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lo4FG78A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bae4kW6z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lo4FG78A"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGNAa4010893;
	Tue, 19 Nov 2024 16:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6A8A7O8nx1A518KImfoKhyZoJsqXrlaE1bV2Eiv63rs=; b=
	Bae4kW6zK1QXCzCdfE4qlC+xerxhCSxjrcG1sK/rt/vHYMsYKJgxiUTPkDpm27oI
	TbTZFdPNdCRxo8lA/0tb8sNTIOxSRJIgFxkFQolSW5pWWPeEHBE/QYnDCVzpPVQY
	7OOVbk0cvWbLW3RoLMwo742SN0TgFi+WY0UOiBbW0so+/uyQeDKK3FATpCdA70rR
	cidXVcFyrc36aPqBHIprlCnVpmoD+S0vzlAsafkhJvCC/qEq42LKygKSaPCHZXxm
	bJ6OcujscFwqKHKnPppaKxV4QTZmpb80vQffT+s3ES+k24qNJiS42iYxAFiIYvxc
	T5QwEsNmx4nD/GvGJP9p1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98n8rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:29:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFeTBq039179;
	Tue, 19 Nov 2024 16:29:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8q576-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqDOHYvljKEVSntMeYaD3u+MQHKfW0KymWKwh4vLkTgx2gxKc0D0z5Th1Vcb6Dai9ukVbQi4UNzltIgwx67KtrtZCbyUjvud5L2kPw1akhASCT/ODyyA/7pkYqewucIOJguI6yI7SHbedEAgohZjGKQP6zGOE2XHAK6RXFnRBjVE3RXhy+T2fhgOJ0JtfCWZUVbyN9wzJ441/UDTfR2s1DwffrRAchT2XzR2QgaNcDpkNXnjcZFf3PkPpmyjoPbit89jiWPkSj7qyyFToihBfMnF3RnAHHlwOuegDArAfgAz1jcF1Ux/GsN3YCysqgxWiPxCGm+G6vEaytrrjxyW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A8A7O8nx1A518KImfoKhyZoJsqXrlaE1bV2Eiv63rs=;
 b=uy4E9fKag06qw4UH9LK4kNh5tgdnDyivTTvi7wjdMb7T90VUrvbDsuwErF4yBfWx8FhY+9h19KLNMlL1LJYwEsal8qIUEcB/mUTOBr58aQWh+/frUGVnPKn/lGJMkeMWKbvTnKct7I4CI/lyUSVKjBtngt/grsmGDsJfgP+DWOdPxXMe29bVzIeF2FzlWXFdi7qx/eGrLzZA5XOdiJTgfi5B5sK6d44XhSTqKHZhc6PHs1GlkUqW/ohYe/B9RpzJQbkJQ59GxcMto/SwWTcJ152f9v31VSbCg/u0lWzYai+FLFHKKCGGEjYY1Yx9Yhm2P8BiVN6rZNHdzvUeG/32QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A8A7O8nx1A518KImfoKhyZoJsqXrlaE1bV2Eiv63rs=;
 b=lo4FG78ANi55tfR1UHVPNUrYlbkEbioyRlE7t2Ol5SecvSz+SVPybug5UWMMmi5xSGTwfoNt1sCQzZHKO/V8HGukbfl/viQxmpg3VAG0uiZCpRJoarQtPHFSs3oWJ4lrHkwWy4RPcsou5dExVdS2sgg5THSMFn1gIcDX8sCJZN0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:29:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:29:03 +0000
Message-ID: <dad8fdc8-2a4e-48f7-9387-343d758efea9@oracle.com>
Date: Tue, 19 Nov 2024 16:29:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] block: return unsigned int from
 blk_lim_dma_alignment_and_pad
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241119160932.1327864-1-hch@lst.de>
 <20241119160932.1327864-4-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119160932.1327864-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 53315763-59b8-463a-02b8-08dd08b747ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWNnWngzdzU5VXNDaU1VMjRtOS9BYzRCUGc3T0RiVGNTTHVBd0NwRVNPcnd6?=
 =?utf-8?B?a2RaSlVyejk3anRSUHZIYmRxTHpwaVVaaDU5TlZ6ZVhwY2x6UFI2dFZqQ3A4?=
 =?utf-8?B?WnRpaUlOdlJHbkJzUDlkV3NIb3RReTNZRUNyemRqTmM0OWh6c3dYYjBVMlAx?=
 =?utf-8?B?bVBPNGpLZmRXd2V0TWVMZzlEdVpqVTMyVWY1VG1iSWlaTjc4RktKVUFuWTJ5?=
 =?utf-8?B?c0F4WFpocnpzTmtkdEpSWDJYZnVhYUZYdUpwWXB4Unh6L2ZHY3hJaVl5K1Ny?=
 =?utf-8?B?TTlWYXl6eG8vMDF6dXlNeVhkZHRRREhqejB1aEdFaUxCZnFkYWpIT2hYZjUy?=
 =?utf-8?B?MVkvNlUxd25nOXhvaVJ0ZURPbnVXSi9aZGVHNmV0NFArMGJ1U0xEc1d4aTg3?=
 =?utf-8?B?UVBPOE9LL2RlUElzVFFyNnl5d0g3S1R4R2E5empyeGVYZHk2eXlwRUdabjVF?=
 =?utf-8?B?WGQ0eXAwcEZ6UnludU9zNHkzY1Z4amM3YmVaVHN6VzFMM0lHWTJtenRmSWFX?=
 =?utf-8?B?b2JQRmpEQXA3T0RwTU5pUHNjQ3FkSXUwdmdjMXREdEUwOTJhdzUwZkpTYTBX?=
 =?utf-8?B?Z0gvRFVZWldjRTdTUWxBMHNESmpNelZmeloxM2ZnQVBpWmtkM0VER1JaNEg4?=
 =?utf-8?B?byt4bzR2UXUwZDFxRnZDSGxCMTZsWlQ1ODFNUTg3ZndwTUc3OWdKa2gwSjRM?=
 =?utf-8?B?Ujl4N1FaNCtkQzBrWDFia1VUT1JWYlZCcXBMTDZhNDdnNFZ5THZnbjVGQ1dj?=
 =?utf-8?B?eXBreFdSVmc4OExORTg0c0JuZEtPTGJ2OFRvZk14bytXbEVlU3M2QzI2NkF3?=
 =?utf-8?B?UG5PWHJyd2gvdW1qdXBRVnFDdEFaTkZ2QVBFOFB1SGVYc0ovazBzWWZNclVP?=
 =?utf-8?B?eW9ScnBLemFPRzR2TWREaUZqN1JuVDBwZCtjSlREazh4Wi9sV29QRUp6ZGNE?=
 =?utf-8?B?cHBhOFVWaGtXT3BoOUdBcHRKNThuVGxzY2FLMk44L29zbWM0WkdCZE1qZ0VX?=
 =?utf-8?B?WFdnWVViMFpTdG50QXJCTG44SE9Zd010bGtBTFlCNjhYSmZVL0JQZ21FWjFF?=
 =?utf-8?B?RUNoNXlUNlAwbHB1b3BvcWpFU0RPb0NGWmI5UlF3amdmclA1dFVsOG9Ic1dX?=
 =?utf-8?B?T1pLb2N3U3ozVENGM205U0hUbis1YmthUjllTHlSVTBaWVhsSHZ5dlAvNHBj?=
 =?utf-8?B?bWZkYzBQVm1ZSS9QUUgzS1YyamtWcjM4QVRxKzFXTkZ0K3k0SWdoOW5IOGc4?=
 =?utf-8?B?N1Q0cGp1akZ4aHRoQkNZd3RuRTB3R3Y1dURWT3loWHhUbkRCN2VhWlllai9P?=
 =?utf-8?B?dkJRZFFvZWdvQkJ1L0RPZkpJZGlHcnd4WXZod2tmckZEU3pLeHNLbG1Bc1JR?=
 =?utf-8?B?ZTRDalFQNXFFM2dpV0d6SnY0alliVGxJM29WV0VHRStzUCtQYTU2N1h0aSty?=
 =?utf-8?B?T1JsblM5Z1pKU2RMa0FSZnRxQUZnNWliU1p3eFVYdEdQNWc1ZGFuWWE2NEVi?=
 =?utf-8?B?c2NQMElpSzdwNDFMV1o2aVpnWGxFcHRoTHlNbzdGK1huK0ovMkplRGd1VnJa?=
 =?utf-8?B?TFh3QnZLZjNDMm0vV21hZ0hpRU5BQWdhWm8xTk9TNDZsWGxsUmpRcndEWUZl?=
 =?utf-8?B?TFQyakphRWV2SjBoTlEyMW9SeFVzSllZR01hQk9UVHJpbklRVTVRazRGWnlD?=
 =?utf-8?B?Uzl1cVpaajA0aURZSFFWNjZtK0l2RGlvMDVncVVIeVluSERvVXdJQnY3TUY2?=
 =?utf-8?Q?53CeekzsfG5EsvsGyUrhiTEMqAj56gLTnY6HypK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkZndVlYazJoTDhCeFhGOHp3S3o3SmhsZWRQZWQ3RVRVb0FVNkRIZkR4cnh2?=
 =?utf-8?B?VFRId2hKUlFBQXlLaW1RU3lod0lWajQ0YlMya1N1MGhGTnNrRFZ2L0NEL3Qz?=
 =?utf-8?B?Q0FTcThSSlZXRnNESkloRytSdWZvYUtqZk0rMzl3YlNib1FZOWN1UTRsaW5G?=
 =?utf-8?B?MlkvUGRIbWRLczhCUWRLcjZibno3Sy84dG4xUDJkT0duT2E5RVNjSzhPR1F1?=
 =?utf-8?B?bEhjSW5wYnFEUUhTK0ZySzBpamZ0NktUNjdHS1pnUk5BaDB4WXd1MCthR3Uz?=
 =?utf-8?B?VU5xS2hKQk1BWXZBRVZXTkZnT3RlN2N1alYrbXRsbG1jMnlKR3YrL0gzZXh5?=
 =?utf-8?B?ek9VYXpORk52Z0VLUnhXZUtBUTNkQ0UvMXRtRHpaQXV0d0xFQjVZSWZyV3l0?=
 =?utf-8?B?eFBwcHd4bGczczhyb3lWNTBOQndYSUdJYlZzUnBnMVBUb2lsODRVazRQNFZF?=
 =?utf-8?B?MlR4Z2VtajgwUmJWaFN4RThWMWZOdzlHQ05TV2FVNUxndndtZXRnclpGOFMv?=
 =?utf-8?B?Z3lGVm9waVVPNWZaYklBUUt2UzlnK1lhREhIWWZSSnhMZmZyQ2R4STRzbExO?=
 =?utf-8?B?cU5HU2x0WHJuSFdmQkl3QzNDUG9JZVQyMXUxajRwWkxqdnFDdVVnUDdMTU1v?=
 =?utf-8?B?Qkszb0Zsd0ZHSEc5UHUwZWM0Nkd3SElyNmNoUGtaeHpXZGZneFF1SmFOcExB?=
 =?utf-8?B?dGluS0t5cDBXS1YwTlFuNEg4Z3E2ckpwVjN1b2RWdmlxS2hrY0o5ZzdVYXpW?=
 =?utf-8?B?dUVjeW4xYXB6c2ZnN0hjQjBveFJ0cHJoL3dqb0luZmtmeE0vbDIwMFo4aExv?=
 =?utf-8?B?VS9FeG1zNStoK0p4cnJRWmw3N3VNcnlWOGxTazBMRTVhUExDVnluOEo1K0hh?=
 =?utf-8?B?dVk3WGlZUll2RG1PSkdOb21NaytydU9lanprMTRkU3dpWnpTbW8xOVhKUFZF?=
 =?utf-8?B?d2V0c1p3TzJ0cXljSkRUV2MyNE1wYjljbEM4bEFUZmRiOEd6NGlTMWs3amJK?=
 =?utf-8?B?aE5ucnNaSWJVQ2U2Qjg0enZkNCszN2x4Q3NGS0RHMnZDcEplQng0T0VIbHEv?=
 =?utf-8?B?M0FSNTNwNlpFR1Jtc0JvWGNZREFJTTNRQUtzSUl5eVZuZllya2drOER5dmxx?=
 =?utf-8?B?OGdySzFCQ0phRFBDaVZ4VDVYMC9OelUyVm5GK0F5dW02UDdLaFFaTW8vcmdt?=
 =?utf-8?B?NlBnNmEyQnlCQ2YvVFBBSkl3NmwrZE1aOGNkRVp5YlgzOU5qa2F3MmVPQVB2?=
 =?utf-8?B?M2RYalVPMGlLcFJFT1BQbmNIenNMYmdzWE85T3ByZzdvSGsvZ2dWSXh1dnNV?=
 =?utf-8?B?T3lsbm9XbWlKTG9ZUmhMYmd1cWh5YVM5QWFuV3p6bzNwRWZySXBoSlFDMjNI?=
 =?utf-8?B?TFVhVk9XbGVLMzdCUGQxa1gwWE9LMHlxZVQ0R0t4QU1PK0tBdXZRSDNRUzZr?=
 =?utf-8?B?ZVMyQWdQRXo5ck04bUo5ei9IYldSUkxlaUtoTnJvVC85VDkvdG04V21TT1Zj?=
 =?utf-8?B?bmR5bDhhYXNEaFIxZ2sxR2FvTWQvTC9VVGRKb1lpS1hzQkJobUI4RUNDbEVV?=
 =?utf-8?B?ODh0eHlXQmlLalRqNjQzaXI3RGU1d2pFSSt0MWVXVituWUpKS3gyaDRISk1k?=
 =?utf-8?B?Z2FYOEJXL1RjbC9ZaGZPWFlTcWNZVU84UHlaUFlmUjFDOGU0cll5RTJ3eXFK?=
 =?utf-8?B?aXg4WlpxdFhGeENrbnBkODR4akx6My9vMVVhZHd6QWRXZ0lta3N6V0Mzb3NV?=
 =?utf-8?B?U2ZHYkxkN2RSZHVEMmtDOVlpcFpHQUlUNUVZNnE3c05rb3pFd3ZMTW96WjB2?=
 =?utf-8?B?NFBsbjhjS3hxM200Z3lTTkR6Zi8zeUJtNDh6Z2lSOE1qTm1Xb2NreDBsaE5H?=
 =?utf-8?B?MHZWQlRKNm45REphN2xuMU1FVTRITHBRaCtxVUhxNzNOUGpRaW9yWGlBRG85?=
 =?utf-8?B?M2FzL2owcGhhVjYwb3NZZkZVdWZDWVdLL1hvcDhwUVZuU2N2UXlDTFg1YmxE?=
 =?utf-8?B?V0ZnMTdnVnpVcXlEbE9KVEJnVFZjc2EzY002OXRrMVp2U2xTazI3RzVxcmVv?=
 =?utf-8?B?NEwwNE9TOVpNenNOT3Nnd0Rnd3BsUEdvd1VJVjZRYmtlSmp5eUFVSzRNcGZH?=
 =?utf-8?Q?YpHpEZVGFnxGbZ0FIX2We8JI2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5xh6oApa3tCQnFLCpFFLgvZvfs79CyIPD+66VOmbdbtHYit4ae1HlfCS+gVHl5JGbP/pt4M6hp+4WnHUNNtl0WSyj9CUdLQENo2SIaUgd+DOtBkrgWN3w/jNqWwWcMJun0Gg8sZruWJ3AOy+IVr//pUWJ+Zbvol1sZmwT+QKDNhNQwju0xn99rkB9PMTGqiJSeK72eGP3+/Ogt+ihzeWT62fh1Ix/aAnGa9td0ftJpnZp1BZoLpFs+CbhDe3/LxuXLY2tpNaJmSrqiceK1eTIszX/38ExYlfBiKVRU8o+Qi4JIqzkEAfPsZu35HoyeiJYjRjOpGT5tfAsdk8qbTol4FBKgdyv3tvk1RcTWv17BMeOnvzOseRYRDrFYn6rfzCy2AOgtM07SyexrhiJWLJDgpwB2UqFd55AjJXG9O9xSjxiQa9Ow/lb6HiL74PG4X/BMe0R6BRtbunBBIjaBB8ZqwNtrrgPNA9jP9eI6CVs9sqh+HTiWf065JAxdpY3dEf4Z8CASFApqdT997zTVin/Cu2UinMpaLg8+T3ZniWacWeoQU1S+L+UvmoxwqUIwU/2XLD/3hNjJXJ3bry5oZLt1+GNNjI1YjYDQKi2BGGsTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53315763-59b8-463a-02b8-08dd08b747ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:29:03.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObXB+sjYRZAV2Me55jecCa8UHwnFD9+R8Ccr3EpU+tByb5Kph2GQmFLFiaVJ7GxmDrgsN6EOkkfcHmuvq5roew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190122
X-Proofpoint-ORIG-GUID: VAy7q2BECtB9G8fRCBz7nrgMmYgZ3H6B
X-Proofpoint-GUID: VAy7q2BECtB9G8fRCBz7nrgMmYgZ3H6B

On 19/11/2024 16:09, Christoph Hellwig wrote:
> The underlying limits are defined as unsigned int, so return that from
> blk_lim_dma_alignment_and_pad as well.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>
