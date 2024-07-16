Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48A199E84
	for <linux-block@vger.kernel.org>; Tue, 16 Jul 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130644; cv=fail; b=DyKO0YaUD5XOb8QtUzpSgnd2eeyOj1WpcvRW1hC5szQKfeVxdRMFu2icNbZ5Dlh7orqlayLtn9+dfArhRkBjYIDmtwPNUd+CRE1c6gP4BMf2GnAV1uVWIiKPPEs2z0bDW8qFcvxMt0SLqaYprBeRMEP4Sqq3BTrGtBB3bK+eFRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130644; c=relaxed/simple;
	bh=H8Ms3o+RJfrb2MfP2z13dTbg6Ww1QVkyyvLjf1XgG6c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WvhBHL5aJpdP4Ii/oPk0wjw5bjRCnl/CPslY8T3qRTi7Hdg2HgMbQfEYpMvTUcdR5QGj9dqc+c+pL2HuMkq9Dc9p0wHnTpLwBXFf9FyLnOZClTCmbosm63N2eGa88SYkRJJfWPrQDow7EhV0AuheIjqbL6mkCMumz4GWrEtDBpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=Lpzo5wII; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="Lpzo5wII"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhpJOdgLAUkZ5GhDEyfy1Pp4ys6MG8m6u77vUZT+a9jPK+FCyaQEf19BQW7Lju3i5AR0nGSVwt0YQbUkIUZTaMlj9PEV0YazJWexTLKXJpJJi0idn36CKSO6qZOdZHPvKis3kC/5SS53IVgYfng0WIBhIgmay0Jol63NEdeyXERgSp8h9puq9KyHNyERi34PgmDp9AhNUU7INU0LP6hVpedO4rQB4O3oKvkD3Y09eozWoHipFjVTg8dm9MMEWDvp8yHKBuvsFDiVf7cvicQx9URb8gs7sv7DRAwsAUq94sIHXcGZ2C0df0vU9QOVDEAs1oRJ82TQ1lCzF7lwQ9/MdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CXxUVMFyqkTTueK0QZ1UxuE2ghnPAV/kMXK+Vdp0CQ=;
 b=lEVtAUJZ6zj21U0kfYU6rVEew8LIOUB/+cIGxXu+iSA5a1uwdnuXDYQSgu1zkPydvVn0/ni1VbuBnv1bh420Jy/fPjTTgiZtaGOoimdJ6FmNuAJCgeAw1QD1qrHXmxgh+veUoL3Z3P/jwx1SaobxPw0m6L3yaU6XItgQjJCIQFwXH8U3MMm6mZzldyL9gO2GGDHMB131EhSa4wFI28pHwyCvhBEPd0p5fd3HVHsxCigxVaPr3ANKdm10pQ1KqFVt1wNVgJIly7Bayr5QfyUPSjC56y1BM9uiJW4LuGzmDJllrWWyeOq/fvwrUrzSxb2Pa+qclH6KI9bEKfakidrQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CXxUVMFyqkTTueK0QZ1UxuE2ghnPAV/kMXK+Vdp0CQ=;
 b=Lpzo5wII2WEiUmcmFwWBYlhB5k46pXUEo/f3O0XcLrZLTXVLe0r6rNVdXjRXzviCi49Vv0hVgMQ8FBKtkVPlwhK3/UjhK39MNXkR9Gm1xClLIKQKp5qNC7dS/b49YVf9mg4MznBE6flOZTxfPy8mzH2bnfA+paANaEUvRnRtsX2xvUYNGnOSimtBiEmwIdgN39f+uUt+vve8HPxSOS1NQQ3pnsIFuJeu4NNSk9ovvK58od3xzMlCOcvR1WC/O62Tdo+kARj0sGNrH+Ye0XVnQl9sMxZQl43qUo3EdEdtqwxCQxnz50x7qYg3EU7oN5ZJRYJ+JxhP5TzpT3ik/q9Fog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:50:38 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 11:50:38 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Subject: [PATCH blktests v3 0/2] md: add regression test for "md/md-bitmap: fix writing non bitmap pages"
