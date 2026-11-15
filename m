Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755450;
	b=v4XyW4q0W1eWNvc2atHHJ5Y0Z7xPb2x/WMkGoHOH44AChY39d2tOXOUg2n6DmJIVhsMr
	 9PnpQtujF832tnE9iqcaLuvZ/CyKlc0DhLcovAhb+HPLSzmAa+JWOT6C7ah2OuRrqI/Xc
	 eXChKDYCcp5c4sr4hC12N9x47ZAk0bnhRVZiijTA4VTep389GI5IWQtUreRY5ChMhuiA6
	 QQxQhWXEfl9iUWlZu65AsHY4Xyiic5XrfSE07rn1sWBDL7kXa5ltDrWCE/6x183Jd+6E8
	 +xvexnV2sOBGU0zDd7qPptU3vbio9t8vc7ZPEG0SA1hBicMJBTsmqO+2OLcZA4zdEag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eaxEZyXDYRmU5Dprx1kNAyA3+B9VXgQMpA+bJiAtB4A=;
	b=SelTP5qCGha4JL1sl0wl5HB6rg79BhUn8yGTNSeYdRS+oLJYsT0prveDF/lCMu7hKDMb
	 lxpgqZvl/iRAF8U4WvNjGUERP6MA6CU6CFxmDNtHtEyEQ1qgFR1PQQjODEy19DaGBt7sT
	 LMutZMTijrgAY7k2Iqhn4y7pvcsDg1s4UWjjFQSWQ8PVJA2ejqQEEqCiCsUbhlLDv97RU
	 SxCkbPTIxQo6Jc4kf2/R/ScvAuqs+Lhr4FQykRC55oCzq+KvCvnodBb73KsvZKEpwhIqm
	 98Qy+8jegGKKOa2pUvVpO4qxl6BVl25BwBcNMM30V6honl4oBHSzSyiD2fuI17P6rUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S5tl92Wr;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F91606A31F
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 15:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F91606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S5tl92Wr
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so2740953c88.1
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794755448; x=1795360248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eaxEZyXDYRmU5Dprx1kNAyA3+B9VXgQMpA+bJiAtB4A=;
        b=S5tl92Wr9on2l61eHo+A1t4Eq1oCUdGXafRbi1t5HhQLm3kMyU3JzQ56DoKjpPcS9I
         vlsIw69+LRFR59sefyKphsOhi9eldOeSLN90ZXpkkHLqNwRrPAqYsWE8vSmdSVSDdXbC
         kKT11rnPEAzp24Olv00TjYGYd7MINAuS82MsECmzrO6dTcXtDNn1+ZGpFjUm7PRXjabf
         J3n1fkjdmknHHEbb/ZnVwpqS47giWdJS4hU1CK3OewdFfe23j8i+d7GVp5ZeQ1GbTx6D
         kYKr6Pm4iD5Imau0Gl5EiyndHLxrPkSI4ES9XYPAt2CQkb0Ib4UIVBQb8GC5YQnrZDtc
         2jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794755448; x=1795360248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eaxEZyXDYRmU5Dprx1kNAyA3+B9VXgQMpA+bJiAtB4A=;
        b=Eaaoa1S5tymtb89o7c7fKaF7abADwlHI8GvH6xQR5ybEcbjj8qImY6fT8FPvOy2/yU
         DU0X4UTHXd/JB08b9onlECg1fq0ZqNBCbw+jpgizjlfVyHYACZjeyGTip+Y4RI1IYbj2
         7PdiUIfruBK+SbkjsVAVeAFbXZPpfvym1TsjYPOJzq6A2ITwAtkRPyByl2nV85sbl/av
         eCd1WSjXbcXt+se9Mk9dhD9diTu8Q08CKKwARwHfAjWV0tVWN76G9XvSog2lOJMy2S6E
         ygHUiUnff+MjddSqUICUA5RmkjLo2BhZr3Au+dsHX5YLjLDL3GCOnNT8b9tdt6b/naYn
         y13A==
X-Forwarded-Encrypted: i=1; AL+hErEcvBcILbQYXi8ys+FKx9Npcbe8ioazoanlG68MrbQsYKZIs4hgDOyJHVSHA7REivHvU4xjrkkiCw+TZQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cfF5Z2sxcNPV1DMNI7i5Yi4+dt0+7YXJQ/G86PlnzNEulZEr9
	FRGd8u2e+hT93fDjXNxHwneUp4DUONcUQShABp9AvP+vFJ2cORg60xt/7wV4xFUGD+o=
X-Gm-Gg: AYBFou0F1JqslfMf6Bf8KBi02fx76f+X3+azDBxv9z2x/wVqeoDprjUeDpa7yT3MdrI
	eEGhuB7u8XLnyLDBYdA8CroAYLPFPtfaZXJSQEs2J5JeZSQqrPtgmjrYoGz9SWxbsOjV/36MC+g
	Kg3nm8PcMmP7nXdJ7rfRuuln4CWb6xQAcEEHz3UGI/L9xi+JbGykQOJJuQ4Y526VurQA1mn0oPc
	JVJnwPii8KmKpk1YYGEbT7gzUYi0GGY5HOij9EI3M1iN59BeCfFSW5cO+EoM+YWp72HkCSMJkyR
	XoSrA0aGC9oZwehKtXwYQvwD7FwASv2WRqvPdQ3Y0vpwG1Hg6QZivi6Tj6NL+owDmpOJtjAC9AD
	Cfc50zl66SxY5shDffMEmUqJmv10F6guPAoKmf0znR1xUHFhoVr8kgw8QMu63HyrIpJMA5dTNRZ
	piC2OSTSHbYD4XJHPHdXo3VkZWUqxRB2NelwFASgatT+iyDtC/J/+Hix3KOcnRwrvr72p60UMtX
	Tfoy5q+G4JsQgggdgj+EKp2GOy8huumcWsnWeDD6ZKU4nPAzCs/8b4bR/+6YY2rAke79wIYpEua
	dXpIhkVL3kmXHqey99DWHfN3Ngjfta0kV/AtHE2XjA2k+wLKdwOAxi4FdGDwJEYDAUtMtD5wOpO
	R/WEk7r6Hpcug
