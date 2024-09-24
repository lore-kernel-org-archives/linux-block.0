Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E511CA0
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202600; cv=none; b=S7ZyKD7oKf22CzAqkvTNOLa0JogHM+rIzMNhVItCJcuLiv6N+DvRZU98lVZGku4HlRh3PtoqeWDKEoNjhu0usmcU/9S0g9qjlOaxjTNxPKjxAI/9wzGjYdUAvJc3HLmJRR8mBH6wyUn6+7GhPF4dY6S5A7VUKiwRNr5gOMLhE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202600; c=relaxed/simple;
	bh=mIU+jZYCA07ETgW9mqEytVGzjGljhr50za7oCvQvBAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAkHw9HKhsK/7+RlLxj+sT3DrRN4qHN+yn2qV48O9yazKfMcnMtEc9ZROebOGoBwigtJgHwn2ibRWu0ZwaEImGNOFOP5SOmqHW7AlKszmUUmxrIvfxVd0slgSCh7dtxxb4t3vPBou34ZQXPfZooMHcs0p0KSHK2zEU1o85RQchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7+nOvVn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7+nOvVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D30C4CEC4
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727202599;
	bh=mIU+jZYCA07ETgW9mqEytVGzjGljhr50za7oCvQvBAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r7+nOvVn8rhykGva1wQGFuSDqrP7XTU/mAMwEEe4A9LQ26dhvoh8tZlNxigv5Q+cK
	 Y+B3TtMwgk3JUb54cGnuYWuaFDjwXvDRTWCbJJVkVe9PbYBb0yTr1XvL88I7GKdYWT
	 58EAxRMRzQfwfaSnNotNH5CfCw+SXojTgIyqo3lziE01ZRfC5T1A4ycnQtb3oTnp6B
	 GZDaCcaoh1mjCuS4O+FOkA4p7xBpt1Ge0nX1rtESYviDxR8QJ2E8Vnb47TrHrcXm3A
	 aEL3ZNB/ebhX0aQR8QQ1D/vW0Ju2HEgJVe5zkoohA5Z36taU1W1tr5kdPxWI1Lj7cE
	 cPq3N7lRK160w==
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so20055ab.1
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 11:29:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhNFUVJsfay2I+3POnfBpS1daLrI8MA1C04Ohd5g8dSpNy57UwokP6OjDQYMwsdqMFLnaLF9Y2srCHzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0ZgjlkFuxarfqiV1BAh9jeuVyVXVfaIMgRUJJ/WOElRZdw4o
	++KCbV1tw7XC5pNkyuj9mqdLit2hDJkQoKUTwWSVc5eC3v5SyatfpY6pEV95xf68a3odANm3fW6
	TIBP84WbkFQNGkh/k8E6XprbEj3SsBlun0+E8
X-Google-Smtp-Source: AGHT+IF8B2cjYkfVphYhTRNnDxUjC4Iky/2GXwjtHIRcJzxknIkH9HWVVGlr9HeS4fK9Q+aDK5I6qbtEqQtrEXD0KFQ=
X-Received: by 2002:a05:6e02:b21:b0:3a0:9f85:d768 with SMTP id
 e9e14a558f8ab-3a26e4ea74amr265085ab.11.1727202598726; Tue, 24 Sep 2024
 11:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com> <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
 <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
In-Reply-To: <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 24 Sep 2024 11:29:47 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com>
Message-ID: <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com>
Subject: Re: [PATCH v3] zram: don't free statically defined names
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:56=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Hi,
>
> I also hit this problem in my swap stress test. Sergey pointed me to
> this thread.
>
> Just want to add that the fixes works for my setup as well:
>
> Tested-by: Chris Li <chrisl@kernel.org>

I am very sorry that I sent the email out too soon. I should have
waited for the swap stress test to complete first.
It turns out that, with this fix, the initial warning and BUG()
disappeared. However, my swap stress test failed with OOM kill about
20 seconds into the test. Given the first 15 seconds or so is
extracting the kernel source, it seems that as soon as the 32 compile
jobs started I got the oom kill. I need to withdraw that Tested-by
tag.

I have run the test twice with this fix, the oom kill is reproducible
in each run. I also double checked the mm-stable commit before this
(effectively revert this commit rather than fixing it). The swap
stress test passed without any issue.
Given the merge window is closing. I suggest just reverting this
change. As it is the fix also causing regression in the swap stress
test for me. It is possible that is my test setup issue, but reverting
sounds the safe bet.

Here is the kernel dmesg of the oom:

