Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD288C2B9F4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD1611AC
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 08:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhFSIuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 04:50:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51584 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFSIuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 04:50:19 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15J8lVn3015307;
        Sat, 19 Jun 2021 17:47:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Sat, 19 Jun 2021 17:47:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15J8lUTk015300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 19 Jun 2021 17:47:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] block: genhd: don't call probe function with
 major_names_lock held
To:     Greg KH <gregkh@linuxfoundation.org>, hch@infradead.org
Cc:     axboe@kernel.dk, desmondcheongzx@gmail.com,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        vigneshr@ti.com
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <YM2STfTN5AupWlSa@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c4edf07f-92e1-a350-2743-f0b0234a2b6c@i-love.sakura.ne.jp>
Date:   Sat, 19 Jun 2021 17:47:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YM2STfTN5AupWlSa@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/19 15:44, Greg KH wrote:
>> Note that regardless of this patch, it is up to probe function to
>> serialize module's __init function and probe function in that module
>> by using e.g. a mutex. This patch simply makes sure that module's __exit
>> function won't be called when probe function is about to be called.
> 
> module init functions ARE serialized.

The __init functions between module foo and module bar are serialized.
But the __init function for module foo and the probe function for module
foo are not serialized.

> The module owner should not matter here.

The __exit functions between module foo and module bar are serialized.
But the __exit function for module bar and the probe function for module
bar are not serialized.

You can observe a deadlock via the following steps.

(1) Build loop.ko with CONFIG_BLK_DEV_LOOP_MIN_COUNT=0 and
    a delay injection patch shown below.

