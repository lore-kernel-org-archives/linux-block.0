Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A318B46E
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543239; cv=none; b=X2YeCXIJzWkB2CWzx/hfETFEfjVCfSw7HwafYtY8mWBvXfYJOirD2jxqJ3ve98zMZUGHYI/xiTo3X9KvJ6b++Y3Z5E0Sbe1Vokfk4Hkd6hw5xG21lmJRns2wzbrb7MgW/RIZF+7P571hGxdkdBl6DqJlWamU08lMgjZUXW0+K9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543239; c=relaxed/simple;
	bh=PiocJepozT5Wzc85joZQLeMoZqfMtu0i5zK2buyQnyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlveDpwq3UA0a9aNqYPJH4dNek9PobqJ1kuo1F0AS46GCbbO0QGi9rZdDSz+zwKc2UtJtoi56Wu9aiX+FjZfWX/REv0MS2DEJ5uqbkC/18xrrD+VXab+w5NCPQcuFC9wVkAkJS4lNEvPTTsxSUDVwHM6HtBlv9f4IvhMVy/85hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Tn4XBo5V; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Tn4XBo5V"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E7D183F682
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742543233;
	bh=WjL8iAZiIWqERvoFylQUGeXXKtNQg3t8LQFWbJd2T2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Tn4XBo5V0GLHsONSr7CmcC8FzQL0gYeQnUQ0n6dDWX4KUAEFcQ3ykKfrDapACKfmw
	 bJT4bm+7T/hRC17vFtEIde1u/IVAe2wn6m92tUwih069TbnnZd2BW8WSMs5rNDytyV
	 aKIQMLrfMTgl/NqXqwgvokzOI+utg4XlPPUhKkXGqZ8cm4dRkW2Xrzs58OTJSsynr5
	 oXHhvtdm9/qQXjEbLk1uuoajhdbZLA4xHWSH2tfE/WRR5V+fBYiwzfOWKw3tsq4X4W
	 31jE7ZWcTQIL5IAqc3yhaK3tvvW6sisaJT1JJhXaJGUIhbnVYH/dOwo5n7OEBNUdZi
	 wmlL81BGHV32w==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225505d1ca5so25570085ad.2
        for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 00:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742543232; x=1743148032;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjL8iAZiIWqERvoFylQUGeXXKtNQg3t8LQFWbJd2T2E=;
        b=osl8bmG3Lp+Btb+KozbF8U6dvSipNCOtj+Wp4MnnipcE79lXhyr9urGp1pldTfQpqM
         4s2I7dN8uDEc5NKx2BjUaJTs1Va1dlcDlgGRqB8vp4We+Ifp+939qoX0ikYa0FFuvQj5
         JM47YuKzvmk6QSYdhgOgF//f4XpcJ0r7tnIMpxOI59kRItcTCrfHWlM52YUZ2GKRvRpZ
         uxY7nrQ0316ffiLE4x8XqC8m+XtmbkKx22RRUFxIW+U+mFBQYBMDavThdJBoUATUajqy
         wNqFvktxrQ5clfvcGyHWtut2skzNcFjNdda7dVcniV94RbcH0Uzn+/MI3EiwtObk0+WF
         ACaQ==
X-Gm-Message-State: AOJu0Yxu+8Xfz0rQWiEQ5mcPSJws6FTzWua2pzA2RrzKInEGi1xYHBqF
	DEwxWQuNH8IsfVXn/vA4mDWIs0U/QF7NCzgrIGOz/8EErPToviieufqt9EOTHKxMtx3qnzMztC4
	A36TeVd1SGKJhOQrIMPiommFSZpNMP0CrGehZPYShjElKrT77Aeq92XDwKyIujlpUu/m7IDfP6p
	oL
X-Gm-Gg: ASbGnctvurxzHuXGwvJGkXABLRFhLIdcMaAO1wB+Ii4bysvEKby+LXZKbbUNVF7UY5k
	S9vPPuwhCwc8D2eztGG7+QYyuGw5zbqtfyhtTk0aCtk/FZz+UqUte11CSfxil19AAhGx2T1xXkS
	2Fj9x6Lb1oh0WQ5ftHNrARRcMSmzUw/Ii6WKkNaWDMd5QQzKo4+fd1seb55WuNDqZfWOF8TbAP6
	hcRzNtuITaRhPoe5Vo74jKCIFc4U8yEXXFYWHyCbCqNLE+Xe+LK3B70nNGeUj3kT43+0c/1Di0X
	gXFh8eMAxDoBxlIbP9hE1So=
X-Received: by 2002:a17:902:cec4:b0:219:e4b0:4286 with SMTP id d9443c01a7336-22780db462fmr36097265ad.29.1742543232230;
        Fri, 21 Mar 2025 00:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5Mvh4aBkhywQOx/Vf8f0nV5E26CI+uDLTwyCMKGbXc5xeJt01y/v7ypELXBLur6PmwWo0FA==
