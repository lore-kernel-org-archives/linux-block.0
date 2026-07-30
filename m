Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3C3C1D45
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415959; cv=fail; b=ZSAVMgZ+M5R09R9rvgFxSVIpfQ0RWcnnxg6bp2SBohYXCi4D/xiDRdKKRZDA1ytawoEAq0hKFmry7hSNvqlXUwBuSuuH8KZcVk3BZ3r3TtJOrktvDqJShLkwZJNyxxod4CyCEFJ5mfjD0g7AE9No6RnVkczagw3WVvqGv7/Ag/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415959; c=relaxed/simple;
	bh=Y3k79SkAfJTzJXOjfvkW0Z9YsjoToRK8Uix9GCTZ7mU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BwNyixyQ5CHbmGit9wU84zEj/MtkB8amBVRnxrre/6uszYS0WyHz9txAOmF2P2TYkc0YRZaJz71FrnGe+A28EipWs7AicKTOTvBZS9SdooQ45MjKdc2D7OvJ1AmOx7Jnta7Anccv3Qu2dzkBldr/eXnaAXdOcNl/U55nJvGs0o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TmTV1lUv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AWBfdejd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TmTV1lUv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AWBfdejd"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TNjQrk3035331;
	Thu, 30 Jul 2026 12:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QGEkNDlF6SMiKo0waIL9s0g0/PKcq6eFiJkrRFAIuIA=; b=
	TmTV1lUv6iuZjpcRFWQ5gXCPJjImaV4JKL2z3lkQmzpUSyPF2OEZskBhDVfxMKz7
	LCFDtfcMC1M2ddCf8tWLfyX7HpZc0tFJpAFhuwEalyU26Me7cAdPIC2QyAs+za5s
	RGwoZ3uaiGgM4b/UeA+L7yEqo/WDj3ReO3EthHbaqDe0PKxt/jVIuI+FTAYyqnlt
	gVBD+BtLrWqzKrK4bzuScihUFpEM0TDi/tl/wo+Jl4hftlYSj2fOaEx4apkc7XqX
	y/p1WFiAK7G0ytHKI8rf0PAisas1/cNhOBJi/+kZEf8IvpPwkefZtp3EnPLN9N21
	+W5535bV9jL/0FT35UmwLg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5nqkng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 12:52:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCoZ7Q032078;
	Thu, 30 Jul 2026 12:52:07 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6f4ar4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 12:52:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XualnDPNY8v9cPUHHx8bIlv8+nIXELAT+7AQtdocU22SvUXYzH+BYtFBMbOx7J4pe1VOC+B5VpRn3ateY2GvgGfXSPj//m7rKOaaCASvR4PGArxwuQsHjLKTk2HtarwJwfor7cK4kwOMAEeM2jqNhfrXferWErthvh5ozHvsuZu3cf4DPbW+k+D01XrTJ9swnESbnrWPbsFo5vQco5E6rs160cq6FcG5hiq8AhM4NCxbISJOHsbfeaAu71XIqIHZsV8T/Z/+sCUosFb1L+IbtwZrwLNo2QneBSXdZXdSZ7VUQI0RI3T9V0q9BTU3BSwy0AbHAKfSIqaEtvIq8u2YQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGEkNDlF6SMiKo0waIL9s0g0/PKcq6eFiJkrRFAIuIA=;
 b=JBeXqTvqbj11ll2VxF/2WHGqWSATXoXK/ropigK6MaHZO+OmxeBItBhqy4+w6AmHfmpywrHHU619Y352dInmjVukfQ2PwoPXYJqmdSxAL/SGucAJ7URHVONZoDjkmvAcECdWlQw9DpEpfmKm6Yol5/NvUe8p84lC1X7NV5pwsz5lyhPD+D0DxDFQLYGHf3bTc6I1dY3Xsigwb1m9+j9Qcr2l51GIGwiuNplnu/LLtCcZrmoMakKWbSLMkdise0WGVgZJKZckEBYlTd1j4Bwt95cpAxTbIRV7MlsTQno5N5Si8f9/ZgZFTfqu3USviKWprvTaSurGI+niZQyqL51OOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGEkNDlF6SMiKo0waIL9s0g0/PKcq6eFiJkrRFAIuIA=;
 b=AWBfdejdfPGvriNP19RHKyjIut5bvebifHVWQfhJzzm+ZjrfB4PLDRo61RLxqsrVn/Zm5qzs0hhaYfUmAW8th3CCt6qXbym8b/Q51ajtE56bThVrK7ItlF2mm21Ojp+yMqLEitvD1SeOv/dA3yAY4XMy7gKErgTmlrBD6Gb6vEw=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.12; Thu, 30 Jul 2026 12:52:04 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 12:52:03 +0000
