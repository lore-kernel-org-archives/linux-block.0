Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BF3F39E9
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219835; cv=fail; b=oFsUFP3DA1p3+dBUSFPj4D7SSdRCN7RbZ//yjmosKMiXwwsFa1pCdok5RaSEcInVrmTpd9wuIWgABYWsLNKapni+xBYaJCd2cQz5JxC76WPP/CxoawW0s3vg37T5tAHWKm9SKyMAk44IwDTJBOZsBLpvMa1SvYWEtuFdEq+phAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219835; c=relaxed/simple;
	bh=UCn31ammgsNkG+cCJvv2FNppA6LZxkMxCXHgErBd/bY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G0hzdSX1AFB0tgGBGA79mI54rKeO2j5nEZ4S++OjhxqU7NXLFs07IPiYkuVCO4t48OxIe1eN9PhWnDw+bs8SE2m4al65p3FrtCIv0knzOQOFpQIPjgy+Ca2RVIYotX3TJD3LXfsoS0sQBFgWI6Hg2EDy9wZFl2byiiNNLYhtLZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UkqhQHPY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sZdWGgkA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UkqhQHPY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sZdWGgkA"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GFLlY6843276;
	Thu, 16 Jul 2026 16:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+lxSxxuZCe3N8A/ClHtQgv6MOdon/DU0H0Eh9kdIZIk=; b=
	UkqhQHPY+fKSP04ZEICe8ZMC81JMARJFNEZcS1+pI5d3dhUEoZnALSO8XcWwGgg9
	KxA59xXN0hZXhGG8VtLQb4/k/siJOs8d/OJYdhK/4v8f+Auqe/iAxOlDZpJeU66H
	a/nLkAIz3JShEF0Pi8QZtrl+0U9al2HXJp7RLhXlGo/XSGjJuu4NuFzMF164f/n4
	wr4IjOow5wVcMkbGN37JHutJXIO6S5XxLdDFU5A/KdnqarJ+giY/usoc6bZoOMAe
	nQt15zyJDP40lfwrTc2ZYrWJxQnWp3h9sW62BPyFaOpSqTNQt6tLkp1ybg3MmP/T
	e3TErf/C2V+yBAwDgdl9ZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep391em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 16:36:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66GGXCio011530;
	Thu, 16 Jul 2026 16:36:53 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4feqycn459-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 16:36:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klm0zhDcUXWfEKGZuMaKFSIo4tO/R9cO9iWmlfGLoL5XpC4wRzh3azlgV1008jj1vGDz4G+5oO8TR/peVukaXG2mZhV4lumyeF81wS1iylxp3dJvtcww8Q7vZh/b8fwEI7m0G893iT74nG6W8Rqx84dEGeIwnfJC+SDn95ulLHBfjylkmkP26fFsvDZ7Whb6ytj+X51WgZhIHFE9sV+li6PcpDqDGctY0RemTVfzg0JRcNsezubnExovBDaPxaUb/9tGGeDLTxDPMqyAJIh5xCG+eGQKinJcKFZfJxqwKcr7OmElnvoBDlAl04HUkXyZDq8rYyrKvveL71/JNPQfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lxSxxuZCe3N8A/ClHtQgv6MOdon/DU0H0Eh9kdIZIk=;
 b=QGdLY63be7hIFlSYpQJ2xqPuKvZvF8Traq7+zKH9cO3rVt3FAgqdCXVfnFRnN0+30N5mRias/GITvC2Fm5Dc6ZRZKS1AGqNyHal7/EWua//7fYgzM23X/J5u42u8SAEpEz2iehHXj5uy6YovIxwT9m75dHwiuLEXzKR2c1k6QyBANXu4uZ44iP+66ZdTI+ObCPQj055E68oAa3Ek6qkMvWaakFItn3CN/D5stPa65TE1qTFM51yMIxn8P2ZCza0be5K8XbsuODZFmwsGFkImRpyXbRpx7eaA3bJBEevau46ZSDUw2cTJ2KnXl6Y7vKnkiwaI/C80D5qTh/DD7ad3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lxSxxuZCe3N8A/ClHtQgv6MOdon/DU0H0Eh9kdIZIk=;
 b=sZdWGgkAU2a/J799eq5hzpSo0DmQhNNuSSPO1Sf5KPvyoY86Ta1BpMwmiPb3P/w9nDCOBo9OADIDK9BU+XfEHFZAIh6j+NorgPB/a5Kr9WU9PM3t+6scsxcMD4EsPwJsEQ8HctECoHJgjSwDcwBolgnflwO7luTfZwAtHaQh/do=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 16:36:50 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
 16:36:49 +0000
