Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1142BB15
	for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735027196; cv=fail; b=gYBa/ny0kuvVsnwz3tOe+uhLVdm0GCO/LcAonXewQXA+sVuWCZfIuBULKlcwuWYG4YcvI29fREqJc5DZacx3M2zHUrFlMA3HJRgBXWyo+fG6GwQ9Rwag5/gOerxejuANoTTGsbMb4ZCN1LDw5tmtIQica0OIhJA1k6T7XP9nDQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735027196; c=relaxed/simple;
	bh=UQZPZJdZ6MIcjNUtEX+V+502bi1HHWUbZPEQocgfocg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cd1KQGnfGJvWdDKB1hEsn/srqs9GzaNSuCtajoeok3OAKaASLbOdhzfOFB7HY4PTUe0snY+5xwIDgjEe1YZySnb2TbutUgcC3EgvGwpupP4Hxd7/8xrTJ7JLVMLhcVH86xowJ4j7onLMgoo19JXhE3ijxQ5/6+pXcf268sDn7A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PoaY/4pU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f2+a5J5V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PoaY/4pU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f2+a5J5V"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO1u8YW007973;
	Tue, 24 Dec 2024 07:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xnEXo2204Dr68vqTI3EhAKIdl/z+IRUsw1SOMbY0ZWE=; b=
	PoaY/4pUSrHg5MIrOdGexXcmKbUFQQpQzeSIpS4wPIoEqXJ8FHPWLncD32Nu+ttd
	CLJqcajmJvNkfTTyYNvHuIgskdZDGorAyfimBvg0Tr0UtiiHSj+Lrh8lHlSpBN2S
	N5+GLYMgn81dIf8phWz6MvwZexTOhUyouHA62SJ/gJ9AG/irAeJEMXaemk4vq6P8
	syv2c6t/Ck1euAr9gH48XZhXSlqUBqbnMqS3p4agcsLSWNcunZqn+v2P49hL0P7q
	Jt22riIaO3KnNeZ11Euf/jrJF5miRC3K4pi+QG4GWlLWuL2WqZ6Bz/Mekf8ZOCle
	JfxzNe+N9m50SkEBz2t2uQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nqd5kv9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 07:59:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO5WwYE040901;
	Tue, 24 Dec 2024 07:59:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43pp6k94u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 07:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S16p7MjR70aC6uOesvV/Tr8m6ZcgxbD5Jl+nH3cHp6TuxzpXuJt4kUZRB0W2jqL/lhsiceXcPd8LV9VakGaj485JbePEtBG38Qi64D+flt8xsi+J21u18zdbN/AM5Zwxb5C73T5hKsV/tKIUOx8YBNv1QhHAYqm4kBqXcMDTdQN1zLkNyez6/wugUXOfsE83fL8FSMkJaUpXl7nAD+ZPOAkqKfw/5QwFd02E68zVTawAImPQk2ishLRC40evAnFKEd7CQID7OSZT5DX7y7fEwxH5xkVcGoOLu5VoqIiaN7QaJNs+1kKwYGpQlLXDfZRXO2tZXO7GvSsC6DJGq23BlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnEXo2204Dr68vqTI3EhAKIdl/z+IRUsw1SOMbY0ZWE=;
 b=TfaierMF+0sK6R9F+JxWITkZ2vhi9IIzzYG2DrSn56EUecvKsXZrTwQ/Np11IOODfw53rlMkelLBp1TyAlWUWtz0KahJHQEKrxFfbuOa4jAPUe0Ot+vBN1hJUdAQQOZzmzgBZwFlzBBpp9vnZZD4ks6Slt82kH+C477uHli3tMponPWFhmkZUIKSY1+nYQiiPrMhjbmrol4ZtTtCrJhKZub1+2L5peUNomNbqu+F7w9oW8YBZzfLpQXjokBKGI6uEqY4lWAVaKgqd0Gs+6XLdK99q5ajSUT9meAhViZtYKFx2IZBj/VQUYNzUwOmu29fvv6k8/Gq3hZTJAYIMZ+3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnEXo2204Dr68vqTI3EhAKIdl/z+IRUsw1SOMbY0ZWE=;
 b=f2+a5J5VyONo9itHFSB/OCZUfmvNhH363AKBJqcYR3yy1ulhgjPslFYe+LvPgHGoe2UKKa1qn7N6KWV+W/ZuDg6g+iBsWP0yKKYvdh5L8dpgvRkAUNSLO/OfdhGqfXGSDHcsLvUUZmQW4eNfxlQtiLHp08rHLfl+p055kztxL+w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5741.namprd10.prod.outlook.com (2603:10b6:a03:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 07:59:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 07:59:38 +0000
Message-ID: <34e7a3c5-58b7-40b0-998d-b6af94e85eac@oracle.com>
Date: Tue, 24 Dec 2024 07:59:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Use enum for blk-mq tagset flags
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20241223104153.857953-1-john.g.garry@oracle.com>
 <20241223192727.GA21363@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241223192727.GA21363@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bb354e-306c-4e09-635a-08dd23f0e9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YngvSjZrVVh6QnMrQlNzNmJqOWR3WVdNWUhJdTVQNHhWOTBnZnhOUWc3c3pj?=
 =?utf-8?B?d1FEYndlTXBFVXJPb09EUk1wY1ZFM25vQk1CS0swdDlEbjJpK3oreHRyQzhy?=
 =?utf-8?B?RlNyQXF3TWFrTlJjY3JPM3dUdEU4M2hlTzFvcXNEaG1kZU9pVEhZYS9lWHNk?=
 =?utf-8?B?R1JYdXpVTkRFdG5zb0JlckZORGhlWnhJSCtiNEpCQnRrRzBXLzlPRTJPMDVu?=
 =?utf-8?B?SlA1QTBVNmtGTWJ4R3VPaVZmcnRJMHZ6VEk2b3djQkdxcFZkR3Q4Wmg4R1dy?=
 =?utf-8?B?aDdEUVlqMklxdDJFM01BdkVVTFo0am9Temd2SmhkK2NaSzczdE1Pc0E0SWZh?=
 =?utf-8?B?UWVRRmRyYnhnNFpqamEzZU8vUW5KblhrMU1venZFbW9SZW5oRStvd3B0dCtq?=
 =?utf-8?B?R1Qvb3dQZ0x0MFRsYThUVDJCRVlLdWpZZVd5NThCYTJiTm1zajMrSWIxaGk2?=
 =?utf-8?B?MlNGenJQMGJ0NHB6TDlNQ0NpOFBBOXY0aER4YlByY1hMVVN5blBQUHZsWHV2?=
 =?utf-8?B?VDFjWkVtTVFqaHQ4RktKQmt4TU5PSlFETk94WWRZd3Q3NkM3dVhHakZuNjRT?=
 =?utf-8?B?UlphUTVFYWZZbGZ4Qmo5TnFkZGxscGlhNzVBeHhGUVZmbHFlRzhRMUg3dHYw?=
 =?utf-8?B?RG1JbG5JL0ZETXZhcWZmRDQzN2dGSTRIYi92c2FLR2ZJNmY0R2xLQkdTVHd4?=
 =?utf-8?B?TWdSRnVIMGw5K1FYbUdSVEhDWFgxMmFzbWIzUzBKK0s5ZllvT1R5MzllTTBF?=
 =?utf-8?B?Q2s4UHFPQVZmcnNlRDNFb3pieThBQmppY1N2REVocDUySFlkdC9STTlyTDhs?=
 =?utf-8?B?Y1hySjRHbWE1L2VnZTQyc1VaRm5RR1g1MzFFWmE4VC9CSmRoK3llRE5SNVZs?=
 =?utf-8?B?MjJNOXRwSVJNRnFuRXYwS3F6azNva1FOK05xcENJQUl2ejZNaThYWDBwQzc1?=
 =?utf-8?B?YkpHNkI0U2NsVW5PSFhyU3dIR3cyeW01aTRkdHZpSWpoODNpeE8vdzluSmZk?=
 =?utf-8?B?aHg1dXd2YldpbnZnVjVqaTk2cVV1YURtdkZScStyZkpVSzZyaTZpLzYyYU1D?=
 =?utf-8?B?ZEt4MzlOT3ZXY0R1ZHFTZWtYNlNOeFBrVGpOT0FxZFJSUHZ5VlduZyt2UVFS?=
 =?utf-8?B?bTdNNW1Fakh4WU1SYzgzRzhOSEd4MElSQXZzNkVDOWlidGkwbXNIbGM3WHY1?=
 =?utf-8?B?MUVVelVGWGlPQjZPMW0vZzBIUmNjZGlMQWpjaTZyMlZtYmFYOXlFK0Vpd1J5?=
 =?utf-8?B?QUZXMUt3bTlyNjJURTZjc3JmYVVtam90blR4K3VTNy8wS1BxTXZPL1ExQkY1?=
 =?utf-8?B?SEd4MTZmVDFZQWZ0clhLM3AvQUhKa1cwK2RHbHI1UnB5ZDIwWUdhcXNzZVhJ?=
 =?utf-8?B?ajJVQ0lGZUswb0JGVGV2T3ZIYzRJbWptVFFNbjF6SWNNbUhFMXN3WVByQ0Fk?=
 =?utf-8?B?U0VSV2YrK2Y2Mkc0RGljRXYzU1VYQXJML1NTRjdsY1hRRGlxaHBSa3plbms0?=
 =?utf-8?B?SGZLb0dkQmZaMC81R1N4SEdSWFpFNG1yMURDTGpTOFFxeGM1cmIvYUw4NVNO?=
 =?utf-8?B?ZGhodXpIZUpLMENVYndoSERLQVg4UlU4TFp3aWkwMTM2Y2t3TGJUVk9pR1A1?=
 =?utf-8?B?OHN6c3lWaVVpWDkxUGJneVpVOXFPTmxaUzh2MGlQMHdSUHZUcC9vV2lnRFZi?=
 =?utf-8?B?MjBSanpSTk9WTDRkTWt3V3ppbGVmbTBhZ1pNVHd4a2N5bExDUE10YXpJYUtI?=
 =?utf-8?B?OXZvZHFNeDFMa205KzdraTliVXN4alVJemxzRWFWbVFYTm4zUHBpOUtaOXVv?=
 =?utf-8?B?QXBDakdYcGQvMndYbFFPV1B1eGt1MW1BN0x2bFlNL3F6MkZDNEdYV1Z6N3VM?=
 =?utf-8?Q?1f8xwymvJ+N+w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG9ReHNlc2V3eXRaK004WXMzNUZBb2dIMTVvdDRjNmxYN3NTNFdPVnBVaGVE?=
 =?utf-8?B?bHArVlRKNjRXOGt2UFBQaExCaFdVY2h2c3dFVU9KVXA3TC83cy9Hb0VwS0k3?=
 =?utf-8?B?MldoK2ZyUFVqWHNRdE5lbDN1dFcrT0dLbStVS24vck5DVzdIejBXL3J4OFZh?=
 =?utf-8?B?MTBhRG5kdm1LejBBRUljVnpDd1loTjhzZVhDajlheGdDL2NWM3RQamxBV2pT?=
 =?utf-8?B?YWtsOExaWFJVOFI5UUJnSXoydGtwWndFNjNvSHliZ1J1WDlGWXE3TEU0SDly?=
 =?utf-8?B?TDZNTzRzbTFvQWFNQURWTGxLVGhhcjJTY3dwelU3VVVxZm82MkFIREVIdzlQ?=
 =?utf-8?B?Y2hKUnFERnhOQVNMZlQ4dHNKQmJ3UHR5WXZYNi9oMk5TSG4rRWc3T1RxcGdn?=
 =?utf-8?B?cnU1eGlFN2hMaU1iUzVNNVBBMHlCZE1kdyszSUR1ZHYxK3hGVlJXNVJPbjZW?=
 =?utf-8?B?MnlBZWhuQ0xMLzhlOXNjM012WXNTQzRwY2ZxOTg4NHIrdGsyQTd3dk1NMWZS?=
 =?utf-8?B?MFNJTzg2cG45b3lGL09BOU5vcTB4Qm5SMldveEpiVjNLUDVOdklOWFRWMFZ1?=
 =?utf-8?B?QnBsVWdKZDQydTgyM1Q2NkRHOXM4YXNsSXY2QndMcWpaSk9pMXcvUXJRM1Jy?=
 =?utf-8?B?VEhHVGlMbkVzSFVCM2RqWnQ5M2VOWlQvaWRSRVMybEt5MndxQUlnNHc5V0pt?=
 =?utf-8?B?RnFUSUtDL0Y2Z25GcG1qenE3SVdlTjN6MWQ3YUtjWCtmOWdFaWR4UXZCN1RD?=
 =?utf-8?B?NG5pZVBXSmtIa2E3ckpsM25McGo1L1VMSVByT2dycFZKT3FzRUx4cElhN29l?=
 =?utf-8?B?QVdnY0FFem5yNXFVN2doMWw2c2U1QlNGYWV4QW96MEZmbk9nS3JHZlRqTVJy?=
 =?utf-8?B?Ujl5RW5TUU0zTEd6Nmd2aGFuVlhabkpUSE1mcDBxS0t1cWVxWW9xcEU1N05u?=
 =?utf-8?B?ZTRRYW1PcTk3ZmFGTnBXaHJBZktnVTQ3NFNBNk40dHJCTTdPTFNrQ0RNWU5W?=
 =?utf-8?B?Nnk5WVJrRnJGWWkvWGZET3kvSEdNL2ZYRDhndGpSTzF0TU9CdE9tOVJGNlRp?=
 =?utf-8?B?UVdZalNQODVqdXdjZW9uZ0t6UWpCZmxTM2tzaXhVNE8vZjJUSmJBWGRUeHVa?=
 =?utf-8?B?b1FoTTdVK0xBWkgvNTZDMVRJYW9vbDlRNVhsRTBlZWlwMFpIcis4cUhuMWRU?=
 =?utf-8?B?WmtueVQvY3U2dEpyREdTMWNNTklTOE84MHNZUzEwa1BRN0Vhanh6VDFVVlBs?=
 =?utf-8?B?T3dZRElLd0NpTTJLOTcxL2JIUUl5ZVoydlEzMmg2bDIxd0U5aXl2azl3T1Y2?=
 =?utf-8?B?R0FFaXpMY2NxVWtQODM3SlFRbkU5aUpPd0tBb0l4M3RGUmV4eEdVekpkRW05?=
 =?utf-8?B?MlpIanZpV21GaHJzdDh2d1VHZXI1Uk55YXUwa3g5TGxXT2lzR3NOWndLbGtq?=
 =?utf-8?B?UmYxbHBrQW10SUVocm03aXNxdzR4dWI5VWhwQ2xHS0l2Uy9nUytJWXNWMEV4?=
 =?utf-8?B?RFVwa3FIOHBtV2pvVmpBTFVDU0ZxRVp6aXI5Rmd3dmJiUXlTRjF2YTlZRGpH?=
 =?utf-8?B?MzJBaWxZT1hSMndMTjhRQWdXbTExZkxsTlhXOFpRcnQ1Q0NUZTg1Qk12NUlS?=
 =?utf-8?B?SDk5UWJrdERpeVNuOGE1ampRd0FUSVlsS2hhdFN5MjcyOUxzRWNVais4b3FO?=
 =?utf-8?B?N1Fqb3FrSDNBdHdBNFhUVGNLNktZVXhMa0d0dzkzOU4rd3FhaktMU3Z2cHQ1?=
 =?utf-8?B?Wk5PUWY5aVFnVUIwZldodUd4eWJSdXdzVXdQSTYxZEhPczQweURiY2Vsa2pu?=
 =?utf-8?B?amxFRUtUaVhPSlZLMGJkblRkdDIyUmpyL0RvV3lSMlV3bUhlY2ZGUk5QTlZh?=
 =?utf-8?B?QzNhRTF1aktTZVRFUWo4QUdJUU9Wc2FaN1F1R0VOclIzNHd5K1I3NkZwZmFr?=
 =?utf-8?B?bEswRTB1RmhzQTRZZjJIOXg2N20rKzV2MnYxMXZWcE94QVYxTnkwWEE5aG5P?=
 =?utf-8?B?TGtEK1h3b0s1V1d5RWN6a2MyZzVXdFptazZ2YkhrVkN2U096UnVseDlwL2dX?=
 =?utf-8?B?SzNlZDQwZWZIczhhakVxWk5Sd1AwMFY3V0pTazkreWZaTGY0WW1VcHIyZXlY?=
 =?utf-8?B?MlpidGFXalVEVGJKNVJjdVR1M2c5UEVxamhJcWJoUlhMc3R5MUNKNUNqYzRY?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bGA8BVu7+CnkA3erqovJoTT76ypPfTbefZWU6H9RmS1ZfgsruJpA8VmTTZMdmhmEaxfd/ZQ3Oas7lkU5bQyK12EHINkdJcpqXIVJhi9Uc9Ctf0F5PIGWuis2cqC7f0rI+uwkec91EFPyiIkHCavmqbfYymbKdSXCJjghJB1Q/S+KBAd4p+WCEsRt+tu58LYmxu7I0b4+w94+Ee8pWkylIwYpSVVVbU+DhqdRTRfdR6m+gKFDAV2wgl/qW1nDroMGYiH2oqTqQHgfPrbjoKzMVZJvpCh8DRKHhFuIjqvwH/P0uYcK2hXz/mQvnNNarU9C85GfJDbVmBS0D+ej1diptGDo1tYoRT8xY4WPjAKFwonWvPidpuS7F6a/QQsVd89y2VvO/G6p+cnOgjt+8FdqcRUvo/tmQkEklCLANRCXPwpF2ekCZqEiUF7PEoahs3YJ9dsDTIJ18vF/4JS1ItKFY3N1KvLLy7dFjqhPietuQW4GBfxcwUvXd7AwVq/2kleLfYA+BlQw7L99k0hUsVE180PApoqiQheCSOkVOKwRlnAuEGFqHMHfl1h4RjiDCtZLEVBNIYtB+qH8Z46Ar5JEmiqpBEEX8XmZLuGCW/6PLLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bb354e-306c-4e09-635a-08dd23f0e9c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 07:59:38.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhIgP8v7hYdiJGNqma7WbM87ashtvMqBgTzX5u+bm0itcwgtlsZAqvluWt+AnaNf1faqF/3NAckfN5H95NS10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_03,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240065
X-Proofpoint-GUID: mn3TCXMrh8g2vwlMGh5SOdVnrivvQbYH
X-Proofpoint-ORIG-GUID: mn3TCXMrh8g2vwlMGh5SOdVnrivvQbYH

On 23/12/2024 19:27, Christoph Hellwig wrote:
> On Mon, Dec 23, 2024 at 10:41:53AM +0000, John Garry wrote:
>> Use an enum for tagset flags, so that they don't need to be manually
>> renumbered when modified.
> 
> They don't need to be renumbered. 

Sure, they don't need to be. But using an auto-numbered enum makes easy 
to catch when we add a flag but don't update the respective debugfs flag 
name structure.

> Sparse bitfields work just fine
> and are a lot simpler and cleaner than the indirection added here.
> 

I don't think that having unused gaps in the bitfields is so neat.

FWIW, this patch could be further improved to remove the ilog2 usage in 
HCTX_FLAG_NAME, which is the only remaining debugfs macro to use this.
