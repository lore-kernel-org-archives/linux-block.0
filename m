Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182614F98
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780530; cv=fail; b=R9DSM9ZgDfPYoFY+Ud8bpQXHUGukNeS4Dsu3ZVfUoWzYEdeqUyOhZWiTZlWwAmUlUnAJ6FC+9rZwvwBAB19H15cX12DpoK24CqKiy+1J2SiD8kul2ljG61InnERjR47QQDvuDvYOrwZtvyVO0lxqYKxQYdDRds337FVD5TLjoj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780530; c=relaxed/simple;
	bh=0c9gxn8Bc1eJIBe7b2EYze8tB+yEyL85nO0Ob67gaFI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SqLTuuXzRe2PB2drItFOHk+ZqTJXf25dhF9A4PkV8vUID0Apk/MQTisme2wr218Ys2RzZ0jMOhZqUDIwVMgiH/p2CelrlYDSpecKZIsXBc+yMhwJq0l8PALGXav1wyOHnak+7E3skGX5jqWXBV7WX08AgHY9Vz4GvCjR348pIPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sdi+V0Ci; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kr4+Z5uE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sdi+V0Ci";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kr4+Z5uE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g6Rj030235;
	Tue, 29 Jul 2025 09:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=I86T6Y4dzwQVqA83
	dXjpTTfb6MpxbbviHEAAU+JT9X8=; b=Sdi+V0CivF+90bSyC6CofC6aqYM603mC
	jteWN5qleLWohJh4KdYAMbynkVY1hlioXq88xsvOLZi31mCvJ3jiiy/h/PRLVUiS
	vcy2sZV8Br1SsrgPry1STIvDGjTtUuxJBsONOLIEJuNn07qLFWi7sSw/11UeRHeX
	iqDUw5nVWSQHxH3GexnIirZWYVWfRlC2iPw0kpqU9HXTmgQjPsFqGzpFWzMTAAPA
	JIiDeaAL4bEsJQzhpD16bbvL67z1lq43ePESJhQ//iJ1Sq/oOj8iWbN0T8AxfC5J
	uA0jYVTyuafI7uot5q52/crC71Hh80t/0/jclJUvNCmXL5ZEh/m69Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wq4sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:15:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7OAvo016708;
	Tue, 29 Jul 2025 09:15:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nffxtd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N49+uRPhri/eWed+OHgMriL0IozoWuLaPEFaeg5JD7GZo6eMgbozM0QiMjdE/YU1ik5mubcs4Ga2nz8o5SmmXY1wrkdg56eaUh/MV6wf7lyydgYV6rg6SMehm0UgTwZ8M5oEFnlxc1EImaTQF62jyhGN7e70AD3IeHBwSF3MAzvfwZOp46f3jr1NqoSSylDvFEdyI4PMszTEyKYqxCaUsHpa50HCJnnI7baqNxq8VNQBZE29Avh1jOkG+6wqlRFw8RxDiG9mTEW9e8FE+14FwZWwp+JWGZwqGJPiM9IQPfGyZmkzqRiVoP3qZp9R2clUauk8PwgQDBdO4wjhQc8vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I86T6Y4dzwQVqA83dXjpTTfb6MpxbbviHEAAU+JT9X8=;
 b=J4JM7rnWcOZUaKylU3URfzrqPxAHxRCagSLUEkqkA9HEFOoVqnD2Wdm47DdtSTKB55GFnPyJOdL8wno8nZsjZ0VjPhWSNn5n8xNTSsEcbxyIjUfTv+7O5FK9WpXQ2TKgSxC1P3FT9ILlk7rj0bvhX2hEDIwI7cAu6mhSDfC+1RwNtKBYuk8mFFSF/8VmtTgW4mXrW6ZtWz+tDj7jJd54XX2cfM9e++nxhH1lrJ0tGh0f6vAlIsgk103zqeUizh7pN0TZlyD4Y1Uz7tef0OZoDn+w8vqUl0QmKPHNwbJprnZuaUfkAjQFvwAG7GEj6r/8HfFYIxXP73mcvKs8hVdkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I86T6Y4dzwQVqA83dXjpTTfb6MpxbbviHEAAU+JT9X8=;
 b=kr4+Z5uEf/fgCBvp+mPd8WDP8WXTysSfr3mIEIuWd6UReDGyBr8bdazLBSijq/pLv1B8Z5kgHkczBdn3hn3tjt9SWnhBWEbmw8NOezwiyfOhx6+w7YlrPr1QH4deOT0PdgiMNlHkxFBWirWAUyiSCVp7VnlSh8RSVMQk2kVvjLQ=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 09:15:02 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 09:15:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        hare@suse.de, bvanassche@acm.org, dlemoal@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 0/2] block: make some queue limits checks more robust