[   64.191987] zswap: loaded using pool lzo/zsmalloc
[   64.280184] zram0: detected capacity change from 16777216 to 0
[   64.286990] zram: Removed device: zram0 <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D no
warning here any more
[   64.343738] zram: Added device: zram0
[   64.372215] zram: Added device: zram1
[   64.469525] zram0: detected capacity change from 0 to 6553600
[   64.532199] zram1: detected capacity change from 0 to 40960000
[   64.640701] Adding 3276796k swap on /dev/zram0.  Priority:100
extents:1 across:3276796k SS
[   64.675277] Adding 20479996k swap on /dev/zram1.  Priority:0
extents:1 across:20479996k SS
[   81.623460] cc1 invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL),
order=3D0, oom_score_adj=3D0
[   81.624056] CPU: 64 UID: 1000 PID: 5646 Comm: cc1 Tainted: G S
           6.11.0-rc6+ #34
[   81.628794] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   81.629016] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 09/21/2023
[   81.629422] Call Trace:
[   81.629564]  <TASK>
[   81.633896]  dump_stack_lvl+0x5d/0x80
[   81.634167]  dump_header+0x44/0x18d
[   81.638557]  oom_kill_process.cold+0xa/0xaa
[   81.638778]  out_of_memory+0x219/0x4b0
[   81.638995]  mem_cgroup_out_of_memory+0x12d/0x160
[   81.643485]  try_charge_memcg+0x488/0x630
[   81.643728]  __mem_cgroup_charge+0x42/0xd0
[   81.643949]  do_anonymous_page+0x32a/0x8b0
[   81.644162]  ? __pte_offset_map+0x1b/0x180
[   81.644375]  __handle_mm_fault+0xb34/0xfb0
[   81.644588]  handle_mm_fault+0xe2/0x2c0
[   81.644823]  do_user_addr_fault+0x2ca/0x7b0
[   81.645040]  exc_page_fault+0x7e/0x180
[   81.645254]  asm_exc_page_fault+0x26/0x30
[   81.645467] RIP: 0033:0x7f892250c407
[   81.645967] Code: 3e 0e 08 00 01 74 9c 83 f9 c0 0f 87 7e fe ff ff
c5 fe 6f 4e 20 48 29 fe 48 83 c7 3f 49 8d 0c 10 48 8
3 e7 c0 48 01 fe 48 29 f9 <f3> a4 c4 c1 7e 7f 00 c4 c1 7e 7f 48 20 c5
f8 77 c3 0f 1f 84 00 00
[   81.651207] RSP: 002b:00007ffc4aa3a5f8 EFLAGS: 00010206
[   81.651499] RAX: 00000000195aa850 RBX: 000000001949bd60 RCX: 00000000000=
01858
[   81.656091] RDX: 0000000000008008 RSI: 00000000194a2520 RDI: 00000000195=
b1000
[   81.660702] RBP: 00007ffc4aa3a640 R08: 00000000195aa850 R09: 00000000000=
00001
[   81.665385] R10: 00000000195aa840 R11: 00000000195b9000 R12: 00000000000=
08010
[   81.670185] R13: 00000000195aa850 R14: 0000000000010010 R15: 00007f89225=
86ac0
[   81.674802]  </TASK>
[   81.674970] memory: usage 481280kB, limit 481280kB, failcnt 9260
[   81.679505] swap: usage 171812kB, limit 9007199254740988kB, failcnt 0
[   81.679924] Memory cgroup stats for /build-kernel-tmpfs:
[   81.687282] anon 443244544
[   81.723088] file 25722880
[   81.727808] kernel 23789568
[   81.727963] kernel_stack 2490368
[   81.732353] pagetables 11616256
[   81.736751] sec_pagetables 0
[   81.741145] percpu 188256
[   81.741307] sock 0
[   81.745628] vmalloc 0
[   81.745844] shmem 1302528
[   81.745983] zswap 0
[   81.750314] zswapped 0
[   81.750477] file_mapped 18034688
[   81.754869] file_dirty 0
[   81.755029] file_writeback 0
[   81.759807] swapcached 2109440
[   81.764557] anon_thp 249561088
[   81.769449] file_thp 0
[   81.770044] shmem_thp 0
[   81.770747] inactive_anon 64327680
[   81.775654] active_anon 379654144
[   81.780542] inactive_file 4321280
[   81.785362] active_file 20099072
[   81.790348] unevictable 0
[   81.790914] slab_reclaimable 794232
[   81.795728] slab_unreclaimable 7392640
[   81.796394] slab 8186872
[   81.796960] workingset_refault_anon 5287
[   81.797820] workingset_refault_file 580
[   81.798465] workingset_activate_anon 2898
[   81.799097] workingset_activate_file 539
[   81.799717] workingset_restore_anon 2871
[   81.800337] workingset_restore_file 538
[   81.800936] workingset_nodereclaim 0
[   81.801578] pgdemote_kswapd 0
[   81.806357] pgdemote_direct 0
[   81.811214] pgdemote_khugepaged 0
[   81.820714] pgscan 130203
[   81.821234] pgsteal 52640
[   81.821745] pgscan_kswapd 0
[   81.822268] pgscan_direct 130203
[   81.827039] pgscan_khugepaged 0
[   81.831786] pgsteal_kswapd 0
[   81.836529] pgsteal_direct 52640
[   81.841303] pgsteal_khugepaged 0
[   81.846070] pgfault 1001627
[   81.846568] pgmajfault 5856
[   81.847106] pgrefill 146480
[   81.847604] pgactivate 26070
[   81.852395] pgdeactivate 0
[   81.852923] pglazyfree 0
[   81.853552] pglazyfreed 0
[   81.854013] zswpin 0
[   81.854468] zswpout 0
[   81.855157] zswpwb 0
[   81.855595] thp_fault_alloc 498
[   81.860352] thp_collapse_alloc 0
[   81.865086] thp_swpout 1
[   81.865567] thp_swpout_fallback 0
[   81.870312] numa_pages_migrated 0
[   81.875015] numa_pte_updates 10760
[   81.879669] numa_hint_faults 21
[   81.884307] Tasks state (memory values in pages):
[   81.889021] [  pid  ]   uid  tgid total_vm      rss rss_anon
rss_file rss_shmem pgtables_bytes swapents oom_score_adj
name
[   81.889895] [   2025]  1000  2025     1795      450        0
450         0    61440        0             0 kbench
[   81.891180] [   4734]  1000  4734      636      299        0
299         0    49152        0             0 time
[   81.891953] [   4735]  1000  4735     3071      751        0
751         0    73728        0             0 make
[   81.892763] [   4736]  1000  4736     2706     1034      288
746         0    73728        0             0 make
[   81.893571] [   5515]  1000  5515     2701     1052      288
764         0    65536        0             0 make
[   81.894311] [   5519]  1000  5519     2559      897      144
753         0    65536        0             0 make
[   81.895093] [   5520]  1000  5520     2547      884      144
740         0    57344        0             0 make
[   81.895844] [   5522]  1000  5522     2547      884      144
740         0    57344        0             0 make
[   81.896635] [   5524]  1000  5524     2547      900      144
756         0    61440        0             0 make
[   81.897430] [   5525]  1000  5525     2551      891      144
747         0    61440        0             0 make
[   81.898354] [   5526]  1000  5526     2569      888      144
744         0    65536        0             0 make
[   81.899172] [   5527]  1000  5527     2570      904      144
760         0    53248        0             0 make
[   81.900023] [   5528]  1000  5528     2540      898      144
754         0    61440        0             0 make
[   81.900827] [   5530]  1000  5530     2544      874      144
730         0    61440        0             0 make
[   81.901631] [   5532]  1000  5532     2581      890      144
746         0    57344        0             0 make
[   81.902463] [   5536]  1000  5536     2546      890      144
746         0    61440        0             0 make
[   81.903303] [   5537]  1000  5537     2544      892      144
748         0    69632        0             0 make
[   81.904128] [   5538]  1000  5538     1798      744        0
744         0    57344        0             0 sh
[   81.909083] [   5540]  1000  5540     2581      891      144
747         0    61440        0             0 make
[   81.909846] [   5541]  1000  5541     1797      751        0
751         0    49152        0             0 sh
[   81.914803] [   5543]  1000  5543     2544      886      144
742         0    65536        0             0 make
[   81.915581] [   5545]  1000  5545     2545      890      144
746         0    53248        0             0 make
[   81.916393] [   5548]  1000  5548     2547      903      144
759         0    69632        0             0 make
[   81.917275] [   5550]  1000  5550     1798      742        0
742         0    53248        0             0 sh
[   81.922333] [   5551]  1000  5551     2539      888      144
744         0    53248        0             0 make
[   81.923198] [   5552]  1000  5552     2539      888      144
744         0    61440        0             0 make
[   81.924037] [   5553]  1000  5553     1282      767        0
767         0    49152        0             0 gcc
[   81.929034] [   5556]  1000  5556     2541      893      144
749         0    57344        0             0 make
[   81.929831] [   5557]  1000  5557     2539      896      144
752         0    57344        0             0 make
[   81.930624] [   5561]  1000  5561     1282      753        0
753         0    45056        0             0 gcc
[   81.935632] [   5562]  1000  5562     1798      764        0
764         0    53248        0             0 sh
[   81.940609] [   5563]  1000  5563     2573      907      144
763         0    61440        0             0 make
[   81.941409] [   5565]  1000  5565     1798      750        0
750         0    53248        0             0 sh
[   81.946403] [   5566]  1000  5566     2544      902      144
758         0    53248        0             0 make
[   81.947214] [   5569]  1000  5569     2542      888      144
744         0    53248        0             0 make
[   81.947991] [   5572]  1000  5572     1282      755        0
755         0    49152        0             0 gcc
[   81.952957] [   5573]  1000  5573     1798      764        0
764         0    53248        0             0 sh
[   81.957974] [   5574]  1000  5574     2539      896      144
752         0    61440        0             0 make
[   81.958816] [   5575]  1000  5575     2540      880      144
736         0    65536        0             0 make
[   81.959657] [   5576]  1000  5576    13008     7927     2771
5156         0   131072        0             0 cc1
[   81.964615] [   5578]  1000  5578    15729     8291     5119
3172         0   151552        0             0 cc1
[   81.969617] [   5581]  1000  5581     1798      742        0
742         0    53248        0             0 sh
[   81.974649] [   5582]  1000  5582     1282      601        0
601         0    45056        0             0 gcc
[   81.979839] [   5584]  1000  5584     1798      746        0
746         0    57344        0             0 sh
[   81.984885] [   5585]  1000  5585     1798      744        0
744         0    57344        0             0 sh
[   81.989933] [   5589]  1000  5589     1798      750        0
750         0    45056        0             0 sh
[   81.994984] [   5591]  1000  5591     2514      888      144
744         0    61440        0             0 make
[   81.995852] [   5597]  1000  5597     1798      744        0
744         0    53248        0             0 sh
[   82.000886] [   5598]  1000  5598    14686     7403     4243
3160         0   143360        0             0 cc1
[   82.005980] [   5600]  1000  5600     1282      765        0
765         0    45056        0             0 gcc
[   82.011122] [   5602]  1000  5602     1798      754        0
754         0    61440        0             0 sh
[   82.016151] [   5603]  1000  5603     1282      735        0
735         0    49152        0             0 gcc
[   82.021250] [   5604]  1000  5604     1282      765        0
765         0    45056        0             0 gcc
[   82.026367] [   5605]  1000  5605     1798      750        0
750         0    57344        0             0 sh
[   82.031423] [   5606]  1000  5606     1798      742        0
742         0    57344        0             0 sh
[   82.036506] [   5608]  1000  5608    15456     7968     4812
3156         0   151552        0             0 cc1
[   82.041749] [   5611]  1000  5611     1798      762        0
762         0    57344        0             0 sh
[   82.046785] [   5613]  1000  5613     1282      764        0
764         0    45056        0             0 gcc
[   82.051923] [   5614]  1000  5614     1798      745        0
745         0    57344        0             0 sh
[   82.056956] [   5616]  1000  5616     1798      734        0
734         0    53248        0             0 sh
[   82.062176] [   5622]  1000  5622     1282      746        0
746         0    45056        0             0 gcc
[   82.067474] [   5623]  1000  5623     1282      605        0
605         0    45056        0             0 gcc
[   82.072487] [   5624]  1000  5624     1798      748        0
748         0    57344        0             0 sh
[   82.077553] [   5628]  1000  5628     1282      753        0
753         0    53248        0             0 gcc
[   82.082633] [   5629]  1000  5629    14716     7401     4241
3160         0   143360        0             0 cc1
[   82.087642] [   5630]  1000  5630    14614     7064     3922
3142         0   147456        0             0 cc1
[   82.092661] [   5633]  1000  5633    14588     6926     3779
3147         0   143360        0             0 cc1
[   82.097685] [   5635]  1000  5635     1282      616        0
616         0    49152        0             0 gcc
[   82.102675] [   5636]  1000  5636     1282      765        0
765         0    53248        0             0 gcc
[   82.107729] [   5637]  1000  5637     1282      748        0
748         0    45056        0             0 gcc
[   82.112810] [   5638]  1000  5638     1798      745        0
745         0    53248        0             0 sh
[   82.117833] [   5639]  1000  5639    14575     7105     3919
3186         0   147456        0             0 cc1
[   82.122838] [   5640]  1000  5640     1282      755        0
755         0    49152        0             0 gcc
[   82.127866] [   5642]  1000  5642     1282      753        0
753         0    49152        0             0 gcc
[   82.132897] [   5644]  1000  5644     1798      745        0
745         0    53248        0             0 sh
[   82.137960] [   5646]  1000  5646    15823     8639     5463
3176         0   151552        0             0 cc1
[   82.142999] [   5648]  1000  5648     1282      767        0
767         0    45056        0             0 gcc
[   82.147955] [   5651]  1000  5651     1798      750        0
750         0    45056        0             0 sh
[   82.152953] [   5652]  1000  5652     1282      752        0
752         0    45056        0             0 gcc
[   82.157964] [   5653]  1000  5653    14026     6214     3199
3015         0   139264        0             0 cc1
[   82.162975] [   5654]  1000  5654     1798      742        0
742         0    61440        0             0 sh
[   82.167970] [   5657]  1000  5657    14119     6858     3684
3174         0   143360        0             0 cc1
[   82.173140] [   5660]  1000  5660     1798      740        0
740         0    53248        0             0 sh
[   82.178178] [   5661]  1000  5661    15751     8608     5422
3186         0   159744        0             0 cc1
[   82.183201] [   5662]  1000  5662    14093     6976     3823
3153         0   143360        0             0 cc1
[   82.188343] [   5663]  1000  5663     1282      767        0
767         0    49152        0             0 gcc
[   82.193338] [   5665]  1000  5665    15863     8524     5354
3170         0   159744        0             0 cc1
[   82.198390] [   5667]  1000  5667     1282      754        0
754         0    40960        0             0 gcc
[   82.203440] [   5668]  1000  5668    14076     6269     3251
3018         0   139264        0             0 cc1
[   82.208471] [   5669]  1000  5669    14083     6713     3555
3158         0   143360        0             0 cc1
[   82.213507] [   5671]  1000  5671     1798      599        0
599         0    53248        0             0 sh
[   82.218523] [   5676]  1000  5676    13444     5798     2781
3017         0   147456        0             0 cc1
[   82.223549] [   5677]  1000  5677    15181     7544     4389
3155         0   151552        0             0 cc1
[   82.228575] [   5679]  1000  5679     1282      753        0
753         0    40960        0             0 gcc
[   82.233629] [   5683]  1000  5683     1282      755        0
755         0    45056        0             0 gcc
[   82.238641] [   5684]  1000  5684     1282      767        0
767         0    40960        0             0 gcc
[   82.243633] [   5685]  1000  5685    14670     7640     4464
3176         0   143360        0             0 cc1
[   82.248681] [   5686]  1000  5686    14601     6845     3670
3175         0   147456        0             0 cc1
[   82.253827] [   5687]  1000  5687     1798      735        0
735         0    57344        0             0 sh
[   82.258819] [   5690]  1000  5690     1282      753        0
753         0    40960        0             0 gcc
[   82.263841] [   5692]  1000  5692    14024     6379     3366
3013         0   143360        0             0 cc1
[   82.268966] [   5693]  1000  5693     1798      741        0
741         0    53248        0             0 sh
[   82.274000] [   5697]  1000  5697    15288     7953     4794
3159         0   147456        0             0 cc1
[   82.278987] [   5699]  1000  5699    14042     6225     3211
3014         0   143360        0             0 cc1
[   82.283986] [   5702]  1000  5702    14653     7386     4202
3184         0   151552        0             0 cc1
[   82.288984] [   5705]  1000  5705     1282      767        0
767         0    45056        0             0 gcc
[   82.294075] [   5707]  1000  5707     1282      767        0
767         0    45056        0             0 gcc
[   82.299067] [   5715]  1000  5715    14684     6882     3852
3030         0   147456        0             0 cc1
[   82.304088] [   5716]  1000  5716    14091     6713     3679
3034         0   139264        0             0 cc1
[   82.309082] [   5737]  1000  5737     1798      740        0
740         0    49152        0             0 sh
[   82.314109] [   5744]  1000  5744     1798      749        0
749         0    61440        0             0 sh
[   82.319327] [   5751]  1000  5751     1282      767        0
767         0    40960        0             0 gcc
[   82.324397] [   5753]  1000  5753     1282      767        0
767         0    45056        0             0 gcc
[   82.329414] [   5755]  1000  5755     1798      759        0
759         0    61440        0             0 sh
[   82.334384] [   5765]  1000  5765    13431     5815     2962
2853         0   139264        0             0 cc1
[   82.339405] [   5767]  1000  5767    13614     5959     2968
2991         0   147456        0             0 cc1
[   82.344380] [   5768]  1000  5768     1798      764        0
764         0    53248        0             0 sh
[   82.349390] [   5771]  1000  5771     1282      764        0
764         0    49152        0             0 gcc
[   82.354401] [   5778]  1000  5778     1282      754        0
754         0    45056        0             0 gcc
[   82.359462] [   5780]  1000  5780     1798      748        0
748         0    57344        0             0 sh
[   82.364494] [   5781]  1000  5781    13423     5798     2655
3143         0   135168        0             0 cc1
[   82.369477] [   5785]  1000  5785     2545      891      144
747         0    61440        0             0 make
[   82.370307] [   5787]  1000  5787    12900     7513     2549
4964         0   139264        0             0 cc1
[   82.375365] [   5788]  1000  5788     1282      767        0
767         0    45056        0             0 gcc
[   82.380409] [   5793]  1000  5793    13305     5367     2369
2998         0   135168        0             0 cc1
[   82.385768] [   5808]  1000  5808     1798      757        0
757         0    53248        0             0 sh
[   82.391002] [   5814]  1000  5814     1798      742        0
742         0    57344        0             0 sh
[   82.395991] [   5817]  1000  5817     1282      607        0
607         0    45056        0             0 gcc
[   82.400970] [   5818]  1000  5818     1798      746        0
746         0    49152        0             0 sh
[   82.405978] [   5820]  1000  5820     1282      753        0
753         0    45056        0             0 gcc
[   82.411029] [   5825]  1000  5825    12584     4814     1930
2884         0   131072        0             0 cc1
[   82.416092] [   5826]  1000  5826    13449     5961     2946
3015         0   135168        0             0 cc1
[   82.421135] [   5827]  1000  5827     1282      767        0
767         0    49152        0             0 gcc
[   82.426206] [   5832]  1000  5832    14026     6102     3106
2996         0   139264        0             0 cc1
[   82.431209] [   5836]  1000  5836     2541      888      144
744         0    61440        0             0 make
[   82.432102] [   5849]  1000  5849     1798      742        0
742         0    49152        0             0 sh
[   82.437079] [   5853]  1000  5853     1282      755        0
755         0    49152        0             0 gcc
[   82.442106] [   5854]  1000  5854     1798      746        0
746         0    53248        0             0 sh
[   82.447138] [   5855]  1000  5855     1798      754        0
754         0    57344        0             0 sh
[   82.452189] [   5857]  1000  5857    12542     4766     1920
2846         0   126976        0             0 cc1
[   82.457330] [   5859]  1000  5859     1282      607        0
607         0    45056        0             0 gcc
[   82.462329] [   5860]  1000  5860     1282      767        0
767         0    45056        0             0 gcc
[   82.467376] [   5863]  1000  5863    11918     4284     1584
2700         0   122880        0             0 cc1
[   82.472418] [   5864]  1000  5864    12782     5213     2353
2860         0   131072        0             0 cc1
[   82.477480] [   5866]  1000  5866     1798      762        0
762         0    49152        0             0 sh
[   82.482511] [   5867]  1000  5867     1282      753        0
753         0    49152        0             0 gcc
[   82.487557] [   5869]  1000  5869    11826     3577     1008
2569         0   118784        0             0 cc1
[   82.492580] [   5870]  1000  5870     1798      759        0
759         0    57344        0             0 sh
[   82.497616] [   5871]  1000  5871     1282      738        0
738         0    49152        0             0 gcc
[   82.502671] [   5872]  1000  5872    12506     4280     1584
2696         0   126976        0             0 cc1
[   82.507703] [   5878]  1000  5878     1798      753        0
753         0    53248        0             0 sh
[   82.512705] [   5879]  1000  5879     1282      607        0
607         0    53248        0             0 gcc
[   82.517772] [   5880]  1000  5880    11113     1506      144
1362         0    98304        0             0 cc1
[   82.522782] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpu=
set=3D/,mems_allowed=3D0-1,oom_memcg=3D/build-kernel-tmp
fs,task_memcg=3D/build-kernel-tmpfs,task=3Dcc1,pid=3D5646,uid=3D1000
[   82.528351] Memory cgroup out of memory: Killed process 5646 (cc1)
total-vm:63292kB, anon-rss:21852kB, file-rss:12704k
B, shmem-rss:0kB, UID:1000 pgtables:148kB oom_score_adj:0
[   82.534240] Tasks in /build-kernel-tmpfs are going to be killed due
to memory.oom.group set
[   82.535005] Memory cgroup out of memory: Killed process 2025
(kbench) total-vm:7180kB, anon-rss:0kB, file-rss:1800kB,
shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.536248] Memory cgroup out of memory: Killed process 4734 (time)
total-vm:2544kB, anon-rss:0kB, file-rss:1196kB, sh
mem-rss:0kB, UID:1000 pgtables:48kB oom_score_adj:0
[   82.534240] Tasks in /build-kernel-tmpfs are going to be killed due
to memory.oom.group set
[   82.535005] Memory cgroup out of memory: Killed process 2025
(kbench) total-vm:7180kB, anon-rss:0kB, file-rss:1800kB,
shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.536248] Memory cgroup out of memory: Killed process 4734 (time)
total-vm:2544kB, anon-rss:0kB, file-rss:1196kB, sh
mem-rss:0kB, UID:1000 pgtables:48kB oom_score_adj:0
[   82.537464] Memory cgroup out of memory: Killed process 4735 (make)
total-vm:12284kB, anon-rss:0kB, file-rss:3004kB, s
hmem-rss:0kB, UID:1000 pgtables:72kB oom_score_adj:0
[   82.538684] Memory cgroup out of memory: Killed process 4736 (make)
total-vm:10824kB, anon-rss:1152kB, file-rss:2984kB
, shmem-rss:0kB, UID:1000 pgtables:72kB oom_score_adj:0
[   82.544358] Memory cgroup out of memory: Killed process 5515 (make)
total-vm:10804kB, anon-rss:1152kB, file-rss:3056kB
, shmem-rss:0kB, UID:1000 pgtables:64kB oom_score_adj:0
[   82.550088] Memory cgroup out of memory: Killed process 5519 (make)
total-vm:10236kB, anon-rss:576kB, file-rss:3012kB,
 shmem-rss:0kB, UID:1000 pgtables:64kB oom_score_adj:0
