Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817FE25757
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388667; cv=fail; b=XvJdS4TFzH4DlOz6+gR8ss363EDh5uXrDxgYFaSW0o0D1QytoTM0KngtX2RNAGMSQaOC4muF3txooeT+zhNfjb68TmkV7Yj5ysIg7TN/Q2GlnbCQWZhjQF/WAooHizNvD6sRmnXoPrFtrOEx7+GscCzSzLo9DoJhYgX0SufGXdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388667; c=relaxed/simple;
	bh=dW+r15BiKzsPz/9NeZpFqaQsR0Htc97DhfyNMPnQMaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOuDNLemOwGU4BaJtwNohxWnW2iV+TnQ24k1n3Xhqv8gQwUk74VY3wmuYlQXdomL5tnW/XeN+jb3IHq+K4w8kqzPSSSHAQ0y61hc951HaOGXhSuJjmv0KE0lOAE5IZ3Q2M4rvNFGkcQaVpYsgX9TpJiJQJG/VgIkU2Ixx69jFmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nHfe18EV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AOj8Icw3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nHfe18EV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AOj8Icw3"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBKLF3027867;
	Fri, 19 Jul 2024 11:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=imqOXXWEC76V8NVu2FxzFwt3aO2hoHmEOPk8wsFepYM=; b=
	nHfe18EVmHHfzH0kjvZdofcM4tfw6wAcfUdhPbA3DyGW2L4sTMdkPq6Wyvb1DEUc
	+Ys0xsDyM7UJ4tm25Gnq/uGVkb+yamphQdsmRA5H8QcpiMHtidsodbzYqBbDFMaA
	mNY8HzLgsj0ZVCfEcG9KdNN/LCuaEcr15yfwSM4cQn1Yn6S0szNxDlkfdeEjQSA+
	sse9eGSwer8sHQh7rM8WC77f7IjowLd6kLLqLZB0KK0otPKPHkLbv0R1234ioVrC
	L+BUqT0ZhfpHl7EYPOMsDcyTTEbD33tiyVMP+W5pjeJLLiqUnJdyUzxxEQqF7fbr
	DuKhLGI3f/0Ufwb4nE5yBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JAYb6i006695;
	Fri, 19 Jul 2024 11:30:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf14crq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/M1acE9QV6LiK+rGGiGQ57PTvJy34pPCJyur+lJ8mZz21K7ONSMt0CfpZar/fRkkZcLfzd6TRULp9HnTQtNqPr/y5pzlZo0D4IldJYMXtWXrMkK+GrYuKGx9JrmW046DBsDNCE9GP7hYVzGCh5ipJK0Px+d+ozKi83OgNKb3IZKAIVEFK2O2B3hIXIw4kUd/GM3GuuebhqsL8sHR8JwjU4tIOroMOPgCK0f/2oJ5zH3LdIhwknvsRmbEzaaaam0YUzpyoNV3n8gheXikGjFx5db2AEGVgAS3x70dFm/Ohivl3Rf8CaTLwlcBcanSoJx85hx8mBojywOKKaA+Lgc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imqOXXWEC76V8NVu2FxzFwt3aO2hoHmEOPk8wsFepYM=;
 b=wM7g3O/v1KQ/g5QNZ604i5fh3SEPgc0zxwnEEDHKBo3E5FN1b1kkN1/9J8rxHGtFYdIyihQYefshqGKDMYfjDwpjF3O47IXkFn2Kj1//jDOelL83d8ovZF0zKkF7Yu/Qm28x0NLMrqITznAsT8JxFUT3qMOqv3vWrQLKSaxUTQamlKQNyvJYTmuwRhbfSjk97xXkwIoWD6qIE973eJeQUWID3KSMzuGxn95wqwgbsuC+YwsO/Q4Q4lJqNXaa/mJow4ntUoQdAhFGJzgs5Umja5JFKX1zzdMpEOZWn16927FXAfoJ4ZgtW4Ui9HedYOgYmukXDWVSR+cUCZL2X/hR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imqOXXWEC76V8NVu2FxzFwt3aO2hoHmEOPk8wsFepYM=;
 b=AOj8Icw3pJxonH7cKIJRj7OuaQqtrKdzA1eI32aCeTpy7tvwe78m49SlMEQ3kUOSndYKT9xk9ZNNp87gHfZRh72JiFLQ4a5QYV3LFkRuCl08Pqc2pWZe5W3TtV4PpaZmDh66rA8axAzv8Qdks3cBVumJK8S5hhG5OhBfmj6TlZI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:30:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:30:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 12/15] block: Catch possible entries missing from cmd_flag_name[]
