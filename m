Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20C2BCE3
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267285; cv=fail; b=B4jT1k7D0oTWC0MBYaxQZlOrqGGjP4NbH+Ey3Qd7HCuPmZr23fQlAtMFjbJN8+3KObDYBCIRnTLwKv9EdzFEH6TChejhjL7IRA3HTHUdqc3D8aJQfBtO1eyVPlY3/UbV1fE03J4JKizel2+el8a1I0I4rvtfZWe3p4pB8b969xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267285; c=relaxed/simple;
	bh=aT8VIzMybnG2q6XyZPmzqt+5GiJH/AmX79ojl4S+IOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GhKnIHbP0j/hgP1ySNDHKFuPWtw5a9rkyanqJ41n9pb3V22V7hplVVeEr30b/1Ts0o0XFdzeI78H6uVky+OKuABQueg4lTgq0yuDaXPHC+g7DWR1LXqRRuTDe4xvznR+9mPZD8L2oEkelAFF+zr2EDq+arfVma/BsZFrRzCBcZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ez2HzNen; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J+7Yxx1R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ez2HzNen";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J+7Yxx1R"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449F0v4a016480;
	Thu, 9 May 2024 15:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dvL2Shjz4Z2dnSLq9ipC70V8BbEV9Q+Cl8ogHlecW3Q=;
 b=ez2HzNenX6hRQbg4s/Pz9xbDW8yFKJehBgKxegGzJZ41Shwthrd9BvZhgvo2DX/2IjJI
 E8dQ5iOi20LYekbs1Xpo9Y7rAOV7QG5QkK2Bw9RQg/GBOFl74M7sq+rJPUlax86oGIR1
 /0sJKvDjFK2TJWgNaWXLZqrMlQWfaJbpv+zUvqvoxCmlooFJQuSrduIXRCa1ujqeKkoz
 6z7B2LBSU1W3EfOKyW+gdH1Hky/MyYidnJk4w8SJHJ5YHPkNOkiZ/DfbHrBCM0uSyBS5
 pN80dT6xwZWBZp9Ij/GqnetnCL1CuI1/3YoZc8fXgAAcPKBYKACXniRl2UuE3jRJ2veY zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y10n8g0k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 15:07:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449EKKjg031066;
	Thu, 9 May 2024 15:05:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfkc5ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 15:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeqwKudIi+Ygk6up9VvoS1Ed7YzC0MLFqb2ZMOYdLbMpWdzy1/WGjHZhtkU4i2R1fJxlFZR1+mQAjBvwc/hzUuMJDR8hijOyYmf5VvLnC7MAO/Fd4Bc2GLI6hY4LGQtCpQDj3C1MOIc9L5byCUAnyl6r9mL3FXvwdNhxz4/asdNZwuzE5W8Uf6RCR9rbAABUc84G66XcWd6Qwser7kw8V0M+/wPb+jHfDa5MoKLJdy6jnRQU/utDUKXDc5gvYza6txfWBIarWYheGb644YyxhJKBLQdc2pl0DNYSly+LAOngeC2fbwxJv5jkUEnBs+JJkIv6TRSXq6sIpwDvozp2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvL2Shjz4Z2dnSLq9ipC70V8BbEV9Q+Cl8ogHlecW3Q=;
 b=SGTgu8Eqj+0e6EB2sNwyrbzRQNWAebfwhD8XL0aQfoh5mTDYD2VwnDuDoLzKQoJCLFn2qI6GFdvo13F34Smij4GwBp7vMxpVw5LCuWwJcA/5A7jxboHFmKQRQKlSP0z6XHt3pqz5bNCtmZaWCvSIerHK6PpdNyZItYvc4EtsgpdqywQq7I9+uw3U5yY7+UvMmJOPcnspSSMQkhOozYeKQ4NOHdOB4+csWgTQ+wTwBKcZbK90/QvBgp1xwJV9Zjf9iSDdruJq8+1xRkUSEvTt6hG2bP7Mzaq4tNrpXDwbdhYQtnU9yyGn9VRPv7FYplAnIFCXBDIZ+MNtvrVQVvIibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvL2Shjz4Z2dnSLq9ipC70V8BbEV9Q+Cl8ogHlecW3Q=;
 b=J+7Yxx1Rt+r8N34dqin4EUAE4b2puOtwaDBMrV53cO6Y/Jknb5Az4Ly2c1sKK4xDrd5r7nJ4Lkku/BbAjALjR8tfLx1M3VD2XJkdQDVB+xp2DM65mCT8DCkuXgih6Uikrx6J1hJuVuSCKvc+mVAccw9h9rxWBgczPiaYd7MM3s4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6361.namprd10.prod.outlook.com (2603:10b6:806:26f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 15:05:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 15:04:59 +0000
Message-ID: <65430500-14bc-4e71-ba40-024ef293bc4a@oracle.com>
Date: Thu, 9 May 2024 16:04:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
 <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
 <20240405171330.GA16914@lst.de>
 <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
 <20240509125856.GB12191@lst.de>
 <4bc6ab52-31b0-4e1c-96d1-2568a43af7b5@oracle.com>
 <e2181429-3f0b-4999-87b7-8fbc8aea3765@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e2181429-3f0b-4999-87b7-8fbc8aea3765@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e338e9-f6a1-4ad7-a0e5-08dc7039656f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TGtUcTdSTnRwOXBIYWNZUUpCRXlMZVNxZU5XcVh2ekJCbHZGN1dJNVl2aUZH?=
 =?utf-8?B?alZKVm5HK05LUWVxb3FVa3FvUWhxNUpENXQ0VzBkdFZFRThlTERuZzZIOVRj?=
 =?utf-8?B?Y1RrandiWGRub0JLYkZ2WWtpMlloT1lWNFZNaG9NeTRvQW0wWWhRLzNVTUpU?=
 =?utf-8?B?ME5mOFp2bW1ZbmZZanNVL0NpTzBxdGZTeTBlOG1sdU44bGlhVkwzbEpMUGhE?=
 =?utf-8?B?UnErQVZDKy9pNU5pWUVPRVRNUDBzeWZiVFByMzdHOEVPQ0N2Mm5lNit1Q2VV?=
 =?utf-8?B?dnRtUytWWUNwaTNPanh1K3pQOTNvYW11Ulgvb0dzR0pLVThPVFZvWFdRUWhY?=
 =?utf-8?B?RDBiSjBTZFBIR1lCMU1FU3pjMWdaWVdOMTVYL1pPMnJ4aUNVRkVxTmZnbWNS?=
 =?utf-8?B?RERWa2hQTnNqRzQvQkwrNnEzNWllbWNXNGJ4b0FvT0ZKOFhSYlNZL3VENVd3?=
 =?utf-8?B?RWtZWVFkMXg3ajNFSEJMUGpKOUJDd0FvbEYxajN1UWxDRWdJUnhSc2dMUm82?=
 =?utf-8?B?QXY1NXFpYVZxbWwxMnArSEdPOXVGdERxeGM3M2twWC9UVHFhSkFwWVdpa3lM?=
 =?utf-8?B?bUJBWnFsdHNpZ3RKMVNsQm45TEZJR2lKeDRrb0hjUmZjYjhxRVV5VXd6MkVi?=
 =?utf-8?B?Z1VyTW9qd2tyR1NCdzNSdC9VMEEzU2M1eVh6NFBjWnR6YngrbzcrdExpRjBs?=
 =?utf-8?B?dlgvZWpVdUYzdnVOM3h3S1lMSEFZbWN3ZGlJTW5vU1hkRUJQWHFrQ2pXNkFM?=
 =?utf-8?B?YW1SQzR6WDNYa0YvaUVqNXUxdVFiS1IzOUc1Rng4K1lFNCtJQXdDN1FKcmpM?=
 =?utf-8?B?TnlxS0UrR25SSzBPR0J3TzBGcnUzdU1TSWJvQ3lWaG1qQ2V6VkExdEY0NHFB?=
 =?utf-8?B?ZC9jZGtiSjdvUDczd2dneUJJZUsrc1dqaEJBNnBaMkx6WDVJS1JNRHdVMEpt?=
 =?utf-8?B?L1FTTU1XUDlyZDFoMUk0R1FMVVlxNnkvbXVwbkp4YVJYTUFRYSsrUEZSQ1l3?=
 =?utf-8?B?dERCa3Q2ZVRCQUZjU3FDV00wVVNYcHFpeTBHb0F0YmM2RnlMcHkxWWxHRFo4?=
 =?utf-8?B?Z1FHMmpYc3VhcXhxYlRFNkkrNnZVdGhEMFlGVVg3RHVnaXZRL1JJN1lsSzk5?=
 =?utf-8?B?QXF2cUJFV2hoYUxlNDFDbVJpV3UyYUdvMVZsdEc5SnB3TGJQbmVTL2hqTk5K?=
 =?utf-8?B?WTVjL1JaYmx4VHB5RDY2cXJSTkZ1MXpYcGVaY0l2RjlDYkVtRUwzaXh4TFRs?=
 =?utf-8?B?Z01yR1ZjZm9MRVpFOUthTzBXUDJUbE9sdnJseHo2ejZUc1JUTlg1RDFjaE9S?=
 =?utf-8?B?OG5UeVZnL3A5VitSN3JFT2szOTR3OWJPd3FxWVFoblVkZUtGSlEvcXMvSDVJ?=
 =?utf-8?B?dy9oeko5cnFySzNtRGI2OW9Hd3dJM3NQUXpSd2VUZ2wvSGhOYW1rbUZCeUhN?=
 =?utf-8?B?alVDRGVjZDVSanZ0YlJYZFl2ZHJKbThrOEE1aFVsMG1xbk1hOTc4YTFMWG56?=
 =?utf-8?B?T0ZRN3ZveWEvckJrT2JLQmdkVlFLU0llZ2c0c0NabGRXZnBoUTNESGpCSGdM?=
 =?utf-8?B?bEZYQXN5bzdUQ05NZ29hNkVHN0hOK0VEbkxPWmw1QmNRNWtiRVRsUmw3dDdV?=
 =?utf-8?B?WnhBWTNSNVBiSytCcW4xOVZXWmJtUW1XeE9WRDk3QVVSUWViZC9UUHF4Rkg3?=
 =?utf-8?B?ZWdJMGZzRnFmWDdsSjV3YVN2bkhzb3NuZ1JTY3pleXdkc2lwYk5NS2lBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wm1hN0pkUU9telhJaWtWRXVtMGZvVW5OMlo1eVd5aGcxM0luOEVyUEQwa052?=
 =?utf-8?B?ZVI5TUMvTlJnc0pnaE9WNVRDYlBIVTR0MXZ6cEVDS1Q1SGZGZEVKc3ZrSUNu?=
 =?utf-8?B?TEJyL3lTM1gyQVVnT2pqaUdTaEc5RWtycUlBWGhhU0lmN0RZaG11bEFJbDBm?=
 =?utf-8?B?TE9wUHp3QWYvNmdON2srdXRGSlpMR2pkUHk3c3BlWmsrSlp5ZEFpUVRjV1RM?=
 =?utf-8?B?OGs5cnM1OWpOaHg1NW9jckt4S1gxUjlRTE1kOFRabkFuSmM4L28yS0o1Vkpp?=
 =?utf-8?B?OGNNWWdocjFqcy9FSFN3MVIwZzdnemNOSWJVRU9Ld1FLaHhkdlhCS0xBOUg4?=
 =?utf-8?B?Z2JibjV3ei9Eb3gvdDJ1UUFtS2JYSnhSSDFlR0tTMEVkSkFwd1JTSW95UjVv?=
 =?utf-8?B?K3NmMVFZKzlSMXFoOVkzMVdLRjcwTHFqYTgydHRNM3ZXQ1dzYmVRblpPWFlT?=
 =?utf-8?B?bzRwTmNNdkZEVS9NdUphQVNkbnpHdGpBMjdFV2Z3cUxoZ2ZoNVNJTzZ1eng5?=
 =?utf-8?B?dnRsSHlRTWhOL1pwV1lxYmp5S2pyQzJpSFFyUWNBclQwUkxnTkNMejFGdmR4?=
 =?utf-8?B?Q0g1M29Rd0l1aU9VS3hPR09seWFiQ3lKQjdTaklyZ2JkMVplRVBaOG9pR0hE?=
 =?utf-8?B?NDM5RlkwR1d1Q2RJQkxWYWEzbUNrNmhiY3FRRVFjckU0Q1U5RlFsbTBybHRK?=
 =?utf-8?B?ZUw5eCt3T0d4cUpYQTBxMXhBUFhUOXJHS1hrWEFVTmFKelpQV0NIR01rb3hm?=
 =?utf-8?B?SkxpN2VuajhiQkNIV3RvM21tTTgvTXlzdXphTm9QTFVyYWNuaytVaDZFMXRZ?=
 =?utf-8?B?MkxGb3ljT2pDaysxd2ZPRldHOHBCQUJxMnR5SUh3QnRqSkJHb2Q2eFY3S01G?=
 =?utf-8?B?cDVNRWhYa0ZnYmpsWW93b2cyd2hTZDYrK2VIU290NFNHVjhTMEdkdFRZd1BX?=
 =?utf-8?B?UGh5YWE4S2x0OGt5ZlpzVjE0VHYvZnJML3VuS1JqVzZDNEEwcWRaeGFSY054?=
 =?utf-8?B?QitVZnQrcGh5RE1vMlZ1SEV2SkF2V3FHMGxSZW1KczNWdURqUFFhUXdPNkdO?=
 =?utf-8?B?cDlndEFHOGZrTWY3VVFqUE9CZjh3ckYybnJ5b0dLSjI2dmhOSmNIVE9MV0dw?=
 =?utf-8?B?WFhKMWtkVS9XNnFGRGtmQmpwU3BCZjZ6Q245U1d0NVJ1Y3NnMGRka080dm44?=
 =?utf-8?B?empGUnVtdVh5aHVSTXp4Um1SbEZFc1NWV1E1OCtNdG5hWktQVXNtUzdOUyts?=
 =?utf-8?B?aGpFSDVwaXNUSFdpQzNucm1JRVlXTDlXbzUyNkdXVlp4WDFWb25lVlRWZDE2?=
 =?utf-8?B?TXNQYnBKZ25YSXR4SzhScTNYeHF1WVR6d0w0dGJ1UWNHN0lkZ044bkt0ck1p?=
 =?utf-8?B?RXdIN2hvSG82QXNXUW03MjF6TlhNczRwNUM1K3BNcWRCZzdYcERIRDFFSmpw?=
 =?utf-8?B?VG8wZW5MRVJoVEc4Y3NMbm1Kc2YwZkxIaFJzQkM5TDZHRUlhMnhSMDN4MHhE?=
 =?utf-8?B?UUxybGZMRU1obGJSUXhDREh4Q216ZFNzN1czUFFUcEtMeGpocjJJVHV5bGV4?=
 =?utf-8?B?bDV2YTUvSHZZcVhXc1dFZ2ZUY1dtMUI4MHlTS3p5L1B2SDRoYndyVGl6TWxW?=
 =?utf-8?B?a3VLN2lxb2VrQ2dMU3BTNmlWaEk2b0g3bG53bmRNaEpoSFJiNWZMQzl0bkFK?=
 =?utf-8?B?WW0vMWtWZTkyL0RybmgzU2hycjBLNHRIWlBzZHh4cmtDUXo0M3VzV3k0K29T?=
 =?utf-8?B?cFk5MWpJZjlRTlJMYzZxanFYcmYrOWMvd01JWTlpRFdiVGg4Mk0rK292OXU3?=
 =?utf-8?B?eU5mQjhtanowRVFkelVqQXRhZUhDZ3lTUlQwZ0kxbWcyemNselBrdXJqcFFY?=
 =?utf-8?B?ZkgydXF3VWVFVTB1eUtWYmhBazMvS2hiZEhWMWZ0QzVMV0ZTbnJ3Z2JTeEx2?=
 =?utf-8?B?MWdGeVpOcVdic1hVS2tmd1pMWGVtOEtHSjVQVVNUdHhFY1FuSmtLazlQTmZD?=
 =?utf-8?B?TXRwVnBsU000enBMZHpjR3JQYlF2RUdlR2VjY0RRUmVqMlRJdVhLK2xkQWx5?=
 =?utf-8?B?NXhmaURINTJWYWxkRG13aXVvVE1VKzdqVlQ1UXVPdTdPR1hsVDRLbUFSWmp5?=
 =?utf-8?B?Ni9IYTZGdnFkd3JVUDlWTlQrdzVBb0ltbkQ3TE1CeWhZU3VkZnY5OXFCTXhk?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5k2gljV5dfyUYtLdPbEsRYvQiFnUMQh2J89nMBJIUpOGLvr6LsY2XdAbvw0RMqMS1etd6hGrf3StJcqmBvpbIIHwVkLtWoXEsstsc9tDJxT4Rc9NWEv90tX0yf1RNvbdech5x2zDMpfh9cQu09VyjzRCLxDXHNLdSUIXaZq8mpCYgqvineu2sjV0IMVL+jYwu5tI7m54g0TWf3JVy42AlYmHomngu9IKZ0E87L1QUibS5bD+74XZAeSop85ACcbpb06KBHBFIk1BKFuiN3QKFFRpcRPR6G/bZNrzvvroYMiijWB9Qw9KI5RDAQgN7uCJkcryslpjwLorZDKPhJLHZeJDUTwrRZ3ZfO2s90QaRebTfmjy8Oy1Hbtr3CbGA3acukQdfaH2/8cVzWoh6TuH+UgIpGa33gVMgojyWBtsjcdXBg+sfNWGHTw9r0vz3uLPuIeih8hbDoCddyLQBHHNv5D2nLgSe4xAuwE+3T1XPFNIUp52QFLbbGJ12smFi8DkCxE27Qm36dXrl8V+iNNuvYj/TmrJMhImOrAnNxV9p+TWwcimZqZKT5wOKm+x2PZjwvhAgxz4r6ozW8NXC5EuYSoFVE7ersuDM+34aRe63/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e338e9-f6a1-4ad7-a0e5-08dc7039656f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 15:04:59.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e78ZzBLBfRdc/tUnG5Vb6+PEFSkbECgNtIDtOnXo8LUXZFdAD7r+wktX2M7XGuWLRLnZgFFr8fhFrfspkcNnNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=951
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405090101
X-Proofpoint-ORIG-GUID: vJiO6Klkie7S4rDT6xAwTjiDKh5oWRlr
X-Proofpoint-GUID: vJiO6Klkie7S4rDT6xAwTjiDKh5oWRlr

On 09/05/2024 15:00, Jens Axboe wrote:
>> But, uggh, now I see more C=1 warnings on Jens' 6.9 branch. It's quite
>> late to be sending fixes for those (for 6.9)...
>>
>> I'll send then anyway.
> Send it for 6.10.

ok, fine.

JFYI, Here's what I found on the 6.10 queue in block/:

block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared.
Should it be static?
block/blk-settings.c:263:9: warning: context imbalance in
'queue_limits_commit_update' - wrong count at exit
block/blk-cgroup.c:811:5: warning: context imbalance in
'blkg_conf_prep' - wrong count at exit
block/blk-cgroup.c:941:9: warning: context imbalance in
'blkg_conf_exit' - different lock contexts for basic block
block/blk-iocost.c:732:9: warning: context imbalance in 'iocg_lock' -
wrong count at exit
block/blk-iocost.c:743:28: warning: context imbalance in 'iocg_unlock'
- unexpected unlock
block/blk-zoned.c:576:30: warning: context imbalance in
'disk_get_and_lock_zone_wplug' - wrong count at exit
block/blk-zoned.c: note: in included file (through include/linux/blkdev.h):
./include/linux/bio.h:592:9: warning: context imbalance in
'blk_zone_wplug_handle_write' - unexpected unlock
block/blk-zoned.c:1721:31: warning: context imbalance in
'blk_revalidate_seq_zone' - unexpected unlock
block/bfq-iosched.c:5498:9: warning: context imbalance in
'bfq_exit_icq' - different lock contexts for basic block

Actually most pre-date v6.9 anyway, apart from the zoned stuff. And the 
bdev.c static warning is an outstanding patch, which I replied to.

At a glance, some of those pre-v6.9 issues looks non-trivial to fix, 
which may be the reason that they have not been fixed...

John





