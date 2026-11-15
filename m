Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755453;
	b=JLOGiseNW6a3CFIvunebxL7frHCy2U9Q65E6kVDJXtUMgDb3aGK8UGI1geVOpskDvyZ/
	 rTfMDBXXLGlHQKnT3Gh27dQWdv4yF4qCRTjmO2jUZyvkAHL5Me8lxCud28uOigrpjfLBK
	 ReLFqVWma5Sa5rTStfHK6Nb9OUKmRVbX6NOYzDHljGH3xVKzh/7/uKH8HNvvysNuIU5dw
	 Ze8BD1asN4J7sXu1qOgIGAKFQQnJmgdB7ptjNOdIDk8Zx4pdi3THUtKjT+ZKK1WkLsC2J
	 Uilf5NQA2wRbk7bAScMIqRdJX+4fQRF1rgw9F90GGTLhWmzsIZriX0lmW2ybimB/5QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+daLeqx/lxVUIzrCUHcjunWtWzpqthykT9sEDQIc3m4=;
	b=ZeQNyR+kvojWYTSldem7NTk9lI1vj+2o3HTDwnH09x9HqBE7RtyZwva5PAdfM0qDrR8l
	 VzbcVhpQb6BpMG1UD0mu4u0quVkryq+ZQBQ1uVEw7Ae1ycMvwgrL60m7SKDhSrOYiG78S
	 YC3qUSMW4ccvuHyuACYrJqLxgXYtGTdiyzBnSMfrawJ2VWpYLy5YNCnZrRayTJX48SIyE
	 qrqTGzxGP1esotN1bD2y3NzanCm+j4EBTVAMCq4o+tEQSFDjcVAvB8xzKSV5fEZL9YyCf
	 5nSpimlmcMreRrBO87EFHZ4Fu1o+sREjpt1AvkPEuGVp1vU1vuDmiHIlf/17zo6pWUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ruH808aN;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265C606A31A
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 15:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A265C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ruH808aN
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso3225293c88.0
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 07:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794755452; x=1795360252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+daLeqx/lxVUIzrCUHcjunWtWzpqthykT9sEDQIc3m4=;
        b=ruH808aN9cP1sUIbECxmrxkFrFybCv9DxGIo81u4xiIW7K2Ty1uMEjPEa8HO4Y0n9m
         H4b7+q8O4bgBRPas4m5BOVRwEVx+9wQj/NuGAznsYgIA+bHlmmiE7iT1TeWU8H3TB1TL
         Y8r+MQKk/Wf+PKUT+LvoTnCjrblTLSJoBSUXXuTJSEhXIKdotABYjiQjRiRuTP/X2oLE
         B3/bFZ6fvfYx1bYwS3OQ0acMJPVxv6bRbP3O2yN9W9ofN+iT/2Hcn6bzSSXermOmLKrY
         +c/q0RldU0SqJ9PxXTp3z8WZ4aMvDmTADMkZWx0U3w3Zheeox1qbV5rZj6h/FryOUN4X
         P8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794755452; x=1795360252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+daLeqx/lxVUIzrCUHcjunWtWzpqthykT9sEDQIc3m4=;
        b=mst388osXPIXYplhvm4xPB+7Zm50/zC+1cXvzYUE0u5sx6ZIbLJO/Ms93Vqy2dd7th
         lvpYGAkEQKf9j3wsjs2loiyuCyP7sBHwbLzxiZBQFHJWR0enV4W3t5pC9K7Woh8KfV2q
         fwviBTo387WJJh0pfLpnMkGR4gbKkswQOjh2k469pc4mPov0yMZx0Wj/j+OKix/KlwGb
         RL0O2dHfc/uqNIyD5fhHBOXnvrQcSxMJetz9fMDcsReGopQCZL7sOzlGdLAEMhoSwvYk
         TFtuJtHuu0ZMvyNMi0627nOgeOacDtXHjbkqRM7PllRABTXkwz1lIIWZEEZmt8SIUhZ2
         I/Tw==
X-Forwarded-Encrypted: i=1; AL+hErGi9VMar5ckVLGBRYA1rt9XOMxIkiZvTnuXvakbk+zz4qiAZq2dNAH1omg2PKwrz0ySRYUHpFkQwWL2Eg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9t4VWMRlNNxa99zOpnuz37OxNhpB4jDZ0iKpWl0k9Zd8A6w0jP
	6AhV6L5v/5R6JKITFWmgk/ZfI0ukLfoSN1dSZ15bSaZyfq6MQCiFbDKxt9kXliCcomI=
X-Gm-Gg: AYBFou04Vi2zEmeYnPWCaWjqvUCExFPgUF4LZneqt4Ig5nTejcsWTQ/Y/Zl5lTlaXbn
	O7//NTzB+aGS0+u6XKnWeWERP8/HUD764QSdW5u9dSZIXWGzyVxUgZQFJWGwfFE0i3FO4C7J+/h
	lw5niI3QS7GnYge8+Z0hoFYRMXTFqKhcCz41OoOoHzSwDY9eleiNAPQs/c5ctrdCRruKTnWKZXY
	k2qGbTJbeXuoYBbMENIgK8XfCxkcJmdqPahli73yNK6b2VgFUvdKkaA6pHnE4cOjsNFuo9SitYz
	p35KfD81UIBCXzDEteQyvw1Hx7UGdecKx5pVnG4A/wjoSeaaLYiFetBdLKnMVLd1ct1lUmK5ckA
	5qjhMFRfL8kYnlTzLed8UyloAZ20QDFWlstXKZJPJui0K7QEaAFgoUPfj7VXsFHbPUIqLTdxPtH
	/PXfB7Jw7Ao5onIDq5X0ty8y/lm2dtZWK/LMGFYzVnNg0Ec5oce5GfHfd+EwsEDEXjhS+FYc1lP
	dhPA30d4Jfr0QeSlStgNxSKV73+G/CfsaQcJc9eJdwOPNtCXNbyzcH5WKaEAGR4wtpoWMLOxIon
	SP+hM7VRdVHJPOMTBMgpK/d8+0VHsTmUYOdqqyH/1WP9vUuWbcgmgsf68Bo2eGElpr0ATU39Km7
	La3erymtB4LAl
X-Received: by 2002:a05:701b:4182:10b0:1b2:5128:df1b with SMTP id a92af1059eb24-1b5031b7dd3mr7952805c88.45.1794755451719;
        Sun, 15 Nov 2026 07:10:51 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50300e5dcsm20992451c88.0.2026.11.15.07.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 07:10:51 -0800 (PST)
Message-ID: <d5e8a108-c563-4c1d-8339-f50d2b7aa1db@kernel.dk>
Date: Sun, 15 Nov 2026 08:10:50 -0700
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

#syz invalid

-- 
Jens Axboe
