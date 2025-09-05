Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F9274B4A
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097704; cv=none; b=SvdBmz0g+Gf8pr7VuEhVJAKsbmsM+siveNTsV2Iq8fRKwgyhf3ny9hRunp3Nk5BJwNdDVnB7UK8Mc5ouqT+msNlsrw8cgaJvoLjjbm9O0gbKRhIgCsVMvzRMi17EkfY8/MwBFuPM5/KHU79AtksbyfGcB8iyOyZDHG+fUpa3eHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097704; c=relaxed/simple;
	bh=gnFYk0hFNHgf1Sg+25eZm51d37xcfphZYvcwItGfNFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSUMAhCjuKHr+CRGpMfY93Ypv2wJ9Txp68nnf08ecngvZp4BOm/HSwakqbWXPQT/OklzY1ihN0gi+vAbL5BffQ/JlwCuiwL0rgDRlH0cbnHPDbaujyiA6+z/gyL5TpvA4nvjjKqkj/gf7QQkWqRIk54E8fVjQpbHHhNT59uE5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=faQukWHh; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="faQukWHh"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e98b7071cc9so2434477276.3
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757097701; x=1757702501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDEg+eeO21xMg+I2e1MREOvahBXCNbXJKYsvFNtWL1o=;
        b=faQukWHhceCg5anApSIKitB6k9m7h/NEhDcz6nwwS20eyGI1QMIBsysCti2fLx6WKu
         hkf/AlRK/JwMOMnmmAIRh8a4Y+flTiWR0wWftHgUbIq0gmqwaMlvyv7PgfcNSGoV4R+t
         HR8dfrVkHIRbp0cDQ797gLbcpPKTjnM1lLhKLu0htMDbby0Y1boHW81YZWs4fj8W+i68
         E9a2DRoziOQXDCD/M11FmyOAJTwPYBiMV8NCaF+CBpJ4Zwhkt1FLGPsLN5khqwIvYxWY
         WPNPeVso9oe1Sr5HH6jtUiXqFFWi8F61/k+71BEmVfs/j0tuddmUpfTO2r3pTKebOtQe
         enhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757097701; x=1757702501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDEg+eeO21xMg+I2e1MREOvahBXCNbXJKYsvFNtWL1o=;
        b=en/Ufm+/MUJ1Jp6Js2j1qe+6B46hjj/CZvdlsjsexvyXuhdEd5qQ8dBN9il82TFaNE
         u1gaTXMzCRtpf8c+ZyTNlE4LFdS5ZQuIzPxn15T/0VnzuEHhWQ0klgyDOzl4z93oU/fp
         1T+Hiwd66YV3KMFZcPhNyzQzElPzB11x5ALoWfN55xFGDwQvn/pybny7mwXqaVRMysMe
         H70AUFhL7qYsZpdUS564/PA2eqna2CHbDY1816nn0VPS/l8yTKABtno+QxBV8dsbxYpk
         K5C7GMxd3vygJds96iL5X90kVOeE4sdgU25gc7ZsgG2cNcj8/6v78bi6OyovenUSjNam
         +hZg==
X-Forwarded-Encrypted: i=1; AJvYcCUD1y87uM1u6+obngehRn9vNcddXLftufmMZijFHJrGOtC05QmRWzRW2qJ7iGReekIJStdKhmoZAu4TaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8/8Mit2Pwew5R7ON3biDXPXAMiuzaJ01i5ZHnD2Z9GzUkUZN
	ktSPFB78BoDrEfKNZEPVOuDeVwlkf7n7SKgjwZZGr/ofGGxfDXxOM53CpZaKil20xdE=
X-Gm-Gg: ASbGncszIFvHmDsqImqt4oi9QDjBov6ttyjOWNyLUJfDZknp7jB7lMnE9X487IMqHwS
	XHKtB0kHqbvxFtCHH/6k8msz7FuIQzMU1ibdkthYkyHcV2TKRuj78aVYwUN2Q8dyumOwqHuF5eo
	HCt7LlzFxtGJhIqJ5DjZKUzKPRVXvHfBXYU37vU6iwxJwhzwRls6p6r+o40+7kpJPWlz2DT67t0
	ABYfHlMh7XRfr1pf8du4q5ZMNu/eVyQYYS3ODKGvcdnrrZREz35WaxE+qk9IqHV7Npe4rOXij01
	cqqodPXQ3Th9VbmIEI4pMrSVBGyw8fIW0ixF6jbceEXY4FfbD3DdMJhiYBGtCaWltbLT4p37bWF
	2yghSUmimeSkWzVRW+lCjJMYMKo0ZAA==
X-Google-Smtp-Source: AGHT+IEIFnMuJGf9nlLx/o+R7Xas6e/S1Sd/cHueNiJaJ6sHQ2tImMIluyjeRBxWo7Ry2qiJSUsBgA==
X-Received: by 2002:a53:c945:0:b0:604:3849:9bc8 with SMTP id 956f58d0204a3-604385901a2mr5807335d50.22.1757097700854;
        Fri, 05 Sep 2025 11:41:40 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a82d58b8sm31690837b3.9.2025.09.05.11.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 11:41:40 -0700 (PDT)