Message-ID: <ae3a2f44-b26d-4040-b9a4-cd6122dca29a@oracle.com>
Date: Thu, 16 Jul 2026 17:36:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme/069: add a test for multipath cdev lifetime
To: Nilay Shroff <nilay@linux.ibm.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>
References: <20260716082927.4053505-1-john.g.garry@oracle.com>
 <a4f4f444-967f-43a8-becf-465a3007ade8@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <a4f4f444-967f-43a8-becf-465a3007ade8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0107.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::22) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SN4PR10MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cb6eea-74c9-4082-86fd-08dee3586ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2n1rzpmsA8ZMPMgKEwPM5SzcZUmZvtxKUVoPuAQ5JmHlZucHfg2Y4DhKKBQ/OX4Dc1i3F2AIfK+KDEYrLWh02Q1nqEtktKeI2y+BoCBXkpqMPK1ZJclbcMUM13uL7+0C2hFVyNZ/mBKWlule9Azg5HnB2XLOT0NlB+nGA8j5jd3aOgdfiu2pA0jS9YDTthkO/KxHV6cWRlo5ABzpF2W2wIVKn9DJkPTD82djRlwSfunRhIl3CaMU854SNAdsb+MIidi2ZuSAjD3e8lo8Q8hfqSrrpHLxBq3g3nkId2eAgsxhbv8Uka7IEm3dfbYs0LEB24XqUdCL+eWRMpFyL+vHXRy5AGwX7/htFWI9dPA2p/1o+H5hJelypGat8LNECzXJ4pR2HbCLUf9uHPMW5udZiZD4tVFU/v0Sko3MIOSx8i8d4lzGhVfxKyGnPeL/8uX4W2nBPDVBmQ7tzdE0432vwT7nxdPcOcNUv1/LqGiX5oBMNdSSX8cTeg5YNAjfPO23Dx8BT7z4Cf13CsUPWj+KdOySwQpschJZxnoDNcOAoSitGFFNKDBGeI4XqbubPakA6SBuEFW6n+zezscxteHd+bNKSNEH17DqEVV9kZK9WE4ysXqwBHb1yaWm8j+D2p4Nmpd9f9WJ+w/xkxxQCgwCZL7I2/a3kEs2KHdJOne4eSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHRlOVE3SkhzSmFiQnZzaEprcGdXNE5sa25tdW05WmRENFg4UmsveEhVa3Iw?=
 =?utf-8?B?VmZFbktEZzFvWEJiQStzR3ZLekI3V0hxVmdCYndJNWZrc09aVmdSWGJpak1U?=
 =?utf-8?B?ZHVEYk5WV2JLWklEcVhvS1c0RUZEN2RIT1kzditoV3Z3VjZoaFdnNUdoaTZw?=
 =?utf-8?B?SnNmKzVOMXQ3a1JobXdmRGRML3R1N2s0OWpNUHo4b1FHQUF1S2pXcXkzbGc0?=
 =?utf-8?B?TDNiMy9CK2QrbHNIdFB1ai9xeW5JcTBEWko0NnhYU2EzZ2lnSzNwUE1uUHNx?=
 =?utf-8?B?c3NzVUtYcnFQYTlyTUNGbWhJdGpYWExuK3VzVGk2bXNMa1VlZHd2c2FnbWJx?=
 =?utf-8?B?d0JOeGZrRWZ1RTE5TVlCakxnMUUyaktmZmZqbjdScVN2Skd3Q3k5WjlBZHNw?=
 =?utf-8?B?OE5IUk5GTGExRURCRGx3am1hVGl5V2xNaFlmSjFxU292TXJZZ3gvd2JUcGpH?=
 =?utf-8?B?eFdlVWltOVVGLzY1WGFmZFhWR21hSmJyZnNPZFNkVFdCSW1zbnFYZll1a1Zh?=
 =?utf-8?B?VVV5Wk1uRHBCMFJlL3RjRDloWWtDYllkMDlOL2RlZy8ydUxBWnlieDRGNlRy?=
 =?utf-8?B?YzZpTHhySGFRQkNkTWRuUFhoTXRPRU5vVEFsZ0cyQWVpUlVKaHZBOWZ5Vmkz?=
 =?utf-8?B?aVJYbXdVaEsySDJjYVpub3Q1OW4rVjFMVzdubmlxM2hjNVN5UWY1L3l6UjhX?=
 =?utf-8?B?QUtnZjI2NmJ3WmtvRlZEb3hCOW93S3RkVERWVnc4TWJJMnNGQ2orbVlLVzRR?=
 =?utf-8?B?ZlVhenAxUmZwN3dxTkY3QUMvRkFzL3NBTmpEOE15OWFOSEx4bHB6NFBuTGdm?=
 =?utf-8?B?ODZDZDM2aE5Jdk9vY08wbUZQY2NYcVZNWGp4di9PTUFIQ2pSOVMzbFdZc0NX?=
 =?utf-8?B?cVl0ZWhpY3liakw3MDdXeTZPbmxoMVQ0U1NRejRhRmlwUXRKZzhYRlBVQlJy?=
 =?utf-8?B?Nkk3a0ZCSzUzVnArVDFFU0Q2THhlSUxvR2VsWEM0L0ZrMmxCaCtZQ0V6NmdS?=
 =?utf-8?B?UjUyaFRtU1hxZ2NQMkk2YnlpeWtDS1U1NGh3UW5GVC91T01KZG5zR1hpaU8v?=
 =?utf-8?B?TUFPRjNZeWxZa1BoZS90Q2FXTmVzN2xPR01ZVVJzdU55THB4SE1jU29GYjI5?=
 =?utf-8?B?YzRxYk9JZ2JmdHF1WldBdzBMSVExeTh1d1F3R0p0Qm8yZDNYTkRUOWNTWDYy?=
 =?utf-8?B?NUtyZ1Zxem4wdWRrbjF1Z0E0YzZKOEVFZUFqeUZ6RFREUjdqMEE0bXpmNktj?=
 =?utf-8?B?RzlMRzI0MHpreXpZYmt6QWo5MlNHbi9aOVRFN3JsNEFSV2xpdFNsaHRnenZP?=
 =?utf-8?B?UDdvOHRsNi9EL3BrZ1k1VmgwR1FOcW0rT3Y0NjIxdVd1VDVQUTZaSUxENWZ6?=
 =?utf-8?B?S3AvRDJ3dGhCcnFiUnJUWXE0VFFsTFhOTjVqVjE4dWFkQ0liMXVUQWN1MjlT?=
 =?utf-8?B?dHVDZm1DT2lUY2l5dnJNV0lWL3AyQWcwRzIzUE0xOWdZR3Z4bjhVT1U1dHlz?=
 =?utf-8?B?TlpLS2tKbjVsL2RVRW8wSlpQcnFHQ0FOQ21pMjIzYXZkdVptSnRyWU1UKzVD?=
 =?utf-8?B?NEdGa1BuMTZlZG9PYW9LMDZydUR6bytzM2FYTFNOb0NmMUVTWjA3enVpN0hn?=
 =?utf-8?B?alhNeVh0d0sxRWU3MG9BQkV2ZUQ3RXFjbEszZnlkQnhEaWQ2LzhKK2M2ZC9l?=
 =?utf-8?B?K0R1REVpU0NVZ0dUSVNOb0RQMFNpOVNwSmhVODZISGtDU0c5RzhkL2QwOVp5?=
 =?utf-8?B?a0R6QlF4c1Z6SE81TXlvUXgrZGN2VVdVaDhSZFdHVWVuVXgrZ2NCZm8yOW84?=
 =?utf-8?B?VmZVU0J5QTRlcnFySkZRZDh4QWNQeEhRMGV4bkhmaWhyOEFwOFdPaEJ1Z3I3?=
 =?utf-8?B?L0dRR3pCcjlNQjhwaGxIeGZidElQY0Qxd0VJcjdhTlE3K21sUlh0cmduQkZm?=
 =?utf-8?B?SDdRTDNkMHBLTFR0Rm96ZS9keklUdWRvdWFLREhTMVV2MDJrQ3kxenZCZXhR?=
 =?utf-8?B?MElyNTJCZmFwN3VuODlRTlJrRmNWaDdiUjBYZ2pnb2NPVnEwOGZ4MUN2azhs?=
 =?utf-8?B?SEtvZHlZeitzLzNvb2RZM1FWK1FYc0hpNGFTRitHQ0M0cjZ2UElUcTd1SGxo?=
 =?utf-8?B?dXNIMWNVdzR3YmVQVG90aFY3QSttMHVDeVZJRDdkdEpnQThLOUZwQnBDVWxa?=
 =?utf-8?B?ZkVFZjhRWHJkY2pUUTRTd00xaG9kcVdYZzBHNzFhd0FhWnJzcGRZNkNRRkh0?=
 =?utf-8?B?dTludzVhaGg2NGtiVnpHbktMYUZRUGh6dkRNVnNlVFBXdVduUjN6UjEvVndE?=
 =?utf-8?B?d0JDb2k4NVJJL3lrQ1BTWlJTU3hwVjg0c2l4MGxVRkJHZnBVQ2hBR1liN2U0?=
 =?utf-8?Q?fwCo2mI5xIxu9LQw=3D?=
