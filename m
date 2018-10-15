Return-Path: <valdis.kletnieks@vt.edu>
From: valdis.kletnieks@vt.edu
To: Dennis Zhou <dennisszhou@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>
cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [BUG] ext4/block null pointer crashes in linux-next
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Oct 2018 19:28:48 -0400
Message-ID: <13987.1539646128@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

So I finally had a chance to find a replicator and finish bisecting this and:

[/usr/src/linux-next] git bisect good
e2b0989954ae7c80609f77e7ce203bea6d2c54e1 is the first bad commit
commit e2b0989954ae7c80609f77e7ce203bea6d2c54e1
Author: Dennis Zhou (Facebook) <dennisszhou@gmail.com>
Date:   Tue Sep 11 14:41:35 2018 -0400

    blkcg: cleanup and make blk_get_rl use blkg_lookup_create

I was able to do a bit of sleuthing with strace, and I tracked it down to one of
several execve() calls that 'rpm' makes with my replicating test case.

 grep execve /root/rpm-exec-strace 
execve("/usr/bin/rpm", ["rpm", "-Uvh", "--force", "dracut-049-4.git20181010.fc30.x8"...], 0x7ffc9d967d80 /* 33 vars */) = 0
[pid 119212] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.w7fu"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
[pid 119213] execve("/sbin/ldconfig", ["/sbin/ldconfig"], 0x558ccf928ac0 /* 33 vars */) = 0
[pid 119216] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.bIKt"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
[pid 119217] execve("/usr/bin/systemd-run", ["/usr/bin/systemd-run", "/usr/bin/systemctl", "start", "man-db-cache-update"], 0x56360645d290 /* 33 vars */) = 0
[pid 119221] execve("/bin/sh", ["/bin/sh", "/usr/src/redhat/tmp/rpm-tmp.OGWg"..., "0", "0"], 0x7ffdfe17d480 /* 33 vars */) = 0
[pid 119920] execve("/usr/bin/systemctl", ["/usr/bin/systemctl", "daemon-reload"], 0x55c0f5d43c30 /* 33 vars */) = 0

The ldconfig and systemctl commands run just fine stand-alone, so I'm suspecting the
calls to run the temp files - it's quite possible that execve() gets invoked on them before
writeback has actually gotten the data to the disk - though that shouldn't matter.

But I managed to trigger a different traceback. I cd /usr/src/redhat/tmp, and I
did an 'rm *' - and never got a prompt back. Traceback out of pstore below.

Now here's the weird part - I'd already unmounted, fsck'ed, and remounted the
file system before the 'rm *'.  And thinking that there was one file with a
busted inode that passed fsck.ext4's sniff test, I did:

cd /usr/src/redhat/tmp
for i in `find . -type f`; do sleep 5; echo $i; rm $i; done

and that worked just fine. Nothing left in that directory but . and ..  
I then re-ran my rpm-based replicator and it blew up again.

Traceback of the rm crash (I have *no* idea why it has systemd-tmpfile as Comm:
as none of the tmpfile config reference /usr/src at all, and the config says it
shouldn't have been running at the time of the crash, and I can't replicate as
the directory is now empty...)

[  919.756309] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  919.756317] PGD 0 P4D 0
[  919.756327] Oops: 0000 [#1] PREEMPT SMP PTI
[  919.756333] CPU: 0 PID: 3659 Comm: systemd-tmpfile Tainted: G           O    T 4.19.0-rc6-next-20181005-dirty #621
[  919.756337] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A21 02/21/2018
[  919.756346] RIP: 0010:__get_request+0x31/0x7e0
[  919.756351] Code: 89 e5 41 57 41 56 41 55 49 89 fd 41 54 41 89 f4 53 48 83 ec 50 48 8b 1f 48 85 d2 48 89 55 b8 89 4d c0 44 89 45 c4 48 8b 43 18 <48> 8b 00
48 89 45 b0 0f 84 ba 03 00 00 48 8b 42 58 48 85 c0 48 89
[  919.756355] RSP: 0018:ffffad75883ef858 EFLAGS: 00010086
[  919.756361] RAX: 0000000000000000 RBX: ffffa27a9892b000 RCX: 0000000000000000
[  919.756366] RDX: ffffa27a8a81cf00 RSI: 0000000000003000 RDI: ffffa27993c25840
[  919.756370] RBP: ffffad75883ef8d0 R08: 0000000000600000 R09: 0000000000000001
[  919.756374] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000003000
[  919.756378] R13: ffffa27993c25840 R14: ffffa27a8a81cf00 R15: ffffa27993c258c0
[  919.756383] FS:  00007f15be4f7940(0000) GS:ffffa27a9d400000(0000) knlGS:0000000000000000
[  919.756387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  919.756391] CR2: 0000000000000000 CR3: 00000004058ee006 CR4: 00000000001606f0
[  919.756395] Call Trace:
[  919.756410]  get_request+0x214/0x8b0
[  919.756420]  ? remove_wait_queue+0x70/0x70
[  919.756429]  blk_queue_bio+0x23b/0x760
[  919.756439]  generic_make_request+0x2fe/0x570
[  919.756446]  ? guard_bio_eod+0x40/0x320
[  919.756455]  submit_bio+0x4d/0x190
[  919.756460]  ? submit_bio+0x4d/0x190
[  919.756465]  ? guard_bio_eod+0x172/0x320
[  919.756473]  submit_bh_wbc+0x236/0x2b0
[  919.756481]  ll_rw_block+0xdf/0xf0
[  919.756490]  ext4_bread+0x96/0xe0
[  919.756498]  __ext4_read_dirblock+0x44/0x3c0
[  919.756508]  htree_dirblock_to_tree+0x6f/0x2c0
[  919.756522]  ext4_htree_fill_tree+0xc6/0x3c0
[  919.756529]  ? ext4_readdir+0x9e8/0xc30
[  919.756536]  ? ext4_readdir+0x9e8/0xc30
[  919.756542]  ? kmem_cache_alloc_trace+0x382/0x4a0
[  919.756551]  ext4_readdir+0x893/0xc30
[  919.756568]  iterate_dir+0xa6/0x1c0
[  919.756575]  ksys_getdents64+0x13d/0x1f0
[  919.756580]  ? iterate_dir+0x1c0/0x1c0
[  919.756590]  __x64_sys_getdents64+0x1b/0x20
[  919.756596]  do_syscall_64+0x8f/0xa52
[  919.756602]  ? trace_hardirqs_off_caller+0x22/0x150
[  919.756609]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  919.756619]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  919.756624] RIP: 0033:0x7f15bf1ace7b

