Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022080.outbound.protection.outlook.com [52.101.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04836A352;
	Thu, 21 May 2026 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406231; cv=fail; b=ekGxftV4XHNb83IgAINA83d2PJUZVF3P+goxtOIrMBbibehIkJ9Y+5HWircaWkdQW4S/NqHiNZQVYG5OqgY1HVREG3yRGd3Xlge7ac2xDWHMuuhpC9SlqlT55HZGgk/wnMysWR7H9Nm6sYFUORHT2GJbev6cztJEhCmzoh5Eob8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406231; c=relaxed/simple;
	bh=xwkp1m4Mho42vVEQyCbCAZLNrcLouq5kFANDAmnKf3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hq6rkByWiO7FuXE8CCc7LrWw+8q+OlXxgG0CLdE1Td8KUJa5C96gEex9p1+Ro48J6oxL3OXYttvYZe/rdCRqDHCHkPkhLlorZHRbQFLbyVYMN6ly5Ney7WBjSK7ItfOepsZ1R4e3VeXzkA63ucC4nMEl0sm/WgZXGRnDf4alQlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVl+Bd1mjbRf90twdFyxQ6G9hJfymsrVH15ElOJvqqP/jATp8WrS3/31vKCkFNlaZigRzxKHswP1TN7u7DeAMfpRfMQ2Pjs96wxXB6M0GFEFcjGwbR5zUEU21II0dgsq2ZUHdrUt23y0ijJGIswUeO+RtOI8kzQt4W/0dEMsQIicwZX0O8H22okhfjswlOyADOIxSTsx5osveaL/T2ykrTyZ37v58usxKrfD0OSMNHlN6u/+RMiW9vopXTpkvFyAgKfNUn+PwUXnBcynO2nTnOzbwXSxVpXqvcao/Cg1R1XPsL41x0tQztJNrzpXuB3UB+P0vjQ9bw4BIs3EIDt2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeKeEqwHpZKZATHUqnFE+WIBucVi8HgWbjUcpz9Q9+s=;
 b=l6VF/sMS+PpNCRn9H7hxzdNnU0L1017+Ed0W1LWFxrhRDborRkK+oB0UiW1RtDegujCkmH9gNJbuoLESf97PqTeq//9tH0gWVRVGOg/gwPWlbROgFj6+K1+zJggfhqppL/Z7Yct2a2ioXSsU+JY+N1APwBIIeN2RH7g+OLEbAyUOZ//i09I5QlLOV+nMvWNjW9rsPNb5iSQKsUcw0EX6Dt/SstWzHxEI+lIMy1PnuXHc3ycGmCos2H7E0V9P71yyrFT2+1shz//DjHu+1mrbbTx1G4ZKZGp7oyAANznE3hu9/ufX0xF+RKq+9DC6jXrg2Rx+Q0LIf7vPzvMBrmD5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:28 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	tom.leiming@gmail.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	nick.lange@gmail.com,
	marco.crivellari@suse.com,
	rishil1999@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 7/8] genirq/affinity: Restrict managed IRQ affinity to housekeeping CPUs
