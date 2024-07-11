Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA641509AE
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686252; cv=fail; b=IPx+aAoKUH64g5t8F5lWiFNtrn0yrgOevUgko66DzlNqB4KnLDYeCAnwLtZHYxJy5crgxiGUzI+OgOeoc+W00nGfGSg6ihkJ9eWEqSa9xtrSN78ofdUxQ4MGG0/xj5Xg4DyyJFQMYWnp0q4bxviuVWBTRJj2FJas5tuWp24K9/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686252; c=relaxed/simple;
	bh=Aquu7l3Hy94ZtQ9quHFD31h0L7p0RnLMaky4aZ9EAHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7LctZoPGFSTnlFnRcxMsLyGTlTfxUMa5U+Ppp2WyOYofO2OdqPXCpoKvO+0SclYArdOqHhPKCtLH8fVrqRqQ7wNHyAecm7SzV1ZVHE6dp9fFbzcYuLPd/m305mHogk7T2BACkuCuQnqWGmi8voGZn4hYr6L4Uvs48xGKHzsHzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JhUiJYM5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w/oIac9/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhUiJYM5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w/oIac9/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tXut026816;
	Thu, 11 Jul 2024 08:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cAHN189/YfDwmOQB1w75AVuZRKBznp+zHfWm2ncNEaI=; b=
	JhUiJYM5fIUn8FKPB53ksHemrnIQHy6f2p+6tbWwHdxZFzWLSCG2LWzbSHQ4/RAo
	Uv2xWZD6L1gq4KhYe7Pf+FytlUr0ieq7w6ntUyCRhG4c8XFUKZO5POpdM7tMA5eW
	6Tb7MTlM0/oT/4awI5TJv/xF+aAV25xT6NjsWEfo8eg3UT2uEE61bgxenyvWn+t9
	Xvv88pnH5AHWftE55EalBMSj8quajBJ0DNjTTnmP1DdaJ3NmfVNMQrDZWC0vrqFe
	3ijBw9hS0n6j8XI8yC8qY2fBvEor8n3r1ccw5XA8H/BDnPfwalXGS9S2L0opqfh/
	AD51H58mkfRCYNAlGFHgqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkns2bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B7Gt70022712;
	Thu, 11 Jul 2024 08:24:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv25gxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMDMMnwFdtQ67QpfS/E2SyyI6/MBYrGG9+DMNXc6n78+rKGt6tZSk3NMFWYjdULnqwJDIfSJemprk5bUVPBpHtu+MnSPLA5cEBBrHg6e/D0KzAeJgTy0t9hvqxGpJtffrZp3N33FRbjEPzzOoG3sxQ/xffcCVMAPjcgpaZeUrAahLuGL/jWNOx1pa6/1nKrFXgq3DIQ96yveOABqTpq+Cp3AoauNWyrzIqYzHiHb+epkCmGJ559PPw3s+b44z5Dy6HklMv9XfwdQ1eocFgp3LqifYAZSroDInpJxG8aqBCmaZZuRJzP6k8+XKA5uvdXU5RkScnDW/JHREqXd7YOiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAHN189/YfDwmOQB1w75AVuZRKBznp+zHfWm2ncNEaI=;
 b=XMqVIg/gkDxCCelZ5ZtI4Uz+ERMxCpAjexZ+K0DbeaNtCSKaBorSNcu7X/xURxaO1r9Am6LQcrxN0ObiVPiSpUm/P2hYnpFqQHtHt+5WlLnkdZNH489VgSSGGBHKNo59BEgXt+JEZl8rGasFyFzJwPgEoM3Igf3WF6xjR22vrl38idx97/Y79kVa2LJZgof3cgBgOs2QoKxr886y6rFxjmy+cTA6U+GGTP8WVu1YkYvqmMTkIV7PY2Ahi3XrTUdw6S1L3oRiPrOJS3OlrfJq3FZQs+Tir5FTR4e1juv37OqMlPYmu9CZARv2x3s8IYz0h4m8sKNpr1kMruCJsTTWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAHN189/YfDwmOQB1w75AVuZRKBznp+zHfWm2ncNEaI=;
 b=w/oIac9/H502SL75h+vCLvG9DCsLw5BzKELbwO26ivLf1Y1AcaFk3gn4wK0N2n7QmLX1aaH9HVOfODdglQPLBO31ZbJMXtaR3Ph9it4jR9mCcOCCcBgvK7NModOYVEentdDkz2ph1cN0sxkJ0xYt42v4H4Bh3/mgE63RhYcWYZc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/12] block: Catch possible entries missing from hctx_flag_name[]
