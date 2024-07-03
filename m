Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE8804;
	Wed,  3 Jul 2024 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973732; cv=fail; b=j8mLH3ytONOMYPGeM0f4zGoeoBelDc3NUPsCXnYi1aPC94ntNS2PRmjX8rMj8EHcU2iFWKM5OhNDJU8QGeQsM89jcrWq59/zxIGcdtwziWHciMUCU7x3MgwpEYLev1ouYU5RDpw0ymXO/NrN9d2NjHrxHkYGNGFIhaICLMnapfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973732; c=relaxed/simple;
	bh=icj+onM5WOEwnUpqdZSQ4ZVHKxRo1OFk7q/M1yfxLWw=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nbmaUAeiF/dT5banWINVWsuPh6LUFEqk6QVTCI6I48VO3SD5e4tAZP1H80MUjnFQDMPcwGm3cZskKBR8hbEKvNbXnzxUSzi7zJUzduiMY80+6R0IDiKgLE7szwd6Iiu0OpzUjpuMoMaUjM/QabU6g52gK1b8ztnaWC82OBGqojQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TJkbWmvZ; arc=fail smtp.client-ip=40.107.117.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TJkbWmvZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYct3jjeXMk38VhTGhg4bPX3LkZ616g4udbuyvpS+G9iCrhpbK3i/+J5kJVrF8+xV34ZO/N0AVybS1OTrDNSXnCaep5vt0HRD+ugijtwrlwZLj1WOtxPcI4hC6QtuBw/eiYpYLTdLNYaXVNsmrCOKvSnF+hEXCGCJCpfgxQR+BJ8unAUqSbdouIPUIHclR8gA/dztSKTwHTzBqWgS9+TnfL09HED3i6QjpaL1atLQEtCXEdUFEA9YpaTcIwKpTuimwq7p7iPQXLht8p0tKJOmDZwHMJXoKkAzNMXp6Lp7nDZ1PQEKuW66RJWOm6xb912DREZMYG1F8BF+tAfcIZuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlxofn9u635vJjVcDIgFVkW1Swp6Sv5vpIO4GtVQdqU=;
 b=Ryy8VHU9ymno1Gt/TTL/FVdzQ3XtfFcEUh37PP0Jx4qfiTFzGPO7zsDQN6ugWBn3WfuodL1ufePR6DIRvtjkzkU8w0AVFBLbgc2XXfSQOlXw/MqKHK4xHSDXyOzug1ZKQu+oKV0fpVj5bknbQ7Sz1gYAmZdP+9NDCXgHlknl0Z/TOLbJbSEXhkVHpj9ZTqqn+tB/QE8YwvKZT+8idZB4jepEmIJq9n3Vf/eFutjkbG8KbAbAzAee1Yg3FegDtuK29eankqXggLdoBOhgDSmOqOENikKw5jBCp4h8EetXZ/zYxkOYqsfUwRRIn4D8CA+NS7xg0takm3Zoev4VNfCsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlxofn9u635vJjVcDIgFVkW1Swp6Sv5vpIO4GtVQdqU=;
 b=TJkbWmvZFYT+yPBguHraVBjanB7RC6j0W+Zr7ieQU3WdeOaFhRd0P+V7yweuBHn+mT2bhCFhje/RPXDzhRoVQVnROvXdXY8svU4WfybQo5aHyuZZ7trirbuPvBHWK1E2BqdRTo1aF3YFXl0Sm9Nm1KRwZZUqeC5UWNu4GU2kEoCDbVtjH29r3xYd71BjJdsfJpKWQHAwRsCvyNsd8ILocmHSQX8k7bz9fXXVouG51Snk+M449Npb8Hd6FHIUkQsNGY44UwNQR2kF+nqKQ+Mzv/2OxcPu8ar541Z//Df+2Z6dZjlG8S3V9iWizm2UWQfg11EOx0S1gM3pDs78pWT2+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by JH0PR06MB6800.apcprd06.prod.outlook.com (2603:1096:990:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 02:28:47 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 02:28:47 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yang <yang.yang@vivo.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v5] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Wed,  3 Jul 2024 10:28:03 +0800