[   82.555514] Memory cgroup out of memory: Killed process 5520 (make)
total-vm:10188kB, anon-rss:576kB, file-rss:2960kB,
 shmem-rss:0kB, UID:1000 pgtables:56kB oom_score_adj:0
[   82.560873] Memory cgroup out of memory: Killed process 5522 (make)
total-vm:10188kB, anon-rss:576kB, file-rss:2960kB,
 shmem-rss:0kB, UID:1000 pgtables:56kB oom_score_adj:0
[   82.566342] Memory cgroup out of memory: Killed process 5524 (make)
total-vm:10188kB, anon-rss:576kB, file-rss:3024kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.571948] Memory cgroup out of memory: Killed process 5525 (make)
total-vm:10204kB, anon-rss:576kB, file-rss:2988kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.577447] Memory cgroup out of memory: Killed process 5526 (make)
total-vm:10276kB, anon-rss:576kB, file-rss:2976kB,
 shmem-rss:0kB, UID:1000 pgtables:64kB oom_score_adj:0
[   82.582835] Memory cgroup out of memory: Killed process 5527 (make)
total-vm:10280kB, anon-rss:576kB, file-rss:3040kB,
 shmem-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.588226] Memory cgroup out of memory: Killed process 5528 (make)
total-vm:10160kB, anon-rss:576kB, file-rss:3016kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.593641] Memory cgroup out of memory: Killed process 5530 (make)
total-vm:10176kB, anon-rss:576kB, file-rss:2920kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.598976] Memory cgroup out of memory: Killed process 5532 (make)
total-vm:10324kB, anon-rss:576kB, file-rss:2984kB,
 shmem-rss:0kB, UID:1000 pgtables:56kB oom_score_adj:0
