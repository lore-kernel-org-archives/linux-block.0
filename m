Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3E30E833
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474067; cv=fail; b=ef9616ZTTQ4kr2jnVNEmCpDMo1gEIlJkIZ09YWbXFUj+ine5sicu6ltTWh40o6J+ZyLJvuk5yEvjU8TJdjRcmJGh9AYwf8OQkHdrVudWTw95fKoZk9yAW9PqsUFci5CFDp51sG/YpY24CtXv6PdMnj1HF2pJa2Onw+vrQPLkOrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474067; c=relaxed/simple;
	bh=Je3f93CQ4uAU0EQqFhWHloq3ital4v8sh9D09LDhd40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbAZLOOJ47fH/3D0pkX8kMBfNiIhwFsPudb6GY0oV1++/3y8RpAZ1PaeVmtWSZ3cwxqExyeslnFJhLtkkQ1gdzBR6cNc/ko6O+Oo5poGSOU78knwdUA8+4oCw2H9iGSaNmUD3wRbe3Vxkj3zFnfdsZDP/Nc7NZ4wAl3KJH59myk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DOofKgq4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=axU4n6uZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DOofKgq4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="axU4n6uZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562GCD5v009521;
	Wed, 2 Jul 2025 16:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9n9Srt6wntBbWXMipS3ZFRmlFayseGWAIn5ly0NJvnM=; b=
	DOofKgq4tOq1gqi9Ix2TFol61h48xOAT0hRcC5RfYeAqrdUY/TEu5d4xBC5aJRUq
	fjHrpc2V3jcFOk2c1fjou4gnTP/WjGlgJWMNOhs2XL4Ah2Kf1Dqc/VE3IKq3WV+a
	wbMYoLkdxJZnU/dQlKjkr+FMAQLCyiTw0LPDZTULTFpg0SCaQz6CPzSN0lLWMi8b
	fVV7yywvBbxrbYybZFQOSL3LxPQVrGoV27Dq5626apUsqv9KamZbdgiSu9IBoTsA
	npsSnZDSe3vJgha4VtjWaF2tUcbASHvdaJ393bp+ts9HYuVSyUc9Rdr0QbXPYgOS
	8JNjuvNAY40yd6JXvNFBQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tffadb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 16:34:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562FQjD3030365;
	Wed, 2 Jul 2025 16:34:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ubganq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 16:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOSpWM69J1FV5jyPHB4+ug6ktxjoFiWO5f2P6tacCwOYj2je6wwbbyLlwi2exfK6XWtpXnY7L7nbWzmUVJLWTAmxzUwaTvjwxDX1rM5M1osp+I0J7Em9JgT4NgT2d8AN9XTo79yXCzW+nvetlHY4N6hmb4X7XRYmysNuyXEeYO2dJeVaWxiwGhBVT7SRsVwYtaxp/vIBYy3H1Qr0LjCkPvO+rO5DzylkAeI8ia9tf85hZdD8o1lqrxLHkhzqQiN4Uy0WYdfbLUBfV2MOjErG/+FkQ0zv9lbh+q8DMJpEZ/t6YtFQTTldDnkXbPZIBKCEO3GnLXs8+3XWl0maDjJX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n9Srt6wntBbWXMipS3ZFRmlFayseGWAIn5ly0NJvnM=;
 b=Fv6KicSyLgMp2x+FHQLV+N7kjQYzPp/RNKmXrzK33FAIP0noBUr924CeB3l111i5hBbwW+ZfVgmgM4U574LmYHrUAknLGWcU+xBUnD3HfuhTTmw0zsGYY7dV2zJ4kdaWjMvJVfkI6G6ta7q/dc5Wytttzn44VHPW5lOXNCkPq1vfWvuK2nLolOFuyjHT/IXSjNeEBLGj53wQvYNafUGRE+Vb+JtAKbQllnMGOaZ8zDg3ZE5QoS5DQRI24Sl3ziPMAUlrcYksMgOIY5KGHQQkt/PCGwXSnO0Uwn9ZITA7TvPWQ78Iqh1DRK7Qs8Sa6JCfwTx7CNmB7LZ+fkLak5G02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n9Srt6wntBbWXMipS3ZFRmlFayseGWAIn5ly0NJvnM=;
 b=axU4n6uZsTvgQpKIO/1KQMtU8gc7rNbtxRsILeA9JcWnhR2zc5tQvr5QfIW7LEbuTCCwK3/D1wYJCRpWmmhoau11YH4Ifun6rwtV5H3OdndBGgv5fqV+B9e+6p2xb6Z2EF3szuwlkA+u+DpHOWii8cSQ6rYDbtwVPSSejHfWfqE=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 16:33:33 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8857.036; Wed, 2 Jul 2025
 16:33:33 +0000
