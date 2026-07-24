Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0E392C48
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877023; cv=fail; b=K8hvSWuAVa0/kzJx3B6oeX/t5bNCaxmD+UEG9HxTpECs3hfGB3/hf4JJZqkbKIosC26m+ukx3PC0oFIXoaFdUzsdYjGP2Da3OzI4IJiNLrsd0Sn+qz9Zss+O7TpvoceafJGrWQHaoHvtHnBdBqfwdXR/6A0yTLsLhLanjcfQhgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877023; c=relaxed/simple;
	bh=nELN3jva/CoFNok2U7zLcpBWMNFRxOoKBuomQAbH2Gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=LEV8mgvyJ+FzeXpp9jgVaZAF0DTaK+EpBJz1ulbdJjeJ/Hj4AJIZtqTS9mfofNehKA7dRYoDD+jsdj3FTqNEJSUJkiRnCtSmQkeeEz4mQMcYsebBbV3N7UZdXotsuP1d0ovWwVrkMkq97UFCUOicZYbi81vqamUCijBglGGnRuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hEMxCuhA; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JbtzVu8K reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEMxCuhA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JbtzVu8K"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O0nQO32162130;
	Fri, 24 Jul 2026 07:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nELN3jva/CoFNok2U7zLcpBWMNFRxOoKBuomQAbH2Gc=; b=
	hEMxCuhAyE39RIN5XrtiAzYo8FCpwQhnK9nB8RX9M9OWvOGEpIcEYqaXfwitIJ95
	c66Tmva4xJB9TsuDHTQGuAHWyMzhyVYCIw2YhnFJ8h30LMJl0qNgSdqyeu+qcb+E
	zyRCJbz1ycXGbZ+Hw8evpcY3lOgO8EjWZIK+xKtfJ1/6OJnLKNfF9p9KAiHNwjjC
	3PdXIi00gB7DQMNRuT3SGVSCV/pr6gTeahDg9pDMpQ2+7IAPOpAQSr1zjbUmTgNf
	bjqtlcsDKgllqqb4na4BVybBMJXmgP4JEKJ/gaq2/GYxCcFs1UKk5Zzk432o8e9L
	G2YQ8C26iCa+GA8Ks+j/vQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1tk06sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 07:09:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66O73ALQ005376;
	Fri, 24 Jul 2026 07:09:56 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxfq175-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 07:09:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olj4Hp6MAXmvbX5CENDEJUh/HMchAI3DxqYzcsDmrWCd40DxrgilpMq/+ePd1uJdIqapwBpz4KHbNdew0ImE3VeCEJpxtfr4B8+wImUrkqJBwG5xScTx/NedYpW88q4F5lgW5SJdGHfrj3HiDLSSSniyQhzkkCPOlMEyv427cGpSLhVikcGJPL3RTaecsRHMhPsQxTxZb8Zg67fCcsiaWlen53Fyx5wh5ARS+r5DtaFVI4BCBTyxWrGZN+H7Se3Eo23MzSYEFiqEktz2k+DsXSRLkMnIFl0JXWwyZ559PIGVGAdMAjdkrYLx8EJXB5kACB0nAfYdTQVD8/avVKS34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH0T5GJVYKt+3RizQsfJ0mafWqrQuI2cigqCep+s1Zk=;
 b=nGUNnNimzkjSSCaKOR4w5yP4wXbsLj22rqCXyUbZRjcTql5HjNvwMegihqMggZFEXzFesgUA3juIecAzdrqpG4Ht8mcUyCE0IzumPt/jD0n/neW7cI9il6sBK2Z6zl0pFbZhmdIvTQmeyUQVWvli65kQA0QKQbPdm9l2EPKyileqLAwrVkGcSnPPn25mUGNqxX9s5MisC2wjBHZBUebrRgIscg8zGDpgXPSsr95A6c5xZyKNsB4kxxGZRGwQSRIGBwPHN8HNWEr4QzhkMn0WM/Hlbg/o/y/F90+Zn+rqSr2V/ce7/4xNDybtzK9OcHTuLKlu1Gmg4+EM5Bgnql/V8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH0T5GJVYKt+3RizQsfJ0mafWqrQuI2cigqCep+s1Zk=;
 b=JbtzVu8Ka7Rq45u9SO87+5H12vBrYBagpfoL5Yi+Vr3qM21LGCUGpdq/CiqjeGJU/TFb0sumG67aNzrTZAwseQzBBLolV3kkWBfUg0qKa6X6cxOJCndC/JSpFPhUkw4q27CTyLmq5yAZtYXlPK8B2hzq9u56fQglWqAGr99U+dU=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Fri, 24 Jul 2026 07:09:54 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 07:09:53 +0000