Message-Id: <20240703022807.642115-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0220.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::20) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|JH0PR06MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b692122-26c5-4dc0-7b4b-08dc9b07de31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94BoMaJWUktji4GSQ6I6ba5jdcM8y2K5uJ0e19Jx0VCVAaCcPDXaaL5z+wto?=
 =?us-ascii?Q?g7BuIx9jE7EHECnSoKSf2z0Q6DOo2xMVUzQ4jG6A7he4p0f6N77VTLSbQ54F?=
 =?us-ascii?Q?8G6rbPQVuUDWbNHBf/HpY5DJ6w2i6mxJwEwWtzR6Z3J+0aRyT16Og0dDtbtd?=
 =?us-ascii?Q?kDrc79ZYQLlgLbvEzO2HzfKQ0gvtxDsh/H7dZ8w98y+qRayC3cUgODMSzGKt?=
 =?us-ascii?Q?4QpwhvaLZ3Ca5K2LGoYrr3XwwKCGIe81AtrB0KOtzyq9hIqGfl6g2t6qKxpi?=
 =?us-ascii?Q?hbxI395lrpgVP7NXfhWL/L58iL1cSphOCKEG1l0t1JZCsF0MudJygow8rxee?=
 =?us-ascii?Q?QQHjwLLhU+2IGLb48ZfhPz7TgmrGEKyqmLgU2LTLOOq7gH6MgYZB7uFYmh3p?=
 =?us-ascii?Q?GyDuskcPkHz6ddM64rIaM7FdeschBF+TnsqXTPTXzP8oF1pUDpSL14t6bSbe?=
 =?us-ascii?Q?6Q7DL94SWham5PlJAZmmlWGIOV74xKNj4K+gnbLcu27gDlFPydZA6mEvSDPk?=
 =?us-ascii?Q?OxDH/hiR2SB9YiJdPPb602OuggtCZ4fYK5BtwqKCi7f2Oha/EcfsnugY7dct?=
 =?us-ascii?Q?3XEBUY20RyDeE0ImC4Olwlb+v6wSkbm3f4hXyUSaJ88g+JFbZz5uaoiOWnp7?=
 =?us-ascii?Q?oKYUv+RtVe50gl1L//VLWONJGQsdMU1Eyvr7Ivbp6YouyCaKEms6U7YR319J?=
 =?us-ascii?Q?apIoYBb414i+eFK+TP0ZHdzP5HjY4dSpzZM7CKhImUpLIexjtif+bXvVs3tJ?=
 =?us-ascii?Q?+LYSasyUmgrL2lOAO4FyJz70b+s1ew14eGCEw0qxtPMqF+1eYUtdyCHIV8lt?=
 =?us-ascii?Q?Y6V8YxuIQ22TycMRIAIIN777pscLuOD0XdaO00x10q2NdAtnNM1OoE7bV7FY?=
 =?us-ascii?Q?t7e16vnY6+fWK2go5aA31aXCWQKUo9kKvrCWGqc3ikaMLwKpLipzp2CIU+04?=
 =?us-ascii?Q?o3sb1s+oY+jKnFs5CwPDlKK+XQPp7W9sSsYBLyUr8Rtr5kAGvMfawsB7q1FM?=
 =?us-ascii?Q?7xQFULp/5gwPOG5rlkuK1JWrTlfbIDeSWxuFq/HPO46rZK4YW1ljNCt1i094?=
 =?us-ascii?Q?x0hV68Efs0gh9yhIxSQPllS6r5TA2Mx/bhKVePUkmkBfJa+e/MIGKdaikdNj?=
 =?us-ascii?Q?24UPhkFWfkQkJAeERer9GvckvswNMV33TWzckYNqGF7+QB20QXdcQMtfnh2Q?=
 =?us-ascii?Q?BYU2b7vF2h/NuMX4RP292s53nFcTpozUJKOvm99GFDMQ0pySstV40jH5G71d?=
 =?us-ascii?Q?zC1dez7+MRCmsXrA8EABs++Fr7RE04fVauX4CGhQZriBAds/fbeayXHvb6WG?=
 =?us-ascii?Q?wwt2auISmH6GXEBjln99LXI4LX6TM62I3KehDxeUCr4j2R1MGXzP0waMJarm?=
 =?us-ascii?Q?NExobUUEixivNQEh6YivLuYN171BmmGV3Z1r9nHVMbu1ok5P/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKdcA77a9T1/9awRe6XuTlmu322wfjXwewFLNxA16Phj2+c8yn0p2TBz2ajQ?=
 =?us-ascii?Q?zo+7FE4m1UzT8YLt9sovDoZBYIO3SOZadHazv9ZRumLABU6JemWQSE6m4h8Z?=
 =?us-ascii?Q?eve/f5XWgN3U95c2ZJb+UzgeK47TZ5aLOrZ9PA3dXNNbfLK6NJUcVZjxwNy2?=
 =?us-ascii?Q?xrxxKlYkTu3VZsR9tST23jZojiJ1breCZbqpgoMFr54PqtFWi7MicWO/qU9V?=
 =?us-ascii?Q?fhDITaL0vZ3pXXe3kUZ37VT0Kf4i3hEknKdbOrPMJMZosjIJjBa2jmDSQ2Hz?=
 =?us-ascii?Q?y0hXCdhYGulB1WPLkRIpLiRKDNYhccJbQ2rRnRtnIEKPCEOtWJUi553Fj36q?=
 =?us-ascii?Q?O1i9SZEaqvdyTs14I4ZYXyPXeRypfSPBvtayQqqzcQyTzSTQu3t/LplnQFKD?=
 =?us-ascii?Q?iALl6e1+jwIQhnopo/jDmDE95NnDqHwcIcD6C+Pzx3e2ITaL2JrHqPRb8gEa?=
 =?us-ascii?Q?BIheZ7ACu+nbK1XR+J7nl9j+MS0emO0OVPgRNe0aqcnzqRTLj+HtJIF3ySwS?=
 =?us-ascii?Q?wDSmucndhJURumnlaWlTYbCBwXbBDn+cwmhXDFoX0iVbvCdqZmTRCzaR7Job?=
 =?us-ascii?Q?gee920QtSlTTs1zlcWUWgz3DVDIT5ea4EvH2LGy/g6e4sj+6d/sJqaWOT0oh?=
 =?us-ascii?Q?Qe/XT+kSoB5A7Y08mzAnFc/13262yPsLfJjuHtC3NsJ0+6ogo4WH+eCQ91do?=
 =?us-ascii?Q?xha9b4+C166xhNF3ooqP3wXqMqP+R8/DHT7cNVbFa4F0zP058/44oP/gUTi+?=
 =?us-ascii?Q?QBAYttogCYfBoP1LAag7l7cYRLIuiaNWTwOF2o9GrRgea/QnsiZ7Jwm5mlWM?=
 =?us-ascii?Q?UmiToRHVb0mWoEdxxNh2MBEiYEja9hzsMrTWAsFhJZ+Xq88XQSz21o031NOW?=
 =?us-ascii?Q?WVaNUc7IQSHpwkqcJGbJlIVlALavmjaoGRf45gUMSa5xlkdc2U9x3+2pex/o?=
 =?us-ascii?Q?O1jJw4vKteeLWjHehphzl325l80VvKW+YqNdSixTTGA1JcOAU/NbTjVRtwQb?=
 =?us-ascii?Q?11cA3eV0HNZGYPkl+v5N7/o46RMwH6Jj1lnQu3HHD8OqYj6XM4yOA040uu56?=
 =?us-ascii?Q?P3g/CjQlgO+y/gAmu0lUxL6t1/DJKOoG5wgEIkOB2I5mU9Y1axaJ5/zzErWo?=
 =?us-ascii?Q?g+djhUwU4P269Qf0fabI06DQK9nWbhoBKA1JUPu/R1yNGiPU3rGP/NVt4GT/?=
 =?us-ascii?Q?eNK00/SzYJT+CuQ1VWCB6SHekfbkN/H6+LOfox7S5kf6KeeTXqRNiyhExMEv?=
 =?us-ascii?Q?a/oBCaciJ2Go8g3UaGna1kaVqYQ3A5LBy9UVBRkTR2ErdtKiO+PefVgHDGsu?=
 =?us-ascii?Q?SoXB4OmufQfLXk17/g/cli6nFXBdbtseD67jmJsZxJjcx/uDj6X0abq/Jcuq?=
 =?us-ascii?Q?Cp3zQq3z5FbBeftEhCTJoeyLh8xZsomfQpaJJPvNBFOkTZIBdG5t97rCn/Tp?=
 =?us-ascii?Q?Yu+GJRymNQcebIaMIsck33nRx7JyGeRyHOhPYCNKkeMZpR428kQYUgp1Q7Ff?=
 =?us-ascii?Q?Q4ZukcDs5hjJHatjoarcxV287HTGuX5Ln93Otif5rSejBz1kHWWUcC2qd+yP?=
 =?us-ascii?Q?T4NvxXVOics5N0ymBm9rdzrFxCiAGhLjBFHVnQzi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b692122-26c5-4dc0-7b4b-08dc9b07de31
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:28:47.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lj7MWHfK5n6Ywt/2SbwgVXHGr0CcySE2F7akyVLhlhUtfycZ+ccmcH8gVqZRL9J+5LLRPrE/EjSRiV3iX4wlwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6800

