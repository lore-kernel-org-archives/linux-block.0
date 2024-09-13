Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00F1D86EC;
	Fri, 13 Sep 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229360; cv=fail; b=ZUrWBPQSQnPoE/xR4y8xAfJCxJFEgdWU++H7LH1Bg0hOdhY1GecQHFFvCBjzoDmq+E8lZCi3OCDc6aM/qBX3Ic8DEcZ1nYLxhHig+Doj6puuUChVle8DWP/6EP2Bwv4oYJYB6WAvnmioRdMch1pTmzDFi6wwG0Iks5atgONxdQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229360; c=relaxed/simple;
	bh=ug4hGHbvCJJ3QSQh6RmDe4dde4n5RRVtqOSGRIcX2L0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfNSHimtd6LZflAZpwb9rXylI2+VYp5GHsaAbJ07qfrYJmFGEg5XiZwx+xX6Bk1HYGofFN1dkOM/Bip/L1A2c5QgyLilAryUdIntVveYV1SCEE07Gp7g2glFCkWP/iGEp5MSzbLq91KjcQ+e3gRWRk49X/vWGp9vCb/jx+1PD7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i3rdS5Jn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lmtqrpRK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3rdS5Jn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lmtqrpRK"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YLbB008399;
	Fri, 13 Sep 2024 12:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=25kp2z5AN5PdrShCiEZUxNNOxTF6u8ptRh/+OWB8mjU=; b=
	i3rdS5JnCWkxRySVpBL7joxAukLp0KLMxOq1RiOarhTtrMgdgD7pIScz1MvBKhhE
	/JX7No6b2jX+3IOHX5MYwBy42eW8Y1k4eJNo654lvwmZsJxhCkNB+/30VI9O4LuF
	uzUb12xWv+P4aLuPcuAvUQQXVF2TrNeNECwJ/CouFk9ZPN3S6ex6tvI2ebg7vqvZ
	9zK8jbU3kF9tFfN4AYrXL656fWCOx9BHALLDIEinc+OH8GjHKihUFuS8l+oGgEJ+
	ZGA1fwRzyUB1bpx5SjOkGqM9CZFpFXk/rR2S7vUZq4D1YM/aApJ9OhB2rlS4xt4G
	7dwLi3GXZKBB13d6JUiIkw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrbde0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 12:09:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DC6Hb4033021;
	Fri, 13 Sep 2024 12:09:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9jw4ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 12:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkZixUmpXWEkeZwchqKmmW5YlCE735OoN54BhaYk2QezqqZ4OZHzbZeSxrH5kyNNt2Ah5NhrpI+U9H3dacUDOzFTGpbbXglNE6wUJ51T4SzvoRc5HMtz2ydb9JmB8ReAvMHYl789QTQF7r25ur4sdgGiQdKTDYeCQ+6dXkvtV5CcIIvyWbgtUr/QHVYGGvAWTWI5jYNw7t1F+og/DVMZz1f2X5/4Gr7dp0Wno2YsZzuQUacfoPB3/qmTzSuZ4UYdAD4cMrhoiR5slDMTkYFcM/Am/lEAImi56TkL8a51P9rqA+7Pvo9LN7VsCSiT2EoLBHEfhiax4vdF5H/t9TTDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25kp2z5AN5PdrShCiEZUxNNOxTF6u8ptRh/+OWB8mjU=;
 b=aDG3HD+tYp2TaPaHStzZ/20nYinhscLVqn7UC/med75W77HO53mxD3s+8qE2u3GMCH9qNM/KEzdshLCEnL+49ZLWSc2IPIdI9bXRKtks+ZBm/e2EYuhEjlCh48jowaXnCrt9U5cRtjS59ge5ck/iKL8eqYhAfC3SET9lu5j7jCvKIS3SoB6TcoHkigp8HRXQ15wE6oAfucJRDpBVXl0Ha/jV4vSgV1P81wraV/AI0dTSODYO5lV3yB5Hz+LTi/Wmtgr5cTYifM30QvWomZfAdz+hF1afLa/Yc2+613GrRoT3HwL0neA+Mzzwid7PvLYQ2LMUV+nl5XD6EtL98TMSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25kp2z5AN5PdrShCiEZUxNNOxTF6u8ptRh/+OWB8mjU=;
 b=lmtqrpRKgfG83rUfee6xqpj+hSc7SpKWRgGR9oPDs7KB5FPtk7KH+4M8v+dkMxbivMBJAU61jeebsqx1NnLngFrthe7+TZd3kSvzyJJ8qb42Iky5NYfZNyi50HKiUcmSZuUQjrY16Mkctxfi2gIFsi36nIVmxwlmNuyqG/5I9A4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5052.namprd10.prod.outlook.com (2603:10b6:610:de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Fri, 13 Sep
 2024 12:08:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 12:08:57 +0000
Message-ID: <77f6fd38-e216-47cf-8ceb-930395614aca@oracle.com>
Date: Fri, 13 Sep 2024 13:08:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] block: trace: add block alignment information
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, gost.dev@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Dave Chinner <dchinner@redhat.com>, Daniel Gomez <d@kruces.com>
References: <20240912-add-blkalgn-block-trace-v1-1-335dd6eea557@samsung.com>
 <CGME20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997@eucas1p2.samsung.com>
 <a7f9079f-6f47-4a47-a327-98497bd33dfe@oracle.com>
 <20240913112626.mmr27xzxicyf37kh@AALNPWDAGOMEZ1.aal.scsc.local>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240913112626.mmr27xzxicyf37kh@AALNPWDAGOMEZ1.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0031.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c1dec0-9a4b-4df7-fcfc-08dcd3ecccd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzFVNWF5REVYUi8xYVRNaDdDcGF2UEZ2K213cEgwVmlmcjlvTEpxQzJVeDJw?=
 =?utf-8?B?QXRIYTdqdk1tK0NHbWVPazBMMU9kZXBaTHdHaWMzbTN6L2drN0pGWENiMjU3?=
 =?utf-8?B?L0I3UjBtbzlRbDVzcVZZZmEwL2VLU3hGSkJOUGFrSU9GWUNtdW1DdEwwcDZw?=
 =?utf-8?B?MHEvQWIxbXVoUUpyZ0FYYUtGd2laYTBtMTArSGt0QURrQXcvUk9HUzhnaXRi?=
 =?utf-8?B?K0lDRzkxRk82WTJSMnMvVHJqWHQvbEgzcEZ3bVVXblBCR2dhUTl3aVd6MUpH?=
 =?utf-8?B?Vm5UUFBIVEZ0RXExSTBHVHEybUloeW15cDBmcjhrRlFhNzVBbC83Z3ZrVHZJ?=
 =?utf-8?B?OUd6K1kyVHV1ZXV6aUNHK1RnYmlrMzJmQW1mOTlFOFZCNWJyTXJuTmJ3T0gz?=
 =?utf-8?B?VGx1TTlzR3psYjNkK20zODdNbzI2anEvVXQ3eEJFZitmeGh5cUxwZS94TjBJ?=
 =?utf-8?B?UGpmUU5JNWtGVzYxb0JOcWFaWG5Cazdwd1N1REVFUHFQZ2pSMEpaa0dPYWdM?=
 =?utf-8?B?ZUVrOFYvZTl1NGdrcW9IanIzWTJpNVpiaytxUXNILzJmOHdBN3dDZkpEWG4y?=
 =?utf-8?B?ZXUyTEIzZ2RaUzZSa3ZWZEI5RldGZDE4YTR5clFndmdYVDh0T0RiTkpZK1lX?=
 =?utf-8?B?ZytGYldqNzcvcXpXbERpOWhoZzh4MlE4WEdRYVBRWDJoSnllZVN4d29MK1VP?=
 =?utf-8?B?Nm5IWkVpUDNEdndiQmxHV0lGRjhoamJjalEwbnhGUXpwWXY2b0FJTGN1UEh3?=
 =?utf-8?B?cFZpT25vdFZqWEhjYTNkUEVoTllEUmhzVEJJc0czVGJZc09ENklyby9yRlU2?=
 =?utf-8?B?bDBOMkRISTZCRi85VXkxUlFKcDJpbGpISzgyOHNZcUNaaXdISm9ZdWNPMEIv?=
 =?utf-8?B?UHJUK3M1VHo5VWtEMVVPR1N4SlRXV25INzRTUmpQNUZTS0ZBdjZCNDkxU0sy?=
 =?utf-8?B?bnNuMGpBcG1IYXQ5WFJtWENYSzVrRkVLV09peXBUUHNuL25xNXZLNUl5aHlN?=
 =?utf-8?B?YThaRjRtOE9IbDg1YVJpUVkzblR3d2dUSnRHSW1UQzlGZXhUZzRhVWNSS2sz?=
 =?utf-8?B?Z2hqQnN1VmxRVW5TT2ZIZW1HcmZPcXJaM3RPeW50UHJPdDRhR21pMHZpVDU5?=
 =?utf-8?B?V2IxZFVXNkd1NHBFVXUzTnhnSHgybFF1MnZOaG1zaWpxaVZRR1RPd1VwU0F3?=
 =?utf-8?B?ekpYNllNbEZpc0VvdVQ2c1dZcTBKVndha1NMcjRjSEs3Szh1aUtkd0lvR1lS?=
 =?utf-8?B?TnBtRmx6L3B6OVdkV2NjL1JaaE04bW5HZ3pCTXNNZ1ZtT0t0a0xTM3JFaW5n?=
 =?utf-8?B?N21heEdKdTFpR3ViR3RMbVBnSEFhT2E2Z2V2dFVtZ1FvdmRacUR1VDhVOGs1?=
 =?utf-8?B?VFAwYVpBODFobnpYRHhNVk9pVEFTWUpEeXRvMC93MzV4YXlYbkwzSEhsQlVo?=
 =?utf-8?B?WHBkQ1pnWnE1dm5BMWovQjBnUTY3cmJwcVpnZnlESE9uVWhIOFlVcnpWV09O?=
 =?utf-8?B?Zjlwb3Q3THVUTytSTWswNkE5enRobHg4M2NNVjEzc2NOQ0NUa2dWeVRvSXk3?=
 =?utf-8?B?MjhCUEFtMjJFSzRjUEY5M214eUVBUVFIZDRxaGVwZFRFMTNYSm9HYWIrRDZ4?=
 =?utf-8?B?Y1lJNGY4ZU11QWRMdkcwY25rRkhkMFRrc1RENXg0N3hkM2RzUWp4eFREU1RR?=
 =?utf-8?B?YzhiSlFkUkhVSVRZNks4RGZKVnlvRXR1elczNU1HVFEyQVNZOHNBc1RoNy9P?=
 =?utf-8?Q?H514SSAjJOgo0FXmng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkROZWQyaHdZRFlIQUZuaFNKRUdvWVJmemp3SUlhOXhMZDl5cTB1WEpnVVA2?=
 =?utf-8?B?dXBqRHg1MFBmL2FuTG45Mzl3Und4VzZoZ1IzQkFwVzdPUVV6cGVoS0NISlhR?=
 =?utf-8?B?SzZpY2RhQ1VWdWRVdm9nejRxNnZIYVorNmx2ZXgzY3dyRStoM3pMQlBKcVFZ?=
 =?utf-8?B?cnlybU1SaGp4eDduQSsxRHhvcWRQWmVvWU15aTVwbG9Rb28zOFd0K1lOUTM3?=
 =?utf-8?B?c21yK3dwVGgyY0IvZlpNRmkwZVcxM0Z4QUhTNVJOaHUzZGFHellpSUgzR0JS?=
 =?utf-8?B?bWt4ZllxcFVrMDNISTN6TjE2NU4yNUp6c1BBbTBsWnMwOEN6K2JFK0QvYjZD?=
 =?utf-8?B?cDJxOWZQNEw1aE1IVjhFRGxlMEFkUC9sZXBYcmxTS2N1OXFEYTNKZHk2aFJz?=
 =?utf-8?B?a2N4cndaOVNxcnpzb2Z0TDJuWEs1clNKQ25HSTBSU215UmxJWmtXMjFQdHZ2?=
 =?utf-8?B?WUM3VVBMMklLdTF4VlE2VDhDRnhDMEV4WjN5eEx6NVczMGtpVHBSUlNCT1Jn?=
 =?utf-8?B?V2oyNzVIdCtBbyt5dVhiQUNyV3ZOaHYvSlhNbXhmanVndmNDcFhlUzRoY29v?=
 =?utf-8?B?V3lFUnNVUWpieEpRV2UzYjliQ3FUREhZRW1jQWdxWG5qb3ArdXYvMVM2Ujlk?=
 =?utf-8?B?Y2svY3BNTHFvS3ZnbHhUZi94YmlNNGxxNkh2YVJ3UkdTM01FaXZWRFZWMHBu?=
 =?utf-8?B?eWl0TmJwUzMwblRUUFBBV2tWU2EvT040VWVSNlF1eEdsREdzSnZZa1JzYUo2?=
 =?utf-8?B?RXlvNmFYWEFwdWorUkIvajVqZXQwN2VmK1RZT0x6cWlnWXkzeFIwajNWL29z?=
 =?utf-8?B?WXFJZEpzRng2VGlwT3BndkduOGJTZ3h4czlwVkl2STBraFZlVEVQRUkrOVRa?=
 =?utf-8?B?djlBK01oNkYvVVJRdnJiam0ySExQYktVd0hFT1dXSnc4eEF2WHl4eGt4YkxT?=
 =?utf-8?B?RFV2dFBySVhscTlNNjBPTHppYXJhS1BvZlhTUnVHSDZEbkRCcVNsQVV3eFRv?=
 =?utf-8?B?U29NR2M2d0xHNjBGZHE2Vk53Yy9wQmxaMFlNczM1MUJxclo4QjgrYVZGT2c0?=
 =?utf-8?B?bDJEbURjenBzY0R5Y0RpbFZ2TEl0VUo5M2VRTWQ3a2U4bktkcHdrTm9laE12?=
 =?utf-8?B?V3hCbTBHcFdvZU9LRzd4YmwwUjN3ckFyaW9OTnJOV3BIMlgxM0xsRGV4akIy?=
 =?utf-8?B?Nko1aTczTFhObHZXWGxvUElEWnM4UVAyMHVGRW0wZnlVeGJRUnBEQ0V4elF1?=
 =?utf-8?B?NmJQb21MKzNFSHh3V0Y4NFROdDB0NVIwdFhPa0gvVGYvaEVqRjJGczdQYkRj?=
 =?utf-8?B?dzNNOTFvMFkyUGphRG5pYTY2T3dIbENqOGNHVXh2d0pCTTVXVHV6Tk1OSUF4?=
 =?utf-8?B?aDRWaHAxVWQ3M0FHWjBhQzV3RVgyaHBzUmVnbU9ZMHE2U0RjMFBNT1FaaVNK?=
 =?utf-8?B?Y1BKVjNGSjJIZktxbnZFSzEreVpycnF2a1Y2bHY4NGtXOUVILzJxOG5KdHpN?=
 =?utf-8?B?OVVpdzVrc1A4MVRvYWV5b25aMWg3V2U0dWNtZ29qeis2aElIcUVVRkw0Szhs?=
 =?utf-8?B?R1RRd1pDMHlxdlhQbFNHVFdsZVFhajhEalJ2c2RSZWpSRm1ZYkZiVWhkZDVK?=
 =?utf-8?B?WFFNSGNjcnR5MUlOajRHSkcyOEtsUmVDRnlCMGRJN2RKSDlqVFdwaC8zSGtI?=
 =?utf-8?B?MUNVMllXZUd1Nmo4VGhobGVPQ3FLZjA4VWprMzV5dWR1RWJNNjUrdTFVQ3lr?=
 =?utf-8?B?WEJyaGRhYlFLbW5TQkhuQTFzblFuaWk5dHduL2ZKWTVOZjJiY3RHQXV2cG1G?=
 =?utf-8?B?S1RvNEdUT1Q1cVVkZ0JhVllXRFhiWGVEUUczM25jRjNUc01OWFJtWllrb0V2?=
 =?utf-8?B?a0lxSkVvaGljTGttaTJaOXBINDd4NHdPWFhZQ1AyeVAxb3kxY2lGYjdwQnRs?=
 =?utf-8?B?MndnYWFHMlJGckxIQ2FBZHRBNnl2czZudHZiSi8rVFJsWVJ5a2ZsNTFWMUVq?=
 =?utf-8?B?RVJ4YnZueWNSTkt1bGt5RWhoVTM1SUxyUUtDQmlqMUE4cCtjeGMySnJOMHFa?=
 =?utf-8?B?c01oUkJVOFBaMnNWZ3UxVWtRbzlJU3BMVmhQVE0xMUdDNHhLMmFyVWRPTSth?=
 =?utf-8?Q?lMo4DCY4sNGvcOhfZUysbVlEq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NfDCCiKjML1+GSFIyIFNK8OYYzu8EkDLP0oTgad7QZ7Bfw5UrOcFiBY6RP2s0inHvB++QtWwoEoJuAYdsQGsCW+0NY6khdSZDSLl/3cxZFe/qOGpjIAB2QZwUIh8sOsNxClYDHK/e3sOfB9ky0+VPnAu/aVv8oBSHuv3MN0HBWq0cOAp9UoVAape//gH2iI4U3lfSO/ozeo3CSzoQD6lU9kb0hCzEiv95SDGeZjgpOTTRkueH3ZvMm4SY5KbkO7yQ5oETtgyo+B5YcEaNVCANHGZycvuE+qisTJ91cVDUYF1A95LlKpmIIwH+MbwE6KETL/4hlZ0zYQHBW12hsIzsBx47AR+69cYmx8DqmWiR50L80bRviz49nVav5wgmiLqb6FF3up3CGJemrBiJkZx+vCjodCxOZ36dQP+1a66nXunoo1TsbOxGs6dLFw5B5ox+K0phSMAAjweomd27NcxoAvHrwNc9CjMc36MTAyl8TrB/A3ql2QW0eYooS3PRNcThqmup85Un30IBXLYXNC/EUVFbyA2GyUxBpB3VvQgw3t6fYerTrx5Si8fff5uW7DmeXl6ccTL1uG/8nOfepPgPCfBI5I4OLq/Kwg1Nr3TBQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c1dec0-9a4b-4df7-fcfc-08dcd3ecccd7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:08:57.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsLlHHRUWDhM67jc7/lSzHelxTnvhNLlpbvhRFNo+54pqyNQ/84wDzI1u0Mg9w1LYQe4+dQ7xMtSTPSKsLE7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130084