X-Received: by 2002:a17:902:cec4:b0:219:e4b0:4286 with SMTP id d9443c01a7336-22780db462fmr36096905ad.29.1742543231808;
        Fri, 21 Mar 2025 00:47:11 -0700 (PDT)
Received: from acelan-precision5470 ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3964bsm10198955ad.32.2025.03.21.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:47:11 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:46:54 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, 
	yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com, 
	Dirk Su <dirk.su@canonical.com>, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
	intel-gfx@lists.freedesktop.org
Subject: Re: Regression found in memory stress test with stress-ng
Message-ID: <hshsylujj64nlrakfeboyriwhnfvmo2kodju6mrznrf56mttmv@3nuxifxmo6yc>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Baokun Li <libaokun1@huawei.com>, linux-block@vger.kernel.org, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, 
	yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com, 
	Dirk Su <dirk.su@canonical.com>, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
	intel-gfx@lists.freedesktop.org
References: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
 <180d8a88-52d9-4b83-83de-0184ed7cb4a5@huawei.com>
 <z6wlwwcbrmr3mcws6wmn5r6z45kosinvq6wyfq6hxfvcuxdjp5@ucjecgmhqp42>
 <59a1fa13-888e-4fe0-9de0-cd0e63c91265@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a1fa13-888e-4fe0-9de0-cd0e63c91265@huawei.com>

On Thu, Mar 20, 2025 at 02:32:55PM +0800, Baokun Li wrote:
> On 2025/3/20 13:23, Chia-Lin Kao (AceLan) wrote:
> > On Thu, Mar 20, 2025 at 11:52:20AM +0800, Baokun Li wrote:
> > > On 2025/3/20 10:49, AceLan Kao wrote:
> > > > Hi all,
> > > > 
> > > > We have found a regression while doing a memory stress test using
> > > > stress-ng with the following command
> > > >      sudo stress-ng --aggressive --verify --timeout 300 --mmapmany 0
> > > > 
> > > > This issue occurs on recent kernel versions, and we have found that
> > > > the following commit leads to the issue
> > > >      4e63aeb5d010 ("blk-wbt: don't throttle swap writes in direct reclaim")
> > > > 
> > > > Before reverting the commit directly, I wonder if we can identify the
> > > > issue and implement a solution quickly.
> > > > Currently, I'm unable to provide logs, as the system becomes
> > > > unresponsive during testing. If you have any idea to capture logs,
> > > > please let me know, I'm willing to help.
> > > Hi AceLan,
> > > 
> > > I cannot reproduce this issue. The above command will trigger OOM.
> > > Have you enabled panic_on_oom? (You can check by sysctl vm.panic_on_oom).
> > > Or are there more kernel Oops reports in dmesg?
> > Actually, there is no kernel panic during the testing.
> > I tried using kernel magic key to trigger crash and this is what I
> > got.
> > It repeats the "Purging GPU memory" message over and over again.
> > 
> > [ 3605.341706] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> 
> The messages are coming from i915_gem_shrinker_oom(), so it looks like
> it's still an OOM issue. I'm just not sure why the OOM is happening so
> often, like every 0.05 seconds.
> 
> I'm not familiar with gpu/drm/i915/gem, so I CCed the relevant maintainers
> to see if they have any thoughts.
Hi Baokun,

Right, how the i915 shrinks its memory may need some tweak to check if
it can really shrink the memory.
But this issue is more likely from the swap.

We found the issue can't be reproduced after reverts that commit, and
the issue can't be reproduced if we run swapoff to disable swap.
I'm worrying that there might be a bug in the swap code that it can't
handle the OOM situation well.