Configuration for sbq:
  depth=64, wake_batch=6, shift=6, map_nr=1

1. There are 64 requests in progress:
  map->word = 0xFFFFFFFFFFFFFFFF
2. After all the 64 requests complete, and no more requests come:
  map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
3. Now two tasks try to allocate requests:
  T1:                                       T2:
  __blk_mq_get_tag                          .
  __sbitmap_queue_get                       .
  sbitmap_get                               .
  sbitmap_find_bit                          .
  sbitmap_find_bit_in_word                  .
  __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
  sbitmap_deferred_clear                    __sbitmap_queue_get
  /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
    if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
      return false;                         __sbitmap_get_word -> nr=-1
    mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
    atomic_long_andnot()                    /* map->cleared=0 */
                                              if (!(map->cleared))
                                                return false;
                                     /*
                                      * map->cleared is cleared by T1
                                      * T2 fail to acquire the tag
                                      */

4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
up due to the wake_batch being set at 6. If no more requests come, T1
will wait here indefinitely.

This patch achieves two purposes:
1. Check on ->cleared and update on both ->cleared and ->word need to
be done atomically, and using spinlock could be the simplest solution.
So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
may cause potential race.

2. Add extra check in sbitmap_deferred_clear(), to identify whether
->word has free bits.

Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
Signed-off-by: Yang Yang <yang.yang@vivo.com>

