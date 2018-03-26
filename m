Return-Path: <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] block, bfq: keep peak_rate estimation within range
 1..2^32-1
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
References: <152025413365.161046.7757556276366364549.stgit@buzz>
 <FE5352B7-CAFC-466C-BA07-F1B7427AA309@linaro.org>
 <ff761610-4a37-f239-a491-cf2a04c44574@yandex-team.ru>
 <E9AC28A6-848D-420F-8DAB-8B1FC709BA38@linaro.org>
 <38320074-d1e6-96bc-e832-e535efc07e81@yandex-team.ru>
 <E810B04D-CEC3-4D98-A52A-08509E7CE417@linaro.org>
 <17F0A3D1-29A6-4688-96F3-6776AF1DB7A4@linaro.org>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <cc3160eb-931b-d907-29a1-d1baf9f47d5d@yandex-team.ru>
Date: Mon, 26 Mar 2018 13:28:37 +0300
MIME-Version: 1.0
In-Reply-To: <17F0A3D1-29A6-4688-96F3-6776AF1DB7A4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 26.03.2018 11:01, Paolo Valente wrote:
> 
> 
>> Il giorno 21 mar 2018, alle ore 00:49, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>>
>>
>>> Il giorno 20 mar 2018, alle ore 15:41, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> ha scritto:
>>>
>>> On 20.03.2018 06:00, Paolo Valente wrote:
>>>>> Il giorno 19 mar 2018, alle ore 14:28, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> ha scritto:
>>>>>
>>>>> On 19.03.2018 09:03, Paolo Valente wrote:
>>>>>>> Il giorno 05 mar 2018, alle ore 04:48, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> ha scritto:
>>>>>>>
>>>>>>> Rate should never overflow or become zero because it is used as divider.
>>>>>>> This patch accumulates it with saturation.
>>>>>>>
>>>>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>>>>> ---
>>>>>>> block/bfq-iosched.c |    8 +++++---
>>>>>>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>>>> index aeca22d91101..a236c8d541b5 100644
>>>>>>> --- a/block/bfq-iosched.c
>>>>>>> +++ b/block/bfq-iosched.c
>>>>>>> @@ -2546,7 +2546,8 @@ static void bfq_reset_rate_computation(struct bfq_data *bfqd,
>>>>>>>
>>>>>>> static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
>>>>>>> {
>>>>>>> -	u32 rate, weight, divisor;
>>>>>>> +	u32 weight, divisor;
>>>>>>> +	u64 rate;
>>>>>>>
>>>>>>> 	/*
>>>>>>> 	 * For the convergence property to hold (see comments on
>>>>>>> @@ -2634,9 +2635,10 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
>>>>>>> 	 */
>>>>>>> 	bfqd->peak_rate *= divisor-1;
>>>>>>> 	bfqd->peak_rate /= divisor;
>>>>>>> -	rate /= divisor; /* smoothing constant alpha = 1/divisor */
>>>>>>> +	do_div(rate, divisor);	/* smoothing constant alpha = 1/divisor */
>>>>>>>
>>>>>>> -	bfqd->peak_rate += rate;
>>>>>>> +	/* rate should never overlow or become zero */
>>>>>> It is bfqd->peak_rate that is used as a divider, and bfqd->peak_rate doesn't risk to be zero even if the variable 'rate' is zero here.
>>>>>> So I guess the reason why you consider the possibility that bfqd->peak_rate becomes zero is because of an overflow when summing 'rate'. But, according to my calculations, this should be impossible with devices with sensible speeds.
>>>>>> These are the reasons why I decided I could make it with a 32-bit variable, without any additional clamping. Did I make any mistake in my evaluation?
>>>>>
>>>>> According to Murphy's law this is inevitable..
>>>>>
>>>> Yep.  Actually Murphy has been even clement this time, by making the
>>>> failure occur to a kernel expert :)
>>>>> I've seen couple division by zero crashes in bfq_wr_duration.
>>>>> Unfortunately logs weren't recorded.
>>>>>
>>>>>> Anyway, even if I made some mistake about the maximum possible value of the device rate, and the latter may be too high for bfqd->peak_rate to contain it, then I guess the right solution would not be to clamp the actual rate to U32_MAX, but to move bfqd->peak_rate to 64 bits. Or am I missing something else?
>>>>>>>> +	bfqd->peak_rate = clamp_t(u64, rate + bfqd->peak_rate, 1, U32_MAX);
>>>>>
>>>>> 32-bit should be enough and better for division.
>>>>> My patch makes sure it never overflows/underflows.
>>>>> That's cheaper than full 64-bit/64-bit division.
>>>>> Anyway 64-bit speed could overflow too. =)
>>>>>
>>>> I see your point.  Still, if the mistake is not in sizing, then you
>>>> bumped into some odd bug.  In this respect, I don't like much the idea
>>>> of sweeping the dust under the carpet.  So, let me ask you for a
>>>> little bit more help.  With your patch applied, and thus with no risk
>>>> of crashes, what about adding, right before your clamp_t, something
>>>> like:
>>>> if (!bfqd->peak_rate)
>>>> 	pr_crit(<dump of all the variables involved in updating bfqd->peak_rate>);
>>>> Once the failure shows up (Murphy permitting), we might have hints to
>>>> the bug causing it.
>>>> Apart from that, I have no problem with patches that make bfq more
>>>> robust, even in a sort of black-box way.
>>>
>>> This rate estimator is already works as a black-box with smoothing and
>>> low-pass filter inside.
>>
>> Actually, it is just what you say: a low-pass filter, which works by
>> deflating two non-null quantities (the previous and the current rate
>> rate), by and adding these quantities to each other (to get the new
>> estimated rate).  In addition to being larger than 0, both quantities
>> are much lower than U32_MAX, so this computation should never yield
>> zero because of an overflow.
>>
>> Even some occasional zeros read for the sampled rate (because of the
>> suspicion you express below), cannot lead to a null estimated rate.
>> In fact, this is a low-pass filter, meant to cut off occasional
>> spurious values.
>>
>> I'm insisting on this part, just because, maybe, you say that it "acts
>> as a black-box" because there is something more, which I'm overlooking
>> here, and maybe the bug is exactly in the part I'm overlooking.  But,
>> if this is not the case, I'll just stop now for this point.
>>
>>> It has limitations thus this is ok to declare
>>> range of expected\sane results.
>>>
>>
>> Correct, but if the odd value you cut off is a random value that
>> follows from a bug (and I see no other possibility, in view of the
>> above arguments), then the result may still be completely wrong.  For
>> example:
>> - the device may have a rate of, say, 200 MB/s
>> - the computation of the new estimated rate yields 0
>> - you limit this result to ~0 MB/s but >0 MB/s; this avoids division
>> errors, but still leaves you with a completely wrong rate, and a
>> consequently inconsistent behavior of the scheduler
>>
>>> It would be nice to show estimated rate in sysfs to let user
>>> diagnose whenever it is wrong for a long period of time.
>>
>> Absolutely.  This is actually already shown indirectly, through the
>> budget_max parameter, which is the number of sectors served at peak
>> rate during slice_sync.
>>
>>> Printing message all the time even ratelimited is a wrong idea.
>>> If this should never happens - WARN_ONCE is more than enough.
>>>
>>
>> I'm sorry, I was totally unclear here.  My proposal for you is:
>> since this failure does occur in your system, please add, temporarily, the
>> printing of all involved values *all the times*, so that you can track down
>> the bug, and fix the actual problem leading to this division by zero.
>>
>> What do you think?
>>
>>> I suspect crashes might be caused by bumpy timer which was affected by smi/nmi from mce.
>>
>> Yep.  The problem is that, for the estimated rate to go to zero, a
>> null value must be sampled for several consecutive times.
>>
>>> I'll try to find evidence.
>>
>> Getting to the bottom of this would be really great.
>>
>> Looking forward to your findings,
> 
> I guess no news yet.  Anyway, your bug report has pushed me to think
> over the representation of the rate.  And I may have found a problem,
> which might be the cause of the zeros you have seen.
> 
> With a little math, it comes out that, for a sampled rate below about
> 5 KB/s, 0 is stored in the variable 'rate'.  The reason is that such
> low values cannot be represented with the maximum precision currently
> available in BFQ for rates.  So, if these very low values are sampled
> for a few consecutive times, then the estimated peak rate may actually
> become zero.
> 
> In the system in which you have seen null estimated rates, may the
> virtual or physical storage device be occasionally so slow?