X-Proofpoint-ORIG-GUID: l4-oBGCYFIGnb2V-fN68URqAIiG2h2lW
X-Proofpoint-GUID: l4-oBGCYFIGnb2V-fN68URqAIiG2h2lW

On 13/09/2024 12:26, Daniel Gomez wrote:
> On Fri, Sep 13, 2024 at 09:59:08AM +0100, John Garry wrote:
>> On 12/09/2024 21:48, Daniel Gomez via B4 Relay wrote:
>>> From: Daniel Gomez <da.gomez@samsung.com>
>>>
>>> Report block alignment in terms of LBA and size during block tracing for
>>> block_rq. Calculate alignment only for read/writes where the length is
>>> greater than 0. Otherwise, report 0 to indicate no alignment calculated.
>>>
>>> Suggested-by: Dave Chinner <dchinner@redhat.com>
>>> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>>> ---
>>> This patch introduces LBA and size alignment information for
>>> the block_rq tracepoints (block_rq{insert, issue, merge} and
>>> block_{io_start, io_done}).
>>
>> eh, shouldn't this belong in the description of the patch?
> 
> Yes. I'll move this to the commit message.
> 
>>
>> And I still don't know what we mean by alignment in this context.
>>
>>  From looking at the code, it seems to be the max detected block size
>> granularity. For example, for a 64KB write at a 32KB offset, that would give
>> a 32KB "alignment". But a 64KB write at a 64KB offset would be "64KB"
>> alignment. While a 8KB write at 64KB offset would be 8KB "alignment". And a
>> 24KB write at offset 0 is a 8KB "alignment", as 8KB is the lowest power-of-2

