Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AB186613;
	Wed, 21 Aug 2024 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222992; cv=fail; b=s2B8CD6X/6MfqGrqPIZjD0u/VonG5PYJHQfBbVQ5QeEV+W/cmyrkRrHQcHlecnDKw1esWrv+nqyYwLSnE6f8d46cnwFHf/VBQbn491s3nUVZTT5FCQiyjbBAo0dV2f+JuM5ZxlYrps/nTsu7MZDa7u6aHiimiwALshQ1+ACf41U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222992; c=relaxed/simple;
	bh=X93ur3p6TA/FVFF5nDEnUgTHHmuDXqabE8mwFDDy/Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cC5ApJk0bUpEtyWmF2gbpxL7tOzC0oyQqklmSg6qHpLfaE5/A3zs/cvDBauNhPeS29cz6G8Je9QsBPRNYGJFHJFnxqfwZ66L67TEnycFBgA8irAIIxPUHsUoyYout8+8XmZBvO+q6VfKv9ngvgV6QY9Kqy5oChfYHbf8lmtEr68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iP+BJHw/; arc=fail smtp.client-ip=40.107.215.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iP+BJHw/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssQYeU4kwZ4sbtEDWu0CZoFLEjaSyNDND11t4Cp00qOGV/mclPPvW/A+IpxBdn4EjezdrN+VHr/+PwTCz+jTdHmaGnD4UYjvJ5g4htX/ajUlVgDZE5NaPINhS/JvHSDFIFYnbuv56LOumjKAbiQEU1VOo025CxIJERK++bKZ2pOy6eOthXi/jFiQL8jLRdLuNm5pVxckB/0qIr0ivR+ne4oH9Wlr1kHo9+Q4P9NH+Y7VLCHsudPY1LvEiYs5npd5IfAtHjMjQ/LPtoBauZX+o4g3SpiQ5LlkBq/TU18pJN84vswDeaTvGz6TvdYVaT9xJgmsXBiC6hf6CRv+OhCmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxJKvW21D725Aso8seiMR/IKn7gRy5j69tKZZiklEXA=;
 b=XLWdQwywEpQnfIPXoUfvAQXkYoNWpBGwUA3SYfvyWaBww2riJhQZZvkGD1oa5VCv0Nw29lfnPxprid/g5mpnV0zYvIwPMs9kr1Zm+cNVvqTWE8cUOvQZ7bIaVjnPc18dUxBOU4e28Ml8zjsq6ruT3+2kvoZrB0DgP3XexJVJ+wjqICobLc4gYCWt3HwJJVKuPa1FnaSgEzuw3e1H6jUFaosj6LUuW8NKX7NDg+Sm7Jov/z8uRC/BkXZtcG84Eco0lWkvbFT1kLDym5GnkFUtxAeZ4sdtuWsIMnSxIXQxko0ggKpK3hHxSKUDSnLtzftyUHe8D+RynDcmsTrMNZcYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxJKvW21D725Aso8seiMR/IKn7gRy5j69tKZZiklEXA=;
 b=iP+BJHw/dRv58P1ukRp8BlvBxDlRzJzBnKs0+mItz8qnl+oSbV4sXt2BtdAfiOElJvHHCBmg+7YDnqce2owzFQiXrBG/esNxmkwejXmCgrQCOxvxQWTGxanKxPw0h8IFZTXS066/V94bq1dGv+H330/g5oLz7zSSHcifVyOCEaVJjK4xdStHg+PLsyasdKBr2uX46lEdepvYilOMDb1RwqdS1yqiJrCieCogOXgi9xZnITwxLGrbOVToEUjh9YqiWIlrATRZ+oNi9vcGi6eOpU8Q/0G/nEPl9kCiVfMN5nSdxhY4Ne9hndc5iCfrEvBPQG9p2E+nbXBfy1bDUjhViQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SEYPR06MB5157.apcprd06.prod.outlook.com (2603:1096:101:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Wed, 21 Aug
 2024 06:49:43 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 06:49:43 +0000
From: Yang Ruibin <11162571@vivo.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:block:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 02:49:32 -0400
Message-Id: <20240821064932.6592-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0226.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::22) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SEYPR06MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 97df897d-2691-401b-65eb-08dcc1ad6fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8PoLWqTI4VL0ua5LbArZNOp42TvfeD3nf7jRfbSFdWPm4FsQ4Mq/88B5H05?=
 =?us-ascii?Q?VnTy91Qd3mX8y6XwWkMn3Bt8kgX3sVdtPGMGC/8bGwMcKRZSeWUxuP+ndD4J?=
 =?us-ascii?Q?AcN4GtGgrqebs0D6Jv3DGzIycRVnSHJ+dacU5AabECunDhatPZmB2iZ74OsE?=
 =?us-ascii?Q?Z3tbaC8AaXxNatsK50hnabKcgsaoSxnIbrmKtiG/JbjZA/5mrYB9onyjTHEr?=
 =?us-ascii?Q?N3+UfNo6WxqV0zmhkfPCoNmCN/TCCLhwvuhCGsDl+TXTSzflRbHQjSr2GN9x?=
 =?us-ascii?Q?b/trg1mfeVK9F33uxme91vyReqCcyvrol8VnPFXmnJFIiGYKbzLiOpKCJNGi?=
 =?us-ascii?Q?mnXsquj4RrVIxhRQw9+m4MtAudCVOgGPOjaVj7OHN4PWb+CurIFkSDlEdI4t?=
 =?us-ascii?Q?PV/e5+O0Rc/1jMJ4h+x0LXdHVsEZt2pPI5NOJZH9oh/DrLBnokh+o0ehPmBK?=
 =?us-ascii?Q?jO0dWQR1Rzw0CPrLjx/ORbDDzAX1lJl8Jsp6l3x3166inPrIpXJeFNpfFSlO?=
 =?us-ascii?Q?sEOTd94XfRuXiH5dT2D9VcXKcULAnuJUNYQ8GCszq/DUvFJd39BogwzUrkGQ?=
 =?us-ascii?Q?U7CUBnqaNbY1d8NZxg9TNAgbVNLlYjEa5r0wbT/f4FALSgdtyeIepMJEHVu4?=
 =?us-ascii?Q?Agdf1cC28MM7StkSUs22+vWiBO/OFDrFGExY8oTDiCsVKOvFQhADD44j3t56?=
 =?us-ascii?Q?Qn7thKg14FbVK2VcnhvsAqublpjE3Z+B+B+sFraK4imlyRF+cFdUMtFkH+r2?=
 =?us-ascii?Q?2vww2WeSQrKhWwi24Eqhi4TobLj8LbznL5qvb9PFtuO33QdB/At3JUX5WfUp?=
 =?us-ascii?Q?+EUvw33CbbEylvEoIuxckNe3f8GXefewULqJdpCV8Lon0I5JR9vnou18QPLn?=
 =?us-ascii?Q?ioDr7gMSjP6ZdUGu/u8LEn5mIkxgMOMuiwpCLsABPwsbdi77VMUeXFQ7JRFp?=
 =?us-ascii?Q?teFODnQ4KDIh8bb2kdAohpfsuaqrqGVbV2r87ETxcLJ8jkzAqZOszXuGPceE?=
 =?us-ascii?Q?SEs9+DDNpDF8dIBQ4Vq1MGsqVoJam9xdQWtCvJHl5TvDbEgUdjK9fzhWBJGy?=
 =?us-ascii?Q?oR7gRSgr++9cdKe1OyPWCRnYZu6J++1bO+wc6bt26xGEql0UrGZqcvvZudt3?=
 =?us-ascii?Q?Fm6yeWI2U5JxPLf4XGg8vXCQ6qNZB8WjMlhcvC/JsqE+GUovffqnxRFv4/NB?=
 =?us-ascii?Q?qPqEJ6tLESkd4ks8JMGKG12DpRyWaasasSs0bljJU53CwlB2PkU61UM4YflW?=
 =?us-ascii?Q?m5Z7XiolM12IfZxh4ROwK5vPvGgRqp+p4cYvxlKUhUVQsSdkULZclVh/UpJ/?=
 =?us-ascii?Q?n3+gDfUfpAlPbE/yn1dNNJ9p3jhXVYy2Ul7TiTPNiqZCuNAgOg6jtOSn9ZPl?=
 =?us-ascii?Q?SSD3l242fZGTeOGLdPd/Y6WtKRe9UkZ5yFncQAIhmpA+mTxYg1wvXL7gSBu6?=
 =?us-ascii?Q?JoM1qcGDLgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dNW3bN9hcM8jvG8t+WKuCaGeMvUgoAWRr6KykeTVmnRYWrbCMizYbvH4pM2?=
 =?us-ascii?Q?edcgck9llAFSd5R/X2WZC2zTPHViCI31aRh1hAD1alvAyjgwsaxtv8SF8HFG?=
 =?us-ascii?Q?gG6Wp1qrSUOJoa7F34d6G9fQFYzfuANuWMo6v5ZxwwOy4BqD2Q68HvTxnjT1?=
 =?us-ascii?Q?a9J0NX7YSUzg8EpXHCTHT1yUIm3qFrYL324fiMDlzIuMZteiOw9Y0ry8E73l?=
 =?us-ascii?Q?9cNsfemAVLiFgMWpslR+ypa6NFOK9Y3nkjq+uZ9ZHnzncfJiMDaCLzY3ueT/?=
 =?us-ascii?Q?yratYI0KC8PetG/Y3a0FqQS6KeMUXbA5y4kB8I7dblkvzB1JFyFo4MRMXFOD?=
 =?us-ascii?Q?mgxaFCBIqYbXUPvHzR14E25FjxXEPMsiBkLZJN0nB7adKOChwwk6fmEEQVeF?=
 =?us-ascii?Q?sIa6NW6QhUyo348csfngqxEsgdHtkcuy+SKJsfuoto8IG76IQCuaztuFyHWj?=
 =?us-ascii?Q?qcFg1of0ChxaAdWkDj1W+6NjJSvKDyreTT0NNx2rWK1vy6irLk31pb4G/Xvr?=
 =?us-ascii?Q?wrVg4eMvjbeD+/gZeUlkctf5Weh0Mp8yGw8fEPVnQmqSH8HGLCMR1Jt2tZvJ?=
 =?us-ascii?Q?EvMmoa/j/vfKj0quGDIufcI38+GVI7st2nOnVjFjoFEzMpCwlwg38jW4ighs?=
 =?us-ascii?Q?CZE3C2XFvr57c0VCgiYPhtY31YXcOmwjKnJAQsZXNisyEs/T6geuPwv0ac7O?=
 =?us-ascii?Q?lZ59FGAMeP/THOizznfDkn31wPSQahzrDzO1iicA3eSXyaYGKiGH14i0LhMi?=
 =?us-ascii?Q?TDtQYeSACQqvoQ3bGA4vuKRFpPBbKXLvAivWLvcxeT6zxZoRoyrDZCpzqT8J?=
 =?us-ascii?Q?t8Ou8vWepriE6y6ICdM8WcP/uUjwgotV7IIO5ocJKK8EOlqI4Qu2Kx42V1CA?=
 =?us-ascii?Q?hSY8TPykJBmZWCjR7iHWK6xQxk2ojPE7SKzSgSOAR8RVF/GVHJAWqS5wgZF6?=
 =?us-ascii?Q?N5dBTjYMZ4DLLzCV9PYaNZleEoiDipwTR8dwMNMfHT9JDei+aMq3AE4BcuaJ?=
 =?us-ascii?Q?lSGzgDQRRUGe4vT7758JkquixiR3+r9lMnvpq5pP8JGOnKwK7wU6SNzZ2eyy?=
 =?us-ascii?Q?QCmPj2Kwm+/NY3Rpu0QCxUJo8MHFKSzAWqxKLJlgv1nykTa9P9e9aFrM8Z1T?=
 =?us-ascii?Q?l4Z9F9CRajtJffmUZvBW1swvHizGYRnet9I0a4pB4tNq77A6y9m0RVm6p6AU?=
 =?us-ascii?Q?2MzpSdl2yy24C/Yk0bc0Wr1Gy6r7kWZRfL7rKUt7ldrzN6YAMR3wxvvXOLTw?=
 =?us-ascii?Q?nicVzzLjeIqGVJWF+xeMktb/Mu+pgs7fzeny4grKB4Iv5PZ6W6eEUmdc6vH+?=
 =?us-ascii?Q?0GauMwFn2vkWQ0cL+Syl5CvURT9tcE9T14r+YXWkQB1LBmR59fB3XQDvQng+?=
 =?us-ascii?Q?gMWPdnWjPiTvFhS3CMOB/K7aAJG6m81d+ynokymT4P+2llDyfJdvXw3RrRlf?=
 =?us-ascii?Q?xauIpD7YCrQMMj+NwMg8vDb0Q4sgMnzGe/4UAYo52xNt4oMZ1ErdrmCkCsmj?=
 =?us-ascii?Q?zuE7FE4WL7g4JkfiC4HRXw+wLB/5dCoDErzsQN9/h57A+k2/3WaCIEsuYwgx?=
 =?us-ascii?Q?qmipN2DdL+FUTxC9wyYzLc4jCKFBYOyAcFsm+gka?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97df897d-2691-401b-65eb-08dcc1ad6fd2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:49:43.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v23IHWRJN9L7so/IevdhrAzr1+G/RmPRHdYDv/CXoewLLM+sZHIqGK81hIUK8Ilvc2/d3HDMnsEEHY1MFnnSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5157

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7cece5884b9c..030b7a063a0b 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -498,7 +498,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
+	if (IS_ERR(pd->dfs_d_root))
 		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
-- 
2.34.1

