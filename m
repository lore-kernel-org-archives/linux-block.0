Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E03C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 09:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CC9613EA
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 09:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGBJub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 05:50:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhGBJu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 05:50:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2315721FB4;
        Fri,  2 Jul 2021 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625219277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQejxrBRgdHn6jyss78NHSQQbF5WESo4cgDMMvQ3Qv4=;
        b=Q8dtv8whqMkN2kfApjKcVHAEZB9mk7p84E+u/wdiRojSl/aW1e4kQ0wlNc5eNMjxNJa5J6
        6ZDqJ5MudOyDzI9XuK89jNWzVPEU16XWcMhB2q7FmG40rAp0L3KqwnkfzlThVsn5MPtfPZ
        wHwC67h+9tknxhOE0OcyjCxhIgjlJuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625219277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQejxrBRgdHn6jyss78NHSQQbF5WESo4cgDMMvQ3Qv4=;
        b=HYkexFxqTPAbvKAxsGKoRz5Je+sHqDXW4MlD/P/iKEst+JGBrleA19ao15BrsxWKSHRYAv
        xyNkJKdg6J4lSPCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 116C911CD6;
        Fri,  2 Jul 2021 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625219277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQejxrBRgdHn6jyss78NHSQQbF5WESo4cgDMMvQ3Qv4=;
        b=Q8dtv8whqMkN2kfApjKcVHAEZB9mk7p84E+u/wdiRojSl/aW1e4kQ0wlNc5eNMjxNJa5J6
        6ZDqJ5MudOyDzI9XuK89jNWzVPEU16XWcMhB2q7FmG40rAp0L3KqwnkfzlThVsn5MPtfPZ
        wHwC67h+9tknxhOE0OcyjCxhIgjlJuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625219277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQejxrBRgdHn6jyss78NHSQQbF5WESo4cgDMMvQ3Qv4=;
        b=HYkexFxqTPAbvKAxsGKoRz5Je+sHqDXW4MlD/P/iKEst+JGBrleA19ao15BrsxWKSHRYAv
        xyNkJKdg6J4lSPCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id rhRAA83g3mDaSgAALh3uQQ
        (envelope-from <dwagner@suse.de>); Fri, 02 Jul 2021 09:47:57 +0000
Date:   Fri, 2 Jul 2021 11:47:56 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <20210702094756.34zkja2yc6am3gyc@beryllium.lan>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
 <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
 <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
 <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 09:46:35PM +0200, Hannes Reinecke wrote:
> Actually, Daniel and me came to a slightly different idea: use cpu hotplug
> notifier.
> Thing is, blk-mq already has cpu hotplug notifier, which should ensure that
> no I/O is pending during cpu hotplug.
> If we now add a nvme cpu hotplug notifier which essentially kicks off a
> reset once all cpu in a hctx are offline the reset logic will rearrange the
> queues to match the current cpu layout.
> And when the cpus are getting onlined we'll do another reset.
> 
> Daniel is currently preparing a patch; let's see how it goes.

FTR, I can't say it was a huge success. I observed a real problem with
this idea and 'maybe problem. First, we can't use nvme_ctrl_reset_sync()
in the cpuhp path as this will block in various places due to
percpu_rwsem_wait operations [1]. Not really a surprise I'd say.

The maybe problem: I tried the test this time though with
nvme_ctrl_reset() and this worked for a while (a couple of hours of FC
port toggling with stress cpu hotplugging). Though eventually the system
stopped to respond and died. Unfortunately, I don't have any core
dump. So it's not totally clear what's happening.

BTW, I used the same test setup with Ming's patches on top of the two of
mine. The system was still working fine after 4 hours of the stress
testing.

[1] https://paste.opensuse.org/view/raw/62287389

For the fun, here is the nvme_ctrl_reset() patch:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66973bb56305..444756ba8dbe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
 #include <linux/pm_qos.h>
