Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4473CFF49
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302144; cv=fail; b=r5x+7zPokPVcPO+NGLN7Hy2ns1wzV0NoV38E3wo3bV/ZnSO3IdJv+AkipGr+ymUU8qmieyf6oeYtALvajE2HtuBpALleW1E1HCjMPtQEgcxjR+x6LP1Ell8t3ZFxWVVlUUSDh7PVaX0viR1ZYNCzBwpozt5Y+CFxn6jcIiYF/X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302144; c=relaxed/simple;
	bh=rJvzFodQwYYihdrTm76dKEP20s61afo5bj/o+jWPwNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=guBNCpOGOn0RRuTrlzJyoBmlIHkV72K/TmHEoZfuYn+Nj5W07Gm5X9L5GdYrsZdtpEGNPcTprgVAEA5PT5kADLUDexlq37v4xYr/rLzJMIKlT0iYteK9Nu5rNP0GUUQ7sAt/ml0dkkEIuojS+0k2c/InfBMzaSlbiMwXmouXJKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HMx3QTg/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pUBbeHxj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HMx3QTg/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pUBbeHxj"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L3jxEi1477885;
	Fri, 21 Aug 2026 08:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RLvWt3imm0ZlVv8genaB1Bgx2d4YJ6EUIm6Q+dq5IhI=; b=
	HMx3QTg/EwvCzbhr1g8bBktRxG0X30q/WAEndcFjtx9Zz75YqdCfEKLwUYmf8E2p
	UrSwDVyDXQ6Lw98wPpUSdxySvX3FkaP5pW2EmxC+lEwyTpcqpw6fcC4Mq6avozdj
	6iGpDCL6q6iNeB3jyVwV/20MWuYeCIcdILAFDum8K4REDuWyXcf1cQcvOpd+b9TS
	WuEWo/G3q5UZx17xEVzu2PnJBd305IOCg6bj+ECqiCNtBSr9M9ybyUnzVGNElemq
	+n4YoRgAH8v0eaQZs3hIWu0eKVEZdUapeEkZbqs0BBsqWkKIfQoTbOBpf7T6t+Vn
	uOLwRAmV83AJgMUvyQ5RRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydempm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:48:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8iYYx007185;
	Fri, 21 Aug 2026 08:48:49 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32hu5n88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 08:48:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4vVeTx91FBYYB2MT3DZIksP84LbG+fXhWDEAZ8aDHgfRRiQE2YJIgWCWX3NNi4Eyj5/oSvlEHiuywWSO8bsxcDmR+y1RaptsCva+p51BvmndcKbdyxF6sBLYVpSYDaIVFaMaIudtRegSQauN6zFma1TFSE34XT+9xxBQe6SUzTdS8XWRP9zsdsNm0R6l0MxiqOAVXUqMbYvYn2nRohu1f5UlEzM8iSwVTp3G9Ao931neJ8x5KZZwXry+1aryxvbHA6tdjCevIKr6O7pR3G3Cz0ONNRW0mhxYEJwwuG+kig5gjnGO+SQVyVXD+SxzedJAefOYWbOalHC9aMMq2I2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLvWt3imm0ZlVv8genaB1Bgx2d4YJ6EUIm6Q+dq5IhI=;
 b=SpV2pfLKQDJtxONeWD79E4ogDYi9Cg80YMHzwxPxYbxow4HG8DRwb+YftZhkIWydoq2rtuXjoNQIiTrctTsJZy+cJHLPEMDSAJISv5bSaFBubmycasE+7XsixO6nP13PYcye4sfpcpvQZzHy6qUG7GVgbXmXu1ANZCFrBwRudkElst+60/AXzxQiwQW0K71X6glyVYERBebKDG1WcsjOx1vGso23XNcqHU2iLc/PUaU4nJ/ytemJxzmeEiEzRd7TZQbgx54uXi03cJD3zl8xdkp0SVXBvpps3RUSzC81a7DfFba2ZbYAKDLRDhNjOd5Oj+fXSJL7xcKU/wjV6vinug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLvWt3imm0ZlVv8genaB1Bgx2d4YJ6EUIm6Q+dq5IhI=;
 b=pUBbeHxjTg+6UKK4BmhKAklrZJXRGKsmvUytLLvGdXHLhWW1jgmsN2PhZjsNmEXVmW+Xviay6lVhUD7uZ2KjIc97ibZsmkvlu/BSduqcE4DCFyAdOiyycd3frMiGg42pDP9ef8xSUiPwyK23pBmOlxpbCIc2vxsTiH8dwlYhRkU=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM3PPFAA42ED99C.namprd10.prod.outlook.com (2603:10b6:f:fc00::c41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 08:48:46 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 08:48:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v3 2/3] block: don't show partition diskstats for GENHD_FL_HIDDEN
