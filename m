Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53E2F3E
	for <linux-block@vger.kernel.org>; Sun, 25 Aug 2024 05:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724562672; cv=none; b=UHi5bHA4gqVZpH4tCyBzxDAp7+RJrfdS0UcplCXtJ2GKlrD/KYLpG3RJmuVJdoc42SmZ4IRAJvW5Y9eNjL932w45KfYLv7CEpN297stAbnBMJ9PwCZ5sFXOSvPekQXQ00e6m4E11QTU2JH3P//FeAMijbqwdX+m0cK6WN9s2hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724562672; c=relaxed/simple;
	bh=r8fSZZAkztvwgMS1RQkgMWFwRxP1fwiNkSnvFeTAVD4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j901gqEaXyTw10+gvmaByGtuwQZVSOXZ5YsNwX+7iru3pGil1f6TiFLMLNZLRVPjPyAhAY8YhGY6FHHF6rp9pSDmqWwGGoogwbAF/09MbWVka13/bweIVusKK1ankBTo0fH2qVZz0cuVhwyib92iE/2YGSLPufrdeOl8ZKJz2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=dHCviQG4; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kw2ExnXp; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="dHCviQG4";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kw2ExnXp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724562671; x=1756098671;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=r8fSZZAkztvwgMS1RQkgMWFwRxP1fwiNkSnvFeTAVD4=;
  b=dHCviQG4uVLptoIbLamNqx51hrxDzZ5D28Uqs5QA7+BwNYXtFDMlIsXV
   rh1iJiDYzPZwzl35/872/iAyhzzeWybkysEcRUUAsFc0d3dRJD7HLr1T3
   W8eEo2YGrUGfSXrWK5X98T9yavhnb8TAZ0Wfjk0ZNcs8RmUceNrtuUWmm
   OaFyVj18E5doQhknPQ7GNKPARkWYCHYkgKoKT+davrtQoLqMZt5fCeuAD
   aWZzo08zCsBhYv3ZiRkq5BVFM6aIILcB8kM4plWsmIXJhCjRGa6mIRU7h
   qmQY8qhy37yMPOiGkJ+OMIs1lXuGOQOZ4plE4hi+3asFtkLBuc7HCogGZ
   g==;
X-CSE-ConnectionGUID: Dhl1zKAhRuexI2qNO9qgvw==
X-CSE-MsgGUID: zw0u9nIYS1SwP6zPCJ+HcA==
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:11:10 -0700
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7ad78c1a019so3184858a12.2
        for <linux-block@vger.kernel.org>; Sat, 24 Aug 2024 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724562669; x=1725167469; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p7huxQOEChvdaykUFKGm0QTI9D846dJ8HoKnVfcJIa4=;
        b=kw2ExnXpdlUQP09ttmT0ceOnR7mSxNdXShuqB/68jUKUh2wFLjBiWf3BoaJIDb14sm
         vesPkWVAiMRgoIJ/is+33HR8ZDpP7qrxtKYIRLAVDYeCEk22acCJIL7xDA2jT1KY0efh
         /1+Q2SU96Fsy8dCUpCN4tpba6CDmiN32/P45c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724562669; x=1725167469;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7huxQOEChvdaykUFKGm0QTI9D846dJ8HoKnVfcJIa4=;
        b=Zrbs+rdLfWEa8/JQ+7pCwJfKI0czD0JjbAtTeSp6MwnG6Vw1K+xXJE3mcVc+GgOjQt
         KGKOV4WHznpTCYnCt7mEnwMZ/A2NjAwWWRGEY4bLL2mwrSanxu5C0XVUpgLKD1DhnRiT
         G1HYs3ndVlQI5Ip+XKZvSTpWEdTLhrYTXzxQXbFBKomZFjgUPuCF0Zv7J5Lw6Hz+K8KZ
         Ba2JbzFxF0YHt2jDoLk2m4aN2hHDfiLX0V3OALtwXeaqeMzK9kl9kdZitHx55pl9eY8R
         CuCtqMsl0Dg0Cy81Oex4L43dVM6Y43LjuMBX9xF/PJXeVXIphIEkY6FbNAw3dp0t/nEd
         QlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHUe2YPP39vXS8H3ERhW3COUcgBHlVJaDBxDpw7Ed+uV8E9intHwnI9mQp4EA8LBp/potOGDfsW8zHHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKE8cYJsv7GqD/oOafA/plvcf+cP/pBIjQx2u8Kwfhc2qjFnRm
	ns/mKKQrEUi14AXvovfCHiDf8BqVNldmcUapdL4Oc4gSFcXTvm4rl+2FHlDx+Rzb4GS198ym6F3
	fc5ib4a4YDB+9xNtw7qtpxPsbrXhLBsKjOcGH/NFfmv2LRrU6X3QR9Z0qggDHRV83aIlVP2LvOJ
	sDIT9YOY3FgTwLDHD9PudWFoPwcRUhdR4pbcPG
