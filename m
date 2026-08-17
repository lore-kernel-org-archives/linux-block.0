Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908B463B69
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986373; cv=fail; b=iU+9TjqZNmhzIIlBDfEqeREHCZrVa1/dWheLw/Gxw8jHecxEzpR2h7RF5LR6ZpTn/7378wKw/cNsHi+1nwQ20Id9veZ7JHGewq3v98Ui4Xl46LT53enq8tXhaIpEukrbWdq66cyzd08rYX60sAC6CMmaUpNtXvRjVGXai7r+7+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986373; c=relaxed/simple;
	bh=TJQYyyxC3Pu+KHDBPpn1s3/InNPIoRy9qYnzGUfuGCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IoWySzgAjDD8QIwXmDIBFRGuoZ4EuGeqNGp0YdWHTMaUEPZIGLncdsxn3kQaQVwLbt2SgigJHpoLGnGVVMiFXqlyk4BL3uMi1l26MCSNAkkum+IEdYjT9x/0XC5mjNf0luZcNohuetGL4dCf83HzGTfLmA5tKy4x7kG6HhX/y/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SCjSPHKe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DuLJfVDv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SCjSPHKe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DuLJfVDv"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFhv6b1095705;
	Mon, 17 Aug 2026 17:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=44ZQPqIfr2Ui84Aq5j2ISGlL9mPz1AJADI9Gr5/B8zU=; b=
	SCjSPHKehSANLjWpbIocyDBN7KNJv3+SZvj3lABDSkdXvp30/Zuk+mWlZ+w5Tmi3
	FeYPWGXUe+8PR22yetS4kSFLSmtdHyTXwcU2KZ9W5RjKCLiTzNg+s943QL71Ux1P
	id7l5TxW67f9irZe2BHkDpOLpaI+thJek+onOQjkxyzsW90YY+A8byPogG03tJst
	/ySCNDULxByxuUzHKBzcfr7HqvxBfEKDEbSMh9G0f6OrKEDIikZkUuocrtpnrg4N
	pujy3rQNA1XxapcztVgp1fmiASZrn46xGjKHy3a2CFPCx+UI3b0b/pzTmSu8zwEH
	e10vlVlhnjd0WZnUBjQ3Rg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2g07jnhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 17:05:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67HH5ZiJ026588;
	Mon, 17 Aug 2026 17:05:49 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejpnjee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 17:05:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJDV4jcuOVLxEAVu2CUwiBuFW9zFdz6ZkRBcksPGTM6EsDjTCS4ZMYPxZXdN7JGaPlu3ced66Gm/nCo3s69UQW9ictU3iYp/90eAoWHHBRPzad6cRGyhXqtpSTTXVlwuZLEGQf6d0edxKBSBN7LCmoe8md2XUoTO1bx31N8mhQEXzqso+bphmd0F+ym5Ru2NDShqoy1xVJgtS1YkrT3rxXDbM5OKZPlvtdr+j6jFiXsAZBPnCE0O/ilHGYcg5RDofqwA2twozYfvY7b24YZOWGe7PkNJy51dTHVNHNA9eJJW4un4LzHJIOdc/NJyb0v1JMHADn0UZL/9xXmXFonwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44ZQPqIfr2Ui84Aq5j2ISGlL9mPz1AJADI9Gr5/B8zU=;
 b=c0L/7JjJhd+oBYF0Uw/N46q85rMI1tpaPo93Mhsp0fxHyoDEV/ol03XOOL8ths7wccmfuFryhydalDjhCOaidw7UPHg/nRU93WJgBbHyMmWFoaOZyZ4bS/P6YhHVd0W4RRfcgECYJK+AUDLXKH7GSWOcvkHa5XVcaEFb2AlBVnyXFWSYjbWoXO9K5CPgGIqLEwn4kfHG/bj5zDx4doncpZsoMP0eZy5+f1SUhPeqOgMry+BA9LOnJTPqz7JpJRWmXcBBFO09sC+X+P3B+FSanRCNNzM3GOaSj2sA6HZvZvpJV3rtBPXTIGOEjdyHVSIFEkfhZz4zbDPZorQzgX8NJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ZQPqIfr2Ui84Aq5j2ISGlL9mPz1AJADI9Gr5/B8zU=;
 b=DuLJfVDvkQyr1HfBzojWacRQ0fUxZjyOoO6c7v6YGnAX/CCOYd6nh4sGiBOumyl7YC6cpFyAKnXSOXpE5POsLDhCO/D/G87hOF7NYoP3mqJeAQ3Ny7Q7gxu74zDXGx6KXog8bRLFsedkRk0B34Iic1FuGyb1ilXdaC9ur8yVfWw=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH3PPFBE86117B9.namprd10.prod.outlook.com (2603:10b6:518:1::7c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:05:31 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 17:05:31 +0000
Message-ID: <58358ff3-2c59-4ebb-bfa7-3ef22a7fb1a3@oracle.com>
Date: Mon, 17 Aug 2026 18:05:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] block: factor block size and alignment handling
 out of blk_stack_limits