X-Exchange-RoutingPolicyChecked:
	JnaKQQDxx4YIYOgCd53Po7nm9hBVB7OhbTN074ubIppJ1U5TUhTBivFYLH1O484t41BF72b0rmXYf6oxZAggsoWKEtb6s7pLlAjAsB2XKYsMw8BZrZgGH8BAys3AJ6CCH8+tE8Gy6hhLQb/KybfHjkJ0nUXzPryzjwNT0dCURvrcw2FHrM3ZxvYN14ZYdwKTKCb7MFO1vYgHgfoaSlc6XFquxYoNbwLtWvmwYbrjXrXnBwOY1KycZCWJA+OOYE/gt4vB48NeeKLL5aKhzC3frBw4BIBQAv54WApxdstJaY6PxgXDS4XpgKHuyDVavBuivo03R8sGVx0yHxVsbvqsYQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AH3ef59KLz5Xu7ahpEyPY7lkw/HBxMsD1yrjy2m2mH8X6+1FIYjts3Jp80OSEmSUZl/5gmh1uPJKDRnrunx75lWKwl2/kgh+FCWXEFZj+HCO9N2M1j+Me3MO8Y4a0v9roTPP85h4wKpCNVJoK6j5UBImX9z8AOgWJr2l9mZIypwUQqHJUZCI8xjAFLMZ2uCwqIsxhc0TAtdk4fZ9GU6gLaW51Ex2PrwzZEAiTHe5Y6MY04pWU26YL0ACCXeXaXl7aVUaOO7twex8yunsvL94YboNgu2Uma/4q6kXdgrTb5WtLaMUuEBQjSJPy3PPoSYOzqPgKSJFFE8UuLMBu3o8cusTLV2SRaikRrH4fGn7BmHRZtT7VKk8pcR5jvwZU4D5IFJp3W9H2ODzN1Gwk0yHuzIZAvv+zlnmlQ9InABtRFr8+IaWHKS/G8XZvfAyPAg2Gz9bADtwk0OArMPo0ZJHUINCDkTEVS7VXnXIgJ9bSYbZEH7+wq20egQRw+MrxL8hl40nQrV4qhU2MwJDL7nsicwrdS7QYNxumMZNQAmwH77P7QtXg0CWSQQJ2HJHO+7Wg05TgZOa1RdeJh6mcwSbwuW4R2XVMJKzDs6wbO+yt9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cb6eea-74c9-4082-86fd-08dee3586ebf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 16:36:49.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k28W3daD0Eubly3P6l0GRaV8igxD59CJJo0hHp0lL2cWy3OM2talraMCXD+/uY+GfmGwjdz1tzk7+JXLohNYJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=742 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607160170
