Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520322E62CB
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018038; cv=fail; b=majS6ZtmwkNG2OHfs4fE7Cylhl87PDQtp5qHdC1TjdoSOQrzP00STKp0oW44JKAocz62T5+BcTldvyLhliNLkJ9YS3FY8L8kc5LFqBZYtBsgVtOPp1kd+a8ZxPD+MKwaB0cnR7fdRuOU//VVn6jhjXShSXvw2RXNT6zffyfiux0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018038; c=relaxed/simple;
	bh=bV0udrzbOq/Wcu+f1dYw33URIy8hVfV5oR9y1+bU4RQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C9RSPGGdV5lXU1g1uGnK5tcKgfLvGVKmRdz/6bfunMuFNBElJFslTOgS9WRznSBc7noB38706RZD8mABPCIZkPUSCE1OA3ewUGifa+85BX2kiEb+XnGmlcrTT+GCCHGpH4y5lGtq698BPBwfqsE8y1RRDe7QlKLwypQMGBIQfxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qvh9VXL4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VPbVyLL3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qvh9VXL4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VPbVyLL3"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1gmeG003469;
	Tue, 16 Sep 2025 10:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/oYNObNI6zrQK9nUE1eIKkZdxf7umNW1qaF3pFQldwU=; b=
	Qvh9VXL4oWAik8LlsqdPbtkfgwHbMOepTTReljZabGgN42AUHclW6Ykefhwufy/q
	GIvJPIPQ11GSR8XuP2o9GoG7cGVDZm8BLfGu9H9mYbTWtcTfdQrV1u9yT1vUj1uR
	EXc7oBmjkkK10eEExO19mNcIwZZEayZel7+pHz8ShdNqi3RnNAm552gzb8+Kd1fD
	NUkpzXXMUrd7HDbFtGzexV5pYs7xOtJoNeXADFxZoQaXg8/A5QPLKeY98MDpND/r
	a4+hDRjJ8XCJTu4I5Kc7ZyEDA0mWw8y15kPSoS/rXsaeO9W4kb/3acOFEc0nIzWD
	ONyAyktxy1Dvt3t5JOYrhg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf4cgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 10:20:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9A8oA027230;
	Tue, 16 Sep 2025 10:20:34 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2jf9v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 10:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv3fSSKsiQPNCrctEI5W3BesAokISrhFrCAPC0uLAgmhqJ6TBeaGsderhTf+rDcPmV2I2YptodEQ9pV+yXHSbm/FBYBetEHZolUjZ7xuX5J3oYL3HUpnQi/7Bq1lor7PkDzU2gVoqllw+iyR+PbFjdkKWsfGDN+NNEMBl7vCKDqCTaP5ltR8xtJDNllkZFMhuajQ2Zy6c5qojtcM67v8bAh4HVlfHn7b9fLU5++nW++IAu175Vp01GgsjtDIBejj6Ya+43jYZL195lRMiojmERkF9ox370D0YKK7HWczMyKcdQ1V9yI5bC1s4gW+fUw3keseDLlBWM1R+WgZFCN6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oYNObNI6zrQK9nUE1eIKkZdxf7umNW1qaF3pFQldwU=;
 b=oT8w8y5fE+H0PR0co2zNUiOwbaJ/53cOljOFOShCyu68+Zz8KPGQwWEusHykQ5cBaNOBy/SzQ7pacnWuDxZZPGPq1ZgxSZWyaMeN1Z4v891e292fcmI7QR4LvNcXzRM2rLe1kO4KalzzoVGAVSL4HxBXA2tRTTe+vzF+edUlRWqUjTF+kdYxXDfwfRQonMApjiX5sMNDF3jEcMuD6Ci+pg+sypLaWCCCRjVEK5Hny5I0PQEcGgbbuLBSqYEbDrKM4UUUcHvkSs5DpgoqUPGShXMqiaRqentv6Juh08SYAehcBOdqkpzIYMeQ2oqqrID0nzWYgMuMtClW18QqV+lRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oYNObNI6zrQK9nUE1eIKkZdxf7umNW1qaF3pFQldwU=;
 b=VPbVyLL3w/yzzFekK1XH7yPsMWfOmryH6qMkbXBl6A1tYOoCEIfAsceDp41443imgqnOLn0iJa5e3YHVY5ScrzNLKoHkqV/dY7A+G+gk0oizkLRq0ic6dVNaE0ySUz2Lkc9p758sQ2voZ+H1J5l5iSN4aNr296n2yARX9XRGGsk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ2PR10MB7581.namprd10.prod.outlook.com (2603:10b6:a03:546::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 10:20:29 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 10:20:29 +0000
Message-ID: <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
Date: Tue, 16 Sep 2025 11:20:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::18) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ2PR10MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 4887fcef-371d-4bcb-69cb-08ddf50aa8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEc3eFAzYUdZT2tEbTQ2Y3NNMEFaSEpsSHV6Z21EWSsxNi8yMXpGaHZ1NndH?=
 =?utf-8?B?bGhYUDNwTUZ6LzNQRjdRWXhtU3A0MUYzMkRqTDAyby9vRk5kUFppdm9vNFVR?=
 =?utf-8?B?VlpZRmhjZ0hFT01Va0Y1ZG93SmlMdnRLR1AvSFZZdWhMSEEyZ09kbmtld21h?=
 =?utf-8?B?K1RYWld6Q2hEMm5BS2pvWkp0bGZuNkUxeG9TQ2lKUWRURVk0L2QwNkQvdy9n?=
 =?utf-8?B?WHF5cmRFRW9KQ3B6ZUo0aVhXcEdLTDJPaGxMeXZzVE5XWEFleDZ6WEFkY0hG?=
 =?utf-8?B?cDVLNXh2RUozSXRENzZ1eEtpZVFBZklkdElZY2psaHlkMCtOSm5Jd1RYUDIz?=
 =?utf-8?B?QTJMOWh6enZjOHM4eGh3ZWh3WWFyeVF4djdmeXZLUXZ2bWZKZmg1Vm9XMUQv?=
 =?utf-8?B?SXBDR21xKzU3UVUwK1dqZnpkdStJc3Z0VlpJbUZ3d0NISExsam1RcUVhVmg4?=
 =?utf-8?B?eFdnaWhmR0pQOWI3OVhuS3FZcjM5VENtcVZZekRqUHNFVlVFbXAyUWJMS2ZZ?=
 =?utf-8?B?YmhPaklqaXJ0OXF1RjdXZDlaazJtSCtiK2JYems4RTc4Z1VncDdyRUp6dmJD?=
 =?utf-8?B?MzFtcW0xMDhCTmhHMnpUUytGalBLNDcvM1dHY2h3YmtBb1VaZVVRWFI1WEFy?=
 =?utf-8?B?S3U1b0N1Nzl1YStNTzFOakFMZUV1YUZyaHRmWnVDMnVaNWVxV1RKaXlpS1Nq?=
 =?utf-8?B?N1M4SkRTVVI4NW9xdWU0WUtWclZWMy9IWVZjZkNvZSt2REorT0xHM2ZSUE9Y?=
 =?utf-8?B?L0tzRG5xMGp2OXV1K1o3QzZFdjVYdVhUT3JTYkVHTlhGck1MNG01SU93UDRa?=
 =?utf-8?B?QVNIRmhEN3kzUWVzNVVMMUNVYjRETElwRHZWTDIybHhuNEFhQURjL2NSL1BJ?=
 =?utf-8?B?UkRCRzVuRWVoaWN5cWZ5RDlXQ2xYdlZadzVVdHpDMnJzTGlZK01rWHNHUjRB?=
 =?utf-8?B?TWJ5TDc5RjllMUJxUnZBdE9EalJESjA2b1NQdFdpN0dLMmZKbTBYWXJNVWhk?=
 =?utf-8?B?aDZYdU10bm5FVFFrSzYrSTZsd0VQdWc3a1pmRUl5Si9aQzRPNFIwcFAxMTVx?=
 =?utf-8?B?cEVlZjdVMWVNb3o5dUZ5akx5N0JMRk1GL01CZEdMRHdQTUtaSUFVU2lqdjhp?=
 =?utf-8?B?RWdQRytITEl2Qi9DTFV5R05ITDlqL2x4TUl3YlpFekd6M0JvSFBoZzMxY3FO?=
 =?utf-8?B?NnJPbWFYRG9PbVNnZENRYVZIcVBhOXRBd09abGFQQXN5VnJDSnZOUlllRnlu?=
 =?utf-8?B?YlVINnVHbWRzVTBkbE1ZTFF5REtwNEU1UmFLSUFGY29Ddi9WQTBDT1hyQzN6?=
 =?utf-8?B?MkVwTksybU5LdDNZSWhGTTUyTlZPR2xwU1BJTE5jZWJ2QklWYUNVdzhucVZL?=
 =?utf-8?B?VFdxTThTdHo3K20zM21qNUJsa3h3VUdhaTJuS2ZFNmRBSlZpNW53M2dkNXlO?=
 =?utf-8?B?MW1rWWlwdHdEUDBLeE5SRU9KV3NSVDREdXlQUHp2eG83S2M2bWpkTjQyZmJZ?=
 =?utf-8?B?SUlUa3VlTFlUSGdiZmVxZ0d1K2Y4enZLTitaZkRSSW5neFk2eHplMUkrS25M?=
 =?utf-8?B?alpPZldFVWxtZnNlUXZnUDRXSHRLOEM0M0hLZ0xYa1hPdTNhNm0wd1REYjEz?=
 =?utf-8?B?OUU1bjJLQ1ZMVFVNaWtDeW9aNlJadFpRV0FMOE9yUzhOK2cyNzRUaitxOEI5?=
 =?utf-8?B?RGxod0ZGYVQ0RGo4bEp0NmpaY0xqeXhDWEE3VGhrUWl5SHlidm1tcERTdzhT?=
 =?utf-8?B?ZVp5S3p2elRlY3U1UW5naElsRXB2d0JQS1lxTHBxTTc1cldCRUlhNXlIMHNj?=
 =?utf-8?B?UDYzUExZZE9hQXM1aDdxTWNRTFpJMWxyZ3BQcjNlMHgvanNUSEtVcUJYZTc3?=
 =?utf-8?B?WDU1bTVvMFNGdzJWaWRnVy9GUStBbGpmcHJ3N1JiUzEyakpOZVZ1QzBFdUs1?=
 =?utf-8?Q?AHOXt7w5X3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG1QY3ZCcEZEdXI0aVF6Q1pua2Y4Q3REOU81SzY4Y2tUOTZJUU5mNCt4N3hq?=
 =?utf-8?B?WjRwWEg2VzBoTlo2dmc4aGZoRFdUQkFOTGlZSFZmNnNGK3ZwZDdsUnNST1lG?=
 =?utf-8?B?VHorRldvK2N6d2R2WldPclpaalJFTkprcVFUQzJ6ZTRIdUZNd3VjTVh2WU02?=
 =?utf-8?B?alJjeTFydVpOdWRoQXZHYnYxMW9IMHpyVXVUZ2NoekxtZUxQb0NUZGh2aWho?=
 =?utf-8?B?L2h3RnJzSldGVzFxRlE4MUl3cVpVWHY2VWI4Vmg3TjhRVy9hRUJQV0xDYlpm?=
 =?utf-8?B?SElvUnBsNy95akxRL29NYzZjVDVoRUQzWG5KZGh4OTlUTHZqT2tYYXl1cVFK?=
 =?utf-8?B?OEwwWWVJVVhsbEpOY1NmRFc3dFpMbXRlZk5MYVdqa3pWTXRWREpRa2o2UkVo?=
 =?utf-8?B?UUthOFhLTkRUYVBYQlhJNkh1OXRXNG90SEQ1elk3U1E5b3lRb3QxMzNFa3VG?=
 =?utf-8?B?MHBTS09oUFdLSzBuUjZNRTFSd0hZZUpwSm5LTTV6eTlEL0xYUGovcStFQitQ?=
 =?utf-8?B?RUIxcTFTRmEvQVNVRCszeS9ZNEI4OCtoOUFTSmVDczEzYjVxblE5a21qLzVm?=
 =?utf-8?B?RFA3cFFHSHhBbVhmNmFRYkp1Q1NwSjRVMVBwRU1zeFh4ck9Ea0FlL3VnU2xs?=
 =?utf-8?B?MVdxbXFaMkxEMDUwcFd1NWtIeEdYNzRFbkMra01CSWdLajFzQm5QeW50SnQv?=
 =?utf-8?B?ZUgyQnVFN2xENyt6ejNIaUYvUnFablZrVFh6UVhFSzB5Mm81SWgvTG5KbU5q?=
 =?utf-8?B?R0o0YUx3Y3hzSWdrdjlmZ3NTV2QzRFU0aWxBdUhzQk5JL2xOWno2TnRWbm1P?=
 =?utf-8?B?ZkhZejdQSXVsTFVzNHBVQTN5c2FXRnVuUzFrd0lLK0pEQXVZQ1h3eXBPUGRU?=
 =?utf-8?B?VVFiNmtWMjh4a3VVZGNyZjFsK2hXeCtET3ptbWNJOG42T2JONlM4NGxmcGRs?=
 =?utf-8?B?Zm5YeHowYzdOcDEvS3Q2QTJKZzg1eFpXYmFMdVNJKzFzYmlSY1E5YWUxZHFt?=
 =?utf-8?B?VisrNGE5aCtNeWV0SjVaQUV5TXAxK05wL3RNUnIzNlpVRWx6cEQ1eTl6Nkk3?=
 =?utf-8?B?ZzFoSDEydVRzRWEvZFFYOEpob2g3di9rVW11MENIejFHRzlvNWk3V0ptcERZ?=
 =?utf-8?B?WUsyYjhtZ0dkNSs0aUNxMGcycUF5akFZRnduYjNpUXYvb3lya1hEWmltbjRG?=
 =?utf-8?B?ZnF3ZXNqaXdKT1ZqV1dhdUg0bmZRY2FlcE85L0FQdWVRSm5lR2h3OTVEWlRD?=
 =?utf-8?B?SHk1dmJKSVpOcW0xdGZVNUhrbTFDbjh3Sy9tODZWeDlZckJhV3dlYzhCL1Jp?=
 =?utf-8?B?SVFvZ1BBNVJUUEh4WlpkeU1sZXkySWNwdW01cGhLQkpnR3owcTVGM09TT3Zv?=
 =?utf-8?B?K0V3cEN3YjNHRXluaE5RTmE1WUhVeVlQRjVuN1BVUHFqYzlBYzA1R1pINGY1?=
 =?utf-8?B?U0lweVk1MUtrdlYxTE11L3phN2VvK0dTUGJCQUk2bTNyd0N2aHhveGtNR3Nn?=
 =?utf-8?B?WlFidUFkMWpBbjdjVncrRngrdDFLSUJFd2VIbVFRNFFlV3ZEbDZ2b1dmMWxm?=
 =?utf-8?B?KytUMENmL2U3MTVvM3dFNXFrU1JOVkdQcXB1cGdIWmJTWk1Jd2Z3a1NWblZu?=
 =?utf-8?B?Y0dnK0UyQisyWU01K2F3a0pydkVqUVVlWU0wUllaZ1VJZ0ZLL1Nmd1g0cmZk?=
 =?utf-8?B?ZlV3Q1JvNWNDMTVBV3B3UnUvOFFvYzdiUWFnTjhlQlE3RTQvNFZoK3BqK2d4?=
 =?utf-8?B?MGlXRmY1eDVTVFFtdU5pZ0ZsYUJZU0V5cCt2RmhBSlV4RHNoaDFMbFNaanlK?=
 =?utf-8?B?RGtKL1k4ZmVENWRrak5Kc2g4bzBwaWpWQVd1UVErSUwreTBSTy9RcmtodGwy?=
 =?utf-8?B?elV4VnZJbFlsa0xraStsOWUwQjNRRDJoS1B2TDN2dEFpSG1KMkpiY3FOQjB2?=
 =?utf-8?B?Ky9FMEJXcGNaMUN3ZWtnaWNNbGp5cVhFNTFSNm0zMk1LSTlBTFVXa3hDUVVZ?=
 =?utf-8?B?ZFMrY01RMjFja09qYnlMNnA3MXlFdm5RNmdoYlBuRVcyTE1IVUZ2QUhQSG05?=
 =?utf-8?B?TnVzMDdaNE5jbVVXTXFNaEdPR0g4blQvVVo2d0lEZms0ZTZtZElVdkl0aE5F?=
 =?utf-8?B?Rm9qR2ZBQTBRaGRNREdSRkxjN2pYZDA3RWZ3QlQ0YnVyYTd5Z1lzTTUxOWxR?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LawTQTt3Pvl/U682QXl2/+c5AC/V6eVbuVOue5RDBnft4hRXe79OM9Oo64xiKvVdzJ0niUrgLGShQaZdqZM/nQcmNWfG8dlfch9lwbumxMEdtfq6B/UdMNlCsbgPc8V4lJIZzlUUbmsY+WZsE6/Vowd7ExRI3oQhgUkBOiPZTsczin7kcQdWEZhtxJhaY3sq0rJM9mngzpymukNHfq09Aoctfj10u3w0WtNFQroJCXFodLNx99hXZYFDgXJ+2FHIWV9bwz8k3U+YN4Vrf4i8x1dpEPWcxsMmkOmE35MprC52wLbaiDsSIHvaA2OPA81FdVCjnXAC5/Gu4+UgxzmopWElqF4Nz1961EEODOLl1q6krjEsaMq8MJV1Zw9e7Xs6pZ6Qm8tvvylwt3LfM1i8fxJhNDz56tHyOOzSasOyfREItpCetNIKFIJjl1HRSSns2b98WNMfj7yEZVJ0vmdg2thvWaGDaFa/RJOL2SzBCuasyDphnF1gZhYcmeAWrO6AELvNZEIjpa0nYcSEau/miLrbUmDe7HpMK26uTtwfz6I1dmnuR6bXiRAkptEXi0XzLfBRNoHjPdO4nUKjgfSnK0Wmhh75HFh/30GoZr9ILHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4887fcef-371d-4bcb-69cb-08ddf50aa8f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:20:29.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duK6ABDaRvYaHIChWfRFnNrSM6QZ7Hy2f0uEUiuj1Hfy3xQtUW05ar7qI1NIl3OG7PBjwCj0Jn+nxQufBT7Plw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160099
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c939f2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=jcU5z_5U5o2pKb0cXikA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX4vqij9Ygkq1I
 RGTqJ0XUA/YcgrgqvZJ0ObLILNM3b8bs2vlVHu0LJKG0eSQE2xhg0SpRzaBfBiWef7UA/fMg34e
 9mFK1NJMlJXOCHGhAtVf8pan0YCZ6Nc9aJ1OsG9Cl5XB73mgbZVRKplwj7m4Agf8oXkX9zUxrun
 VF8DZBhw5hV5vUDxvipPum/Iznuq5iVU29gaNHttyh0hP2C9dJyYdq9s/JF+R1sxVWVajgHqjey
 Cm5tPJ9Yn5B/RwnCuXK8d0KBCaIIDbYkYXoxCV1CyGf3FFnHqukzwSwC5oz5qvA4h400UqzN7Hr
 RzqnfNKVkbCzCYKEqrtonxmEsOQiyq7ZSA9x57LMDGSpbcBikzQD3xiHw3M2xOffhuV1FV4FMSh
 NB3P4VL3sw7LS+tAnVtP12jb2BpKbg==
