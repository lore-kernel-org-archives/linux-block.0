Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927022066;
	Tue,  4 Jun 2024 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717470742; cv=fail; b=Kdkd1h7JHzOR9riQ5P89xJ6cseZZFGVJrZqMIOQHGZ5mNpYNecTf5lxUpTFJF2seTcaYAvShQVnvwzF9ojyXTIMPQvqiySkhKuqXcGGX/7jHUwRMiYJT22kgmykGCrw1CzEFttOV9kT+rRw/b6iJZLJN+R9mI5yk5rLTa3Up6yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717470742; c=relaxed/simple;
	bh=xs0W73+ePrhFhCXsXnMtZylbR5WmMkS1BSYQbkqZyVk=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FvnX/2mxONBNcipyRwZpVcYuvyM1+maKzFmWEepfkcyJZs8Blsi8t8GTxibO3I60v3HCLZmYXiv/LEygrQGT483y2I5s6ha4Bpt++zZZz1mAnBcnlGs/bYs6MMta7qAIjR6yLgRUKsgUM1c32DnTOOONuYYV+ADW5XnYPJEM4eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LdZfjAGf; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LdZfjAGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9pi/Ie1Rs0tJtZUiWuf6mgjSDbh+TtQETzihAHZ9CD9Lemu8+6OwRKSq7PfE+/pvLLC14F/J0PeefWmGNZjYiI7BakZsy2lRihE++7SX/3SeBdMqLadVPlur0pzmupFTzMniyW0uXT1LFpUqewtNKQthhAyKBwUJO0HX28zJo0Q8Z6I1VITnSDnQzTEJn7Avk5tPbGX6NVZxxetpI1Ec+VYo+Xw3Yp7qen9jXn/4V7nr5JheiW6EKLljCkdsiL0LjgFNS2sx+zJ9ypVKBHLFRpUF6wUYmwcwAwP9FtSyrzVGOdQm9INFHsMWdIYuIvYa+1CIZ71IckmIb20uvxtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM3dU0jIzvcHfAeOJ82RAJnzUPdXK4a+0gNlf1QjXU0=;
 b=gIHNU5FypD3y723L23nPgJwjtnmdR7w879yBUoRUKtMD5WfWuGCp3vfK4C3DNRmYgLMByJ3vl61HL8/hpdhW9+KeuN8SUFOpvoDvigv7vbTVtwCo1QrfhOcGJ2RN9lYXTpyG10o4F8JrFewparU/u1P6kdf9FHlumUYwmsk58PY/rVbsNcsv6OICvgdnKCUoFLr7lQQV6oSZlqS1TQUH6X5BfmVLTtVmH/+vk5ilhkH2lpXiNRjpZExpkDP8ZD0xyhX9S6nzMKaP6wHvG/Tah72x8PFATXUTz16vtGYwpinjtS0S0QMv4nvWYDmIL+Fh+q9wzwm+Pgn797PYQz84kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM3dU0jIzvcHfAeOJ82RAJnzUPdXK4a+0gNlf1QjXU0=;
 b=LdZfjAGfp+nyRjjx+CCEjqe++WrvGJ3pQ8HRe45IQJQ/I0NRkgtSuoSBBE85jdMjb83okMuo3mVisfHGseJTWqTGIoh5RTDr8nr2NZ5Q0kEYILYvEApoKJRGpypjFWeUbi8OcLLxlm/hWFEFkNENXC+aCovssadFW9thfiQhA+YDZCyNvOEmU9Q/ZXgdOuvwiF4guJC06q8EPsOWycHFkdvOO7ExtAF9My/s0S3fuEK9FhGPgufbcIcKIDGjKdV8E099x+caVZ49wD8iT+KC3M7at7Vm+blWtzY5sCOPRUnf8h6IGs57zjUvR9kksC8PMQ1u7mpZh8zH4W8giqi7hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by OSQPR06MB7232.apcprd06.prod.outlook.com (2603:1096:604:292::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 03:12:15 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:12:14 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yang <yang.yang@vivo.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Tue,  4 Jun 2024 11:11:20 +0800
Message-Id: <20240604031124.2261-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::10) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|OSQPR06MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eda0607-eb40-4baf-ad2d-08dc84442246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Um8i7weMO0F7vjCGAxmb+3JiqesfTg+0zWCw69sik2aJBUSa8322SAur+2c?=
 =?us-ascii?Q?Kq0WejZCe/CXzobpJD/f6HQo6Z9jHbxk3BN3D7L8sf7LBAEYUuYYu1Ih+b70?=
 =?us-ascii?Q?mlztP+4MWXIc3RdovGZc/riYK5bfuvbmdjjDDPvnIhWVR9bpqHp4uY7+l80n?=
 =?us-ascii?Q?LrKzrbaHFPbycYdtW8+85Rtr4gy5thLY7QLiFHjEpXe0pTl7/f5KQdFp3gJj?=
 =?us-ascii?Q?3UIv057ZNQImDCQN2HzW7V3YS35a3evQ4ZCpqmnIEdiqWFA3KeWdzJsxRTSv?=
 =?us-ascii?Q?mpXzmKh0MhaeTeO/zfthkP/B7H9D867TE3ORtY9pge7bCzmKW0klo4yG9NiP?=
 =?us-ascii?Q?RenLW0reVTgOf0YGmG9GoGxCxV4y5VblzHpsP4FZo2mpUEMKzGk1NVAMvY5z?=
 =?us-ascii?Q?aRkPt+p5cTPv/YBKYBn8hNv5Adou0AJLviPK4SWKlooAtkU1upD3ZHxDsv8y?=
 =?us-ascii?Q?TRj76Js29Ypn+zz/AN7tgMhDanqDesT3v7o0XogjdJlvS8aZHz9ZwfwTPSb4?=
 =?us-ascii?Q?aG6p6YfeGT3wy1WW+ldsT7pzw/uOVUJcDJiUWU2I2VTVvEvT4i7Kl1rLqnN8?=
 =?us-ascii?Q?cgfw2AExbFBqx8A4/QFLNm9p2TSCkZtgYzwaxn0KN2WoaLTm73XbeBOkQzkN?=
 =?us-ascii?Q?NzBa2h05JJ+4PTyHVfQtOLHFmuwyeH+wGxROqcpwJRzUt7syDimL3lEN7nBU?=
 =?us-ascii?Q?VyDr6KB3ezABQKyNz6u7b/4cQhk4jg1EHy3M5j/Ccx/13fNncJX+k3TnHpLg?=
 =?us-ascii?Q?//UoMB5bnvbDmgrpMwxt+SOkgSW4RhIdf4ZRLImQQaAbJqxPze4DNA8L2pYk?=
 =?us-ascii?Q?GGxHE260fcW4A8q+7UPgCj3kKB97A5Mp8Bef+LDnn7MJZbiUyVMsBE3fQhFA?=
 =?us-ascii?Q?b2UdRFUqdswk4IMCWjYQNRLhpzR/04blj8yNl5vBC5oq9SnGDloHcHcVRa2K?=
 =?us-ascii?Q?7xQFtbHyGhr8NvM3LdVAcBDyksVmwL2peMNAMUwPtGtk4vBF5lfcnuk7ohWu?=
 =?us-ascii?Q?pwDVcOGA2NVrpkvBgcuASWDHqiFU+pLT9egvq4LEY1YXTal7jvGOeFj6xi0b?=
 =?us-ascii?Q?E2ryPlxVNxb+11PqbPeJbA1I/mYPlqRV2FS3j2Yw249g6o72LauG/336Lr3G?=
 =?us-ascii?Q?Zoy4whFSL+e4bVWoy/mFjm3X4LzvzEDly/q57r1oYet8SFv4GJqUpswxSNLL?=
 =?us-ascii?Q?qkjPCi+HQNninqOvkFqG7kBXB+y6KPDBkApT0/IA7NJ2YYA00PYN12JBUM56?=
 =?us-ascii?Q?kQAyEFFD/EFz6fNqd06eEsvaP00h0fkMDLcoCh5OtXVnCTBhhI7XItFJFUW8?=
 =?us-ascii?Q?W4A71psuWL7/KJ9nETSiD3hKdfNq5Nji8N5MidImYPQ5Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFdX/zT/gZ1MRDma/YVdgRa+Mu2btuPhkksdzW1f89dOM/WIqq2duEcL9IzN?=
 =?us-ascii?Q?COljqZPGergdhHsA8vfpp2sywQHHUU2uHM0Vgklm2w0NzLMlPk9HmTJLMOJh?=
 =?us-ascii?Q?XDww4oqJ4RYM6ESVxhTNzRngYhbwgp8jNHxsdj5EYbVomUgMXrDEFjy7/Rri?=
 =?us-ascii?Q?I6kzx+En5lHDYRQMHskMsY7scJ6loH99xvfn2O0HkuBbMUI4lTA3AgqSwU9q?=
 =?us-ascii?Q?CUdKA0pAZQEmY8c9FHyf+h9fXxXfJkMRl9kaELdHRVB0V/4PJEjxvsSuzRyb?=
 =?us-ascii?Q?p8gf5RysdX6nORX6MNtF6LYTyUm7WH1f21KOo87sQGHDB8A6n1zwEAqixs+M?=
 =?us-ascii?Q?t345CCqHnROzjZPP9HUj2m4e7w+t4cbBaWhsaBIqegW/Z2JfUKSjBxBTNyL7?=
 =?us-ascii?Q?4Ai7NtO86n79pf3DQ142ANIfklpZ/vHwitEY3ruQkCpNR3ybI4fcZzqLa4qa?=
 =?us-ascii?Q?Lw2ykP/HKDoRgMUWmfw2rwV3UbgQR0lLoPBS0hQIrsgSo8oQZNXJ/vddUuWu?=
 =?us-ascii?Q?dm85KcAmAJiEVaC9Mcy4CGb4ibLgCZ8QnTMLLLXE1av16PPs3m57++8OYeL2?=
 =?us-ascii?Q?j4jXQRz1RQI2fu0o8ZhzIfuJA3568XTxoqM3PG/cSQdxo6e6LVHsCK1wKVtL?=
 =?us-ascii?Q?U/e7889H9WX4iCvMMps4BvoRS8UemPlM8cmxwAygD6WIUyZ9yo2uR9lG4wIN?=
 =?us-ascii?Q?mlg5lKPMdrpaZyHiojta7PQdFfwQZb+mq7u2NJjWIv2H9dvExehlLB4wKF9J?=
 =?us-ascii?Q?xG556NXaa/CP6hUupsgPlpqG1mLbIMdRza9UMWVVptnaw2UNX4T33vLxfK2O?=
 =?us-ascii?Q?dA2TkPgSD2VhS4xJb1lIpUVBwLH5I/NZQ+i5r3NobbOLp2eVTt9kpHf502hY?=
 =?us-ascii?Q?xoNroAAY50cZ7tdFEeJMfV+sbvfWj9uXhkFZgfThsXeiuwYg8vsDEhW1Mihe?=
 =?us-ascii?Q?sGHoqalb2s8r3mEY9H7FFoaIEFhgYPYoR0rsAz2gSFkm85BpUeScHd6RDG+J?=
 =?us-ascii?Q?abRm9qyI0R+91SAKhCZmS0vJUCFJsJgijq6SOkX17GrBYe9cS7FPbyzpp7yo?=
 =?us-ascii?Q?AjiqPz4NC1y1uRxm/KZnVKD8qvvCiVmzh2E8OuihbPfHqfAL3xRDyWLpZ12V?=
 =?us-ascii?Q?N+B/1oGmtl11ct4VYzy4ttGnuq/v9n4/sU5pY8A+1nYOdsX9pq2bM71d71hK?=
 =?us-ascii?Q?VqPI/AMW0beYBrMO1qzBBt+yDIlMqPQfHP8X9iafEANjkYo7wofmp3ORqJln?=
 =?us-ascii?Q?yceV3fOwUtECCiQBYlcAmSUnak2tm/EwoYZJdLtDbHSU5j15bH7Wff7E9QX1?=
 =?us-ascii?Q?uXDb3gqCI6qYx72HvzlLPnuzNul4rc7kJ7rn5dm3F0qXp78EVu4oqZD7x3+T?=
 =?us-ascii?Q?eAMIBpGqShqpLUuC8fav8RYev5xM9gPCwAwIIyiDmXDsJn34ELGlgiYbQYMK?=
 =?us-ascii?Q?lyLVH14qKR4UodOn90DfU09VBXa8UAw8oOF2wg7usmMh7qZs/TXYrL+mHmxA?=
 =?us-ascii?Q?1b90B7ClB4L+Gpicopy/ahzFzb4aEqvgolqBh6fZrmyAtSnEKOCN1WOr4VP2?=
 =?us-ascii?Q?3VkLUylU6fD0C+w2NQRZVQGsititSuW06gdSCbhR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eda0607-eb40-4baf-ad2d-08dc84442246
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 03:12:14.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D80DufWL9w8xCinpKT2zbHoJoFnLIA5yWzbqHNKxxdQREiFH6Z12WrMwxngW+E26gkLD293RO2ey71Wz4Ada9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7232

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

To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
remove swap_lock"), which causes this issue.

Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
Signed-off-by: Yang Yang <yang.yang@vivo.com>

---
Changes from v1:
  - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
---
 include/linux/sbitmap.h |  5 +++++
 lib/sbitmap.c           | 17 ++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

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
index 1e453f825c05..dee02a0266a6 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -63,9 +63,13 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 {
 	unsigned long mask;
+	bool ret = false;
+	unsigned long flags;
 
-	if (!READ_ONCE(map->cleared))
-		return false;
+	spin_lock_irqsave(&map->swap_lock, flags);
+
+	if (!map->cleared)
+		goto out_unlock;
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -77,7 +81,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
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
@@ -85,6 +92,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
+	int i;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -116,6 +124,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < sb->map_nr; i++)
+		spin_lock_init(&sb->map[i].swap_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
-- 
2.34.1