To: Yao Sang <sangyao@kylinos.cn>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
 <20260806024658.4193386-3-sangyao@kylinos.cn>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260806024658.4193386-3-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH3PPFBE86117B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 968d4a38-8923-487e-1c25-08defc81beb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	YzY078NdpV7cnVr37yAziLWN8bea4BgZu3C9AxqTdSQ49p08HT9rOoJTcuS47i3k5Z5aJQhMEc08qcRqsPsKjHKBgA7m7l74ZC1rd6JzaveNZULYcuEu6b82aPmUddoORwe8pmE3pMRClyqCoJR3Iz0quyUTbhneo7wHWUSc4Ag371R6he62Xo+rKVq+MQnkAWRbEqjNvXXIC0j2NMzWkdTH8qMy9G27R5N7KdyuwfUjFdwCswaAClPILEYT+p+JpehGY0buEKM0Ulm34njUgkPT5johQXwf5nf2+98/Z4/EVlheFKf7CqmXT02k7hakse3mfLO6LDWrpoXgMDBOnGDqX4CSrzsardt0VTw9yjx+CtnufbCPOksF7z/Qfu+EiJOWmK/9sWC8nSUgykKEVQWAJGsu3nGPHt5Xg0QKT2NDkwNLSHf/7uomxaPArV4XPtkGploupqwW2pswbvcyndDKHYXxXYP3W/9lYWQZbzIGI6dXjv2uWdtC5638vhvdVIp+2dQ3ARMB6d1hwwsDVSRwCg1cZU2s3ngWmMS/1/7O1+kOTv72/QqI3uRzmHFkmJPY7Dl1t1unXibLulXFnUEVE8A1iG3ZGcoXhtB6tizZY3Umaw6MVr7J90QTGb27rAvWtuuSx0IKl8KHASs3y8olCNHS29QBIPdqAPcr9vc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmRXbWs3VXFRMkNTYVpObkhqMVZSOFF3RzM1K0lwQ0hudFlBbUNlYVA4ZXFj?=
 =?utf-8?B?enBtK2RtSTRUMVhvT2I2L1IyaXZiSVFmaVRDM1l2VEtvZXVJeHlOUU9tYjN6?=
 =?utf-8?B?SU8wS0dsN3AwZWZEUnpLL0VMelhRVTBCOVovRkVEV0RBODdlbHhNa3M4TVlz?=
 =?utf-8?B?eXhMTmRuamxERU1uNy8zZEtPWnhpdUFLNmdKYjVXVmtOSTJQUTVVQlpBTG1V?=
 =?utf-8?B?Z3hTSVZBN0dVQ01nQ1pyZGQ5eTJvd2hISlQva0k5c2tVQytrQXV4VFlZem1C?=
 =?utf-8?B?U2FnZ05mZlVBMVg0d0xUT3pXdHU4eVlyMzlVM1djeEJkTUJtanp3aEpsY2Ev?=
 =?utf-8?B?ZG5OT0RiTXlOVTBHeDl5c1ZPbXRNWHNCNGxjRXl2cXJuTVRnVGxPMEkvYkVn?=
 =?utf-8?B?MzlpSUlmS0wxM0xFbVh5aXg5NFFsdDNEOEdQZ3VQY1Q2d21XeUN6aXpibnYv?=
 =?utf-8?B?Y0RZaVJXZjRKVEdpaTA1aDVvcFJWNVVtcHh0T3ZreFRLdDFBTEFNVDEyZ21j?=
 =?utf-8?B?eXR3SFRqdXlydk5tVWl3cHowU2trNTNzUXIwQjEvZGpwQUJRS1FNRXFyODdj?=
 =?utf-8?B?UHRtaE0yd2hoYnUybHhKbkNMbGJSMUNlUzdYbmx2SlZPaGk4eS9FNjFuT0pK?=
 =?utf-8?B?NEhzQTBjYk5MRytXSFM4U2FYa25QeDMwTzhUZ3pTREY0dFBweGsybzZZemdU?=
 =?utf-8?B?UXJ2MlJjNDVaZEYrOFJKUDh4VnVRbVp2TXNINTE4UDFqMUJ2SmkwMktFZ1Ny?=
 =?utf-8?B?aklwV0pJK0hncTBhdHhZSDVWVjJkczFQVGxhR1FjK0dMK0E5VVZNVWlzL1ZZ?=
 =?utf-8?B?NDF5b3RWZW5LeU1xeldQa3E5eXVBc0tqTklCYTRhOXM5L2haUWJKM0IrSU1x?=
 =?utf-8?B?SGNwUW9qNDF2bFFlU2pIMkdidFVEQzIvRlZZblRsRHJIajNvM3Jod0FBTHV5?=
 =?utf-8?B?N09DQmkwSHZsS2IyRU9YdzNJTEI1UmlhNzFMa3lJU1A2akpqTWxuMXMrUDNS?=
 =?utf-8?B?QVE1NS83eU9OZjl4UFNlZHYxbVZmLzNXZFJzUnljTlIzQTR1dmZtc0EzYTYw?=
 =?utf-8?B?VDA0amtjeUpvNFdNR1VWbHJkeUkzckRCQXl3M2JISWxoSWRMVzBBUUpEZ3dH?=
 =?utf-8?B?ZE9FSHdPU21HalBVd0IzOG1yWis4T1BvdW9HTGppNnFaQkNhOU94WEFFVWR2?=
 =?utf-8?B?ZXcydGtXenVZQ0lycktoYzVHYjk4RHlLT2oraWFPY1FpSjNrTC9XV0VLaE1G?=
 =?utf-8?B?ckpTbUFlU3JLRlJtdzdTWGtpR2VTWG1PNU5uLzExRWdrc1J3cjRYZkw3a1Rp?=
 =?utf-8?B?Q0ZqMW5yMTVlNjhNTzdpVmVaYk8ydmJzUjZ6akREbUVscXB3WTZHOUtFMkI2?=
 =?utf-8?B?dzRGa0hlR2VLcFBJbWl0OWUxOGNaWEtZeWF2cEh3VzI1QUo3cW9maFF2RjF5?=
 =?utf-8?B?Mm5QY0tnejN5SlRCY3YrL0xxMFZvQXdVN2h4N1ZjdTBWNEthaWFJS3Jhb204?=
 =?utf-8?B?K0JJenlPZFdHaVlDWnpVWEFOZVovelNPUGY5Ym1vTjY1RDJGZTFUbFBOZ0JN?=
 =?utf-8?B?TmpVdG5YS0RNaTRMemZoY1pFRlVKWFcwa2VKcXV3UlJ1SEtRaUVVOGIrTHVU?=
 =?utf-8?B?Qnp4SlltakYrdXFFc1YwVmwzdldHZlJJSkVZbHJXTnIzcVFvM3NJQ0VsWEdV?=
 =?utf-8?B?ZEsweDRucnByb0lmU3Vqc2pVWjJDVjh5azNrZFQ5WHpzbGt0Ni9VdlBZdlFJ?=
 =?utf-8?B?WUJYRXhaczhTUC9RWkl5eU9LM3prcjR1R1NhOG81SW5jUHpEUE9BbVhBdVBX?=
 =?utf-8?B?TDVFdVZUNDdNWkt3L0I5WHFORXF4VzZNNEI3SkZuREpmZ1F3Ly9ibnlHMFFZ?=
 =?utf-8?B?d2c5MGd3blpPTFNJSXJDazNWalZqVmFZRlVKaGFmZDh6ZDU1eDQzTlREd2lr?=
 =?utf-8?B?b0JwT0NYS2FkT1pmYi83dUorZjczMHBXMVBIYWJ5UHBsV2d4SkxHaGViblZD?=
 =?utf-8?B?cTJLVnhOTmhaYjNmbVp0YmxlamtvV0lOYmk5TVF2VnZBb3hDakhyaEJVYk9l?=
 =?utf-8?B?M3AzdlBUN2tnUjkxQmM2T094bXFzcTQzNXo3cXE4VzR5cHJlNTNSbFN0aWk0?=
 =?utf-8?B?Nm9DV2NlMGZkRE5ZdzVpRFRtVmg3eWtNOHkyWG1vNjRqTkxtTXJyUFpVSVFv?=
 =?utf-8?B?NlJNVXRUQithc08vMmRON3Ixb1NGZkk0NjJKTEpGNDVvQlFWYWt0MXYzWkpL?=
 =?utf-8?B?QXhWaU9KNWNJbWNQQWFvSy9DZHBZOTEzeTlnaUtFN2RkNEdzekhaNnhxWFVy?=
 =?utf-8?B?NytsTXhTYzJwYzRkdVNlSjZUbXk5c3NjMkNoTHBMeDI3Y3NxdE9yTVZBWGlk?=
 =?utf-8?Q?wD0t8P1qYWqbEQlQ=3D?=
