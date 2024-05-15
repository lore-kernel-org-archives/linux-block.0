Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9C19B
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715732501; cv=fail; b=tI6yQdHODKWO3Eexu7yAWDx4Ynq9ALTv65UBtNhXgXg6Im+tK6AX3L5GQAJU/yCMf8d5yK1sXNMmGhaKOPWfoNLMbwv3QivuPwSghI0Ur2iEP9OxARcOMZdHFfLcYRx9hnxBzuGa5DlSn/cMH7qld9+dclU+mWvuh4qyulvl5Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715732501; c=relaxed/simple;
	bh=3R3y4/oqsATNoA0Q8mnqmoF2NT0SDDcmvCckQbnPX9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eG8npVS9+I3UhBM+MYsCRHnUA/jc46It5YPk/zOocTa0jo1HDPPGXEtZiILuZXjzy/hyc1MTBDfuJYTEaGw4TvBeIxaFA7uf5I4KLzg2DbM72XBZa64denT6rdOpuFqrOgDiqP/NZ/Pg+f1etM5fY3e10EJAh5ncCdnU8oNMcPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VwhVZwf8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U0HKZ2Hg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VwhVZwf8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U0HKZ2Hg"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKXvQ4011154;
	Wed, 15 May 2024 00:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Jv6ogX6opYQwNKEQM9S/ybOp7o7nY8x9fXWX+w2dykc=;
 b=VwhVZwf8sW+lKOXmXW2u+yI/2MtsKpStukJ1+GVBxCCaJDKdnJIoaEi9H/DHEgl1BPlj
 SCzNFTd6Gkmp1Mn0S1+Qw/o5oDX+7p/JmaHIBck+/PVHS4xN+/h1Le2L5900/KAUF1eA
 G1akCFEg3NrgmaowM1WWDEXTxMyL26bQ2LUSYzEiwJ84rQUbU1jXIrJdTzbPm6f+diIP
 kSxzUGzw0Tf1jYNtG8jHo6P+AqqLSxpm4g4zAgx8LNap+L6GDUBHq2bNW94asn6pZpIu
 9DsNf0BSu7WKK1vT+4sVh/gFbYxJYqZtCjqTAtE40FLWUIDRmvRslcEz3cuQr4+HhRIu MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7bhs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 00:21:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EMDnA5005761;
	Wed, 15 May 2024 00:21:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y481ebv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 00:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9MnDHXwOL4rSy5DkHxzzDylH5F7jDcu5rQUKbBktpLKC/pexPiucAUXtzrFY3MR9DvtyrOblIg4zWK7tcKqipbMbIIflXdrv9pZUmkuuNhE4gcT45zEDdXFw0NA8QKn1iFP5Ytfj3DE1PqClpB/q5Vb0H5deEy/erKpKFHKwW0vxeTbAQGKJt6YGH69KHW3o75Pi46eAkAWaBtleZI1T7kR1cXu2hNTlL5dCN+xTLb3MB/BBF91+yF3f5SQlZwK60CkBAOKR1MeCSZlw31o63G4x1/W22UvqfQ9b5GJrqiRM1E93t+/9SJ4u0nLEqZYxBz9BOktWLU7X/SbUHsj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv6ogX6opYQwNKEQM9S/ybOp7o7nY8x9fXWX+w2dykc=;
 b=kS83Hp06VtE0YGr44DUa2auZG1cS/lhHnB42tjPWKuxf8ciVLQEMkdbRA5+c4JqeuiKPfgehNkl4BWtf37N3ErNRvXpdR970nQiPWcHmoNgieFDSsEBNOQPE2+V3ZyV1pUI5e2EVjjblxl2naSDIZISxcgyIldSZDNN0e/BcRyo5gkatr7/6QSXr4L+e0hR3N+Xs2QZTEENGSI2nvNh9VSa9T/ePzwq3TSOVKVs1Q9AbkqkorjqpIbhmAjhJLQeXIavXA25pRH9pj4AFDRC4nAqYDIHPbwtMidfZI+q4wvKjOAOIFOZqnQpYb5tnO9JYSZD+8EwO7a66H8ott5rJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv6ogX6opYQwNKEQM9S/ybOp7o7nY8x9fXWX+w2dykc=;
 b=U0HKZ2HgFjnEs3sZlpFxdXeCj+LKfx7XkzOkWGGo5rqZWp1NN1H0pKCDfiuv/2XB0Sq5idYQpXpUX3yc4J00yAsAj+5PhDqXkIHWauTrVhA5nLZ6rSP6b0GsA2nBOyxAAWvrXPRCdYwOMI1izVVmzR1YUN+cJdsN5tQlFOmvQH0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5596.namprd10.prod.outlook.com (2603:10b6:510:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Wed, 15 May
 2024 00:21:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 00:21:06 +0000
Message-ID: <258db2c1-6c08-467d-a365-6b623c208c85@oracle.com>
Date: Tue, 14 May 2024 18:20:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] blk-merge: split bio by max_segment_size, not
 PAGE_SIZE
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20240514173900.62207-1-hare@kernel.org>
 <20240514173900.62207-4-hare@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240514173900.62207-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0492.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 33adc38b-e3c6-4418-8645-08dc7474e997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NzQ5NHRyS2thbnFTakRkTGpzb25hZTlrNGl6U1RsZU1zS3NxZHBiTXRBR0JY?=
 =?utf-8?B?TGJZUngwNE5PRm5UOFVjb3NmUWVOU0c2QkVSVlg4RnkxQXptRzZ1QmRKblcx?=
 =?utf-8?B?Z2lmRVVMbG1PekRCdlFoUTd0YmNpS0lUVDJWMlRFWWJTT0NSenpTTWJraElR?=
 =?utf-8?B?OENyR3hYMy9kaCtld01lb2RieEJraDJDcEVyMHpGa2lKWmJ3UzNxVzZRL2RJ?=
 =?utf-8?B?UnpUMzJEc0ltbFNYN3pqVmlQUGI4UTNoblBFVWJOamRKUXVGQ2FFdU5XU3A1?=
 =?utf-8?B?UUhNWDNzWDBMdHFZUEJsdkdYaDN5YzJIMHgxUDE3QlVoQ3pwYk9Pd2pxTjJa?=
 =?utf-8?B?dVRNTU5WTTJjSFpUeUsva1E1K1EwUVJKRFB1RXVxUWZ4ak0rR3ZrQlVwQk1L?=
 =?utf-8?B?bi9PTE10dDNDOGpNQVo1U2gzZGZvNGxDMFZBbCtJSDQ2MjhUSjFHc050K1h2?=
 =?utf-8?B?QkRxdGxJVEpjeGIxaWlZRVY4dk85cDhOczFRdXIvUzdWMGtRMElGM1JNRFF1?=
 =?utf-8?B?ZkpKdnRrN1MrSWdMSDdBZjZNczFXTUVpKzhYeDM2WGxKbjJGTzVxdE5xZHVs?=
 =?utf-8?B?dDJCQlkzV3U1VnVTcitUMEpUWGhSUnV1YzBsbDVFNmpVOVFjNmxEdlBiRHo3?=
 =?utf-8?B?dTdrNnZScnkzS3hkL2szK0hCM3l4YmxsdmFzODNkNnFYaklvZXlvNUxoSHox?=
 =?utf-8?B?UGU1ZjhCVTZSWmFTQUpuQ00zTmJpUDFmNmtpUG9WcDg2K3VaSTRDem5vZDB6?=
 =?utf-8?B?UlRPT0Y5Tnl6aHZ0MWlwUGlMYkFJV1pKUnd2WEZDQWtwcWxkVjh1NVhUY3hr?=
 =?utf-8?B?eTRQREtZNVhJTGJYWFEyT0tOcXh3dEMybm1TZ3hkcGZyUzlpdWtvZ3BPUUIr?=
 =?utf-8?B?djltSnRXUVhsUVpZdzM3THJjL3dONXRRMjR4VDRENDNlVVgyakc5OTFBT085?=
 =?utf-8?B?K3ZnSVhTRXBMQVcraXlVdXFkTDJvYzRkUnN0Q2YrdzVvUmhqYWdmN1RnR3Z1?=
 =?utf-8?B?N1ZVbnRySnE0QlZvZy9Bbm5UVDBHZU9NMlNLRzFZYjRVdFlEdzBlUk55TzhW?=
 =?utf-8?B?L3VBT3IwUGdOa2U4Q1lJcXZDS0tBSDY3RVlITlZDTXhXdTVjRGpGK2tWbEdO?=
 =?utf-8?B?MnhMSWtYSTFRSU1RdzYxVG9xZWJGTldnZ3I1cVdWNHp4ajIyb1p0T0dweW4x?=
 =?utf-8?B?N3lyYm4ydlU5c2JPNk5SbnUySWRXWFhxdk9ZVHFxdVZIQXA5eFVTYzdJeGZU?=
 =?utf-8?B?TXkxL0lnUzlRWmRUTVZwQ3ZjRWRjYzlhM3Z6VWRsazluMlBGNXhsWTNZbTdX?=
 =?utf-8?B?YUY3b1gwaXBXeUlMWDlJb1VhQS9yY2t3Qlc3cTRKQ1F0ZFBvTjhkUitncTJG?=
 =?utf-8?B?dzNKRnlrRlJzOTFxOHMwUEtWUk9jY2hsMjhNR2VvWG1RK0d3Q3RrK0ZNRDgr?=
 =?utf-8?B?WE1Ib3gvRFk1aVFUaEw1Ri9SZEdJc0UyYkhvbEZjRklSd1p6T1RVWHZKb2RM?=
 =?utf-8?B?Vk9mYmR3bisxMmU5Q0N1ZkFtWVZhZk5EZmZjUW5QNmpYTzViTEhXL0UyVk42?=
 =?utf-8?B?VFFsZ1VUNWdXUEhXOUh3SWxxRWVhajdwQXlYaGh4cUNQbm5NVFZFTWxYMGJC?=
 =?utf-8?B?cSs1QmpNaUxnTVhZa1Y3aERyN0ZIRGJwL0cwQ1ZDMGV5VnRISDFTMjZ3NVkr?=
 =?utf-8?B?MDZtY0VTZmhQbFdROEN5QXdDVVlHZWkrMjF2d1ljWkRNWlFjNDEwdDlnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?STU1OXM4UUluMU0vNlpDRmRJMXQ5aG9RUUZyTEF3NTB3ckdDNmxoKy9KOWZn?=
 =?utf-8?B?ajEyaEFCN2FIQVNhWDlpbUkyamFlY2pwaStEVWIwcnQzNjl5T2JaV25pSnZ4?=
 =?utf-8?B?MW5oTUdHTm44aWZuNHI0RHBHL2VOM1Y1bEU3WFJRbC9PaVNIV2FIS3JMcUMv?=
 =?utf-8?B?VlpiN21XUGVmcFRydFkwTWFCYUJYUGlJcWgwY2N2NUFJbVV6SWVkb1l2N2JB?=
 =?utf-8?B?OFJsTGY1OFo2Z2xzUEsxUXB4TUl0dUg3Qm9SdVBJazdhdEZQcU80bVRFV0RI?=
 =?utf-8?B?VnFvNjV4VnppYkwvM1dKS1llQnY1NFVOZlpnb1dCSXBrZ2dlNThQSWpKaDNF?=
 =?utf-8?B?bU9VbTgzVGt4bVo5SGtNdE44cWpFUnRrZHlCSkZKY3JMQWFUNjNIa2J4K21L?=
 =?utf-8?B?S1pPU0Q3TGh1MEZsbEZrOW10VXBBVnFiWEhEYmZnTzRlQi8rZUowNVVyZ2dW?=
 =?utf-8?B?ZSt1WUhHY3ZPOEhQNE5ickNsdytjMHZlRFEweFZjY1JxWUZZNUNad0pvU1ZT?=
 =?utf-8?B?UlViYi96bTVnci9mc0ZXMXRrQUU1VlM5UUJ3WjVaRFM1QUtJRU5CUTNodTVZ?=
 =?utf-8?B?citYcnNJQWJqcHB4SkVucVo0dzhSUTI2ZG55NmpFMTVRMERRZ1l5UDhDcElB?=
 =?utf-8?B?dkRzWFNvWkZEdERRL0kzdXdSRjRncXUzOXJ6eUtkZ09LKzlzV0xwdk0vT0Q0?=
 =?utf-8?B?TEdWS3drOS9VUjI1NGNuaS91ZVlBT0JIUDlyMHNWbmxlRUVISEhQSngvalNa?=
 =?utf-8?B?VHlXcUdVOU5DMVRjOVV1UTRwcEx6c1lJbGxlZVVSbnM5UFdJVlhMb3Y2cTBG?=
 =?utf-8?B?TGdjS1JieFlacG45RzJOaG1MYk43a0l3cVBabFJMeFNMN0xwZitkNGt0aVdD?=
 =?utf-8?B?UDg4RjNSenA1Z1BWOTZsNDdSQkovYmR3dzIvQWZ3Njh1ZEVPR1Ezc1FTS0pz?=
 =?utf-8?B?dzBXZU9rUURKSUhJblNMazZLUkN1bGtKZUM0Ri91Z253QnhqYnAyUFhxemVa?=
 =?utf-8?B?NDlOK3NLMjI4TVpzcG9wNjlSZkZuOGZieDV0Rlo3VjU5aDdpa0l3dG1BbUo1?=
 =?utf-8?B?N1RpYVlLdFVERGpUOTBqNEUvN1h4cXJuWXBDWHhDbXRuUEsxcWVyNm02OWQ3?=
 =?utf-8?B?dWxTM3dVcGlmNldYaDIreUNGaVdJTjFzOUhYUnI2T2duQTRpUnVjenhDcUhh?=
 =?utf-8?B?TE1lcFMyTlVNNVJJMUtPTXhXN2RKNmJ5RVBuaTlzU29vbEtLc2JETXJSdXBs?=
 =?utf-8?B?UHBjZlFRNTN6QndvQ2xCS1M0MlhRT2NJTE1DQVdubmtjMkFSdjZOaUpuaXVS?=
 =?utf-8?B?VDVxa1ZERWFrL1puMVZVL2MraG5pMm5SWlVwM1NBblJ0UkJQQUQzK000RWY1?=
 =?utf-8?B?MHNDZmNJY3ZrU09kYjhVczkrNHlGQjU1UzFRUzNGdzNGTTlXc1Z3c1IvNkV4?=
 =?utf-8?B?OVZ6V2o0ZkJXQ0dUOFdtbmZ4WURlTHhZdDVPSnlPek5ESGNqcVgzUG5nK0tw?=
 =?utf-8?B?TGFvR2xmdGpsRVhKendTb01rMzZkMTZCbTIvNXUzMmlPMVBJUjJZL1RwQVpN?=
 =?utf-8?B?Tyt2SHQ0Z2o1R1V2MmYrMStJRkdJbUNScE1JZE5ySGVDRmhXT01wUnd0V2Iw?=
 =?utf-8?B?ZFFhY3grZUQ2K2g5YkdEd1c5MVFSSUpQRnN3WG9TQmtYeTh5RHVUc2psaFpa?=
 =?utf-8?B?NXp2WkpBUVZITmhOK3dSeS9ObjByOG5Tblo3LzlhallzbHpMSzRGNkU4cEpD?=
 =?utf-8?B?MllsK0tIcjYxeW5ibyt5Nm45clQ3cmhqeUs3cisyT2xST3ZFdmlzT0VxM3FL?=
 =?utf-8?B?cjdmSnJ2UDFpK2xBMENFWW4wbWQ0cit4Rzd2YlhkMW9NTGZTZUVJWWtYUHY3?=
 =?utf-8?B?Tk9xQUJqOUppNDlNQnNscFVNK0VXWjl5aStxMXk0dUFWRGVuWXJsZ0NXMGhO?=
 =?utf-8?B?L1RjQ2xiUkxPV0hpOUFWd3lJLzlsVG1HazI1SFc1SUU5ZTZXT0dBNVA2cld5?=
 =?utf-8?B?TWM2c2tlYkk2a2RBQWZnd3NBenR4ckxXdlk2aTZ2Q2RKY2E3Y3VBRit3Mm9D?=
 =?utf-8?B?dXZ0SHZsdmtvMDRLaXNhb3N1OFVlaHJPWWowYlRPdlFweWdRQlNCK2tnSWp3?=
 =?utf-8?Q?SI13ZuGgE32v8vO8otViWEeqw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NeMvNd0qLt+uVvlCkEoPwR8Bc2pAuTa4omDNV9/i1johkPp9x/2RzTbhC/8aXZftchA03TJDF7vM/JwzdDUUUwGN5IokNTb113cSs5tjC4RczXCMMyoxvosqV98tk7w2K3KQCpvotm7RV4h8rS3TwnTFrqrfdqnLwsAUQiQvkWm+nhuP9vtK5rSQ2FTODorjBdW8SzhkXSx9mXVonwhC0rf39X3SFMx9CRziuc63aDeKqbpcpYxE/FsextBD3VNvqtqm17RXedBrTRn70rG0gadrl2bHmO7rau8IR44KUmKgPRXrelariLvg/AhyPzCZi9fAS3XOO22jhIj34rsE8LcQ0G89ZeKCmDOHql6Yf+DjVSF4oDuA4A7/lJUN4IQo6YHnEJLeSk5GxlkHidxWOIq+PLmojhBbgpzyov0ozG1PGZr9DidDdyDDC/u5p6S5uFuTQWlX3vEknvBKcX/1FV8ylwRIxxiLMmCOUTcyezlc0kkNvXEbzKiuNuqbh+eZKMej9MPT2S4uOh+BwpmzJx5lHamRsGjq7/+PwYTXFGTqXj5rb7L84MJ557qsPZ5bRPANr7dtyq2ETDOKaKaucuhij/+ObQ4wINQAJQxcmQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33adc38b-e3c6-4418-8645-08dc7474e997
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 00:21:06.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7/PY4BmCB5BLSuGUPKp/B+USKq4Yp/kjU6YZSxqRt8aU4qxUQxv7GES1QQwErSN7pHySS8YK3d99zug0jjegg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_15,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150000
X-Proofpoint-ORIG-GUID: ZwlELceAah-M1LcPMpgVnIiHvSoydIJ8
X-Proofpoint-GUID: ZwlELceAah-M1LcPMpgVnIiHvSoydIJ8

