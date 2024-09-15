Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B93C14012
	for <linux-block@vger.kernel.org>; Sun, 15 Sep 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726379427; cv=none; b=Q1iXkSwlDGhUjRLm+W1Pw2yPQcrMRfko9GZpdFzc9WgnDm5AEk2F49srYjUXp6J7iSfYoqnZZPf0p1+tf9onUkcD9bFSFRGHCO3cwvOBvjHwm4ahwGDJO1+edrUpo6s0T5k3//t7/7wTMQPZZxWBWsSE7SSnSG5iE45U8EQ7MYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726379427; c=relaxed/simple;
	bh=lQl7jmUDb4c8lw4IrcQIgoRgqvkG1Sp4n0CWEBaisp8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kewa5Y+3cY7gbVc0ZKeLESnuZHy7+YK8rIelDsUcgXXj+cgUzmfzZa0+kdQIqoXeGZAw4WdxLrFna+RM4OetdcAtGUf3iN/5B0imzu6ps3WZLBMrX8dUteQfGpqfeqjGZDRbL5kg6ZisouQw7eZme9IAKsS5VuVswt85F7l8DUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cf28c74efso853141839f.1
        for <linux-block@vger.kernel.org>; Sat, 14 Sep 2024 22:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726379424; x=1726984224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61NMgJkn8LfmHo4kTFJjxaAjtgXjESTtZN5vJyuiZTA=;
        b=TB65ep+COrZ8mqmzc+SMSxQuS20fhjFwEla02fvxDTXhJHzqNToEsmKOS3C7uAV1jJ
         oufL/EPuLapSDKnfQEXP61Jle0m9XI39nBCu97slDJk/kjAoPLQ0j/BHNJzyQvaZwtjR
         grem64/GIwhaYJMMmQvCAgsoxFh7r0QoxDTwBMY9ouYM7FBkWEC1/v5Qf3TKGKpnAYDf
         cM7iANJiCL8AhAIS0coRWL3drv/1dCe+cuxIXx03upHkdohU8SdHDDkiWqsOC3xpekSt
         hZ/DD9hbQLKYSJx8MjrDvqLqfLr60Z+T8009nZV/EQZKragJWeugPsAG5XoMi9duYZpj
         lzrw==
X-Forwarded-Encrypted: i=1; AJvYcCXiGHrVVx1q9a/jyxqnrVOCp3XYVSbh3cVj8MoMqq2170IRE0vJyOe/L+AotaSzc8DLcJzwaNWdYqpCfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaUTm6VzyPw+xAkhJ3AR2JATCtxoLodppbLj0ME85X4+jLgGr
	v7M4yJ4JkjIzQnVHAoT9jFWiF7ZTdgpEVZmr6n3egGwRrFaQ5HLe5IHEr+W1/t5GPLkjxEitlpG
	oKB9qZdUhjFrvYwNhhltxmIRCcFjZRgTN4eiXf0SXmKu9tBkwDIkvy+M=
X-Google-Smtp-Source: AGHT+IHUkv6fjyQHJ4enVdWcIvOhkCrYCYzCVHcMraoSBAExiJTAnlGnVeHBvbHiZ/JT+ROSvEzXhDgf6rIQuwlr0ub1XPOioDt4
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0d:b0:39d:300f:e8ff with SMTP id
 e9e14a558f8ab-3a0848c8e16mr116221755ab.6.1726379424700; Sat, 14 Sep 2024
 22:50:24 -0700 (PDT)
Date: Sat, 14 Sep 2024 22:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b6b0e0622220846@google.com>
Subject: [syzbot] [block?] [virt?] kernel panic: corrupted stack end in
 kernel_init (2)
From: syzbot <syzbot+ec17b78de14721dd3bdc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1ff95eb2bebd riscv: Fix RISCV_ALTERNATIVE_EARLY
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=172cb0a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79e90d7b2f5b364
dashboard link: https://syzkaller.appspot.com/bug?extid=ec17b78de14721dd3bdc
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-1ff95eb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1491182abe4e/vmlinux-1ff95eb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/926302c5c645/Image-1ff95eb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec17b78de14721dd3bdc@syzkaller.appspotmail.com

