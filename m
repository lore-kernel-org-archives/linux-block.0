Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53062562E
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736303; cv=fail; b=kjaKV6jMqhJqDxdc8NDrOX6oi3AfSfaMja1X8W/CA2LyIZ+J9kjunLaVhTEh7JSg046fgT4X8LHdSqg5HbhZD8TEWt+ELQtfzP9A5IYjvx2n9hQmu+D/dnoQwF/l86XAfF98OcajYmUkkgrFhJfD8AECBTFiEHt9ZcAT2ZFc5cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736303; c=relaxed/simple;
	bh=G6WBOHUWSuhRGrJVunPLbuU376IE02fHI403bawikDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rAEpOCK+n8raug5GVGzDnrVhuVOpzcDljrcpCOZFOFkPZfB1oAGns7wako9AjMpo6JslNCq+Fem0qg62BcKsVoan1/PvNkGDHyuem3+VX2ekINlOfT5tzaP6BqR47hGLtg27f2wZ00wQ3jRb/zhnVXWmplMvtxaXGGAVzcuU1Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=llKW3JLf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HiyFcG9h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llKW3JLf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HiyFcG9h"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtVcB017293;
	Thu, 15 Aug 2024 15:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=5HKF4FendymYzv+GBNBRZOg4bm0oQY/t4nRK4ww6EJk=; b=
	llKW3JLfq3h1QqTzek4kxKsWjoS8R41auC+bvaT8hra5AFbDJvGKCf9BGmxUq6Il
	P4xnTKfYzdKC/6jmNI3DTb6ZSN3UZ1MkyhahPrUjRBFfuIljWlCxjgK7BiaDdd6m
	gO6sSWybzIBNfd7/aKtYqPL1ZQEnA+Ra5BA1sr7hcwPNB3Lp/uvmpOcU0SirLI40
	QSxRozepTJvc8iabQGYhpP5xAKRzRLgp1hb59LlkAdMUPvykn0WRoVOWmrUWWmxe
	6HHJl6GsGffouOHUGLQvMJ8BoRqWsMe7sk0t7nnxP9b07++xgKpWQ741Hz61qgfC
	+aDLYglSilCkhTt230eFJA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttjtd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:38:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FFD1ZZ017670;
	Thu, 15 Aug 2024 15:38:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnca88t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj4/npQzLEk4DXABArDQ1I6xV7Xv8VUCGy26a/pCZCZT2HV4PkHGNDZ4Tt/i7c1UcufgeG1CJcD2PTe24IgOlRw0kuZcD77ZyTko9I62tyr9kaboXkzRdMdPXuL4vD4SwsWftliywmQJ06qgeUY1O6gIACOcfmglNNEg39zaA5Tktl0IDzORqlADlw5fH1lb4OYqXva+8la5YlVMSch1rXbOdrEriQxXoP8/cCQ3bmBslmzYKqZCl8Oz6LbmipiHc4GRxWl7Rl8NcIg4/re6p6xQ1BvtuZ5vsycsYVw4CFQA7gabytU6PEDNNHMX3yBym3cBt2BnQaA58H81i1ke+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HKF4FendymYzv+GBNBRZOg4bm0oQY/t4nRK4ww6EJk=;
 b=a6XWI+DSfXtx/l/JaYeBKjWeoEH8zbWyA93gQM+7PypRIqgJw6YKPFz+y3KY4d6M0vOPer6UYeSsDHLAueuwmDI1PPFZvLMjlBiEivWk5y6PckAgqBWEFA6D48wPuZkbIc5MrVxIS2LLM51XK1kpiLPDfxjJCvh34h74bSGjnLT1QZpIA9xuY79UetfX31V+KEPwaKhvr2NGRzf09HbHWpROpzqSZqLNjesYqIx32R7jDfRqGfISpRY6lNfn5yhwIUfkPCh/8HyCKGjSmjuMIv5+FbFIVi7Ci/1vzUvg1fjm5gxuE9D3uAjYlEdB1MxPOn3UWsr04c3NCX1fzxiKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HKF4FendymYzv+GBNBRZOg4bm0oQY/t4nRK4ww6EJk=;
 b=HiyFcG9hCFCOuZ/aSxXoX6wxD9z6KTncy+wdw1reHDilmihB9UTsFr2jseNxgO1rTVmJKH6Z55/2EGl4wJJQN6eFUAyXdCxEjWH9xHmDdLGVHluz3TWZ+/U1X8Yl+QErUr84hpArFMR8a02jXHIFGpMTOzU2ktztYV/tTa83VvQ=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8139.namprd10.prod.outlook.com (2603:10b6:208:514::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 15:38:10 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.7897.009; Thu, 15 Aug 2024
 15:38:10 +0000
Message-ID: <76f7ed9a-2491-43f6-9afc-381dc109e944@oracle.com>
Date: Thu, 15 Aug 2024 16:38:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-block@vger.kernel.org,
        kbusch@kernel.org
References: <20240815082755.105242-1-john.g.garry@oracle.com>
 <20240815082755.105242-2-john.g.garry@oracle.com>
 <20240815124047.GA7803@lst.de>
 <3275afad-cb94-4c8e-b70f-3a7e8bacd89b@oracle.com>
 <20240815152638.GA17618@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240815152638.GA17618@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a71c76-a1ff-4ad6-e795-08dcbd404461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWRVNi8rQmQybHBTNUF5QXVweWxmNDNoaE5MaEpBdERxdUh2WEJHMnFNek5h?=
 =?utf-8?B?MVFndGtOYVRBQ1BLaVJnUkJaVlFTWFlaY1RwSzN6WDlFMVZxclNTQW5ybHor?=
 =?utf-8?B?cU5UdVc0cU5POStabXgyN1l2R1hsOVVTM2Ywb0orT2lVZVVTWEFERit6Z3Jt?=
 =?utf-8?B?M2ZVNnBIM3JFdzFkZ2VoM0xwTTZpQmpDbC9nMkw0eWUzU29yZzZxRXhrb2Zq?=
 =?utf-8?B?Q1l3MjUvN2x5TEIwVWdVeFFBbC9jTFVpUTM1bnB3Z3lSOU5GaVpnT1hHUHlF?=
 =?utf-8?B?RVJNOExhVmtDL2JCdG54SFNCb3NDYTFYYTIwQ3VZamhBaUNWczFQQmZIN1Bl?=
 =?utf-8?B?TXlDMHF2TUdLVGJXVHhZRGUrSHd5OFZkYUxCamNQZkp4aFFVNGYvYXM2QThu?=
 =?utf-8?B?LzgyMm1HMHllOEFQaWVLR085ZHVsSDBpa3VycEt6aWNLclFRRVBEbzZmVDls?=
 =?utf-8?B?N0dObUZ6MFVPalpHV01DektXQkx4NFlSNUxoUmlhZ3B3dUlBVy9yZkNsZXpI?=
 =?utf-8?B?NDVjcWNkNnUrWkp0YkVsM0NsVzFyNEZNNGxPWnlXNVczSU1LSm10bXovTnVt?=
 =?utf-8?B?b0wyenVYM2NnRVhiaXYrdkhIdlloQlhDek5TeEQ4RzF0OVFpWGJ6ZWhTdjZi?=
 =?utf-8?B?ZUZyMkJRRlZvRkNTVXFKWHA2dmExaENFSmNsbmUwelVPb0N0aGhORm00bC9w?=
 =?utf-8?B?cFE0d1lDckR2clNtek9Jb2N1TXNoNkZaVm04Sk9oVmZ6RFczMnByM05BSGE3?=
 =?utf-8?B?TlB2TGpuR3RBdVNFK2xPWmRNSVFTRFk5UWxXNXZnQ1ZNZG54S09aL2pWQWFW?=
 =?utf-8?B?TTlGekErNHRabFgvSEF3WHIxVnNZTDdTd2xtNkZVTUp3dVM3dHVjVitLSEV2?=
 =?utf-8?B?NU8vWEh1YXFwWVdIYlhmKzdNMWI4Z09UWDVsMWordHRCa2pkNmZtTnVMQ1lv?=
 =?utf-8?B?ZzduMHB3WlNIWnpCOWE2L2tTNHVFeFc5OGdxRTg5UzcxUU1oeHg5bGtaejAv?=
 =?utf-8?B?N0NWS0RXc2NwY2o3bjJUQVIxUkEveUxPUThPUjkyWllpbUNrdWZRMFBpaTJr?=
 =?utf-8?B?ZEJydkNOZTZ0RUtlS2d6dWZmd2llc2dOaU5ZR1BYbU40ZWEwMThMSUNIT2F1?=
 =?utf-8?B?QWx5b05McmEzeEhKclk0MnQ4WlJOUjYwT05wU2FDbmRUYVF0dHR5ei9URXk4?=
 =?utf-8?B?MDNRamV0bm9qamRsYXA3c3RQcjR2ZU9ReTFScklUWmZsaHY0SHdMRUFGZFR6?=
 =?utf-8?B?ZjdDQTdmY3R2WEl3aVZwY3ErSTZkeVpSNE1tek5nbVRQdDdKU3Zwcjgxc256?=
 =?utf-8?B?L3ZOOTN1bDI5Y05ZU3JDVEUxTnh3eVZ5OGpKRFhHTW01VnNBblkzbUd6TG5W?=
 =?utf-8?B?cXVDNkkyWi9INFByMGMrQUtaaUtha1M5SVM5RHlzbEtHbWp4eXZDbS81MVBY?=
 =?utf-8?B?dkFmVlNvajFkOGFCNCszaS9NQXNzTXdiN2FYd1JhM1NvSVdXM3lpR1RJcThK?=
 =?utf-8?B?Mk16UFJRM3VxSDh0Y25qMCtsN1hOb3I0M0pUbGsra2R5Qk9EaERBbVZQSGpl?=
 =?utf-8?B?dGovNmVlQXpRYWc5VzYyUDFhakhxenp6MkFGZ2R6YmhGdGtiaW9MZCthU0dC?=
 =?utf-8?B?MEUyOWNoMVVuUnVTL3hRRkMzRjZ0K0FMdXF0enhQM203dFhHV0NXT01GKy94?=
 =?utf-8?B?QU9KbjF0N05QcmtxWFdrKzN3M2syNXNwVlN2Mzc3Rng0dzNCcjFKS3UzamdP?=
 =?utf-8?B?VUl5VXJ4Ukd4YmZjLytNR3RzNmMvNjkrVS9TaXY3TnlERmd6aThVa05vblBH?=
 =?utf-8?B?djNrMGkzeFhFTWUwWHdHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M09TbFpWREVUMVpQd3RTS0J3RTdMeUppUjNZd2dlVjAxVFVNTnRLTHNGc3Fq?=
 =?utf-8?B?ZDViMndjbXl4aGJ0b1FHQ0RNUjg4WUlMaXlDQ3M1R2ZvVW9EWUdHSzNtSjRx?=
 =?utf-8?B?QlhIVGM4WVcrU0FqZEVwMkZrQzVjU0tDMGg4YTYrd0FOeU1zT0c0NDZJbTNk?=
 =?utf-8?B?LzBFMXJ4ZGJIeUF0RHpZNnFyZ0NYTUVkSTN2SUh2T0hSODFyQ1NEYWEydHVR?=
 =?utf-8?B?VGs5OStlb2NDY2xydnhHOWhhV05sUXNaQThySkxpanRmODRvbXhHdXovRkRI?=
 =?utf-8?B?UHh6dEJINDREUU1Sa3hDeEFEWWZqQUtuVjdLZWpuY3Q3eWZ0WXVZYUo4VXlx?=
 =?utf-8?B?YnptUU41bWxROW9jWjQzSUF0eTRkL0lsZ3NjSkRCcVJvNitJVGFWVE9PUVdM?=
 =?utf-8?B?WjZzdU9DU2UzQXk1N3A2Sk13N2toMlFaeGhaVFJWTUQxdktuaktrRTYyRHJ2?=
 =?utf-8?B?UEhtQ3d5aW1mcjNsMCtaNUtmb0dHajBGL1NGU2p4WitXMWM1UlFwaUozUmFJ?=
 =?utf-8?B?NTBpd2FBbXlNdTl4WEp3UWxXbDMvcURoRDZINjgyRTMwM1BsbHp3aHprLzM5?=
 =?utf-8?B?QjY4TVZsandKdE5ZVWVKZ21GQnpuZE9iWm1rN0pUQ2w0ZXFncHVsZ0JJNDIx?=
 =?utf-8?B?SjhnZmUvTmJTMHZSSmV4d2prMXIvSER2Q0Qxb1pRR0VZTU5QTk9mNHVNODUv?=
 =?utf-8?B?Z0dvNzZGTUM2SDd2NFd3WXg4bVBSdW5UcXVCSk9vd0ZRVlV3TzA0aUJ5YzJY?=
 =?utf-8?B?QnZRUFRxYlZ0bTBGN1d6cmRWbTlBeVZuOFFsSzREN3hkYjU2anBENWl5Y3g0?=
 =?utf-8?B?S256SWN2aEo5YTJWa2Fna3hkMTIvYmVaYWNJdVV3YmVoOEVyWE9hWFhRMmE3?=
 =?utf-8?B?eVNyN2YzUlBHRVpMY0VUamp1M09LVzRiam5aanlhTHY0TmlpZGZraVhzaEhv?=
 =?utf-8?B?QnpXN2pmNU9XdHZNRjYzNW1Qcitaak9jN0pDQlRYak4xY0pwUU0reS85OEdV?=
 =?utf-8?B?eUsrNEJ0RU4wcFBVM2ZQNm0raFp3MDU2YlQrMkdGa1dBRXNWWFVLMUZ3dGpM?=
 =?utf-8?B?Q01Ma3dTRnN1ZnEzYWl2T0NTb1VyQnNLbWJnUkswR3ZHdGNCcVBJaWg1RXQz?=
 =?utf-8?B?N2VDZkhvbEZIOEUvUVVSYytyQXEyU3dPZGp0K3Nzc2xQdzhTWXJ2YkVXd2RC?=
 =?utf-8?B?QjZmeVdkdDVkMk9rbVkrejhIOXlXRm11TlkzdnJKUUwvUGtCRkNaclZ1UUZs?=
 =?utf-8?B?QkI4REtFNW83N0NHVFphOUYxMElkNTNlSE1wekYrRkZ5ZUtqZThjbFdvYmVH?=
 =?utf-8?B?dW4xajhhZ1FFQ1hKNEJEaDVoSFRhcVFSQnlQZ3FiTnI2azRsK3RFbFR3UXls?=
 =?utf-8?B?Y3g4NFQ1Q0I3YnpFbW94eldkdGdwdW1GSXFNWWg1cDRFeXpiYjVoU3pIU0lK?=
 =?utf-8?B?SUpMM1NKR3BWbE1nTS85dlN6Q0cxMXVlTGJ3d2xPYjZEYWZCZVBUakNqS00y?=
 =?utf-8?B?OW42UXA4NTR0NURyUVRnUmhkMmxYbXVXYnF3eThFMS91QVA1SXlKNWcwb1hZ?=
 =?utf-8?B?SmVOR290WDNzM2lxci8zM0NxSVp6bUFKZGZBejNKdzFaL0xuOFpRaE9FeWE5?=
 =?utf-8?B?NWxLMktzN2YyUGllUEF6cHVSdjA4ajM3STVBdVYrZTRKOU40OGN4bVpOY2Ur?=
 =?utf-8?B?L0RTa3NZZkhIbU5GK0FMaWFucEQ0V3pVcGVYOXNTSVNmSklxZ1NIamxDYWk2?=
 =?utf-8?B?NjV4QmtLYzlhbjBpOHFja1NYL243NFRXZjUxNk9ZZ2FiS2g2QmlFNWU4T09i?=
 =?utf-8?B?RjhFRmFJQ1R6WEtUOTc5RnhSMFRpWEZBNVFETWpyY2Q2ZE5NelViTVlRRm1C?=
 =?utf-8?B?ZE5VRktpenpXMHBXRW5qbkQrUkZhTGR2YkN4ekMycDJWaXJINE8zTUFuVFV5?=
 =?utf-8?B?TzMrRU1NSmtkREFycG9nOFluVDgzdGxFY3NFMDZCQzJCQWduZm42UjlsMXZC?=
 =?utf-8?B?OXNxMGtxbmhxL0xZTVZrR0tOd29BZFdEb0x1RmkyUUNIbkpkSDJucWp6dmIw?=
 =?utf-8?B?RjZrckxBUTdaSEE3OGxKdUJJOTQraW5qcDVMT3krTnAzcDJVbXdGZE9WeHUw?=
 =?utf-8?B?OXZ5QVlSckhDb1lCeWRYWkdRUGkyWThsZ1lQYVk3MDRtK3pZK1paWmgwMDVI?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Prix+o6E0z7JYFpyFXceZ14mnC34TKlG8qaZxRecGPe98j/ossLde/Qtjp9BHoQrCWuxj13Nmqu3AerFnfq9Z2fEHDJCV0FIB1T9EM8K+IW+cHfnGcr5kyZCn0DUUA1ozMU9sm2+4RORRp7kPJ5W19qN2RqjvYNSKD+UWS+KClVTQC3C23GzQXxmLrp9rn9On5ZIeY/FYcRMhq6Gag40IZliX6XxdqnpgMJLCpoeK69Ld9BikPoMUt4YTsk23TNgDawMejSQROqML6kJYzZc7f2kTxSXAkDU9RcdvGUl15MClvqAPEj9K7lA6ivE53t/g2qbLwWUcYsGAMn5TEu4Q9QkpddaJGbWrWU7wCX4kS103wCn5ULYvKYCy5kRntT3eqZY6OPzwHpLvgCz8/RmwKqAuHOoqCyYScnR9ajJB2En4WPn06wyVmO+oN8DsqrdBHxjFYPAJut77Lr+c0J9JPAjMYLfV4e1Kl0UK1ZyK8WP4HHWn1Vp9dJo8dCEtcUE8lVHgOp2hTFJfd410DRld14YUFZv2VUqpS9EPxbebC7cNUv8mlTpKR24S2GdFIrLDcE7SJdy3hsQvGZsIjN0vMdmFAulrWxk6rO4oPvhy0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a71c76-a1ff-4ad6-e795-08dcbd404461
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:38:10.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/bsiP8BXp72jMKMrr9WPB+r/RegGQ3GF6eJQTaSm8AswBs+9isWf7vgrq/xhfFtUAnwiLGV7hpJddxE7qd+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_08,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=950
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150113
X-Proofpoint-ORIG-GUID: LBWl-DK3cRPCrxqNElD8VVVDE8cMUFPB
X-Proofpoint-GUID: LBWl-DK3cRPCrxqNElD8VVVDE8cMUFPB

On 15/08/2024 16:26, Christoph Hellwig wrote:
>>>> +/*
>>>> + * Pass bio_write_zeroes_limit() return value in @limit, as the return
>>>> + * value may change after a REQ_OP_WRITE_ZEROES is issued.
>>>> + */
>>> I don't think that really helps all that much to explain the issue,
>>> which is about SCSI not having an ahead of time flag that reliably
>>> works for write same support, which makes it clear the limit to 0 on
>>> the first I/O completion.  Maybe you can actually spell this out?
>> Please just tell me what you would like to see, and I will copy verbatim.
> Probably just what I just wrote.  Unless Martin can come up with
> better language.


/*
  * SCSI does not have a reliable ahead of time flag that reliably
  * works for write same support; instead, the limit is set to zero for
  * the first failed I/O completion. As such, only read the limit prior
  * to submission, as it may later change.
  */

ok?

