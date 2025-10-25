Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066E1F4CBE
	for <linux-block@vger.kernel.org>; Sat, 25 Oct 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761399321; cv=none; b=NAVX/78zGcbDaPPMUyZDkafQ+PRdQWzBCmyvXAugsuCZ/lVnzTNphbladdOzeb7uIkb/EbXsIzgv6baO/IWGQvSJPyr9Alk9DxZZkgja0hzzqNuhkhA5coA/F/4bhM0KrZjQvDQ/oSBH+1AnWg0mFBXXYDX7d2Puex02NnA9i70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761399321; c=relaxed/simple;
	bh=KaJEkYTqekpnhFSpp/NU696b33Tgs1yMxnVlUqYJ2Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CqeKEOAP+c+eYodNiMVkjWnLY2sa7QP9UeMrVD/Pma7meV0zn7/jONmLp6x5XpLV+zUsI7vC/GprCMDR13n95GBlh00BrsssxAu2jpojdH+c4bF1chZsTKJAbVvI8D9Hx5hNyDhdoEH/sd/qTpVCQCz8waczJAXeiCYxA9g7EUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d7O80AHG; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d7O80AHG"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430da72d67bso20761765ab.1
        for <linux-block@vger.kernel.org>; Sat, 25 Oct 2025 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761399319; x=1762004119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkM7ja9TV9L14WZ6g5Dh9CjBG8l999BM6l9iQGovaUs=;
        b=d7O80AHG6IdcYxicc7LHUAVG2H0o0ZVN52lFlGcMG65MFejtvUzwWNsgRZfYwP4Rxf
         cVa1LK4gQ294ztBZyYvEPAUm+h/6gjcbxgy2/x244POdsOWW4g+FrAh5HHnhbvGuJuJn
         z7s3dYIQkwzVTHKEUGLotGWDvATHebdO4bR3ggVfLIhidPT5JaBUSBVFinriRFIefeG8
         UbGX/Aam2b4OD/kPbxXMTaq+3XIbNmxW3KqSVBpwbwCYjJ58X/Fy/a8Iip68Bnv2WhUq
         OgdAmotkIpFz3EfR/I2OdspTRmItTSKlE+isbmg8+2pYi1ZoiDqAUOVCeJR7RqV9sr8k
         lBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761399319; x=1762004119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkM7ja9TV9L14WZ6g5Dh9CjBG8l999BM6l9iQGovaUs=;
        b=ZhmNa9ezwW6uM9TH/x7XfbdsjVRZs5yVf9EGMsRe38pPBUahwA6iELO5bTI3XNpCbU
         UxTfH/9yk2fqAKWTDURWOOtiapWULEO4g59zNVk8wlSnsCWtdBZMnKIxexMSniCbUhUu
         uq2FPfb8A4rwwno8/VQUc+X37WMmAqTmQCdcHM6F+WCuQTP6XLn2ItkcK30bHF2a865k
         sOkz5vqH5rdN5gJe86YdwYoOZClR5seea3AJixV+9QywDT78HQOaMMPGSiNjC/TwlW4A
         hUgCWSAtAx7brq1n+pxmwaPaSE8RkOCGOsLxnurqvPD4Ki+O8k3qA8we3FwMxCIoKD5J
         bQEg==
X-Forwarded-Encrypted: i=1; AJvYcCUU2GSkX7hrETtxx4LMRTLKHo5PntyIcRgOHmTYMGTvAHefwTkL+VGJiaPyoB9pNLGXNsCn4z7XdcL5eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGYv10NSonuIn4VLdJN6i2JnQMp1i4mNlH+H8i5TFSej/jA9S
	88gM8QbQiHx/xGhuSmWZ6zKWV3aazfUNTyMzwtv8RIpGw1xg/DQnGNb/WinLuhVBSlc=