X-Exchange-RoutingPolicyChecked:
	gTyAxXF6stWBF7ygHkI2RMMFyEvcFF2NEGQmmH+RiLfKiPSdKaWHQZD2KphcWmnv/YroXQqpLAVNxxi+PrXk77Wf3ahiGM7XnS54iXIOsaHkKLz1MWc/FtMukIWPZZWjxn3iKBpXA1BSm9vHmvEic1cBrs7ipYj1O0MFOTybgt5LrQ8dWKJKQ2UyH4ytFChPUIowwpdYpC5CSzGQuXsGCTv+yxdBGuOEZYSLZQv5L9AjTlFT5leGdiiqv85e3mMAcGlRIRCjcbIyaME6sVarQYBkYrwDga7AbpWI/K/1lHN0KJZxdkyqycmw80Y8lvMqwhKba7YYCosfjvwUQfh7EQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kofCQH9xHN7dhruUN3AtNKmcbYP25WoaWZoax/eG1+NQIqdsOedbMi04XkD6mAzkWHduvgHlCKutiwqtxtP9dR+wJ0T4+c6TuP1qoWj9wxvtxDbGWl3Di57SwuxxOJZ1qDKS13KgDQR+lHsOKulrwS3iylhHzBHlT4kZ/cbpSiutHvYlTepXy7xU5b+b6Mthx68ZjiqcmCI1k9SrrQASuFXeLjUzzjZytahVQoxPEG1nyTMJ/tR7x1q4ZJIW4C7CYG2jM88qYTbP2UVFtX8mmDewEF3u7gw+bMgaYVNvym5G8nFIfZugCwvzf1Y6pkDKWb+2kUA9C+ANT8p8+/PEV3VOrSG2VDYOoS/IUMe2jLppqCU6EKeOtGsuDCdq492beeLzEeQbPYsytIrZPuU/lhSX1x+1B0NLD4OFWr89hZz8QQsgKEPEXLga+xxaKKEG58scl9iID2DL8wWFKOUD0DKS8Tc5Eo+j+eEQL8kUElK22KsG5ELTgTRFMTC3oKoSgrtvrXsuNNwkrrILLPX2Ae8gRPh7QLIDiz1/Z/cv5xS9W7anW+OgnK5nKiOho7oi2D1UHzlLKTxXKleEHS1L0WC7GtEnCSknrP4AGpZNAbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968d4a38-8923-487e-1c25-08defc81beb3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 17:05:31.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnWaFgCvvX9XwrE4gbtSNY+1KuI1lOFmnF6UE/teozZ925or2SqWbpscrAVvGdLMlrFFQdhuHT0Mf0AnxZ+xrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBE86117B9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608170131
