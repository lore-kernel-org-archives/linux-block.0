Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF19C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F9724676
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 07:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdcqvUNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLRHUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:20:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbfLRHUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 02:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576653616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVmb7Dh+DdWajmPZmt9mRCtxtfm5zs0OAIIoTm/348w=;
        b=AdcqvUNmNvGACDTzJNrCWJkjaivNeeoZnoF7E6i7T7snjWMSxr27rD+zyOYldG0/FIDYuk
        lihjIv1TpY9Ukbuivc7vCckk91IqkxhKAxf8OXuVcnrHjenDRcE3TcXWIs4/lbkfgXBQRO
        xL+PzE2JeQhkp+Su/VP4vi972U93ygY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-QGA8U42_OSOt0AuS6CH7aw-1; Wed, 18 Dec 2019 02:20:12 -0500
X-MC-Unique: QGA8U42_OSOt0AuS6CH7aw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8C6C189DF7D;
        Wed, 18 Dec 2019 07:20:10 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EAFB5D9E5;
        Wed, 18 Dec 2019 07:20:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Date:   Wed, 18 Dec 2019 15:19:41 +0800
Message-Id: <20191218071942.22336-3-ming.lei@redhat.com>
In-Reply-To: <20191218071942.22336-1-ming.lei@redhat.com>
References: <20191218071942.22336-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some high performance IO devices, interrupt may come very frequently,
meantime IO request is often completed in irq context for minimizing IO
latency. Especially on some devices(SCSI or NVMe), IO requests can be
submitted concurrently from multiple CPU cores, meantime these IO's
completion is only done on single CPU core. Either fast IO storage is
comming, or multiple storage devices attached to same HBA, or multiple
HBAs in same system, IOs from multiple storage devices may saturate one
single CPU core for hanlding these IO's interrups.

Interrupt flood can be triggered, and scheduler is stuck, then CPU lockup
is followed.

The interrupt flood infomation is very useful for the following use
cases:

1) avoid CPU soft lockup

After interrupt flood is detected, block layer may switch to complete IO
in process context, then CPU lockup can be avoided. And switch back to
interrupt context after interrupt flood is gone.

2) partition IO completion into interrupt and process contexts effectivel=
y

When handling IO completion in interrupt context, IO latency is good,
but there is risk to lock up CPU. When moving IO completion to process
context via NAPI or threaded interrupt handler, CPU lockup can be
avoided. So people try to move part of IO completion into process
context for avoiding CPU lockup, such as Keith's work:

https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.or=
g/T/#t

However, it is hard to partition IO completion in the two contexts, if
less work is moved to process context, risk of locking up CPU can't be
eliminated; if more work is moved to process context, extra IO latency is
introduced, then IO performance is hurt.

Interrupt flood information can be one useful hint for partitioning IO
completion work into the two contexts effectively.

Implement one simple and efficient CPU interrupt flood detection mechanis=
m.
This mechanism uses average interrupt interval on each CPU to evaluate if
interrupt flood is triggered. For saving cost of reading clock from hardw=
are,
applies two-stage detection:

- in the 1st stage, read clock from scheduler runqueue clock which is
software clock, and the cost is quite low

- after small enough interrupt interval is observed in the 1st stage, swi=
tch
to the 2nd stage detection given it is reasonable to assume that schedule=
r
has been stuck

- the 2nd stage is for confirming if interrupt flood really happens by us=
ing
hardware clock after scheduler is stuck

Cc: Long Li <longli@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: John Garry <john.garry@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/base/cpu.c      |  23 ++++++
 include/linux/hardirq.h |   2 +
 kernel/softirq.c        | 161 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6265871a4af2..34c253cde5f3 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
 #include <linux/sched/isolation.h>
+#include <linux/hardirq.h>
=20
 #include "base.h"
=20
@@ -183,10 +184,31 @@ static struct attribute_group crash_note_cpu_attr_g=
roup =3D {
 };
 #endif
