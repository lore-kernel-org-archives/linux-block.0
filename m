Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DA2C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 02:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B236121E
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 02:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhEUCwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 22:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233648AbhEUCwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 22:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621565451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xZtf0jHx+2rKPyHTNoh/t8QQN1j1nYziUDCyxqSr+1A=;
        b=OFPNZ6lbA1LvRbU0KdHmMgl41wXk/taBbrCHkLwzrSHH6GFIM9wXxb/7WBerNOCQVSeju1
        jUKA+qdT6rb+20ViudETZCre8Uc9yyCkvAfYZFOCbo8xV5DXg6WamGOr0Tt7ur3km529JT
        T+t+GpwbIVG6PYazeQhBsArney/Qxoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-gnJ6J7rzPsWtu6eOCU5Lpg-1; Thu, 20 May 2021 22:50:50 -0400
X-MC-Unique: gnJ6J7rzPsWtu6eOCU5Lpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C70343A2;
        Fri, 21 May 2021 02:50:48 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EE555C261;
        Fri, 21 May 2021 02:50:39 +0000 (UTC)
Date:   Fri, 21 May 2021 10:50:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [bugreport 5.9-rc8] general protection fault in
 __bfq_deactivate_entity
Message-ID: <YKcf+xN/G4O75vZp@T590>
References: <CABXGCsP63mN+G1xE7UBfVRuDRcJiRRC7EXU2y25f9rXkoU-0LQ@mail.gmail.com>
 <CACVXFVOy8928GNowCQRGQKQxuLtHn0V+pYk1kzeOyc0pyDvkjQ@mail.gmail.com>
 <20210305090022.1863-1-hdanton@sina.com>
 <CACVXFVPp_byzrYVwyo05u0v3zoPP42FKZhfWMb6GMBno1rCZRw@mail.gmail.com>
 <E28250BB-FBFF-4F02-B7A2-9530340E481E@linaro.org>
 <20210307021524.13260-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307021524.13260-1-hdanton@sina.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 06, 2021 at 07:15:24PM -0700, Hillf Danton wrote:
> On Fri, 5 Mar 2021 18:01:04 +0800  Ming Lei wrote:
> > On Fri, Mar 05, 2021 at 10:32:04AM +0100, Paolo Valente wrote:
> > > I'm thinking of a way to debug this too.  The symptom may hint at a
> > > use-after-free.  Could you enable KASAN in your tests?  (On the flip
> > > side, I know this might change timings, thereby making the fault
> > > disappear).
> > 
> > I have asked our QE to reproduce the issue with debug kernel, which may take a
> > while. And I can't trigger it in my box.
> > 
> > BTW, for the 2nd 'kernel NULL pointer dereference', the RIP points to:
> > 
> > (gdb) l *(__bfq_deactivate_entity+0x5b)
> > 0xffffffff814c31cb is in __bfq_deactivate_entity (block/bfq-wf2q.c:1181).
> > 1176		 * bfq_group_set_parent has already been invoked for the group
> > 1177		 * represented by entity. Therefore, the field
> > 1178		 * entity->sched_data has been set, and we can safely use it.
> > 1179		 */
> > 1180		st = bfq_entity_service_tree(entity);
> > 1181		is_in_service = entity == sd->in_service_entity;
> > 1182
> > 1183		bfq_calc_finish(entity, entity->service);
> > 1184
> > 1185		if (is_in_service)
> > 
> > Seems entity->sched_data points to NULL.
> 
> Hi Ming,
> 
> Thanks for your report.
> 
> Given the invalid pointer cannot explain line 1180, you are reporting
> a different issue from what Mike reported, and we can do nothing now
> for both without a reproducer.

BTW, we get this report 2 times on 5.12 kernel, following the kernel log, and this
time there is hard LOCKUP.


