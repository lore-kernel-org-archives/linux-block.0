Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AB23F36F
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016392; cv=none; b=I3pW+5RJXmP+OYuPltcvaOeSMD6oZAy9nFo8CpBxqHhYxJVFrwp1GHgcnNi5Xd/tg0DemtLNCne9ZYlTXYDRtwS8hvWJ5HmtxdcPZO61PXdREtGuwzB38RStJ3M8ZlfEVjMNrA2LzRDRLcbySKmZFUn3EXmonItwJ26kQ3U06HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016392; c=relaxed/simple;
	bh=9ohOOOjox65ewwTQTlyIkdR0oiUHuAwhRBKISfacbAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFHt5sadBkRT6MieC6umxq+8dFzQHiEmO1hHeRoNa5UR3lRXUWBp6dEgDvdRfTvTWuIFo9Fy0BBWqmKmsrRJBtpH73zg/R0WYavg+XiRbzFkRfzrGDA97qf6L2P3nF9mZPZLdBVjDr+LeoBk+8xk3umpZ4OXZ3LfamQlWyvq27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MhX7Mm15; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MhX7Mm15"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-439950a45daso29367355e9.2
        for <linux-block@vger.kernel.org>; Mon, 03 Mar 2025 07:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741016388; x=1741621188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMHWvw7fR22PBuz4Qp3n7v5BzkivILkbXOLPhRB7PNQ=;
        b=MhX7Mm15wavFTnav+7gC6R8eNTGQ0ZWAGfBABgMcr+LSfJjiRNWvSaBzBkl7fgRlyb
         ZnQ+nfcpm/6mC2Z9VewxAOqdV+zinwQNOaYiftYsMyvVLe/f4upEyds5lLV+6df/AByT
         1rzBrQDcQtLgE2iligv2+V4CEnCBdCemraf/ro0sUxg++tcYDzWIlwoSSpsHH6HPeSZB
         abfswFPEGXWQiozIwX67jJFZOPwLCd0XGiYuSDDbRRDUqBJRy65P9DHSnzLUHUDybctM
         QeqKSHtlWG0yT4YDoZJPISXm6BryGwSE53vkcu8aqr5crNxXSj8ekKpTXD1DS5n17tO2
         9J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016388; x=1741621188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMHWvw7fR22PBuz4Qp3n7v5BzkivILkbXOLPhRB7PNQ=;
        b=Ni7UGtu8Zt3K0BeqFfDPIzvOWXsa/UTdm4IneD77nnTM1aF1Gfan/c7VaN2Opa6+at
         bw+uh4Kk+k4yseqBHgV/VA5BfHkwom1S7PoQRkZHYXWXjavAA2/nxZH/9xaB2Pe76zc6
         Zh8bmirpm3pOe+hpw3QD8If9sUqA9yNNxOpf3xAvMFeM3rRBBt2c5L/gV5XCRlU+eCJH
         FopyTP0XaR0POvX8GqDECN7Tpkl1yPJ8pWUenaOhXBoeCIeVzhpsAhHwthWeB3As2zvn
         JamQyf6/7DHELJgqgWFdneL4DkdLVGbNzjRHNZGhah974vqKdXvAbRNf+MN3l8CAZeZL
         MEaw==
X-Forwarded-Encrypted: i=1; AJvYcCWCUdhZoThQbb6aL6BKmJj+MICsqlDa/7NGYOiOFfvMpLkU34HYyRDGctciB4/rMTL3wS2/2mVkwYy4LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSmMzRa64P3Y6NJ2nLV2qC7notvvjt5xZxbA/VPt1VqwwsDtX
	gFFPG68NwLnbSiaxiKUY2FYj1Bb0w+5KErDwq3fmVnITgzdgoOZ+BeoG2WB1HyQkbRLAnsWtiYO
	O