Message-ID: <d3058b64-e162-4bfc-990d-13ff5f03143a@oracle.com>
Date: Thu, 30 Jul 2026 13:52:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
To: John Garry <john.garry@linux.dev>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
 <amOGxr3rxvDflHLv@kbusch-mbp>
 <94ed42ce-895d-4197-994b-60fc1d3f040c@linux.dev>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <94ed42ce-895d-4197-994b-60fc1d3f040c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0242.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::13) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf19e44-fc03-4473-b038-08deee395a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9wD2Ljl04PTCT63Qe0dLLqqOCPSRemjCjTcezqelO/bXcI8EPccgIFPZzeKA0Pz1Cb7S9drrTrY8lU9i7RD4xLx1JPdAP63uaL1EZA5ytSpXTASi36MgtYeK0ekgoxo0F8TEe4isDBojL8jccjG6hWi27ex77XWom0F/CqwAJ1+O5RiJ33/YFcCXlxPY4Y0jsi4sY9vPrJhCljiqk719zHaL6YKC8IS7EcNozn+sB/F7aj1qoNkXGWK/T2sc6dLzdwHPtNQDmmXe9WGJyIEYae5nAGvuintgx2m/BBNK95I8+PI7mvR9n0lrwGYp7PEFN2U/6fUjBkPCmoaWvwso8nOCoBjffi0HQ5jr1rRRftwapGKpQ+6c7J9GwWCDYDl9dX2igytMlIuWVk+X/PSCn2bk4YQerJih7BtbaIEzBmFoQGNIJZzhgXMYpB0ndiqke3Ca/HV8Hy3lENp419HHs3Scb9uSmx2eF3cWFnAYUDM58Xk3ik5HAY89/i/BEzHBUAc2aW9vFEkAV1z/BZPskrHRtDLVlz15FyT1VNI19tdCBGMyncsjzK+31oL5O2UbKBaQZmpBwgUmMo4Mdnye0IWXhGJip6nBVnbRDHRucWSiWvlTO6cU2GoSDCXVaIvTqtSjervXq5jjyDKLaJN+rcea7fKUVaBGpSGtOPHHpKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBsZnkyV2N1VzZ3MEZkc3lFK1JqWjUzRXM0Q2l2VE1uZ0E4WWNhcE1kT3I1?=
 =?utf-8?B?aTJZRkF3NWREcnRsOUpzd2JSTExxTnhpSXRtQU5kbFdjSWdUU0lrNnMreG9z?=
 =?utf-8?B?bUZWRkIvWHBzSFNVc1RQNGdlaU1BclI0NHBZSC9Bd1hWbkVoWHRTRm9nQ0Z1?=
 =?utf-8?B?aENjVlA2NEMwbWFJU1k5Y2pJWTB4VHE4dmRoWDVzRmJiZVVLWTc4dmdTVmll?=
 =?utf-8?B?VjUxNk83cjRVMFRac214UzE2OXl3dkFyQVA0NzdoeGttenVoU2h3YW8vRjRq?=
 =?utf-8?B?WFhLck03RGNEUmRvRm1hOGtXODVzaDJvcmRhR0wzd3ZYRFgyTUtOZUk0WVVD?=
 =?utf-8?B?Rk1hRCtqNVZFbklhOXI3bjJjTnFYSWZRcElCdzZUK2IxS1QxcDVwRlYycS9t?=
 =?utf-8?B?MG1kcTNtdGVKN3JSMFQ5ZFBWUzhtaGNyNkdSVnhmU25SNHo3N2l1elJ5NGg4?=
 =?utf-8?B?bmhaL1A3TVl2VUl0bzlsOE5wV0EyTzd4ZU1SVXNITExIVGd5aTkyaWFZVTJK?=
 =?utf-8?B?S1ZVSmk2dzRYUVJCZzhwaHB0Y0Z1Znl5UFg1ZjV3RE8yUFR6QS8rcXpNZ0hx?=
 =?utf-8?B?SEdnSUlaLzdnd3oyZC9aS2J3ZHJleW1UQld1OWdpYW14RjVSYU1oTzh1MjdO?=
 =?utf-8?B?aGc3amJwQ2xvUnJ0NGJlc0l6LzE4ckc3ZFRFMiswUjNaRVNib2drMFE1QzNj?=
 =?utf-8?B?ZUhxdUg4bWhqcGxCTkk5eTJmajZmZ2Y2bEd1N3FvZHFvb2d4SEo1QmFrMXNY?=
 =?utf-8?B?cFBIYWhXeVNqSXJGMjFva0dvZ08vc2lyTmpNWENLcDVBV0xHbEtXMFl3bWNw?=
 =?utf-8?B?QjRtb0JMWUc5ZFNZeWVqbVkxMWJVSmFyQ0t3Y0oyRVdsTG1wTGlCR3NFUVdr?=
 =?utf-8?B?NlhPUTZWcHFjZGZDVHdPL05TYUlqeERwdTVMSW9GNDFVTmVwMGpDN1dBUTIw?=
 =?utf-8?B?MGRxY2RjVno2bld4YUY1ekxHZDhTb2RyaXREWXUxd1NmODlHYVBHbDQ1clVx?=
 =?utf-8?B?aG0ycUJSRWZ5QUl1R1pmajdmSXZQd1dScFcreG5XdndwQitLWldqc0o2YU9Y?=
 =?utf-8?B?ZVpOWmppQ2lYdUhzQnN4azNxL25CclBPOUxpaVJ4alo3VkM4TWgyeHJYZjhV?=
 =?utf-8?B?UkFCMzMwVGtNWmxYMnRsSnVyWnZib2MzeHFVeFEzaWRQOUZIVHZpUXh1QUZG?=
 =?utf-8?B?NXRDMllFYjhTbXBoNEQwVW9yNndtZTVwcFlJZ1FGL1IzUmpwZXRPWFRRa0xN?=
 =?utf-8?B?R1puaVA0M0lnWGdQbHJVblQ0QUhCNTNrNnV5OStQYndSZTRIdXFXZEliOXBz?=
 =?utf-8?B?K1Y5ZGpGK2xKNW53bkJSS2JGTk1WK2R5dUQ4cmtFMmQ1OGtZRElIVlpKYjZV?=
 =?utf-8?B?cWtPRi94a3hQaUZMQ0w1bjVkL1hFWkRDOEN1blVlTXZWRlJrNk9mMVBFRjU1?=
 =?utf-8?B?eStyNXVEKzJVcW8wcDFpVHJ3Tk0zWDI0eHg5L28wbThacUNCU2hyelorak1p?=
 =?utf-8?B?bHk0RmZWYjRWekJvRUhLOXIxL2JjN21kMVR5SWNuaXZRTVcrckFWVmZ0TEIy?=
 =?utf-8?B?YldmbXJkTFFrUUJ0THEvb3lnZFFQQlFPQTlqeEE1M3QxU0lsWkhBZHc0aWl5?=
 =?utf-8?B?SFFlLzdpS01MWmV4YStFbmRUbXJsVENBNXRUVVVTd2FNZGtXWWIzZVJHLzNN?=
 =?utf-8?B?SG5pRitlUEJnTkdTRFp3NXdTd3JudWlQUC93NlRzRG5sMjV4YVNDK1RNRlhB?=
 =?utf-8?B?TWFNakZzaUwvYkVYNjhoNEYrcVNrTUt6cktsSyswbFpQVTVEUklJZE9tU3V2?=
 =?utf-8?B?dnAySjVKM2VLemJ1bDZwbTFXVkdra3Y3bjNLL3RrMmVWZmNPUWtEOFdvWGRr?=
 =?utf-8?B?RHFsRGdEUWl1Uk5qd1hVMzN0NUpHaWZuMWdvRjlQQmI0VkR2SkZCZUduYlBW?=
 =?utf-8?B?cnU3MS9TQjFCVUFhbTI1cnRjOUlEYlROLzJGczFwRk5UeVUvTFhjeWdJeVph?=
 =?utf-8?B?cVErYkVGOG5pRXRCMGZJRU5peFNFUmdhWFdFQStZc0ZhWENXZ1h5V01uazBT?=
 =?utf-8?B?QnUvUGhhQWJ1a2pFNFJOZEd1WDFoekUrcXp6d1lxYnJyWW9INjMydzJZR05M?=
 =?utf-8?B?TDNkOFZOdVhhU3E5TGVuSDRFaFFFOGxGZ3V6WWk5UDEySkpNeHpjK0tnbmpS?=
 =?utf-8?B?ZXl0Qm81VDcxVGU5QVA2N1plRzdqZnN2TnlWTndoMzZISnJTTFJta25ZOFMr?=
 =?utf-8?B?N2t6NHFyWHZLZ1VId2pCc25Ea05HYW51Z0hMekdwbEpKR09UTVV4Qld3L2hH?=
 =?utf-8?B?bHRDL1I2V00rQ0d4dVFOQ1B6eEd5eDlwckQyY3FvOVZYRXZrT3J4dz09?=