[   82.604485] Memory cgroup out of memory: Killed process 5536 (make)
total-vm:10184kB, anon-rss:576kB, file-rss:2984kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.609872] Memory cgroup out of memory: Killed process 5537 (make)
total-vm:10176kB, anon-rss:576kB, file-rss:2992kB,
 shmem-rss:0kB, UID:1000 pgtables:68kB oom_score_adj:0
[   82.615357] Memory cgroup out of memory: Killed process 5538 (sh)
total-vm:7192kB, anon-rss:0kB, file-rss:2976kB, shme
m-rss:0kB, UID:1000 pgtables:56kB oom_score_adj:0
[   82.616558] Memory cgroup out of memory: Killed process 5540 (make)
total-vm:10324kB, anon-rss:576kB, file-rss:2988kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.621995] Memory cgroup out of memory: Killed process 5541 (sh)
total-vm:7188kB, anon-rss:0kB, file-rss:3004kB, shme
m-rss:0kB, UID:1000 pgtables:48kB oom_score_adj:0
[   82.623641] Memory cgroup out of memory: Killed process 5543 (make)
total-vm:10176kB, anon-rss:576kB, file-rss:2968kB,
 shmem-rss:0kB, UID:1000 pgtables:64kB oom_score_adj:0
[   82.629202] Memory cgroup out of memory: Killed process 5545 (make)
total-vm:10180kB, anon-rss:576kB, file-rss:2984kB,
 shmem-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.634612] Memory cgroup out of memory: Killed process 5548 (make)
