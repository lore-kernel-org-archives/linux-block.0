Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641269;
	b=hE0PWvsvljIMga7t3YQ4+Vl9nFHbzqwNITufueebP7TYZC5Q0sN5GcY6PPppKxoWxXHl
	 qhJ8bHXde8te6JOf0HYv4IfHL6UhrX6O9whPz50RW3mLprBevn7YW3LYNm2Pa76UCfNDo
	 g44pLhhQn0Vdn8H+lrbBoaaiHY2zf9UuDT2AIE+FrfikMZWqxXzwd9hP+fDAR6Ba2i/r4
	 mwA3FLMi0Ncsk03rFHQVrub1uQjcKRXNDLo8Kmx+eKSxrK+45THj//sSNBvcTT3rXhYWB
	 /bSsIhmEbetMhcnpViyOT5XN4DNuDVOWRveBo9p6BSORviGKmulUkE0vvyqOhuVjZzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641269;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lcVJL0pqCYPSdZWIDSO5fs/v8yycoBdGqp1BBSqYt2c=;
	b=SNG+mzfG++rwmMtVskXBkzhu9693d1ooArt9H/GTdo0YRVEdU4xqtC6zChZB74tKM+O9
	 moHsZWHQNY0efOTBXWarh6k1Wp904FUKZc1miiIL8dMN8uNQKyFPajlOpS9gRVhWc+C6f
	 5u6US5qLyXWWEcFjFVe9SoXTvN81Ji2sVSMqRbEnudMCNUd2lWOtgeBn4jhoMT0MLVtGW
	 mRuiXhIXrMI9I4kcl4hvXIVj1A5ufNYcBwInbIY6uSiK23eKRfLxD3+W+1ciS4fZZBLsH
	 rZqsowLCbihq70sg/dkE7a07zCVX7W7sDIGtT/s29bEWH8MTcEoRYEp2IRyyUsgOO3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.125
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021125.outbound.protection.outlook.com [52.101.100.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44467606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 03:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44467606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cj0ElfrJ4dNy7toEJ8rSYlrugyUm+OSC+/QFzud0nXsF5pTcrBwi4J9mB/bMRml1dvQX/jIEnrQ9oxZQtPI1+I4zKj3XqCVfjNo0Vdx7BPmQnnAGBgZPHO5mJSr5pc38CEemrmyujx4NCiUAUh8EIno0fcGOLIqfZ1+eHvtZARBHieC9+JJPvWKGMsTCkrEuuFos8hPbJSVnrkWK70yXIncJEygek2KPgzzUMkRRnqcZZxIAqtHf8g0TgW5NjYm623iSuH/WQfFAmGpEWlavfz2gpj33Lh4zpwCRFMAtXKBvkJJSixFiQvS3gH6tgf6myQeIjD0n8RyPWcj/ZVwP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=lcVJL0pqCYPSdZWIDSO5fs/v8yycoBdGqp1BBSqYt2c=;
 b=HsxF1hV/8Q18c7VxaZwxDrBO/2jso48KxGiY7IJcC9yswg7HNDj7WTdGO28hiMkaaomSDk3BqQ9ThWDcMs5dIfLaY/2zwdktWQIjmvE6wfav/YrZvf4fDmoSV4hCm1ka0xGUqb38he62Ypk+zflItiowAENwRQdmKE4Vnh/wparbV0E6KKC8s6bsutHL8k3JvsytyDjlDBk6ne5QrmrLBDVynAvp6apKuX5QdVV64Qb0OpreUqImfFsxBrTjVz/BGbJY76dfVJRhnq+EZ5AQDtSRhVU3CJRco7N8IIKQOANjY7OExcOyJAeJhEFyQz0z45MZfgzVITETCvNWbF6R8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LNXP123MB3723.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:54:26 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 03:54:25 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: shinichiro.kawasaki@wdc.com
Cc: wagi@kernel.org,
	axboe@kernel.dk,
	atomlin@atomlin.com,
	sean@ashe.io,
	linux-block@vger.kernel.org
Subject: [PATCH] block/050: test deferred blk-mq queue work placement with isolated CPUs
Date: Wed, 21 Oct 2026 23:54:21 -0400
Message-ID: <20261022035421.48421-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LNXP123MB3723:EE_
X-MS-Office365-Filtering-Correlation-Id: 529e188a-3f89-46ba-d186-08df2ff02a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|261021123027099003|56012099006|261009223027099003|10067099003|18002099003|6133799003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	5hEwYUcqV+E60+W38KRvWmnleZ6f/tq+3PuNnVHN6O8jovHA+ouhbjTUQ7sH4LaTY3nE9eMWmQOxBI/VzjFQqg6I9W+tz7DJqxR02Dvb1OvqxQ6dvpRweOjAayu9nnKDsuH078qCFRViZ4UjTbAPorfFFFw+tEUyVZF1io4nFlqlyI8oTXieIZg4SXj475Fu/+omnmtlMxKUVGWPtFzUijjXoPcsVUqY7+78RoMJJFtrOQImxrc50+Zd5BEF/pXS/XHaqo6zTIelg0U2PI2+urXmi9UueL5IXu91X3WrJLjzjePA25p/VlmihY30UacS4P6YRw9UpxgdNgfsi5cr3rlfnQbyC0tFdArDu5EIOh/XtpEWRgcAeoEbUtvjwHlrev1HHhLc2cL/wONzTxC4rKeNtxaq0xtF+2wsog72Hsv8qk7YfUIvBCudChikCa8I9qDanyUlH4hTqYLRu58aCzfunQ4pMoKNb77P9vKOODEcNpITYW1wJdkulQNbpZXZCsOfWTd43rg+sguWNfxfWcse+i6g2xqhl8iM3EsWUwIj6hQdC298OLyJUro8gKOKiJCK1SD1n7h/74JgR3BrOcogRulEUkf9CPmSrJWmQA5s2+ruB4Zyy/gVzuf+yuXX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261021123027099003)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dMp6jPm9busALjqsl9v85rWseQp9ZRCdDY7uBX0bZEsd2FQjdo96DJetEZR5?=
 =?us-ascii?Q?fH24ljRNs7KVJAPVvLEOVHYl7dTluAQLM+2LDsrwK5A9Fx+d7Mp6qH/KOpHo?=
 =?us-ascii?Q?3ub92vjdaiGIhv+voHhmLu8QbAA+6h3hb4BDnGjH0WsIszPz7ebCHp684cO5?=
 =?us-ascii?Q?tl1TwLrI//2Jx6OztzU8lhJfNlB7LiIm39gmmUceGaejB+xLIKgEWs/Kplgi?=
 =?us-ascii?Q?xR2E0QxsqIixVH6JJ8JV8sJtbCPouz2FM9vi5Ag2JeiBpvmNKUdtoFGVKJ1d?=
 =?us-ascii?Q?sFgXIkXkCN/dMZKBvngKf6V73YSkBuO57eawjAZ187ViFEq/yFvwvmHZAuNf?=
 =?us-ascii?Q?Pf2fTyfZYXUIvinEUDRpCCXqeZgnmVJjGUdyqkLX/vMhcKyHnSZNxHiUnzYO?=
 =?us-ascii?Q?UwEkWOAx1tTFIOHM1ednpkJ+BZ1BfSbq3ObYui+ZRP6ElNUL166/QddUItFM?=
 =?us-ascii?Q?4POMK0Z9k3qhXDTd0Aq2yN+8BBzxKTpRZJS7y25enWWxtRrtckuWayk4ggMU?=
 =?us-ascii?Q?l9Y0MySs7m7qt0llRF5GEncGJ8PLCJNykGYtQeIuRclK7CbupVQzMdnKHRay?=
 =?us-ascii?Q?R120DOwxLBQ4r6sb/2knVzPN3yBoUgijU4ldt4fhi/RBi9xqmPm0xAi/RCCO?=
 =?us-ascii?Q?hL+kHKN5hiG3YOlznGAOEJBuEqiPxGXrlFRAeQzmjL0gyYvG1uuwlIo8qQ9s?=
 =?us-ascii?Q?seYdtLkjD4Jk8SWXJsgvhinvWwUzJJpTrycKdySMliGzv01pgqJb+kaGrY4u?=
 =?us-ascii?Q?yg8MGRbMZBUSM2Sj20sQ/diKqPT+rGuWD7bq89j7KwG4kVaz+S7dTPQt0co0?=
 =?us-ascii?Q?aL6khw1eU+zwM/YactIqQ4IxvYJNkhcjt+kGKxZTX6OYW1xynKF9cPUNHIhr?=
 =?us-ascii?Q?hBorpMlQNjWyj5NXCfVRPDOu4KT4kffa+0/0QNySRzD5i0ro4V8POhAo8X6c?=
 =?us-ascii?Q?tf8kjfyYdm/vhP0N744uBQmjpqiJqc1hgSsKMLMlCJ7/V5HP8lufDuWLvvu3?=
 =?us-ascii?Q?g+z7jNxUHwT/ie0gd3A8ZR2iZSZLghIfWWLsdfd1/8tPpaMTMlHZgdNbrXmq?=
 =?us-ascii?Q?yqiSYnohJ4QbMsZZZ6UnYcRCyl68xrBk4mxvr3XKSOsfnQAdOw2Ls23MLxJM?=
 =?us-ascii?Q?zrX+Lm7Wy07ClxgPF2CW6ePcKTl0V1Ggd8AGfyV1GFwS9St3KSVQ0GAJELel?=
 =?us-ascii?Q?/j6XGDQVeeUxCsFZs9J7rzoCDXtPbpn6p19aCqQinUz7Elo4EqfNr0F8/2kE?=
 =?us-ascii?Q?xnvGL5IPVR5sZH/oFejDeqCC34Pxe2hgMwQz4SpXLXMOTHMpwdzDMgXqdicr?=
 =?us-ascii?Q?SflSl4Uspdcwq4mVFr1mruEuOjT8iySlmCOlGqEexVj1OsN66w2UMf1ZJ6Hj?=
 =?us-ascii?Q?/MXg6Js0HNSvCVTFKuutRyefwD6fEJAkFti7agoTmAdt6+OefHE9b4S1sIdv?=
 =?us-ascii?Q?0caFS5+AVeuKUf4ALP6NmStVYsW8OiiXbeKHelQQAmRMM3gs8n5JxGCLgTt+?=
 =?us-ascii?Q?P7UQ7kvleRYjvwfariOTjipYTmGuGAYNZ4B5ZG5X7IPXGjMdJVp+sFoHP8xe?=
 =?us-ascii?Q?08nYK+hbFy3s4JpvjeB9ikR7Q8+8+LaM4czARhY8MGNDf0lu+4TDxm2P/VOs?=
 =?us-ascii?Q?gYCl1z2pEDcoblVL9SfR7RumZ7Jy9dVSW2RShgyY6CVpR8DH91hEtWivCQw+?=
 =?us-ascii?Q?KI+/WV58WGh/SeFUnExnphT2nDhrqERBtD8jEVeYiRkScA3y0A2QUFxz9crG?=
 =?us-ascii?Q?Ebxhq6clwg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529e188a-3f89-46ba-d186-08df2ff02a39
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 03:54:25.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dI/Q+AVLm88C1Jo2pa6GSC1h2AxLia0J94BAUdGLjNcaUV/I8gmAVdxd9F+mTJWvNHhEJAcWJtMygUlhLByAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP123MB3723