X-Exchange-RoutingPolicyChecked:
	KqswfkBFNfha+tJ8V2mSPlPUfXYNKyeM5LwGCgJGE/K3EhxUhSiDsnPsAkO15715CcnrtvvwBloopOGpbbUiXyzJO2EpppalORnqvw0MAwPwIYYNF9BF/TU/r6+uwbckPPhzCne/AdVosA0xbOvfWonKwyYahoOHly61O23xLGMsiuBFXDswchutoz667RWKglpZcBdNx3Tybr7XL4rA4g9it+I424mppIzFeWSGQl2y7qvq4i1DgTHxm0zCG0CZK9+dxR+HLLH61grq5REy3mZZTOYx69wjp+NBJ8nipVCOLi00qtvZ+TisdpB/za2rzgDThRlVtGyqRH4vQEsyPQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/Up5Nk/xncp6jrkYgCTZ8f/yz72fOPKyKePVYXZPcsquEdauLyG3decgodm5eWRhp5CzunTwl4oclprAN4Ux+buClB+Z0/zBFEryekcvQqDrUPxXLjw8ltueT3juGguESxdLHoP/SdNDaa0k4abtURfymKgbqh8iqi24L7X4Xwgat3P848e9fZq861AqtYw5++pBWnYuM9zmDpDzWXrcYQkNjSxKS7VGPwWOHDhwCTe0ow93xyI9c3ogYEpB+SPQ6K63y8s4raSBWmEHlnmeT92+Q2f7DFlgcOGN2TckM1pnrBRnXbivOC07clkKXxw9X8Qu9oock1XPmWPsxgLdaas6+C1f+6WwI0t5jlvZnfoxstqSVYjSKPafrEUcYCTe+LJgpG59Y7AeHNKUqCWGgXpTKXddepHQNXUuCyJ8GEPmofNBIboKz90BkSGxX4H45rScfXEbtNnQ79K98c9ABh3HA2aSTGFHONDDKntPaNzh5Wd8Qorl4/54nhyh5yHKjsGVzYC5524+KKZEgx/zMCFNMEIfoXSn+5XxFHEl+oaUS8Ot1hiDNwXSCKKy3vo0Yl/3myhbF98+Vps4+MrfSKSPF7vDdbyDrUml4qG16ek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf19e44-fc03-4473-b038-08deee395a86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:52:03.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vo9kv4qtpclTqvSl1AD2Tb+aKUAwAN0gitYcNOqvW31SmkzAFMCo5LMhFFETHSi/1TjtjVTwt7QOW1uGfMeJIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607300097