total-vm:10188kB, anon-rss:576kB, file-rss:3036kB,
 shmem-rss:0kB, UID:1000 pgtables:68kB oom_score_adj:0
[   82.640089] Memory cgroup out of memory: Killed process 5550 (sh)
total-vm:7192kB, anon-rss:0kB, file-rss:2968kB, shme
m-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.645892] Memory cgroup out of memory: Killed process 5551 (make)
total-vm:10156kB, anon-rss:576kB, file-rss:2976kB,
 shmem-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.651431] Memory cgroup out of memory: Killed process 5552 (make)
total-vm:10156kB, anon-rss:576kB, file-rss:2976kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.656848] Memory cgroup out of memory: Killed process 5553 (gcc)
total-vm:5128kB, anon-rss:0kB, file-rss:3068kB, shm
em-rss:0kB, UID:1000 pgtables:48kB oom_score_adj:0
[   82.658138] Memory cgroup out of memory: Killed process 5556 (make)
total-vm:10164kB, anon-rss:576kB, file-rss:2996kB,
 shmem-rss:0kB, UID:1000 pgtables:56kB oom_score_adj:0
[   82.663629] Memory cgroup out of memory: Killed process 5557 (make)
total-vm:10156kB, anon-rss:576kB, file-rss:3008kB,
 shmem-rss:0kB, UID:1000 pgtables:56kB oom_score_adj:0