Message-ID: <c482c91d-5a5b-4f82-81c1-b694962009ea@kernel.dk>
Date: Fri, 5 Sep 2025 12:41:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-arm64: xfstests crash in bio_iov_iter_get_pages on
 next-20250904
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux btrfs <linux-btrfs@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <CA+G9fYtsamwXQzuQm4dYNC8kbSJzGAQvZ5mr4BA8X9WE29+yyg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYtsamwXQzuQm4dYNC8kbSJzGAQvZ5mr4BA8X9WE29+yyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 6:58 AM, Naresh Kamboju wrote:
> The following regressions were detected on qemu-arm64 while running
> xfstests with the Linux next-20250904 tag. The system crashed with an
> internal error in bio_iov_iter_get_pages(), resulting in an Oops during
> direct I/O write operations.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> First seen on next-20250904
> Bad: next-20250904 and next-20250905
> Good: next-20250822
> 
> Test regression: next-20250904 qemu-arm64 xfstests Internal error Oops
> bio_iov_iter_get_pages
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> qemu-arm64:
> Test:
> * xfstests
> 
> Test crash:
> 
> [ 2074.633472] Internal error: Oops: 0000000096000004 [#1]  SMP
> [ 2074.639619] Modules linked in: sm3_ce sha3_ce fuse drm backlight dm_mod
> [ 2074.651698] CPU: 0 UID: 0 PID: 154238 Comm: xfs_io Not tainted
> 6.17.0-rc4-next-20250904 #1 PREEMPT
> [ 2074.652132] Hardware name: linux,dummy-virt (DT)
> [ 2074.652429] pstate: 22402009 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [ 2074.652716] pc : bio_iov_iter_get_pages (block/bio.c:1074
> block/bio.c:1272 block/bio.c:1336)
> [ 2074.701159] lr : bio_iov_iter_get_pages (block/bio.c:1072
> block/bio.c:1272 block/bio.c:1336)
> [ 2074.701366] sp : ffff800080f83950
> [ 2074.701506] x29: ffff800080f83980 x28: 000000000006f000 x27: fff00000c03b9408
> [ 2074.701853] x26: 0000000000001000 x25: 0000000000000091 x24: ffffc1ffc153b480
> [ 2074.702133] x23: 0000000000000002 x22: 00000000ffffffff x21: 0000000000000100
> [ 2074.702421] x20: 0000000000000001 x19: 0000000000001000 x18: 0000000000001000
> [ 2074.702710] x17: 0000000000000000 x16: 0000000000000000 x15: fff00000ff6e9a80
> [ 2074.702987] x14: fff0000007413500 x13: ffffa44770f6e000 x12: ffffc1ffc0000000
> [ 2074.703264] x11: 0000000000001000 x10: fff00000cf850800 x9 : fff00000cf850b78
> [ 2074.703510] x8 : ffffc1ffc153ac08 x7 : 0000ffff9626f000 x6 : 0000000000000fff
> [ 2074.703794] x5 : 0000000000021000 x4 : ffffc1ffbf000000 x3 : 7878782f78787878
> [ 2074.704079] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000001000
> [ 2074.704436] Call trace:
> [ 2074.704685] bio_iov_iter_get_pages (block/bio.c:1074
> block/bio.c:1272 block/bio.c:1336) (P)
> [ 2074.704971] iomap_dio_bio_iter (fs/iomap/direct-io.c:437)
> [ 2074.705167] __iomap_dio_rw (include/linux/uio.h:228
> fs/iomap/direct-io.c:530 fs/iomap/direct-io.c:559
> fs/iomap/direct-io.c:729)
> [ 2074.705331] btrfs_direct_write+0x1f4/0x3bc
> [ 2074.713828] btrfs_do_write_iter+0x18c/0x1ec
> [ 2074.725568] btrfs_file_write_iter+0x14/0x20
> [ 2074.725936] vfs_write (fs/read_write.c:593 fs/read_write.c:686)
> [ 2074.731508] __arm64_sys_pwrite64 (fs/read_write.c:793
> fs/read_write.c:801 fs/read_write.c:798 fs/read_write.c:798)
> [ 2074.731822] invoke_syscall (arch/arm64/kernel/syscall.c:35
> arch/arm64/kernel/syscall.c:49)
> [ 2074.737438] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:132)
> [ 2074.737885] do_el0_svc (arch/arm64/kernel/syscall.c:151)
> [ 2074.738235] el0_svc (arch/arm64/kernel/entry-common.c:879)
> [ 2074.785073] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
> [ 2074.785245] el0t_64_sync (arch/arm64/kernel/entry.S:596)
> [ 2074.785643] Code: f9400fea d2820000 7940c377 f8795943 (f9400462)
> All code
> ========
>    0: f9400fea ldr x10, [sp, #24]
>    4: d2820000 mov x0, #0x1000                // #4096
>    8: 7940c377 ldrh w23, [x27, #96]
>    c: f8795943 ldr x3, [x10, w25, uxtw #3]
>   10:* f9400462 ldr x2, [x3, #8] <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0: f9400462 ldr x2, [x3, #8]
> [ 2074.786668] ---[ end trace 0000000000000000 ]---
> 
> 
> ## Source
> * Kernel version: 6.17.0-rc4-next-20250904
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20250904
> * Git commit: 4ac65880ebca1b68495bd8704263b26c050ac010
> * Architectures / Devices: qemu-arm64
> * Toolchains: gcc-13
> * Kconfigs: defconfig+xfstests
> * xfstests: v2024.12.01
> 
> ## Build
> * Test log: https://qa-reports.linaro.org/api/testruns/29762004/log_file/
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250904/log-parser-test/internal-error-oops-oops-smp/
> * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32E6ypoTqaDjAEJISuUAAgkPUva
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32E6us2qcXmnop3jTYQMOB9eVPt/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/32E6us2qcXmnop3jTYQMOB9eVPt/config
> * xfstests: https://storage.tuxboot.com/overlays/debian/trixie/arm64/xfstests/v2024.12.01/xfstests.tar.xz
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

Adding David and leaving report intact, perhaps try if it's the same
that syzbot reported:

https://lore.kernel.org/io-uring/68babfe5.a00a0220.eb3d.0011.GAE@google.com/T/#m28a0c46852dbbfb8ae655256f4e8270d81a33076

-- 
Jens Axboe
