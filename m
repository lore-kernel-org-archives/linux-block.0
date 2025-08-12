Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013065.outbound.protection.outlook.com [52.101.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269E2EA158;
	Tue, 12 Aug 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990299; cv=fail; b=Z2zoDTHGnNArhV7F2JqePg8cynkWD4+3GDBSt4br/TTNOgcH7B69ibVh2GSGng8IHt8h0uQJUALJL4rj0H/jn4UATCnSKty/UAvyWc1bas6YaAGw3x6COegFKc95jTM2DICvhAeoWY4SytdsTYbod3D4Ebn1U8yTEk03b5iO7eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990299; c=relaxed/simple;
	bh=AS0Hs3JjYeXduUzE4GoVUGFTHXnCEAwLs9cXxH0I4AM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UiTKIbvDChP3GomhmezJ35QwnW5pPNuFKYagmqmaebUbq4Cms4ue1XhsYXF77kyxBIu7N4YVCkeU/AmkZVVZTfDYY5cxkH0y4qBefNXCE2E6cqoDSq6XLgoAZvSYDjrAi/Tns0Ho+ZIlJs2+Ih6ebANGrC0glF2uXQ7bGWIHpXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eedG8Tfk; arc=fail smtp.client-ip=52.101.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eedG8Tfk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nawmi+sB5RdbvK9KgcH8yfBfZoTwQMqltprsTTEwbQAx7MHZjOKvK39yOfqN4Y+MayOJbQ0qMqtigOdKR8n7xbpCjUlkuP8GaTPp8YedJaRRxBAUF0NfzSUKaWfQpJoyNv2jpnpvfKiuvKCRIim8JcJXruVX++fLTbCtvqh7wrysB8bDYE8WmZaBV/peo1bEf5iP6y/sm/h2Cy0VRslh7g9+yy6N77c+pqE/5Tv+JVGUtPQzF3aIDdsYlZJDjS6VuCUaDS6AvWH6wOcwmn3/zW2gBzPArK2QUvylOonHbzzStrSZmpPSMtxaORvBsGUBwczPkUphLjTDYKeD2w9YWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2G42K45HiSF8Y7fTGDTSya+v/R/Z2lDj836W7G3MyA=;
 b=gHC1pCJ0tse3diDCkNr/VT0dLs72nIh2yCTjim9Joy3ChcQLCtXiNVE4QVBMzl/E0lvqGEdWT6Mpo2TZJ2LJmfVyZ0tHA6aCdVo6zTr6uO9n+Ieqih7J4XGz6FCJV6nMeDnJ24ZgpzhsaTbDFS6okov52QhA2Zju3LOurOWe2uEvTvwCkEZtUbIkgrzt/yGInZkzTWw2vfA1Uq9LU3D5isX7QNcizaFs/20QffEieKqC0O7LcEFVy5aBht2Xo6G3vYiiesfh79tW+d5TCqOA4wf0ZFCyGteVh/rqeDKzM8MU+KHmJ+U9puERa0Qq/LZl5hQt+WS/Nk1KXTAeE6RNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2G42K45HiSF8Y7fTGDTSya+v/R/Z2lDj836W7G3MyA=;
 b=eedG8TfkWgaR9+JYVRI4EcnQr9n/0OOH0ThSIAq8eOkImTbFm4fy0B9PLFBpJfhoaI0qQvlqMfN1WtZEnw+uF8ysvZQj0DNEQpLL9vBDwBSriGnCyieRSBaRsUqAnCtoRKKowp4qcLtMBq5mtKSn/Ta0frk1LweQvrzIXRslnQzkZmlA6nsb8FiDPU/ZmMviE+BD6v7mQsuQiLpZcmxLH9WlIWqR+KP6rX9LfipD+GKHV4AhIbxZOX3/+Uqwsxp6M43KlkH182Mt6ipHQmuHioIYtr/Mf7skz6dOVnjZNmqJ8iMkI2g7V4jKijZg5/FCMycgkaiSQU7StwNOIpwHfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by PS1PPFB7AB72C83.apcprd06.prod.outlook.com (2603:1096:308::260) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 09:18:13 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 09:18:13 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] block: fix "prefered"->"preferred"