The original RPM replicable traceback:
[  680.692888] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  680.692895] PGD 0 P4D 0
[  680.692901] Oops: 0000 [#1] PREEMPT SMP PTI
[  680.692905] CPU: 3 PID: 15464 Comm: sh Tainted: G           O    T 4.19.0-rc6-next-20181005-dirty #621
[  680.692908] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A21 02/21/2018
[  680.692915] RIP: 0010:__get_request+0x31/0x7e0
[  680.692918] Code: 89 e5 41 57 41 56 41 55 49 89 fd 41 54 41 89 f4 53 48 83 ec 50 48 8b 1f 48 85 d2 48 89 55 b8 89 4d 
c0 44 89 45 c4 48 8b 43 18 <48> 8b 00 48 89 45 b0 0f 84 ba 03 00 00 48 8b 42 58 48 85 c0 48 89
[  680.692921] RSP: 0018:ffff9fa98d93f578 EFLAGS: 00010086
[  680.692925] RAX: 0000000000000000 RBX: ffff975ad40e7040 RCX: 0000000000000000
[  680.692927] RDX: ffff975aac306e00 RSI: 0000000000080000 RDI: ffff975acce39840
[  680.692930] RBP: ffff9fa98d93f5f0 R08: 0000000000600000 R09: 0000000000000001
[  680.692933] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000080000
[  680.692935] R13: ffff975acce39840 R14: ffff975aac306e00 R15: ffff975acce398c0
[  680.692938] FS:  00007f8fb7876740(0000) GS:ffff975adda00000(0000) knlGS:0000000000000000
[  680.692941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  680.692944] CR2: 0000000000000000 CR3: 00000003ebc64006 CR4: 00000000001606e0
[  680.692946] Call Trace:
[  680.692957]  get_request+0x214/0x8b0
[  680.692964]  ? remove_wait_queue+0x70/0x70
[  680.692971]  blk_queue_bio+0x23b/0x760
[  680.692977]  generic_make_request+0x2fe/0x570
[  680.692983]  submit_bio+0x4d/0x190
[  680.692987]  ? submit_bio+0x4d/0x190
[  680.692992]  ? bio_add_page+0x4b/0x60
[  680.692997]  ext4_mpage_readpages+0x814/0xed4
[  680.693002]  ? get_page_from_freelist+0x42c/0x1bd0
[  680.693015]  ext4_readpages+0x55/0x60
[  680.693020]  read_pages+0x72/0x190
[  680.693031]  __do_page_cache_readahead+0x1f6/0x220
[  680.693045]  ondemand_readahead+0x2ae/0x4f0
[  680.693055]  page_cache_sync_readahead+0x112/0x250
[  680.693065]  generic_file_buffered_read+0x542/0xf70
[  680.693079]  ? _raw_spin_unlock_irqrestore+0x78/0xa0
[  680.693087]  ? avc_update_node+0x1b6/0x2c0
[  680.693095]  generic_file_read_iter+0xd0/0x140
[  680.693102]  ext4_file_read_iter+0x6c/0x80
[  680.693107]  new_sync_read+0x121/0x1a0
[  680.693116]  __vfs_read+0x49/0x60
[  680.693120]  vfs_read+0x152/0x250
[  680.693126]  kernel_read+0x43/0x60
[  680.693131]  prepare_binprm+0x19b/0x1f0
[  680.693136]  __do_execve_file+0x5ca/0xbc0
[  680.693142]  __x64_sys_execve+0x38/0x50
[  680.693148]  do_syscall_64+0x8f/0xa52
[  680.693152]  ? trace_hardirqs_off_caller+0x22/0x150
[  680.693156]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  680.693162]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  680.693165] RIP: 0033:0x7f8fb7942b5b
[  680.693169] Code: 41 89 01 eb da 66 2e 0f 1f 84 00 00 00 00 00 f7 d8 64 41 89 01 eb d6 0f 1f 84 00 00 00 00 00 f3 0f 
1e fa b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 62 0f 00 f7 d8 64 89 01 48
