Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B529537E9
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671072; cv=fail; b=p+gc0qDS694oIJxRRC2ywoaSETllTdUH1eHRflWqFAQYKu8EOscjtxsNO0R+T8wYlfWsQy23lQTOWtjo6uNOiRmFjQJKtaDiZntv0LVY28017XEeVCLTclPAcHe8K9W0V5U4OqP89C2iTXflZSc3DciROZCkByWJ+TvneAbTkIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671072; c=relaxed/simple;
	bh=tbuV8YlQ4xu1/K6CbNL9S7iXA3ueLDWcSoKCfD7B9BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BE5Mvp4SnibjzBrJFqxrybfyE7GYt5u1WZt8lJf/4JFPy9/rv08GE1pFhsUPu8QGPMFiQrfL3z8NGZZKVQfVpxBe4rdLP8io/wfpHYEs9zCjgC9Rl1gxeg6WdJLYzJvfXiYfnmeA1MFMFrnJOQS9vrMerpArKG2OVcRnEXkhhn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UqyA38We; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gpqARQbP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UqyA38We";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gpqARQbP"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uRRq016819;
	Fri, 12 Sep 2025 09:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tqoOTsZz+hZJKCkM5Y7ufvee9SOxaM8lh6qUmGDoAvA=; b=
	UqyA38WeufwK4bqaI+H/gw/++XljtDzrjdG5LR99Mkl9Q4FR3TCmBrVf94qWW6hC
	mCNNXVi3qsFNdsKTW++gYvLEtvd4XPxCbcJVGNeBvJF7yv3dal1LxlsOf9yKBdad
	uMoNwn/FTkooAAxUsTbz4CkSpa81j7KPKxIyhWIbfmzE8OhtH1fuGjKddAYfcQ7S
	yWlCfpxTcAMpLVGs2TcgzN2A6hFN162UUVKAD9sehcT7hJhzNvMyLweavcGGh+aA
	1jHpA7nmFdsZCWO94f+PKFLN7o7i9E6dV5IKVh7h7Svi1xemxlTLDkIjRMro2I1I
	qa4U4s/eRd++BMBxRZaU3g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922967yja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:57:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9FaGd012871;
	Fri, 12 Sep 2025 09:57:44 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddudcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfS07U0Yv9uSsoMcuYmnGKnEyAroICWAXfyxvq1UCc48HhDtjxt/7tUEjTYOqPSbCkssT1O/mCvi8Vg9FqkGsd7qp8XrCk728WW1XZSCZ3lGpHQyIHMWEz2viO0G3t5JPC0P/9T2nJIcR34me6o6Q/2sbVCv53MbZuZTUujJNzjdpqNZ5HqJBc5pn2hDKmnhXKcLtdxLWncR+40T7yrMDXiiKIkDhZ3Oen0PNmsssxpY3xsxI00seFrSeOFh3C89G7E13UsO4Flk0NYp9nHqUDgphUqsGMSWZpICVgDxEtP9R2nvKwVD0/2D7MHaw+iv8n/KShUJmzXO77kpaUYoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqoOTsZz+hZJKCkM5Y7ufvee9SOxaM8lh6qUmGDoAvA=;
 b=h4tcIDCxrgCnfFUWDqhTrqza7mxkDrmmOpX+v/RO9et8uHAOplNPvwogFI3AxEsaxRnsC8ixl5k+pBetzbCpBk5CfRSIdkxqoB+G22r7bO7auOSte6J2GXoBL2NnUiacNsMnUgwaJRiOl1aliJbN5rd4ZkUY/wFb7yUny9Yy6ENjcAA2cy197A6qVogUwsd9ySn0gAtg1e9VlwmYSEd3htdW1WjoVUnIX9QfWGgNSQIj4QXBknibIwJQ7Em7bgqmsw1il9XFKaR4i8c+ButcOLuIR+Kk5JzXUB939eJALXG5co85OajIjKr83aInE9osm8GMr1Z12ZznuuYV5qz62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqoOTsZz+hZJKCkM5Y7ufvee9SOxaM8lh6qUmGDoAvA=;
 b=gpqARQbP8OIrBqaJJfrNYw/M16X3CgRAvQkyA/jrISrvTAXXcNF71JywaVIi+imzSNClzSl9oMkqbUMyV43GqpUEkSVE0MexsAGO5jTuo/ylNi1kTfimGpRRS9PDb/LZrjcJmDg48CEk0Mkt/gbq5HyhOUEdn5229QD7BQV1eJM=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:41 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 1/7] common/rc: add _min()
