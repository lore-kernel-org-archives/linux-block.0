Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E21227EB6
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446883; cv=fail; b=BktUBAtMtS3r6o5IullEdXkBJLV0+MKzon5E4mDW/BJmzLXG4O8cf1JoJmTzII7cIEvNi2AddrNtgFU4k3l9tJJjQdt6yFYR/gUIpJTh23jHtLqO41KoYLemF0hhrjwPIizZ3P8hl5V4/+muU7niS0d8694C7HmKJRn/eccMyBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446883; c=relaxed/simple;
	bh=vKHsBlcodrIXuzBbgbX7+1UkIznunaU+vA5F8HORL/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BasBTe8xduuIpETzx+IV4jhTXtAJgplAbrLFxiSNLlytyqSd349AQeyYXM88IfNaiTzAAdNSpHih8JIdDRbzBRWSaZ1+wjAQEv+jhaDfepM7JUAgFZKuZ8nOkPd32rx7Lcy34+SP+j1UkK7ZsNzlwVtu7xuHcglnGOwnPwUHcbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WtViwMB4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RGz6vxcj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtViwMB4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RGz6vxcj"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8feQV001627;
	Thu, 13 Feb 2025 11:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gUGvTuXJxQKGb73QjOiMI7++FO9uEFAhGcOsFotY0lw=; b=
	WtViwMB45rNYaJBdJ/x2TtNVxQuw6yh+iAIrEDpZJHrYPqMokiQximdtiJCSaYWr
	lUeURYoTPj5PynZ0bZ+chM6beH6h0qUBgq0gss5eGv12+vI6cjEDNBuZjCVAEtH0
	6MhEHS7ueoXDUlLaO6WQYnZonIn9MqgS5ge1w06ONhLPhB/TyzQfk2X9iKk3eQ+g
	QcNm50XwCWt1v8UPO7mqvxT2Dy56bj6as0W75gQxH1gCRz6VDC35TpE7BFuP3N8j
	h5Weej5OEGdp2eamwACsDiBmunAXV0ItwOl2ehk8fU4GrwstuspGyc4hu2HCLck5
	kn224n8fxO/su+2uHV6r4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qahc3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:41:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9disZ002626;
	Thu, 13 Feb 2025 11:41:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbmkfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXiiuWF2ZugrOqc01gDGUttiLp4sH8swbPH78PN9/IrqkyedLoB4ltU11hiijwNwUF04nySywfCx/7WxLgdQuX+lKimJUN+BBquMY0prN48STjkg0UBrFWZ2QPanws6OLANTvUUrFVMm4Sfgx7Q3nGrwKqytuzUZuBsCHr9I4MKxa0xg64iPXLrkVTiq1BzxWLrODGHGtZQc8nmqLK49abJzFXScEYNWOo3PU7d2q4u3Ly+7qrZfcIyTmQaRV0MxP5Y1RZu/QpULrnwy7n+4kHTtDVbKNk5je6st0sBT0czGLwQdA8/IjNobSUv22N9GumTRsN2qZ1jgPSZjo+gzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUGvTuXJxQKGb73QjOiMI7++FO9uEFAhGcOsFotY0lw=;
 b=jnU6NxiKpIH2sWo6YYE/2YolHXmkUsfxRVgYrXRslC7ogDUnlj7H46HOHQy17UA5I5desCvdx88Wl8/U53OLGgTQaCB1fxLJQnVckrApep4CLHvn4mhXZ8v4gA5pN7kq/3b7194IzlZyj/nETBLs85WMn3AkXPNBVXc9D7CRLJCpX5OAypHLERYBuMwYWU6FE6Uq6E82nZ5WnL82CDypzmJ0RQOgbKRM3U/586NEwLFYibzmZesyti9iNMCCvYFuQ4iDczUX8U7AQfo2tk3BioLcv8uMbqPUdxwbgqjAp17cFp8ZSuiRngwKzdvKK9C/0JDbt0lXm/PV1aWYAXBBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUGvTuXJxQKGb73QjOiMI7++FO9uEFAhGcOsFotY0lw=;
 b=RGz6vxcjFzDvTdZcKrFfD68xlmo5E5HGPYbIr7mBWhpI+20Un+WGoqY/J5vrVkHSyWzQDtzmj7/2B+bao0Y8mEsxMukOSjaIlygA0T2E0fQsle5Vqs46kFU35YNw6RB7y8cXA4/KLeHVdfTB66oKLKmNCFgctA1ijlZywmkjy6E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH4PR10MB8171.namprd10.prod.outlook.com (2603:10b6:610:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 11:41:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 11:41:07 +0000
Message-ID: <e4832a36-cf75-40e2-8712-6eca2a45a0bd@oracle.com>
Date: Thu, 13 Feb 2025 11:41:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com> <Z63CY9rE7X8m3nmv@fedora>
 <63bdc82a-fa01-44ae-9142-2cb649d34fb7@oracle.com> <Z63K99wkFLWqIfxW@fedora>
 <80fb598a-ed65-4e6f-9781-7742086a1d19@oracle.com> <Z63Yb9_wvjqLbg47@fedora>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z63Yb9_wvjqLbg47@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0112.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH4PR10MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e5fa83-2f16-49f5-fa4f-08dd4c234e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wng1K3RxL3g0ZjlMdUdHMHF3R1VMM0NWVmk4aCtQVzFNamhNUHJMTDkxcjBO?=
 =?utf-8?B?eU4wdDBGSEJOeks3RHo0RCtpVy8xb25ScU4rYUpmY1NlRks0cGw4Q2QyWFlw?=
 =?utf-8?B?dUx2T0UvSFE0cWFrcHdFSENXbjczYm5ZYmFnR203VStKeFlzS040ZVQwZVhs?=
 =?utf-8?B?d2p6MTBrZ3RlVTRZUVVITXdHcnZJWUR1RFVhMy9KZG5iOWVpV0dxTlp3V1Zl?=
 =?utf-8?B?YlIxbER3dmxwQXV5RU1sTHljM2FiMVp0OCtPSVYzNW5udW9jQkRESHV5RGZT?=
 =?utf-8?B?MUJEQUlJRWVXMEpHVFpTUVpYOEk3Yk9kOGh3T0thZVFQUjNCQjQrRU83VWdL?=
 =?utf-8?B?WCtDTTE3TXdheFhyR3ZjV0lFS0daY2kxUXNqdktNYUwwWmRkaU1ydEVxclBL?=
 =?utf-8?B?QlpqOFhXMnVzbnBOS3hsS3MwSVYwVVNIVjhYRHRmYzZtR2JlUTdkWTMzOTRU?=
 =?utf-8?B?QWFXNEdUZTRrdWNnZzkyKzlRemRlWFVHZUIwTk5CNit1TmQrV0hvcGMyZE1p?=
 =?utf-8?B?TVZvcFRNRlhMTHRRTWhFWVRyODZGeGJBVDFNUUdON0R4N1dMSWwzeXFETFky?=
 =?utf-8?B?dTBGZldsOXRiMVNJMTdkMlZXQWhhc3ovMGE0U010UU53MktUbzBOeVJJOWFI?=
 =?utf-8?B?UC84bkwrZ2pXVE4vanY4YWNUVnFueVNSdlQ4VXkzbHZwL0hwNTZHeUlzYXVt?=
 =?utf-8?B?V1IyU2tNTEV5RFEwWU14MFhnaXVhTzU0dFJVbVk2cmVpc25taWYraEIvb3VN?=
 =?utf-8?B?Qkx5Ri8zN3J2OGdmMXlmSkdYTi84YmMyaDV5V3BLcDZMejhDZ3hja3IxWDBv?=
 =?utf-8?B?S0tMb0JFTm5JdWV4OC9zTHNnajJWaTRnRlBWV1B0anp2YTJYaGUxVXprcDlG?=
 =?utf-8?B?bW9pQ3ZJKzBud3lwQ25sYmh3eEluYkhVZGNabXRUaXpGbDlUSFBoSzJrRjFO?=
 =?utf-8?B?bFZuTFMwb3FMQ1NlTXQydWtoYzM5ZmVsRktjdDVHWjBDTEtzMVZyZWN5dUJO?=
 =?utf-8?B?cUU1VGpvRncvNFFzZlVQYlp3YlRxaFNUdWsxUEl4cjlWbXhtTUdwSEhheGxR?=
 =?utf-8?B?cDVoMHVZdzczOHcrUDVuc3NFT3VmcndKSWpVWTJiUGgwVjJqVnYxWE1pQXp1?=
 =?utf-8?B?aTNnYmZ2NGx5R1dYMTY1YWY5T2lKTGVKUmJSR2JzWkxaQkJRZVgzY2JHdmg1?=
 =?utf-8?B?VzR2MGFKSWlESU9SRk9oVGo1aFZxYjlueGFOdVo4b1hiYUhlZG1lZGIzTzAw?=
 =?utf-8?B?WU5XUVlYd3FOeFVTekM5UjV6dklSekRWbWJDd24xMFlqYlpGTXM3UTUyWU1h?=
 =?utf-8?B?cmo4NTFsLzNCcHFNUEdtNkFJSVNOYm4ra0VKYy96c2s1TVFJVXlDZkNGV1Bt?=
 =?utf-8?B?VjIrRndVeUJlK2FyUVVWRWJGWDFXQzQwV0gzYm9RelNlNnY5eXJheUhTODFu?=
 =?utf-8?B?ZnJWQTMxREdMU1I4eitUdythM2NjczNmTStoTk1VZnNJeW1PYWswT2VUcy9w?=
 =?utf-8?B?T3QxV3N1Z3ZoTm12eGY3SnhkaFFNYnhkaUJ5TGpJdlM4VHJjSGx2dVVWOWFI?=
 =?utf-8?B?RDhVa1BNeVFPQ3RBVXdMZ2ZQTWxBazNFYW1WYm9GcGRvN1JBYmVLUjFzbnFl?=
 =?utf-8?B?dXowUm5rcTh1Y25NanZFLzZhdCt4Wnh3OUJiS3RNNldYKzFKQXIwUVdEYmlC?=
 =?utf-8?B?c0Q1YTdNQ1FLakp5cXRGN21zdkZyZ0ZoZExMTW51QlRLSkxNN0Z4Slh2U0tq?=
 =?utf-8?B?dCt0ZmJOajhlbjRaQzNycEl5dzEzMGljbDlublAyWXZQSXliMjlMYUdSeDU2?=
 =?utf-8?B?YStKYzFPc0ZUSWZGR0tJSVU2MGVaVVZjczBQZ3gxQVUraXgraDEzQTZGL3Vr?=
 =?utf-8?Q?eKrNWtiAV3Os2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlYzNjdMNXFiWGo3dldPM3JkT2lhY0pUVllMVmVqU2hnU09vRWxKbkZBMVpu?=
 =?utf-8?B?clQ4WXZJM2pMY3lveWtTdkgzanhvRHdDVjNRM1pNclp4ZHJ5UXM0bFZkQ2Z0?=
 =?utf-8?B?YUNGV2NtdW1ZSkkvM1BNcVpETGs1MTNWRlIwK1VwWEgzMlkzdms0UmpJUmxh?=
 =?utf-8?B?SUl0emdTL2QxTGt4WVdkODNOS0E5c3hHNXhQc2swZ1lSQzM4R01iT1gvdTR0?=
 =?utf-8?B?S1BDNlgxb0lUbUlMQzRRRXB5S1NyVzV4UkR5MnMzSFJzWjVtM0R1eTB2YWsv?=
 =?utf-8?B?RFlmSjV2bDJUWG51cU1lUXRkeStiS3drNkJVQ2pJVHdiZ3NIYkdhWUVGSXdx?=
 =?utf-8?B?U2krRzJLbFJQK2Znakc2amJXc01hNk9ONHcydWdzSjhRNnlaeVQvWDlIajFP?=
 =?utf-8?B?cXRUa2RVZWtlYzdVNmttd0VtQW93NEpGKzBnNTlSbDhvL0JTSXBoaXkzTjFG?=
 =?utf-8?B?bUxlL084SFpLY2RMMG5GWGRVZ2p4Zk1aVXdTaGpsZmJNWTF2UFh5YmVmNHUz?=
 =?utf-8?B?WkVXYlhFaHJTcHRDWXdwSmhNSGwxajhNTkhiQWFZeGNqTzZuZlN5VkY0UGpm?=
 =?utf-8?B?TTVQQTVFUlM0eUxMdVpDOE9iSHlwUlphU0V3ZXJzRllwaE1GbnMxQ1FhY3Jt?=
 =?utf-8?B?aCtEeE8rdjVvOEwzdU1CRG52b2pjRnBHbXg0QmZNOWI2Ym01TDJ4ZUViUjBQ?=
 =?utf-8?B?U2JHa0s2aENEMjdYZGVmbTRBZXgvNHRteVpiWjQ2MHdsRmxsVDFJbXBKdWll?=
 =?utf-8?B?TjgwUFpXaDc1ejYvZXN1ZHhOTElsWkZ2SXdYeFBDZkEzYXE4YWJQc0RJYTZM?=
 =?utf-8?B?WXg1dGhpa1JwMG12Rmc1bmxnZHo5aFVDWEUrMkNlOXA2Z2NnQzJFb3ZtZ1RS?=
 =?utf-8?B?czR6NU5YRUlpNWx4ajd3MDUyTkNiTTRCeG9NSWM3ZUoyTklvMXpsaWRSZkJv?=
 =?utf-8?B?dTEweWNSbGZpRUJJOWJxZ2hqZTdtU0FCUS85TExYM2pvV1VGU1V4RVA2Nzhi?=
 =?utf-8?B?NituVDVobjg2bTFKMjZXMjJoVTA3Z0NIcW9qOHZnaFZQTmg4QWNyUy8wK2JD?=
 =?utf-8?B?VEx6VUtJUk5vZElrMGdTQ2JYN042Ung0dWVwaGE5a0pwOXBVallrL2dMN0tz?=
 =?utf-8?B?V1EyTVQwcDJZYkRteXRUK1JjQzVkRkhXdFZyU2FVMDVISHZycFQ1K2Y1d3lU?=
 =?utf-8?B?b2RsRGl2d3J3VHVyU21nWTRyaUZWZUloQnNlWWYzWnZ0bVZHdzkyWXVEUlJu?=
 =?utf-8?B?ZElkcXFoNUFHK3hMWVp1WU90NzZGM3VEZE8xL1A3SHFKbk1OQUJYOHkwd09K?=
 =?utf-8?B?ZkpFTFdTbTdETkxIdE9VbDR6eVFteWZDQVBEQnJnUE1DMXMrSHR1ZlBQYzZR?=
 =?utf-8?B?Yk12YjNzRVNuUXAzdDluc2R5azhOeFRYODdFa0hBWWUxTmwwc1liMVN4bTVP?=
 =?utf-8?B?RkpHZTkxZE1JK2srbUtkQ3RUa1V0UGtNV2JJQytNcUJjSEtXMkJLOVFKdlc3?=
 =?utf-8?B?bUtZbHhoME5vQzhpVXp6NUJScWU3T1ZFcTlLRHJBMWVDZUZkOTlaTGtXQWIy?=
 =?utf-8?B?L1crVDQ2VTVheHIxbE43NmlYNGhmOVJYVWx3ckI5YlNYemFZUWQ5bU5hYmxM?=
 =?utf-8?B?UmxrMEdiekN0TGNUbFkrOWoya1RacWFFbm9maTV3aG5UT2xpblNsL3BoMVdZ?=
 =?utf-8?B?TlFOZXRnQ3VlKzhKb21nYnNrcDFEZUFSUlZnWlZYSlMyaXlDUUwvNlZZZ2V4?=
 =?utf-8?B?eHZXT3lvVGNkV2ZRQmtWemd4UVpoYUNDK01ZczVuT1FYTDY3aDhFWWo5Y1dD?=
 =?utf-8?B?ZThjTjJQNHcrWTlsaXRiUjFFZG1zT0hjTUdDTzY3dkZ0MmZWSk1vWkNEQisr?=
 =?utf-8?B?ekFIcTBOVmxEdTQ0VmxmNHBLSzdMR2p5RHpydUtRYm1hK3pqTG56SHZsYTNo?=
 =?utf-8?B?TGhkcnJac0h4REJwd2NHNXUwdVVWZ2dFdVFkcG5QR3FTUTQydTk5RWF5OUl2?=
 =?utf-8?B?MkhxVWU1WVZhVWxiRGpGSnM5aEtwZXdweGNmbE9rank2WjF6d1NFM0ZoNEhs?=
 =?utf-8?B?cmVScU5JYmlxTm82RjIxNHRGV2NoT2h3RnN5YnZjUFJGSUw3STA0bE05YXFP?=
 =?utf-8?Q?2XQr05hCcdu2aJvxTZ8LgtqUW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Taj29JxHRU2uZWAYaJYupMhEqa3Gyac/he1RRJrhtz2nlGahdBaIqrd3NgAYzmraBHyjthP8c+mg+PiDqsfAUdNGhz60XlvLcNpSjbRI9YvD93gZylcYik38zXm0fHuNM6yYDZEVsNluGxxgs1gltalAH6M9YNfndTSXWow3WK72f9GBW8UekJi1SXtbmQ3+vhccxEFVYZHl8LpNqWsQbF0ItTNW1sdJKM21soBIEp9QNmS7JqdWXtLHIjaMQG83aERgcT6TExtD72qhrrz93EwtVHHYxTaRb8FCEkiGNoA8VUvhtbJebrC+qcPCGlzBjKrashYd7bNq8hIIXW6kk1bTpKnl1CUUjPVhWKGRaTQ6MqGY3bfm0KqZCjT+TNiJ/n1Z4WiDS/321Uw29SxbQXINIBNTpNK1ESXcntMo33HAfdENNAalBacjXOPRivQwsilHFUXAjoKneCgXtnMJKvi5npGp74JMxNQLyz7fvGtHkcsaP/XA2Yv+WmsdXNWZAVCzEYroUV9lymhMwpptAhiW13FD3T/PNctDh6aGEi+U9wV3dAQHuWuqg0N1dZbGR8BZy9cJ+k9GfeZKUFJUf0nHMfZH5HL9MXDXRii6iXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e5fa83-2f16-49f5-fa4f-08dd4c234e1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:41:07.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8quOFMS68W7RAvKNd2aYqJdOSVUvqSaX5SHa4pr6NGQcYVqvNnRZX7FH+JGqLYwcGW1ZX2ppQBFTEBGBX/sG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130090
X-Proofpoint-GUID: hpjL4q3NnNTh23HkuxTNase4iRNJmAf1
X-Proofpoint-ORIG-GUID: hpjL4q3NnNTh23HkuxTNase4iRNJmAf1

On 13/02/2025 11:33, Ming Lei wrote:
>> I think that we need to take max_segment_size into account in
>> blk_queue_max_guaranteed_bio(), like:
>>
>> static unsigned int blk_queue_max_guaranteed_bio(struct queue_limits *lim)
>> {
>> 	unsigned int max_segments = min(BIO_MAX_VECS, lim->max_segments);
>> 	unsigned int length;
>>
>> 	length = min(max_segments, 2) * lim->logical_block_size;
>> 	if (max_segments > 2)
>> 		length += (max_segments - 2) * min(PAGE_SIZE, lim->max_segment_size);
>>
>> 	return length;
>> }
>>
>> Note that blk_queue_max_guaranteed_bio() is only really relevant to dio, so
>> assumes that the iov_iter follows the bdev dio rules
> It can't work because ITER_UBUF from pwritev2(iovcnt=1) is virtually-contiguous,

Right

> and the middle segment size has to be PAGE_SIZE.

I would have thought that those PAGE_SIZE-sized middle iovecs should be 
split into multiple segments, no?

Thanks,
John
