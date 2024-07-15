Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548756BFD2
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030306; cv=fail; b=Beg8mFaXuccSnpDbuQSPYnkwiUeXwPGfxu6yH9TlmnAxonSsu5V025oXpz7+b5I4siDBLbANn8eKCOwdk0iSLIeMmKhyRhpXyxIzC4w8hz1H/sQHM1+c5Zib05GV5DK3nRQtQUjxoMuFVDX4Pgp0jYdJRviDPwSJtwFUzDuOcv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030306; c=relaxed/simple;
	bh=XBzKWTQgIcTS0koRNFSCl08qx9kNblC9dwetc928fvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gt54ZraZWq0Xm68/QW9fnPa19WbRIk+95/EPpV9adloyCye8Cn5bs5B6LmCCxh5Yu96pFFHjnBdkKBqwYm5swB93NNNfydReeYSZhaCN9Tvg0MyBTQ7XScrl/9GjDx1Z7yE3WGI0JEuKCaJpbNNoWZuIe/W65YqWDHQj5IwkNHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DW07KmqR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iQwjqYIw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DW07KmqR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iQwjqYIw"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F7tVM1014879;
	Mon, 15 Jul 2024 07:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=uc7RUfnR/Eewvs6a+3bzfuglbwfMo2GqeG0najYpaaA=; b=
	DW07KmqRCVKM2w4XiSlUy4tIAOKbdxjEocW+Oor2Lr7Vb97LDeOA12ydEM+TLRJ1
	UxrgCu34X+iOOACaGpjW1rzgF20jWFNPuEPTlAmfS3R6yTamwSdQUHIO7D55xGR6
	aoGHIAF/IZyPCNh3TjkSbe7vsztwWVkUfyPIbUhMRg5eBGFHoQjEqRc/6vLEUTs7
	sDw3n+TGRaO5fhPojwiJ6f/ZlcXtuW81kqAW4zmotIEWoerOQM5pVYh/8+BY5iLi
	FdS7Fy5rth51GtCWMlw1vLJbHxLXePikg6E47PR1Om/TPrA7QJJz13dMObYdzJq2
	0ESuu82sEU0siORDT/GboA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bh6stjw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 07:58:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46F7XeNV013781;
	Mon, 15 Jul 2024 07:58:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg16cqdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 07:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qs/v/toZpqUvauL4c6w5JEDEtcBTzmRtvovEj/vYpP/3v9Kuo1KjosN0uCcIh2k5VLm2TgaNuWpIs1Zj2ez6u4LZlBcNvgnovbLaeYNhY89J50RL4rr9ICw0iOXILWp+bbwba+coGk0rKMqgFEbQ4xJf5ro/cXz5VhNMNbEmSUTOb+IL4Cro4Tt9xSccBJVbRDm6Aw3bb6hInomD3oPEuvX4yQUM2pvIhvOEqy+P7q3bvn+PK4i1xF2XsQ+TI8asML+2tgONtS3/1BfFLX6ACw+JwuSotGuRgMrepZJIxAE9AM+Fr9s82p1+cPg0qqs3ax9reH2QFjq5Q0rlAb80pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc7RUfnR/Eewvs6a+3bzfuglbwfMo2GqeG0najYpaaA=;
 b=GZWAGTZuSiSSYG0W6/+WIv8qr5D819HZjdEzyrvacgn8lm3H12cyDoNdoY9A0dsymbekyOZ2S3FntqIEaXkzWjbxCMzpsCgtoHX7k2Zxdia1AGZpEuVxHlB5JX56tjurT7U4ggRTS+ReggpOqn5JfRgZ9/umhv0tQ/Z4eNThkHBwPfmsfWKPgWEPT8pVtQ/u/UdNFuVVrP52ZBRaART5pObNAieLcAgaTgI3+5gLM3/2UFFO/NBdFTzY/oPmNVbwbkd6qeeCDPFz595zqUiF7sD9ctqOJTLPENnvCt6cC9KRAidYBB2p/Ss8ez+07nZ+U8Eqh7jd0y2F+hvse/XwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc7RUfnR/Eewvs6a+3bzfuglbwfMo2GqeG0najYpaaA=;
 b=iQwjqYIwv13HfRd4xy15jXo0Lr3Q8+iD+3U0719UbZdCOWAqop7oNKLFOYvGpShNz4ZyaxsZ5ba2xa70KsfB8OXP1jTvH2/V6qIMyM2hCv3GG2SrixfxgoQPeY8cRGXtUbuzVEKvxXw5o9ivDEdOObsww3Z3EirzAi75FsLnVmU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 07:58:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:58:15 +0000
