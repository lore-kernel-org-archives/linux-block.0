Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE257D512
	for <linux-block@vger.kernel.org>; Fri, 12 Jul 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780447; cv=fail; b=g4CIhiF/BmnMYjRXhHv3GQUXXZZdq5KE+R2cwTr3jbb7GlvOXRNIfL5Gj1J0PUrCJ8Ta0F/ibpZJQ6TLpI8wkT1GJczuIqdqpwA+1x+uT7rg8ljR4lYWg/X3CNDNCvwkpvX6UH+yqj1bG4msa+l1fpVfDW8/mpcCmH9SoFnR7k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780447; c=relaxed/simple;
	bh=Ry4GHPQ0ZylzNY9J1e9O5eH90ej9qKHqZQ9oZ2iahyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ug0LLMSYsV8wme+hPWm+CiHeIq5KCPJHvCQGTlVAerfb3KxQ3VcGX7tye0R0ADCEKFztYBh0MMvtIGLUuNRAcsxn7CxyGp0jp3r7J0wodHEV5yfVml5ASD03q/qoDdfNeQcCNLxjOnXZjF4kea0TWLiOtaR/woYwEVtg6n0nodw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T5m5tgxj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=acpEkv3u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T5m5tgxj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="acpEkv3u"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1BtYZ002975;
	Fri, 12 Jul 2024 10:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Ctq/aZC5SzDze/z69rHbY1pH/8WxtspPEPkbYMofx1A=; b=
	T5m5tgxjzjr2cdQ9T0QrIfHZqKUgEqSs+u4sgp9nQ9I/41/YMObf5urlp6dqrjsY
	QydGyE1o5SRRC5DGzf1HN5mlLxXyQGPR1+Gq+QL7SUV6E0ex2Hx+jbndzctZDQcZ
	+x9yUCcNNDHB0Klaqq6+1rI/DyC1/PsIWuy4nuaeBudHdP/MIWVUMFIBSty7vtXC
	+i83Erl/3SWFXG8LvzEAljXfoTTuwtGBtqaayHAIkd+uFwQ0/OGgFNyWrScbzdEF
	2fxW1k2w5tp5F1FPuixZA0BanLBX1m3YOHuIG0IgsL0sldHvIOO9TJFkyq6tojR7
	XkSCwGe8UCYW9fdYv7QEZA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybuqg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 10:33:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46C9PiPR033921;
	Fri, 12 Jul 2024 10:33:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3d651-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 10:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeSydRGfzIHifSf7wWHnpWKccAcfO4Dha8M49LMuwPygUvwGDUDyydcRkhCrtKaFvc8aZLkTE1ufqth+DNToKsxw6FSjuwFQPsXUCCqKrUAmpNCca9GEKIo4TDSRWNgyflsId/Dv9n26r4BMp/P7kwQkhanPBALg4XI2nGO85SY24qnS5pT89axAuL4v4Ejjv1yC5HS5j1mrG9weu2CPrNZg9yHvaorHMOtNkGG/wPDNoTI2iPoICtjlrkO3AJkcoLbu0JzWJxaWGGq/oBw8EnquCrVIPR7+kvCJ6rTs13uiFnK6ZtuwmA7IK8FqbccxEtAGXw0B+PM1lEFAqEYj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctq/aZC5SzDze/z69rHbY1pH/8WxtspPEPkbYMofx1A=;
 b=FpyZrNXf3odiqjBEu4cX0xEYTVuzowOad4YO3Ker3VDHLC2YRJfvK6/01ae08xuFpCn0J2QC4mTlhAS5CNa94NANLydD60uGwjP4q1Gae4o/UoGicquDUqRFkmeL9kwv1zFK9UC8dyn2kiySpWlLHPVgQDxHMOF7/7rD4R6HHB5iYcAizUChLlC4Fesij86XVtS+HdoSnVbim7UVHPjoTp0p0nl8Qm7TstPGfcsRmFJ3pFKcDD9R6gqegO4sweZaEYMjn0mLnZ2QPP6te6FJ4RasMCvnCCklCyu5F1BN9HQqHMIPoAk1+NNitFrxgwqirSnJ9Q1Bsb6u5o35ME9G4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctq/aZC5SzDze/z69rHbY1pH/8WxtspPEPkbYMofx1A=;
 b=acpEkv3untun0n6BFJZJnrvw4UUXeax0SVaL8P03RbUdJm2GhT3NKG6e1vAA/9XmFLaICZgtJdF/namsFTOS/lnuoE+KjxGCJONSoI2Qi0vmvIzvoyKWOAS9+7gkXeUghPed+1PKxSzPWnnuQat1JeVd1eydP509iK5AttF2wY8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4124.namprd10.prod.outlook.com (2603:10b6:5:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 10:33:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 10:33:53 +0000
Message-ID: <16f35275-7849-4c67-8678-db2993017596@oracle.com>
Date: Fri, 12 Jul 2024 11:33:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] block: Make QUEUE_FLAG_x as an enum
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-3-john.g.garry@oracle.com>
 <3708bf11-ba92-43b7-8c71-30b2dff76c5f@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3708bf11-ba92-43b7-8c71-30b2dff76c5f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0048.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 61239555-0676-43c3-791b-08dca25e2082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VVVGczFFbTk0VE5BT2luYlJ0UTlwdlhRMVk3eXhINjJWakN2dEtsSUMvQ212?=
 =?utf-8?B?Skh2MndMamJZejNOVkxIcDZaVXY3dGQvL29rQWx4cFllOUZWYUlOZGFUV04w?=
 =?utf-8?B?UnZHQ1NrNXlHNzZJbFNrdm0vRm9xSTNlVmhDcldvakN1MDJ4dDYvVXlhK1NS?=
 =?utf-8?B?OE1uZTZETmhGa1J6SllmM082WmxNd0d4NVU2SVJ6OFpMcDB4RkdZSWpMZGlU?=
 =?utf-8?B?MHlHYnF4NURqd3NILy9UZDd4VFRSZGd4aC9nNGJBcEh0S0ZwT05KeHBpMEI2?=
 =?utf-8?B?NGJKUnMxRFpJMHJLbHY0dkJmb0JMWkFXdzhTTlp0R05NaFQrSTBNVFQ2NnA1?=
 =?utf-8?B?QXNwUy9nN2Q2MzU3VjJJUEMvRTdjRU55Nkt4MWl2S3JKUFl4QjRyL3VqQ1hM?=
 =?utf-8?B?SlpzMlZscGoyTUF6QzhZNzdjU3AzYnh3MGIwQ05QRzVIMVdOZWNSdVQwdlQ5?=
 =?utf-8?B?SmFXUGRLUmk0Qjhzb0FSWUptT2hjRlh6bkhuU0JqdisrSUVmYWtCcW1ZcHkx?=
 =?utf-8?B?ZXEzS2gzWFpueTBHb3k0Z3RHcFNoZFVDZFJnbjVOb2UvVWFsMmNYTW9wYnBn?=
 =?utf-8?B?Q0JHR1NkNG50cmIrRHh2citnZjA0NVkzb2gwb3JyYXk1WnRwRWRucnZYVXNG?=
 =?utf-8?B?azhjQUk0dE80RVhzd0xuNHNQQmNWOHhIWi9EOHE2bXpJTWtqL29zOWZDUWQ0?=
 =?utf-8?B?b3BIdXMvMm5UM0FmRWY2REJQN2ZwUlA2eFZRU0ZKbUR5NUhNdFprNXlIOFQ0?=
 =?utf-8?B?eWtWZGl6QkwrWTVtZW1NT1hySitQc1pyVGZSazdkQUZiUDFucEdTT0hSOVJn?=
 =?utf-8?B?U3k4WW0zcEdmUGsrZFRBR29DR2JLVzFIYmczNDRDRXpWNUkvdWxlK3QxNHlJ?=
 =?utf-8?B?YlczZTE1ejRMQys1MDJoNnN6TWVWR0lnalRTL0diclFtQ2lES3FVelRKUGJR?=
 =?utf-8?B?OE5MWEYwdFpvV3JQTDhiV2VMVmJOSHVkM1VPbzY4R3hvOEErellWRGN3dGQx?=
 =?utf-8?B?dm10MHhIZmRSTDdMZ3hKQ0JBNWFRZVhCOFJBTTdQa1J2T1pVckQ1Q3Q5TW5C?=
 =?utf-8?B?YUxGa2c1OGt4dUd2NGo4UjRYdTJXYTU5bmxlYXhQRks0a2o2bU9VWi9Cbk1y?=
 =?utf-8?B?U2NOZnB0c0lYekNrcCtrb01QTXdZYlFvOFp4SlI4ZW94dThXMmZrY2djclFl?=
 =?utf-8?B?dmdFSGpBU2ZvODhLTW1SNW9kRHd2MWtGK2VIMVVRN3kyVWIwMjJKeEt1YlVh?=
 =?utf-8?B?Zm5WY3RVZlpiUFd6SlVTU3F5L09PQ3VIa1FnUy8ycDNJbWxEU0tpN0dEV202?=
 =?utf-8?B?eEVlWjJ5SGJQTjNwMHZtVTBYaFNYb1ZSb05iUW95bnpXM0VVTWFaR2VTQk1u?=
 =?utf-8?B?Tk5TK1BsMklhK3hhRnRGUHYvcWN2d3hzZEErS0NwbXQ1VEdlZmhsNjNmYThS?=
 =?utf-8?B?NWdxb3J2cDNaVG1JRWlycEtkMUNzM3l5Ym01VTVQTHM1L24rdnR2eUFucUl4?=
 =?utf-8?B?bnBadHpuLzJwQ0tYUjd1NjFDaGVZbm5qc3hTaHFDNjFtZThiNG10ODBwRnZQ?=
 =?utf-8?B?ZjB6bld4RVovN0NXNWFqc3YxMTAvbkM4T3p6ZG45YTI3Q2ZHL3pxN0FEd3o4?=
 =?utf-8?B?aExFRWc5cGpKbW9jKy92QVhUMVc3cDRGV1lMMmUrbXVVNVFtbmdPMzhwcmVs?=
 =?utf-8?B?WXMwV3k2SkRoU3VOQzF1WnRPRDllallpQ2NFb0RkbUYyQUZKeDlHNXBvd2RW?=
 =?utf-8?B?QzJaQnZ6Y3hEWC9jNDkyU0RtSUhaenpicTVpZXpLbW41aFE4TlR6Qno2SGxG?=
 =?utf-8?B?L1ZFSmJSeE9aSm9YN0ozdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFByTGdveE9Sd0FidC9yalFvTGpvYjhsakhyY3pQajFwcWkwdDRxYlh3SWhV?=
 =?utf-8?B?M3ZTVkVQZE5aZ0pCclFCNWFSZ0xhRTZ1MW81WE9jbDZ5WXBuOWxiTE9icjUv?=
 =?utf-8?B?TzVvSDNRbDRad0w5RDRod081dnpoVkcycHdyaitmYWh0T0pyQ2NlOXI2VjBi?=
 =?utf-8?B?OCtzVVBuVHAweEN6VUFhK0VnVWpiMk9hc0F6VDd5SFVkOVNFY1BucEVVYi95?=
 =?utf-8?B?RzlKQXIyTnAvNzFCYWlHUnozbCtVdWdRb0lWekZlU0hDNEs0cm15NklNVXRt?=
 =?utf-8?B?bGJMcUUrNkZQNnpuSGp0aytzMUdmOGdpc1NBcVhyR0E5RVlKa2xoUDNUUXNh?=
 =?utf-8?B?Smo5eW4wbG9iYy9nUlRKU3dDbjg3K3BVL1U2dWY4YW5ILzlqRWtNRkV1QXpl?=
 =?utf-8?B?bFRRTExuR3NBRFdEQ01BbHRLQ2hYQkRGWC8xTEF3bXhDV25kTjRuNUl1RnM0?=
 =?utf-8?B?Qm9na3ZhallDRmRnWVZadm1zcWcwVzBkUERmWjVDaHVadk84Mk1ZVHJwMEZj?=
 =?utf-8?B?eXV1dXZnbFIvbTQycG9JYnFXbHg0OUZuQWgyamRPaDJ2TXR5ZnNqVTRraENr?=
 =?utf-8?B?T3ZCaDgvVnhpbW03dFpRUDBXbFhlUDRRMnI5K3AzUjNjSk5VYlBvQzNrZVFr?=
 =?utf-8?B?cEs5TEVBWW1iNTEwbkxxVjk3dlBvZS9KbmRRcEFsS1lmWUE2bEhCbFB2NTB4?=
 =?utf-8?B?ZHpTckxDNlhnclJIaXg2VEs4RnNHK0s2Q2ViTGdBZUgzbE5RbEVUY0ZEa0di?=
 =?utf-8?B?MEdOYysvSWZJZGdZYmsxeWhscUpzS3BNcm82OWJYTS9DdC9PSVVhWU02M2h4?=
 =?utf-8?B?VGZSTkZDWFJmZmVIUGFGV0Y4Y0xwU1JRRGRjWjloYmhuYVk2WXZwSEh2dHZT?=
 =?utf-8?B?U2V2a0NUSjdTbytjWmtlZFpmNUtNSFhsWTFHMTluUzhKaktubitWOStqbjdQ?=
 =?utf-8?B?Y0NWV0VMOU5iRHhhMGR2SFk0TDhwejR6UFFHMEl0Q3BSZXRSM0JNUVNuQmJh?=
 =?utf-8?B?YzZQTEQ2d2VvakcrTmFBRFFWQ1ExS2gvaDdBY3Y0TEgzZDRhRDE0b0IvTDRl?=
 =?utf-8?B?bHdDaVRoQTg5UzFBWXdHQ29MNXN2UlppS3hOdElsS0NmVlhmS0FvWHRrc0ti?=
 =?utf-8?B?UklWS1lGMm1aYk1YRDJhYlpid2RXbml3Sjh5VGRkZVFuN3JuZTdjZmxZb1Rh?=
 =?utf-8?B?Y1BGUDlxUWphTS9pVWJlcnZ2cXBxamtKL1JEOUpqMGhiK1ZnM3JsNU11a3Zq?=
 =?utf-8?B?M2JLMW52SC83WG9ianZmVXltR2lobUZPTnUwRVg0YmYxZis2K0lRM0NrdExw?=
 =?utf-8?B?a21pMS83VGFtZHR5dXVYU3FiSHFSZmJ2cEtac1FwNDJPQ2VBVW50QU12TEx5?=
 =?utf-8?B?M2pOTDVIT2F4WkY1T3g4YjFnTnNOVGd0ZHJkeEJzMjZyejNUQVB5MmNNQVI3?=
 =?utf-8?B?YXh6ZjJsNzdjSDdzeFliVm91MGFLN1QxRVFLSEYrS3FrbVAwM05ObGhtMGlX?=
 =?utf-8?B?dHVMb3ExQ1NuZVowRE0rUi9BR0NyVG13TjNwTmYxSG8vZEtWTittZkFaeXVC?=
 =?utf-8?B?K1dRZmFtUXFJeWtOQWhlaWJBZHlVeU8wREwrVEJrQlo5K3RUcm9KWGJOVHhN?=
 =?utf-8?B?RDM0LzZMb3EwL2JSTU5CRysyOWtrTGpNUTkxUmFPdnl2VHluZTF1REZ2bTNu?=
 =?utf-8?B?ZkYramEzOWgvU2lDMGd4UmwwNGNqT2oySUU5bE91dDdpc3lrTmlaaE5JOWhI?=
 =?utf-8?B?QmxMQkNhWGJiakZ3OUxZY1k4QU8yUkQrdG5tSlhWZjlNWmhCc2xmTlgrZTFK?=
 =?utf-8?B?SGJ6NlNBZE5uUW1aZ3RUWVJPbk05dys5ZXhJeHRrY3JpQnNnWTlGWGdyd1Vr?=
 =?utf-8?B?bzQvZitDdU0zT21tT1k5dXAzY3NEWjN3VmRXaFloQ1ByOU5UK2F3Tk1JblN1?=
 =?utf-8?B?V01rNjFGdkMvaUl5ZGwvTitKQXNmNFlzbkVxTExOeE5IeGRjL3gyaHkwaitx?=
 =?utf-8?B?NU9DSzdjOXcrQ3gzUWFwNWI3YW5XQU5UZ0pRbkpJZVFHclhLaUg4cnhNaE1J?=
 =?utf-8?B?QzJqTW1TYmp1QmdGM3o3R3oyV2hOTkVQaVRQc2Z6NlZ4SlFHbEFuUUhmOGU5?=
 =?utf-8?Q?vr0BtmdsICmk4RDRmhGPYlN4Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	m92bKCU4R1ojp4q2ioJuhtmQrTB+eiJeZ4Tw7jKobnnLggYQGviVjv4DH81nbbNLWo1qFRquQqcByer88oC0sCwuVQu7ol6kM9sv2Q0Um+oJqzxKSh7lsaNUXZW46oBP6tn28ejkjVs+jHD5edg6jRV3yj08DPO3nzNGsdSu1KVqcp9lVUENDsfr9w4kvCNYmRihr7VgV/KRmP9w7wKTSTOG9djlaTkxzSllphdTTEWYo+o1GXystlHCfauw0GTy8hx/xlhe6T2uhQ1tOUiyoXMvc6NSwDGtLSu2KfZqLv3xZEPvgghflTzF7R+yIaKMGoMgibDnyiL/JvGgqjgVaYWnGOxsiZfrfLQ+H3NWQkKKPwkdypPdKCbyyoGI0d4n/6+j4D4CiI3Jh/aqkvnz1tuYM5w+EU6LGgdGmSs6pVr8d21VEuXLDwZtQQhL/Cm8cZQhPi20nzrxQ26GmfoJTCF5nXYYAfqkySx9aLuayYYVraBylPE9IfLd2GCdR6jQuuFso/HjRTEiygpEKgpeViclwVKHZY/xzpOr6gk75is4iV/vnjM16ymPLuR2LjDlKWqEmlD74vHUHpYXrK5RFEqy7tk8XzPqJdDDmnjY2Is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61239555-0676-43c3-791b-08dca25e2082
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 10:33:53.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gRdHpIgDoSSE3O9jn64muOoFzUVkDGcgGsoR6c1N68homoWS/ydcwr0X2zCFjyp+mPzuhgRAu0qVPaFir2aGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_07,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120073
X-Proofpoint-GUID: hO71kI9PLSFMTxMFLaQ7SXfixePrYRyr
X-Proofpoint-ORIG-GUID: hO71kI9PLSFMTxMFLaQ7SXfixePrYRyr

On 11/07/2024 19:05, Bart Van Assche wrote:
> On 7/11/24 1:23 AM, John Garry wrote:
>> +enum {
>> +    QUEUE_FLAG_DYING        = 0,    /* queue being torn down */
> 
> Please leave out " = 0" since it is redundant.

ok. I think that assigning the base member to zero is 50/50 habit and 
paranoia for me.

I'll look at the rest of your comments next week.

Thanks,
John
