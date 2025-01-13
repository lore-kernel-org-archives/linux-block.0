Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297621465AE;
	Mon, 13 Jan 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756612; cv=fail; b=rUOpYg8B/4MuyrwtiqQABXlizznaHH9D7MNvOVdm8UM5+wbdLW78GdV/KyYcsM1QPGFKV3ZrjHy6trqIhpZogyua1R+M6zbJGHMon2qAIP2+t6Tqs9s6eZ0bqS2eJATeE3Xei1dKcqIZzTMKSu947FJCyLT+QdFPdhtc9i9teRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756612; c=relaxed/simple;
	bh=htNPgPtWU2o+QBmirsa1Cbd/V7avNAEQhPtQFySVj7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LLGvpF2U2KfrkqY47IgF515qRpmfQHT2RRfkNaiPYNI6MQJK33YYe20/piDixSWAzdujVPmFM86bO7b6O9nHhlQTSgYk2Vov8JVfFK0GqjDxKhObBDSoZlzO3iNWUm6h5JPXrEDgnoUMzHkoN33KpXS3jN8edSPme1ZwXPI/dJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bC6Yr9xt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L8ojTjJP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bC6Yr9xt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L8ojTjJP"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D4tsDG016875;
	Mon, 13 Jan 2025 08:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9sOs6QKexkmqy+5jahZ1PNOF0zuN3uvHkcbTlAs2WdA=; b=
	bC6Yr9xtWcXdhJLxmaKpyW9M7J/Die5KTSVB0tuIwto2xZyktvPmUcCntgnJY4qw
	wzSAuLZJd0uz6ZZQip+ToQ19rGwIweklhjHo3eL4bRO0fxvp2Ajk+eShr0F2SqEY
	GeBNYjYak0z0gMXlhGZn26cd53LOYAOfdEwT0hcis66f0IHXCQol5lNYXV7aEnwS
	5TmU19GVWqOX3v3hNlMpH/QyPchuC0icBKisJeOm3RR8q1NnUCiLWhpgBqh/3lNG
	HUlhNFyuPpx9v8J6stSMKu78EIqNUvjgxeGcZ3/8qm19gIpB2jiOBXQsU2FlkZcx
	vPqgzgkhQ7gfhoHzu//zOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpck68r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 08:23:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50D7liSE020356;
	Mon, 13 Jan 2025 08:23:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3cyqej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 08:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIg9kVPSzDXNvywEa339/hxhxd4EOXVpmpiYuswFDgMwdtTOX8KTmKrxC87BUhQs7lCdCqKjMQJeYQMP6UsRMxzIfMYi+TcYaphirNeHmCmv+R+5wPAvAumy+ATBzIJDAdUVIEUzquVIpowmwRp2t46z8ya14rvJdOTkdWEE5kz2ywtjreZGk7jfR+NhoV/28PhoXFOsNMisYLWnkTFCe5YIAW4cB/xw7Pbxif2OtaAD2YWrQgbAQoKcU/7Cysnt6jWBrsLU1N7JhsmrtHXpV7TwzpDGa0OLIo/c9q3u0KcSCTlkD+rh3hxPpAPun/4LNfiK1nmBotSMVmGT6Ysyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sOs6QKexkmqy+5jahZ1PNOF0zuN3uvHkcbTlAs2WdA=;
 b=XIGXrLv+SsW6nxM5VMlIY6yWuqYprKoe+ZfHeMwQxGWwpWJ9jz58eKZvyq1T+MJzwvWPtSU1jSFYYVWrMNdQ50syvrrrWbOaxX9N3b+h7e+Dv+7kFoRLwVqq8wCmleTA+ZzLCIWZ6c+Sw3qSONNWhCOzKWu4xCVZdq6kUGSeAC16peT/aGJvQSs0ECJvwAEgup8Us9tmmny9v7TmlswhxMa5BRQNwnTfCcCdDu367/iBnnTzkkxLbD9itZGGcbSApRL2I8bFIPE0N34KZLai2glrm/XfZRRge6MlY0MQbv4JNKnqStuNWYabq3cSK17G8hlnODbbYtpX5xz7PcLaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sOs6QKexkmqy+5jahZ1PNOF0zuN3uvHkcbTlAs2WdA=;
 b=L8ojTjJPOeWCwIQ+XWNsLz3yledQsvwGrz2AO+9gdprqjjw8URSm2rejZwQYGzFa7/XwOEiSBFAf+tjFvgZZP2nvVXRiYAlyyoodWz8nxQZx+4jI8tBwNqQIwVIb+ETDUzvCxCd/UAW0yyTdLPicdd+J+iRdU+S8G5dy2RxKGBI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6118.namprd10.prod.outlook.com (2603:10b6:930:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 08:23:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 08:23:22 +0000
Message-ID: <2fa89c60-a507-43a0-98ed-4d182bcea3ee@oracle.com>
Date: Mon, 13 Jan 2025 08:23:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: mark GFP_NOIO around sysfs ->store()
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        stable@vger.kernel.org
References: <20250113015833.698458-1-ming.lei@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250113015833.698458-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 8963f642-2e0f-46b8-96d3-08dd33ab8b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uno0enFTaE1RWkd5endiMUdKTk9QR3BLK05PUzZyTnJxMG4zMUZwZGpXWkpB?=
 =?utf-8?B?U01DMC8wQjJMeVdDTG1wUmdsN3FFR2dROERkTnBpdW50cDF5a1Vic1k5T2ZQ?=
 =?utf-8?B?c1hUWHVoT3Y3NUMzSjFJV1pLVURQemNmeFc0ZzhKUmo3akxrMlMwRllmQ05Q?=
 =?utf-8?B?MU42QU9lTERZZUxNamlYcVl5TFExZXo5bk9RaGJycFA4bTRZdGhsQkl0bFRJ?=
 =?utf-8?B?TkdLU3BVWlZCSzNGbFBBZTdBK2dnNFE0MUR2WmIvT2QvKzkzSkozbWxmSS9T?=
 =?utf-8?B?TzZrbUIvdFZKY3hvSkdqamZhYitKdjdTNnJrcC9mVzhRczIzaUJKVCs4eVQ1?=
 =?utf-8?B?N0M4NzZDUGw1YVdhZjZRWGRjRm05OVd4Rm1rRU91QjVSVlRkclJTdjJyWFQr?=
 =?utf-8?B?elVzeWFZb0ZrZ0xuVDVwL2dHeTB5SW1oRXcxQ3d2ZTRPNFI0MnNnVTRaQ3Ur?=
 =?utf-8?B?SnIzLzhYaGFLK3NGL0V5cU5tdGdFRVBUUEtKVXFzZnpmdEo2RmdWY0hrZldj?=
 =?utf-8?B?ZWVlZmR4bWVGL0NTWjhkeFo2M3BTYWhHTkFqOHExUnB4M2NNQVRmcDgvS0JP?=
 =?utf-8?B?MGZHUm5tZU42OE5lcmpLMk5Zd293c0liMlYyNFdCK25XZHlNZHQyZ1VBRlNr?=
 =?utf-8?B?cHBjRDR2RmZKR2lNc2NlY1B2QmV6K3kxZVgwTEFvWjc5bVlyanY2dTMvR010?=
 =?utf-8?B?bFVPVWxZdEpIbGowYy84c1l2RkJpYU5PYmRwVWhGTHRuZDFYWDlsVVhOVWli?=
 =?utf-8?B?TFpYRTQrMnJGZjhqRW1weldvcXhwenN4L0VrSk9LYVBaZCtOcUVKbkNIdnE3?=
 =?utf-8?B?ZDJoSGY5eTdUc2xDcnNRZzBvbVRnbFlZNG9IVXlpb2hjZWhCL00yWnRxdDNo?=
 =?utf-8?B?VlFvQkt1aGFpYU91TEtTSk9PbExNTGc5QnY0VndZM05VNjRxQThMVzBYd2x3?=
 =?utf-8?B?UXlCMFQ5dTlRMk5wSGdoTlRGZGgveDRBdUxWb2luV3VGQmVCSUEzQVV2MjV2?=
 =?utf-8?B?czJjV1RZL2xnYmVySDFQMDdNTmhPdzV1ekIvbUNnQW9hTi9VajA2VFZndDdB?=
 =?utf-8?B?L295c0RSMkhRVm1CdnB6T3I2NHFkbG9yWXRqbTI2SmJkaXZZbGhGQXlmdkZq?=
 =?utf-8?B?SmoydFhOVk1HSkpRZ0dZR1lNWjhYbmZjb2VRaEIvOGdZckYwVWFhUllEb3RC?=
 =?utf-8?B?dm9qUk5wd3ZaVUVwc3ZWZ1gza084ZzZHbmJlQlo2YkNNcWsyMUpuKzJrRkUw?=
 =?utf-8?B?QUpiK0NKWGFTUEpybDJLR1dZRHpLeExqSUg0aUw2VnRvYlAwdVY0bEtnNVpo?=
 =?utf-8?B?VEJzeDFrTDVxajV3aGJXY2cyeXYzNFhDNEg5eVpzUVNwd3p5bW9EWkpTWDRq?=
 =?utf-8?B?c1pEYW5oMlhjM0piMzRkMXNxK1pwbFluU2QrZ2dkOVZjSDVZeXJNYUlYZllQ?=
 =?utf-8?B?MjMwZDdDY0NtTUhCVWZiN3ZHUThWeWJOL0FYU05walUram1nNFpnOXJqU1pT?=
 =?utf-8?B?TDBVUGtDWXVpYThMbER1d3V5cGFVWkxoZnZibUJFNWQ0Wjd2bjdYd3dZL21y?=
 =?utf-8?B?VXl5KzB0RWR4SWcwQkd3ck9aNS9yL1YyTE91Zk85cEt1dHM0dTJPRm9hOUM0?=
 =?utf-8?B?Y0lldFQrTzAxUXIrdVBDMXAvRHdCSFQyekF1M0FMZDJPZFJaMjZyNzdLWnpp?=
 =?utf-8?B?MERNZFlNbzlLUFR4Zzg0RXdYbXhKUDBnNmZiSmhaM2VBQkc1amZqMXBzOHBV?=
 =?utf-8?B?cEpzN0hvbVk4NnN5WFJkZjBYTUZ0ZHJLRDhnaTBQYlpVS0RLUlViVENuS3JN?=
 =?utf-8?B?anlER1NlNVU1dTBHYnhZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXl3UzBJUmkyVDNxUU1WY2JGRFoxSXY0aGpiMmU5QWdQeTY3b3dJeDhIQytS?=
 =?utf-8?B?c0dYZkdYbkJFbW1UQXFiQ3ZTQU5WU1lJOTdyVURQVzdJZVVRT3BCUEM2MzNF?=
 =?utf-8?B?b09aZDRPUDFNbTl2Qk9mdEZjWjNTRlNXTS82T0tCZFhRRlNNcU5oaXVXcHlW?=
 =?utf-8?B?aXdydmFqU0xpeVJaazk4YXNhOGljWkROYUoreTNidEtEWkF0dVhDSHVkNmpl?=
 =?utf-8?B?NVRvcFl3d1ZwcVAzeWZrdVFCTEVGcjhITm5selpPT3l2TjlLZnZxNzQveTJV?=
 =?utf-8?B?dzJwYW9yNDhFQlZkRmpNZFEyaWtXQkszUmhKcE0rVmsyVXN5ZGVvMys4akhX?=
 =?utf-8?B?UlVRTkVqb1RTQjZWaXU3dEdncXp4V3ZWamZBWU5kc1lGMDgrQ3pPVUROSmcw?=
 =?utf-8?B?TmdqQmoyYTFuQ28vYUtNakwzTmNoM2JvOWo4VjlHbFZHRWdCU1RLRW9vZTdU?=
 =?utf-8?B?K0tkeno2VGoreGx6Ris4Tkl5dVBzd3BGbSs1R1dzZFBKRUlvUzV2RW1LZSts?=
 =?utf-8?B?SjU4d3BSeVhick1hSWhGd3FYSmVKdys1T0N3ZmlmVER5NWhZMDdLNWFzWlgw?=
 =?utf-8?B?dlR5OVVXcU5YT0xUSXBydExORElZTmtHZkE3VkZaYWZuNXc1bTJCODdUdHFu?=
 =?utf-8?B?MTF6L3hMTnhTd1N3TFF1S2lnVGZJc0VQYnl3VCtJNkhYU2tLbHNZckcrdDFi?=
 =?utf-8?B?ZUhkeFRJemozMmtsNmFoSTA4UmdId1JZSzlWNlcxL2I1VGl0K010ZVRINGpy?=
 =?utf-8?B?dHhOODNpRW1KZWptbEdvbVJjTHZKZktlVlhTSzg1NkVwMzJrMW5Jcmx1UUt4?=
 =?utf-8?B?d3l3WFhobFg1THZGRStvZi9wa3pnMFRNQ2ZqcXJzWkhHaU5selhTVURkeUFU?=
 =?utf-8?B?dTZBMWJIdnQ1Y3I1V2V0RDVYTkx5bWtHWGZJcFFHdHMvNGxnN0czNVBUL3BO?=
 =?utf-8?B?YXdMN0kxZVZpWjd3LzZJRUpwZGZxOFdnZDBIRzFmVUtuRkZDdFBBamR3bWhP?=
 =?utf-8?B?dHp5SGtES3VBQlNkL2ovN0F0Q3RtQVRFNzFWM05OZS9iYXJybHdwNGtVL3JE?=
 =?utf-8?B?U05iUU1wcGE1eVZGOTQ0dWtwdFpJVlYxa0ZUbkhrbktRUGN1RnpmODlHQmNn?=
 =?utf-8?B?TlZGb1MyNkdSWHdpUnlyNlp6R1Q2ZHFPNnRIVCtGZU1rNDNJOGdtaFZyTzRq?=
 =?utf-8?B?WU9PbzdiNVduNnh4UFZadXZYZFFBTnljUUlHMlpublhEbWJ4WXh5RzJTK2Iy?=
 =?utf-8?B?UkVLbURTYUZUS0xnbUVXWlhBbTMwdkwzQ09PbnNvRGdXY3BQMFNIYzRnNDlv?=
 =?utf-8?B?L1llSUlSRFdKSmlZQ2N2NzVLVDluM3hENjJlc21IcEVKZmFvd2tER1gwOFV5?=
 =?utf-8?B?NkUrUWdGY0FTeXJvczZOUVlJdjl2TWRGZ1FUeTFGK2ZqeEpJTlBMdmZhUEtE?=
 =?utf-8?B?TEtJRDU1SlBrdFFKMzRrQ1BzWDkxc2NlV3Mwcis3T3N6YnV2Y1ZFSi9ENy85?=
 =?utf-8?B?MVpKZkp0amlpemdJTDRWR2k0MGE3YVpJZFNHUlo2UmxUQmRweGpVY1ZDQy9Y?=
 =?utf-8?B?MU04V1lvcU1KTm5OT01MaURBenoxSHkxYXV4aXJpMWUvVDM0ZjVZcUYxUlpr?=
 =?utf-8?B?bEwwSG1YZHdZb0hZSzhibGpvcWJHRzNTWENxaVBBZXlPNHdiWnV4MDJYVVZT?=
 =?utf-8?B?Zll6RzltQzVySk4rZm9yeWtiYkI3dkxZajhMNDc2WjNueUY2Z3FzRGx0ZFZW?=
 =?utf-8?B?eU9sdVJiRDNZQVlvS2pFQVMyVDUrN1lySFovaGNTZHdUblFoTEFPb1BEZVh5?=
 =?utf-8?B?dEdxYkFFY1hzUGpST1ZWYlY5SjBETzNMWU5XMmFVTUczcmp2cHovaDZpbDVo?=
 =?utf-8?B?Nk5UdkViODl2SkdaZURyVnd5cWZHNklwaStidE5GOWdYN2dKa1BjNFdpZ2tX?=
 =?utf-8?B?TEV5WGVucGgxRjJBc1l0akpHOUZXNStHb1Y2QlBpckNsNFlFeEsybUlRTldV?=
 =?utf-8?B?Z3dCVWk4YjZvem9ZRUM0MHIrTlNZU3M4UEoyVTEvQ1ZLTGswVU16WHVqWTZ2?=
 =?utf-8?B?RGNpeE9CNURNaWp5TzBnSEFYbXU2YVlJS0ZOWjd2VVVrTnVhUC9QTjV2UG1w?=
 =?utf-8?Q?Og3LCtkJ+bscLHf1csgcLRt2f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/DE2PLk18SZQFwZhVyeOFZ1sAjCKbVEIus3/63AazNuYeX7lgPLs5RN2PyQiYmJuOK61Mzk8yIIgLxxtvPcTimeX8NZrz7SeVsl3KQ0GV9NhFMY5uegzLcLatILMh6LA6a5vQOg1m62Dhf3JneGvJGY8rWGzbaQqbigGDvEhHT5s0yBjt2XRU/ZKIqbOSKE9X2SBJov0Du/EYSVMi+24L0E/efdlTMTFGO5oRdqj4CCinRUQTN0CwSl/tKV/IXGJBYjRX7Fyv4mdGtT8un1uUeUuUnziw4naV7I+IHNJD/Lr7Y6hm7lSTKISYgLiREUKDEj4sBiS2y0GmM5wwoDNKl7nqsFV9S4nUa4hIrMuoSB8DCMGp3wTqAT18RnHJZOX6Imofgrb8foyP3/hFlWV9/X0lOppUg8mGEYeozLQGjgqxXvxhlTUldT1wVh0pvKGiqRzdn07W2AHB2zH2YjCYgXDJUaZspwks81Ycgx0UssAE+3XZKGk3KwOt0kmncbs9esEmkTp/pbSnU51CtYxxLzhbnqabgTnLZmpxPoZpUk0/y8e2SWstFibJd80yYZ8USS4nSylNyT1sLhKqkXz0g08mfWh94IENyRen5xcso4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8963f642-2e0f-46b8-96d3-08dd33ab8b4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 08:23:22.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e37klu5V89vaF0hL5nOPx+f44OcrVHW1Xvw3X5v6szp814XduVFLv2PrcbQjY30Bqj8MN+nQayPG6WRIL4muPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_03,2025-01-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130071
X-Proofpoint-GUID: rfVWLIDE9GLZoEWcHnzx8hyaCPndbYcZ
X-Proofpoint-ORIG-GUID: rfVWLIDE9GLZoEWcHnzx8hyaCPndbYcZ

On 13/01/2025 01:58, Ming Lei wrote:
> sysfs ->store is called with queue freezed, meantime we have several
> ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> memory with GFP_KERNEL which may run into direct reclaim code path,
> then potential deadlock can be caused.
> 
> Fix the issue by marking NOIO around sysfs ->store()
> 
> Reported-by: Thomas Hellström<thomas.hellstrom@linux.intel.com>
> Cc:stable@vger.kernel.org
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

I guess that you should be including a link to 
https://lore.kernel.org/linux-block/Z4RkemI9f6N5zoEF@fedora/T/#mc774c65eeca5c024d29695f9ac6152b87763f305

Regardless, FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>