----------
diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..fe0360dc8c5d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -680,6 +680,11 @@ void blk_request_module(dev_t devt)
 	mutex_lock(&major_names_lock);
 	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
 		if ((*n)->major == major && (*n)->probe) {
+			if (!strcmp(current->comm, "bash")) {
+				pr_info("sleep injection start\n");
+				schedule_timeout_killable(10 * HZ); // Call "rmmod" here.
+				pr_info("sleep injection end\n");
+			}
 			(*n)->probe(devt);
 			mutex_unlock(&major_names_lock);
 			return;
----------

(2) Run the following commands from bash shell.

# modprobe loop
# mknod /dev/loop0 b 7 0
# exec 100<>/dev/loop0 & sleep 1; rmmod loop

(3) See dmesg output.

----------
[   32.260467][ T2873] loop: module loaded
[   32.289961][ T2880] sleep injection start
[   42.484039][ T2880] sleep injection end
[   42.484218][ T2880]
[   42.484248][ T2880] ======================================================
[   42.484381][ T2880] WARNING: possible circular locking dependency detected
[   42.484455][ T2880] 5.13.0-rc6+ #867 Not tainted
[   42.484508][ T2880] ------------------------------------------------------
[   42.484579][ T2880] bash/2880 is trying to acquire lock:
[   42.484638][ T2880] ffffffffc075b468 (loop_ctl_mutex){+.+.}-{3:3}, at: loop_probe+0x44/0x90 [loop]
[   42.484760][ T2880]
[   42.484760][ T2880] but task is already holding lock:
[   42.484836][ T2880] ffffffff873ffe28 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x1f/0x100
[   42.484950][ T2880]
[   42.484950][ T2880] which lock already depends on the new lock.
[   42.484950][ T2880]
[   42.485053][ T2880]
[   42.485053][ T2880] the existing dependency chain (in reverse order) is:
[   42.485144][ T2880]
[   42.485144][ T2880] -> #1 (major_names_lock){+.+.}-{3:3}:
[   42.485230][ T2880]        lock_acquire+0xb3/0x380
[   42.485292][ T2880]        __mutex_lock+0x89/0x8f0
[   42.485350][ T2880]        mutex_lock_nested+0x16/0x20
[   42.485410][ T2880]        unregister_blkdev+0x38/0xb0
[   42.485469][ T2880]        loop_exit+0x44/0xd84 [loop]
[   42.485534][ T2880]        __x64_sys_delete_module+0x135/0x210
[   42.485602][ T2880]        do_syscall_64+0x36/0x70
[   42.485660][ T2880]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   42.485733][ T2880]
[   42.485733][ T2880] -> #0 (loop_ctl_mutex){+.+.}-{3:3}:
[   42.485817][ T2880]        check_prevs_add+0x16a/0x1040
[   42.487091][ T2880]        __lock_acquire+0x118b/0x1580
[   42.488427][ T2880]        lock_acquire+0xb3/0x380
[   42.489701][ T2880]        __mutex_lock+0x89/0x8f0
[   42.490960][ T2880]        mutex_lock_nested+0x16/0x20
[   42.492374][ T2880]        loop_probe+0x44/0x90 [loop]
[   42.493756][ T2880]        blk_request_module+0xa3/0x100
[   42.495207][ T2880]        blkdev_get_no_open+0x93/0xc0
[   42.496516][ T2880]        blkdev_get_by_dev+0x56/0x200
[   42.497735][ T2880]        blkdev_open+0x5d/0xa0
[   42.498919][ T2880]        do_dentry_open+0x163/0x3b0
[   42.500157][ T2880]        vfs_open+0x28/0x30
[   42.501312][ T2880]        path_openat+0x7e6/0xad0
[   42.502443][ T2880]        do_filp_open+0x9f/0x110
[   42.503592][ T2880]        do_sys_openat2+0x245/0x310
[   42.504647][ T2880]        do_sys_open+0x48/0x80
[   42.505689][ T2880]        __x64_sys_open+0x1c/0x20
[   42.506730][ T2880]        do_syscall_64+0x36/0x70
[   42.507795][ T2880]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   42.508890][ T2880]
[   42.508890][ T2880] other info that might help us debug this:
[   42.508890][ T2880]
[   42.511436][ T2880]  Possible unsafe locking scenario:
[   42.511436][ T2880]
[   42.512303][ T2880]        CPU0                    CPU1
[   42.512727][ T2880]        ----                    ----
[   42.513143][ T2880]   lock(major_names_lock);
[   42.513557][ T2880]                                lock(loop_ctl_mutex);
[   42.513987][ T2880]                                lock(major_names_lock);
[   42.514417][ T2880]   lock(loop_ctl_mutex);
[   42.514841][ T2880]
[   42.514841][ T2880]  *** DEADLOCK ***
[   42.514841][ T2880]
[   42.516112][ T2880] 1 lock held by bash/2880:
[   42.516518][ T2880]  #0: ffffffff873ffe28 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x1f/0x100
[   42.517383][ T2880]
[   42.517383][ T2880] stack backtrace:
[   42.518228][ T2880] CPU: 3 PID: 2880 Comm: bash Not tainted 5.13.0-rc6+ #867
[   42.518679][ T2880] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   42.519650][ T2880] Call Trace:
[   42.520128][ T2880]  dump_stack+0x76/0x95
[   42.520608][ T2880]  print_circular_bug.isra.50.cold.71+0x13c/0x141
[   42.521105][ T2880]  check_noncircular+0xfe/0x110
[   42.521607][ T2880]  check_prevs_add+0x16a/0x1040
[   42.522106][ T2880]  __lock_acquire+0x118b/0x1580
[   42.522606][ T2880]  lock_acquire+0xb3/0x380
[   42.523244][ T2880]  ? loop_probe+0x44/0x90 [loop]
[   42.523753][ T2880]  __mutex_lock+0x89/0x8f0
[   42.524250][ T2880]  ? loop_probe+0x44/0x90 [loop]
[   42.524749][ T2880]  ? loop_probe+0x44/0x90 [loop]
[   42.525290][ T2880]  ? blkdev_get_by_dev+0x200/0x200
[   42.525790][ T2880]  ? vprintk_default+0x18/0x20
[   42.526286][ T2880]  ? vprintk+0x56/0x130
[   42.526797][ T2880]  ? blkdev_get_by_dev+0x200/0x200
[   42.527286][ T2880]  mutex_lock_nested+0x16/0x20
[   42.527768][ T2880]  ? mutex_lock_nested+0x16/0x20
[   42.528250][ T2880]  loop_probe+0x44/0x90 [loop]
[   42.528730][ T2880]  blk_request_module+0xa3/0x100
[   42.529209][ T2880]  blkdev_get_no_open+0x93/0xc0
[   42.529691][ T2880]  blkdev_get_by_dev+0x56/0x200
[   42.530176][ T2880]  ? blkdev_get_by_dev+0x200/0x200
[   42.530688][ T2880]  blkdev_open+0x5d/0xa0
[   42.531170][ T2880]  do_dentry_open+0x163/0x3b0
[   42.531656][ T2880]  vfs_open+0x28/0x30
[   42.532132][ T2880]  path_openat+0x7e6/0xad0
[   42.532612][ T2880]  do_filp_open+0x9f/0x110
[   42.533094][ T2880]  ? _raw_spin_unlock+0x1d/0x30
[   42.533582][ T2880]  ? alloc_fd+0x116/0x200
[   42.534069][ T2880]  do_sys_openat2+0x245/0x310
[   42.534566][ T2880]  do_sys_open+0x48/0x80
[   42.535015][ T2880]  __x64_sys_open+0x1c/0x20
[   42.535462][ T2880]  do_syscall_64+0x36/0x70
[   42.535913][ T2880]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   42.536364][ T2880] RIP: 0033:0x7f16f15737f0
[   42.536797][ T2880] Code: 48 8b 15 83 76 2d 00 f7 d8 64 89 02 48 83 c8 ff c3 66 0f 1f 84 00 00 00 00 00 83 3d cd d7 2d 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e cf 01 00 48 89 04 24
[   42.538148][ T2880] RSP: 002b:00007ffde9e2df58 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
[   42.538671][ T2880] RAX: ffffffffffffffda RBX: 00000000021b5020 RCX: 00007f16f15737f0
[   42.539173][ T2880] RDX: 00000000000001b6 RSI: 0000000000000042 RDI: 00000000021bd310
[   42.539681][ T2880] RBP: 00007ffde9e2dfe0 R08: 0000000000000020 R09: 00000000021bd310
[   42.540187][ T2880] R10: 00000000fffffff0 R11: 0000000000000246 R12: 000000000000000b
[   42.540696][ T2880] R13: 0000000000000001 R14: 0000000000000064 R15: 0000000000000000
[  246.772906][   T35] INFO: task bash:2880 blocked for more than 122 seconds.
[  246.774289][   T35]       Not tainted 5.13.0-rc6+ #867
[  246.775478][   T35] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.776734][   T35] task:bash            state:D stack:    0 pid: 2880 ppid:  2856 flags:0x00004000
[  246.779550][   T35] Call Trace:
[  246.781054][   T35]  __schedule+0x271/0x9e0
[  246.782381][   T35]  schedule+0x50/0xc0
[  246.783671][   T35]  schedule_preempt_disabled+0x10/0x20
[  246.784978][   T35]  __mutex_lock+0x467/0x8f0
[  246.786277][   T35]  ? loop_probe+0x44/0x90 [loop]
[  246.787582][   T35]  ? blkdev_get_by_dev+0x200/0x200
[  246.789093][   T35]  ? blkdev_get_by_dev+0x200/0x200
[  246.790409][   T35]  mutex_lock_nested+0x16/0x20
[  246.791700][   T35]  ? mutex_lock_nested+0x16/0x20
[  246.792992][   T35]  loop_probe+0x44/0x90 [loop]
[  246.794286][   T35]  blk_request_module+0xa3/0x100
[  246.795757][   T35]  blkdev_get_no_open+0x93/0xc0
[  246.797066][   T35]  blkdev_get_by_dev+0x56/0x200
[  246.798360][   T35]  ? blkdev_get_by_dev+0x200/0x200
[  246.799661][   T35]  blkdev_open+0x5d/0xa0
[  246.800953][   T35]  do_dentry_open+0x163/0x3b0
[  246.802258][   T35]  vfs_open+0x28/0x30
[  246.803559][   T35]  path_openat+0x7e6/0xad0
[  246.805201][   T35]  do_filp_open+0x9f/0x110
[  246.807128][   T35]  ? _raw_spin_unlock+0x1d/0x30
[  246.808461][   T35]  ? alloc_fd+0x116/0x200
[  246.809763][   T35]  do_sys_openat2+0x245/0x310
[  246.811034][   T35]  do_sys_open+0x48/0x80
[  246.812257][   T35]  __x64_sys_open+0x1c/0x20
[  246.813416][   T35]  do_syscall_64+0x36/0x70
[  246.814522][   T35]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  246.815624][   T35] RIP: 0033:0x7f16f15737f0
[  246.816707][   T35] RSP: 002b:00007ffde9e2df58 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
[  246.817863][   T35] RAX: ffffffffffffffda RBX: 00000000021b5020 RCX: 00007f16f15737f0
[  246.819033][   T35] RDX: 00000000000001b6 RSI: 0000000000000042 RDI: 00000000021bd310
[  246.820059][   T35] RBP: 00007ffde9e2dfe0 R08: 0000000000000020 R09: 00000000021bd310
[  246.820687][   T35] R10: 00000000fffffff0 R11: 0000000000000246 R12: 000000000000000b
[  246.821292][   T35] R13: 0000000000000001 R14: 0000000000000064 R15: 0000000000000000
[  246.821882][   T35] INFO: task rmmod:2882 blocked for more than 122 seconds.
[  246.822456][   T35]       Not tainted 5.13.0-rc6+ #867
[  246.823011][   T35] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.823599][   T35] task:rmmod           state:D stack:    0 pid: 2882 ppid:  2856 flags:0x00000000
[  246.824799][   T35] Call Trace:
[  246.825405][   T35]  __schedule+0x271/0x9e0
[  246.826018][   T35]  schedule+0x50/0xc0
[  246.826621][   T35]  schedule_preempt_disabled+0x10/0x20
[  246.827232][   T35]  __mutex_lock+0x467/0x8f0
[  246.827854][   T35]  ? unregister_blkdev+0x38/0xb0
[  246.828608][   T35]  mutex_lock_nested+0x16/0x20
[  246.829237][   T35]  ? mutex_lock_nested+0x16/0x20
[  246.829858][   T35]  unregister_blkdev+0x38/0xb0
[  246.830478][   T35]  loop_exit+0x44/0xd84 [loop]
[  246.831112][   T35]  __x64_sys_delete_module+0x135/0x210
[  246.831749][   T35]  do_syscall_64+0x36/0x70
[  246.832379][   T35]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  246.833019][   T35] RIP: 0033:0x7ff4990fcee7
[  246.833655][   T35] RSP: 002b:00007ffe445ecab8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.834326][   T35] RAX: ffffffffffffffda RBX: 0000000000a21220 RCX: 00007ff4990fcee7
[  246.835011][   T35] RDX: 00007ff499171a80 RSI: 0000000000000800 RDI: 0000000000a21288
[  246.835794][   T35] RBP: 0000000000000000 R08: 00007ff4993c6060 R09: 00007ff499171a80
[  246.836501][   T35] R10: 00007ffe445ec520 R11: 0000000000000206 R12: 00007ffe445ee840
[  246.837206][   T35] R13: 0000000000000000 R14: 0000000000a21220 R15: 0000000000a21010
[  246.837922][   T35] INFO: lockdep is turned off.
----------

