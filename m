Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E671CA95
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178569; cv=fail; b=EBZYchsxjs+oA9Qkv3P05IGdv9s+OEIU9yv4XShL+SLfqNTAw26xNORubtLcsjjg/uE+G1uPuCtVq34HIggWtaEg/yxKCm7Co0AM2mTnM6k1HDIjov72UYJH+o4llEhDc5pwqoSIlQs8U31VxAJ+STDYM6rKWfABUeQoPFwTHc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178569; c=relaxed/simple;
	bh=sIRPscUD95AHuC1TQVgHrNbqAyhx/K2fWcigS3St0WQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hMj0cK9nRPbOP114HqzcYkFfWoukJzKLKL3DBg/b3ch4A0//RXbTx8fvR0z3H+UQcXZ+mJx18la73JeR36YmVGg5UU52oKWTrmIWADuwey6MxG6KVwhgbL6raiQt7XfdLDCJE382BENFi3Z74BTjnaXxEFxT3lmnI4KqXgOhsgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yu77yVFP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xlt9/8iU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yu77yVFP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xlt9/8iU"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9xbbq011467;
	Thu, 25 Jan 2024 10:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=n+W0KPaoXr53i7jXBa+TJcwntC8C9GPNc5KQ148Kiho=;
 b=Yu77yVFPJ6xKBGamcQtlkzE70mrmM9+2Fx05aSg3k3q6DWGc1f7WV2ENYj8A8ijorl4q
 /4l95YyuFCj9Pcye4qtfT11SMkuY7yXhJ4AN8lfMCwaowPj4Tp8zOFo4x4zDfbQc68iE
 6Ckb+z8aUH2fyCqqnYeQH+V69g15XsxUHJRlknhsmtma6FD2co9K1f2XGYq42U7663Ye
 ZV7Hay9rwT8MmNOLG4hBxRhbdx0DCVyP6j8SFBtkZHCBk36K4WKbL1lmEaAgnpr/hs7Z
 rbKYgaIWuKmQKN00WHQk9pmWeiVijhAXfGSo21At8cf9fU+afYox5cwD1HuV42BCj1w5 xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuxsbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 10:28:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PA6ip7004059;
	Thu, 25 Jan 2024 10:28:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32u6hj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 10:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKiLbU/ksM+vm5/uAf30ImXedBoMEL7NLDXHbRReA3FhJixBDIQLeJNLpImbvYgk+sfJL3Ohr9e6rQE/wsyLzWlnTSpO3cIzOuAe/LHwJ14IAw5QOlQo25K2vLZTeHMGSGk3fBP4Xb0Mh7j30S9BPt3desgbEh2dSkwpOWItY1GlC2TO8B8UEsxAPVcMu6Gm4ThBSaVpxt2SNXTlWwczc03v87SHLFJZvkiO++yFsYnQ5/25DHbiE2aPFX93YWLGyYxED21Q5c9IeLD5/taKre0c3v1Cixekm/B0nq54fdYyzWWCW+2AzxzB/kZP6Biwt8caduOU4M9WaKOJMxo9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+W0KPaoXr53i7jXBa+TJcwntC8C9GPNc5KQ148Kiho=;
 b=RyZxK9OjTsMnI8q/3G6VeC3r7Q80w26ptIkgqoRg12PRkQqZ5zZ+Kq9LncTwQXVz/Qm+9rpu3pyn+JdPIe7lcEQUcN688kbxjm3PyMNAopGuf6SK4tk4P4qNJ0YkdlgMIpBtPEVJOmPH1u4pkG19rMSX0tvx1yx6+L98Ny8tBu5uG27b97QtTxxcDTJFC0ApnyL+YcuZmV/hoJwiI0LOntepmIN8TdcPgUG4uc0v41g6CK1Gs5wPvaBLHDIlPoNYUVXsyeda2ke2dFgj/+QSo110sKXihoa5F89YiW5Jdg2uKmGfZdSA6tGnwmpV9NNaF4a5rsWZgbeOspFbPdMbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+W0KPaoXr53i7jXBa+TJcwntC8C9GPNc5KQ148Kiho=;
 b=xlt9/8iUZSVJEtXMnMzgUSTKR987cOxaj6ozCM+1OwTti2DLPlkOiu69fcEStLz9mJVepaI8cskJ0yPqfV8b6wozup2HalKPvwWYVmrD0NAL7wCy5irUHOKM0qwW2ltmOx6mDLmWnuatEmY4TnNLwCHYuMR41v41p9U+uDiEe6c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6484.namprd10.prod.outlook.com (2603:10b6:510:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 10:28:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 10:28:54 +0000
Message-ID: <79eb5c4c-d9c0-4a70-94ac-04892bbf8085@oracle.com>
Date: Thu, 25 Jan 2024 10:28:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-4-hch@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240122173645.1686078-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cfe902-b9c8-4e96-67a2-08dc1d906df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UNgMSPYZc7O7JvdUcfzJblgtftq1CdWoW4V1L0tWPC75QXu+bM6KzRN17qMUvNdrz1qKzRNKsh+FAWy0/1Buhgwn675eUgefqM1cszs8nruKdHFQCKIl2Ydj7nLWzYII1tUuiSALdo8iXfwdeeEa66e5SEZSCX8Ag7KuytenF+/+/By0wNh6mWCz6b6hro+yGH78B4VPnHkLAIBQ3QhfD81zhA8l7QemHVj+QruInDNuWsoGnL0Z3oBEcCNGJ5DLZe6Cs8s7NRWVE8WyCsWhLEFTgGvBsrMwI+7D3Dutjua3M7RlCAbA2JM9+iOeOTF5Af86rWC7ins+AlYvmF/VX4+n+V7T+lfSE8xlYmWW32PgzGxchdHA+kWLpgmAo3GtavXrbBBLGAAf7pRYKOIS/53vVV+9zE27dzOruR3m2iikocAK7+MZwlMR486kC7vlZi3CiPf25qIpXRfe8nvQKt6pqdNkg/moDT8/0N3khSAgl3pVS1bQOLmnjtPRJ4f5rygtdpELecwM/gNSrmcz48vmdgolBfwEZmFzvKJczufj3vIQlAgHIYSix5asCZ4+iW1/axomU5q9wopy0WM2Dzxv3/IrFOJFv6rkBYOssSCS+bDkQMUKor92V4QzZIw/zjAnIkGhDJ45iqyy738I3g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(110136005)(5660300002)(54906003)(2906002)(15650500001)(7416002)(66476007)(8936002)(4326008)(66556008)(316002)(66946007)(41300700001)(8676002)(478600001)(31696002)(38100700002)(36756003)(86362001)(83380400001)(26005)(6666004)(2616005)(6512007)(6486002)(36916002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVJOajhNVS85a1VhaUh3NzE4aW1Bck1qT0w2MkozdWY5c1VPcHA3TWYvT3Zn?=
 =?utf-8?B?ZHZWWjhmU0dOY1NuTmxOTGpLeStoTEsrd0ZJYzRMWEdSTDg4bzU3eGd3NzVO?=
 =?utf-8?B?NENrWC8zbHVYOENxUmxoZFd4Q3hXOWFac09UYVh0dFZzOTlDS1BicmVycDRQ?=
 =?utf-8?B?NHVvb2N3WnkyY2UwRlkwVnpmakR3MHl1QUFqakpmUHJBUkoweWVhWXVmL3dE?=
 =?utf-8?B?WUttbE5DUnpMMm04bkozWkRZRldwT2ljRXVRWU8xaEQzQ3ZSYmJxNjZFMTBW?=
 =?utf-8?B?cWdxWHhFRzBndkw4ZWhKRDR1cDBVR0d2cUpxM2NaYTF5ejFDQTdsOG5RM0xD?=
 =?utf-8?B?NjN1eUJkRlBacy9tTHYwNy91bXJxUk00Y2ZMckpRY3R5emlUNkRLN2ZQa2Mv?=
 =?utf-8?B?TXVMUE1INUYra2RQT3ovdGpzdko4WXFkenc2aDg2WUdZbEJ6bUJXaEdCVksv?=
 =?utf-8?B?UUpwbTRKNU0zd01leE54WGlGR0x6bHF2NHV3V1RBYXhESjI1MjA4YXBKOFhs?=
 =?utf-8?B?T0g4eTlEOFZESUthTGNleHFnUm5xV2poV3ZDUVRMb1UxZDVhYXNBbTNMSzBt?=
 =?utf-8?B?dkFBQTA5NEcremVmVG4yQmZoK2dINXFTNmNYVkV2RmFuM3RlL2VuSHVDT2Ux?=
 =?utf-8?B?alJOcFgwNWlWOEZZUUlYRWFJbndEWFpSUzh4K2x1ODNTTG5ZSFIwbWVCWWkx?=
 =?utf-8?B?T1BJOTdTVWZ0MlJrMkhaU2ZiVGlTVWswai9OY21sRXlKV0NQbTgrWGUxcHlv?=
 =?utf-8?B?cVFxSUs2bzBHZUJZSGRsZlhRUE0zMlI4aXY0K1FNUjVYS0VrOVJ2RUtVeVlx?=
 =?utf-8?B?aGpMVVRlNitZMzJLTkNyRmFLWWkrc0lPQjJJUDVrMHM1QXNCNFE4d24wcjQ2?=
 =?utf-8?B?VzlpR0cxN2ppT1JtL25ORTE4em1JTEJ4cmUrQnA3TkxwT3BFYXRWWFJNeVBL?=
 =?utf-8?B?NDhYUlZxT05lK1d6M01SNHFaZUk1SzVDalE5MmR4UFpMeXRnb2t2RXBtenRj?=
 =?utf-8?B?VW1YNXlSSlNOTUFmQSs1TW9NVFNLd3M2YmsxcGNMNGZlRWRqR0RhaFFEclFN?=
 =?utf-8?B?MnJDUWswNVpXdmZqbHJEd1ZyZzVKYmdtdXJTK3VQeXVFWGNZby9vRUsxdVN1?=
 =?utf-8?B?ck9pTmR6dGVmRU9LR2k5TjlkeG9MSFpLSGZCQXBxa2JGbFVUcTVSRDAva0Rp?=
 =?utf-8?B?dk5TTTB2blJ3eE9VY0JJbnhSalZjdk91aEV2SVN4Q21nc3hyOUR3MzFjdEYx?=
 =?utf-8?B?K3o2UWI4YnpHdEJiOVVJMnl6ZmRnRFRtNnY3Y3R3SkFDNU16U2JlM2ZCNzE3?=
 =?utf-8?B?czUrNW9DajJuZkw4aXJoVXBUS1ZhQ0E3REx1aTdpMHE0RUkwTTlQeWRGNWtU?=
 =?utf-8?B?L0d0NTlQenpKMlZNWlJBdHFiK2E4bUEwUzRhQ05sNnUxNXBUZkY0MEZ5MVow?=
 =?utf-8?B?bVZybUJrdWZZeHhzblFqT2xlOTNGRk92YXpsSVh4K0ZrMDZOZnBESjJaRnB5?=
 =?utf-8?B?TDVtS2dkU3BVQnpqMkZtdHFjVE5aY2NMNmMxUmtJTDgvb3VjdXVST1lXN1pn?=
 =?utf-8?B?SklIOUJ3c2RLdTVxTVk1N0lEcWtyK1Z0WEZmUUJyVG5lVmM1TEZyRVBVci9M?=
 =?utf-8?B?QVloNi9iOEJWUWdzdXZjNEZITXJNdER5WDBIakdYeWx1bkkxbklUTUwvM3M5?=
 =?utf-8?B?a1JDMUZnczk1OEQySStjd05NRTVzUjZteWNzT2M3c2cwQjBkOWtEQWlrY3Vs?=
 =?utf-8?B?a0JlYzEwNVRaa2FyazcvSnYvbHZ5NGFHcUkyOCtFNUJvZjZyK3pmKytueE5s?=
 =?utf-8?B?ZkNQTW8xVmtXUm9RcmlHdm9rYmxCZFZNUmV3eGo0MS81NVdCR2QyVUwySGtO?=
 =?utf-8?B?M2dvRzBvREI1ZXZCK2NGRER1eVNFYXI0SlNyVWRhOGYwT1I3MEFvRnFUSG8x?=
 =?utf-8?B?b1JwSmRJaVdIUnlnbEROREdFaXQ0YkEwVnE1enc0cWJjVVNvdGFNRFIvcmNy?=
 =?utf-8?B?Z2NrTFE0RHJuT2trbVFPY0tLbmsySFJrTy83eTB2M3BlcVVEa3RxclQzSGhR?=
 =?utf-8?B?MmVPTi9SYWlwTmdMdkllWkkrcGlYSGo0ZWU3c01mdzBTRk5BSU9rYlcyWDVY?=
 =?utf-8?B?WWRtM0Y0emNPK3BoYnlyUEhSQXJqN2daUTFUSHJyZkx1NXJYQ2t6ME5zSS81?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Tk7A2Mzs9Z2OmyDpQqlkKAWPsxXN99+zWcvWlQGRn02dDsG7QohtG+M2DRN+7eyybXmDc3qvgMg1hVl5DZvMCZRkaLi0vRO5QhdMl75nP0bGkzv+IGGDbTKoQSrowPdpSPNWXHoO40IF+vkM8iWywApzyaLoIGUbo9lMSxIsl1fjjkoezhKLl+BY0Lzq2bUJ720J0ZnchKzVpWOZNQxsjV6BHPltD/e62KXMRN4GIblzZRqv0uVunhiN9j2azsAqxPMj/1B1u4YEIeGrpoGaod4kTbpB5zO3qzkrf5y3rjoYNq/pRZ5gUj6jywkuEEDBTdrNgIN7BZsOCs/Jn9XkWVg37STekETkPE8u1bNi3DctC8wi4MVTI0rMMV7X2OhS5holIpkLsYGl4Vs3WgFfAgaFIpIa50cZEYs3P9/hZLkvm9YZbY2lfNQkBFAbyJ79E2BUoCyk89nr2PK+NA2+7URoFKwykSYsbWEdRzCrdwDPRPSpQ1fUwlEKSLZHafK77BT1RULlRmGUWYQOWJdhQ1ag6i5+Iwn9eDGstsN/wdcyjYK/cv/7G8AgvLiaa8VLrQynYgAJ3UYsXm61IrLoUAgCiq4BItltSmCiGmc/iQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cfe902-b9c8-4e96-67a2-08dc1d906df9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 10:28:53.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/NYnvONFIccy6OLq06oQXtPYIFB6XXyv0Fmkixl7BjOzbjpqoV5tUzIlYI9RjAmax12N8VC52KDUojtBN2jmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250072
X-Proofpoint-ORIG-GUID: 2d3wdAaij2l_oMcwlf3jxd-vpvPFUY4s
X-Proofpoint-GUID: 2d3wdAaij2l_oMcwlf3jxd-vpvPFUY4s


> +
> +int blk_validate_limits(struct queue_limits *lim)
> +{
> +	unsigned int max_hw_sectors;
> +
> +	if (!lim->logical_block_size)
> +		lim->logical_block_size = SECTOR_SIZE;

nit: This function is doing a bit more than validating, as the function 
name suggests

> +
> +	if (!lim->physical_block_size)
> +		lim->physical_block_size = SECTOR_SIZE;
> +	if (lim->physical_block_size < lim->logical_block_size)
> +		lim->physical_block_size = lim->physical_block_size;
> +
> +	if (!lim->io_min)
> +		lim->io_min = SECTOR_SIZE;
> +	if (lim->io_min < lim->physical_block_size)
> +		lim->io_min = lim->physical_block_size;
> +
> +	if (!lim->max_hw_sectors)
> +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))
> +		return -EINVAL;

The WARN_ON_ONCE usage is odd, as it will only ever WARN once for a 
specific q, while other queues associated with other drivers may have 
the same limit issue. But I suppose if one issue is fixed, then the 
other will make itself known...

> +
> +	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
> +			lim->logical_block_size >> SECTOR_SHIFT);
> +
> +	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
> +				lim->max_dev_sectors);
> +	if (lim->max_user_sectors) {
> +		if (lim->max_user_sectors > max_hw_sectors ||
> +		    lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> +			return -EINVAL;
> +		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
> +	} else {
> +		lim->max_sectors = min(max_hw_sectors, BLK_DEF_MAX_SECTORS_CAP);
> +	}
> +
>
> +/**
> + * queue_limits_commit_update - commit an atomic update of queue limits
> + * @q:		queue to update
> + * @lim:	limits to apply
> + *
> + * Apply the limits in @lim that were obtained from queue_limits_start_update()
> + * and updated by the caller to @q.
> + *
> + * Returns 0 if successful, else a negative error code.
> + */
> +int queue_limits_commit_update(struct request_queue *q,
> +		struct queue_limits *lim)
> +	__releases(q->limits_lock)
> +{
> +	int error = blk_validate_limits(lim);
> +
> +	if (!error) {
> +		q->limits = *lim;

this is duplicating what blk_alloc_queue() does

> +		if (q->disk)
> +			blk_apply_bdi_limits(q->disk->bdi, lim);
> +	}
> +	mutex_unlock(&q->limits_lock);
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(queue_limits_commit_update);
> +
>   /**
>    * blk_queue_bounce_limit - set bounce buffer limit for queue
>    * @q: the request queue for the device
> diff --git a/block/blk.h b/block/blk.h
> index 1ef920f72e0f87..58b5dbac2a487d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -447,6 +447,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>   		unpin_user_page(page);
>   }
>   
> +int blk_validate_limits(struct queue_limits *lim);
>   struct request_queue *blk_alloc_queue(int node_id);
>   
>   int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4a2e82c7971c86..5b5d3b238de1e7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -473,6 +473,7 @@ struct request_queue {
>   
>   	struct mutex		sysfs_lock;
>   	struct mutex		sysfs_dir_lock;
> +	struct mutex		limits_lock;
>   
>   	/*
>   	 * for reusing dead hctx instance in case of updating
> @@ -861,6 +862,28 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
>   	return chunk_sectors - (offset & (chunk_sectors - 1));
>   }
>   
> +/**
> + * queue_limits_start_update - start an atomic update of queue limits
> + * @q:		queue to update
> + *
> + * This functions starts an atomic update of the queue limits.  It takes a lock
> + * to prevent other updates and returns a snapshot of the current limits that
> + * the caller can modify.  The caller must call queue_limits_commit_update()
> + * to finish the update.
> + *
> + * Context: process context.  The caller must have frozen the queue or ensured
> + * that there is outstanding I/O by other means.
> + */
> +static inline struct queue_limits
> +queue_limits_start_update(struct request_queue *q)
> +	__acquires(q->limits_lock)
> +{
> +	mutex_lock(&q->limits_lock);
> +	return q->limits;
> +}
> +int queue_limits_commit_update(struct request_queue *q,
> +		struct queue_limits *lim);

It ain't so nice that the code for queue_limits_start_update() and 
queue_limits_commit_update() pair are in separate files.

> +
>   /*
>    * Access functions for manipulating queue properties
>    */