X-Proofpoint-ORIG-GUID: hr5yqoXV7LKFf9F2B9BZ5Se4brYGeUyl
X-Proofpoint-GUID: hr5yqoXV7LKFf9F2B9BZ5Se4brYGeUyl

On 16/09/2025 09:55, Shinichiro Kawasaki wrote:
> On Sep 12, 2025 / 09:57, John Garry wrote:
>> The testing of atomic writes support for stacked devices is limited.
>>
>> We only test scsi_debug and for a limited sets of personalities.
>>
>> Extend to test NVMe and also extend to the following stacked device
>> personalities:
>> - dm-linear
>> - dm-stripe
>> - dm-mirror
>>
>> Also add more strict atomic writes limits testing.
>>
>> John Garry (7):
>>    common/rc: add _min()
>>    md/rc: add _md_atomics_test
>>    md/002: convert to use _md_atomics_test
>>    md/003: add NVMe atomic write tests for stacked devices
> 
> Hello John, thanks for this series. Overall, this series looks valuable for me
> since it expands the test contents and target devices. Also it minimizes code
> duplication, which is good.

thanks for checking

> 
> 
> Having said that, I noticed a challenge in the series, especially in the 4th
> patch "md/003: add NVMe atomic write tests for stacked devices". This patch
> introduces a new test case md/003 that uses four NVME devices. Actually, this is
> the very first test case which runs test for multiple devices that users define
> in the TEST_DEVS variable.
> 
> Currently, blktests expects that each test case,
> 
>   a) implements test() which prepares test target device/s in it and test the
>      device/s, or,
>   b) implements test_device() which tests single TEST_DEV taken from
>      TEST_DEVS that the user prepared
> 
> The test case md/003 tests multiple devices. This is beyond the current blktests
> assumption. md/003 implements test(), and it refers to TEST_DEVS. It looks
> working, but it breaks the expectation above. 