Date: Tue, 29 Jul 2025 09:14:46 +0000
Message-ID: <20250729091448.1691334-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::28) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d0c7d5-7570-41ca-8344-08ddce806640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YQUSqKkRiIdSKXSZfZi8pNKKVNT79jQBg76WDw8D3a/CuD4a/SN+Z960SVUE?=
 =?us-ascii?Q?UUxEqwDBESXmdAw+NuiKaqam/GV3ACjdY3foqBfGnInAZEiXFAA+uu42Y5JW?=
 =?us-ascii?Q?LNggy4UXZUchGJhxFA5HTMkQis73iLVS7ZrxR1OBYobNx6oWdW6lKztt4slV?=
 =?us-ascii?Q?vD/B+GmNf1Ax8XEfMUkOTlbwMKopYrC5O29dppsJBsijYL6w+fl5dvg74D1u?=
 =?us-ascii?Q?eOrx+6L63WRc1R3ziFfw4teGFaN6wOFwBqjHvV0uz44PbYQwGzz0/kwiJq7F?=
 =?us-ascii?Q?42N98bUbIAaVfb3kXraVBdYawJ8uFeMzgerGMyEiij7DH9HpBYFwO0nL1Tbz?=
 =?us-ascii?Q?p7Mfn4QcWSy+RCsQrbGcq8uX8tFDOEhr7c/Eq0i3TJ2RAoOm8+tDeUpGGf+k?=
 =?us-ascii?Q?u8md28cxSFLcdr0iCSczAGNWxR60lvmfmLAh9Ri6QKPG+CW2S4+Xcip0t0Ah?=
 =?us-ascii?Q?BLWad/gL5nRDwPs3nulfvUVNpAmjC1saNvxswZRn2q5WGN4mvbxXaW3GCCXd?=
 =?us-ascii?Q?2FSFSiQU357KHqihna4ZmOUAKjRga4xH7synMI8OaIDTfS6feBCscjK7yPBb?=
 =?us-ascii?Q?6uE4GG3pdGAejod/JhvtLWNLcpGoX2HtwPKAVW261juKlx/fUkag58Wyj1rg?=
 =?us-ascii?Q?qQ1ZZw1D06Zzs3GfokgQRN1PhKlXpkq9L34QnOw9o5GkomThtA+z+JBDFupA?=
 =?us-ascii?Q?mNb+/lQ8vwr+fJAcpEQHEq2KQWHFnrgM78HuCsINRb4Wrvi4ukQpTrkrNKiC?=
 =?us-ascii?Q?bQHXGv6Q2JQQXe7d8KnScIXCn1mBhP7JmbJSSgEUsPVqaSItQwnFudCAaCXR?=
 =?us-ascii?Q?EtTj1iKIREqAYD5PRdhAD6XfsUp3DOabUjPp7xK0y99Z7O5sTrvpX8MdF8TW?=
 =?us-ascii?Q?ps9q2lx6TVvuRyeKoEjL+8eGLXw7NbEJsSFaATWfMLsWUeBn3+rj/ydkCn7j?=
 =?us-ascii?Q?tTKJeOQVcVF1oo4EXJwPBrJQtfVOPpVq19WV8ohMzR1rxQ5VsjXO2CYMUqe9?=
 =?us-ascii?Q?iQocqKhZt+ZNQEtt6fdnG2HD4mHwXUA7ZyfqA06lZnutWZKvROTlaQPw3tWP?=
 =?us-ascii?Q?yfWAqv1GTE0O2camrsTnwoAoZyhWNcnNh6TUnP2j5NG/bfklRSp77kGc7KdD?=
 =?us-ascii?Q?8z7QXzQXK6MGPK+pPlvd2oWlnmpiWOTNR+0muT8Kwd5rSZd9101iSsNUwEJr?=
 =?us-ascii?Q?fxIVLth2QDQVwB+NenRGAZ6iXcWKtQw8O9CqFEdJU+HS1/P9fvWqoNh+3ocN?=
 =?us-ascii?Q?N8bfa9wJt1CN4wGc1CZ7kMyJy+ploP5uZvh1oRsntH00h91ZsU0Uz6oHDhTS?=
 =?us-ascii?Q?SjDbc0e5DR7s+87yXxH3PxwYyKLpdkhhYZAsKPvzC1R8Nok4RruJcWB44Myr?=
 =?us-ascii?Q?BCSmry7J8WM5F3ussQYod4skmXXI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kw9Iy5EnUEqLJSajVw+WJdIK47Ooi7i/9897X0m/oxONAusuS2Ycn0oDbyZF?=
 =?us-ascii?Q?drBtysvEUs2vJWrTvAp5msDBRXtSjJhpJGkvrEJibPrOfm1XVJewFOfgIlih?=
 =?us-ascii?Q?mIL0dojOadKERMEJfDsp1uP7rLOiISc/My+DXVZ0cvqTcdb7zi/frTBovnIN?=
 =?us-ascii?Q?xAQpTA8pEicL3Ji1OgHVGoEax1k73N5YArdlE3oGIJdFeKaaJJX3sxZokE7Y?=
 =?us-ascii?Q?eEDKfhKzFJd95+Dl94TZ9FYCH4JLt3lGzNolH7j3yw3x4+cIQBRglerkE9k+?=
 =?us-ascii?Q?E7BToz89U1YegL1qnzDgd6T6jG/v3E25wgBS3VDSWp9d2xoBTbb76slsC5mC?=
 =?us-ascii?Q?/MAyMXe+cjVbRHVjWcY6bdhRgA4DNxgrv6Gmf28gFU7uqbzXEm7eegL+mDEw?=
 =?us-ascii?Q?bzeyH/9t/jRo4oHcAH0QAYr/GOPyniHI26MeHjuLPG6LOXJHMsxPBh1+a1jE?=
 =?us-ascii?Q?3BGOez6xeQDnGGgW2EW5IytPCEieocprQNZWaYyijADCTMH+nnGlurJvadf+?=
 =?us-ascii?Q?oPK0a1K6YPO4UG8MX4Vu00hEWTzi4NoetVXdJ+qMNL2bxqSDdYCikW1NKtMX?=
 =?us-ascii?Q?qs7wdVknurTURl8BaGefHCndbQvmFeDqHNz0KHJ/vh1sxrC6rndd+1YYiAl4?=
 =?us-ascii?Q?FBucwUPx40KDaaemHdk2tpFjXKxKgfN9YXw7T/ANpAbvgfWJ0rm5j3auj5n+?=
 =?us-ascii?Q?L6wGwGWZfCbXQlcr0VxSkY57d9xxMMdiOXGyJR9A1iaX53C9vKu5jl9AIfuM?=
 =?us-ascii?Q?uLFDDR5bGWruKOf8ji4IDyVnly/IcFGoPB4suxE3Sl3hT3tjWwLAq0hAik5l?=
 =?us-ascii?Q?FV1cwA9kdb1nAMTMi8AUFmhXcKJGoAC/3XBjJh6tQdJaPYAzqJR4NgH6NmMh?=
 =?us-ascii?Q?oD19602eZM3clysoxeVcLSe26AApt4wZiCV6gTwmGgzM4V5ml2YDNuNBI8qR?=
 =?us-ascii?Q?emHRMyvSsFKyD3nitKlh2z79Yk/vIgTrEJeQl/QRphhB5JpUGiU1pv+s6Br/?=
 =?us-ascii?Q?PSoRJFuL6r+R31qfqQRZV7EFsRVYDXT0CeFMCOjIJU60Cfo7uzxCeDODSDs0?=
 =?us-ascii?Q?J7DmdElB0RpSNFQ92ob96MDtJjfm2zjc59Qec2vgv+wtaVuFOJUzNDXGLfxz?=
 =?us-ascii?Q?VNuTEaSzb/66Kj/S6qelQX/Xx1/C9yFPiG+h6sRCpX5Tku0EOQ4kHsaaWolm?=
 =?us-ascii?Q?lBMphGJ7bYUS354HGry2o/poqQhfmRaMhz7DJs5TniGKKoRpNO97kvszJbUI?=
 =?us-ascii?Q?tZQAmoWwgYd6bGOEfsFsgeqRgKksOfEjMgDa2vuoqzfinjC7kIz9kXKdTSDm?=
 =?us-ascii?Q?I0ZA2opDsThdj2Yjf0i2MlSEpjhATiD9IfsUFHMZWMrEiwoo1zAO14tBMS1t?=
 =?us-ascii?Q?o96AaAyUFSIvBFH8xCKV/Xsf2O9IruQCQjQ0cccxgzaKzRoPAwPpeLauYQXA?=
 =?us-ascii?Q?k6DQz4+L2NkcA4p30+yO5n2cEI4ZXHIIDXNe3iC9k/eWGxY7EgR1kzFX7BAt?=
 =?us-ascii?Q?DInh0k0i3DWutQOoAj3UehPBW71jf1IcXZUPM4aRjMK6361FwaE1/+7shzvZ?=
 =?us-ascii?Q?LRVi2P0qWv+FDwVsaLuhC6Q9IO/J37NpFuUukAP8+yzOc05EZ9lFWYT24iWN?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yLxcgKkxnQ1bXfebA4PkhnCD//eaROI/i3b4qGZkO6DQq9RoXrpDTwqYpZ8bVYtVY9RhPVVqkoTL68aDfXwuEqEe/x0y2Id0Xl3YfglJMYUADAeYw18mpE2veULaBxsJ3XYWtQ184KkBjtzqrHudOqB+3rZqdHm6LfVZoZGxSI2SI/8IWzKgvzTt6KqihDz5AulXkGN+TeIG6/HH3jguOrD4woT0JGoiynBZieiXEXnupdG26qOBcczASadfyMmTkockR+2DI9oK4vfyYiS+Lbq6RJyRf9hLyzUVIpkdUJIKQRc/8NgYVADUaiFRhP7I4gFp0b6cubtun711DqyBxQNuvxQ7YeKC69RTmfi5k/dlCnkf/5UJmbEH4v2n5XdGAJc+4tq3azbG1zEtLyIUaVEoo0sIJle5MEUv71pI9Tjkvar1qszwR7MDXVMofdO6/isGyXMFr/DUFFaJreiXRfSOOL7Y5P02pJUqsMzXqiH4yJTjrlHxOohHyA0zp8CI2WuMclPgGUQYMWWsXActhwPO6on0Qpvd0yyFyb3ZeY4yncBVrM+l7d0gG2DcITzp2dwDYCqQmjBaB88aQS4gZ5IOz5VygheDpN/FY87Ah/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d0c7d5-7570-41ca-8344-08ddce806640
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:15:02.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+j/+7bPqJDgp4LKqPu7v1yiJjwwz2ZzcnncgfiE3e8T5NZi13Nm2PU3pj8spMz7nP8QXmwNSLPN84b0XZkwIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290071
X-Proofpoint-ORIG-GUID: IkUHxwhDlWubet9dJN3S7uQb5I4R-_dh
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=6888911e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=fO_fDZIbc9CCpDXkTfwA:9
 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3MSBTYWx0ZWRfXyM0sj8qEE6Ap
 LZnnssvT4QXK/jBizJ/z7s5PVx5zgUgxV0z30fz4NYjI/yQVDOilodmmOpLcQbYb7kkXb44+pvj
 lYA2RDlazL/b1n6eKK3R3lWSRXFSU0dvbAM/QCb/+/pPo3noxwaplC3LXMTLtcSMlG+Ps1owKGy
 /YZ5OWATAX1lBbZFiEDYJVqVGdAs1vIYAxc9xUbIfixTor2ukV0FbKuEeHyRQQmztKDwTxZajZO
 ZMr2KRe+V3U35atR7abx7L2RHQ1mnk5lowj1JJRye9aMgVL48ZZwVnkFMVBPhGK+hK7O/M5oYHE
 183rFRjHC23FqAYI19UEp8r5rGwr0xU/B+jic+5sglDxip2wrnGcvKX8zgU38kS3kxKsHLYuVs+
 SujcoU01eNdU/tCdDmTykzEsjbGDN4sQwfRxzhbNh4b135DiLaCIepynns3Y8buXZNWnaGLx