Add a test case to verify that deferred blk-mq queue dispatch
(&hctx->run_work) is steered to an online housekeeping CPU rather than
executing on an isolated CPU.

When asynchronous queue dispatch is scheduled (e.g. using an I/O
scheduler like mq-deadline or upon hardware queue backpressure), blk-mq
queues &hctx->run_work onto kblockd_workqueue. For single-queue devices
or multi-queue devices where all CPUs mapped to a hardware queue are
isolated, blk-mq falls back to unbound queue placement.

However, because kblockd_workqueue is allocated as a per-CPU workqueue
(WQ_PERCPU), unbound queue requests issued from an isolated core can
resolve to raw_smp_processor_id() and execute on the local worker pool.
In real-time and low-latency environments, running block kworkers on
isolated CPUs introduces unwanted latency jitter and risks stalling
queue dispatch if higher-priority SCHED_FIFO tasks preempt the worker.
Deferred dispatch must instead be directed to an online housekeeping
CPU.

This test:
    1.  Isolates an online CPU using a cgroup v2 isolated partition
        (cpuset.cpus.partition = isolated).

    2.  Tests both single-queue (submit_queues=1) and multi-queue
        (submit_queues=$(nproc)) null_blk configurations with the
        mq-deadline I/O scheduler.

    3.  Creates an isolated tracefs instance to monitor the
        workqueue_execute_start tracepoint filtered on
        blk_mq_run_work_fn.

    4.  Submits concurrent I/O from a workload confined to the isolated
        CPU.

    5.  Verifies that deferred queue executions occurred and that zero
        kblockd worker executions ran on the isolated CPU.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Tests the fix proposed in: https://lore.kernel.org/lkml/20261022034737.47820-1-atomlin@atomlin.com/
