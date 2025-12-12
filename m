Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350981E885A;
	Fri, 12 Dec 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528316; cv=fail; b=BhoJz1BP3Zzhq6w40M0R/lpAK19JuahEKPlB5yr4g8WdCZdZE2GJkLDhzAroqZCf366nUrTM1mId1Q4sQgW3/cIIvqA7Z8lOo8Y78Oktj9NTg0idotBh4hieMvd7DSOO6qlPN/2vBDcKxz0xv7rpFktN/zC9iUHOkSsGtQNNX5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528316; c=relaxed/simple;
	bh=8BG7C/QQvS+URXh9B+fiitKoWNb+vAfv4J3IPVqnTMU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Vhu9Y4+D+nJ/n1L3oqlK6RDjeAcJ0H+XasGCavIBmjtP/fMq8BX+/ElEcTNhG4Xrkidjzl1UREHAuKLkvkNH+SfdZ+5trA3bVA1tz5lCiCfXLGfK3YcPIKk08W2Z52Cpd1VMN2I9lTRSVFaJBLpvkAL/F2Q/5/OelubHALeS+O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CIvK766t; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CIvK766t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYIZmXdodrFtilbs7eQy4HF/H1eV7EGmVGL2DyHD2rbkHDcek1PRwQoYRRTZUS9XlgbO4vO0GSqt5UbIhFV9OZpdVQt042/Ar5vSKz3W0+dzZ+uu77f5aj0mg4oZ0GGHH+GTO8WxvibgntzfHh4rv268pRzVN6nuRSPdyiTpUtvAlQnE5A5J+C/8iNUJ0Gsc0/q9kgwrIhEg3oEnI6sv530nS+V/xp54IGUWqVRWhP2xdBuWrT2ekoqsy8b82K0boEJDFWbbXCUceG9OhSIrHsmsEf1SXzOTDz8KujS1JKzt4WFQzoWnsX57C2LKtdWBefXRGNtGHPR1hbsU1DdZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZN+3TQVhXFemY863MohESXsrg/5JOdFOaEaD8CjTII=;
 b=OK4k/ksjhJ70YE/lSTmyysdS5LfBBfhcjYnY2B5+TeH03+veGaPO4Z0mj19RsPkR89c8G6JlLGahDjMNIl+rB11VbwDkZ8wfCrcCyWgd7ErI1WPKPnOSvKXWk5VBz98ovACuEwA8euR2GPyAzhMMDUfu1BN0ufarI9foAfvgK2g8EAAzYapEcSfYbfx0FHBRtKa0fNA4BDjuDf1Eu88MpvOnBp5hdShBeH1k6NCBFo4GLN0H9aBk7SczlBKIpsKWTdrdBNXbQgWjQPY5gU7+8aGGBDN4ZMfSgTQdQfVZWi8qa0ilNEq7kBnh09tvC83CMdXgXO4Hp9EWWA3rViMazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZN+3TQVhXFemY863MohESXsrg/5JOdFOaEaD8CjTII=;
 b=CIvK766tkCELeDWeXp2ineOwDEKUUW+ZvXe9Dv90jvmo2itHY8Gyyk3lFdLwdefFaADZyEL7kV/mhakOomKZumndYe4Ayo2MKu+hE0BCsRvtdI06JUDZABVUpAkDsGgpcuSEaUNXI2dCDkIzbQAVODUnGZaNWcN5+NcCeXrX9iGa0wBgXUjFl2WSuC6xGLSmyEoCVC1TPULn68QHSP/kPJbSU0Cai7wdrNxVFfPj0t0s7o/zd3vlSt7OWylUyHXYeMRhe6+DypqEzYJuEkV2pGAPBtXvPiizzW9jJZuQWhvJVqdfvsiK0d8UL1rQsauskjohs+NX/L9y0tHId4XJDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AMDPR04MB11556.eurprd04.prod.outlook.com (2603:10a6:20b:71f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 08:31:50 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 08:31:50 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 0/2] Optimize secure erase performance for certain Kingston eMMC devices
