Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6013AA2F
	for <linux-block@vger.kernel.org>; Sun, 15 Feb 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771165044; cv=none; b=AAEzNqFZSrbzv6rrZwjhhEnVoegAz4o/4m5MFNnsSEoKLr4oPAwayEcMuloaOKKKmoByhr9cCSWfTHUHBwxsxvpA1QqWFAIQg66fbCLYNTQHApVAeYz5gEEoGljrM+5opREc7NY1Hm77wl1JBqLVXhKauKaI0Tx/4mXj+wojfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771165044; c=relaxed/simple;
	bh=ZBLB7jFPV8OZ7V3p93BOQLk28F7cz08wYQ94FSvB4ss=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GCoCqy4s9y5E7miI82GOjLTK9iXM3y6Ei226Gk2AbgBhgqST56JKXRX6vWY2Dvb1sTzkqjJsr+PaEVsunjh6I5/7s5yxlybl/zjPQ0wR3v8mRXcBNU1m7oYt3ZYJ11KXv/6iCpzTRMSTt5oSNwAMR6QCDOguF0ELbfF+ULS6Y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6751720c676so28267772eaf.3
        for <linux-block@vger.kernel.org>; Sun, 15 Feb 2026 06:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771165042; x=1771769842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFQ0suPqLa7s93qRuDqntHlf05CVVhmbHVLlG5/KLUU=;
        b=TiqdxTgdleB5tAq7e0D3R0f0GBtB362mtY8/Q34yLO2GNnkpewv5NoZdBFXCT7TpJH
         juzeK49aFuGKm3xQe+4m6KXWXDjfQQSY9D3l2JxziLAkLftSWnYyOeZVnSYJqL3nwZLj
         /FBL6ojoQJ7avv3vgSsXUcNhoC6w+E9UD0Gq0479f7mq877N+KPQO08RiypxFFlHk4Tl
         8d2ybJyDMO9ann/OaYsCnZeDYNF0bcM9P6zBGv0yYP71F9I3wKjTJCUTnP8feIi8FNdu
         HUlHTnQh1H0FcpYge8L4lW031Ikz3B48Io8coDydVkDX1Hum4odheZOedT/eEUguaIum
         dbXA==
X-Forwarded-Encrypted: i=1; AJvYcCUZuTUotWylRtBKqJ059sQ6v5KAza6gufixsVAEaMEKjuENsLT08qPtbMcqs/GQnfWuci5aiMAmCFj1mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgHKG5Rjp+0aPuRrZSZubkU0CD8NlSzdEPZA11HJYdrVdVtzq
	5QtIrc5kX4E6hgVtHwTzF0vloRtEifzkGyUdv0fkxGB7kxRRBP8LVYCqEFjh6zlarQDVQIqZbOj
	QN2w0KxWXA51P/JVuikCbmHwZkFoO2NfIpwYEdaKfplV0enyqkWFJ4H5WkAA=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1623:b0:659:9a49:8f9a with SMTP id
 006d021491bc7-6785989e4abmr2824842eaf.19.1771165042168; Sun, 15 Feb 2026
 06:17:22 -0800 (PST)
Date: Sun, 15 Feb 2026 06:17:22 -0800
In-Reply-To: <691367ae.a70a0220.22f260.0141.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6991d572.050a0220.2757fb.0031.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_startstop
From: syzbot <syzbot+774863666ef5b025c9d0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    635c467cc14e Add linux-next specific files for 20260213
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14d8ec02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09eec269f9f4746
dashboard link: https://syzkaller.appspot.com/bug?extid=774863666ef5b025c9d0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc2ffa580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24870d51cbd0/disk-635c467c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49283c738806/vmlinux-635c467c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c5f9d1da977/bzImage-635c467c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b01c09978893/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=163e915a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+774863666ef5b025c9d0@syzkaller.appspotmail.com

INFO: task syz.3.20:6102 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.20        state:D stack:28368 pid:6102  tgid:6087  ppid:5957   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7061
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7fe/0x1300 kernel/locking/mutex.c:776
 blk_trace_startstop+0x8f/0x610 kernel/trace/blktrace.c:901
 blk_trace_ioctl+0x315/0x740 kernel/trace/blktrace.c:947
 blkdev_common_ioctl+0x13a7/0x3250 block/ioctl.c:724
 blkdev_ioctl+0x528/0x740 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f530c39bf79
RSP: 002b:00007f530d2e4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f530c616180 RCX: 00007f530c39bf79
RDX: 0000000000000000 RSI: 0000000000001275 RDI: 0000000000000007
RBP: 00007f530c4327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f530c616218 R14: 00007f530c616180 R15: 00007ffdd027c568
 </TASK>
INFO: task syz.2.19:6109 blocked for more than 150 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:26720 pid:6109  tgid:6091  ppid:5955   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7061
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7fe/0x1300 kernel/locking/mutex.c:776
 relay_open+0x3b8/0x920 kernel/relay.c:516
 blk_trace_setup_prepare+0x425/0x5a0 kernel/trace/blktrace.c:716
 blk_trace_setup+0x2c0/0x430 kernel/trace/blktrace.c:789
 blk_trace_ioctl+0x380/0x740 kernel/trace/blktrace.c:935


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