---
 tests/block/050     | 191 ++++++++++++++++++++++++++++++++++++++++++++
 tests/block/050.out |   2 +
 2 files changed, 193 insertions(+)
 create mode 100755 tests/block/050
 create mode 100644 tests/block/050.out

diff --git a/tests/block/050 b/tests/block/050
new file mode 100755
index 0000000..3283a04
--- /dev/null
+++ b/tests/block/050
@@ -0,0 +1,191 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 Aaron Tomlin <atomlin@atomlin.com>
+#
+# Test that deferred blk-mq queue dispatch (&hctx->run_work) is not executed
+# by kblockd workers on isolated CPUs.
+#
+# When a hardware queue experiences backpressure or resource starvation (e.g.
+# upon tag exhaustion), blk_mq_delay_run_hw_queue() schedules deferred queue
+# dispatch. When I/O is submitted from an isolated CPU, blk_mq_hctx_next_cpu()
+# must steer &hctx->run_work to an online housekeeping CPU rather than running
+# on the local isolated CPU's worker pool, avoiding SCHED_FIFO worker
+# starvation and latency jitter.
+
+. tests/block/rc
+. common/cgroup
+. common/null_blk
+. common/fio
+
+DESCRIPTION="test deferred blk-mq queue work placement with isolated CPUs"
+QUICK=1
+
+requires() {
+	_have_root
+	_have_null_blk
+	_have_fio
+	_require_min_cpus 2
+	_have_cgroup2_controller_file cpuset cpuset.cpus.partition
+	_have_tracefs
+	_have_tracepoint "workqueue/workqueue_execute_start"
+	modprobe -q mq-deadline 2>/dev/null || true
+}
+
+isolate_cpu() {
+	local cpu="$1"
+	local partition
+
+	_init_cgroup2 || return 1
+	_set_attr "+cpuset" "$(_cgroup2_base_dir)/cgroup.subtree_control"
+	_set_attr "${cpu}" "${CGROUP2_DIR}/cpuset.cpus"
+	_set_attr "isolated" "${CGROUP2_DIR}/cpuset.cpus.partition"
+
+	partition=$(cat "${CGROUP2_DIR}/cpuset.cpus.partition")
+	if [[ "${partition}" != "isolated" ]]; then
+		SKIP_REASONS+=("failed to isolate CPU ${cpu}: ${partition}")
+		_exit_cgroup2
+		return 1
+	fi
+
+	return 0
+}
+
+start_trace() {
+	local trace_dir="$1"
+	local event="${trace_dir}/events/workqueue/workqueue_execute_start"
+
+	_set_attr "" "${trace_dir}/trace"
+	_set_attr "function.function == blk_mq_run_work_fn" "${event}/filter" 2>/dev/null || true
+	_set_attr 1 "${event}/enable"
+}
+
+stop_trace() {
+	local trace_dir="$1"
+	local isolated_cpu="$2"
+
+	_set_attr 0 "${trace_dir}/events/workqueue/workqueue_execute_start/enable"
+
+	local isol_hits=0
+	if [[ -f "${trace_dir}/per_cpu/cpu${isolated_cpu}/trace" ]]; then
+		isol_hits=$(grep -c "blk_mq_run_work_fn" \
+			"${trace_dir}/per_cpu/cpu${isolated_cpu}/trace" 2>/dev/null || true)
+	fi
+
+	local total_hits=0
+	total_hits=$(grep -c "blk_mq_run_work_fn" \
+		"${trace_dir}/trace" 2>/dev/null || true)
+
+	echo "${isol_hits}:${total_hits}"
+}
+
+run_io() {
+	local dev="$1"
+	local cpu="$2"
+
+	(
+		local allowed
+		_set_attr "${BASHPID}" "${CGROUP2_DIR}/cgroup.procs"
+		allowed=$(awk '/^Cpus_allowed_list:/ { print $2 }' "/proc/${BASHPID}/status")
+		if [[ "${allowed}" != "${cpu}" ]]; then
+			echo "FAIL: workload not confined to isolated CPU ${cpu} (runs on ${allowed})"
+			exit 1
+		fi
+
+		# Submit concurrent I/O with iodepth > hw_queue_depth to induce tag
+		# exhaustion and force asynchronous queue dispatch (&hctx->run_work)
+		_run_fio --name=tag_exhaustion \
+			--filename="/dev/${dev}" \
+			--ioengine=psync \
+			--rw=randwrite \
+			--direct=1 \
+			--bs=4k \
+			--size=64k \
+			--numjobs=4 \
+			--iodepth=8 \
+			>>"${FULL}" 2>&1
+	)
+}
+
+test_workqueue_placement() {
+	local dev="$1"
+	local cpu="$2"
+	local test_desc="$3"
+	local trace_dir="$4"
+
+	if ! _write_queue_sched "mq-deadline" "/sys/block/${dev}/queue/scheduler"; then
+		echo "FAIL: ${test_desc}: failed to set mq-deadline scheduler"
+		return 1
+	fi
+
+	start_trace "${trace_dir}"
+	run_io "${dev}" "${cpu}" || echo "FAIL: ${test_desc}: I/O execution failed"
+	udevadm settle
+
+	local res
+	res=$(stop_trace "${trace_dir}" "${cpu}")
+	local isol_hits="${res%%:*}"
+	local total_hits="${res##*:}"
+
+	if [[ -n "${FULL}" ]]; then
+		echo "${test_desc}: isol_hits=${isol_hits} total_hits=${total_hits}" >>"${FULL}"
+	fi
+
+	if [[ "${isol_hits}" -gt 0 ]]; then
+		echo "FAIL: ${test_desc}: ${isol_hits} blk_mq_run_work_fn worker runs on isolated CPU ${cpu}"
+	fi
+
+	if [[ "${total_hits}" -eq 0 ]]; then
+		echo "FAIL: ${test_desc}: no deferred queue executions observed"
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local cpu
+	local nr_cpus
+	local trace_dir="/sys/kernel/debug/tracing/instances/blktests-${TEST_NAME//\//-}"
+
+	nr_cpus=$(nproc)
+	cpu=$(awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/online)
+	if ! isolate_cpu "${cpu}"; then
+		return 1
+	fi
+
+	mkdir "${trace_dir}" || return 1
+
+	# Test 1: Single-queue device (nr_hw_queues == 1)
+	local nullb_sq_params=(
+		submit_queues=1
+		hw_queue_depth=1
+		irqmode=2
+		completion_nsec=10000000
+		power=1
+	)
+	if _configure_null_blk nullb1 "${nullb_sq_params[@]}"; then
+		test_workqueue_placement nullb1 "${cpu}" "single-queue" "${trace_dir}"
+	else
+		echo "FAIL: failed to configure single-queue null_blk"
+	fi
+	_exit_null_blk
+
+	# Test 2: Multi-queue device where isolated CPU maps to empty hctx
+	local nullb_mq_params=(
+		submit_queues="${nr_cpus}"
+		hw_queue_depth=1
+		irqmode=2
+		completion_nsec=10000000
+		power=1
+	)
+	if _configure_null_blk nullb1 "${nullb_mq_params[@]}"; then
+		test_workqueue_placement nullb1 "${cpu}" "multi-queue empty hctx" "${trace_dir}"
+	else
+		echo "FAIL: failed to configure multi-queue null_blk"
+	fi
+	_exit_null_blk
+
+	rmdir "${trace_dir}"
+	_exit_cgroup2
+
+	echo "Test complete"
+}
diff --git a/tests/block/050.out b/tests/block/050.out
new file mode 100644
index 0000000..fc4e537
--- /dev/null
+++ b/tests/block/050.out
@@ -0,0 +1,2 @@
+Running block/050
+Test complete
-- 
2.55.0