I've found couple crashes from qemu-kvm virtual machines.
Their disks are slow for sure. Zero rate for a minute wouldn't be a surprise.

<4>[125253.240885] divide error: 0000 [#1] SMP PTI
<4>[125253.241031] Modules linked in: netconsole configfs tcp_diag inet_diag unix_diag nf_log_ipv6 nf_log_common xt_LOG xt_u32 ip6t_REJECT 
nf_reject_ipv6 xt_conntrack xt_multiport ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_filter ip6_tables ipt_REJECT 
nf_reject_ipv4 xt_tcpudp xt_mark xt_owner iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_filter 
ip_tables x_tables nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc 8021q garp mrp stp llc drm_kms_helper syscopyarea sysfillrect sysimgblt 
snd_hda_codec_generic fb_sys_fops snd_hda_intel ttm drm snd_hda_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd soundcore i2c_piix4 ppdev 
kvm_intel kvm irqbypass input_leds parport_pc fuse lp parport xfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
<4>[125253.242257]  async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear ata_generic pata_acpi floppy [last unloaded: netconsole]
<4>[125253.242537] CPU: 0 PID: 36766 Comm: push-client Not tainted 4.14.15-5 #1
<4>[125253.242731] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
<4>[125253.242928] task: ffff880210ed3500 task.stack: ffffc90002d78000
<4>[125253.243092] RIP: 0010:bfq_wr_duration.isra.15.part.16+0xc/0x40
<4>[125253.243240] RSP: 0018:ffffc90002d7b9e0 EFLAGS: 00010046
<4>[125253.243357] RAX: 00000000000d59f8 RBX: ffff88023014af00 RCX: 000000000000001e
<4>[125253.243567] RDX: 0000000000000000 RSI: ffff8802302685a0 RDI: 0000000000000000
<4>[125253.243785] RBP: ffff880230268400 R08: 0000000000000001 R09: 0000000000000001
<4>[125253.244004] R10: ffff8802305341b0 R11: ffff880230268400 R12: ffff88023066cb60
<4>[125253.244222] R13: 0000000000000000 R14: ffff8802305341b0 R15: ffffc90002d7ba88
<4>[125253.244489] FS:  00007f74d59e6700(0000) GS:ffff88023fc00000(0000) knlGS:0000000000000000
<4>[125253.244784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[125253.245073] CR2: 00007f78e7261258 CR3: 000000021275e000 CR4: 00000000000006f0
<4>[125253.245406] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[125253.245696] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
<4>[125253.245961] Call Trace:
<4>[125253.246097]  bfq_insert_requests+0xda7/0xf60
<4>[125253.246313]  blk_mq_sched_insert_request+0xf9/0x150
<4>[125253.246520]  blk_mq_make_request+0x1da/0x630
<4>[125253.246692]  generic_make_request+0xfb/0x2d0
<4>[125253.246847]  ? submit_bio+0x73/0x150
<4>[125253.246984]  submit_bio+0x73/0x150
<4>[125253.247229]  xfs_submit_ioend+0x80/0x1a0 [xfs]
<4>[125253.247466]  xfs_do_writepage+0x4d7/0x710 [xfs]
<4>[125253.247636]  ? invalid_page_referenced_vma+0x90/0x90
<4>[125253.247906]  write_cache_pages+0x23a/0x4e0
<4>[125253.248166]  ? xfs_add_to_ioend+0x240/0x240 [xfs]
<4>[125253.248345]  ? dequeue_entity+0x2f4/0xa90
<4>[125253.248596]  xfs_vm_writepages+0x94/0xd0 [xfs]
<4>[125253.248793]  do_writepages+0x17/0x70
<4>[125253.249020]  __filemap_fdatawrite_range+0xa7/0xe0
<4>[125253.249269]  file_write_and_wait_range+0x4c/0xa0
<4>[125253.249514]  xfs_file_fsync+0x55/0x220 [xfs]
<4>[125253.249719]  do_fsync+0x38/0x60
<4>[125253.249877]  SyS_fsync+0xc/0x10
<4>[125253.250098]  entry_SYSCALL_64_fastpath+0x20/0x83
<4>[125253.250285] RIP: 0033:0x7f74e92a6a7d
<4>[125253.250484] RSP: 002b:00007f74d59dcc90 EFLAGS: 00000293
<4>[125253.250485] Code: ff ff 8b 07 4d 29 c8 4c 0f af c0 e9 27 ff ff ff 48 89 c8 c3 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 
06 31 d2 89 ff <48> f7 f7 48 89 c1 b8 b2 0c 00 00 48 81 f9 b2 0c 00 00 77 0f 48
<1>[125253.251304] RIP: bfq_wr_duration.isra.15.part.16+0xc/0x40 RSP: ffffc90002d7b9e0

And this one definitely have timer issues.

<4>[69620.113311] hpet1: lost 1123 rtc interrupts
<4>[69725.670214] hpet1: lost 1257 rtc interrupts
<4>[69730.301092] hpet1: lost 295 rtc interrupts
<4>[69785.817074] hpet1: lost 804 rtc interrupts
<4>[70276.099325] hpet1: lost 1138 rtc interrupts
<4>[70338.962431] hpet1: lost 1274 rtc interrupts
<4>[70687.531960] hpet1: lost 314 rtc interrupts
<4>[70708.789681] hpet1: lost 1359 rtc interrupts
<4>[70892.699792] hpet1: lost 775 rtc interrupts
<4>[70985.631630] hpet1: lost 448 rtc interrupts
<4>[71045.952024] hpet1: lost 1109 rtc interrupts
<4>[71236.781185] hpet1: lost 1216 rtc interrupts
<4>[71253.521384] hpet1: lost 1071 rtc interrupts
<4>[71477.087387] hpet1: lost 563 rtc interrupts
<4>[71568.587212] hpet1: lost 357 rtc interrupts
<4>[71837.330897] hpet1: lost 705 rtc interrupts
<4>[72029.244809] hpet1: lost 1286 rtc interrupts
<4>[72251.173477] hpet1: lost 458 rtc interrupts
<4>[72398.366782] hpet1: lost 1172 rtc interrupts
<4>[73218.363935] hpet1: lost 249 rtc interrupts
<4>[73280.472760] hpet1: lost 1225 rtc interrupts
<4>[73458.506121] hpet1: lost 398 rtc interrupts
<4>[73504.331306] hpet1: lost 183 rtc interrupts
<4>[73596.270009] hpet1: lost 386 rtc interrupts
<4>[73858.989240] hpet1: lost 320 rtc interrupts
<4>[73903.326725] hpet1: lost 88 rtc interrupts
<4>[74170.760022] hpet1: lost 622 rtc interrupts
<4>[74517.835154] hpet1: lost 216 rtc interrupts
<4>[74609.630248] hpet1: lost 375 rtc interrupts
<4>[74884.937850] hpet1: lost 1126 rtc interrupts
<4>[74886.291818] hpet1: lost 86 rtc interrupts
<4>[74902.415909] hpet1: lost 1031 rtc interrupts
<4>[75134.991339] hpet1: lost 1140 rtc interrupts
<4>[75139.948051] hpet1: lost 316 rtc interrupts
<4>[75183.709393] hpet1: lost 50 rtc interrupts
<4>[75486.178692] hpet1: lost 115 rtc interrupts
<4>[75634.770692] hpet1: lost 1261 rtc interrupts
<4>[76322.311822] hpet1: lost 18 rtc interrupts
<4>[76941.322201] hpet1: lost 1128 rtc interrupts
<4>[77341.716930] hpet1: lost 884 rtc interrupts
<4>[77347.532830] hpet1: lost 371 rtc interrupts
<4>[77348.620826] hpet1: lost 68 rtc interrupts
<4>[77362.430004] divide error: 0000 [#1] SMP PTI
<4>[77362.430139] Modules linked in: netconsole configfs tcp_diag inet_diag unix_diag nf_log_ipv6 nf_log_common xt_LOG xt_u32 ip6t_REJECT 
nf_reject_ipv6 xt_conntrack xt_multiport ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_filter ip6_tables ipt_REJECT 
nf_reject_ipv4 xt_tcpudp xt_mark xt_owner iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_filter 
ip_tables x_tables nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core 
snd_pcm snd_timer drm_kms_helper snd syscopyarea sysfillrect sysimgblt fb_sys_fops ttm soundcore drm 8021q garp mrp stp llc ppdev i2c_piix4 
kvm_intel input_leds kvm irqbypass parport_pc fuse lp parport xfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
<4>[77362.431347]  async_tx xor raid6_pq libcrc32c raid1 raid0 floppy multipath linear ata_generic pata_acpi [last unloaded: netconsole]
<4>[77362.431545] CPU: 0 PID: 39134 Comm: skynet.heartbea Not tainted 4.14.15-5 #1
<4>[77362.431720] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
<4>[77362.432013] task: ffff8800964adcc0 task.stack: ffffc900030bc000
<4>[77362.432185] RIP: 0010:bfq_wr_duration.isra.15.part.16+0xc/0x40
<4>[77362.432348] RSP: 0018:ffffc900030bfa90 EFLAGS: 00010046
<4>[77362.432552] RAX: 00000000000d59f8 RBX: ffff8801348d6900 RCX: 000000000000001e
<4>[77362.432725] RDX: 0000000000000000 RSI: ffff8801348c1da0 RDI: 0000000000000000
<4>[77362.432992] RBP: ffff8801348c1c00 R08: 0000000000000001 R09: 0000000000000001
<4>[77362.433214] R10: ffff8800b9eacf30 R11: ffff8801348c1c00 R12: ffff880134decb60
<4>[77362.433466] R13: 0000000000000000 R14: ffff8800b9eacf30 R15: ffffc900030bfb38
<4>[77362.433696] FS:  00007fe28c721700(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
<4>[77362.433948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[77362.434125] CR2: 0000000001370ec8 CR3: 0000000135b2c000 CR4: 00000000000006f0
<4>[77362.434328] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[77362.434571] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
<4>[77362.434828] Call Trace:
<4>[77362.434997]  bfq_insert_requests+0xda7/0xf60
<4>[77362.435150]  blk_mq_sched_insert_request+0xf9/0x150
<4>[77362.435366]  blk_mq_make_request+0x1da/0x630
<4>[77362.435516]  generic_make_request+0xfb/0x2d0
<4>[77362.435701]  ? submit_bio+0x73/0x150
<4>[77362.435827]  submit_bio+0x73/0x150
<4>[77362.436100]  xfs_submit_ioend+0x80/0x1a0 [xfs]
<4>[77362.436339]  xfs_vm_writepages+0xa8/0xd0 [xfs]
<4>[77362.436549]  do_writepages+0x17/0x70
<4>[77362.436692]  __filemap_fdatawrite_range+0xa7/0xe0
<4>[77362.436884]  filemap_write_and_wait_range+0x30/0x80
<4>[77362.437106]  xfs_setattr_size+0x121/0x380 [xfs]
<4>[77362.437313]  xfs_vn_setattr+0x6b/0x90 [xfs]
<4>[77362.437472]  notify_change+0x2da/0x400
<4>[77362.437663]  do_truncate+0x5b/0x90
<4>[77362.437842]  do_sys_ftruncate.constprop.18+0x10b/0x170
<4>[77362.438033]  ? SyS_write+0x66/0x90
<4>[77362.438251]  entry_SYSCALL_64_fastpath+0x20/0x83
<4>[77362.438429] RIP: 0033:0x7fe293e8bd87
<4>[77362.438586] RSP: 002b:00007fe28c71fb28 EFLAGS: 00000246
<4>[77362.438587] Code: ff ff 8b 07 4d 29 c8 4c 0f af c0 e9 27 ff ff ff 48 89 c8 c3 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 06 
31 d2 89 ff <48> f7 f7 48 89 c1 b8 b2 0c 00 00 48 81 f9 b2 0c 00 00 77 0f 48


> 
> Thanks,
> Paolo
> 
> 
> 
>> Paolo
>>
>>>
>>>> Thanks a lot,
>>>> Paolo
>>>>>
>>>>>>> 	update_thr_responsiveness_params(bfqd);
>>>>>>>
>>>>>>> reset_computation:
> 
