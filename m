Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4742C0F6F;
	Wed,  4 Feb 2026 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176282; cv=fail; b=bAaeoUYyFurPLUZH2mrxM8aKsVs2J3od2sderbbB9D6FOvC1ICZKeQ70Zzy5YV6OukjXv69B+hDUwodD3cFChrZ21S9jTYikbSWin90gvUv0PR9lRMzOoPrAxOOEQv6WuNtXFtYGUC2Nrw45nIM4lh9OkQcdID5EORA8Fd7kkDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176282; c=relaxed/simple;
	bh=nyNw8qqkFjbDeroZb1Qq4XEGRzC0wfm06XrsMyS6FqY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Vhuh5nLiN/d07iLXWWSLBktXIhwMxp6qA0wC641GdjgeykwzQZB7G2k1/Aee9Nhs7bs2hGCjlIN35I9V1hQ+uOB1xOsokMHlxhvstGk5S7A2g7dOfLTF8ot+S5RiFs7ih3uvatUHbN7ap5UwV0qcnnhaf6QXY3fbR14nq9E3MMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b+H+itwn; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b+H+itwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrVBkIfVsfMPVzr0yuL5MoOnNQ8QN0J8ZdNar9cpJMOaPiniAMVuA2SuisDBYExSsUUYfFPSj3rfrPUSce/LKhI+8RtVHz3QwT4cMwCikVSDk8wvR1i2BYEbWA0ENlzfuk1daWGeZpaRMH0roZLI+AMlm3PK8GPe1PwNwmP09Zp7kYHYQOx8BTTj+OSlG3mGKMHhTXnadgSsx7H6rX545IJePnVeQuBMP3xDgI4Kv0YGbFypetsES66j4oTTpc8k33Q8oZidoQF5XPEzWv7sc7gTyFP7ncDycAE3VvXHA2KPe7K19GUHxYvabL0v4q2nGLdEA9RlBbvzbLO4btFg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2wL8e0DlXWN5DmKyRBpOSIw4/u92WDcd2jTkQ4uYiE=;
 b=KakTLmi5SVo1bQ48WFZN2qf6PmmL2FdtAOCPNK/0AavxmLxbpY6+UsYVTlPqNhFM0DoB1EhTLsLOehtcq0xgGyRtKLDKjw4gYI4pcsEhdf4Lvlrlje21p4HnEG5Uqo6uNL91CfuO49WSXpXRfWEn8E0fEQBHCBYwWrxES3gSp5nVP8oA47PIObeKhELkHmByd2Gv8+OmRZiTAa/khzenXnHfe3EC8WV3bTjC3G0AYEzZZWa+wFy/Gd3eFMwXPin2O/Od8amotgWQpBN0En54ib68cblkx3xU+sDuJVS6VFEC69fV2F5rzRaha9lw39NlV38eNHHn6kXEyfwMhwBHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2wL8e0DlXWN5DmKyRBpOSIw4/u92WDcd2jTkQ4uYiE=;
 b=b+H+itwnzHSSMKK1CIHKPoQ4BfbNbuK0PACasPqNObC1pC+dsVQIn9uNe3vH2gyjiOwyj8HHl3O+5cn85qs7laZ+1UWLdIUN7O2WPHg+x2luIWAOpKX9XYUQCgBEiULZ8WweOFdTXxlNNxyjlXX3LAhDzuHKpGXsXTEUqZVZoV8WoLy4KSWs/wbBZv/xPvpRt1N7O0y99iAf9wSZGsDfjIH8qq0atwtGlfMf3YvAXN3nGx8U+LZOGZ86/3cAZrReqvMbNfF6KA8YjoAdbXssv7q+aqPmadTVTXQTmg/zhhNtOJuMVMtf6PxA2UxagMaL0KaEbZ4EsVHdbAgcJySnxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:37:54 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9542.008; Wed, 4 Feb 2026
 03:37:54 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org,
	hch@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 0/2] Optimize secure erase performance for certain Kingston eMMC devices