Christoph and Desmond commented

  > > And now you can all probe after it has been freed and/or the module has
  > > been unloaded. The obviously correct fix is to only hold mtd_table_mutex
  > > for the actually required critical section:
  > > 
  > 
  > Thank you for the correction, Christoph. I hadn't thought of the 
  > scenario where the module is unloaded. I'll be more conscientious in the 
  > future.

at https://lkml.kernel.org/r/YMs3O/ce1567cf-bc94-790c-cfc0-e4e429e1a86a@gmail.com
but the fact that AB-BA deadlock is possible was forgotten. Therefore, I propose
this patch for fixing commit a160c6159d4a0cf8 ("block: add an optional probe callback
to major_names") which started calling the probe function without making sure that
the module will not go away.

>> @@ -676,14 +679,29 @@ void blk_request_module(dev_t devt)
>>  {
>>  	unsigned int major = MAJOR(devt);
>>  	struct blk_major_name **n;
>> +	void (*probe_fn)(dev_t devt);
>>  
>>  	mutex_lock(&major_names_lock);
>>  	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
>> -		if ((*n)->major == major && (*n)->probe) {
>> -			(*n)->probe(devt);
>> -			mutex_unlock(&major_names_lock);
>> -			return;
>> -		}
>> +		if ((*n)->major != major || !(*n)->probe)
>> +			continue;
>> +		if (!try_module_get((*n)->owner))
>> +			break;
> 
> So you just fail?  Are you sure that is ok?

After "break;", the control reaches request_module() (which waits for module
unloading to complete and then tries to load that module again).

I think failing open() for once due to racing with module unloading is acceptable
(as long as there is no leak/deadlock/oops etc.), but do we want to immediately
retry this loop after returning from request_module() ?

Also, to make sure that the __init function for module foo and the probe
function for module foo are serialized, should we also verify that
(*n)->owner && (*n)->owner->state == MODULE_STATE_LIVE (which indicates that
the __init function for that module has completed) because module_is_live()
 from try_module_get() is rather weak?

----------
/* FIXME: It'd be nice to isolate modules during init, too, so they
   aren't used before they (may) fail.  But presently too much code
   (IDE & SCSI) require entry into the module during init.*/
static inline bool module_is_live(struct module *mod)
{
	return mod->state != MODULE_STATE_GOING;
}
----------

>> +		/*
>> +		 * Assuming that unregister_blkdev() is called from module's
>> +		 * __exit function, a module refcount taken above allows us
>> +		 * to safely call probe function without major_names_lock held.
>> +		 */
>> +		probe_fn(devt);
>> +		module_put((*n)->owner);
> 
> So you are trying to keep the module in memory while the probe is call,
> ok.  But module removal is not an issue, you remove modules at your own
> risk.  As syzbot isn't even testing this, why is this an issue?

That's a crazy comment. A module removal bug (unless forced unloading is used)
is an issue. Why not fix bugs where syzbot cannot test?

