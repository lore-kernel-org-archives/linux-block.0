Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CA3FD969
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039613; cv=fail; b=omkgMq+GqRCb2CQPx8vedjFfw+jqBg7CWXLQz8YnDFdwRXEHoq0+k1QAhFAvpq3iq30e0Kl+2HS238ZYhVW1HWRIcRsfCeKBXit0O3ZTGDBZs9fZC+u3K2LfTEjgzH50X5hQ8oLFhSc9f8Mwni9lMRKT6nrN/Vqi4NYS9ws/U7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039613; c=relaxed/simple;
	bh=+SVB3i5hpG2lTxshSPZXMeQtkjrU9e1pkgrcxc8BlJA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o63zbEuZF2rEzzFjE/ikxdSwBb7ZGlzaeBlHKInr+O6EINYykn3XCfesSV5TprKnelt96A8//f9feDisKPy83gvElMXas913c3n0LthiP/fle3rwxc2NSkjbnBo5thSs7n4isu/LDMPBjaY4FBDh66RSNh4IqJkwCZ0vl9Or23o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rdvW27x0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q/qZ/e5i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rdvW27x0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q/qZ/e5i"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLN5Mn1404084;
	Tue, 18 Aug 2026 07:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wr1G/evdCRI0KN+uRUUMfXdP0DbRpfzj3pwuP1sq+jQ=; b=
	rdvW27x0dDwot+4qQNBqLzAEatTzWSU/tJ7y0w6M+2SSGvYWc7qMicvOL/dHJwb/
	4LjhR3zVI+upEXxU0T2lca3xrAyrKSY6XQbP4VTFPUeQ9FXnVKTN/xsdyJ9si+b+
	OfVujVp8BPsYXhqWPtB58pYOufOrIxAdc4194FoBszsIjRuq8jg4ylb4fVhUnhVZ
	juIoB5sXkChOt9mxBiiIcVQHkeFsLGZ8BA9Xeh/LPlGW4mkSMtzm3czkZsohxfGL
	PQw0PWo4StNXQjxbE+hJqrFHRQ9sBySN74xodi95106wSdKgdmD2ge3GvJ62hahG
	CsjHehKw/Mf3zeU31JeXew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2ew53unb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 07:52:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67I7oaGM005747;
	Tue, 18 Aug 2026 07:52:14 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32hqf0vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 07:52:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3B0K0DM9S4oHDlzqtI6vo2pk2BOgFamxztHaOrtSoVm8BMvMKkyla8lnoRIgAjBxo+RkW9xlgEV67laaUJuyFZEGb99cfKPrbt1IMkAa98DxkKcup/1UptJAf67AJp0XqhM45FeZy4QHGhxnk+gUlgSEqXwkqCCwuHZ24/m4ZiskLqC7CdDv2NIRIgRAAs0P84Mb/CAM6oAUuY2WkeYz/jODoSRhWPBABX0CdVZp5KRGi9+S+6uHUsF3Ivv8Dvr/+9GsGPakTp7h2TkGMmiB7OdyQIgICSUjrtgf1yWgMmKmJSiq1G3J6zlD3yLYjPg8K7zHDmJ5uBZxg62cxi7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr1G/evdCRI0KN+uRUUMfXdP0DbRpfzj3pwuP1sq+jQ=;
 b=dndsOItg7iWw/dAz5bo8S6v9J3djCuJ2KinVqgqNDrAkziqHlFmJhfdVuNv7VTjUZf8eP9Hbo2mnfc06UUYQnVABkAzqrZ2SLAMZ8Jc5gFbuQ1KVRW6vMxqSkZnLMUgLGB1t+DEfd2LbY8Lvkif0pzhn/QOTev2H3NKip0faK2QRJbQ3BKRhX5vp7h2BCLUWt0z20K2zc2TOgAtWoGP+KfJ6bOJUAh0SC/UdJioJ1AdLDig3COxF8YAN9Fm1QtF2XR56PY9oE+hlHhmVpu1N+PfngsNNGRDPJZzNFl9wUEphQOdJ6hwDSMfV+hvWLPenxvue0JOLu8OQ+Zvvev/4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr1G/evdCRI0KN+uRUUMfXdP0DbRpfzj3pwuP1sq+jQ=;
 b=q/qZ/e5ipZCZka0iQqUMgO/t25/YMmi14K6tQ6HZb9zE02yM8MaPYXO1itx6+qfhBCzeIgo9g7NgT4z79C+Xk36bEDLJMs6MuorVEOtxNdvanrKliwVZZ1cJcn03x/5r53WkT0yOPqGTLVhueb3BlRKYPLBk5Ybd6C7C5L35j7g=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 MN2PR10MB4189.namprd10.prod.outlook.com (2603:10b6:208:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:52:12 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 07:52:12 +0000
Message-ID: <4d8f9b7d-339a-49c5-9670-0ddd36d7d203@oracle.com>
Date: Tue, 18 Aug 2026 08:52:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] block, nvme: use lower-level limit helpers for
 namespace heads
