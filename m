Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBB1917D9
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214810; cv=fail; b=PzaT3xbJtpfIhGrR0g9cD0QTGZ8QlbHkpw2V7a//gSTJHhZMJPuBtODQwQ0iqFQSq9RG/6eAzLUtNy01h1aXQUGYZcmRGWmaVKzvz7pBh9jT+cxe7/OI32yx8hb8tlkh9sgA0e5vPNcgitEOFlSRnabf5mxWAkfhkuAxDRAdXR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214810; c=relaxed/simple;
	bh=Nuif812Td4vxCQ4bAI14j/3KYarPhS+StJlV4iiFV8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ehPhMA7YHa2jzuY9w3WPmi4PYl/M0i4SDtExDGH8LWzvvBtdK4xjZ+KgGGEDUXo13Lbi/G1i8Hbk0K2OztzViWnIOTvb2ENQLxo3ZNSWKwlCdF8pBUQhCalQ3BL1BRHuArCfsohkdWqeWu5bNB9qyUVVTBhlay25MyEhdUt5Y5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dEI7dAxr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XcpNHuCe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dEI7dAxr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XcpNHuCe"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtdYv026083;
	Tue, 29 Oct 2024 15:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=16xpxpMLTZA7ATn2ucABnLicU1HrJmTJ85Hboj/+hd4=; b=
	dEI7dAxrqeFTPORHrNTbkpXdae4ZpZLSekA+A7eSeGxi/USJXbc3myWGklAu7U0g
	Y5ObdWKX/JrbXqwlBmZrPFzTq4Cc+TpSetcWfYD46RseMe/bGjv4D4pJMQU+ivWs
	xl+0yxQpw4EBT3wB6GVRat9jwo0+vppIl4i0kaSIDSC6YmUtdT104Lm5b3hEfiWl
	MK2mNsa2Q6mwfbOpMyFdSJ9aDaX3Pb/57BFweqnNou3ccnQy3WHBtABNc13Bkyhj
	9ctUTyTHkV4gAu/T0ITxoCHIghEdheoLlLH9NC6V3/Gnv784tP6j+ifdBlG6rftr
	MOAnsZMsAzGu5Zx1UaWUow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys5svr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:13:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEQkw2008378;
	Tue, 29 Oct 2024 15:13:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9sf15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoHfTLxaaHhEPwslM//zHrcNM1LA8KtM5FnbdmqL3qYjZNw/BK69soNG0yab9Crki49NPWDSXImdbG/gSW3EyqqxPY37Ht3wA7u+FbX+Zz1EdZCLAiTti8JN7IoIURyTDtICfNvDk+BQkVURQvnTBNjfmv1p87L6aODAKn2Y5Baf68+q3gnEuhSshPWuVXLZyJS5eM2uRgKeYqUUBwKr5Pku023Nf6fKRKpD4Xp08geus6/GmKJH0pCk7WkqnrHslZG7m1yUHZrDY5Q8MW1VAYyyywc3yvPjP3PI7gtnAxg0YEPXFzmOrMxdI8KPQ00rkXP/xw8hohhnjUOMXGdlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16xpxpMLTZA7ATn2ucABnLicU1HrJmTJ85Hboj/+hd4=;
 b=CCeNHNmd20xIzMistwIqVAbfZJ/Pf6kCWihmkIrW2UaWVZGJkpvUa2ll+0X8EYYcP2zgzS4r6cJW6lwMRquJ4tKTRPLzimrH7Lyf+KbXtGsLthNNEGjR5LbTssIaHmo2d2xcuZ0479pCCPW8OVXb3r2Y/tE9wsDG0gEPd7MM1WStnoxCGai8YQDIDi2ipsl6bWWwRu+OPAmhjoV++jsfv5rGsPuAZvg9ha7sdcF7DyTBN4Co/+qyPUT0s+MjSBzZzT0xBZZBlDt5UT7uVtwqAb1tVTRXZ8Lds9qwdOrav5VOpm0scQmrofWCtMQSW+uHS2lJg2BGVE6Rlfm9HzH+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16xpxpMLTZA7ATn2ucABnLicU1HrJmTJ85Hboj/+hd4=;
 b=XcpNHuCe36STPq6iyI9nTdKhYcWXDAZysGPKv7FDzvBPwd9J63aFTSFHvEuoL83R1jFMqAG6cO6HbtB7EerKopLyvX89Uu9f60klGUTUM+UVzXh9xOvFyxxRu1zxc9Fy9JUR2DCgK3jD7bz0CYp4Y2S46EVwKfYACoUSQLVYZzM=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 15:13:12 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%5]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:13:12 +0000
