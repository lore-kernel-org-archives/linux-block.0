Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C8DF71
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057904; cv=fail; b=tfrAyB5gG8pQZNaqYHYlrzl29LbfhgRxH3SCja+qlOLfqfwfYZACfpIKQrYOxGVTxZc159tTJxP3glGgQrEBwQhH29g6/oAEw65OM3z3k/zRd7njTJELWjvjOX1EsiGHGpV31PQTz/oGZJk+v/kVv4KbjCoI+fYxw3ApympKknI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057904; c=relaxed/simple;
	bh=dgF9/K5f+lFz9kxw9KTWQ6mg1lXU32nPdxViBxq7iIg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k5j1H18oLnpoLonodaUmfnyfb2U0pUM8zipJ+8uOP5HwfvxwFCGDP1PFisH0gHde9D4/p7i2Vx9cSNGpzG44Lw+clohZg6AggPlwMOShNm5nR+N3hRTO3NN6ny5o07jD4xTSJKwbx0vU2TowgL2WPhVDSVTHSuJTC+BtV9ULOf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ftv6vi1W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1df1HDY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ftv6vi1W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1df1HDY"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856duML019762;
	Fri, 5 Sep 2025 07:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=UyOqWItSrzIxnTpp
	2xHpDsPnTPeQ9FCRCeOpatJSzD4=; b=ftv6vi1Wr2UL8l6lDvClWW8TbQNh999a
	F4YHdWNxtFJ2D2clLgY/1l3H0Pj5l8RPw0jUqTVVMygWYG60jr78YT/f8jJ3VK5E
	CvYml5OCaiMwiewkmi//Ls8SiWDLdcaJb/5j7OKMf7gYSXBcqleGfoNk3pqn8JzS
	1vWUTuiBBKyJaXSA6oqPSa9fKpOxBcVZXqixOVJiCxXFJ7sSs2M0UoG5dxwRR3je
	nWnJ1gtZAJ6gvqLdVCOAnff/oinsZIpKFP6mH1cxsX7F3VcLkA/29j8vg6N9yHrA
	+dARwJk5LM1cEk42D6pVRgilu0T6bNI4IZRvoAvDI3WPTC0ekNAQYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ytsm02qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 07:38:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58568hjl040152;
	Fri, 5 Sep 2025 07:38:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrjnbct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 07:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3nTcW5EVFFMuBnu5BGzX9zpAEJnV6ytzU39TK3LZ41uC7xvJp4CXEuX0tW9T8WTCxpElg62j0qLAgnih2W1ixASdleTWFtxjWDvB1fO6KP7SA3WB6ecgOyCVALSn5UA7gDBbMWESwZ04KEbnnkkpmxLIeiuh1cc6FQYkyo0NLm3IimocSoQezJWNkNl82TExMfLxPRSWNm1+GXqVE/LifwkZzeh78t1Wi7gYD1gVKtGgl0ZlXRZJquOKgBfUxC6Gqtz4cboUg3p04/SpwUBHhMqLmIjrcwuYT6z8bdI6FUQMLcFK5jRMoQou+TerslDGORtYfLjpNz45XROCFPOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyOqWItSrzIxnTpp2xHpDsPnTPeQ9FCRCeOpatJSzD4=;
 b=ZhUEcwbM3ECbtI5uh+toqhsGKDpXg7RvyIBdFbUl1vX6Imk4iQekIypG2qXuqNBiZyAt1610SQ0rjMigI21mkXI3dEcdevTur8m6QMD6IUR0QEQQU5KILXnr7BAXYPzsjGXlCzAkhKL8AASOgztzytcuk9nKXmEw2BB5Gk2RNtiOQTrDzeTXk9aUZ7g3UHU7khcJ2ddwVAK38FUix4sbT126F9TwM8atM3E0hQXraG2EJLp+UF3klTvBbHn28ZLxakQnDwx9N6mrJBoc8dUDT8kla6/qpx/S4dQU7ytX9DlLvC7BAUuLarfp4rQe5cHZIF4ZR0WeTTGghU3QLbzPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyOqWItSrzIxnTpp2xHpDsPnTPeQ9FCRCeOpatJSzD4=;
 b=n1df1HDYqwlujQffbCi3kPaD8Yfbrp/Tp+UOVnh0VatI/CNJnft4gklzTxLKTmUJLsAP0sQGyfJibefqPZcTJzdEG5qyn7fR5uUHGuUhJOViRvwSYF1VZRh5EYNnM2vbKOox+qOxyHIHVbNeKzCJ4LeyxELa7f1DQhVOqdCx1qA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4498.namprd10.prod.outlook.com (2603:10b6:303:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 07:38:17 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 07:38:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests] md/002: add raid 0/1/10 requirement
