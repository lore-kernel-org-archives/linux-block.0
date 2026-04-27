Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021122.outbound.protection.outlook.com [52.101.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0A70808;
	Mon, 27 Apr 2026 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255312; cv=fail; b=QS9D0lK4EvFPSI1/xILt/QJOM+luRF8RBFaaAbXXsD7Xc1R0C5xOwY0vc2oHv7Eq49ZCwuaZr4J+h9/+a29yhm2eS2zOOFOXmUqlO10Dsui1FH0HwohkyU73+ST7/QBxftuV/5KINOrGlzT/PaRy5mpUzD6jaktS3PnYJcwesbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255312; c=relaxed/simple;
	bh=AAUUWp/wUHKfRYRa+quXTuZMtC6C/jEFRbLDDubjFtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IAxHqVwpWGtLczD2NB9qgC36R4WhqTY1efSm4jwq+Oii8/C/+GDr7TKYrEj36xp11Ioon1rUEdpb815UoHYlfTbzBSJZR6i3srAEuA1wHlwoiQwZsZJ9Kyx4Fz53eayi7QHoaVfwb+3X5xRJHp9OZaq0v4XNAt9eGdzE/0bgzt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oteuzdQ0kCQsYijvixGZM/AVvuUMI5L7k4yBUc2M6JfR16W+gxIuJbBXkt7K+8YjRbfINB9T3TIS++YhTDNsqjNgxK3bZ9jpCeHxH2yrjwom4fnTsek4dWoiNc+ogvPhAl2CkcGsO3+s6hhLRNkQ7xih1Ng+b4MIV7fJ0wG9YPnMWthh+SaAUHj2dOuaCqZdzOIkY7ZVJTnsLdT60NUxYSI1dWAH8OzHDS/wp8gbHxP88xh1TKl2cFta26niB4tb5QAOEljCK+QOG7XOc9QRJEi5b4uxCOc2o09Jae36a18lv7APDlvVl3/cc+aXqc2c+ZEx6sDitJ9V8DNu9Go5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjM5wTk5dexYu3YIVeucbDlB/8drfdhxPcP99QiEgJw=;
 b=y659mIQJIUrH4LP5LnlTLJvXMezZe5ILIjb/Jio+kIbW0USLbH5yXmaveVpgs/DFIApoNagjzJ75XA3huJ/nA15I4mvY0w3XuamAmdh8Yvvq+IKykJeAmO7T24vntzPE+KLZGBeTsB43weLYqsiZzLjkn7UbTKWBtiGIJ1kofGHH6qJYguq8L9XybMbTRVKeV5OqFZUUHEbmp1HWfcGBNTW9gyi8arScJtW0vfjbjRUc49hyqy+74pfcVrpg7M/GOT2c7WzG64k/BjPMYOisqcNFLHKWJWzoQWnIqqBObZpi1pDfJ5XYnXYlCVtrwe5ZK8JUu8thee7dP5lhcmZwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3559.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 02:01:46 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 02:01:46 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org,
	johannes.thumshirn@wdc.com,
	kch@nvidia.com,
	dlemoal@kernel.org,
	ritesh.list@gmail.com,
	loberman@redhat.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] blk-mq: introduce tag starvation observability