X-Gm-Gg: ASbGncsDZx/LMVVboIzZ5q6+lV0zPRWZVrH9gHDPPs/RzOx2UHLdZ4P1OtDK0E1ugXR
	/y3Qwl4VfswloaAb3p2QHjBQkKiXavudzz9UEw3veAxRgLPIinGyrz+CTC8Qf7145eoq3w3yjmc
	FUD8iIW7q1HMCXXpdOrYU/0hwa0eQBVhXW+KvpGp6pIQUqJN6JzkzU9nn7a95unEu+I7aCpTphy
	3juVHkdWZPjvcjE5xR3hXXnmHoTSaO4PNfIvDJ+vIHWI7SmZesLmgUBjmklSXEbKi/BUyPWLyPX
	V8nuoMAcr1ouphdbPjdGAmiuuTNfUHEMqjmN7YYtgFWphfmDV3It5pmvE6AYq25aT0XP9w==
X-Google-Smtp-Source: AGHT+IHvXTc6F3EC+abvjlk3Jz42ryStIeQIJ8qFTHUhiMuLTjiR2VQVx8BxyCzAKLhJ2tQ8I+zWZg==
X-Received: by 2002:a05:6000:4029:b0:38f:2726:bc0e with SMTP id ffacd0b85a97d-390eca138d2mr12523655f8f.44.1741016388086;
        Mon, 03 Mar 2025 07:39:48 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm15041360f8f.32.2025.03.03.07.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 07:39:47 -0800 (PST)
