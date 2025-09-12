Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D20289358
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671099; cv=fail; b=jZE0t/AGAY69vQheOkRrS73Xq5lrFFKCDo1rY72o5FkgAtfT/TdEIJTikd2YRvZ/AeHCxFM9cdMuc+X4DSHsNv5KcQ9oHxS4mb22v2WFtDq8laVm4Fe5RYUicI8SCt9ElP4+Xm2nvbDVMLTDbkVo9Sb5D61IctC0umoMqLpGy80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671099; c=relaxed/simple;
	bh=BAAdchft279KfyrY5R9hT42t+QdoBErl8gJgYsgIhWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjwAPXcsainiKzjTDDU65xECxHWHATrbjf6Bw9J+6b+ZDFk7cEDzf3lqGHEHyoLAjk8sTYRqWrmToYlBlByA3k+agauzG8Fu00M7zi8QrHGpFoyYGBK2pdcVZM9P7b0LBiVcHxLkIOieM+eaNVPQ0Mrv/wBw1RK8aKJZEpHafOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K2nTYOOO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OIzHhOd/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K2nTYOOO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OIzHhOd/"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1ueq0009585;
	Fri, 12 Sep 2025 09:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nmSmIuVEwgWNAYqwQxL5ayqWlgErs6Mu3QNjiJ71tv4=; b=
	K2nTYOOOoe88879FPqP60NeAguuvq6Osur/XVibZuiXbWFBv540iaFJe5ViAjkuo
	RAzHl3hTq9eGgrUe6dtoP+1lJPtA8Y1uo88Qr8TQ0M6wO7NvpqIct7hcu+ikk6+i
	87iPjR5Hs/ir71D8V4oe94Ci/RMT2jM1A+AKy4SwhCKAgBVewAL3YPv+3ysejPQ+
	olzoRbUPWp/51K58r87A3HgwbD3QGFNCaqGO0DTCDt1wkqwNkZd25BKUMzPxKgLe
	cCMgwvtew5zfnnXKJo5yCaJdYbIgmH1Go5sgzeQejA3Q/+voECrsqk6lVOvCVfqP
	gDhjdJ9A4Wnh8ePtoVQIRw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2ywer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8uNOl038862;
	Fri, 12 Sep 2025 09:58:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddnqaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZOgnQ3J2z3yHR0wwrRBbAHjsOr7K1+PO2nFEm+fZf0dAkzJy9aHWUB4bnyOSESginbh6Q/RN5cOppwjOAd4hjM1yLHuxPxsEX1v0jpbRTm1ocREnWOPekoxplHVMYNFchxDTZpBenqiQnwSHEcTSh8c8hzoY3ce5iSdQVqdEtNYnx7+5qXAXr/uR7DBuhlrVOjWcGieFIt1IQeGwzRO+4ZOe37Mzs1WuggARsr+ezfJJDBHEgcQ+607ybDN1ORQNhIi8LpIyva3QecO1i/6/lM+rEqeouTR6ROdYMSSt3i7EqyTgjYmMEa2dF0h5S0vXL8E821lKdCs5MtjLnemuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmSmIuVEwgWNAYqwQxL5ayqWlgErs6Mu3QNjiJ71tv4=;
 b=o9LTYFnV3BqVhs+OL4JiTQT6OXFRYqY5HkrEhLZQvRL80Umo8WhstFNy5sTwxVVgcHuJ00KHrZHQY3uQZeqqsbg6KaZG1/OtXr/55jijLY91XsMwFTes8jmviwCoC310k4/3d668Ugmm1CsVCz3XQyDXKWiHuPfitUcQgK2MgrRfNc+Wkl2npoxGhXS6T9Ko2WWXGizVw443CHMEadHmMqVEh04oeIvte5q51q3pmfQUr/c/3lpzemRiXebqBNiyCMa2QD5c+u47f75p/NypOKGdmHcp8X4rRZNVkKvzVuaxBDjKYhIiu9hTkivRERWf25HoLWBbtbjcpOwpEsGuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmSmIuVEwgWNAYqwQxL5ayqWlgErs6Mu3QNjiJ71tv4=;
 b=OIzHhOd/7DEaLTK4Ap+E6gZ8V38SBHNSo5ap593Jyw7SKrt+wX4uUWLEh9XIHPZ9JlfZhSwyNbTPBNIipuCYdTQ8SvTZ58xowWC77sTE9crfO85mfTu33T/G2AuPqZcYPfwg+E+p3l2mIRhCHM8zIv1nICfhRZO0XfpPAF1DGnc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:46 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 3/7] md/002: convert to use _md_atomics_test
