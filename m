Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEB239086;
	Mon,  4 Aug 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293107; cv=none; b=M5VtfeUe7bVQoV4cnZgp0wZnUYvnjGNCF8PSRVCZXUf9dTKFx5bHPUysV5HQdicGjEyHx2w4u0xbRIWkipPT8s6IOt1Pj3fdcl0OWQRJNdc/Z9lDBD7gxfAKxEXhMJpssq+BKDuhlU993z6qBBTbfXJYvYxeeoCveG2FLdkuulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293107; c=relaxed/simple;
	bh=yMJkuWx7IPtk3aMt74ArgnutRpKX8Fl2ge2xGdoEmBI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mz76h+vGU5a9iqleHPTKXh7FW/dVPBjHK3qX6xjOzf8lY9Rg+XpvPhWgqXRDzzWhYPeH0zOxHQeJ0sHvjpRbJEwDvL298NPGMHMKEjz9VwyO4PhClG1QI3Pyof+V/6JaBvH+Xr0BGN9uY8N2dY4mmow9QIHMN106hH72shdqaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bwT1p4df9zYQvHX;
	Mon,  4 Aug 2025 15:38:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4E1F91A0DEF;
	Mon,  4 Aug 2025 15:38:21 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hJoY5BoogMWCg--.25925S3;
	Mon, 04 Aug 2025 15:38:17 +0800 (CST)
Subject: Re: [syzbot] [block?] WARNING: ODEBUG bug in disk_release
To: syzbot <syzbot+1fe2f3ddc7f8f83fb196@syzkaller.appspotmail.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, "yukuai (C)" <yukuai3@huawei.com>
References: <688d8708.050a0220.f0410.0135.GAE@google.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5a2f36d8-763d-68fe-1687-fe1a4854df34@huaweicloud.com>
Date: Mon, 4 Aug 2025 15:38:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <688d8708.050a0220.f0410.0135.GAE@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hJoY5BoogMWCg--.25925S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw17KFW5Xr1Dtr1kAryUtrb_yoW7AFWkpr
	W5tr42krW8XFyUAF18X3WUZr1jgFZ8AF1UGry7Xr1kAFsxCF1UJr18trWDWrWDJrW0qF17
	t3Z8Ca95tr1UXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

#syz dup: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works

在 2025/08/02 11:33, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    89748acdf226 Merge tag 'drm-next-2025-08-01' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=151c12a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff858d5d4508232d
> dashboard link: https://syzkaller.appspot.com/bug?extid=1fe2f3ddc7f8f83fb196
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4f34b67c9cfc/disk-89748acd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2f11bb9a095b/vmlinux-89748acd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3e15dbd303fb/bzImage-89748acd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1fe2f3ddc7f8f83fb196@syzkaller.appspotmail.com
> 
> md: md2 stopped.
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object: ffff88801f3b4448 object type: work_struct hint: mddev_delayed_delete+0x0/0x20 drivers/md/md.c:721
> WARNING: CPU: 0 PID: 11789 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
> Modules linked in:
> CPU: 0 UID: 0 PID: 11789 Comm: syz.5.1495 Not tainted 6.16.0-syzkaller-10499-g89748acdf226 #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 41 56 48 8b 14 dd e0 0a 16 8c 4c 89 e6 48 c7 c7 60 ff 15 8c e8 bf 92 90 fc 90 <0f> 0b 90 90 58 83 05 b6 a5 bf 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
> RSP: 0018:ffffc90004a6f928 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffc9001b884000
> RDX: 0000000000080000 RSI: ffffffff817a2815 RDI: 0000000000000001
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8c160600
> R13: ffffffff8bac16a0 R14: ffffffff8856a0a0 R15: ffffc90004a6fa28
> FS:  00007f777160f6c0(0000) GS:ffff8881246fb000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000020000011a000 CR3: 000000005441a000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
>   debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
>   slab_free_hook mm/slub.c:2348 [inline]
>   slab_free mm/slub.c:4680 [inline]
>   kfree+0x28f/0x4d0 mm/slub.c:4879
>   disk_release+0x2a1/0x410 block/genhd.c:1310
>   device_release+0xa4/0x240 drivers/base/core.c:2565
>   kobject_cleanup lib/kobject.c:689 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   kobject_put+0x1e7/0x5a0 lib/kobject.c:737
>   put_device+0x1f/0x30 drivers/base/core.c:3797
>   blkdev_release+0x15/0x20 block/fops.c:699
>   __fput+0x3ff/0xb70 fs/file_table.c:468
>   task_work_run+0x14d/0x240 kernel/task_work.c:227
>   get_signal+0x1d1/0x26d0 kernel/signal.c:2807
>   arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
>   exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:40
>   exit_to_user_mode_prepare include/linux/irq-entry-common.h:224 [inline]
>   syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>   do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f777078eb69
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f777160f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: 0000000000000000 RBX: 00007f77709b6160 RCX: 00007f777078eb69
> RDX: 0000000000000007 RSI: 0000000000000932 RDI: 0000000000000007
> RBP: 00007f7770811df1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f77709b6160 R15: 00007ffcb194e248
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> .
> 

