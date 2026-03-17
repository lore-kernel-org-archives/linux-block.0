Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BD2DB7AE;
	Tue, 17 Mar 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764366; cv=fail; b=kmbrbGOxDVhJ6PltIWyZ0gKK+bH0gBIYe8uxA0LSsAcp2+kjX60Snz3CzvnHSeTkG3Ogvi6PhgvGHr30I6wIdaGYzUNO/WUwtYmPc9ARvm3UdpoCTxCovXncWfjuW8AFAqOzu3cBnaW9hyVmCLpwlHD5yU9PkQkDb8ekVEDJyiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764366; c=relaxed/simple;
	bh=umqhdqN1eMXWA65OH1XN6qqd4bXSAus1fSCXEZkOIvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0+mv5TgseoOdSPt72vzbHzNlyu1vCOHx4Zo0+RXkVHA5SstONQP6opoBEZ7xPlMu3iS2OCaUkFgIJhADeve6Q8hMKA+bVCItymVPypJkNY/S0xF0YMkM/HqkMYlQKGZ2SaNC/+zND1XMfuSeL5YSvyK8t4jotxVnttJnNqToV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eRTmfNOR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rbX/Fk3T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eRTmfNOR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rbX/Fk3T"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HGHg9k3635785;
	Tue, 17 Mar 2026 16:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1gyazDrbpU90uo2cFVXOwbTYyKUmiQ1yXHdlKaM1Yyk=; b=
	eRTmfNORGzKdUFXUR0SPpt5vBSMLR2s8ahFEjChczvtgw6k5/nsesHVlZHN+J7gv
	iJgOAL+1EFCd2Ytdd8TgxVlsdyNRlNxlMTX8LtFEeb+arvh2sskmRfUSdRkZlxy2
	QjJHyniRb9C0m3K/HjdxizwfaRoW3Q3K8SnYtwQQLOMVqY7K0T6nmRRYv9U/6IE2
	6+NYlMUoGcIqbkDIMFXnPqM7/MHdqzRV4eGsCGd8wbvhM0clRC4V++XNPBSgDr2+
	uMJsWFijso1vNyP7IaLFV0nSlc8oukBecXuKIEQBIL5J42DSlemCTx5GYoUGAPKY
	RL2KZZgH/rpsYBnlQhqgZQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8cg6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:19:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HFHwqh021923;
	Tue, 17 Mar 2026 16:19:18 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4nmhqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoUc2DXa9WytlTrohnRClu/jIo1RJ4Y7WNZ+3zj8vtqopS5no3+4sei3y76R/g3L0BY4kqQTM76aO4mj4nZVaWGSYv9Qt1yRPr9cmXDMg+QarQHgP+Qm/nbTY6yxW7x7fo/p3b+9vN3nnjvmh2jL1auyyAS3iVs7Bu5AtSefz5L1P+J1CL2QHbwevZXygqYEbENYru7WGdStppGV/eRvAMD9o0U56lCO2NmPDM77JQGklzZ4wt1E4rwSDKQBvrt8rbf4hiVxQNnqG6fm74EHAaNXPC8jbAg7kIp/CWEofMpfDu6GtQSrdMsdBEacrjNKy9M6NrwvraVY2y7ygsveHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gyazDrbpU90uo2cFVXOwbTYyKUmiQ1yXHdlKaM1Yyk=;
 b=HjaaN/15AymWjr4AAIHR7VyPt7KETnOxKeNP+XX3Z56O+1y2MjTWPa2HiwJzszpf5FZcMSEUlqVKhkId05fS6H58CHxxuOh0EUsqqpniDPqd6ikSs08IZvoA9VLyMhi4BThvgLILiD6vMMb6lR+CQeWvPq4V5j2qoC0o//NTuVx16IVu3JKu52g1lRa8dkfawmH2/RjyNGRQ9INRDcz3qcQ9Me7VtsDuVKVMypRG9PqO6b/LDC2bxwtcfKS68GhDUiegHmKhaegRATD/8J/Ib9LwYG6E9v9EzWd4N8ll8fKJAxYcTDjCxcBWv7nNa7TqOKUftu/T9UeMMv+GsLdVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gyazDrbpU90uo2cFVXOwbTYyKUmiQ1yXHdlKaM1Yyk=;
 b=rbX/Fk3TWtI3QxSVCDGJ+ui4S8La0Cp+ewMxwdtH1OKbr1u7I5d5DsuEhdo0yFK/J+ZSvkF0BPDklIyLyZyFidVUmNhviq2NCRJGsObA++DCfAMqYUU7G7ABVuXYSieu9sk5is40UkSPAAEceesHO70VFa9fJBPEog34TNYQ6kI=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by LV3PR10MB8178.namprd10.prod.outlook.com
 (2603:10b6:408:28c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 16:19:15 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 16:19:13 +0000
Message-ID: <dd4971df-4d5f-44d2-82da-907e4a6d6453@oracle.com>
Date: Tue, 17 Mar 2026 16:19:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: ia-ranges: make blk_ia_range_sysfs_entry
 instances const
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
 <20260316-b4-sysfs-const-attr-block-v1-2-a35d73b986b0@weissschuh.net>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-2-a35d73b986b0@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|LV3PR10MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ef59b5-fe15-4376-1893-08de8440edb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	3/3dJlqnJJ/jg4lL6+MYXugCoU+pJF41MqCiN6yYtkAQXuUZLBGW96wPx4iczlRL64OIR1svdBHhbZoA/8mvbME2jZSDqT8AVHOzZHE1KIG6DY0nNfyEIGR2BPby4bOq7+1TxxDWzjIzVXcz457+zJ8l7tCM3GXvCFsJDtaxIdZCXtrzCP3C0jQ0ht/DFws0rjkNKYeQf9++GWGiS+jJePftr33GJsLefmNi4rp1MfHlE6YtiE1sP0MYLZ+Ckdbxxoi9w8Y2taJJI7hA4IGSu4+5ig5+fo8zmMsP6BOSIKuodb+r4n2mRKNYPnD9VWQuqmRh3yHGnVLRClmJayhSA8uW73mS2OpLJtJm8D0dD4EpiKv/t7M0gwkGkddMRzRbU81ztJEH83XwHdJtJSdKh6c4z/oLmpKub3dTC+whCKUPeKnkZgNTg/D1Q2n72daX3e7Au6VXU7CDPcniKdfJjHpj306jmxKORFW2eSWbX81VI2dFy4g2+r7IluMsPXlsxb5SA0VISUMFHbjz7l0xeJTqEg7C4D1C3wFUoEUcbAny0Byj1ctM1bmcPPpSw/Q5FcAf3gGAip6TqXlwjZyZ5UjpAR4c0/ZvTnCnSq868wIRKGgYXBqzJIHPg+bsUShfTV4G0K/PTECXf2CKaBZ448NB41VhBO2duN+yvGT4osFzcV251xewRivcLaDBB8uYpsXsZNaJs5Cy3aIzr00ttFBkB6sFz3FgSTikK2EAQZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG1ZUldUb0d3dXRpNk5aM0t0QkZpQ2k1WGxGZVAzK3VpNE84ME5RYktTcnZl?=
 =?utf-8?B?NEtYbkVVc1lHKzdtcWNibnplSGJkZXoramZSRHBYdVMzRlNWVytHSXlhT2tu?=
 =?utf-8?B?ZGQvNjVJd3p0OEZ0Z3I5OHBBWWxKYjVhS3dlOEJvZGVnaEpQRDZ2QmdyYTBC?=
 =?utf-8?B?ZHd1ZFdlcE9jSCtJeUV6Zm9XUTlNM0txeFBRWUlKOWFMSDVIbU5zeXZUcEZw?=
 =?utf-8?B?bXZhMnVheVI2emh5bUYxVnZIRWh0czg1cGgxYkdtU01aazlWbUxSTHM3a2J5?=
 =?utf-8?B?Y2YxckNJcmNpbURLVU5RdjFjcHhqU1RPcUNMK2hyQlRSdHNpWE45cnNkUHZX?=
 =?utf-8?B?UnpJcDhkZTJzRHlacVdEOWVtdHk4Uk42dTM2R2NaNS9FZmlXbzFpdEJRelBQ?=
 =?utf-8?B?VXRzMnY4aHZ6VEJWZzkzdktoTXk1VHd6dURoMVdKa3NYMC9YWXZXSk9MNVpl?=
 =?utf-8?B?d2orL1RWRVJNRGZ6bkRGcWZIQ1crQ2N6dHM1dDZkTm92U1JMMTg2NmJLbm8z?=
 =?utf-8?B?a3R3R01menoxMG52UE8rd0cxQ2RtU293RUNDdkUzb3NRbzY1VVFJUWhwZEt5?=
 =?utf-8?B?ZTZYZWFEYXFvMHdRZ1RkeXBUWnhZOXcvYXM0bExvQW9LdWg2ZDlVRTFFZGtP?=
 =?utf-8?B?TTBUMlBhYktBU3kyUjBTaTg0Y0JCSUo5TWJxNkhsQzBURWdmQUJjQXZyQnF1?=
 =?utf-8?B?emdWdld3dlhJSUxYd2FmUjRvcTAxdE9yb29Tdy9qUGRkKzU2ZGtoemt1cGZu?=
 =?utf-8?B?N2UwV08zNmY5RkZxaks4N3dMNWJwaGd1N1J4cTdKRjdyRDl3dUlIR2RpQjdu?=
 =?utf-8?B?VmZEMkFLTmdlYjF3T0hpM05TTzBtM3p3bitXYnZjVitabklTN3ErRS9NM3dS?=
 =?utf-8?B?NWlIeUJSWmMxaTFkNUdrdHNxOWxxNFlBc20zWmtUUW9kYkZQb1V2UlZyWmhJ?=
 =?utf-8?B?Wmx0S2pBME5WSmg2bjZFRDFxWVBiRXZOZWZqQUFZbjhZUWhHT3FqR0gvcVNC?=
 =?utf-8?B?MUVHMEc3MjVsQ3l1ZE9zSy9GdHp3SUk5Um5ZVXl3Z2duZFJ6UW5VU0hNK0V0?=
 =?utf-8?B?cCtzS2hDVkcrMzhRbWd4TmJlMVJPZVUvTk1BMk04M0pEMy9oRFlTbzdMZUVE?=
 =?utf-8?B?WlJNZmN5OFRhRkV5MVNWQWhGcmNuRVByaEl4WkVJNW95UWhMeVJsZ3dpUndT?=
 =?utf-8?B?MXBrajBpd0J4RzNyVzB4SWQxM21KcGoxT0FndWZidlhTYyt0OEQ4VER4OFZy?=
 =?utf-8?B?aXlLWGhEQm5McGxwcTRJMmsvMmViUXNnQ0I3YUt2amhjdTFRSmZlWk9obTVM?=
 =?utf-8?B?TlYrZFlueTl5cHA4dlZ6ak05clVkVnpLOWxtaVNyT053UVU2eFBPQ1Z5S2FP?=
 =?utf-8?B?WStUR0k5MFVOWVFuL1JQQVp1a2tKekZ1dUp2Vnc5NzMzc3hzblVuYkJNVWVX?=
 =?utf-8?B?MjlsK1Z1dFkzcjNDTUtvVUlvTUlOSGI4YlpIU0xvbHVXOEhjVFdWMU9NbkJi?=
 =?utf-8?B?MmZiUHhORTdNbjNvejV5ck1oV2xuWW8xNEhWZVRNUzI1TFRnbml0bXFxUFA0?=
 =?utf-8?B?L1VGWVZrT1h4MjdJNWRVSXpBNEo2RWtnK1FWcVJzRWpPRDJiUk9uaC93ekNn?=
 =?utf-8?B?SzZDakp3M3MzMFpnZ2greThqZEZDb2Z0b2xQT0RzUVFXM1lSV3czMXBZc3lx?=
 =?utf-8?B?UHdQWFB5MUo3RE1XZHBTUG93aGdTSVVNL1FyMzVQakdweDAySWJBYjRHaFkr?=
 =?utf-8?B?QTBkSTE3SjdFSGxzMmlIQXZDWWl4WXpkbWRLQkQxeXZsOXhNa0t1dDB4V3ly?=
 =?utf-8?B?Qjg4ZUc3Q3kzZ1l3ajJoMGRxdXhyclZpRU05WGZIVHhnZXZNMm5HdlJXZGxj?=
 =?utf-8?B?NWpBMGM1SVNYd3RBNlFQZGVzRHhtdmNvc2x4cnBnci9kTitPVWgyZ2k3ODFC?=
 =?utf-8?B?SzBBa1RaazFQcWI5SmxxZGdVMEFzcURyR3hOcS8yRjVzSUN3WEg4alFKbElM?=
 =?utf-8?B?MTllWXE3N3JqWm9FZmI4dFdqL1NFYitoVjY5Uk1QTGxRaGhtWVBKVjFvbm1J?=
 =?utf-8?B?QnVWck1DUFBzMURaZTdkL3lGUFZLcXc0SGNibnZHckFmZEdjbkcwYUV1NGtG?=
 =?utf-8?B?ZWx2MGpNN0tSZ2dKOFYvbzJvMmZLWmlmb3luWDVyQndMcmVSSkh3WkJ4WHpS?=
 =?utf-8?B?Q2ZOS0QzZmhYZFJQbVhKVE5ncm1peitqVnYyclBwcnZESW1kNzhKK3B5b1JI?=
 =?utf-8?B?TjlReE54eUpZOFM4Sk9aaDZoU0M5YXB0Zm0vYldUVFVid1dSU2NkU1MwSzAx?=
 =?utf-8?B?aDFUcUFxd0psYTQ5Zkg0VkVEeTl5Vi94Um5CNGszSFB0QWJjUERwMEljOUY0?=
 =?utf-8?Q?+cNbGCwSGc1rgGwA=3D?=
X-Exchange-RoutingPolicyChecked:
	cEiJQXwVREa5v+4cHiBSO54eaoklLubMuP5QwX9ftyDc3AXB4oWee4l9h5J/cuN+mcCv4Crycn//L6cyU3eLW2jYK5dxW5le8zuYJiyOVpesgtU9o4kklMGNOZfmRlo8ZfA+n/EOjH7BchuwaYTOPlgjq3lQdaWPWVcKL8VfA0eImBZvMLBO4sS23LLGoC5ESZhTeRRha815BZ/IRbhn/sLKYv86AZch/CeDO5j8WaqoxLEZ/omHryeJCi+Uraa0oOrzvGPhnHJXIwXoUMAMDrmK1pZmk8s3m7HJL5LiQiXQfalhzk4C0INdoVUjaHSH99TFwXxKue79u5CVJ0W9YQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c5n92Lf4tunXOkr0kGfTEVi/7zs1xyBkjM9mGqZgfWWFHEfrCVe78XXOaeMXDbIqkPo98YwSSTzFBJXdPIcu5H2+IPk9Jg/wUDgUswnfRaoJiVhYtH6p0nWuO1Hp+MWavtE652DKhxWYKVkz+JCHJ0Azh2YjXFnOxTg7YlJSQUmVJihgBDT1B/H/nkSlt3XJBjydZlc6TMFwdR0UTvxBbPiRngi3RtX90sinWaI4r8fbdhJDC1QZOslda1Je9sZ3IKYx1o98qe3YHziHquO3ZgQTF6GZPLsxpZWL0RGL7Aypbbu3I2SMe5TDB+m8cLjkCnVDAkRwAiyLCRGf5+LQznRx1MEhFJYKiyd8+sHqYLPNPqBfoVIdY0qvg9dJeVOPP1PbGPi+fl2Oox4IJ/SOldIkBucuDuUr7Dl0fv0O1PxwdfsYlujO9sq2kD08vTOFJJ+wf9qqg2tHRqtGSSkCiYERmiwgA7N8t7MzQ7R8cdkpY2OMGAWmmrQ+u4Nw1IlD4nqlaH7SzgPEhFke0Lgi0D649bBFzPqao5HK7KxJkEXDzlWSi5O3Z4EmmflA35WMss/KvGW/uFkaQPDxXJex7x50Zhem6JZDcYnIWygNrow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ef59b5-fe15-4376-1893-08de8440edb1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:19:13.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEwuHEHCkA/fbWLynmFUkRR/gsNhIulX4w79hIaHifuMkW2fQ4Wat5Vhxtue77g8TVVorsUUv+sGRRkfPaXuGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603170144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0NCBTYWx0ZWRfX1bfNZ2hpmaR2
 9o/pVAMP3jxy3dmS9MKPxxYHC6xhExHGE1j3geZE+C5xwto6QAzGZklQkf8c3ei38GnZrbGPWGc
 t/K16+zXV6eGCkWPr1nQJGru5awh7N2AUQ7t9/sbusX3k1lDF3+XuWVNZbVwLXXyonHRjyYizlv
 YUHUN5MP1X5mXypyfbzTEdSgPcCoWP82z8uQuZNKpBtpOyHyV7OlQ+Fx2bRH9363/CLT1IB90Jx
 wZ0UbGXVbgiUmlaw/+ns25I8C42xjRSgaDxXAMOoo/FC/nqG50exzxMlCSAom96nZ2dD0mmDnNM
 HDkcwHUUAkVasf9qQ7AKUv1lxK+nA2tvzvUlmh5lb0faJjaLtJ5GzC4RBblgsOfd/lqDnHfNAxa
 j+Vhlas91Zrbrx9WHU9DRx5tvjw3AbYtyjSOhmsxEFxkG4yoJTv0Qz1WYU/F34dBl58Nl5yRC5E
 yho/y0c7gDHNvMP0JvWfd7qg2obOCcAM7zPNE+oM=
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b97f07 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VTue-mJiAAAA:8
 a=yPCof4ZbAAAA:8 a=9Ct24hnkDWtZaoGbjgMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=R6trLQSf4H0A:10 a=S9YjYK_EKPFYWS37g-LV:22 cc=ntf awl=host:13824
X-Proofpoint-GUID: u27QZamaNEN66st22ifV1q37c8a8nF0-
X-Proofpoint-ORIG-GUID: u27QZamaNEN66st22ifV1q37c8a8nF0-

On 16/03/2026 22:43, Thomas Weißschuh wrote:
> The blk_ia_range_sysfs_entry structures are never modified,
> mark them as const.
> 
> Signed-off-by: Thomas Weißschuh<linux@weissschuh.net>

Reviewed-by: John Garry <john.g.garry@oracle.com>
