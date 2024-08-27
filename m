Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C15C133;
	Tue, 27 Aug 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743200; cv=fail; b=pnqm4c6xe9QKj/LZJsEmjgI8o36vygAwa9AlmChWRuvVrtZTAkQc562PXZGWpsggFBCFvdbpiki4RPQbuwKPkAU/snQarXr3qhFcJRNP04H51WYQpO0NjH9zxNeIshWfJB6Ro6ZQzAMR0+t8QxkFhdg/w9kg6rU/4MueaaN0h4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743200; c=relaxed/simple;
	bh=dZoL3TDAHk5Av8h7ZbH4PHMjQOkq+9uCYXSGwfgBns4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FUy/tkl0YO44LbGM8NElxfi9ruZ4YLllxZ7t/qO9+ZqeuqxCqbC8moR6aQdYppblKgjQY5hIqjRD5OltMZR6r9/uO4PnFtQaYTq0VwefXC0ez5s6eJrToEhJbFyOVhed09iclNIe21nl1qwp6kaXIRDjpK0D+rUrpczu3UgCKhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RtOaWzOZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YPl4/1bI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RtOaWzOZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YPl4/1bI"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R5tUGr021009;
	Tue, 27 Aug 2024 07:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=X1PRqNYi1gTzNgYm/n07D0gIZY9xRP1a5QxPe2Hngeg=; b=
	RtOaWzOZI5/6Hm/QD6loZwEfBJ/mGGLRGWF7Ksvu4L9eUlgOWngaF28JW9mLYMYx
	JrXMnnZMSBAqsOhF/qsjF94vhJ7DsNJGBa0+6p7U3doa6gPQZcUrbsHZWveD+1Gx
	zBLCUyJiCUzpVyNyEHN6C+HSvJ8irB0czuDxGQFrOt22Vn64SEN8yiWOSK15FBxS
	Z6U/RWXbwY4STEc1z2rEITDxsQXgNOMStd3LhK/shx9XGc6rrZonNvZ/1y2sGrvQ
	n2SvWnH81lEEBNBfA4JBekPfKfYkSYcim7Ni8stZs91Z53f8eXI3aILb482kozWC
	aKzfEou8HsWcoMaBAOs+6A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n44u74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 07:19:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47R7HXuV032456;
	Tue, 27 Aug 2024 07:19:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0thkra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 07:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jffPeggbFan4FthretG9X2NLxrNXoEpyjAqeKNBjjpwqKxooUyamo9T1SOqW4iunx3TKOCdrq56e26aAHzTTabd+xUKFcV/cKQ8E9XnMXFCAchSB/JJ4RHTmOsIIT70OvtAKx0yt8XiLv3fh8zy/sWhLfWlqQOGIxy53jI4iIByPtKb56i38GP/5ELYRvzIKplImFo4uDCWJhBRe5SfjfXiLtzYrELgyM0cEHE1gpKaDDIwoXcFie1tM+QDJgFhrOmoqb4VXRh5vQ+5uHAw07ZSzOMJjXKgcgGxvd4W5OMO3VZ41BW0uS2u1IgBBzadqwzUnsmwlhh08nEawDgwhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1PRqNYi1gTzNgYm/n07D0gIZY9xRP1a5QxPe2Hngeg=;
 b=s0mYN6ebwgWdk0a6QU6xtEkzOypC9znvZvKTUyNd0kt3Rq4OVVicoxiceZjLvl2hDu+f4FssgQDYq9RDefAjw95vTpzvvbaw0B236Si/ARxM/8nXyWlBqWtASM5JiIlEH58ngMmBIRhAYevaQSzEen2dxGf8Ky+Q54/8/vRgrxodia0sn/T+LbM4majwqRh1bAaSKwKnoLexj/qZjdLNOOyyEOCm1pWnN4KoHKaH6GXWQaj6yff7cV89wwRiYnaZlgqcGtk6jpPIuv/WV3qaUnyqZIEiuzhLZtz/SgsVI84UL7Er+krt27Em25/5CX9hjiFUa3bwJV+PJManR3TuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1PRqNYi1gTzNgYm/n07D0gIZY9xRP1a5QxPe2Hngeg=;
 b=YPl4/1bI3Yzr1LLBrVhij2ME3EN9+Li03eKKulJjm2CNSXKfj8o0mk56BWZy2jEATPEmmnv7m331iZcdNet4MQi15YuO7epgg0tal7GlHelbRhSm92e+VwrlWELyrhfeQcebt37R9llDTE8zz6TQv+TLDnYKIznWwAguoOzeqaA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Tue, 27 Aug
 2024 07:19:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Tue, 27 Aug 2024
 07:19:39 +0000