Message-ID: <70d23933-a9ee-45a5-8805-75f477abccec@oracle.com>
Date: Tue, 29 Oct 2024 15:13:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add a bdev_limits helper
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20241029141937.249920-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241029141937.249920-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|SJ0PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cbf198-867a-4f6d-effd-08dcf82c3473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk9yL0E4TFg1SUNjb3FrRVA0WitsQkpTdjA3RHBaRXJEckJIcUNYakIzRmZB?=
 =?utf-8?B?WjR0M1FDc1d2ZXplUkRIQjBoZU5XM3dHbENvaGRhRjI1UjBaVlVFcXp4UXMv?=
 =?utf-8?B?WWQ4L2o0MVJmVTVuLzdvTHdKR0ZvUVMvQjl3R1hNbTAxWStnSWZablhWYjk3?=
 =?utf-8?B?bzFEVUtrbXdXTzNkYnBQVVByWEhzV2NJU1NDUk91aGFsN2Q5c2RtRmRrbVNU?=
 =?utf-8?B?dzdGUDhpWjB6YWFMOFF2Y2lZOUlsT3Z2UVdma25rT1lQcU1GM1JVcGpPZERU?=
 =?utf-8?B?R2RySEFhY0pMQ2tNdEpXNEd1ejg1QWVVTWkwc1FsNVJHbUxjN1JjbU5JU2s0?=
 =?utf-8?B?QllCN3NPTWZyZWw2cDRBa1N6Q09RcmpDSDAvaVNtU3VBajV1L0JTc0IvSENS?=
 =?utf-8?B?aTdGb0xUV2ZiSk5aNE5wQ3BLbTExYkoxR1RkN0dGSm1uZkk3WE5ieTdRa05I?=
 =?utf-8?B?OTdXdmFXcWRVcFBVejhZQllMUTVuSEIwL0poOE90eExQWDlSWmF3T1ZMRm9u?=
 =?utf-8?B?Q1AxM2NxYm96QkpUa2NuTml5aFUvNEQ4c01lV1FzQXhMdy8xbDVYb3ZXZjhY?=
 =?utf-8?B?UFhrcUd2QU5NbHdUK0ZEMWw4NktIUm9xM3lWdkRkbGkveUZNQTdmVkZqSUty?=
 =?utf-8?B?amF2SmRZamsxd0hWeE1oNVhDMlB5Q01WZ1NLMkUwRlBJVG1jZU5BTDVFdzhq?=
 =?utf-8?B?SmtaSnA2VkNzOUN4Zzd4dlFQdzVqUkI0UjZ6QUpiOXV2dVZ1V2VKeSt3c1VU?=
 =?utf-8?B?dXVzemVnL0ZkL21UZndoL2hIc29tYVFIZExCQm1VUkVIVnN6RGpLYWpKRjZs?=
 =?utf-8?B?UzlIUVIrMTVrMFZNSERFRGtjUjMrR0pVUzV1cm9qNTV1TGdPMEVjRGRJODN2?=
 =?utf-8?B?SmM4OHZGQ0FtM2cwTjV4RE5FaTZoRHVHOXp2SUUzY1JETXZLVHdoMTRYN3hU?=
 =?utf-8?B?ZGZLaEpydUs0cVpja2gyZW0zbHkrZi9kVGw1T1hOQzE1MGo0YVExa29mMkIx?=
 =?utf-8?B?YUc3Rk91WDZTMEVPeStRUHNQWExUT3VWanV2ampMWWVDNFpjQVR0SlZGVTk4?=
 =?utf-8?B?TlBmUEtQVHRhb2djV2lCVyt4UWZRSG83MnVQNEZIbFVlZ2N6V1FjQVl3Rlo3?=
 =?utf-8?B?VlltdDY4UXhhWWtwejJlQmtxb29oK3hjbnpDelJZTnJUQkFaWXlRT2h5TXFt?=
 =?utf-8?B?eExSdDZDZ1RMV2lUNWJEbjdHNndldlMzUFdKRk9OdEVjQ3ltb0NGSXkwaXRJ?=
 =?utf-8?B?NEY5T1dRcFhSN2YxeXF6OUpwRjRZell0d0M2UDU0VVltQVIvMFRaZW96TDIw?=
 =?utf-8?B?ci9Bb0ZLcGx1K1dTTTJVUXN5djVsVU1YaUNxbFBnN3BmYlB4UWNDdlVUWnBw?=
 =?utf-8?B?WUJ2cVRXbGhJTXBhSnpBN3FhQm9ibUF6cWNOR3N3Q2k3REYwRUtObHhudFlq?=
 =?utf-8?B?MVhScG9qSCtuWFJ2TDZiY3loQmYva1RKZWhpUWxrQy9iUWNGUHgzelBQL1lJ?=
 =?utf-8?B?VG1meFB4WmtqbUlaMWpraUNrUGZkVERMS1M5WnFobW5BSnFFelBHUGtMcy9Y?=
 =?utf-8?B?cEJvOVg4cGJKOW85eW9ITG5Xd0I4QXp2QUhDWlJHcGM3OUVsUncvZ0hjWHhm?=
 =?utf-8?B?dGhseU95WVVTR2ZRWFJQVk1MN0VNT2hjR2hHTnRtM3dncStReHEyQmFRZkQ0?=
 =?utf-8?B?bGkvZ2hmYkwwRUpIZlp2Q09NUGtacndNTFU0WDYwUy85MFJsRS9Zb3E1YlZH?=
 =?utf-8?Q?VrswiiEcLFqHsbthu0FYph0MBXrFV20G04u/7+Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEhlQzZsQ1BEQUdTQ0EzSzRlMWhGNitUUzdFQnI1M3BLb2tZVEk1UWxtZHFB?=
 =?utf-8?B?VDlXUFlUVm0rR3l1ckxDdFAvaFBFYUI0bStxbzUzNFRQUVBRSzFKR0YxVWh2?=
 =?utf-8?B?dno3T0xwUFpiTXhPRW1Pa2dqOEk1WlBVRjBjUUVRZzdlaEFkdmh2elNMOGto?=
 =?utf-8?B?UGpDbjVwQTlRWExWWG9Pd1paVEtGdGpSYUN6OVBFVzZOTmlkSlFVM0dBQ0hW?=
 =?utf-8?B?eFlKMWZvWm9EZExhQXZUMWs4WlNrVjdCNkVFV2JCNmdyUHdLcTl2OW9rb2NU?=
 =?utf-8?B?NENIOGE1Vk5vVjZMdjh5SHV4U3NqVDVvckR6enVhNzVtTU5JQ3M2Ui9uZmRM?=
 =?utf-8?B?OGF1THkwZHIzYURUZm5mRzhzS0tDR1l1NlhkTEIwcXN1c21LVUticzNXbGQ4?=
 =?utf-8?B?YVNjZ1pSN3crWnk2NXRScVpCNWdSOFNMR2Y5WTBQeWlwN2orRWVFRitJa042?=
 =?utf-8?B?ZVhsNjlIZEZuTmJGSVV4ZENWQXJkZGdRQzFjV2dUelREdDZMZnhNaVhKRDNI?=
 =?utf-8?B?VEV0TGlNWW94WnNXNUtlSVhJLy9zYWRSNE9sQTkycW9YcHhBa0xEMys5bEVt?=
 =?utf-8?B?VjZ1NHVyWWxEVVdlMW9KTWZTTzk5YzRPTXU0TGpBeUpvelZJN3d6Rk0wSmVU?=
 =?utf-8?B?cjc4WkpjYStTMUlEN0JhUjZXUmtYbFlEWVoxcE5HRDJBR09CWHUxR1JMczdH?=
 =?utf-8?B?eWk2MHl3UzJaUG4xTVE3b0NqZmdGenhaaHRzY0Y4bkF5Wmk1Z0JCMjlFc2pD?=
 =?utf-8?B?eHJSTE9jNG5XRHJBa3RDUjZyZmZyNDM0N29ZcHVWOExtemozRUFESmk5ajFl?=
 =?utf-8?B?aFpQWHJDWDh6bjRWRUZoSVQ3RU1wb2lQNU9HU3Y0VktVQzJ2SlExUUJZdXVV?=
 =?utf-8?B?Sk8vcGVhSGtQSWFDVGd0ZWQrN2hTOVJZdjNOa0d1cm5VTXNpVGJUNFhWL3pU?=
 =?utf-8?B?eTNSdzZ5LzIzUGlOcXE4NkJjNXhVUFFJbHJIeEp2NFM5azhQbUZ5aW15c0dH?=
 =?utf-8?B?clY0M3A0bHVIWnFhWjdzVGhVOVBIZms2a3BEKzYwNEpkbXIxN0dNZVEra2d5?=
 =?utf-8?B?YlFkaGZodmFDVGdIOGxlQ3lOUzRSdUgwem5pd0NjYU9jZHRRY1gvYnpuR0Zz?=
 =?utf-8?B?bWpVMW04VStJUm5XOXlxamlkVDVJNHBmNm9CSlVQQWxJVStZWWRZQzJJd2lY?=
 =?utf-8?B?NnVCd21iRlFLVE5waXlrNHNFdWx6ZmRRYTJ0V1BWQVFwbjBLZ0l0ZG15UXI3?=
 =?utf-8?B?MERSQUZodEY5YXJvREVQeGJyc3NFQXArdXk4SWZKaG9tZHFEMlZpMVNjUlQv?=
 =?utf-8?B?bDBCaUx4R2I3OVE1dHlMTXR2NzZhYmJyNjU5RVc1ZmxpWXBLYzV1NUZtUWp6?=
 =?utf-8?B?TWdSNGNGdUpQYi9KMWhiWUkzTHJ0dWlkQndBdEdxUktWVGVhVjJxZEhPZTJN?=
 =?utf-8?B?K3RqOCtVUFZLRGNGV1hoOUoySHNZN3Fka1hSZ21VbDlTQUpzVmlzTW9XWmFC?=
 =?utf-8?B?U1hjbDFuUXUyeXNVemhodUZSYmRpNHRmOW9LaHFudWVvSE93Rm03L0Q5RnIv?=
 =?utf-8?B?WHlUeDAwVlZ0VndMVXZLdFhKUUVpL1hRbkRPd1hwVjZZcXJQZ2c1N0xJeEJC?=
 =?utf-8?B?THdlSUkyZk8xZWNJTzZPNXVtNjBPVUhlL2dWME96NDVYdVZkR0dkS3BaU3l3?=
 =?utf-8?B?WWNXaVh4RTd1MTNaaDFRZU01UE9HZVViNVFkTlNtVzF5R24vNWtqYlM2UFpx?=
 =?utf-8?B?UXpiUzlyMWhKQVFXNWEwMnJnUEtxb0dqTVhNZXFlNFpYdmZ6b2dDWXdkK1Zh?=
 =?utf-8?B?cWI0aVc3VDE1ZFFPUk9LZnQ5QkR1bmd4L1dsYkFqMXY1SUZlZXhGSC9PMlJu?=
 =?utf-8?B?Q0I3UUYvb293cHR3a0xsZjRGaEt2UVQwajhmY0oxQldPVWZwN1I1dzBoUkp4?=
 =?utf-8?B?Y2lxUW5keFhiWjNLakdUU3I4NGFtU21YcU94L0orSjhmVnNUSVFncm5NTEkz?=
 =?utf-8?B?TUwrVGpjZ1VBbC9DbTMzeG5BdTI0d1ZtbWthM1Evc0thdnQ1MU9KbWNTVENV?=
 =?utf-8?B?ZHNXdGhDNkYrTnM3eTVTVGRMYkU3aW9BZnFnRlpLZTRJOTZsQWczYjJJWG9J?=
 =?utf-8?B?NU9Ua29rcWtlM1pxd1lvejNqTkxYOHZNc1YyMzc4OUZsQVQ2R0JrakNGY1RX?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dthjcnsU0BoSviCThrkybCt9BRiQPZNImC9G/5Gc9R0Nq2KQ7rCSYinpI0RVlbkrSNPBZiPDOU4kTq/XS+LpL3ItVMGrPKM4WefY0L04aL+hh7DHcuZiDuA9BXEi6TMfeEg7ZJLDf4H9EecfD2lmNi+bFGbaXRAStvFNV5FJW06DAxM6h/9eDuwdB0Bxs8B32pripeo+9FqWaiMYji64ykowElH9hBniv7we0mwjKdP3Sbc4+S4TFcymOd5blIJe2xRskxPxrExhfTg2LK5E3WXprkS2EbBHOZ8ZjU2Ku+y4YcZpIsUXzaimdD3RP/MJ27QtqUXwLiXIUBuyVbc7K7x7l0Vl1jh4x+FB4H2oOmRtjqDx5GGbuRnx8fSb+d+ggntznSDdwWeS6KHaS3raCE/9bFk1LsraeAp+9ob5mvz1y4OTjMPTy/J/iUJw6IqxLFBZ+q6HMsVVGaaZzjWdTkkTjimD6rGeu7eqqPaYjXp7R7fBy88kGO92k0s/dKnzYO3ZNqkGNAB6ODtutNmVZxVolyPelW2cqDRtx7xTu3ItsdrZsiFsOOdcyku+qiEmvxtvNgIcZzOsvYq9cTw8zUXqcxdqtObRNJ1skd6nGSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cbf198-867a-4f6d-effd-08dcf82c3473
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:13:12.5116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i59UiQSYgWn/wdjMDgwZljRMzYfHImbIbTroqashbDt2ELVa2zyz5keICvglnGcNIK7zVOUYCVLoObORme7ZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290116
X-Proofpoint-ORIG-GUID: ytPC9bdHYqc0sE3eTIWdj6n8kVkiQuQf
X-Proofpoint-GUID: ytPC9bdHYqc0sE3eTIWdj6n8kVkiQuQf

On 29/10/2024 14:19, Christoph Hellwig wrote:
> Add a helper to get the queue_limits from the bdev without having to
> poke into the request_queue.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---

This looks ok:

Reviewed-by: John Garry <john.g.garry@oracle.com>

I do note that there still seems to be patterns of calling 
bdev_get_queue() and then examining the queue limits directly outside 
block/, like do_region() in dm-io.c or lots of other drivers/md/ stuff 
or loop_config_discard

I can try to help clean some up when I get a chance