X-Gm-Gg: ASbGncurbExtPBUHK6ABl2em92qTCzw3Kjpyt7xQCw9g3+GeoU51ymsfA1UW1YtBaNJ
	H4tY1M39g1f+w3bNdFcXLw3nDHngX7odQzLdrld3IdQ9SmJTZy2tXKWNG+1Z0z3XeK5tH6ntJX+
	GuvKus7mByZhfDDCaq1aXHhu9aoN31vSAUKw1Ao1dP/bztQgflhNYBYj68+5H5eOQCVa5ecRGDn
	ijz/Vw4OC3xVrTEek/nABNVJTZjN+0y0Q34oiz40OXhrgFpmyMorcSgRTaC24dLIFKVJxy4mav7
	i7lm1AzHZ8JnYspMPgf8nD0FR6debnmtxlqCSCT9+w4dLIddToYnhsreA9WJM0dScI7MlWfjJZq
	HzUM4k98B8Y/kYFKaMv6mQ2XptZV2PAZtqbXexUIviN6d24lzEo+/3xsKQGXv2vT6XVGxjdOd4w
	==
X-Google-Smtp-Source: AGHT+IEVhWeoFu1fPZNQzOrZE1KrMqDiO+Hp3STAmtvrA30DN6IV0FZYLa01ecdjrXlbpXnVo9cpIA==
X-Received: by 2002:a05:6e02:4801:b0:430:b4e1:bcb8 with SMTP id e9e14a558f8ab-431eb65dab1mr68502415ab.13.1761399319072;
        Sat, 25 Oct 2025 06:35:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688c96asm8069525ab.30.2025.10.25.06.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 06:35:18 -0700 (PDT)
Message-ID: <c4ea8d7c-e449-47d6-b4a1-54fdbe86ba01@kernel.dk>
Date: Sat, 25 Oct 2025 07:35:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
To: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 5:11 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    72fb0170ef1f Add linux-next specific files for 20251024
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1640f734580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f02d98016cc9c137
> dashboard link: https://syzkaller.appspot.com/bug?extid=153e64c0aa875d7e4c37
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105853e2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12722614580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f63074a739fa/disk-72fb0170.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b15d7b8b9621/vmlinux-72fb0170.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/449963b71f60/bzImage-72fb0170.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: kernel/trace/blktrace.c:368 at __blk_add_trace+0x79c/0x8d0 kernel/trace/blktrace.c:367, CPU#0: jbd2/sda1-8/5163
> Modules linked in:
> CPU: 0 UID: 0 PID: 5163 Comm: jbd2/sda1-8 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:__blk_add_trace+0x79c/0x8d0 kernel/trace/blktrace.c:367
> Code: ff 4d 85 e4 75 4f e8 83 0e f8 ff e9 fb fd ff ff e8 79 0e f8 ff e9 ec fd ff ff e8 6f 0e f8 ff e9 d8 fd ff ff e8 65 0e f8 ff 90 <0f> 0b 90 e9 ca fd ff ff e8 57 0e f8 ff 48 8b 7c 24 30 e8 cd 51 00
> RSP: 0018:ffffc9000e54f460 EFLAGS: 00010293
> RAX: ffffffff81c81b4b RBX: 0000000000000001 RCX: ffff8880341abc80
> RDX: 0000000000000000 RSI: 00000000901e000f RDI: 000000008000ffff
> RBP: ffffc9000e54f578 R08: ffff8880341abc80 R09: 0000000000000009
> R10: 0000000000000011 R11: 0000000000000000 R12: 000000008000ffff
> R13: ffff888075c86080 R14: 00000000901e000f R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff888125f22000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555577629808 CR3: 000000000dd38000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  blk_add_trace_bio_remap+0x4b8/0x560 kernel/trace/blktrace.c:1200
>  __do_trace_block_bio_remap include/trace/events/block.h:526 [inline]
>  trace_block_bio_remap include/trace/events/block.h:526 [inline]
>  blk_partition_remap block/blk-core.c:585 [inline]
>  submit_bio_noacct+0x187b/0x1b80 block/blk-core.c:804
>  journal_submit_commit_record+0x665/0x8b0 fs/jbd2/commit.c:156
>  jbd2_journal_commit_transaction+0x3455/0x5a00 fs/jbd2/commit.c:875
>  kjournald2+0x3cf/0x750 fs/jbd2/journal.c:201
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

Adding Johannes.

-- 
Jens Axboe

