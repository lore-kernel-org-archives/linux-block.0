Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB01922E4;
	Fri, 14 Jun 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355853; cv=fail; b=Oj27igchCd07aVfnIQsqzCRBx+3fkoHteQxOSp9wfZlObGTs24Rh2oyulP/EDZvOSUHfoaEKhMlC2oGXq/13/PTGY4nIk6xP37edATTGYFTAj2FG+/5tW5kMS03e4XFacAAwgcfOy6sIp6n3kTormrQp6YXpFi9xLzX5ORttxqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355853; c=relaxed/simple;
	bh=8WDoScvqZJJeYJIgHHLtfli8WlF7Y6jLW+VcVXELMIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AU7uDHcDyUZ37d+yXoGNy8njSC4NVJWY9tTQDAt5FpKabe9+KoAxNEaRVbJ9UwI/GAfy0lNBA0lZuC0VefekM3JFkJcg6boeq7vsLEB4greosZwTVP65wjYPtiJi35z0297z5e/tpEJLDs16qYJ2mODLzYHZtck/yoPp4gHiInY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IwhsMhD4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d4dC8uPI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IwhsMhD4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d4dC8uPI"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1go7b023646;
	Fri, 14 Jun 2024 09:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=20K22XaoqX0f8uwbDdhDoMkexM0cueh+IXXVIXjjk70=; b=
	IwhsMhD4uysyu4Zs3uQaBNXEvr7uSVhxl2zEUPyz/yHss6IGQ3/rteedCwtBGshm
	FmccJA4bMDTfB67Q8J95h64b+XIh5SogBmhoabBUGaoaSVc+u4JWEEcVqopym7d7
	oOX27r1wUSwd2QuKbLqQ/cFRWDrpkDPc9TD+5SLB172ubI/Boi4kO4Is0qGjqsAw
	AjWHR0cSyWN5u0xicjBDywMPvwURYOqYhmBMvFkKOqoW8q7h07buejQ83zmkorup
	rBVLNmv1N/4voodmtswxPeuI4HZfmcRat7I+AJWLv5dMvP9ERsjFF0Kc9+39qmS1
	/TgWf+NG1ySfNDqTdgp9jw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7du9q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:04:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E84i23027148;
	Fri, 14 Jun 2024 09:04:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdxea83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8vxaP6ZZZ86MqCFstKOApzDuf8OOZG1VI9Wbb7pkK9IhdoiWfVHwwxxt5VvX1Uo0DL9nXQapYyDBPq0o6yEKSxl5zohCaoOXPcHWkGuI9v65kAnMR6spNy6k90BWxbV0CTz9qsYHDf5A7o7p1XJnl92ZdgxHD8jg2Hc5aQ55aDTXGFGnNBnaRJizJdFZsoKAKlgSbN6DannFiXe+x6rmOFUxmUZp80hjxyAsLeW1xbmOZ/KQ/7WmGEf8Ak9c05Ad7XzfKlsnUVcjIQUxnYtjP6nj0UQSQxKeqh9MpWmzkwbK5MXSTTUh4BcT1Hf31TaZ4S+cdqjbPd2k9edEMJpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20K22XaoqX0f8uwbDdhDoMkexM0cueh+IXXVIXjjk70=;
 b=KhShkCmcdQPl+f19s4XBYEXnN4BNcQkVi1O6cSLdtvsbjKBQpzh1ZMouP7mmEDjmhzjnFooS9U7Y3ZWmjtpsZeh7y8ku+zYJ20QPijQ7AjQhEw870+Fc693lkqoi0qo1xag29j0AWmewqDPfD+jVXZcdX/MQ3d4TXOjjBWEDXWCEVfeTXT6UaOscOMAOwMH3MxX5hW++v7g7C5P3AV/fty7dun0hz42Wf6PMwHt5alDK6XtWESfZBlflL/LPI/IrpZUt9H+kwOWisHhPUhOwQOKuMmJgALAvcNwVhLINfd6JFGmto5KEeCtP6pKksTRz46iq7JlQjtBIW9ILORRjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20K22XaoqX0f8uwbDdhDoMkexM0cueh+IXXVIXjjk70=;
 b=d4dC8uPImyzdeYDNZYzd9yQogGTOisrKknpMS49CRzvflxOyCuvWgCrc32su2L934MV5tYntjDb9xDILv37r2h0PP7/dDUbO+8RdnLFXbtLhhjlfEwFWMLfoXCp1EZRYmkFZCHIVg3jsEf74pQ604eHEaMMDSbegCsKSmrkGtyc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8105.namprd10.prod.outlook.com (2603:10b6:408:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 09:04:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:04:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, paolo.valente@unimore.it
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiapeng.chong@linux.alibaba.com, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/3] block: Drop locking annotation for limits_lock
Date: Fri, 14 Jun 2024 09:03:44 +0000
Message-Id: <20240614090345.655716-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240614090345.655716-1-john.g.garry@oracle.com>
References: <20240614090345.655716-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: cd997cd2-ae12-48e6-38c0-08dc8c50ee08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8ill6NZrW9MOxSVkpZg3CXLiBCULcYfAIpA7veF80deMuh/GI1ydJa7og++W?=
 =?us-ascii?Q?B58HEUSR8gKw8NDTC+JUVOSZSGczZ0NNrpv8aCpE6GwCJbpIZeGrGZZmbrZd?=
 =?us-ascii?Q?yzi+NRlWPxfhiVe6NBfzonH0BGxEWBbOSHOEknXVy1qYbMav74XbmOANZqXA?=
 =?us-ascii?Q?os48Fn+oepfKB7B+KbaLHZfEzaFiRArNjDRFENJqYYcO3//cOiSmD6/Y26Sf?=
 =?us-ascii?Q?CFwPfqyeBjQO74ymg/4kjD6EipUWdLxNGS+J/hfTVPEWxcwUK2dtDsVJkqEv?=
 =?us-ascii?Q?sEZ+yZf5zGYfWmTICjFHrjUIR03Ix70YGoEdS7MfsVO4jfVL55GVpbPXkrze?=
 =?us-ascii?Q?/bPdgqcKt3cmUPX/32ZStbyhR7ZlaL2x8aaK574IzC9z79/P7jX5DdE0JEgu?=
 =?us-ascii?Q?wsA1E6HwXyHr8Zkncg8CcquT/j3eTgNntynqsFtk4rnTZ9hLuqNfBcOSeAdR?=
 =?us-ascii?Q?jSbGK1neYUVGuDz+dsNpdFmhdvKimZrQZVIhQ1sHEgvFbcUhg/nhf5goQaTm?=
 =?us-ascii?Q?2YljFCEDRz29WpNjyqSAl+VqV5g3tAP8ITq5eoi39DEK2N/orEqDPvDsa32z?=
 =?us-ascii?Q?ljtniff3b8HwfyKK13xQ/zF1L5R+Hod9anp1xurmD0Uq0ZDz8BiSoQvv7D+i?=
 =?us-ascii?Q?Xwm7OTEcCg47G/AC+44vbXURk7zV/nI2RkLEUbMwzvA9f8Fer2Jvq528EcSG?=
 =?us-ascii?Q?mYzV1gB4RgIsOue7Tf9s9wLJKKfWQChkxcy3A1r7dTj/nEuxg6HKIMHuSvuW?=
 =?us-ascii?Q?dY0g2BWdaqVRe8r3Eh/obR/oXL+ruZ+Vr3RbT4gknhL+ImEr5VZ4yt8LUfSF?=
 =?us-ascii?Q?m43onN79z6Nzp4hYPFcE6T9w2wbJkZfSlQdWv3Glz8s4CYTrNQaRLFCXDQxy?=
 =?us-ascii?Q?ru+0qAmON8SJEBN6ER2KByjmlCP/99p5p0wrvsW1xhlMlO5JjTAYaC/QRX1c?=
 =?us-ascii?Q?nLY1QWmTgxJfCuUGS2Yp/3VSTH5VHOqjzFfhJXOQ4pqRkxpiyhUqeYLtl+ul?=
 =?us-ascii?Q?VbvaEVkx2GMr6NxUnoAt98wv1+Qdsq9gQxITyAWPwDQrb4r1JUKLwpf4/3VS?=
 =?us-ascii?Q?8N1Sj3sA6SCrppyZBIuENDdBs5/JuyITC4n4gXjnYPQFvu+tCbkTK112MPca?=
 =?us-ascii?Q?qQCeS3pvYrGv5ipuY0HZO1gLu43jSGeQeFW85FgpZRadig0Rl7+x8getMsFG?=
 =?us-ascii?Q?fggu8RJRV0HmC8VN8R62zbbWAzonSjxfrYnM1HoFOlSaRbpLLIenP2GwZWK1?=
 =?us-ascii?Q?RfndRNaNgAyodhwPie0f?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cGAAMjuGFIN6s2A1o8W6dh9RoSiqQxtaaq5poJ/gu2nYO6Cc8pIV2bFe6FhA?=
 =?us-ascii?Q?nZAuC0y6ejpf3+zVj5Faw/Dc0BS36HApM2Ayo9TCELAvIX53oofz543Qi3RL?=
 =?us-ascii?Q?waz1pLDiwhQtdaipemtyrjrxguBPPGQAYB1WWx2cxbFYUC89MEflaISbV17t?=
 =?us-ascii?Q?xPUB9iITvAdmxnYvlaQQoiWwufPr4jS7+MvZ5fd/2qvdS+HX5JpOSO4+G49l?=
 =?us-ascii?Q?d8pzXiT+p5iwg/oEwcTowzBYUs69rE89uzJDAg+24Wp86pxMBcUHNZSp9ou+?=
 =?us-ascii?Q?9ysOdvj0kICLzWpHGSZKYXFG5lCr/9r3NGs9s7Nkdkn8UgPBcMx0Sntu9cpk?=
 =?us-ascii?Q?sqrOjcX5240Xwyki1m+CV2BO5i7BSt9DsUGdgEkd77YUqugpYeZ+Kap62dgR?=
 =?us-ascii?Q?wjG84Zbwoj/JEsYP+HeuBv19Pv9YLvbFMifq+EqlHW3wg+DbQIFs2UWE31iU?=
 =?us-ascii?Q?FibDYdI7LDB0jaz8VlSatm8n3Av9fPIm1MoVf85WVzD9MH2PZfpb/MOsPOwi?=
 =?us-ascii?Q?Sx6q0k4yEDPgxnykG2bMfinP8NmzxNaIQ+CopQs0vQxwpyuscmPwh6aDl0qH?=
 =?us-ascii?Q?wsVN7yw8WArldNiCTVB57OZFlYHb7WxbbC/yl/paN+/zjM2cKeK7wKsTmwPk?=
 =?us-ascii?Q?LnYDM0u76PVEzqEPFefqNGxY3OPOgWZoMU10S81HOXVpdYOScnHYFyRby8uv?=
 =?us-ascii?Q?g+oscGf0Y7NBklOZMOy2FAykK3dNB+O6UICtUsPGdEmBV3NI8/wP/ix0ZUdG?=
 =?us-ascii?Q?Yf4oJTWhW32xPBVmjlEspBgf5hkIdlc8WanTcI9SoSBROB9oKQNyUsLkK6fO?=
 =?us-ascii?Q?7uM6DAP2wQfB9V5C4Rgt98O++lokWc2bYo0AUUCdArGhU5eqo9tVawHcMKqf?=
 =?us-ascii?Q?gQnBOjNr97efIWe6NRIooevQCBeJCr7Z/qlkwWr96Tqi3TExecELp2/GPUJp?=
 =?us-ascii?Q?67D/mSwnygWlY8n+H0ODJuOFCnmN5FO76cpjUG28dG6NupSmIf4Gcl06Md6Q?=
 =?us-ascii?Q?/p68TdKZTTnEPVNodVd3bYaAZnfYMlqs+DagAKpVOxyYqNhYnJf2ilry/EjM?=
 =?us-ascii?Q?q35bUj+o3nzttpQslyP9aPwyxdMf3vjJGe6Vkhp9yphdQZToBMeP4ZfA14cZ?=
 =?us-ascii?Q?tkfNYj2VxqEnseLgQL90lApg3DvnYEqiJpD+oMzbTq7gubsDnWyPii4Mg7Wy?=
 =?us-ascii?Q?tkbQB4waTHCEue5OapnCFUi7H/pXFXuMUlbVW9RpDshYW2KRtPJ7OkUpoBZL?=
 =?us-ascii?Q?+ZTC0+Sq/I41KDkwbtm1iHbVWYSAiOcT7TqHOOAtHlXGI5uLMrpVma7c2ZlJ?=
 =?us-ascii?Q?ZVHgLpWeLwQM3UkqCrd6Fxf4RlogDzXQU8l6KUlemqg5wbhoybC9ZTykxIYb?=
 =?us-ascii?Q?Kkj5YJfFD7QMc3dHLLYh1XIhAPnIk2R753l3VQZ8LCb6gYedDrNOrIX5u+9d?=
 =?us-ascii?Q?2Pd+TQUODtQPgev9YklwAar7A3C1A40XYdnwXpfeqsViXx8XI9ACEpWsHglT?=
 =?us-ascii?Q?K0IqKpwBLLY17s0Ew3QHsaEasqkEFN3nozUJU0tuTnIiIzRqSBUCCkuXhHYY?=
 =?us-ascii?Q?a3Q1U4Y//3L3A9f5EW5MlATo8lFXdCzSXUTJE2S6hhU8la56GgbV5qEBb4Vo?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ghSQ2w3BLPW90FpsOdP6uuGLtpg8Owa7aHrwwIoYHQt0kPpNjDzz6ffdyl8T6YDaXAXeW3SytwT59mRYuiFB4fo4YmKAMXAwK5mKeRs1RguBurZpw2hz1JfytiiXul/jHuwU73i+18FvHKPTyWFoz3tgBeHOJaVWo3JdWY8Kxi+cDqfRw0adWtSn8mBDV/+p/nAqlwYqo4tGLgdMq6pmaMR8qqLHXbB1eGe559sCldfeZ5Ow1zc0FEwceIR1sCLWHihWoJaeMKvs+7ndfklBx1Lz6RrGDOLIG3WxApCWBCTy6VubWQBA30lDvqjhdUE1p8OCzKaVgbkMdjKF7efagsatkmNksR3gqFdulYvLpqsCh/euH/gOtXLeWf/qgZoivZJczoJMZj6qX9MoYwsUtExeIclvYjRjCc9qkEflQZuKF40CNF7wWIut9Pj27IcbgKlyowx0NA83xgQxLRV7dViLlhec/ct+3W29UqaNe0iQ6mKnD8prlzhBt12Y4YkWVPY9zygm594H/bscj7m1SdFeT+ubPBf/fnPiDAV/31T1EYs4EfwDmNNSJtff7iTUICT7rb61ATjpgDGYHi/iqoSBVUKZk0YwH5rauf7+4/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd997cd2-ae12-48e6-38c0-08dc8c50ee08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:03:59.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tApI+Xdj8cRmkQHNGdqumNkSD/l8IB4xqhSGvIodNacYkbLp6I4w0v2Z4IjIqaKme4HBEdz86SBkacT+r96NWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140061
