Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp> <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com> <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 19:14:38 +0200
Message-ID: <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
Subject: Re: general protection fault in wb_workfn (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 8, 2018 at 6:53 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Jun 8, 2018 at 5:16 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Fri, Jun 8, 2018 at 4:31 AM, Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> Dmitry Vyukov wrote:
>>>>> On Tue, Jun 5, 2018 at 3:45 PM, Tetsuo Handa
>>>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>> > Dmitry, can you assign VM resources for a git tree for this bug? This bug wants to fight
>>>>> > against https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches ...
>>>>>
>>>>> Hi Tetsuo,
>>>>>
>>>>> Most of the reasons for not doing it still stand. A syzkaller instance
>>>>> will produce not just this bug, it will produce hundreds of different
>>>>> bugs. Then the question is: what to do with these bugs? Report all to
>>>>> mailing lists?
>>>>
>>>> Is it possible to add linux-next.git tree as a target for fuzzing? If yes,
>>>> we can try debug patches easily, in addition to find bugs earlier than now.
>>>
>>> syzbot tested linux-next and mmotm initially, but they were removed at
>>> the request of kernel developers. See:
>>> https://groups.google.com/d/msg/syzkaller/0H0LHW_ayR8/dsK5qGB_AQAJ
>>> and:
>>> https://groups.google.com/d/msg/syzkaller-bugs/FeAgni6Atlk/U0JGoR0AAwAJ
>>> Indeed, linux-next produces around 50 assorted one-off unexplainable
>>> bug reports.
>>>
>>>
>>>>> I think the solution here is just to run syzkaller instance locally.
>>>>> It's just a program anybody can run it on any kernel with any custom
>>>>> patches. Moreover for local instance it's also possible to limit set
>>>>> of tested syscalls to increase probability of hitting this bug and at
>>>>> the same time filter out most of other bugs.
>>>>
>>>> If this bug is reproducible with VM resources individual developer can afford...
>>>>
>>>> Since my Linux development environment is VMware guests on a Windows PC, I can't
>>>> run VM instance which needs KVM acceleration. Also, due to security policy, I can't
>>>> utilize external VM resources available on the Internet, as well as I can't use ssh
>>>> and git protocols. Speak of this bug, even with a lot of VM instances, syzbot can
>>>> reproduce this bug only once or twice per a day. Thus, the question for me boils
>>>> down to, whether I can reproduce this bug using one VMware guest instance with 4GB
>>>> of memory. Effectively, I don't have access to environments for running syzkaller
>>>> instance...
>>>
>>> Well, I don't know what to say, it does require some resources.
>>>
>>>>> Do we have any idea about the guilty subsystem? You mentioned
>>>>> bdi_unregister, why? What would be the set of syscalls to concentrate
>>>>> on?
>>>>> I will do a custom run when I get around to it, if nobody else beats me to it.
>>>>
>>>> Because bdi_unregister() does "bdi->dev = NULL;" which wb_workfn() is hitting
>>>> NULL pointer dereference.
>>>
>>> Right, wb_workfn is not a generic function, it's fs-specific function.
>>>
>>> Trying to reproduce this locally now.
>>
>>
>> No luck so far.
>>
>> Trying to look from a different angle: is it possible that bdi->dev is
>> not set yet, rather then already reset?
>
>
> I was able to reproduce this once locally running syz-crush utility
> replaying one of the crash logs. Now running with Tetsuo's patch.
>
> I can say we hunting a very subtle race condition with short
> inconsistency window, perhaps few instructions.


Here we go:

[ 2853.033175] WARNING: wb_workfn: device is NULL
[ 2853.034709] wb->state=2
[ 2853.035486] (wb == &wb->bdi->wb)=0
[ 2853.036489] list_empty(&wb->work_list)=1
[ 2853.037603] list_empty(&wb->bdi->bdi_list)=0
[ 2853.038843] wb->bdi->wb.state=0
[ 2853.039819] (wb->congested->__bdi == wb->bdi)=1
[ 2853.041062] list_empty(&wb->congested->__bdi->bdi_list)=0
[ 2853.042609] wb->congested->__bdi->wb.state=0
[ 2853.043793] kasan: CONFIG_KASAN_INLINE enabled
[ 2853.045315] kasan: GPF could be caused by NULL-ptr deref or user
memory access
[ 2853.047376] general protection fault: 0000 [#1] SMP KASAN
[ 2853.048980] CPU: 1 PID: 13971 Comm: kworker/u12:8 Not tainted 4.17.0+ #21
[ 2853.050762] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[ 2853.053034] Workqueue: writeback wb_workfn
[ 2853.054193] RIP: 0010:wb_workfn+0x187/0xab0
[ 2853.055360] Code: 85 70 fd ff ff 48 83 e8 10 48 89 85 60 fd ff ff
e8 5e 38 ab ff 48 8d 7b 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
c1 ea 03 <80> 3c 02 00 0f 85 05 08 00 00 4c 8b 63 50 4d 85 e4 0f 84 b5
05 00
[ 2853.060692] RSP: 0018:ffff8800600ef480 EFLAGS: 00010206
[ 2853.062210] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 2853.064215] RDX: 000000000000000a RSI: ffffffff81cf0312 RDI: 0000000000000050
[ 2853.066198] RBP: ffff8800600ef750 R08: ffff880061e30400 R09: ffffed000d8ccfc0
[ 2853.068037] R10: ffffed000d8ccfc0 R11: ffff88006c667e07 R12: 1ffff1000c01dead
[ 2853.069970] R13: ffff8800600ef728 R14: ffff8800676bd180 R15: dffffc0000000000
[ 2853.071932] FS:  0000000000000000(0000) GS:ffff88006c640000(0000)
knlGS:0000000000000000
[ 2853.074080] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2853.075699] CR2: 00007ffc8478c000 CR3: 0000000008c6a006 CR4: 00000000001626e0
[ 2853.077633] Call Trace:
[ 2853.078341]  ? inode_wait_for_writeback+0x40/0x40
[ 2853.079642]  ? graph_lock+0x170/0x170
[ 2853.080710]  ? lock_downgrade+0x8e0/0x8e0
[ 2853.081889]  ? find_held_lock+0x36/0x1c0
[ 2853.083047]  ? graph_lock+0x170/0x170
[ 2853.084105]  ? lock_acquire+0x1dc/0x520
[ 2853.085216]  ? process_one_work+0xb8c/0x1b70
[ 2853.086425]  ? kasan_check_read+0x11/0x20
[ 2853.087608]  ? __lock_is_held+0xb5/0x140
[ 2853.088720]  process_one_work+0xc64/0x1b70
[ 2853.089875]  ? finish_task_switch+0x182/0x840
[ 2853.091085]  ? pwq_dec_nr_in_flight+0x490/0x490
[ 2853.092358]  ? __schedule+0x809/0x1e30
[ 2853.093475]  ? retint_kernel+0x10/0x10
[ 2853.094561]  ? retint_kernel+0x10/0x10
[ 2853.095610]  ? graph_lock+0x170/0x170
[ 2853.096623]  ? trace_hardirqs_on_caller+0x421/0x5c0
[ 2853.097981]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 2853.099298]  ? find_held_lock+0x36/0x1c0
[ 2853.100394]  ? lock_acquire+0x1dc/0x520
[ 2853.101472]  ? worker_thread+0x3d4/0x13a0
[ 2853.102558]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[ 2853.104060]  ? move_linked_works+0x2f6/0x470
[ 2853.105204]  ? trace_event_raw_event_workqueue_execute_start+0x290/0x290
[ 2853.107013]  ? do_raw_spin_trylock+0x1b0/0x1b0
[ 2853.108243]  worker_thread+0x9e5/0x13a0
[ 2853.109304]  ? process_one_work+0x1b70/0x1b70
[ 2853.110488]  ? graph_lock+0x170/0x170
[ 2853.111514]  ? find_held_lock+0x36/0x1c0
[ 2853.112610]  ? find_held_lock+0x36/0x1c0
[ 2853.113674]  ? __schedule+0x1e30/0x1e30
[ 2853.114714]  ? do_raw_spin_unlock+0x1f9/0x2e0
[ 2853.115885]  ? do_raw_spin_trylock+0x1b0/0x1b0
[ 2853.117060]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[ 2853.118492]  ? __kthread_parkme+0x111/0x1d0
[ 2853.119616]  ? parse_args.cold.15+0x1b3/0x1b3
[ 2853.120804]  ? trace_hardirqs_on_caller+0x421/0x5c0
[ 2853.122071]  ? trace_hardirqs_on+0xd/0x10
[ 2853.123117]  kthread+0x345/0x410
[ 2853.123999]  ? process_one_work+0x1b70/0x1b70
[ 2853.125174]  ? kthread_bind+0x40/0x40
[ 2853.126201]  ret_from_fork+0x3a/0x50
[ 2853.127199] Modules linked in:
[ 2853.128022] Dumping ftrace buffer:
[ 2853.128901]    (ftrace buffer empty)
[ 2853.129986] ---[ end trace 3ba28e076cb32fda ]---
[ 2853.131269] RIP: 0010:wb_workfn+0x187/0xab0
[ 2853.132441] Code: 85 70 fd ff ff 48 83 e8 10 48 89 85 60 fd ff ff
e8 5e 38 ab ff 48 8d 7b 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
c1 ea 03 <80> 3c 02 00 0f 85 05 08 00 00 4c 8b 63 50 4d 85 e4 0f 84 b5
05 00
[ 2853.137449] RSP: 0018:ffff8800600ef480 EFLAGS: 00010206
[ 2853.138618] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 2853.140176] RDX: 000000000000000a RSI: ffffffff81cf0312 RDI: 0000000000000050
[ 2853.141722] RBP: ffff8800600ef750 R08: ffff880061e30400 R09: ffffed000d8ccfc0
[ 2853.143300] R10: ffffed000d8ccfc0 R11: ffff88006c667e07 R12: 1ffff1000c01dead
[ 2853.144841] R13: ffff8800600ef728 R14: ffff8800676bd180 R15: dffffc0000000000
[ 2853.146391] FS:  0000000000000000(0000) GS:ffff88006c640000(0000)
knlGS:0000000000000000
[ 2853.148141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2853.149406] CR2: 00007ffc8478c000 CR3: 0000000008c6a006 CR4: 00000000001626e0
[ 2853.150968] Kernel panic - not syncing: Fatal exception
[ 2853.152419] Dumping ftrace buffer:
[ 2853.153121]    (ftrace buffer empty)
[ 2853.153786] Kernel Offset: disabled
[ 2853.154442] Rebooting in 86400 seconds..
