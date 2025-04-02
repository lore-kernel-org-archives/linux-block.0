Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24511519A6
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577016; cv=none; b=qjvFP15ovxWdGsxW5S3gvf/iYsHnIADUpahyd7ZCafogvz5+d8o2uldfRS2phlS6Kxgmk/rsVSCy1g8ApzFmJaZn5WdcTLdZDDCmr7KHuMig8+XgyieGuAyRmPOzdbVzJyczbZyTr+yjotBYP82HEXjyZKia/VsT8hkRnidKfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577016; c=relaxed/simple;
	bh=fJ/BtvsK+6L1p7nRw/xMxEqOGWQ9YBxiQfrNkYjekH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5tnlavAXOyqoh6g/K4Z+OwAQutfbmdSktl8Mb3FE0NRaTidofxMgO+uxghqXYEbA0UMtJ/6GyubtWKqhgoIJtaM/u1E9SMTY1lCmHBgIltZSOc0g2p6no990zVSEbcDcP1/knG9HY6rYxgBrgP3P2b0+0uqxSY3seamqg0+7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FJWYxxkL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FJWYxxkL"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4784140060
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1743577006;
	bh=iJCjafL5T3uwEbRIx6/ivF1Ot4vyx5UZkygzmWgtBWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FJWYxxkL0OSiMCtKoyrYD133NYMybxO1vFIybEKtD07eizEoB08gLFVzAnfO86nJ1
	 Lpa1avTHC/Ac1G2D58J0D75sbkhbbJjcpn0GJVxi6RPh9TU/8iuqbBxpTsLxvVQkYi
	 +fOQPYDYyARMbXHOBrvfj6PLOBvTStaIt3fZxiX3rRDDYx82102qucKMwHx6D8IYEh
	 oIcXmW54Kt9JPvePYIqIp2w2RuSc7UonheB5dLD1U+iU8lLKjBG+OeQn9jG2qLf79N
	 0vNf6OKMxXJCBBlccLG71Yt89OW9eXQLJA66GwBhbfSDWfCgCjHDejEqFFF5UlHQmt
	 5AZqdtJlij4bw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac7791ecb7bso64468366b.0
        for <linux-block@vger.kernel.org>; Tue, 01 Apr 2025 23:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743577005; x=1744181805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJCjafL5T3uwEbRIx6/ivF1Ot4vyx5UZkygzmWgtBWQ=;
        b=hWEeJLOTqSrYuErzu3h4/ZhE8ZxYVLfvqsZwcpFa0/wNd4OfVt/kb8KZrbHlZDkO2e
         OjnuOzrrehEeoFVl0HSsO9rOaXS7GaM5zgWMaQZKMWNHXOFWKUCCrgE3cxMdqvqb6Gz4
         7eV0l6vOSWMUmOrQeD6aHau22cS7zKwOlcVQ8Z/+i0lgf4+mNl21laZ2pK+AnEpxPoxl
         OSiEbI2XNGidZvdr0VsRfEmof50H8z4etImuPKwa3aRUC/8ThsAihQZ3fb1DyCKDG/Eh
         CMQBVTn4SEv/jfMmWDG6FQBtYkL0QVcLkKtPdK1rcxjhEdZQqe6SfHLSMQMJQG+XTIX+
         teyg==
X-Gm-Message-State: AOJu0YykS+HcishtEr7oh+rcZNnwPCuHcWng7wXTkV+sSYg+iUVBKvmU
	JRODy3MCwMUPzPlz1UAz69qjlx2f06Ed0cCl4lyqTYoIYNLTpEgrDS0ZFDAKilRsRLkHa+l6SPH
	my/2UCfpIG9L4d3sBsYoZUvqAJEpNVl4Wz3/XpROJREWQ/fYtKRzOnQf/CYUECADZOEdmGqoWe6
	/kpMIKj6H1iopu/wfag/O68M25dIel6pNv8Ajlr+bUhfZoRsbqDaw=
X-Gm-Gg: ASbGncuzfleUuoD3EXePLWFDyV/zPsofu8UJ6Po6rCYu7l9U2ql55r9GS4bQuvUxgkg
	7OZmQKf6YmNH1Zgp7jFq30WmV1YrFF3TlqMzts5uQZNOFmMNIFt8VG6/HS9fqQHugZ8j05BNP7A
	EomNMK2YpszikUM38B
X-Received: by 2002:a17:906:6d8c:b0:ac3:4228:6e00 with SMTP id a640c23a62f3a-ac7a5a6ace0mr73302966b.6.1743577005026;
        Tue, 01 Apr 2025 23:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnByrU9JRG0DAMgNafNLSf28PK8EcYeDsl7ldlIC7zxv+U9ffEaSE9z1Rsy68HNpm8PyZ73Oq1b/ipZnOneUo=