Message-ID: <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
Date: Tue, 27 Aug 2024 08:19:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: Li Wang <liwang@redhat.com>, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it
Cc: Jan Stancek <jstancek@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <20240827032218.34744-1-liwang@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240827032218.34744-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: e190875f-0583-44a1-4f3f-08dcc6689cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmVjU2QxR2drUGVXanRqZkZRRVUvNTNIcitvYkpVdWFWVU16Tnc5U1VyemFJ?=
 =?utf-8?B?K25vUjhlY25HOEllV1dNTFZEQ2N3TjF6QWppSGMxOEpkbkZUQ0t1Nk1jSlVj?=
 =?utf-8?B?aWl5NXBxblhST3NYZlB2SjdWbVhkL1VISGk2S1NyWDhnQ0huNjBOa0FIUHFN?=
 =?utf-8?B?dkltbkUwU2NKVlNCM3Bid2hBNHN5YWFMeFpGeThZVTFpTUJPbkdxZFVLQnRv?=
 =?utf-8?B?Qy9NZmsyQWxSM2xXNml6aGEzL0ZxMlkwS0pSUEJXQ0RsYVZ5YjBhWi9ucmFI?=
 =?utf-8?B?R29LTEJUK2oycVJ5Q1JBaUpyMHJXVjVhYWRmaVkzRjZhaGw5Sjc2U1V6YVpr?=
 =?utf-8?B?RlFLOGUzb2Z3a2hNb2k3UXV4enFCTVpTeUZEQmxsNUxyNlJGQmVSNVUrUmVL?=
 =?utf-8?B?TVBMZ1ZmdklhSC9sYjVMamx2ZzB1VUVUekNIeWx1WlpnWm1HRWt5MkV6VGEy?=
 =?utf-8?B?ejRtaVIxTFRHZFE3N3FtK1h4L0RqRkt1ZStrclF0cFQyOUNWbnBwQnlIY3Zu?=
 =?utf-8?B?MC9NV2xQU0xMNFA2WVN6Z3BQS0Jsb0loTUhhekpBbEc2QXpSTXJkZzBrUGRv?=
 =?utf-8?B?UU1nVXBBdTN2YzFyWlVWK3NDT05LbkJVSWdMWTJqeTRJVjV0bDdRYWxLUDVJ?=
 =?utf-8?B?T2EwZ3M2NjJvQzdUYVpSaXlVVnZlcGxBbFAzRHdPN1JCTTR6Y3dJZEJIVlY2?=
 =?utf-8?B?Z3pFTitFQnY4ZVJLbFFvWDFVM3NNd0FCQ1RZVy9lU1Y0UVVnU3lKQkFjMGR1?=
 =?utf-8?B?L3hqUlEycS85UTV3RzZSNXQyclc4cEhtSlk5WG84T2NNZ0xINWlwbENjOHBr?=
 =?utf-8?B?dHdKa0RjRDBlYk9RSkhLQ1kyZngrVHlQZldyWDZGcmRVL0puRkVxNmhFbzUv?=
 =?utf-8?B?V1h0aHBORDhlOWFoNUxOeDU4QkJkQVJFclpvbGRRVUY5QUdrOTBzUVZxNUZM?=
 =?utf-8?B?dWt2d0F6KzJsQUZzWlI0U2JEdk5qd1cxU1FIc3NMNy8yRjZVa3BvL05VRFo2?=
 =?utf-8?B?eUNqYmJwSnpBcElqQnZXOWF5WmpOWVRtU2hWbGdIVUdsM0pHTmlqZTRBR0FN?=
 =?utf-8?B?SUxtZDdQaTRMb2dncElyU0VJcUwrZ2hzSzFIM05mcVNtc21waUhPME8vN0dk?=
 =?utf-8?B?Q2tiQkFxZEs5UUdQaUt5b0JlQ3Z5bndMcXRHUVozUWZmOEZFVlhJSVA1NVBN?=
 =?utf-8?B?NCtRQW82VDh3UXhoWDRadWJNTkRMRjR5L1AxMzI1UUEzc2FyVytSaGthUGVU?=
 =?utf-8?B?TGxLY3A0NlNsTDJaTnZZTVdWdTNTUDRJLzlsLytUVkxZaWw0cDB1RnNoZ2d6?=
 =?utf-8?B?WTRyZXN3R2dhM0JXWE5oMGJXYnhxZEtKTXphQk50OE9XWWxzeXIvV1Q5WkE1?=
 =?utf-8?B?bWNpUXBkVVFlZ0lSUFVkcnk3RFhkbUNjWTdubUpYMTRyR2QwK1BBc3poUnNw?=
 =?utf-8?B?dEJlNE55ZGFhdjhib0Rid2s0TUNxTVRFRDZIUWpqc21KTmVVMC9qcEhURmtJ?=
 =?utf-8?B?L2hlSDFJcHE4aXRGQXd6cHpQSDc3aTc2MmpjYmhwaFMyTlhBUUM0aUd6bFNV?=
 =?utf-8?B?TEwwL1ZCcThwOExseDgySmsrYXdGNWpoL2lZRVZWbjNjL3Zhc2dsYTFBS2ZJ?=
 =?utf-8?B?NEJxbnZKdmlJb2llSUR6ZFphWCtXbUR2STFRS1Q1OXBXK0dObFVkODdhbzNl?=
 =?utf-8?B?SkJ0a0VQWkQ1V2Y1UTQ5RHMyOEZ1WEFnOThXQk9yTU5xNmcyMDh4ZXdNWWFp?=
 =?utf-8?Q?qgpYjV5J6eqq7YRC+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm15YTMwVWlKdHFPYmd2ZnZ2bFFCRTRHNGlqNE52eGRTNWtpZ296cU1pTlYy?=
 =?utf-8?B?ODhHenE3R044bXl5TG9talBZMGpGMWpXcGVublJ2eU43cmNoUW1LQTZLT0xy?=
 =?utf-8?B?OUp3UmpaM3VaVmlLQjNTb1ZoQ3l5RS8yRnE4Vkw1Lys5WFVrZGszem9hbUs3?=
 =?utf-8?B?RlRjK21JZmlTaE5xRFRJdFV2YytrOWxNSkh6a21SRXEwckozUTZHNUp0bEh6?=
 =?utf-8?B?YXpnaCt4YkJZaExCVndSaksyQ29zUVJ4R00vZkwyRWcrbDlTbVk3REJBd1NM?=
 =?utf-8?B?WEM0RVFJU2V1S2NSMVl3R25VanBUQlB4VzV6QWpiNDlrYWNGc0JCSEwxT0pL?=
 =?utf-8?B?T0tDbS9sWHVjVVc2eStNd3VZTUZJSm9JUDVjQ3NNd1VGWVR2SWNJSVJNWmRL?=
 =?utf-8?B?dVNVK1dCT1dvQiszajIvR3Q3dHlTbDRUOFkvNk9SUWw5WmJkaUl5UmIyNDdo?=
 =?utf-8?B?TEVlMDZreUQ5Tko1R00xUjVOcDNreElQRFdzS3JDU0k4aDBzemVkVmt0SzFG?=
 =?utf-8?B?L1RqZ2NvNlE1S0dKUVhpTFF6eStFOGZyaEY2ZmNwTlZ2QWU0VTBsdkpNSVN1?=
 =?utf-8?B?UDZjM3krc0ZKc1FQQXlEL2hsbVJrVWlMYkhlZ2prK0NRNnRLSFBualpkWklV?=
 =?utf-8?B?bkM5ZVhSUk5lQlRBbi9lZnhhTUJIK0dDSWFPbyt2RHFBM2lWNXZRWFhwMWRI?=
 =?utf-8?B?WGVaeVcyd3AvV2U0V3RDdjRJczJmcVppNUVMdko4Y3BhWUV3NG9CZVh3YmE0?=
 =?utf-8?B?SS81VFFDNEJNTEJjZng1dVBmdUF4WjBjN0gzMkphY1JsOEFSWG9hMzBpb2Ex?=
 =?utf-8?B?MERFRnJRMjJoL0ZsRUhHQzE3S2VodCs5cUlMYTZKZ2Y3My8rdkZrc2ROaXFj?=
 =?utf-8?B?QTRzR216eWhpRk5vNTk5V2tvaTc2NlAvSERKaGJ4cTdkZVBxNDBYQmpkcjNR?=
 =?utf-8?B?NC80eGwvanA3MXAxd2ZnMllFNXgwb3Y1VUorTS96LzY2NHNVMEJQUkJFNFps?=
 =?utf-8?B?RU4xU2NCa3JQTmw2VVJ6RjZBS1ZIN3k3NiswYUR6M1pleGpBbStvMXU0WVE4?=
 =?utf-8?B?TGRFSUQrbC8xNlR0K2NvZWI5MEJPN3Nyem9oZU1zUnlzTkFBZGtnZFZYcmdx?=
 =?utf-8?B?bjdoRjJhRXZIM2tLK0psTXVEWGRlZkJNM2tzLzZXN2hxaUZTY1lJcGZKWFRt?=
 =?utf-8?B?eCtZZTF0emh0cDFmeGFxeFhiSUw3R1FwcDR4UmpXalY4d09NblZYTE5rRElv?=
 =?utf-8?B?ZUQrelpBZi9yME5sc01ySCtZNnBPWUsrMU03WnlBMVFCUS9ETUNUQ3pkbTdr?=
 =?utf-8?B?QjE5SWQ0MlFnc1p4OFB0VCtPS2ZnbEpUQWxtV1Z0cDJGMFlSMmFUemkzWE03?=
 =?utf-8?B?RE5rTTh6ZUJ0a080d2FFVzhTSVBkaGsxU1Y2ekYybGtmL2xQYXpTb1Q3M1k0?=
 =?utf-8?B?T3dSajVxMjlGRFhaa0g0VHU1elUyM2RKRS9USmc3UWlPWVBzT0VNOHl0enRB?=
 =?utf-8?B?ZzRqVlZnL1BHUU0xdkxpQTJQVHcva2p3NEZwWkpGdkJCazB3L0pRTHg1VGRw?=
 =?utf-8?B?dE5kM0dIN2lMYVBxaTI5T214ZS9GbnZUZ1hObnNwdS9oYWdHMTMxMWIvUGNE?=
 =?utf-8?B?cU9QQVljSnRndFJyR2VWbUdxUnBTczlnbkV2bDN6Vm9hREdsYXRacll4MGpS?=
 =?utf-8?B?WU4rNzhINXIyT2NRL2l2UnB0M09iNFBDaVlCbnN3bFBZYjROWTFiZWU0aWZa?=
 =?utf-8?B?SlpNRkRwQU9pQXV1VFdxV253eC94MS92R3B3U3JGZGZMQTlDSUNKOGJDTVdM?=
 =?utf-8?B?QlZyZEl1bDRSMVppbHJWYTlwcDY1aGExc3U0MHRZWFBkUVIrcnh6Zk5vbXV6?=
 =?utf-8?B?b2IwRmpSV1dwZlA4NWl0SEZpV1NRTkxKNStDUnJVSHFhRUVOR2QzV24wbnpa?=
 =?utf-8?B?TkdKSVN4RTNvbmZER2FFSHFRVzcvckxYa3RJd3J4TVBOVmk1bENWMW83WVBa?=
 =?utf-8?B?aUlNZ05sTTI1UGs2Y2lxWFYvdkN4RWIxUyt2Mit2ODc1aTRyQU5pVk4rQ2ZF?=
 =?utf-8?B?c1N5UWwvZ3J1RHdjeTAzOFVBcEpFeVJlQXIyNURmTDZjMkVwbVJDalEwUmcw?=
 =?utf-8?Q?L9Q1xevQFUdLKvtJIcDP71fOu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lO+48h2P+lLSPzf8Mgq3ssTnFh1QJn7roVySZMOlANfszTLRfpMBI46Lq4Z9mIzsz6zSQV62NgJ4WAmhdzEsj8xjuCiVqFC57lUfsGsgUSjZxdxx/Dgg0vvyXRSt+QP7BdfrEJi+cdD2k/KChF6N0776NXZ7Uy/r0NgTXqN6/BjAgCEyNOFw7ur19it89zVsSHCZwm4uKDxk2FKEoDn1bsOZrrS86muL7A62N2M+WeJ5jQcF+YlJV9cn4qwM77BQ//Oki9EuDV7N4cf2GEz/qmSaLymVESb7A4BOgK2QeQTzifoVOGmbS+zV/XBg60d5h0mAkUmGUGpUiwuFsBDvJAekjyiAGVJQMRy1D6s5nATVv4S7fMZ2c7naUsmMKMvAqC0g4YeVRBgnPlrorIpVdjKAk0RtIgq55trVxaY3D3H1Ad6+JFpOp/7ferKRvREUJNjfwqh9mpv3DpXV0QT4myzeAPo8hWOr26JGhyt89zimLe5ojtBu1cjGW15NXTxMogyxNj/wYjXpAxnZI4Z00ChCNw55stMqPpku0kjqZWg1xbv9iBTb0ZqThN/F0G3fMRRL0uUSEvYO2tgglLsuMdLZ89u/XLONO7bP8rLZ7Ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e190875f-0583-44a1-4f3f-08dcc6689cb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:19:38.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIV5eL3w/Pni40wh6hcmhiFxyr3GVs93NceYQIiA0pij9KOgxNiTKrBtOey/6IAhJZ3yuLgTMGjthFD7lj7zog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270054
