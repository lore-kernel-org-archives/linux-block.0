Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
Date: Wed, 20 Jun 2018 10:09:27 +0800
MIME-Version: 1.0
In-Reply-To: <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 06/19/2018 11:20 PM, Bart Van Assche wrote:
> On Tue, 2018-06-19 at 15:00 +0800, Jianchao Wang wrote:
>> Currently, the kobject_del for kobjs of mq, hctx and ctx is invoked
>> under sysfs_lock, lock inversion will come up when other one is
>> acessing the associated sysfs file and trying to acquire the
>> sysfs_lock. To fix it, use mutex_trylock in blk_mq_sysfs_ops and
>> blk_mq_hw_sysfs_ops, if the lock in on contending, return -EAGAIN.
> 
> Is this a theoretical issue or something you actually ran into? Which lock
> other than sysfs_lock do you think is involved in the lock inversion?
> 

It is very easy to reproduce with following scripts.

script 0
while true
do
	modprobe null_blk queue_mode=2 shared_tags=1
	sleep 0.1
	rmmod null_blk
	sleep 0.1
done

script 1
file0="/sys/block/nullb0/mq/0/nr_tags"
file1="/sys/block/nullb0/mq/0/cpu0/rq_list"
while true;
do
	if [ -e $file0 ];then
		cat $file0
	fi
	if [ -e $file1 ];then
		cat $file1
	fi
done

Here is the hung task log:

[  246.752087] INFO: task rmmod:12789 blocked for more than 30 seconds.
[  246.752801]       Not tainted 4.18.0-rc1 #88
[  246.753458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.754192] rmmod           D    0 12789   3142 0x00000080
[  246.754951] Call Trace:
[  246.755715]  ? __schedule+0x3f9/0xae0
[  246.756546]  schedule+0x3c/0x90
[  246.757440]  __kernfs_remove+0x1d0/0x2b0
[  246.757644]  ? wait_woken+0xb0/0xb0
[  246.757850]  kernfs_remove+0x1f/0x30
[  246.758059]  kobject_del+0x13/0x40
[  246.758271]  blk_mq_unregister_dev+0x4f/0xb0
[  246.758488]  blk_unregister_queue+0x71/0x100
[  246.758709]  del_gendisk+0x139/0x280
[  246.758936]  null_del_dev+0x40/0xf0 [null_blk]
[  246.759165]  null_exit+0x50/0xbec [null_blk]
[  246.759397]  __x64_sys_delete_module+0x12e/0x1d0
[  246.759636]  do_syscall_64+0x5a/0x1a0
[  246.759876]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  246.760129] RIP: 0033:0x7fc518522927
[  246.760481] Code: Bad RIP value.
[  246.760736] RSP: 002b:00007ffee4c69b68 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.761005] RAX: ffffffffffffffda RBX: 00007ffee4c69bc8 RCX: 00007fc518522927
[  246.761309] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055783881b248
[  246.761612] RBP: 000055783881b1e0 R08: 0000000000000000 R09: 1999999999999999
[  246.761902] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffee4c69d90
[  246.762199] R13: 00007ffee4c6b774 R14: 000055783881a010 R15: 000055783881b1e0
[  246.762503] INFO: task cat:12790 blocked for more than 30 seconds.
[  246.762812]       Not tainted 4.18.0-rc1 #88
[  246.763124] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.763453] cat             D    0 12790   3141 0x00000080
[  246.763789] Call Trace:
[  246.764130]  ? __schedule+0x3f9/0xae0
[  246.764552]  schedule+0x3c/0x90
[  246.764895]  schedule_preempt_disabled+0x14/0x20
[  246.765244]  __mutex_lock+0x41c/0x990
[  246.765595]  ? blk_mq_hw_sysfs_show+0x35/0x80
[  246.765950]  ? preempt_count_sub+0x92/0xd0
[  246.766311]  ? blk_mq_hw_sysfs_show+0x35/0x80
[  246.766675]  blk_mq_hw_sysfs_show+0x35/0x80
[  246.767043]  sysfs_kf_seq_show+0xad/0x100
[  246.767416]  seq_read+0xa5/0x410
[  246.767790]  __vfs_read+0x23/0x160
[  246.768172]  vfs_read+0xa0/0x140
[  246.768627]  ksys_read+0x45/0xa0
[  246.769008]  do_syscall_64+0x5a/0x1a0
[  246.769391]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  246.769798] RIP: 0033:0x7f743e39e260
[  246.770216] Code: Bad RIP value.

Thanks
Jianchao
> 
> 
> 