To: Yao Sang <sangyao@kylinos.cn>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
 <20260806024658.4193386-5-sangyao@kylinos.cn>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260806024658.4193386-5-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::11) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|MN2PR10MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d28c118-44c2-4768-a80b-08defcfd9cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z5V/ZO79lBZJcLRhtQ65oZC7Fn5HNamUtRDuj4F+OQOe2ALsE0JmGemptRfypelz2bbZieUn2JzWrv7bpj3nudePcJN5ZKazFq4R0iI0YhtXku/L+O3Ut41EEWIQ1vCQtaFlOp3zNWds9LLiJ9rUPXPcdlHYIzHgkP//1ZijV6Pq5naPzz5V1GWg6ZaIQ4OI/GP1R1Re9Ij1lyj9M3v+d57neXNA2/OgN9AisMArlcIZglyifXsoKjtC0Sc4M87gY5GoOuWPxBP53k5AC3ELfIwM3+RVyKGXwBeG33r63osH0QGqJy3kAU7Sg3FWdA1aTcB2qjXUQyYnajDQI83XHJEj7JSsuoYI0fKMnEPM9LQ4LyADEEW+WrEiWce9ORGfomyhl7+VArmJvbXnBMnTpfyhW0Z7eXIX7Y8h0Zm0lrZIH3AZAtH63GPjVRmMXZwGBr8TpadVzedfNLLr72mhxjuH1l6v5Dw4XEIZGaJ4FIoFLEroHNe4euTTkRy+nDZ7g2R1F2el1EcKj4ObzOqbEqkASsOd8dn+y8yBYKjH2ceb20IAX/0kkWvQa8zshybHQEAY0QkIwhg66KxucyKgcDq2u0I9fhQFn4irUtoRgsH/2jhUwhHUBCtL+56Foeun4gbo/rfCAPt2I+8A+l0h6OJuPpt4UcJBGNR9P4n6XJI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjBHYlFPb1RiZzV5aGdOYk1SU3hGc2RvclNNMmx5VEY3TElqUm9ER0xLQXRN?=
 =?utf-8?B?VWJ3eE5HNW84Mm5kYXZubFZPaE1jcWpJSzRMMWFmbW1CQjV1OUVyajBGWWRR?=
 =?utf-8?B?WHM4cEZvMDFaaUorUTJ1TllJeTZGenZyTllsT2M3Qk5pNkNORSt2M0Q4cHRy?=
 =?utf-8?B?aUFnYW5pWnRZVHpZaFJmNndnL3NSbmlEMFovcFNkNDdETFVUeE95eDBadkND?=
 =?utf-8?B?SFNxZC9UbVdoQXBreENKNkhreUV1TjZwTmNJRFgvQlV1ak9ZVS9TYzZWemMy?=
 =?utf-8?B?TUJzd1FRbHZnSmYrTnlLcTFCc1V2QkJON3FuS2dkTlJvQW1NT2dsdHczWGk3?=
 =?utf-8?B?S1hoamd6ck1sb2xBMXVaa0V0N3p1QXhFOVRhOWloVDg5c0thRmlaMitFck5V?=
 =?utf-8?B?NTVUVldlVk5DZmZqcEtiYVlLczUwV3ZXT2t5Q0xJTmtibW40ZzhURUJDdFA4?=
 =?utf-8?B?cmhHTmUrU1RvZEV4UUdhMG4xV1hpaGhxOHRwR0YwN2l4bStmUTlwMHlXVjJB?=
 =?utf-8?B?OGhXSTNwbE05eURWSVFPMjJxakZYUEExeXZDZmhlc3FtemRDY1lDVEFsc3Er?=
 =?utf-8?B?cTdzQytoN1R1V3MzTlB6MmJJSlZXT2hvUmRteWw0UVcrQ0RyT1N0d2lzaE5J?=
 =?utf-8?B?eXJSSGswZGFzR05hdnlqL0Z3S0h6UjZJUHFoRG41TG5CbE1XYlZYaUoyQ3cv?=
 =?utf-8?B?UlBiR2FOanpuSjNMWkplbWtOTUpaZEE0T3R1Z3NQWE56ODBJczdJRlJxL0Ni?=
 =?utf-8?B?WXEzVjlPcTJxblBoT1hwSVlPbVpibWhYQUpCamMwL0Y3YVhmTFgxMnBOT3JD?=
 =?utf-8?B?VUZqZFZDN3dpQzcvQ0V0YkZSMHBJNVpyeWNQK1dGRTByalpjTzNVdzhlT3Fp?=
 =?utf-8?B?VzVsNWhGK08vUm1Qa1Z5MU84RHRBMzV4RmplR3NnUGVRdVFCZUc3WHJEdDdP?=
 =?utf-8?B?bGxKYjJtYnlCSFdNZjgzZ2gxR0Z3dXluN29QSVZoZDlkQWFXbWR1Mkd3QVgz?=
 =?utf-8?B?eDlKSHJ3dDJDT3BNK1kyby91aW9YQWhHbFU4dS9jS0p6Smg1aFl6TXMxVlFV?=
 =?utf-8?B?TGgvN0svMkpqeUZJeURNZDlZdGxVQitZZ0puWUlIdHFKT2I5Y0ZsdUdsYWU5?=
 =?utf-8?B?R2lmMTJHSDdQYno5V0dLY2tTV0srU3hSMFdqUkxoNTcvN3o1eW0zK0VmcFRN?=
 =?utf-8?B?TkRGMkYwdjlUbVc0NURRY0QrTE9kM2ZxY3pKVEdMdlRkTFd0QzdkYlpXK2Fw?=
 =?utf-8?B?UEI3RHYyR2k3bWNxN1ZkeFVTclpXK0xUa3p5eXZRUkRWRll1OHdpTmRzb253?=
 =?utf-8?B?T1pGSnYwVHBXQnJYWkFyVHpqTXgzTkYyR3FaUmtvYUU3aUpNZE1ITktTYjJt?=
 =?utf-8?B?Q0JKNlplTDd3L0s2VG5lR3RIeVpRekxTdFkrQ1Ewc1NIUmsrU2JhRzY2bzVK?=
 =?utf-8?B?dEE0ZDdISVRxc3NvOHpLcVNFb0crVlQ1VzFWZkJLenhNNENWS0NHYnJKSGFa?=
 =?utf-8?B?dkRuRm90N3hYQmhvNjlPK2pTSURrSjZOSVgwazNvZmkrZGJHSXBvRktVSVNY?=
 =?utf-8?B?Yk1pZ1o4RlZZRkFYSytsU043SnpRdFlQZkxGM200YmZGMHRrdEowVW1xbDRZ?=
 =?utf-8?B?Y0NqSlNHYzFxRDNiL09sWnB4bk92Z0tlMDIwQnEwRGprdnRKL2w1d3RLNXZU?=
 =?utf-8?B?RlRKRkc5ZG9UUUVieUVNVTJnNG1FM3JJNThhbmFaYWlVMTYyWU5KY1JOckFV?=
 =?utf-8?B?YVlyQS9HK25JeXJQOWs3UUViUVNLU3JsWForZ2JFY2I3R2d0RlI2SC96eTFi?=
 =?utf-8?B?aXVqeGtMK0NMVmJYcGxVMjRTNzU3UlcreU80M2JzVjU2bmV0c2RROXFhbmlk?=
 =?utf-8?B?N3ZENlJVdkMraDJyNlRTOEppU2ttRmlCcEFvZ3FaT0hQM1RlNzZmdXk2bmJQ?=
 =?utf-8?B?NkEvY3VLbDJNKzBqblVxSFgybGpCS3B4RForRjRYN1BLOUtpYWx2cndZd29y?=
 =?utf-8?B?NHVNMmdIUE5SQ1JsUFJjdjBrL2lNdEhweUh5N1lCdyt0QnZHWGhYbkxRVHF6?=
 =?utf-8?B?ejY5RERCR29ndWxLZDkwT1haMWNyMTRnQ1d1SCtOc2VjVTJSTUVNcFJtd3FZ?=
 =?utf-8?B?UEhrZUJGOGlCSXIybTFBdm9mYmpnazBWckhSZ2Z1U0VLeHp5bEw2eWQ5ek9i?=
 =?utf-8?B?SkczTnd0TjRMU1A0amdYUk41ZnJpWGZUbkNJOFMrWWpIL1pjdWxDclgvZkpN?=
 =?utf-8?B?eDRFaDMwVlJwK0ZneHhnQmlBdDk5TXNUa0U3anBMNHQ2ekIrWlc4ZXg3cVRz?=
 =?utf-8?B?NVZQKzlia3p5bThmdUkvNkNObjNsaW1JSkZRMkRham8ydzkxYUlnZz09?=