Date: Fri, 12 Sep 2025 09:57:25 +0000
Message-ID: <20250912095729.2281934-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0169.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::26) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9e93c9-b396-4e17-5540-08ddf1e2d31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8hE06qvNA9a8GLQ+U6ckzf0nVbsDgVduvHdR/SvoSKSzdY2hE66YSS+2S8U3?=
 =?us-ascii?Q?R1smPYiz/vt9QsgBj6aVIZtlOfAFg2YzR4sOXDMCBcSPUnkZT2hnKoJjWZas?=
 =?us-ascii?Q?CSVq7jvQXUJG9rHO+XUx45cDo+Q2XCkp+QXLHUduwtkd302uLjWjOLcus/tp?=
 =?us-ascii?Q?1uZsg5u0eKKRqmuUtzW+4obO3EJZ//vb0tmYtOxX2fZh+ljaDpHjcxaU5hB8?=
 =?us-ascii?Q?JUezKsdGB8q5dwstiJH1mGe+eKd+sahV9Rasg/AKH4J8lXEIRH5fNxQw2dRp?=
 =?us-ascii?Q?cKjkGvGKW6RGg8cTxW5cm4eXQI22QtHM2p7IKaew3YtOfF1OTtB7y1LWGHeK?=
 =?us-ascii?Q?589VOojxl4lMe84blIuhEPWaoqxAtFPGDsF9rcFkiqPQzLOfUKhKEHxaaO+9?=
 =?us-ascii?Q?Mjtxv6SIMn40iwKGAtnZmJIGOJuaBdGGF0a6NtCWHr7XeMhToZrMjp17fNuK?=
 =?us-ascii?Q?AMYEacxzCbITu90z3dojtFvvV2aw5P2eDluPuDC89WQY41FOWvCvgq20jwdb?=
 =?us-ascii?Q?cHH5+XpWAWbLTNfSOcDy/wnc4VcvKd6qM19/eZbT0RVqRFBDkXzM2X6XCMJk?=
 =?us-ascii?Q?Wp/TtFga9jjH0Q6za0jtdDpcBwt8RbcnvWbPqSjkdiON6z28qxjTYa8eTOWk?=
 =?us-ascii?Q?N2zY0nHlKUGoORviDm7SDo7dR19te4BIJOzLBLABvSDCsl5aYX2vaWW/km+n?=
 =?us-ascii?Q?sRdgEW7DrX4lShvosxBBFl6zF6dDHYQBsM1cmeZbx/hAU3qFrFU/C+YgUyyV?=
 =?us-ascii?Q?i1ZA49I5kxUcjqYfiEa2T9wVPs/4A9v+91fUsMQhjKA1OcmRc2+Gj9p4kCxj?=
 =?us-ascii?Q?AaGZoQeaysTvgbfV5ZwJ9UfIIU2v7HzHGFjCnMgQGadjdNaalzA387Z84vOj?=
 =?us-ascii?Q?sej8NF6DZeGcgeIZDKyzzCFs6qpM/I6+aMBhX6oe2aOHc72c+b8Y7lsbpbL8?=
 =?us-ascii?Q?ynTqJV38aEPdBfMwsAhCiqhxkBp0mNUzdaCN9UtPPhSQ7moq9LIxERHOUBdM?=
 =?us-ascii?Q?ahF77e+zCgUMx1DgQP6WhgKHudQZPHklMGSOOnGVagaLAK06nHyWj1MprOxK?=
 =?us-ascii?Q?HtD/f8bFO8YJyIAoWZyHfxfdhjA5WMysXmOw05Ue9LruI1hMIbKml4WH92wn?=
 =?us-ascii?Q?2B+jxL3YbbluqJiYCVYfaz6UokcbNZ8uO1lEraxjQxrWNljO0biZS9xldQtq?=
 =?us-ascii?Q?GdegGIov0wW1u9mMCqmSeD2XXjoeQVF9if3lFRLAowwIu0KwJMOe4ihDEwTS?=
 =?us-ascii?Q?dlEx27cmV+iqpPSD+CE00tMbzaCA/4aYx4ypBIG9MHOaAYPKMGpjmnHQv8hI?=
 =?us-ascii?Q?Hh3wQ/+N2yIJRkHdM5hrRE3PLsbFmQlHwNr8DHzIHKSUeXlYqK/lfw4WPSM8?=
 =?us-ascii?Q?Usl9d0buI7hJ+cY1yzV5zwl1zFlG8Qv1v2uZlXZH0vptK+fXX0uiKBV3MLZe?=
 =?us-ascii?Q?c3MiWmYiXBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iMhlyOzuc/MmtkjTFgGzut6ZE0rFsz17vnnN4fJzj7yH12SJiC8g6wKi1Usu?=
 =?us-ascii?Q?nZbHI+Wa5xxgA9ZwpIvHdrqcCq5hTFLZ2bJe4kHJy53otZOAMS5kodsz67Vx?=
 =?us-ascii?Q?O6CqS1H8pXXuvTLD6tzAG4voBd79v8LLxJnD/3XU0Vw9mDnK1w6Lr/2A+SYD?=
 =?us-ascii?Q?R42tip8Su05z3DNUllb/2s0Zk9ltgXAulk23lk5lQxdMuWnRSDY98o6AsCDx?=
 =?us-ascii?Q?O02zpz9AMHuaCVk64u9xZg+7Shxjz1ZfilkVgC3eno6qXLfIVHlTsJMM6djN?=
 =?us-ascii?Q?JAe0w1GtUq7DAbuF+XGhiF/pWc0PfZVFkxKPzX0Np06nTBccnBk3ln2JrYIt?=
 =?us-ascii?Q?uAg8TAR7AkgqMA8za4DYOXNtZIxRkY2Tz1fqLzU1bFPHtb9nbz3RNkcNAdR+?=
 =?us-ascii?Q?uOvFfZ+VHK7ox4vSVQv+OwuiejBRA/CMlPufEzxLeTJ0HaNCIpNByMbNJ1rS?=
 =?us-ascii?Q?CvuFA5l23ZkwSxQ/AIv/LOwhIOn+18lySmj3hf9VUPQVdK+VzDS9RV9wtz+7?=
 =?us-ascii?Q?A5tNixwNOxZd5u/+IS3cEkdTTpptk5wX4G6D0f1mhuVSRHpgrn5fbOzwjvd9?=
 =?us-ascii?Q?gL+SOlwIkUvqtszPuieUfGfzCFYSHhv0TOha1Cp3cPdNN39H7/DnIXoHA4th?=
 =?us-ascii?Q?hlK7wJygNZ0elShNB3RcX8+aBzqcAj39laLZJirCL2QM1lWEATJWrR0vLfVQ?=
 =?us-ascii?Q?Xw2YWv0PWV07CeCBiEbWN4n5Qtj+qFGiDMb/fahnlEdyzYh5YUv6pFrNAaHp?=
 =?us-ascii?Q?PF4T8MH5WULl1Qq5h+rD6YtghMs1Gf8C4uzCqdeb5yfiaaIYaWKN8HJueobG?=
 =?us-ascii?Q?kViJ/fgaqEtFT/IabGMs8ngr5xj1S7pgApMFFDKbcgIYH1/D1kjO5qU4hqQ+?=
 =?us-ascii?Q?NkJnFl+Tv9TU4pGPbmKDJvhN4HVVUD0nNZOTUwrQrhMXbfue0Bkec8WYXGbK?=
 =?us-ascii?Q?8jWSsk/Nsc1RsLG3GCsXzIwz9d325FdthCqbc/tMIQrlD/xb4y4xCSmMtQg5?=
 =?us-ascii?Q?iIlT9IurmTztl/FvQLRniOJkIWUXfya33/8koe+w2BjQy6tS84x/SsjVtZOT?=
 =?us-ascii?Q?flDePELahkJh69qOxD/VdHmHNcvjoMq6lo2V29e5qp8ozEIlmUhOi584wx38?=
 =?us-ascii?Q?eHZIsgbXX2F0FJO5AFYDbREbM6/V1CDCu6Ald9UYeY8dCaPvIbQXwVv0OVt7?=
 =?us-ascii?Q?SZkcHABbCvn+HuuSEsXZiGKOWmU3GkyrnZGyD40DvGsEkbwidgnKXgFeUrYG?=
 =?us-ascii?Q?OFDduobEs9Crh5VLMt7LY8CCvgJDWiUgHx5ap1OESUWXe+A32sl+u4U69v/P?=
 =?us-ascii?Q?YnWgpME03Bh0bb5lzv4l5KAB7tAfnnLf81Sqgr/VJs6em2ZI2F0kBOgJmPvj?=
 =?us-ascii?Q?l2in2p+/aT/B+9rfAHk+lGgEkNfSFbJhLFfzDDx/gV/E0/XTRD70t8dBwFEK?=
 =?us-ascii?Q?XNkEE5a8JKvg5kHEVvx88BDFZWhhQqgaLPqBxyncavzbN0tCKOUHVOfk5fUQ?=
 =?us-ascii?Q?JtAh1nt87Ecw1pVMp/0dw1bxERhxDHvWUEhbeHSXh39rq4BHtbZsPdAu2m3O?=
 =?us-ascii?Q?D+YQK2ebPZYzMuOslGjYatNEUHtYWE9fmDrH7ksANbx+SB6XKqhyEW2JPrDH?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0gOC6KnZ4r6A+eJRJp5McQom3P1dv22tPsbWJCJ0sFzgjP7OXhjG4KhF2f2ZldOZap4uIE0bczchgSWDMIjXYW8x9YPxLpEl7P9RKU4hiuKSYQ24g6sh37Y8E2nMMjgZXQ1vjNhsCpuyX3AQSeKxsMMHRQzuO0lyyRe+ZzFFWWwREzgpRsGkI2y+7MI42H32dz5FCkmm/+wdB7UGUSm9ue+epYKwGsLogwRNqZmD7J46T+65ZiSQS1Bt/B7Zn3ox1urPsmkX3nSbwTWkN6ITOZQEgwKcJ9geEb0JMVJE5RIzkqTYEtWeV6yfp+23bhvjFUAvOp9CC8JAMTqeaySe6AY+nxLQxDy8E3tgt0ANIJJNM4y4CH0R+QGtqAm0BPe1IKkGNMVQt7ctjQuJNCGoxq+a0NRZcDLP7C84pYvLgSj6ZwYg73Lru6S1ft4eG+f3AkPtJRGc/MWlRiFS2VsoWSgXZ/xI+QuplwmwvqpzvGjUAV7Ub+18y3sV4rUPhTH+DXcG4cZDqtx6fo3pxbcA2YVPfqLMe+Df+TxgBv9MSvXNVocXJ8i5JhmfuGAsUFUXtYMoheGePcRLJhzSMKFpiUb3ZFggaYUzCBmb1hCEI7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9e93c9-b396-4e17-5540-08ddf1e2d31c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:46.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AL7mZy3uuW2KLhLR5+ayn8zUTS9qvYjKICXHUde9TmG0jpuju7h1jxJRH15DElxZqxapfgjXADAqgjNj25xkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120094