On 14/05/2024 11:38, Hannes Reinecke wrote:
> Bvecs can be larger than a page, and the block layer handles
> this just fine. So do not split by PAGE_SIZE but rather by
> the max_segment_size if that happens to be larger.
Can you check scsi_debug for this series? I took this series only up to 
this change, and got:

     Startin[    1.736470] ------------[ cut here ]------------
g Load [    1.737777] WARNING: CPU: 0 PID: 52 at block/blk-merge.c:581 
__blk_rq_map_sg+0x46a/0x480
Kernel Module fu[    1.738862] Modules linked in:
se...[    1.739370] CPU: 0 PID: 52 Comm: kworker/0:1H Not tainted 
6.9.0-00002-g4eaa50af9312-dirty #2416

[    1.740474] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[    1.741809] Workqueue: kblockd blk_mq_run_work_fn
[    1.742379] RIP: 0010:__blk_rq_map_sg+0x46a/0x480
[    1.742939] Code: 17 fe ff ff 44 89 58 0c 48 8b 01 e9 ec fc ff ff 43 
8d 3c 06 48 8b 14 24 81 ff 00 10 00 00 0f 86 af fc ff ff e9 02 f0
[    1.743015] systemd[1]: File System Check on Root Device was skipped 
because of a failed condition check (ConditionPathIsReadWrite=!/.
[    1.745122] RSP: 0018:ff37636e4032bb90 EFLAGS: 00010212
[    1.746419] systemd[1]: systemd-journald.service: unit configures an 
IP firewall, but the local system does not support BPF/cgroup fi.
[    1.746891] RAX: 000000000000001c RBX: 00000000000001b0 RCX: 
ff28e6d8b0950a00
[    1.747903] systemd[1]: (This warning is only shown for the first 
unit using IP firewalling.)
[    1.748549] RDX: ff7662becb4ac482 RSI: 0000000000001000 RDI: 
00000000fffffffd
[    1.749688] systemd[1]: Starting Journal Service...
[    1.749895] RBP: ff7662becb4abf80 R08: 0000000000000000 R09: 
ff28e6d880fadd40
[    1.750965] R10: ff7662becb4ac480 R11: 0000000000000000 R12: 
0000000000000000
[    1.750966] R13: 0000000000000002 R14: 0000000000001000 R15: 
ff7662becb4ac480
[    1.750970] FS:  0000000000000000(0000) GS:ff28e6da75c00000(0000) 
knlGS:0000000000000000
[    1.750972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.750973] CR2: 00007f7407f19000 CR3: 0000000100f24002 CR4: 
0000000000771ef0
[    1.750974] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    1.750975] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    1.750976] PKRU: 55555554
[    1.750977] Call Trace:
[    1.750984]  <TASK>
[    1.750986]  ? __warn+0x7e/0x130
[    1.750992]  ? __blk_rq_map_sg+0x46a/0x480
[    1.750994]  ? report_bug+0x18e/0x1a0
[    1.750999]  ? handle_bug+0x3d/0x70
[    1.751003]  ? exc_invalid_op+0x18/0x70
[    1.751006]  ? asm_exc_invalid_op+0x1a/0x20
[    1.751009]  ? __blk_rq_map_sg+0x46a/0x480
[    1.751012]  scsi_alloc_sgtables+0xb7/0x3f0
[    1.751019]  sd_init_command+0x177/0x9d0
[    1.751023]  scsi_queue_rq+0x7c1/0xae0
[    1.751027]  blk_mq_dispatch_rq_list+0x2bc/0x7c0
[    1.751031]  __blk_mq_sched_dispatch_requests+0x409/0x5c0
[    1.751035]  blk_mq_sched_dispatch_requests+0x2c/0x60
[    1.751037]  blk_mq_run_work_fn+0x5f/0x70
[    1.751039]  process_one_work+0x149/0x360

I suspect that you would need to also change the PAGE_SIZE check in 
__blk_bios_map_sg() also. However, I am not confident that the change 
below is ok to begin with...

BTW, scsi_debug does use an insane max_segment_size of -1

> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   block/blk-merge.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 4e3483a16b75..570573d7a34f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -278,6 +278,7 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>   	struct bio_vec bv, bvprv, *bvprvp = NULL;
>   	struct bvec_iter iter;
>   	unsigned nsegs = 0, bytes = 0;
> +	unsigned bv_seg_lim = max(PAGE_SIZE, lim->max_segment_size);
>   
>   	bio_for_each_bvec(bv, bio, iter) {
>   		/*
> @@ -289,7 +290,7 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>   
>   		if (nsegs < lim->max_segments &&
>   		    bytes + bv.bv_len <= max_bytes &&
> -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> +		    bv.bv_offset + bv.bv_len <= bv_seg_lim) {
>   			nsegs++;
>   			bytes += bv.bv_len;
>   		} else {