[   82.669002] Memory cgroup out of memory: Killed process 5561 (gcc)
total-vm:5128kB, anon-rss:0kB, file-rss:3012kB, shm
em-rss:0kB, UID:1000 pgtables:44kB oom_score_adj:0
[   82.670288] Memory cgroup out of memory: Killed process 5562 (sh)
total-vm:7192kB, anon-rss:0kB, file-rss:3056kB, shme
m-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.671512] Memory cgroup out of memory: Killed process 5563 (make)
total-vm:10292kB, anon-rss:576kB, file-rss:3052kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
[   82.677226] Memory cgroup out of memory: Killed process 5565 (sh)
total-vm:7192kB, anon-rss:0kB, file-rss:3000kB, shme
m-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.678551] Memory cgroup out of memory: Killed process 5566 (make)
total-vm:10176kB, anon-rss:576kB, file-rss:3032kB,
 shmem-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.684045] Memory cgroup out of memory: Killed process 5569 (make)
total-vm:10168kB, anon-rss:576kB, file-rss:2976kB,
 shmem-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.689561] Memory cgroup out of memory: Killed process 5572 (gcc)
total-vm:5128kB, anon-rss:0kB, file-rss:3020kB, shm
em-rss:0kB, UID:1000 pgtables:48kB oom_score_adj:0
[   82.690824] Memory cgroup out of memory: Killed process 5573 (sh)
total-vm:7192kB, anon-rss:0kB, file-rss:3056kB, shme
m-rss:0kB, UID:1000 pgtables:52kB oom_score_adj:0
[   82.692119] Memory cgroup out of memory: Killed process 5574 (make)
total-vm:10156kB, anon-rss:576kB, file-rss:3008kB,
 shmem-rss:0kB, UID:1000 pgtables:60kB oom_score_adj:0
