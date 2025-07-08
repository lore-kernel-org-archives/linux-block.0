Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69322AD16
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998743; cv=fail; b=nrt0AxZew7U6YdJu3EtY0Zj6jnEjl0BoLRXIXcngmCGY2kNb8011Vl11aijYKCA0BTGZGyU/ugGJKVHrKYpuDsaXbIUwP+CaufCrmHEAoJizBYYdSHDqs/rb/gZoPVHy6467/5m2+GA0g92055PE1hbMlUfuYbFb9iaRH3ijY9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998743; c=relaxed/simple;
	bh=KNQBFKIhPdZXHM6OKc1O5K3zPMkN027dfMh+f5/9Sz4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VEKUklojn/SKoZsI9HG6GlNgh9i5kD6NtDMvwck+kqdCZ0gRMmdv2Onm223rHgJPqOvKdQzxXCtT3Yqf+JUfDmwv2gYP7gvAA8ei+Xbntq3pFw+pQ0alGsYJCJXKWM5QCEoaqUQrLZUA2HYk/QJ5SiRepSeRut2qSOBANzcVj7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N7vdw0K8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dQ9hWHiP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N7vdw0K8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dQ9hWHiP"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568HbFCC029048;
	Tue, 8 Jul 2025 18:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UcG1/teV+3+xy6Hay7UkLpMqbBKRPXuVXt10tIoqqN0=; b=
	N7vdw0K88lvhqHY1MM0GWUA+m4CGSf/qnwChLtGRwaLVQP6Z5UiHvHl6l5c3hO/Q
	v5MvwnkAlUcG8OEl4CzmRqj9NCiibd2ZCAh8174ezM4AVYgpQXJgU4Wk4GtDdE62
	kLAOZSBTMsFEcfCuM28O/1a+hBigwWxbK3IcU6RMk8xY6zEVJMAa5/K2ydztilLX
	US57fpJUtUw98IXW6aG7/2eGjjjw6prDt+cohh70mc5t3/KMQsHlim0fZlnyyTER
	ezThPhNZbRh3pQ2MoP6uAtp2dK0nUwRRF8Hclh2ehhsOliiGujDVLUSkUqDI9A0z
	qNkZ83T0h6Y26AVrs4N13g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s7vsg2s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 18:19:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568I6Eiq014068;
	Tue, 8 Jul 2025 18:18:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9yhyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 18:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArRJK/9hDEW/ZfpRsfviqGSX72k/w9BUrxD31JslXodpljiuf7K81CxY2QzgXgrhNoAl/5LjvpFEsTDUDxP+lNQzDHrV9eazn+tshZWV3GslpitMvZ7tBPzuB61xemIJeaTKr43y+FjPy6zzLc0bCQF7hcj2N+E+TydwhZT+iHW2uwCI/aELWJtpczfKYwb1SGi01DRqRL5ZvkLomKhm3L2E76QBgu+u/mV2t6dJf4a4JHPdT2/Q6x7raAkMteOBWsDFnk7eokT4qquO6KFiIKVsMsgfT7euU0FRGHslW9kgUMDpR3sXlUWMWXF4UwRVawHSPCpH5M2nD+0fja7dFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcG1/teV+3+xy6Hay7UkLpMqbBKRPXuVXt10tIoqqN0=;
 b=y735RiblMYdEG/PEWetq2gNMH0v5l5JxeZrAcDvwTGIt4LQsqGmX2R0A475wVG+p6iazd+apvFsdOEcUWgwNv2btQrQm2gmb6VxrZgODb7nMFrr4OIwf3ik2dW6ULdU3JS2yZi7hVkL+Q4EG1Yq122w9NJGpC4DoCNAdq8h85dsI0hZcyUuzQdBO79WGCFAaqbXrSNf3eFtHD8luEeLnR0GaSEjCudk8LArTc66oxyVwMge4nFlf1bssvbDYr6fOmCkxi/uZyb+R61y28okQAbxectCaZ1P5dcA5Ahlu/CiTxrgCRJhw5ObfYvWca80F+KB1Z54bz+lvrOfM/7UyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcG1/teV+3+xy6Hay7UkLpMqbBKRPXuVXt10tIoqqN0=;
 b=dQ9hWHiP1NlmdlWC+9kqDMPyQE2sXJsM56cKo74IxlOY2KSfM6y1ECntavsl2LrEJRbD8WdlcJcPRQVHO8o17pQojFUckD3vFJVskXVsz/VyMwQSZkOKBgy4HdCKvgD9TxpCPRvYQhDJElTXilsvAaiCDgDN1rESI1I6lwRT30c=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB4597.namprd10.prod.outlook.com (2603:10b6:510:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 18:18:18 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8857.036; Tue, 8 Jul 2025
 18:18:18 +0000
Message-ID: <41c4e8a5-9adc-4847-8bc5-e51e8299b15e@oracle.com>
Date: Tue, 8 Jul 2025 11:18:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] md/002: add atomic write tests for md/stacked
 devices
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
References: <20250708113811.58691-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250708113811.58691-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::31) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f22caf-af38-44d9-dff3-08ddbe4bd01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STNWcXl0K1dVVGVjTzJzK1EvZDBiM2o3RzV1VVN6M0JnZkNDVDAxUk5TQWlO?=
 =?utf-8?B?TExsdUQ3VTVvS3lEVUJYMmdNZ3lGdFh4OC9RclZCRFA2YnJUL0VsT3dBYkhP?=
 =?utf-8?B?NnorQkk5T0lGcTdRZm9kVVc1VTQrTisva2llRWtoVnkyZGFiWG5YNU5nN25F?=
 =?utf-8?B?WWNoUUhFVGN3QnpyR3FSb1JiTVBmcU42ckd4RU9JN085VmE0L0hRdkdVeVMw?=
 =?utf-8?B?VFpLRDRtR1A3dkN6YlBPeWhjVmpyMGZBcW52VjlDU3pzRFdiOTRHaXBFSG1U?=
 =?utf-8?B?VnBOTEptY2VzdndpQzJ4TkNCUWVDRnJwMklwbnJsMll1VUg0d3RnQm1LVDg0?=
 =?utf-8?B?bTNIZXpQcUNWZGZ3NUtqWCtHYVdLWE0yMHo2a20wSjZMbmQxdDJSTjFFYnNL?=
 =?utf-8?B?QkY1UVdmQUU0c0U4VnJHYUxoZXd1dWhZMElWUkhIdkRVM2xWWGJPelgyTEJx?=
 =?utf-8?B?L0FTaEJVWnRBbDRnUHptVjExWnRvd0ZTcXZvcFRZck4rMWNXa3VVQ2hxVXFw?=
 =?utf-8?B?bXpOUlFyWDA4a3hYUlRyTGFkRktZM0xmVDZFdEVpM295U1RVYXEvNnM2V281?=
 =?utf-8?B?aTFleXRkU3BBbnk4WlRrTDdMdXNLZDFvbUVHcEpmOGZmWEJqZGF6cTh0V2Qz?=
 =?utf-8?B?MmdqZy80Q2NsT0pkQk1qTjFMbkpXUVJzMUE4RmM0TXdqSG1vVkhHdXNYOWEz?=
 =?utf-8?B?bzI4eGc3dzhueHZvcTJFWE9PNzFqeTU1VVZhNnBLczVEVnkrNm81NHhSTkpS?=
 =?utf-8?B?VmNGK0QyM05VdHFJQVJ6RmlMV05tTSsvZjdmellFV3FnWUMxUkxCZUdXbzE0?=
 =?utf-8?B?VFEvRWVSc2ovRHpSWit1b3NxYzBramt5OU16azNTWG9SZzFXQS8rZUFJQXpu?=
 =?utf-8?B?MXFiTVVOUDZXRHJKZWpBYXNucmx6QUIwZ0lNM29tVUlWT0VwMEFTdUZzbDhK?=
 =?utf-8?B?aXBLZVpReFZISEx4RWhLbjNUbmhpNUpmazBFSW9Hc3k0eFJwV2JYclNoUTc3?=
 =?utf-8?B?OWtlYmhKc2R1TmxqWWlSakg1RTl3OE13T0FMRStWN0hRWDllbWdWbDlmb1FG?=
 =?utf-8?B?ZjhzTlJmMTJzanlrWEo4eHBVbGo1QUN5Z3dPSmZJYlBvR29sWkVxRWN5TjVa?=
 =?utf-8?B?enJ6WHdxWVdmbGhrejAwRTVKSjYvd1NuakIvRG4reXVoVHl1N0gxSWZVTmZz?=
 =?utf-8?B?ZnNmNk03QmhpS1dFd0VWd0xOdWVRLzM2K1JhWERTbHMzaDIrSjYvdEtwM2VE?=
 =?utf-8?B?M05MakdPNG9RU2J0aGhNWWVPVGd5Y3h1cVZ1L1pjSHBHbFl5MkVpOVUwNXFs?=
 =?utf-8?B?dS9Pelp0aVJwd0JtU3VaS1haODV4YytFdytOV0dEYzJhM29XaVNxU1pMQmRL?=
 =?utf-8?B?TFpvcHJnc0hmR1MxVzBQcFlPTzRwRDQvVWJxdHRHc3BxNVZrWTF2aXJUdGx0?=
 =?utf-8?B?cTVvRE5kMnZFY2JaS1ZZMHdxN2g4bmRxYU9qR3JVeE5GRExtNVhUaWk4ZXVJ?=
 =?utf-8?B?bEZjMmY0NzdpS3NSVzcxaEtneW9WQUIrQkRZelFac2NHZm4yYzFRUGVBSkZW?=
 =?utf-8?B?UjBlWGlweWx6RDlOQUtSUVRNU055aUtmRnNiUVFBV2hLdGJjQmErVW1DbjJj?=
 =?utf-8?B?NHpTZWRrVXZZQ1VxbzhxY3pmWXJjOVZCVmZ4RTJkT25WQTlPZVozSStlQkMz?=
 =?utf-8?B?QTlUSDh5YWtoaDdMbkJrU0ZRUC91ZkJFMHZrbHk4VW5YUVlaRnVHamNVZmdt?=
 =?utf-8?B?WUw5OTdxTnhHL1pFZGFqOG5IblYrSk13NjlKVWkwVnpCcnVzVjFMUThhYlFY?=
 =?utf-8?B?WkorUDJuMHlZQ3RwbElKSkY4dHV1cHArUmFUYmNyNlJybFNacWlNT2duNDF5?=
 =?utf-8?B?VFMrUFdmSEd4MVVTZTc3cTh0QVVpQWljVjBwSGlUbHkyM1I2bzFpZGtRVFZa?=
 =?utf-8?Q?9uGuYZPnPBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZ2aUx5SUJyWmd2dG9FRGZQbkk3c0xiTnZiVlJoSTQ0a0gzU3EyVFliTWFp?=
 =?utf-8?B?M05EK1I3OGpGZmVKNm1tM3N2R1pGSGdLS1VBRFFtVHZkN1phOFNDRjVFQ0ZK?=
 =?utf-8?B?b3BCL1hUd2pJaWVZdzlDajRQYm9STUdVMHhvbFRMdE0vb0pjRzFsU2grRDZP?=
 =?utf-8?B?TGVjeitPTWljUFMrd1YvWk1RSVVNTldtMDNPMktiQlBySjdyc1pTelVJSkNT?=
 =?utf-8?B?OUxmVXNuSVVaK3ZpQ1lxKzR3RUs3UmZHTUUwYzhzOHJMNEZHdFBBb0dpVHFD?=
 =?utf-8?B?VkhEQ1B3V3ZvM0pTdTlSVlpaL2xSZlY0WUJ0eUJWaGxzSTNmRm5TU2lwLzVB?=
 =?utf-8?B?SG83clVBYzROeGU4VEVmaXA1VGYxdjRrQVllV3Bla2w0emRtRURkNjFMeTBN?=
 =?utf-8?B?TC9la0pwdUkzN3lCck5POGpLeHJOQmtNMlBtTlI2U010UUhlUVRjQmx1azc4?=
 =?utf-8?B?WjYvNzVnUzEzbVQrT2diTVJmV09tZlBwR1ZIcEdCWFlUa203WVB5QzJxQ01J?=
 =?utf-8?B?MzRlTFJEaU9DRW1GTXVUeWJWTDlZWnJBbkRpa3BRVE5YQWc3ekhOY1VtM3c1?=
 =?utf-8?B?YlBuYk9WdmMrZ2VrbTV4eU5XSTZZVWpDYVlzNlVpOG1RZHNIZGtXZmZDR2xp?=
 =?utf-8?B?M0hFclpTS2Y3UzJPanFORWlyY0cyMVhYUllscEFPUzdZTFloM3RGSkxSdWZu?=
 =?utf-8?B?STVzY1NZckVMaFlhdEFMMjFlSkhVSmVnY05DUnRadzU4K1hNWUVjSUFMdUxz?=
 =?utf-8?B?YmVNejVwMjcycEJLMEoyblJZMFBUQUVsZi85c1NsTThLYmFTQXBOejFkT3lQ?=
 =?utf-8?B?dmYwWDBrWlJlZ2NHbWUrc1BwaStOSlhXSU0vbXRWTnRxejF2NU90ak9IQjZ3?=
 =?utf-8?B?dVZHdFNZZEZnMkRtY2dzNUkrVkhCNEFXRjZTN2dBL2hydkJFUVQvMFJWZWd6?=
 =?utf-8?B?TXdNNUxLa1lRWndNNWxxTTBwS1dTR2ppNzVPeTdPSW5oRFdLN3krcTBZRVNZ?=
 =?utf-8?B?cGdaZlRyZkg5cDllMVl2MHE2VGZvKzlNOG1IM1FvRVMrb0FTekhnb3hXZzlF?=
 =?utf-8?B?eUVPK3BiQUt3UWRLUlkzSWU2QnVaMXNyQWVxTjRMdFFsWWMvUno0SkdsWkVT?=
 =?utf-8?B?QTZURzlvVmtkd2cwL3lrL2hOTjFFcGFWdGM4L3BPS2ZPWWxkcWI4RzR3T3Jx?=
 =?utf-8?B?YkFQWVNRUG9ZaTJFZ0FZNDhtcTl5bTRvZzBPcHdzaFkrN3VOa2ZTNjZ3cG5C?=
 =?utf-8?B?T0daZm5uTVJKc09GNHdGTkF0NkpLcmxNWDBScC94Ny9POHRrWGdxajFaNWFi?=
 =?utf-8?B?SjRqdDFYT2w0OVdUb0o0djgzWlY3VkkrWFZ2TXhvbjRodHg2V21NQUN6Q1NE?=
 =?utf-8?B?V0FSQi9rMDlDWmdWc3hPZUZ2QisrZ3ZhUngyeERUQjVwRGFPeks0UVhSRmRB?=
 =?utf-8?B?N1ROVTFrMnM2Ymx6cnJYM3hqSllzeEFKZjB0VHZKZFdJa2pEcEVrWlFEd0Ev?=
 =?utf-8?B?dW80NGU1d3NEaVNXNnZzdk1MRmJaSUQ2cnVRWEVkbjNqdnFFanQwUVo0RGNo?=
 =?utf-8?B?OTQwSzI1Z2dVcURQYzVseE0reXZHd09EclZRazdaQi9FZTRqbWlRdGk4L0g2?=
 =?utf-8?B?VDAyOHhsS1M3VEtDeWNjbDg1Q1FLSGZaSmtSaEE5YlpqVE8zNEo5WGd0bWhs?=
 =?utf-8?B?Z1NtWGFXTjBGcVJZbzJLanFKR2IvbDAvL0Q0UndpeHJjNUl0aEJoYlFBTHV5?=
 =?utf-8?B?Y3dHWUIvMFdDbEpDSHlCOSsremtSWVAyS1BNSE1NSmVKZlU3YjdONCttaUpH?=
 =?utf-8?B?ejZYc1U2anlaeVlDRlF4dkxVbElRZEpuRFc5NVAzQ05lWWdnaDZpYmEyNGRi?=
 =?utf-8?B?UDNBWmJTbUYrQ09LWmJWdVVlbDJzaklYTTZEcUZiaUt1RlFkdXZvcjlKYWRM?=
 =?utf-8?B?Q0JmQnhHVzhVT3FuOWJoTWxJZ1REOWtndjJyYjc2OU5PL0tEQ1NJd3VyM1VL?=
 =?utf-8?B?UGdxZWROMmlTQ3FmakZ2OFhZK2UxRElLeGQwalNNa0Z2Z0pVaG4reTBDR1pr?=
 =?utf-8?B?elVIZFg5ZHVKak5aMkUrRE5mcWFTZlhnOHkvNVo4YkkrRndWYmRrcSszNzFy?=
 =?utf-8?Q?XBXdRski2VprtfvXVQ0oW1U8f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WvW2nXHYgvJneuwvz2zoYvvoPTBNNYiTWgZKHFz6E/IxIkgJ27LYv9CBH1HZBeB1IJXc3E1cK6nfURWi3eJBUXXCyhAQuSu+i5C0fUo5ToDnKOoKK1v3M4tuTxdUwtkLQsM3pbYkkl+J9SkhpdL7Ildg98V/KWUeJfHg1a9K78Pu5v4/NDoir0Sny2C493fkNLPbM94xhNM3B5/8J7Ytw0Kr0wBrl//Fhzl4j9X1FDTa/A2ceD+FksEBk/byAhGqZXHVwO/jHiq3IIrHoedhimn4GRgZ82TPV9gsLTaaQ3NQ7ftCZRFrpCo0YaUCbssvpZD3J9R2ggbjMzO7cFKrWswMEeoOq6/6ywOPZ5A7xc41bisgs6IoxzMMey64k75ZDpLWosUGS41JViBKCRY9Fx2qORWWgEEMRr1hICQoltq7Xz5AYmUvcv82014OoX7fSZGlL/q6vt4cUXj/NlzxD5AtU8HGBg6I1YoquVNp2KtdE0ged5F+fYFXh5UAhn4F2Jq3kfi7vIsjWZckdQ+xy4/cbXHYxky2W3asHI6kkVFj5H+pbcAefdykFPBPxLMg4U0dczqFz3svUTKSJYC0ePkzYdgCMqChDs2sPUZ4i3A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f22caf-af38-44d9-dff3-08ddbe4bd01b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 18:18:18.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGSY7TQrwneZqaFsHgK5wQQAfW5KWpWPCaz9+WdVov70HGwJDOuzdd2oUAUosIC7atzVtMJPWxcH133ya+caQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080153