Registered RDS/tcp transport
NET: Registered PF_SMC protocol family
9pnet: Installing 9P2000 support
Key type dns_resolver registered
Key type ceph registered
libceph: loaded (mon/osd proto 15/24)
NET: Registered PF_VSOCK protocol family
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: f2a59455c4296818b28c73c1d87b1152c8ec3b9d'
zswap: loaded using pool 842/z3fold
Demotion targets for Node 0: null
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
Key type .fscrypt registered
Key type fscrypt-provisioning registered
Key type big_key registered
Key type encrypted registered
AppArmor: AppArmor sha256 policy hashing enabled
ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: f2a59455c4296818b28c73c1d87b1152c8ec3b9d'
ima: Allocated hash algorithm: sha256
ima: No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux (disabled)
evm: security.SMACK64 (disabled)
evm: security.SMACK64EXEC (disabled)
evm: security.SMACK64TRANSMUTE (disabled)
evm: security.SMACK64MMAP (disabled)
evm: security.apparmor
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
printk: legacy console [netcon0] enabled
netconsole: network logging started
gtp: GTP module loaded (pdp ctx size 128 bytes)
rdma_rxe: loaded
clk: Disabling unused clocks
PM: genpd: Disabling unused power domains
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
EXT4-fs (vda): mounted filesystem 34b94c48-234b-4869-b990-1f782e29954a ro with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) readonly on device 253:0.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 2532K
Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
Run /sbin/init as init process
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.11.0-rc2-syzkaller-g1ff95eb2bebd #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80010216>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff85edbc4e>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
[<ffffffff85f3714c>] __dump_stack lib/dump_stack.c:93 [inline]
[<ffffffff85f3714c>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:119
[<ffffffff85f371f6>] dump_stack+0x1c/0x24 lib/dump_stack.c:128
[<ffffffff85edc812>] panic+0x388/0x806 kernel/panic.c:348
[<ffffffff85f4533a>] schedule_debug kernel/sched/core.c:5745 [inline]
[<ffffffff85f4533a>] __schedule+0x3230/0x3288 kernel/sched/core.c:6411
[<ffffffff85f45a4c>] preempt_schedule_notrace+0xe0/0x2be kernel/sched/core.c:6801
[<ffffffff85f39cc0>] lockdep_enabled kernel/locking/lockdep.c:118 [inline]
[<ffffffff85f39cc0>] lock_is_held_type+0x7a/0x1f2 kernel/locking/lockdep.c:5824
[<ffffffff816b51d8>] lock_is_held include/linux/lockdep.h:249 [inline]
[<ffffffff816b51d8>] depot_fetch_stack+0x86/0xc8 lib/stackdepot.c:448
[<ffffffff816b5e7e>] __stack_depot_get_stack_record+0xe/0x1e lib/stackdepot.c:688
[<ffffffff809774ee>] inc_stack_record_count mm/page_owner.c:197 [inline]
[<ffffffff809774ee>] __set_page_owner+0x2fe/0x70c mm/page_owner.c:329
[<ffffffff8087cbf6>] set_page_owner include/linux/page_owner.h:32 [inline]
[<ffffffff8087cbf6>] post_alloc_hook+0xea/0x1e2 mm/page_alloc.c:1493
[<ffffffff80883c0a>] prep_new_page mm/page_alloc.c:1501 [inline]
[<ffffffff80883c0a>] get_page_from_freelist+0x123c/0x27e8 mm/page_alloc.c:3442
[<ffffffff80885ec6>] __alloc_pages_noprof+0x1f0/0x2142 mm/page_alloc.c:4700
[<ffffffff809079f2>] alloc_pages_mpol_noprof+0xf8/0x48a mm/mempolicy.c:2263
[<ffffffff80907ef8>] alloc_pages_noprof+0x174/0x2f0 mm/mempolicy.c:2343
[<ffffffff80908098>] folio_alloc_noprof+0x24/0x6c mm/mempolicy.c:2350
[<ffffffff806bd12c>] filemap_alloc_folio_noprof+0x348/0x44e mm/filemap.c:1008
[<ffffffff806fa3ae>] page_cache_ra_unbounded+0x17c/0x4e6 mm/readahead.c:248
[<ffffffff806fa808>] do_page_cache_ra+0xf0/0x134 mm/readahead.c:303
[<ffffffff806fb2fe>] page_cache_ra_order+0xe8/0x17a mm/readahead.c:488
[<ffffffff806fc28c>] page_cache_async_ra+0x51c/0x7c2 mm/readahead.c:638
[<ffffffff806cb988>] filemap_readahead mm/filemap.c:2504 [inline]
[<ffffffff806cb988>] filemap_get_pages+0x310/0x1628 mm/filemap.c:2545
[<ffffffff806ccfee>] filemap_read+0x34e/0xc30 mm/filemap.c:2625
[<ffffffff806cdb66>] generic_file_read_iter+0x296/0x38a mm/filemap.c:2806
[<ffffffff80d323a6>] ext4_file_read_iter fs/ext4/file.c:147 [inline]
[<ffffffff80d323a6>] ext4_file_read_iter+0x15e/0x400 fs/ext4/file.c:130
[<ffffffff809df5c8>] __kernel_read+0x302/0x886 fs/read_write.c:434
[<ffffffff810b71ce>] integrity_kernel_read+0x92/0xc4 security/integrity/iint.c:28
[<ffffffff810c1224>] ima_calc_file_hash_tfm+0x2da/0x3ec security/integrity/ima/ima_crypto.c:480
[<ffffffff810c2b90>] ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
[<ffffffff810c2b90>] ima_calc_file_hash+0x19e/0x456 security/integrity/ima/ima_crypto.c:568
[<ffffffff810c4c98>] ima_collect_measurement+0x7b4/0x918 security/integrity/ima/ima_api.c:293
[<ffffffff810bd664>] process_measurement+0x10e4/0x2026 security/integrity/ima/ima_main.c:372
[<ffffffff810beb44>] ima_file_mmap+0x1be/0x1de security/integrity/ima/ima_main.c:462
[<ffffffff80feef5a>] security_mmap_file+0x102/0x184 security/security.c:2860
[<ffffffff8076b28c>] vm_mmap_pgoff+0xd2/0x310 mm/util.c:584
[<ffffffff8076b54e>] vm_mmap+0x84/0xac mm/util.c:607
[<ffffffff80b83f8a>] elf_map fs/binfmt_elf.c:381 [inline]
[<ffffffff80b83f8a>] elf_load+0x186/0x716 fs/binfmt_elf.c:408
[<ffffffff80b878dc>] load_elf_interp fs/binfmt_elf.c:675 [inline]
[<ffffffff80b878dc>] load_elf_binary+0x33c2/0x4c1e fs/binfmt_elf.c:1235
[<ffffffff809fa6b0>] search_binary_handler fs/exec.c:1821 [inline]
[<ffffffff809fa6b0>] exec_binprm fs/exec.c:1863 [inline]
[<ffffffff809fa6b0>] bprm_execve fs/exec.c:1914 [inline]
[<ffffffff809fa6b0>] bprm_execve+0x744/0x18a4 fs/exec.c:1890
[<ffffffff809fe1e2>] kernel_execve+0x2c8/0x378 fs/exec.c:2081
[<ffffffff85edace4>] run_init_process+0x194/0x1a8 init/main.c:1388
[<ffffffff85edad16>] try_to_run_init_process+0x1e/0x66 init/main.c:1395
[<ffffffff85f3cf60>] kernel_init+0x180/0x224 init/main.c:1523
[<ffffffff85f5b972>] ret_from_fork+0xe/0x1c arch/riscv/kernel/entry.S:239
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