Message-ID: <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
Date: Mon, 3 Mar 2025 16:39:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <Z8W_1l7lCFqMiwXV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 15:42, Matthew Wilcox wrote:
> On Mon, Mar 03, 2025 at 02:27:06PM +0000, Matthew Wilcox wrote:
>> We have a _lot_ of page types available.  We should mark large kmallocs
>> as such.  I'll send a patch to do that.
> 
> Can you try this?  It should fix the crash, at least.  Not sure why the
> frozen patch triggered it.
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 36d283552f80..df9234e5f478 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -925,14 +925,15 @@ FOLIO_FLAG_FALSE(has_hwpoisoned)
>   enum pagetype {
>   	/* 0x00-0x7f are positive numbers, ie mapcount */
>   	/* Reserve 0x80-0xef for mapcount overflow. */
> -	PGTY_buddy	= 0xf0,
> -	PGTY_offline	= 0xf1,
> -	PGTY_table	= 0xf2,
> -	PGTY_guard	= 0xf3,
> -	PGTY_hugetlb	= 0xf4,
> -	PGTY_slab	= 0xf5,
> -	PGTY_zsmalloc	= 0xf6,
> -	PGTY_unaccepted	= 0xf7,
> +	PGTY_buddy		= 0xf0,
> +	PGTY_offline		= 0xf1,
> +	PGTY_table		= 0xf2,
> +	PGTY_guard		= 0xf3,
> +	PGTY_hugetlb		= 0xf4,
> +	PGTY_slab		= 0xf5,
> +	PGTY_zsmalloc		= 0xf6,
> +	PGTY_unaccepted		= 0xf7,
> +	PGTY_large_kmalloc	= 0xf8,
>   
>   	PGTY_mapcount_underflow = 0xff
>   };
> @@ -1075,6 +1076,7 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>    * Serialized with zone lock.
>    */
>   PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> +FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>   
>   /**
>    * PageHuge - Determine if the page belongs to hugetlbfs
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f50129dcfb3..872e1bab3bd1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4241,6 +4241,7 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
>   		ptr = folio_address(folio);
>   		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
>   				      PAGE_SIZE << order);
> +		__folio_set_large_kmalloc(folio);
>   	}
>   
>   	ptr = kasan_kmalloc_large(ptr, size, flags);
> @@ -4716,6 +4717,11 @@ static void free_large_kmalloc(struct folio *folio, void *object)
>   {
>   	unsigned int order = folio_order(folio);
>   
> +	if (WARN_ON_ONCE(!folio_test_large_kmalloc(folio))) {
> +		dump_page(&folio->page, "Not a kmalloc allocation");
> +		return;
> +	}
> +
>   	if (WARN_ON_ONCE(order == 0))
>   		pr_warn_once("object pointer: 0x%p\n", object);
>   
> @@ -4725,6 +4731,7 @@ static void free_large_kmalloc(struct folio *folio, void *object)
>   
>   	lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
>   			      -(PAGE_SIZE << order));
> +	__folio_clear_large_kmalloc(folio);
>   	folio_put(folio);
>   }
>   

Still crashes:

[   63.561990] nvme nvme1: queue 0: failed to start TLS: -3
[   63.652070] ------------[ cut here ]------------
[   63.658068] WARNING: CPU: 6 PID: 5216 at mm/slub.c:4720 
free_large_kmalloc+0x89/0xa0
[   63.667579] Modules linked in: tls(E) nvme_tcp(E) af_packet(E) 
iscsi_ibft(E) iscsi_boot_sysfs(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) 
fat(E) ipmi_ssif(E) amd_atl(E) intel_rapl_msr(E) xfs(E) 
intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) dax_hmem(E) 
cxl_acpi(E) tg3(E) cxl_port(E) kvm_amd(E) ipmi_si(E) cxl_core(E) i40e(E) 
i2c_piix4(E) ipmi_devintf(E) einj(E) kvm(E) acpi_cpufreq(E) wmi_bmof(E) 
libphy(E) libie(E) k10temp(E) i2c_smbus(E) ipmi_msghandler(E) 
i2c_designware_platform(E) joydev(E) i2c_designware_core(E) button(E) 
nvme_fabrics(E) nvme_keyring(E) fuse(E) efi_pstore(E) configfs(E) 
dmi_sysfs(E) ip_tables(E) x_tables(E) hid_generic(E) usbhid(E) ahci(E) 
libahci(E) ghash_clmulni_intel(E) libata(E) sha512_ssse3(E) 
sha256_ssse3(E) sd_mod(E) ast(E) sha1_ssse3(E) scsi_dh_emc(E) 
drm_client_lib(E) scsi_dh_rdac(E) i2c_algo_bit(E) aesni_intel(E) 
xhci_pci(E) scsi_dh_alua(E) drm_shmem_helper(E) crypto_simd(E) 
drm_kms_helper(E) cryptd(E) sg(E) nvme(E) xhci_hcd(E) nvme_core(E) 
scsi_mod(E) drm(E) nvme_auth(E) scsi_common(E)
[   63.667703]  usbcore(E) ccp(E) sp5100_tco(E) wmi(E) btrfs(E) 
blake2b_generic(E) xor(E) raid6_pq(E) efivarfs(E)
[   63.667717] CPU: 6 UID: 0 PID: 5216 Comm: nvme Kdump: loaded Tainted: 
G        W   E      6.14.0-rc4-default+ #308 
190df031934d7fa516e6fdc38148e19d2fe48841
[   63.667724] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[   63.667726] Hardware name: Lenovo ThinkSystem SR655V3/SB27B09914, 
BIOS KAE111E-2.10 04/11/2023
[   63.667728] RIP: 0010:free_large_kmalloc+0x89/0xa0
[   63.667733] Code: df e8 5b ff ff ff 83 7b 30 ff 74 07 c7 43 30 ff ff 
ff ff f0 ff 4b 34 74 07 5b 5d e9 2c 08 b4 ff 48 89 df 5b 5d e9 57 05 f8 
ff <0f> 0b 48 89 df 48 c7 c6 9e bc 5b 82 5b 5d e9 a4 0b fb ff 0f 1f 40
[   63.842753] RSP: 0018:ff824cf0c3307c08 EFLAGS: 00010202
[   63.842757] RAX: 00000000000000ff RBX: fffb0b48c0178e80 RCX: 
ff45d99f856df580
[   63.842759] RDX: 0000000000000000 RSI: ff45d99f85e3a800 RDI: 
fffb0b48c0178e80
[   63.842760] RBP: 00000000fffff000 R08: 0000000000000001 R09: 
0000000000000101
[   63.842762] R10: ff824cf0c3307c90 R11: 0000000000000001 R12: 
fffb0b48c0178e80
[   63.842764] R13: ff45d99f85e3a800 R14: ff45d9a1d3622a30 R15: 
ff45d9a1e9b58000
[   63.842765] FS:  00007f5f53015800(0000) GS:ff45d9a24d800000(0000) 
knlGS:0000000000000000
[   63.842767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.842769] CR2: 00007f5f52f50d7e CR3: 00000002538d0001 CR4: 
0000000000771ef0
[   63.842771] PKRU: 55555554
[   63.842773] Call Trace:
[   63.842776]  <TASK>
[   63.842781]  ? __warn+0x85/0x130
[   63.934362]  ? free_large_kmalloc+0x89/0xa0
[   63.934369]  ? report_bug+0xf8/0x1e0
[   63.934376]  ? handle_bug+0x50/0xa0
[   63.934381]  ? exc_invalid_op+0x13/0x60
[   63.934385]  ? asm_exc_invalid_op+0x16/0x20
[   63.934394]  ? free_large_kmalloc+0x89/0xa0
[   63.934398]  kfree+0x2a5/0x340
[   63.934403]  ? srso_alias_return_thunk+0x5/0xfbef5
[   63.934409]  ? nvmf_connect_admin_queue+0x105/0x1a0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   63.987625]  ? nvmf_connect_admin_queue+0xa1/0x1a0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   63.987632]  nvmf_connect_admin_queue+0x105/0x1a0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   63.987641]  nvme_tcp_start_queue+0x192/0x310 [nvme_tcp 
a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
[   63.987649]  nvme_tcp_setup_ctrl+0xf8/0x700 [nvme_tcp 
a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
[   63.987655]  ? nvme_change_ctrl_state+0x99/0x1b0 [nvme_core 
4c8074fe8bffb31437bcdb2c4a45c7e74861c83b]
[   64.043323]  nvme_tcp_create_ctrl+0x2e3/0x4d0 [nvme_tcp 
a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
[   64.043332]  nvmf_dev_write+0x323/0x3d0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   64.043338]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.043344]  vfs_write+0xd9/0x430
[   64.043349]  ? syscall_exit_to_user_mode+0xc/0x200
[   64.043355]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.043358]  ? do_syscall_64+0x81/0x160
[   64.043363]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.043367]  ksys_write+0x68/0xe0
[   64.043371]  do_syscall_64+0x74/0x160
[   64.108416]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.108422]  ? exc_page_fault+0x68/0x150
[   64.108428]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.108433] RIP: 0033:0x7f5f52f216f0
[   64.108438] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 80 3d 19 c3 0e 00 00 74 17 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[   64.108440] RSP: 002b:00007ffe45dc8bb8 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[   64.108443] RAX: ffffffffffffffda RBX: 00005608dbad8980 RCX: 
00007f5f52f216f0
[   64.108445] RDX: 00000000000000ed RSI: 00005608dbad8980 RDI: 
0000000000000003
[   64.108447] RBP: 0000000000000003 R08: 00000000000000ed R09: 
00005608dbad8980
[   64.108448] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000000ed
[   64.108450] R13: 00007f5f5307b008 R14: 00005608dbad1f50 R15: 
00005608dbad26d0
[   64.108456]  </TASK>
[   64.108458] ---[ end trace 0000000000000000 ]---
[   64.108461] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0x2 pfn:0x5e3a
[   64.108465] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   64.108469] raw: 000fffffc0000000 0000000000000000 fffb0b48c0178e90 
0000000000000000
[   64.108472] raw: 0000000000000002 0000000000000000 00000000ffffffff 
0000000000000000
[   64.108473] page dumped because: Not a kmalloc allocation
[   64.112317] nvme nvme1: creating 32 I/O queues.
[   66.074182] nvme nvme1: mapped 32/0/0 default/read/poll queues.
[   66.084156] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0x0 pfn:0x5de5
[   66.093770] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   66.101810] raw: 000fffffc0000000 0000000000000000 dead000000000122 
0000000000000000
[   66.111311] raw: 0000000000000000 0000000000000000 00000000ffffffff 
0000000000000000
[   66.111314] page dumped because: Not a kmalloc allocation
[   66.112001] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0xdc pfn:0x5de3
[   66.137452] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   66.137460] raw: 000fffffc0000000 ff45d9a24d93f420 ff45d9a24d93f420 
0000000000000000
[   66.137464] raw: 00000000000000dc 0000000000000000 00000000ffffffff 
0000000000000000
[   66.137466] page dumped because: Not a kmalloc allocation
[   66.138095] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0x0 pfn:0x5de5
[   66.180944] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   66.180950] raw: 000fffffc0000000 ff45d9a24da3f420 ff45d9a24da3f420 
0000000000000000
[   66.180953] raw: 0000000000000000 0000000000000000 00000000ffffffff 
0000000000000000
[   66.180954] page dumped because: Not a kmalloc allocation
[   66.181672] BUG: unable to handle page fault for address: 
ff40e4ea8fa50250
[   66.223318] #PF: supervisor read access in kernel mode
[   66.223320] #PF: error_code(0x0000) - not-present page
[   66.223322] PGD 0
[   66.223325] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   66.223330] CPU: 73 UID: 0 PID: 5216 Comm: nvme Kdump: loaded 
Tainted: G        W   E      6.14.0-rc4-default+ #308 
190df031934d7fa516e6fdc38148e19d2fe48841
[   66.223337] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[   66.223338] Hardware name: Lenovo ThinkSystem SR655V3/SB27B09914, 
BIOS KAE111E-2.10 04/11/2023
[   66.223340] RIP: 0010:kfree+0xea/0x340
[   66.223348] Code: b9 92 01 48 89 da 48 29 c2 48 81 fa ff ff 1f 00 77 
09 48 85 c0 0f 85 95 01 00 00 48 c7 c7 18 ba 01 00 49 8b 45 00 65 48 03 
07 <48> 8b 50 08 4c 39 60 10 0f 85 bb 01 00 00 41 8b 4d 28 48 8b 00 48
[   66.223350] RSP: 0018:ff824cf0c3307bf0 EFLAGS: 00010287
[   66.223353] RAX: ff40e4ea8fa50248 RBX: ff45d99f85de0400 RCX: 
0000000000000001
[   66.223355] RDX: ff45d99f85de0400 RSI: ffffffffc1b3028a RDI: 
000000000001ba18
[   66.223357] RBP: ff824cf0c3307c40 R08: 0000000000000001 R09: 
0000000000000008
[   66.223359] R10: ff824cf0c3307c58 R11: 0000000000000001 R12: 
fffb0b48c0177800
[   66.347600] R13: fffb0b48c024ce88 R14: 0000000000000004 R15: 
ffffffffc1b3028a
[   66.347604] FS:  00007f5f53015800(0000) GS:ff45d9a1cdb80000(0000) 
knlGS:0000000000000000
[   66.347607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   66.347609] CR2: ff40e4ea8fa50250 CR3: 00000002538d0001 CR4: 
0000000000771ef0
[   66.347611] PKRU: 55555554
[   66.347613] Call Trace:
[   66.347616]  <TASK>
[   66.347621]  ? __die_body+0x1a/0x60
[   66.347629]  ? page_fault_oops+0x132/0x4b0
[   66.347634]  ? search_module_extables+0x15/0x60
[   66.347640]  ? srso_alias_return_thunk+0x5/0xfbef5
[   66.347644]  ? search_bpf_extables+0x65/0x70
[   66.347649]  ? srso_alias_return_thunk+0x5/0xfbef5
[   66.347654]  ? exc_page_fault+0xb0/0x150
[   66.347660]  ? asm_exc_page_fault+0x22/0x30
[   66.347667]  ? nvmf_connect_io_queue+0xfa/0x1c0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   66.347676]  ? nvmf_connect_io_queue+0xfa/0x1c0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   66.460070]  ? kfree+0xea/0x340
[   66.460079]  ? srso_alias_return_thunk+0x5/0xfbef5
[   66.460086]  ? nvmf_connect_io_queue+0xfa/0x1c0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   66.460091]  nvmf_connect_io_queue+0xfa/0x1c0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   66.460102]  nvme_tcp_start_queue+0x166/0x310 [nvme_tcp 
a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
[   66.460111]  nvme_tcp_start_io_queues+0x32/0x80 [nvme_tcp 
a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
[   66.460117]  nvme_tcp_setup_ctrl+0x421/0x700 [nvme_tcp 
a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
[   66.525407]  nvme_tcp_create_ctrl+0x2e3/0x4d0 [nvme_tcp 
a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
[   66.525416]  nvmf_dev_write+0x323/0x3d0 [nvme_fabrics 
18bfa9223bf0bd1ec571f5f45774adcc919a867e]
[   66.525422]  ? srso_alias_return_thunk+0x5/0xfbef5
[   66.525429]  vfs_write+0xd9/0x430
[   66.525434]  ? syscall_exit_to_user_mode+0xc/0x200
[   66.525441]  ? srso_alias_return_thunk+0x5/0xfbef5
[   66.525443]  ? do_syscall_64+0x81/0x160
[   66.525449]  ? srso_alias_return_thunk+0x5/0xfbef5
[   66.525453]  ksys_write+0x68/0xe0
[   66.585510]  do_syscall_64+0x74/0x160
[   66.585516]  ? srso_alias_return_thunk+0x5/0xfbef5
[   66.585518]  ? exc_page_fault+0x68/0x150
[   66.585523]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.585528] RIP: 0033:0x7f5f52f216f0
[   66.585532] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 80 3d 19 c3 0e 00 00 74 17 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[   66.585534] RSP: 002b:00007ffe45dc8bb8 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[   66.585538] RAX: ffffffffffffffda RBX: 00005608dbad8980 RCX: 
00007f5f52f216f0
[   66.585540] RDX: 00000000000000ed RSI: 00005608dbad8980 RDI: 
0000000000000003
[   66.585541] RBP: 0000000000000003 R08: 00000000000000ed R09: 
00005608dbad8980
[   66.585543] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000000ed
[   66.585545] R13: 00007f5f5307b008 R14: 00005608dbad1f50 R15: 
00005608dbad26d0
[   66.585552]  </TASK>
[   66.691445] Modules linked in: tls(E) nvme_tcp(E) af_packet(E) 
iscsi_ibft(E) iscsi_boot_sysfs(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) 
fat(E) ipmi_ssif(E) amd_atl(E) intel_rapl_msr(E) xfs(E) 
intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) dax_hmem(E) 
cxl_acpi(E) tg3(E) cxl_port(E) kvm_amd(E) ipmi_si(E) cxl_core(E) i40e(E) 
i2c_piix4(E) ipmi_devintf(E) einj(E) kvm(E) acpi_cpufreq(E) wmi_bmof(E) 
libphy(E) libie(E) k10temp(E) i2c_smbus(E) ipmi_msghandler(E) 
i2c_designware_platform(E) joydev(E) i2c_designware_core(E) button(E) 
nvme_fabrics(E) nvme_keyring(E) fuse(E) efi_pstore(E) configfs(E) 
dmi_sysfs(E) ip_tables(E) x_tables(E) hid_generic(E) usbhid(E) ahci(E) 
libahci(E) ghash_clmulni_intel(E) libata(E) sha512_ssse3(E) 
sha256_ssse3(E) sd_mod(E) ast(E) sha1_ssse3(E) scsi_dh_emc(E) 
drm_client_lib(E) scsi_dh_rdac(E) i2c_algo_bit(E) aesni_intel(E) 
xhci_pci(E) scsi_dh_alua(E) drm_shmem_helper(E) crypto_simd(E) 
drm_kms_helper(E) cryptd(E) sg(E) nvme(E) xhci_hcd(E) nvme_core(E) 
scsi_mod(E) drm(E) nvme_auth(E) scsi_common(E)
[   66.691553]  usbcore(E) ccp(E) sp5100_tco(E) wmi(E) btrfs(E) 
blake2b_generic(E) xor(E) raid6_pq(E) efivarfs(E)
[   66.793438] CR2: ff40e4ea8fa50250

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