X-Authority-Analysis: v=2.4 cv=dYCA3WXe c=1 sm=1 tr=0 ts=686d6114 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JF9118EUAAAA:8 a=RA1KEasWfPbDoZevr2EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf awl=host:12058
X-Proofpoint-GUID: AjFuhW-hla6eRVYrIPbopdpwf0SRwaPD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MyBTYWx0ZWRfX3pT2B/JJJc12 PP55QZ/u29mpk8+1X0Gy5K5iaQSit4syePg4xg1jF/H9FUxR9BxHzdZHLpbJQanEGpxl6h9sxFm cGvv2PQ6m2MVxTxao1jRd7lRUAapsh0Qztzfpb7qYDd8yssAuDcKC6LzqR3GGqxpjKz5rmTdgCn
 9qiPll/EZKzy8g2FD3BabY8hVWqxjEYIo61kfWEsHdMsZDLwJ9Chq1UCw5DfAURns4z7EJj0xNY YMTWJtxoR7KViGpIuCNKzZjvEO+zasqy8Rp8hWgz0edAHfh/BpLCJIxCFirCcPeMmD5ifE5iBgN lNHsFIpFQJidrFNbCSyHMgtB4+wDQTLYfcRGzeQVNsjtMH7TKsKaAMrOe2lVfNxctXgp1ntxTc0
 wHj/+JLRzB7/M1FxXlOaqGJpomL63dxhA+zdnppynXscizqgOL53sG/9/MNqXjivdYgRBA5t
