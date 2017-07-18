Return-Path: <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
To: <bo.li.liu@oracle.com>, Jens Axboe <axboe@kernel.dk>
CC: Ming Lei <tom.leiming@gmail.com>, David Sterba <dsterba@suse.com>,
	linux-block <linux-block@vger.kernel.org>, <fdmanana@suse.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
 <06376146-e4c3-efd6-8893-155052b14034@kernel.dk>
 <20170714205429.GC10708@lim.localdomain>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <7e460ce6-7f91-53b6-dad1-d22965b6c8af@wdc.com>
Date: Tue, 18 Jul 2017 15:19:00 -0700
MIME-Version: 1.0
In-Reply-To: <20170714205429.GC10708@lim.localdomain>
Content-Type: text/plain; charset="utf-8"
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 07/14/17 13:54, Liu Bo wrote:
> On Fri, Jul 14, 2017 at 08:22:31AM -0600, Jens Axboe wrote:
>> On 07/14/2017 07:47 AM, Ming Lei wrote:
>>>> @@ -156,6 +156,9 @@ static inline void *bio_data(struct bio *bio)
>>>>  /*
>>>>   * drivers should _never_ use the all version - the bio may have been split
>>>>   * before it got to the driver and the driver won't own all of it
>>>> + *
>>>> + * Note that cloned bios must not use this as their bi_vcnt may be invalid and
>>>> + * this could lead to silent corruptions.
>>>>   */
>>>>  #define bio_for_each_segment_all(bvl, bio, i)                          \
>>>>         for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
>>>> --
>>>> 2.13.0
>>>>
>>>
>>> Maybe we can add a warning here if it is a cloned bio.
>>
>> I think that's a good idea, it's easy for people to get this wrong, and
>> the consequences can be dire. How about something like this?
>>
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 7b1cf4ba0902..13b6ac6eae29 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -155,9 +155,12 @@ static inline void *bio_data(struct bio *bio)
>>  
>>  /*
>>   * drivers should _never_ use the all version - the bio may have been split
>> - * before it got to the driver and the driver won't own all of it
>> + * before it got to the driver and the driver won't own all of it.
>> + *
>> + * Don't use this on cloned bio's.
>>   */
>>  #define bio_for_each_segment_all(bvl, bio, i)				\
>> +	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));			\
>>  	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
>>  
>>  static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
>>
> 
> This patch gave me a crash, I'm double checking it..
> 
> thanks,
> -liubo
> 
> [  104.140220] BUG: unable to handle kernel paging request at ffffffffa0399c1a
> [  104.140675] IP: report_bug+0xc4/0x180
> [  104.140916] PGD 2626067 
> [  104.140917] P4D 2626067 
> [  104.141089] PUD 2627063 
> [  104.141259] PMD 2346aa067 
> [  104.141429] PTE 800000023569c161
> [  104.141610] 
> [  104.141926] Oops: 0003 [#1] SMP
> [  104.142137] Dumping ftrace buffer:
> [  104.142366]    (ftrace buffer empty)
> [  104.142602] Modules linked in: btrfs(OE) xor raid6_pq ppdev parport_pc parport serio_raw nfsd auth_rpcgss nfs_acl lockd grace sunrpc [last unloaded$
>  xor]
> [  104.143493] CPU: 0 PID: 144 Comm: kworker/u16:4 Tainted: G        W  OE   4.12.0+ #801
> [  104.144009] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014
> [  104.144654] Workqueue: btrfs-rmw btrfs_rmw_helper [btrfs]
> [  104.145009] task: ffff8802382f8000 task.stack: ffffc90000f80000
> [  104.145393] RIP: 0010:report_bug+0xc4/0x180
> [  104.145668] RSP: 0018:ffffc90000f83ac8 EFLAGS: 00010002
> [  104.146015] RAX: 0000000000000001 RBX: ffffffffa0356cff RCX: 0000000000000001
> [  104.146474] RDX: ffffffffa0399c10 RSI: 0000000000000480 RDI: 0000000000000000
> [  104.146931] RBP: ffffc90000f83ae8 R08: 0000000000000907 R09: 0000000000000000
> [  104.147393] R10: 000000005170b2af R11: 000000002b881219 R12: ffffc90000f83c38
> [  104.147852] R13: ffffffffa038a415 R14: 0000000000000004 R15: 0000000000000006
> [  104.148315] FS:  0000000000000000(0000) GS:ffff88023a600000(0000) knlGS:0000000000000000
> [  104.148836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  104.149211] CR2: ffffffffa0399c1a CR3: 00000002244fc000 CR4: 00000000000006f0
> [  104.149672] Call Trace:
> [  104.149840]  fixup_bug+0x43/0x60
> [  104.150060]  do_trap+0x18a/0x1f0
> [  104.150276]  do_error_trap+0xdf/0x1a0
> [  104.150606]  ? index_rbio_pages+0x14f/0x160 [btrfs]
> [  104.150929]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  104.151241]  do_invalid_op+0x20/0x30
> [  104.151478]  invalid_op+0x1e/0x30
> [  104.151787] RIP: 0010:index_rbio_pages+0x14f/0x160 [btrfs]
> [  104.152148] RSP: 0018:ffffc90000f83ce8 EFLAGS: 00010002
> [  104.152488] RAX: ffffffffa0421938 RBX: 0000000000000000 RCX: 0000000000000000
> [  104.152947] RDX: 0000000000000003 RSI: 0000000000000001 RDI: ffffffffa0440420
> [  104.153410] RBP: ffffc90000f83d18 R08: 0000000000000000 R09: 0000000000000000
> [  104.153869] R10: 0000000000000001 R11: 000000002b881219 R12: ffffffffa0421960
> [  104.154330] R13: 0000000000000001 R14: ffff880236e00000 R15: ffff880227718080
> [  104.154882]  ? index_rbio_pages+0xc6/0x160 [btrfs]
> [  104.155286]  rmw_work+0x76/0x310 [btrfs]
> [  104.155633]  btrfs_scrubparity_helper+0xad/0x8e0 [btrfs]
> [  104.156070]  btrfs_rmw_helper+0xe/0x10 [btrfs]
> [  104.156364]  process_one_work+0x34f/0x9c0
> [  104.156631]  worker_thread+0x34a/0x6b0
> [  104.156879]  kthread+0x180/0x190
> [  104.157095]  ? create_worker+0x230/0x230
> [  104.157352]  ? kthread_create_on_node+0x70/0x70
> [  104.157648]  ? kthread_create_on_node+0x70/0x70
> [  104.157944]  ret_from_fork+0x2a/0x40
> [  104.159436] RIP: report_bug+0xc4/0x180 RSP: ffffc90000f83ac8
> [  104.159803] CR2: ffffffffa0399c1a
> [  104.160026] ---[ end trace 78686c1f7150bacf ]---

(+Peter)
 
Hello Peter,

In a test I ran myself with kernel v4.12-rc1 I also noticed that a
WARN_ON_ONCE() statement triggered an oops in report_bug() and killed the
kernel thread of the caller instead of letting the caller continue. What I
ran into is probably the same oops as in the above call trace. For the test
I ran myself the disassembly is as follows:

(gdb) list *(report_bug+0x94)
0xffffffff812ba024 is in report_bug (lib/bug.c:177).
172                                     return BUG_TRAP_TYPE_WARN;
173
174                             /*
175                              * Since this is the only store, concurrency is not an issue.
176                              */
177                             bug->flags |= BUGFLAG_DONE;
178                     }
179             }
180
181             if (warning) {

Could this be related to patch "debug: Add _ONCE() logic to report_bug()"?
Is this a known issue? If so, is a fix perhaps already available?

Thanks,

Bart.
