Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257652AD16;
	Wed, 14 May 2025 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206765; cv=fail; b=sS8jIH2xI4oYqbFmF227U/m85AHxcQFuD/tilcgWwlh0rKmX54PHYcPDfpSOMgQTCVAw+znZ8vxsKB0DNkScAl87n+w0w82I6qxPOOqSTlPOD1vm9SYTRLF7OhZNvD9fkyeKhMNbEMeztO1uiFME/2zIbPIEPt6zX24fcOetVMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206765; c=relaxed/simple;
	bh=BHBjLVKDqYWFdTq+RVaF0qIQs+WqMlnPTym8Zc81Z7M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7y/s/bLVb8xh5pkaTOgFMPfJdymU7Uty73W+HgYWBdwIN2dIRlZ3kabVQnNxia3XswtxX9fIPLRz439rSxhIeKQkks15c63VKeZvUNs3GflXX94FQKt80CHQPj7d5uRinr58LcttgnjXh2/SCnDjS2yHg37RrYLhfO5qzfHSGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e+lX/7la; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RZEAJI2J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e+lX/7la";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RZEAJI2J"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fsFk027871;
	Wed, 14 May 2025 07:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lSht8HPpz0J08d4XA0ar8r4j/NfL+j7TYR29aNfFTMI=; b=
	e+lX/7lapxIxEkpoE+7l8c7jubaY/Em9kRNUtRtTtVj68B61QvTYkAjy137rT746
	JiqtOKCeudbcNL8zLozOvLk2c79NGYLNcpA9DBczwU0RNJJLNkuj7RTCNOCySA4O
	zy/QkTBpbL+XEdXZq8WN7cDvZzSf0X2gMZZexgDPy3Iq5UvjrJQ97vixGNDByX+q
	/vyHdJaCAAi8ds3VuASAIcq43e1radGbvxZN5tc8Cul7fvr5SBb0qGNf4om+Ev55
	wkEjv++th+9y/Ycqhi8vE+6/CFOuETe2xqw5LXT4O6WaNVjiQQgL7Yjmr8B49J+c
	1lZWZbk8NSK/Bj/xYf2lDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmgwd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 07:12:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E5kFMl001876;
	Wed, 14 May 2025 07:12:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc50a5k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 07:12:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYjO9vXy5s7MtTNa4E6CDzgZk7naqYAS7Vr7ePDO+iOelHYV4StWzueMdmQAYM7B3SWNQZjW1rq58T0aZr2elYVPGtLYlO8sEjdtFnJpMzevmPKg1p2VDNkwNmo3dRdFH6w0yiebuoCPYfnvDkmJUMQqhkfgeEZdK9NhtfCvpPRBheto26+JeNEAz7ZcULLr+x94N7BDWhcrvj2YWHzdM5wCtxnQOKINcXEAHCbOrWsAsCQLg2do9NrOt20cmuUa+1N5VZ5qQi9vbD0oBi2fePRC7im3//mDYPbTY6GOgUbAUND7K7wecRjbLPl6jLSb/pziOkUu+MztKPuUgeUk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSht8HPpz0J08d4XA0ar8r4j/NfL+j7TYR29aNfFTMI=;
 b=cWao3iJVGenVAd4uZZbl27JiCGuDmi5iG/KEWW/dMcWvGCYcUioI/F6AL20j+lGJhFOlv0KXyTJL7iEdZLTaM3A6d/+iMy4qaW2XVB1tXYnhXahAOiop9JskmhQoFleu90HekUlymL/v0qAu7n2Kway53rcJnIzvQfxRwf9xSEPZ/gHEKedrZHBpyfpckS6OdH+0Rjfy5sUc3jBdYh+YHkLlgNhj30xSfwi5mXse9KTRzMcWgdP0KbgYRBYuY5WEKamBJ/cO6erfgPReRWF5S3G8wlQ4nE5K8NF7VqpJ1Gpyzrei7oFr9faazaQ6RatobU3/tJgoN/Xj9bBZpTTq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSht8HPpz0J08d4XA0ar8r4j/NfL+j7TYR29aNfFTMI=;
 b=RZEAJI2JS7rZ79ibs1N58GXtf0XfqKYXpweGwvyOSy0IPqKU72enFjd+ukbrFjA3PXDCT8A6OuqanCXnMoBQnNgraCb7WsUqaaSpD0fDtkWjcRZy0RseleeePGJiZvohv+RL7kRrM6rMHT3IhgNFHZCKglZPnt4IXrkRNTH+t1o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5633.namprd10.prod.outlook.com (2603:10b6:303:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 07:12:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:12:28 +0000
Message-ID: <10240de3-661d-461d-a8e3-de2754d5f66e@oracle.com>
Date: Wed, 14 May 2025 08:12:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove obsolete configs BLK_MQ_{PCI,VIRTIO}
To: Daniel Wagner <dwagner@suse.de>, Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <wagi@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20250514065513.463941-1-lukas.bulwahn@redhat.com>
 <a0c3a812-8a24-481c-9354-4475ac71d68b@flourine.local>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <a0c3a812-8a24-481c-9354-4475ac71d68b@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0028.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::41) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f46429-c152-45f3-0ba0-08dd92b6af70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2RqY3VGRndhTUtUTTNveWExcnRUdlVKbmhxZmZKY3FRSjNHQ2RqdkVRbzRL?=
 =?utf-8?B?R3ZYZGxuK3lRUXpYUUMyMUZTa2k2N051SWFHVUVwUHc2emd1Z0lIQkQ0U3Yr?=
 =?utf-8?B?Y3Fod0d6eTJTUGx1YXRmSVJWM3VnZVF2S0ViRlp3UldJZkdEVVc2OUE4eHhm?=
 =?utf-8?B?b3lQWUJnVGRrcnhFUVpWQTlyUlBRZitmOEZLSjBibGdYVzIxaU9odnhwNllU?=
 =?utf-8?B?ekk0VWYzdXlSdEVzSEVyMlhmUTVnSkJaRVJUREM1R2diV2hzZExIajFIZ2Q3?=
 =?utf-8?B?RElRUmlKcG96ZDVIWG9HR2psRjFDTTNod1pCZ2hrY1p5SEthNytBc2Fuam8r?=
 =?utf-8?B?a0RDUVJDdVNWeW1rUUZ5NFplMHpxNWpwRk8zOVllVlI0SW1YUmozeFdHM1Z6?=
 =?utf-8?B?RU5qaXpvYlY3V1loTmVCTnZJL2Q0dElnTU5Ec3dlSFJ2NlVWVHpDWG1tL1Ba?=
 =?utf-8?B?UU01KzdyNUFhbWVEN3Z3c1ZYdXlLZjRHellRdWtyWGNSdjJKdW5uVGxCTE5I?=
 =?utf-8?B?eHB3MWg5dzlHZHlzckVHVDk0WjVpYVhucmVib09LMUl1eXpvWmo1Q3RhOU1a?=
 =?utf-8?B?Q3pPazRnM2dSdVpoZXhOY0pVS29iekVlTXhMK0lNUUVGLzZJWWQwK0tXVXk4?=
 =?utf-8?B?My9zUmVMSCtBMERvTWJib0s1dGg1SEhuNmhheEh3Z05COGxuaE8zaEo4ZDdm?=
 =?utf-8?B?ZThxbnBib3djZGY1L1BpU3dBcXFVZDlqSlFNQlZTdTRSUXAycUpibnV4aVBP?=
 =?utf-8?B?TWNJeE5jWVJXSEtQSGxkR1VvR1B4eHlEY2lCS2x2dmFGTTFjQUV1S1FQYVdk?=
 =?utf-8?B?WEhhbDg1N0VYNHVCUFZtcnVCa1N2YnpscnNPdW03OTZEaWlIWGF0Y0lueE56?=
 =?utf-8?B?U1h2VVFlZjlqZndqWk4zWXFHeGF1amcyaGlXZTlYT2M2Z2dpVTNoN3VuTldU?=
 =?utf-8?B?dWJITk1VSk9EKzcvN2lqWTNqUGFJd21TaU4veW54SDFVK3VtalhSUnhtN0Yy?=
 =?utf-8?B?ek1CZXA4cHZCOFEwbUN1cmZpNkR1a3ZoTDNGVHNZWlpzbjlJVnhYRlB5ZUcr?=
 =?utf-8?B?N1JMMmZ4bzQ0RHlPS0h3WkVSbTRML29ZVEVVMzJpQkQ2eVNGdS9iQnI1ZFlW?=
 =?utf-8?B?T216cTkyd2tjUSt0dGtNaldFSkczdUFESjkzc0dMekY2UWdSQlhaS2pYelNU?=
 =?utf-8?B?amJwOVF2OTlTQkZzb1M2ZGRXYmNIamxVWnFQWEM1aFR5cERZT2EvcUdVYWtl?=
 =?utf-8?B?bTg4SzNyU2ZaeXpPcFpCZTNmQ3hxNVRCQ2YzZER6RjZ5TDJyTFhnbWFqejk2?=
 =?utf-8?B?Tld6eFJMQXNqWnp6bU55YW1aelBCRHBnWXRMWU9MSkR1Rlgya3JTQVlNbzE1?=
 =?utf-8?B?N3dmb3VnQWZVbzRmWTZwakhPa21LbVpBTVYxckxsVHUrNkROdkhnZ0IzUHN0?=
 =?utf-8?B?elFmN1ZVSWs5TTNXa0pHaUl1S1EybDR5NzFpNzB0QXdOQUE0YW1sSTVDVEQz?=
 =?utf-8?B?Qzd0bm9YcXl4dnNvTzVaNTBHQUI5ZGVtejk3bzlsek9PaEhXd3EzZkRZSVJR?=
 =?utf-8?B?QjNrTEFQc3lTWFAzYUxaMFJYUUNGME9aOEJ5dlljUTUwWGtWUkpNWXdBQmg0?=
 =?utf-8?B?ZW9TVzFVTDV5eDVwRkI5SnQ5K0ZoU3FwZklwKzRhdGVscFNMUE9HTnNGVjYv?=
 =?utf-8?B?OWhaa0FLQllaekxYdUFMUTVyUmFtdk00TWhJblhCSWl0ZHJZT3JaYVVkUVM4?=
 =?utf-8?B?c1M5MGduSUNCNlJtTlpYYnhDb0JTTkEyQ252Kyt3UEJXRjZYeXFvVTV2c0NY?=
 =?utf-8?B?TEJWNm9iTUsxZmU0M3ZaL3VLcGNLemNYa1d2THI1MHlGVnZnNjRCVGtQeDZ0?=
 =?utf-8?B?em5WZ3lDWHRXcUlJakJ0b25JbXFKM1Jra1JabkNqUFRKVnVnNmdkNlVhZ01E?=
 =?utf-8?Q?bN0V4rJZJf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVowTG5XcFprd0hKTGpLcTU2TTRPMGx3K200bHR3MjdxUUlRNFd2ME9oRTFZ?=
 =?utf-8?B?WjZvMG40eFNxSU5qTW9QU0hPL0c4Skt1MWhMZVNZeVkxVWJodjJqRlZ6VEpF?=
 =?utf-8?B?ZE5mZTlyc0V2YlNiY05UWHVYQ2RiS0NPSk1QSW5sM2ZueUNMREZiK2gzWmVY?=
 =?utf-8?B?VEtpSCtpVXo3ZUExY0UwK2dweFBSRlFSdXVIV2h3bXlkcUZscWE1QlR6cFhy?=
 =?utf-8?B?MUlPRmRUREtqelpsRGNOS1ZCRlR1alZ6OTFEVGxxeC9oaFhBMWpTbll1SmY3?=
 =?utf-8?B?aHpzdmQ3cnorNFAzZWFudXBvTEhzUDQ1MmoySmhpV1BudlZLTitIRmJKdVE0?=
 =?utf-8?B?Q1VyR2tZTXduMkozTnJuZHFESjYza3ZTU25hODRMMjVDU2VmY1NoUFk1UWd6?=
 =?utf-8?B?RnFwQXBzQVNudzg1dmRma2RxeVg3WFVSa2wyemhkK2tVSkc2amxPbWdCQ29G?=
 =?utf-8?B?dmpNNHRmSE1IcUNIdlcrZ1hoMXRJMlNpdWQvcUI5a0ZwOTd1Z3ZrbGNxcFRV?=
 =?utf-8?B?WW13ZDNkN2lQMjJURk9nRUNoSVl1TWhKaVlYQ01wTEdxQ3JyM2s2OXVVa1cy?=
 =?utf-8?B?aWlhUlFFRnNNVml5NDFIdTdveEVHdWxMRWNPOFZvUEJITmJwKzhHVUhweUJJ?=
 =?utf-8?B?OFMyVnFYNHBwbnRnS0hCa0pGT05telBLelkwUFpNd20vSGFreDE2WGtzL2Nw?=
 =?utf-8?B?cnlEOVZCa1NKdmQ3M1gwcGJyam52SjJ3eUMzRzhPSGJWbjk5V3dyZ2UzNCtR?=
 =?utf-8?B?aDRMbk1hbGx4N0RiYVJkenh5OTU5QzA0N20vM1J1WVlBYXNMOUlMUEljUmxQ?=
 =?utf-8?B?Yk9KR2tUNjdHaS9uU1BnRm04ZTBiNFg3eXFpTnlITnpURHNGQUZXc2pNb1JY?=
 =?utf-8?B?aC8zSnJtNW5hUFpucmRUWjJIcjRLcGM1RDI4WUFJNU5KM1lqOFlQL0JmdG9R?=
 =?utf-8?B?aVNrclIzMXk5aTJLemNmSkRYYzl0WVJzYWRsaGpWeGRrbG53N29mZFJwSUQ3?=
 =?utf-8?B?cUxac2xFeVVwREhNNHRybTQxZUlOQU0rMkFkNGtCeFhMZWdxczlhcllLeVFr?=
 =?utf-8?B?Qm9ZUDhJem40L21zd3R5cWdObXZqT2pZRmFzQkpVUkFZaFJzUlpNaVhIOWkx?=
 =?utf-8?B?VTNsS1hSdzBLUzE5NE04L2FKalQ2OFBtemRTcUdvSUdzcDhka3dSakZmMzZw?=
 =?utf-8?B?RERtZWtmbmt4K3hyRnF1VU1TQ0pmczFhamNwekI3ak5pYmZXc09IVTJJNmUx?=
 =?utf-8?B?UFE0eTRIZHhicXpzSVpYbE5qemh1YkRLeXlvL1dzSjJFZm94NmROUmpOOFQy?=
 =?utf-8?B?OENjMGM5RHZyOWJ5VDc4S0lDa245VmNjdWpzVk91dmtMbzh1dGFrTkp2dWE1?=
 =?utf-8?B?azRkaXBnNWRMZkFzMzdRYlk4djI5cExGRjF4Y2xyV3VIb1VBNXdQVGVCNFla?=
 =?utf-8?B?ODVzUHR0dGh1QzZGREJtUkZRWG44TVN2RW82K2c4bHJMV0NZb1R5eDFJTXFY?=
 =?utf-8?B?WFhkVWszdEg4Y2k5MzZIOXVQUkJ4OFg5MHRPckwrYVd4bkhyZktUazVUQVpo?=
 =?utf-8?B?NGNBMWx0bHNHcERjZTF0cXllK2Z4SHlWaTllSzcxZmdGK2E2clp5WTFYTGNM?=
 =?utf-8?B?NExWQW82M0hXMUxHbWFIWjltblNyMVZhWjNIL1c0SzdnYktFa0RrdGFTRkFy?=
 =?utf-8?B?bFpGZ3NaVU5XTXpGdHJnM2pCWDBla0hrV1h3SHFNQTNyK0FjSnVCbHZNaEVv?=
 =?utf-8?B?SklFSDY4emxSV2NvWjhEMkRjNlVFNFkzSWovV2xjYWthdHpwZ0QxbTVYK091?=
 =?utf-8?B?WmtaRTlNcGV5TlRRaFlCaWZPOFFXd2JmaGdIcHpyWFNaeGhjd0V1NkhtV29s?=
 =?utf-8?B?RExaaFhhNnNmdE1EbzJZdGRyckVpRHFFUkJ5R3BiRVhGMWFrVnR1aldkdUJI?=
 =?utf-8?B?THViaUVBcFVqYWpNZzRqM1dXdUtibWNXSTU2UVV2OUxiSm9HeTNSaHdSUVds?=
 =?utf-8?B?YmF3TklEMWlxQmVrTWJhc2JoYzE2Ky9ra2JrTzArMzQyVVJPTmFSNlJhTXRs?=
 =?utf-8?B?ZDFOQi9tdW1sOEhJWXJOaFJ1MmZlYW5EVVczTVdueW43L2FKaGVYSE42eDRU?=
 =?utf-8?Q?kxVd+xedkuiUa/s92WNWqbkdF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fc4MbNlh3s1bm8wmV+V8fx661+wVhvAvdIioEH5dVJ/JYrEUeg27wnlIcJVFhJUW0/5Zg4IPI5lZABx8ts8dOSnfucp0cU2kOPs7Cb0J7zuIs7RTX08uW4w9yhMg+QzgItnY9SgCmLMbxttLQnHwTJ8jZGDESWDeT5ZXTWstn4uMpfrAw/CVfRh5uJyWRGXt6yOKFlvI+06Hku/kcGIEGUkfy3vkvSPma44zlTCnTI9GRMcuusYJbhF+BUIoKUDb1kNyVB1WO29TQDrz+Yqsbm/c2MBgyxPQWFNa1lrZpmzdzfjMiTXb8n0ug0E/xMW2oodMVxpQbcC7eXuH6FfB1Rbv8l6nbFf4g6xeB62NG8ICwJ1mmZ/MRXupcClgyKxK7SKDhUzbPWticRBPI1ROdaN2/XvCZBUNfzbIL/wSq5uTA6MfnJLDhP0L+O6IGkFVjCyZ84LWkeTC9PXQAr4tmnr0uzirz4scdUol8YMFPOyEYgkfiKfx/48MqHxca6zoe3Q0ahZ077lQ9eHr8W6VpphWC6h/NozG7sOpznqYwDwRiRLNSE7dvWBVQz7FPI614uPz7co8x4O1l0rdGV/HFtAzVbTSlbUCl0du10zMoCM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f46429-c152-45f3-0ba0-08dd92b6af70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:12:28.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6y5lnYSCzaN6k+3JJvj+xqzk3T+K8y9dUtJuQvndE0ilgwq/8irevOuh6Bs3IF85UxQLtXjr1SdB33A4NjSH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140061