Date: Fri, 21 Aug 2026 08:48:30 +0000
Message-ID: <20260821084831.4155943-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260821084831.4155943-1-john.g.garry@oracle.com>
References: <20260821084831.4155943-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0133.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::20) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM3PPFAA42ED99C:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ffd3e9-8a00-4dc2-c89a-08deff6102fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|5023799004|18002099003|22082099003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	JeJaSRu0+cpn4u7H0jGtfW9EJ7qH9EPuGETpYsW8LPHNIy2MFAV4RmhNjFkIEjUhJxeEmfWLiQt917UuypUQ6R27PbM/9rs8gAlAHbGgz88M/xX9pZsXv0q+pfweE2TO0JsY5wsERuwhpzM/yFcUAtwi8+vb7cmxznYP2IPQ/I+l05wWVBCW1JLBejPESUwKpZUwVKvu0K1MBLwfPZoSXXiP/s4ex+IcwYsNuJbnyhjp8wLdGl7Tlmavs8xLzQfKm35lrkFdWfIT0pTrz7HasSC7a9fN2lrmSxBR1xuEB4zhUeImA6dBVGq5EM/MRaW68bnYEzXSYrw7kNzCKLUbrIWGa28utMsbH1Rq/wQc81/eAUgVnUf7V7posafyANVDMnGu9wqmeGNguFYo3/wJwHyMRLDS0GCQ1k633IqLvZzgNhcsCVb3ZCzKde0D8592sw8b9PCpfggGMzKeg+5HVr9oeoFsHb3ogASEcm3VEc+AWxN6/GhC5HuHQC7EfrFNnf4YuQIQa8fHTD3muJRLeIXpTNxT+x05djjyiQUVqOtfVlSs1pybN9A+SnsI+vSfhJGSO1tyx1UXHkUkFWgIw+tkWYpAwiOkVJ1xyTBiYDL5YoPyHMoaJbLm0KmdQkBErjGBNMUPNRO/n1mQXA8FZYIesknjgOyBHkpLyzbtE5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(5023799004)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EhPo8PSAOqvnOaM7YVz2peP9JeUg9cDkjfzb4ep1yeBJFx6GDlATu6Epzcs9?=
 =?us-ascii?Q?/Cc7dTgVOBR4HQyd115ayOqxfbx1BfYjI+hrqno7tT4mciL50IED5bhD/uY8?=
 =?us-ascii?Q?Gf/Sma2RkQnexGH2r54kBxEZowpINb/dFvGWtWs9zJnNlX9KaLxBSJ4Bh5Hd?=
 =?us-ascii?Q?BUk/qMsoIsvVrEbX0JS76x7byCJ5MBUET+dKKwEtQdewwhMOZpGXqEnkWGtr?=
 =?us-ascii?Q?tvanQ+ybmcM89NkKsGm/6yE0k1dRc2dLGpa1YiBNR/PV7TebeLXNHAkGqGSp?=
 =?us-ascii?Q?9VPFJpY2CGOunWuBPRBR3x+xcAlA0u41+k/BZz03tiQDExvuFPkTlNdFY5Ds?=
 =?us-ascii?Q?tEETEKIUvdaPW6JFutnammQfdP05LbLC0gr6FKfTsaSKH1whX3Xnc6XH8NO6?=
 =?us-ascii?Q?c88hYuWmkNDNkudOozyEArWEOyeHGm6MmZ4jiwF1ABKzh1c6o83OYq1awNEb?=
 =?us-ascii?Q?ZuOqSflCgPU04N7fQUvMLhnO/vK49TQaDeJrkVaUX+OmHYAb50lccV3CnOS5?=
 =?us-ascii?Q?IIg+gjsZzlORhzGQ+PrqB1zPd5Mal59kAntNTGsrtLWPYcRZ/meYYs64BVbE?=
 =?us-ascii?Q?HyYEQ9E+N+B6Z38va620aH0DHdWoDxZq1GeZsqZmXCozVkpNEfUa6JyGuCsv?=
 =?us-ascii?Q?ungiGfQ7dmcgSYQMa3LYY5aztmvzvOHZpkFE50kcQutqn8WyAsizP/oC0b3n?=
 =?us-ascii?Q?4UBNeWSWHdOUnjQjWWFvzWqrfcA72mFEQwb25M/jlRU2YDStiMeN80elF03V?=
 =?us-ascii?Q?usZHmwCO7I13oN73zt6qHf2EHByT1W3n7LpFp7BoxhTv4kKNY2BBOWcpJP0e?=
 =?us-ascii?Q?OuXdAnmshtY18ThkXTduRi/71wWVjTXLXKyoFIjVSFoX7G0NBABIDBqmfV2G?=
 =?us-ascii?Q?4rJN67/VBaYPoSL/qo7fzZTK/juWkCMDrnqNMROQjGqF9hVv6lC1aziZruAK?=
 =?us-ascii?Q?nTeTdaqBmDnfjz2cUxswgEx/ffFBJXoOXaLQXwuEmhdd+ImYQD5QcUStpSGe?=
 =?us-ascii?Q?Rjy19uhYYeiPEXP+5SlPJ1DRe/YqnPGKm2x2FU95hYuN+49m7DcE9WarJl2O?=
 =?us-ascii?Q?VxieDDFdlxzPRc4bNeobe/99LsJFmxL9NQkxCyVT1rJvK0Ph8LoByavQzbr7?=
 =?us-ascii?Q?3olpagmBggRMGHr4BmOsgFgil0s60uJIAselGigG5pOqdAldULeLT0uhzn8f?=
 =?us-ascii?Q?5sp0eRnZu5REATUvM4twpwLgwG2+p0T2bbtWDu8GerN3JfzXwGDZBO025eFh?=
 =?us-ascii?Q?1DKigX8JWGRwcVOBg5Jm8eRFQu9CL+n7LiMKL4LNHsaB3T+SGTJkkaxxXAx+?=
 =?us-ascii?Q?CRqv2mWYbJXMVbQnRVI83IMABw8ERExu6DwGNonTD0N+Jwiy4p2fSm918mbd?=
 =?us-ascii?Q?Zbv7F64NYZUXKS9hLmrwGmPN1p18vyLscLyPnEBltwMC54vFgjqUj7IXc70T?=
 =?us-ascii?Q?C0dOdCCFPIOsYhwIF3QRZsGVlQ2lACbamhWJKGYM18DTTIM0lJsfqR1pGV/C?=
 =?us-ascii?Q?6BTtnmyYcE6jUXCWqN4l+Zu3FBN8MeVmAwzhGqyJTl7NXGLYyL/RekqG85t3?=
 =?us-ascii?Q?WB1cqypsEOrxz3YDPILgT7yChCNku5mhWYix7i/1Ad+cLL+jCf6di7KSluX/?=
 =?us-ascii?Q?u7/PxwYF9fXYIUeDPU2KMkwv+woykK/5VhPzbac/uxJoJOC2vGk+53Wl4AAg?=
 =?us-ascii?Q?+1l3XdOPr+zioGvgs+XnJfEhzOYV3xfAkpkrgqLQVpg6S+N6yxwnY7DRJtH/?=
 =?us-ascii?Q?9U4WoHgIo3KnI08rhZfVYC9SvcUaF9s=3D?=