X-Received: by 2002:a17:906:6d8c:b0:ac3:4228:6e00 with SMTP id
 a640c23a62f3a-ac7a5a6ace0mr73301366b.6.1743577004608; Tue, 01 Apr 2025
 23:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
 <180d8a88-52d9-4b83-83de-0184ed7cb4a5@huawei.com> <z6wlwwcbrmr3mcws6wmn5r6z45kosinvq6wyfq6hxfvcuxdjp5@ucjecgmhqp42>
 <59a1fa13-888e-4fe0-9de0-cd0e63c91265@huawei.com> <hshsylujj64nlrakfeboyriwhnfvmo2kodju6mrznrf56mttmv@3nuxifxmo6yc>
In-Reply-To: <hshsylujj64nlrakfeboyriwhnfvmo2kodju6mrznrf56mttmv@3nuxifxmo6yc>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Wed, 2 Apr 2025 14:56:33 +0800
X-Gm-Features: AQ5f1JoVlUCXaWINEjljNnyGsYN8nzQE5dUNmwv8EqKv2yuL5g-TVBsldQ-xJOs
Message-ID: <CAFv23Q=Wkko7VEVcztJSC+R8sfwzUDz4G4yLohhv_QfZozGARw@mail.gmail.com>
Subject: Re: Regression found in memory stress test with stress-ng
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, 
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, yangerkun@huawei.com, houtao1@huawei.com, 
	yukuai3@huawei.com, Dirk Su <dirk.su@canonical.com>, jani.nikula@linux.intel.com, 
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net, 
	airlied@gmail.com, simona@ffwll.ch, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chia-Lin Kao (AceLan) <acelan.kao@canonical.com> =E6=96=BC 2025=E5=B9=B43=
=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:47=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Thu, Mar 20, 2025 at 02:32:55PM +0800, Baokun Li wrote:
> > On 2025/3/20 13:23, Chia-Lin Kao (AceLan) wrote:
> > > On Thu, Mar 20, 2025 at 11:52:20AM +0800, Baokun Li wrote:
> > > > On 2025/3/20 10:49, AceLan Kao wrote:
> > > > > Hi all,
> > > > >
> > > > > We have found a regression while doing a memory stress test using
> > > > > stress-ng with the following command
> > > > >      sudo stress-ng --aggressive --verify --timeout 300 --mmapman=
y 0
> > > > >
> > > > > This issue occurs on recent kernel versions, and we have found th=
at
> > > > > the following commit leads to the issue
> > > > >      4e63aeb5d010 ("blk-wbt: don't throttle swap writes in direct=
 reclaim")
> > > > >
> > > > > Before reverting the commit directly, I wonder if we can identify=
 the
> > > > > issue and implement a solution quickly.
> > > > > Currently, I'm unable to provide logs, as the system becomes
> > > > > unresponsive during testing. If you have any idea to capture logs=
,
> > > > > please let me know, I'm willing to help.
> > > > Hi AceLan,
> > > >
> > > > I cannot reproduce this issue. The above command will trigger OOM.
> > > > Have you enabled panic_on_oom? (You can check by sysctl vm.panic_on=
_oom).
> > > > Or are there more kernel Oops reports in dmesg?
> > > Actually, there is no kernel panic during the testing.
> > > I tried using kernel magic key to trigger crash and this is what I
> > > got.
> > > It repeats the "Purging GPU memory" message over and over again.
> > >
> > > [ 3605.341706] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> >
> > The messages are coming from i915_gem_shrinker_oom(), so it looks like
> > it's still an OOM issue. I'm just not sure why the OOM is happening so
> > often, like every 0.05 seconds.
> >
> > I'm not familiar with gpu/drm/i915/gem, so I CCed the relevant maintain=
ers
> > to see if they have any thoughts.
> Hi Baokun,
>
> Right, how the i915 shrinks its memory may need some tweak to check if
> it can really shrink the memory.
> But this issue is more likely from the swap.
>
> We found the issue can't be reproduced after reverts that commit, and
> the issue can't be reproduced if we run swapoff to disable swap.
> I'm worrying that there might be a bug in the swap code that it can't
> handle the OOM situation well.
>
> Do you think should we try adding some debug messages to the block driver
> to see if we can find any clues?
A gentle ping.

Does anyone have ideas on how to debug this issue?

> >
> > > [ 3605.346295] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.350815] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.355463] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.360105] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.364743] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.369426] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.374044] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.378467] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.382958] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.387534] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.392130] [   T5739] Purging GPU memory, 0 pages freed, 0 pages =
still pinned, 2787 pages left available.
> > > [ 3605.394571] [     C11] sysrq: Trigger a crash
> > > [ 3605.394575] [     C11] Kernel panic - not syncing: sysrq triggered=
 crash