Message-ID: <dd322d00-2de9-47e6-b3f0-0586149a0ede@oracle.com>
Date: Mon, 15 Jul 2024 08:58:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] block: Use enum to define RQF_x bit indexes
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-10-john.g.garry@oracle.com>
 <73bbfc02-eb8c-4553-a7ab-94fd14fb156b@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <73bbfc02-eb8c-4553-a7ab-94fd14fb156b@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0069.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 487c84e9-8f88-4b54-9e22-08dca4a3e154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bXcvSjlYOEswTTZYMHVrYWRvYm9naE9qelQ0L01uZEV6MW50Q05kTlp3SmFH?=
 =?utf-8?B?SkY0RzUrWlR3cUx3cGtCRGN5SnBTc3VjUGt2RWxpSkVZWDAvOHdBaFRxRFQx?=
 =?utf-8?B?dENQSEg0dFEvamMyUEZJb21lcmRVSklWZmF1YjBnd0tWS095Q1huU1Vqd0ZD?=
 =?utf-8?B?WjAzMXE0RU93bE1wSi82SFhFWS9nWTJTQXpBOXlWaitkWXRJZVdBZngyZnNU?=
 =?utf-8?B?UEdyTitjcDBNRVdiVEgrbXcwVG1xWmhDdVFvamJwMHJvdm1YNEIza25Ca0Yx?=
 =?utf-8?B?WmZLeVd6WThJNklIUXZjOTBpQzNTR3dTNTdjbTJta1J3SndMQWNvbzVwbWtY?=
 =?utf-8?B?L3lFcXFLWmZ4SFFNc25CZjFwdUM2aG1SV3hTQ1pSWGZGbmR1TEVMU2I3VnJk?=
 =?utf-8?B?WEhmcGpUYjBEWDFEQ0ZWRU1mZWVrcTJSNkRuajdmZ21lSGZwalgzMDM5TGk0?=
 =?utf-8?B?eXMxRWFET3RTc21DTldmZXNDY2JKMklqM2JHMGhGakh0Ty9mNVh3N0xncml2?=
 =?utf-8?B?aWxBVm9XakttaFVEZnhneEhaUWhNNlhXS3VNNjlVeUhqZVluRFRKeWVWaU42?=
 =?utf-8?B?TkxPaVBraUJCOVVnQ3QrY0U4VEZQUmJDQ1Y1eFNjOFRMRTdIYTBLakJwRk5n?=
 =?utf-8?B?R0Q3c09tQnllWmFjRzhzZE5hVjVXOHNEclNnTXBzaTBPV2c1WVVnb2s0ZDRn?=
 =?utf-8?B?clBlWm9uaG56K1RFSzhuWnpWRE8zd2lXdmxxV1hUMjRYSGIwZWgwL3J2Unpu?=
 =?utf-8?B?YU54OFMrNWZDd0tkK1JEcllUbmRRQnY1SDQzc2o0M3JIcUVwSVB4VVF5YXZP?=
 =?utf-8?B?bFAweHM1YXdNN05TK1d1Nnl4VTc5NnJmWjNrM1J1UHFjOFRiVU5wZ1FpZ1V3?=
 =?utf-8?B?UzFzRDh0UmE5bXo4R3hscTVvcGh6eHQ4MEo0d3FnNkxEOEFXVlMxVkdBZ1Z1?=
 =?utf-8?B?ZWJvVjFwaU0rdmdKSGZyRFN5MFZvek1HQTYybmF4Q0RVM1dXT2RUaURkVENa?=
 =?utf-8?B?OEVlcDR6MUVObG5TR1lMVTRtTC9BN1lDanpRUjVtM0NJd3YrZEh1ZGRRWkdm?=
 =?utf-8?B?UXR4dFgxSlQyUGw1OUVUS0pSN0lRbGdtVEhjTUtEWHUwalJzbUJqcVdTZmkw?=
 =?utf-8?B?cUVreDlqNDBmQWE1QVNYYlJsakMxdkY4MEIyQ2c0U2hFMnpNN2pTU2RLWnlh?=
 =?utf-8?B?dTNBWGswclBWRU1YdUlnYi8wbGlMNkNtNlpDdDI3aHJuOXZuMUU3NnR0cFBK?=
 =?utf-8?B?anc1cmtTeml6SmNnWHY3Vm5GMFdWZW8rbjBpL21vSW5Ib05YakJ4cjFScGli?=
 =?utf-8?B?bUZqbVVGVHIxSmZvUnI0dnVNQjVLdG5NU3JsQWtMd1cvZGp4Q1lQNnBpTFJn?=
 =?utf-8?B?WUpQZzNmVXJTME9uL29ja1MyODJtVmxueE91Mi9UVnd1V3VoOHMyV3YvZmxQ?=
 =?utf-8?B?OHZEWGt2TEQ0OHBicTJ5MjlNeVV2WnhLWU1mUHBxNS9PNVhpRFZyem00dUlV?=
 =?utf-8?B?ZDBNN2hib0FLbmwvalQ4QzhuQWw3VmFQam0yR1p4RVNHc0FKNXpDTHNCd3pa?=
 =?utf-8?B?MjFQTys5anlaWE1ISFFLVFlJMnNKdi9GTWtndGp4QnppNGlyUEQvNWM4TitF?=
 =?utf-8?B?dVM3MjAyNjJ4MC9Lbm5LQzQvNnBlWnpPU21NemZ1dkhuM0VLSkEzbjJyMGRo?=
 =?utf-8?B?MGNNeWVQOVNtQXpZY2NaVzRnMmwvWG95Sm0rUGZTK2dLbUl0bjlqTkJjZU5T?=
 =?utf-8?B?MEFRZUZKdnE1TWFadmUxeXBlUGtFRFR2aTlnSHk3NVUxRGFKRTBkR1gyQTR0?=
 =?utf-8?B?Zm1SSlhla1d3QUdkWWE0UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDlLY2RjSHh2ekJ0NWc4UW5ManlJRlNONzhJNnZJazRqSkduLzFrTnpGUEhs?=
 =?utf-8?B?b1dWM1Z1dHFwZ2RTd3BoYkZnQlgxdFZsaGhpYWhWdDRBL2xLcFlVRzZaWTA2?=
 =?utf-8?B?S1pTVGo2ODFnTEdHbnAvUGpoU2tYUTJ2bEEwYTNMTWRObnJMRHQvTTVHaXJG?=
 =?utf-8?B?MG5aWmVWZ2ROVjV1bVgvQXkvWG1pVTlFcHdPdVdmaEJudHpOWk5vNEdsbENl?=
 =?utf-8?B?ZmFZc1J5ZktOYXB2VVozd3NjZzRGdm13YTQ0L3VzVDJ2QS84RVJqUWNFRzhJ?=
 =?utf-8?B?dXNkLzhSSllYN1dqbXh6cWVqK1NXd2pMdiszUjFyamZvQWhONXVRblBJMFBL?=
 =?utf-8?B?SnhFUzRsdVF5bGVCTGNLQkNJd0piOEdYQ0tTbEVNRXZ4VGxpVnIzdmhsNkhu?=
 =?utf-8?B?Y1RjWW5VMWEwRmpvb0liZmhyTTdCenFaTTlVYTZQeTZVeEVRblhVNHJ6ZGNP?=
 =?utf-8?B?SlFzUDZQd3Q4NHEvUy9ZY0Z5KzNaUVhadm9GSXRucitoSk16NUpoOXJid2dW?=
 =?utf-8?B?QTMvM0Iza3J2TnBMbU1LZXhZVnd0YUZJRFZwaXdEM2liVjBCSWo5MURhWHhp?=
 =?utf-8?B?UnlWR1d5UGRnRFZEUHFEVExzTUlycE8yQTh5NkIyRlBkNDJXSE1CQlMxZkIv?=
 =?utf-8?B?dVBnTHNsc0sxakxXSDUxVTJ4cm1MejFEdmlLRUdmU0F6bGx5ZzVKSjBnMzFT?=
 =?utf-8?B?UU9udUpybmtPd0xTVGN6c21WQVdpUWZ0ZHNWT1pmUThYNmZVVUZCVC9vcjRW?=
 =?utf-8?B?eVhkQ2FTMExXVkJLeFBFYVNsQTFNTlpmTzNuYStRUFlWY0pCdVk4V0tzSEs0?=
 =?utf-8?B?NG5DYk1nU1ZNemNKdFZDenZqR0FyTThCbkxCZndYMWtzV1NEMHFPZHI0TXgw?=
 =?utf-8?B?aHVMM2I1TFBQR3l0bnlCOVNVc09sbFpaMndRMkUxWGJNRU9JYm9ZdkJ5Y05a?=
 =?utf-8?B?bVc2Wm9aVUkzWkdjM0VVVFE0S0pEbmR1a1QxQWZiSkJoY0FoK3pBTkRFY2Vk?=
 =?utf-8?B?aG9oejhWcndYbmNyK21sMUhlTVRvWGlYNVAwc2ZSdHo0MEdyYVQ1TnVrVzBN?=
 =?utf-8?B?OXJyVDBGckhFcDZCVU9oUm9VYUE4ZE1uNld6RmgwRTFRdnRkSHZiTFdqR1h4?=
 =?utf-8?B?SnVOWkZsc1gwZkFiblRRU0Uyc0NIWGEzMjU1UjgzZ0p6enR6RDhPc0t1ZVpy?=
 =?utf-8?B?c2JhdnZNL3ZHbDY4Q3NNYndmbGlRTU1GVmdnbG95NFJrMEpmZnBTY2Q3SWow?=
 =?utf-8?B?NGNYblVCTXhTdjhheFV0MzNKZUVDeDFDd05uY0dRMnUrcVBUaHVOenJmNHVH?=
 =?utf-8?B?U24yL2NtUXhoazZESjdrbjM1ZTJHVDFzbmNyUGx3NWMvTWI5ZHYwZUVyL0VR?=
 =?utf-8?B?N21uTXFtSlRtNlBnYnVqb1dtTmNjQnhyejUrcFpnamRiaU5STUF2bzdRcW90?=
 =?utf-8?B?Y1lobXNpL05hVEY3cS9Jb2huWkwrNVE3dThhd2RzSGMwR1lSS3RCcExWOHh0?=
 =?utf-8?B?bStRUXoyeUtodWhKdGtLdGh1OUFLVFNtNThrZmxJbWlkeXY4dVd6anFnT0NO?=
 =?utf-8?B?ekVoOHIyUU44NHczdUZOMlF5R3QyMDdkbUM4WHNxZXpSQ3Z1dDhKdEJKOVFO?=
 =?utf-8?B?ZHFCZDRkK0NBRmZ0WVlqSG11c2ljeHVPQ0cwc3ZVSzU3a1hLSmN1c29TTEY1?=
 =?utf-8?B?SXhrblpVY25KeVBlb3F1M0dHZHQwR2IvRXlHZFk2Z1I0TE1XdURvUUxvUHRo?=
 =?utf-8?B?RDYrb29DaER4VkRreXp0SlZXM2FRNXoraTZWbERpUkpKbE9vR1dnZVNzY3Vo?=
 =?utf-8?B?UVFmYW4rOVJjRHNnU0M2UDNVQXV2azZ3amVFbDlCUTBmb1NMM2VDdFNNdmhQ?=
 =?utf-8?B?ajg2ZFpVanlvUFUrWGphS3RwVUpmVW5YVEVtU2lsc3k3OGV1VkpJanhCdThm?=
 =?utf-8?B?NWhyMWtuSENhVnpLVHp3ZzhiWU9FM3lzMnFkVVJVL2w5NXBUVk5EdDRaZ2FK?=
 =?utf-8?B?ZTF4R2NSZFVQbE4yYmJCbm9wK1Jjc1AwalBUU2RNdTN4dTN6VmpRRXY3SWF0?=
 =?utf-8?B?OFNSc0tTT0R3Q3FVMnJ5ckorOWZYRWMwdGhZWWJFQzBDRitQemZHTi9Gc2o3?=
 =?utf-8?B?QWErTFZ4b0dacEN2QjZ2WlkxSVl0SlpBWTdyckpBcnJXVTFaVUR6ZHlNWS8y?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R43fy99Yv3/AGsy2HVWsqsMuNiXv9ZlEySSLVqIrZG6nGkw6ktsqMGMjEfbBjYIfVt8x0BhhqzdghoSw2Cju9prunOeAVvt8rRmRg/CuNoc98LOVaAInSbnXtRH49+ljbl5C1WwezAZXOTKMEMlqkaD9BlKCvUtwYO8k76nn7JWArnjOr6zRyOGbwoathLJq/AFMWKvqAyceAR41rB1JonxtXcNwIZGPKG+2pQUitYbfAWkxrk04FyxNPc8YtiArEMfspiyt174wIOsxTUf0Ouj8n8982GqYLhxAUeJmJ9x0cfji3zFCxJpoR0NmAhb3wQ8bdaxwrXefzrFlZFzzroKl+RLA7aRL6pS3TEsa6W6x24mOH4ZCS22MYFn9vXPxNArg+K8S/3Fk5vtx/EWbdxeYrG0MxMkoxOm2JLYRToBPwqWIqT7iEMfiS5+7dvqpAsFAd4tuM5kG6eMRSdd1zJwhLwpzEL2QOv9IwgFjvOjI/acJPfe/oMYc7JoBc5muUykN/nG++z34ZiYhojIYLMBKo4nhS/S4xzt2dwLOADeUPSFRLm0iutwcptKwN4kdpexOcIiZWT+KsouzttFPfZa4cqutrz3zmkE7Ce5rJYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487c84e9-8f88-4b54-9e22-08dca4a3e154
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 07:58:14.9570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUzwEpdT2xpCgdNZtVLzjuh1Okdr9Pc3Mg0L2AqjsvitGrGdhHBG+T4sVb1JTP1N/Kn51nTxE9E3b0kRellgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150062
X-Proofpoint-GUID: XJJ-btun8omG8jT20-7KPavolVioAWNF
X-Proofpoint-ORIG-GUID: XJJ-btun8omG8jT20-7KPavolVioAWNF

On 11/07/2024 19:13, Bart Van Assche wrote:
> On 7/11/24 1:23 AM, John Garry wrote:
>> +enum {
>> +    /* drive already may have started this one */
>> +    __RQF_STARTED        =    0,
> 
> Why " = 0"? 

As before. I can drop it.

I think this is redundant and can be left out.
> Additionally, this enum definition would be easier to read if the
> comments would start next to "," instead of occurring on a line of
> their own.

ok, I can put the comment next to the value in cases where we will not 
spill over 80 characters.