Message-ID: <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
Date: Fri, 24 Jul 2026 08:09:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>,
        linux-block@vger.kernel.org
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260724050152.GA3680@lst.de>
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ad9cbf-5206-4194-2bb0-08dee9528f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|4143699003|22082099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info:
	bJAy63J6r9vcIh987MKQLQQdF0KaZ59SJj3BlVfqOBR3MOj/grvcqbhEjWD3zwOrba5VKrnstsT8Qmaz7GES9woP6+L5FVrgzsckiDdF8Aa1IsgiaC6MWSftzqsZL9WZ4QoT1b0vc30NMNakel+9qWQNFolL5Ur+rlJXJ8L1oSErHk+2cueAl++qwPXdQ+sKE8UuiHG5C2Hct16bbsoVIjpZY2Kwq8Kx1uncqqmyyQbBPJngBOdrUZ8F9UD91zloBuue+WM/GizFk19aZ7lJpa988NdhkLL6+HOCQlCre0NVVTuWlQ1wBFJ+9MCRW2Nfhe/i8+Q+Ks2ze2A/Bun4aUFcpsMFJ3K03mK/kOFdwp9eYov/OULIuxRhfv0RqEsYLYx5h6Wa6vk5CpIBOsm6iFK/QV+49Wt+1atIi0INvz89loX4h9nRKffAtIcq0O9iGmiugsaUeV1SeUnRtxE+gV3vdtA4LBmQCucWY+WKKxzRVVHpLp0r8vGLPl7qTl+EeViroY52rZvaEh81hYTMIMovkCIuqwcsa9LjnQ5Ca6GdWKyemEKg2cghfJNhfLzzLAQ+7XKJi/ZshLseeXxyihnnjUAgwUcUVpBaMMfgy8U0xr28yqztsW5jK+vNBpr9ZLZvtKc5N0OoRbY6wyoPCFWIaPoVjrGFvkZfq+TBbcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2FHd2taOXBUdXFBaDhVaFJKbW1XVElSMjJ6a0MvZHJ4UGMveWtHUWRYWGtu?=
 =?utf-8?B?c1Z6MlQvaGpuNjFHWHc0a3F3bkdIS0dHckEyOEJzQ2J2Z1JEU1I0QlV1TEtX?=
 =?utf-8?B?c2dKSVRjeDZRb0lCVnZqbEMzdm53V3NEblh4Y1RJVG93OFJITGtMZmxKbjFY?=
 =?utf-8?B?LzN0UHVVZVFEWnhoS2FFZnVIWHZtNGZMdUdNWUNRZFFZMEd3aCtXQ1BVeWJw?=
 =?utf-8?B?aEw3RExqb0V3NE1SREtnakZjTEZBVnl5L0Vmb3ZOTVJSeDdwbHJuN2l3bWxB?=
 =?utf-8?B?dk1ubitKN0VHQTVjWU13MUI1bWtwVnE4QlFaL2thT1ZtK0l0L0MvQjNiZkR1?=
 =?utf-8?B?d2ZYb1NHRU5HWC80MlBEbFVXbzQ0TlRSRVdaaUgwSkt1bHRVbDRZakg3dmh5?=
 =?utf-8?B?dWRXcFdlM05LUTdBMmhDRkp5T2RaOTBYL1lwcGpJejQwTkxqWXY5RGtvWVNu?=
 =?utf-8?B?Y2NCemp5Mi93bEZpZlBZcmZLaWNZNFN4NTdwejBWcys2Q21vQ3EyZGVPejE5?=
 =?utf-8?B?SE1CbjNyZ0d2Rm1kaWJuOVRJUjlleHIwbW8wTGV1R0dXdmoxdHRuZGp0VVdL?=
 =?utf-8?B?TXQ2VHJ1ZG41ZFBEV3RKWDdINkJXVzFWOFgzcDA4Q3hiRk82MHlSZGV2OHA5?=
 =?utf-8?B?VUQzYzh3MkNYK2FPL1V4VldZNzhqVEExeWFVWXhHOEZMd1FEc3dDWENQbVll?=
 =?utf-8?B?Ty9QeEd0VzllYUdPOGJHbTVYUUtDbFRqQVVLaFFycU5NQXB6SXkyRjNzajNx?=
 =?utf-8?B?SmE0aHMzTUovbnB1SitnU2FGT2NCRTBqVGtZM25hTDMwdTB3QXMvNnN0S1Fl?=
 =?utf-8?B?cmpnbXNoRzlDdmNqUTJVRWNIWkp2S0JWMmRFK3FySFR0cWdoT213dUVEaGNO?=
 =?utf-8?B?Q2hOYzI0a3BPS29NSFF4MnEzb2hrWWJnNmlBekJIVTR0dFU3RFBRa1BiTUxK?=
 =?utf-8?B?bi80QzVwK2lEKzBCengzdzc3NmZMSlB3aS9MVWdmUFJaS2hZU21BQWtHNVpv?=
 =?utf-8?B?MnUybmNiN2w4YllvN3ZOWURiSWVSNG1nL203NHd0NkxjYVNNNXFFaWZDU2k4?=
 =?utf-8?B?bG1ESWdidmsxdFpVWWJHdVQ5bnZBZlJSc045KzQwMHVHSjZzeGFWT21DNjRZ?=
 =?utf-8?B?RUtYa0hWc01IZmFESFdCL0RsVXBXY1FWZ1dnWllOK3pxSk5Hd2wyL0xnTEw0?=
 =?utf-8?B?Vko5ME5nR1dHWFlpNlQra3dZd3ptR2JwMnJ0RDRVSXAydzk4aDRid1JqeWRo?=
 =?utf-8?B?TjFIdGNsU3k4Nng5ZUZoRGN1endOM2g3MWF5WnFxbW1MR2NlcnhZYXhhUjhJ?=
 =?utf-8?B?Qk1mWkNDZ0RqTlJzSHBUM0h5Nmp2ZmlzWlBIR0t3M1VpVHZUc2paN1hOemRF?=
 =?utf-8?B?TEd2RUNvUVVCaHFDWXNvR3lWKytnNjNMK1JDQlRVYXdFbGt4a0hZOXE4cXQ4?=
 =?utf-8?B?b2lPczJBL3UwNng2STRUMFhORmg3TDZKT2YxRSttd3N2RlZhakJnT0Z4WWJ6?=
 =?utf-8?B?dktMQkFCQmUzblNhZjhuUWRFUnBrME01VUN5UVBKU3hucjBNTWxaN2dyRUhx?=
 =?utf-8?B?S2tVT2FyY0VkT3RLL3lnYWJhN2NTRUpRejZjTUhJWUpsUUlpdEludEloaXBu?=
 =?utf-8?B?ajNEckN6cmhhbTBGdW16aHFaYmR4NE9yMVl6d29UMGpaNnlRM0pjZC9Ha2Ni?=
 =?utf-8?B?WHdTSlV0alFkcXZsNzJXTWZPTDFheGNaMWRQSkR4UUxycVVCWHJKSW0venJo?=
 =?utf-8?B?OWo5Vk1CeTJYMDNPcEJWR3ZkYTVaQzYzU0VrY21mNGp4eHFiSTI1dlY2eksz?=
 =?utf-8?B?dHlYTzBJM1kzSUQ3QXpXVis2S29pNzBhT0VvV2ZDTjI4UFVkalduUDFuakV5?=
 =?utf-8?B?Z2prSU1paXZMZW5OUzRIOGo3RWc0YXc0aVdHcnVqT3lUZmlQaXIzOCtraGZO?=
 =?utf-8?B?Y2w5dEN6Y1NxYnpLbERvbjJkS3N1UUIyL3BjSFk3enlxdDc0VmpVUW5TQ3BU?=
 =?utf-8?B?bFVrbEwvTnFRbVAzdHRxUkFxWGNLZm4vS0dhdm5XZ2FvV0VpdnlpN1cxTXE3?=
 =?utf-8?B?azNueEhpZWszZWJFcTZrWVRHV1F3T29mWnRDak4rU08rUE9tOUlrUWVoTnJL?=
 =?utf-8?B?cXd3THhseHhEbDViN0loSnp2SFJzSVhoTUcrRXIrS2NXeWlFclNEWEFFeFU1?=
 =?utf-8?B?SnNsSXZTcEJCWThRT2dzUEVjMWV0R2NqMmc0dWRsdmJKRTRLT1pUZU5MQS8y?=
 =?utf-8?B?ZFZIUERDVVlENlp6amVrbXZTaXYzcE03YjdhaUdXYmVzaE1LSytXWE5TL3Y1?=
 =?utf-8?B?UVh5UFlYRDZVMUI5TkhYVjY5dDJwZndHdStwbm4waXNPZndzWmdQZz09?=