X-Exchange-RoutingPolicyChecked:
	ErkbBM+Muldg/oPmkGztBM4NN79gHmjQkcotPLYWI4MfKvQFRY6SZRj5qO0e944EC2Ef6/DcgJmn2DzFoA61p0sNsa4S0Z/hjZb3n92QC2+gHDBXuK/j1JfFI/3jn9xSP7LFbPrvamFV+FHy/JP1xqpCG73cjfxwa3x+0ZlSQjYbFLIIM59WviRwl1DhCFLSFIOrZ6WKYWlaD1DOIe/+7QEeeLCUK/c8ZEAcFLn34l9tGWsQIdJOjPS7ovbVIHQ41KWmk/eXelbeuDwVX2/tYfTCTgypUAz1D43ENImgOrr8EXGMhhaKUvdt026ohwI+A5fMx3R5AG8ePnctcf2E9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tjV36SXzboTmt4Yb9/5t2dxXTDBbWK+ZyuB6EdWxk1g4gV2qZC8pwcKLra1Lmcpyig+BIrPwZZ1mJjQbILYsH4SxdGGIpsmGxa374eWKgRFLFhGs2gdL5MFiUM0OK38+S5vMVxDHlOMMBg2qNjk7GnAlaBJ0kDrRsWK0NmY0Wv+dqV9NCSr/kXyxUCugEmDIlFF+pew1jBYH505t/LINrmGFlij4YmKZ0tDP0sHgkOoeiRu6Wks4LY1M1KRMirfdJhxIek5Our3LuduQ+98SulyhipAaGVbe44jmXeWjRS1LepxENp2EHcDMqqxfzHdgCTv7Hrq+isZJe/73u6c2cjhO80LzjCMuamdoHQt0axtbGcNefxsDSPrxYhSrWQL25Ma7uTkcZyfDJMQB7QypVt4qfV0WzyKrsHxbm8qqb72NflwQHC+YRuZ35D16/SWOrdGebeNH7IPMwSXU/Po4paITDySpwg8eEbuQJnZyP+bZPcHa1kIGOOZkor3+FVaXqacojw3VJ0AXnMR/HOh8PSX1YLUsrMJjG00Dy9iP4dnNGx13vWP+CQRVLCcEWcKZ+1A9rV4QtxLfUO6/D/ANDcWFP35RA/c/RhXAvU5h08k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d28c118-44c2-4768-a80b-08defcfd9cb1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:52:12.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlLPmh+X4Wo3ukjf0g1l7uL7WEqXzVzxKg6cBFyFg6zNYGRpy3G8n9IO/xiE4+3fY98lsjoWTfPvv7JZ0l2hXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=824 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608180057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1NyBTYWx0ZWRfXwr3cZqCruSeM
 fSeLFkivz/qbsRp0PsCbT+Dv5Cu9xGsO0xV/grrVCqUXqkeUil7JBm59sVd7TqrKe+JvKuypBz2
 o3Yq7yiSb+vQZJ4kMz1uyQrgWoRz1QeaIosCX2FgjX21wR9xhnfvHaAuosyFrfTupSAfeUWMUnl
 ZU1vVJwZxactTxZptdpLoBq4euGtaGJygfCDhXHd3psAaIpUKuH8ZLnVzpIDqGEYIHIZ47bXSQj
 CnZSH9BJmPR7HcEu9zOfPUC5Ra/2F176iM22fpm0f0XzJeH6pOsn7UUoMed/jxFVPY9mEgC0K5/
 Ps1Z1qQrYzSEsTbfk//PAOp94TwuRkDzwKHndLkocrH8cOV9YlH8smluH6e8L3C0o8Ao1nJoE05
 YMrHoIvxfJPIoGnzkuUGL4uTs4FthPVEHoPNXjzfII1C1OGZJ17+OqdUGxa+yf0VJYjmIdnwbTU
 D2ImtjqbbyMRUNUHrlF44BNSwmwrRj7lDzAe/aQg=