Date: Thu, 11 Jul 2024 08:23:32 +0000
Message-Id: <20240711082339.1155658-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 781ff115-b0d2-48c1-86c4-08dca182d26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0fX7pYfsVd7yT9hkjORL3bEzBuAatJGeNjWMKphy9bO0aG3EY8fg5ky8+BpI?=
 =?us-ascii?Q?GBtxtecMjPJMTAX3iP4cAbDamQ3F4+FS8Mj1Ejbw236nZPPdPXvNN1yGu8xY?=
 =?us-ascii?Q?in0F5lZ9ruoMpqK5T5o0VK+SeH6XZ+wY2DmYzTdtU++UOwPQ6xlPNhTwMhcR?=
 =?us-ascii?Q?Ga2Tqin0FCky2BMWnmnEGrdTfeXuflnApv7yePhZnhlEB2lq1HH1u8xtPOn/?=
 =?us-ascii?Q?P1nHco3qjPIcXa7nUj7d+xDa+gx+TQed7qLhYQ0LxqmelHXcIoDS/NGCKhCo?=
 =?us-ascii?Q?w4w2IheZXUeGu9nhyUZJpYWpEe7j2aWvnmR+cQJp0oEgO3QFWG2uSaRzwnvR?=
 =?us-ascii?Q?hi9J8UU9+C7qlBreCg47wk7un92IhSCUo0SSZ9wl8k1SMzINdXsWv/SwVWiT?=
 =?us-ascii?Q?R1L7unYMQ4ZE9CHPPh0woaSEsTQowTTB4s21T1U4G8SoMXdaDL1dj/ZB7UtD?=
 =?us-ascii?Q?f65HUf4crtiLOoTlfs2V25IrwXWRIA5WVEmoGaX/+SoZrtc6Pd7QlBFnLsMV?=
 =?us-ascii?Q?UhNezkQZ9nppau2EuHup37FTGhTqh8hb7cbnmLh+cMPAUR4KMuQrkTxa5jT6?=
 =?us-ascii?Q?cbJK+sFjPTvFq2VqNJhOlVxt011ztJMWoLSHIms8Z7LXaWIfWl1Auh9NzGbx?=
 =?us-ascii?Q?y6rCow/FFOIzmf5QzjRugL1i8Qmh5DbAfAQO7rikokwcibzZRwTK5BR1ItOS?=
 =?us-ascii?Q?gKMvmoFcz7Fuwr8kjl+NfunizLVuT/5Ubuzul7imEC/an4+SYTwxWZoHC1ni?=
 =?us-ascii?Q?PgqsmaawIU9VdzBEnvmsuNUEkS/LHtQ2T0g2igDIkef3h2YWrUGpt6342eps?=
 =?us-ascii?Q?zZCsYjfjAo7zHs1HX18/6eQkv2LMqaIYjWnoTrMCNwcM38ievPYjC5mwrhIm?=
 =?us-ascii?Q?bgsoDSjiB8Mtn1OXdP26FDFL4nbx0fO7ZDJC0rMaBaWd5UWtSTIZuI0s98Do?=
 =?us-ascii?Q?GEeOoNc33xbv7O9fsnpZsaTarf34XAOXwnAchh47z8M7Bwbh+XdtBxAsDjiY?=
 =?us-ascii?Q?7F734q2T6af+9rAE3iLZ8SFtRN6DdMIYdoOyrIQFn7ZJ+zYMgMgxSRmn+3Sc?=
 =?us-ascii?Q?zBBrCHFnVBRkc+ey23hE79tTaM/eKQsECgvW72Jbl/NvSKnKiBcGxrLJ6nfr?=
 =?us-ascii?Q?lTBlT9bIwuYER9TpyqO9BQEhqT280nBEvuvvDwpAQZ+HrEetAJvhO2XtPRAc?=
 =?us-ascii?Q?CT36w81h47ylyOfEYC04evneLEUtOkQiTifdtR27BR+4fhHC0U+xB3RVsogG?=
 =?us-ascii?Q?tAFyRhADgEb+A6PUKx1HFHBsA8hff0/c7egI3juo1PAArK14n2jUfxzHpq5G?=
 =?us-ascii?Q?cGAXsYFFDdsEFjJTGe2YQe76dOCFsoJ8+EgcD5FvZXh/3A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3VbE1GuOefGBN9fuholdv0wzxES7dcnC3X6MyBQ2Zl2pSRthlzjq1wcutbPm?=
 =?us-ascii?Q?jIJO3fZX4vHoQX69HDJNHwBR0o2KNjLFwJYDVWkJ7Zuu0otM06D2XoubCDjd?=
 =?us-ascii?Q?Sfy3brE6I3uxyASKAaN236yMHwrUSIpmJQzv0Tix1jlukTFaGXt0H/AMk7eU?=
 =?us-ascii?Q?BHMAFhbcJwyhvF8V5XtlMi+2CjmQ4qqxpKz4NoZUgPq3rvWcIy3oKYNO/SYp?=
 =?us-ascii?Q?XT7I/mq+3G1TmBBxHPTwh5MV8WIf3HlRw3BzP3lj2QcUb2CIdL/IPWEaJhhn?=
 =?us-ascii?Q?pcMBpHZ1uJCdgZl3FuAPmECLNHFeDZuEVSj8MkST8yoJI5csGO287/ych9Fe?=
 =?us-ascii?Q?kCHcyM7Y3DYbxE9tTf1hjFFDUYAXfkXx419pBzaex68v1YuG4vvfJNcKfRe+?=
 =?us-ascii?Q?xGGV7ujJt/KjU+kwjme5T23skwcJZIrU608cy2BjrjeVkCshMM9LigFAKGss?=
 =?us-ascii?Q?Ss/Uk6NU/TpfZy2rZWkADOdSVBGLxL51/EK9KVtxPr12jak7oiR+5ALcj6pZ?=
 =?us-ascii?Q?ooMaiyaPJ9xF2KjzLAQ5RvRe4neK8/usDEBVyl6LwJ1gQwU6gwUSkeXrhtE7?=
 =?us-ascii?Q?dynEO9EmWT08IK9WDpkVbCze41KMVPPsiSpFbkeFtDx4/ChfKnF5vcYqfOeB?=
 =?us-ascii?Q?/a2B+pnlHXprJMBwOF81nKhYv0EFU3Z3Obn0BQGwkvXzAGHb1fMNANSeaDGI?=
 =?us-ascii?Q?wW08E8d99KidnzOpuiKF6Fx+a+gK1tUyuzSUv/5dFWHH6YTTJ4gKrQt65ou7?=
 =?us-ascii?Q?MqjSsm4CumRzNWISyDpAfUh1lTyGoNICIEW9/HclWhweMwuv22MTpkZ7pozq?=
 =?us-ascii?Q?Q2UUNtw3V+Qi29Sc8IBGGgxScLci2ccK1zzjuMzTXVfRtDHLT2g9O0w+tROF?=
 =?us-ascii?Q?l50vIrYfjsoJJMJYzH++pDYIcfKzz6V9qrg2cu529cOiczqOqKNnk46MtMWY?=
 =?us-ascii?Q?8iWHFPQ89yYzTbwjgf4tXkjtbryKpgBcly9F2zlVOI1nJruold/FS/+g/E4F?=
 =?us-ascii?Q?eQTnNfkEFFHmxUH2Pb38eOftYInHFDD1/pqAqhUFMuKlhcIGqLsFbAdSraWZ?=
 =?us-ascii?Q?KCoYl6C57Pk8oTqtId5jFO6LflrgIfj5O2F0D3PpZf8H5gFT4VzmmB1o7/3b?=
 =?us-ascii?Q?bfpQTn2Swu+2n67dlkeLOWo1a/QkSysCqLHTp5xuygxi2ZMwQnNO7NJRr/jD?=
 =?us-ascii?Q?hiRWdAWmY7vYfOugQjU6/1hq7EhdVcwUQx1w4pTU5RM0/SlGxH2C/JQk7fnb?=
 =?us-ascii?Q?CW6LWkEkOdGdI8zNMFNLvs/gg2ZOXykb+EvN4Q0nxsyYWladYARQ48uQvuqU?=
 =?us-ascii?Q?/ihHBFMg/1KGgQOCw1kzCLUFqNStqH+K6LAN8MtWLXDGLuydxxN5DJa2itl4?=
 =?us-ascii?Q?PDdP7awKFyVlmsgzBR5FZKHN3yaEJwxn+jCqsnIhfjk4qsWtQQ0aQaMXxa1a?=
 =?us-ascii?Q?QLDYoyG8Iqpz3ZYxjY6BMTAxRkNVuQ6uDX9SxPT1sE0u6WwLwPDRu67XrA9M?=
 =?us-ascii?Q?0ru+iycirtQsuYAMAO4NqTQRT0sIFqhCzCbDicVdAYDemNQp0CQZDcW8yREy?=
 =?us-ascii?Q?7lTPDYeBakKNPfhM4w3fW3znh/rWO5lqd11gZLUWrL9goZYEOiGh4I8QMt5Q?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TS/Ef7dyJJ9UdFn2ZbNisCt4TvsaN46mPDgYOR2alDLETZVbm04g3zH69Xa+/AwZ366cpX0q/PEneSpqPZIYD5/YaFS05KFihnA2qSmRMxv+p/p1od63zlWc8rlcIKXl0CCdy99P2NWifDQcIh0qsu+NV+KN4IL2V8Jr+qf/RCHu/hS5E5KnFN9IIyhcI3wYsrAE2yIs/JCG4aiIHXEkZqEyDzVD8UYsHVAUaxNxwtxcVFO7g3IKa/M+zu7o2B5UZRtfdj0Kb7rx5DCH8LWB70+81UojD0t9x+9t6BtcLYHY+COzU9hmcWayHvul8pq1/kOskmxjY+I9U2FR11LSf42mSu/yqiCBrnLSOuLSEWopusPmYC/k+bomZj4h0teFvAwgO86t5eNdDLRCMmd5AptRQ4kCqaLJNTN0S5igw24iksbul1Cy2075AM5+FtBBowBwK9x16I3Z49oIFihKFb3nZzIXvCkGXM29jMOJxOvFvFIGzgNAtgPtuueoSl0sy87WcG17j4Xo8zsm2VMIUZN+63hlaUZsyqbh78n+M5BYugi2ddVcpIzYsoPpDZFsg+grGV3vGzGNwgmnHK8xc9c1PcV0aJWAUKkYZ6ZHDUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781ff115-b0d2-48c1-86c4-08dca182d26e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:02.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8j81NQawEY1fSM5Mlb39Wp9q6QtI2NE7qLugHr83RVeB0VpYmZh4yGURr8jMqISX55aBCUgsZYU8F99eW/7Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: n1Fjcj_pjSsI1zp2oh2AVj22fFcc7pHt