X-Proofpoint-GUID: zClw8K7-_ovFfmI-o1kUpTyjGksnkxqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX+1W0XBnILCjM
 ltECWOPhyX5D7nLn+Q51nUPDkc46jq2OEHWf5utBY/j5HAHMaJSeZqUZuLORYmrD/p05pVlO99M
 xP/NopWl5JqE3EHETijeuqOAkjjdoPmLGFEkZ+ewhumuQKtFyTBiwVTgyYnacYt37dc63bWCpVY
 ++WpSuj8pkU+G/4qHAjzsFTVH5FOlAhztRlSguAYwrrd0XNAGvAAIFugRG3XhH/KDPkWaGbW4Ah
 ZRcOIM4VzM9vc3XCIMQZwItPB2UyYZhqU9LVFTEv6V9GTw6tKZyOmytTeojthd2Qq3sXtOJtfQH
 4tftzTQshmv5uES94nXSaqrWvqmyrdJFP00kPr6AJOo9mtCI+Z+DfFS48anAN+XxpWX7U/ZS+BU
 k6Q7J9oOw+aKyA2SsOIEDvRaq/nl0Q==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c3eeb5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=q1clhW5q0aa-2bEoYAsA:9 cc=ntf
 awl=host:12083
X-Proofpoint-ORIG-GUID: zClw8K7-_ovFfmI-o1kUpTyjGksnkxqY

