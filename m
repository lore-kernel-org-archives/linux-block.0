Return-Path: <ming.lei@redhat.com>
Date: Fri, 2 Mar 2018 10:16:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Don Brace <don.brace@microsemi.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
Message-ID: <20180302021557.GC10471@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-2-ming.lei@redhat.com>
 <633459ac33bf49c9a3ff6e515aa790de@microsemi.com>
 <1519930884.9730.8.camel@redhat.com>
 <1519939174.15243.0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1519939174.15243.0.camel@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 04:19:34PM -0500, Laurence Oberman wrote:
> On Thu, 2018-03-01 at 14:01 -0500, Laurence Oberman wrote:
> > On Thu, 2018-03-01 at 16:18 +0000, Don Brace wrote:
> > > > -----Original Message-----
> > > > From: Ming Lei [mailto:ming.lei@redhat.com]
> > > > Sent: Tuesday, February 27, 2018 4:08 AM
> > > > To: Jens Axboe <axboe@kernel.dk>; linux-block@vger.kernel.org;
> > > > Christoph
> > > > Hellwig <hch@infradead.org>; Mike Snitzer <snitzer@redhat.com>
> > > > Cc: linux-scsi@vger.kernel.org; Hannes Reinecke <hare@suse.de>;
> > > > Arun Easi
> > > > <arun.easi@cavium.com>; Omar Sandoval <osandov@fb.com>; Martin K
> > > > .
> > > > Petersen <martin.petersen@oracle.com>; James Bottomley
> > > > <james.bottomley@hansenpartnership.com>; Christoph Hellwig <hch@l
> > > > st
> > > > .de>;
> > > > Don Brace <don.brace@microsemi.com>; Kashyap Desai
> > > > <kashyap.desai@broadcom.com>; Peter Rivera <peter.rivera@broadcom
> > > > .c
> > > > om>;
> > > > Laurence Oberman <loberman@redhat.com>; Ming Lei
> > > > <ming.lei@redhat.com>; Meelis Roos <mroos@linux.ee>
> > > > Subject: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
> > > > 
> > > > EXTERNAL EMAIL
> > > > 
> > > > 
> > > > From 84676c1f21 (genirq/affinity: assign vectors to all possible
> > > > CPUs),
> > > > one msix vector can be created without any online CPU mapped,
> > > > then
> > > > one
> > > > command's completion may not be notified.
> > > > 
> > > > This patch setups mapping between cpu and reply queue according
> > > > to
> > > > irq
> > > > affinity info retrived by pci_irq_get_affinity(), and uses this
> > > > mapping
> > > > table to choose reply queue for queuing one command.
> > > > 
> > > > Then the chosen reply queue has to be active, and fixes IO hang
> > > > caused
> > > > by using inactive reply queue which doesn't have any online CPU
> > > > mapped.
> > > > 
> > > > Cc: Hannes Reinecke <hare@suse.de>
> > > > Cc: Arun Easi <arun.easi@cavium.com>
> > > > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> > > > Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> > > > Cc: Christoph Hellwig <hch@lst.de>,
> > > > Cc: Don Brace <don.brace@microsemi.com>
> > > > Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> > > > Cc: Peter Rivera <peter.rivera@broadcom.com>
> > > > Cc: Laurence Oberman <loberman@redhat.com>
> > > > Cc: Meelis Roos <mroos@linux.ee>
> > > > Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all
> > > > possible CPUs")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > 
> > > I am getting some issues that need to be tracked down:
> > > 
> > > [ 1636.032984] hpsa 0000:87:00.0: Acknowledging event: 0xc0000032
> > > (HP
> > > SSD Smart Path configuration change)
> > > [ 1638.510656] hpsa 0000:87:00.0: scsi 3:0:8:0: updated Direct-
> > > Access�����HP�������MO0400JDVEU������PHYS DRV SSDSmartPathCap- En-
> > > Exp=0
> > > [ 1653.967695] hpsa 0000:87:00.0: Acknowledging event: 0x80000020
> > > (HP
> > > SSD Smart Path configuration change)
> > > [ 1656.770377] hpsa 0000:87:00.0: scsi 3:0:8:0: updated Direct-
> > > Access�����HP�������MO0400JDVEU������PHYS DRV SSDSmartPathCap- En-
> > > Exp=0
> > > [ 2839.762267] hpsa 0000:87:00.0: Acknowledging event: 0x80000020
> > > (HP
> > > SSD Smart Path configuration change)
> > > [ 2840.841290] hpsa 0000:87:00.0: scsi 3:0:8:0: updated Direct-
> > > Access�����HP�������MO0400JDVEU������PHYS DRV SSDSmartPathCap- En-
> > > Exp=0
> > > [ 2917.582653] hpsa 0000:87:00.0: Acknowledging event: 0xc0000020
> > > (HP
> > > SSD Smart Path configuration change)
> > > [ 2919.087191] hpsa 0000:87:00.0: scsi 3:1:0:1: updated Direct-
> > > Access�����HP�������LOGICAL VOLUME���RAID-5 SSDSmartPathCap+ En+
> > > Exp=1
> > > [ 2919.142527] hpsa 0000:87:00.0: hpsa_figure_phys_disk_ptrs:
> > > [3:1:0:2] A phys disk component of LV is missing, turning off
> > > offload_enabled for LV.
> > > [ 2919.203915] hpsa 0000:87:00.0: hpsa_figure_phys_disk_ptrs:
> > > [3:1:0:2] A phys disk component of LV is missing, turning off
> > > offload_enabled for LV.
> > > [ 2919.266921] hpsa 0000:87:00.0: hpsa_figure_phys_disk_ptrs:
> > > [3:1:0:2] A phys disk component of LV is missing, turning off
> > > offload_enabled for LV.
> > > [ 2934.999629] hpsa 0000:87:00.0: Acknowledging event: 0x40000000
> > > (HP
> > > SSD Smart Path state change)
> > > [ 2936.937333] hpsa 0000:87:00.0: hpsa_figure_phys_disk_ptrs:
> > > [3:1:0:2] A phys disk component of LV is missing, turning off
> > > offload_enabled for LV.
> > > [ 2936.998707] hpsa 0000:87:00.0: hpsa_figure_phys_disk_ptrs:
> > > [3:1:0:2] A phys disk component of LV is missing, turning off
> > > offload_enabled for LV.
> > > [ 2937.060101] hpsa 0000:87:00.0: hpsa_figure_phys_disk_ptrs:
> > > [3:1:0:2] A phys disk component of LV is missing, turning off
> > > offload_enabled for LV.
> > > [ 3619.711122] sd 3:1:0:3: [sde] tag#436 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3619.751150] sd 3:1:0:3: [sde] tag#436 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3619.784375] sd 3:1:0:3: [sde] tag#436 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3619.816530] sd 3:1:0:3: [sde] tag#436 CDB: Read(10) 28 00 01 1b
> > > ad
> > > af 00 00 01 00
> > > [ 3619.852295] print_req_error: I/O error, dev sde, sector 18591151
> > > [ 3619.880850] sd 3:1:0:3: [sde] tag#461 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3619.920981] sd 3:1:0:3: [sde] tag#461 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3619.955081] sd 3:1:0:3: [sde] tag#461 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3619.987054] sd 3:1:0:3: [sde] tag#461 CDB: Read(10) 28 00 02 15
> > > 31
> > > 40 00 00 01 00
> > > [ 3620.022569] print_req_error: I/O error, dev sde, sector 34943296
> > > [ 3620.050873] sd 3:1:0:3: [sde] tag#157 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3620.091124] sd 3:1:0:3: [sde] tag#157 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3620.124179] sd 3:1:0:3: [sde] tag#157 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3620.156203] sd 3:1:0:3: [sde] tag#157 CDB: Read(10) 28 00 03 65
> > > 9d
> > > 7e 00 00 01 00
> > > [ 3620.191520] print_req_error: I/O error, dev sde, sector 56991102
> > > [ 3620.220308] sd 3:1:0:3: [sde] tag#266 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3620.260273] sd 3:1:0:3: [sde] tag#266 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3620.294605] sd 3:1:0:3: [sde] tag#266 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3620.328353] sd 3:1:0:3: [sde] tag#266 CDB: Read(10) 28 00 09 92
> > > 94
> > > 70 00 00 01 00
> > > [ 3620.364807] print_req_error: I/O error, dev sde, sector
> > > 160601200
> > > [ 3620.394342] sd 3:1:0:3: [sde] tag#278 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3620.434462] sd 3:1:0:3: [sde] tag#278 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3620.469059] sd 3:1:0:3: [sde] tag#278 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3620.471761] sd 3:1:0:3: [sde] tag#467 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3620.502240] sd 3:1:0:3: [sde] tag#278 CDB: Read(10) 28 00 08 00
> > > 12
> > > ea 00 00 01 00
> > > [ 3620.543157] sd 3:1:0:3: [sde] tag#467 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3620.580375] print_req_error: I/O error, dev sde, sector
> > > 134222570
> > > [ 3620.615355] sd 3:1:0:3: [sde] tag#467 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3620.645069] sd 3:1:0:3: [sde] tag#244 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3620.678696] sd 3:1:0:3: [sde] tag#467 CDB: Read(10) 28 00 10 3f
> > > 2b
> > > fc 00 00 01 00
> > > [ 3620.720247] sd 3:1:0:3: [sde] tag#244 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3620.756776] print_req_error: I/O error, dev sde, sector
> > > 272575484
> > > [ 3620.791857] sd 3:1:0:3: [sde] tag#244 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3620.822272] sd 3:1:0:3: [sde] tag#431 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3620.855200] sd 3:1:0:3: [sde] tag#244 CDB: Read(10) 28 00 08 31
> > > 86
> > > d9 00 00 01 00
> > > [ 3620.895823] sd 3:1:0:3: [sde] tag#431 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3620.931923] print_req_error: I/O error, dev sde, sector
> > > 137463513
> > > [ 3620.966262] sd 3:1:0:3: [sde] tag#431 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3620.995715] sd 3:1:0:3: [sde] tag#226 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3621.028703] sd 3:1:0:3: [sde] tag#431 CDB: Read(10) 28 00 10 7c
> > > b2
> > > b0 00 00 01 00
> > > [ 3621.069686] sd 3:1:0:3: [sde] tag#226 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3621.106253] print_req_error: I/O error, dev sde, sector
> > > 276607664
> > > [ 3621.140782] sd 3:1:0:3: [sde] tag#226 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3621.170241] sd 3:1:0:3: [sde] tag#408 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > > [ 3621.202997] sd 3:1:0:3: [sde] tag#226 CDB: Read(10) 28 00 08 ba
> > > cf
> > > f2 00 00 01 00
> > > [ 3621.243870] sd 3:1:0:3: [sde] tag#408 Sense Key : Aborted
> > > Command
> > > [current]�
> > > [ 3621.280015] print_req_error: I/O error, dev sde, sector
> > > 146460658
> > > [ 3621.313941] sd 3:1:0:3: [sde] tag#408 Add. Sense: Internal
> > > target
> > > failure
> > > [ 3621.343790] print_req_error: I/O error, dev sde, sector 98830586
> > > [ 3621.376164] sd 3:1:0:3: [sde] tag#408 CDB: Read(10) 28 00 14 da
> > > 6a
> > > 53 00 00 01 00
> > > [ 3641.714842] WARNING: CPU: 3 PID: 0 at kernel/rcu/tree.c:2713
> > > rcu_process_callbacks+0x4d5/0x510
> > > [ 3641.756175] Modules linked in: sg ip6t_rpfilter ip6t_REJECT
> > > nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT
> > > nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack
> > > nf_conntrack cfg80211 rfkill ebtable_nat ebtable_broute bridge stp
> > > llc ebtable_filter ebtables ip6table_mangle ip6table_security
> > > ip6table_raw ip6table_filter ip6_tables iptable_mangle
> > > iptable_security iptable_raw iptable_filter ip_tables sb_edac
> > > x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass
> > > crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc iTCO_wdt
> > > iTCO_vendor_support aesni_intel crypto_simd glue_helper cryptd
> > > pcspkr
> > > hpilo hpwdt ioatdma shpchp ipmi_si lpc_ich dca mfd_core wmi
> > > ipmi_msghandler acpi_power_meter pcc_cpufreq uinput xfs libcrc32c
> > > mgag200 i2c_algo_bit drm_kms_helper sd_mod syscopyarea sysfillrect
> > > [ 3642.094993]��sysimgblt fb_sys_fops ttm drm crc32c_intel i2c_core
> > > tg3 hpsa scsi_transport_sas usb_storage dm_mirror dm_region_hash
> > > dm_log dm_mod dax
> > > [ 3642.158883] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.16.0-
> > > rc3+
> > > #18
> > > [ 3642.190015] Hardware name: HP ProLiant DL580 Gen8, BIOS P79
> > > 08/18/2016
> > > [ 3642.221949] RIP: 0010:rcu_process_callbacks+0x4d5/0x510
> > > [ 3642.247606] RSP: 0018:ffff8e179f6c3f08 EFLAGS: 00010002
> > > [ 3642.273087] RAX: 0000000000000000 RBX: ffff8e179f6e3180 RCX:
> > > ffff8e279d1e8918
> > > [ 3642.307426] RDX: ffffffffffffd801 RSI: ffff8e179f6c3f18 RDI:
> > > ffff8e179f6e31b8
> > > [ 3642.342219] RBP: ffffffffb70a31c0 R08: ffff8e279d1e8918 R09:
> > > 0000000000000100
> > > [ 3642.376929] R10: 0000000000000004 R11: 0000000000000005 R12:
> > > ffff8e179f6e31b8
> > > [ 3642.411598] R13: ffff8e179d20ad00 R14: 0000000000000001 R15:
> > > 7fffffffffffffff
> > > [ 3642.445957] FS:��0000000000000000(0000)
> > > GS:ffff8e179f6c0000(0000)
> > > knlGS:0000000000000000
> > > [ 3642.485599] CS:��0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 3642.513678] CR2: 00007f30917b9008 CR3: 000000054900a006 CR4:
> > > 00000000001606e0
> > > [ 3642.548189] Call Trace:
> > > [ 3642.560411]��<IRQ>
> > > [ 3642.570588]��__do_softirq+0xd1/0x275
> > > [ 3642.588643]��irq_exit+0xd5/0xe0
> > > [ 3642.604134]��smp_apic_timer_interrupt+0x60/0x120
> > > [ 3642.626752]��apic_timer_interrupt+0xf/0x20
> > > [ 3642.646712]��</IRQ>
> > > [ 3642.657330] RIP: 0010:cpuidle_enter_state+0xd4/0x260
> > > [ 3642.681389] RSP: 0018:ffffaed7c00e7ea0 EFLAGS: 00000246
> > > ORIG_RAX:
> > > ffffffffffffff12
> > > [ 3642.717937] RAX: ffff8e179f6e2280 RBX: ffffcebfbfec1bb8 RCX:
> > > 000000000000001f
> > > [ 3642.752525] RDX: 0000000000000000 RSI: ff6c3b1b90a53a78 RDI:
> > > 0000000000000000
> > > [ 3642.787181] RBP: 0000000000000003 R08: 0000000000000005 R09:
> > > 0000000000000396
> > > [ 3642.821442] R10: 00000000000003a7 R11: 0000000000000008 R12:
> > > 0000000000000003
> > > [ 3642.856381] R13: 0000034fe70ea52c R14: 0000000000000003 R15:
> > > 0000034fe71d99d4
> > > [ 3642.890830]��do_idle+0x172/0x1e0
> > > [ 3642.906714]��cpu_startup_entry+0x6f/0x80
> > > [ 3642.925835]��start_secondary+0x187/0x1e0
> > > [ 3642.944975]��secondary_startup_64+0xa5/0xb0
> > > [ 3642.965719] Code: e9 db fd ff ff 4c 89 f6 4c 89 e7 e8 96 b8 63
> > > 00
> > > e9 56 fc ff ff 0f 0b e9 34 fc ff ff 0f 0b 0f 1f 84 00 00 00 00 00
> > > e9
> > > e0 fb ff ff <0f> 0b 66 0f 1f 84 00 00 00 00 00 e9 e5 fd ff ff 0f 0b
> > > 66 0f 1f�
> > > [ 3643.056198] ---[ end trace 7bdac969b3138de7 ]---
> > > [ 3735.745955] hpsa 0000:87:00.0: SCSI status: LUN:000000c000002601
> > > CDB:12010000040000000000000000000000
> > > [ 3735.790497] hpsa 0000:87:00.0: SCSI Status = 02, Sense key =
> > > 0x05,
> > > ASC = 0x25, ASCQ = 0x00
> > > > ---
> > > > �drivers/scsi/hpsa.c | 73 +++++++++++++++++++++++++++++++++++++++
> > > > --------------
> > > > �drivers/scsi/hpsa.h |��1 +
> > > > �2 files changed, 55 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> > > > index 5293e6827ce5..3a9eca163db8 100644
> > > > --- a/drivers/scsi/hpsa.c
> > > > +++ b/drivers/scsi/hpsa.c
> > > > @@ -1045,11 +1045,7 @@ static void set_performant_mode(struct
> > > > ctlr_info
> > > > *h, struct CommandList *c,
> > > > ����������������c->busaddr |= 1 | (h->blockFetchTable[c-
> > > > > Header.SGList] << 1);
> > > > 
> > > > ����������������if (unlikely(!h->msix_vectors))
> > > > ������������������������return;
> > > > -���������������if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
> > > > -�����������������������c->Header.ReplyQueue =
> > > > -�������������������������������raw_smp_processor_id() % h-
> > > > > nreply_queues;
> > > > 
> > > > -���������������else
> > > > -�����������������������c->Header.ReplyQueue = reply_queue % h-
> > > > > nreply_queues;
> > > > 
> > > > +���������������c->Header.ReplyQueue = reply_queue;
> > > > ��������}
> > > > �}
> > > > 
> > > > @@ -1063,10 +1059,7 @@ static void
> > > > set_ioaccel1_performant_mode(struct
> > > > ctlr_info *h,
> > > > ���������* Tell the controller to post the reply to the queue for
> > > > this
> > > > ���������* processor.��This seems to give the best I/O
> > > > throughput.
> > > > ���������*/
> > > > -�������if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
> > > > -���������������cp->ReplyQueue = smp_processor_id() % h-
> > > > > nreply_queues;
> > > > 
> > > > -�������else
> > > > -���������������cp->ReplyQueue = reply_queue % h->nreply_queues;
> > > > +�������cp->ReplyQueue = reply_queue;
> > > > ��������/*
> > > > ���������* Set the bits in the address sent down to include:
> > > > ���������*��- performant mode bit (bit 0)
> > > > @@ -1087,10 +1080,7 @@ static void
> > > > set_ioaccel2_tmf_performant_mode(struct ctlr_info *h,
> > > > ��������/* Tell the controller to post the reply to the queue for
> > > > this
> > > > ���������* processor.��This seems to give the best I/O
> > > > throughput.
> > > > ���������*/
> > > > -�������if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
> > > > -���������������cp->reply_queue = smp_processor_id() % h-
> > > > > nreply_queues;
> > > > 
> > > > -�������else
> > > > -���������������cp->reply_queue = reply_queue % h->nreply_queues;
> > > > +�������cp->reply_queue = reply_queue;
> > > > ��������/* Set the bits in the address sent down to include:
> > > > ���������*��- performant mode bit not used in ioaccel mode 2
> > > > ���������*��- pull count (bits 0-3)
> > > > @@ -1109,10 +1099,7 @@ static void
> > > > set_ioaccel2_performant_mode(struct
> > > > ctlr_info *h,
> > > > ���������* Tell the controller to post the reply to the queue for
> > > > this
> > > > ���������* processor.��This seems to give the best I/O
> > > > throughput.
> > > > ���������*/
> > > > -�������if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
> > > > -���������������cp->reply_queue = smp_processor_id() % h-
> > > > > nreply_queues;
> > > > 
> > > > -�������else
> > > > -���������������cp->reply_queue = reply_queue % h->nreply_queues;
> > > > +�������cp->reply_queue = reply_queue;
> > > > ��������/*
> > > > ���������* Set the bits in the address sent down to include:
> > > > ���������*��- performant mode bit not used in ioaccel mode 2
> > > > @@ -1157,6 +1144,8 @@ static void
> > > > __enqueue_cmd_and_start_io(struct
> > > > ctlr_info *h,
> > > > �{
> > > > ��������dial_down_lockup_detection_during_fw_flash(h, c);
> > > > ��������atomic_inc(&h->commands_outstanding);
> > > > +
> > > > +�������reply_queue = h->reply_map[raw_smp_processor_id()];
> > > > ��������switch (c->cmd_type) {
> > > > ��������case CMD_IOACCEL1:
> > > > ����������������set_ioaccel1_performant_mode(h, c, reply_queue);
> > > > @@ -7376,6 +7365,26 @@ static void
> > > > hpsa_disable_interrupt_mode(struct
> > > > ctlr_info *h)
> > > > ��������h->msix_vectors = 0;
> > > > �}
> > > > 
> > > > +static void hpsa_setup_reply_map(struct ctlr_info *h)
> > > > +{
> > > > +�������const struct cpumask *mask;
> > > > +�������unsigned int queue, cpu;
> > > > +
> > > > +�������for (queue = 0; queue < h->msix_vectors; queue++) {
> > > > +���������������mask = pci_irq_get_affinity(h->pdev, queue);
> > > > +���������������if (!mask)
> > > > +�����������������������goto fallback;
> > > > +
> > > > +���������������for_each_cpu(cpu, mask)
> > > > +�����������������������h->reply_map[cpu] = queue;
> > > > +�������}
> > > > +�������return;
> > > > +
> > > > +fallback:
> > > > +�������for_each_possible_cpu(cpu)
> > > > +���������������h->reply_map[cpu] = 0;
> > > > +}
> > > > +
> > > > �/* If MSI/MSI-X is supported by the kernel we will try to enable
> > > > it on
> > > > � * controllers that are capable. If not, we use legacy INTx
> > > > mode.
> > > > � */
> > > > @@ -7771,6 +7780,10 @@ static int hpsa_pci_init(struct ctlr_info
> > > > *h)
> > > > ��������err = hpsa_interrupt_mode(h);
> > > > ��������if (err)
> > > > ����������������goto clean1;
> > > > +
> > > > +�������/* setup mapping between CPU and reply queue */
> > > > +�������hpsa_setup_reply_map(h);
> > > > +
> > > > ��������err = hpsa_pci_find_memory_BAR(h->pdev, &h->paddr);
> > > > ��������if (err)
> > > > ����������������goto clean2;����/* intmode+region, pci */
> > > > @@ -8480,6 +8493,28 @@ static struct workqueue_struct
> > > > *hpsa_create_controller_wq(struct ctlr_info *h,
> > > > ��������return wq;
> > > > �}
> > > > 
> > > > +static void hpda_free_ctlr_info(struct ctlr_info *h)
> > > > +{
> > > > +�������kfree(h->reply_map);
> > > > +�������kfree(h);
> > > > +}
> > > > +
> > > > +static struct ctlr_info *hpda_alloc_ctlr_info(void)
> > > > +{
> > > > +�������struct ctlr_info *h;
> > > > +
> > > > +�������h = kzalloc(sizeof(*h), GFP_KERNEL);
> > > > +�������if (!h)
> > > > +���������������return NULL;
> > > > +
> > > > +�������h->reply_map = kzalloc(sizeof(*h->reply_map) *
> > > > nr_cpu_ids,
> > > > GFP_KERNEL);
> > > > +�������if (!h->reply_map) {
> > > > +���������������kfree(h);
> > > > +���������������return NULL;
> > > > +�������}
> > > > +�������return h;
> > > > +}
> > > > +
> > > > �static int hpsa_init_one(struct pci_dev *pdev, const struct
> > > > pci_device_id *ent)
> > > > �{
> > > > ��������int dac, rc;
> > > > @@ -8517,7 +8552,7 @@ static int hpsa_init_one(struct pci_dev
> > > > *pdev, const
> > > > struct pci_device_id *ent)
> > > > ���������* the driver.��See comments in hpsa.h for more info.
> > > > ���������*/
> > > > ��������BUILD_BUG_ON(sizeof(struct CommandList) %
> > > > COMMANDLIST_ALIGNMENT);
> > > > -�������h = kzalloc(sizeof(*h), GFP_KERNEL);
> > > > +�������h = hpda_alloc_ctlr_info();
> > > > ��������if (!h) {
> > > > ����������������dev_err(&pdev->dev, "Failed to allocate
> > > > controller
> > > > head\n");
> > > > ����������������return -ENOMEM;
> > > > @@ -8916,7 +8951,7 @@ static void hpsa_remove_one(struct pci_dev
> > > > *pdev)
> > > > ��������h->lockup_detected = NULL;����������������������/*
> > > > init_one
> > > > 2 */
> > > > ��������/* (void) pci_disable_pcie_error_reporting(pdev);
> > > > */����/*
> > > > init_one 1 */
> > > > 
> > > > -�������kfree(h);���������������������������������������/*
> > > > init_one
> > > > 1 */
> > > > +�������hpda_free_ctlr_info(h);�������������������������/*
> > > > init_one
> > > > 1 */
> > > > �}
> > > > 
> > > > �static int hpsa_suspend(__attribute__((unused)) struct pci_dev
> > > > *pdev,
> > > > diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
> > > > index 018f980a701c..fb9f5e7f8209 100644
> > > > --- a/drivers/scsi/hpsa.h
> > > > +++ b/drivers/scsi/hpsa.h
> > > > @@ -158,6 +158,7 @@ struct bmic_controller_parameters {
> > > > �#pragma pack()
> > > > 
> > > > �struct ctlr_info {
> > > > +�������unsigned int *reply_map;
> > > > ��������int�����ctlr;
> > > > ��������char����devname[8];
> > > > ��������char����*product_name;
> > > > --
> > > > 2.9.5
> > > 
> > > 
> > 
> > I have a DL580 here with the following:
> > 
> > Ming's latest tree
> > 4.16.0-rc2.ming+
> > 
> > 3:00.0 RAID bus controller: Hewlett-Packard Company Smart Array G6
> > controllers (rev 01) P410i
> > 
> > /dev/sg0��1 0 0 0��12��HP��������P410i�������������6.60
> > /dev/sg1��1 1 0 0��0��/dev/sda��HP��������LOGICAL VOLUME����6.60
> > Boot volume
> > 
> > /dev/sg2��1 1 0 1��0��/dev/sdb��HP��������LOGICAL VOLUME����6.60
> > Single disk
> > 
> > /dev/sg3��1 1 0 2��0��/dev/sdc��HP��������LOGICAL VOLUME����6.60 �
> > 2 Disk Mirror
> > 
> > 
> > MSA50 Shelf at 6GB, all Jbods
> > 
> > 0e:00.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID SAS
> > 2208 [Thunderbolt] (rev 03)
> > 
> > /dev/sg4��0 0 43 0��0��/dev/sdd��HP��������DG072A9BB7��������HPD0
> > /dev/sg5��0 0 44 0��0��/dev/sde��HP��������DG146BABCF��������HPD5
> > /dev/sg6��0 0 45 0��0��/dev/sdf��HP��������DG146BABCF��������HPD6
> > /dev/sg7��0 0 46 0��0��/dev/sdg��HP��������EG0146FAWHU�������HPDE���
> > /dev/sg8��0 0 47 0��0��/dev/sdh��HP��������EG0146FAWHU�������HPDD
> > /dev/sg9��0 0 48 0��0��/dev/sdi��HP��������EG0146FAWHU�������HPDE
> > /dev/sg10��0 0 49 0��0��/dev/sdj��ATA�������OCZ-VERTEX4�������1.5�
> > /dev/sg11��0 0 50 0��0��/dev/sdk��ATA�������OCZ-VERTEX4�������1.5�
> > /dev/sg12��0 0 51 0��0��/dev/sdl��ATA�������INTEL SSDSC2BW08��DC32
> > /dev/sg13��0 0 52 0��13��HP��������MSA50��-10D25G1���1.20
> > 
> > I have multiple boot passes on the HPSA all passing, and have not had
> > any access issues with Ming's patches to the megaraid_sas drives
> > 
> > I dont have the decent SSD hardware to test performance on the
> > megaraid_sas to match Kashyap unfortunately.
> > 
> > What I can say is that so far all boot testing has passed.
> > 
> > I will exercise all the drives now to see if I can bring about any
> > issues seen by Don
> > 
> > Thanks
> > Laurence
> 
> Don,
> 
> I am not seeing any issues with Ming's V3
> 
> So Ming's latest V3 is rock solid for me through multiple fio runs on
> the DL580 here.
> On both megaraid_sas and hpsa
> 
> Using
> BOOT_IMAGE=/vmlinuz-4.16.0-rc2.ming+ root=UUID=43f86d71-b1bf-4789-a28e-
> 21c6ddc90195 ro crashkernel=256M@64M log_buf_len=64M
> console=ttyS1,115200n8 scsi_mod.use_blk_mq=y dm_mod.use_blk_mq=y

Hi Laurence,

Thanks for your test!

Seems Don run into IO failure without blk-mq, could you run your tests again
in legacy mode?

Thanks,
Ming