X-Received: by 2002:a05:6a20:c78e:b0:1c8:d4d4:4139 with SMTP id adf61e73a8af0-1cc89ee9760mr7128026637.43.1724562668889;
        Sat, 24 Aug 2024 22:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMx+3/jZdACx242VZMz16w96+QtHP69PBKO3MDWyzAQk+gOxzbDpBjWTxSNCAsJyamiZqedVQCaEf+xbuOsTE=
X-Received: by 2002:a05:6a20:c78e:b0:1c8:d4d4:4139 with SMTP id
 adf61e73a8af0-1cc89ee9760mr7128020637.43.1724562668543; Sat, 24 Aug 2024
 22:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:10:58 -0700
Message-ID: <CALAgD-6gJ4W1rPj=CWG7bFUPpEJnUjEhQd3uvH=7C=aGKb=CUQ@mail.gmail.com>
Subject: BUG: general protection fault in update_io_ticks
To: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We found a bug in Linux 6.10. It is probably a null pointer dereference bug=
.
The bug report and syzkaller reproducer are as follows:

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 45 Comm: kworker/u4:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:update_io_ticks+0x94/0x2c0 block/blk-core.c:992
Code: f3 f3 f3 48 89 54 24 18 4a 89 04 32 e8 75 77 59 fd 48 c1 eb 03
48 89 5c 24 08 eb 03 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80
3c 30 00 74 08 48 89 df e8 6d 82 bc fd 4c 8b 3b 48 8b 44 24
RSP: 0018:ffffc9000090e620 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888015330000
RDX: 0000000000000000 RSI: 0000000100000845 RDI: 0000000000000000
RBP: ffffc9000090e6d8 R08: ffffffff843a8b4a R09: 1ffffffff1e48be5
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000100000845
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88801d4f2058
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd0a027408 CR3: 00000000232cc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_account_io_start+0x189/0x2d0 block/blk-mq.c:1022
 blk_mq_bio_to_request block/blk-mq.c:2559 [inline]
 blk_mq_submit_bio+0x1043/0x1f40 block/blk-mq.c:2996
 __submit_bio+0x1bc/0x550 block/blk-core.c:627
 __submit_bio_noacct_mq block/blk-core.c:708 [inline]
 submit_bio_noacct_nocheck+0x3ed/0xc20 block/blk-core.c:737
 ext4_io_submit+0xd4/0x130 fs/ext4/page-io.c:377
 ext4_do_writepages+0x293b/0x38e0 fs/ext4/inode.c:2699
 ext4_writepages+0x20c/0x3b0 fs/ext4/inode.c:2768
 do_writepages+0x36f/0x880 mm/page-writeback.c:2656
 __writeback_single_inode+0xe2/0x660 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x8ee/0x1140 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2018
 wb_writeback+0x3e7/0x750 fs/fs-writeback.c:2129
 wb_check_old_data_flush fs/fs-writeback.c:2233 [inline]
 wb_do_writeback fs/fs-writeback.c:2286 [inline]
 wb_workfn+0xa29/0xf00 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:update_io_ticks+0x94/0x2c0 block/blk-core.c:992
Code: f3 f3 f3 48 89 54 24 18 4a 89 04 32 e8 75 77 59 fd 48 c1 eb 03
48 89 5c 24 08 eb 03 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80
3c 30 00 74 08 48 89 df e8 6d 82 bc fd 4c 8b 3b 48 8b 44 24
RSP: 0018:ffffc9000090e620 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888015330000
RDX: 0000000000000000 RSI: 0000000100000845 RDI: 0000000000000000
RBP: ffffc9000090e6d8 R08: ffffffff843a8b4a R09: 1ffffffff1e48be5
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000100000845
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88801d4f2058
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd0a027408 CR3: 00000000232cc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: f3 f3 f3 48 89 54 24 repz repz xrelease mov %rdx,0x18(%rsp)
   7: 18
   8: 4a 89 04 32           mov    %rax,(%rdx,%r14,1)
   c: e8 75 77 59 fd       call   0xfd597786
  11: 48 c1 eb 03           shr    $0x3,%rbx
  15: 48 89 5c 24 08       mov    %rbx,0x8(%rsp)
  1a: eb 03                 jmp    0x1f
  1c: 4c 8b 2b             mov    (%rbx),%r13
  1f: 49 8d 5d 28           lea    0x28(%r13),%rbx
  23: 48 89 d8             mov    %rbx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 30 00       cmpb   $0x0,(%rax,%r14,1) <-- trapping instructi=
on
  2f: 74 08                 je     0x39
  31: 48 89 df             mov    %rbx,%rdi
  34: e8 6d 82 bc fd       call   0xfdbc82a6
  39: 4c 8b 3b             mov    (%rbx),%r15
  3c: 48                   rex.W
  3d: 8b                   .byte 0x8b
  3e: 44                   rex.R
  3f: 24                   .byte 0x24


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
HandleSegv:false Trace:false LegacyOptions:{Collide:false Fault:false
FaultCall:0 FaultNth:0}}
write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
&(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf26=
4340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12=
ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a3=
00916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc4=
14539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
0xb4)
r0 =3D syz_open_dev$sg(&(0x7f00000000c0), 0x0, 0x181040)
ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})


--=20
Yours sincerely,
Xingyu