Date: Thu, 21 May 2026 19:29:55 -0400
Message-ID: <20260521232956.553287-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:408:fd::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: bd566961-9df2-4e89-4c3e-08deb790f13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9gHBYT+IrS1DVvsxk5x8q5oqRtXfb3GnJA8DBrUmwIS2ERMpPC9pLeV+aMsGQ1/Z1tCKadZGesS2QrMdhpdeTfQ/JGLABx299W7Uir9BhrxA/B47dEGl/P/qUbqXJc9H2zSZN5D9tkX7ChRgaOIpqcmDosA+d894ek01nIPqr5sUPNLoJthKp1f2b1qSlP6R/kf6Tt4jTOBiR+CviuBVS2ZFudbYhenV815K++Ws/KJr7iyFWJ0jMsL02NF3vF7CvQ7bxJ4wj6vtJxCNcYlIT43MrCn5lD97BFytIiRlQYJsHHBiYUIe+poEb2AFKjWoM5bu5LwRRO01GArimjqD+78MNtusyEZv8j1ZHIAjKghhzuEOXXG2UGHVTHjOdWwr30uBGO92UAcAaaeZhJ8fDC+ZXq/7N2BtYJMNKQ3vfgTTbJwGNhpmtBlCIqcFhQANw8s6Y93hVvbW8iu6SKAv/pJtLmWNyusdUtc/P8xuvKt1V276nbnh1EVW65J3IDhkFEunaB3h/KjPD2MxvX0nBrkjfwe9DMB7jX+pU4lz4Xw3ktx+rhS+dWWzom/8cea1WahRCsXXE1rk6q6wdu6e0lj3V7Hvg7cvoKiWYm0NPm8IRxLhvv2MzNyzpysqJwIwcvswyD4Bk+zEBH/UQJWLcPM1HznJiJjkyqRWgRaBhLq8dFbDUeICvj+1FdgyCb1l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYTTPBvjYMwEzBIs+sSKC2wpSCGeNjG5Ay894v3ooXOp9eA1YkBJlgqURdjV?=
 =?us-ascii?Q?3K3H4nK1ZzyrdmUOroevQazxs7/0Kx7xqUmWfijvLxvasLoL/fBO0EdpeURk?=
 =?us-ascii?Q?1AY9rheL6VRsbzfbF4OSqxqEL+/vphKtA/gnxhWrKTFbXW5fv4/1TdsomfAR?=
 =?us-ascii?Q?+1EmoloqnW4fpOWoGcwbIMvo/bs4aScZ2lhK4Wx/zG4I/oMYAz1R0ngPD4YU?=
 =?us-ascii?Q?VfYvWpY2xlU1dh+86zKDGVbEirwrGFY6sdWmFvhTsRBMNFXhFaqPv5lzvefC?=
 =?us-ascii?Q?bvUxS7j+9pNP1LBUO6l0c2UPoIS8n35A9idzdKxbpixexdFE7OaJF3QrlIoy?=
 =?us-ascii?Q?nom6BjVL/HdS3VdKXowJYbB35o4HwXsYQ1B5Ic95f1KAtFgoQknXi79IgGQJ?=
 =?us-ascii?Q?R9K941cwleN1cQuHDz5xwE+ttxKAYdC8b0uSZ3f6e6xUmZAqtEYEJA58/smz?=
 =?us-ascii?Q?QTFVOUb78P0a2oMDp7KUSDTzzscKDEIT68rhe98Udde3pSrwJjFIXhIW0gnt?=
 =?us-ascii?Q?7hSsXIu8zqCTq3SGbmZWk0GdCtyDG24IznEtFd3v7AcApMh/F4sBPVOOxU/U?=
 =?us-ascii?Q?JsDxa43uYPxjcb8qximTBuONHV+Ffdv62+tFUQiVj8nkmBKpV+4f4oyiLara?=
 =?us-ascii?Q?xvvbLDLi9wusz4kg+MQtHH5YolXVHYqaH7Im0Gdq1CoQevMMGzowAPXwb0AQ?=
 =?us-ascii?Q?XBSNYyPsDRftBl3fyLeBSu1soUm/foQ7qIU+62TnXkNKHhPtiV+oexorL1eC?=
 =?us-ascii?Q?/Ico9bSiXn8PeE6SBOU7X/DfYCUAlhnkiPAY82rDLXa9wxEezdi5ZVCw7l4t?=
 =?us-ascii?Q?Zg7naN5JYnu17SbzhDbExLII3z9Q5n8iT4Tjko9FlOrTTrfX1LQluGc5CRDO?=
 =?us-ascii?Q?Vjtn4IUJ2fepGtL2sddB+0RjIIAV3V3tYle5k7eOmnQM6F5/YvhdqIt8Iiij?=
 =?us-ascii?Q?8ap0dhfPG0/Sj2BUCvMuc9dvrytmEeUBkN7HDiyI9omwcX47T8YigUh+O73v?=
 =?us-ascii?Q?aRbzMVF3LOKvVD9zqqwBQAHspnsztnEdxPZm4zt74R57juDvQ7Xf/nwJF3j8?=
 =?us-ascii?Q?v1btg1Ize5fL8595nMqiPEAEZhGAeZEO24kSK1JomGyVxMldyzGYbKyXCBU0?=
 =?us-ascii?Q?Fgb74AwT5M9c5wPU8tK1TDSgNHPmLwT5zAiI8O0wlvMwhLzPmowF21YYG8Va?=
 =?us-ascii?Q?BFBP6VM3dXu0SKeW9ClRfxhl/zYv3QD6A2usEf7pANkqt8YDjWd6v/RW+lrH?=
 =?us-ascii?Q?tSdDFsQG4yFlnKMOUzMmeAhqyEKfIaNHuRdvC4DM09lCAxJ4SltfZasYNR7e?=
 =?us-ascii?Q?VqNZR+2ahMbZPWtvabSV75+8z9LFjj52o9wf3fKn48sSu4o4KXOo46ofkl3z?=
 =?us-ascii?Q?tHc4u0eR19UXAIbLbOupF2EkbF0aJmRkS97Yqwd0GWxzueU+OL0wZybQjFf4?=
 =?us-ascii?Q?fDGBeDhyaCLgAaVIJ10/EqUJjlie7U0sgzWa1g6qrlQ0lVLpdQqtjnIfX3Uy?=
 =?us-ascii?Q?L4GHGzIbOtWtbnxwzUkBagedxyP6sz4dMc313eN5iz2h/SOcWd8qjBWxwQVx?=
 =?us-ascii?Q?9MSAkVLiLrAebmCJ1P+e6XLQgWvaelio3BkGWpJSVwYv27aTlvVb1FAyobJn?=
 =?us-ascii?Q?r7QAs8ZqWXV9p61ILiOsqsZWITZ+m21wI5USe+ezZgWYZbeWtDad7DsJwBQF?=
 =?us-ascii?Q?L3RMzUfn5Q8JWfzji47jZdRxo+0nzkWdc/Es0VBJpcEFD/Hael4pm7n7lShh?=
 =?us-ascii?Q?IOinPHPC+Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd566961-9df2-4e89-4c3e-08deb790f13b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:28.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z4zAm6eS3yLYU5Rj14yoAzcJqsPmUtWHFtOtDv+tsH1x0P26SdpCXFWwX+3iXauUDA+zUdg+qpstGu96A5X/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

