Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D435CDD0;
	Thu, 14 Mar 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403169; cv=fail; b=oJ3GDxiTdyIadrXtN2kytKtHWPVwfv7MKB3H6gDZDiUFVzVa+PLEDEVVEv79Sn6uFW+vNE/0ZN5Ymfk2qDOeBCXUyjbtQ13KViamnVEkN3ZN+8upUYXLeHeYG8/VjYUjBrIxSPiFLceKTQpmIBvmGYcuDpLZIgmaNGfqXqpLo1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403169; c=relaxed/simple;
	bh=lcJyxJ0j0aZkJOpVcUzCaDOZELRbwVJ1V2vCCCJl0K8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BE1Me20HRA4kRgb3r9iPNaBBAb2oRlVFIRfNG9NdQ2PYU6DjZ6IibP5U6zANXJY8e/YNNwHLn9ssfRcBjdCAKe8UPEV31601gM8O/4oKJxIbuTqrP8bNGrBp2RrdcfyxuteeKGJqalKM1ZRHUNgzyt5iKrBSArmw66c3RzTwye8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N3yA9KbG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IbsuDwBP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3yA9KbG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IbsuDwBP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7mqR4011544;
	Thu, 14 Mar 2024 07:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XqNPNg/tbOY85lpeRSB8z+V6muy32f7mWZQOj/4/4Co=;
 b=N3yA9KbGutXBe9gJ5O/xsm5zrlz9DDxA5dfzjOmXWm3QV0A4o3zdgt5utx11cqAC8FM+
 TmJRGCXBd1102na2kzysFmE0nHLOZhcOk1UvrP1J1SeMtT6RIA3ffWRLcbKzD8M//WH/
 8E4cFSMJveD3TwJCkwM03gXaLD7QV4wicleRH9+yDkrNTn8iqCNdrqevRj3sMdgYW/mc
 rtsl9CLqpYQlCU/h52rfsT1GoEe/ZOBundCcIWYTFeW5+aef5Zx/WBN68X1s+bCYAd8q
 KMcfLA6CFAqubOI4Y4ZvvZFC3OUpZOO+kdHjVEUH3vGmuTfp7aCx4fXqFK9Q6vFg8+/T cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcujy6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 07:59:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7FJPO009104;
	Thu, 14 Mar 2024 07:58:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7g85ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 07:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv3Z63Ffx2VeUNk0jgaRrcgkVqKtBv2veA4Fx2g4FXJaTH1j8Zpd//7Dnn2gYhyWpxlMdLxdB86sLYmgN0hSueNglNNfX4qwi+doqhw7Jm+iDUxGdyMFNGXLsNgsmz2MKsIqtgn/LdXey8d9fpUX3jV1qTuWrqrEGcM9cfSqeVchNc3knQHyUCqekG4EXzAopickSVKaHW6Ys89WVLkPH/N7SaWeoOO1QM8K5nPO7sZbBuVC79MDmN1Y/4kxrhGyfkdLotcN6nweaGW6OiPRYrRSOh2Gpi6Zxa75byAJnXV9e/RDtpr5RMulxaast54sigaubjswpYU7CQNPmCBreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqNPNg/tbOY85lpeRSB8z+V6muy32f7mWZQOj/4/4Co=;
 b=IwxpwMntrNekCSpH6BoPJeOAuPIKQdCp9NWtc3MFg1ci1HN0PUdWacirc0eOrQdY/xLoymEGM/K/NFhVFfGrlhTorsYMz9RNbEP9UvMBBImrRojxIbz0NYSvauG6klqtqDx650cZKa9EZOqLd5q9rpfc0xNkpclbWY3a5XUb+7QqYjNi0nJqscTgR9vjb7WgmPB/Uge2fLYHDxtEJ5csWLETD7EBDlxfOy4SiuyiINfnVcK9ff++ZoUopwHuk16Uu608r63awd2Y2jE1+fKKCSLfMG/t5RxcHkUu/MELd3WeBCRA0fpnHUIHMTUcAim7BUdt7y0eZo3eNjjR5W/xFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqNPNg/tbOY85lpeRSB8z+V6muy32f7mWZQOj/4/4Co=;
 b=IbsuDwBPmzVejNGDdhgUlXpe4FEwAnIAEIY8oJhfCS3D3O/ONVs3hTLexQ5Y3Y7ovaAKn+rtRS5//z2HnawEjoqIFcmWn3GrqxCjtktoPZaJGpKj0kszIHyR4RQBEHuepRiatRPrkBZ58YvB5YF+kjU2dFapiYUqUuuuQd2lW8E=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 07:58:46 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 07:58:46 +0000