X-Proofpoint-GUID: IkUHxwhDlWubet9dJN3S7uQb5I4R-_dh

This series contains a couple of changes to make request queue limits
checks more robust.

About the change to enforce a power-of-2 physical block size, I audited
the drivers which set this. All look ok to comply with this rule, as
follows:

drivers/block/brd.c - uses PAGE_SIZE, so ok

drivers/block/drbd/drbd_main.c - uses bdev_physical_block_size(), so ok

drivers/block/loop.c - uses same size as LBS (which must be a 
power-of-2), so ok

drivers/block/mtip32xx/mtip32xx.c - uses 4096, so ok

drivers/block/n64cart.c - uses 4096, so ok

drivers/block/nbd.c - uses same size as LBS (which must be a 
power-of-2), so ok

drivers/block/null_blk/main.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/block/rnbd/rnbd-clt.c - drivers/block/rnbd/rnbd-srv.c - uses
bdev_physical_block_size() to fill in
rnbd_msg_open_rsp.physical_block_size, and rnbd-clt.c fills in
queue_limits.physical_block_size from
rnbd_msg_open_rsp.physical_block_size, so looks ok

drivers/block/sunvdc.c not sure on this one. For v1.2 spec we have 
vio_disk_attr_info.phys_block_size, but I cannot
find a spec detailing it.
https://oss.oracle.com/sparcdocs/hypervisor-api-3.0draft7.pdf has
earlier specs. FWIW, no rules on power-of-2 not mentioned for
vdisk_block_size in that spec, so unlikely to have rules for physical
block size. Default pbs is VDC_DEFAULT_BLK_SIZE = 512, and other sizes
in driver are all power-of-2, so likely phys_block_size
will be a power-of-2 always

