Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA2149DFA;
	Fri,  5 Jul 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180331; cv=fail; b=ckjIon77WfoAlovVKqXh0fzk/JFzvjRA1a3JaqG9R5h2lfl6gJKueQddnMCZHMi1fdiFv6/9H3KsTWTvU+YBAlXN1IKU/VCXxSwFULK3qbRPitqhNQJ5ZI3NXWtx8gbHo8z3Nat9/8gfEqBQseMaeQkKUAZB/91zFAW4PX3S9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180331; c=relaxed/simple;
	bh=bvZdbws/YR9PlUnSIEyrRFeX2cx5WWkxJYf+wY+iB8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Otb26cgDotZ8Sns59Gk/U6zgRVu94TQ4F4iLBtz7lGLpINZpqDK4yv3giz7N2N0N29wHec4qyRlGsSBjmnt1PuFPdL5qG7/puZsxgQYzBGvkrIBilq7ocLm6KZFcL7LqE+hnukoy9/uHs02ww2KF9ZK+HbBtGbugCADOw4RhK64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L3ASgCNi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UA0e0vbK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L3ASgCNi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UA0e0vbK"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BfbmB026082;
	Fri, 5 Jul 2024 11:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=E/N8uyy+d9hnT366wcls5uEgZcCdVabP2DKuBmQIVCs=; b=
	L3ASgCNi6zbIACv5QeRQo4W+5Wt247joM+RPMOAXZ5nzxNRzVGmNDQPtBb9zcBVQ
	Ja7kDsh0ibJrlX6t2zrCMjhQRVtlKAVAJjypYJ60J67cGbpcK4xSrDh+b9z6y62/
	xlzlhMW0uua2aS+laoyjVYGDZHarmHixqv1r+LZWKCeoreSw5BuWpnH6kEnLIPPF
	VrEzM70RLW6YuktWEyh5pM5y0TBVoB6HEkYTHDFlxx0nKEEeXxosJ1bmO1YqYSMw
	A793WgrrWAsGyqxj92JIwqIautOE8rFua6lsful2zsR65Kskp/+W8AYwBmfHg1vG
	FQvqkh5K/kEJ5x7c+uh59g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59bhbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465BDgUV024718;
	Fri, 5 Jul 2024 11:51:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbsb77-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSXShr4Q46AjQORTAgauBqIL0GHr7PMdVRAo3yilnWRZ0vey5aW2+Fgx32zQLG1OQ7iaKJFHlb+eCIlo6TF8VvzusumWaW0BI4HOydNtGujK7VgdY6EUfeybR7orwPQBnwouQiOg4jnY0Zc1Cb9+Aw7z/Izd1/yMS6dn3yTVkbWO/KjJmxqalDnShp18uRz4EPygQz4x2OswGEt58SYNhFgA8MeOkmnGICY27tWx7QgRiGS7wN4hbhrbrXvTqgi/HpwOcaNLLodwugFotHTs7odUAPAdN+rRu0xyaHQmHh0SgJLkKgAd/zatkfKcDQLvjjoszVAazWrWg79d6BTBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/N8uyy+d9hnT366wcls5uEgZcCdVabP2DKuBmQIVCs=;
 b=Aw9eGurDW0gPmnnNzAKGmuLOiCHIFLkpopBSW3bO/49j90Ac8NiXuKrQRlUBZN4U2UGV4wx3fxdLA5SZg37OLYlzM0MpuUbrKmj+AMbB4e42REyevBZGL0oOuwBigKMj/s5PxmD65aNUGD++rNOMRwveYpl19/jt1gfrnxxD+L5nBAK3Ejv9yVLS8S/PkHosvguGQsNejpOa1fjNAY/5d2RTaKPE8QmEo3muIQn6z91uLDdrjuDDGtMgWlX85+vH8D+h4JanDLsM30UgvEC6RGUsR/3WC4vusqWw392YCxDUpqHot94IZw97ep6ldkrHcTlfr5LQnQ4581CUa0uq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/N8uyy+d9hnT366wcls5uEgZcCdVabP2DKuBmQIVCs=;
 b=UA0e0vbKe1JUhv1lhjileqzGhp1VaFqXnBxY9O6Ly4yJE/wbPCqj+92jljFBNhL2fVaHbI7d3PSb/hUTZ6mM9vnUZmJhuEihpzPTMRbReJfVCqcI78zVlXfM6+eH727f1JyVt8HgSzQataL9gChdOCcelvHfHP7bbUJYlDvjKbE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Fri, 5 Jul
 2024 11:51:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 11:51:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/5] block: Validate logical block size in blk_validate_limits()