Message-ID: <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com>
Date: Wed, 2 Jul 2025 09:33:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added
 (0/7).
To: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8a70cf-2e36-401b-9e34-08ddb9862fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9jc1pucW9xN3lrZmJQN0haU0ppSVh6V1Vqd3I1RmpyZTNwODZYeXlwUW9p?=
 =?utf-8?B?VjYveitYZVU1MXpwZUQrTXpJL2lYUnUweGFCcFhrQXI4YlF0OFMwL0VCck5H?=
 =?utf-8?B?eU5lQUsvd0R6Z3hhbGtKVDZmWEgzT0dqRERza0dWSmppTDYveHZlQ043aGlJ?=
 =?utf-8?B?b0RPeHBMQTAwaWxERW9tQWtKY2JNbThtTUhIeHdtMzJQRXNUZTZlNGZoWmJO?=
 =?utf-8?B?ZHpIVWhPZUJ2YXl3YUpRc1NSTUR5dzI4dEV2VmdNeVNmNzhpdHZKemRiTWgy?=
 =?utf-8?B?Zi9nYURmcWVQL1lDRjFzeld6V0hlWFoyZkl2MHdnTjZOR1prM09RRWw5aUtC?=
 =?utf-8?B?QStJSWlJcXdXQ043REZyWEpYYUdKVUV3YzZtSTg5WHU1ZUJGc2NoQUtuNHV5?=
 =?utf-8?B?UjY0U1pRTWEyc3hQK0V4S0FuWHJKMGVRZHdwMElKa2Q4b3F6S3R1cmNGb0lN?=
 =?utf-8?B?OXY1MVA2U3RQN3FYdGNyYkdxd0dwOVhYSno0YW5wYnlFSEhLSmpmOEo2NGlR?=
 =?utf-8?B?THcySS80Y2p3UjJVZHdPa21vVVhOZlpIVXplRVNWSzBKQ3FGeGhUTklESU92?=
 =?utf-8?B?Nm4yTExsNmdJODVUY0JpR05QL0ZjQll4QVY1NjhBWXlDU1A4RFJCQTRPcGxB?=
 =?utf-8?B?UlhaK3JLMVRaNzFDUzBIOTlia0JXNC9CRzZhdi9PUWtucktZamI1Z2sxUm5C?=
 =?utf-8?B?SW91bXRJc0k1WGZySEdHay9HTXk0QzBoSFlLdDB0bEdCRGZmYnlTb3BwbGFt?=
 =?utf-8?B?cWZoMXhLYUc5MkFXT2JuN3JOb3JxVy91bGI3UW05eXUvUXVQaHBFTFoxMENF?=
 =?utf-8?B?c1ZjekM0bHExd2p6WTdmZ2RBa2xCOVg4OHYvM0hXdmxteEh0Z1lTVWZGQ1hT?=
 =?utf-8?B?aHdwUXd4b1VidkFZc3g0VVZTZWtDZm80L3B3dEpUZ3M5TUJVSnB1aWVoZTI5?=
 =?utf-8?B?Tit0M1d1NkRmU1ZNMWk3RDlOS0hJL3N4ZXdEcEN3eENKL0RSK2lKeFBaS2pN?=
 =?utf-8?B?VDV3aEJhZzRibVp0a2xyRXp2cWVmVTAycWxOc3RpRW5BcWpxOS8yOG9XSUpQ?=
 =?utf-8?B?SVZ5WFhYdmRqVVNXcDBTMzR1UmcyTmI0cWNzUE9SMEdLQzdjTVVXL1FaSUtG?=
 =?utf-8?B?UThxMjRBK2ROajNnQ1ZwaEo1NmEwWDNDdkY1SHY1b3RuTHlRK1RBYk5GMHN5?=
 =?utf-8?B?VDlTTGdaSUUwb2tVdlQ5MklIZ0h0SVFObDBzUHV3TDFKVXhmb1IyZHBYSzIr?=
 =?utf-8?B?M0RTNEozdS9oZlRCckNsMVl1QlYwY2RMQjhrdVNJRGlvcjVOV1RtZitBeGhh?=
 =?utf-8?B?RDh6ejBIbm1weEFCY1UrZEdqYUVkaWdkUkxibmd5bVVDRmZ1NXY2TEhENlJr?=
 =?utf-8?B?UWE1bEoxd2YvTWVyOXppVTYyN3VWOThNQ3lndm9vOGFxVDFOYUtkNFRLcVlX?=
 =?utf-8?B?MHBrRXAzNVlMZW10c3Q3SUNXRzRZWkZWanhyd1dVNTV0ZFg1M1gyNzZHWUxl?=
 =?utf-8?B?Q1lwbGNKVENJZzhZY2Q3QW9rcnk2cnhpcEZRZElHMU1weGZsTi90KzBNb2Jp?=
 =?utf-8?B?d2c3YUJjWUxGVmRWNlpUajZqc2RXZFQ1ZmhQNEZWZ29adWMzejlHVjEvcWZM?=
 =?utf-8?B?dG5rcHQ3RFdzMnI3cWIreVJZK2NidzBzUlZJNll0RnBqRmVqTzY5YitWekQw?=
 =?utf-8?B?NG41NkRUdjJwc0t0VDdjZmkwTlorZ1VydTVKS1RNaEdWeGNIVm9ZVUJNaVlx?=
 =?utf-8?B?VTdmNzB5M0FCWHFZRk5EUWlOeGE4Mlk5elhJZzNwTEt2T0FGMERPNG5hSEFJ?=
 =?utf-8?B?ZW9HbThpbTd6dmxUQ3dPUEhHOUxlSjgwU1ppZWUrNndKVExVdFp2SVcyOGtW?=
 =?utf-8?B?VU15dmNkSEpNUGQxMlVQZjhJc21BR2Iwa2lndmFtWnNxZVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVVvNlJ5SnpXRGtsZ3FqUjNWU1RIWU00bm5abTlWN3JVNUpPTHBCU3VTdWhO?=
 =?utf-8?B?a2xkbENVWityUFdVWDVra09Qc0N4M2YyNVFIUTh5TjFHYTZaT2F1UkxDdHBW?=
 =?utf-8?B?OU9mK05sbXBoeVQ0UStFRHRISUI2TVgwZVU3eW5qenFnVEFUNThnUTBMQ1Bp?=
 =?utf-8?B?TGNEbk5zMk1EbG5ZaHhSZEhBY290YmF6WWNkQjBTdjNiN2NrUHpKNzFzeFFm?=
 =?utf-8?B?RTVTTXFKMEx4VGxMSnM2bGtYVzk3Z3BVWkc1SnBwMWtOY1VDYkI3aVNKcXlu?=
 =?utf-8?B?WU1TOEQxcEJiNmFtVEViTTg4NlJEcEZhMlVTODNBdjlFL255djhZRk5OUXJW?=
 =?utf-8?B?aCtsYy9jZXBUMmFQanExQ0NvaGU2elJOM2JUZVh0eWszaUx3N2M3bEE1blB5?=
 =?utf-8?B?d0hDNzJua1RuZGViam8xNDJ6ZXJ0ZGxsQng5cGpaQ3ZGc21iYUlRSnZRbDhC?=
 =?utf-8?B?b1JLZHdjcGd6WGpLMUs4d0EzcUI1cnpqZHEvUjZoVXB0NVVyc3hpZCtnaXRp?=
 =?utf-8?B?QXlrRjdMcnhZQm45RG1aZGVtUHVoOXB4eUJucFBOMm9RRG9LZjlJbGpwWkZj?=
 =?utf-8?B?MXdhV2NMUCtFbnhCV3R4aktucm9ieitOYmRmQW1DeGNGVlJZVmxVL1p2aUMv?=
 =?utf-8?B?RDdycDJRbG9WZ2p6L2xtbEhKRkVGS3ZZK1BlZUhTbGFPbU5FM3NmejNmVDdq?=
 =?utf-8?B?R0U5OGRKWXlrWEtxeGtjK29MUXAzOHljWlVLMXFLTGlsNVdkclltRCtvcHMr?=
 =?utf-8?B?UVg4b0w2OVp4QU1RajRsUkgvZkxNVWtRbk9pNi90czNTTkRvRS95Z3VQVkpN?=
 =?utf-8?B?azhYencrUjMxMTdWcXBKdUdZdFpweGNYU3NrSDAya00zdzdmTHlEY3NsMnM4?=
 =?utf-8?B?a0dKZUpUUnRTYy9TUHJ4YWlZRTZCWlRwQksySHIvSm5sbHMwUzcrcCtuYXZR?=
 =?utf-8?B?KzdZMmltOVltUUhlNEV0RDQ2cWZnVTJNbTMyYitGWW1FTWVVU29MUlQwSlZC?=
 =?utf-8?B?VUtLTzZDRXVKRXdNV2RWZ2FCTE9vZ256M0tIaFpPdWhCNzlVZm9xOERnMHRs?=
 =?utf-8?B?RTVNbWpJYmhtQUFEU2YrUi9vaEdMMGp0YStFWHd3UDdxNU9kSmNhMlN6WkQ5?=
 =?utf-8?B?SjdNcGIvTHliQ2hJakNXUm15QW13NXFjWlVPQy9FclRqaUhGT0FSL1ZVRW8x?=
 =?utf-8?B?cXpVY0tXYUp1dHl1bS9GQ2l4SGNPWFFlNE41bTdLRmFUY0hZZmRNRUROUDQr?=
 =?utf-8?B?T1pMZ1JJTFhyZ0xjNWlKUDQ5NnJaTEpFSFJzd0xpR2V2WSsrSkNiYzR6TWpR?=
 =?utf-8?B?VDdSZGo4MTdPQ1I3L3FJc0J4MDVwbzdKaUFVZHlkU1RseUkyVUxXREdlcHlI?=
 =?utf-8?B?NlpTVUhTeEpoWG1nVTFKOVN4VXZ6ZnRJbngzZG10MGdPNEE4dTJUWkJ6VS9H?=
 =?utf-8?B?ZldMTS80ejNicmRyNUcvQjh3L3A4U0ZzVzB1OEp5MmROL29xTlFzQWk2bjJn?=
 =?utf-8?B?YnVzb0Y4Z01wRXdDQTRrS1gvSk5nQXVPdjRUL0FPTDFDeURaRG5ranlrYkpo?=
 =?utf-8?B?U1JOVXQzZEFKUEI5bEF4VHZEZ2ZUV2NaU3ZzTFNEcmpZVk9JSlRZbHQ2aGky?=
 =?utf-8?B?Mkw3SXRvNUxURmM1ekIzUm5zcFRudXNsTDk5MzR4UHI4dGpqbHJFbjhKZStI?=
 =?utf-8?B?aW1tWWpteWJGS2dsWUU3SDhwa0hKRitROWxUbmJHeEl3RENPTTFPSTVGNXl4?=
 =?utf-8?B?NWovVWFaeTBpNHEzTnFHQ0ZERnZQZEJHM3lsK1NBRVc0ZVlGMlRSdVcyditv?=
 =?utf-8?B?bnRwUTRDUk0zQURoR05BRTkwREYrd1V2dlFURGh5Wk5KdHRmdkp2ZGdUTXVi?=
 =?utf-8?B?T1hHWSt6bHpSWFNnd2xYa1Zvei90bFM0cklOdnNrZlpkYytDS3grU2k2WjE3?=
 =?utf-8?B?QzZXMm5DRmZnenhOTVhtK29GeGFRcG0yUTNzTHZDckdHajllcE1KeStHMVNU?=
 =?utf-8?B?R3kvQTF4eFV4bEg0dmdNY21mVmJTZGlaMDZKbStLUGhKMDhLVUJnaHptWStq?=
 =?utf-8?B?emFiRElua0xJZWRUeTFMbURId1FXRng2bTdIcTJXa1JRajZMOHJqL01CODEv?=
 =?utf-8?B?bjQ3RWgrSmZYeUhTdXdIVU5GRFpFZk50clkvUjNXREV4aDBCeDJUbmtaMGRR?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FSUmxauoyznJejEYvuQ13fCS5LMIwyeoDL/xfbBtpVvaPdt0pXfOAZVyPJyWAfq/uyXQ0oHC3imtFF0wqRixz4K4KoAmKpr5SR6vFgpBfqUGyjQeTo15t0bH7yHBQVLhXeZ9aSXvl4nc/nZuRyqQT2oO0YMC4kBXoRGPZaya5puE26xM/jjrfWcei1eAd7M+Qzgm9DYth1SIh/AhaereF9ciAvgKB//OBCtaNQ0B4tJH/g1DHSDkNIJrlzRaell++LE2j1X4FSgpRoK4OEQm719Rm1DJhAkXL9kPyjYhMBWWMNR09RVZsC62CQdbeqRJon011yu6fDgLy1iBO1bjYAJUrAw8y9SiX7MWZU14dTlG59oZrbAfVJDxWQpX2yvxDqRYAKOL6GED/Velk07nPARpfGwkIYx62FgNYqE7iqz5kdD/TtBXxyNosUbRANeCmTCrtcLT2ArGhd+0iRfN6E8f2p1a/rl6cp8gaIOAvhtQmsUm7XlEaYT0Y6GfiqRlTehraGW1ISmPfbRRHN1jWidVDAB3m0AGl1S2O7lidUzNZILYmYdfXvCi5qtopwQSKS2XF883KJbesQikHdaqsX2on21Wz1S+bpz2XHE12Tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8a70cf-2e36-401b-9e34-08ddb9862fc5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:33:33.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FVUnKhs5w71t4HZOlW+UNPWwHlgZqCPyMIh+G8U2xp77e26Bv0a81tW+fxuFw4B0Rwdm/CzeE5SbmyOYRNdhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020136
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=68655f86 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=e64cXYtMg1U04Dd1XDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-GUID: MG0Z4G06nV4LMv8_3y2MElD38up70yp8
X-Proofpoint-ORIG-GUID: MG0Z4G06nV4LMv8_3y2MElD38up70yp8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEzNiBTYWx0ZWRfX1LC3H+WJ5a4Q uqMFg7jcuY5fqGGHmF74ztzinNcxpWctGDx5pE1EFtczRTDgO5V4BF6m92WHZhR13ZNX13GuCMr YnoJmG/VFL8oFdFXouwVYKcymt55XObqeSw2NT9W5JOfnuXr0xzPQsNZOS7b9PaO5MYspTzPJ9C
 sP4rjJ4mZslMHczinqeEgIkgVy1c0+4WjqoGfWa4dYaYSRAOK7mN0szMP3tdvpaf/K6XMre5ywP LbftVztPdEOpnQPfQ67ax8qvWeDtkVd2uyOW2hly5YyNgvS3ltTJJFITaP0/bTH3L9zgkbvMLFa Gaf2hdHJJ9ORA6VbQEcDV2QlLOMzoeLzZgBLpwBVPB7tMHYH5RCLS46G7ca9aH4aUhBGMERjVEt
 RIq/suRd/McC6lVeBb9xulfa46P1a5uyEUCfK6kK9ERfA6vU1jks8BnocnPLDgg9JpW+f3b3