Sure, I do think that the current infrastructure cannot handle what I 
want to do. I want to test multiple specified devices in tandem. md/002 
does not have such an problem, as it creates the devices itself (and so 
can specify test()).

> I concern this will confuse users.

understood

> For example, when user defines 4 NVME devices in TEST_DEVS, md/003 is run only
> once, but other test cases are run 4 times.

Yes

> It also will confuse blktests test
> case developers, since it is not guided to refer to TEST_DEVS from test(): e.g.,
> ./new script. So I think a different approach is required to meet your goal.

ok

JFYI, I had been using QEMU to test this with virtual NVMe devices. This 
allows me to manually set the atomic properties of the devices for good 
test coverage.

> 
> 
> I can think of two approaches. The first one is to follow the guide a) above.
> Assuming nvme loop devices can be used for the atomic test, 

I am not sure if they are, as I don't think that any such device will 
support atomics. I did already consider this.

> md/003 can prepare 4
> nvme loop devices and use it for test. This meets the expectation. This also
> will allow to run the test case where NVME devices are not available.
> 
>    Q: Can we use nvme loop devices for the atomic test?

As above, unfortunately I don't think so.

Indeed, the test really only tests NVMe device queue limits and not 
really the atomic behaviour itself. If there was a way to configure the 
atomics-related queue limits for nvmet, then it could work, but I don't 
think that there are. Indeed, it does not really make sense for these to 
be configured manually, as they are real HW device properties.

