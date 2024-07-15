Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B528F0
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030104; cv=fail; b=lTYghKsZJER55FIY0ACB0cgW2XaxaVSGGtdgjK/x5miwXJz9bU01ExpYAGbQIaGP2/0NOgA0Jz9rybm4RAaoE0GwWK0mIb/zSpKQKqj0SEi5L+Sm+Z3y5qN9va1PTw+PFVH8C2+xM5sGIwMbkTPFi4FTQnt33LS90BZvJBe4MIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030104; c=relaxed/simple;
	bh=9DutEivfFaVzoH/x/8I98uRfIpP0rN4ilOMnzje+4to=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pG6sWE5BYeglM1raw+6gK7z3t5Xkhe/l6t9S88heH2Gync8ovSN0TA8RzjVC1NOaRBapmvKsmGQrUUvHJHZfwxKoAqRFuTKIdSeeyX2MPYLjcMxEncbvd5BZbv2Sp2o1GA0IFD3XnIRoV3xYwJK21Lcb8yeae7uS0KX7ru9LuqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CnXR3EMH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bL706Ww3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CnXR3EMH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bL706Ww3"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ENwT8X014686;
	Mon, 15 Jul 2024 07:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=E4OF3WkejGQGLWnD69DH031JRvrA1OoalEw1CyTEv7s=; b=
	CnXR3EMHF4K8kJZp84hpvqG8G6X7/OQgNXlTmSRNRxAbEG8vDAFzLkM3B9g6/TJ2
	FlETmpaJYePQjVPQaJsRQu4az+UeYGrh3eJ0S+SkZaSyizwAxWew5HeJefkLDicz
	XjPT3brrt4AluYgK0EYKeXt3PaNrHbILBmjFUDR1hRpFAwpnX1a/C/sFLqKEYyB7
	lPlKeZpAG7DrOaVWUFmag4DH2yR/6tBFGqA8B1dfq+hEnrgBw9q3GDNd+al92Pru
	E4JsYRUUOSw3mF5J3Nm7gn+8DB4GYQpmgLzpDb3s3NQhCHhfIFz5U6WcFUYNkSOV
	6aYU8pbJux1+pOStm+m4tg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhmcjb6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 07:54:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46F6xMQs035074;
	Mon, 15 Jul 2024 07:54:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg16cye6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 07:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzUAddQQ8P7czHKJXzv5Su7IazC4V3LRKI1Ow4yXYadv7lesUcXQeIzLDeCZiyLLRxXqyaRTfFRkwfLza8lqq9xVksMd98R8yDl7mOQLtBDkmSxzvRWEMV+gCR6OKc4dxvxfX4QEBzE3TK7p3bXACUGbSc2isJM1UO/oC2opGoJQseGLd4MeBxH0wYacjvAohnHgEkZSzCX0EWItEYtE42u+SWMUHpoM8L6IjWZRrIP6e7mh9blkNOudH/7fWW+DUmO/vEK+hD/l5IXgvlUaC4OfRV50NEFoDY1kH7xq0pbW69p5ECxuQmShsQ2do/8x7pnW8M6Z1b9BxlB+kxVB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4OF3WkejGQGLWnD69DH031JRvrA1OoalEw1CyTEv7s=;
 b=S4u0Gl4p1Jvte9BozCnmk8HpT04rOzhzg2DzIY5eDJZJ0pOPStQe+4+SwXdQpJdVxZUjDV54/96BKx80jROJxAn+nVmQYGb7cPFpDQ1FJY97WHi9MYHN3ZyBusauLrCZ3dWAO8hpdea2/z9fhbxCEZ2pGfat0cKlwTikr/wtZSDNC3XETnooHnJdXukeuRkf6w6ze2N3TBdZI6Zg/vp+M9Z7z3gkvEeATeHqcnda6SvP0HeX3RO+3gvkBRBc51z0vKW1O8iLUVedw87MuoE3ieZEx4AH69phmGFW6T+2nwjzc866dBUUbrTPh6gQQcQJwg30bpu/tciGKIsLFUgxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4OF3WkejGQGLWnD69DH031JRvrA1OoalEw1CyTEv7s=;
 b=bL706Ww3MKWELkvfmVQSodinTw22V7qP0ToPA3OfEAh2FBBmUoMicEHTNHKhz5axdCX+aBvLxetAJwdZsN68jSVbMb6zC6IgvS2E4PlvLD5AlE069+iKkwF8gPUnA/PWriikoAEW80l5WgsNcZb/QVWasH0oBRawW87xKGXU3HE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7069.namprd10.prod.outlook.com (2603:10b6:806:315::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 15 Jul
 2024 07:54:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:54:35 +0000
Message-ID: <5fca6dde-bbfd-4a25-8d1d-c1257540eac4@oracle.com>
Date: Mon, 15 Jul 2024 08:54:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] block: Catch possible entries missing from
 hctx_state_name[]
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-5-john.g.garry@oracle.com>
 <b97da63e-386d-4cb0-9bf1-cfbe00154979@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b97da63e-386d-4cb0-9bf1-cfbe00154979@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2e647a-de7f-47d7-25cb-08dca4a35e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGZlRjdyK1F3TUhRNUN2YUQzYTluMWdHcDFWVnpOeGFZZUdwZ3pyM1FlNzFu?=
 =?utf-8?B?MXZLZ2FnSVVOdkZXVmdsTW5qanA1RU1wclNoRDdERVNiSzh0VXhPOUtZSmFK?=
 =?utf-8?B?NlRFRzVmRUxwL2dSbTFrWW5qakkzWVV2N1p4T3BpZnUxNU1jbmdOOFhRNkJS?=
 =?utf-8?B?NExZMk5XcVp5czN2VG4vVHdxYzFybExqem90OUZPb0MwQXhSM3pTM1lCaVFs?=
 =?utf-8?B?K0IxQjdlU1JjOTNrczF3NFVDWVlXcnpYWllhZ2w2NXlTWmErYmx0TXpXelZN?=
 =?utf-8?B?M0hXNWREazZUbVFBWkhMdGpTaTEvMWlxVXA3Q1JsalZ5bHFUM1ErQ0t4czBJ?=
 =?utf-8?B?NGc4K2RpTnUzYU1kMy9xUHhuRm5yVU85cHJ1VjJzMHV2KzNZa25NWjFCcEQw?=
 =?utf-8?B?cUxwM09SYUVlYWI4U0FTTWdzZ0pCd1NrV3dldE9JVllVeGRwVnpUZ0NvNS92?=
 =?utf-8?B?RnFvM08vcWlpZEt1N1dPQVNYdjlTOWt6UTBIV1UyMHB3NlY2aUR4K0dnT3BK?=
 =?utf-8?B?aUJHdll2UWoyUlVRaVVLa2l3RDdncEZaMDdjL3NoSEFLMUZJZEhPU2dwMWI4?=
 =?utf-8?B?YWRkZVN3di9hNFY0VkcrUno5OEU5d3dGVExRUmJIMWRUbW5NMGVBd3owOXN2?=
 =?utf-8?B?alhRV1l5U2k3Z2xydjQvbjVCVE8raGFWYm9BbytpWTJadUVkYjBhUTZ0dFda?=
 =?utf-8?B?MkROejJJMHRiOFFRQXNiSS9Cb1YveHFTWGNsUGhvaGIyM0F2QmlHL3hzL2tN?=
 =?utf-8?B?b3lYdFF0cWRqMEVGUmRZS2MreXVsNkppQm9EMGNzR0Rpbi9IY3lGcEI2d253?=
 =?utf-8?B?WGxESHRiSCtaMjJSZU81bFVaa0EvOEdXY2lzNmN0L25MNXdPZ2hQQWM5Q0JS?=
 =?utf-8?B?Q3BjODhwMW9zRDRjWGl3dGZ2alBTb1JmaDBvc0Ficmtpa0hPZ24ybkFSQzQ5?=
 =?utf-8?B?ZURubVpNcFVHWkdzS0R2UUJXY3QzQ2pLL0NLYWZNeXVJM2dGZ2FTdXZBaURr?=
 =?utf-8?B?OUY0NkJSQ1hRbXA0alMvbFJVZnZQbzJYbjhTNlE1V0x2amthVVJLekhtS0p0?=
 =?utf-8?B?YUl3dUYrQlhyckhjUDgxRDUzQ1BaU0VmQWJocGp0dS9sc0pCSk5iWXRSenJU?=
 =?utf-8?B?MlFFdWNiYlVITHcxYjZWOUh5WUwraWVneTN1bHY4V1h1SFlVTmtkeSszUWJw?=
 =?utf-8?B?VkRqN2o4cFl5STRpeThYSnd3R1B2NmtHbkgydEtZOFFHN0lRd0hyaVlEMTNB?=
 =?utf-8?B?VmlOUnZPbUExQXU3UTFGQUhBZ3FqYVh6S3pFRndEMjI2Y0FCR1hBNnh3WDhL?=
 =?utf-8?B?NHZpb3lYM2dybVM5NW4zUGwxVkRlRFZ6VExZVkp3dHRNcXc3ZFFJODkwWUsz?=
 =?utf-8?B?aDdETUE0eVlxWVRvVi9iRGtBVGtKdEc4WE16U0I0QXMwWHR1WDlDRFFpeFZY?=
 =?utf-8?B?c0h0V2FOajR5WHJyNXhUalZaUElhUjRBS2x3OEQvTUJtNmdTMUlONGxOUS96?=
 =?utf-8?B?R2V3QTNzZ1RNdG13d0ZZb01qbjRpWTk0RXNzWERVZU9yK2dtbkNjRUFpWW85?=
 =?utf-8?B?SVV4cTQ3blY2L1lkZnBlaEVHZFFrYTR4MXpETkdUem9tbFhJMVorZnJsbkV1?=
 =?utf-8?B?Z1dRcHNSbHBqM1VXYW9IT252VUVJVWZ3WC9abXMvZ2hJV0hnV2FkRFJsdnU3?=
 =?utf-8?B?VVY1UmRDZkZFdTlMeE9lQ1VuNG9zTENSTExqOUtYNVZiMFdqaG5MRXlrcXVv?=
 =?utf-8?B?UXFFYzB0REhwNmJRVS8xMGpETEhSZWFUSlljemNWd2ZSL091WFVHRHlIRGVD?=
 =?utf-8?B?NFZIMFRZZXoxNkliUHQ2dz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1htdlZXUWJPQi9GUWMyckJNSCt3Y0xCQzVjcGc1VXlaekVENTBFR3J0Nm9Y?=
 =?utf-8?B?cDl3cnFhNktUVjEzR0tBWEVKL09WOFlTWUFBSW10L2t5YkovZnI2c0FHdm1D?=
 =?utf-8?B?bU1GNzBpUnFjWDUzN1NEQWt0MWQwcmlNeGZ5T2gzRERmNFhKSnRwckh6cDU4?=
 =?utf-8?B?S1RYTnBYMDl3eTRTaWlwUXlSZ3R2Ti9udEh1SkFpMlRZQ2tCaW1BSm1Uc1Za?=
 =?utf-8?B?VjNjbTJHY1ZkSWNqWmcya1VpTnlhY1RwbTlPRE0vL3FrL2F3enRZOFBZcFZZ?=
 =?utf-8?B?R3pDbjJXSXJ5RVJ5WE1zQU9rUzM3TlN2blh4OEQ1d3Q0M2d4bTVrUGRKOGZU?=
 =?utf-8?B?ODVjS0xicUxzakJ4VUptaGx6TVVVazlMQmJJMlppUmJFR1F2ZFJ5V0hZRVJ0?=
 =?utf-8?B?dzVSaHF3bGRJZS9PTEUxVUY3MUZoT09zT09PR1JoVXo2czQ4N000Nm1rZS9Q?=
 =?utf-8?B?ZWVyR2dJRmZMN0ZXRXdqcjRoZ29lbXp6MnpNc3A4MXR2VlIyTnQ5NnpnT0gz?=
 =?utf-8?B?YW5CQXlTNWR2WGVzWUlEbUNWcjRxKzBkNDJkNGx4b1pLNUFGTVZDR1VObDda?=
 =?utf-8?B?bDBzNVRjZmxSSUhSb1oxUVJGd0pUTUlJanBYVWZaZDJJaThaUkRHaHlmOTd5?=
 =?utf-8?B?M2pDdlJpcnRmaFh0Ukl2bFJXZXJ4STlLWkJxYWJTZHYrZVQ2QWtWWS9QZHQy?=
 =?utf-8?B?cEc4Z1lqVzQ3N3c1NkU0c01WK3RWcWsyRitBaklnSTdOcERYRHB4M2NRMjR1?=
 =?utf-8?B?WDZadUc0N3VhajV2U1ZYemtnVlRaOXpYUnpXMllsK3Zha0dhUWZFVW0xNnlD?=
 =?utf-8?B?Lzl4Q0N1ZHcvTWJDNjdGcEVGNEoxMmtyUWpJbWFVaUNBOG9TRG1peDl0NW4y?=
 =?utf-8?B?Y2lad0tteW83MW11d2YvaElPSVFwcTdWcndlcVpEUUs0MXdFRHgzdUE5eU9Y?=
 =?utf-8?B?Y1dQTXUyZkhtZUxyQkpubndybGRVbTJzUlpzc2doQjNmMEZVMDBMRlZRd3ht?=
 =?utf-8?B?aGJ4ejZqZHp5WUc2VDBHdW15NThHbjV6V2loeDFkVERwYUV5WjdwbGJSMGlJ?=
 =?utf-8?B?VFNGU0hYRGlTQ3RjQ1o0SHZSWTg4a0hVMW5ZSkRDcXlQb3hMRWpVN01neEdT?=
 =?utf-8?B?dms3Y1A1citHanRhM3dKcGRONmF3bGJld2NIUmtObXVTMldjczdjVVFGYy9i?=
 =?utf-8?B?ai9Dd29Cbi85R25tTDJhdWRnK3ZyaHZRam02RDhLOUJmWStJaFA1VE1uSUx1?=
 =?utf-8?B?bjJRQkdpNFk2czM0V0E0eXBVR2ZMbysxakFlMlBxY0NRUE9YMnYwUjg5blJo?=
 =?utf-8?B?YTFCK1V6UElCWmlFL1BNZDVQaS9KVFM5R3QvKzR6WmJ1eTEyUDJpWnhKeGpM?=
 =?utf-8?B?NDhhOUxpdkZ5OGJESFFpc0FiQWRIVFJlazNlNE9idU5wYTh0UjRLYW1Rejgv?=
 =?utf-8?B?Wk9Ya2N0N2IzRGlkRmM2Z0czelprTDBvTFhORS9EM3dCVHo2dEk2S0FFb2Js?=
 =?utf-8?B?aS9VdVBJeUZNMTlyQWFSaGNNTThockFUYTJjcW43RGtPdEtJQS9zN1hUYS9W?=
 =?utf-8?B?MEpvMCtWUDB2UXU1NEtYcVVhNFBPajdDWDZEV2xUR1BxWjlEMnR3YTlrZitN?=
 =?utf-8?B?dzZLWktwWW42TU5tRE91MnJsYUQzQmd2OGNDU2kwb2MwT2NsRzVoajVmVWwv?=
 =?utf-8?B?Qkp4TUtleDVHZlJqWVFnc1hvRlBVVTRqVjE0MGJBUlRVTSsvK2tUaC95cHRS?=
 =?utf-8?B?SDhBdHdjWjBuL2lGVC9vcEVsMFJVQzY2VUlhb3M0QnlIbWFCRVVMS0JGWUIr?=
 =?utf-8?B?dGNXUnhGZGEyRkNNejlxSkw4Uk5Ic0JyQmZXNTYyQzVYUFFRZ3pHaXNzbTUz?=
 =?utf-8?B?WHF0TllqTjd2TkJBOVNDWVQyVmZKNFcvTXZEQmY3K0xiVVZwME85ZDY2bE9R?=
 =?utf-8?B?Q2lsek9RbHB3b3IySlE5ZGU5Z1oyQitGWis3Tm5DRnlyR1FGKzFRR3FIZU5Z?=
 =?utf-8?B?ZkZ6Y1p6dC9EMHFBTXZma2pLRjBPMXBXcW9Ca3J6d1lQSHRSekRSNEg5Um5C?=
 =?utf-8?B?RHh2OE5EaFhxbGhTeVZzRGp0akhFTTlYb0RieE9jSlpGNzBtdkxSR1g3aU1I?=
 =?utf-8?Q?HQSXnIs0rJambyqd1tmTkxF8e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fypgL/RtAIehm0HTTvH1V8W9wUHIXLwvwFlhu0g0WPOW/g4GikZ4pXWJ/jZZB1YRVWoTveh4xcwzRhub8TsPsA+IQfPTPFbzla28MJ9eZnTgdJEUtwSV09OO9v6PhVR+XMiPTxcNkKMD2qM+BB5CfZUbsPgBykb/2pxQ5j2HF/hdgsguTHsMeJobgW5NYwFw2Vgs5JMqO07CblyizCRB61fd0tOD8tM2seEcRKDI8TWGgJ46x5MIcTgQA+ocE2tWszgnj1icFScrhzJgcPHnKaiIrXoH8uMPJbA/0DnEfkBrJIKCgkowHiKBNl+v7diopcEOB0/odCyNE7PcjXvWSJhxBP9tVCmRm0Tl32VS7zWEV2w9TjR6VUi04RpLlO9vesHkbwxNurVhXJA10cuLBbelUH/63OReWKL8otYi07dtTnUj+dbxAw0RrEIO+/mpW7p41nrrWs53HJfWzvuOCJT2g/nCH4gH7L9qyqj2aPTuftNBCOlzFhYc3ZvPvmvrFme6CxFWHvEeeo/TePfFkMOBjwZZFb2l8IBhJHVDD2n6c718EE6AwCdsqhL287yPVt2ZZoYe2YZ3xel5fR6K8I/ee0124XGTCIRG7EMIaCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2e647a-de7f-47d7-25cb-08dca4a35e66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 07:54:35.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BoW082P53iM2SQUKa1G9SatXbT6HPfpav9cH0BRKJhK+zvCqiGIKUC8YMjuwmVaNsOeRDjLl2tqQ/JaVIjdpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150062
