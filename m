Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011004.outbound.protection.outlook.com [52.101.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361C13E88C;
	Thu, 16 May 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850924; cv=fail; b=twQffp1IiEcbUq4iyzBhXp5z9ipJP0RX62BbFFNr1OTE0vE6jLU98BMVP4ARQJwYnkhHc3Sx2ZUAWR3ZKry9CtpEBEBygJwwCrbNtihJHqZHrK7LnsZ+N4qY1Bki1TNkEMHDxy6xtZj/pxY3HMaQtxv48Wr+DYUVauRWEv/cpII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850924; c=relaxed/simple;
	bh=Cei+CausnpPb8x3GmtV2rBfd6zdOobpKpsD/lzpj9uA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FCFXwUV6nKaKfpVCW891esxjexKFvUmyX+mny5CJEiCGOL8QczE2GZ2hv45mtCjzvaqVe62ENqcqipMrRXRdunPGVyHZnndkZv2h9RIcnVWmItlBEhyIZ84xjL1RJcOQP8hkYtkLoDyh2mKlA/VqrWn94rU/KhGZOYZhB/dTgv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Qe2nlXXM; arc=fail smtp.client-ip=52.101.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Qe2nlXXM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyh6BCXEVQ8QwC+hwrSr62uvsLhqlKeZ3GxU9yVR0KD4dYbxgO0d/G6yVvabm1KwG0xSdDBjo8VD8+QYLGepaX84kzblgsmLPfhvKsdGM1zQ+31Ksa3sZTcRTpX+6Zv0nPqX5X3tJwdHu++yu9fCZA5COdpzQlTYKCusx70uiaCBTpozWy8bagKJVX0ZGlPM3Nxl84WvAY3e1bDB51T2kO68f2e5l7xuUkOwAkZX5MhU1Q68BMA3qpMDtrNn/5OnsaADTf3zBWYnqPgkZ6dX8BLwdkZqg/xoNrL5k6pgfu1G1qaLTq/Nd1782gl8C9K2E+4k9Pf85GGHXM/Ko7nssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ItexeuD/OXf2ibU8nqSZmbAChTB2zYEl7JynPRvsqs=;
 b=PzvTJpdWkIZjk5gx4jlyLhHsdP6vNUpZhik1R2CoDgnsWTAOaL5O2FcpZ6nyfV4EZA46le66hsxiiHc71Sct3wOZ64GNkvic3IKXKGS+067a0tp/2e8SHFsyGiWRvsVaNOU3MbCGH+aA7CLXgoCWVjLhLT35wpsbFxcsC0NEcmCaT1vBa2M3h2lnYt20u/o1ipzCiaaCfnSzCtJoz+WsCcZSsWqXNcIA8i3NAGjodkWBM2/mr91fHGvLwf3E3vZNvRlBFZp5NNErRd6gyY+5l6JblRgpTnah5ydGq/ok9uD0foRHOK+sxBVKLNzmhYheFaguynIbOp123SWjI3C+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ItexeuD/OXf2ibU8nqSZmbAChTB2zYEl7JynPRvsqs=;
 b=Qe2nlXXMDblk5yY6s3E094lw9ORjN68m2md9DiU0nlgc+qBXEHRwNxjM1rP1f7Nar1XhY2mfO1BNoI32wKW92fT4eO+IZ1KtzqyB9fJYgXZy2CpWcDp3OyB2nMVELXmTq9rKLDxgAEzsBzlP8kHafDsKvdkuoIWYW/Y5eHhRLsmh3d3pCVTZ5Byq26xYyIeDgYzKvLEMbfCqMTHi7KHc9BAYM11JBo7sB3lwioFELf92jYjZgGe167h4K7OWmo4v5stVbqtH4isGcszaYzSo7LieQRvYXCzeL1/8IZtrmFgs7G5ke5KHIM2dUdLYFYZJeZUGr67eipt3dyTiAa4gGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR06MB6259.apcprd06.prod.outlook.com (2603:1096:820:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 09:15:17 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 09:15:16 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>,
	stable@vger.kernel.org
Subject: [PATCH stable] block/mq-deadline: fix different priority request on the same zone
Date: Thu, 16 May 2024 03:28:38 -0600
Message-Id: <20240516092838.1790674-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|KL1PR06MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daf06ce-4d92-405d-2850-08dc7588b36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9VMvZuFTSmVSxNqxro7Cuzd1gz8zUBJ/DclcOWzaw/8X5RxlqTVLNP3Q2m+W?=
 =?us-ascii?Q?Bqnunt3+NbUpVN3soLiz4FxnsCXkqDsmwqFbJiZ0boU8g/xTnjvNq0dElDGp?=
 =?us-ascii?Q?iqNUrcXwdRsjeMti4Viy4kHxWF2bvkg5lIvz1uPX0jbDLIeumL5oQUC8BFG9?=
 =?us-ascii?Q?mfYdD6LYwB0LouOEIBpW8uI0j+EZuuRhH2ToEwQLZjd5/Gh/M6VIr1izjed4?=
 =?us-ascii?Q?wPpLORBd2m8PaldInmyOVtcWXdr1jT56E5YSny5St3k/Xgv7FhelXXajm8i7?=
 =?us-ascii?Q?Pr+e+w/iFVMK6vcfcvuJZHBYLEvRUGYmKQKdU9D9OpqDCpocXCNKiZ1YTYo5?=
 =?us-ascii?Q?LWLMaxk3QWUHovUu1Z5dmXYzMmKPH9Fc+QF6sXe+Vqh6pwv+d2rZuMuRrYlB?=
 =?us-ascii?Q?bO1458UANC8ZFGPlb0ALtsX1xxVyjkzNEexnj42DpCn+JdE4KzT2V0vje/Y9?=
 =?us-ascii?Q?ovAQbEEg8kspvvDbtBs1fjtrfbFU4xATOa2MuKIeQqR2v7Ktbv00RsAalUE9?=
 =?us-ascii?Q?3oygeih0gmBD81Jm2nikSbVeaev3nSbewFsDRqDydUHa/p7lRFLWHx+0sPr3?=
 =?us-ascii?Q?MZ1Fxp/+o4dPJZbAvlLRxzzZdu70zqXaStNcYymgnVG3FL5AcYZF0sopHnGk?=
 =?us-ascii?Q?KObp5sTbqafUrESy5A3k35VAoLvW4FQ+AaoWn6HmJUmkFD5tUCFZhat2UVHb?=
 =?us-ascii?Q?JsTpaDztViB2eOV9ez9kFCGhXVLyBRGGrTx5DpBJOulM3z8OZiKH8eGbou12?=
 =?us-ascii?Q?sj1o7z0knXqvI4UUnBgW5mToXNx8wbT5HRGOqK8N4Hwinej2OHHY/CQ+BP8o?=
 =?us-ascii?Q?9xpYG08e1wmXJrM6hyGryEC/9g/eD/PuOWwlvwohtepkADTLcM61dnhIrnLF?=
 =?us-ascii?Q?Z1tN6NpC9rz1sL0hV79vZYlc+oEeyQ0rp6ITHg5CknCFLGBG88cTAwiUr3Of?=
 =?us-ascii?Q?RGHhcjr5OFoaDpAOMfuJkOnoSN9ntwgxxYheP7AGS41Y6nD1z9y6BT9EqedO?=
 =?us-ascii?Q?nnih6rHQUmMyG/xO4xa9W6c2uzgnQTlj2zeQQ0L7cx/ybys/M5Rw8olUQIYu?=
 =?us-ascii?Q?a5lNaq4t65DD8phnYNCpWVZbpsIhxI6hn+j7O+Hj8sQg5nZEIql5LYcoWcq4?=
 =?us-ascii?Q?xVRZvrUkejip3F1vfeJBQrx3NLUTLuS7PlWVXtuvDJKXDhR6YH3KpAvNfLlL?=
 =?us-ascii?Q?gf1x/rJ8vx2xQtIKSXbHndeIAd0mCzSfnuiJhOlPo6YIQLMyjb5WXJby2Gpg?=
 =?us-ascii?Q?R1bhwycNrjrhTkGhE+a7IYdXVy2B6wdNKa44YSUq4dKMeZfWRuGH0BmQfE5X?=
 =?us-ascii?Q?XWiM2gZwoZ+Y8/7E9kVpfhUMUzrLIa6guqjxPSZ/5ApsVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dCqWOKGRePjkRa8c8gEbL4sR2tnqylsKvUgevYEvhrQMS6qdfyy84zwTYPnw?=
 =?us-ascii?Q?X/EnOD6ORDPtEUHada5HH2fMCirQPAvcQAFA/a/1FxRHc9BXd0lbLKkQLR69?=
 =?us-ascii?Q?MPiuHLOebBRo0x/F8483f9Tk48g1lI+nX9FK1u1zQCaH83zyNWL8+gOhPSCp?=
 =?us-ascii?Q?r/fRhukYgszVrFA1wYQptlzgU4A7j0aVrKcWmSlwgg/71yDn6KxA7EDUimah?=
 =?us-ascii?Q?x994TwWwBmYyAaMK8RWdXHU1w27VC5x+hhDn7In62JcZunSznXnAJntlbJ0Z?=
 =?us-ascii?Q?67C3iWTXqkYTfbDAQt8z5M3beTaN6LB2Xtp8yjdfwYg0yOYYMcaTq68c+s0S?=
 =?us-ascii?Q?oOAVAooT2bkqRWm42PiWVuSOgusc4QLtEQjNyWdQsAFqhwYg+GiV4JQF5TRL?=
 =?us-ascii?Q?d0VAR6v51uOxW3ACYjhnA3d9niKQWqODa2zk6NNHOPbTAuLZJm2HeM3wRswG?=
 =?us-ascii?Q?aB21ocFum6cM9Fg+NieUvsgWKTWAasIP2K8OXNQH9gmxrj9ySzqHybzcPUfP?=
 =?us-ascii?Q?SC1dG6mxh/5RhcUlN+y9BMraoZH/jFW8HiPZGXpYkdJVENkmxBbofPtIvUkE?=
 =?us-ascii?Q?84hfTzRcNt7AuLiRhTEPvmdxNjVdkWlr3ANn4PyY5Zw5oB80IKK8/6dVf2tf?=
 =?us-ascii?Q?cM8Aw05x2x0l0yf9yftJSAW1OKS86b+o4pprImZOEZ88uS0aX61HC1wsca2c?=
 =?us-ascii?Q?EPZu4Sy4UikwVft9BSsJHZqyQi/3EhZ5k7znSlUKh2YAA2yOp5YNaVEAoeHb?=
 =?us-ascii?Q?Zw36yQIQEqDuAQglZ1wl2hfpMiPF7QhILMX+ks3R6WiJQd5Tp4MYcWoiAp7a?=
 =?us-ascii?Q?BPybStFUBK+h15PhfUp2VbLm+yoKYRxvoG79Tkm234WO+v+PBXx4iX7owzzX?=
 =?us-ascii?Q?AhplPA2F9NaAYcH4BD2CS11qBAHJJb7AW+fJbvQN2GCvfAmhmZ5fJOJ7Vq+s?=
 =?us-ascii?Q?wDfY7RX/211v3ZmULrw79MsAqHj54dZ1W5ULrYCNIaXwTXKNmqAXkKjn8EH6?=
 =?us-ascii?Q?dInnDccwGBlFPOwfiVvjX/b7oKes+6MVuJJ1KGr8JnzpRWHPjxoTbYLD1jMb?=
 =?us-ascii?Q?39Kzg45ruPOqpJobqA7RH2vR3DWN6NVsXOEi9B7hHhBDqU3eW4Ey2rHQKVs0?=
 =?us-ascii?Q?vzf4tFnV1xMvJ0QPv4Fvofl+8SbFL1asev6XBLeofipXdOm5da8rEbIYQf5o?=
 =?us-ascii?Q?FBtBhaA1gndqW/RknOqdhg46iyqr2WhPUISmrghEX2kMMsK31XcPeOD3PWrG?=
 =?us-ascii?Q?/28Vd6YlJHZL3jWJFHaNcQcLtE7x6D0AxAlNbLNvcB2rSFIEJLIYw5tL2p+Y?=
 =?us-ascii?Q?5WJlvFPheb5+5BiDAebXfh/yq9/Ulf0llfpjt4OEOKEQBdD7q60gr8CRgAmj?=
 =?us-ascii?Q?/oD0jjoSTJ5jm5W3SXqJEdDfE9F8TrXDQFhRexbGb3fPd8bA3tlpM3ma2cCk?=
 =?us-ascii?Q?w1RaMjgwe+kZ6+nbxWY62yZL8Szp9Tk/udWosiKhZgs2YU4NsT3k0KvhB7b9?=
 =?us-ascii?Q?rgtVVe1veYy1T1xybL0pLi3+X25VHWpNJmSYmvyS6tPhLuF+RmxFJn1jQLJB?=
 =?us-ascii?Q?BmD8UVupeTmBkz2DmyHktLa5GHl4Jlpub1Je1q82?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daf06ce-4d92-405d-2850-08dc7588b36c
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 09:15:16.8082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Rs4zL32OrUMYsjpjYxiv55ByBV6UrOh4p7CDJZlvadj+xgMCMhvSjKJzhjjkoRuVzlThivf3OhizFiUMZRu3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6259

Zoned devices request sequential writing on the same zone. That means
if 2 requests on the saem zone, the lower pos request need to dispatch
to device first.
While different priority has it's own tree & list, request with high
priority will be disptch first.
So if requestA & requestB are on the same zone. RequestA is BE and pos
is X+0. ReqeustB is RT and pos is X+1. RequestB will be disptched before
requestA, which got an ERROR from zoned device.

This is found in a practice scenario when using F2FS on zoned device.
And it is very easy to reproduce:
1. Use fsstress to run 8 test processes
2. Use ionice to change 4/8 processes to RT priority

Fixes: c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 block/mq-deadline.c    | 31 +++++++++++++++++++++++++++++++
 include/linux/blk-mq.h | 15 +++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916ba62ee..6a05dd86e8ca 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -539,6 +539,37 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	if (started_after(dd, rq, latest_start))
 		return NULL;
 
+	if (!blk_rq_is_seq_zoned_write(rq))
+		goto skip_check;
+	/*
+	 * To ensure sequential writing, check the lower priority class to see
+	 * if there is a request on the same zone and need to be dispatched
+	 * first
+	 */
+	ioprio_class = dd_rq_ioclass(rq);
+	prio = ioprio_class_to_prio[ioprio_class];
+	prio++;
+	for (; prio <= DD_PRIO_MAX; prio++) {
+		struct request *temp_rq;
+		unsigned long flags;
+		bool can_dispatch;
+
+		if (!dd_queued(dd, prio))
+			continue;
+
+		temp_rq = deadline_from_pos(&dd->per_prio[prio], data_dir, blk_rq_pos(rq));
+		if (temp_rq && blk_req_zone_in_one(temp_rq, rq) &&
+				blk_rq_pos(temp_rq) < blk_rq_pos(rq)) {
+			spin_lock_irqsave(&dd->zone_lock, flags);
+			can_dispatch = blk_req_can_dispatch_to_zone(temp_rq);
+			spin_unlock_irqrestore(&dd->zone_lock, flags);
+			if (!can_dispatch)
+				return NULL;
+			rq = temp_rq;
+			per_prio = &dd->per_prio[prio];
+		}
+	}
+skip_check:
 	/*
 	 * rq is the selected appropriate request.
 	 */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d3d8fd8e229b..bca1e639e0f3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1202,6 +1202,15 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 		return true;
 	return !blk_req_zone_is_write_locked(rq);
 }
+
+static inline bool blk_req_zone_in_one(struct request *rq_a,
+		struct request *rq_b)
+{
+	unsigned int zone_sectors = rq_a->q->limits.chunk_sectors;
+
+	return round_down(blk_rq_pos(rq_a), zone_sectors) ==
+		round_down(blk_rq_pos(rq_b), zone_sectors);
+}
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
 {
@@ -1229,6 +1238,12 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 {
 	return true;
 }
+
+static inline bool blk_req_zone_in_one(struct request *rq_a,
+		struct request *rq_b)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 #endif /* BLK_MQ_H */
-- 
2.35.3