X-Proofpoint-GUID: buP6PO9_FABZTxbohj0offmgmwnkvOXT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE3MCBTYWx0ZWRfX1lpw8jHrCA/c
 ReiKCbA9BFeJnE38QZPIrc3bmyf4r1cv6e/MG8Lhxs+o4wEUZOd8luf0skEYioLNXgxBOy/Qm6b
 mKHMRMdMsnD8FQNvxy1pINJSLjt/8E0yPZUNdH3xXNpGkSrQMeXs
X-Proofpoint-ORIG-GUID: buP6PO9_FABZTxbohj0offmgmwnkvOXT
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a5908a6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=Div3BxVobdCgMFV0OP4A:9
 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE3MCBTYWx0ZWRfX4LBwG0YsbK4w
 o89b1Yu9Q28tLzZnkvmGA8PC4CHgTrTL8KjRT7LTaTtXBDc1U0ReJqOGxGF0WW0FbSegLu5ICxG
 LBGtQUfaKg+xxAXdZSqt125hg2/msY2bPdOaT+/HN/FsN7wVO1d5krmpKmQW63XKi82a1pfr8+b
 NDsMAEb3tAB6OkOb/zswcIeyJKm3sBBb9b6L6PY2a1BKLSMRIrdzP7DS+2ypXTATQG63tXzZews
 rkRjlD+G9l+hzYh17kckae624udqh5BbtlmBarx5BIpgo3YqJqxzksRZRo4iGQbpUYDqHVxjjuj
 hW1/SzrWCE/5At2j03F2uwt/5sD4wLzsBJ6LEr5yoywyP59cRTB49CmsVime3mf+4JsPA5o8sBX
 BNNevOnBEM7Lh9zhE4CRN+JpK8w2iqVV2QtCySyr3TodyOkYlFnx62aWNcxMBC5pDru0pqpntQG
 4ZbV65XvIvt+N0M56Dw==

On 16/07/2026 16:16, Nilay Shroff wrote:
>> +	kill(getppid(), SIGUSR2);
>> +	count = 0;
>> +	for (;;) {
>> +		fd1 = open(argv[1], O_RDONLY);
>> +		usleep(500000);
>> +		if (fd1 < 0)
>> +			break;
> 
> Does it make sense to check for errno set to ENODEV or ENOENT
> before breaking out here?

ehh, if the errno is not ENODEV or ENOENT, then how to handle? Would it 
to fail the test due to unexpected errno?
