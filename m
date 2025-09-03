Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266212D97B8;
	Wed,  3 Sep 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901661; cv=fail; b=Lce0Lv9Vd5YqAPt3jUidF/5WDITyG4j2zbusoyeVyUIer/WwVYmo51nh/2OyhcPXkJS1gL7rJNvCAITozfDcykS8jGXBWkEeXvxrk+J+ijWYZIs+hB4ZEMUChu1kHVnaV7ikg2rbxT7pkoT4lRHcL4nanim7aindNRbO9i2toKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901661; c=relaxed/simple;
	bh=5KugmdzzDY7hWWRrKqJKVJqWBeIKOoTRtGOz5SL/qok=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jcda00z8XBH6SW3EhNFNL5DEFm/2Ow4nt4xpIqwaraiUCQmf+3LWmYqo12AC3v69drd18aNKIJ7iEK3aVjQuzHq1Xww7hN6Xi8Q1OgBupSmgsOYOJgZVXLR99udkt4tNm1Notz755MZWQ3BsubdiYqdR2O+HnPb1UNI4hLNcMaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kD/wsaku; arc=fail smtp.client-ip=52.101.126.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kD/wsaku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wc17eDNOnuj8Q9bYiixgXzgp4p/Eoar1DBlTpl1iKM0D5gloroo8FhfYO4NmN3o2iQp3UEpTYaJgcodrdmb3QkO9YUIPPdawwVtGaDaO/zGYsygxs79xn307Pb8qngU9XN3RykHPPn3+gLBRx1wVKu8EtRzytBmolCZXoNVvyN8rEsDEA0UVpkSVfhdRgl+5RW5KrnSfhT1pAVfZTOiEwhRutm+wiCZ84RRlQRCpNyaPDgJqlou7viYJTOmoORXz1RU2KP0QBdb3OyH4KK0My+tsTNlmRQpkyKE4sbMAVPdUx+ufRvrJIKyvMxJhWfuQtYO1eUOGzguBP1Gm5Re7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7jibh2S3q8oqaG0IcD0xwaK/tKHOFLnr5OHjswo8T0=;
 b=TCTMf/1y9usxHvNlKfWHUhk9UeGZ4bC6oZ/ZvVBn0Ju9fEibrXoUcM01Yd73d2qsABYctmWgMiTFroROn9PIRcJQ3QMZMcnXXoeZK1CcdC04i09EKLE8hkCw7+9yMzTn48Ez5kZuvzoVn91IW+BxJ6Tp3aingnHnll0Wg4drnmsbEsEWJi5i2vCs5Va5Lp43iEHKghN3o4QmQujMOCX5yrDQvNUTo/MuvTWVV9y8FQNuCwTtDGNq2UxoyRS1GX7QVl6/Fm3l5U2xgoDF0lEfFXVv1Zg21ySXZzUGvwP45DPw6rX+LDj8iIMH0DNV3WVVlGI8+K0OXP+U8jOSpKby1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7jibh2S3q8oqaG0IcD0xwaK/tKHOFLnr5OHjswo8T0=;
 b=kD/wsakuTnWwiI35lmJAhv8JyGnZsAHUuJY0wMdskuUxojuLExkx08yb1bjrTK0PwcVcIze01KNWWw9kJED0aXmV3oLFTvBU4rtUdnpjDLd6tzu+thHMUHQUfCAYZ/Ugs7j3Sxrq6+9lBaJUany2+W5MIJaNwkSh5dB8W9zUPTotjGCBjdBFXMbH9w35cc+hemZnhzZZkrCAWS4lF1xwS+xKEoAPgnXsYr6wPfwDS5FGNsVuui3QjTBIC4XrXCKOEK5/EQBhP3S0AuHHFwCSX/ZjlvIqHLVe5YcOpm146fU9wuyR4t3DPkyY5yAvTqmJlBGzGAdfaRFggW8SPeenzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7318.apcprd06.prod.outlook.com (2603:1096:820:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:14:17 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 12:14:14 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] elevator: avoid redundant conditions