Date: Fri, 19 Jul 2024 11:29:09 +0000
Message-Id: <20240719112912.3830443-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:207:3d::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d2a768-cf10-4110-fbdc-08dca7e620dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0HCM3/VPm5GtydRmvD8fKo0OMQG6/M3DUd2jJOxJBjjmBnNW/W9T7ZRpIXVH?=
 =?us-ascii?Q?xS7UVHCVK6Xxbo//qs3gO6qeaaQXHgzSUnomhOAAW2xnFVAAbs8C6yDrzHP0?=
 =?us-ascii?Q?O1mUQyQU5k1OwLNg6WmBWbgCo4P8AduZr/EsGBfWAXYfNFaH1+BPJmBfcYBI?=
 =?us-ascii?Q?XNiCv+yV+3ysRQj3FwuuHfehyxRxd4jugX/eDmMuVSFZ1QVUwVxTnf5ZuAL3?=
 =?us-ascii?Q?4vXuihGvP55wPbZL8dxQI38+x/3j+zgocwL9javviyFo6qfdVppUD0xjG1Hk?=
 =?us-ascii?Q?KLvccs9kTivSLbHwrvMZG55/KYBECpmQhpgHf9L2rnwRcZrrfRBtmdfaACOK?=
 =?us-ascii?Q?snX0TBC2aNLD1uXcH/EDgwmysOPFKXM8TZRfJRxIg66RdT31RTqBobWCi6zM?=
 =?us-ascii?Q?qjsCj1jXPsFi6L6C3ZQLHzOF2KXbRV4kWAHPM7IAclRETSm2B1MKV6JiDvxK?=
 =?us-ascii?Q?zCjGN/UD7/Iiaya4Pg+9pfjFC4HYp/Wl1ygmt9NJTJ85imqQungpvyO/JNWT?=
 =?us-ascii?Q?0uAPFy/nT4/shyzx97ZI6D95XTWqbTkYUze/HbIkV+URt77S4N2Rw4wbUZPN?=
 =?us-ascii?Q?jD6R98JgisUpa8RVC+HBg21XF4NCUaOZyzztMFsdRUZKeq2d9kFnp+6QfgN7?=
 =?us-ascii?Q?YBgcmwsMHgRBUODL3m+I3+iY5ZCRmX0/TL7JDmrNYKIcPYTNSBulcmXaswvq?=
 =?us-ascii?Q?6+/VlQRRn5qGlfhoj8+oes82JoRdNbbrzcF/rq6vbcUxUhGITbZDL8LxSeUX?=
 =?us-ascii?Q?XwRYzvCAQr55b1eHPm+cg7DSlPdVD0Bg/0UGpVaCtwdlfMRr7xnL4tyK+/+I?=
 =?us-ascii?Q?cPkhNzbZeDAG9v5IdftkK9l6kgQC1IyjeSdvG+3N/WuRXsp1rSqHdUmxY59Y?=
 =?us-ascii?Q?E/1ZXME5FikPm6j3QrxGEz14bGwp6vJHgs43tLOVigeKkvatpNEpS+JcZYVy?=
 =?us-ascii?Q?AF4U+bcoX5wjZ+ZuaySS6UYhMsrdRQ4W4VRz3D1dodF6nF1Pia80LPDyUzUh?=
 =?us-ascii?Q?kOlBTgM9YOzw+RQZof8VKBaSA49yy6bP8mJO3T7LInHtb+ozt8WSW177pkis?=
 =?us-ascii?Q?WvMoSLjYxpzoXl7j9wsUKFd9pIJrMcaOwY0vcTEEZfMPSGTFSDI0/YpPy7kI?=
 =?us-ascii?Q?Owe6s17xJEQAIF1qv7JBUwgXKXtu3K4Emo7FxAcNnFIgRUPASJVt50fImd+o?=
 =?us-ascii?Q?n7T3qfkhajFDixVZVcvxs73wutdKknCrPrvRLuG+B+eNAgPo4O1x0YpJYUWK?=
 =?us-ascii?Q?vf1SeqEMKZX2WX9Bhz/8TSNPoD5qjoc1t7jlo9B2a30xnzi6EvMylsBXyKuB?=
 =?us-ascii?Q?fFpEVF9mwUH9pe35bnrCwlaruuOoE+Xcj5SHAO5TsMUoSA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7rquvxvWF+SXUefRA6m9CANByyI5SEkrHmokSztRL2BUi6tAXAVeOAXDa/CK?=
 =?us-ascii?Q?UFxnbGqY/yEaFeWCPL7DHkkhaj3wlwpekbgfF2Jn+5oaGfLbYgrRo0aG3eJl?=
 =?us-ascii?Q?+Kwyc+uiuBtgZSepEkkP3jddAtpYYI2pIsta7M0xol6NBURQpgHU2ZoSY2hQ?=
 =?us-ascii?Q?TL2i4IeJvRc8e8x6omI3YAvRM8G1R/j3fvSWJEnvHCnABzw10D88TTy3TDRy?=
 =?us-ascii?Q?sX44xrGP98yGLtwkZrPYK0aAkUHmvW5J4cQL/HtMrhQlbY/z3898aa48/xHg?=
 =?us-ascii?Q?2RvUeQ2ujI5G1fa2MS7LhKav/lZGTAoN5AUMo3CBQ8WMYIGEEvUFu931S8rI?=
 =?us-ascii?Q?rRerejuYP4eX2dWFvnVFYs3QegD/SpavTmlWSfEAa0hGXi+T9MgBu1WqP+5R?=
 =?us-ascii?Q?+REK6lBHNhT3TXSW43G6BoC0vTdrf8of50IAgKpjEvjWgUaO+3DykDoLKOHp?=
 =?us-ascii?Q?zKhO47ubtduTe6FQFgy6NKmiIzqh1aQmEqQTnkFMX/f8zmft54CQTqMML5RL?=
 =?us-ascii?Q?o8Grj54ihFwSK3zdiVLftJMFT/0RyyV7Jwh0U6IZH4ZR9eyB4WWf2nSZuStf?=
 =?us-ascii?Q?NRMcKmru0MUntTsbPSAgct1RpRXVAQGWBjr2SSzVpqnO9wcC3lh0V26waEHo?=
 =?us-ascii?Q?3NCGB/oFXa1fw1F9v0mqJk80+aWSNPQZwa7hNcL81R5qoDzIbz6zRhl8Tbk0?=
 =?us-ascii?Q?X/PR0wdrRFj3+nVDn9DqrN49DjhTO2rYLZx5wBX7WlQhz/RAcsGqHI9m/v4v?=
 =?us-ascii?Q?5EkThaCr1WOCIBDAmzUd0+QkjbUpTWdhJORZ277WDV/LpKfMvcCTz3g4/Rk4?=
 =?us-ascii?Q?3MKZ2xovbXCdL7VU3P29mMnp948z6haKvFZE22CSbpg/gfZNKArPozN0Q+4E?=
 =?us-ascii?Q?te4kYRz1JK+Tt/2O8YQbhy3vM/BWe7SkCjJcKaimOZfpk4vPJ3uyJ5vN7esh?=
 =?us-ascii?Q?7FFWSPf2KV62FnYlPeIMnKmUWt0lpu6OMFQtat+MLPkaFTNwJwhRZOSaCLe3?=
 =?us-ascii?Q?2+BHKAitvlzP3TyOGbeLkpSmmQo/vcrI0qSkAsIjUQodqAiM32R6w722UIJN?=
 =?us-ascii?Q?KZPPxBNAW1+KkDT01tordB+02zI25n4ZsyI3VJhAFCfn78km5p5aRqorxn6U?=
 =?us-ascii?Q?PIvEQ6lJYWD80YgMm56AwhEmCGNapoPedleiQLZyGeJoYx7iT2k/cu7lOsRy?=
 =?us-ascii?Q?sKdX+4CobTNGNm3V4Q7SIlrY2n6sxejs8cEn7MWyxXlOnFlI6d3O5zhfAqkx?=
 =?us-ascii?Q?hCABbaTp7qUM7TtmOoTn2bfd53eGhRImmkZfNKbjSJGfDAv2H/5Chq/xXwx2?=
 =?us-ascii?Q?dv2MzbYkNbiDkUnIz6oGIg0jHzQaeDNvz4dqhEg5rGKq3lluLJiqCgT39vLA?=
 =?us-ascii?Q?3qxecLIdM54RLj7Su7uJKKa2dbJ0AuFm0pA2HlN0GwtlBnG2z8VtzumWQrKE?=
 =?us-ascii?Q?dRqrFWCRaEMN9lKyjtejwinE/iSTIY2B2E3C7dwKEx/hXUJL3C7n40dt62LN?=
 =?us-ascii?Q?hhE5euHIiZP0NbgD89vi3f77Ln+auhjg/6hDUjVCoEP8D5p/aDMG5Tom6tn1?=
 =?us-ascii?Q?1ZAG0U4r6cmmHxDwT41ZHnh28/Jq3awNkfY5PMsJJYScdkY6EyYnGWyg99dr?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AsupNAvlvQagzc56QoegSaZDhJyEO+coNV30GNJQTmngfPAMAjwxp+a8491K3caMtDk/vdqauIF5i++2m8wmfFVfIxPFwpW2xc3fzWxzUNRyN+eGZdfEBtpfU1jaMLeaq1mGpW9NcWyf9Iw3ulB2KBKvPQPxxndsqWZwnteAY9gxPpU6SWj+x2ibkeiqmpkK8vjVJT00FAE+KFoDKz6kZV9/WG2hUhcit08BZ9YiEz8S3GOsycTzuyjEkI7o5Pi1DzqdygJ+vsEjI9fkoTjtHumz7EK+NzPSIVUGji3CLn2e5TYg7Z8TSxQ8KYuk69qICJkrSDmUZ/kw0UnB9cM4qTGL0ifdVvgTNjFG/hfCqzXZBnFHF7zJZKDuH0FJPUnuwES8cJzrZ56wj2pX4W5CArry0xioIxkaHUQvzjfVy+0LdwzVYhaksNz0WF0uWWZI6SDClZthbvk3U8/vl/a9boNAu1flzELD2hO9WOBsqCJlgRMGOzdeYRMERheS0ozuVq5sY8Y/ubdO4mSOEsB2hiJqnhzLFbG3Jr9pqvvjvpBfFmir+CnTCc6Y7jXrnmjHQVOlT+Oij0Ajnb6L/ssOT7nwkvTNJ3Kexc4/YMfamYU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d2a768-cf10-4110-fbdc-08dca7e620dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:30:01.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zA9NU//n8u/0N/hjcrGkq+lwf3RT5JQdyBdnHTOVrjd1QFG/7mpVWUm0AohwlLZpPP2ae+9Z08KKqomsai9AJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-GUID: -u8AhD2kDxw5p_9PTzZF-9bIPcNPbjFO
X-Proofpoint-ORIG-GUID: -u8AhD2kDxw5p_9PTzZF-9bIPcNPbjFO

Add a BUILD_BUG_ON() call to ensure that we are not missing entries in
cmd_flag_name[].

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c    | 2 ++
 include/linux/blk_types.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 312e8a40caad..a4accd79c225 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -281,6 +281,8 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	const enum req_op op = req_op(rq);
 	const char *op_str = blk_op_str(op);
 
+	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
+
 	seq_printf(m, "%p {.op=", rq);
 	if (strcmp(op_str, "UNKNOWN") == 0)
 		seq_printf(m, "%u", op);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 632edd71f8c6..36ed96133217 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -354,6 +354,7 @@ enum req_op {
 	REQ_OP_LAST		= (__force blk_opf_t)36,
 };
 
+/* Keep cmd_flag_name[] in sync with the definitions below */
 enum req_flag_bits {
 	__REQ_FAILFAST_DEV =	/* no driver retries of device errors */
 		REQ_OP_BITS,
-- 
2.31.1

