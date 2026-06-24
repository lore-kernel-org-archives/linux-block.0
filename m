Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760623B47E0
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307406; cv=none; b=NiZvSdpeHBUdAmEBNvufIwkDffXinNu6wG+TrlMqYyAocdNadQT9dtGlIvgjlMdHeK8ym+bUrdyuexfF+y2Jjukd5efijlpyE3LaE0aRqDB/tsvZQpiUQkcpJPIShWG1STL+CZngZ1euzrXpCy1PmwLe5/9SlL4s3agvwBvYgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307406; c=relaxed/simple;
	bh=nOGI1wI+vpa0w8/Vtce1TwCsycM2v5+pG5SNHLWaxXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmgDQbfKDA92AkAlrdMsQxfWi2i05zJvfnZQfJiJIwtOla8ZUfOJEr6U1yUJnSVg2Am+fG1Ql2izEOzYvvnFTtW012BIzWVLTGJW3gIa8j01peAAILNItFakYFpx1ixnECeWXOgKJRRC2WnMp8ovFxTlm5kiVK4Y/hMmvgwidsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cgCrq7NG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cgCrq7NG"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso158621966b.0
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782307401; x=1782912201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcv3i8MxYGcE66nrV/kv3D5y9IOE8aUQHBcOTbfUFU4=;
        b=cgCrq7NGG1p0s3yNJZX9a278VP+kx23StqMr2I8tXonWrDsYnISG5dIsC6qk7Uktc2
         XLunBxsVzP1gxhwR2nQvA90HP2RjR2M9FgYY9DSuiLrzvk6fsfdn0LWScB2xSSnwfQDi
         v8R0W+ObgUgIdywLlvB6Ksnki2hBo6ScvAQqgWh7u5IW8crEsW93sq9e8vpdKTYxbXO5
         oSpBX3P45oikv1Y4B6xCJKqfYnxKeRsMOj4VhHh/AMDnMGroAUGKEw0dbbK674Jrillk
         eeEbLOaqP9SZijhcjbaCyCEx0vYr+Np3sq/WmLVv9PAVJnuVhBf9mptydGoMPKthnC9M
         aelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307401; x=1782912201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcv3i8MxYGcE66nrV/kv3D5y9IOE8aUQHBcOTbfUFU4=;
        b=O4xN2QkyOsfW0bYSoIN4nqCBj6LlzL3eiZSIKASmfw4VIrxYW7jEfJ4JNJyc1c10Fu
         kuQ7Me9HLgsZPB2HLtpi9/KNR+TVC83rNW/gBa1qBfW0XZC2Q/x4Yf1j14bG7KRKaVT8
         2YXWiLsasIAChDTGXpo1R+lKHkR+IzBtxsyGiiPvMYel4TXyAt1xLYQfTZFelltewJ1C
         eLTawN2rAI+945vb1vOpyH39fc7Z7ItMthDM9ZqUP1DkZoTh53mrA3vwuOAZtTQT4lmo
         6Df41ALO5DUasQWcTGVGBKz8/yth+cit467hg5rPCh6xiQnvWAnVwX+WRif0oHvGv2Ha
         lufw==
X-Forwarded-Encrypted: i=1; AFNElJ8YX2xmpki7J52G97xAAzUCyagWjhvb11wa5jeN1JbM9i/mcivWWmrsKA8lmUI/Nw8FTGBjTcw11rFdhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDT9GBQPkYJ+WLyzwP0yFOfIRdoDeHTSedVSFnRcaagrMOOyi
	fNVYa5CUnl5oQO7arX38Ms7EQlxuCmzblY5v53k4656DKaG0HwOkklIrqA+oIZ7zOl0=