Date: Sun, 26 Apr 2026 22:01:40 -0400
Message-ID: <20260427020142.358912-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:408:eb::27) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: 027980ce-8919-4c8c-15ee-08dea400efb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+HtAqN28vNe5Or+PBCaXC8Ctm1ZDLlPN3pZxiDXWRgOhuMSA/UJ2nq3Gq65DL59wDDJ+YNnxTwzykncNH4lGFHGHCfbqrGPoS4WBJfzG9P47/Dn5ViOcBGBqRJXTa9ZjP69W9dhfw85K4tdlo/L9DMFJLvLMb/CvjFCfA+e0/9ZYeBbARM2r/1Kz3YlziB6eZ1uugC5D7ZPikK/BbfK2xW6jI6wdA/WuMWBtZhLBz2EaftM+1gG/hpNoqh2TUPaGfGy+4Cm8RctUSVseQEKjMZOFOuwffX2UMTUix5mYJhGqCNeVnAuXydGikKdZvEmy/WnVsSKKJEIpoddo1gTQeltUXPu2zTHPESum0RktjgS75/sRvITS1CDHPLBecBKiViN24yBRn/aIj4IOf2mAV8Y+l34MtdZkC3dT3kOmvCG/as4P0L6q1OHX31uuT/MOr8krokSq9RVuMBrs21Jd7MCzV6KU7ZXdST80dtltvvj/mfSDfr+kmPa8zPjbo1zOQKmdBWn9hLMumSqxDWw9GU+Q3FRzKfY+qLy+M7WfXm6V6swpchzqYsKPuyb+MDBLapM0skS3/gnpIebsLqkhfhcI3dVmgG+RDt8a06mdllSfCOjE3qrz0Fr4emtWlWpOkyAloTzu6xesO3l/vNynNjSSgYBAgKNlvsNkTG27bAI3ewx+jUbto3jNBLGx9oo1emTFB3mYrZY5CDdQBE8PoFwLJQcIspVZ0MOllqKkzEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gtkfq0EDL+8jlf9NoU84AC6nlIKRn0Ri6Di572JQY0e4JA5IHh39hy0MKQKK?=
 =?us-ascii?Q?PlOd8n30hnSHxOY/xfh9WHppAlhB2HODZ05pzrAQPUQXfoBR9+N2hkv95hPf?=
 =?us-ascii?Q?HuGYgLxeu6w4rCvcfTSDyzXiWKSTj87SC/VY60hY0d02ndHH/xGM/b3nybKr?=
 =?us-ascii?Q?3BfmGQc9HNNgPu+ISGBoX6F/BuPYXi0Ngg6i7JRhbCa2fHxu1vOZaGZA5EhJ?=
 =?us-ascii?Q?2KLESrEJ6woc+vpz0wYvJZz692ACyrWDm5EOCNAiiLtsMtkFngkQ7daErDLy?=
 =?us-ascii?Q?bt5kzDwvHxEDME6J7phUjlUPR3SxaI5Kt7HZUkD/WoEIj28KHmvuePymYGlz?=
 =?us-ascii?Q?vs4rKudf3itzIXeQoekqHkXDoO0WSv3AaAiH23MToIXA59gAkFd8EXHSEAs/?=
 =?us-ascii?Q?dDOtD7C8WmgAepfDlQ1SxLR//enUU3KntdGTZCWMHCtBKnO169Lgsi/lUYFa?=
 =?us-ascii?Q?OTcgqt5uLUAYHd9a1FB1u7Z6UH+iK/VSlowp7kY663zm7pnAJKbgAnhefrkW?=
 =?us-ascii?Q?E9ODLNk3mJMGiKlc3NH0vVTkSrYFvobxoPbzuQ8phLnBnaFZwmRf/FhBPSwP?=
 =?us-ascii?Q?ZbIjosvBM0ayLLwurTI4Fg5ZWSflGsUkxBWsWSB9QZeOxx0nspGmZnyLbo3Y?=
 =?us-ascii?Q?XWn2agzSeT85DkVyKir66J6f74uzalsxisJe6cqV5dEatrldSaOaft6IoiY+?=
 =?us-ascii?Q?lwABQXoTaHAQoUECwvWDsip6CUZeNp60H6IuKZBxkNxJScEUIVQy9fuNteEf?=
 =?us-ascii?Q?K2bh/v2hAkzc166jxeq+Us8kxejhyvtZWXj7q/eGht+jn+wuW7XhqzmLwlz1?=
 =?us-ascii?Q?/SiaB3ekrYY4jSaYXBlhV2xFrnW1W82/JCU72Ny2jhlFy/AcdZhsBSwf/YTB?=
 =?us-ascii?Q?bWHCGSz5vx2pq6hvRWp/QiSHc1d2P3ZgI2JCjoFq8IvcNF6wMUnytPEreTyP?=
 =?us-ascii?Q?W0RxemiFuBimjeY+VggQ441vRcKUzI+gGIxJbNA4COgVx1aUUEFp19lerSQh?=
 =?us-ascii?Q?vnTl0Swxpv2m3Q5gtXUO2A2sdT1B5krFPZ01kgQqU8oLWUj+F5gbn8WC7i1Y?=
 =?us-ascii?Q?q+iDjm8+12weFXtMlluNVby6chY/DnCVzgnLy94E/codSHa6VP4snNd0tWi4?=
 =?us-ascii?Q?i7Uz9UvzlBuXCZYxfa2cv5f9e75umdLs16j/k+gLsmZLi8sa9PVfgipfSF/J?=
 =?us-ascii?Q?M8OFLXO2SoGr3ZgfTzMd+g45ruO59HWiaC+l+U1dStRr287gpoGTghmm2cju?=
 =?us-ascii?Q?4FEgW/sCtWExn5xx7q/4i8QY3/ZErnYs4V4vySixSt1TkVjGOMsPtqWx4lGZ?=
 =?us-ascii?Q?1aQIKzhaYbmZeu2K8xk6/2PxSwEyKYoJcsJAf79dUWownR97H3HiGyE3/Y55?=
 =?us-ascii?Q?NJQNqER8oOFfQrGFYasiqbdAvzFrPmU/JjctjuVtAzdqGYvqKOlbIaPGNyJL?=
 =?us-ascii?Q?BAZ622VRl8l6p1c3184d128/Jfe4enOraZFb8jlOXFgHO7cMIoiDhVDdnV6r?=
 =?us-ascii?Q?J/P6eZ4Z6eb5X36tI4VbHou3oChaIaBaT6AOPmdlLItuK8T2wSJ6GjrGL+z/?=
 =?us-ascii?Q?EkOoWCQv3693um8T7oxiRvUWv2CLer9RkYWCKGzenolD/pwi3a5upRrhxbtj?=
 =?us-ascii?Q?cRPv6FtCYVUurrCiIAPMM8IdWbaCQ3nNwYYfTOFg/8GpXZU8mrmX6/D/h1r7?=
 =?us-ascii?Q?0b9DTrZMvSAR+IevZdtCDILt6wjTg74yjV+QpNOLHT10n0GAFFJOVq86jjyK?=
 =?us-ascii?Q?97rajRDQOw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027980ce-8919-4c8c-15ee-08dea400efb3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:01:46.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cTOkxFJJ+39+amKsl+pMzm9BmKzR6gZRKz5PYKTX0vNwAhnXBoYVtLGvKDWEVVOETvTtpYbm1izts3vJ5HenQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3559