Date: Fri, 12 Sep 2025 09:57:23 +0000
Message-ID: <20250912095729.2281934-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0047.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6814c72b-bb4d-4b69-22fd-08ddf1e2d028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vveLYvl3GwdPM1YYCUp/dhzLjHkRDg2abK9SeI1QkcZSlYOqFy6s+AS9zrJw?=
 =?us-ascii?Q?9EcZvlwcit+tb/vqCWBWTOd4Qijdh3gUd0mIySgedJwH9w+m25o7Zus1kh30?=
 =?us-ascii?Q?VGZft6zUWJNBF31aAP3t3V/IxtlLye5GVFTfjyStk7qE+B0sHARnW3KQjUcP?=
 =?us-ascii?Q?ehO9okKK1CkUEV7BUtR/v6FeaWLwHTcGICuICynU7c7PiEGX9FPrNmcNFBH1?=
 =?us-ascii?Q?N7R6eMokh2tZmFnedCVClS+Li7cIeOQq11wrSgcLRqx/3cIjoYSQjUQWNPNH?=
 =?us-ascii?Q?Fe8GJAtb8Gdv+OjGX9b9Tq/f3zSdqiydSAoI1sjZfNk8BwuNbtmYKmfTSaUd?=
 =?us-ascii?Q?qihLyo68ojHhcoFeBce60aO9xOYej/hlywnVg1GiBFpIP9fFHv6kPgxizhAy?=
 =?us-ascii?Q?O6hwRiaUMB65+z+wnO7KiqrcbX2F9RbVVs1+ABs+tKuVfmjpSum1Cn+SOm5i?=
 =?us-ascii?Q?LG4b1bNP6wzqpTO+ShKv9J2hfltu5CWTup8aJRO4LltUC/vF4BtwWiQTrMYO?=
 =?us-ascii?Q?9nLBaZ3kjboWT2rwdana78J01UAE77a9JWgCGq6QI76M0V+ws0BVo59WU+dE?=
 =?us-ascii?Q?HxrHQJDZtszWC+cl0bmifDK62unMW4iII51raZwFxqSkLYx0DmGRUPcONLPi?=
 =?us-ascii?Q?W2A+4q8qYxVtkbFJFPYtPVhgaoTy4wYLEn7G7vV8o7uGSUPC+j/ikik1IahM?=
 =?us-ascii?Q?g4VjD2jpMUlYWWrmY3rHdpzge98D9W2Y5qG3jirMHThFzbMtdzzeuYA8r9g7?=
 =?us-ascii?Q?XJzQwKEE71NPkxEOwMYaX4glL26oZp5Uzkxiukb6PAMFlvYJCkvbw7GCtVqv?=
 =?us-ascii?Q?dBkoFYnDVT166qKPkjJ63bR+N3iqIibg90sVvJ/Ad4sTayoq/87fLUQ23plu?=
 =?us-ascii?Q?2mWlbNkpHJCmD1KgF3FP/zp1mt2ikrcNMGEN6FwCApTULrQKA5idffgKcoyS?=
 =?us-ascii?Q?4ASGJZ/iaD1z1jWVYVJkRgY+PU9hl8eG/wbS8moojTcxnajUQ8OXmNlJwI+3?=
 =?us-ascii?Q?NXqo7F05cnQRH47n4N7+MYsFNpsKEWfdU1vuIDXlXBXHhqjc6GIa6cUNpF4k?=
 =?us-ascii?Q?OZBWfXSH8M42tlF7nWrWKLeI3dmlaPfxmixWPT+30620PJTRr/WkMt/otx8E?=
 =?us-ascii?Q?fD165mw4b5B5wJCKbjkU8YOTE88Wj4ceYRUo+axMupLXWJaOg3gbRdV5JHvF?=
 =?us-ascii?Q?sGDvhMbZCHSiIbtjgh9HI3cavy2tK+AQMazhSsAqpDfWx+o6kaZoshj+mqYq?=
 =?us-ascii?Q?GaY6e+bJGJNoKhcXD00Y4dsqfVEP7ZOle4RxLFpAACsXwwnwQbJZiLoOv2DE?=
 =?us-ascii?Q?OCBje4b+AFT6/+nolchTxStmw2WFTc+VuUjDrtyErwdrRrxo1Y8OIhsHurBf?=
 =?us-ascii?Q?7s3p3V14/2lXv0O9f2K/5qT3q1Ny?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+9s1UiJb9euJ+l+/2uBdc3IjwTeb61d1pDGiOteWnWhuRnOR6DO7toKwP4Q?=
 =?us-ascii?Q?n79I+FBPB4GwmXm5OKHYEY8/9xRTS3Dj8KwWwmUTynDzrWqTb//j4X9rWyFw?=
 =?us-ascii?Q?GZ36wR2oPWurbbbxUa8sXaUHiR8Kme0fYhKUp+h9JCvs8bGzYNdVhsy8pqSs?=
 =?us-ascii?Q?wg1BTpEedOhYskiDT0SFWVDbslwiu7qWgz/WDgX4Q12Vh834UAjwRaeS+Ogf?=
 =?us-ascii?Q?Do6KdLLwCI68dOwG/pCwVM0lfEutrRqbeL0f1G9rmhfKMb9kwaOFlkziPqIv?=
 =?us-ascii?Q?BEBbKrL5gxi+fBqbNmPCQ5Vd1Bxc+K+J6/XC3hp1GhxwcfdrxA5TqTDJCfo5?=
 =?us-ascii?Q?1PMreo7z9pgVkPWbM0/8xC66J+FVJ6UhIz+z1xD+8XuSq19+0gSba48e6ul8?=
 =?us-ascii?Q?4TOonEQmXWiXE4JBEZhFJcckteeYX7ub73x6D3MGleMFZlESIs5E5N6AMESQ?=
 =?us-ascii?Q?gYPuyh0wFYd/TZY1VLJQ4+D30T2lT4UWLe/dbq/Z67W4iX3EzoeT8aouX0cR?=
 =?us-ascii?Q?n8TpppzKq1DGyhU2PphVY14NXm9BXivYXZl/kih19sEBzv7XfjRsxSQAXOUk?=
 =?us-ascii?Q?G0QkktwYafEB/lHts/6vnQpVYywBJNUiyrbOTL1iC0y4NQLJGIl1KvJADZ/a?=
 =?us-ascii?Q?ccDo1wNzFv8c3evcr9gVl2xpFhd7jYkKsX9apqYsB8Fzex9tTY3AN7AUqWXT?=
 =?us-ascii?Q?8CT5oR2gTfiX8mOt2croQhYx+fOsKwur+8JrXIcoGQYTO+0+YHF6fg/kZyb3?=
 =?us-ascii?Q?/hIJfQvhEiYlgjp/NBIQV5A4UlM88gZkNuocHudAbz3rbSZtgu/BKF6s3fqB?=
 =?us-ascii?Q?fQoubtF87IlbMDWiPMlbC9opvgb4y2ZRb+wcvqersixfmOMIEozkF9BQr6Dr?=
 =?us-ascii?Q?W9jB0Zo18iK4Ae2/gwLVu8k5fS108OH0hQfwGUJjwuI9GAuo3rlEFbnKlQOO?=
 =?us-ascii?Q?vDcqX/bbAkLeKAo4Ob+kjb2yDDG3FkKRcAm7N7A77uI6ZvS+tIjJkJ3CSyaQ?=
 =?us-ascii?Q?X4840U2tzIRBHNrHlSlmcz7Eg/55TvGXkNg6AOvGm5NsAjsUVcwlGPKuDidE?=
 =?us-ascii?Q?O3FJcugfUdJEtpHb0ZaPLD2qo5LQ4GcZqEbePeN/Qra3a1SQxGSKnjD+6oG7?=
 =?us-ascii?Q?TbsxZ1MahSbznv6AhK9bWaXulR5RjYVHlUUxXuTp60QT4RE78a34kLLtqNiN?=
 =?us-ascii?Q?2FKvbnHyf62N2B6TQlk3ZRl1Rzfz+OGd7TwyxJlVhyXrX6Uzs53Xg+0MDB73?=
 =?us-ascii?Q?WUFnYKEVVu0GkO/be+Irt54HybM/yW84MZ1A3xIu0eV8qeyvb41RlzdFGjlA?=
 =?us-ascii?Q?7RrB2jnubz7loxAAv0ynl5x9yiJqK5wtwtEQH8cTXUu6UFHIELyZm9KhGmLF?=
 =?us-ascii?Q?IHPNCeLr5mpTj+K8H+Jm9XciBlkKKprocR8lpOC+/jzhR51Z+Ui5HRPhiBqD?=
 =?us-ascii?Q?xRoxPLrlyYtOvQe7fvW1AyvTxRFQQPJZZDssgHSk6Wj0P52J8qah2wfsfU16?=
 =?us-ascii?Q?mJvv1aZCKd3lXgopTtVLHKLqUuuEnhESyI1Mn9Prw6ataPk9eMbSAEuvuvN8?=
 =?us-ascii?Q?sKeroG5Pc2a/qfJLNWdvGfnZwFEsRoKaqIC1KdAhf0jdqJJSKgEc4tfguCPv?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	COSJ5SS+mdKPDQjgaS8fK07vegmtjhTfkEy/s49yIY2gSHYNA2iWKirKbJFZgyvrdWtFDsJwyliUL5+0XTVCSHoLBwKU5IJ/LwvpT1ZuKIUMF6bSzncELZiymaPx2qnoDHcVi6wjMZK491TU7bzbx/pWx2zTAbf43An4ZN+dTfqgMvy/+MiYs4dypbXS2dqSVkzCpxtn0vzlN0kFiVx2MGdE2Ucm7jEaCQKFwjciOzf657WI6COsekrJvnRBq+hqQbYRL5dVyzN/+1UuZl4qYjx8hAP9k3fAEcuVHARa9jMbNw8hpbuKAJId2wYdRyx8wbVjBlzH+SBodfX2L5gyuM/QB7DeCrXY8dGswDzOshwNfZaBVdumrrDe1XMW0Jv1ZF90czdV/fyCkPMxgLwBe1bSedG5UZ7/y3BA9O0rk1IS29m/Dh+71DKDK36y223YDEi+jqHRpH6cOSyMvvYqqAhPpw0KCnO0LAZdsI6Di0du6aJxXGdG37//E8N47pPadUeOUqMKPVMtmbAkN0qKscUO0sgpF2RCUOk+E9bODQ+WVs/S6owAeE13Uvmxkv/GVE0+YKJx0wDaZx0ghmf+Y8mHIq8B0E5okCWboPig56o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6814c72b-bb4d-4b69-22fd-08ddf1e2d028
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:41.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE7hjvksOpooyucUoxF2QfWx0PvjXhD0/Sdynh4PKXFlnzRSrDvWZVolbdafaLNGx3VW+5cdXf9+46vLhOTNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120093
X-Proofpoint-GUID: dwUjwwXFveRAhvAzBnYBT8FQjMowXlsH
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c3ee98 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=wDx1mg2EYdB0JXDzLs4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX/10QrK/CF0sF
 SHoOsBvXxgg4D+ripTn9aEmpXwwxfl/JCXxXtcQvBEsqmgtDbNLfDjqtVXwLoHFQ9+rBKloZBwW
 3GSdm/o+8j/et6WhfA6VODHRGtlkNhMuIhyWdhzZa6xG608ly5PWwakGqqT4WL4Q43ruq05YQpt
 VZNkILcrwK+m4LIPgpmOtA/6MBAjH8zrPLg9ELoyD7CwHOqfErICJcVhreNWML+O1mcL02TjiTS
 zn0QrWb+ymB46vloSqGSy1dWTabEzEroopreyOBJZBgnnc9ZKzF2y8NlNOJhgCDYB/GF1H4bc6Q
 9As1qYP+lQ0DSi1jErxPM1pPefJpT9J0jr1+4fmjE8EJCUUYx36fpee1PPazFWx9saMajMyXTC8
 7SyGlBYs
X-Proofpoint-ORIG-GUID: dwUjwwXFveRAhvAzBnYBT8FQjMowXlsH

Add a helper to find the minimum of two numbers.

A similar helper is being added in xfstests:
https://lore.kernel.org/linux-xfs/cover.1755849134.git.ojaswin@linux.ibm.com/T/#m962683d8115979e57342d2644660230ee978c803

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 common/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/rc b/common/rc
index 946dee1..77a0f45 100644
--- a/common/rc
+++ b/common/rc
@@ -700,3 +700,14 @@ _real_dev()
 	fi
 	echo "$dev"
 }
+
+_min() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( $arg < $ret )); then
+			ret="$arg"
+		fi
+	done
+	echo $ret
+}
\ No newline at end of file
-- 
2.43.5

