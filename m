Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918282BF002
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066510; cv=none; b=r26JMwTkXZNryCBA0GxxMETFhuJeDNeTH7uvLUqiDHYdyqTtMYr+wqt0mTsi+z/P/ypNrDgSHgbtyt+zHEIqwBClF6zi+fTE8zkrOGuck5zGWgGQRsZFXC8gDM3+uCqKSzmHkjhC7CfnPrgH4UnqVKIf1z8LFHn6IM6dPqA8noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066510; c=relaxed/simple;
	bh=QrUw5wx6Zi6OdHnBtaCTdCevZ09hIv8FNK8RsANa4Yo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DRDDNEVgAdBUAh12FkJQjsAsIaGjEgq8XMSesn77wRL1QG24oTQrwdL3g9bK7oQf1yI7FlBrVOLx8zzOBwAXyso41CF7qAgPUceWbcoek5853lyL7o6qOlESPP3bxXS+eS9BnVVyMiHxNEMDP/N1UgaPZWkKLYtxo8EG39zX+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4b388697b03so306254b6e.0
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2026 22:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066507; x=1788671307;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M9Xja3isy4PvneAFilyVvbQLwR9EOrBnUoImyCuQUe4=;
        b=F/qryVWklA2728Z/MO6RI3BFRuW5I6z7ei2+yA7EoYglxTgipv9P6Stev3tRTtFWSE
         wPIRslS9bnbyvjHgRGv/lvlPR1ljbqCvHsK05L9Pppxxq/gnMh6VTHDcMqZiRNqSxs3O
         X61uhdXhWCA1T/JKoFlCmL4PY8VD7GMPUHWz2wPdXHMIs7FR48Ck8Q5P2DPMVQpasl00
         blgEnNSYbe9bc4LpkBw6KeNHDxR9xB23XAeMxb/MvOmkjaCXtf47PbkcU72OxUhezMm/
         fNCEBbkkindkKk3x7hllxgkz4kIf7YVycxdSRnw4lfyNo4WUSJEJH+6YofUFAURTv84W
         UTWQ==
X-Forwarded-Encrypted: i=1; AHgh+RokOIogqESfkdwBFprF+1ZfJn0Vz6u2EVPthJT75ioAJlSmBgDkB4rXttW43+TGrywAq7VH/V3keSn67w==@vger.kernel.org
X-Gm-Message-State: AFuF++mki8Kt7qNe4/xQ+TR0beNIIQEtqstWCGk7E0jJN9rxGxS1Itue
	++4rBp+A2HJDTS7iBnxd00pi0i8b9h93D3sjBsNPulxRUKjiIN8Ip5p+1pplwOkjp8XjVPWqyRK
	08IMWa+a/lNgObkkekzZQbCp9E3fOlgEPDRVRJMWIbbXlwlQ/3ssO/mk3MV0=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fea:b0:4b3:7b31:8df0 with SMTP id
 5614622812f47-4b3981ae41amr18296040b6e.10.1788066507419; Sat, 29 Aug 2026
 22:08:27 -0700 (PDT)
Date: Sat, 29 Aug 2026 22:08:27 -0700
In-Reply-To: <6a778d36.01d0871a.3a0d52.006f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a93bacb.08e933ee.dbf97.00f9.GAE@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_validate_limits
From: syzbot <syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@infradead.org, kbusch@kernel.org, kbusch@meta.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e30626823a40 Add linux-next specific files for 20260828
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=157e7d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da8932b2925a9804
dashboard link: https://syzkaller.appspot.com/bug?extid=ac00e7bf7ac8c91af921
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16936e25580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179fc379580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3d0d809c004/disk-e3062682.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14efbbb42757/vmlinux-e3062682.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0919b1002ace/bzImage-e3062682.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4f0c60a63a72/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12936e25580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com

F2FS-fs (loop0): f2fs_disable_checkpoint finishes, err:0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e6
fscrypt: AES-256-XTS using blk-crypto-fallback
------------[ cut here ]------------
lim->dma_alignment > PAGE_SIZE
WARNING: block/blk-settings.c:497 at blk_validate_limits+0x1676/0x2270 block/blk-settings.c:497, CPU#1: syz-executor215/5627
Modules linked in:
CPU: 1 UID: 0 PID: 5627 Comm: syz-executor215 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:blk_validate_limits+0x1676/0x2270 block/blk-settings.c:497
Code: e8 cf da 0b fd 90 0f 0b 90 eb 8f e8 c4 da 0b fd 90 0f 0b 90 eb 84 e8 b9 da 0b fd 90 0f 0b 90 e9 76 ff ff ff e8 ab da 0b fd 90 <0f> 0b 90 e9 68 ff ff ff e8 9d da 0b fd 90 0f 0b 90 e9 81 00 00 00
RSP: 0018:ffffc900038dee60 EFLAGS: 00010293
RAX: ffffffff84bbe625 RBX: ffffc900038df0f0 RCX: ffff888076f99f40
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000001000
RBP: 00000000ffffffff R08: ffff88806ec9427f R09: 1ffff1100dd9284f
R10: dffffc0000000000 R11: ffffed100dd92850 R12: ffffc900038df040
R13: dffffc0000000000 R14: 1ffff9200071be1e R15: dffffc0000000000
FS:  000055557ce9e400(0000) GS:ffff888124dd6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000072708000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_limits_commit_update+0x87/0x390 block/blk-settings.c:552
 loop_configure+0x7f1/0xdc0 drivers/block/loop.c:1086
 lo_ioctl+0xae0/0x2010 drivers/block/loop.c:1564
 blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1351d03669
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd20598c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1351d03669
RDX: 00002000000005c0 RSI: 0000000000004c0a RDI: 0000000000000004
RBP: 0000000000000001 R08: 000055557ce9f580 R09: 000055557ce9f580
R10: 0000200000000600 R11: 0000000000000246 R12: 00007ffd20598c60
R13: 0000000000000002 R14: 431bde82d7b634db R15: 00007f1351d6204b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
