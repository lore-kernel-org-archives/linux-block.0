Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA057890
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201032; cv=none; b=iChEhXsmMcG42lqeOPrFzYV6VN4n3E5ZFIJZE1o84xshCBnFGZ9OcO69V9KVTSkeNtoNEiCp5iKJ8SGhZDPdCQnHXq5iEPwjUW1GSZOuocDNtyd03kaD59n+zthZZO4QNoLjuiJf5FCLK/yIiIGfcndo785/bRR7TDJV/sd44Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201032; c=relaxed/simple;
	bh=oM+DvS4yIXK2bnj43VJHIHt4QiHv8jXU+O9EfUO3VXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl20REw+TvRhgRo8c4nKhOY+S9WRcPTiPHgIZHN0DwJHc/XIfW8+jwAQdYTJDpD88spwEfjxjVrrJ0NAuObUpnuHOVV4Ntb4xsBJKyqvWQQuWKA+r/GOl+zMWKsMQnO6zTLH+fN5DKXrArqwUn1EShuW0UPCu1zXBpvqAoGi/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=IB8Y+Zwf; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="IB8Y+Zwf"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-788412a4b2eso165814585a.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710201028; x=1710805828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqE0SrY3iEgbk3Bu9/ko/1vjn3GCfFJDrzSKZRFrTlY=;
        b=IB8Y+ZwfbIGXQdV3DfHz5H4Dh7vp5ux3y5KJhVioGUAYqZW3t2Z1mc97S/A1s0hGv6
         I5Mb2C6jz7KMnuHka1AuMEpoiD7Dq2zzZtIxNOQNTxZBS6QFg84DKi0Y8gQd87btZOPj
         BL55jQUQMapSL26EGNmKR2M7app/rOME8FSP6c0cYyof5cOYoLkRJmFrmKCLUuZyszox
         PFkNDccxPDNfF1MIpo0Wo7CggMa02YZYs4s4lVPGrAd7N4aOY4QCUvM2tv4Nt31vdjqw
         4j65qoycFuhpqHk/JdRSMju2PvREYf/vuAG9w5amSvBIcGLP3o811ggBjyGXJL7saN+z
         NpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201028; x=1710805828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqE0SrY3iEgbk3Bu9/ko/1vjn3GCfFJDrzSKZRFrTlY=;
        b=nQblIfKkRBGSyf1qpYksBTuiX+LevGRai5InaqO1hS8JfaBFp0X2SNuRYUs9a0a7Ro
         mxuBKflAlgdnvGtQ+DTijY+tmJ1UujEQwAEYvBW9vduFfezUdbS80Flw0Fi7Jtd84tEA
         iBNj+t8MAJ/BNaJxw17HB2HGCRtVMy8gRKpYVH1eQDCZYtDGleqLw9vUJG//n1eK4Asu
         v/0wZZ/wJcOmBROlncfYGMWseHmGoVh63iHh6oHUGLrv8jpkFhqCT849VeQ/T2Jjp41A
         nXxiFqZFFEIDA/suI272MXnRWQKQ84z+Y/dvmdIu9ne0ZKPZDwTbKeF07M3zPgvfbZ8C
         Lbdg==
X-Forwarded-Encrypted: i=1; AJvYcCV8OsM4NmP8XpVeFzx5MR+Mn7spOjG4pYrOl0f2gySwCBVoLYcnkoK0YGs/Ww4D0sGY6drVOk+afKO5J0TO0e1NKHd6n+ZlUS0Ti2Y=
X-Gm-Message-State: AOJu0YwQTyXBfMRfa+7rkHIQ8iwMBAV/aeyn5eIceOQm4kCENZZzfpgq
	aQf2FKb6BBaRopXxj4grNb7wtbRjfWYXvLw4f8kumOxtzEdPj9S7SN1oc5m4/8cCTVx9Jap4Wcz
	7
X-Google-Smtp-Source: AGHT+IEm8CpTcjrry/gRv6GsVXYEh4nPB1101WIw8C9KCNyaUQSwhc56fiS4Oa93vrWacYLaVNvU9Q==
X-Received: by 2002:a05:620a:45a2:b0:788:1e29:9721 with SMTP id bp34-20020a05620a45a200b007881e299721mr10458908qkb.16.1710201028483;
        Mon, 11 Mar 2024 16:50:28 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id qp10-20020a05620a388a00b0078870b3ad29sm1184356qkn.126.2024.03.11.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:50:28 -0700 (PDT)
Date: Mon, 11 Mar 2024 19:50:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <20240311235023.GA1205@cmpxchg.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>

On Sun, Mar 10, 2024 at 02:30:57PM -0600, Jens Axboe wrote:
> Hi Linus,
> 
> Here are the core block changes queued for the 6.9-rc1 kernel. This pull
> request contains:
> 
> - MD pull requests via Song:
> 	- Cleanup redundant checks, by Yu Kuai.
> 	- Remove deprecated headers, by Marc Zyngier and Song Liu.
> 	- Concurrency fixes, by Li Lingfeng.
> 	- Memory leak fix, by Li Nan.
> 	- Refactor raid1 read_balance, by Yu Kuai and Paul Luse.
> 	- Clean up and fix for md_ioctl, by Li Nan.
> 	- Other small fixes, by Gui-Dong Han and Heming Zhao.
> 	- MD atomic limits (Christoph)