X-Authority-Analysis: v=2.4 cv=OPsXGyaB c=1 sm=1 tr=0 ts=6a6b48f7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=N48UDI-TnyNced6mYk8A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13517
X-Proofpoint-ORIG-GUID: 6Sn3YYE3haMsCkj9eZ03anMjsp1yGrZm
X-Proofpoint-GUID: 6Sn3YYE3haMsCkj9eZ03anMjsp1yGrZm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NyBTYWx0ZWRfX8YzJhVLFeCSB
 odzYbJR6eJ4gRTHxX1Uuy36g2PxZoI0lOEtpyTvTqUq8IPNGOSgx91fMvUxKTNZYVSykRzMc9bh
 lLloNhKNo2v7kXJ6XcLyNqiuIxcdc5TeQ35p3xylZXoLTcf5V7fP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NyBTYWx0ZWRfX5jjbOd7xmKms
 b3oZtYjz2dqRZc0sbPceWOzmqyEhb4q3/N7YguzfSRzWtsTzlCcjH0clfhg+ovcTeLqmKxoGj93
 pcpw91IltPYPBN/NC5UPFR81wWOZIJsPX9N6tt+6KtbazA9Yw+qR2T3QsDkGlTlofJTBYAy2X49
 /jtkiYSMJW5r7wIrBMnBhaVdi6UKQ9fgqKW1/cR/2qx65wZ8FRpQ7g2+pYZShKt492lZ0N8EbsE
 d2k8CGB94G3tS3UZ2/Qq+1ZsT9LWauSiIvcntXyGCUbcKrON7Tt0ju5uCYNeGQXm/pq8gOQJi6k
 ya7AxllVujbWrrIjuHVdHp4EtbqXpEsYdwDfvcwGchkyYgD8qP/GJbtfLKuF1+hphjizFlF1rSA
 wb0zTVHhpypw2sNB+3pZPp748pzNY6NciOFwgrb9pv6ulOGN9PFQGW9/PYun0O6IcjFKhdIO2+z
 WN2x895ZK/sheBq98gzyh0/OvHOkyPlpFHb8dVAs=

