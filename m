Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C924A046
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476774; cv=fail; b=OBFLdmqFeDqFzC7Vuvreceg0bydq0ud8zRpGlxoMsWVh0BfEb7aG7lfjTARbzcnFyJ9x0oZicsjje73iXJL592KX9OlL0k+izp3cEyT06fXKnRuoJPM/n7hQIfU+q21bh/P3eOfM0/Vp6jZxW15U4Z17GVNMx9A5p5oiPS50tzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476774; c=relaxed/simple;
	bh=iADdxKgbZntye94/HY4+Bmv64znkCAgiLg+RyeyAwao=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=pnn0+69ShaBqQylQ3iJQyvv1oiLUwci8zm4T1+zdKx1ICab49bCwhpI1xwNMzSwoeqyOCM4Q19iHDfulQXZ7aY2EQA6E3ZbZ03Xm47g82Dz1tjiYdr9EIfw8cAyePuZpw9eYvl+tZIaI1Zh+atIZLCyJihxFJXfFASCapJHGOeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YcYisduD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tJlp5JuW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YcYisduD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tJlp5JuW"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfL0c019482;
	Tue, 14 Oct 2025 21:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ycrnlq89KRPKIzZ88E
	+SQy4DyrKsJCC5tvnVjMj1jpI=; b=YcYisduDq7ZCcS4n562YJbgtzSzm7mV7Fn
	oFIox8MqT/nffiKEF113rw4ceJMatbPKddu0OvG+RTJPZno5+m0puJnpscYtM70Z
	i8bQh+gUbH3l3EgyUv7eK6NMokdbRQILEEuv2l0HHxSXbyydaa0BYLLLQVs8hUFg
	504BZ0Pwp2ijshbY3I6PW4hIyvH5QV+wJxiTKOWQvEbBgi1mLULhv2Yko2oeaYYo
	2lZs4KJEmAuw1mghZy0eJJh7RJ5WjPruZ7jPGcMdxZ5KjzNmScJxngFaeQr8WW+R
	1wIFZNd7HZyNmIzqzIOrEik8N4P8CKMvD/BZQpeN4L7IKqebfF3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bwcr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 21:19:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKskgm018002;
	Tue, 14 Oct 2025 21:19:22 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp98wq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 21:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzRSDJUOrgVa76JWRBewuIVoBCvsgSc3cjttMn40aqRJDL4tYOHpFzK5ZruNc5rydi2IfInYbwcdIYX8+YmcZRi0ni24I9KHtNUtyX1g254vhlgMwLQaY3Pgz0enNVZGXyavbXWQIcPVM8Q19KGjBHiXQl9MytUZG5cQfInqgYjUWZUaMcO520BWWouCQlkbqJPTenqiYK5sOOYMEbb7rKa2xAZ2H2vwT8hzJiU7IOHJOCVf2P/yqX5SDV32fDQqANEvZ/JCwiHthznrnPtL23jVXkWENji4qEoDGIuanQvUDfVOTOaXp23cC9S9Xg65FYs0qoi1R1ntD03Ok2hwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycrnlq89KRPKIzZ88E+SQy4DyrKsJCC5tvnVjMj1jpI=;
 b=isOTo+EsalMIGt41ESuhRwxAGEawzsTY23LDhNLvWTtBs43SlsgPJq3HNI65momr1+qCHouj8ErxuaD6jdaXXkFoSlpu5CO+jFUjPTvY9ntyav1kKCdgnF0RKFg4hSLCfz8kKibrzYjJVXF4hqQMpqbLI8BVRMqP6CnNT15HhR5gGxZZew+mESqin8rK2X53f7TXVsZ+FqpxfW/ZWRZBROY/RrOfujRmLGSomecp+AW3i6Gf7HQsEwcE3BRBUPcD8lWAKbt1WVVfmZKsGkF0KDoytd0OL7N4IAAbl8ex9qJbdiQZ2f7OlTzQ0OZ24np+MEE0Jn/l7bu/lqKi8l8UcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycrnlq89KRPKIzZ88E+SQy4DyrKsJCC5tvnVjMj1jpI=;
 b=tJlp5JuW7+kEEvZ0+XttAYkkuNE+eDnEPQw7mGzgubAxVV5eYLI8lqgCsIfeCXeVHvWhPPjaVPNbPiTZA4sS479kJCWffdpXddBHRVqs0NvypLNmOSYJkMafhnsbSkiFMv6tE+dz+McqLNBda17d7a5F9s/8L93w4ZHbvyUSexo=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM4PR10MB6791.namprd10.prod.outlook.com (2603:10b6:8:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 21:19:19 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 21:19:19 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv5 2/2] nvme: remove virtual boundary for sgl capable
 devices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251014150456.2219261-3-kbusch@meta.com> (Keith Busch's message
	of "Tue, 14 Oct 2025 08:04:56 -0700")