...
There are more processes that get killed by oom_group I omit here.

I haven't figured out why the patch + fix can cause swap stress test
oom kill regression. I will revert it in my bisect script to continue
haunting if there is another change breaking my swap stress test.

If there is any further fixup patch, please don't hesitate to send it
my way to test it.

Chris


>
> Chris
>
>
> On Tue, Sep 24, 2024 at 1:16=E2=80=AFAM Venkat Rao Bagalkote
> <venkat88@linux.vnet.ibm.com> wrote:
> >
> > Please add below tages to the patch.
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> >
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> >
> > Refer:
> > https://lore.kernel.org/lkml/57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux=
.vnet.ibm.com/
> >
> > Regards,
> >
> > Venkat.
> >
> > On 24/09/24 7:12 am, Sergey Senozhatsky wrote:
> > > On (24/09/23 19:48), Andrey Skvortsov wrote:
> > >> When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
> > >> default_compressor, because it's the same offset as ZRAM_PRIMARY_COM=
P,
> > >> so we need to make sure that we don't attempt to kfree() the
> > >> statically defined compressor name.
> > >>
> > >> This is detected by KASAN.
> > >>
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>    Call trace:
> > >>     kfree+0x60/0x3a0
> > >>     zram_destroy_comps+0x98/0x198 [zram]
> > >>     zram_reset_device+0x22c/0x4a8 [zram]
> > >>     reset_store+0x1bc/0x2d8 [zram]
> > >>     dev_attr_store+0x44/0x80
> > >>     sysfs_kf_write+0xfc/0x188
> > >>     kernfs_fop_write_iter+0x28c/0x428
> > >>     vfs_write+0x4dc/0x9b8
> > >>     ksys_write+0x100/0x1f8
> > >>     __arm64_sys_write+0x74/0xb8
> > >>     invoke_syscall+0xd8/0x260
> > >>     el0_svc_common.constprop.0+0xb4/0x240
> > >>     do_el0_svc+0x48/0x68
> > >>     el0_svc+0x40/0xc8
> > >>     el0t_64_sync_handler+0x120/0x130
> > >>     el0t_64_sync+0x190/0x198
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>
> > >> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > >> Fixes: 684826f8271a ("zram: free secondary algorithms names")
> > >> Cc: <stable@vger.kernel.org>
> > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >
