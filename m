Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8B1CC88C
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020778; cv=fail; b=ahiCJlDKZlKJLAISvsHCzxx7PzlTP44i37d85zWzUqtdwoTB9yztIswpw1LGfkMKW049OF+fDQwJoSciF2vljSNYa+NcHFKRIsHXWbnc5/1sqPye3SNswVUqXebNBOg4aWrriwlLEuIKiKyIxDjyLwQYrud7mrcoj3PExn0jqjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020778; c=relaxed/simple;
	bh=hF3VOjNTCYfz8JHZYFpoLIr0NOTyGYZTIyWNh+HrtNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgcPMXpOIEgcl32EuXLjpqHZVhke12Wnbc10MhjF0HUwbyfuXReohhBqEko+/Lu2RgN9so4Hw8ya/QsY8Mrg+PBmRQVzK/x6Q9n7HarZXgHO8gJ5SBLQ2h5lQSIWNpVeKbudlapbIIxKcCBiVZZ0JQ54t0lAJPK8szw+Fm1JGs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fnXk9DuR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EXzG+jQf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnXk9DuR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EXzG+jQf"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJCpx9q013419;
	Tue, 19 Nov 2024 12:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HACfMQ14N3B/WH+Yl+8cEc0XYUU0KDUA3gA/gD2ffBM=; b=
	fnXk9DuR/b0JA791L7eYEXHFSO03HFuOhIOH1eDl67l3i9zpq4UTWkbE69MDuQAp
	zdDoqYybuXIu/zd2hsdPrUiaGSE0uFdoyPDpjslPA1my7oxx14tm//WUp+smksRe
	V3cYtYGtUvgFA52pztwPBEF4m9vS7vN35OVMyb0nBEHLho+4Cy67Q/TIwQXo60Bg
	JGzRlGOaqfABlMoPZ/yNLX/5xnBhSw4W1KZn1JPZorn/OsFe1688lmh6Z6pMA/p0
	cdOd6WHtaXEQHeaiKW419e4vLDoWQmL0/1WeP987DZOOJunAz9zPcCOKckC5GY7+
	Fa+xvEBwXf2Lenij0/QXrQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc4vep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 12:52:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJBVevs039202;
	Tue, 19 Nov 2024 12:52:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8e2m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 12:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxaM50KKlL2P7F5jXX5VPUMbN8T265hTztsWE4DBGvbbiXh88QjJeDqf0R4Jp7xw3yJ4FoDhZVQAqQSpq507EehHFN6FIaoaqm+6hqYZC77tcOSbjnPkPAyz/JaTr7DyOB8L6//rt3lZMPWQdcnFSmb8nVvClQTglG8pneMdjIYpUD0KCoyWf+e0u8nya7L4eW6sknPe1oNkfG0hb85GxllKfQbQYfN0KaBWgM/Fl7Aes6gu8QVEzCMNH0o3LPxRwiDJ6AOg37tHeieCvt6eQQIQ1HNpn3GMuJbdREPijR2NaJ2exaoxZl+d/R8cFhaR0eQkLmEO4BZDSLVYOJqWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HACfMQ14N3B/WH+Yl+8cEc0XYUU0KDUA3gA/gD2ffBM=;
 b=IsMS/qeIc12xgdnweMxjyxd8KXjiLuSLccvL3l0fUEWwRvksvC3JIr/y7axtt4vCmD8UgOGhWUzmXxSU37hqEXM78u0Z9QpHSjIZHsJ1D72c8z9fBFR2ScOmc2JyvNqg7/uryAxAkywDNzyLWXGeYYaQaxWdwYfYT/I6AkJ2jvlxPWpy9KNA1lb0sExEdEKECfYFpk/QmtkE5Syk8x2hUncVxedFHAaKTWR232G82hqf0rBNj1rDCHKErDD5k3ePh/XJGshzJKqKk/SGIff4iXlS1pCGARobsgZsnXxerzqHd43NqmwrMOmbH4g7jkglgwud3nTv4SZztcx2gBOM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HACfMQ14N3B/WH+Yl+8cEc0XYUU0KDUA3gA/gD2ffBM=;
 b=EXzG+jQfHQVQT9OSQsAYXZEoLgd5ApU0hwx3SjT+Rzw1XN9XXID6KoOZljmD9WY3DJP/WwRr6lWuRcUBfBO/8MlAejrPyfC49HGKjUKxG8Sgr51jgL22/d8WNH2FejCqP8OdR+zOW38zBAkUZIqWeEb9/coMCI0Vyi4clb1sTe4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 12:52:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 12:52:42 +0000