Message-ID: <0197fbc8-41ac-4b85-a523-5e5bbe02f3ca@oracle.com>
Date: Thu, 14 Mar 2024 13:28:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block/mq-deadline: use correct way to throttling
 write requests"
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        Zhiguo Niu <Zhiguo.Niu@unisoc.com>
References: <20240313214218.1736147-1-bvanassche@acm.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240313214218.1736147-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: de6ba68b-d8c4-4780-9662-08dc43fc9381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dXatfrntZFuyz/SMdkL7LI+Q0Ciooltuvhg9SBembFbHITMpUUSFWs6ttTIMJkcENchypjg2gQKDOHgIhQ7UQ8sbE8c9Mubrabf5n260KleSR1KdlD2tMlLKqoYJe4CioTfKdl0JbCWmsYikT5CV/p97QAv3kp3vOSrU6ts3VuAbyPlbpJxFiQDyAol+wtS0ByuEZYoSEm+7c6eiNv3YQoEuc6ofABgAiaEiA2bQamHy+AwbDPIZ56mJs1HC46j4rj3C7yJrjw+pi+jdKX95pgNJ0jT9yuZByKC4IQH37NY/lhRel2eCL9owcZf9BoC3CEfOwa35OfQX5uTVS9yHJWDxmI3gKAbbQKJxTkxxuxrZnobJ4yvBGG09QN+1oqC9bIUowd7rsHzByOu5rNbZye7xAp6bWD7vlatJCDO4fmQv8uaerRRv/pfXldEtvK4NDHTkk6iNtW/7QNMD9K2AnGd1Ia95V1yg1lvfBw/HO4x2ttgQSGxJE2cv8MiZBHw8M0YpxfaywjDNZSttF/ERv7eKdfry0T6mYBdbgIT9MmGyuBqV4yjGSLsv4d2maueZGagcuaz+T6icodTcmygA6IAvSE5wrM41umO5eRdX06A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlR2QU1OQi85Vis0VE9LLyswRUhuSWx1eUdBUVhFN0EzR1BXYkZ1NFRwaW9S?=
 =?utf-8?B?cW42ZEpoSWNpdDFpRU15TlNHRkduWWxVMXJFcnFHeHdrZkF3M1NxL3psNGdk?=
 =?utf-8?B?V2RJOVBYUHNVTnA3ZG0xem03MWxtYllWNmVlb3h2Zzc5M2ErYWJUUE9yUHNm?=
 =?utf-8?B?dlkwSU9tZmhhYzFsWnFTQUM5Yi81SmdFLzl3S2YvMHViaStKOW1ZUTJ0RHh6?=
 =?utf-8?B?eUJwTmJST2dQVGc4eHNjbFBDOFgvcTB6dWhrZml4U1EzWFNURVIxVmRkeWph?=
 =?utf-8?B?MnN3cmM4SUNIbkdpYlIyOGt6MDJWRVNwYTF1ck9hb3lDRW9ZYThwTWhWQm9G?=
 =?utf-8?B?d0I1aW90ajlDTmx4d2d6VjVTU25RWGlRZlVwQTlXM1ovWFJxOGhTUWMvR3I2?=
 =?utf-8?B?U3JwdVVsTWR3TXBWT29zeVBKallGV1NCWXdlSkYwd2U4dlk0WW9BeXg1T2lq?=
 =?utf-8?B?RVRxekE2Z2ZCVXh1WlJsa2t4OTZkT2g2dnk5OElTR1l4TW9Kc0dNTi91d2o3?=
 =?utf-8?B?clF5dDdkMEVibUhqSXllemdZcVNvZjNXNXhWVGZmR0NURGgwVVhjb0xPanc3?=
 =?utf-8?B?WThmT0M4YWFhWlNtTmFlS1V0SlkydEJuYXRTM1pibGxvZC9sRWZodFMxUDd3?=
 =?utf-8?B?MnFKWkx6a1Zkd1dxOG1kZnhiSFJXNTJIeG9xZmhxRk1ySFJGNTArNmVpTmg3?=
 =?utf-8?B?ZHk1VDJCZnluckY0K0xoTEFHNHFnbG9IN1J3TE5va3Y2a3o2alJYMTRPWEVO?=
 =?utf-8?B?Z05OdHBUeEJvYVE0bjhHcldKVEFKampOaW1OV0VrbEt5NFhiSzVjdlF6UmxT?=
 =?utf-8?B?RUlCN0VGaEx5TDFrTlN3OU52Q3RrM28rRFdocWxQdjEvOURBbVdEV3V3MmZS?=
 =?utf-8?B?TEdyU0x5eElIM2xZSTY1Wnp5T3pYeVVsMnh1cnFWT1MrR3NpQVhBZWdSMkdm?=
 =?utf-8?B?RW9KY1NuWldkM1k2enMrdzRhUjZMK3BIc05Fc3VzVFFYOWdqZk9kVDZQeTFH?=
 =?utf-8?B?dXB5RlpnbkJERXFrSHpyeWsvK2FoSm9nOElMYjUzYkptWnI0OC9VNlRIVjAv?=
 =?utf-8?B?V1ppbzFYMEp3Wnc4M0h0Ui9qeEx5dFdMRHYvWDF3Q1pUTFd4ckxaK2lyaWZH?=
 =?utf-8?B?akxiTFFUNE5hTWVZTFpYV3Z6a1hCc0N2TGNWSEI1c283WUh1S1JHY09QNmtT?=
 =?utf-8?B?UDFnVnY2U1QrclEwaUJrUWhZd3BpYmpoZlJIVnB4Uzlib25sdy8xN0lYY1U2?=
 =?utf-8?B?dmZZK2NhWDRhWjlWOUZCaWdEWTkrN0dkUXFRSGh1OWRScTQ4K0lRRGVaM09J?=
 =?utf-8?B?aWdVaUswM0ZlSkV6U2l5VWU1NlVNYTB3ejFzU0ZLSnIzaE9OUVdDK2psMDBG?=
 =?utf-8?B?QTE4bjEyb05GUXkzaUFDbzlDRVZDOXFsWTBUdWRuMjEzRnVodWZUaWlIR1Yx?=
 =?utf-8?B?MEQ1MUIyVGhVbk9zdnNQZnZNU1JBR0xXOGk1VlNBVTh6dWxSNG9NNWhiNWk4?=
 =?utf-8?B?c1krZnhjRlduaFhIUkhaRStPV1BsVWE3UnMvK2xDYXoyN2xhY0VRRE1RbVh4?=
 =?utf-8?B?U21hS2JjSk1aek5XVStWWldCV2tnckxIOFlabDl0WkFNalkzRHFBRmxXT0dG?=
 =?utf-8?B?SnZXYVJuZzJkNjdWaXZPRDVlZkd2N3FETjNIWE0veW9zYU00S2FsVG1pdnFS?=
 =?utf-8?B?M0VqRlliUTgxM24rRDU4ZnVMRE9SeVZuUDJ1eWNtaGdYZ21NOVBaWTdIeTht?=
 =?utf-8?B?c1paL2pzWkpYT1pUZDBiWWhSMjJ6SmZtOHJvY3JsdCt5RFlCc3JMM0ZvcXFn?=
 =?utf-8?B?a1Q3OW1lNUxsRTZhVEZocXR6Y1E0dGhUZEJqQUhocURtQ2owdzVwWDZQNXJY?=
 =?utf-8?B?aGxMZFdJZ0g1OEhLRllMd2tDaGltR1lYUGdWejV2TzNhK0dvWDI2bXRZSmhs?=
 =?utf-8?B?NTN5dmdvelJjTFpFWXdmQXBEOVY4U2tGYXNMOXpnNlR1dU01TWNYcy9sR0xT?=
 =?utf-8?B?YXVwK3hwSTVIL2ZrdmxKRUlIT1UzVm1BQ3owL2JCblBObDBsNEhubEhwbUo1?=
 =?utf-8?B?elR4SllPeUZ1M2dBaVlwR2xhUnp2QTFaMTVUOXZjNStYSUVRQkNLOVpiZ2hk?=
 =?utf-8?B?eUNtRnZHdVd4ZnFPMU94NzZnWGM4Zm5ST1d1Nzh2UDdaMjJORW0reXZJQjMv?=
 =?utf-8?Q?L6bTaoa7w4bSfdsX4sR0bek=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xUkrbfV+B3eSjZGCHV80x1EQOfOC7l0vBNKOvMK0fYgjaYjzdZtgjxTmjfuoTDtAPjFREcWOv9SequDb7ICZb+dAq0UvsEB3fxQsN6DYzuT+s+xXNI2eVnQlJ3LryVZOqIdAEqlBzabWznfMuZ43UmxoTmZrzHsPcMSZBQpQ9E78GTZf4CP2X+Ot85yLqNeU7d5vLATH2ZzLD2fPwKAGGdmTUDbO1Q0o7o3CxOygtL6n59RhNd9Qo2alLeP3UlxwFe46lLi4PhHViLaAvqQCDg5h8Ua+tRYgSOZ8k1K32IKtymAyUN/qnJd/pYNhIBePelrGnzeam3tqE2yqUlPY+sW4lrOmA3s78sJvGeUm87IsELhXrQbdL+Z2Qak8MMMsmdg+U5P605m4f4V/stTj2lqWb9L1eSAKJ7uY+1rlwraEuACDnGqzw/MgXXEt+cO4kkyifigGfiLOnaCp4lNHUOsYnSBmFyXiFUiE2CLqBcZ4r3Hq8IRtdRGrgdcDlFgOGiTAKSO/O0GM/INdC6PTWXUZBNnpLppdQt2LNUINjpKnzf4uQLElgFCa03t3yQl1tQ/7sHC8IXv0JJKvQzhmhaDMAcA0JyRU7pLeVMXNgvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6ba68b-d8c4-4780-9662-08dc43fc9381
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 07:58:46.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LEErGF+IDmJrLkABNntO5g/fJUGyuf/wl7+fRvsOfknYF5OINpEaX6NWFV8RibWjtJcRo1HnIr6g2/4thV0d1ZvbfCFKVcNSWpMk9RDuKAWIzNgEbN6oRy6sKsYU1zx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_05,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140053
X-Proofpoint-ORIG-GUID: eSDSYFUjoF-T3UE8TlB8CD3Tqpmsyt2G
X-Proofpoint-GUID: eSDSYFUjoF-T3UE8TlB8CD3Tqpmsyt2G