X-Proofpoint-GUID: HEbHITFLPAZabSjeh9Nxy-zQE0Yyeazk
X-Proofpoint-ORIG-GUID: HEbHITFLPAZabSjeh9Nxy-zQE0Yyeazk

On 27/08/2024 04:22, Li Wang wrote:

+linux-block, Jens

> This change allows the loopback driver to handle larger block sizes

larger than what? PAGE_SIZE?

> and increases the consistency of data types used within the driver.
> Especially to mactch the struct queue_limits.logical_block_size type.
> 
> Also, this is to get rid of the LTP/ioctl_loop06 test failure:
> 
>    12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
>    13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
>    ...
>    18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
>    19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
> 
> Link: https://urldefense.com/v3/__https://lists.linux.it/pipermail/ltp/2024-August/039912.html__;!!ACWV5N9M2RV99hQ!Kxyf0QaP903VtqbEb5n4dgWFhDjWex6vfZhJ9i2ewSqvAWf_iqFNNoOLlJm2BR_ofSSwGwowUQbky65jbg$
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Jan Stancek <jstancek@redhat.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   drivers/block/loop.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 78a7bb28defe..86cc3b19faae 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -173,7 +173,7 @@ static loff_t get_loop_size(struct loop_device *lo, struct file *file)
>   static bool lo_bdev_can_use_dio(struct loop_device *lo,
>   		struct block_device *backing_bdev)
>   {
> -	unsigned short sb_bsize = bdev_logical_block_size(backing_bdev);
> +	unsigned int sb_bsize = bdev_logical_block_size(backing_bdev);
>   
>   	if (queue_logical_block_size(lo->lo_queue) < sb_bsize)
>   		return false;
> @@ -977,7 +977,7 @@ loop_set_status_from_info(struct loop_device *lo,
>   	return 0;
>   }
>   
> -static unsigned short loop_default_blocksize(struct loop_device *lo,
> +static unsigned int loop_default_blocksize(struct loop_device *lo,
>   		struct block_device *backing_bdev)
>   {
>   	/* In case of direct I/O, match underlying block size */
> @@ -986,7 +986,7 @@ static unsigned short loop_default_blocksize(struct loop_device *lo,
>   	return SECTOR_SIZE;
>   }
>   
> -static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize)
> +static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
>   {
>   	struct file *file = lo->lo_backing_file;
>   	struct inode *inode = file->f_mapping->host;

