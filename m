Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8316426;
	Tue, 27 Aug 2024 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725679; cv=fail; b=szr715R1PFTNvNdNJB/XL/1QXeI5Y0bjTs5PRsFpAMkTRHfb/uqql9N0fbaRkMD461ySwje6smj7v2F4u8MGIyja2h9XwislrFV+Hh15TujKmg0bn8Nqp+8/6jJUxJkqSpc9eeHPccR50fP/q6YE0uyKv4DYVf8a/HdomMSihTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725679; c=relaxed/simple;
	bh=i15ugCWVs9cPd6aJ33hZAy+fAvNa4jhqLbf+NF4CrUw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mpWbxdPkhDmRHL95cOxWMHWfWfeoPO0avm03kuXzsMikvDi22OueEPUmrXrDp9gdxjXgkelDDM7ei6rYt7v3+WXHMAOEKwZHssPDMvp1tnIJNAWsq6Bo/RA99o+yxDJuBkmEaP9q3okFVcYxnqA/OjaBXzo+/L9pQ6nrc8QUzUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ICrRVK2x; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ICrRVK2x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZsKEm8CpiIQnl/OMLAFrOkv9TrucQNKuY/RQwbgayrk5bNpdVIyDLJninOWbN2b99eTj/y4Cqy1SLb6cAhikZgtk1v9Xp6VxIfnTQS5k3lykTYjRH3xPtTgFjcYK1KdPnGeUBUJTqDmVBfrdnumBiqXbOOLbeRlF/gt82hxvryFEVaynncDvg7URxGnbIiXQre2eGQUCzEOsIphT9qY6dItmT45ORqdueWYPXRGilN1Lm4z3VDHMVoG6RN+1Ag42vSHqCcV+9yXSSuaO6gI9Hds77n4UjvxlA7mKw+WH2+AaGPXU91Khx5xc6GzWEUokENnpwVNRidaETwbZAvcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpbzTc3Hv7PKQXmcrI4H16ZJaMQ282ztuqI4J9LoZ28=;
 b=Dg71lgklUJ3Bu90KXpAm8V5iulIQaQtB80njKXZNNQKYE2pRIV+oaWIWcYO1yaP4WRe4dvJGFpT/JAdx0R+tWy7l1X2OaYQfJPBCvmdOmgHNaBj1+XVLwex9IZe7Yp3ugZza5GP4oM6OWNUcdC6TedqaNgFe+uM6R4fHQw9TN3H/jem+5In6Ymjv7dHGCwfbP36PRts8y9XaDovzLeokgUvN+KLnaNsaMmW3RF6W8nmMr4bt82m4sZFd1XHGe1BpSOMOsYN0Xo+WDzAq6mfjuRNGdwSeQqapAhekZD4mljeicUgsLEkE6ojOzpyp/9PwxoGaCBqdT4Kuk3/qKbzXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpbzTc3Hv7PKQXmcrI4H16ZJaMQ282ztuqI4J9LoZ28=;
 b=ICrRVK2x1gs7U3nTfpE4vFvPg1J/nH4XKeurGAJzdmDxkIS4Un6REO+qpDWpub0BKRPF0ewqEtKj9wh/QuBTOOvCAv2Q5UuKzkkZfJrjzruRftni8HzzUabQuUGkrywSJhVL+0czTeDZZXwViM4AM+ztvlzu/xF5M5MXmbbJAxk2JJRcL9ZZ6AGP2+hZ1sH8tQe7s0ag73GBOvcO9cj7mHAQeP/8mTZJvR6Y7me3kYCYKFIDfO4KTLUcvXajLenmMlyp2hixu4Uc/ds3x82ARkbIaENO5TriMP0VXFGUfsHrZ96EfkrGOAqJT5ixjSOUfZvFAnSfMhY2S8Xd1ExqhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SEZPR06MB5879.apcprd06.prod.outlook.com (2603:1096:101:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 02:27:50 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 02:27:50 +0000
From: Yang Ruibin <11162571@vivo.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v7] pktcdvd: Remove unnecessary debugfs_create_dir() error check in pkt_debugfs_dev_new()
Date: Tue, 27 Aug 2024 10:27:40 +0800
Message-Id: <20240827022741.3410294-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0034.apcprd06.prod.outlook.com
 (2603:1096:404:2e::22) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SEZPR06MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a0d6fc-3c68-4f9c-9e35-08dcc63fd8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8UXTHTnOWjKiRgCcXX+04T31Us6HRFsQ9yA/dETU7wvF1L4Qc8olmrOoNhLi?=
 =?us-ascii?Q?McTEmONYK2tEb6dzDryQCd12gmWjDGYXrMcVoOJSBVycF6+3yksr2F1EmnLP?=
 =?us-ascii?Q?MLoQCa/2EfinCCThH93vt80coLfgMi9uYsfm0xkoIWb+hy5RLG55ElZF1eaX?=
 =?us-ascii?Q?1t98zJbZ+ebmuZsvMAaot4qiGdyPQL6pH4nF8o15c3gZgxAQUovVEn32q7lY?=
 =?us-ascii?Q?BVtPA/vnxsIYnkIZwntam+RccoW8yfU59nERNk0RpLz3JfuItcHiDGLGccCD?=
 =?us-ascii?Q?7G/F98Hrnu1zr+IStArX3iuw+6uQrCsy1lf+r+bAexVcTnu2sgxki/Aq4Ysd?=
 =?us-ascii?Q?32hGtKxLMMSkGIJPsNSqfWXkslAsSmfIJ6381Oma2+a61D0Vn3zdORv/4T5/?=
 =?us-ascii?Q?BWUvBgBcWZ/RgOliRmesAkjOzIv/FEgsRLcBImBlHOhOHk/tG2J4c77v0L/9?=
 =?us-ascii?Q?QmIQubGFNDnWT1um56tBeg1dZxLRFOFdibBnHRSpPQmLTRXiY/fhlEWDdJEz?=
 =?us-ascii?Q?rnJvQYoJu00MoH0ClsB/dXKYOnGw8V6lKausRy7XD0h0NQM48suCXKHx/4Gu?=
 =?us-ascii?Q?ikQM3zQSqkGT/G0rZOWSWisvrHyI7d6E2rvuUQ/rVqGWdMeZy5C22LGbWlAL?=
 =?us-ascii?Q?wrEDvVyWs/MR3BS02Hca6d5raSkYKmjxC40Lv/aTMdN2FCb4t03iETax+KY3?=
 =?us-ascii?Q?EV3/GhXh413syJvxhsU5LITruD58LTWxUZ/lJbGirio05OBLlaraMiNinpz5?=
 =?us-ascii?Q?P1NSwNPX0IfsXYjsAiLXnYkSTbxy54q7ySnifMdv12VaHJl2cH6QBmakseH/?=
 =?us-ascii?Q?okp7JBNqOCRaE9hOx9lbNWbdNMEgj07GNANNTaWzx4CKG/RoQPdGePM55RvA?=
 =?us-ascii?Q?nO+4qaX+tXUg5aExq1xk4SWow3yeX6upEclnSkUI5F7qp5qzalYozxqmC+s1?=
 =?us-ascii?Q?waBUBLgu1k6Fhtt/hyrIRyi/97RPxh++3MJwwc9qjOcZl3Bk0dDBwtwfc6Fx?=
 =?us-ascii?Q?59k5zISTaoZdZrh++3LktlLHVvcMcIdo4FIlVroSANN5i7Febqqsx7YC25vJ?=
 =?us-ascii?Q?Z5s7g97yy+tv29QBNdTC5fmtrAr+l6GSzqvfa1IAOcRdtcKQjaTWa4xTgeRB?=
 =?us-ascii?Q?agdBsr/QHzawSHoruySKiQCyaQEikB+y2svoZyy1ChcA4RxUCGHa0PPEemq2?=
 =?us-ascii?Q?ww4pONpYyqExvSyfwZoC4rmkQhyOPdmcFzjTZwpXtK2+EN+kl7bdsoVjeMEa?=
 =?us-ascii?Q?2tqCMgYsjuTCVhStaMTjX6V+Y9aQu55JdDDqKwd5GR0fcbDA3c+//10C5lE5?=
 =?us-ascii?Q?dzTlRuHxTcYMYPcKMwkiWFivK5om1yqPk7jTtGemxVfoqY2kRVh1BWbV6HtO?=
 =?us-ascii?Q?gQECS4jkZbudIJEfw3BCJBwxOFGse+bI0ptbtbWIAf8813oYiDXn5K42ufy6?=
 =?us-ascii?Q?mpQvQbUGlEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hrxjs6fWUAs+G8JvB8PiZ4ggeesdpMYjFUCnUqcWaCyryVuZcsiK42rsvnsd?=
 =?us-ascii?Q?/grew6BhtS6j0uTPmTB2jks2mNz4hrPqS+Nd8M9NM0KzA8ca3UUv/0wIXWnd?=
 =?us-ascii?Q?yHBbrpZA+CVADRu1mYqZ+lhvmp8wgt+lMbqUxkk0LB2mIoj79OE21WgATt6W?=
 =?us-ascii?Q?QMUqoX9FOWCRwVyeeVqxAaTbUjBiQxLuB+06gq5mXIVrinP5SqBbJWjG2ECs?=
 =?us-ascii?Q?sZYuWiH2mI315j83FuDBR3JKZZnpkDr0Jj2LeIKj6hRx03IiyTJUiRW8l/Nz?=
 =?us-ascii?Q?ttWrrJxbXWLVEW9/4rCw6Fy8Sgm6aBClqzU6jroX/WCmNev5sNDHGbFHxo8V?=
 =?us-ascii?Q?tKlMYVgDpSouYFmZh27FhN6wUfSfLHVAS4g99RZRssfRjkQupfK959c3Tauh?=
 =?us-ascii?Q?ZXhITwYVj1bdufmkt+tSMfj8N60wZJ15ZrX7e3LaUY7Ls10K685W5URCpwBi?=
 =?us-ascii?Q?dCqN22OqPwSWbyRnrI5TdW1FdP7zOhUgJ4i855N8SdoAMquamJ5mu+aLNKEa?=
 =?us-ascii?Q?ChTM0eaXOj0zCl45Ep34LW/gI98Q9BMaOp5hVvjgQQ7LBWvJnQt2GAcACqD+?=
 =?us-ascii?Q?9mMZsV29A+e5mF47FDVF2vXFXAhUW4TjbFezSkkep37Wpb0ID/YaBD3YmrqW?=
 =?us-ascii?Q?juCHDC2h4Kg8WD5QjhbxMX8vUm8hgWHqTyhFt0UQvzYZGX3prIIP0rwxqy/N?=
 =?us-ascii?Q?XlHX/Gcki1wjbFPH6pk696qXRQc408pZnnz8bwBmD+JIziZusRnJc1QDmfN6?=
 =?us-ascii?Q?+oPdCfR0vjcGlEJ2q3Pf+FnrY3gpJkIY3q1/8946DPwr41bDXWRGlAvMrS+z?=
 =?us-ascii?Q?ABNfU6smn+RDlFh7rnXNsdyql3j02LAcVc2ityznd6p6yaYtMUuIHxe1S2DW?=
 =?us-ascii?Q?4rTml31nvyfKbfGxhU+A4qJyoUox2lKkvjtlPsAX84rXKN0BrLVubewkMmys?=
 =?us-ascii?Q?ON5IvPg0Po9DLcHJyJWnQTzoyiZTPj5YvWb4ZzXuOyzt7O7/zipmzPWSCtyp?=
 =?us-ascii?Q?Ps1KL/G7ZyG63cviuA1oVdSlEe80BmsM2XPNJAUQ3/GiS6BPPL6g/TzEBQMB?=
 =?us-ascii?Q?91A2F7nnvKJ8A7FHAbIyrzKho8AZtjeD6hjXSu+pOCHp2Rr+pXnNwSD5rTuK?=
 =?us-ascii?Q?jTvgPWjcQA2HeR3xduflOUrvsSdKt6hLEiLuF7dneaUcg4vKMPU4LbQI78se?=
 =?us-ascii?Q?UKaKPCaBVPNtwcxDqdxzOR7YaQanR0S4PtmE4yjYs20QeAAunh7ggRigjgde?=
 =?us-ascii?Q?bcUfh2E7old0g4T/ghS8/6TXt3/7NfzVpEWMErPW+afCyg0jRTIuLBP6/f8G?=
 =?us-ascii?Q?xxhtJA6x40GmAeEMcNzhqCj/UtgG2lvdXQ69egKccBNacDGaGymC6W7my2+Y?=
 =?us-ascii?Q?4+oQA28jBCFoLJAp4SRLzrch85XygPoxAu9I5oZajYRe8qB0vrHh2niFHvys?=
 =?us-ascii?Q?XmHhDg3hzGNEHzrpp5ExOQzz49gwE9kXn0QuVH6JBt/cght5fl3s7+R82CD6?=
 =?us-ascii?Q?lYhFK+O8e/ZK8Hf0O67Igud+qwNb+6KIz2r4+KgSANgnUzkWmK0ahqdiZU1Y?=
 =?us-ascii?Q?QmedUIhhVKMIcu8s8C2Y45xiQyF/TnrnaX4YAfnp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a0d6fc-3c68-4f9c-9e35-08dcc63fd8c4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 02:27:50.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kouK5/9K1Sume5L3vABoUlwqGnceYv0BD1Lsn3eBEsUfD4Ho0Dkr5VjLhR8JhbZHahNxDBrgRwtucw4QZMY7Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5879

Remove the debugfs_create_dir() error check. It's safe to pass in error
pointers to the debugfs API, hence the user isn't supposed to include
error checking of the return values.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes v7:
-Update commit messages
---
 drivers/block/pktcdvd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7cece5884b9c..3edb37a41312 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -498,8 +498,6 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
-		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
 					     pd, &pkt_seq_fops);
-- 
2.34.1