note: I meant "8KB is the largest power-of-2"

>> which is divisible into 24KB. Is this a correct understanding?
> 
> That is correct. 

So maybe it's me, but I just find it odd to call this information 
"alignment". To me, what you are looking for is largest block size 
granularity.

 > Do you think adding examples like yours can help to explain
 > this better?
> Below the same examples using fio with the trace output:
> 
> 
> 	sudo fio -bs=64k -size=64k -offset=32k -rw=write \
> 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> 	
> 	sudo fio -bs=64k -size=64k -offset=64k -rw=write \
> 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> 	
> 	sudo fio -bs=8k -size=8k -offset=64k -rw=write \
> 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> 	
> 	sudo fio -bs=24k -size=24k -offset=0k -rw=write \
> 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> 
> 	fio-789     [000] .....  4455.092003: block_rq_issue: 259,0 WS 65536 () 64 + 128 none,0,0 |32768| [fio]
> 	fio-801     [000] .....  4455.474826: block_rq_issue: 259,0 WS 65536 () 128 + 128 none,0,0 |65536| [fio]
> 	fio-813     [000] .....  4455.855143: block_rq_issue: 259,0 WS 8192 () 128 + 16 none,0,0 |8192| [fio]
> 	fio-825     [000] .....  4456.235595: block_rq_issue: 259,0 WS 24576 () 0 + 48 none,0,0 |8192| [fio]
> 
> 
> Also, the motivation behind this is explained in the LBS RFC [1] and I should
> have included it here for context. I hope [1] and my description below helps to
> explain what alignment means and why is needed:
> 
> [1] Subject: [RFC 00/23] Enable block size > page size in XFS
> https://urldefense.com/v3/__https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!NoMpDxzuA5uKlv0RAWE5UtOQKOrNB2zv8PHmOLWxfGCEzw5WpyyvonfhcMi0REPjCgF8pgBvEO9kyhTPO8z1$
> 
> Tracing alignment information is important for high-capacity and QLC SSDs with
> Indirection Units greater than 4 KiB. These devices are still 4 KiB in Logical
> Block Size (LBS) but because they work at higher IUs, unaligned writes to the IU
> boundaries can imply in a read-modify-write (RMW).