Date: Fri,  5 Jul 2024 11:51:24 +0000
Message-Id: <20240705115127.3417539-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705115127.3417539-1-john.g.garry@oracle.com>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 9094d68e-0c63-454e-e8d4-08dc9ce8d806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SNxQns7JZ2QGJpejloaQH2myk10/L59xd/ytdyimn7aBAcxTn8OyHa+K2+jA?=
 =?us-ascii?Q?LPeML12JhypcBAPGbrcrqYlc/VyzItL6UwgMft/LVtk5srgMmsK/C8JXDVj4?=
 =?us-ascii?Q?BRiXoh4ZclrSbfVmxYyDlim4nSa+ijWmewbFR5ksHMuUIz1PNKF2NXe0Qb0s?=
 =?us-ascii?Q?gwxilKk2s1XdClg7f0CvnzaGhYiPolg6D9GJ8kpAadawRjKyVSveNjmqwYMd?=
 =?us-ascii?Q?I0pUfu5djravGYarrAxAL46R+NG4tQKJQd+CPGmZvAF+3b8gjS54gHEM0K1T?=
 =?us-ascii?Q?dRuPhZkAjRLpv543Ckzfht4Qd4lhm6htGT0SjUlBkWi6Ix+sXalyM4pb2Z+L?=
 =?us-ascii?Q?BOTF3ngggKXUlIlNzfVk9IpUZLLiUDGg2yOl8F8LDB2TuA3oqyChNuMEXFXO?=
 =?us-ascii?Q?Dazwuti3GPMpe7yEDj8Ylh5spbaOpLvgV+s7v6sKngycbYW6POhPe3pEEQVA?=
 =?us-ascii?Q?tjmcgzxaZ0k9b4BMWH06LCSpFTzCBSGiRcN4iKQUzgAC4gdN2qEW8keFY1SC?=
 =?us-ascii?Q?Uw5WlK3kiyoTbkPJLoHI6Ni2wT3QwfSxo7qcUj0NwK9Hf18nb6l0SrthOOqg?=
 =?us-ascii?Q?78ozo6J4K0XCWZ6m9066CgaWxhWk2EmXzOHG+Eej2dsIgBkkJUVmcPDQ4O63?=
 =?us-ascii?Q?Yd90142mr8wkKwv+xrjNPEj1dgC+RHsnirMLXV0EUYK/ahFRvAjsEsVRiZu/?=
 =?us-ascii?Q?z8fjBjZ1X9OQWmlhqdhaR4HOBsT/i4LO6iYmKW5+0idAWGmiltPWGz22b6lw?=
 =?us-ascii?Q?x4JufFp3SRKl0bT2ldf5iK1RTiEwsdutykbKbTTzvOdf/+96VjtRbskATVT5?=
 =?us-ascii?Q?clETpkMQvhs9bUOl+wmyvIAbEbV75VylO3jTD4alGFQW5FWKGTwf1xMwCoYD?=
 =?us-ascii?Q?OXcnGJyAbVWyA1YjdRpqE+pDqTAKnz+bMvht0CeImvpGFbr4pamBqXqC7W1+?=
 =?us-ascii?Q?vQnQM7rfSpQdij64sJJFWBONqa4iWgcoqyJSKGLLerRVxZ4Z1p9grHmT+c49?=
 =?us-ascii?Q?65lbtaBldysHPwnB4MbJXZKQuec2HhEpYP5Tv/0QQF9+sIpS4QqYzcpVYBgN?=
 =?us-ascii?Q?RwumD/RlR7s1JMkw//0sXQ0qZDuKiQ/D6AUN9XjyW11nwTTL2jdV7upL/A00?=
 =?us-ascii?Q?roK148OVvzAD2r/CQpZ+Xw3kvOYyXCfb4u1VXFDozsrjKNCKrBPh0Ldlkanf?=
 =?us-ascii?Q?/GmK31j81j4VYNoqJnC8x1vWndmWxmitC5rQ38fcs49o8wD71hygKoKVvFX5?=
 =?us-ascii?Q?NeNLr8e3eooOs2TfBQGeD9u0WzsXnIMliW7P7NU4hC2d7MKBgokiGh853x7A?=
 =?us-ascii?Q?vLDxaFCymBU11b4Ojq2TXHLpWMFIciu8b/M4PSWXmxaSwfDYf15icHL5hyu8?=
 =?us-ascii?Q?CXBQbMAqD4ui4/ORwCwGl/IoShs6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5f/kwuBPLkTtD800zAica4zdCw1Jl0OuissgsnvdtymnT2GJpNPsISJe1E2O?=
 =?us-ascii?Q?/qwG9qBh5GXt1WNqA2yTt+mL7LQqrZOyG9rvu3nLqLoXLYq6sobPj2ag5PbA?=
 =?us-ascii?Q?D/xC9ufXtO0AuvFy828H85Au+ALxSmpUlhj0O4grtPDTiD17i4iCRPS0V26j?=
 =?us-ascii?Q?SC9SnQp8m8pleq2jouqdw+fEziCLSQkjttmw5fqgvwUXW0s0Pg6NnMzkfLau?=
 =?us-ascii?Q?5i01UCsoHEuMmdfnUKzhW0/Y/q4Uz2xFBl3D9KakMNgRbZHZyLjKfcWrd3yB?=
 =?us-ascii?Q?1DeU+K7O0TXHj+lmUff9hBKRb2YG+v1y++OfLoCfJ9v/VrGQ328ue1TxvK6f?=
 =?us-ascii?Q?sK0nvk43qiyzkF4eNAjbXWG3ig82lzAvkL9UfCpLlnEj074XKgVBvU355wWe?=
 =?us-ascii?Q?WMHffxBvA51OqfqGa5gP8GDyh74FRjFRXmjw1oQr7i/+PgloTPHtZiEJ7pxx?=
 =?us-ascii?Q?Hbt98RdkcmLfnXbrA/3bNfnYFj0KNZbdtfi/WgwpwAXEeRyrHgdSMBWDnZHt?=
 =?us-ascii?Q?2rU5zD3Vvi/apoNktiC6NyzVrWshGWyFVK4nTf6Z+xpCqMmRwKNezROI96hW?=
 =?us-ascii?Q?2Dy0sxx8IS0rqcCZ0i5qUyw3FXNRSbd6wVBK+hUp4FHZYajYrrzVaxvVptsM?=
 =?us-ascii?Q?PlrloJciDCG1dU7qCeaA/qe7S6qGfdKfm0N+qyUAIhtSd/CwvPhAR98w0Y6i?=
 =?us-ascii?Q?lgjONb7VN9Wzf4wb/IPY34WooiLjC53xGa1guSWwDOXBFDcwx7EIKuvzyEUO?=
 =?us-ascii?Q?qRvo9tnKEJ56GB6ER/wymWM1UKq+Z9Xfo3q3vYRa+iR6B9/keL/lF0tCS7JJ?=
 =?us-ascii?Q?WHZ4Pum7K4gymGwSPXosIjz10t+Za+RiPBoGaAQrG3gbkx6IlQs93st70tDi?=
 =?us-ascii?Q?DeHskY23NEUM36W4Dn+stC0QRHAVRGODXd7ickyuap4BU5wMu6rkeux/xfIx?=
 =?us-ascii?Q?GVMpYc25ep1PZBxyiDoYigmpm2w7csDDWq/q6zJzFa7jk2TyZo79/L1Io+9U?=
 =?us-ascii?Q?FnQ+fMukpI/n7kUuRGftoU3NWTgCk2QlScUatElrJGm7wRcZzfcaSQib0c5d?=
 =?us-ascii?Q?7KA/sk9Sk8FFqqRho5ATT5ZqXrwuagEiZ8SJ0FEhCTSDqQT+ZtQtcKeV2cFe?=
 =?us-ascii?Q?n4VRqlYlCyPGnDBlaXkgbqy+8RIXGaO61XXxa/Exk3yFKqYlrb2tIxZV/wt6?=
 =?us-ascii?Q?sKCfWTAMvZFAUaDbKUzPXIjoQpPk83dLGO52YCdQLo/bV/Ru0hD30I+4gli3?=
 =?us-ascii?Q?pqAPRHPv/MOCkfBpsb1U7ZjOq+4dHBRVWc0gF2jy/GPL1VJpASDL0r4ET9id?=
 =?us-ascii?Q?LQKK3MwywQfQWbxcVhcFS5Q5WWmL27K8sc2ugUj9HZePaS5lgVt4GSdIBqLR?=
 =?us-ascii?Q?l7ndeF4zV3Ri9jaUdPJ2w8okx+FvoY1KMzQcF/MQ3LVn9jgT2kK1K95Hx/e8?=
 =?us-ascii?Q?8+ran66UrJMnezG8C3UMINTCb9MWsLMq3JBqOGBZlqirU8TSttHSzFtxiYas?=
 =?us-ascii?Q?VTuDqjBKuI7/pqBr0n8sWC58i1N3QcvcZunWlHCG4N//WhWbx5vhGFhkAhc4?=
 =?us-ascii?Q?ljtdVp1Avbk6/DF5h8sOA4R+L3nmrZTWXLBp46Iniz2lUpAGbkJr7yRlDzJE?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/rEoN0o9kGRW9rWKbdDmfbdAh41e3Moor/4LUQO171yQaKVyFuzu1K/wriFLMrF1cMqAPW5JLD5JcVfMDN18ll8tZtjZDiW6AYS/S6WW2a5+WahVcnlpPMFGagOtuwd71Tu9xzYEixc6SSVEU863u61fQ93uJei+3NvGe0AYKaqe8cm7/n7ArN2bKRfQ8JDCFPdfCdYHu+r0kDzkWS83Zl/FtIMB01CqBK5a7OBS4pDdHM3494j6BMb/m21EDU1M8hQLQ4aaxMSNlWQhI/nE3WGnoPMbNL2myh9NSQASjxvSJxUbHagOpm25iFBJHsA7JNlLIZvcT+tzzWW3qXH8MmyzQrAt2p96/mHRORYR/yH00HVhv/j7m0HxE0+oqI4KoSBMkhxxWlMP+LGyQcSvG/8GXTca2Vsu0orSa+OAoHXmt8CrtgJ7vnVAzuKwHFydr1cQrDQrSSoNQ3zS8qlgbotiZPF994FDsWPDxZ6N0EQ1NprPip3MpcE9wvvRJg903yEWefL4M9TOcqwkoSpBEId9dbmaaiT9jl0S02dSzJT+cbH1oKajE5a3fF+GdyaeXnYxOsT+vCnsjSPhdoinwUoghNbWpAC1roqTNDuW+l8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9094d68e-0c63-454e-e8d4-08dc9ce8d806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:51:45.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVAhKGYIFfHmaUQmmB/9dJfCHQv10nEy2SoZrrMWPT07R8jpqHVQPyurybViDKM5ZrzfmLSK7oi26yRY0fhcTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050088
X-Proofpoint-GUID: 1Gz9HHyYjJkNK446ph_2RTDh5cCxtdXc
X-Proofpoint-ORIG-GUID: 1Gz9HHyYjJkNK446ph_2RTDh5cCxtdXc

Some drivers validate that their own logical block size. It is no harm to
always do this, so validate in blk_validate_limits().

This allows us to remove the validation in those drivers.

Add a comment to blk_validate_block_size() to inform users that self-
validation of LBS is unnecessary.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c   | 2 ++
 include/linux/blkdev.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9fa4eed4df06..55eef9541ce1 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -235,6 +235,8 @@ static int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->logical_block_size)
 		lim->logical_block_size = SECTOR_SIZE;
+	else if (blk_validate_block_size(lim->logical_block_size))
+		return -EINVAL;
 	if (lim->physical_block_size < lim->logical_block_size)
 		lim->physical_block_size = lim->logical_block_size;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02e04df27282..7eb165bcc069 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -268,6 +268,7 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
+/* blk_validate_limits() validates bsize, so drivers don't need to */
 static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
-- 
2.31.1

