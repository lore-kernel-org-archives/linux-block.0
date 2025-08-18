Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF2271450
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532422; cv=fail; b=ivOvEZmjEFr9NlEV0Z8a5LGsijrSNG12MVBVs9bjMrqj6uN/bphtMQXgX1MsN9y5ly58qqQP22T7fwPXM9QkKc9ugqbtNSsch4D8ItZnxdYB78M5fQLBApOboSWhzNj98CcP6lhOGznf95HNruK/Ojo/zElVXfPWQvHtT9BgAls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532422; c=relaxed/simple;
	bh=n0r9Ok92GWrtwVr9u36vzOtDOE1cwdH9mwvHcll1qJc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=GB9vwDNoRlon9OUpq59GmAdQNVM9i9BotDOtfnrsBPwThKmTIEjvdmEQSn1UgIjVsLUv+3rRAsHdAWuiUq8AdUeIGdTRb1pq1X4bvjreRKEFP0tB1mvzlG5Pl3OpaxwTGIrmOrAo+thkbW7YRTQD5dRjnSpldFdoX1qvY7qXXzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BimKtpg2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pZTZ8btY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BimKtpg2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pZTZ8btY"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEtqds032304;
	Mon, 18 Aug 2025 15:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=weMdwZq9rX6Drc3IHf
	SmnOyxag5gzoKzNyaf5QRGkd8=; b=BimKtpg20kvD5s19+vVnAq616OvMTTr9k8
	SNaJ60JBNbq8H8Y8Vt+z92Tind9F8Od8WNNNCKY97xCdSk9O0H6UGkDqv67DG0t0
	vl7HE6jKV4kogzg8kexCQ8UyygvLvB1zvrAYyRdAdWZVcUc9Y5dCQs+pH6q++EQS
	wYXt1VEkB85WV6fGFSkckVaJ+3T0J4Y5zSSugBgJIAKVG77zY9mvKK5DUOk4d5Gx
	+Nwr2yedBm1aLM9cx+cFwi5iCEzbfQj8zxf+nbIlGBtoFt9daMfJnt1Im0z0Sz5u
	/kpXwm8Gs3GYAT2aIDn5CKkRpwMsVDqYxm/PBKHUZYXusGhdIH5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48m0ybrx86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 15:53:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEnsYD014589;
	Mon, 18 Aug 2025 15:53:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge96urw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 15:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkAdXx1rBDlPrLjwUpqyFhKEsOdBN7op6xfDl5NT3WdzDFYi/ZsRHJ/8fQ2X++xu0P0rziLp60HosZBA94Dtc5lVgCmPd6WkEmy0qppgdcTrK/+vAWKue2H+u/Pvw06J+IaH4xowa9B0AZHGxARXqpH+rmT24lqXNMdY0l7EuqlOTkx1+7pVFQUKH82F3nm7m48vi7pxVC+geHaaVi0huO3+yWJwaymLo+gqVEJ0dbJmsW8B1hwyE+BdqUsvXBBbd3GIroI4/d55G5NhS92pI/AH80YiekoNrBC5jWls6Bk9JtMqq6vfMjCU1yPCFfe4l4NUPQ/43D0qBb4h6N9IfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weMdwZq9rX6Drc3IHfSmnOyxag5gzoKzNyaf5QRGkd8=;
 b=ZCzAcyzwNVD0+CAr71EM/eeAMH7WtA0wjMBQ6wt0tBlE2PvmBe9qYwTdBa2PBQBFVJxvmcO4tBGlpj3ssmEfN9yVrJ0u/giM0u1zQp2F2egRtOipsP12IRFZMd2eOooI5s8lu8qjeD9zHDgEZYdO2V7pKPWvM2ovatW6X2Arc86SpKc33pZpcHyKBmmbKFCCDatHA/+eh4jI3qeIL87qqH8DFwnOThc5ggQfleSS9fKflCG3mISeBL7nP9xiGBajIjQNuyCrwovhhqQ8Nk/3kX26haQwHZk58Jc7c7Gzl/hTeMwWn6iecmmTWN9vfG89TT96qvOhI60ismGnNJi8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weMdwZq9rX6Drc3IHfSmnOyxag5gzoKzNyaf5QRGkd8=;
 b=pZTZ8btYNtdaIzNjULkjzWfkz/F6J3Ge+Jd9GCHuKkZq0a444pCG+P2bDjklu3ac1gOJhQiP9hqLU1+sYX2APx3u2PZcnClY3b0v+8m5KyamN5kT0FZ45CWbBRJStu+z3/hJs1O0/Vhnywc1pTjquDpNhWbYpZQm0DNLuFs1xJc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB7089.namprd10.prod.outlook.com (2603:10b6:8:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 15:53:18 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 15:53:18 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Subject: Re: fix stacking of PI-capable devices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250818045456.1482889-1-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 18 Aug 2025 06:54:49 +0200")
Organization: Oracle Corporation
Message-ID: <yq1349or5ia.fsf@ca-mkp.ca.oracle.com>
References: <20250818045456.1482889-1-hch@lst.de>
Date: Mon, 18 Aug 2025 11:53:16 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::6) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: e89284a1-5916-47c5-9f70-08ddde6f599b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gSitMlW9RJ7xCHSiAykHFUgqQzxJe/Nhuei7n6LWtdDu9A9zsJH2HEfyI4i?=
 =?us-ascii?Q?mn+QjliH/Z+L5vtwe9LDd6GS6ipyUlAgKRNSp0FMfzmL4GKmhXXPY7RBMOf1?=
 =?us-ascii?Q?WVxF8sevCNishq5m7E52WcU2N4Afbz6Xp0F/oXWjn3nJM+i2T/TyiAWYAxtS?=
 =?us-ascii?Q?RdWQ7xHcsZKl0OT5Iqlonu1NjQq0zWPQr4M34iKf/+g0fWeFNGHG68oRwHBS?=
 =?us-ascii?Q?/tqU5cU4DtCrQwuvzalxcGZ2QJcb42vYE5emPmwj6pyxklANDFOPF/0JUPcl?=
 =?us-ascii?Q?E9mgAv7G1X4qmrxVwFHES44rcnyPr+9AbwU7j/3c2Iex0ogr6mWo6ifn1yjj?=
 =?us-ascii?Q?lAIT8LEx+VoSFq1vsSzYp7I4isSJUIkv24LC/YFcuEZKOo3GGNyRb93uMtOv?=
 =?us-ascii?Q?Qj6/bnhAEqkFgkIdc6ZdOuaz82er3c9b57uDUAkboxj5miN3vK63Ikfij0Ns?=
 =?us-ascii?Q?0EXWU5s0bUbGsgmRWKdQQo2qJbTKe+fN1VsxH2qTh7u3TcgoHKgvixmsYx7Q?=
 =?us-ascii?Q?rVMwXtJp7vbXUphDLsDJgl7RUEpWahm4YW57X6u6JTboJM01hgxGtebbvG1U?=
 =?us-ascii?Q?njZzhIwy549nfkmxzDMf/RvXVkDev6HMf43daJXONCC04C3EhnvZXr8YQn/j?=
 =?us-ascii?Q?cPqw1aaMWFV+kaMuuMOE30Qp1W9eJRd9qj8k4y8meGBxBU1GzscReWQOGegh?=
 =?us-ascii?Q?n0r0ieICHOJ9XSLqq/gMvl3YUWZKg6gxoK97+7GT9FsMdk2hsjWHQeW1nlhs?=
 =?us-ascii?Q?2NvrKgk4TeqYaMacK+YwH6QkJzdxz6vTYK+9n6uc39bWkLdPFMxyEaNUrPr1?=
 =?us-ascii?Q?d80FwfqovmK9igMb1yWn53Fwkpuk+3tg4KOE1x+acAvtBD5YF9UCkGWDuXYe?=
 =?us-ascii?Q?/oFf+/eRyccr9A1WWIckU5TygLZDxsM2VT4eSQNwHT6/S2EsrNgA6cBnEwS3?=
 =?us-ascii?Q?RYygQiCa5C/XePUKdr8CNwgmDRmiUvYto2uX8IlNt1O0quP2cVeh1TU2Ajt4?=
 =?us-ascii?Q?vVr/xgbxS6t2DoVQPluguG5XqcOYScP4QmMamjjA7lnhe/KzEZHZj2qzdRgL?=
 =?us-ascii?Q?b4B3cC+CoFT2IYCRzUSsgl1fKxSRiH9qMshXCrVG6LtKTRJpV8I9Fznj5wfZ?=
 =?us-ascii?Q?tUzj9zplIxHK6C+LCWJik+NmaiLrbBoELYIA70cSfEH+uJdwIyU7QCRYPF1p?=
 =?us-ascii?Q?470xT10Q+R7MG8Jx5rtDTqwuFPkPgm7N2SbH4N4SLI9AIXP3pb8u4Cd9dTdK?=
 =?us-ascii?Q?yeOa5AFUBf/hOScvDNcza2gDvZYVS1Upc5CiErZzi6xULI5PDqm8FqarPJ3a?=
 =?us-ascii?Q?ny9KQxy1TawIcVx8TkNYcrA7Pwc7iVFtHiYOaKB31RZ6vo0QtGAs/WL4SQwQ?=
 =?us-ascii?Q?XErI9+X2MtBfTX+LHGW14q13iyYpnB8pVCxt3PCtbnyfOaxV2ooDm1YKHQca?=
 =?us-ascii?Q?50Me8QCoWZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFfYnvWbEl3SMvzAVnreDjvm1qaxH93A4DfhPfL0HmSrj8XyeL9tDhcR+mhV?=
 =?us-ascii?Q?A4aAfNWEI4wVLn6UoOQ0dBIVmXPRvcjGjAS7njEKehYupZ0tvtxvUsRg3v2p?=
 =?us-ascii?Q?CpQHO7JgnRtc3IRa2KgJ6hVKA6aR0fr4Q/j8MpVgCDrlmlSj5it7Yn4iHkpa?=
 =?us-ascii?Q?bzKuzf6oTR88kEKQbvRkM3MBDdKhJnIYGB+k2fHdh5z1W8abymNSDb1NldoO?=
 =?us-ascii?Q?ewz0xJ9yXaJTNA11fP4b+MRRBcmvTJV5hajkkoLM6LlzAFzbUJ8Mqlh9i/bv?=
 =?us-ascii?Q?AjChTTbLniOMcIU0NIFVQS4dKdbB2nRzRmgtSRcVjISUtEtU9cOEVVjwzdLw?=
 =?us-ascii?Q?6WcjGf+JiTGodSvcOssb5E40DTUS/J+i1GUsx8zrdWTmhP3pnweTv3C9US1V?=
 =?us-ascii?Q?4I06E9Pu+uaxgwvfh/yvfxklHyTTifzAK/jYTNu4vex31w7uJ6jrUx20AesT?=
 =?us-ascii?Q?a0YiC8aEqtrvbC9DRoANb9SQygASX1LG27x2e3jkZz2bpmpkJzGSEm/U9G2p?=
 =?us-ascii?Q?d3i/uG1K7qEPt4lRcnAGyEo/dBPka10XZZV8nt7nH5zLxUv0t8k8UIxBdSAS?=
 =?us-ascii?Q?fJvUqe8AuCttYIkbvckXapzrNmbiyfhrxGDq+ZigdHMPvuWrDJrgQpyKDcHb?=
 =?us-ascii?Q?7DIao5Dy+LqsuWHorjfuryldxjFnjmXFRI0Z0e07RD71QjC36xUq1kB6eYA8?=
 =?us-ascii?Q?K2cU9ICNMd7MCUQtBCU8oEup+CNmZnP1wmXwUjgtjQyn4xdrclMBebYfvHIm?=
 =?us-ascii?Q?jC3kxgaRdxU7Ape0ZGvECYFzRcYoFu27i3F/vgFvx0txSoj9OPvyeF5BmKmK?=
 =?us-ascii?Q?0c5r02oqMRZ8zAfGiOMyZxp2lPp4aw7XgwiJiTP8xALuPAePZ6C4JUH2C+X0?=
 =?us-ascii?Q?Whf8eYilP5fM0WLJwZkgEpoKj9J4/3qphWeTtdm1v4owQnFZ+7rzdj/WZHBH?=
 =?us-ascii?Q?6dXSkeAADbKemU7bqX24BV/C4BSGiZzIT7OFXf17qZLR/UNVcvPvTvrjS1Er?=
 =?us-ascii?Q?3bjf54+YSpIO5ZbzNyCKYIXB5gk5vaifbhGoer1iuvZsNgN0nl3vDHzSBs1F?=
 =?us-ascii?Q?zm5eXEmc5OHhh1WLHrKwFtumWQBAbGlNVxcmnA8yYActdZb7t5vK9e5A0fBd?=
 =?us-ascii?Q?yTu68s64orGaVVnEGfHZx/Yhu7Z4cS96VmYzMQF9zwAoDT7VymP8fbFqPoNL?=
 =?us-ascii?Q?RM0N1o56lWgCYmVlTb0n2WG4LU+XNMsNSvFTcLWcnnOSH4YhHQMLGaC6evAr?=
 =?us-ascii?Q?wjWBXBgf53HcFYP+K4+YRbn2HZbWlcr0Vc7/AEhHVCf0+qdfxzRUFuFaXSdf?=
 =?us-ascii?Q?VAulLUURnMrESGxQjUMxKXFmdb8RqRfmgwiTqDKVYApNjFW19gtEu6hJdsid?=
 =?us-ascii?Q?sM/6GfjzEStt6k1d+mJzP87digfW5YnsdLgj+vj9odN0n5x4poohFw1WdEED?=
 =?us-ascii?Q?PHO2kBoqBbDpm4z7eE8OvyVOXLVtqZVSqx1qRyiZnxVViD0ewGnae+dpUy8J?=
 =?us-ascii?Q?roiOcr2mrNG1gdnRsWQDpeGkwQEaCsoigitoCsG36AOed03ubYtP/B+qJXfe?=
 =?us-ascii?Q?woLMSuhuOXYmWiylOpNF5MKsUjkxfNQmdSfVVO5fxG09UCP8+wknAJrCOhsP?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YF1nrPeohqMN9OZvFKyZqhjRnasug7w9eKdphIXykyZL82zHdzVgmu6o50iivZbdoIcWNtMEIzFMPmIUQDLa0e2MJqxyPnfY+32HdVGABdlZeZT3tNJuJHG1eRTTdCF7g0uJp3pkoUycPeCR/XCQ6veiBacRYrixTaMdESF7QX/CJ5vMNoZrgI/MBM1ZkOrq6BUzsQUXJAxk1YtVcLkHzq1glL7295pLLDIhJ8vrqnH5NuCY+kEZb3Bd8SYpV1CEHh8zku7eldoj0iJtfwjC7C5VMxlvOQfk8CjMUQ7UD4q25Xr9AZ7I2QrB5LrZ1U4L9KLEcgRN1UYTPtqN/hPJqbxvaSz5D0LFLTWeFesbUGC5lM7qFsnQTnY41fpwbxITln4z1kg68s04uLmk+pUcvSCj6ZX7XRsahtG2wyIyRuKSdZwQNLx+ppQE62vSWEFr8RvlhgjTZc7TPW49q7aIxqHMqg+Yhdi0zecBjeuA8N8UZ61lOPLOetnv9nywiCcBURFzEn6T3lAwh0UH5zt7q4XDZU4G13itr9bShHVYqnDfKPoHtllUDK2S+qV6/F5cfViozc3G0Dv0//FtXR5/c+amBcO+Gwfy7qJzzWNYQFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89284a1-5916-47c5-9f70-08ddde6f599b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:53:18.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAKQoFGNzwpjRsRD2hlO9m6drrh7a87J6ssutJXcQg92zU4N1FNRQgf4g3ZllSlLX3w+BE4eR8fhs8KBZIisDMa9TYwXlYXOjfo6Fnz5Gao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180149