X-Proofpoint-GUID: Xdg9Uze9DutkCq9zdUhbvqx93GLbExfK
X-Proofpoint-ORIG-GUID: Xdg9Uze9DutkCq9zdUhbvqx93GLbExfK

On 11/07/2024 19:08, Bart Van Assche wrote:
> On 7/11/24 1:23 AM, John Garry wrote:
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index 89ba6b16fe8b..225e51698470 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -664,12 +664,14 @@ enum {
>>       BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
>>       BLK_MQ_F_ALLOC_POLICY_BITS = 1,
>> +    /* Keep hctx_state_name[] in sync with the definitions below */
>>       BLK_MQ_S_STOPPED    = 0,
>>       BLK_MQ_S_TAG_ACTIVE    = 1,
>>       BLK_MQ_S_SCHED_RESTART    = 2,
>>       /* hw queue is inactive after all its CPUs become offline */
>>       BLK_MQ_S_INACTIVE    = 3,
>> +    BLK_MQ_S_MAX,
> 
> Please create a new "enum {" section for the BLK_MQ_S_ constants.
> That will make it more clear that these are unrelated to the other
> constants defined above and below the BLK_MQ_S_ constants.

ok, fine.

If we are going to start breaking up this misc enum, then where do 
BLK_MQ_MAX_DEPTH and BLK_MQ_CPU_WORK_BATCH really belong? I'd be more 
inclined to have a separate #define for each of them. I am not sure how 
they ever ended up in this same enum.

BTW, BLK_MQ_CPU_WORK_BATCH is only used in block/blk-mq.c, so I don't 
see why it is even in a public API.