My desktop fails to decrypt /home on boot with this:

[   12.152489] WARNING: CPU: 0 PID: 626 at block/blk-settings.c:192 blk_validate_limits+0x1da/0x1f0
[   12.152493] Modules linked in: amdgpu drm_ttm_helper ttm drm_exec drm_suballoc_helper amdxcp drm_buddy gpu_sched drm_display_helper btusb btintel
[   12.152498] CPU: 0 PID: 626 Comm: systemd-cryptse Not tainted 6.8.0-00855-gd08c407f715f #25 c6b9e287c2730f07982c9e0e4ed9225e8333a29f
[   12.152499] Hardware name: Gigabyte Technology Co., Ltd. B650 AORUS PRO AX/B650 AORUS PRO AX, BIOS F20 12/14/2023
[   12.152500] RIP: 0010:blk_validate_limits+0x1da/0x1f0
[   12.152502] Code: ff 0f 00 00 0f 87 2d ff ff ff 0f 0b eb 02 0f 0b ba ea ff ff ff e9 7a ff ff ff 0f 0b eb f2 0f 0b eb ee 0f 0b eb ea 0f 0b eb e6 <0f> 0b eb e2 0f 0b eb de 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
[   12.152503] RSP: 0018:ffff9c41065b3b68 EFLAGS: 00010203
[   12.152503] RAX: ffff9c41065b3bc0 RBX: ffff9c41065b3bc0 RCX: 00000000ffffffff
[   12.152504] RDX: 0000000000000fff RSI: 0000000000000200 RDI: 0000000000000100
[   12.152504] RBP: ffff8a11c0d28350 R08: 0000000000000100 R09: 0000000000000001
[   12.152505] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9c41065b3bc0
[   12.152505] R13: ffff8a11c0d285c8 R14: ffff9c41065b3bc0 R15: ffff8a122eedc138
[   12.152505] FS:  00007faa969214c0(0000) GS:ffff8a18dde00000(0000) knlGS:0000000000000000
[   12.152506] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.152506] CR2: 00007f11d8a2a910 CR3: 00000001059d0000 CR4: 0000000000350ef0
[   12.152507] Call Trace:
[   12.152508]  <TASK>
[   12.152508]  ? __warn+0x6f/0xd0
[   12.152511]  ? blk_validate_limits+0x1da/0x1f0
[   12.152512]  ? report_bug+0x147/0x190
[   12.152514]  ? handle_bug+0x36/0x70
[   12.152516]  ? exc_invalid_op+0x17/0x60
[   12.152516]  ? asm_exc_invalid_op+0x1a/0x20
[   12.152519]  ? blk_validate_limits+0x1da/0x1f0
[   12.152520]  queue_limits_set+0x27/0x130
[   12.152521]  dm_table_set_restrictions+0x1bb/0x440
[   12.152525]  dm_setup_md_queue+0x9a/0x1e0
[   12.152527]  table_load+0x251/0x400
[   12.152528]  ? dev_suspend+0x2d0/0x2d0
[   12.152529]  ctl_ioctl+0x305/0x5e0
[   12.152531]  dm_ctl_ioctl+0x9/0x10
[   12.152532]  __x64_sys_ioctl+0x89/0xb0
[   12.152534]  do_syscall_64+0x7f/0x160
[   12.152536]  ? syscall_exit_to_user_mode+0x6b/0x1a0
[   12.152537]  ? do_syscall_64+0x8b/0x160
[   12.152538]  ? do_syscall_64+0x8b/0x160
[   12.152538]  ? do_syscall_64+0x8b/0x160
[   12.152539]  ? do_syscall_64+0x8b/0x160
[   12.152540]  ? irq_exit_rcu+0x4a/0xb0
[   12.152541]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   12.152542] RIP: 0033:0x7faa9632319b
[   12.152543] Code: 00 48 89 44 24 18 31 c0 c7 04 24 10 00 00 00 48 8d 44 24 60 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[   12.152543] RSP: 002b:00007ffd8ac496d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   12.152544] RAX: ffffffffffffffda RBX: 0000564061a630c0 RCX: 00007faa9632319b
[   12.152544] RDX: 0000564061a630c0 RSI: 00000000c138fd09 RDI: 0000000000000004
[   12.152545] RBP: 00007ffd8ac498d0 R08: 0000000000000007 R09: 0000000000000006
[   12.152545] R10: 0000000000000007 R11: 0000000000000246 R12: 00005640619fcbd0
[   12.152545] R13: 0000000000000003 R14: 0000564061a63170 R15: 00007faa95ea4b2f
[   12.152546]  </TASK>
[   12.152546] ---[ end trace 0000000000000000 ]---
[   12.152547] device-mapper: ioctl: unable to set up device queue for new table.

Reverting 8e0ef4128694 ("dm: use queue_limits_set") makes it work.

Happy to provide more debugging info and/or test patches!