X-Proofpoint-ORIG-GUID: AjFuhW-hla6eRVYrIPbopdpwf0SRwaPD


On 7/8/25 4:38 AM, Shin'ichiro Kawasaki wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
>
> Add a new test (md/002) to verify atomic write support for MD devices
> (RAID 0, 1, and 10) stacked on top of SCSI devices using scsi_debug with
> atomic write emulation enabled.
>
> This test validates that atomic write sysfs attributes are correctly
> propagated through MD layers, and that pwritev2() with RWF_ATOMIC
> behaves as expected on these devices.
>
> Specifically, the test checks:
>      - That atomic write attributes in /sys/block/.../queue are consistent
>        between MD and underlying SCSI devices
>      - That atomic write limits are respected in user-space via xfs_io
>      - That statx reports accurate atomic_write_unit_{min,max} values
>      - That invalid writes (too small or too large) fail as expected
>      - That chunk size affects max atomic write limits (for RAID 0/10)
>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> [Shin'ichiro: replaced spaces with tabs, removed group_requires() call]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Alan, thanks for the patch. I take the liberty to modify your original
> patch [1] to reflect my review comments.
>
> As to the kernel version check, I left it as it is since I can not think
> of other simple way.

Sorry, I took too long to get back to this.  Your changes look good.

Alan

