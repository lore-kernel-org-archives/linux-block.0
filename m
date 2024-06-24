Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2127.outbound.protection.outlook.com [40.107.6.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAD2F24
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225997; cv=fail; b=mg3f0xEVbYNLkvrt7Qi1MeWpzi2ZHetI8vujgXE4D88CRdug9KzAFJy6enC9w+sx27zaaNuEM5yNbOuFQjjqIO7dP281L2bsXx6kGICSed8G54meG0acMGlttPfUWg8npmqDCxxu/GavV57yA3y8Kyt8rvreTyA0+5xRe2FpzYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225997; c=relaxed/simple;
	bh=bbOUxyijTk0SNOBlEHt97ZZghUi2oHHf+JxmBc7VBtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JPA9F6ZZ/786vyw6P8NDPXz7OeoanBffaRO/axYJdmXviVi+D8J3a6xSAfAuXhGpEx9LxghSXLtDeqfauTYRfIlWjynwxWloks7Ubb/tQsIiK3jBmvm3v3JZug4+KfNfdazDnWW0cBndH52hrWPAGOzSgRsCObdxPW+NM2P6Rjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=AKXcuEa3; arc=fail smtp.client-ip=40.107.6.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="AKXcuEa3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6kVh5pWA8JI/+LZBBaN1uNm87VnYPnasq4oEKS2xdq6TgKhN2azCRQkeGOisCB+kxU8NmB9asMbj2+IrfQw/ZmvHALC8FaMG7j3O7wq6ROmItI6vLrbiask3gePX+krs9lzjsSL1srpC6fj4y2s2dsf+uB5Mvx0XOtNWfQFcQ1vzj2PsfpSav76yMyVLou5Aogoi3MZC6VJQlDS0jrXJ8NzPaojU3D/cHp3gdRlHXJ8hT0zbve/q46h7FnCyCrInMNRlqi4WI/rgEJCDsvZ6H0upWKFJW8sxhXBF1E/gWV/i3bpCVrnX2e7d2EQ4SDMGGpBsGEuXKX3iDK5CNgyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp32iAqbX63nVrXMhFwJTJ4kvIb9vgnLVyYP4tSoV/I=;
 b=lb57Ui/4jJ9sbuMj9uV39yNR1BWMWIZ9VgwQmtARiTsGNFc71ACYsRF5cXAlKfKFs4WjWy5OdC6QCBQp20CXtFRuJgLBGhGkL+2ERdrHXPcXtE4KEFF/l0b5qCwiMbP0UqfSG7ZliPyPfY8K7h11pODOvc82OuSCeiQ5ArN1Us8gVgqkc3v7AXeu79kLVzJRcTdH1iU0BXAEcU/sCl0Qnyo+ZjyPp2q9hB0DsAlF6voNUqlSpbrka6HwNGYzno1cpFihEMaYVS76DqofGUOtz8GQCvlp1fI7c13sH2N0pMKZUnZllgSg5Bgi3hFJhM2e1YmPw5+W/w7oRcgoGDq2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yp32iAqbX63nVrXMhFwJTJ4kvIb9vgnLVyYP4tSoV/I=;
 b=AKXcuEa3ITbG5Y4rw0Rad2tQPm6ip0sdl+ObguOJ+/UaeM7HBODy7Dexkb1atiVmxwk5kXWkxu+zXXW8enKFRC9hPrhoaw+aCWw2DrayySyZQ2U3qG2jti2Y7PjKPO9s6jZMclDQ2WQTzxtKYnrGTmzbMgIZCN0vCC9BvwXyFgJkldA82NtLOirGXYAZkeN1YcSKSmgZa8Udyqr6sBkhApbKcySn2s6yn+KhIP1UJG18mTOcd8lcvPERQBQzFfzY+hPodBJnksqqanQGY0+IjL027RyfNwa4vhbLibYIOL3W14Gp/dsIv7EsHElq1rjl7Qw9Ql6a/REacUbVP0zWCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by AS8PR04MB7605.eurprd04.prod.outlook.com (2603:10a6:20b:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 10:46:31 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:46:30 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Subject: [PATCH blktests v2 0/2] md: add regression test for "md/md-bitmap: fix writing non bitmap pages"
Date: Mon, 24 Jun 2024 13:46:16 +0300
Message-ID: <20240624104620.2156041-1-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To AM0PR04MB5107.eurprd04.prod.outlook.com
 (2603:10a6:208:cb::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|AS8PR04MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: d150b54c-1c4d-42ea-2141-08dc943ae80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021|52116011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzI+JiJjFWGKqzn9mNuXhu/QO2iCU0/VjjUDqfpwfczpK6OKbt3fZF7bf6A9?=
 =?us-ascii?Q?NbZiSbug6v1VOB10/NBZzMiKb/xx0Tf8TUfXOP/YGTKJn231zqz+2qk3Ey/U?=
 =?us-ascii?Q?+8hkSMBuqEp7Q2cKWL1D8nvdBqL8vxCSo8zuWvYkaQW4QEFgyL/7oysI+Nfv?=
 =?us-ascii?Q?zHoRH0YP8i3FoXLESNPDCarBSyey58nIXGqixzbBU3VSuB05kYnqcz6NU81M?=
 =?us-ascii?Q?XzxkMzb5BXmBtV2g1szBM8oS4+3g+nj0Z+xsGHAQcmjQzKMVjxSiEkY2SAbD?=
 =?us-ascii?Q?MFtpD47gBdO1cPaJZi2jCTZGmeIeeVHAHA3umpBjb71xX1CXxTW9xUSot961?=
 =?us-ascii?Q?EEYgvi2+WG27Ac1NpXVzwOrGZefOcNZ7AKdtdVp7oNglz240KHxTMOUIik9o?=
 =?us-ascii?Q?XPrvpr7sA6VNHoZ5U64hJZ0jN+BcRkubNo3PXXLWGtdfsCnPiIAZoA3BjHJ2?=
 =?us-ascii?Q?RuseOULR8jdcMPGytttkmvOx0mAjMpNZ/DLBH0gVcxv6JPhXGSxHNRxahRXM?=
 =?us-ascii?Q?tA8TGNMkXS8CSV9YHPGEKc9JUr9ql+7IYzSI1RafLhi2PpxBSAbRg0DdEsUx?=
 =?us-ascii?Q?1Z/D6Yiet7B8aK4ARXPjAyOwbddPysSyu2zY2tUdIXxDKhTcg751uXYM91+X?=
 =?us-ascii?Q?zap3Gh1mcWXh0/ATmQt7KqORuagClGMg9e6VoveBQ4iyM+ksehSGVpdDFRv/?=
 =?us-ascii?Q?dNWfkuyQvOw/NxFNTueupeLmnf/rH3Px2/+1MhYyfjKnrarkP3caaGaLP6uY?=
 =?us-ascii?Q?YnbSFmkN0tK5p1Iw2ShBVqoM4ehRTyRktMnaZyO/3pBg/BbQ1Zt8ivMwRhz3?=
 =?us-ascii?Q?TcY4bEGkDBC/TS7PN10aORJd4NfOK0kUWw8GjpdoZ0f2htjuCAV1EFw6flzy?=
 =?us-ascii?Q?oY+ZMz/qnZoCFiA8Nvh8dBMCx9qpzfKp8FHrO+8H0x8Ls9mgxIl5HMhuQHOx?=
 =?us-ascii?Q?joeEEsb607ywK1obMQyMfwcIpPWVjFaOq/8+uhPZUHQOHpcGbJef8xrZ1DYU?=
 =?us-ascii?Q?XMGzOO2xD/j+3RE5wkpijr4AvhZwrkWtG4lIaBopxJtTajTC90hqPBiKhj1X?=
 =?us-ascii?Q?vcsdX739Dzl4nSKl4oZez0GwP/V0RnIh6qvrRN4WU2mHvNn2yhS54JJ9Ph+3?=
 =?us-ascii?Q?p9qrp6Z8+gV7e5N/4yoW+l+4rKS7WElTo34RMEnBBQztvv3yYegU3Dzma7IO?=
 =?us-ascii?Q?qmRy/Rmg/pWpD6i7vgpHm0l2yGLLkP3O6bY074yUSqZdcg6OkwbDsrZ/ewXC?=
 =?us-ascii?Q?lCLTYUoxpEw2hXjrbrze8/5F7eUePa083BuPAbE2XVPmFccmzEYafOo6Om3J?=
 =?us-ascii?Q?+8WTIdlDLveMtxh1J5NfAnHZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(52116011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qcga7OopuW1nljEOE5cKeJHNNGHZdMY9qGIQ8Gb3QdS6OA0Bcn3PtKSSQb1j?=
 =?us-ascii?Q?Eycvz3XrsnshwqqbOTFrHj6GxomOckEq0szlyZBLSUmnek7ojBpqIlnW/DmY?=
 =?us-ascii?Q?hHZa0ClmXdsVdllybdJXb8CaubiXP1mhRGUzQjW7x2pNG5WEfyi/ayCQiPUl?=
 =?us-ascii?Q?xkeknp3mYNZ/5QvI5dJ8Xo4SEE56T0O3coZ8yLMZ6tMsH7iAaRSh8hQX4G3a?=
 =?us-ascii?Q?f52Ct0gEPlXoGQkypEahcISFYiFJo6zdJLAjEkVbExphsWLkMERFgWKbkRnb?=
 =?us-ascii?Q?eqsPQVk1V0YI9vgu5W0YcOsHRvg4uwy4fdPkh+1/+XDqhJm+pE14rLoYXuL+?=
 =?us-ascii?Q?9USoRPgj1ad5s4e2s4TnHIpr6InHBnnTPdwnmsRnaLYFm5/vbdrqBV+6+h5w?=
 =?us-ascii?Q?K7GO8alFR9H4pv6n59RI6KkiRMK5JViLLDeYfzx9jHXRujjkmNx2X+Lbpq1K?=
 =?us-ascii?Q?KEA57CDX4osMYbJSFmtRNHBybtqKh4VtGXqnA/bq0AhCqOdZ9Yig44bilLZh?=
 =?us-ascii?Q?1myJmKDJKB6OXzAAKeoBaw9+ITJpiD7Izo+22kmD57qebah3r0xmy1eJXwhj?=
 =?us-ascii?Q?M62c8ZmtmkJk3PgreGoM8PtHOInfV6M2zXq9502r1paEAIgFna2YqO/y3uXu?=
 =?us-ascii?Q?PGdVzOBtv+6qWXKkFtQxwGI6x7DcOCir7pXb0e2dDTWf1DJ9+Hbljan2hlZ3?=
 =?us-ascii?Q?5bVVZHCkK7exgQEswmyO1U0wLOblV0QtRrB+CVHtkDotEiiWSzSyxqmpQIxP?=
 =?us-ascii?Q?7diIpPkA/iTyLo4WgaxIHjsGm1r2Fr4qaz/JymZ+y/E8emgc75X8uCZ4QQmk?=
 =?us-ascii?Q?WgdZB7ACE3qH14wQrwpvEXmJZWetD4Xnq0lOIRWDIxTVcU4i+nsBWV/zUEDA?=
 =?us-ascii?Q?JQ3ihSHutfGF6BUR8/DpqtWaYa5brAtIh9UTQrsP8Nk7ebtTBBDi8/e/wy8v?=
 =?us-ascii?Q?4y6LPYziB/p1BnsLcW9mwckSPzHenro1y+qAOHb8Qw0tP20k24kpafcZ8yH/?=
 =?us-ascii?Q?H0bdH0wHhHd9kZNiKyd0/bl7ZpdoRLw4/znSS80Q50UgBpWbQqiQdhk681qX?=
 =?us-ascii?Q?N/T1mVYzq6vP1HKN34CNRJM10ytZ7rNmShwDZ1b5Q+Iz7N4G9snZSVCfUgm9?=
 =?us-ascii?Q?g6+tvR1ZOuFJaO1Db22WFl2IxftbIrQh/DpAdzAjCeBNGYEOugE1Abr0DLtD?=
 =?us-ascii?Q?Tvnep7fxu1xpYn/J2ujteavk2/PDWZSY27cwZcvS+RylR00oOCJDGimIKVdM?=
 =?us-ascii?Q?4+NfvuEm8Oi/YeKCkChzk8sV8H+p58zkfTox4bFS+vXRgeTAzG+VOv0uIqut?=
 =?us-ascii?Q?h7R4ZRFvoFU8TBYnKAr3g/tUlXZlUENAIXP4Rf0u6pffVdH20F1RfZfIl6+H?=
 =?us-ascii?Q?c4utpKXUW/4wmU5XmcNu4YA1hLkOaa/vU0iNlNKkFSHR8aT/KlnkqHS0pDFi?=
 =?us-ascii?Q?g+ghdK1se+06RKBrUKmGMiwN8HR2CZ/ung0gJsUr5bgR4/2sOnCT2NjsCgmQ?=
 =?us-ascii?Q?bYvEoAXQdQfg2JpYT3wtp3Ep2oR6GRG3Vny46tGY6jyuHCeI9hFWh0a9QvBC?=
 =?us-ascii?Q?dBUr3hfDa4NIMqz0UmTEVZSYIeZRhZ0CcC0S2Tfnx2tY69OsLzzvX+IRhn54?=
 =?us-ascii?Q?X460keOT7hefgwo77bSHirn2Vg7DdEKq1Af4cKTZr6Xz?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d150b54c-1c4d-42ea-2141-08dc943ae80a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:46:30.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wvln9yzdqsnl+ZhQEKWZPI1AU7yXvHyKsH1zxl1eQI8sKgHlJTPnaYJat3GEzRT7YIhIqnWIa4L4eliLK5LhyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7605

This patchset adds a regression test for "md/md-bitmap: fix writing non
bitmap pages".

The regression test requires a network layer as the underlying layer of
md, it use nvme-tcp as the network layer.

Changelog:
v2 - applied Shinichiro's comments, use common/nvme instead of
   tests/nvme/rc, disconnecting nvme controller on cleanup_nvme_over_tcp

Ofir Gal (2):
  nvme: move helper functions to common/nvme
  md: add regression test for "md/md-bitmap: fix writing non bitmap
    pages"

 common/brd       |  28 +++
 common/nvme      | 595 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/001     |  88 +++++++
 tests/md/001.out |   2 +
 tests/md/rc      |  12 +
 tests/nvme/rc    | 591 +---------------------------------------------
 6 files changed, 726 insertions(+), 590 deletions(-)
 create mode 100644 common/brd
 create mode 100644 common/nvme
 create mode 100755 tests/md/001
 create mode 100644 tests/md/001.out
 create mode 100644 tests/md/rc

-- 
2.45.1