Hi Bart, Jens and Zhiguo,

On 14/03/24 03:12, Bart Van Assche wrote:
> The code "max(1U, 3 * (1U << shift)  / 4)" comes from the Kyber I/O
> scheduler. The Kyber I/O scheduler maintains one internal queue per hwq
> and hence derives its async_depth from the number of hwq tags. Using
> this approach for the mq-deadline scheduler is wrong since the
> mq-deadline scheduler maintains one internal queue for all hwqs
> combined. Hence this revert.
> 

Thanks a lot for helping with this performance regression[1].


Regards,
Harshit

[1] 
https://lore.kernel.org/all/5ce2ae5d-61e2-4ede-ad55-551112602401@oracle.com/

> Cc: stable@vger.kernel.org
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Cc: Zhiguo Niu <Zhiguo.Niu@unisoc.com>
> Fixes: d47f9717e5cf ("block/mq-deadline: use correct way to throttling write requests")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f958e79277b8..02a916ba62ee 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -646,9 +646,8 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
>   	struct request_queue *q = hctx->queue;
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	struct blk_mq_tags *tags = hctx->sched_tags;
> -	unsigned int shift = tags->bitmap_tags.sb.shift;
>   
> -	dd->async_depth = max(1U, 3 * (1U << shift)  / 4);
> +	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
>   
>   	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
>   }