X-Gm-Gg: AfdE7cl7DVLPNrSAB21rrQ2QTjpTpbVO4mLs4d5Jo5DVDOD73QAmT9WgjtwZFsnp3Zk
	d3jFVwBm+rB0RV8R4Zov/F0YU/cMT1B6AIaDY0DeJOgSqVPw3munVncWKr/c9ovO+f7lrZZk8h4
	EeoGOKGiy0EUhU6S0Z7p3oceN5mtgn+x0Qs8HxDiTSsBfhJ3vUQQyQF5lV2ynhD8iezLtKJDN4r
	oh09v7lKXlHE42+zGdwDN0j9f1qHRVx6bH5d4dJcURTNoSzj4yKBWmI1lFey2vuuDVcFMH5hNyR
	p6SKplOkh3KRZoKxyiCWe2VKzH0OzmDKuxnnAPOpJzixymFhgKTJ01FwE0X7JVAglLOb2+BB4St
	n+kQbON7/pDUK5Tth7A9evR4UorMt8Spt71YRDhxVuZ4mLFzrm9XN8WdP5WZy4w9Dvbd4m4PkPr
	uji4JUmyy5uGYeFE+3tmnGKfdoT+hqcJhcpZfJxB7ZfwmmcE+VzpYs1x7lB8HvouOpk6ODvOkxn
	RiNHU4zeTJO3HchVoTFsJYcr5AX4co1jZ5q+UlTjZ1hUkFuw5M27IUd4T4=
X-Received: by 2002:a17:907:a807:b0:c10:d41c:e540 with SMTP id a640c23a62f3a-c119e179685mr185363566b.11.1782307400601;
        Wed, 24 Jun 2026 06:23:20 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99e1aasm644551166b.25.2026.06.24.06.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:23:20 -0700 (PDT)