X-Proofpoint-GUID: vYXm_v-absF6buJ07gGFonzHxl8qtYL3
X-Authority-Analysis: v=2.4 cv=Hu9G3UTS c=1 sm=1 tr=0 ts=6a833f6e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=2Y1E1HC7-X-LOBB87MoA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12098
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEzMSBTYWx0ZWRfXymkYBBz+n00k
 X5hscEO9REo1XQJRFDVF5fjiD+3DHVzes5+Ep273FQFg4CFUp7V8Uyrg9vBSOBu0EBp5ZO194en
 2BB5jLQDeXsNmGFcfcHlrRa1Fh6rvPoAwkK4ibRpmHk0g20vz5G2
X-Proofpoint-ORIG-GUID: vYXm_v-absF6buJ07gGFonzHxl8qtYL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEzMSBTYWx0ZWRfXxQGtZIq1iZaL
 XB21/3zNRo+UneUdxf+lmYKWknFCgHiQki+QZHcYZn+3CmT6H3xm0MdWoAMXDXCFtLZPyS2sgJ0
 1HqpIgu5HGoYDchurHDZtZFHHmaK+UXM5cd9Xo/JTH6ycz+CT4g2FyRnVPzLPOLWncAj6gubdrT
 ydvN0EQ3apSa1vLKLBmmpJcf72Q4K3WoCpLI2wllEiXXMrbDIHWMmugZO8UPcccjUuT+X937pSA
 H5GrX4S+6fX01VcDNNYIAO5FKkgc6yjf+akmUzh6/uhPUFrrScIUzZNoiRijtDP0UYTRN+kTwkJ
 Auk9kt3Dg60dcdjCWo1vJ+TlYr9Lxj+Mv2qhlsExbmqLcZ88SL0NSMFfBj5hT5gIt+wXCjJWmdN
 4sjAKffjFd//zycAxKF2I+OQYjI6N7P6IsoYPQYgoENXbCLjv/PJOv/1FcwR1dqtBRcVo121L9B
 3Jbd+PyypDzhUGiX/vy9k3FMal5hsGR2niNMY41c=

