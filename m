Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9972E57D
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034087; cv=fail; b=ZzVYjphng7tuy0nD5AEG3DlUqGhlO/APDza837/EuuqEDKYxRjf9EB+W6voa5YB4ojWBMlSTCu2sOQNfQvuVoRf059BGSTqBfaQpDehabof3YLOrn0/cEseYhFTgep4PSCLeGu95c4jrLZaYflxWuLiDm6tX5fqE0XUa40lVtsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034087; c=relaxed/simple;
	bh=F0hDH74GXjMyzXaEdH1syCoIC3cbAy9XUXyayt/avR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FY4YECJkNG5WzBU7Kq4sY88EVKhSMuMb/J8qAIEYTB5hI+F1BkutOYGCG/6ZpjLkv/AkcWv+F+M5f5YPDw11R3Ol1h3hog9CZddbHYbFUbFw8sdSiV8THgBXtPSDVItFWjJ0Sjq7VWoOJw9D4A0EBZyH08nRCzONPna9hGfzrr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h1X2EZBF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E9g92N1T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h1X2EZBF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E9g92N1T"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGMXqS002640;
	Tue, 19 Nov 2024 16:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QEtfm0DAiRFUx1QoCHMDVYCJuxu4g5Pc4RPCBxoq7dA=; b=
	h1X2EZBFCDr/5q2KhgXgPsWO43Pxn7UOkcfmHSVtrnPfTY7OhMSa15w7XQpHDB2n
	s1udIuIrXsfw8XjxCxuJS5+VEfXV3cxreua1qUFnF7GmQqAcIwYJSxE4G3Tc7Qbu
	yhlXYYmhOfFbpYkOcXVIZrlxLdYj+kRPK2Dyki+y6Cz5VKx/iFaAIxzngr78E99v
	7wu8huYdSemSiDM39N/o8cH3zeSKtFVUAfdjmv6vRHhDxXd68hReOR/Gd9aKvpwv
	4MFywlma97FJjwcWaSIXZrO22jC4+wkA9ua30+A2LtKjqYydAEgi9RNA8lxk613K
	C/nGsDgdSNI3yjmOFcB+gw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebweg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:34:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFwnCQ039178;
	Tue, 19 Nov 2024 16:34:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8qcvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mI7ppDRGv8tPipN5rgqNpIu6EQ3U6mE6Rp23M/+W4Owvgkng6VfaPj9lChzss4xUBxiBAF5/OZ9JU0pbQ0tzLCKC0RYUrTRAC4dXUUQlNy5VNEhwuISmsE0xYdINWJ8MIuojV21XfEsF0wzq8GLO7zz2f4FTkZ1df60RIdusK0huGTijIzIGhTsJmSMtYAoC3mJm5GXvVvn7D0c1XztBYMQ8jd0AZxN63TYSrtCrARkMhfdMXoEzxESVSSfvsfIkPPK2KJgfX2b3rXs+bfsa7Y7xstTjxkJpGmQNXdWgR48uxawFY0ZsKweocte7HYw7RhITPSZhXnMqmFbyX/j+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEtfm0DAiRFUx1QoCHMDVYCJuxu4g5Pc4RPCBxoq7dA=;
 b=xZXH1aWxx5ir6A0TnLQhG8tEgpTRv24gqFwJRq1PKYYNvGzPqGYrTJQ3Nh83o/f0sYly1JHllcYUr08YvI2F0tCiu7v6kIxt+XNt1ginnrc454zpa4LYYNRjfD1b6u/OQftFBw+3f4To6VqIwgHjTsGQ5XbnpKiSJalfl+oOrA/iazImZHjaM5aATwUoheHL44UcGvs/ZRewe62NYHbrvJl/WJp3J59BWNov7XfCzUsIDDepS4ZsxhobkQgSnXoYFVZZCsdJaAuAqWHas+WKiVNlUWyddz1ERuSrcRzLnKRBJklUzwXHmSGSzB2HrujYLEvR0uHCMQCtrttOHPfncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEtfm0DAiRFUx1QoCHMDVYCJuxu4g5Pc4RPCBxoq7dA=;
 b=E9g92N1T82EuuPBBQeuPM7P1ppJeJnoyegY8FiCemZTNX9eZHAQeKCiE6Emn1i/T1M4eteex+CoIDWQ7zp4R+ihjSlPsXsVq/q6d1Oq1RCozOCy8S1XuSUyufdvoWt1E/BjjrJl8yUEcKsn1EpiSVjLoSIExLYpDJVAtrnidGSE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Tue, 19 Nov
 2024 16:34:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:34:38 +0000