On 7/2/25 4:13 AM, Yi Zhang wrote:
> Hi Christoph
>
> I found this failure on one Samsung NVMe disk[1] with the latest
> linux-block/for-next. Here is the reproducer and dmesg log.
> Please help check it and let me know if you need any info/test. Thanks.
>
> [1]
> SAMSUNG MZQL2960HCJR-00A07 (PM9A3)
> [2]
> + nvme format -l1 -f /dev/nvme4n1
> Success formatting namespace:1
> + nvme reset /dev/nvme4
> Reset: Network dropped connection on reset
>
> dmesg:
> [  751.872864] nvme nvme4: rescanning namespaces.
> [  752.177475] nvme nvme4: resetting controller
> [  752.221030] nvme nvme4: inconsistent AWUPF, controller not added (0/7).
> [  752.227653] nvme nvme4: Disabling device after reset failure: -22
>
Looks like the device isn't reporting AWUPF after the format/reset.

Can you try:

nvme id-ctrl /dev/nvme4 | grep awupf
nvme id-ns  /dev/nvme4n1 | grep nawupf
nvme format -l1 -f /dev/nvme4n1
nvme id-ctrl /dev/nvme4 | grep awupf
nvme id-ns  /dev/nvme4n1 | grep nawupf
nvme reset /dev/nvme4
nvme id-ctrl /dev/nvme4 | grep awupf


Alan

