Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C23208D0;
	Fri, 27 Feb 2026 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168642; cv=fail; b=OQvQCLx+lTDC6xiYQtoLHubEZA/ezhy9ULkdVFtsY5mwdy7YIRt8dKzhKZ08Y5UL8glJmMqYYMiumPlQm5tnS3lK09B3achGal/ZYKK5SrcF8WPZng1Y1UDEudXrVs6kj1XtiG3g13rRCzx9rwZ1yBzzVz9ktoxPL2hpApCyyB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168642; c=relaxed/simple;
	bh=LAWJ7UG2FhTYA7hlJcFJchT6AMfXmTO7kKwojSy/FU8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wg0y029ETNWlwoU7A22aAay0SCq5udzL8xES+3d4646t4sLVN2NIAMibZAGPOlqvVqm865zmfGqbOUMt1+/BbkZHNoZ6aZ6/2uqKyNwngEYEekuQiuok3ML65YE4ijTDV19Hrp3o6TPMSLVHBb0YnLwaWoy7PM/jvzaSvWgjLhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qp04hJ/L; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qp04hJ/L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QojpUAh53dtMINMvr4HZQAcmKpB+Ayxtg4JmMux+0B+2W/SnUgPQ1oZoZIDZctXrSOebQKoNUw8pfUJvb6C/tcmYjT3soDmvF2TgrqQnLXmQiUBwFjQ4/HiszFPEncgC/NkuT5ihvyNLyHsJqhdTaCzgKlt+kMBfuxHYG2iY3jVf+fIOR4CZJbmNfJ/4nfRfDyksrkf3B6KrWdN/hQ5sYxPnxneewFIaWQ7rPIbGaKX35A4mSC8wah5R7XPhTZzm4etgoiaacub7B/W9cNcuO0MOr4zRlzN0kKCVqwsLV+/cWNIQSBkPgK+PsNdyyw+aS/rsVx3vXwPgQCcv9cYJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVlVqki7ZPxcdf+/duwvAtBBUSmUldyLMr7WypXwsVA=;
 b=fG99Kx9XfFsQkwVxecTeDWxJ/Ma+foZRgF4SS6rr8jjW8jEs0pSrGq0ULXe9ijjBuwDqzWRjteMw790Gog2qUNRz+GwXFbrK/SiBn86tvVeJdvsZsagDUvCNGpbj23b9F9jrgoBkqWenojnC1OGbh3GjibmeomO7PnA2o7nMX4who3hGqn2aQh7O9Ch4YDEs8nxzI/45d5Ousy8tr6NGgmdiUM/iqT1DXsCO2py5YFkWgmbIh1Do5dfHDM4ehBo8mfgnXz0Q7JRBHSd/2/kvhgFsdZj1jkE4PxOp0cHsG/hLLNXpFd6T6SNoGu1Ca0U5aOHOeMVxcbfMm7gZkatNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVlVqki7ZPxcdf+/duwvAtBBUSmUldyLMr7WypXwsVA=;
 b=Qp04hJ/LtVdNicnI/JfQZ7cdEmfwQuuf2u12gb9WTrgVqEUPKV6q+KbddzXLAWnK/bSjo5fQAPayuysu4Yk6OVwLmR54OZ4QGbWWw12L6FRgrQ76Xh83SatWxRWSUcbBZTV/GvJIdVWNXYYu+9kzlvA9EcOWT8FOPyPKTee9tSA/ttTUv4n74LB/kVGkB6xhTgY3x+uvY2tG3cdvZReq8Sa5WEPMfJXgdhgj7o896BLW3oAv94gfZQR29fleNhK6Z8CV/Gf3NgpYsq+0fF1MY08ditWg3lfOxK8EcSyfMada84vppKmQsKvluxh4q2OCP/hvK/f3rDMBhInK0dlQ3g==