Date: Wed,  4 Feb 2026 11:40:01 +0800
Message-Id: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AS8PR04MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 7291217e-0e2b-4524-8571-08de639ec7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0SXmOrHjCbbDriI9rlbUB2YNbl7wkfgRRaaApSkMOdMGMxjHsL4O9sbvcpHI?=
 =?us-ascii?Q?SWj2+HSEGKs1DEObvU0y3kXskm+maQdtKG5Lm5z5tiWOBUMdsIvtPJvLK8+Y?=
 =?us-ascii?Q?4+eRreCJBxow5xmKnZu1bCWhz+JP6QMod4YALwNTyXbXWPTVKYaOXT2pN9uP?=
 =?us-ascii?Q?7YhKtzzlvuhUc1ko+mQqo+iqG9Zarxnbv0MLKhPc0vIE+3udUYQK8P0V6M3l?=
 =?us-ascii?Q?LAV6vUcGKeUhEgFwGcX373zuxmvaFnc4NUiY2g1aqsjqqDPW+vPANBFpOPKL?=
 =?us-ascii?Q?GHH7R14bFs5rm4FlIUWDdTnPxvp4iLUGNhoBK04CHG8f58y4L2XF+txUxjoD?=
 =?us-ascii?Q?nzYqhmGJSRo3Pvs7AZuNMm7NqWDSflZNas9fPdiSngVwhaFhCw0Whm2qj6sR?=
 =?us-ascii?Q?BVr6x5kd9It8s4E5p5iUQOz/A+gfA1dK8wHdrycFr9Wr4ErXVKhTJmQgo58c?=
 =?us-ascii?Q?h1e4Ts/emoRyimJwNrA8tAsPuAMuoDibbl/KT0B5Dr3NfAC6Yr1gjEjJIBPj?=
 =?us-ascii?Q?7NBrE7Q45QSi7fZvDEQHuLf03gv2xn1NHCL23s+sW0/EdwYs7X+2pf2+8K4B?=
 =?us-ascii?Q?Z81j4zFYHizFkmey31PROPlziA4GypjIV74/C/vPXXIefJDUkXiB6abvl04O?=
 =?us-ascii?Q?q/8dMbiPkrX83oN0sO/v9iyn+tl9sOHqOqkpNgh/c0iDKFClRhK8udgeBeIu?=
 =?us-ascii?Q?0pXFV570gUD5KbJqUsZQFilqT4sE2yIuEW6LxLqPXCe6eZ2tIf9hnpceNwQO?=
 =?us-ascii?Q?mwMijJgVCCm+a3b8bg3eWTx766nM7SXTbe5Xc8tXhnXlF5tnEocB9fX6hshy?=
 =?us-ascii?Q?hlVEMqJr+K2ngYWV6GAYcgRXAo/lLPhdGksiKSSEfhQa0/+DLekm/H0y/MNH?=
 =?us-ascii?Q?Nm/3x2Kq+OWVNDaKl3QwsnluSUWvhNBVwnpriyfhR13Kthwc3BO3IphhBFx6?=
 =?us-ascii?Q?LliJxcQqzzlcNSzPWS3fvr/pzbCUBzY5WvKfCW2MKxni8tbOQYEnCPdGw/DE?=
 =?us-ascii?Q?PvSCC/URrF5t6KOANu/CvQZAvyrMjHw/J7gPlBAN9IM2KwlJHoqq/cZMHQQJ?=
 =?us-ascii?Q?iCywMOtS9NmevoGp5gLhRc2zWmXZxd2VsnrZsqW5mO/6fHrtmHT0bbQqO0Jc?=
 =?us-ascii?Q?M7gM+4LNIYk7XGpGQi2fMs/AMdn6j0zSNsdtCiAXUiJ9t2gc/cIc+396kxvm?=
 =?us-ascii?Q?bB68uRCaybZY3UKsno+hrsFiDZphNTLPrRS7DMs2XUVM5ooaxF7wgeyjXEYd?=
 =?us-ascii?Q?Vo11h7OhQxoOeBmkXYDBQXosZvAIK+YZ9YHET/p8FBMkveY6Vs7PkIHC7ms3?=
 =?us-ascii?Q?wTd0hSeresdDLzwWf84nmHYcqzUyCDzHLN2FZxeV54SsoDJbuGgx9APPf17m?=
 =?us-ascii?Q?2LOWR/g/2A/CtD3l9HiqEpekb6K4VHK3SLI2Qa0K302kb3gCpTmE9K5Ohm9A?=
 =?us-ascii?Q?OvIgtskmJsWegGBgLkjOU9LeeMaGXKhdSZJPDgytW1kAdBEymdHDePQ9fBfZ?=
 =?us-ascii?Q?ZgUaJOC1kmy76mE9x+92t0ckacugsCIRWr/HxI+27QHKwWti/8YPYJQlPoi7?=
 =?us-ascii?Q?rMwJS+xekP0QoeHMJaqs/f97FHtV5p6HDEuLjxJuAp7mgl6zaf7XVbGJi1kh?=
 =?us-ascii?Q?0oL2gk8MSdvgUojR1JuTyJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fp/j5STXYFSyrohreHgPzgYnXivYAboneF1Wqmlv+uq890locZb+CH05c4Dj?=
 =?us-ascii?Q?BMHDudQ+qYpZsEptzYkugeX7I2VHNJmlf6HaL7EvEfkmvaqEnz2tVo/mqmJo?=
 =?us-ascii?Q?uIKhSOrMxS33tHjJmMkdXC1UbWprpMF4ZP1qnaKXCfd0YNYUbyIARNru+u9U?=
 =?us-ascii?Q?+Rq0Lk18vgIktMVRo33H+jfAY4C9WLd+mfHr1FsAMFzR3iAWDLckVmy79gcF?=
 =?us-ascii?Q?KgkMbkMwrsLxmcujvXV1pZ1nH6XmuXE9Vs8+YgGs6kN086nQ6LFxg8d2clw6?=
 =?us-ascii?Q?bUR8UNhCgoI0DAa8i1C+WNtygeYS7j4nN+SrLblaf/LXsXrwDrI4QirJ8ErS?=
 =?us-ascii?Q?vh2pQCMHVTi8+sHkvx2AKmf4xMD0Vj63N2MlaSA+CN1OP0R5iJ/RgECBTM+p?=
 =?us-ascii?Q?kWk0xvHDQCU2jUd76GDsxzHHKGDyZXWOmnfIaLMF3P2a356MnDqPpv0uHevp?=
 =?us-ascii?Q?ARUTdyzuahQ18TPWV53c929twZgUuMFS0nPkNgztX/OlqZxItSUrIBuCRp+9?=
 =?us-ascii?Q?rPuVag2M0Z++ogLRblYKP/aUcDd/geBhua/5DHYZoKygytFg7XL2ZWISFhlL?=
 =?us-ascii?Q?JjJEbdD3qalfc0ms3zmTAV314fYhoRL54O1g9lUokMBOpDKbcRJmpCmLpPYr?=
 =?us-ascii?Q?4EAhmVvxFGmt5F6V8vT+KrwNip5hwScjLADlAiEwYhgOJiMC4+W6CB5YrP1f?=
 =?us-ascii?Q?CZnvi9iCvyepnv/V6Fllb0FEHl9gsXMJHjQfTt3JjkeBSk/F99wXvBqavp8M?=
 =?us-ascii?Q?8GWDIYLcNNFRk81VXZB8uw6Pef1eLe5Ryr/a2O2vPk3B7vmSDAa9sZ/bqjUI?=
 =?us-ascii?Q?Qrpa3ZN1YwqLWeJDYofoMceqbsW34k7ftnldAgtdAlI8sHJV1UNYcbSnU2C6?=
 =?us-ascii?Q?MQDOoHlZt4PEFNZ7/ylcMteTp5Pi/Xr+rTfQYpZaaCArdNlpqgGcclsDbI6L?=
 =?us-ascii?Q?6WOKEppRioggOOKuApNxDXhWO8w16R3tVWx7GC8seA5jbbybrVLfKMzT61u/?=
 =?us-ascii?Q?8HllpboyhKdLYxmphdRkMxWLNoGPwCxeKxSTnK+3ILI1BQbuqJ7NSgidZb6Y?=
 =?us-ascii?Q?QgsXFhrb8k2gKUSjFaN4gwbVvbXHDBwzg0X4NDoxIrq0IGZ1FUpwpVrZgLZ2?=
 =?us-ascii?Q?vWuAj5DIvRWWW+aqYireyssYOO+6/EyTlFsOG0rhTuxDwPyPZd4lxBayGh2S?=
 =?us-ascii?Q?R8W3k0DxlGB8gqQdKgiCgGY6ux4qIjMIHWa4Hj22DJtf/INmrVGzBm35WznT?=
 =?us-ascii?Q?nmGPAM1gnzkv5JGOXszwWbgYLXAs4IteFYQ3cfJg4A899ZHJU/zJYfvA03s9?=
 =?us-ascii?Q?Y87urtnipBySnuUbMYc/Onxjw/BwYAPiB1HQmGnIdXmVJ2t/R8pakeskNJsl?=
 =?us-ascii?Q?4bjZg0zS1S1B9Hjd8vsL4q9eWUPfI82zcR1gHMNV5ZJlx3aVuRDqRDLVjsYb?=
 =?us-ascii?Q?Pvcp2BgXncgDk+fxjqad30cBX1qixfK6j6CdKCPMNJKQKubXw1lFWD/ozOMg?=
 =?us-ascii?Q?1ToOKBIaD+exVD8fr52af/DILX4TJpMeXbO8/qkBiS6xED51W4758xQEIIYp?=
 =?us-ascii?Q?2bEKr/w/gkgfx1XGq+vqlRP5n96W9WgJK05C2k1KcXoDeCo0HElre74qEN5w?=
 =?us-ascii?Q?OsxxdLWhAFYPeU54F5rPtiDqrXB/KH0NwD/dHTy+q5XSkocz1gHGxHL1jG3D?=
 =?us-ascii?Q?oj3+PogIG7FdnUox1xmVMUEMdRO1Va+svZ/nu9cxoiFZ+SBWfNW/k7wnJ/Ty?=
 =?us-ascii?Q?AOmUcbsAtg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7291217e-0e2b-4524-8571-08de639ec7b8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:37:54.3613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XswnXAr4bOE7Fsa9Q2Ouc6+DQmhxXx1tYxEMpsaFhCgyAVbOQAg7tIEKL+BfTcrpGc6Ke5dW1n8C+4qiTeSrdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703

From: Luke Wang <ziniu.wang_1@nxp.com>

This patch series optimize secure erase performance for certain Kingston
eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
erase operation regardless of size.

Currently, a 1GB secure erase requires ~300 operations (limited by max
discard size), taking ~10 minutes. With these changes, the same secure
erase completes in a single operation, reducing time to just 2 seconds.

---
Changes in v4:
- Add back blk_queue_get_max_sectors() changes
Changes in v3:
- Refactor to use helper function __bio_split_discard()
Changes in v2:
- Rebased on v6.19-rc1 as requested
- Cover letter: terminology fix (command -> operation)
---

Luke Wang (2):
  block: decouple secure erase size limit from discard size limit
  mmc: add quirk to optimize certain Kingston eMMC secure erase/trim
    performance

 block/blk-merge.c         | 21 +++++++++++++++++----
 block/blk.h               |  6 +++++-
 drivers/mmc/core/card.h   |  5 +++++
 drivers/mmc/core/queue.c  |  9 +++++++--
 drivers/mmc/core/quirks.h |  9 +++++++++
 include/linux/mmc/card.h  |  1 +
 6 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.34.1