Date: Fri,  5 Sep 2025 07:38:04 +0000
Message-ID: <20250905073804.3981762-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 483c8e11-0995-4af6-6943-08ddec4f2de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQyplF5SXRbcEBtoB5XxBiSUZftie+stU9ZZn5lQXY0x1PcKmNvI1Vi6uV+F?=
 =?us-ascii?Q?bKdmxAVRAMNsY8+06Qwa973aPn4WJO1g7LKTrHloZp1mP8Shc6EK9Qh8WRyV?=
 =?us-ascii?Q?iobhkU+4AQxSvzrfwiGm3Sg79O+eGnHEuw2aUz0BVhbMV8GmiJeNo+5Cwumo?=
 =?us-ascii?Q?QPO98u/ibIhWpIIWpttY6dl3NfDK8b9JduFLSqbJLNensU0nXH9/m0k7z7OO?=
 =?us-ascii?Q?m/nV7EyztnCQsWgvAbbIfMxbrvsvfq7kR87dbG7CTLIAGgGIf4NuRhhdo2gP?=
 =?us-ascii?Q?uL92mirDN6uNzEIgpW8zPYkDglu54UXti0R2F60VYMHwyZ5i+HjLvS3q8rzI?=
 =?us-ascii?Q?9iJwjBMvz+ArQ6Jzm+TiDDsg381qlN6CpNUGYK6tqaEd8kSpSf+cTYNBsKu/?=
 =?us-ascii?Q?cuxARC7BmIL8cDpevAj6ZqE8tgP1SO8ip1mQGehJqpBSW+C7C4Ry0/rXfWVS?=
 =?us-ascii?Q?sNrgWCeUpicA73yliEECKGRjfh51rR7msBQa9XFXOCO57AtYQeNWxbWAkAKz?=
 =?us-ascii?Q?wnxmKZFo6mZbVBcLFCHC8T79Vuykaq6I4h8eGsoFZ0jimexGcwGIjA8ZiBUv?=
 =?us-ascii?Q?fSkfmSi9O6R3j07ZvzacTMWqOSU024amUkEEUtqjkMBFUVlnRtgQqZPNBPRi?=
 =?us-ascii?Q?nHZf4xtrTHC31g0wL0xoVpALv67K86+9bcNWcY5kszM0tCOfqZirqdj/HQm8?=
 =?us-ascii?Q?K0nP4ZOLJbUuO61twM73c5//I3kkzUONCAwjpfDPn90TAevwNA5Xg6bmkLHS?=
 =?us-ascii?Q?3uABaEkaLLiWRWyjhIzLaHksF4xy0ELZRAeYdM0rcSpQWTIaII1487fDePoB?=
 =?us-ascii?Q?DlhWqR3Hnz59QCp+BB8uD8hYPOUIbrvzJgGX2tGwFLUrw52mtTq3jsr8Xdzw?=
 =?us-ascii?Q?oXtoXTbRmgRQNHMhMWuLUojId+As5L3U+KcsLvAfMPEQtoBDUTXFWPL2VGvZ?=
 =?us-ascii?Q?j+ZKKgaPM7oivxFA2oA8Pn3YuURqMn44aW23NZVYc3T2pM9KJRQusK8Oz7/P?=
 =?us-ascii?Q?+SDTIZca0EBzWcFwjmrJ8T0sZexXaM3AMsLRRKzi3hy3xMxUXigQ4xAYpj+0?=
 =?us-ascii?Q?w1AqLU3GsQBZmLenOK6Cr1zdCUtykOgRfzZ8Ei1dq8cjseZjPa89p2ul5W3d?=
 =?us-ascii?Q?NLR/61Sa7lnZ7Dp0Lkp1aYotcUWbxuYhKD21TZzc2f0GtjLjTTXZtWn4lmrA?=
 =?us-ascii?Q?E/lDoNLGaFxqE6NUKKKsqBj+jcbP8kzFZhkGxw9Do0HSo/NVdRcKz9VPRwh3?=
 =?us-ascii?Q?2IRxzhHQKliTcuiaJipA/Qfn18T6n2eMBh89gY/6Niw7ajBVslsB0HbDIn1J?=
 =?us-ascii?Q?iC9d+ZsIIHwWHAj+h3hD33Z23hC5emqmmXLPAzpyW5DGwtS8qGVvKpnpW/bi?=
 =?us-ascii?Q?EbTc2kSQmPLOT0TbJFfup3pgVrI2MO44FfJZU4Z/khW4U+EpHIPUxdkWL0q8?=
 =?us-ascii?Q?tBeUuILNDLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbe8tfum8Mn2COX0j84asuTnPyhzW3h7pHbFGsiJXFxfWQx5lf1XY2h1kFnr?=
 =?us-ascii?Q?RND2aXkoK2kPAn9yqlsxAX+EwCNYe24SspLkGf2EuhqHxlFwbH2Xd+856Z5D?=
 =?us-ascii?Q?IbiBYMcckNIPhzwBqegOwlbfItZlz/9LvaBsSInHW16nCmviOxMbOhB8Vbge?=
 =?us-ascii?Q?dXkMYWzyfML04hTz8DT6wWdp/ngSzUS6EZ5H4NsGxOcLJFvJ7KVdd+OYTE0P?=
 =?us-ascii?Q?fC4QbyiSMnoO9bMGS7VBQN4S3msTWcCAgOT6W2FbNb+65xB/qBy8eJfY3e46?=
 =?us-ascii?Q?bRolZVqKFQ1L6U/ru6eHvA7rj/bkxRKkegHiHIP+850qb46GgOEwPapC9Jis?=
 =?us-ascii?Q?ZXSK8AsGlWbpUek6lyIjdwy0ml24n1WrMB6erxYYbIbBVKhgcWdSRWQU/Z7k?=
 =?us-ascii?Q?LptM0RB1qsvgzID/z4XXPq9DOA9dhpidNz3p6zbrjjOlP8aMdy/V3yGKWsOa?=
 =?us-ascii?Q?AWletaxbRW1R2GMK/oGf5p7cKqtqPiAG7O6NJygXbI0CAl0yFuDjG99JCyqC?=
 =?us-ascii?Q?10q5y/Q2Kyc0ThGR1MiLfvt9gpLU+RL7K0X85hzvRJmuAUeQR4baH4UrL3K4?=
 =?us-ascii?Q?Md4K7Uv5plqC71Jf4R29/dDBXiQyVLDPZO27JjVkWW80relb8XqLLL88naz8?=
 =?us-ascii?Q?eyxJSLDI2TiqHptnh5PfDB09JLjx1Ndro3np3IzlbB7R8xgjIQHmbZj9UZjA?=
 =?us-ascii?Q?koZsb62fOt9N8j0RD7jNFW2l54ykb/efC3NmDbEST0NF++bt8MeFABmEEYmi?=
 =?us-ascii?Q?CF60KOULhL82blRCHbK2T2smckb563QdqwTrSQh8nP8KmQ4jfd1k0Xy0n9SX?=
 =?us-ascii?Q?eN5RhZOclB0DAaOsDkXtqk2jkihVkhpJ0GmLfx0uyuSQSfTCP2vb11fBOKiT?=
 =?us-ascii?Q?xxS+55eDqImAyyXuF1P2UysKZnc7Nf1huwNZQ3nrGHjVSW9TIenz47sXfQXX?=
 =?us-ascii?Q?PdV6phkP+dFj0hiweEW/bG2Rk53WHJl6pDixqNFDS54uJReL8wlDuHTnZ8Vt?=
 =?us-ascii?Q?nBfsH4jLN9l7Xe4RN35+HJTIvovr60zOcbXyj8zXZYkTTLqkwAoSYzufJS6N?=
 =?us-ascii?Q?W9WXLMWiIxzQdw8tws/n3g0y8mJF7i5TLkR6TIJ5M3NFa3EsJBiNG0ZTbfy+?=
 =?us-ascii?Q?i/lEvurD8fNRHMXv+MDrGiIP+y1n8nRjx2xJVlIAyE5TbzWGKCTS7/+ntnc4?=
 =?us-ascii?Q?abyrma0483m/l1mwETUDOkYWUXp4O8Qi12IwcOOWcTqTXfogrgSdrdNAIhqn?=
 =?us-ascii?Q?6Z2Jv7ai1xpuixLwOOg6KHp50bO/+qTU8Sl9w5hANxEm9ZbILYiP6RafJoJh?=
 =?us-ascii?Q?Nq3sElqKnTiYL/z7me/+hD+EL4jpadb+aJav1fKFm7hYOw5UHsd7Gj9E8nJS?=
 =?us-ascii?Q?4nu4b1TjSzWw/F0+19R+tNy5Za6vJs7QFgai9YyT+4ky0WEjvQsI+6xg6AGQ?=
 =?us-ascii?Q?tjYkdMcw3dFPLcKPmqWXaNeZLxNi72l7HxpRvGs4+HGIILxUMMWHKTGvjqox?=
 =?us-ascii?Q?7+u0GW52w0YW8mWcBke+2fNdDy2H1dcsT+mVP1MI3h1FAxobcOBTfxsR3/qO?=
 =?us-ascii?Q?jeMtKxnl7g+vi3tBJuBv85R9uap7odkcyF2nHpoDr2EcoSVNDqA+zk7jxB07?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X+vSqJb4zH+e3JnBpAZHNFUXVKZIyVtFkVKvdAABAWHj8w4JWHuOewbzF97YOau+Q06Z9kqIakiuGVr3lGFfi/urVS7i9bFFA/Hkh2aXnryxpvD0712gfKsP+j0nLMqcDhKp0idua+HXXAnuZs7mPgYNo82K1ao2MfmZLmN/qu+avbnw4jks0CNXyS0jaBrjVmDvG8xNwoGYyY4LAjii1Eg/Fj0YIs0NEsiTMygFPIwhRgaQeJw+dqkD+ake5m+HeNAgiWOeowZj4cW+b5xZXX99rvSj0is0fvxNNuyMiIWPvezik+283UpTfqIgm9mXFxLkmL7kRxx6vvF4i8LzRBG+33XOaFd6BhYPPIMGiRS4ygZygXTp+zmamPDouG1XqnKFRT221zKvVoJV0K1QFrAby32jrBvt5btBWpM7yobk+Z2lJvHD5gQMXsA6tJ4a/GoJP/igH/SYLROBas6BqeZ4egrDl2aR8Pglm2qNQ1i7Lam46QTiPQzm1B5rpr4ynyMOUuwvzogH/9Q4f8P5cVYED4OryiNORMGoLx006l/rR+iG9xJ9gKmMqdddsRDTLr5//HyxN3dK/361H+7M/ve4ALrH7kCIaSbZD4q5kV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483c8e11-0995-4af6-6943-08ddec4f2de2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:38:17.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh4lwGCTJtf4bek2Oeza1EeWs9gnUouqQZU6pod66CW7wVTCj+CFPAn85zgUTcfW3rrT2Yxg9SHzJvFUsRwKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509050073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA2MiBTYWx0ZWRfXwFIear6t5Wyx
 wXQGyCO/gV8/cQZmYY3qi0dTfiVwSIH8GGmw5f/cg0AhB+s4AiTLwssxpyS/zcfFKbEn9Jv4gz5
 D02QNSlcI4iLYvFF/rp8SRCVJ317XZjzkrjl+gkxP7D5wIh+TZL/b5PmyTsUbC++kafQspOexZi
 6/rGAQNTvxNKHiRM3UQpE0195/uVKemiE9Q5+InNK9s+2ajKdP0Rm/NlNNG1zkP+mClvuyGz7Ga
 4PdjSGA9c37Rk+aUl5ey3jZmnKQj/WtbCtRvVdomqU5d8kTSVuFpW6Lt10H28P3COoQPcMdxtrf
 +al7NzGk0JX38+doMyIr/fG9Wiyri5gEzK2QgO/CzNH3Z9H/qy4y11cKtNDWyvh7h3FTr9eRRnM
 Sk7rOEGo5trCrJRVirsWDuw8f7ZoKg==
X-Authority-Analysis: v=2.4 cv=G9AcE8k5 c=1 sm=1 tr=0 ts=68ba936d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wdG3rnVZqKkDrR0aZKIA:9 cc=ntf
 awl=host:12068
X-Proofpoint-ORIG-GUID: j2IsC0gM8kj7aHFTmzMU9INBy2esPtXA
X-Proofpoint-GUID: j2IsC0gM8kj7aHFTmzMU9INBy2esPtXA

The test requires raid0, 1, and 10 drivers, so add an explicit requirement
for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/tests/md/002 b/tests/md/002
index c9d15ce..5e77d60 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -16,6 +16,9 @@ requires() {
 	_have_program mdadm
 	_have_driver scsi_debug
 	_have_xfs_io_atomic_write
+	_have_driver raid0
+	_have_driver raid1
+	_have_driver raid10
 }
 
 test() {
-- 
2.43.5