X-Authority-Analysis: v=2.4 cv=fcOty1QF c=1 sm=1 tr=0 ts=68a34c7d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=RcPNFgo5iBpDjDeoP20A:9 cc=ntf
 awl=host:13600
X-Proofpoint-GUID: j31VQbiYFWhlwKq8nMv69FwjdrqF_HUf
X-Proofpoint-ORIG-GUID: j31VQbiYFWhlwKq8nMv69FwjdrqF_HUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0OCBTYWx0ZWRfX3D60sBP+S82c
 oqp+uuypojwM2amtBxKb8WXQojszSQAjO7fkMB03/AnEHZGNDilHQpzLE7rz14e8hok0dXQqwG8
 JbEjvtOrO8FyzR/gjStQXuu1/qo+ZpCWs8+EQlAnZ2luj0ueEsP3TGBC0yUC/+QOu+UjD7CADO3
 AT8Y2zj4w4/jPgYuQ+ZnjOxIevh72y+pi7g+3Ypzs/b11JwY1wYfzVxhdxzguZmbZzg1dwa4yeX
 L3jEkwWxOzWpBsLxFE5JeXVLTgNVjBRpiv4giEa8qlCXI51qXTFg8+d/kGFB1oQqMj6C6DVADx+
 NZXAuJDEqrMq10ir19HmCDb8+BTFFGVLNgBNjpMKBK/OQm8IkNcE1FbK/pJTjXoeRco+yPSmInW
 nJvHT7PXssCeGbheMt0GKNSgATtw777XhHM6Iu+f5q1E/2TYW21zoBMuX97uLtxu/1e6zZ6D


Christoph,

> this series fixes stacking devices such as DM on top of PI-capable
> devices by adding support for the new pi_tuple_size field to the
> stacking helper. It also makes the error message when this goes wrong
> more readable.

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