=20
+static ssize_t show_irq_interval(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct cpu *cpu =3D container_of(dev, struct cpu, dev);
+	ssize_t rc;
+	u64 avg =3D irq_get_avg_interval(cpu->dev.id);
+
+	rc =3D sprintf(buf, "%d: %d\n",  (int)(avg & 1), (int)(avg >> 1));
+	return rc;
+}
+
+static DEVICE_ATTR(irq_interval, 0400, show_irq_interval, NULL);
+static struct attribute *irq_interval_cpu_attrs[] =3D {
+	&dev_attr_irq_interval.attr,
+	NULL
+};
+static struct attribute_group irq_interval_cpu_attr_group =3D {
+	.attrs =3D irq_interval_cpu_attrs,
+};
+
 static const struct attribute_group *common_cpu_attr_groups[] =3D {
 #ifdef CONFIG_KEXEC
 	&crash_note_cpu_attr_group,
 #endif
+	&irq_interval_cpu_attr_group,
 	NULL
 };
=20
@@ -194,6 +216,7 @@ static const struct attribute_group *hotplugable_cpu_=
attr_groups[] =3D {
 #ifdef CONFIG_KEXEC
 	&crash_note_cpu_attr_group,
 #endif
+	&irq_interval_cpu_attr_group,
 	NULL
 };
=20
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index da0af631ded5..a0db287bb574 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -8,6 +8,8 @@
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
=20
+extern u64 irq_get_avg_interval(int);
+extern bool irq_is_flood(void);
=20
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0427a86743a4..f6e434ac4183 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,8 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/sched/clock.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -52,6 +54,26 @@ DEFINE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 #endif
=20
+#define IRQ_INTERVAL_STAGE1_WEIGHT_BITS		ilog2(512)
+#define IRQ_INTERVAL_STAGE2_WEIGHT_BITS		ilog2(128)
+
+#define IRQ_INTERVAL_THRESHOLD_UNIT_NS	1000
+
+#define IRQ_INTERVAL_MIN_THRESHOLD_NS	IRQ_INTERVAL_THRESHOLD_UNIT_NS
+#define IRQ_INTERVAL_MAX_MIN_THRESHOLD_TIME_NS  4000000000
+
+struct irq_interval {
+	u64                     clock;
+	int			avg;
+	int			std_threshold:31;
+	int			stage:1;
+
+	u64			stage_start_clock;
+	unsigned		stage1_time;
+	unsigned		stage2_time;
+};
+DEFINE_PER_CPU(struct irq_interval, avg_irq_interval);
+
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligne=
d_in_smp;
=20
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
@@ -339,6 +361,140 @@ asmlinkage __visible void do_softirq(void)
 	local_irq_restore(flags);
 }
=20
+static inline void irq_interval_update_avg(struct irq_interval *inter,
+		u64 now, int weight_bits)
+{
+	inter->avg =3D inter->avg - ((inter->avg) >> weight_bits) +
+		((now - inter->clock) >> weight_bits);
+	if (unlikely(inter->avg < 0))
+		inter->avg =3D 0;
+}
+
+/*
+ * Keep the ratio of stage2 time to stage1 time between 1/2 and 1/8. If
+ * it is out of the range, adjust .std_threshold for maintaining the rat=
io.
+ */
+static inline void irq_interval_update_threshold(struct irq_interval *in=
ter)
+{
+	if (inter->stage2_time * 2 > inter->stage1_time)
+		inter->std_threshold -=3D IRQ_INTERVAL_THRESHOLD_UNIT_NS;
+	if (inter->stage2_time * 8 < inter->stage1_time)
+		inter->std_threshold +=3D IRQ_INTERVAL_THRESHOLD_UNIT_NS;
+
+	if (inter->std_threshold <=3D 0)
+		inter->std_threshold =3D IRQ_INTERVAL_THRESHOLD_UNIT_NS;
+
+	if (inter->std_threshold >=3D 32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS)
+		inter->std_threshold =3D 32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS;
+}
+
+/*
+ * If we stay at stage1 for too long with minimized threshold and low en=
ough
+ * interrupt average interval, there may have risk to lock up CPU.
+ */
+static bool irq_interval_cpu_lockup_risk(struct irq_interval *inter, u64=
 now)