X-Exchange-RoutingPolicyChecked:
	WstwlEdGHon+TH34XBGEgzqw21+Ob/u53jMBiBm7HL/caB1NMPr9JMfVAv2zZAaNzY3LFqCMEr5X6V3a1B3Rgkf4dYpmnVlgFUCEfXbEuF6wBPvyBtwwnoeZXnBjtu8oTwq3UR0f0wnKhI3XxkYymh3X7c/yrP+gE54cGsTtNbd721q+fl8Tgjbp7brGwLHj4UX1RpZ9PymeMJrBcDSQXdJ4tY+BxbJ/vMvjxsAYvnHwu3aKTWpTPk90SK//4rccTqDYErJdb204ZR3DFxTUyVr041cJ17iSguqc+NqRkDiON4E/lQZTzC0q2IKbQ421wvLUFvKCw+IKDD19MIWoAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dcWp+qddruACq2a8wmZE1zm4644AIKfIwk6NFgRx4MFl0TaRp62wXRkb6iO3bWuIfz9GlU49oPCd8YbXStuCB22f+pMexWQ89xZsODR1yWZ8MGSvCP1TFQVJCsPhEwiaquSv/A9h/fsKDo0odic0zHKCX2a843ZbR0tL6sH0mTOId2W0730OWdWeUoT1WGvwWcXrALW8QlGtLAnXzkVo5PgXSHWxM2x+1T9Tv/qJM7kd9gynSuJAMJjHHN58fc8OdSOaYe4SmivzhVogaB8QyC53VYkRZGANlIiUOP5eqE4/6nF++xbSwE5cCg/0FDPEoEBqB+ukdv8LGoHQ2Ek0FHthSZQCZIjIUVGJPiAUnBjFIyqpoOL0me6/gi8G40qrd0q6kvogXUJbc2/yrIHTPdV4287Tge1frkzAfsd93Cj+/9+XAqDtmhiGGV5zAVuhVWpoHeHrQAUoJJlEkh4ruknvEgk9PaZAW5pEu7bmqZZf77W9LgQBrxTpgjs9v3t7aCmpwhIR9QjosHmpeAwxDWexGfW0cz+s5OWdrnvHW8/oIeBDLMFuvAt36MKfKOGee1JDuU1ERgdUwYRx8nER00VzsFrQ91XXDRiPJA7k3H8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ffd3e9-8a00-4dc2-c89a-08deff6102fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 08:48:46.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhMINbbmPe2+vvtu6axw1f04DUzy2VFUnIEqKUjVnNx7yEhAduz6kcZPE1uNfQUP99l3Eq7edaO8M8D334UhCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAA42ED99C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608210063
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfX+T0IlHKcThpk
 46uG4F8jmC9Z3rMFUr2d6KHvvN5lzNccN55cbHwBJOSqxzba6cLNdZN3+llVZkSYLQJkZ2yuGy2
 HZDj0RVRA0kIv6U5R5oafjru4TQYHIU3cjqfXpUrHutyMzIXJrtZ