drivers/block/ublk_drv.c - uses 1 << p->physical_bs_shift, so ok

drivers/block/virtio_blk.c - according to [0], should be ok

drivers/block/zloop.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/block/zram/zram_drv.c - uses PAGE_SIZE, so ok

drivers/md/bcache/super.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/md/dm-crypt.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/md/dm-ebs-target.c - ebs_ctr() -> __ebs_check_bs() ensures a
power-of-2, so ok

drivers/md/dm-integrity.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/md/dm-log-writes.c - uses bdev_physical_block_size(), so ok

drivers/md/dm-vdo/dm-vdo-target.c - VDO_BLOCK_SIZE = 4096, so ok

drivers/md/dm-verity-target.c - uses 1 << v->data_dev_block_bits, so ok

drivers/md/dm-writecache.c - writecache_ctr() line 2376 ensure
blocksize is a power-of-2, so ok

drivers/md/dm-zoned-target.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/nvdimm/pmem.c - uses PAGE_SIZE, so ok

drivers/nvme/host/core.c - may not be ok, so pbs comes from npwg and
spec does not mandate this is a power-of-2. According to [1], nothing
like this has been seen.

drivers/scsi/sd.c - uses (1 << (buffer[13] & 0xf)) * sector_size in
sdkp->physical_block_size, so ok

drivers/scsi/sd_zbc.c - uses sdkp->physical_block_size, so ok

drivers/target/target_core_iblock.c - uses bdev_physical_block_size(), so ok

[0] https://lore.kernel.org/linux-block/aa4b8526-5346-4004-a3b7-abcffd201b1a@kernel.org/
[1] https://lore.kernel.org/linux-block/yq1qzy8x5m8.fsf@ca-mkp.ca.oracle.com/

Changes since RFC:
- Add RB tags (thanks!)

John Garry (2):
  block: avoid possible overflow for chunk_sectors check in
    blk_stack_limits()
  block: Enforce power-of-2 physical block size

 block/blk-settings.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.5