---
Changes from v4:
  - Add some comments according to suggestion
Changes from v3:
  - Add more arguments to sbitmap_deferred_clear(), for those who
    don't care about the return value, just pass 0
  - Consider the situation when using sbitmap_get_shallow()
  - Consider the situation when ->round_robin is true
  - Modify commit message
Changes from v2:
  - Modify commit message by suggestion
  - Add extra check in sbitmap_deferred_clear() by suggestion
Changes from v1:
  - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
---
 include/linux/sbitmap.h |  5 +++++
 lib/sbitmap.c           | 46 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..ec0b0e73c906 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -36,6 +36,11 @@ struct sbitmap_word {
 	 * @cleared: word holding cleared bits
 	 */
 	unsigned long cleared ____cacheline_aligned_in_smp;
+
+	/**
+	 * @swap_lock: Held while swapping word <-> cleared
+	 */
+	spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..22d6e86ba87f 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -60,12 +60,35 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 /*
  * See if we have deferred clears that we can batch move
  */
-static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
+static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
+		unsigned int depth, unsigned int alloc_hint, bool wrap)
 {
-	unsigned long mask;
+	unsigned long mask, flags, word_mask;
+	bool ret = false;
 
-	if (!READ_ONCE(map->cleared))
-		return false;
+	spin_lock_irqsave(&map->swap_lock, flags);
+
+	if (!map->cleared) {
+		if (depth > 0) {
+			word_mask = (~0UL) >> (BITS_PER_LONG - depth);
+			/*
+			 * The current behavior is to always retry after moving
+			 * ->cleared to word, and we change it to retry in case
+			 * of any free bits. To avoid dead loop, we need to take
+			 * wrap & alloc_hint into account. Without this, a soft
+			 * lockup was detected in our test environment.
+			 */
+			if (!wrap && alloc_hint)
+				word_mask &= ~((1UL << alloc_hint) - 1);
+
+			if ((READ_ONCE(map->word) & word_mask) == word_mask)
+				ret = false;
+			else
+				ret = true;
+		}
+
+		goto out_unlock;
+	}
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -77,7 +100,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 	 */
 	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
 	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
-	return true;
+	ret = true;
+out_unlock:
+	spin_unlock_irqrestore(&map->swap_lock, flags);
+	return ret;
 }
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
@@ -85,6 +111,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
+	int i;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -116,6 +143,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < sb->map_nr; i++)
+		spin_lock_init(&sb->map[i].swap_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -126,7 +156,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(&sb->map[i]);
+		sbitmap_deferred_clear(&sb->map[i], 0, 0, 0);
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
@@ -179,7 +209,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 					alloc_hint, wrap);
 		if (nr != -1)
 			break;
-		if (!sbitmap_deferred_clear(map))
+		if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
 			break;
 	} while (1);
 
@@ -496,7 +526,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map);
+		sbitmap_deferred_clear(map, 0, 0, 0);
 		val = READ_ONCE(map->word);
 		if (val == (1UL << (map_depth - 1)) - 1)
 			goto next;
-- 
2.34.1