Hi Jens, Steve, Masami,

In high-performance storage environments, particularly when utilising RAID
controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe latency
spikes can occur when fast devices are starved of available tags.
Currently, diagnosing this specific queue contention requires deploying
dynamic kprobes or inferring sleep states, which lacks a simple,
out-of-the-box diagnostic path.

This short series introduces dedicated, low-overhead observability for tag
exhaustion events in the block layer:

  - Patch 1 introduces the "block_rq_tag_wait" tracepoint in the tag
    allocation slow-path to capture precise, event-based starvation.

  - Patch 2 complements this by exposing "wait_on_hw_tag" and
    "wait_on_sched_tag" per-CPU counters via debugfs for quick,
    point-in-time cumulative polling.

Together, these provide storage engineers with zero-configuration
mechanisms to definitively identify shared-tag bottlenecks.

Please let me know your thoughts.


Changes since v4 [1]:
 - Prevented a NULL pointer dereference in the tracepoint fast-assign for
   disk-less request queues by safely checking q->disk before resolving the
   dev_t

 - Fixed a Use-After-Free (UAF) and permanent memory leak by decoupling
   the per-CPU counter allocation from the volatile debugfs lifecycle and
   tying it directly to the core hctx lifecycle (i.e., blk_mq_init_hctx()
   and blk_mq_exit_hctx())

 - Fixed a potential compiler double-fetch bug by wrapping the per-CPU
   pointer evaluations with READ_ONCE() in blk_mq_debugfs_inc_wait_tags()

 - Passed the appropriate gfp_t flags down to the allocation routines to
   maintain the strict GFP_NOIO context

 - Updated kernel-doc descriptions to clarify that the NULL pointer 
   checks guard against memory allocation failures under pressure, rather 
   than initialisation race conditions

Changes since v3 [2]:
 - Transitioned tracking architecture from shared atomic_t variables to
   dynamically allocated per-CPU counters to resolve cache line bouncing
   (Bart Van Assche)

Changes since v2 [3]:
 - Added "Reviewed-by:" and "Tested-by:" tags for patch 1

 - Evaluate is_sched_tag directly within TP_fast_assign (Steven Rostedt)

 - Introduced atomic counters via debugfs 

Changes since v1 [4]:
 - Improved the description of the trace point (Damien Le Moal)

 - Removed the redundant "active requests" (Laurence Oberman)

 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260419023036.1419514-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260319221956.332770-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260319015300.287653-1-atomlin@atomlin.com/
[4]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/


Aaron Tomlin (2):
  blk-mq: add tracepoint block_rq_tag_wait
  blk-mq: expose tag starvation counts via debugfs

 block/blk-mq-debugfs.c       | 109 +++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h       |  19 ++++++
 block/blk-mq-tag.c           |   8 +++
 block/blk-mq.c               |   5 ++
 include/linux/blk-mq.h       |  12 ++++
 include/trace/events/block.h |  43 ++++++++++++++
 6 files changed, 196 insertions(+)

-- 
2.51.0