Organization: Oracle Corporation
Message-ID: <yq1347lchd0.fsf@ca-mkp.ca.oracle.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
	<20251014150456.2219261-3-kbusch@meta.com>
Date: Tue, 14 Oct 2025 17:19:17 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::18) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM4PR10MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d506e7f-0445-4d42-154d-08de0b675637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q0CgvvTf0cik+zm4e9kTKowpEgxK6bKHVUArFlXH+UxWhWJr4F3Nu7ZpIYKz?=
 =?us-ascii?Q?5e5zWMQ+duEj438/ZYq0Sdzy2LRnjKwRHYH6j8PNktbkDfW4ySnpbQyjcNqh?=
 =?us-ascii?Q?Zit0wgAIAai+rlJVMAn2WJ7BDZb9fNu8ZFXShfydmqFPRbZdQuzfF4TWCzWJ?=
 =?us-ascii?Q?j0SRxC2noQkTta1I9Adz9wTZHC66BdvvBPdTW+sXvOZDtlBtoQL0VXqqU+SY?=
 =?us-ascii?Q?WcSClVugZzpkBUS85TqN6aIyMygsj0v3Af/NLU4mv7hpWs+oErp3nKlJLE89?=
 =?us-ascii?Q?nId8JpzUfpQJg+61NmX5NlxCnaNiT1oTIizOggqJ1ylHQ7d+4+dqFNVdIdFp?=
 =?us-ascii?Q?3Wzd5CP68g7o+wMFxU4O24jrhTtZV7TvQzcD+7HAhsEVrmZ33iBdQlyjdg8p?=
 =?us-ascii?Q?VkbrZbElaUSQbmTK2D1T0KUmMG7sJlvV+CxB5+lQhi/2loM/mvGrYk/GkLuC?=
 =?us-ascii?Q?UvC9nDszpR2cNg99eUk0zmG8Bb1gZLi0lg/d0I/mK7RFwDrl3AeLPNka38Nj?=
 =?us-ascii?Q?rfPp5iocNWtNvGcowxgqnEz5uT9aov5T0+6NbSCOiZ36shx0WezzAt2eDI9Q?=
 =?us-ascii?Q?NrjBB+DRd6EEk4g1zHpgefJ8ScELFTRTbfvjjj429JWWcuPPdsePW0QSfnxM?=
 =?us-ascii?Q?3voiMdb0VrUxSHtDHuhGz6BquJBiS9gW88h0l6F8UBMIWpMDCL7uCH6WB/YK?=
 =?us-ascii?Q?FHDrBM1pmfzSs6nnZVvuhIGa9FAk7EJnsE/P3m+kJnr9zfedgd+ZjEmZTRlP?=
 =?us-ascii?Q?C4D46eZ/o7RXW0dxVpudt5OcT7uLX9XXWKLKRvvPIqmOMEmxFc2MQgQfP8I9?=
 =?us-ascii?Q?EChXXdVxorYIKh+8NwMxlNSQeHJ/1iaHDP2djXFvT34BodivU5RoS86JRTwD?=
 =?us-ascii?Q?ze/X0IXUy+olEfaMAlLIYHimzgedoOpKcTQMqw4qHvFlfFPXMoJfyXlczVJL?=
 =?us-ascii?Q?NXnjTJa36Lza7Dw3U8ANzyK7ADB0Ej95GnWEK88BHwlm7wA8as12LeG4+6pR?=
 =?us-ascii?Q?lt+CvsL9pJL/nHije9E0W0KxQhIZ1JVr9dq8RAUWCHHN+JE81aBEKUGS90QR?=
 =?us-ascii?Q?t+BACmdaCTUqVcxgVDrlT1GPy7UCG9rH6PnGao/0vYkW0mJIJT50DQn/GMrr?=
 =?us-ascii?Q?m6si4GXgHZ7ReSikIs6Tq1uv21cMeOY6boOUtYpASnGI376Z3ohI+y9+sck2?=
 =?us-ascii?Q?Mvc8X1VzHhgcHfgbTDiB5gr5XB/e6kC9qdYNn/vv3X3C3c/1bhShc4Ir56Aq?=
 =?us-ascii?Q?myxpl+I8k6pbDgU2J3157iheVwCPhXcmphmDKrGKGcZ4SW/PUArfEDx4mw+3?=
 =?us-ascii?Q?oLQy75PfwS1Z4F5V2rbZHALblbfNIBPH784JhPqb2TtJ6a7q0pQa67p4v+zz?=
 =?us-ascii?Q?dqmB/VWwEp23VlR24pSJaCN7rmP4LKycR6L6TOvnjuqLGT8ee/c93++OxDY4?=
 =?us-ascii?Q?oalE1HgqEXW1Wba7VSEBIH8sEk9KuCJC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iGkurM3DFDf3LqoNjpN7iOOu0Bu5o4jTUQ6Jx+B3xeOhBZWlVll6MhwT5F8p?=
 =?us-ascii?Q?teVd/SLd+KVrNxZ5NSZci+ahqDQz64aJn7dnY+KBFu6GPt6Mararap/PY7b9?=
 =?us-ascii?Q?qGKZ+/LhSS/x0QZZVJgwbe8BWApL71/sHxLHXV5zk5ydZbLcY5LRyKq/L+G5?=
 =?us-ascii?Q?JKK3yFWM1k+GXSOdxAyNcg56AeHYDHtHxuwUeHAa/nrlfsV6tNxgEZDVpq/O?=
 =?us-ascii?Q?0L3wNedDeBmRZPvmI+LA6mSPf47chgIInM3XglXCVzWWR5IAdlI3gEsl9NUH?=
 =?us-ascii?Q?FykIAaspVAiBaNi29kRFyYM9q0adEg1GHNVTr8Fnn8+lR3yVXCyJZTPUFBM2?=
 =?us-ascii?Q?3uPZRx0qq96QOA5OhRcjipoyHUQdbPhRPdnPvykZvnTC/K1WcNZ+D7WfQrsn?=
 =?us-ascii?Q?R04v51oPr2hCMz/D9wP82QEhanSVlTdm7HE6glFwqGcv3T55vc4XiLX66PKd?=
 =?us-ascii?Q?zDadKUplLO0naawDj3tSVCmtouWp54dqi4aqD+LjJkr8159MDJ1QfFFDbXDb?=
 =?us-ascii?Q?Q7ifT6gy4C7brpSr/+U0JV2b6Gx9jwgd7SbkpHvpC/vgH4huWYpNPfY0D4ym?=
 =?us-ascii?Q?IQVsIBgaUq9HP/qkHsifptbiaUo+ghoPLR8ELg8zLJGw+24yQQ529hqJPRO0?=
 =?us-ascii?Q?4rGNY6IBxP4n6yzDwL30QehoUzczZvpziyH7usgSMTAImplqfkYYECVgvCKV?=
 =?us-ascii?Q?dPaXYmdJF7HNklimNOXpBOxmlKzLPeM1xTekzT4IB+I8kL0TWLEi8hjSFvEk?=
 =?us-ascii?Q?B8+ZcRAy4aTpTXULeBzQy1CVcSb4Z05KmfiBlsR1GHx2CVrRUtwjrXTw+rHd?=
 =?us-ascii?Q?6kZ40/saA4aCgLDI0NlQwpH9JLxg7iSHzQy7rfsvLfA+a+YQ5pWz+XsBytuq?=
 =?us-ascii?Q?HUyyBlwhYac+5KN+Enoqra+isFNMIBlgt2V4BwTRaaSOVhOto+m094+njL9p?=
 =?us-ascii?Q?KQCjwvHhkeG+W4bJtuuOKmKERWRh9We92GxIWLuDeOSyPLwy8OEo9/Wn35eK?=
 =?us-ascii?Q?9dmwnQC5qC56AWpaSc9OXE1HiD9lm4Y3mvbRjaMJCIXhbWvBmXR6ZgkvOXzB?=
 =?us-ascii?Q?wyHv62gHne6hHKdTbUccqDO6qnGXnjcgY0DMw6VMp6c4ocVtHvEGexevd65r?=
 =?us-ascii?Q?oLIrMwtViSfzV7n5CHSH0X32NQJyvA429pPW/hAtb2NET62VUBB/IrVJvPtQ?=
 =?us-ascii?Q?1JwiYU2Ok+8C7A1UEBiRm3cwKTpy1rn00HNGTUtyz4DkHsmfszaPevWL3zxG?=
 =?us-ascii?Q?jr66jkEViags/VjDZe6U5XMEOUWaMjzIyosk7lckZ0IH5mhSJofF0TzMeNuq?=
 =?us-ascii?Q?bbyBAJlq9SuNKZVhYjYi5KjDgQxMm4fPN8ELqkpPxTZc/0wn0qFhWXsp0Blo?=
 =?us-ascii?Q?mNqe2p/Ez1I/ERKwaft0Y4gJd7eUHz91jV/FPKh53GavoOUlBFfaF+kL1sUV?=
 =?us-ascii?Q?I+sbubMk3/Zoe8G47/kx7fRess9wJzlITvDdHhyECV1caSE8vEgBkDXCZkRZ?=
 =?us-ascii?Q?TRoYpIANqGCNhusIDmJ+yRed0kuuZFzS6fIk68josRnfCW2F/obrFWdB2F0M?=
 =?us-ascii?Q?hz5pVTWufW5scs0Q892YKQcICaf5Drx00bYXMeAK3PDmGNsERyFxo5Jt7mMm?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7iJaz/pnyy10sQ9Ig6axSJkN3KWqJoqGqT64JNHMLx9PANw24nf1PQ+AHbrE0qW/H1OXWNgse+OtoV5orhBRmWYSPo8hLJQ8FW8Cs3HEJaj3TsgdiZK651S3vBwjmtLC9jggVLOx2yQdaXoJzCelr8ZQzQw5Nlr16O5ewTeVvlxovrAp2nniVzQ8uRfg33NZHsvime79yajRGMywwBqUqOjsK/tZ7n6AUfB3TIVjl8RtKo1Bi+oePm6z4uGG4L9Aik80VMVYg2fa8PG1FMPgXDDJypw6P3IEyZxFgGWjvwv+wWIpaHkpRH8YmzdE8Z996CA/Prz4OwZNpq8BeCRWl1N+eotAQEKDjcWYS1n/A2i5Sez870EUh9p7GGorr34QARckaP5E+3oTqI034ZDFuZwaGyyjlv48ck/V9YcJ7MF8zSc40NQMOV//H5WLcMfCrz1dPucNOljhyQQxJ6g5feCCBvUCwUnjwCyItDVy4I3EsrpUBIo2zI8B6t0N7FPZtDX1kT3fO5/AuzlAbaGpigjoQzzv9S+PLrgFELTBSPmVWzqtzi31YZx8WQmUNS2wiZ0pC1+ShrLwOfsTrz2i5563STwfixckP1XMmXCo89g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d506e7f-0445-4d42-154d-08de0b675637
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:19:19.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yaSiuS2y9aWD9sHFJd1GdZn6soTUGlXdPP9U5GBWzuUa9ACu+uTh1upVPDAW7qM0BtM4pyFk3R6IoQ+ajRkdyTgXXMvrV9T8fdlS1syaPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140145
X-Proofpoint-GUID: OQzX8PQdmGBaiQzGoK6lU9ch0hoX2AN5
X-Proofpoint-ORIG-GUID: OQzX8PQdmGBaiQzGoK6lU9ch0hoX2AN5
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68eebe5b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=xYZdHb2nXaq73e9136wA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX69FIsqHoN0/X
 vlLfSiVS3JKIcGVi8LKD1x/OXkDpXvzIiNf0bisC3gXpiyItTnH8rc23C2iH7FRHLvd0UJuYuQW
 C0E57ODHlC+v7K9TIKJky6EwuHCM9S1M1xUwon9NqDPVPICOHhR57IT7YDIhoOLvvOpRxRHy89h
 1yMlMpgKoW9uSM90lYsqDnE96xQCJ6CTZudC65/QQ+C6mrmtTmiXhRPdg/W+fws7Vk0lwdifdMB
 l+tz5V7LTEdNc4cBn6tvejkl4EzyBdOTVXf6AplLuRU+6qJLLH25Wi3V5DDXJwxYU2Bp7dQtgxA
 R7csoye3YTHdoUu7KGGsY7POpuaAMIHBBbIF3NeAgTrw0M7NTuoHxDTL9HzJn+4mIhdttCCZIP1
 mTXc/ndVzEQIC7sRJLNnpVr+IjaEOA==


Keith,

> The nvme virtual boundary is only required for the PRP format. Devices
> that can use SGL for DMA don't need it for IO queues. Drop reporting
> it for such devices; rdma fabrics controllers will continue to use the
> limit as they currently don't report any boundary requirements, but
> tcp and fc never needed it in the first place so they get to report no
> virtual boundary.
>
> Applications may continue to align to the same virtual boundaries for
> optimization purposes if they want, and the driver will continue to
> decide whether to use the PRP format the same as before if the IO
> allows it.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