Message-ID: <572ce7e6-b742-40ad-afea-a3ef65c02bed@oracle.com>
Date: Tue, 19 Nov 2024 16:34:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: return bool from blk_rq_aligned
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241119160932.1327864-1-hch@lst.de>
 <20241119160932.1327864-5-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119160932.1327864-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a015aba-8c36-4c56-efda-08dd08b80f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGV3VkovUCsrZFkzTGpRTUhDSkl3THZqM3VsR09HcnN0ZG5ZckNkaWlQamZr?=
 =?utf-8?B?VGJwZnJ3VXQrY2ExVlMrZDdGN2NGNjZzcllBZys5ZXFmcTliUHdmdGtRZWZk?=
 =?utf-8?B?anVxaWVqYnlRRXJLaWJKYjJCRGpmcmYxcWUxdU9ZM3RFMDVqdzdwdDBlTVZX?=
 =?utf-8?B?U1p1TXI2Mm1jK1VXZkNYUWlBRFFoeFhmOGpxL0lyelRnT3VNdzhDd01YUUJt?=
 =?utf-8?B?YVZRM1lJdUxKRnNNdjhFak1pYVY3a3ZuRkNXRitIcG16anltNituR05icXgw?=
 =?utf-8?B?T0V1WDIxYmZiOVM2TTBGY0JINnNXV3pNTkg0eURuc3JxclM0ZlBqeVBZb2Vm?=
 =?utf-8?B?N3lSbE5POXFtMHA3Z080UWk2bXh2MkJzNUpSTVR2MFdCQmhYaURJUXFULy92?=
 =?utf-8?B?MVY3M1MzSlZiT0JPeHhoWEdCb3NVdksyVVRkS3VmVzlsbVo2cG5sSnNCY25N?=
 =?utf-8?B?TURpZHRFcnNqVEF2UEFLZlJZQk9RSm1NdFNOK0N4YmxlTnd5MnBObHBweHYv?=
 =?utf-8?B?N2pOK29PenlpbzE2bHhlMFhKdlBvWmgxbERmVVhxZjc4Uko5cUxrY2VDTWND?=
 =?utf-8?B?L1c3aWtGOVRvQ3FkRGtkQW1QQStnT3VkN2Y1ZGtrS0lld0prWENicXM0azd4?=
 =?utf-8?B?ZW1vRWNhSURmUHdVbVBSSEdSZ0tPZzkwTU9FaHZQRGgxa2RMVm5XOUpiUnBo?=
 =?utf-8?B?U3puZ0RnSTlUelpJeHlFYWt6TnArMzVSd0g3cFpoZmRwUHN4bm1rQkFXbVo3?=
 =?utf-8?B?WktlZEZ6TnF1OVJwYUlYU0ZKOTd6M0FzbC8wUVRYTFFaVW5KaHhQMHY0RFIw?=
 =?utf-8?B?UmlzSmNzaXdyRnhEVUltc2JsK3NOSVpJS1VXTlBzVit4U3dFUmVPbU5ORjdh?=
 =?utf-8?B?UmQrZkxvdWY1WW5pMXByYTlJY0VUUnNtT1pYRDJrbUlpTnpHaEk4b3pzQi80?=
 =?utf-8?B?b2w5bThjOU95bGZOdHVhcGgwekQvRnBNWldlWUtwQ0hjZWV2d1YwWTlBbGVM?=
 =?utf-8?B?RGVtMW1FdFFJTlljUktQcm43dWFsQWdPVlcxeDdwSThEZnAwV28zMWROUEUy?=
 =?utf-8?B?OE9hQlVCdi82NDhKOWxSTzI5b2R3NDU1TVVJMHNIUzUrVnhiOGVXNXhHQ002?=
 =?utf-8?B?QXNLc0xNMWQvcm9YbS9wbEc3UjMwTjgxZHM2ZW1Jc0daZERvN29ZUENuZmJQ?=
 =?utf-8?B?SHd5YSsvVEV4d1pxUENoUVF6UlJQQ0NLTXp3VW9JcVBDWm9LTTh6Mi9ZeUY3?=
 =?utf-8?B?SDM5TzFBalh2eWpHSE1kV2llcXZZdHliaXNhc2M2L0RsL0RFaUJmc2lJbzNX?=
 =?utf-8?B?QzRWRlpFdUN3QUJTSzNVS2xJYm16KzhOaC9nZ0RST0swTUYwU2FjU3pwcU81?=
 =?utf-8?B?ZnRQWFpEZVFlQ1NtWFlSV1I5ZTFwTGFyQzYwKzE5K2FMNUszY2o3Q0NWOHFH?=
 =?utf-8?B?Y0ppc0Y1bnc3cU5WOFR0OFo5YUh1Sjh6bFNkUm1FNkRlU1lKVG13ZEViaGxY?=
 =?utf-8?B?QnJrK0xuRzZMaHBLY0kvTUh1U0VhMkJkamkxNmk0bEJHbFNKUmlUWWo0L0R1?=
 =?utf-8?B?dXd1dDVQNTNqY2hXL1o3TnhLdGFveldHbXJkRVBzUzRyb3N0dHlOUnl4T0pk?=
 =?utf-8?B?Z0U0NXYyemgwZjJIaG1qZEoydzdDR0tFcDlNS1RGYVBTOHpBM3BzbzR2UDlT?=
 =?utf-8?B?ZkJsL2x2QXJIMWZZQW5XdXdEa2RjSjVqMHBwQUNhNmZxK0JGbi9LTEJ3TjAw?=
 =?utf-8?Q?e4NTq0WHO4H+LvpEq8Sjr7qkVeRfWbiZfJ5KyWY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnZkT2hkZko2aTdVdzNxUVh2VWVWNE1meFdBS1pzQmZGT1ZFdVZQSXFhL0c1?=
 =?utf-8?B?SDc3SVFRK0FVd1g2YXJqQzZlaEFhUWxURmZJKzlEWE95VlhzSG1WeERTSzdi?=
 =?utf-8?B?WURNVTMwcm9GRDkxVjBzU0VjVFRHNFEyQTV0SCsrYndqdXA5RW9Fc21hcWNR?=
 =?utf-8?B?ZVIrSVpSZWVwV3BXbkFzcTI4K2lVQ3pRelpCZ1hEeWhWbDZueENNeWxoaUJw?=
 =?utf-8?B?ZDByY1l2SXB4NWVtSVRDYnVOQXBtbWpiamJaM09SWXNsNXArSFhrZUNkbHdJ?=
 =?utf-8?B?ZGVCUUF3SHhqTi81b3ZXbVZTZW05YlNEd2hXRjlWUk1nY0htT1hWcVpCKzlq?=
 =?utf-8?B?YmFDT3F3VUpvRHRGUUVGT0JUaVV0OGlwT0FJa1V2Vlpkb05Qa3NSS0xOUWpa?=
 =?utf-8?B?QmY5MG40OTJhalRFcXU4OXlpZGtzTndhQVh5cEcxem5TK0RYSHVlUU5XY3FT?=
 =?utf-8?B?L0Z0dUVwVUtkOHM4ODZPM3pTUGJ2UVJkVm5hSUxpb2dFSjEzdEVRUmIvM1dI?=
 =?utf-8?B?cjFPakJWdUhqQk9kS3J5SWNvQVRaRitvL0lCNWw1K3hvNVEwODZrZGhPelRN?=
 =?utf-8?B?bUU0TC94S2tsM1dncjUxOXFYanozdEhqODVpTkwzQmlOVSs2T2NRaStTTUEz?=
 =?utf-8?B?aytxTkxRN040eldueUNKdFpwRUdLeVhhZitzd3pSTzVxN3hKWDZaK29MQXRl?=
 =?utf-8?B?eXpCTEU5cHFEWXBSZW04UjFmbXpPeU0yajQ3WXZnckQxTHVpRy9hN2tpWkx6?=
 =?utf-8?B?dTQ1QldmWWhRdC93OXoyMTBzeVVmZ3pKY1QrZEd1UDl3MDh3bXRmZ0NRSElB?=
 =?utf-8?B?cG4wbS9ueUowa0xVT0hUQjBqbFhYbVFQYkY2UzIyYW1HSXMzOXNzVjJxR0o4?=
 =?utf-8?B?WVFRckVYYXNWazBjbEhKSVVhNXgxcVA0Q1pzT2RvQ0NFMis5U0puc2lSVnRv?=
 =?utf-8?B?cUd0bS9lY0hXSWlJRFo3QUNCbGpBUVRYQS9sZTJWcUdUVnFVN1FmVkR4ZENM?=
 =?utf-8?B?RHBlVnF3ZmZoMkZsMG1PREpmL1dwM2Z1TGdMZjEySXE4c2o5eEtKWFU3eFY1?=
 =?utf-8?B?cnhIcEE4OEFuSmc1bmwxcXA2Z2l6OEFpa0h5UWRlZm1EeG1pVVJaZU54MEVw?=
 =?utf-8?B?Z1Vnb2d3S25ySHJiME9QZFFhT1VYdVpDaDNVRHh5ZzlQRmhFcWY4TU56VndQ?=
 =?utf-8?B?WUZDZ0U3MHJWZzFQamQxVk9NL0lIbU5vUENyL0xGVVJZZnJWNFpLcHFDMm82?=
 =?utf-8?B?a3p4S3ZIcDJFOUtpUzZOSzNhRzFQS1F6WnpwQ2tlTXhNZnhya054ZWVDb0Ix?=
 =?utf-8?B?U3k4MG9xVkRLWDE4N1o5NFJ1NlFMekZOaGhHbW5CZVpPSEJtcFo3TGpnWEh1?=
 =?utf-8?B?UDZhMXdjTUdZSWpibkJTcm9wbWtEdkF1SHhnRUhScVBkSXpJbjVzY0hVLy9n?=
 =?utf-8?B?SW95M2RuNHkvQjZwUmhOcTRBQ09nNVJpdGdUUjVQSkRpZitCY3JTSmV5cGdj?=
 =?utf-8?B?MjlBNjJaVlhub0tmczNXa283SXJHSDJXS1kzdHFVS1IvczdFc3hkenRpcGhK?=
 =?utf-8?B?R0lpSHpyWXRzbmU3ZXJ5STIwb3Yxei9vOVhsb0tmcE13MUt6KzNGT05zSjhI?=
 =?utf-8?B?QWFNT29iS3FLUkVVcGZiZDFyeGJhK09ScmFQczdRVzJxNWIzUEZWZ2JDVTlz?=
 =?utf-8?B?UFZyeGFLdHU5cE1SZ1hVOWFKQ1hPSG11WVlld0orc08wQ3NZU1cxc2N1NDN2?=
 =?utf-8?B?UDFMcDdFNGVwVnFMMTFTaVNFWCt1QlA0M25MLzMrMGZHcjdaYjExVjEvRkNs?=
 =?utf-8?B?UVFnZWNiM1VTT3d4MjF1QnNJcEowdDVGdUtiZTFPblRla1RPOGluR2Y5b2hm?=
 =?utf-8?B?MTZDS2NVWXR0WGljclFFdmx2bTk4SVVsM0xVRzR3ZzFHYzJDYW1HY1Z6U3A2?=
 =?utf-8?B?TzRPRTN6aEVOc3hwZlNGRk5jK25BZ3FJVjR6dVE2Znk0TjBYZk1HUXpjbUxW?=
 =?utf-8?B?MGtRb1VqZlFRdVRwWTk0L1VGRmR2K3hFa1dpMXpaaDgyQitWckRUeDQzREl5?=
 =?utf-8?B?aU1JZWZ1bzZlQUpKQ2Q3MWc5MUYzblE4b1Y5VmJqNFRJQU1hbW5xV3oyc2JM?=
 =?utf-8?Q?tDnYlzoUvWmcyAyCSR57rYhcU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jNgVMhzrJTojlER25lU3I2fAvLdoDN0j67xs+AY9pV2nzteDoeLLRgxg9WVST43QMzYOS/tyCSkB1ewaukyoeGS+wBXDGs63+5/5NVopi3aZSoBoXO6ENK7K9T/upeSwI13dlCyf0Yh4Ca1EDfhTWf0ejA5etKK78/VuzhLkVoMXyMifYEmkaHf6YAZWNDlXOXPiFjYGYnRpEGdZcIj9YSYYtFUw+SAtvdQTVI+uW2qJJLHiGNHFr1wp8dV+M/D/3i6Yey9RhaNh3ul3lpDC9zvn/HbAuo1pHsNRq/O1QFECfITE1LCb9ft4yCDXiad96ChMWu0WsL4mBkL6TB3Q2kPiuvpF2klHJmP24FcuonEnuYLuDSHiJdYhlsE/6uZEmfHoz6O/q7o2ghuZO/2OkRwXJDzL5k5eWoh+4J2tWew2OI6s+q9EIHw9F7uWNbjO9KPYhGHEgU+7yvoAyN+pJ8VqN6Zs6BRZCZXIeH8oB4vjMbdWQvy5KvnIInHxkZpaH6hnU0cqRNK5C1FNfbYrtI7PiNmSTzK4Rd8OCQQ/DoQosfzGmnem3ycoHiqcwQS6bG9y5r6VB22rpNpxdDLo249jJ91Vc/eKGL5cAf7ksLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a015aba-8c36-4c56-efda-08dd08b80f1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:34:37.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo6ti8G4FBqjKp7zRvfoB+6hFRuEhWAPDa9zoyDPaAFPQMaDXIcx6nGfUMd2JOWR7KWOrrW7a+1/xNinaNDTzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190123
X-Proofpoint-GUID: Dxk76Ate2Fo6B61U0oFHP-kwf_zBPAwb
X-Proofpoint-ORIG-GUID: Dxk76Ate2Fo6B61U0oFHP-kwf_zBPAwb

On 19/11/2024 16:09, Christoph Hellwig wrote:
> blk_rq_aligned returns a boolean condition, don't mascquerade it as int.

I think that the spelling is masquerade. Well according to spellcheck...

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   include/linux/blkdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 74e3c611a4f7..e4fc967e8cb9 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1464,7 +1464,7 @@ blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
>   	return lim->dma_alignment | lim->dma_pad_mask;
>   }
>   
> -static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
> +static inline bool blk_rq_aligned(struct request_queue *q, unsigned long addr,
>   				 unsigned int len)
>   {
>   	unsigned int alignment = blk_lim_dma_alignment_and_pad(&q->limits);

