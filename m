Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BE13A3F7
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969334; cv=fail; b=CWsoeOnQnSLAojquT6YTdaFTIVVdfr0PfQep6D75TWssNgLcsi0rvyO2FPYRT1AA8RfUu+jlIhujcJ5lKMIK4JwKOZHk2EHnMamYviSmT8lClrbSPyDYnYOeOfRUwU+/rhzlJywS1Vz9gxn9JCkKVGPJb2WxUkxBtI5D4EUOGPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969334; c=relaxed/simple;
	bh=g+dedSpcErQn5FOR9oF6vAEoLEhP0WJcXkfYNe5mBFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IR3KYgHCpkQFPwSfU3EM6+3K9+agQrPf9SX7PBrqa+tWY4BmvYfIN9yW437RB+JcEaiokgUE0/DU9AaqPBfsYCwNi07x4YoYvTUjol8t1aeiut39uUMVSO+XanJjeYTMr3CvkTPAUH6Q1DyaqovpHeyy4Suh0lpvxeL8BQ0Txzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KXldpFRH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mgsPii8x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KXldpFRH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mgsPii8x"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5689HVAF028761;
	Tue, 8 Jul 2025 10:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TAvu8heeajN76Ynl6SznaLRyRAZQOEV/NtXTtdR1hoo=; b=
	KXldpFRHZWb1AGJCIWhA6t4paYYM2TA9gwDZE8Q51akfrKJdRfnn+hPOEsbl0bPW
	MkeQ0m8BqOCmYNXvIN+fTY+xYe9LoU9NcW3DxxKaouz+0zhuqEfOQ41SiIbgW44L
	Wipw/jkQ00GrFpD/khvp9gmVpHxx1zWTJ4z2UGFe49KRT/3M+Xv/r/KvHM+eypR5
	Qy/9sNxwjSAm2bCtbOG5cbCTdTkfV15LDhF6Ed30xuYAJltTh7atyncaez1DcZau
	CfyNrBSoHdMPMMNPg8teEap7RCGSAun1f8qSwah7YSAD4+SHHL7xRf7Z9gHBjS0c
	Q3r1Zz2tGhuSyzfC666ioQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s0jd02um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 10:08:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568A34Np040655;
	Tue, 8 Jul 2025 10:08:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9nf8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 10:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLUuy9dGkRO/7dT6Psxo7Mzif+P+jeKyCsVEWSxpgNpkL7IYOkdd2s2yUqy4RqTu3raZ5Hy9//ltnFfbYFbNH4Nun7tLHOtKCRMcRMh6omo5yx1yyCjrgkrrcl9nSwLNyK1+fmOwMnXKqUo3SefyrCmAKYNzXfDzYqFkL3QYdHcR+iYgvmGLvvUNGQJHRKjUm0c5FE2RLxtdUpFupHFY/c/zJE7HoFqdZEYceBJkcz8STfDFcbih9gRw+Q7ud3mGiUU7KwbH6N3bBXsSpcu+MqCgh0F3rg29VmXO+GxSIEu/zQMOwOo/MaKHcgOG8jHbd4gMZ57EnPUDPW+A26XNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAvu8heeajN76Ynl6SznaLRyRAZQOEV/NtXTtdR1hoo=;
 b=IC+2RnPE2aLOvH893sJ/JCvjmpPaXGtqX0YTBWgY/V8G49RN+0DsmLQSgAIjFRkkXKjMGSXuWFBKwFZ6nZX7IKtFykRaxcg6UI1vKthK2Ejeif4b8gKI4/ZI/2fV/BO91vIgBtbkKKOUCi5jPDTCoUAs77bUkO8i4jYb/YJtDKtuJdPaHZFiXOKtw56vsKRozGkXWx2gqhUnFpjO1qNKStFOoNNIkdaDzfQDzWVQpqhJJw9lPPhlehfqfyvZtsFVy1NnLQBU54FZsU8ZmzbPvAZh8zAin5mez22y0IRKuQ2FMb5IS2MrhtqJg0tXqqJkIMLMqLdYsvlwltoviU9toQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAvu8heeajN76Ynl6SznaLRyRAZQOEV/NtXTtdR1hoo=;
 b=mgsPii8xicQbcBq0RIADNRI0DobzF2xdMpUiaKNYDlmDG+F6Et+duAqMsCIT9nzFWUuk0pLXHsrGNARdyu5tNZjENIlsyCHl16xlpsqHQ/RxBEMFWlCLq1IVIr2yyLhpcj1Lka6aKeqoJvmbD+9/CzowMbVibXImSgp9dS1+4WE=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY8PR10MB6729.namprd10.prod.outlook.com (2603:10b6:930:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Tue, 8 Jul
 2025 10:08:36 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 10:08:36 +0000
Message-ID: <4d7650b4-a0c1-4988-a886-e0431def7844@oracle.com>
Date: Tue, 8 Jul 2025 11:08:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        mcgrof@infradead.org
References: <20250707141834.GA30198@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250707141834.GA30198@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::32) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY8PR10MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a1c98e-7b1e-43d7-158d-08ddbe076751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWhxY1JMdDh3Y1NscW10UFE1dC84TUw2cWxMS3B2MlVJUGRyRUJqRzl2WFQz?=
 =?utf-8?B?RG1aSkg4ZHZDbXlmU08wYVY3QUNIQ1NUTzBJbjg3L1VLK1MzWnp6b3p4K1ds?=
 =?utf-8?B?WE9LSmpicUJuMUlYazVDMzlORm1Bakc3UE1DcXNaRUVwQlJOYTBNRk44TVR5?=
 =?utf-8?B?M3NLc1VwSHdYRDRsUDg1d1U1Yk9DaENabFZZMDNpa3FVMnlvRjJPZS9rR0Na?=
 =?utf-8?B?QnBKd0VaeWh3aTYvZk9lcFhiU0lZYjgxRlpDMnVHN3RqcjhoVmU0VkdkeTZz?=
 =?utf-8?B?TnMxaWdsS0VIVzcwZWNVUnFSU1Ryd1ErbmhObnBIRno2ODZPNVBpaU1tNzlK?=
 =?utf-8?B?MkowMmFzZkpuQ1F3Qm96MkllbzFJNDg4MlBlQVp3V0Z1QUJlczNnWWtsWHBz?=
 =?utf-8?B?U1JrNHdBQzZVQVVoQis3VlhheGRkT1RqUmJUTmE4YVo1dEhEVDU5QzFaSjVm?=
 =?utf-8?B?OGNFbE1mQWlCOU1qcjIxVVpZTWVnR1FNWW56WDJiSFRTNVZFRzlxOENyeFIz?=
 =?utf-8?B?NHhqSVQvaG1RdSt4OXRCN1JqNTNXaksreFQ3YlRBYWkwcEtWc0dNa1lGUG8z?=
 =?utf-8?B?NWtUTGcyVHZtZEJ4cmVXRFBvUzR4R1d4WFFqNU9iTFVZOERvWHF4Y3hJL1l1?=
 =?utf-8?B?VEFVMVpBWW1Va0xNMDEzY0c4ckFtS2xnMGYxd0sraEtmUHp6UmpKVnUycjAz?=
 =?utf-8?B?OVJUb2JMallpek44SVN5RjZDV0MyTWM0ZXRiOUQrKzlSb0hacjBFSTdpVjNm?=
 =?utf-8?B?SzkzeWpHdXJweVJhYjU2bGJ4eTI2YWkxcE1nZnQvTW90clNPYzdBeUZ4a25Y?=
 =?utf-8?B?YkJYWElOM2J0Tm5PNjV0VW03TFY2U1pNR1puYUVrR1kwVXFvYUhwcUU0OTUr?=
 =?utf-8?B?eTBrYjc5U2JuN0prNHd2SWY4WTI4UTlORGdxS20zTUtqQ1pRWVdPVTlGTHZ1?=
 =?utf-8?B?QTIxenhlZzJRaWNCR09JUStKdENpUXVMR3BzWmV1SVlUdVJpSzBLZ1dNOFc3?=
 =?utf-8?B?NmlGM2Fsb1A3Wm1Ma0wzc2NFNlJJZ2pRRkZITE94WVd5RCtRSU5CQVBCRE1O?=
 =?utf-8?B?TUdFQmhHVHBFbExhMkRieVYzK1E1N1BRK0F0T01pUzJRZVRoR2JRNjNUcDBx?=
 =?utf-8?B?Nld6U1lmWmdNam5YQ2swYkJLZnlkRDR0UEo2azdTdEh6dTNMZTkvRzR6aHdq?=
 =?utf-8?B?aktRa3hVSng4eDY1bk9tM25NR29vdWloTG5aMkhMaXdBeHorWWZPYzJWUHNG?=
 =?utf-8?B?dnVRcy9LRTl6WEswUVNYaGR2SzhHZmo3eFFLRWI2OTZsWUFJNjVDMERza3By?=
 =?utf-8?B?bTRBWFlvcEFqQ1V0TGxWOElFbW1IbWY3NWdER3NxVmpwSXpBV3JPY05vTXln?=
 =?utf-8?B?b1NXMGhIc1I1QXF0UjVhT1BYb2NneThpV1FNUFBHMUF2L3A5dlV3dmU3WTQx?=
 =?utf-8?B?THo0S2tjY2dSOFRnSEhYTWZ6U1dhd0E0Mk94UjdXNkZhOTlzdzVoVmwyc0Jj?=
 =?utf-8?B?Uy9HcVFVZ3V3MHgrZTI4cU1CYVhYMVR3bkNIdGw3SmM5YTNwdFA5Y2tPRTFX?=
 =?utf-8?B?bGFkbjR5R2dNV1I2U3c1M25EeEZ6b2tqb1BNMFZ6YXdoMlVVMTRWQUJxczhu?=
 =?utf-8?B?WlM0TUJNdkM5WXVvMUl6VzYvUmRTeUtNcDZqUjJWU1ZldmVSWUNVNDhHbm1i?=
 =?utf-8?B?Ynp2bTdnYXhFMXlMSjFPM0dHcEhUVllHMERsYUMza09raitCK05hWnJCWDZI?=
 =?utf-8?B?T0Z2TEpDSWNjVFhqSmRLdVBZV3dLalNUOFZLRHVlTGMzaC85N3BROE0xN1FO?=
 =?utf-8?B?RUwzZ2ZxV09GN0gvenh4R05vVG5xT1E2TTZpUTRhVjdJNjl2MHQxdXluQ1V3?=
 =?utf-8?B?LzNQeGhvOUtyTmhZVmJ1TkM2ejd5aDUybEgrckNxTnNxeTF3Wm9iSjdXbW93?=
 =?utf-8?Q?tm17cDhN4RU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHg2RFZaU004UndqVHE1YVdLZDBONERMZTdJWGVseUpkV1NLb2lzL2FJMU9v?=
 =?utf-8?B?WEt4NVU1dVI3enFVdm1Zd2xnaXQ4U29LSFBxMWVlSVJTQ3VGM3NhN2VmaDhJ?=
 =?utf-8?B?NStWNGRxL1IrVzZaYmM5OXdkR3ZXV1d2d09weERPd3VFY1d1UkVadFRVbW84?=
 =?utf-8?B?VTB3Y09QYTJXMTRnRHFDMGVZOWQrRTRQWk1lbStNRm45VjcrUmUvK01vMmhr?=
 =?utf-8?B?TmNubGZQYjRicFJ5cFZWSmt3aXZIWEdBb29BWjdNL2diSE1mQmNXdWE1NWVp?=
 =?utf-8?B?empON2Y1R0NzYnc5a1pTNllCeCs3eHZKUGcxSWVOcTVBYzZQSitnT1V4bnpa?=
 =?utf-8?B?WXhWek5PQXNjOWRSYmlPbEFhV0hLanlwVlhPNUZXSDF5OWNsS3JSQXRqM2lL?=
 =?utf-8?B?eFJlWjcvK0JUVUxoc1JiQkZQTDVCb1lMQlUxUFhVYjBqdVg5b2crbkFHb1N1?=
 =?utf-8?B?bno3NDUwSEFicVBTZjBpWjVaR2dWZm1XZGZxTDdvOVpJUVovaXFZNHBma1FH?=
 =?utf-8?B?ZkpyZ2czRGFpSmJrR1I5MHlReFowMzBCNkNXMENLNnFHTWZpbzVWN2pXT0hN?=
 =?utf-8?B?MzBBMGZFQllWc3FscElQZndKQ2F3L0dvOU9uU0pFSXBYRkl0WVJvTzFEOXIx?=
 =?utf-8?B?bmk0a3JMcXpkTE9aTXJMZWljeHk0K1JqUEZBUFdQc3VBcmFWTDR1blhNeW1m?=
 =?utf-8?B?NnE4eVJlYlcwajc2Q2hOU1JOajE2NDdPc3VHaEtuWFAvcHVpYXRBc1E4NkI1?=
 =?utf-8?B?NXAxc1lrN3VDeWtmUFNrR0p6a01RaXNsVlRmK3NTdDZlVVdNY3NRYmdPSWlo?=
 =?utf-8?B?Z1FTa0c0bjNoV1RxOE9RQmJ1RzFCeCtGeEFOLzFza09mWEh4enFBWkI3YzF4?=
 =?utf-8?B?TFBWRTV1cFY1eDljWVZpMEVDS2FNK2pDM2w2RmpyUllZMVd3OEVob2w2emhF?=
 =?utf-8?B?blVEY2hLMFRkT1paSm1XOHQzNnVmN0o3dnVCY3B1V3IxMml3QlMxOFRZRURP?=
 =?utf-8?B?VlQvQU10b3dIRmJJN1BJbXdCYkVDaFgzczN3U1pGNldhdHZzc1RITGEzWGQ0?=
 =?utf-8?B?V0dOd0Y5cjRsTjYxT1g1WFFUejdGL1E0bjNZQ2FOaVNFWWRyejZ3cDVPQkJB?=
 =?utf-8?B?ZGdWTlI4OE9adnN1ek1wdTJTemdlVlVrZm9aUktwc2p5RDBDZVI5K1FCY0Rw?=
 =?utf-8?B?NFZDbFFpSmVmdVBQNVA4UjBBeDdobmlsUXBtbm55L0VxelJ6MXVJUlRCTEIr?=
 =?utf-8?B?MURSZGt4cSs3cGNvQzdya3B5cWFMbVJGWDY1ZzFRMUc5L0ZRWjlXS0NQM285?=
 =?utf-8?B?aVZyUDlEbzVHamdMVVc1cWx5Q1Q4bDd0TDNvNjNURTdPd0hjUFZpU1BZY0dK?=
 =?utf-8?B?bDZKcVFoNkF0M3Z6b1ptSzJTdGhuMllNZWo2Z2t6Q0RKUU5ESUk2RFZmWUVB?=
 =?utf-8?B?c0RxeVVJWWRjaHhLbEw4MUVjSlBnWi8ydVFWeW1NdWY2V09yZEZJTTY1Tkhw?=
 =?utf-8?B?SVhhWURaQTZWeUNxM0crWTFlTHJ2VERxQy9jbHpzWU9QUFdnVDJBb2RjTGdP?=
 =?utf-8?B?SElhdnVQUHpEazArcnVLQTh3ZURQVkhCWENxNDNEUTNJb3doQW9SdHp2Zkk1?=
 =?utf-8?B?VFVCNGc1WXowR1lvZnFqUjgyY1JJV0d4SUhsdlgrazZ4bDBqYU9nNU40Y1BP?=
 =?utf-8?B?eFFKUFpiOWl0VkJuazRZN1M1a29tL21CS3FFcDRUZUxGUS9yTzFOSGd2alIv?=
 =?utf-8?B?aWlHV2REYWErVGZ3a3lSVlpxTkxMVDJqbWFwd0MvSTNrQXRva0hYTTZtdDhu?=
 =?utf-8?B?R1VkOXcwdmY1WUROdzl3UHdQeXFkczY3RVJJU3k0TEZTcVBJRlJkWVVhcnZQ?=
 =?utf-8?B?d2pkTXNsTG5sV1ZxUlBGdmFUWkd1YnEzK2tSajJVTjVNampaY0hwSitpWmQw?=
 =?utf-8?B?NVhBY0dkcHBiTDVxRFhYeWpxVzVNN0xXTVk1MVNQK3JmVWhvRTY2L3ltTzU5?=
 =?utf-8?B?YjNlZFVvV2JyZ2hGNjl5dXVpbmg1UWttMHNQNWxKVmFTd1BkQ25YU2ZObUhR?=
 =?utf-8?B?OTNSL2pCMldLR1hlemtWdnBJNmduaVVQNjBCajVsTHJ2QnJBdXpuQVRxcUZJ?=
 =?utf-8?Q?U4Hh3Fw7QH25FKJ07yntpbg7D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kagzA2i6bYWB9+HS3ME7Z5kOKxv15pu1yq44oc2NGvqkX7KBwInEZ/QzZfZEPOvFhCiQT5HrQrchaUJTwbtu72AMNW+rcvdGZXkIlsSWADl6FJs1oldsEj3o5ZpA3LUb+T3ASv6H7icKV5V6EGKdwgwMcN8ZW6+7V/gwsPv9UhPL+vn01aiePBwN1lShzxK2/SzrPLue1KiazjHCXAzKmbhWp938w0twobaRDuuqMVKZ8ZcctJtxAmkgaP73eBcy7b1ah6C9ZZTEnW161Rz10DLGJCS1uHMjH1TtvDULLuiNl/O6d7MnBdg24A26DiSgxnPyECEnugrAbnP9uNWWd/nwvz8onhJPlGbdbm50cy/6eRH5RdOYG23a1Os/c4pK3XthEs/a5yedTuq3ZVSm3oSC/Nx7omTC3g2Un5I293PuQaq4mRH7wFZejQAFe5duvPKeh9JGDLMyO2UWN7hPtJl9gj7WPgbuMLkuzVdGv5vLz0UP65TYYzxT/JQmQYbRbUQQzg3hARk9+dMcgy27EIOer62oMIRh8fptekEe8nj3hkuDw5YUEFEMv1mNdyVnl6h0S1AfjfkXv2ok83D+IPNifUoY0sIBsX3aKQyRFK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a1c98e-7b1e-43d7-158d-08ddbe076751
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 10:08:36.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m44HcOscNG+VUFgW6frrQLVuVgqnfoKsDO0teCMMJnXuP3wG12DJlxDHCkeKIck4VFEbcnDS+bCYxUTyzMeG7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080083
X-Proofpoint-GUID: LJqVrHZ0gJ731aVd5EgM6qv7qEFMbcWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4MyBTYWx0ZWRfX72ZmWZKDFGnY Z8/5FXH9R7O4+4tIctKzjZat33ieeQCsGav1np9ZJUkIcmRlY6lVkNbyMv5ZfxfTT5IZjyglqRr +2W7S/BrU+MigabwRwxfB9BAm7aSvjNoLSLEtX8t6Ty5KMvvGMRX7GIxT9ZpQVnSWCzkSstZLqN
 +6zqQ2zut+5/hygFhcZ8IvlZnarTNTeiB2/B+TwuR1rIYWXm5gWDMzUlXbCHSi4EEIce7JOCFCz ueUG/fTKSO8qWxe8NoLlk/w4gaBKTwpl3gIPY/1K4lH58a2KVEqd92nu/GNXPQVdFx5iq8c7JfN yEJV17JKqDc1tRhoXWV4i+MH7QJ2VGsrzYYrbNDNIUBFHNXWF0dkNMcHE3bxQ5cMPoPvH8uRKSz
 Qu9AFl+Gt2mIV8uQ43nHd1aZ261QU40/3J5QAoW13KEfS+2Kp4w2SQLvwtGtP+OrcQVlDFZJ
