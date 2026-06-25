Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97182D7393
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354568; cv=fail; b=IjW3oNAlgmt7cH8rlMsRrR/qs+xRrspl+8hECkvy0on7i8Z7uCRfvI7C/DUfwIDP0/MIPw4QjOYb1vZlYDlEwFwhgT0B6WrH3c0HlqgCMD//YeX14tpDEY4hgKSiQbCgh6lJR3ENXHUp1NkRne3d0OS3LBauL7Wb7jddqPpj4dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354568; c=relaxed/simple;
	bh=RHE5aAg8gFFJc1z0VfQzsiG7v91q1z3UttEXOx2ioDw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Th11aPpmu/uEyeI3hSptMgmIzno5eVjQQBkjV2f9J6UMm4LupkdcbzV4Fq7E9w5cJkpT3aHxAwS9bqYEsBOm305oxV4qx0UgJl6uGV5n4L9xs/K/4WGHfKcHPQmvxXX4kM0mlOZe3JCYsJ5Eq4/GGGoe6/X3EZu2w6ojV9+p4Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jfiztufE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vQUa+mad; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfiztufE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vQUa+mad"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEXSkT2590330;
	Thu, 25 Jun 2026 02:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EFl8ZeXgfWwOpfEhbK
	W9dBgRY6z0xCB4uSritn08q+o=; b=jfiztufE1cNBlIoJceAvXGPd1+cyy3Phtm
	jqMVXvxDNOTB8ISvz0E3r5oxxi/ddzlJmH9Jqvam1NwPfluSzbBbW668kd+W8bxk
	3ouTWh/3ntaXOel7OqksDIimvQN5ram9Ymv2t9RQMg2bKHqBgNb8N9sgXAP2+wyD
	E+eLQmrP2ovrCvMrFgRTJmii8p1g1VCYFd+hflMfbOUQmK8PliiBKI/GW8OUzYC4
	s2eLbuaw+viybASo8orRn6DK0uyAX37hQtNZC9EyeNYwnHCt83WJ3PCUwih7ffnI
	OFF1EpseaPf6q7nMUa6Absvrn2VtRuCy8BJyD7QIfTQSbvdTs31Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhf1phvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 02:29:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65P2S9cs029539;
	Thu, 25 Jun 2026 02:29:20 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f05s9rsmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 02:29:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq6zJMnIbKmTkjQW+SwDqIer/OHI5gpn62shLVqAzh8Fh+4Qa28mVw/KMjqraqOB0NlY+C/ooWYvC8SCq/WgqPgjW1wEuYCbdBMwIrXGBDSOgXQUuEfNy18LeowH2pK2CsYDbLBPKLHxv5xqgyNCmHfLdPkH/AK+PH+AcA2IPt4Va7/KBKwu3D2CfvwOFmLlvVA/suYKmkKPH6aj42OMZ1wb+5QUHE/w5Ch73JKQvu5tCdmG/nbahLmbBwB3ffao5dJHTwIkJzklHEvdr4/XSRBmuE7i0BkaNKpLlBGlw0/rtMbU72B9F53PQ81tEflqhvMa9xyFPVk/WroN1KPZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFl8ZeXgfWwOpfEhbKW9dBgRY6z0xCB4uSritn08q+o=;
 b=a1Wv1ed8Ko6GS12a5HS3Wr/StgDDEdq0lyqR0j44o1FjoFzP7khuW3PNoUAmknwu8Ww3Lu5ok0UIvyx73B2S2MfXcfgUCUi/wftdAsDbQP8LTW43L/cXcv525EmqBA7CI5rJz3GZPU2qcgNX0pr7AdKFhto8TzLXELwASyQORvqKAXBrZNIgcAQ6wivwov3qfP2/KoIaR4auDIe2cLUubtlXeAlWOv9jr3ouoagsA0j+j1VxTi0UCqe6QkdAWebasikJ+z0O7NzCTtQRXIIFnVTM2IK3lD9tMNtHqSVIHfIWTheUxJiW0Z1gbRzidaRWsT3cpP3WqYTDtuhAAy/PvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFl8ZeXgfWwOpfEhbKW9dBgRY6z0xCB4uSritn08q+o=;
 b=vQUa+mad/GHTD2U0x2Gk5qin0/CHRegFqZ/3VswimHfvddXvgFYoRpn6OXWpojer876Fl2zNn6F1vgotlOHtPvTFr4lO8I1gsEm6xVWVWFr5J+/i12BbuRQt8IAxAM3zSY1sDK7L/2QwdOgcQwdanpM6qfRZUnZFi0ekL/skdJM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW4PR10MB6605.namprd10.prod.outlook.com (2603:10b6:303:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 02:29:16 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 02:29:16 +0000
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: handle REQ_OP_ZONE_APPEND in
 __bio_integrity_action
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <CADUfDZrDNT5rVXE_zSn9-MT1YwZvN2ynCSy_zY4xt-jx_SyuTw@mail.gmail.com>
	(Caleb Sander Mateos's message of "Wed, 24 Jun 2026 08:42:36 -0700")
Organization: Oracle Corporation
Message-ID: <yq1cxxfpfiw.fsf@ca-mkp.ca.oracle.com>
References: <20260624080014.1998650-1-hch@lst.de>
	<20260624080014.1998650-3-hch@lst.de>
	<CADUfDZo4hysS6qj=Z=dEzVk=DQe6D7-zTFODLk8RGTJ13RY5uQ@mail.gmail.com>
	<20260624153856.GA13186@lst.de>
	<CADUfDZrDNT5rVXE_zSn9-MT1YwZvN2ynCSy_zY4xt-jx_SyuTw@mail.gmail.com>
Date: Wed, 24 Jun 2026 22:29:14 -0400
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::21) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW4PR10MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ada69fd-25c1-4ae6-865b-08ded2618d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I5ikrLwZQ2g3GI64RQTjJzRO+XfdB0kNnH3hw9B00JxFq94bAiJoGagHGotZQMPAXVbNHi08riMZRGUGnXFUT2WqByJpEqPg9squxCz209Nio2z4gk0YDdTUH4VfmpSRqM+8sZMYjI5xsj4PkqVmd3RNDJ5vWs82Xq0kWLK4Vq9fhNfF6h5Sqo6EsIe4apuwjTFpmS5dda12NRJ0QC6H33LT2b8WsxpStsh7y50dwaQQyvv0np3N3IwkYMz+7yfVmV9aHUNEIRCZjWl4OwTC8zGI+Y/fmz2tAvYBXBCzKD2Nwdt3uL4xjmw5hLOUHYS16/2/PmTqpPJFNRY/G/DzEYbsFwLwuZgMjP5GNvowIDNsv0oUlz+g2EKoG4FQk6a7GAGiUAxA/lcU64JiBrQMYFyntI5+1Om1QziKzZW2PUIz+6vM94OOyn/dkVruLqcw9oJUKgQGOe3pF4jqwTlA75F8JHedZdDfhseJrQmKWNKE+fIG8RZTMrUMaPoaFxxYEgJfTEaiM+hwbF/O9CN0IdATDz3qC3gmzJp6+DRPBsX3e124nzyjtG3g1A0jZQWqlv8W3mzCaxcbBxYMbrh81M4aQT/8cf9f7GWKN5jzwbQkjuEZzNe+xJfpFzaX0EjIpGp3IukJNJfTygK5JUBXX/3wOo+kxd1tayiXBAFkMiA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?faOvIBnMGo+ub33W6UFc+8aLio7rHRCwhNMf5Q19gEFAkC+gNhzPlOpM/WBS?=
 =?us-ascii?Q?qRGmLBjkth9yKh3Ps9M/ovl9Ta5qN4zUpaurJyGdI2QmDLEhvHXv+zi8g4nC?=
 =?us-ascii?Q?8zp2CZRnuHEGdEb/jvRhyU5U99bsFY7tHJEV64ttcDOxwj1RU5Q4PlR4Z11j?=
 =?us-ascii?Q?oSjuVB1f06/l/yfO1e1f+C68kRaroSfNWr3vJvPyY6HkMJt+vIl8EYYu5X2E?=
 =?us-ascii?Q?U0gI16ZDHzb/j5dKPg/KRMrpJQHPn7jEC2TYE+G1OBKOChhhS+a1SmU+flH7?=
 =?us-ascii?Q?W2TbBSW37hDutyDSiLu9DODEaOeCylhz7ntpUPZqw5SPgkTWGPQpuA/t04RV?=
 =?us-ascii?Q?plJWoMNsOmD0+4WCZ+QUjmVhnWPBSGte86xxqYgCxIFrfID0uLyxIuqCfo+m?=
 =?us-ascii?Q?drti7L2PlGh1hR4PVPKwrOpV4YVmmpLqy6Syxbh+5ILGkw91wvwG4JO2YG+y?=
 =?us-ascii?Q?3iMnoJQV9M2yXnBBV0aqjVYjF/v66nupioVRkzjIHx6miM5W4JqaGUkODd7u?=
 =?us-ascii?Q?PulL58C1N2ZMR54/y3f1Scq1GTcXnxCNkv2iH2EdVhXL6o4LN5Es8FxI4cjD?=
 =?us-ascii?Q?o3SymDD1Kpx/m16leQEYsM+eUeHAj0VZNh9VrzJMM8inDS9CU/HcJIIf1/4j?=
 =?us-ascii?Q?IQ1ZKfeERyXDV0hZEP/cdun9KB7pFsCcbvT3TMnzhPyMuukgQv4UEgxDR3fW?=
 =?us-ascii?Q?W0DsiAi0Nh6V2AIpKusNA8fmpFmohAt8z2Hym7O7Z7MefT6gh0XgyHUHrfL0?=
 =?us-ascii?Q?zukGN/wYntjlbuZUqAdy4ZbjrM55Rd1wOMt8235nS1yAifowsCWz3Sp9uPQG?=
 =?us-ascii?Q?kdbWB9XEt4c/HYUytg3/3lBaAzuMDGLJ2BT14Uwu75g0mhDRcku8Pmi5OCrZ?=
 =?us-ascii?Q?bEBG2F81RHTWu7oIcv+q9kh9dpSF3hdZgtkVffotmof249wGMZXk1xzW0D5H?=
 =?us-ascii?Q?Z/hzLel6QaXistDA4WH8fpjUmrVf0HaJRo3oU3a5GhVzmVn6swz2g3VTrHXU?=
 =?us-ascii?Q?s5/sp99GfGStPGsrMjW1heZYEGwVfaebfGNmcHLYKlT/5NIZDhAj5UlrZ+Zg?=
 =?us-ascii?Q?MSckzm98sJkPCCM0hofUMFzEs7iLgjuHuNe44cmRNVSQOptK0ZyJR3a0ZLJb?=
 =?us-ascii?Q?Wuv5hC+T+5HcPdjCBb7XghHWf4MFx77tXcog4RLo2A5xK+MDAQ+hmxiEMgTS?=
 =?us-ascii?Q?2bPmX5c7BkRmqh2mbpmCffswO74Ug98sbf+3gRgvhiyz3BgUFC8q0sjwb0z1?=
 =?us-ascii?Q?npg43UDh+RQC7Vyo138+M9luxf5SLEUuHuXuVtdWxuL7MRl9UurTaUWefbhI?=
 =?us-ascii?Q?vKL865KPwj81wFkdCPyV5eeYmuiDYIrViz7xHiUn1ksGeVr9mAqM+3186hLS?=
 =?us-ascii?Q?3AyQpMgwdNSXoEVGC7ynisQHtrm2D9Lh3JyQpJltUz5noc4XGScq9PUZBpp7?=
 =?us-ascii?Q?1orRUi7o2HOdybbHgHTKYfXKkKT9le/s2rWrBVSaIByyqFwHQx9Z9FG2Zsnr?=
 =?us-ascii?Q?z4+aSVmlBfhIDbVxfR7IGi6fjeEqNvWtMkRiQDE3KVthmpvG7uU9u5i3iMrS?=
 =?us-ascii?Q?g1pDhwsyOY3vyKnRKY/euDulPCK9QjdKP5aWx6h/guw2dKMCICzIxlItTUZf?=
 =?us-ascii?Q?bB2IAiDPQ6dx1bflBeccdTM4j0xCgPsj8cWPUW33V17w4uqryAnFN1WHjM/B?=
 =?us-ascii?Q?tXdtwG/HY9wp4nggZnjMrzNHeJ1QQNcpWjWMWNswG95R8z3XK8cvWToARYM8?=
 =?us-ascii?Q?HoLPqjmlaeW9yKnbniN3GAE92YUSHr4=3D?=
X-Exchange-RoutingPolicyChecked:
	NBqOd/xa8iOFGajqpfPN0nE+hB1JbIQHivNLpbqNBUMaeGunN6QSFAC51grTs5rJfUOFtL6Qda6uCkNUTf8Dmr7YR85w4jCGZL2eqD1cy9Jj0sJUNV8KKUq3seYbJnDbu2oaNHrY30WF+QhZZH54qdHi44V8TxFHPNmdkcIkGJhA3rgOzeS2O5rFQ39E49vjd+BwDNrfpiHGcBFknTS8fiAONPe3P/t++7JBAr2lt86vqBmVzhPkbX5kEFKra+1yrTfvj9kN/yibYoa2ldyh0S80x4g1x6Hxb0vG6yW1OK5QjxKImlqOtAVkGi0FpqZlQ0vEaZIXRVdio/L9a/J3vQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jXA6gAfqqtNu1z19gLPzbpipvquEvkctCnUyZEMFaywMeZX3dIy76fcZreLHiklgH+Vx5pD4KmAMex/pj2Cn1wvj99oTAry19N02r83Gu8PPCtw1DcXScHhwk5zzKw9a7srUWQIwPBNR1CGTzNzVAU2Of+oSC2GBzfWLvGn7SDw/sgZQrqARjn9HMAcq14wXN+t978BG0xc/GJRTHh4Si6JoqXor37qeJuH/DxiSeEJYAp1/TuQxJpcSoJWxIugmLmssDbAKxxigI34FYMyzYw/9omXAHJnPgaS+W9zwUAwq/N53M+xb+L2bs7f7x0kXP2vV2Y64ZRks0gqaVBhSrmStk1CXA8rbJEG62Ucw7w7GLTz8oNwGDDcgxpw6pBVAuU2oTLq+pzzG1DeqpIo/M/XiPmbGRI2QyCXcfxq2A6WKCWV0Q1wDl5vil/x6bdF72v2T7YENYmvR6L+ZOA5d8qG5X5NZ69Oj2rvhnwC+2E6UKOgbANTEomnlSyzFq88Kfny3M/k6lgzM5dJH5T5lXZ8jVJNokYfvwu15ATIzQhmORKVldJKgoowAU4U0TBH/UlvL+Rjyy+3yPebowqhusMfL87VjwFZuKzBPTtN8gnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ada69fd-25c1-4ae6-865b-08ded2618d9d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 02:29:16.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ke7dbD3H2oc/iFD6MajA1STHyX0sVQwr4qe4ssyEsrbhkG8pHr+G8Dfq4CeRj+LI1QDAelqgLCHQo+tAxcxM41kWRH0LkCWlQvj0ZRBojo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606250020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAxOSBTYWx0ZWRfXyPD0DVz/Emol
 05BKOP6VUum8uhm0jgUllaZYQ8KzxtWtYktzk7wfJPBJOY+gwUZ0i159TJqibhDla0G6wM0aGTd
 x56G7EaUXZW8eqBUiz2D4dhjyeBVUfY1ILM+JII5+0ENxjUK/6E+69CpUtyPHlbf9Whs4EhankA
 qyD7W410rirrbjrRsNSDQ9ooDE1pRfppvWdd6fRV34bQPW2puEjByaPZAPp5/35TSVZCd9USaAw
 PHL1kPWZDI7CQz8yZAA/OH0HCEGaFswQsU/ugsPmlVRHIRWfXwXJu1gryXCIJXH52rbkE4suNom
 3rQSuA5OLJ8CUenFrtg4UawUC4IscSRWCYUYjvAvZMmjIAwhysjG0uBCKQhsoL2CLpUzx5BCx5d
 i95qemZ/JZQj9ZRc7Doe/eA94ARf0jV7OIpQU7CW2qeH8X3tdUVwi/+nNbfafoARCNep2xnR4Yz
 EKc1ADdrUVsUqFFp9xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAxOSBTYWx0ZWRfXyS9qzaFzT9Gl
 bE4L6t5OM1n+cXhT0fGd2SYx2yXxxShkYuEdTlO3XbpgjB9IeNrYeFQP9RJizpiYqjj2p2g4Fz5
 2Sh+MIcQQ9ZIads0jtVHE1lRFjS5Z+5+R/I1WoXa/rOCDdAwjzx5
X-Proofpoint-ORIG-GUID: 5gtbL4UO3luTi_tstsnAQImi2Nct3WXO
X-Proofpoint-GUID: 5gtbL4UO3luTi_tstsnAQImi2Nct3WXO
X-Authority-Analysis: v=2.4 cv=A+lc+aWG c=1 sm=1 tr=0 ts=6a3c9281 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=5P_jiD4La_DPMTnUGk0A:9 a=WmVTiCyuxqgg3mnwYu6p:22


Caleb,

> Right, I don't mean partitions of zoned devices, but block devices in
> general. I was just trying to understand why the remapping
> infrastructure exists in the first place. Seems like we can't remove
> it entirely, but we can at least ensure the ref tag seeds are correct
> if it's skipped for a non-partitioned device.

The entity attaching the PI to the I/O decides what the seed value
should be.

If you are an application preparing PI, you don't know which LBA a write
is eventually going to end up at. You just know you are writing block 10
inside your file. So you generate PI starting with a reference tag value
of 10 because that is what makes sense to you. And thus you set the seed
to 10 to tell the remapping code which initial reference tag value to
expect in the prepared PI buffer.

Once the write hits the bottom of the stack, we know which initial
reference tag the hardware expects. So we remap the reference tags in
the PI buffer from whatever made sense to the application to whatever
the hardware requires. I.e. an initial value of the lower 32 bits of the
LBA for T10 PI Type 1, incremented by 1 for each subsequent protection
interval.

For reads, it's the same thing. The application wants to read starting
at block offset 10 inside the file so it sets the seed value to 10. At
the bottom of the stack we know how to interpret the PI returned by the
hardware. So we validate that the reference tags received from the
controller match the lower 32 bits of the LBA or whatever the correct PI
format is. And then we remap the reference tags in the received PI
buffer, setting the reference tag to the requested value of 10 for the
first block, and then incrementing by 1 for each subsequent protection
interval.

This allows the application to validate the received reference tags
without ever knowing anything about which start LBA the I/O happened to
come from.

Both DIX and NVMe also allow the hardware to perform the remapping so
the software remapping step can be skipped altogether. Christoph and I
briefly talked about that last week. We currently don't take advantage
of that capability in the NVMe driver.

-- 
Martin K. Petersen
