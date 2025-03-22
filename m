Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59761523A
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742608124; cv=fail; b=ba+gik1SzBekGCsGHh7LZvPGT7S6xy3N1DaunWLOmJiGx1SrgKDz5j08N5M0sDukDO0zGg2E6ZSKutAoPguwysW9c3WIZwPfu+L90zKIlraEeYkNuAqW2bpxUv69sFug6PSvBAAk03Od+DPn9z7stneO5Qni2bO8oGJxHU3f9ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742608124; c=relaxed/simple;
	bh=DscXfSOAJvNAiYOUR41ItoS92ZPDran/Yd2tXi2rSpE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=OUDXdd9J/pb5sEyEKT6TNh43hP8wXzH2QmIY7g7M6t8ZRAXKRN5tf721TgU05bydoHesf1LBSIgR1U9AsMySwgsjh8wnSOVLPz0+pqW/NtxK5ORJd7w8GeRtb8yLCJ8CVALvbnrZtfTnb5e9ZrREoBiEsZxBuFlr/90Ar10U2DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5zii0l+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u6ZiZYP/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5zii0l+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u6ZiZYP/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M1lTTc018792;
	Sat, 22 Mar 2025 01:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TjchH1bT9VHmR7JIod
	jw0E/KTXZNajAOsIaJ1TPvYbA=; b=S5zii0l+mqC+ZT4FP4G3b0GaJcbETos2Gm
	ko+fNZD8UElhhkVzROsOFZgUfcDMW77XUyzB3KB+a0Oh6zB5xc73iauy8aW3H1oC
	A46vbTDH0uBYhZO9ahA4Ab4as49tdNNzPRnt11pfSdveZdak8aSN6YM//3tNklPr
	/mbt9l+EocNt9PhF33ep/ng9ktUmbS0pXNP3/SZSlg9C+/jacQAvgSX9chWvxlR/
	u6uE1ZkFMgl52YhfCmQkQisy3luZGXQTwV+ybZXd3inFQmadIkIE2xivCzQ0FskE
	RvdujDJ23UmoEtFlxDN1hTU4C6lMFUM0to3qsJTXml6UWukIq8Sg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hkt00028-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 01:48:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52M1YGSa025473;
	Sat, 22 Mar 2025 01:48:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45hknc06n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 01:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALQAOa7EiCj4eXp1xjs52RBY2xXwOXC79INubWZNMj2kVw5M6ZNcMxObSCefUCkjcjMZNPa88qMUS4rGKt43lwzXsaQqeZtJ5eI+P+0NTNZ2yFcOppk+ksh8XJu6vRl2mO6AOUXvaYpdt/iEzPVM25K91vaAn+cKrBY+4okwq9tQMFdNZgFvkEcKLoG58cCZU3aJcdymv3Z9uENg0FVK4ToBoJPU+uiXA04dbqNX0OpJS3ojInfwqhDRPuufdIVw6Q+eFA6kuWgdcRFAw0PVyv3aRVCvF4U5P1GtnDK6Dq9pz5PIextBDRwbjrILIRzxKOQ3iNyXOWn690eHXQOy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjchH1bT9VHmR7JIodjw0E/KTXZNajAOsIaJ1TPvYbA=;
 b=ISZI9jd5dmtYWi1AlAlhLFObYDB0GOSVEduAtl7bRav6EdhIpVUsxGK4mlob7OcI4Zc5j9PoTb1kD8yUYeru2y2T2X5cwQJpfVYckBOkhhgURM53xYIBPm72Qak7TD9yoKcyQywRI6N3U48BrzODAuQlrdrnJQOAWMIysdw+I2DTQVZhtcxe8otA7IPO1wMGUm6hQhNI+N3ClN90iYBIp5N10XikYdxMUHmoQtzZz/B5AfEVgKWiG//zgXJnp8WXkFtXc2COC1Lb2cTfJxldToamRvFvJKJlQAe31uRJuhfSIDNjPvR+TYWLqtcyPD1myW/xT57VRL301BpHeFCwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjchH1bT9VHmR7JIodjw0E/KTXZNajAOsIaJ1TPvYbA=;
 b=u6ZiZYP/PSbhm7GLT5JOIntSI0HTWDGu7um6s0NWuGkgBd2GIJBEFkPweR6Rmj4es2vqiaVchAnMJMD+MxwYrC3oxhTtYTIPOyDZfL0gi79M0op/4+uTC3QMeyLzZ9k6O19iAGqmj2spWbPUmLtqioEQ9Ooi3/pUR2ozLyOBICc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Sat, 22 Mar
 2025 01:48:10 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 01:48:10 +0000
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of
 the multipath head node
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250321063901.747605-2-nilay@linux.ibm.com> (Nilay Shroff's
	message of "Fri, 21 Mar 2025 12:07:22 +0530")