Do you think should we try adding some debug messages to the block driver
to see if we can find any clues?
> 
> > [ 3605.346295] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.350815] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.355463] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.360105] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.364743] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.369426] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.374044] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.378467] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.382958] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.387534] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.392130] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
> > [ 3605.394571] [     C11] sysrq: Trigger a crash
> > [ 3605.394575] [     C11] Kernel panic - not syncing: sysrq triggered crash
> > [ 3605.394580] [     C11] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Kdump: loaded Not tainted 6.11.0-1016-oem #16-Ubuntu
> > [ 3605.394586] [     C11] Hardware name: HP HP ZBook Fury 16 G11 Mobile Workstation PC/8CA7, BIOS W98 Ver. 01.01.12 11/25/2024
> > [ 3605.394588] [     C11] Call Trace:
> > [ 3605.394591] [     C11]  <IRQ>
> > [ 3605.394596] [     C11]  dump_stack_lvl+0x27/0xa0
> > [ 3605.394605] [     C11]  dump_stack+0x10/0x20
> > [ 3605.394608] [     C11]  panic+0x352/0x3e0
> > [ 3605.394613] [     C11]  sysrq_handle_crash+0x1a/0x20
> > [ 3605.394618] [     C11]  __handle_sysrq+0xf0/0x290
> > [ 3605.394623] [     C11]  sysrq_handle_keypress+0x2f4/0x550
> > [ 3605.394627] [     C11]  sysrq_filter+0x45/0xa0
> > [ 3605.394631] [     C11]  ? sched_balance_find_src_group+0x51/0x280
> > [ 3605.394637] [     C11]  input_handle_events_filter+0x46/0xb0
> > [ 3605.394643] [     C11]  input_pass_values+0x142/0x170
> > [ 3605.394647] [     C11]  input_event_dispose+0x167/0x170
> > [ 3605.394651] [     C11]  input_handle_event+0x41/0x80
> > [ 3605.394656] [     C11]  input_event+0x51/0x80
> > [ 3605.394659] [     C11]  atkbd_receive_byte+0x805/0x8f0
> > [ 3605.394664] [     C11]  ps2_interrupt+0xb4/0x1b0
> > [ 3605.394668] [     C11]  serio_interrupt+0x49/0xa0
> > [ 3605.394673] [     C11]  i8042_interrupt+0x196/0x4c0
> > [ 3605.394677] [     C11]  ? enqueue_hrtimer+0x4d/0xc0
> > [ 3605.394682] [     C11]  ? ktime_get+0x3f/0xf0
> > [ 3605.394686] [     C11]  ? lapic_next_deadline+0x2c/0x50
> > [ 3605.394691] [     C11]  __handle_irq_event_percpu+0x4c/0x1b0
> > [ 3605.394696] [     C11]  ? sched_clock_noinstr+0x9/0x10
> > [ 3605.394700] [     C11]  handle_irq_event+0x39/0x80
> > [ 3605.394706] [     C11]  handle_edge_irq+0x8c/0x250
> > [ 3605.394710] [     C11]  __common_interrupt+0x4e/0x110
> > [ 3605.394715] [     C11]  common_interrupt+0xb1/0xe0
> > [ 3605.394718] [     C11]  </IRQ>
> > [ 3605.394720] [     C11]  <TASK>
> > [ 3605.394721] [     C11]  asm_common_interrupt+0x27/0x40
> > [ 3605.394726] [     C11] RIP: 0010:poll_idle+0x4f/0xac
> > [ 3605.394731] [     C11] Code: 00 00 65 4c 8b 3d a1 78 7b 63 f0 41 80 4f 02 20 49 8b 07 a8 08 75 32 4c 89 ef 48 89 de e8 d9 fe ff ff 49 89 c5 b8 c9 00 00 00 <49> 8b 17 83 e2 08 75 17 f3 90 83 e8 01 75 f1 e8 bd d1 ff ff 4c 29
> > [ 3605.394735] [     C11] RSP: 0000:ffff9c57001f7dc8 EFLAGS: 00000206
> > [ 3605.394740] [     C11] RAX: 000000000000003c RBX: ffffbc56ff59b618 RCX: 0000000000000000
> > [ 3605.394743] [     C11] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > [ 3605.394744] [     C11] RBP: ffff9c57001f7df0 R08: 0000000000000000 R09: 0000000000000000
> > [ 3605.394747] [     C11] R10: 0000000000000000 R11: 0000000000000000 R12: 0000034772423b38
> > [ 3605.394749] [     C11] R13: 000000000000f424 R14: 0000000000000000 R15: ffff912c8122a900
> > [ 3605.394754] [     C11]  ? poll_idle+0x63/0xac
> > [ 3605.394757] [     C11]  cpuidle_enter_state+0x8e/0x720
> > [ 3605.394762] [     C11]  ? sysvec_apic_timer_interrupt+0x57/0xc0
> > [ 3605.394766] [     C11]  cpuidle_enter+0x2e/0x50
> > [ 3605.394771] [     C11]  call_cpuidle+0x22/0x60
> > [ 3605.394775] [     C11]  cpuidle_idle_call+0x119/0x190
> > [ 3605.394778] [     C11]  do_idle+0x82/0xe0
> > [ 3605.394781] [     C11]  cpu_startup_entry+0x29/0x30
> > [ 3605.394784] [     C11]  start_secondary+0x127/0x160
> > [ 3605.394788] [     C11]  common_startup_64+0x13e/0x141
> > [ 3605.394794] [     C11]  </TASK>
> > 
> > > 
> > > Regards,
> > > Baokun
> > > > Best regards,
> > > > AceLan Kao.
> > > > 
> 
