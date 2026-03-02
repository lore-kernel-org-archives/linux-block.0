Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CE430B85;
	Mon,  2 Mar 2026 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772410955; cv=fail; b=UD/l/yNWbEisl1qrz09PEAxCVNM9/EjbSxtn13JL3mnt2jg/MR2WgXuiXiZvn5/P+rKkr7X5WXdh/xTVdtRdEsW/+8b9gzhWpwp9+3bIFYddjf1xPnv4E9aTABQo47rDvrBwYXh2vM59nQvRQ23TwRacmy/Bf82gHnS8DbROY7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772410955; c=relaxed/simple;
	bh=3tkq0dvtYacqOktXDK+sJ37izSWKyHWjchKxn9PefCQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DusFlprXvZzhnDOkxDMFXUuk/rTMRKbkmH2inAWc3HKpuUezFVwwinoqsST1jGoV8KXsuVBFmExaxQGUJ+tIeb3OEKGqgtmTOX/NI+czfd92M55cugwPNz6gM7WiqgOHGYIn7tbLMvo9uBUA2M76hdp8y4r3QHHMy6AvlHsqTiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oERD3D6Q; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oERD3D6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u80WAO+TseLuveyAETHvb6Me/gKXSeEi0dQ7+RTzPkr1CwGVPCrG9RH8xug8xfnfsHxqPhk9CPEtx0LeZmBvZHToCssUYiUrZ5lerP2fN6j5wLh74Ogwozznhi4LpMjZD9PELXdYJkPBG4/LQKKBTPhIdaChsFzZERGdVgaPm0b+deFILH6maXuk+P3eCljt0tkmndGi0bZ/c38nZahKiZo/B8HwaZVCS3UnGtJyKcEaDG34fcDmqKJIQOjsHG5p7ZxiOvFUMCeWrR1qYtq0dujktnpy84VzIl65EhtHTnovh8I5WW/ChN/LclITC3+BEHqPdaTZtSeeuq4fEy39kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY991wE8LibZu/ZtTLsnt+XmIPxjmbnxYbEYw1It0KY=;
 b=GCkBHXKaV3Z8KK2RY9xSt8tZOxfW+sRyXgMtdeKhgoZ1dK+3Qq1ViAl6mboSQkGDSQEox86exe8tg6GZt+yctWiW4vPX0FMwX3OnAMHD9levV7Rq+rUlte82d3ec7aZtxeNOFUlCmma5bzveVNsps7hgNrMHdq34nuQIDbtN2wl0BW9uvarvYezXGtqbC0fOocm1nB4QI6ECIh3S4IAyzDmufvy9+DgZmo2s5K9PjgOZG0OTzmRTwiv5Q13i3pq8IImu3C8tlCFINlppec4Bj4zV8vZderRWY/YwBrYgERsqWKrEPwAuXrVRvoVN6ojn+dLUcHK22qsBRYiDZqHYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY991wE8LibZu/ZtTLsnt+XmIPxjmbnxYbEYw1It0KY=;
 b=oERD3D6QQccipG5QeQXsecUGL+bOo2iKYYvHVfdAQ9J4PdS6Jf95yGVoyBz4eTabOI/594yJehYTccvEMjbtLO75bd7k7MQucvKY1udyPG6h8zR8gQQSm9R1lzGjdHcej4qasfUfFojXdRZ84Ynp3zlmKWLKGsrwu2bAxP8bFHVr4vm17k0eEU5fCi2NQtnD1EG0fsan7WAwPCkkMlIFXuifiXFFi4uuvZ2FKj4xRMhIGyK2HCxhMhx6zgT9enKFWDLmM/tnNnQwgEjEWiH+1yEIHUBpj+JtHGXBFv36OQUIWaPUBVrOJ8/gN6rWwiyBhd0S8qxqyivGtx/jzChOvQ==