+#include <linux/cpuhotplug.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
@@ -4245,6 +4246,8 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_NVME_QUEUE_ONLINE,
+					    &ctrl->cpuhp_node);
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
@@ -4357,6 +4360,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_free_name;
 
+	ret = cpuhp_state_add_instance_nocalls(CPUHP_AP_NVME_QUEUE_ONLINE,
+					       &ctrl->cpuhp_node);
+	if (ret) {
+		pr_debug("failed to cpuhp notifiers %d\n", ret);
+		goto out_del_device;
+	}
+
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
 	 * be visible to userspace unless the device actually supports APST.
@@ -4369,6 +4379,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	nvme_mpath_init_ctrl(ctrl);
 
 	return 0;
+out_del_device:
+	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
@@ -4529,6 +4541,80 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
 }
 
+static int nvme_notify_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct nvme_ctrl *ctrl = hlist_entry_safe(node,
+			struct nvme_ctrl, cpuhp_node);
+	struct nvme_ns *ns;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+	bool present = false;
+
+	pr_warn("NQN %s CPU %u online\n", ctrl->opts->subsysnqn, cpu);
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		queue_for_each_hw_ctx(ns->disk->queue, hctx, i) {
+			if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+				present = true;
+				break;
+			}
+		}
+		if (present)
+			break;
+	}
+	up_read(&ctrl->namespaces_rwsem);
+	if (present) {
+		pr_warn("trigger reset... \n");
+		nvme_reset_ctrl_sync(ctrl);
+		pr_warn("executed\n");
+	}
+
+	return 0;
+}
+
+static inline bool nvme_last_cpu_in_hctx(unsigned int cpu,
+					struct blk_mq_hw_ctx *hctx)
+{
+	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
+		return false;
+	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
+		return false;
+	return true;
+}
+
+static int nvme_notify_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct nvme_ctrl *ctrl = hlist_entry_safe(node,
+			struct nvme_ctrl, cpuhp_node);
+	struct nvme_ns *ns;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+	bool offline = false;
+
+	pr_warn("NQN %s CPU %u offline\n", ctrl->opts->subsysnqn, cpu);
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		queue_for_each_hw_ctx(ns->disk->queue, hctx, i) {
+			pr_warn("htcx %p cpumask %*pbl state x%lx\n",
+				hctx, cpumask_pr_args(hctx->cpumask), hctx->state);
+			if (nvme_last_cpu_in_hctx(cpu, hctx)) {
+				offline = true;
+				break;
+			}
+		}
+		if (offline)
+			break;
+	}
+	up_read(&ctrl->namespaces_rwsem);
+	if (offline) {
+		pr_warn("trigger reset... \n");
+		nvme_reset_ctrl_sync(ctrl);
+		pr_warn("executed\n");
+	}
+	return 0;
+}
 
 static int __init nvme_core_init(void)
 {
@@ -4580,8 +4666,17 @@ static int __init nvme_core_init(void)
 		goto unregister_generic_ns;
 	}
 
+	result = cpuhp_setup_state_multi(CPUHP_AP_NVME_QUEUE_ONLINE,
+					 "nvme:online",
+					 nvme_notify_online,
+					 nvme_notify_offline);
+	if (result < 0)
+		goto destroy_chr_class;
+
 	return 0;
 
+destroy_chr_class:
+	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 destroy_subsys_class:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0015860ec12b..34676ff79d40 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -352,6 +352,8 @@ struct nvme_ctrl {
 	unsigned long discard_page_busy;
 
 	struct nvme_fault_inject fault_inject;
+
+	struct hlist_node cpuhp_node;
 };
 
 enum nvme_iopolicy {
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 4a62b3980642..5f6cf60bee1f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -159,6 +159,7 @@ enum cpuhp_state {
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
 	CPUHP_AP_BLK_MQ_ONLINE,
+	CPUHP_AP_NVME_QUEUE_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