Message-ID: <5108f61a-c471-457c-ba32-3003925a4de1@oracle.com>
Date: Tue, 19 Nov 2024 12:52:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: return unsigned int from bdev_io_min
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20241119072602.1059488-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119072602.1059488-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: f42e4bdc-f3d0-4204-2f47-08dd08990e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0s5OFFCYzcvTU1Ud1FhR3pRKzVrcVNjNHc5VzBuU3UzWXpOWnloTDFiUDM5?=
 =?utf-8?B?NG40TlYxdzdtNW8xcHZLV2pjdlllSXZqdTRVN1V3dG5jQzZtVXBsMzRxT1dB?=
 =?utf-8?B?ZWVZRG9BNUtYdy81TTFEK3U2aUhHUk1jWEsvSU5sWHo5cWRvSXFLNzFCb25W?=
 =?utf-8?B?UFltdVp1UStRb3ZrdkFBZlNRNEtkQlN3MUpQV3QrK2NLWG9kM1JrYnlqcGVs?=
 =?utf-8?B?QlZvNTRFNDhVOTQ3NVZSR3RlVzBiOS8weDAvMzJJMElwNElCa0ozWjZ5Z283?=
 =?utf-8?B?eHVRejBHc3JXc1VtZGp5N3o2djFjNXd6MTJXS2xzV25hMkNlNFdCZDFQS1Fx?=
 =?utf-8?B?RE5PbEJGMy94dkRwK3k4NG5RL3ZqL2NUcFM1d3BBYUxPQ3ZQa2h1TXNMQVhG?=
 =?utf-8?B?SU82U0RRNktrWC9CU1B5U3ZXd2tSWkFhWCtXMW5kbldzQzJZMG51M2VGRFpJ?=
 =?utf-8?B?WG0yUlNxMEI5NWJvTFVOcmF6NTZwZldIYU9wT3FDZUdhTlJuekFoS00rSVFI?=
 =?utf-8?B?cjIyS1RPV2paMkNxMTJmSFhYWVMvYmFYTVc0dkZJZFhGODRNK2JycVNUWDFr?=
 =?utf-8?B?YkNuN1JlVFNwSGlGYkprTURESGFnYVlmeFBRZ0FRSk1GRmdyelhKNm0vNDFq?=
 =?utf-8?B?ejIreFhTZzROYXg2OEwrbGZENitTcFJqSmtOM1Bud0lsVWRUR0t6NHBCaVZJ?=
 =?utf-8?B?Qk9yakY4S2FLVm9FY0U0aVducTc0ZEp5dnZZbTJsVkRVNmxlR3FTamdaY3Nx?=
 =?utf-8?B?QndYelMzSGFVV2ZUamcyK0FFaG9HS1M1MTJrNm9HV0JDZWVPMkRNcFNRVkVn?=
 =?utf-8?B?QjZueFBHRFltWDRUYnYzREE2YjEyNXFoTFFsb09EdHVlK3NJd0lOQ3F2dVc0?=
 =?utf-8?B?N0ZPNEk0SEhoenRGN1VMQUVQYURjUTc1OUpzVHJyODU2OGpsNVN5QklnM2VT?=
 =?utf-8?B?bkRLSVV2c3VaOWNjTkFkdm5HeFR4QWpNWnc1Qm11WEpNc1pRaml2QXQvS2Zy?=
 =?utf-8?B?VHlmUnNzM09wVWkrK0M3WjVyNFZZZ3E2MUgwMXJ1TURjV2dRcW83ZnA5eGhF?=
 =?utf-8?B?ZlladjhZeUQ1bzZpbFFmTFdEWlV3cy8vWVBCR2FJOGpsUGNzdGJ5YXU1NFJV?=
 =?utf-8?B?YlZPei9yOENUdDlOYmhsR3JweUs3bm1rQ3paQzZncm9rSmJiUUxRRVY2a3Bp?=
 =?utf-8?B?UFZMdTAyQ1J0bStWSjFWbG1SYi9ycmpYMHRCYlVoRlZoZmR6S1FBRno0TzdG?=
 =?utf-8?B?UEtPSmh5TnY2NjRTZkI1d1VWcnNXeStsK2d4dUJrRmJEaCtPSDBHR3JieCtI?=
 =?utf-8?B?em1CKzkxQ2ZvNU5ZZmFKZ2xieThSbWp5UjZpdnYwOHJJbVFYU0NZeFhNaDYz?=
 =?utf-8?B?cTk5amJnZU9ONmFDZ21seGJjQkRqT2ZnTTI4MGlINXRuZGdGVk9jMDhOZ3Vo?=
 =?utf-8?B?elhyNzM3Z2Qrdks2NHN3ZHEyTG1vcUxaVnBBQnFoZTRhUVhuRnk5M2tKYW85?=
 =?utf-8?B?TXp5M2FUbXl1NStMVlBwYjBlRHV6OHRNRU10K25pN0RTeXNUZDB4d21UM0E2?=
 =?utf-8?B?bGxQUDdHV2hlaFBaVlY5SnBIMFpXNkFnTHhwbkcyem9IYWN4ZTk1WENmZzR3?=
 =?utf-8?B?T1kvOW8zcTh0dFR5d0hCQVUxdlB4THJhNjZEbGVUUGU3QnVicDIwbi9YdVg3?=
 =?utf-8?B?ekFBWll2YmZ2a0x5cmJCVlpma3pNdWVmUWNSLzI4a1ZPY2RwcnhOS0QyeG1U?=
 =?utf-8?Q?VaPUOo325maI+2a+AsVxSL24lmkk5tMjSsi/tYs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czVFMUljbS9ra0hOd3d4S3Zaa2lSL1RZOVgvcVhJQWpCMXBnYzlESFRUU2p0?=
 =?utf-8?B?T2NER3c5dkovS0lYUDlwdG1SNnNoZ1IwOCtkVUZqK2RFQTlnRHFZTW9QS2xX?=
 =?utf-8?B?NUhXYzlGL0lxeGRId1EwTHhxUlV0MTA3QWZPaEVlZjdsRW9WUDFiRHZOZkZI?=
 =?utf-8?B?bU9OTm5LcHdlOVU3MjI2SWNVcXNrajRCV1IwRWd0VENyVWhiUGhzMEtuazF0?=
 =?utf-8?B?SWRENnB2am9IWHZkSE1Md3NCSE54azBCaURmeFNuSmFqTjVQWXlRV25pWk5o?=
 =?utf-8?B?UzE5TWMyYVBVekh2YTY2NldVK2Q0Uk1jN1RZOWZwZU9zRldONVFuUGhBMVQz?=
 =?utf-8?B?VHRPQTBYKzc1aEY2WWtjYlVFVFN2RVkxOHR4YWtSRERXRWNMWWFNS2ovT1Fl?=
 =?utf-8?B?NllaSHl3L2V3aG9CNWNhaXVPRmZlSVVuS3VJdXRRcWYwa2x3dDZPc0Jza284?=
 =?utf-8?B?L0ZEajFGZ211SmhxSHhJKzFyT0xZQk9wdWxJYXJjVzVsZ3cva1NkcjU3bTZX?=
 =?utf-8?B?VDlEU1hRSWtNTTF2eEpTVndUNnJvZlRIdkNodnJyR2JRTE1meXJGaERodXpw?=
 =?utf-8?B?am80NjhZLys3ZHpqUDIxc3ErTFE5UDF5RHJNeEpJaVNVeGtBL0pveVJoZVJ2?=
 =?utf-8?B?VG5teFIwRnJRYXRDWUlJZ0ZBeHdXV0tMVnFQY2k4d2huNzdrbXd5N0hkSmEx?=
 =?utf-8?B?Q1FKNHJnajJhUklUN2NLWXBOKytEeVMySVpGQXQvN2tqRzJ0RTJPMHpEMEFQ?=
 =?utf-8?B?TE5jYThXVVl6dm5YRHhyU3RCNnVrUzczUWd4TnpTUFpIcEcrWnE5eDZ2bDU3?=
 =?utf-8?B?N2JZWGRuQ00wZjRQYmJBM0FSZFJPdnhBZnNXdCtmVUZJSHU1Ky9ReCtyL0Fx?=
 =?utf-8?B?eU93dVZHcnlZUjNSbEpGMG1Rc3dsUThaSjJ5c0MzaEwxMktqRGNYN21EOWlZ?=
 =?utf-8?B?UVhiS1QwNmFkeUhKbzVyQ1VwUmxSU2RBaklIald1R0tPaGVhRDN4VzZuVkhS?=
 =?utf-8?B?SVVScEo0NStkcXF6c3hNK0ZnVnBKQ252Vkh5ODd6bVBxZ2dwNncrQ1NMTVhY?=
 =?utf-8?B?amMyMUVlM0F1eWdaRUlGbjFsUll6M0lsd0Y1bTRmeExEWUpwNVFWKzRmUzJD?=
 =?utf-8?B?WGhMVER1MmdFU2xqdkpPK0gwN1A5ekxLakdudXZUVStBUSttMmlWMW51dEpW?=
 =?utf-8?B?MTZwUm9EVHovcHZXaUhwZWRXM1NtVllBeDFhYWhXNE53Rkp2R2NheXEwZFN5?=
 =?utf-8?B?S2hkWmQycW5BTTg3MWRxc0FYcHRnNThCOUQwbWJUMzUyU1Z6a0gwQzlkQWRV?=
 =?utf-8?B?eEFjM1JFbXlEamQxYzVKNjExUGpaQkpkZlBXdjFNSDhFQmIrdXpvczl6Smlo?=
 =?utf-8?B?Wm9JQk44WnBKRFpiZDRtZVlFNFBUN1VYUFUvYVhNcGdsdVI2M1QyK3dabVVZ?=
 =?utf-8?B?QkVVckR0TnV2V3UyK3VqTFBXSWo2dWdCTy9odGNWam04T3hCcmpVUkswRmhN?=
 =?utf-8?B?OG51V04yMEFLT2dITUd0NmQ1d084L2RCd3FCZGxPZlZKc212VTdiQ2FvbWFn?=
 =?utf-8?B?RHQwMDE4K240a0FvUlRXVTMvczJ4ZFVuQ1lxbXBuVDlNUS9iMnBkTmt4WEdZ?=
 =?utf-8?B?b3lsUlF4Z0RTRnl0eGU5V1I0WldZbXU2bURtNGFJZjZEbFdvaWZKemRHeDgz?=
 =?utf-8?B?L1FTU0hTbXhkbEI2OVVUcXV1NUZWZFlHMGVSNU5WKzdNRG9vZEpnblFNZjkz?=
 =?utf-8?B?U3UraXlkYjJRS1hKTFA4bm9tRHFiblpqeHNUSGwyT2JhQ1U0TDhuRjd5VnI2?=
 =?utf-8?B?UXV0dnpsd2YzbXhuQzFzSkNvUWhhVjdjODkwQitTdjduY0FmRjloSzVSd1hv?=
 =?utf-8?B?VWlHUjV0bVg2VTlTb3hzeG1ISlRPRWU1eU5TMXl3akF4VTE3aThrTUpLVUdD?=
 =?utf-8?B?YjhsNHFUS1lGcldScjE2Y0ZTdHV2K0tFVmZrQy9SK0ZNa3UvZTR5K0FKOEF4?=
 =?utf-8?B?aVNlQVM4U3VyK2tjOTYvS2FSVWxCTlZnRUtnMGg3MHBmYXdvLzZSWm5lcnlj?=
 =?utf-8?B?bU9SdGx2TzI4dGMxVjZrL3o0UUlqZ3lxVUF6QlFnTk1GMFBSMmxrL3V5M0hC?=
 =?utf-8?Q?wwYk9QMwBHysrn4V0fPtuLNGu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XOCREmu5wMQH4MSs45YY59Ts4H3ZD5dIr6cZalPKS/91+p0WFlmsC3cZWjeqYosKPj+v9RfLHoYr30f8trNL9wIj5VB99DHFGdiOh4YAMTW7wkDUJ9QoyYYBJGyRUyHYN974EMcxyVfAH5hd8omL6RN7jcT1TWchOMPXJUM7/Fy7L2E8pPtFXlLKtjXL1IG8RXj370+toYTTqcjX9FmMFPmb7NoXE1+rQviwZvu3yFL53Ue2nVg/K3EcLihA2nK2ghJhUi8z0Ncuia3XCzSW9NNtnnirZbRD9+/nR6OB+XFBf76KGOGF0mzEBds+20pLfoAnLWuESzNFBF6/bZIdbh/s8F38U9PsBb1nAY+EYl7Oq8hL4kxYtBlH7jsmIHCQhiFXqTh1e30xo+fkMZSr9vbw/xLjJJ7jR3z8sh/rVX+NgL0DbKYqrg2af8WYAWOtSS8aHPl0puVaffnppBoqbiar6QvYArxw7IQweDBQnVyJPoBgzoyt8nKNWGZRLeU57C4VNBn4ey7O4nlBsfWh68NiHJtb8DF53BcUsV+/UfcmZ+7ArIAVINOrAURU92DzusEdR4ETje79ntMMrfW5VkyMO4eay2MwbKw3SP2aZV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42e4bdc-f3d0-4204-2f47-08dd08990e98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:52:42.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROe1eBc4ZXLWFSkEp7hAlKF5QQY2p+D50UmRx6A6T8mnDpnMajt0c2q9M8F/4MvCt1vsw1QbOkEVDxc/nnlZkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_04,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190094
X-Proofpoint-GUID: 4ha6TUDvrctYXEjnsjmfQCKTdoH5EWxV
X-Proofpoint-ORIG-GUID: 4ha6TUDvrctYXEjnsjmfQCKTdoH5EWxV

On 19/11/2024 07:26, Christoph Hellwig wrote:
> The underlying limit is defined as an unsigned int, so return that from
> bdev_io_min as well.
> 

There seem to be other helpers with the same condition.

Even bdev_io_opt() is defined as returning an int, but actually returns 
an unsigned int. And even though not a bdev helper, 
queue_dma_alignment() is similar.

> Fixes: ac481c20ef8f ("block: Topology ioctls")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   include/linux/blkdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 00212e96261a..4825469c2fa1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1261,7 +1261,7 @@ static inline unsigned int queue_io_min(const struct request_queue *q)
>   	return q->limits.io_min;
>   }
>   
> -static inline int bdev_io_min(struct block_device *bdev)
> +static inline unsigned int bdev_io_min(struct block_device *bdev)
>   {
>   	return queue_io_min(bdev_get_queue(bdev));
>   }

