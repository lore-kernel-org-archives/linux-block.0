Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071.outbound.protection.outlook.com [40.107.215.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685D1474D7;
	Fri, 23 Aug 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407863; cv=fail; b=Dsc1fC1ylLLwXwDXgqE6CoZywpnRw6iux+kSb+IQgHcZsp1q9lR9CCFYjxPouNn+OZzqmJhK8oSExzA8Re+gamNmH42Xf3D9JOLcfDEze2qEjaZ5GVqbX3Xg6jq/2EA79eABwBctL5rSdazHC22JVn9SQOgwkI7I+xbszEOZZEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407863; c=relaxed/simple;
	bh=6Mv7pqiov7wl4aTXb1WVGTOUK/s/Ptdis5Dd23xNoxE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tk1M6fmvxuY2FB/DoIMFegaY/F/EX3qQaEkLb251JgyKPSvDSlMaN1zN560QHubQ7FtjukedUi/Sxbdqg+P+NC5J3yxum5FkGRWpLDdK1R23R6dayiAqAXdmgOmZlZ3VKeR8MIrjRyCYGr+qrVCpQE1uJlkPxNVpYK/jHyKScsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NG5aURU+; arc=fail smtp.client-ip=40.107.215.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NG5aURU+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFwIsZHKwOlkq6EamCJ5TNui5vGY+8isxHWXx6ECxGodI/XoIQwSZq9tnObbLZeCE/8jX7LEssNJjwIKZtdtD4vFLOS0F+dz0YQ4Hy85pr5QD6ZSs71hgUdGcHi0rG2BVUmApuY+mO0QcbhrXzLsq6y+slXVJz9j++x99HrH3hM33HBqHZ1FaYL4GDpR3r0KnBdDu9Bg6Xm3fN8fU1K0Cme30IHeqSE4dU3bPzSjkT37vh3X9ozU4/9u6XPkaiBpxEV24bCS6rKQxTE3pcbeQzQXmUTUS5QoqfWqXcLox94vin21qD/MqBiEYMUM+7KB6HgxCr0q9tZCPDanqUy94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGnl5l3UgpjZbQwZ9pf0K9II6ubLN6boqX8BFrsrCl4=;
 b=EchFNSKvasoYNxS0aWc41ALEhjQcxN5U9Hh/dmbnQL4h5pHwSj4iF9K2RrmJkUd6Ih72adKLA/q2pCGqG9VNZC4N/BNDK5lUpVPWeOUVip5FgbhNDGzn3CVi5SxPIcCCGrDRyzBaqw47XRDh3Z9zUz7JyR1TVGm3XDXIA11Q2PXLNFmatFKhnPdjEpMpRRzG/QTDPsv9QugbsY7v2oABSM6M/kXRRyH9k0182O9j5ONxiraXOkHq2jwZCCmvFaokQ+bEEVJN6hr6n/FqW9FgNg4RlIaGEl2VrizokmlF1JKJkyNPJpQ75tOWkTmFhsD2RLKF47RQNC0tmhJeGvGfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGnl5l3UgpjZbQwZ9pf0K9II6ubLN6boqX8BFrsrCl4=;
 b=NG5aURU+3OetEoTEZ3rEaw/v5TzRUW3NOuhUMSmML9F7RJ/8ZNkGmw/mTmbHHWOjWXL5B9CKFQZFZzCQVhVW9OWLBaExftpI1XPyuuj9wLIgNA4xs34Xq/xAvJF3Fpx0LE+Yfjm8QbnIwxxkCsWZ4XpRpWgB1zojSMQyWay63L/CEifLtJuMgPZ4WXJRcS9Nqx7m+Tw0u/i1y+HdOmp3a5nGD806918wdS57+uz+ZO5WZe1Wx12uXPAELhyg2PRbObi5SZgx+VaLKUpORdzxVh3iDEDjf83EYaQf24NIXfsQDsKl1n3BR/u61PM/dVvrX8KsuK1NkQwASK0hIDMbUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by KL1PR06MB6887.apcprd06.prod.outlook.com (2603:1096:820:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 10:10:56 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 10:10:56 +0000
From: Yang Ruibin <11162571@vivo.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v3] drivers:block:Use IS_ERR() to check debugfs_create_dir() return value
Date: Fri, 23 Aug 2024 18:10:46 +0800
Message-Id: <20240823101047.3755190-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:404:a6::34) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|KL1PR06MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: d6390dfd-b668-415e-cb42-08dcc35be0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?05Jh7IaodJ+03+zgjWGhFkWl3bRGQiT/EZ5Xix0kY1XU6C6n1TsOhZPjfzAE?=
 =?us-ascii?Q?7QZYQMKYK2sCYoDFsn60BmZf/MldwhXf8oFKX4eOnwfHbwDmK/Xt9gMltCKP?=
 =?us-ascii?Q?OJrOPnnawG9CyrcBqLq0WY/yLzP+TQVEXyz5X2sOTH3TfTGzOsaLXCt24peq?=
 =?us-ascii?Q?rOlvbEegpGGxGOuXDXNhKAA2E1UttJlC9msBf7xV+byWlv5EGSCOFx4laO6/?=
 =?us-ascii?Q?DlMOnVmXaDLW5NC7eyEwYbHcI4cTyLIvJvvNK3pWQSOf+AdHrkJTFG/GhfTq?=
 =?us-ascii?Q?3A/UInCHOf/X2s172eAarWaCmkYEuu0qsIbHrubLQESDG3juU1tWyYuXBSOl?=
 =?us-ascii?Q?ZKhEpT264OUvwvmJUBE5QX11PnV8g2TwKKeDBO6cLkDFKSEVwhMPZuTw3Q0G?=
 =?us-ascii?Q?2f+qtEyaVNEMH7jeruVsVt8kCCVxRpnsICu3XNPU+1T8RXOp3BOWdUgl/0Qb?=
 =?us-ascii?Q?D+tM1tUX+KiSidgWCB+2LLsI0SDQlgBDIfWuRg49Rer+FBFF4yh3i7Pn0dYL?=
 =?us-ascii?Q?lnHVxCVKzuyms2hVRWEeKK+bloSRqXH3hLhx8TBmv9u8jNwQxEHzo/IPZWm1?=
 =?us-ascii?Q?VavwFUPufdmOi5Vl2ldPd8fh49AOo0ThtPoM0Sj2VdpAvGb4uq6MHrI7KDrV?=
 =?us-ascii?Q?usZZG0eaVvxO3S3XHrF/efce35aMDlU/yX2oCd+MziA9iIxDY4qry20liQ5k?=
 =?us-ascii?Q?4YQWMixHoJdaqEiHN9qlPEFJ3wW+/3cu5CbeE1usy9425p5SremHAl0dhSyk?=
 =?us-ascii?Q?QsdU2t0hjrdFRw1uI9CRPJ5V/gZBpavGKAv6wVPabDrgmgmTHpWyll0SKSII?=
 =?us-ascii?Q?xASzg/9o6tJD9g3ZXDNSiGmlNFKHweGreeZxAwzTrxAwPicHqvJjNaxjLRz8?=
 =?us-ascii?Q?n5DlCi+UOPHmPItWrvWh/BWPpH6pg+CGTp/wsdGVt75BWamwHwpxqthzJGEe?=
 =?us-ascii?Q?4+60tc777bBMMFkgmzLc4PEQdvB5yN4c8hwVf0mRYcgvYIqytkkwQZlALO8X?=
 =?us-ascii?Q?8aEeSsFgi+D+xBbdeu83l7vxeZvVTZdUnibTilumIFrHUg7jN/dOtJiUMiQ4?=
 =?us-ascii?Q?w9FBrxgaG3uzaCvkxNhhdtT3EGHDmajGVKUCCqIDK65ogjSEpiLJ58czOdjF?=
 =?us-ascii?Q?Wvv2EP4Zi9lLkP0+RFvRInDnb1sKTC1bx4jMongbAFAEFSbUOQKZUW7rFWGC?=
 =?us-ascii?Q?i1w7M/oyGkS9XCsRMyq1kF2e1YAxNoi2bBv/9yogaoxuNZtojToO5BTtPjPn?=
 =?us-ascii?Q?m9oIhfUYUPZcLH0zWMmNA/wT3x3eZgqcWY+TRgL0hYSf97MrGSedIFNpSTUl?=
 =?us-ascii?Q?sGdZ2yloiBnsbUPfoKtsdABKkUXWBhyEI4+INTsY3Wqxy7bF3RpVh7wxiBDE?=
 =?us-ascii?Q?IZ04b3S3Plm7mDySeb+lwrcWchXXg4qdDZ+eL8QUSIB9GxnupxLv3Dp6xMEW?=
 =?us-ascii?Q?eRzagakExls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FR/BLmn3iGtFlrM1e+k1KlKNK1i1YygJeSJsqxmgpAQ+zp1E0IG+/hFdSXr1?=
 =?us-ascii?Q?xoPqPlwHGLyner2OB+5PlpX30PaEgIITDURG+vt1mKJDYQUnUZ4pDQxYiqYZ?=
 =?us-ascii?Q?3YvJD9PgD++EikNz+KwM66rxmoBM/QFXG+rMy8G9xbCeWguMeQnf4KTBRJtZ?=
 =?us-ascii?Q?RJa0QFz4SZvVU++9M0lpP//eDHCuVKgmuCT+0Sf/fPTJkZSwsgEAkREwVXTF?=
 =?us-ascii?Q?F604oyRftr4XCPzdLqedqt6+nfafwY7l4Kddr8cIcgYe4LugSKr0gtz4OiZV?=
 =?us-ascii?Q?0yAHtCqzipzH5OMrzlxJGV/Y65U7cJ82Tp7t2aZAkCgAcABED6ApI/T/Dy8y?=
 =?us-ascii?Q?IuzRZ0aQgHh/648g8EBOr8XY0x28+KsWBOgRP8sScpAZRTzcTMBkFeJkKYNg?=
 =?us-ascii?Q?kyNQYaqjjLzrEPr4MM9w8UJYc95SnNTH2l5uvoEmkYyHr8MeYca76T/7TRHC?=
 =?us-ascii?Q?v1PWgkitK0+Snoi/fBxNHgwE3uxxy2qySc8IJuObXc0A7gJH0D+1V9Q/6Je5?=
 =?us-ascii?Q?gu28aEwE11fB2eHvQWKb+9j9CGuvYgU1poDxDeQXip8QB9imWrnn7GwVa8yB?=
 =?us-ascii?Q?U8h+/muP+ynfk+Un1nsoeoxcloYxfQnyUcF5jo94s/07VFg4Re+On2Ix5fhv?=
 =?us-ascii?Q?JtXtrSM04mlGlqevBX/rD2Yd3HyIwVrdQCS/kpapLrISmI580N/sSoV7NcgO?=
 =?us-ascii?Q?F1ZUwDymBEZlpwnfRICDAt/sexytlatVx2jfXUuWMTljn2uJzopIqj0dw2aT?=
 =?us-ascii?Q?V+gCi0wPYvPVCJ3aII0aYF6wHiSFYmjOK1ZrOIYqLZOCBGD5nS7m3S7/Mmmw?=
 =?us-ascii?Q?7FdvXKsTuto2uYl1YBV2pfCavRBh10+ZDgbpzeUr2nbfA1d6AoOCyx0pmQ0j?=
 =?us-ascii?Q?4DZ77FXjr14ajoOD/WrIXr0VCkbYXtAyVJ4yi8jwfYSasugPwWvXe8yNHK8e?=
 =?us-ascii?Q?bteWOAtW5Y+a5C1Io1UqFlTQztPHsC0wW1pAHI/Sy1IQXIJJT3oo+hQ9N++z?=
 =?us-ascii?Q?hMrFeGPm2fM51rkUpQJOekoa8qmEEBWf36lh2Z1YNYLaXj68N755/6u27ep6?=
 =?us-ascii?Q?vSC4bPfHML8hHpqphZDSryPC64i4Jo6weUX+7PwSU2PcwFnOP1rOlhEMavOM?=
 =?us-ascii?Q?H3Nam6JSLDvYq1FLJ251rwl0Sgv/ewjjNyNsEsGsF5Ll+LuOPfk427Psm3Ti?=
 =?us-ascii?Q?Z8z32HPED0IAlZo3dv2eR4Bd6uhouOWppFqbfpULFIKgEKRUn062CnGRwTHZ?=
 =?us-ascii?Q?nbJ2jHW01KLxl9bWt2sxXjhI49L1lWg1sRmYTA8W94oBFcNut0k36+4cet/f?=
 =?us-ascii?Q?LTljfzumP1ROKCG5hF42DZzyuDSlaXOrSqS5VKWGBcdrShhgqOQ8PuxDpjPN?=
 =?us-ascii?Q?zFYrY68ZB61sbvF3w23hJATkAsA5S314PFK02pA2OUG2i/++tyyf1tKR24xh?=
 =?us-ascii?Q?PbMUudVxVQQhcYqbhsiUL6j1RXF99UUzSw/1qJbf4EecomVu26bboGSr+WJW?=
 =?us-ascii?Q?mQwFoQYpoanP0NVkdJomagZ6bG6dOOmMrpOq+WswDF1rKXT8iumbQc1CT5ei?=
 =?us-ascii?Q?AXo79g7hbOP4WGQzpL152eobd9D8V0s8HEL3gnyT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6390dfd-b668-415e-cb42-08dcc35be0bd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:10:56.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVaGZ2AmpKkZCb9d0oTX7IvrQWLuoFIsaSok1Aw3qWsJSkeRZw6tkWMjhIjV+WreXc+AXRS10ijunYF7VqnTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6887

The debugfs_create_dir() function returns error pointers.It
never returns NULL. So use IS_ERR() to check its return value.

Fixes: f40eb99897af ("pktcdvd: remove driver.")
Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes v3:
- Add corresponding fixes.The revert original fixes information 
- is used compared to the v2 version
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