X-Exchange-RoutingPolicyChecked:
	QXlBjja5FLDow0Q65PUrOp6zEUSXejNLskszN5SkLe6nWrFd5NXeadR6fQ9dCJB2kyy8qyAoc9QrjAiQB2SjjGB4XOqlGh6wgRDe9B43jCOYryOdm2vieF9I21b8y2Nh5+HGfgawJBY5nl7AT+1vbaNsAmwiwXLwweEDEDiY9UYPwXxC/AwYQFMuNPZ1FK+WoGUu5oLVrl1NDsQSmw2TBA0f/XE5F/QtvchCiEzr50J8gvd92pPH/xdidkUvJy4LzNaKlrj1C6xYxF+qbmetbT/NrGtkLqgv+Lk9b8aAeriDOa8ZDVMGFGZyoCPSUgjqm1GQUlKMCPnyn4DSp5SYYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7reC9k6VMQp76lCrBx1v1uyRN1XEi29Qm0jD8HHzI8LWiAYn5yAqEbgPqG8m04DHbhX4+P1QqmT2lcFpZs0WevkYhPGVLFYnpEx7L2SPChAvhlzns+eTR/RR7uk49/w32uPqkSRCQVyJFRNk+uFP8WMYYyJYART3owly57ioNmIH6NjFW7gJFs6hAUl2Q7v8Zxjx/yxr43Tk85O6hj1Ld6vZXrJwf2M3kTlxwK/N5ccazDwJ7QulK6doE5Xd27XDWwwH2C4paK8l4ZMZ445aCGzIDJGvI2ByKjblBcy7aOpJCfDFKhAL3HEmtT56/hD+ePTXxJ0QI2HZm/Iz1Bu3i1wwwmaTuDmYiqtCRUyBvRESl7R8synfJjxNztcvwjRHJoDoEse54LWcPtYOU/z31Ox7iPrN9AHyiObjo9jVEJrU83I5wHi9SLzj1aem0IRaDMXNIWp9vJe+pMz7FSAPM0eD+4xs9lrlOvpHiA3rF3BsINmIHX5gF/f2qGwVIfmrw1cD6i7qILCjzEZ334cP2lrM5q/wPJSuGMZLeatBriEdMLXthNZKfVn6xgDioTIADz5ZK1IG93nIrC5lKyMslai7WhinnycSZ/5VYJUdUFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ad9cbf-5206-4194-2bb0-08dee9528f6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:09:53.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwAprhKBHv9d7ByOMz4xQV7HL41hgsvBChgc2oiYV5vSjddM36HWO1CXSlRCfM3KLndvhoNb1bEF1hPv8a0XtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=921
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607240063
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=TN51jVla c=1 sm=1 tr=0 ts=6a630fc5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=RpNjiQI2AAAA:8
 a=ZpLeu3NvKOF0J3WGQBwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pG4XhbJivbIimZd72pMBOSf6h2B2pvH6