X-Proofpoint-GUID: abypskWNfRJy00HH2DrUhlttXaFHG-mO
X-Proofpoint-ORIG-GUID: abypskWNfRJy00HH2DrUhlttXaFHG-mO
X-Authority-Analysis: v=2.4 cv=WNBPmHsR c=1 sm=1 tr=0 ts=6a8810f2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=OAPpbdP468vXStva1QEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfX90oanYHQW9eD
 5MAbosw5xHwQ70Nnd9aBIcXvPTTdQainImCSe2Fj2mFlOM9rgSvU+Kh+N33dIBVLNSO5S/gvgCH
 W58B0FIZ1G4GZ1dL3JrrE7VZRUMlEKw3WtCV1ZhC2NoZ1CV4E7xhOKTrUpkusIY0LLqxxMCTKcG
 z0FtWQYedAcEH0l2jy2YsUX+hk/3l9RhCAvO1Ix+lrCIUYKokaH1A5neTr4ncFMx3LEvshLjJ35
 KJQTnmLcMFUZiT/esvU7SbmfrYfuOQZ/+5qXCcBtebnONqC55ZAAOHVQuKdbdqj0TcuNC2v8OLe
 bgIlLFTzag+yTuMwt19kwDhmeWi9VjxT20E/yYfXRUdqSnL81Pgn5DUZMgpf596kO1zgs64Z24P
 iqhjq7gKTcNRoLHFXdoC/Y1F7gJOkbL85yaq6o6J4hHwrnhgNe4bH7OxSY2F2ixtUuZi2Ne763Y
 /cV+oURgYMJv7LqIK9AiSf6o0TO3CG6IWAGce0Gg=

From: John Garry <john.garry@linux.dev>

When flag GENHD_FL_HIDDEN is set for a disk, normally the partition table
were not available and so we won't get its partitions showing in diskstats.

However, now hidden disks may have partition tables.

The diskstats for partitions on disks with GENHD_FL_HIDDEN can bloat
the output and is not too interesting, so always hide it.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 79cf26e8f5dbe..896369a96f96c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1388,7 +1388,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	rcu_read_lock();
 	xa_for_each(&gp->part_tbl, idx, hd) {
-		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
+		if (bdev_is_partition(hd) &&
+		    (!bdev_nr_sectors(hd) || (gp->flags & GENHD_FL_HIDDEN)))
 			continue;
 
 		inflight = bdev_count_inflight(hd);
-- 
2.43.7