> 
> If nvme loop devices can not be used for the atomic test, or if you prefer to
> run the test for the real NVME devices, I think it's the better to improve the
> blktests framework to support using multiple devices for a single test case. I
> think new variables and functions should be introduced to support it, to avoid
> the confusions that I noted above. For example, the test case should implement
> the test in test_device_array() instead of test(), and it should refer to
> TEST_DEV_ARRAY that users define instead of TEST_DEVS.

sounds reasonable

 > > Based on the second approach, I quickly prototyped the blktests 
change [1]. I
> also modified md/003 to adapt to the change [2].
> 
> [1] https://urldefense.com/v3/__https://github.com/kawasaki/blktests/commit/7db35a16d7410cae728da8d6b9b2483e33e9c99b__;!!ACWV5N9M2RV99hQ!Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n1Q9dRRRJxbZQeqRtr$
> [2] https://urldefense.com/v3/__https://github.com/kawasaki/blktests/commit/278e6c74deba68e3044abf0e6c3ec350c0bc4a40__;!!ACWV5N9M2RV99hQ!Lm9AlQ3T9qSGDEjCR0nGmjCGC_2wfuAbkP6zN9EfZD7L2Y7mgpKPah_fYZh6L_OPkH9IIxP4f9n1Q9dRRRJxbSlcsw0E$
> 
> Please let me know your thoughts on the two approaches.

Let me check it, thanks!

> 
> 
> P.S. I will have some more comments on the details of the series, but before
>       making those comments, I would like to clarify how to resolve the challenge
>       above.

ok, good.

Cheers,
John