Organization: Oracle Corporation
Message-ID: <yq1wmch7sga.fsf@ca-mkp.ca.oracle.com>
References: <20250321063901.747605-1-nilay@linux.ibm.com>
	<20250321063901.747605-2-nilay@linux.ibm.com>
Date: Fri, 21 Mar 2025 21:48:09 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0586.namprd03.prod.outlook.com
 (2603:10b6:408:10d::21) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: a4af8ce7-34a8-49a8-b795-08dd68e399ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Q1YCs4Sg7h2yg6HzwrNSV40XMOB98mtqnfR7xlonl5JlmCnmxEWZ+XdUj1h?=
 =?us-ascii?Q?MHPyHe6xB+fzUQXfDqJEgEAtJEcAtaVU5uLo7R3+ZI2O5eNz4epQ3sF1OUj4?=
 =?us-ascii?Q?kgLoe/YMsHF3/x0E1aINBacCiJczdsrvFJWTWJUQs4CQGPPCuCeG6suBi1r8?=
 =?us-ascii?Q?PPraXPWxX41uESrAopr5cKIyi26thsJaSfbSbtr0myhmXmJtixiWCFcNUMcx?=
 =?us-ascii?Q?OS2prROkHKY0CqMpDiU0f124OfhjVCt6as72rv+mYLODOpJ5Pd+UkTruyYDH?=
 =?us-ascii?Q?1SioVaF6ThmBW5Rni2Q1eRF9KGTiOJRZSzMf3SfbfNti2Gh61cJFuDk7D7Ku?=
 =?us-ascii?Q?pPWEB1E/cT57pNmtjhHKgZuHQIv+FsxpPbB5BAnnc7/oN6PFOxu56F4mX7KH?=
 =?us-ascii?Q?C1Q2lqm6iJq/52/BDprME6+J+iurTho9+Inty5a/LkXn2klKcyeAVFc3XhTz?=
 =?us-ascii?Q?bl9pMQJuteIBY1yG63QUgyuRutCUNa0vpXET98HA67PY25uilIX+CD6hYc5z?=
 =?us-ascii?Q?mWdfSYQ06G3A8L2quS91ebz4ZjsA3d3sT/7WbS5wg5a3EpbkjVgowAPe9LgM?=
 =?us-ascii?Q?9ziPU1JfoziFtECkc/D7lyQ7cwInMxToQTm9B6IBiogWS+th+0P5jlcrRf5Q?=
 =?us-ascii?Q?FSw4paF8j7e5TNiezSrkNeO2Dm1iambvGfWxK94vKsthObsiNz1KDaDcRaFL?=
 =?us-ascii?Q?/5W9YhqVKFAJSU47K928a7sXrl5koIMOFxmihTPVwJtJHlurkiBj6bd2i1UX?=
 =?us-ascii?Q?UpVyEGnRRClvl0RtkDLEXUHFoFy0SnSp2D9Cyy1dGCo5DZ9e0Drx/n6OKADI?=
 =?us-ascii?Q?72wHgditxk2F2JQhkeKq5TO7u3hAaGG0gzixlr0rlgxt7fGe8xcPoryUurnG?=
 =?us-ascii?Q?LWg1AZDzQHF1jLkWbrepKgi858vp0MFdt98ZR044dLDLPDWNZTbibKe412o1?=
 =?us-ascii?Q?aruTfKHZuIEIcFC7cpsmdfDPx7apnhEwz5hlgFG1G4HPxfWgwFRRhQnqrHIM?=
 =?us-ascii?Q?3k5ZPrEIG4hbLC6+2xK+6fIZShGcloUUVSEXqis4O5UcjmrkJUwqK90SngWo?=
 =?us-ascii?Q?R3t0d9OxO96EweeRmDkuetoQHo9A+jbNhifGKQ4MSUzcINag00bJO6CEJ8B0?=
 =?us-ascii?Q?9mXhUzbcoWCoSsLwk/yLll3uCaaUHN9Oi+8W3ow6RKOAyHPQNgG40etjSe1K?=
 =?us-ascii?Q?Jj9cdKhnP7xXwy14xE6Ph73muS7/lKGddWEy2PZ2hAb+iGE1u5YKBI6UZOF1?=
 =?us-ascii?Q?xi3JojyeqkUPVVPRRFQhqHkYRjMALeIDx2jIS8seHOuLUo533OPZSVZiI6ZY?=
 =?us-ascii?Q?jYL1oNpn7TxJmI609HHUOeibkkClxCvJp7AVRHUVHxdyt0eXAAvEbBcKQZeW?=
 =?us-ascii?Q?Efta7ushp4+H5nC0BZrFgiqnRJUr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eAAEAXONqSBoLXZu5nfqe81le5yB0FmY3u3Sn7XdIj2YMlenSGpXGrm5F9gp?=
 =?us-ascii?Q?P9bmkKQ5wLeYcDtTc1t7u5ktk2gTKQWEQeCKRg7/C/KRwr3egDyGu+uhP43Y?=
 =?us-ascii?Q?wLNijO69KthYGbYQCf8xW7xr7E4kadhgUnmysaL+q0PxvdgVwXVNOk1yAKmk?=
 =?us-ascii?Q?p9Ivu/Wm4MZF7oXhP/FkeRAPEhIL3Cnq1dHIloM1KBDv7oo0vYlJ2Rqt6J+m?=
 =?us-ascii?Q?X8kCZ9oAT7Z3AKQeXTN68ZFdP31vkRImJAGG3w41EQa/GkyIwOagctFwmTJ0?=
 =?us-ascii?Q?V5IV/UIdgemht1KTQZ8jopNjw+rJU/GfIpi1O5KJu89rEjqqT18jyWHSrybY?=
 =?us-ascii?Q?DvOSYFnOKE/5nEfYF3AcsU2KBa4zEIEEyNuFKLatgTAJ+ij43WzY792Z1y0p?=
 =?us-ascii?Q?jDhRw3YdRgfmNFYdEbXUw8ILgLS7t152DS+Z9j6Ei4WxG9SGWkXHEJtngGSK?=
 =?us-ascii?Q?0dRBWvP0AP9tuQQwRt1C8AtqfncV3Ki+6g0j+MQUS9atyjHlY8Xl3ICBXMSb?=
 =?us-ascii?Q?8eO411Lwh1rGIMJ2HJCfy8JO4xFso93N1rCw6unf+Ka5p5VQw+ua0LGKdFsG?=
 =?us-ascii?Q?rli3nGrnTq5ocJ3VjYLACffLugOd54wyS5LYz/FdpGuyQkDEkMOa0jvuT+xX?=
 =?us-ascii?Q?22iOEBv3MXkNq0hR2SndTrSTZmgrWL8hiLWdcXqxPcdJTAuTUAWz0wDRZWSl?=
 =?us-ascii?Q?2xuomFfYU52aHlKw919OvIyBeYv5xbKvvUnaz1sV21hBlrauyzj1yMcI3kx0?=
 =?us-ascii?Q?+ayrze0Y+Uf7TgL+sw9NUD1mDky9GKVF0MU9imCrjHHmQ7siLlwiAYqgHPSt?=
 =?us-ascii?Q?IWu0PPuZe0GGDUpHxXN4fXl3xkHswAl5yA2ML7iKzdnZjx7Ljv9JC3qzGN+J?=
 =?us-ascii?Q?ZdudzdnuxLsUkUUagpZKqnYW26+ml39I0TeOX+AVzEBNJ2BO1e9TwHu+vhBH?=
 =?us-ascii?Q?heRiDPLg6ZzJ/fpwxF5iZUmzCVzPthJz+xldhIyg7G0r/16KK5trUmzqjNUn?=
 =?us-ascii?Q?8XSMtaRYK4A4KSaIUqAYjy8XZcU8foUJqGYM6jVNwYEsK3tJEiL3HYg+EVSw?=
 =?us-ascii?Q?hvMg2ZFO2NASRVMUMUH1CDFvP+YIDN2QZ8zrVgWHc4rCGF/n9hZYfoutMHqM?=
 =?us-ascii?Q?yYyViaNa0kvajmYJXBTK4/vSLskCLsrXKA7aXawX6Qb8WFnvDc58zNqOmZdD?=
 =?us-ascii?Q?QTr2iki+L88yacfmDPD0hUEPQMmSGtlKJuMXK+USLBq7NXv3Uc2oeR+1Nwde?=
 =?us-ascii?Q?gKIugjuraiGEonp+zKdn2mC1x37Rkn9JLfwModOI/Y5vKDaQqZ7tPMvuNN4e?=
 =?us-ascii?Q?hwHygipp9+0NciHJT9FfJSXcH4z1XDixHlbgZPZOcsMl8P6tWZcf6uoFuU+L?=
 =?us-ascii?Q?9DSeUF/Tw45drX9ddGNPH0G/3/cpXcg1bsolIvX1jv0aLfRCEzJcTznYTQag?=
 =?us-ascii?Q?YDdHu6j2AH2oAvhxUXRbm12jIHKCkY0i08ftFPvtY3Jza5VThFGCM5fE7sBw?=
 =?us-ascii?Q?M1PG0qTDGGDX1wBakkzw/r5IPI3QTozWw8Dni9RU1f/XzeN02ZK8ZUA6OS2/?=
 =?us-ascii?Q?fIf9qZdRYbgyHLoJRJy5ZrtSqkYq1eG3HbwYnNnxUhqXtGekRtAk52cX3Vbe?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RfM23qaD01qTzlPXnsZXqRrhSt7o3caeEUNFrz3lTdcmxkCM/WEUkuDh0lvPvEBS9mwiG6GO12vjcDnDSwQQRY4oszMorgfvb0dJabqu3BvW1Y6fK8xEY+n46l+nw6IxcIvcy+a7xIfdgyYDFl1Nxdirkiv3cXBmLEIhGzOMSKvcKZC/PFCMDxNtr8cVRAiwintqptVRZLW7/IFzBQ8kAZuLzmDV6wZLXOeT2lARYDAZT5JsUIWw66NXVGDq6iuHdG4qf/O4QRCsaN0pLf/FL13bwh203SR8EAO8znIVnKm+We5LfOMaTSR/2nflb1jAdOOZj6QbsXhapxn/ZUj5Ns5LUCtkrPj7JaL3Lt2jKfYSLMF0SMSYbN4G/MULIycATjBtxj4qDxCeTzJaxph8g/p9Pb+y3cDg0kLdtS+9Sb2k2VM+wLA8vCI7XNGKEVz3QOkpqf40LPAsRUd7Ifq20J7IVNcAqFwGiPwrixdd3fK1qnHw99uYyftps77oS7658s2Xvv7KDLW5Tmh6OHvpU5/qLS3tZPYywO9cMhjTW8c1Exi+FNHKO4LIRorZZVpMFLSveRnaaitO1sPsflfmung9xor4cylHink2gA/8iFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4af8ce7-34a8-49a8-b795-08dd68e399ed
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 01:48:10.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrmJvDqXF4083W89S+kgG5/bgF9LguWukUZX19TnV2WL6zPtXiKWnK7A3WaO2a3djH0bcaVgPOLWNGjS2/ZDayOClRMMogf6QV4esOaQ8tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=827 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503220010
X-Proofpoint-ORIG-GUID: DZKPWxlNzMEF0nsk5H1XiNT0J6gRgvU6
X-Proofpoint-GUID: DZKPWxlNzMEF0nsk5H1XiNT0J6gRgvU6


Nilay,

> A new sysfs attribute, named "delayed_shutdown_sec" is added for user
> who wish to configure time for the delayed removal of head disk node.

Shutdown has a fairly specific meaning in the context of NVMe devices.
Maybe "defer_removal_secs" or "delay_removal_secs"?

-- 
Martin K. Petersen	Oracle Linux Engineering