X-Proofpoint-GUID: -vd3GrfVQM8B_0_h9nMm7S67qBNuTsBo
X-Proofpoint-ORIG-GUID: -vd3GrfVQM8B_0_h9nMm7S67qBNuTsBo

Currently compiling block/blk-settings.c with C=1 gives the following
warning:
block/blk-settings.c:262:9: warning: context imbalance in 'queue_limits_commit_update' - wrong count at exit

request_queue.limits_lock is a mutex. Sparse locking annotation for
mutexes are currently not supported - see [0] - so drop that locking
annotation.

[0] https://lore.kernel.org/lkml/cover.1579893447.git.jbi.octave@gmail.com/T/#mbb8bda6c0a7ca7ce19f46df976a8e3b489745488

Fixes: d690cb8ae14bd ("block: add an API to atomically update queue limits")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c   | 1 -
 include/linux/blkdev.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index effeb9a639bb..cdc7845260b9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -254,7 +254,6 @@ int blk_set_default_limits(struct queue_limits *lim)
  */
 int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim)
-	__releases(q->limits_lock)
 {
 	int error = blk_validate_limits(lim);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 24c36929920b..f798c9c6eb30 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -904,7 +904,6 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
  */
 static inline struct queue_limits
 queue_limits_start_update(struct request_queue *q)
-	__acquires(q->limits_lock)
 {
 	mutex_lock(&q->limits_lock);
 	return q->limits;
-- 
2.31.1