> > > [ 3605.394580] [     C11] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Kdum=
p: loaded Not tainted 6.11.0-1016-oem #16-Ubuntu
> > > [ 3605.394586] [     C11] Hardware name: HP HP ZBook Fury 16 G11 Mobi=
le Workstation PC/8CA7, BIOS W98 Ver. 01.01.12 11/25/2024
> > > [ 3605.394588] [     C11] Call Trace:
> > > [ 3605.394591] [     C11]  <IRQ>
> > > [ 3605.394596] [     C11]  dump_stack_lvl+0x27/0xa0
> > > [ 3605.394605] [     C11]  dump_stack+0x10/0x20
> > > [ 3605.394608] [     C11]  panic+0x352/0x3e0
> > > [ 3605.394613] [     C11]  sysrq_handle_crash+0x1a/0x20
> > > [ 3605.394618] [     C11]  __handle_sysrq+0xf0/0x290
> > > [ 3605.394623] [     C11]  sysrq_handle_keypress+0x2f4/0x550
> > > [ 3605.394627] [     C11]  sysrq_filter+0x45/0xa0
> > > [ 3605.394631] [     C11]  ? sched_balance_find_src_group+0x51/0x280
> > > [ 3605.394637] [     C11]  input_handle_events_filter+0x46/0xb0
> > > [ 3605.394643] [     C11]  input_pass_values+0x142/0x170
> > > [ 3605.394647] [     C11]  input_event_dispose+0x167/0x170
> > > [ 3605.394651] [     C11]  input_handle_event+0x41/0x80
> > > [ 3605.394656] [     C11]  input_event+0x51/0x80
> > > [ 3605.394659] [     C11]  atkbd_receive_byte+0x805/0x8f0
> > > [ 3605.394664] [     C11]  ps2_interrupt+0xb4/0x1b0
> > > [ 3605.394668] [     C11]  serio_interrupt+0x49/0xa0
> > > [ 3605.394673] [     C11]  i8042_interrupt+0x196/0x4c0
> > > [ 3605.394677] [     C11]  ? enqueue_hrtimer+0x4d/0xc0
> > > [ 3605.394682] [     C11]  ? ktime_get+0x3f/0xf0
> > > [ 3605.394686] [     C11]  ? lapic_next_deadline+0x2c/0x50
> > > [ 3605.394691] [     C11]  __handle_irq_event_percpu+0x4c/0x1b0
> > > [ 3605.394696] [     C11]  ? sched_clock_noinstr+0x9/0x10
> > > [ 3605.394700] [     C11]  handle_irq_event+0x39/0x80
> > > [ 3605.394706] [     C11]  handle_edge_irq+0x8c/0x250
> > > [ 3605.394710] [     C11]  __common_interrupt+0x4e/0x110
> > > [ 3605.394715] [     C11]  common_interrupt+0xb1/0xe0
> > > [ 3605.394718] [     C11]  </IRQ>
> > > [ 3605.394720] [     C11]  <TASK>
> > > [ 3605.394721] [     C11]  asm_common_interrupt+0x27/0x40
> > > [ 3605.394726] [     C11] RIP: 0010:poll_idle+0x4f/0xac
> > > [ 3605.394731] [     C11] Code: 00 00 65 4c 8b 3d a1 78 7b 63 f0 41 8=
0 4f 02 20 49 8b 07 a8 08 75 32 4c 89 ef 48 89 de e8 d9 fe ff ff 49 89 c5 b=
8 c9 00 00 00 <49> 8b 17 83 e2 08 75 17 f3 90 83 e8 01 75 f1 e8 bd d1 ff ff=
 4c 29
> > > [ 3605.394735] [     C11] RSP: 0000:ffff9c57001f7dc8 EFLAGS: 00000206
> > > [ 3605.394740] [     C11] RAX: 000000000000003c RBX: ffffbc56ff59b618=
 RCX: 0000000000000000
> > > [ 3605.394743] [     C11] RDX: 0000000000000000 RSI: 0000000000000000=
 RDI: 0000000000000000
> > > [ 3605.394744] [     C11] RBP: ffff9c57001f7df0 R08: 0000000000000000=
 R09: 0000000000000000
> > > [ 3605.394747] [     C11] R10: 0000000000000000 R11: 0000000000000000=
 R12: 0000034772423b38
> > > [ 3605.394749] [     C11] R13: 000000000000f424 R14: 0000000000000000=
 R15: ffff912c8122a900
> > > [ 3605.394754] [     C11]  ? poll_idle+0x63/0xac
> > > [ 3605.394757] [     C11]  cpuidle_enter_state+0x8e/0x720
> > > [ 3605.394762] [     C11]  ? sysvec_apic_timer_interrupt+0x57/0xc0
> > > [ 3605.394766] [     C11]  cpuidle_enter+0x2e/0x50
> > > [ 3605.394771] [     C11]  call_cpuidle+0x22/0x60
> > > [ 3605.394775] [     C11]  cpuidle_idle_call+0x119/0x190
> > > [ 3605.394778] [     C11]  do_idle+0x82/0xe0
> > > [ 3605.394781] [     C11]  cpu_startup_entry+0x29/0x30
> > > [ 3605.394784] [     C11]  start_secondary+0x127/0x160
> > > [ 3605.394788] [     C11]  common_startup_64+0x13e/0x141
> > > [ 3605.394794] [     C11]  </TASK>
> > >
> > > >
> > > > Regards,
> > > > Baokun
> > > > > Best regards,
> > > > > AceLan Kao.
> > > > >
> >