X-Authority-Analysis: v=2.4 cv=Lq2Symdc c=1 sm=1 tr=0 ts=686cee29 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=I5r0CxplrSDLCy34:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pfleYRJ_qRmfgFO1rC8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LJqVrHZ0gJ731aVd5EgM6qv7qEFMbcWy

On 07/07/2025 15:18, Christoph Hellwig wrote:
> Hi all,
> 
> I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> 
> As a short reminder the main issues are:
> 
>   1) there is no flag on a command to request atomic (aka non-torn)
>      behavior, instead writes adhering to the atomicy requirements will
>      never be torn, and writes not adhering them can be torn any time.
>      This differs from SCSI where atomic writes have to be be explicitly
>      requested and fail when they can't be satisfied
>   2) the original way to indicate the main atomicy limit is the AWUPF
>      field, which is in Identify Controller, but specified in logical
>      blocks which only exist at a namespace layer.  This a) lead to
>      various problems because the limit is a mess when namespace have
>      different logical block sizes, and it b) also causes additional
>      issues because NVMe allows it to be different for different
>      controllers in the same subsystem.
> 
> Commit 8695f060a029 added some sanity checks to deal with issue 2b,
> but we kept running into more issues with it.  Partially because
> the check wasn't quite correct, but also because we've gotten
> reports of controllers that change the AWUPF value when reformatting
> namespaces to deal with issue 2a.
> 
> And I'm a bit lost on what to do here.
> 
> We could:
> 
>   I.	 revert the check and the subsequent fixup.  If you really want
>           to use the nvme atomics you already better pray a lot anyway
> 	 due to issue 1)
>   II.	 limit the check to multi-controller subsystems
>   III.	 don't allow atomics on controllers that only report AWUPF and
>   	 limit support to controllers that support that more sanely
> 	 defined NAWUPF

This would help avoid the ambiguity in whether NABSPF is valid if nsfeat 
bit 1 is unset.

However, it would be nice to have an idea of how many/percentage of 
products it would affect today. FWIW, I only have 1x SSD which supports 
atomics, and it does set that bit.

I suppose we could quirk known "good" HW which relies on AWUPF (to 
enable atomics), but that is very far from a nice approach.

> 
> I guess for 6.16 we are limited to I. to bring us back to the previous
> state, but I have a really bad gut feeling about it given the really
> bad spec language and a lot of low quality NVMe implementations we're
> seeing these days.
>   not the