X-Proofpoint-ORIG-GUID: pG4XhbJivbIimZd72pMBOSf6h2B2pvH6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2MyBTYWx0ZWRfX8YkURSu1K0E3
 /+xz/BkoHRipyYLANCDrEYaQAiWj+H/2uotSYpsoIarkKmmZhPHOv8BSXik7ungqKq44c7OYuLR
 5UcdqFE1AHLglLMoQRuvKBewAbCWO3UCf+CtAapB3hDoPtC2++eq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2MyBTYWx0ZWRfX/Tt87EcF9F0h
 1XELVHBfXPmwP9UzppQ5tIVCpIyMq24TaarRlIXLZVNRe+DgecAkspg/5SWbpYvBzmZehDlqOPh
 AlO6JgUSi6Q++lLXul0GTOmRiWOOTd0T/36FLlCxpZ7y6dvv1Tn1PpVMuKHNtn0qcN4ZhNsLOdj
 iQO6w/oxZBfDKjeqIswOmB1dniTK99ZHhQHLzAcV2FYcdnhs+KaA1eO7LFp7+dHmbWNPKMvlfPs
 9f1d+HEnJ01NJmILE/R7z+h9m6QRthLnL4A4Wkd/932u2rU6uD1vtDr6E3uwesPsYtaNYdN1ioC
 pDhH3EPuw/6kZ4PeAzgrrBGmu0FwpItwesTr+FsKmIob+6SHr64gxoVBpVXycnf2SLov5l6mRnD
 SyhVo0xPRZqvTyMkKxvQKEZdhGcXkHjBc4s//yoCc7N+4If5MgMTppxwbcz1OXWbCQeyEbDNizT
 zaIcmrDgC9jZoPsyUpg==