At present, the managed interrupt spreading algorithm distributes vectors
across all available CPUs within a given node or system. On systems
employing CPU isolation (e.g., "isolcpus=io_queue"), this behaviour
defeats the primary purpose of isolation by routing hardware interrupts
(such as NVMe completion queues) directly to isolated cores.

Update irq_create_affinity_masks() to respect the housekeeping CPU mask.
By passing the HK_TYPE_IO_QUEUE mask directly to the topological
distribution function (group_mask_cpus_evenly()), we ensure that managed
interrupts are kept strictly off isolated CPUs.

This patch additionally addresses the architectural constraints of
restricted vector distribution:

    1.  Vector Limits and Overrides: Updated irq_calc_affinity_vectors()
        to strictly bound the maximum number of allocated vectors to the
        weight of the housekeeping mask. This correctly overrides
        drivers providing a calc_sets() callback, preventing them from
        wasting memory on dead hardware queues that cannot be routed to
        isolated CPUs.

    2.  Multi-set Alignment and Leak Prevention: When isolation
        constraints result in fewer available masks than requested
        vectors for a given set, the remaining vector slots are padded
        with the housekeeping mask. This replaces the historical
        irq_default_affinity padding, ensuring excess managed queues do
        not leak interrupts onto isolated CPUs.

    3.  Minimum Vector Safety Net: To prevent fatal -ENOSPC device probe
        aborts on heavily isolated systems (where the housekeeping CPU
        count might be lower than a device's structural minimum), the
        final vector calculation is safeguarded to never drop below
        minvec. Queues will safely share the available housekeeping CPUs
        instead of failing the probe.

    4.  Zero Overhead: The housekeeping mask is conditionally assigned
        via a direct pointer, completely avoiding temporary mask
        allocations (e.g., alloc_cpumask_var) and bitwise operations
        when CPU isolation is disabled. This guarantees zero performance
        or memory overhead for standard configurations.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/irq/affinity.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 78f2418a8925..dade92f8b4b3 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 {
@@ -25,8 +26,10 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 struct irq_affinity_desc *
 irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 {
-	unsigned int affvecs, curvec, usedvecs, i;
+	unsigned int affvecs, curvec, usedvecs, i, j;
 	struct irq_affinity_desc *masks = NULL;
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	bool hk_enabled = housekeeping_enabled(HK_TYPE_IO_QUEUE);
 
 	/*
 	 * Determine the number of vectors which need interrupt affinities
@@ -70,19 +73,29 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int nr_masks, this_vecs = affd->set_size[i];
-		struct cpumask *result = group_cpus_evenly(this_vecs, &nr_masks);
+		struct cpumask *result;
+		const struct cpumask *mask;
 
+		if (hk_enabled)
+			mask = hk_mask;
+		else
+			mask = cpu_possible_mask;
+
+		result = group_mask_cpus_evenly(this_vecs, mask,
+						&nr_masks);
 		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
-
-		for (int j = 0; j < nr_masks; j++)
+		for (j = 0; j < nr_masks; j++)
 			cpumask_copy(&masks[curvec + j].mask, &result[j]);
+		for (j = nr_masks; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j].mask, mask);
+
 		kfree(result);
 
-		curvec += nr_masks;
-		usedvecs += nr_masks;
+		curvec += this_vecs;
+		usedvecs += this_vecs;
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
@@ -115,10 +128,12 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 	if (resv > minvec)
 		return 0;
 
-	if (affd->calc_sets)
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		set_vecs = cpumask_weight(housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+	else if (affd->calc_sets)
 		set_vecs = maxvec - resv;
 	else
 		set_vecs = cpumask_weight(cpu_possible_mask);
 
-	return resv + min(set_vecs, maxvec - resv);
+	return max(minvec, resv + min(set_vecs, maxvec - resv));
 }
-- 
2.51.0