Date: Tue, 16 Jul 2024 14:50:22 +0300
Message-ID: <20240716115026.1783969-1-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 1956dc20-485f-45f0-c005-08dca58d8296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFZtZbt9bfnP1CfhR50tYdtRTP+4iPNnmFBhE1hOeSItaZvBDHvpb56HfrZA?=
 =?us-ascii?Q?BouvCwu7o+2W7B0fzxXtbBAW8mlqUZUHkhY8tiQNAzZQBMBsGnSBm2UtWC/6?=
 =?us-ascii?Q?hjQ8SToIRz9wkqXeYt/KZpTA7qmvR2DGJub26j4k8F5SUApy7OncDHeY84R2?=
 =?us-ascii?Q?W3mNTtl087T1AFtN1/VyKUIRp/vI+6QDRE/bgT6N0EIRCu76SnLcMFH58OOu?=
 =?us-ascii?Q?3y2sLmiI+iJ+sqaf1IOpAn4tLbQy5XIHlOp3K/ciYheBVaorDsdNN6eUL+O9?=
 =?us-ascii?Q?l3zgpOvbowsKQ6kcoXs+3Fl6oAvt0M9CglXS9mn0LcCRrmyQIhNyvLNkeiSZ?=
 =?us-ascii?Q?IpKzmYwVUCvrdfzENTNslMIkYkP90Ip+gq5t2FzRSIsnk3TqCVOZDYAtasYP?=
 =?us-ascii?Q?LXImTlBPM1idTak+GIekV1fJQOhJtZVmEnG/RwPv0OL4w63XbKAF1f8g6NOk?=
 =?us-ascii?Q?l8DN4vvODQUu5IeDzt8OodrQV5NnMdIKEdUSLAGuoxgBTQuF0p/3UikxGfyi?=
 =?us-ascii?Q?QptlvegODn3lIpOO+h2aoswKx3hJ4O0ap1HA3Tr1bY5wE6wLCbYRdRneVgEL?=
 =?us-ascii?Q?MtzBo2w+NgSJRg4wroAwcUAf5+4RlJXHbLN17iQXkaLaJ76IUbCYmz5BbIu1?=
 =?us-ascii?Q?wLioOpqy9M8buYht7yLg7zbDgktFhFbs+vgDpalS4sTd3CuuF+0oeSRiT16E?=
 =?us-ascii?Q?VIIr4C+QmYm7iZmiHfZ53eeowNd2tmFgQ5wU3KqL/fVY9BH3onTjTmmjc7Kc?=
 =?us-ascii?Q?ha4OGK1wOHxyQEUHrTJMZSapU58pagGqLAC5N06kTKqbI+cJcUIlZHKhCaxE?=
 =?us-ascii?Q?wEK5/dwAlv0OX85/I+0PJjVYEO4z1zxJo1L5xPXAs8MTjRbyxT0bksJtiBTO?=
 =?us-ascii?Q?1AkmQGs6LABUNS7VcBt0ldJG+AU/N3nI6O5LoxJCzoVhNexneBCICJC0ghzw?=
 =?us-ascii?Q?6T6rlG71st7LizgzzsVXOfht1+d5psZcrBI4UpHCYuc/rLzZeWFAo9+DhOX2?=
 =?us-ascii?Q?9NWps5RG1QtSg67fI0dMrQ6ehgN9OomDdqw2WpxjHFSVgxlIwVmDCPWW+gK6?=
 =?us-ascii?Q?wNqkmKHPytLwgv3nN9aNB2SuYyJZFXbcInTtew0auEf2Z3asuNEvlX3qUEAe?=
 =?us-ascii?Q?MYDWJSFobSnzVEPHwZjTAe4L5QjLgfaBBUHwV3WY09XT2F/ucc/8lAZ1EMU2?=
 =?us-ascii?Q?FK2c5tmi4qfQX9nCTnC+Di8Yhjl6L/YxQ0xviTtYslkMnRLLZqF+Y9VhWD3s?=
 =?us-ascii?Q?RQvG7EGu9d6IHW5ftFOIk7u2FySPYx+E5L30/aqbSCH1EDBpPD0GPUTZ7ReG?=
 =?us-ascii?Q?GdEmL4fUM2fa++dBNNvNoM5Af4zmuV/hvqisp2lQBq4or1Tj+wtllrVv+PFv?=
 =?us-ascii?Q?8/qmMBmpDn/ApkiMXDMoa09uxUuuzT4sYxoxB9Go3hdmAGjVtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4WwuGYKV9FcyBcTEWmt/ea8NRwd2xhr14U9aO432WwZi7+6K8QSr3wzvk5H2?=
 =?us-ascii?Q?zw0bvFi4+Lfvfsws3A7quRRCOJBGdFti2Bq8FAyPuqsg6j1G7DYrZgteQG15?=
 =?us-ascii?Q?0xO0Q97gphyPkwPLHz8d7moAL0LLRLjl8I1HHTk7NdAjSYjZJ7SZ3WEKiFLy?=
 =?us-ascii?Q?AZRBAbQoYgGBj2ALFCP3YRgrdZTgdWsI3zKFtsM3veq2FJpjpfjtXadxkNkH?=
 =?us-ascii?Q?0xbv63Z7lJJXQPjmZilIlU1zEGsozaVLu+/OKIGizEoo+g255tydwIWczTq2?=
 =?us-ascii?Q?Lt3oUNRYytw+QqozsRF3KA1Pm8T7CbNL9xLTlFis2bevGh5hDxoEO87+UD6k?=
 =?us-ascii?Q?typ+nMQMwLYrvPVZuqphwWVqbPYJkxiqJ0Ykn01w14etz/XaN3IyXFACcz+t?=
 =?us-ascii?Q?kC00z2RoL2Vc9Yk5HcLWcJ5WpTwvIg4UehNPa5XwOQYCSTNi9IN42+2veudQ?=
 =?us-ascii?Q?3I6sthu/+gG1U5h3sgBTrzZQSQYUK2IRN0tFSSpMDzfCzXwMt0+9B4RW7JGZ?=
 =?us-ascii?Q?2xb1IMbGteoopzV6wGH1eVV31JdN7PpFxiGi4IM76VCWRkJgrKTROdTYlOg6?=
 =?us-ascii?Q?4YlVQ598uMJoYxkGm88qr5AieKReITXsFzMhM0ouWoiq9qCGVKcxnJN70185?=
 =?us-ascii?Q?oMaMEqT1Dg22TximYdlfCEQDjskuZ5QGIzutd38/DRnPrs5X6vvxbJy88MJV?=
 =?us-ascii?Q?kMDxKS47iSefGOYjyj6Vi4ph/Rj5HV224BB0gyzw87XpKSVcd88kLDRKVXjB?=
 =?us-ascii?Q?YPfRpYH5iguGfV8k9sgyKTmuQPO+yGJrXBlPQ7RHD+okUhZfH1N7Kzgtif3Q?=
 =?us-ascii?Q?GYKjtu+OTX+zOTwGHEsNMMPVWWMNCuUUe/0XG7oRIDtW1mTjEH4k2caho33U?=
 =?us-ascii?Q?XlWXAl+B0Ogw2cdicuTY0yfQaJOUL8iqq0Wy5OqcBMD5gjTSoJ66+TyHhy7F?=
 =?us-ascii?Q?g8eXMcFxQL7T2TJsaU4WJw5YAXBfwAAwWFsb6x83GzND7RBIgPY/W1CVgukI?=
 =?us-ascii?Q?2kr5v1iUqAU3guc+vb6UrbReikLYrvdyNYo/eMeFRIpCF7zBKvPDFcVuxtXe?=
 =?us-ascii?Q?fAsrwCKq60Lkt+ODT4v/uAUPPHvIeYSfSbrpu/6v2jzPQK0lTR37k3thAGv8?=
 =?us-ascii?Q?jA8VTyP4Wx7d2nR3PinGvv4Z84/zR5r+s1jgcrnA3cCV4lJcvqSQH6VzRgl0?=
 =?us-ascii?Q?WbXBINISwrSqHIt5fcLkr8qnPQpXwU0M/3AHkUbHFaChlttg7ndbhVQlD+gV?=
 =?us-ascii?Q?UiE1gRcB5jajs/WQBqomJlbbiI9uMM1wWZ2L8T6oljTwolZbbQIybx/ri3To?=
 =?us-ascii?Q?vQ7zeziFAOfD4BmJz0mVZYOu/Dz0KC6z/Y65NSBAwXoNmk/tmNjMH6q3Iy73?=
 =?us-ascii?Q?vBy+SYZBparCOenDtx8NAPSl3RXqsmps+d3JFxtbhDu2foeZFFBzRAqrTQyQ?=
 =?us-ascii?Q?XqpfZmLmOQcuW92+f+OloqYxNRjeIXDT1y/fU6utnsX8uJCtzW/BdnaRIIP4?=
 =?us-ascii?Q?KWVxTN1c/1lMFqCrIx0BQv8LXJ7Mt3uC17ln4Q9XxLornUGU7oKHVaS30MUe?=
 =?us-ascii?Q?OT5G1PB57SIZutN9dYHARLbcOHm4J13qrlGXw3b6?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1956dc20-485f-45f0-c005-08dca58d8296
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 11:50:38.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsLtm4BtJaBAqUU7DACLEX9VwzrARebhJMkndIRjv3MiX70sNAb5YfzbyaVuOKTWqPzHpONpz0fVFotY63Zvyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

This patchset adds a regression test for "md/md-bitmap: fix writing non
bitmap pages".

The regression test requires a network layer as the underlying layer of
md, it use nvme-tcp as the network layer.

Changelog:
v2 - applied Shinichiro's comments, use common/nvme instead of
   tests/nvme/rc, disconnecting nvme controller on cleanup_nvme_over_tcp

v3 - applied Shinichiro's comments, fixed shellcheck, moved
   _nvme_disconnect_ctrl() to common/nvme. applied Daniel's comments,
   using ${def_subsysnqn}, moved _find_nvme_ns() to common/nvme.

Ofir Gal (2):
  nvme: move helper functions to common/nvme
  md: add regression test for "md/md-bitmap: fix writing non bitmap
    pages"

 common/brd       |  28 +++
 common/nvme      | 636 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/001     |  85 +++++++
 tests/md/001.out |   3 +
 tests/md/rc      |  12 +
 tests/nvme/rc    | 629 +---------------------------------------------
 6 files changed, 765 insertions(+), 628 deletions(-)
 create mode 100644 common/brd
 create mode 100644 common/nvme
 create mode 100755 tests/md/001
 create mode 100644 tests/md/001.out
 create mode 100644 tests/md/rc

-- 
2.45.1

