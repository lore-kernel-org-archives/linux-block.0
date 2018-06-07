Return-Path: <liwan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel> <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Jun 2018 14:26:35 +0800
Message-ID: <CAEemH2c87NPib_=BhihJu0gboKRbB4cSQyPur6G8-vxSS61mKw@mail.gmail.com>
Subject: Re: Block IO issue in kernel-v4.17
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Coly Li <colyli@suse.de>, hch@lst.de,
	darrick.wong@oracle.com, snitzer@redhat.com, linux-block@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="00000000000081949c056e075d79"
List-ID: <linux-block@vger.kernel.org>

--00000000000081949c056e075d79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 6, 2018 at 10:18 PM, Jens Axboe <axboe@kernel.dk> wrote:

> On 6/6/18 2:41 AM, Kent Overstreet wrote:
> > On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:
> >> Hi BIO experts,
> >>
> >> I catch this panic issue on some kind of arches(x86_64, ppc64,
> >> ppc64le..), it seems the root cause is very probably from BIO changes
> >> from kernel-4.17-rc7. Plz take a look.
> >
> > That's the bioset changes, the fix is out and on its way in
>
> It's already in mainline, since about lunch time yesterday.
>

Do you mean this commit?

commit d377535405686f735b90a8ad4ba269484cd7c96e
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Tue Jun 5 05:26:33 2018 -0400

    dm: Use kzalloc for all structs with embedded biosets/mempools