Date: Wed,  3 Sep 2025 20:14:05 +0800
Message-Id: <20250903121405.386483-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0151.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::7) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 7180c04b-d735-4448-8aeb-08ddeae365a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BA6C6sMutO5TWIvBsjfIxirACrD1BOvXCoQs8gaOgIdlcjb+lyuVYQDUfVOQ?=
 =?us-ascii?Q?dcnzKw0SEsFSU9S4bKARBt5NuJNktrzsYyf0GemAd1/2EtS8N4UTLX8Amk3I?=
 =?us-ascii?Q?8EEJJA2fgR8oZloSRzqoAbpVM5e6i3nGKA/l/m5brGhh+0uksgFlxs7eyHyJ?=
 =?us-ascii?Q?d5bYatIOWp6dlJIW1SnEeE4j12YUsWQMzvF9j4cnw4mLhl6s1HAuqeOq6pEU?=
 =?us-ascii?Q?H3NWV9GJII+s0qY3nTL9WdmvkI39s7S4trLV0xcOgg7o3sbmiMy3wKbg2atH?=
 =?us-ascii?Q?Eh27ZNdZt2ljfcV+jJJtkuC2gT+XHlCzmwtv4PpCEq35hSUn7XL+sqxOlkWG?=
 =?us-ascii?Q?HttPbyuwq2MZr8FlullpftZMXzznqQMZ8og6rhY2iKkHaxk7499zx/9i1rX4?=
 =?us-ascii?Q?h9Q5eoHaQ6GFzR8NuI4mcjwLfMkV81tryEd+41SJ1l4KbTdpOiT0njUNveE1?=
 =?us-ascii?Q?Eec9MhxLpIQxEa4kfgRaJ72xleWuoSo1yN6AE82tKnoj3zTqDfvfM/dWfiKC?=
 =?us-ascii?Q?mCTweyKswzpIxn5sDGyYAYgXWspIO+wpjxoX8RRnDkFmowS5LzDbqMA1aPPh?=
 =?us-ascii?Q?t7RPQ9/zx/zY+RPBD551Zhl2td5PYrUft6pdDAHa3hLhYrHfwESk2o2wpTAL?=
 =?us-ascii?Q?M81nMxhiph6ThePu5HUJWLiojQl5pMSWOiuKqky4R/2Xya+MICziuJNFIy8J?=
 =?us-ascii?Q?r3wo8ICGnmpT8ZfxJc4wY91tI1JGt7lSYrcyeHDqWDKdr3vb2yJcq0AxQPmm?=
 =?us-ascii?Q?BVrll2Q2FyIPbLbzRuiIqZh58uF1ycMHmH0RUqUVeYWpTZGFFubr7d121Eft?=
 =?us-ascii?Q?QI7BDAFVj2MGYhIZDe1XgD79thge2stRTriuBfqfwjQ1NouI3t9YOx0GdjYE?=
 =?us-ascii?Q?m3JfsgsA3CjjU6gZPoslKxM05KCt06TxC7TrR3eE6hwKK+EBSSpO5migNoTd?=
 =?us-ascii?Q?CYwhNapBoKcCRxTVYZlqzAYS6H6p3HU7s7VsKOzF9GgqPRixMu3XYCtDp1Wg?=
 =?us-ascii?Q?08HlkPBlAyYYw/GGPceX8PH3N9e178f9fCxOoRHCEIslMntY5UzLaaIZinUf?=
 =?us-ascii?Q?db3wiUCYrqdvDezSu0EmTMepH4O9ky8BENDNg1GUN301MwEheTgOAL2BD9wQ?=
 =?us-ascii?Q?iLsR29fRafZEGKq1Hb0/DjbPGCpClEEEkMxoUSQlL0HpGhMvnmOnk+BIW4Gd?=
 =?us-ascii?Q?HelyBNK0wZxdtRvBUNMwJBalTrWXoAkK4dhwNz564WWWzIakc+4PespGYqbn?=
 =?us-ascii?Q?YpfIP3aSvx+XOCxVQLbs63xcvEtNEN7opEsLu8GE+DyZcJgBNfrl8LwEzm6f?=
 =?us-ascii?Q?0QeruKyW1vePmE03aamYxN7pynH5vEMz4y1qeB10nvFYkLqtFq091znsbC07?=
 =?us-ascii?Q?GTnSCK9wbrtC0Kh+htTqpzGR2YCD5wf9GFuYb2HAJow/v0qu69mpWiO8aQRA?=
 =?us-ascii?Q?PR6fh13HUmpqzYEwELidYAGCtW4qFilFgX9JkWB27wZgI2+DyNrTMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pN1AFE9E9JXbI2Odivwi9Ss8cei2XkxtG6zTN6ZyFtz44ULZ/zvlo9Fn9RBy?=
 =?us-ascii?Q?jhJR6TXHQ/4VUcbijg4OvMy+k/xm8EVc3FneD5qMyTcY4HNzD19FEcwAkXdY?=
 =?us-ascii?Q?hjrkGVm+e/AW6MbGMAkf9ihfgI8G53vQuZ2VsoFB/zIcvj6162EYep2E7tuM?=
 =?us-ascii?Q?3L/Hm4f4BDLmEua4aZjQulCWP7x97hJpR4LetdQ8ioWdIObEkDbtdkbETsgt?=
 =?us-ascii?Q?/lTE8+Smfw9/Zp9oVqqYvv5vEYCY3sNU0jcpMLDq83GdJc7PY2IK9OCVPZFY?=
 =?us-ascii?Q?MUAznqc7YVlQy9wQYCP13lyrB3XQhbukZ5N6JRoTYMp7cLyGUF8d9+YWZFJ0?=
 =?us-ascii?Q?2IS1qhTDUxuo9K+p2mYIeaH/c7mtQLO6E3gArKaNbbpwWCbgdGuxy07ZReRj?=
 =?us-ascii?Q?p3uTKYMfQdUwe0Surpq+ghooqpAo0ev8KlWQqcgHmjwFbwCIKSYJZny3xISW?=
 =?us-ascii?Q?tzf9nTwdrhtAHB6QwHVrm7NjabKtW5QfLExl4Of/JP0LHbSKEoUAt7KOXSSu?=
 =?us-ascii?Q?ryOiYTwRz5O0zSV6rMKx6ncg48yUeHueKtub70Lt6FH99+CKBWXByRsjC90l?=
 =?us-ascii?Q?WuY+Y6D7R3VcP1aCjI85DPDYGirp9i4eFx2Zsmo6+ESy216MQLzGDGP89BzO?=
 =?us-ascii?Q?+0J5ysjwRtQ085ru7WMPQrP9Iunl6XTk+aJWjvYdz9fTj2ITg0kr6zGrpBlt?=
 =?us-ascii?Q?Bc36Z+WYxR/ZNsWH3cteIJ36/pUoEzXdsnr1EKA32CeiG+0H6g1AcQtCseJI?=
 =?us-ascii?Q?lS4W1LOmpdhbCG8aYqDRFHIMFerXLVp6t8nR1yjTgas8DQi2B4bUVuoGV3A3?=
 =?us-ascii?Q?XQUUHp90CEb15BZik4jrV2juIaXcryCxH33Mdc7Fl3w8ecSPf8lc/avo9tB+?=
 =?us-ascii?Q?KCOsVPOmCMBawXQtkY+eH72uqLqb2KG9RDeFcVSdhflGXDIL+66vU+gOF7Re?=
 =?us-ascii?Q?Bpc+9IhmWeIJQ68TSpiI7gKzAx6JSIlB8QTJMAGR7jGX7h1yG654UEwF8kMs?=
 =?us-ascii?Q?8NSmr72fSBM6uDAJMdABEPydFC3ZMEspQK4yJxgy/HzTgDmAFcNS8k2YZpSU?=
 =?us-ascii?Q?gzsonHKyQzHqPusSO9zKoMj07z1CqL8Mkejw2iOSZqca2wcs12fAtrZ8+kcz?=
 =?us-ascii?Q?KMRcxWh2Q7CwFOmHIInLJUt913MGJZX77Ow3FuqqtCXGD7QxZuwI7RzBcuKz?=
 =?us-ascii?Q?9At1Z+o/Fn0my4kJgoL9beN3cGjkowlwwLLSATrEiY804W+0SV0helvDXGaZ?=
 =?us-ascii?Q?UZTI7llPgCnvfVyszvVt5w97d1GJYDg4v/PrdpW85I0i6SL8rUctYdgRlBOH?=
 =?us-ascii?Q?VTshJs9ZfuJyy8NZEVfRzN1p34FcF++oyRZ+LLnk8ZR8CEkPi+A/0ee9Liuc?=
 =?us-ascii?Q?xwl+NCxCg1CvDPPEkjy8Evq1rz10687wqpQ4vsNAOQjDPwFBMB1nlUJtOppe?=
 =?us-ascii?Q?IgbH/EDr6kboSzWla+hDClXidoF7CYBoLcfLzWV5s4UyEjooeFgLZDt1qA9Q?=
 =?us-ascii?Q?X+jdzjwvCBMiQd6KAwa4cG2VepHaBa//1mEcgRR2DxgHLudPRTBEbOGR6B92?=
 =?us-ascii?Q?B138uylBqZ9WjSJiHk6VqWU8HrZ7cFii6L1IFhjP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7180c04b-d735-4448-8aeb-08ddeae365a5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:14:14.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SGybn2wJMrOLjhoj3aifVRrCeOGwkMus3gaNKE9bwxILpT1np/y/KYJ7UuHFOv7HEI+msriA7rnClTKcbAUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7318

While 'if (i < 0) ... else if (i >= 0) ...' is technically equivalent to
'if (i < 0) ... else ...', the latter is vastly easier to read because
it avoids writing out a condition that is unnecessary. Let's drop such
unnecessary conditions.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index fe96c6f4753c..3828c35f5753 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -240,7 +240,7 @@ void elv_rb_add(struct rb_root *root, struct request *rq)
 
 		if (blk_rq_pos(rq) < blk_rq_pos(__rq))
 			p = &(*p)->rb_left;
-		else if (blk_rq_pos(rq) >= blk_rq_pos(__rq))
+		else
 			p = &(*p)->rb_right;
 	}
 
-- 
2.34.1

