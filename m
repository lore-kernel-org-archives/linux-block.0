Subject: Re: [PATCHSET v6] blk-mq scheduling framework
To: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <e1f8f6c5-5347-d8d8-57a2-0367d828dd22@suse.de>
 <5850a4ad-74a1-8d30-e865-fbd35679e84f@suse.de>
 <2e968ed9-7269-488b-4c38-b318ad99ed3f@fb.com>
 <3cda10cb-b74e-0f6c-bbda-37d366b92ad0@suse.de>
Cc: osandov@osandov.com, bart.vanassche@sandisk.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <c8c8f077-a8e2-fd2c-284b-a83ed6ab4100@fb.com>
Date: Fri, 13 Jan 2017 08:34:55 -0700
MIME-Version: 1.0
In-Reply-To: <3cda10cb-b74e-0f6c-bbda-37d366b92ad0@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/13/2017 08:33 AM, Hannes Reinecke wrote:
> On 01/13/2017 04:23 PM, Jens Axboe wrote:
>> On 01/13/2017 04:04 AM, Hannes Reinecke wrote:
>>> On 01/13/2017 09:15 AM, Hannes Reinecke wrote:
>>>> On 01/11/2017 10:39 PM, Jens Axboe wrote:
>>>>> Another year, another posting of this patchset. The previous posting
>>>>> was here:
>>>>>
>>>>> https://www.spinics.net/lists/kernel/msg2406106.html
>>>>>
>>>>> (yes, I've skipped v5, it was fixes on top of v4, not the rework).
>>>>>
>>>>> I've reworked bits of this to get rid of the shadow requests, thanks
>>>>> to Bart for the inspiration. The missing piece, for me, was the fact
>>>>> that we have the tags->rqs[] indirection array already. I've done this
>>>>> somewhat differently, though, by having the internal scheduler tag
>>>>> map be allocated/torn down when an IO scheduler is attached or
>>>>> detached. This also means that when we run without a scheduler, we
>>>>> don't have to do double tag allocations, it'll work like before.
>>>>>
>>>>> The patchset applies on top of 4.10-rc3, or can be pulled here:
>>>>>
>>>>> git://git.kernel.dk/linux-block blk-mq-sched.6
>>>>>
>>>> Well ... something's wrong here on my machine:
>>>>
>>>> [   39.886886] ------------[ cut here ]------------
>>>> [   39.886895] WARNING: CPU: 9 PID: 62 at block/blk-mq.c:342
>>>> __blk_mq_finish_request+0x124/0x140
>>>> [   39.886895] Modules linked in: sd_mod ahci uhci_hcd ehci_pci
>>>> mpt3sas(+) libahci ehci_hcd serio_raw crc32c_intel raid_class drm libata
>>>> usbcore hpsa usb_common scsi_transport_sas sg dm_multipath dm_mod
>>>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
>>>> [   39.886910] CPU: 9 PID: 62 Comm: kworker/u130:0 Not tainted
>>>> 4.10.0-rc3+ #528
>>>> [   39.886911] Hardware name: HP ProLiant ML350p Gen8, BIOS P72 09/08/2013
>>>> [   39.886917] Workqueue: events_unbound async_run_entry_fn
>>>> [   39.886918] Call Trace:
>>>> [   39.886923]  dump_stack+0x85/0xc9
>>>> [   39.886927]  __warn+0xd1/0xf0
>>>> [   39.886928]  warn_slowpath_null+0x1d/0x20
>>>> [   39.886930]  __blk_mq_finish_request+0x124/0x140
>>>> [   39.886932]  blk_mq_finish_request+0x55/0x60
>>>> [   39.886934]  blk_mq_sched_put_request+0x78/0x80
>>>> [   39.886936]  blk_mq_free_request+0xe/0x10
>>>> [   39.886938]  blk_put_request+0x25/0x60
>>>> [   39.886944]  __scsi_execute.isra.24+0x104/0x160
>>>> [   39.886946]  scsi_execute_req_flags+0x94/0x100
>>>> [   39.886948]  scsi_report_opcode+0xab/0x100
>>>>
>>>> checking ...
>>>>
>>> Ah.
>>> Seems like the elevator switch races with device setup:
>>>
>>>  1188.490326] ------------[ cut here ]------------
>>> [ 1188.490334] WARNING: CPU: 9 PID: 30155 at block/blk-mq.c:342
>>> __blk_mq_finish_request+0x172/0x180
>>> [ 1188.490335] Modules linked in: mpt3sas(+) raid_class rpcsec_gss_krb5
>>> auth_rpcgss nfsv4 nfs lockd grace fscache ebtable_filt
>>> er ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables
>>> af_packet br_netfilter bridge stp llc iscsi_ibft iscs
>>> i_boot_sysfs sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp
>>> coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_p
>>> clmul tg3 ixgbe ghash_clmulni_intel pcbc ptp aesni_intel pps_core
>>> aes_x86_64 ipmi_ssif hpilo hpwdt mdio libphy pcc_cpufreq cry
>>> pto_simd glue_helper iTCO_wdt iTCO_vendor_support acpi_cpufreq tpm_tis
>>> ipmi_si ipmi_devintf cryptd lpc_ich pcspkr ioatdma tpm_
>>> tis_core thermal wmi shpchp dca ipmi_msghandler tpm fjes button sunrpc
>>> btrfs xor sr_mod raid6_pq cdrom ehci_pci mgag200 i2c_al
>>> go_bit drm_kms_helper syscopyarea sysfillrect uhci_hcd
>>> [ 1188.490399]  sysimgblt fb_sys_fops sd_mod ahci ehci_hcd ttm libahci
>>> crc32c_intel serio_raw drm libata usbcore usb_common hp
>>> sa scsi_transport_sas sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc
>>> scsi_dh_alua autofs4
>>> [ 1188.490411] CPU: 9 PID: 30155 Comm: kworker/u130:6 Not tainted
>>> 4.10.0-rc3+ #535
>>> [ 1188.490411] Hardware name: HP ProLiant ML350p Gen8, BIOS P72 09/08/2013
>>> [ 1188.490425] Workqueue: events_unbound async_run_entry_fn
>>> [ 1188.490427] Call Trace:
>>> [ 1188.490433]  dump_stack+0x85/0xc9
>>> [ 1188.490436]  __warn+0xd1/0xf0
>>> [ 1188.490438]  warn_slowpath_null+0x1d/0x20
>>> [ 1188.490440]  __blk_mq_finish_request+0x172/0x180
>>> [ 1188.490442]  blk_mq_finish_request+0x55/0x60
>>> [ 1188.490443]  blk_mq_sched_put_request+0x78/0x80
>>> [ 1188.490445]  blk_mq_free_request+0xe/0x10
>>> [ 1188.490448]  blk_put_request+0x25/0x60
>>> [ 1188.490453]  __scsi_execute.isra.24+0x104/0x160
>>> [ 1188.490455]  scsi_execute_req_flags+0x94/0x100
>>> [ 1188.490457]  scsi_report_opcode+0xab/0x100
>>> [ 1188.490461]  sd_revalidate_disk+0xaef/0x1450 [sd_mod]
>>> [ 1188.490464]  sd_probe_async+0xd1/0x1d0 [sd_mod]
>>> [ 1188.490466]  async_run_entry_fn+0x37/0x150
>>> [ 1188.490470]  process_one_work+0x1d0/0x660
>>> [ 1188.490472]  ? process_one_work+0x151/0x660
>>> [ 1188.490474]  worker_thread+0x12b/0x4a0
>>> [ 1188.490475]  kthread+0x10c/0x140
>>> [ 1188.490477]  ? process_one_work+0x660/0x660
>>> [ 1188.490478]  ? kthread_create_on_node+0x40/0x40
>>> [ 1188.490483]  ret_from_fork+0x2a/0x40
>>> [ 1188.490484] ---[ end trace d5e3a32ac269fc2a ]---
>>> [ 1188.490485] rq (487/52) rqs (-1/-1)
>>> [ 1188.523518] sd 7:0:0:0: [sdb] Attached SCSI disk
>>> [ 1188.540954] elevator: switch to deadline failed
>>
>> Where did this last line come from? Do you have a udev rule or something
>> that attempts to switch to deadline, which will fail with scsi-mq?
>>
>> Trying to get closer to reproducing this, no luck just setting the async
>> scan option, mine still boots fine.
>>
> Ah, indeed.
> There is an ominous udev rule here, trying to switch to 'deadline'.
> 
> # cat 60-ssd-scheduler.rules
> # do not edit this file, it will be overwritten on update
> 
> ACTION!="add", GOTO="ssd_scheduler_end"
> SUBSYSTEM!="block", GOTO="ssd_scheduler_end"
> 
> IMPORT{cmdline}="elevator"
> ENV{elevator}=="*?", GOTO="ssd_scheduler_end"
> 
> KERNEL=="sd*[!0-9]", ATTR{queue/rotational}=="0",
> ATTR{queue/scheduler}="deadline"
> 
> LABEL="ssd_scheduler_end"
> 
> Still shouldn't crash the kernel, though ...

Of course not, and it's not a given that it does, it could just be
triggering after the device load and failing like expected. But just in
case, can you try and disable that rule and see if it still crashes with
MQ_DEADLINE set as the default?

-- 
Jens Axboe