X-Proofpoint-GUID: BI_Fl9ALyzIlAENYfIDYOkEBy7iHSD_A
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a840f2f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=zqmjy4rEkjCe1fTbgmkA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12099
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1NyBTYWx0ZWRfXwEpslF3eGyOR
 em0AestWBEjjcm1+lSE2h6ipGB2RRZoSDwNDQriLTy/uqwd03mPWm+wUt9WfgVbsnEWv9CMmlxK
 sHK7nNxqGOo4NBAcicwNrIGObT4JFgSUYn+7ySV31P9XGIz/2t1K
X-Proofpoint-ORIG-GUID: BI_Fl9ALyzIlAENYfIDYOkEBy7iHSD_A

On 06/08/2026 03:46, Yao Sang wrote:
> Refresh logical_block_size, physical_block_size, io_min, io_opt,
> discard_granularity, zone_write_granularity and the write stream limits
> from the namespace that was just scanned. Keep chunk_sectors conservative
> for non-zoned namespaces because NVME_QUIRK_STRIPE_SIZE can make it
> controller-specific, while zoned namespaces refresh the zone size directly.

I assumed that in this series we would make the change to avoid updating 
fixed limits per-path, like logical block size, since that should always 
be consistent (per path). However, that does not look to be the case. We 
always call nvme_update_ns_head_limits() -> 
nvme_apply_ns_head_limits(ns_lim) -> 
nvme_apply_ns_head_identify_limit(ns_lim)