_md_atomics_test does even more testing than 002 does now.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     | 210 +----------------------------------------------
 tests/md/002.out | 158 ++++++++++++++++++++++++++---------
 2 files changed, 119 insertions(+), 249 deletions(-)

diff --git a/tests/md/002 b/tests/md/002
index fdf1e23..990b64b 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -12,41 +12,10 @@ DESCRIPTION="test md atomic writes"
 QUICK=1
 
 requires() {
-	_have_kver 6 14 0
-	_have_program mdadm
 	_have_driver scsi_debug
-	_have_xfs_io_atomic_write
-	_have_driver raid0
-	_have_driver raid1
-	_have_driver raid10
 }
 
 test() {
-	local scsi_debug_atomic_wr_max_length
-	local scsi_debug_atomic_wr_gran
-	local scsi_sysfs_atomic_max_bytes
-	local scsi_sysfs_atomic_unit_max_bytes
-	local scsi_sysfs_atomic_unit_min_bytes
-	local md_atomic_max_bytes
-	local md_atomic_min_bytes
-	local md_sysfs_max_hw_sectors_kb
-	local md_max_hw_bytes
-	local md_chunk_size
-	local md_chunk_size_bytes
-	local md_sysfs_logical_block_size
-	local md_sysfs_atomic_max_bytes
-	local md_sysfs_atomic_unit_max_bytes
-	local md_sysfs_atomic_unit_min_bytes
-	local bytes_to_write
-	local bytes_written
-	local test_desc
-	local scsi_0
-	local scsi_1
-	local scsi_2
-	local scsi_3
-	local scsi_dev_sysfs
-	local md_dev
-	local md_dev_sysfs
 	local scsi_debug_params=(
 		delay=0
 		atomic_wr=1
@@ -66,183 +35,8 @@ test() {
 	scsi_2="${SCSI_DEBUG_DEVICES[2]}"
 	scsi_3="${SCSI_DEBUG_DEVICES[3]}"
 
-	scsi_dev_sysfs="/sys/block/${scsi_0}"
-	scsi_sysfs_atomic_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_max_bytes)
-	scsi_sysfs_atomic_unit_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
-	scsi_sysfs_atomic_unit_min_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
-	scsi_debug_atomic_wr_max_length=$(< /sys/module/scsi_debug/parameters/atomic_wr_max_length)
-	scsi_debug_atomic_wr_gran=$(< /sys/module/scsi_debug/parameters/atomic_wr_gran)
-
-	for raid_level in 0 1 10; do
-		if [ "$raid_level" = 10 ]
-		then
-			mdadm --create /dev/md/blktests_md --level=$raid_level \
-				--raid-devices=4 --force --run /dev/"${scsi_0}" /dev/"${scsi_1}" \
-				/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
-		else
-			mdadm --create /dev/md/blktests_md --level=$raid_level \
-				--raid-devices=2 --force --run \
-				/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
-		fi
-
-		md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
-		md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
-
-		md_sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
-		md_sysfs_max_hw_sectors_kb=$(< "${md_dev_sysfs}"/queue/max_hw_sectors_kb)
-		md_max_hw_bytes=$(( "$md_sysfs_max_hw_sectors_kb" * 1024 ))
-		md_sysfs_atomic_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_max_bytes)
-		md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
-		md_sysfs_atomic_unit_min_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
-		md_atomic_max_bytes=$(( "$scsi_debug_atomic_wr_max_length" * "$md_sysfs_logical_block_size" ))
-		md_atomic_min_bytes=$(( "$scsi_debug_atomic_wr_gran" * "$md_sysfs_logical_block_size" ))
-
-		test_desc="TEST 1 RAID $raid_level - Verify md sysfs atomic attributes matches scsi"
-		if [ "$md_sysfs_atomic_unit_max_bytes" = "$scsi_sysfs_atomic_unit_max_bytes" ] &&
-			[ "$md_sysfs_atomic_unit_min_bytes" = "$scsi_sysfs_atomic_unit_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $scsi_sysfs_atomic_unit_max_bytes -" \
-				"$md_sysfs_atomic_unit_min_bytes - $scsi_sysfs_atomic_unit_min_bytes "
-		fi
-
-		test_desc="TEST 2 RAID $raid_level - Verify sysfs atomic attributes"
-		if [ "$md_max_hw_bytes" -ge "$md_sysfs_atomic_max_bytes" ] &&
-			[ "$md_sysfs_atomic_max_bytes" -ge "$md_sysfs_atomic_unit_max_bytes" ] &&
-			[ "$md_sysfs_atomic_unit_max_bytes" -ge "$md_sysfs_atomic_unit_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_max_hw_bytes - $md_sysfs_max_hw_sectors_kb -" \
-				"$md_sysfs_atomic_max_bytes - $md_sysfs_atomic_unit_max_bytes -" \
-				"$md_sysfs_atomic_unit_min_bytes"
-		fi
-
-		test_desc="TEST 3 RAID $raid_level - Verify md sysfs_atomic_max_bytes is less than or equal "
-		test_desc+="scsi sysfs_atomic_max_bytes"
-		if [ "$md_sysfs_atomic_max_bytes" -le "$scsi_sysfs_atomic_max_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_max_bytes - $scsi_sysfs_atomic_max_bytes"
-		fi
-
-		test_desc="TEST 4 RAID $raid_level - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length"
-		if (("$md_sysfs_atomic_unit_max_bytes" <= "$md_atomic_max_bytes"))
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $md_atomic_max_bytes"
-		fi
-
-		test_desc="TEST 5 RAID $raid_level - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran"
-		if [ "$md_sysfs_atomic_unit_min_bytes" = "$md_atomic_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_unit_min_bytes - $md_atomic_min_bytes"
-		fi
-
-		test_desc="TEST 6 RAID $raid_level - check statx stx_atomic_write_unit_min"
-		statx_atomic_min=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_min")
-		if [ "$statx_atomic_min" = "$md_atomic_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $statx_atomic_min - $md_atomic_min_bytes"
-		fi
-
-		test_desc="TEST 7 RAID $raid_level - check statx stx_atomic_write_unit_max"
-		statx_atomic_max=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_max")
-		if [ "$statx_atomic_max" = "$md_sysfs_atomic_unit_max_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $statx_atomic_max - $md_sysfs_atomic_unit_max_bytes"
-		fi
-
-		test_desc="TEST 8 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
-		test_desc+="RWF_ATOMIC flag - pwritev2 should be succesful"
-		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_max_bytes")
-		if [ "$bytes_written" = "$md_sysfs_atomic_unit_max_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $bytes_written - $md_sysfs_atomic_unit_max_bytes"
-		fi
-
-		test_desc="TEST 9 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
-		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
-		bytes_to_write=$(( "${md_sysfs_atomic_unit_max_bytes}" + 512 ))
-		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
-		if [ "$bytes_written" = "" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $bytes_written - $bytes_to_write"
-		fi
-
-		test_desc="TEST 10 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
-		test_desc+="with RWF_ATOMIC flag - pwritev2 should be succesful"
-		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_min_bytes")
-		if [ "$bytes_written" = "$md_sysfs_atomic_unit_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $bytes_written - $md_atomic_min_bytes"
-		fi
-
-		bytes_to_write=$(( "${md_sysfs_atomic_unit_min_bytes}" - "${md_sysfs_logical_block_size}" ))
-		test_desc="TEST 11 RAID $raid_level - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
-		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
-		if [ "$bytes_to_write" = 0 ]
-		then
-			echo "$test_desc - pass"
-		else
-			bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
-			if [ "$bytes_written" = "" ]
-			then
-				echo "$test_desc - pass"
-			else
-				echo "$test_desc - fail $bytes_written - $bytes_to_write"
-			fi
-		fi
-
-		mdadm --stop /dev/md/blktests_md  2> /dev/null 1>&2
-
-		if [ "$raid_level" = 0 ] || [ "$raid_level" = 10 ]
-		then
-			md_chunk_size=$(( "$scsi_sysfs_atomic_unit_max_bytes" / 2048))
-
-			if [ "$raid_level" = 0 ]
-			then
-				mdadm --create /dev/md/blktests_md --level=$raid_level \
-					--raid-devices=2 --chunk="${md_chunk_size}"K --force --run \
-					/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
-			else
-				mdadm --create /dev/md/blktests_md --level=$raid_level \
-					--raid-devices=4 --chunk="${md_chunk_size}"K --force --run \
-					/dev/"${scsi_0}" /dev/"${scsi_1}" \
-					/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
-			fi
-
-			md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
-			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
-			md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
-			md_chunk_size_bytes=$(( "$md_chunk_size" * 1024))
-			test_desc="TEST 12 RAID $raid_level - Verify chunk size "
-			if [ "$md_chunk_size_bytes" -le "$md_sysfs_atomic_unit_max_bytes" ] && \
-				(( md_sysfs_atomic_unit_max_bytes % md_chunk_size_bytes == 0 ))
-			then
-				echo "$test_desc - pass"
-			else
-				echo "$test_desc - fail $md_chunk_size_bytes - $md_sysfs_atomic_unit_max_bytes"
-			fi
-
-			mdadm --quiet --stop /dev/md/blktests_md
-		fi
-	done
+	_md_atomics_test "${SCSI_DEBUG_DEVICES[0]}" "${SCSI_DEBUG_DEVICES[1]}" \
+			"${SCSI_DEBUG_DEVICES[2]}" "${SCSI_DEBUG_DEVICES[3]}"
 
 	_exit_scsi_debug
 
diff --git a/tests/md/002.out b/tests/md/002.out
index 6b0a431..cd34e38 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -1,43 +1,119 @@
 Running md/002
-TEST 1 RAID 0 - Verify md sysfs atomic attributes matches scsi - pass
-TEST 2 RAID 0 - Verify sysfs atomic attributes - pass
-TEST 3 RAID 0 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
-TEST 4 RAID 0 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
-TEST 5 RAID 0 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
-TEST 6 RAID 0 - check statx stx_atomic_write_unit_min - pass
-TEST 7 RAID 0 - check statx stx_atomic_write_unit_max - pass
-TEST 8 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 9 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
-TEST 10 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 11 RAID 0 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
-TEST 12 RAID 0 - Verify chunk size  - pass
-TEST 1 RAID 1 - Verify md sysfs atomic attributes matches scsi - pass
-TEST 2 RAID 1 - Verify sysfs atomic attributes - pass
-TEST 3 RAID 1 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
-TEST 4 RAID 1 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
-TEST 5 RAID 1 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
-TEST 6 RAID 1 - check statx stx_atomic_write_unit_min - pass
-TEST 7 RAID 1 - check statx stx_atomic_write_unit_max - pass
-TEST 8 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 9 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
-TEST 10 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 11 RAID 1 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
-TEST 1 RAID 10 - Verify md sysfs atomic attributes matches scsi - pass
-TEST 2 RAID 10 - Verify sysfs atomic attributes - pass
-TEST 3 RAID 10 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
-TEST 4 RAID 10 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
-TEST 5 RAID 10 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
-TEST 6 RAID 10 - check statx stx_atomic_write_unit_min - pass
-TEST 7 RAID 10 - check statx stx_atomic_write_unit_max - pass
-TEST 8 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 9 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
-TEST 10 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 11 RAID 10 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
-TEST 12 RAID 10 - Verify chunk size  - pass
+TEST 1 raid0 step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 1 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid0 step 2 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 2 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 2 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 2 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 2 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 2 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 2 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 2 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid0 step 3 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 3 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 3 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 3 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 3 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 3 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 3 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 3 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid0 step 4 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 4 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 4 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 4 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 4 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 4 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 4 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid1 step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid1 step 1 - Verify sysfs atomic attributes - pass
+TEST 3 raid1 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid1 step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid1 step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid1 step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid1 step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid1 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid1 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid1 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid1 step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 1 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 2 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 2 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 2 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 2 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 2 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 2 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 2 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 2 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 3 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 3 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 3 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 3 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 3 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 3 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 3 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 3 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 4 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 4 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 4 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 4 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 4 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 4 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 4 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 Test complete
-- 
2.43.5