X-Proofpoint-ORIG-GUID: n1Fjcj_pjSsI1zp2oh2AVj22fFcc7pHt

Refresh values BLK_MQ_F_x enum, and then re-arrange members in
hctx_flag_name[] to match that enum.

An entry for NO_SCHED_BY_DEFAULT is missing, so add one.

Finally add a BUILD_BUG_ON() call to ensure that we are not missing entries
in hctx_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c |  8 ++++++--
 include/linux/blk-mq.h | 10 ++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index fca8b82464b4..b9bf4b25b267 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -183,10 +183,11 @@ static const char *const alloc_policy_name[] = {
 static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(SHOULD_MERGE),
 	HCTX_FLAG_NAME(TAG_QUEUE_SHARED),
-	HCTX_FLAG_NAME(BLOCKING),
-	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
 	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
+	HCTX_FLAG_NAME(BLOCKING),
+	HCTX_FLAG_NAME(NO_SCHED),
+	HCTX_FLAG_NAME(NO_SCHED_BY_DEFAULT),
 };
 #undef HCTX_FLAG_NAME
 
@@ -195,6 +196,9 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
 
+	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) !=
+			BLK_MQ_F_ALLOC_POLICY_START_BIT);
+
 	seq_puts(m, "alloc_policy=");
 	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
 	    alloc_policy_name[alloc_policy])
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 225e51698470..6a41d5097dd8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -644,6 +644,7 @@ struct blk_mq_ops {
 #endif
 };
 
+/* Keep hctx_flag_name[] in sync with the definitions below */
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,
@@ -653,15 +654,16 @@ enum {
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
-	BLK_MQ_F_BLOCKING	= 1 << 5,
+	BLK_MQ_F_BLOCKING	= 1 << 4,
 	/* Do not allow an I/O scheduler to be configured. */
-	BLK_MQ_F_NO_SCHED	= 1 << 6,
+	BLK_MQ_F_NO_SCHED	= 1 << 5,
+
 	/*
 	 * Select 'none' during queue registration in case of a single hwq
 	 * or shared hwqs instead of 'mq-deadline'.
 	 */
-	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 7,
-	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
+	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
+	BLK_MQ_F_ALLOC_POLICY_START_BIT = 7,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
 	/* Keep hctx_state_name[] in sync with the definitions below */
-- 
2.31.1