X-Proofpoint-ORIG-GUID: xs3JnBXkJOJX6-epU9Z8uGSsWnHFRds8
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=68244261 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=PCMa_IL9L43O5Bbr308A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2MiBTYWx0ZWRfX5oF4Ps76Y/+0 HTRi8FP8IL6lXarLMV8aVwzU8nEGhRCYq5AXvmllzq5ne80s7u5/e+wmCwz+iNqYGF7qIFPKl0i Yxp/3Wn5brcIVt+Fjo5KalJWSfmw+NoVbvhsE5XOYC18ErSvyUqr7do2Ww8zazd7beIVjgsMRez
 nwnFENNRl6+7RURZ6dHgl9pH9Lj5nLOyq9lahjmEGrdqwxiiLWbAMZJDusdFD1EuCOosi8TmaUO bWTHnQGZLyItGTONKQylBS12lDPW+ttUyRMtptfzey4g/tFiqEVzQ92vIsWYaVU2Zey8VEl60Vu w2aX7sNVD3x108H+BdB0YvLFHN9QxWoBAiprYRUDgnDciK7oCNP5BpyPJmrnmDpyAn8so54rJyL
 LC56BuT4kh1VXsCYuCv9uTS1Hacx4MKP/a6karZLsKHny3O2n+hkaKDPDEas5yp+i1sbHpKw
X-Proofpoint-GUID: xs3JnBXkJOJX6-epU9Z8uGSsWnHFRds8

On 14/05/2025 08:04, Daniel Wagner wrote:
> On Wed, May 14, 2025 at 08:55:13AM +0200, Lukas Bulwahn wrote:
>> From: Lukas Bulwahn<lukas.bulwahn@redhat.com>
>>
>> Commit 9bc1e897a821 ("blk-mq: remove unused queue mapping helpers") makes
>> the two config options, BLK_MQ_PCI and BLK_MQ_VIRTIO, have no remaining
>> effect.
>>
>> Remove the two obsolete config options.
> A quick grep revealed that there is at least a test config still in the
> tree which uses BLK_MQ_VIRTIO:
> 
> drivers/gpu/drm/ci/x86_64.config
> 108:CONFIG_BLK_MQ_VIRTIO=y
> 
> Not sure how this is supposed to be handled.

I got a feeling that this stuff (like kernel config files) should not be 
there ...

Reviewed-by: John Garry <john.g.garry@oracle.com>