On 06/08/2026 03:46, Yao Sang wrote:
> Topology limits are the block size and alignment limits that the top
> device exposes after its data is placed at an offset on a bottom device.
> blk_stack_limits() uses start, the first data sector in the bottom device
> used by the top device, to calculate alignment_offset.
> 
> It then stacks logical_block_size, physical_block_size, io_min, io_opt and
> chunk_sectors, checks that they are compatible, and rounds max_sectors,
> max_hw_sectors and max_dev_sectors down to the final logical_block_size.
> 
> Keep these operations together because the checks and rounding must run
> after the final logical and physical block sizes are known. Factor them
> into a static blk_stack_topology_limits() helper.

It still is not clear to me what is the criteria for a limit to be 
evaluated in blk_stack_topology_limits() (and not in blk_stack_limits()).

You seem to be just saying that some limits need to be calculated before 
other dependent limits, so put them in a separate function.

> 
> There is no behavior change.
> > Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
>   block/blk-settings.c | 169 ++++++++++++++++++++++++-------------------
>   1 file changed, 93 insertions(+), 76 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8274631290db..1aff818aaaac 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -756,6 +756,96 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
>   	t->atomic_write_hw_boundary = 0;
>   }
>   
> +/*
> + * Stack and check logical_block_size, physical_block_size, io_min, io_opt,
> + * chunk_sectors and alignment_offset for a bottom-device range, then round
> + * max_sectors, max_hw_sectors and max_dev_sectors to logical_block_size.
> + */

This just describes what the code does. Anyone can see that.

> +static int blk_stack_topology_limits(struct queue_limits *t,
> +		const struct queue_limits *b, sector_t start)
> +{
> +	unsigned int top, bottom, alignment;
> +	int ret = 0;