Yes, I get that this might be important to know.

> 
> The graph below is a representation of the device IU vs an I/O block aligned/
> unaligned.
> 
>      |--- IU Boundaries ----|      |-PS-|
> a)  [====][====][====][====][····][····][····]--
>      |                      |
> b)  [····][====][====][====][====][····][····]--
>      |                      |
> c)  [====][====][====][====][····][====][====]--

is there meant to be a gap at page index #4?

>      |                      |
> d)  [····][····][====][====][····][····][····]--
>      |                      |
> LBA 0                      4
>    
>      Key:
>      [====] = I/O Block
>      [····] = Memory in Page Size (PS) chunks
> 
> a) I/O matches IU boundaries (LBA and block size). I/O is aligned.
> b) The size of the I/O matches the IU size but the I/O is not aligned to the
> IU boundaries. I/O is unaligned.
> c) I/O does not match in either size or LBA. I/O is unaligned.

what about d)? Not aligned to IU, I assume.

> 
>>
>>>
>>> The idea of reporting alignment in a tracepoint was first suggested in
>>> this thread [1] by Dave Chinner. Additionally, an eBPF-based equivalent
>>> tracing tool [2] was developed and used during LBS development, as
>>> mentioned in the patch series [3] and in [1].
>>>
>>> With this addition, users can check block alignment directly through the
>>> block layer tracepoints without needing any additional tools.
>>>
>>> In case we have a use case, this can be extended to other tracepoints,
>>> such as complete and error.
>>>
>>> Another potential enhancement could be the integration of this
>>> information into blktrace. Would that be a feasible option to consider?
>>>
>>> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/ZdvXAn1Q*2F*QX5sPQ@dread.disaster.area/__;JSs!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtYsRb3aY$
>>> [2] blkalgn tool written in eBPF/bcc:
>>> https://urldefense.com/v3/__https://github.com/dkruces/bcc/tree/lbs__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXthE7cfng$
>>> [3] https://urldefense.com/v3/__https://lore.kernel.org/all/20240822135018.1931258-1-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtqQ5uwAE$
>>> ---
>>>    block/blk-mq.c               | 29 +++++++++++++++++++++++++++++
>>>    include/linux/blk-mq.h       | 11 +++++++++++
>>>    include/linux/blkdev.h       |  6 ++++++
>>>    include/trace/events/block.h |  7 +++++--
>>>    4 files changed, 51 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 831c5cf5d874..714452bc236b 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4920,6 +4920,35 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>>>    }
>>>    EXPORT_SYMBOL_GPL(blk_rq_poll);
>>> +u32 __blk_rq_lba_algn(struct request *req)
>>
>> why use "algn", and not "align"?
>>
>> "algn" is not a natural abbreviation of "alignment".
> 
> That's okay with me, changing the var name to a more natural abbreviation.
> 
>>
>> And why can't userspace figure this out? All the info is available already,
>> right?
> 
> We are interested in the block alignment (LBA and size) at block device driver
> level, not userspace level. That is, everything that is going out from the block
> layer. Using the block tracing points currently available makes it block-driver
> generic.

I am just saying that the information already present in the block trace 
point can be used to get this "alignment" info, right? And userspace can 
do the work of reading those trace events to find this "alignment" info.

Thanks,
John