Received: from BN9PR03CA0800.namprd03.prod.outlook.com (2603:10b6:408:13f::25)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 00:22:29 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::17) by BN9PR03CA0800.outlook.office365.com
 (2603:10b6:408:13f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 00:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 00:22:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Mar
 2026 16:22:14 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Mar
 2026 16:22:14 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>
CC: <shinichiro.kawasaki@wdc.com>, <linux-block@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible context
Date: Sun, 1 Mar 2026 16:22:07 -0800
Message-ID: <20260302002207.12165-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: f57d554d-7808-4161-65af-08de77f1ca0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	Zhjv7/r9C0jshz3Fl2p2A0iwOAxHI6pe9xoYSj6Ey6PohvnNm+I0pdD79pPFH9WvMvPxAgj0IAyyqSwCsw2UTvK/5PTEQpEWoQI5JjepaYFKceLN54qkIDbcC2XPrxlqs9V7ykAlgXetYj+vLqsgtGhSFi4EszRZXY4qdc2VzJskt6JAdEUrMm2d9fF1jHyMq60X7XOiRVRCNdbbJnaSIW+yIL8HKMgYdNhE4APmnBlNUfnXvbwnTz/U/A3NC/sNTFDO7FUxhRqgCbO0lGs10pLL1fP86U56sSmKEJqgXDskn7D4eOtGVXJmtlMeZ2b5JiaARp62EA3bgR6PEuoh0SjTcaESVxa4JSy+Ypk5lhcAoyhgJYkbvB7cmFwgtjFUDJc0CI9CNAFxcYJUgjoGCrrE07o81CXe1G6hZjBeecLjrsP/WdQ2CfF3bQ/lwT+ORWOADu6cYlRGFRGeF/cLk6qj+Cu/bz+7hTa0WRsMLbWNPrv738JC+hM4q05Fxru2yoMaf6hVW0g0hQI2RZhlngH5bXoDj/NoVA9WG4v6XERO6PQZaAvEOotTJ2OvO48yd1O/DqgdWiZiSeYyVO4/zTGpuJM3NZ7nHMJoBTJY+P3uGzDNKCy8tAkMdJewVckOIjcfL05pN91sozCKdb0wG3V007oYN1/nFvWi5PZTAhfWQFuM09H0N/yyD8S6dnbW7IoXzusI4Jcgn5LE7nCMYfCxXb0N+s3FvzO4lWOENVyf/WHqoBDsHARbDy5En9bZVaUhs5SboI6GeuM4dZtBA+gd8o28widwgPtGa4i+P7D2RkqZlzR8lZZeZfn40OTUjARFddxcJs/S3JijdyDzdA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xr/6vz3oj8qkDtDffOz3Oslt17cxpHZS1NVJvKjAipOJHgE3dyS2gJoc8Cj6ZskiIMcE9k/XIaF9P6bz9XfNTLROg8a7JEMlCzNMvfbnmFyRATCvjKTi5PaKweXYxfOnOzSdrO7Pyzz9mfldxrBNaGoozVJX1NoNeBjZvtbywBWdz2etkTSexPA8zaVNjRnWQX8Zt/KiEtAgEOwVUTQdCbC9Rs/4ciHuSYuAhdnD26sqINbzg9aycdQNM7fOSBo85EzrcMbhC1IDfiUHXoRsJf55kboyHMmKOeVSP1ss6lMENECIu4MwWMVk+d65RE5BKEjWr6uVHlf7CllSWbEOHfTwDnOqXlwkA5LN5+khBBOTBSwuwrkVgCsXwbp1lRdRAQGxDYfbstHlEhBH0bD0kZsAwBtMZr9BWJgN+87ijRr3jUZdgM83BIJYEn/x2GbC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 00:22:29.1854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57d554d-7808-4161-65af-08de77f1ca0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790

tracing_record_cmdline() internally uses __this_cpu_read() and
__this_cpu_write() on the per-CPU variable trace_cmdline_save, and
trace_save_cmdline() explicitly asserts preemption is disabled via
lockdep_assert_preemption_disabled(). These operations are only safe
when preemption is off, as they were designed to be called from the
scheduler context (probe_wakeup_sched_switch() / probe_wakeup()).

__blk_add_trace() was calling tracing_record_cmdline(current) early in
the blk_tracer path, before ring buffer reservation, from process
context where preemption is fully enabled. This triggers the following
using blktests/blktrace/002:

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

The purpose of tracing_record_cmdline() is to cache the task->comm for
a given PID so that the trace can later resolve it. It is only
meaningful when a trace event is actually being recorded. Ring buffer
reservation via ring_buffer_lock_reserve() disables preemption, and
preemption remains disabled until the event is committed :-

__blk_add_trace()
       	__trace_buffer_lock_reserve()
       		__trace_buffer_lock_reserve()
       			ring_buffer_lock_reserve()
       				preempt_disable_notrace();  <---

With this fix blktests for blktrace pass:

  blktests (master) # ./check blktrace
  blktrace/001 (blktrace zone management command tracing)      [passed]
      runtime  3.650s  ...  3.647s
  blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
      runtime  0.411s  ...  0.384s

Fixes: 7ffbd48d5cab ("tracing: Cache comms only after an event occurred")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v2:-

1. Remove preempt_disable_notrace() and preempt_enable_notrace() calls from V1.
   Fix the issue by moving a call to tracing_record_cmdline() after ring
   buffer reservation which also disables the preemption.

---
 kernel/trace/blktrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3b7c102a6eb3..ead03e0e0fbe 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -383,8 +383,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	cpu = raw_smp_processor_id();
 
 	if (blk_tracer) {
-		tracing_record_cmdline(current);
-
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
 		switch (bt->version) {
@@ -419,6 +417,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		if (!event)
 			return;
 
+		tracing_record_cmdline(current);
 		switch (bt->version) {
 		case 1:
 			record_blktrace_event(ring_buffer_event_data(event),
-- 
2.39.5