On 24/07/2026 17:56, John Garry wrote:
>> This is the idea, assuming we can get the partition tables of the head
>> and path disks to be aligned:
>> 
>> ---
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -543,7 +543,10 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>>          srcu_idx = srcu_read_lock(&head->srcu);
>>          ns = nvme_find_path(head);
>>          if (likely(ns)) {
>> -               bio_set_dev(bio, ns->disk->part0);
>> +               struct block_device *bdev;
>> +
>> +               bdev = xa_load(&ns->disk->part_tbl, bdev_partno(bio->bi_bdev));
>> +               bio_set_dev(bio, bdev);
>>                  /*
>>                   * Use BIO_REMAPPED to skip bio_check_eod() when this bio
>>                   * enters submit_bio_noacct() for the per-path device. The EOD
>> --
> 
> ok, got it.
> 
> And I think that we would need to do the reverse lookup in
> nvme_mpath_start_request() and nvme_mpath_end_request() to get the head
> disk partition, like:
> bdev = xa_load(&ns->head->disk->part_tbl, bdev_partno(bio->bi_bdev));
> 
> I suppose that the tricky part now would be have the per-path disk scan
> run but keep those per-path disks hidden.
> 
> I experimented by stop setting GENHD_FL_HIDDEN for the per-path disk,
> and the diskstats look ok, FWIW.

Here's an attempt to get the disk partition tables for hidden disks:

--->8----

 From d7e124982215648ae914a1fb48f34f915f94eb60 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@linux.dev>
Date: Thu, 30 Jul 2026 13:14:32 +0100
Subject: [PATCH] block: scan partitions for hidden disks

If a disk is hidden (GENHD_FL_HIDDEN flags set), we currently do not 
scan the disk partition table.

GENHD_FL_HIDDEN is used in NVMe multipath support to hide the per-path
disk.

However, it would be useful there to actually have the per-path disk
partition table available for situations where we want to send bios to
specific per-path disk partition.

Change GENHD_FL_HIDDEN to scan partitions. For anyone wanting to avoid
scanning the partition (and keep the disk hidden), flag GENHD_FL_NO_PART 
can still be used.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/genhd.c b/block/genhd.c
index df2c3c69b467..64469943fbfe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -417,6 +417,10 @@ static void add_disk_final(struct gendisk *disk)
  		 */
  		dev_set_uevent_suppress(ddev, 0);
  		disk_uevent(disk, KOBJ_ADD);
+	} else {
+		bdev_add(disk->part0, ddev->devt);
+		if (get_capacity(disk))
+			disk_scan_partitions(disk, BLK_OPEN_READ);
  	}

  	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