Date: Tue, 12 Aug 2025 17:18:03 +0800
Message-Id: <20250812091803.94751-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0054.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::19) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|PS1PPFB7AB72C83:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2e1845-2ee7-4576-7c31-08ddd98129a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70DaxJHjiPhMkHH2O9nhVoJarNDCEpHOPXnhUPE1BH8fDW1lbOuXlnxFb6Vs?=
 =?us-ascii?Q?+1v8z5xXQpxO18nwF5nmPr9rL1Qa5BzAWjpLlzgxJaDhDLgfCsYfLbbd3XGz?=
 =?us-ascii?Q?Hl/C7djmze2ggemXslxmYY86QzZwz41zt4Q65ZJFgvTDjKGmQ5jcYc46uO1g?=
 =?us-ascii?Q?yL6GPYQoW5Cjt79A6WN+jxDYVjLqVJhQE/7eZPthZXXMID0zKLcPEEQvmq25?=
 =?us-ascii?Q?egkPKOAQhUsWggyTUV1tPL03Yk9oVDPb+2z7ki/5tR5sdMAL1uJ+YASO3Xdl?=
 =?us-ascii?Q?fl9CHauVW5jmNg3evtNPslAT1ai3EBSYqS7ke2k/TZm/raIIr2f5qbW+ef7Z?=
 =?us-ascii?Q?gXA+x0OOs4koVz+fEAtmYnXhKuqK8o6JIUrJVkaZufAhCbzAM1k77vUB6Efw?=
 =?us-ascii?Q?0VDk95TRmjkKrnbZUiOkzbo+jX+ms3AYzkNls9BNMXDj1GtSmetrahP1URaU?=
 =?us-ascii?Q?ohK9A7nkpStWUxhvn3FH5W4Y0TXgWVa+PvZcSQATeRjbzKzlNOgOxx57wrrq?=
 =?us-ascii?Q?+T1zgeqqw6F8/RvoSlymVZbRgzcuKPh6OEokkpaGHX07QyrfbbM/Dpe8rNRA?=
 =?us-ascii?Q?p/IePLfdVsPgiDpT02X4AooM5WSyiuJ3S2N3LDQ7XOojFnHQrKjjZxdbnB2v?=
 =?us-ascii?Q?LP1KIoSgNPStXMAMmwjHjcWoSFiz12TWqzujQ9krRZGBmHgy029VOX5w497S?=
 =?us-ascii?Q?525YBwRWu9PAZAcAeUUtCRikgK1wj8yMQ5lkGBcv99MUeOA2s195iSCzrSYf?=
 =?us-ascii?Q?gOJ9cB6eA6xw+Z6+c614BShthEGUF8kS9NGEHoHIOQOJ4UAgg4rCKsEqSG9b?=
 =?us-ascii?Q?81T8U3GYzzEHvUEZWuaipt0Ity1BtdRXgRqsHcJ1udI5aSMzHbjWch/k8xQO?=
 =?us-ascii?Q?DfJpQn/FD7F10SAONyG2yGGdntRoqkgFTb82mMSIPD2o9c7W7OM/pCCzJRsR?=
 =?us-ascii?Q?cBh9YTi44YqmFeUQX+S52H5JH1ltXS1wn/JYBdrCu55Bupnj6xzH8iZcSpge?=
 =?us-ascii?Q?ekFx4HAyvBMd3D/5ldFb7R/F83jeuuUK7k3h0mPddN/77woZa9YfNVhmdvjX?=
 =?us-ascii?Q?h5q1JGWy3HP7Zrp2+Wi079Q3dWJJTaxTz1bb6frXdmoBigVg4aWafmWoVvcZ?=
 =?us-ascii?Q?+4XxQ6WtrzvaQ1l+nYktnSxb6Gpr6oEH9WmbGFvnN3FOwWcPykIBMDTzq9eR?=
 =?us-ascii?Q?GGKATjNav7LejOL7epbJwIhrftP7Bw/ehmOUE/kCXt5v3aoH2sEwcSs1VsQY?=
 =?us-ascii?Q?ZFtWSjLLnMU3HtHtngbMlkaQAi+8LNGTR45SnAex0g9fz38JmwgcePSA0FF7?=
 =?us-ascii?Q?u8+hWtGrXRAiNGMoZuO45bI/Ytt7IL1JQnKscbT5R7zH+HtZeS+YN/VoSUj7?=
 =?us-ascii?Q?ssIs3wZTTzNrmIAxU9i3Ovoy2/KI+vgQ8lqHmiw4edlFDd+IiJR4HjzHx+aM?=
 =?us-ascii?Q?OsJmUhXyDz7gcbRsO8TnD4DHEweaRpivnWfPuXwpGoiMzXWWtH8xwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9B9h7+CgwAx7Ckiu4V/OA4+xxIQtyjmYhnZhhZ6cjs9xqC7O1g9cUSodEiaK?=
 =?us-ascii?Q?BVReMz3iRvgK3LbrC7zQV8qC1QMj9zXz1Xuo42XFirFwgSyd+0pMtJh6sLII?=
 =?us-ascii?Q?MIIYUHMNoyl37nRW4w70W2XlCt8RZyJ81dvhgrfhE+iUa3YUZvB3DoT0YNcC?=
 =?us-ascii?Q?bnE66hUA1+7IEXySKgTaGZev/qrdPZ4PWSs/1dR18W2C2dlzDnpV1dX3lcZH?=
 =?us-ascii?Q?juUtWlZTapjba1O0dXylW4sGFYm5ZLVXn1u/PatwFPKWwPtkmb+B6cdmMG/z?=
 =?us-ascii?Q?yhgLhYC2XR6j8Onz7qlmOZIpJL5J3qg9ZfPgRsS/Bjdutrxf+T5QmUz65Snx?=
 =?us-ascii?Q?qhaEOs4IVM43kC96HAYqCaBtFYc6TAeyVEVOJMwAQPHfeZCtEM98VPWqUawo?=
 =?us-ascii?Q?rI6BKYc3UDnNLBCmMT4PucUIeB3EcvnxDovxZ4ecpotmWL2Y2BScH4czHzcJ?=
 =?us-ascii?Q?EtYJ0TLmu9e2hrSssoPYSUb5xYjY7O7a4DdXx/6XUEotey1cJ2XktrFT8hru?=
 =?us-ascii?Q?Shln0w7cj72DgzSZMNF+pxgHSxrAGUPn8d86BE8Z5Zsc3myiTZyLUnSm+dcL?=
 =?us-ascii?Q?uu3lCvbe/l3IRPX/xbC/fEbyJg16bCNAZ1dydJ88mn/KujS5SSLutxi5xs0F?=
 =?us-ascii?Q?spYJ0r6EsyCG1YBWbG9ybrd8c33UIWHLbaJ77c987Slh8EXqB3dlAvXD4rjv?=
 =?us-ascii?Q?FOlQnFAMfNt+3Z9Cb84lmuXiniAxHTSmNDAAKyz1j3MTcaHYECPerZLx9xeU?=
 =?us-ascii?Q?g3CzPNOx9l11lXULF6kzoSFnb47u1Zub9ol6gmcndXMa8vBIQvxpnJOsXfIh?=
 =?us-ascii?Q?otqSH/+VI7xG+fVaF5az65nYdxU22NS6AxJ/NX+DA4uJqMPchPVyMMVO5FWr?=
 =?us-ascii?Q?GvyzV0BklDNnhWih+tX8fEzVDTA8sc4gpcXN9+bEtxTKg4rYtNMCe+n0O5pE?=
 =?us-ascii?Q?8dGQRFInfa0XygKtjWjMDWmuG4gmOSnJrgMYZ24EK9zLWOJ/tB7/jlkk0lBN?=
 =?us-ascii?Q?blGRDl+UPKXII+qZWiBlZb6g7uW8RWAgFe9XOgPVWVl9d5Hv/gkCQgkSzpyz?=
 =?us-ascii?Q?2kFW4+hh7gSPlp5fDeZqmVNIYIP956bTHGfburfvvUrJA4x+j7jnUt8xIL0N?=
 =?us-ascii?Q?SALnvD9gZ6guZ3iCixpSInaWwb/bt8z4lQ+1r5yDYMU0MxYAQ5DEntthR8DA?=
 =?us-ascii?Q?S0CYLoOdnJbHe6TgJ/bzuU9olR8Cs/M2QtwvqMw5IqABvxlNM14RwfFnGIcE?=
 =?us-ascii?Q?mGp+Qr3Lqh4jHROCnggf+ZBZZnx6Ovf5QtcvddiNLycO4WHjsz2NW6ogcNx6?=
 =?us-ascii?Q?uInMGtcXVY2K60pJKvOUP/YQvXF1kAo0JXpvJm0F8mmWG9jfjHw9dUPKXncJ?=
 =?us-ascii?Q?WN1ZSt2fYuApBCxi/AjoRlG9/Foq6kevLdCRiLRmlYSWKBRWcAc87lMRC2B5?=
 =?us-ascii?Q?/tuhICFVXToA5uYJfPIDLKJdiSNw9V3884egD+bYtwoQ53C2/ycXO7gfKoP2?=
 =?us-ascii?Q?DSddGjdu05b1JqddVbSyJFzMCbqc7CQwsKOusjqJ4KAf8ilyYMkswaRLFhaI?=
 =?us-ascii?Q?wkuw3s0QdrODnNXIKK28e8gaz6dYw0FIB1R3N2Xm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2e1845-2ee7-4576-7c31-08ddd98129a7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:18:13.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5p7X7jLx8LqE7HPFsuNkwXEgXpKtL4XjLlkdv2KkVIpVyPLcG/1FP4MzAhSSkbQnM76et/4ts3/X2g0e8z3Zdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFB7AB72C83

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9692fa4c3ef2..adb26eab67d8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2361,7 +2361,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
 /*
- * Return prefered queue to dispatch from (if any) for non-mq aware IO
+ * Return preferred queue to dispatch from (if any) for non-mq aware IO
  * scheduler.
  */
 static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
-- 
2.34.1