[  337.526984] systemd-shutdown[1]: Not all DM devices detached, 1 left.
[  337.526988] systemd-shutdown[1]: Cannot finalize remaining DM devices, continuing.
[  337.531043] systemd-shutdown[1]: Successfully changed into root pivot.
[  337.531046] systemd-shutdown[1]: Returning to initrd...
[  337.533136] watchdog: watchdog0: watchdog did not stop!
[  337.569177] dracut Warning: Killing all remaining processes
[  337.706605] XFS (dm-0): Unmounting Filesystem
[  351.593888] NMI watchdog: Watchdog detected hard LOCKUP on cpu 2
[  351.593890] Modules linked in: dm_multipath rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_ssc fscache rfkill sunrpc intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200 dcdbas iTCO_wdt irqbypass i2c_algo_bit iTCO_vendor_support rapl drm_kms_helper intel_cstate syscopyarea sysfillrect sysimgblt fb_sys_fops cec intel_uncore pcspkr ipmi_ssif mei_me mei lpc_ich ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter drm fuse ip_tables xfs libcrc32c sd_mod qla2xxx ahci libahci nvme_fc crct10dif_pclmul crc32_pclmul crc32c_intel nvme_fabrics libata ghash_clmulni_intel tg3 nvme_core megaraid_sas t10_pi scsi_transport_fc wmi dm_mirror dm_region_hash dm_log dm_mod
[  351.593929] CPU: 2 PID: 95 Comm: kworker/2:1 Kdump: loaded Tainted: G               X --------- ---  5.12.0-1.el9.x86_64 #1
[  351.593930] Hardware name: Dell Inc. PowerEdge R430/0HFG24, BIOS 1.6.2 01/08/2016
[  351.593931] Workqueue: cgwb_release cgwb_release_workfn
[  351.593932] RIP: 0010:rb_prev+0x18/0x50
[  351.593933] Code: 31 c0 eb db 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 17 48 39 d7 74 35 48 8b 47 10 48 85 c0 74 1c 49 89 c0 48 8b 40 08 <48> 85 c0 75 f4 4c 89 c0 c3 48 3b 78 10 75 f6 48 8b 10 48 89 c7 48
[  351.593934] RSP: 0018:ffffb7280048fd70 EFLAGS: 00000086
[  351.593935] RAX: ffff98bc30f448a0 RBX: ffff98bc10d1e150 RCX: 0000000000000014
[  351.593936] RDX: 0000000000000001 RSI: ffff98bc00b39098 RDI: ffff98bc00b39098
[  351.593937] RBP: ffff98bc00b39098 R08: ffff98bc30f448a0 R09: 0000000000000000
[  351.593938] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  351.593939] R13: 0000000000000001 R14: ffff98bc10d1e110 R15: 0000000000000000
[  351.593940] FS:  0000000000000000(0000) GS:ffff98c37fa80000(0000) knlGS:0000000000000000
[  351.593941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  351.593941] CR2: 00007fffeeceaea0 CR3: 0000000105b40003 CR4: 00000000001706e0
[  351.593942] Call Trace:
[  351.593943]  bfq_idle_extract+0x98/0xb0
[  351.593943]  __bfq_deactivate_entity+0x224/0x240
[  351.593944]  bfq_pd_offline+0xaa/0xd0
[  351.593945]  blkg_destroy+0x52/0xf0
[  351.593945]  blkcg_destroy_blkgs+0x46/0xc0
[  351.593946]  cgwb_release_workfn+0xbe/0x150
[  351.593947]  process_one_work+0x1e6/0x380
[  351.593947]  worker_thread+0x53/0x3d0
[  351.593948]  ? process_one_work+0x380/0x380
[  351.593949]  kthread+0x11b/0x140
[  351.593949]  ? kthread_associate_blkcg+0xa0/0xa0
[  351.593950]  ret_from_fork+0x22/0x30
[  351.593950] Kernel panic - not syncing: Hard LOCKUP


Thanks,
Ming