+{
+	if (inter->avg > inter->std_threshold)
+		return false;
+
+	if (inter->std_threshold !=3D IRQ_INTERVAL_MIN_THRESHOLD_NS)
+		return false;
+
+	if (now - inter->stage_start_clock <=3D
+			IRQ_INTERVAL_MAX_MIN_THRESHOLD_TIME_NS)
+		return false;
+	return true;
+}
+
+/*
+ * Update average interrupt interval with the Exponential Weighted Movin=
g
+ * Average(EWMA), and implement two-stage interrupt flood detection.
+ *
+ * Use scheduler's runqueue software clock at default for figuring
+ * interrupt interval for saving cost. When the interval becomes zero,
+ * it is reasonable to conclude scheduler's activity on this CPU has bee=
n
+ * stopped because of interrupt flood. Then switch to the 2nd stage
+ * detection in which clock is read from hardware, and the detection
+ * result can be more reliable.
+ */
+static void irq_interval_update(void)
+{
+	struct irq_interval *inter =3D raw_cpu_ptr(&avg_irq_interval);
+	u64 now;
+
+	if (likely(!inter->stage)) {
+		now =3D sched_local_rq_clock();
+		irq_interval_update_avg(inter, now,
+				IRQ_INTERVAL_STAGE1_WEIGHT_BITS);
+
+		if (unlikely(inter->avg < inter->std_threshold / 2 ||
+				irq_interval_cpu_lockup_risk(inter, now))) {
+			inter->stage =3D 1;
+			now =3D sched_clock_cpu(smp_processor_id());
+			inter->stage1_time =3D now - inter->stage_start_clock;
+			inter->stage_start_clock =3D now;
+
+			/*
+			 * reset as the mean of the min and the max value of
+			 * stage2's threshold
+			 */
+			inter->avg =3D inter->std_threshold +
+				(inter->std_threshold >> 2);
+		}
+	} else {
+		now =3D sched_clock_cpu(smp_processor_id());
+
+		irq_interval_update_avg(inter, now,
+				IRQ_INTERVAL_STAGE2_WEIGHT_BITS);
+
+		if (inter->avg > inter->std_threshold * 2) {
+			inter->stage =3D 0;
+			inter->stage2_time =3D now - inter->stage_start_clock;
+			inter->stage_start_clock =3D now;
+
+			irq_interval_update_threshold(inter);
+		}
+	}
+}
+
+static void irq_interval_update_clock(void)
+{
+	struct irq_interval *inter =3D raw_cpu_ptr(&avg_irq_interval);
+
+	if (likely(!inter->stage))
+		inter->clock =3D sched_local_rq_clock();
+	else
+		inter->clock =3D sched_clock_cpu(smp_processor_id());
+}
+
+u64 irq_get_avg_interval(int cpu)
+{
+	struct irq_interval *inter =3D per_cpu_ptr(&avg_irq_interval, cpu);
+
+	WARN_ON_ONCE(inter->stage > 1);
+	return (inter->avg << 1) | inter->stage;
+}
+EXPORT_SYMBOL_GPL(irq_get_avg_interval);
+
+bool irq_is_flood(void)
+{
+	struct irq_interval *inter =3D raw_cpu_ptr(&avg_irq_interval);
+
+	return inter->stage && inter->avg < inter->std_threshold;
+}
+EXPORT_SYMBOL_GPL(irq_is_flood);
+
+static void irq_interval_init(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct irq_interval *inter =3D &per_cpu(avg_irq_interval, i);
+
+		inter->std_threshold =3D IRQ_INTERVAL_THRESHOLD_UNIT_NS * 2;
+	}
+}
+
 /*
  * Enter an interrupt context.
  */
@@ -356,6 +512,7 @@ void irq_enter(void)
 	}
=20
 	__irq_enter();
+	irq_interval_update();
 }
=20
 static inline void invoke_softirq(void)
@@ -408,6 +565,8 @@ void irq_exit(void)
 	lockdep_assert_irqs_disabled();
 #endif
 	account_irq_exit_time(current);
+	irq_interval_update_clock();
+
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
@@ -683,6 +842,8 @@ static __init int spawn_ksoftirqd(void)
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
=20
+	irq_interval_init();
+
 	return 0;
 }
 early_initcall(spawn_ksoftirqd);
--=20
2.20.1

