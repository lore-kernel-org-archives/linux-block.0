Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022137.outbound.protection.outlook.com [52.101.96.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342571A682E;
	Sun, 17 May 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779053782; cv=fail; b=tPNSnLOQ4gTJ4bjtE0EYLFRfGCsRgdx/7FEtuAI2DuYEHMfwE/XWc+1XIKKo3SeXw4Or0qIHyvIZDIp02/Jj5LPVcdrPC7nZIrHjeLKc+ncbifII7UIKcQ2WF6+BmTr8HDk9BcszPUt5IMKvL+1zy9qIFDZ6jZKmQ3vurhkXVtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779053782; c=relaxed/simple;
	bh=fEuFOO0HGRQy1cQyCf4fjr51v11JdOBAUXfLUSwHkl8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uFXhDYmcvyQowN/6soBwZsGn68aJ918e5RTykYcFCDtrAG9W5eotGsKKR+hW6vz6R0z+WZGJrFw44fXIoemMyEMTbyDGCaqTKL//mqdeT1FeGfwGolhXXemfHFf8JZOJ9hzNUdF6J7Mae2G3Lo+uvSZSi4RfbW5tO+LAdVtqv08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYgFDQLUoUf8kfAXZ6VxyePl1v2+2C0sX6PvA/cq1jd5DOaON2k4NaY+7px/f+vbTEGBIL2d9N5qCgOZuFmWKXCA8N/wZDso+/74A0UCV3/OI3lUJyLzhlPbB8nKlr2/Ap+sZDAe7OM/txncReqSqwqIN7ZfAqf9p7u6X8YNR9erS2lk28jI3VAdArQbaAOFdXr6rzg8FHddSr+sbDpCbA8Al4iLppIBRemsHamBY5L2LHfGPzg7zDPpTsdSzhZ7bL4VOkrqnruhnXvhfKikBRyb/g1qVHBwOtybaIdIIFNsL6gHSoikrvCSE5R3p7x749nRv8CaOuHsK9RUEK8brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxvX5PQh7puzwhYmZizUSpwSsLD6CLX6+H2dzB2nQGY=;
 b=qGOOtmO+qk5wzsVzxURFvaOoYAnO/HoOrdRJq9gLC4ww3vjeQukSFlnqaezMN3jOyBq42quwfubcCjozcohovdq7g2S/9/xRPqU1x1qTa2ui9fhIZ3Ecbhs80q9ISHMFCpEdGj0JZkuwQ0wXTafASHTwW1Yrcv5qVV6fFAqRUPnafie199qXREU9bQZfKWvRY2KcAn54pQzFBSHPEgMLNYemhinIUbCeQ+raczxiGkFL6wuRYhoTJrMFpGnferr8gUd7jjeefev7PlzzAjxig2w6l6RS8jlRVkmCWwdPznU2YVLsSQjWlIVJu7YqNjp+A3DOHohEfd83D3RE9niIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB7236.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 21:36:17 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 17 May 2026
 21:36:17 +0000
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
Subject: [PATCH v6 0/2] blk-mq: introduce tag starvation observability
Date: Sun, 17 May 2026 17:36:12 -0400
Message-ID: <20260517213614.350367-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:408:eb::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc0e433-211e-4ef5-763e-08deb45c53e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fCiEbZ1cazUAL6sXIuDsC566rFRtPErf56TzOYwtsmGvjcrDpUKv+BsLmozz6u2E2jyoSvOtXrWJNCupTIy9oKVGY8lLxeAP9jfbx35unUmVvy/EKWYLjYOrobp0yEKbWsYfIXjl6qY4lImE3mIiv6OtLJyD+eD7QH3h821sOghnBmCT95BPaUSEWlZx+mp5qS/Bc69xGMsAwByCge++FlLtCHN3ay+e9m4eNxxag6FO4JRRl9bZf/BrRznrtT/jNW3TgWQoe1Qx40U0Mm5/lSsmZBBPpeo4k83153rNsuG/Q/I7PF52Pedea+MJgL+KMBRwxF0Uy2vDiEjGECJbdr52xDjbAckZ5UBn+Cuv5XavFjYF3pZnS2Io0MGF2CQzhrAGZKdhRbDm7DOZWH9yGFTen5H8uMZEQ1EMLFJawcDP1E69Sg0AS7v/us7Ect70rgSOhq78dBektgkrfOUYs7XvR2U8WrGG0mPp8tdTs1Hv0NEdSBdqSfBM6udlRymtsY+CBX6XWJ3WDvikqdsLmrdkvl+PK5Q58HdbgUdk/Y7QVwQYTPe4gLqtarLiZQ+ghJet7dumoJmiOOtVWDhRKl500dKAKkNma47pIdorqQIb+bGdWaiZFiaoCf13YiqrDrGkJ/1DIBDaIDHNF95F7He2V2rdFozKwIo9Rsvdpi4b7Mst1T/TRftZ+aWzXd3R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QoBmYvSxbONdf4U5eDPFfh0Xzo/k+LYxBd/v69uGGSrZUPiwvnpwWpyiUHUr?=
 =?us-ascii?Q?Kb0BHOFjpoOnukMzpIxhH9djbt1+YrAkmWAql1LgOCF9KKxGhMWkhA4Tw/SW?=
 =?us-ascii?Q?P7NmDFyWPTANIPBHX9ZJBQrgPNL48uU1fmg96InJqAnjWEV5kncHOJaxMV47?=
 =?us-ascii?Q?7fGlvBrWAzgeuNI7U6xCwwDZTTO48VL1+pbn7P0LyD20UbB4duq1opg2AvUW?=
 =?us-ascii?Q?DhEOdtDLF8WwO1vecqo71QJRE3/5c9FWy6X+ZuUOkW032ZCd7dZQ481KHbIg?=
 =?us-ascii?Q?t30K4sMaYSU8AMz/I9t58XMG5u44ib9vtZlzjPybYp8hI51LWX0ZNFw7/x3w?=
 =?us-ascii?Q?rodjAMdw1eo/iXOPI0fJ7lPMN6g9jJaQLKDhHt5U82bhbTpC9uMocA/UgjR0?=
 =?us-ascii?Q?hyTse04OxSU/jjTGsGVYBpwaWzerv1YZP3tbquzTZif2qDrQDqNvsq+9mdoD?=
 =?us-ascii?Q?UjMYeKCJCyYP/uu8wDjhxtnfJqedYB2Sz3ceP23iDf7mKb7uvByAln9nWeJ6?=
 =?us-ascii?Q?RjtU7Ur6eoJeRF1BXhHNXcQ5AZ/6Wqp1ecGMdiWBXTWhH9nTVnYGsBXkqvAZ?=
 =?us-ascii?Q?tSdDwriYeydF7B/csrArdZh6fHONanR/SBcDnvdJnZm85WJKdSY5U/+JN/V2?=
 =?us-ascii?Q?kb+qPF1cRAmYxyTzZYwn9KYfgXJQi/dskebn41W1ezXQl79Gbhc0jUHzbeid?=
 =?us-ascii?Q?LYNLavtUTWVuNxlO/he8PoS2JrALWb2J/G24ZHNVuFH0A92oSZVjerlWMD5w?=
 =?us-ascii?Q?8mzoxp1g5lUb9hbDW+8QkgNCbLbGCXDi10ZNYKue41+9D3Bs9eJ8lzPgKaSq?=
 =?us-ascii?Q?mXKkmewiO1Rh+pRnyygARKtHVRH8S/eEPjYpbOxEqJPpma8LQNVfpG0d3hn7?=
 =?us-ascii?Q?OREh7kO1zIbQR4m4Mr5UCyNnO1Nuwj1pHltPhyAsgvYJpv/xoFO1xch3pWDE?=
 =?us-ascii?Q?ar9cx/u+69PD5ICiW2MYNIGV0b9pD1pZx5Fcz4VN3lCwmbYsf/C5DJ4BRlM9?=
 =?us-ascii?Q?/QspBYLgA3tgHm1IM+2vrq2KlXJhKSjybbMjpgdezdNE6VSFszaOUgB/E9YY?=
 =?us-ascii?Q?ptQaijk48C9kC3Z7Z2VhSmkGxtATVyHDi6dRU6uWhXDTWMixAk58jnKsQlHe?=
 =?us-ascii?Q?ja+gx1gerTdG4S3nWnTJ+oEtBpmoqqavV4UWfmN9tzJKuYKYD1MX14R+unGG?=
 =?us-ascii?Q?zJcQBJJpkJyxPOqBVuJWhcnWzmPylh0iWbzSNL4dCE1IqM7QFtD4vhjTXLPb?=
 =?us-ascii?Q?ZnhSN1AN6BV2GBRt1VOc2k9BdJWQ0vHHmWInrVrPWYiaUJ2ceDyUxJ7X5hpI?=
 =?us-ascii?Q?dvNV/RMJD+5lTuuPUhTGe4auXM/rJ3HgYhpJdco2YECU/I6wEmMlhZ70Hjvc?=
 =?us-ascii?Q?NNoxs063AMM+lizm9CDnrXY/xGukPwuEmDyYUcYRu3thW8OvIwETh7CrpcYG?=
 =?us-ascii?Q?jW0BbH/b+qDIozIHauxyYfm3x1oSsTF0l72f2z5oa7e7hRG3OHDwuzZ+GolG?=
 =?us-ascii?Q?VrQJ9rWgh9gz6HWq+nPtrSuMnduuoU2iFWHjW/1lUn9O6iNg12GZF/Oasjty?=
 =?us-ascii?Q?8zseF3CX7gefsZJ4aBuN9IjH5Yhm023N0VljXZAsVOjM0NiDEq/ERwo8cYPy?=
 =?us-ascii?Q?/nkUWXgKCsd2jS9oYdQvguI9XHS1AmpJZiMhWx7NshjLYfDsp4LT9s6ptQzx?=
 =?us-ascii?Q?P8Bw5cJLxEEPor1hgnelMVTeC0hSCJjdUPNvCcDOm+f11LNSCBUvRLVjofGs?=
 =?us-ascii?Q?T6Q72WqyeQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc0e433-211e-4ef5-763e-08deb45c53e3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 21:36:17.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWT1MJqjb1NaYXuRZGLfoVCYQ6ztZSjmmLRGgZgv0ZNlp+N7R153TcJVaerk+OoGYZVI+SfmFKm7UyqlM3NtMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7236

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


Changes since v5 [1]:
 - Replaced this_cpu_inc() with raw_cpu_inc() within
   blk_mq_debugfs_inc_wait_tags(). This resolves a preemption warning
   triggered under CONFIG_DEBUG_PREEMPT=y, as the routine is invoked from a
   preemptible context immediately prior to io_schedule(). This adjustment
   deliberately prioritises the reduction of execution overhead over
   absolute statistical precision for this diagnostic interface.

Changes since v4 [2]:
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

Changes since v3 [3]:
 - Transitioned tracking architecture from shared atomic_t variables to
   dynamically allocated per-CPU counters to resolve cache line bouncing
   (Bart Van Assche)

Changes since v2 [4]:
 - Added "Reviewed-by:" and "Tested-by:" tags for patch 1

 - Evaluate is_sched_tag directly within TP_fast_assign (Steven Rostedt)

 - Introduced atomic counters via debugfs 

Changes since v1 [5]:
 - Improved the description of the trace point (Damien Le Moal)

 - Removed the redundant "active requests" (Laurence Oberman)

 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260427020142.358912-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260419023036.1419514-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260319221956.332770-1-atomlin@atomlin.com/
[4]: https://lore.kernel.org/lkml/20260319015300.287653-1-atomlin@atomlin.com/
[5]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/


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

