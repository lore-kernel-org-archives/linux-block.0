Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA542065;
	Tue, 23 Sep 2025 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609358; cv=none; b=TOx1SYqQK0ZXbuES+5v1p0h14U2OgdkEijN5Bj3cG/qQmLCcLIALHPLZnKtrEla/AmjCr3w8rocxCKTGkFwLjo9BgIMI8nDHbN742ypf7kqbq/VFtqVu2YDQI/Tvpb5yuu89DUeYy/xrnNkweeptbryX8yJM1QalsVvfVKnmjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609358; c=relaxed/simple;
	bh=GmYl4sidVZ2b8f9R+Mbdxe2D1L3Evjy3NL/rRlJbGX0=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y6GBypu8tzRyquM71/dPoBFy9PhID4acJS5KmU/O3xwlj8wTGKxE30MCSGhkJ6mJbVzK2YQ/pzqgn+TW84objeCf+iVB4+GsCdr6jcYTOIJ/ARQ3eSnRkrVWoL22F0wn40e92SbfN3c8xqE4M6OoybmOPgKl7mNf5LBQ4mCE2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cW9GS6ppPzYQvSY;
	Tue, 23 Sep 2025 14:35:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 742681A0F3F;
	Tue, 23 Sep 2025 14:35:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBnK2PCP9JocX0eAg--.38804S3;
	Tue, 23 Sep 2025 14:35:47 +0800 (CST)
Subject: Re: [syzbot] [block?] general protection fault in
 blk_mq_free_tags_callback
To: Jens Axboe <axboe@kernel.dk>,
 syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Ming Lei <ming.lei@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <68d1b079.a70a0220.1b52b.0000.GAE@google.com>
 <4d1fd301-cd8b-496b-b5da-de8b9f17d44e@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3a069431-dbc0-28c1-c7eb-6f376b38c866@huaweicloud.com>
Date: Tue, 23 Sep 2025 14:35:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4d1fd301-cd8b-496b-b5da-de8b9f17d44e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnK2PCP9JocX0eAg--.38804S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw15tw4Dury5Cr4xGr1UGFg_yoWxGFy7pr
	W5Jr42krsYqr1UAF1xKF1UJw1UKrZxCa17JrWxJr18A3WUGw1UJr1xtr4xJryDJrWUC3W3
	t3Z8W3y8tryUWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

在 2025/09/23 14:20, Jens Axboe 写道:
> On 9/22/25 2:24 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13c238e2580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
>> dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e427c580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb8142580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/c53d48022f8a/disk-846bd222.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/483534e784c8/vmlinux-846bd222.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/721b36eec9b3/bzImage-846bd222.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com
>>
>> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>> CPU: 0 UID: 0 PID: 5962 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>> Workqueue: rcu_gp srcu_invoke_callbacks
>> RIP: 0010:__list_del_entry_valid_or_report+0x25/0x190 lib/list_debug.c:49
>> Code: 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 89 fb 49 bd 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 af 58 47 fd 4c 8b 7b 08 48 89 d8 48 c1 e8
>> RSP: 0018:ffffc90003d2f8e8 EFLAGS: 00010202
>> RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88802f573c80
>> RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000008
>> RBP: dffffc0000000000 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
>> R10: dffffc0000000000 R11: ffffffff84b089f0 R12: 1ffff11004cb1e1f
>> R13: dffffc0000000000 R14: ffff88802658f0a0 R15: 0000000000000000
>> FS:  0000000000000000(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055946acdc950 CR3: 000000007a708000 CR4: 00000000003526f0
>> Call Trace:
>>   <TASK>
>>   __list_del_entry_valid include/linux/list.h:132 [inline]
>>   __list_del_entry include/linux/list.h:223 [inline]
>>   list_del_init include/linux/list.h:295 [inline]
>>   blk_mq_free_tags_callback+0x5a/0x180 block/blk-mq-tag.c:593
>>   srcu_invoke_callbacks+0x208/0x450 kernel/rcu/srcutree.c:1807
>>   process_one_work kernel/workqueue.c:3263 [inline]
>>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>>   kthread+0x711/0x8a0 kernel/kthread.c:463
>>   ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>   </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:__list_del_entry_valid_or_report+0x25/0x190 lib/list_debug.c:49
>> Code: 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 89 fb 49 bd 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 af 58 47 fd 4c 8b 7b 08 48 89 d8 48 c1 e8
>> RSP: 0018:ffffc90003d2f8e8 EFLAGS: 00010202
>> RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88802f573c80
>> RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000008
>> RBP: dffffc0000000000 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
>> R10: dffffc0000000000 R11: ffffffff84b089f0 R12: 1ffff11004cb1e1f
>> R13: dffffc0000000000 R14: ffff88802658f0a0 R15: 0000000000000000
>> FS:  0000000000000000(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055946acdc950 CR3: 000000007a708000 CR4: 00000000003526f0
>> ----------------
>> Code disassembly (best guess):
>>     0:	90                   	nop
>>     1:	90                   	nop
>>     2:	90                   	nop
>>     3:	90                   	nop
>>     4:	90                   	nop
>>     5:	f3 0f 1e fa          	endbr64
>>     9:	41 57                	push   %r15
>>     b:	41 56                	push   %r14
>>     d:	41 55                	push   %r13
>>     f:	41 54                	push   %r12
>>    11:	53                   	push   %rbx
>>    12:	48 89 fb             	mov    %rdi,%rbx
>>    15:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
>>    1c:	fc ff df
>>    1f:	48 83 c7 08          	add    $0x8,%rdi
>>    23:	48 89 f8             	mov    %rdi,%rax
>>    26:	48 c1 e8 03          	shr    $0x3,%rax
>> * 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
>>    2f:	74 05                	je     0x36
>>    31:	e8 af 58 47 fd       	call   0xfd4758e5
>>    36:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
>>    3a:	48 89 d8             	mov    %rbx,%rax
>>    3d:	48                   	rex.W
>>    3e:	c1                   	.byte 0xc1
>>    3f:	e8                   	.byte 0xe8
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
> 
> Adding Ming, looks related to the SRCU changes perhaps?
> 

A quick look, yes it's related. Root cause is that blk_mq_free_tags()
can be called after blk_mq_init_tags(), while tags->page_list is still
not initialized by blk_mq_alloc_rqs().

Thanks,
Kuai