@@ -487,8 +491,7 @@ static int __add_disk(struct device *parent, struct 
gendisk *disk,
  	dev_set_name(ddev, "%s", disk->disk_name);
  	if (fwnode)
  		device_set_node(ddev, fwnode);
-	if (!(disk->flags & GENHD_FL_HIDDEN))
-		ddev->devt = MKDEV(disk->major, disk->first_minor);
+	ddev->devt = MKDEV(disk->major, disk->first_minor);
  	ret = device_add(ddev);
  	if (ret)
  		goto out_free_ext_minor;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7c..a48896c6c791 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -152,7 +152,8 @@ static struct parsed_partitions 
*check_partition(struct gendisk *hd)

  	}
  	if (res > 0) {
-		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
+		if (!(hd->flags & GENHD_FL_HIDDEN))
+			printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));

  		kfree(state->pp_buf.buffer);
  		return state;
@@ -164,7 +165,7 @@ static struct parsed_partitions 
*check_partition(struct gendisk *hd)
  	 */
  	if (err)
  		res = err;
-	if (res) {
+	if (res && !(hd->flags & GENHD_FL_HIDDEN)) {
  		seq_buf_puts(&state->pp_buf,
  			     " unable to read partition table\n");
  		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..869fd05019d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1790,10 +1790,6 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)

  static int nvme_ns_open(struct nvme_ns *ns)
  {
-
-	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
-		goto fail;
  	if (!nvme_get_ns(ns))
  		goto fail;
  	if (!try_module_get(ns->ctrl->ops->module))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..a270cf1394c7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -260,7 +260,7 @@ static inline unsigned int disk_openers(struct 
gendisk *disk)
   */
  static inline bool disk_has_partscan(struct gendisk *disk)
  {
-	return !(disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN)) &&
+	return !(disk->flags & GENHD_FL_NO_PART) &&
  		!test_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
  }

-- 
2.43.0

---8<---

With that, /sys/class/block/ looks a bit different (with the per-path 
partitions):

#ls -l /sys/class/block/ | grep nvme0
lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1 ->
../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1
lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1p1
-> ../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/nvme0c0n1p1
lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1 ->
../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1
lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1p1
-> ../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1/nvme0c1n1p1
lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1 ->
../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1
lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1p1 ->
../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1/nvme0n1p1

Thoughts?