On 24/07/2026 06:01, Christoph Hellwig wrote:
> On Tue, Jul 21, 2026 at 11:=E2=80=8A45:=E2=80=8A53AM +0000, John Garry wr=
ote: > Setting as an
> RFC as adding this extra bio field is not acceptable, but I > can't see h=
ow to
> lookup the original partition. In general it is not, but you should mark =
this a
>=20
>=20
> On Tue, Jul 21, 2026 at 11:45:53AM +0000, John Garry wrote:
>> Setting as an RFC as adding this extra bio field is not acceptable, but I
>> can't see how to lookup the original partition.
>=20
> In general it is not, but you should mark this a block patch so that
> Jens can better cream at you :)
>=20
> I'm also not sure that supporting per-partition diskstats on a multipath
> device makes too much sense, but then again there's a lot of setups
> that are crazy and actually used..
>=20

It just seems to me that we should have same behaviour as if it were not=20
multipath.

So we can't use bi_private as that can be set by original bio submitter.=20
I was thinking that this bdev pointer could be temp stashed in bi_next=20
(as it should be originally NULL), but that it dodgy and maybe won't=20
even work.

Least worst I can think if is to alloc some temp memory per-bio in=20
nvme_ns_head_submit_bio() to hold this bdev pointer and original=20
bi_private, set bio->bi_private to that memory, and then set bi_private=20
back to original when we end the bio. But this is all crappy, especially=20
just for partition diskstats.