Date: Fri, 12 Dec 2025 16:32:44 +0800
Message-Id: <20251212083246.582806-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AMDPR04MB11556:EE_
X-MS-Office365-Filtering-Correlation-Id: bbea9102-3e61-4854-9658-08de3958e29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CGdnR7iX4KGtw0gWZv+OdboR91GUSrSfCL3/U0KP9G3TuY8BMYCGGE2RGjLV?=
 =?us-ascii?Q?kNAqC36m8e23XFVQoKTRrlumE6nuxngHzJd0XM8NtQy0T+/QopVZ0SPAN7me?=
 =?us-ascii?Q?TRCyKh3Kc6Se87hjvPREHGwkTXqUrgIZAQk2AQXa5sciQNiJsTpsPsqvAtcK?=
 =?us-ascii?Q?Lh/oiKdC0RAmDtUo/fFs+4MGymZOsJzvlNBIo9y73htu2l+rAXLRCJ/Nmtm+?=
 =?us-ascii?Q?hD2Du429C1HbdnzcxMG2Qlyox2kl6V+8seNWZtN+38+lxvZdWXzYaA2UMQWU?=
 =?us-ascii?Q?th4Gn5nZlFIl4R0KPlGFNZYIHrZ4j1A+agBamfnpnLJ6elyKLYljE4JqH/8S?=
 =?us-ascii?Q?d9YRh6cbqMI6nS5CSnzjigb17q7NIOGRMu0M3xPTL9OlylqIDsKHMvdZF8NB?=
 =?us-ascii?Q?rovIwGuyR2cvoSs3RswlTbW/nrvt4zJES9I2CAZmHlTFANm9D1kSPcepdTOp?=
 =?us-ascii?Q?tJjmBrcYtUiYxLl/rhFPMeTFFPPtJVNjQoV7aytbnWCmzzC05TtoDq4z4+oz?=
 =?us-ascii?Q?iV/gCHUYf0SJ25I/N0iGJG4D3wuV1GBYyFUZqPFsPRA9c+9PAh8V7YzWjxVA?=
 =?us-ascii?Q?XV1v3P3POfZP4nb3iclu1vyXquLXQPz+IXQ/4jcArqxj8NlMPzJOHSHTixZH?=
 =?us-ascii?Q?0vc6zCDXcX5q/scRhQKeHeTthet56AqQJFZKPrhLHCUgyVjgvp0XcQRgNMyT?=
 =?us-ascii?Q?oee/pZy527syhDEbM69xbu8lg4wDNR4a5dHqVs7wCgqGkqlq8+mTrkMwCXEt?=
 =?us-ascii?Q?Znga/CgS74LU60tndwT8J8JaECMELw+jvmaLuH4jJKCSZ6mpZRjBcuU0oneX?=
 =?us-ascii?Q?abD7BRFdLQjtlvBxHPzbgEfDq1258kgE2bL62VtzqKjbGetpTYCbgwUjdc3+?=
 =?us-ascii?Q?U19PEYBPTS62raHMkTN66wnlH0u14NKD+qS3FJD3iFprlT/n8DF86KLictHM?=
 =?us-ascii?Q?jLrpVAtsUf1Zyz76ASgUB1FlXdCIUAfNpMW1zS5j57KWjO3DDiSiVzNh102+?=
 =?us-ascii?Q?HBdi8+zm27TF2Dm7m817JVkh9fm4yRKn85H0APsssFEiv0AFttKSprNbjSuY?=
 =?us-ascii?Q?HMxp0mkMPR/IN9bPoBY3afVCpiHPPRhpHV6j3ZrNCK69c2zonbZRbmGceUXr?=
 =?us-ascii?Q?00m65xZVWaqAlOk7VnBLaoboVvDeiYvuNlyPw00imkWi5IwpnR9rdo0tYgYf?=
 =?us-ascii?Q?ZZuIuBlxUjXsNAsK8QyhisG76oY8j9kHdwyC0Yoqj9a1vG4sum8kot2dyfIp?=
 =?us-ascii?Q?elsqbS2HNWri5TqnKPDY0VtJtqk0xfZR/323l6/xxZOGGUoaC/28IB9Mkdx0?=
 =?us-ascii?Q?NW/xam5+9i3yb/z4UpaU09HW4Ha7J4ziRVsMqOG3WbCjWmC370XbpNxaMqIr?=
 =?us-ascii?Q?YwyCQDDjqdNUc1SfULgZ0U+5S2YRFv68JRwvk1zbf17AyPS198KiDoQJ+qVZ?=
 =?us-ascii?Q?0yV/qSlCe2NeaGxl3Q++SGoORRBRq5vleelT078W2ECbX/H5uG3seU4/rRaE?=
 =?us-ascii?Q?s+sR678jTY1tGMqFcoAnog4ynswHc0mx5Vfd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UyNxK1hrGjIVnaZiN+m3JlPE6V2qus09QOc7qmHHKYDzbhrX/Bi+Apx2OyJC?=
 =?us-ascii?Q?JllkBFhb3gexnQgwA7KsKnKGQG33a403sWYkfT11rA2RUET9nEJHJmzGsKoL?=
 =?us-ascii?Q?2Co7tf6B8uGWuTkv+5nGfTEMhmwKG2bnmGN/K64J+5YviW4WbCHMglKkx5fM?=
 =?us-ascii?Q?3yuAxLbVTbt7L1SfzTXbxGVdarQ4c9VMqqvg9dNFz0lkmWNNLJHbw5WHL110?=
 =?us-ascii?Q?AYK4A5NHh9iOZxQ+vH7rlX/YnUPa8Ci+aWkDYdrJ6DnNl+rAmYi0NT8o6m+E?=
 =?us-ascii?Q?gTV2yA4B4BU3BEd2qdkMYJMbJYwTaC+mmFeljcDd2WsLG8ZZMEPAZHDY4sx1?=
 =?us-ascii?Q?ZyncpO3SfzP2XhEvZ2m/x4tmC0B1fFXQsR1EXsl9LkDttX5YU/+x/lEuuACr?=
 =?us-ascii?Q?fj/fs+NPNybLpp3ns9FeAZVSXyhImPJHTyEKim+WYrpT/Go42bxRVYsn1wTF?=
 =?us-ascii?Q?4G5LvyE3LOmmr+vqzy0BxrLcEA6UTMD1EZtGADXU7xhMdMx6Hg7TXXH8bHAh?=
 =?us-ascii?Q?DYEKK22C8YNQQb0iKom0fEZom5n5dx4Zl6EEFd2SoWTAS8O7FovEsCiP+vSk?=
 =?us-ascii?Q?tkm0ggkq5+ue9RjUVnhEMJvAHCLaUF/mvZnOsJr36U1/JCcDFFAAB4iOvULH?=
 =?us-ascii?Q?4vdtqCXl6x9JDGTPGlEq36u481CwtLQToD6ipdjwjB1D017JH6Zc/ypFbT9B?=
 =?us-ascii?Q?E7Q+0S4dCBV1BDC6UPLEkeH2/Er09NQKVO9uiqEWxyNXuB7cr4MWlZz5TwN2?=
 =?us-ascii?Q?P3UqrMwfqsn5rwLFykA8qdYz/CyQ6z3sqBv5dUe6YXZKzpsLPNMOqDX4fC+j?=
 =?us-ascii?Q?1P6Df87gxzdq9x7ihlGIhP5qKngAc9ojcnmxfGuPUxNSxpZwD1ULaqXADt+x?=
 =?us-ascii?Q?phPLn3iX7wUb+rCwKMcQ8r6lGMNC2eVWxaVbvR8XFq+kg95H2MJnEiFMpCvx?=
 =?us-ascii?Q?0YyNEeJo2bUkjUVOvboQ42YOXrnb9UG7aNQCcVnQnr5H1vvxm0anNe7Gn0iC?=
 =?us-ascii?Q?qUGbWmFvi0ZSmTS8jxi8GeD+WkaZLN45NaUsy5IN/iS8PTkSNDR2VMHdOL5U?=
 =?us-ascii?Q?AKFSd6VAvM9EoRMlR4HogZziUq7etV4XyTIqGatMMcr8AD7OEJWBNexic+Zz?=
 =?us-ascii?Q?i0qLnm8XKj7fnOech51C3hWRwsGiDubkXILmeP13ZjPT/d88Mysc+eNP36cl?=
 =?us-ascii?Q?1HvuX13gXQpPRj2+h1TdV5BDYF/RF8CP0yMuugRoy0axZIsMwz/pp4tKI5TO?=
 =?us-ascii?Q?GZUiiAve6oHWPepCKoEnFCmEy6QAmvGjaePMmNkkZ73tlKO9sRleH2sdQ81z?=
 =?us-ascii?Q?hM9BnrvoRIoyRikVF5GNL63CQLunpY6pj6Mn365cfesrConuXOX8QYxDYlaY?=
 =?us-ascii?Q?Le1JFQ8wl01eslLhRi/RgC3Xs5hwMqznU/geuZDNOpjjXYp5PIhdN0F/AEeA?=
 =?us-ascii?Q?UmHM3O2++iP3DSw9T/jt3CTFnacpimGSpZs4rGXk45aYHJc8w4cLcSK1dnOA?=
 =?us-ascii?Q?gqpt1EWGWBH+LT5NPfOni7+XNwchi1U0KrTuZvINL15IT71AsNxi3P20uW8A?=
 =?us-ascii?Q?M9ncDOJhfUOZ0ic91gR9U6atwK75/u8e3H3lZdPx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbea9102-3e61-4854-9658-08de3958e29a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 08:31:50.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMJfghOeYkah5C+t6BtpF7EOB3anHOJQ9ADsl0i7LGIsMjryaWPi8Sbjmn96dxM2GDh1Q1hZulEuIA9WL+FUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11556

From: Luke Wang <ziniu.wang_1@nxp.com>

This patch series optimize secure erase performance for certain Kingston
eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
erase operation regardless of size.

Currently, a 1GB secure erase requires ~300 operations (limited by max
discard size), taking ~10 minutes. With these changes, the same operation
completes in a single command, reducing time to just 2 seconds.

Luke Wang (2):
  block: decouple secure erase size limit from discard size limit
  mmc: add quirk to optimize certain Kingston eMMC secure erase/trim
    performance

 block/blk-merge.c         | 9 +++++++--
 block/blk.h               | 6 +++++-
 drivers/mmc/core/card.h   | 5 +++++
 drivers/mmc/core/queue.c  | 9 +++++++--
 drivers/mmc/core/quirks.h | 9 +++++++++
 include/linux/mmc/card.h  | 1 +
 6 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.34.1