Unfortunately, I pull the latest mainline kernel and test, still hit the
panic. :(=E2=80=8B

=E2=80=8B

[   21.832230] ------------[ cut here ]------------
[   21.832244] list_add corruption. next->prev should be prev
(c00000045f5801b0), but was 0000000000000000. (next=3Dc000000461b2d5b8).
[   21.832265] WARNING: CPU: 12 PID: 2499 at lib/list_debug.c:25
.__list_add_valid+0xac/0xc0
[   21.832270] Modules linked in: sunrpc nx_crypto sg pseries_rng xts
vmx_crypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp
ibmveth dm_mirror dm_region_hash dm_log dm_mod
[   21.832295] CPU: 12 PID: 2499 Comm: stress Not tainted 4.17.0 #1
[   21.832300] NIP:  c0000000005021dc LR: c0000000005021d8 CTR:
00000000013abb8c
[   21.832304] REGS: c0000004623926d0 TRAP: 0700   Not tainted  (4.17.0)
[   21.832308] MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR:
42244822  XER: 00000006
[   21.832318] CFAR: c0000000000f93f0 SOFTE: 1
[   21.832318] GPR00: c0000000005021d8 c000000462392950
c0000000013ac100 0000000000000075
[   21.832318] GPR04: 0000000000000001 000000005b2baea6
0000000000000000 0000000000000000
[   21.832318] GPR08: 0000000000000001 0000000000000007
0000000000000006 000000000000017f
[   21.832318] GPR12: 0000000028244824 c00000001ebddc00
0000000000000000 c000000461ccb800
[   21.832318] GPR16: f00000000113d1e0 c0000004623931f0
0000000000000000 f00000000113d1c0
[   21.832318] GPR20: 0000000000000000 0000000000000000
0000000000000000 c000000462393360
[   21.832318] GPR24: 0000000000000000 c00000045f5801b0
c000000461b2d5b8 0000000000000001
[   21.832318] GPR28: 0000000000000002 c000000462392af8
c00000045f5801a8 c000000462392ae0
[   21.832372] NIP [c0000000005021dc] .__list_add_valid+0xac/0xc0
[   21.832377] LR [c0000000005021d8] .__list_add_valid+0xa8/0xc0
[   21.832381] Call Trace:
[   21.832385] [c000000462392950] [c0000000005021d8]
.__list_add_valid+0xa8/0xc0 (unreliable)
[   21.832393] [c0000004623929c0] [c000000000159b28] .prepare_to_wait+0xc8/=
0xf0
[   21.832400] [c000000462392a70] [c000000000268720] .mempool_alloc+0x180/0=
x1d0
[   21.832407] [c000000462392b50] [c000000000496ee4]
.bio_alloc_bioset+0x1c4/0x2b0
[   21.832422] [c000000462392c20] [d0000000045f1578]
.alloc_io+0x38/0x170 [dm_mod]
[   21.832435] [c000000462392cc0] [d0000000045f3824]
.__split_and_process_bio+0x34/0x1e0 [dm_mod]
[   21.832449] [c000000462392d80] [d0000000045f17bc]
.__dm_make_request+0x6c/0x100 [dm_mod]
[   21.832455] [c000000462392e20] [c0000000004a3368]
.generic_make_request+0x1e8/0x420
[   21.832460] [c000000462392ee0] [c0000000004a3654] .submit_bio+0xb4/0x1c0
[   21.832466] [c000000462392fa0] [c0000000002d74c4]
.__swap_writepage+0x394/0x540
[   21.832472] [c000000462393090] [c000000000284ed8]
.pageout.isra.36+0x288/0x490
[   21.832478] [c000000462393180] [c000000000287928]
.shrink_page_list+0x948/0x1090
[   21.832484] [c0000004623932f0] [c000000000288b8c]
.shrink_inactive_list+0x2ec/0x720
[   21.832490] [c000000462393400] [c0000000002897c8]
.shrink_node_memcg+0x238/0x7d0
[   21.832495] [c000000462393550] [c000000000289eb8] .shrink_node+0x158/0x5=
e0
[   21.832501] [c000000462393670] [c00000000028a838]
.do_try_to_free_pages+0x118/0x4e0
[   21.832507] [c000000462393760] [c00000000028ad08]
.try_to_free_pages+0x108/0x290
[   21.832512] [c000000462393860] [c000000000272508]
.__alloc_pages_nodemask+0x638/0xf90
[   21.832518] [c000000462393a40] [c0000000002f15c8]
.alloc_pages_vma+0x98/0x240
[   21.832524] [c000000462393b00] [c0000000002ba560]
.__handle_mm_fault+0xbc0/0x1900
[   21.832530] [c000000462393c30] [c0000000002bb408]
.handle_mm_fault+0x168/0x280
[   21.832535] [c000000462393cc0] [c000000000061cd4]
.__do_page_fault+0x1c4/0x9b0
[   21.832539] [c000000462393da0] [c0000000000624e8] .do_page_fault+0x28/0x=
b0
[   21.832544] [c000000462393e30] [c00000000000a634]
handle_page_fault+0x18/0x38
[   21.832548] Instruction dump:
[   21.832551] 38630948 7d264b78 4bbf71dd 60000000 0fe00000 38600000
4bffffac 3c62ff8c
[   21.832558] 7d254b78 386308e0 4bbf71bd 60000000 <0fe00000> 38600000
4bffff8c 60000000
[   21.832565] ---[ end trace c4d85974c8ca08fa ]---
[   21.832569] ------------[ cut here ]------------
[   21.832573] list_add corruption. next->prev should be prev
(c00000045f5801b0), but was 0000000000000000. (next=3Dc000000461b2d5b8).
[   21.832584] WARNING: CPU: 10 PID: 109 at lib/list_debug.c:25
.__list_add_valid+0xac/0xc0
[   21.832589] Modules linked in: sunrpc nx_crypto sg pseries_rng xts
vmx_crypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp
ibmveth dm_mirror dm_region_hash dm_log dm_mod
[   21.832609] CPU: 10 PID: 109 Comm: kswapd0 Tainted: G        W
   4.17.0 #1
[   21.832613] NIP:  c0000000005021dc LR: c0000000005021d8 CTR:
00000000013abb8c
[   21.832617] REGS: c000000472d2eb70 TRAP: 0700   Tainted: G        W
         (4.17.0)
[   21.832621] MSR:  800000010282b032
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,TM[E]>  CR: 42004022  XER: 00000006
[   21.832632] CFAR: c0000000000f93f0 SOFTE: 1
[   21.832632] GPR00: c0000000005021d8 c000000472d2edf0
c0000000013ac100 0000000000000075
[   21.832632] GPR04: 0000000000000001 000000005b2bafba
0000000000000000 0000000000000000
[   21.832632] GPR08: 0000000000000001 0000000000000007
0000000000000006 00000000000001a7
[   21.832632] GPR12: 0000000028004024 c00000001ebf1200
0000000000000000 c000000461ccb800
[   21.832632] GPR16: f000000001131de0 c000000472d2f690
0000000000000000 f000000001131dc0
[   21.832632] GPR20: 0000000000000000 0000000000000000
0000000000000000 c000000472d2f800
[   21.832632] GPR24: 0000000000000000 c00000045f5801b0
c000000461b2d5b8 0000000000000001
[   21.832632] GPR28: 0000000000000002 c000000472d2ef98
c00000045f5801a8 c000000472d2ef80
[   21.832675] NIP [c0000000005021dc] .__list_add_valid+0xac/0xc0
[   21.832679] LR [c0000000005021d8] .__list_add_valid+0xa8/0xc0
[   21.832682] Call Trace:
[   21.832684] [c000000472d2edf0] [c0000000005021d8]
.__list_add_valid+0xa8/0xc0 (unreliable)
[   21.832689] [c000000472d2ee60] [c000000000159b28] .prepare_to_wait+0xc8/=
0xf0
[   21.832692] [c000000472d2ef10] [c000000000268720] .mempool_alloc+0x180/0=
x1d0
[   21.832697] [c000000472d2eff0] [c000000000496ee4]
.bio_alloc_bioset+0x1c4/0x2b0
[   21.832707] [c000000472d2f0c0] [d0000000045f1578]
.alloc_io+0x38/0x170 [dm_mod]
[   21.832716] [c000000472d2f160] [d0000000045f3824]
.__split_and_process_bio+0x34/0x1e0 [dm_mod]
[   21.832727] [c000000472d2f220] [d0000000045f17bc]
.__dm_make_request+0x6c/0x100 [dm_mod]
[   21.832731] [c000000472d2f2c0] [c0000000004a3368]
.generic_make_request+0x1e8/0x420
[   21.832735] [c000000472d2f380] [c0000000004a3654] .submit_bio+0xb4/0x1c0
[   21.832739] [c000000472d2f440] [c0000000002d74c4]
.__swap_writepage+0x394/0x540
[   21.832743] [c000000472d2f530] [c000000000284ed8]
.pageout.isra.36+0x288/0x490
[   21.832747] [c000000472d2f620] [c000000000287928]
.shrink_page_list+0x948/0x1090
[   21.832751] [c000000472d2f790] [c000000000288b8c]
.shrink_inactive_list+0x2ec/0x720
[   21.832755] [c000000472d2f8a0] [c0000000002897c8]
.shrink_node_memcg+0x238/0x7d0
[   21.832760] [c000000472d2f9f0] [c000000000289eb8] .shrink_node+0x158/0x5=
e0
[   21.832763] [c000000472d2fb10] [c00000000028b590] .balance_pgdat+0x200/0=
x470
[   21.832767] [c000000472d2fc50] [c00000000028b9bc] .kswapd+0x1bc/0x5f0
[   21.832771] [c000000472d2fd70] [c000000000124d78] .kthread+0x158/0x1a0
[   21.832776] [c000000472d2fe30] [c00000000000b654]
.ret_from_kernel_thread+0x58/0x84
[   21.832779] Instruction dump:
[   21.832781] 38630948 7d264b78 4bbf71dd 60000000 0fe00000 38600000
4bffffac 3c62ff8c
[   21.832787] 7d254b78 386308e0 4bbf71bd 60000000 <0fe00000> 38600000
4bffff8c 60000000
[   21.832792] ---[ end trace c4d85974c8ca08fb ]---
[   21.833118] Unable to handle kernel paging request for instruction fetch
[   21.833121] Faulting instruction address: 0x00000000
[   21.833127] Oops: Kernel access of bad area, sig: 11 [#1]
[   21.833129] BE SMP NR_CPUS=3D2048 NUMA pSeries
[   21.833134] Modules linked in: sunrpc nx_crypto sg pseries_rng xts
vmx_crypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp
ibmveth dm_mirror dm_region_hash dm_log dm_mod
[   21.833148] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G        W
    4.17.0 #1
[   21.833151] NIP:  0000000000000000 LR: c000000000159e8c CTR:
0000000000000000
[   21.833155] REGS: c00000047ff93260 TRAP: 0400   Tainted: G        W
         (4.17.0)
[   21.833158] MSR:  8000000040009032 <SF,EE,ME,IR,DR,RI>  CR:
24028028  XER: 20000006
[   21.833166] CFAR: c000000000008874 SOFTE: 1
[   21.833166] GPR00: c00000000015a09c c00000047ff934e0
0000000000000000 c000000461b2d5a0
[   21.833166] GPR04: 0000000000000003 0000000000000000
0000000000000000 0000000000000000
[   21.833166] GPR08: c00000047ff93610 c000000479ae7880
0000000000000000 d000000004606758
[   21.833166] GPR12: 0000000024022022 c00000001ebf1200
c000000474557f90 0000000000200042
[   21.833166] GPR16: 00000000ffff9358 c00000047ff90000
0000000000000000 0000000000000001
[   21.833166] GPR20: c000000000df7080 0000000000000005
c00000047ff93610 0000000000000001
[   21.833166] GPR24: 0000000000000000 0000000000000000
0000000000000003 0000000000000000
[   21.833166] GPR28: c00000045f5801b0 0000000000000000
c000000461b2d5a0 ffffffffffffffe8
[   21.833208] NIP [0000000000000000]           (null)
[   21.833212] LR [c000000000159e8c] .__wake_up_common+0xdc/0x240
[   21.833215] Call Trace:
[   21.833217] [c00000047ff934e0] [c00000047ff935c0]
0xc00000047ff935c0 (unreliable)
[   21.833222] [c00000047ff935a0] [c00000000015a09c]
.__wake_up_common_lock+0xac/0x100
[   21.833227] [c00000047ff93680] [c000000000267dc8] .mempool_free+0xc8/0xe=
0
[   21.833232] [c00000047ff93700] [c0000000004971ac] .bio_free+0x4c/0xa0
[   21.833242] [c00000047ff93780] [d0000000045f1998]
.dec_pending+0x128/0x310 [dm_mod]
[   21.833253] [c00000047ff93850] [d0000000045f1edc]
.clone_endio+0xcc/0x180 [dm_mod]
[   21.833258] [c00000047ff938e0] [c000000000498c84] .bio_endio+0x184/0x290
[   21.833262] [c00000047ff93990] [c0000000004a3d20]
.blk_update_request+0xf0/0x4a0
[   21.833267] [c00000047ff93a40] [c000000000642ae8]
.scsi_end_request+0x48/0x270
[   21.833272] [c00000047ff93af0] [c000000000642f44]
.scsi_io_completion+0x234/0x710
[   21.833277] [c00000047ff93bd0] [c000000000637cc8]
.scsi_finish_command+0x148/0x1b0
[   21.833282] [c00000047ff93c60] [c000000000641e18]
.scsi_softirq_done+0x198/0x1f0
[   21.833286] [c00000047ff93d00] [c0000000004aee24]
.blk_done_softirq+0xc4/0xf0
[   21.833292] [c00000047ff93d90] [c0000000009829a0] .__do_softirq+0x150/0x=
3a8
[   21.833297] [c00000047ff93e90] [c000000000101d68] .irq_exit+0x198/0x1b0
[   21.833302] [c00000047ff93f10] [c000000000016024] .__do_irq+0x94/0x1f0
[   21.833306] [c00000047ff93f90] [c00000000002779c] .call_do_irq+0x14/0x24
[   21.833311] [c0000004745577a0] [c00000000001620c] .do_IRQ+0x8c/0x100
[   21.833315] [c000000474557840] [c000000000008c24]
hardware_interrupt_common+0x114/0x120
[   21.833323] --- interrupt: 501 at .plpar_hcall_norets+0x14/0x20
[   21.833323]     LR =3D .check_and_cede_processor+0x24/0x40
[   21.833328] [c000000474557b30] [7fffffffffffffff]
0x7fffffffffffffff (unreliable)
[   21.833333] [c000000474557ba0] [c00000000076565c]
.dedicated_cede_loop+0x4c/0x130
[   21.833339] [c000000474557c20] [c000000000762d9c]
.cpuidle_enter_state+0xac/0x390
[   21.833343] [c000000474557cd0] [c00000000013b8cc] .call_cpuidle+0x3c/0x7=
0
[   21.833348] [c000000474557d40] [c00000000013be38] .do_idle+0x2e8/0x390
[   21.833352] [c000000474557e20] [c00000000013c098]
.cpu_startup_entry+0x28/0x30
[   21.833357] [c000000474557ea0] [c000000000046980]
.start_secondary+0x4d0/0x520
[   21.833362] [c000000474557f90] [c00000000000ab70]
start_secondary_prolog+0x10/0x14
[   21.833366] Instruction dump:
[   21.833369] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX
[   21.833374] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX
[   21.833382] ---[ end trace c4d85974c8ca08fc ]---
[   21.835408]
[   22.835471] Kernel panic - not syncing: Fatal exception in interrupt
[   23.884733] WARNING: CPU: 10 PID: 0 at drivers/tty/vt/vt.c:3885
.do_unblank_screen+0x268/0x270
[   23.884740] Modules linked in: sunrpc nx_crypto sg pseries_rng xts
vmx_crypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp
ibmveth dm_mirror dm_region_hash dm_log dm_mod
[   23.884766] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G      D W
    4.17.0 #1
[   23.884772] NIP:  c0000000005bb758 LR: c0000000005bb524 CTR:
c00000000002ae00
[   23.884778] REGS: c00000047ff92cc0 TRAP: 0700   Tainted: G      D W
         (4.17.0)
[   23.884783] MSR:  8000000000021032 <SF,ME,IR,DR,RI>  CR: 48022042
XER: 00000009
[   23.884794] CFAR: c0000000005bb538 SOFTE: 1
[   23.884794] GPR00: c0000000005bb714 c00000047ff92f40
c0000000013ac100 0000000000000000
[   23.884794] GPR04: 0000000000000001 000000000000000b
0000000020646d5f 6d5f726567696f6e
[   23.884794] GPR08: c00000000168c100 0000000000000000
0000000000000000 6e67207874732076
[   23.884794] GPR12: 0000000088022044 c00000001ebf1200
c000000474557f90 0000000000200042
[   23.884794] GPR16: 00000000ffff9358 c00000047ff90000
0000000000000000 0000000000000001
[   23.884794] GPR20: c000000000df7080 0000000000000005
c00000047ff93610 0000000000000001
[   23.884794] GPR24: 0000000000000000 0000000000000000
c0000000011da080 c0000000015767c0
[   23.884794] GPR28: c000000001576798 0000000000000000
c000000001685340 c0000000015767c0
[   23.884863] NIP [c0000000005bb758] .do_unblank_screen+0x268/0x270
[   23.884868] LR [c0000000005bb524] .do_unblank_screen+0x34/0x270
[   23.884873] Call Trace:
[   23.884877] [c00000047ff92f40] [c0000000005bb714]
.do_unblank_screen+0x224/0x270 (unreliable)
[   23.884887] [c00000047ff92fd0] [c0000000004e88a0] .bust_spinlocks+0x30/0=
x70
[   23.884894] [c00000047ff93040] [c0000000000f9cf8] .panic+0x1b0/0x308
[   23.884901] [c00000047ff930e0] [c000000000022e5c] .oops_end+0x1cc/0x1e0
[   23.884908] [c00000047ff93170] [c000000000062648] .bad_page_fault+0xd8/0=
x144
[   23.884916] [c00000047ff931f0] [c00000000000a650]
handle_page_fault+0x34/0x38
[   23.884924] --- interrupt: 400 at           (null)
[   23.884924]     LR =3D .__wake_up_common+0xdc/0x240
[   23.884932] [c00000047ff934e0] [c00000047ff935c0]
0xc00000047ff935c0 (unreliable)
[   23.884940] [c00000047ff935a0] [c00000000015a09c]
.__wake_up_common_lock+0xac/0x100
[   23.884948] [c00000047ff93680] [c000000000267dc8] .mempool_free+0xc8/0xe=
0
[   23.884955] [c00000047ff93700] [c0000000004971ac] .bio_free+0x4c/0xa0
[   23.884973] [c00000047ff93780] [d0000000045f1998]
.dec_pending+0x128/0x310 [dm_mod]
[   23.884991] [c00000047ff93850] [d0000000045f1edc]
.clone_endio+0xcc/0x180 [dm_mod]
[   23.884998] [c00000047ff938e0] [c000000000498c84] .bio_endio+0x184/0x290
[   23.885005] [c00000047ff93990] [c0000000004a3d20]
.blk_update_request+0xf0/0x4a0
[   23.885013] [c00000047ff93a40] [c000000000642ae8]
.scsi_end_request+0x48/0x270
[   23.885020] [c00000047ff93af0] [c000000000642f44]
.scsi_io_completion+0x234/0x710
[   23.885028] [c00000047ff93bd0] [c000000000637cc8]
.scsi_finish_command+0x148/0x1b0
[   23.885035] [c00000047ff93c60] [c000000000641e18]
.scsi_softirq_done+0x198/0x1f0
[   23.885042] [c00000047ff93d00] [c0000000004aee24]
.blk_done_softirq+0xc4/0xf0
[   23.885051] [c00000047ff93d90] [c0000000009829a0] .__do_softirq+0x150/0x=
3a8
[   23.885058] [c00000047ff93e90] [c000000000101d68] .irq_exit+0x198/0x1b0
[   23.885065] [c00000047ff93f10] [c000000000016024] .__do_irq+0x94/0x1f0
[   23.885072] [c00000047ff93f90] [c00000000002779c] .call_do_irq+0x14/0x24
[   23.885079] [c0000004745577a0] [c00000000001620c] .do_IRQ+0x8c/0x100
[   23.885086] [c000000474557840] [c000000000008c24]
hardware_interrupt_common+0x114/0x120
[   23.885096] --- interrupt: 501 at .plpar_hcall_norets+0x14/0x20
[   23.885096]     LR =3D .check_and_cede_processor+0x24/0x40
[   23.885104] [c000000474557b30] [7fffffffffffffff]
0x7fffffffffffffff (unreliable)
[   23.885112] [c000000474557ba0] [c00000000076565c]
.dedicated_cede_loop+0x4c/0x130
[   23.885120] [c000000474557c20] [c000000000762d9c]
.cpuidle_enter_state+0xac/0x390
[   23.885128] [c000000474557cd0] [c00000000013b8cc] .call_cpuidle+0x3c/0x7=
0
[   23.885134] [c000000474557d40] [c00000000013be38] .do_idle+0x2e8/0x390
[   23.885141] [c000000474557e20] [c00000000013c098]
.cpu_startup_entry+0x28/0x30
[   23.885148] [c000000474557ea0] [c000000000046980]
.start_secondary+0x4d0/0x520
[   23.885156] [c000000474557f90] [c00000000000ab70]
start_secondary_prolog+0x10/0x14
[   23.885162] Instruction dump:
[   23.885167] 39487a00 3c62ffe7 3863aab0 e94a0000 7d2407b4 7c845214
4bbd6671 60000000
[   23.885178] 39200001 3d42003f 912a2080 4bfffe60 <0fe00000> 4bfffde0
38600000 4bfffd8c
[   23.885189] ---[ end trace c4d85974c8ca08fd ]---

=E2=80=8B



>
>
> --
> Jens Axboe
>
>


--=20
Regards,
Li Wang

--00000000000081949c056e075d79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"><br=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Ju=
n 6, 2018 at 10:18 PM, Jens Axboe <span dir=3D"ltr">&lt;<a href=3D"mailto:a=
xboe@kernel.dk" target=3D"_blank">axboe@kernel.dk</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"gmail-HOEnZ=
b"><div class=3D"gmail-h5">On 6/6/18 2:41 AM, Kent Overstreet wrote:<br>
&gt; On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:<br>
&gt;&gt; Hi BIO experts,<br>
&gt;&gt;<br>
&gt;&gt; I catch this panic issue on some kind of arches(x86_64, ppc64,<br>
&gt;&gt; ppc64le..), it seems the root cause is very probably from BIO chan=
ges<br>
&gt;&gt; from kernel-4.17-rc7. Plz take a look.<br>
&gt; <br>
&gt; That&#39;s the bioset changes, the fix is out and on its way in<br>
<br>
</div></div>It&#39;s already in mainline, since about lunch time yesterday.=
<br></blockquote><div><br></div><div><div style=3D"font-size:small" class=
=3D"gmail_default">Do you mean this commit?</div><div style=3D"font-size:sm=
all" class=3D"gmail_default"><br></div><div style=3D"font-size:small" class=
=3D"gmail_default">commit d377535405686f735b90a8ad4ba269484cd7c96e<br>Autho=
r: Kent Overstreet &lt;<a href=3D"mailto:kent.overstreet@gmail.com">kent.ov=
erstreet@gmail.com</a>&gt;<br>Date:=C2=A0=C2=A0 Tue Jun 5 05:26:33 2018 -04=
00<br><br>=C2=A0=C2=A0=C2=A0 dm: Use kzalloc for all structs with embedded =
biosets/mempools<br></div><div style=3D"font-size:small" class=3D"gmail_def=
ault"><br></div><div style=3D"font-size:small" class=3D"gmail_default"><br>=
</div><div style=3D"font-size:small" class=3D"gmail_default">Unfortunately,=
 I pull the latest mainline kernel and test, still hit the panic. :(=E2=80=
=8B</div></div><div><br></div><div><div style=3D"font-size:small" class=3D"=
gmail_default">=E2=80=8B<pre>[   21.832230] ------------[ cut here ]-------=
-----=20
[   21.832244] list_add corruption. next-&gt;prev should be prev (c00000045=
f5801b0), but was 0000000000000000. (next=3Dc000000461b2d5b8).=20
[   21.832265] WARNING: CPU: 12 PID: 2499 at lib/list_debug.c:25 .__list_ad=
d_valid+0xac/0xc0=20
[   21.832270] Modules linked in: sunrpc nx_crypto sg pseries_rng xts vmx_c=
rypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp ibmveth dm=
_mirror dm_region_hash dm_log dm_mod=20
[   21.832295] CPU: 12 PID: 2499 Comm: stress Not tainted 4.17.0 #1=20
[   21.832300] NIP:  c0000000005021dc LR: c0000000005021d8 CTR: 00000000013=
abb8c=20
[   21.832304] REGS: c0000004623926d0 TRAP: 0700   Not tainted  (4.17.0)=20
[   21.832308] MSR:  8000000000029032 &lt;SF,EE,ME,IR,DR,RI&gt;  CR: 422448=
22  XER: 00000006=20
[   21.832318] CFAR: c0000000000f93f0 SOFTE: 1 =20
[   21.832318] GPR00: c0000000005021d8 c000000462392950 c0000000013ac100 00=
00000000000075 =20
[   21.832318] GPR04: 0000000000000001 000000005b2baea6 0000000000000000 00=
00000000000000 =20
[   21.832318] GPR08: 0000000000000001 0000000000000007 0000000000000006 00=
0000000000017f =20
[   21.832318] GPR12: 0000000028244824 c00000001ebddc00 0000000000000000 c0=
00000461ccb800 =20
[   21.832318] GPR16: f00000000113d1e0 c0000004623931f0 0000000000000000 f0=
0000000113d1c0 =20
[   21.832318] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0=
00000462393360 =20
[   21.832318] GPR24: 0000000000000000 c00000045f5801b0 c000000461b2d5b8 00=
00000000000001 =20
[   21.832318] GPR28: 0000000000000002 c000000462392af8 c00000045f5801a8 c0=
00000462392ae0 =20
[   21.832372] NIP [c0000000005021dc] .__list_add_valid+0xac/0xc0=20
[   21.832377] LR [c0000000005021d8] .__list_add_valid+0xa8/0xc0=20
[   21.832381] Call Trace:=20
[   21.832385] [c000000462392950] [c0000000005021d8] .__list_add_valid+0xa8=
/0xc0 (unreliable)=20
[   21.832393] [c0000004623929c0] [c000000000159b28] .prepare_to_wait+0xc8/=
0xf0=20
[   21.832400] [c000000462392a70] [c000000000268720] .mempool_alloc+0x180/0=
x1d0=20
[   21.832407] [c000000462392b50] [c000000000496ee4] .bio_alloc_bioset+0x1c=
4/0x2b0=20
[   21.832422] [c000000462392c20] [d0000000045f1578] .alloc_io+0x38/0x170 [=
dm_mod]=20
[   21.832435] [c000000462392cc0] [d0000000045f3824] .__split_and_process_b=
io+0x34/0x1e0 [dm_mod]=20
[   21.832449] [c000000462392d80] [d0000000045f17bc] .__dm_make_request+0x6=
c/0x100 [dm_mod]=20
[   21.832455] [c000000462392e20] [c0000000004a3368] .generic_make_request+=
0x1e8/0x420=20
[   21.832460] [c000000462392ee0] [c0000000004a3654] .submit_bio+0xb4/0x1c0=
=20
[   21.832466] [c000000462392fa0] [c0000000002d74c4] .__swap_writepage+0x39=
4/0x540=20
[   21.832472] [c000000462393090] [c000000000284ed8] .pageout.isra.36+0x288=
/0x490=20
[   21.832478] [c000000462393180] [c000000000287928] .shrink_page_list+0x94=
8/0x1090=20
[   21.832484] [c0000004623932f0] [c000000000288b8c] .shrink_inactive_list+=
0x2ec/0x720=20
[   21.832490] [c000000462393400] [c0000000002897c8] .shrink_node_memcg+0x2=
38/0x7d0=20
[   21.832495] [c000000462393550] [c000000000289eb8] .shrink_node+0x158/0x5=
e0=20
[   21.832501] [c000000462393670] [c00000000028a838] .do_try_to_free_pages+=
0x118/0x4e0=20
[   21.832507] [c000000462393760] [c00000000028ad08] .try_to_free_pages+0x1=
08/0x290=20
[   21.832512] [c000000462393860] [c000000000272508] .__alloc_pages_nodemas=
k+0x638/0xf90=20
[   21.832518] [c000000462393a40] [c0000000002f15c8] .alloc_pages_vma+0x98/=
0x240=20
[   21.832524] [c000000462393b00] [c0000000002ba560] .__handle_mm_fault+0xb=
c0/0x1900=20
[   21.832530] [c000000462393c30] [c0000000002bb408] .handle_mm_fault+0x168=
/0x280=20
[   21.832535] [c000000462393cc0] [c000000000061cd4] .__do_page_fault+0x1c4=
/0x9b0=20
[   21.832539] [c000000462393da0] [c0000000000624e8] .do_page_fault+0x28/0x=
b0=20
[   21.832544] [c000000462393e30] [c00000000000a634] handle_page_fault+0x18=
/0x38=20
[   21.832548] Instruction dump:=20
[   21.832551] 38630948 7d264b78 4bbf71dd 60000000 0fe00000 38600000 4bffff=
ac 3c62ff8c =20
[   21.832558] 7d254b78 386308e0 4bbf71bd 60000000 &lt;0fe00000&gt; 3860000=
0 4bffff8c 60000000 =20
[   21.832565] ---[ end trace c4d85974c8ca08fa ]---=20
[   21.832569] ------------[ cut here ]------------=20
[   21.832573] list_add corruption. next-&gt;prev should be prev (c00000045=
f5801b0), but was 0000000000000000. (next=3Dc000000461b2d5b8).=20
[   21.832584] WARNING: CPU: 10 PID: 109 at lib/list_debug.c:25 .__list_add=
_valid+0xac/0xc0=20
[   21.832589] Modules linked in: sunrpc nx_crypto sg pseries_rng xts vmx_c=
rypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp ibmveth dm=
_mirror dm_region_hash dm_log dm_mod=20
[   21.832609] CPU: 10 PID: 109 Comm: kswapd0 Tainted: G        W         4=
.17.0 #1=20
[   21.832613] NIP:  c0000000005021dc LR: c0000000005021d8 CTR: 00000000013=
abb8c=20
[   21.832617] REGS: c000000472d2eb70 TRAP: 0700   Tainted: G        W     =
     (4.17.0)=20
[   21.832621] MSR:  800000010282b032 &lt;SF,VEC,VSX,EE,FP,ME,IR,DR,RI,TM[E=
]&gt;  CR: 42004022  XER: 00000006=20
[   21.832632] CFAR: c0000000000f93f0 SOFTE: 1 =20
[   21.832632] GPR00: c0000000005021d8 c000000472d2edf0 c0000000013ac100 00=
00000000000075 =20
[   21.832632] GPR04: 0000000000000001 000000005b2bafba 0000000000000000 00=
00000000000000 =20
[   21.832632] GPR08: 0000000000000001 0000000000000007 0000000000000006 00=
000000000001a7 =20
[   21.832632] GPR12: 0000000028004024 c00000001ebf1200 0000000000000000 c0=
00000461ccb800 =20
[   21.832632] GPR16: f000000001131de0 c000000472d2f690 0000000000000000 f0=
00000001131dc0 =20
[   21.832632] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0=
00000472d2f800 =20
[   21.832632] GPR24: 0000000000000000 c00000045f5801b0 c000000461b2d5b8 00=
00000000000001 =20
[   21.832632] GPR28: 0000000000000002 c000000472d2ef98 c00000045f5801a8 c0=
00000472d2ef80 =20
[   21.832675] NIP [c0000000005021dc] .__list_add_valid+0xac/0xc0=20
[   21.832679] LR [c0000000005021d8] .__list_add_valid+0xa8/0xc0=20
[   21.832682] Call Trace:=20
[   21.832684] [c000000472d2edf0] [c0000000005021d8] .__list_add_valid+0xa8=
/0xc0 (unreliable)=20
[   21.832689] [c000000472d2ee60] [c000000000159b28] .prepare_to_wait+0xc8/=
0xf0=20
[   21.832692] [c000000472d2ef10] [c000000000268720] .mempool_alloc+0x180/0=
x1d0=20
[   21.832697] [c000000472d2eff0] [c000000000496ee4] .bio_alloc_bioset+0x1c=
4/0x2b0=20
[   21.832707] [c000000472d2f0c0] [d0000000045f1578] .alloc_io+0x38/0x170 [=
dm_mod]=20
[   21.832716] [c000000472d2f160] [d0000000045f3824] .__split_and_process_b=
io+0x34/0x1e0 [dm_mod]=20
[   21.832727] [c000000472d2f220] [d0000000045f17bc] .__dm_make_request+0x6=
c/0x100 [dm_mod]=20
[   21.832731] [c000000472d2f2c0] [c0000000004a3368] .generic_make_request+=
0x1e8/0x420=20
[   21.832735] [c000000472d2f380] [c0000000004a3654] .submit_bio+0xb4/0x1c0=
=20
[   21.832739] [c000000472d2f440] [c0000000002d74c4] .__swap_writepage+0x39=
4/0x540=20
[   21.832743] [c000000472d2f530] [c000000000284ed8] .pageout.isra.36+0x288=
/0x490=20
[   21.832747] [c000000472d2f620] [c000000000287928] .shrink_page_list+0x94=
8/0x1090=20
[   21.832751] [c000000472d2f790] [c000000000288b8c] .shrink_inactive_list+=
0x2ec/0x720=20
[   21.832755] [c000000472d2f8a0] [c0000000002897c8] .shrink_node_memcg+0x2=
38/0x7d0=20
[   21.832760] [c000000472d2f9f0] [c000000000289eb8] .shrink_node+0x158/0x5=
e0=20
[   21.832763] [c000000472d2fb10] [c00000000028b590] .balance_pgdat+0x200/0=
x470=20
[   21.832767] [c000000472d2fc50] [c00000000028b9bc] .kswapd+0x1bc/0x5f0=20
[   21.832771] [c000000472d2fd70] [c000000000124d78] .kthread+0x158/0x1a0=
=20
[   21.832776] [c000000472d2fe30] [c00000000000b654] .ret_from_kernel_threa=
d+0x58/0x84=20
[   21.832779] Instruction dump:=20
[   21.832781] 38630948 7d264b78 4bbf71dd 60000000 0fe00000 38600000 4bffff=
ac 3c62ff8c =20
[   21.832787] 7d254b78 386308e0 4bbf71bd 60000000 &lt;0fe00000&gt; 3860000=
0 4bffff8c 60000000 =20
[   21.832792] ---[ end trace c4d85974c8ca08fb ]---=20
[   21.833118] Unable to handle kernel paging request for instruction fetch=
=20
[   21.833121] Faulting instruction address: 0x00000000=20
[   21.833127] Oops: Kernel access of bad area, sig: 11 [#1]=20
[   21.833129] BE SMP NR_CPUS=3D2048 NUMA pSeries=20
[   21.833134] Modules linked in: sunrpc nx_crypto sg pseries_rng xts vmx_c=
rypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp ibmveth dm=
_mirror dm_region_hash dm_log dm_mod=20
[   21.833148] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G        W         =
4.17.0 #1=20
[   21.833151] NIP:  0000000000000000 LR: c000000000159e8c CTR: 00000000000=
00000=20
[   21.833155] REGS: c00000047ff93260 TRAP: 0400   Tainted: G        W     =
     (4.17.0)=20
[   21.833158] MSR:  8000000040009032 &lt;SF,EE,ME,IR,DR,RI&gt;  CR: 240280=
28  XER: 20000006=20
[   21.833166] CFAR: c000000000008874 SOFTE: 1 =20
[   21.833166] GPR00: c00000000015a09c c00000047ff934e0 0000000000000000 c0=
00000461b2d5a0 =20
[   21.833166] GPR04: 0000000000000003 0000000000000000 0000000000000000 00=
00000000000000 =20
[   21.833166] GPR08: c00000047ff93610 c000000479ae7880 0000000000000000 d0=
00000004606758 =20
[   21.833166] GPR12: 0000000024022022 c00000001ebf1200 c000000474557f90 00=
00000000200042 =20
[   21.833166] GPR16: 00000000ffff9358 c00000047ff90000 0000000000000000 00=
00000000000001 =20
[   21.833166] GPR20: c000000000df7080 0000000000000005 c00000047ff93610 00=
00000000000001 =20
[   21.833166] GPR24: 0000000000000000 0000000000000000 0000000000000003 00=
00000000000000 =20
[   21.833166] GPR28: c00000045f5801b0 0000000000000000 c000000461b2d5a0 ff=
ffffffffffffe8 =20
[   21.833208] NIP [0000000000000000]           (null)=20
[   21.833212] LR [c000000000159e8c] .__wake_up_common+0xdc/0x240=20
[   21.833215] Call Trace:=20
[   21.833217] [c00000047ff934e0] [c00000047ff935c0] 0xc00000047ff935c0 (un=
reliable)=20
[   21.833222] [c00000047ff935a0] [c00000000015a09c] .__wake_up_common_lock=
+0xac/0x100=20
[   21.833227] [c00000047ff93680] [c000000000267dc8] .mempool_free+0xc8/0xe=
0=20
[   21.833232] [c00000047ff93700] [c0000000004971ac] .bio_free+0x4c/0xa0=20
[   21.833242] [c00000047ff93780] [d0000000045f1998] .dec_pending+0x128/0x3=
10 [dm_mod]=20
[   21.833253] [c00000047ff93850] [d0000000045f1edc] .clone_endio+0xcc/0x18=
0 [dm_mod]=20
[   21.833258] [c00000047ff938e0] [c000000000498c84] .bio_endio+0x184/0x290=
=20
[   21.833262] [c00000047ff93990] [c0000000004a3d20] .blk_update_request+0x=
f0/0x4a0=20
[   21.833267] [c00000047ff93a40] [c000000000642ae8] .scsi_end_request+0x48=
/0x270=20
[   21.833272] [c00000047ff93af0] [c000000000642f44] .scsi_io_completion+0x=
234/0x710=20
[   21.833277] [c00000047ff93bd0] [c000000000637cc8] .scsi_finish_command+0=
x148/0x1b0=20
[   21.833282] [c00000047ff93c60] [c000000000641e18] .scsi_softirq_done+0x1=
98/0x1f0=20
[   21.833286] [c00000047ff93d00] [c0000000004aee24] .blk_done_softirq+0xc4=
/0xf0=20
[   21.833292] [c00000047ff93d90] [c0000000009829a0] .__do_softirq+0x150/0x=
3a8=20
[   21.833297] [c00000047ff93e90] [c000000000101d68] .irq_exit+0x198/0x1b0=
=20
[   21.833302] [c00000047ff93f10] [c000000000016024] .__do_irq+0x94/0x1f0=
=20
[   21.833306] [c00000047ff93f90] [c00000000002779c] .call_do_irq+0x14/0x24=
=20
[   21.833311] [c0000004745577a0] [c00000000001620c] .do_IRQ+0x8c/0x100=20
[   21.833315] [c000000474557840] [c000000000008c24] hardware_interrupt_com=
mon+0x114/0x120=20
[   21.833323] --- interrupt: 501 at .plpar_hcall_norets+0x14/0x20=20
[   21.833323]     LR =3D .check_and_cede_processor+0x24/0x40=20
[   21.833328] [c000000474557b30] [7fffffffffffffff] 0x7fffffffffffffff (un=
reliable)=20
[   21.833333] [c000000474557ba0] [c00000000076565c] .dedicated_cede_loop+0=
x4c/0x130=20
[   21.833339] [c000000474557c20] [c000000000762d9c] .cpuidle_enter_state+0=
xac/0x390=20
[   21.833343] [c000000474557cd0] [c00000000013b8cc] .call_cpuidle+0x3c/0x7=
0=20
[   21.833348] [c000000474557d40] [c00000000013be38] .do_idle+0x2e8/0x390=
=20
[   21.833352] [c000000474557e20] [c00000000013c098] .cpu_startup_entry+0x2=
8/0x30=20
[   21.833357] [c000000474557ea0] [c000000000046980] .start_secondary+0x4d0=
/0x520=20
[   21.833362] [c000000474557f90] [c00000000000ab70] start_secondary_prolog=
+0x10/0x14=20
[   21.833366] Instruction dump:=20
[   21.833369] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXX=
XX XXXXXXXX =20
[   21.833374] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXX=
XX XXXXXXXX =20
[   21.833382] ---[ end trace c4d85974c8ca08fc ]---=20
[   21.835408] =20
[   22.835471] Kernel panic - not syncing: Fatal exception in interrupt=20
[   23.884733] WARNING: CPU: 10 PID: 0 at drivers/tty/vt/vt.c:3885 .do_unbl=
ank_screen+0x268/0x270=20
[   23.884740] Modules linked in: sunrpc nx_crypto sg pseries_rng xts vmx_c=
rypto ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp ibmveth dm=
_mirror dm_region_hash dm_log dm_mod=20
[   23.884766] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G      D W         =
4.17.0 #1=20
[   23.884772] NIP:  c0000000005bb758 LR: c0000000005bb524 CTR: c0000000000=
2ae00=20
[   23.884778] REGS: c00000047ff92cc0 TRAP: 0700   Tainted: G      D W     =
     (4.17.0)=20
[   23.884783] MSR:  8000000000021032 &lt;SF,ME,IR,DR,RI&gt;  CR: 48022042 =
 XER: 00000009=20
[   23.884794] CFAR: c0000000005bb538 SOFTE: 1 =20
[   23.884794] GPR00: c0000000005bb714 c00000047ff92f40 c0000000013ac100 00=
00000000000000 =20
[   23.884794] GPR04: 0000000000000001 000000000000000b 0000000020646d5f 6d=
5f726567696f6e =20
[   23.884794] GPR08: c00000000168c100 0000000000000000 0000000000000000 6e=
67207874732076 =20
[   23.884794] GPR12: 0000000088022044 c00000001ebf1200 c000000474557f90 00=
00000000200042 =20
[   23.884794] GPR16: 00000000ffff9358 c00000047ff90000 0000000000000000 00=
00000000000001 =20
[   23.884794] GPR20: c000000000df7080 0000000000000005 c00000047ff93610 00=
00000000000001 =20
[   23.884794] GPR24: 0000000000000000 0000000000000000 c0000000011da080 c0=
000000015767c0 =20
[   23.884794] GPR28: c000000001576798 0000000000000000 c000000001685340 c0=
000000015767c0 =20
[   23.884863] NIP [c0000000005bb758] .do_unblank_screen+0x268/0x270=20
[   23.884868] LR [c0000000005bb524] .do_unblank_screen+0x34/0x270=20
[   23.884873] Call Trace:=20
[   23.884877] [c00000047ff92f40] [c0000000005bb714] .do_unblank_screen+0x2=
24/0x270 (unreliable)=20
[   23.884887] [c00000047ff92fd0] [c0000000004e88a0] .bust_spinlocks+0x30/0=
x70=20
[   23.884894] [c00000047ff93040] [c0000000000f9cf8] .panic+0x1b0/0x308=20
[   23.884901] [c00000047ff930e0] [c000000000022e5c] .oops_end+0x1cc/0x1e0=
=20
[   23.884908] [c00000047ff93170] [c000000000062648] .bad_page_fault+0xd8/0=
x144=20
[   23.884916] [c00000047ff931f0] [c00000000000a650] handle_page_fault+0x34=
/0x38=20
[   23.884924] --- interrupt: 400 at           (null)=20
[   23.884924]     LR =3D .__wake_up_common+0xdc/0x240=20
[   23.884932] [c00000047ff934e0] [c00000047ff935c0] 0xc00000047ff935c0 (un=
reliable)=20
[   23.884940] [c00000047ff935a0] [c00000000015a09c] .__wake_up_common_lock=
+0xac/0x100=20
[   23.884948] [c00000047ff93680] [c000000000267dc8] .mempool_free+0xc8/0xe=
0=20
[   23.884955] [c00000047ff93700] [c0000000004971ac] .bio_free+0x4c/0xa0=20
[   23.884973] [c00000047ff93780] [d0000000045f1998] .dec_pending+0x128/0x3=
10 [dm_mod]=20
[   23.884991] [c00000047ff93850] [d0000000045f1edc] .clone_endio+0xcc/0x18=
0 [dm_mod]=20
[   23.884998] [c00000047ff938e0] [c000000000498c84] .bio_endio+0x184/0x290=
=20
[   23.885005] [c00000047ff93990] [c0000000004a3d20] .blk_update_request+0x=
f0/0x4a0=20
[   23.885013] [c00000047ff93a40] [c000000000642ae8] .scsi_end_request+0x48=
/0x270=20
[   23.885020] [c00000047ff93af0] [c000000000642f44] .scsi_io_completion+0x=
234/0x710=20
[   23.885028] [c00000047ff93bd0] [c000000000637cc8] .scsi_finish_command+0=
x148/0x1b0=20
[   23.885035] [c00000047ff93c60] [c000000000641e18] .scsi_softirq_done+0x1=
98/0x1f0=20
[   23.885042] [c00000047ff93d00] [c0000000004aee24] .blk_done_softirq+0xc4=
/0xf0=20
[   23.885051] [c00000047ff93d90] [c0000000009829a0] .__do_softirq+0x150/0x=
3a8=20
[   23.885058] [c00000047ff93e90] [c000000000101d68] .irq_exit+0x198/0x1b0=
=20
[   23.885065] [c00000047ff93f10] [c000000000016024] .__do_irq+0x94/0x1f0=
=20
[   23.885072] [c00000047ff93f90] [c00000000002779c] .call_do_irq+0x14/0x24=
=20
[   23.885079] [c0000004745577a0] [c00000000001620c] .do_IRQ+0x8c/0x100=20
[   23.885086] [c000000474557840] [c000000000008c24] hardware_interrupt_com=
mon+0x114/0x120=20
[   23.885096] --- interrupt: 501 at .plpar_hcall_norets+0x14/0x20=20
[   23.885096]     LR =3D .check_and_cede_processor+0x24/0x40=20
[   23.885104] [c000000474557b30] [7fffffffffffffff] 0x7fffffffffffffff (un=
reliable)=20
[   23.885112] [c000000474557ba0] [c00000000076565c] .dedicated_cede_loop+0=
x4c/0x130=20
[   23.885120] [c000000474557c20] [c000000000762d9c] .cpuidle_enter_state+0=
xac/0x390=20
[   23.885128] [c000000474557cd0] [c00000000013b8cc] .call_cpuidle+0x3c/0x7=
0=20
[   23.885134] [c000000474557d40] [c00000000013be38] .do_idle+0x2e8/0x390=
=20
[   23.885141] [c000000474557e20] [c00000000013c098] .cpu_startup_entry+0x2=
8/0x30=20
[   23.885148] [c000000474557ea0] [c000000000046980] .start_secondary+0x4d0=
/0x520=20
[   23.885156] [c000000474557f90] [c00000000000ab70] start_secondary_prolog=
+0x10/0x14=20
[   23.885162] Instruction dump:=20
[   23.885167] 39487a00 3c62ffe7 3863aab0 e94a0000 7d2407b4 7c845214 4bbd66=
71 60000000 =20
[   23.885178] 39200001 3d42003f 912a2080 4bfffe60 &lt;0fe00000&gt; 4bfffde=
0 38600000 4bfffd8c =20
[   23.885189] ---[ end trace c4d85974c8ca08fd ]--- </pre>=E2=80=8B</div><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Jens Axboe<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div>
</div></div>

--00000000000081949c056e075d79--