Message-ID: <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
Date: Wed, 24 Jun 2026 15:23:18 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 2:57 PM, Alvin Sun wrote:
> During tyr debugfs development, a kernel NULL pointer dereference was
> encountered after `rmmod tyr` while gnome-shell still held /dev/card1 open:
> 
> ```
>   [158827.868132] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   [158827.868918] Mem abort info:
>   [158827.869177]   ESR = 0x0000000086000004
>   [158827.869519]   EC = 0x21: IABT (current EL), IL = 32 bits
>   [158827.870000]   SET = 0, FnV = 0
>   [158827.870281]   EA = 0, S1PTW = 0
>   [158827.870571]   FSC = 0x04: level 0 translation fault
>   [158827.871043] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108dec000
>   [158827.871623] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>   [158827.872242] Internal error: Oops: 0000000086000004 [#1]  SMP
>   [158827.872246] Modules linked in: tyr sunrpc snd_soc_simple_card rk805_pwrkey snd_soc_simple_card_utils rtw88_8822bu display_connector rtw88_usb rtw88_8822b snd_soc_rockchip_i2s_tdm snd_soc_hdmi_codec
>   rtw88_core]
>   [158827.872337] CPU: 4 UID: 1000 PID: 11276 Comm: gnome-s:disk$0 Tainted: G                 N  7.1.0-rc1+ #331 PREEMPT
>   [158827.880534] Tainted: [N]=TEST
>   [158827.880535] Hardware name: FriendlyElec NanoPi R6C/NanoPi R6C, BIOS v1.1 04/09/2025
>   [158827.880538] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   [158827.880542] pc : 0x0
>   [158827.880547] lr : _RNvNtCs257m05FHVbX_3tyr2vm8pt_unmap+0x8c/0x12c [tyr]
>   [158827.880578] sp : ffff800083c236b0
>   [158827.880579] x29: ffff800083c236d0 x28: ffff00013f8a0000 x27: 0000000000000000
>   [158827.880585] x26: 000000000000007c x25: ffff000108e6ed80 x24: 0000000000401000
>   [158827.880590] x23: 0000000000000000 x22: 0000000040000000 x21: 0000000000001000
>   [158827.880595] x20: ffff00010f778138 x19: 0000000000400000 x18: 00000000ffffffff
>   [158827.880600] x17: 000000040044ffff x16: 045000f2b5503510 x15: 0720072007200720
>   [158827.880606] x14: 0720072007200720 x13: 0000000000401000 x12: 0000000000400000
>   [158827.880611] x11: ffff800083c239d0 x10: ffff000141e4fd88 x9 : 0000000000000000
>   [158827.880615] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000400000
>   [158827.880620] x5 : ffff00013f8a0000 x4 : 0000000000000000 x3 : 0000000000000001
>   [158827.880625] x2 : 0000000000001000 x1 : 0000000000400000 x0 : ffff00010f778138
>   [158827.880630] Call trace:
>   [158827.880632]  0x0 (P)
>   [158827.880635]  _RNvXs6_NtCs257m05FHVbX_3tyr2vmNtB5_9GpuVmDataNtNtNtCsgmSOfgXi5CZ_6kernel3drm5gpuvm11DriverGpuVm13sm_step_unmap+0x3c/0x120 [tyr]
>   [158827.891166]  _RNvMs4_NtNtNtCsgmSOfgXi5CZ_6kernel3drm5gpuvm6sm_opsINtB7_5GpuVmNtNtCs257m05FHVbX_3tyr2vm9GpuVmDataE13sm_step_unmapB13_+0x18/0x34 [tyr]
>   [158827.891187]  op_unmap_cb+0x78/0xb0
>   [158827.891196]  __drm_gpuvm_sm_unmap+0x18c/0x1b4
>   [158827.891204]  drm_gpuvm_sm_unmap+0x38/0x4c
>   [158827.891209]  _RNvMs5_NtCs257m05FHVbX_3tyr2vmNtB5_2Vm7exec_op+0x1cc/0x254 [tyr]
>   [158827.894085]  _RNvMs5_NtCs257m05FHVbX_3tyr2vmNtB5_2Vm11unmap_range+0x124/0x188 [tyr]
>   [158827.894105]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeNtNtCs257m05FHVbX_3tyr3gem8KernelBoEBK_+0x44/0xd8 [tyr]
>   [158827.894125]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeINtNtNtCsgmSOfgXi5CZ_6kernel5alloc4kvec3VecNtNtCs257m05FHVbX_3tyr2fw7SectionNtNtBL_9allocator7KmallocEEB1r_+0x3c/0x100 [tyr]
>   [158827.894147]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeINtNtNtCsgmSOfgXi5CZ_6kernel4sync3arc3ArcNtNtCs257m05FHVbX_3tyr2fw8FirmwareEEB1p_+0x94/0x190 [tyr]
>   [158827.894167]  _RNvMs4_NtNtCsgmSOfgXi5CZ_6kernel3drm6deviceINtB5_6DeviceNtNtCs257m05FHVbX_3tyr6driver12TyrDrmDriverE7releaseBW_+0x30/0x98 [tyr]
>   [158827.899550]  drm_dev_put.part.0+0x88/0xc0
>   [158827.899557]  drm_minor_release+0x18/0x28
>   [158827.899562]  drm_release+0x144/0x170
>   [158827.899567]  __fput+0xe4/0x30c
>   [158827.899573]  ____fput+0x14/0x20
>   [158827.899579]  task_work_run+0x7c/0xe8
>   [158827.899586]  do_exit+0x2a8/0xac4
>   [158827.899590]  do_group_exit+0x34/0x90
>   [158827.899594]  get_signal+0xaac/0xabc
>   [158827.899599]  arch_do_signal_or_restart+0x90/0x3e8
>   [158827.899606]  exit_to_user_mode_loop+0x140/0x1d0
>   [158827.899613]  el0_svc+0x2f4/0x2f8
>   [158827.899620]  el0t_64_sync_handler+0xa0/0xe4
>   [158827.899627]  el0t_64_sync+0x198/0x19c
>   [158827.899632] ---[ end trace 0000000000000000 ]---
> ```
> 
> The root cause: `fops.owner` was `NULL` in Rust DRM drivers, so the kernel
> never blocked module unloading while file descriptors were open. This leads to
> use-after-free when drm_release (or other fops) is called on freed module code.
> 
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, threads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates configfs
> and rnull to use `this_module::<LocalModule>()`.

I cannot comment that much on all the details of the Rust
implementation, but the series looks reasonable to me from the modules
perspective. I'm glad this issue will be finally addressed.

I would only suggest adding the new file rust/kernel/module.rs in
patch #1 under the MODULE SUPPORT support entry in the MAINTAINERS file,
similarly to the other module-related Rust code, so that the module
maintainers are emailed when changes to this file are proposed. I think
you can change the existing 'F: rust/kernel/module_param.rs' to
'F: rust/kernel/module*.rs'.

-- 
Thanks,
Petr