Received: from MN2PR06CA0029.namprd06.prod.outlook.com (2603:10b6:208:23d::34)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 05:03:55 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:23d:cafe::18) by MN2PR06CA0029.outlook.office365.com
 (2603:10b6:208:23d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 05:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 27 Feb 2026 05:03:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 21:03:15 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 21:03:14 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>
CC: <shinichiro.kawasaki@wdc.com>, <linux-block@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] blktrace: fix __this_cpu_read/write in preemptible context
Date: Thu, 26 Feb 2026 21:03:03 -0800
Message-ID: <20260227050303.10945-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcba420-09d6-474c-25db-08de75bd9b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	LVix4cwKB98taNhbzbhYLP6Ejzq47TnCysbP97T0jiFUzXtiX3CpIlTU03UM2nwV8fHzDGk0C3G3Y9jHKuc73uUqcXGOe6XltlAZDJYvIR79hMmcI4mocjj8KVrNFK1Zd9t9AKK3nrr8v20rSp+op7e/Nzwu5QduZlYvSbfdz+phSrh0DNOh6G6t9mTcUYmt1XHaJSclpIHGd7PyzmuUam43GMhYlLgtNZarkX/YEOiAog9xLAeak9evYArt76tRvF93EcSfL65GnaM4FtQFj6c2IjskKAtOQsBTiJbuyFpzti7mHdLpIdF77slJGRXIbremw33GTv6tmZSepwkyjdKyngNu2IJsbxApg87gaxJPAwL4kHym7FIa6zc5PKZCxCHtxC5CaCXQK2d41XU+hyfhA0oUucHDqHbQ1jPvWVQ4pgEHRlbl+H835k58GuFJjidzx4IyL8LFKEuyudJN+5i6CCWvR0XCuqc8/SXXpyMAvTLdDArfuuMt6WlbHOGXCENAw8lu7uw+Hu5UG4N1f5dgcknIyMO3fZBBrfAv2Rbp312/8x6E7hPCGvvIUxrStccNe8KqMJYdrNzQdvz2aB1tlmVmsDqEuWFVhMa0DgbQ4PJ0MeO6CyGQLnq1rVdnrdw5zB5QBxhCnUAb3y+4aQ5qKqfEakH3gFdat8YBI17BhvS+nNH46ENZkL0gcOxwV1fh69byqOSWfkRaK51kYSnMJklgeREB6XHmc1P9kcf4lABYpPUKPFC0s2wD7DyYNn+4SO+1fBpWgOc2pz+ifh46nr291Z3DW/pase48JiWu6qjl5cHA43jOaxwoaWkrLEA7Ms8sl/3NwKNzNIcScg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Ap5KSyMyuvDjyXen/q0SiBJBZDGs6r05vwyecE0y57f4uHcQls0f8uAuHhLWKyNwB8Q5weNnYdvJCTbk2xgg2audWtVRSiqRzVFoLKuss1QdW9KV0XENvdTziguTvjnNXroji7ee2MPr/4t8eGsH5aoQghu7vXcbRLh7HYKegQY6uoXM2rojEESvLdhRanAwQglUSiFTKZ+IZK0foVDFsXLMWhFDJKe3O3Y1o2/bM6PBmUB5XhUzAZRtUMs5CFPYyZvpUMf5rFonj+Q/Md+q0urCRDmezFtCJkg6UHcqEAnC2dLUL6lSraS6xdyRLPYyuMqLvvTZmZDMW6LK5odMr8fO3+3fWIaUUVRHMp3ETYWZvcvDrIwKtRAONrQS7qAPx/k/PwU7LPoGfhzhm8UHcD8POyjpCtqOKbQB0uaq8wUIHtEGkN9Z7a5LnXYg7vj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 05:03:54.8280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcba420-09d6-474c-25db-08de75bd9b6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783

tracing_record_cmdline() internally uses __this_cpu_read() and
__this_cpu_write() on the per-CPU variable trace_taskinfo_save, and
trace_save_cmdline() explicitly asserts preemption is disabled via
lockdep_assert_preemption_disabled().  These operations are safe only
when preemption is off, as they were designed to be called from the
scheduler's context probe_wakeup_sched_switch() / probe_wakeup().

