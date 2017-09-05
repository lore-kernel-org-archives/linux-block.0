Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37568 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdIEH40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Sep 2017 03:56:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id u26so14949110wma.0
        for <linux-block@vger.kernel.org>; Tue, 05 Sep 2017 00:56:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BFQ + dm-mpath
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <AE77899A-0365-4C7C-91E4-5ACCC396B26B@linaro.org>
Date: Tue, 5 Sep 2017 09:56:22 +0200
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <ED23C7AC-F202-40E3-8421-E714BF446399@linaro.org>
References: <1503611578.2899.69.camel@wdc.com> <AE77899A-0365-4C7C-91E4-5ACCC396B26B@linaro.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 30 ago 2017, alle ore 18:31, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 25 ago 2017, alle ore 01:16, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>>=20
>> Hello Paolo,
>>=20
>=20
> Hi Bart
>=20
>> Has BFQ ever been tested in combination with dm-mpath?
>=20
> Unfortunately no.
>=20
>> A few seconds
>> after I had started a run of the srp-tests software with BFQ a kernel
>> oops appeared on the console. The command I ran is:
>>=20
>> $ while true; do ~bart/software/infiniband/srp-test/run_tests -d -r =
30 -e bfq; done
>>=20
>> And this is what appeared on the console:
>>=20
>> [89251.977201] BUG: unable to handle kernel NULL pointer dereference =
at 0000000000000018=20
>> [89251.977201] BUG: unable to handle kernel NULL pointer dereference =
at 0000000000000018=20
>> [89251.987831] IP: bfq_setup_cooperator+0x16/0x2e0 [bfq]=20
>> [89251.987831] IP: bfq_setup_cooperator+0x16/0x2e0 [bfq]=20
>> [89251.995241] PGD 0 =20
>> [89251.995241] PGD 0 =20
>> [89251.995243] P4D 0 =20
>> [89251.995243] P4D 0 =20
>> [89251.999194] =20
>> [89251.999194] =20
>> [89252.006423] Oops: 0000 [#1] PREEMPT SMP=20
>> [89252.006423] Oops: 0000 [#1] PREEMPT SMP=20
>> [89252.012354] Modules linked in: ib_srp libcrc32c scsi_transport_srp =
target_core_file ib_srpt target_core_iblock target_core_mod scsi_debug =
brd bfq dm_service_time rdma_cm
>> iw_cm bridge stp llc ip6table_filter ip=20
>> 6_tables iptable_filter intel_rapl sb_edac x86_pkg_temp_thermal =
intel_powerclamp coretemp kvm_intel kvm af_packet irqbypass ipmi_ssif =
dcdbas crct10dif_pclmul ioatdma
>> crc32_pclmul mei_me joydev ghash_clmulni_intel=20
>> mei aesni_intel sg shpchp ipmi_si aes_x86_64 ipmi_devintf crypto_simd =
dca cryptd glue_helper lpc_ich ipmi_msghandler acpi_power_meter acpi_pad =
wmi mfd_core ib_ipoib ib_cm
>> ib_uverbs ib_umad mlx4_ib ib_core dm_mul=20
>> tipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua netconsole =
configfs ip_tables x_tables autofs4 ext4 mbcache jbd2 mlx4_en =
hid_generic usbhid mgag200 i2c_algo_bit
>> drm_kms_helper=20
>> [89252.012354] Modules linked in: ib_srp libcrc32c scsi_transport_srp =
target_core_file ib_srpt target_core_iblock target_core_mod scsi_debug =
brd bfq dm_service_time rdma_cm
>> iw_cm bridge stp llc ip6table_filter ip=20
>> 6_tables iptable_filter intel_rapl sb_edac x86_pkg_temp_thermal =
intel_powerclamp coretemp kvm_intel kvm af_packet irqbypass ipmi_ssif =
dcdbas crct10dif_pclmul ioatdma
>> crc32_pclmul mei_me joydev ghash_clmulni_intel=20
>> mei aesni_intel sg shpchp ipmi_si aes_x86_64 ipmi_devintf crypto_simd =
dca cryptd glue_helper lpc_ich ipmi_msghandler acpi_power_meter acpi_pad =
wmi mfd_core ib_ipoib ib_cm
>> ib_uverbs ib_umad mlx4_ib ib_core dm_mul=20
>> tipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua netconsole =
configfs ip_tables x_tables autofs4 ext4 mbcache jbd2 mlx4_en =
hid_generic usbhid mgag200 i2c_algo_bit
>> drm_kms_helper=20
>> [89252.103941]  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm =
ehci_pci mlx4_core tg3 ehci_hcd crc32c_intel devlink drm ptp usbcore =
usb_common pps_core megaraid_sas libphy
>> [last unloaded: scsi_transport_srp]=20
>> [89252.103941]  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm =
ehci_pci mlx4_core tg3 ehci_hcd crc32c_intel devlink drm ptp usbcore =
usb_common pps_core megaraid_sas libphy
>> [last unloaded: scsi_transport_srp]=20
>> [89252.128375] CPU: 13 PID: 352 Comm: kworker/13:1H Tainted: G        =
W       4.13.0-rc6-dbg+ #2=20
>> [89252.128375] CPU: 13 PID: 352 Comm: kworker/13:1H Tainted: G        =
W       4.13.0-rc6-dbg+ #2=20
>> [89252.139884] Hardware name: Dell Inc. PowerEdge R720/0VWT90, BIOS =
1.3.6 09/11/2012=20
>> [89252.139884] Hardware name: Dell Inc. PowerEdge R720/0VWT90, BIOS =
1.3.6 09/11/2012=20
>> [89252.150243] Workqueue: kblockd blk_mq_run_work_fn=20
>> [89252.150243] Workqueue: kblockd blk_mq_run_work_fn=20
>> [89252.157449] task: ffff880911d80040 task.stack: ffffc90007c64000=20
>> [89252.157449] task: ffff880911d80040 task.stack: ffffc90007c64000=20
>> [89252.166038] RIP: 0010:bfq_setup_cooperator+0x16/0x2e0 [bfq]=20
>> [89252.166038] RIP: 0010:bfq_setup_cooperator+0x16/0x2e0 [bfq]=20
>> [89252.174222] RSP: 0018:ffffc90007c67b20 EFLAGS: 00010082=20
>> [89252.174222] RSP: 0018:ffffc90007c67b20 EFLAGS: 00010082=20
>> [89252.182026] RAX: 00000000ffffffe0 RBX: ffff8807b9988700 RCX: =
0000000000000001=20
>> [89252.182026] RAX: 00000000ffffffe0 RBX: ffff8807b9988700 RCX: =
0000000000000001=20
>> [89252.191990] RDX: ffff8807b9988700 RSI: 0000000000000000 RDI: =
ffff880288554a68=20
>> [89252.191990] RDX: ffff8807b9988700 RSI: 0000000000000000 RDI: =
ffff880288554a68=20
>> [89252.201956] RBP: ffffc90007c67b68 R08: ffffffff825820c0 R09: =
0000000000000000=20
>> [89252.201956] RBP: ffffc90007c67b68 R08: ffffffff825820c0 R09: =
0000000000000000=20
>> [89252.211899] R10: ffffc90007c67ae8 R11: ffffffffa05a5ad5 R12: =
ffff880288554dc8=20
>> [89252.211899] R10: ffffc90007c67ae8 R11: ffffffffa05a5ad5 R12: =
ffff880288554dc8=20
>> [89252.221821] R13: ffff880288554a68 R14: ffff880928078bd0 R15: =
ffff8807bbe03528=20
>> [89252.221821] R13: ffff880288554a68 R14: ffff880928078bd0 R15: =
ffff8807bbe03528=20
>> [89252.231715] FS:  0000000000000000(0000) GS:ffff88093f780000(0000) =
knlGS:0000000000000000=20
>> [89252.231715] FS:  0000000000000000(0000) GS:ffff88093f780000(0000) =
knlGS:0000000000000000=20
>> [89252.242667] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
>> [89252.242667] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
>> [89252.250958] CR2: 0000000000000018 CR3: 00000004aa731000 CR4: =
00000000000406e0
>> [89252.250958] CR2: 0000000000000018 CR3: 00000004aa731000 CR4: =
00000000000406e0=20
>> [89252.260774] Call Trace:=20
>> [89252.260774] Call Trace:=20
>> [89252.265341]  bfq_insert_requests+0x10d/0xf20 [bfq]=20
>> [89252.265341]  bfq_insert_requests+0x10d/0xf20 [bfq]=20
>> [89252.272549]  ? lock_acquire+0xdc/0x1d0=20
>> [89252.272549]  ? lock_acquire+0xdc/0x1d0=20
>> [89252.278566]  blk_mq_sched_insert_request+0x123/0x170=20
>> [89252.278566]  blk_mq_sched_insert_request+0x123/0x170=20
>> [89252.285936]  blk_insert_cloned_request+0xae/0x1f0=20
>> [89252.285936]  blk_insert_cloned_request+0xae/0x1f0=20
>> [89252.293026]  map_request+0x123/0x290 [dm_mod]=20
>> [89252.293026]  map_request+0x123/0x290 [dm_mod]=20
>> [89252.299705]  dm_mq_queue_rq+0x94/0x110 [dm_mod]=20
>> [89252.299705]  dm_mq_queue_rq+0x94/0x110 [dm_mod]=20
>> [89252.306557]  blk_mq_dispatch_rq_list+0x1f1/0x3a0=20
>> [89252.306557]  blk_mq_dispatch_rq_list+0x1f1/0x3a0=20
>> [89252.313520]  blk_mq_sched_dispatch_requests+0x16d/0x1e0=20
>> [89252.313520]  blk_mq_sched_dispatch_requests+0x16d/0x1e0=20
>> [89252.321183]  __blk_mq_run_hw_queue+0x11d/0x1c0=20
>> [89252.321183]  __blk_mq_run_hw_queue+0x11d/0x1c0=20
>> [89252.327987]  blk_mq_run_work_fn+0x2c/0x30=20
>> [89252.327987]  blk_mq_run_work_fn+0x2c/0x30=20
>> [89252.334284]  process_one_work+0x200/0x630=20
>> [89252.334284]  process_one_work+0x200/0x630=20
>> [89252.340515]  worker_thread+0x4e/0x3b0=20
>> [89252.340515]  worker_thread+0x4e/0x3b0=20
>> [89252.346317]  kthread+0x113/0x150=20
>> [89252.346317]  kthread+0x113/0x150=20
>> [89252.351572]  ? process_one_work+0x630/0x630=20
>> [89252.351572]  ? process_one_work+0x630/0x630=20
>> [89252.357890]  ? kthread_create_on_node+0x40/0x40=20
>> [89252.357890]  ? kthread_create_on_node+0x40/0x40=20
>> [89252.364607]  ? kthread_create_on_node+0x40/0x40=20
>> [89252.364607]  ? kthread_create_on_node+0x40/0x40=20
>> [89252.371303]  ret_from_fork+0x27/0x40=20
>> [89252.371303]  ret_from_fork+0x27/0x40=20
>> [89252.376912] Code: 96 08 01 00 00 48 c1 ea 06 83 e2 01 89 d0 5d c3 =
0f 1f 44 00 00 66 66 66 66 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 =
83 ec 20 <4c> 8b 66 18 4d 85 e4 74
>> 12 48 83 c4 20 4c 89 e0 5b 41 5c 41=20
>> 5d =20
>> [89252.376912] Code: 96 08 01 00 00 48 c1 ea 06 83 e2 01 89 d0 5d c3 =
0f 1f 44 00 00 66 66 66 66 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 =
83 ec 20 <4c> 8b 66 18 4d 85 e4 74
>> 12 48 83 c4 20 4c 89 e0 5b 41 5c 41=20
>> 5d =20
>> [89252.401319] RIP: bfq_setup_cooperator+0x16/0x2e0 [bfq] RSP: =
ffffc90007c67b20=20
>> [89252.401319] RIP: bfq_setup_cooperator+0x16/0x2e0 [bfq] RSP: =
ffffc90007c67b20=20
>> [89252.410858] CR2: 0000000000000018=20
>> [89252.410858] CR2: 0000000000000018=20
>> [89252.416257] ---[ end trace ec48e99a50d88cb4 ]---=20
>> [89252.416257] ---[ end trace ec48e99a50d88cb4 ]---
>>=20
>> $ gdb bfq.ko
>> (gdb) list *(bfq_setup_cooperator+0x16)
>> 0x1d76 is in bfq_setup_cooperator (block/bfq-iosched.c:1959).
>> 1954    bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue =
*bfqq,
>> 1955                         void *io_struct, bool request)
>> 1956    {
>> 1957            struct bfq_queue *in_service_bfqq, *new_bfqq;
>> 1958
>> 1959            if (bfqq->new_bfqq)
>> 1960                    return bfqq->new_bfqq;
>> 1961
>> 1962            if (!io_struct ||
>> 1963                wr_from_too_long(bfqq) ||
>>=20
>=20
> At a first glance, bfq_insert_request seems to get a request that has
> not been properly initialized: the field (rq)->elv.priv[1], where bfq
> stores the bfq_queue the request belongs to (in the function
> bfq_prepare_request) happens to be null.  Then the parameter bfqq at
> line 1959 is null, and the oops follows.
>=20
> This lets me suspect that something wrong happens around
> dm_mq_queue_rq, map_request and blk_insert_cloned_request.
> Unfortunately, I don't remember having ever read the code of those
> function.  So I have written this short, preliminary report just to
> see whether it rings any bell for anyone reading this email.  If not,
> I'll dig into these functions to check whether the bug is really where
> I suspect.
>=20

Ok, my suspects seem confirmed: the path dm_mq_queue_rq -> map_request
-> setup_clone -> blk_rq_prep_clone creates a cloned request without
invoking e->type->ops.mq.prepare_request for the target elevator e.
The cloned request is therefore not initialized for the scheduler, but
it is however inserted into the scheduler by
blk_mq_sched_insert_request.  This seems an error for any scheduler
that needs to initialize fields in the incoming request, or in general
to take some preliminary action.

Am I missing something here?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> Bart.