X-Received: by 2002:a05:701b:2402:b0:143:868a:20c1 with SMTP id a92af1059eb24-1b503193011mr7283380c88.46.1794755447423;
        Sun, 15 Nov 2026 07:10:47 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm28769861c88.5.2026.11.15.07.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 07:10:46 -0800 (PST)
Message-ID: <f462fe3a-229b-4ab3-8138-bc963c72c82f@kernel.dk>
Date: Sun, 15 Nov 2026 08:10:45 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING in io_wq_put_and_exit (2)
To: syzbot <syzbot+b0d54b9e81de55179e47@syzkaller.appspotmail.com>,
 elzeigel@gmail.com, io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel@vger.org,
 syzkaller-bugs@googlegroups.com, tom.leiming@gmail.com, zcgao@amazon.com
References: <6af9509c.07d0a7c9.39b765.0026.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6af9509c.07d0a7c9.39b765.0026.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 11:26 PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    aacb77975041 Merge tag 'ovl-fixes-7.4-rc3' of git://git.ke..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=1105ee3d580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf189394a856f11
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0d54b9e81de55179e47
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1093cb69580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0d54b9e81de55179e47@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> time_after(jiffies, warn_timeout)
> WARNING: io_uring/io-wq.c:1482 at io_wq_exit_workers io_uring/io-wq.c:1482 [inline], CPU#0: syz-executor273/6014
> WARNING: io_uring/io-wq.c:1482 at io_wq_put_and_exit+0x372/0x9d0 io_uring/io-wq.c:1511, CPU#0: syz-executor273/6014
> Modules linked in:
> CPU: 0 UID: 0 PID: 6014 Comm: syz-executor273 Tainted: G S                  syzkaller #0 PREEMPT(full) 
> Tainted: [S]=CPU_OUT_OF_SPEC
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
> RIP: 0010:io_wq_exit_workers io_uring/io-wq.c:1482 [inline]
> RIP: 0010:io_wq_put_and_exit+0x372/0x9d0 io_uring/io-wq.c:1511
> Code: 00 00 0f 85 7d 05 00 00 48 8b 15 e9 74 8a 0a 4d 89 e7 31 ff 49 29 d7 4c 89 fe e8 f9 fd d7 fc 4d 85 ff 79 aa e8 4f 03 d8 fc 90 <0f> 0b 90 eb 9f e8 44 03 d8 fc 4c 8d 63 08 48 b8 00 00 00 00 00 fc
> RSP: 0018:ffffc90003abfb10 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888038fb1000 RCX: 0000000000000000
> RDX: ffff88802b0d2580 RSI: ffffffff85367db1 RDI: 0000000000000007
> RBP: fffffbfff1f81e50 R08: 0000000000000000 R09: ffffffffffffd785
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000100001f9b
> R13: 0000000000000064 R14: ffff888038fb1018 R15: ffffffffffffd785
> FS:  00007f00678c46c0(0000) GS:ffff88812246c000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe270457d0 CR3: 0000000023abe000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  io_uring_clean_tctx+0x117/0x180 io_uring/tctx.c:261
>  io_uring_cancel_generic+0xa9e/0xb00 io_uring/cancel.c:771
>  io_uring_files_cancel include/linux/io_uring.h:52 [inline]
>  do_exit+0x344/0x2a00 kernel/exit.c:920
>  __do_sys_exit kernel/exit.c:1090 [inline]
>  __se_sys_exit kernel/exit.c:1088 [inline]
>  __x64_sys_exit+0x42/0x50 kernel/exit.c:1088
>  x64_sys_call+0x156c/0x1570 arch/x86/include/generated/asm/syscalls_64.h:61
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f00678f9a99
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f00678c3fd8 EFLAGS: 00000246 ORIG_RAX: 000000000000003c
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f00678f9a99
> RDX: 00007f00678f9086 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 00007f00670c3140 R08: 0000000000000000 R09: 0000001000000008
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f00670c3004
> R13: 00007f006796b0e5 R14: 0000000000000006 R15: 00007f00678c40e0
>  </TASK>

There's nothing wrong here. Your reproducer has a stuck request, which is an
IORING_OP_OPENAT on a fuse mount that never responds. Hence it's stuck and
can't get canceled. This btw is different than the original report,
which was the usual silly "let's generate giant reads against MSR" where
MSR reads are really slow, and yes that can then also take a while to
complete if they are already executing.

IOW, they are both bogus, and I think the only sane recourse here is to
change that WARN_ON_ONCE() to a pr_warn_once() with the necessary
details. The entry point to the io-wq exit can be gleaned from a bunch
of minor things like task etc, so won't really lose us anything. But
it'd prevent noise like this report in the future.



-- 
Jens Axboe