__blk_add_trace() calls tracing_record_cmdline(current) from process
context where preemption is fully enabled, triggering the following
splat on using blktests/blktrace/002:

blktrace/002 (blktrace ftrace corruption with sysfs trace)   [failed]
    runtime  0.367s  ...  0.437s
    something found in dmesg:
    [   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
    [   81.239580] null_blk: disk nullb1 created
    [   81.357294] BUG: using __this_cpu_read() in preemptible [00000000] code: dd/2516
    [   81.362842] caller is tracing_record_cmdline+0x10/0x40
    [   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G                 N  7.0.0-rc1lblk+ #84 PREEMPT(full)
    [   81.362877] Tainted: [N]=TEST
    [   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
    [   81.362881] Call Trace:
    [   81.362884]  <TASK>
    [   81.362886]  dump_stack_lvl+0x8d/0xb0
    ...
    (See '/mnt/sda/blktests/results/nodev/blktrace/002.dmesg' for the entire message)

[   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
[   81.239580] null_blk: disk nullb1 created
[   81.357294] BUG: using __this_cpu_read() in preemptible [00000000] code: dd/2516
[   81.362842] caller is tracing_record_cmdline+0x10/0x40
[   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G                 N  7.0.0-rc1lblk+ #84 PREEMPT(full)
[   81.362877] Tainted: [N]=TEST
[   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   81.362881] Call Trace:
[   81.362884]  <TASK>
[   81.362886]  dump_stack_lvl+0x8d/0xb0
[   81.362895]  check_preemption_disabled+0xce/0xe0
[   81.362902]  tracing_record_cmdline+0x10/0x40
[   81.362923]  __blk_add_trace+0x307/0x5d0
[   81.362934]  ? lock_acquire+0xe0/0x300
[   81.362940]  ? iov_iter_extract_pages+0x101/0xa30
[   81.362959]  blk_add_trace_bio+0x106/0x1e0
[   81.362968]  submit_bio_noacct_nocheck+0x24b/0x3a0
[   81.362979]  ? lockdep_init_map_type+0x58/0x260
[   81.362988]  submit_bio_wait+0x56/0x90
[   81.363009]  __blkdev_direct_IO_simple+0x16c/0x250
[   81.363026]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[   81.363038]  ? rcu_read_lock_any_held+0x73/0xa0
[   81.363051]  blkdev_read_iter+0xc1/0x140
[   81.363059]  vfs_read+0x20b/0x330
[   81.363083]  ksys_read+0x67/0xe0
[   81.363090]  do_syscall_64+0xbf/0xf00
[   81.363102]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.363106] RIP: 0033:0x7f281906029d
[   81.363111] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 63 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 33 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
[   81.363113] RSP: 002b:00007ffca127dd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   81.363120] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f281906029d
[   81.363122] RDX: 0000000000001000 RSI: 0000559f8bfae000 RDI: 0000000000000000
[   81.363123] RBP: 0000000000001000 R08: 0000002863a10a81 R09: 00007f281915f000
[   81.363124] R10: 00007f2818f77b60 R11: 0000000000000246 R12: 0000559f8bfae000
[   81.363126] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000a
[   81.363142]  </TASK>

The same BUG fires from blk_add_trace_plug(), blk_add_trace_unplug(),
and blk_add_trace_rq() paths as well.

Fix by wrapping the tracing_record_cmdline() call with
preempt_disable()/preempt_enable().  This is a best-effort "record
the comm string for this PID" operation and briefly disabling
preemption around it is both should be safe.

With this patch now blktests for blktrace pass :-

blktests (master) # ./check blktrace
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  3.652s  ...  3.649s
blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
    runtime  0.437s  ...  0.389s
blktests (master) #

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 kernel/trace/blktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3b7c102a6eb3..488552036583 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -383,7 +383,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	cpu = raw_smp_processor_id();
 
 	if (blk_tracer) {
+		preempt_disable_notrace();
 		tracing_record_cmdline(current);
+		preempt_enable_notrace();
 
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
-- 
2.39.5

