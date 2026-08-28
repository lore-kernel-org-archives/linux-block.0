Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204483AEF43
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893016; cv=none; b=fd2ak6vpBAmRLvJ4SQuFRaHPgxhniMonQRHUIAmMkUSF9qj0gS9mPwDvgX28AQUIqFQ8VQfYm2HP2r7r9R6nI6Ge9ap/gGXZC2wMkFlsdkTxVUBCj1lkaaq6sqeLdF3dBZA5yQ9vhBFyJNkKhGZfgijEBILoUohFfDvwGvnopYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893016; c=relaxed/simple;
	bh=77wrUWwNZTmgFB8/L0BIsaNPPrH2bZi7tGTp6vlHBvI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rLyTKSm+jiNrjf7ChyGrSDPgcbOI0TVsEIdHmYpFX3lDUWZA4iChoF4qWDuvrfwjIeyOH6cLRD2T0qKW1D25erDFWzO04lo9gkJ/BTgRiSiEAaR7dRJJ78iDRtZBHNkAd+bdQ/RcqCjzfpBS9orEKP96MQOqkSYeifYEx3abjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewR53Spm; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewR53Spm"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so430795a12.3
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787893014; x=1788497814; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lid+8x57/u4+O0NBSStfeDrDE5jCqjkQVo9yG43Fj8=;
        b=ewR53SpmiFehi5xtnzOFAMbsGzT6FS3DbtqxLCqU1IkI8JP/jp4sdxhJ4k04NSedw3
         DtKFdSz3c+ljzvhu2z4VbDMXF85Ip8pYvw3ctQLMS+8nUGxF+AUsXkU6NoVluBOEGnQ4
         1VpPUNyP2Re6GH8zggB/50qlY3n5Tos88HYHncPyfXrK20r58F3CSxfhmqeZrkX0sTgZ
         T+9VFQYMiplRdgy8WLimlRZCDOe17/Sx/JWGsyno2RoIyUPoceVGkHUZJQ0UI04w+sXR
         XwitVC2QbIPILaBlZZDYhuE7dW7FSV0Iejt9rpJ/dWifuyBdN0cN5pEWJg60nyZXe0O1
         d+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787893014; x=1788497814;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+lid+8x57/u4+O0NBSStfeDrDE5jCqjkQVo9yG43Fj8=;
        b=Jclzy+StceA1Es185g9zDvXcHmAap5nEqAXnCQ37VPz5BthAyaoZ9aGvGH3KbARcz4
         8UuaK0r44r1/Xy6ackpMS6JfbKlnQKed115I0RwJcotFMc4UCGvVVyP/jgcmkQaulhuD
         2ybwMPIw1AQXjne7cEEydX8V4pIJlqSIbWtZHix1EsLB/97+BszL8qNgSdBChPhF1FGN
         BqhOs+TnPzCGVc4SANo2w4Xyvi10yWt6UVQi5JrQQf0Bjm8nI7MTTkTTB7nz2Vls4KqR
         x569BpLdXcBZJB4crMp05PkWzY7V7aDSV/YnkhG1Nsc/MqFrFJPv1tNXN6I3QlJvEc1i
         tn3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpn/7alkktct8CdXup78R46ANamm5H6IE+lWm1vedjITM34jt9NtYPZV6QoFAm99+vxu55sKvVlQDksaA==@vger.kernel.org
X-Gm-Message-State: AFuF++nAM/kkpg7Lg7bkzd86bgy2wMPxLDb9xxon1uMXNhiwIZSKnbLk
	/uusvrwm7kOPsiF8aFLFtI71CluYAUJBBqxqPYSBxLnmwXhnLzuoy4wJ
X-Gm-Gg: AR+sD110HjZ2SwGsCbVpQgHY7KNvukqSDaW61JUzzZMktZH43M6gNUU2y4x87bKsU6/
	OoWRzvms7vTK6qDNJFSF79Aw8u8eGRW0az+GeYvQEOraTCn8o80ER3apzle8eb+HKAlssmuW0ii
	9UMgzVRsTo+Du1q8cUaJ4Gs1rWOHLHGuBYrvVlhsbBzH0ryAeeOL8C8w4187yej/I3LXoJMP4Pq
	1pDxAL+QNGMHh/RR+J5oJZ8XGxFBBaE2tTvc1CSbLqFGefN25c+i83CVhGH9zPEo5tGx7Qn4bdE
	av59cx6gQVyM8sI2c0Pz1G8yZSOWFb7ORSOYHwRVX/02CWvtThWO3U9zO6FDeKIWZ60H4o4W9r8
	+wTEB7+6xn92g0VlbuJy97e5t0x7y7bTcDqLU0vcZw4LsJhZZWEPuOHVyexj3I5njhzAtV/A/r1
	wKgxtMbsOO+1UH9vlOQ/a/iEszWl/Z4C32Lb0+wkpPASYEi2HQlFM41PI3SH1yFp3l/Bc/8X0XG
	L4cUh7fyLtxsIcxv/Xb3Vzhx4sjbowH0/8w4fUjyNKCywYDvfWRd+vtZpou8WLkfGuM
X-Received: by 2002:a17:90b:180e:b0:396:5c22:b1f1 with SMTP id 98e67ed59e1d1-396d0e26ca8mr6874731a91.8.1787893013979;
        Thu, 27 Aug 2026 21:56:53 -0700 (PDT)
Received: from [127.0.1.1] (ppp-124-121-113-94.revip2.asianet.co.th. [124.121.113.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d3fdf6sm2945568c88.6.2026.08.27.21.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 21:56:53 -0700 (PDT)
From: Mikael Etienne <mikael1022bzh@gmail.com>
To:
 iommu@lists.linux.dev, linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc: regressions@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Date: Fri, 28 Aug 2026 11:56:48 +0700
Message-ID: <178789300872.392066.15963676631650361573@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[Resend as plain text. The first attempt was rejected by all four lists for
containing an HTML part -- apologies to those in Cc who receive this twice.]

Hi,

Since Linux 7.0 I observe silent read corruption on SATA disks behind an AMD
600-series chipset AHCI controller. AHCI/libata, the block layer, the IOMMU and
PCIe AER report no error at all; only consumers that validate the returned bytes
(btrfs data checksums, fio --verify) notice. SMART stays PASSED throughout.

Hardware, up front because it may matter: AMD Ryzen 7 8700G, with the SATA
controller integrated in the chipset:

  0e:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD]
          600 Series Chipset SATA Controller [1022:43f6] (rev 01)

This is the same SoC as bug 219609, where dma-iommu was already identified as the
trigger for a different device class (NVMe). Details in section 6.

Two observations sharply constrain the failure:

1. Once corruption starts, rebooting with the same kernel and the same command
   line, WITHOUT rewriting the test file, makes the very same blocks verify
   correctly again. Continued reads can later trigger the failure again. I have
   therefore observed no persistent corruption of the test file contents; this
   behaves like transient read-path state.

2. Adding only "iommu=pt" to the command line (nothing else changed): no
   corruption observed over 40 consecutive verification passes, 10 TiB re-read
   in 17 h. In the default translated mode the same test failed after 768 GiB
   / 3 h 25 m.

Good/bad boundary: 6.18.16 and 6.19.x are clean, every 7.0.x and 7.1.x is
affected. Kernel is untainted (/proc/sys/kernel/tainted = 0), no out-of-tree or
DKMS modules loaded.

Important caveat, stated up front: all kernels tested so far are Fedora-packaged.
I have not confirmed this on vanilla upstream and I have not bisected. See "What
I can and cannot do" at the end.

#regzbot introduced: v6.19..v7.0


## 1. Test matrix

Test file: 256 GiB fio canary with crc32c verification, on btrfs, on the 12 TB
drive (WDC WD120EFGX-68CPHN0).

  7.1.10-200.fc44, translated (DMA-FQ):
      first verify failure after 768 GiB re-read / 3 h 25 m
      once in the failed state, a plain 4 GiB O_DIRECT read of the same file
      produced tens of thousands of further csum failures
      btrfs corruption_errs reached 20,858,094 in that session
      reboot -> counters back to 0, same file verifies clean again

  7.1.10-200.fc44, iommu=pt (identity):
      40 consecutive clean passes, 10 TiB re-read, 17 h
      btrfs corruption_errs = 0, zero kernel error lines

  Earlier, translated mode, other workloads on the 8 TB drive:
      read-only workload      9 h 30 m clean
      deduplication workload  failed at 3 h 17 m
      sequential write        failed at 6 h 35 m

I have not yet run enough boots to give a proper min/median/max distribution.
The 3 h 25 m figure above is a single, carefully instrumented data point.


## 2. Reproducer

fio 3.40, io_uring engine (libaio not tested yet).

Write the canary once:

  fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
      --ioengine=io_uring --direct=1 --iodepth=32 \
      --verify=crc32c --verify_interval=4096 --rw=write \
      --do_verify=0 --fsync_on_close=1

Then loop the verification until it fails:

  while :; do
      fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
          --ioengine=io_uring --direct=1 --iodepth=32 \
          --verify=crc32c --verify_interval=4096 --rw=write \
          --verify_only=1 --verify_fatal=1 || break
  done

The reboot-without-rewrite protocol: when it fails, reboot and re-run only the
verification loop above. The canary file is never rewritten. It verifies clean.


## 3. Corruption signature

The frequent mode is a 4096-byte page read back as all zeros. btrfs reports
"csum 0x8941f998", which is the CRC32C of a zero-filled 4 KiB block.

The interesting mode is a structured permutation. From one btrfs report, inode
6646:

  offset A   offset B   delta
  1314816    1355776    40960
  1318912    1351680    32768
  1323008    1347584    24576
  1327104    1343488    16384
  1331200    1339392     8192

Verified programmatically from the raw btrfs csum lines: the data read at offset
A is exactly what was expected at offset B, and vice versa. Five reciprocal
pairs, symmetric around the pivot at 1335296 -- a run of 11 consecutive 4 KiB
blocks in reverse order, the centre block mapping onto itself.

This pattern suggests incorrect DMA/scatterlist mapping or descriptor handling,
because the affected chunks form a structured permutation rather than random bit
corruption. It does not by itself identify the faulty layer.


## 4. Hardware and storage stack

  Gigabyte X870I AORUS PRO ICE, BIOS FB1c (2026-07-21)
  AMD Ryzen 7 8700G w/ Radeon 780M Graphics
  32 GB DDR5 non-ECC, single stick, JEDEC 4800 (EXPO/XMP off)

  0e:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD]
          600 Series Chipset SATA Controller [1022:43f6] (rev 01)

  ahci flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso
              sadm sds apst
  32 command slots, queue_depth 32, max_segment_size 65536, max_segments 168,
  max_sectors_kb 4096, scheduler bfq

  IOMMU: AMD-Vi, "Default domain type: Translated",
         "DMA domain TLB invalidation policy: lazy mode"
  Controller iommu_group type: DMA-FQ, becomes "identity" with iommu=pt

  Test drive: /dev/sdb1 -> /srv/12to
    btrfs, data single, metadata DUP, mounted rw,noatime,compress=zstd:3,
    space_cache=v2. Plain partition: no LVM, no dm-crypt, no mdraid.

  Drives that showed the symptom (three different drives, one taken new out of
  its box and affected within hours of first use):
    WDC WD120EFGX-68CPHN0, fw 85.00B85   (btrfs, quantified above)
    Seagate ST8000VN004-2M2101, fw SC60  (btrfs)
    WDC WD101EFBX-68B0AN0                (ext4)

  NVMe devices in the same machine have never shown the symptom.


## 5. What I ruled out

  - NCQ: queue_depth 32 -> 1, no change (304 vs 769 csum failures per 4 GiB read)
  - transfer size: max_sectors_kb 4096 -> 64, no change (388 vs 342)
  - both combined: no change
  - SATA link power management: already max_performance on the affected ports
  - PCIe ASPM: disabled on that link
  - PCIe AER: all correctable and non-fatal counters at 0
  - SATA link CRC (SMART attribute 199): 0 on every drive
  - temperature: 41-56 C
  - swiotlb=force does NOT help, which is consistent with the dma-iommu path
    still being used underneath
  - not btrfs-specific: at the same moment, ext4 on a second drive reported
    "bad header/extent: invalid magic - magic 0", and parted reported a corrupt
    GPT on it. Both drives read correctly again after a reboot.

btrfs is what first exposed the problem, through its data checksums. Filesystems
without user-data checksums may hand affected data to userspace without noticing,
although metadata validation or application-level checksums can still catch some
of it -- which is what happened with ext4 and parted above.


## 6. Possibly related

Bug 219609, "File corruptions on SSD in 1st M.2 socket of AsRock X600M-STX +
Ryzen 8700G". Christoph Hellwig writes there that "the problem only happens when
using the dma-iommu code (with or without swiotlb buffering for unaligned /
untrusted data)", and that iommu=pt or amd_iommu=off fix it.

Same SoC (Ryzen 8700G) as this machine, but a different device class (SATA/AHCI
here, NVMe there) and a different kernel window, so I am reporting separately and
cross-referencing rather than piling onto that bug.


## 7. What I can and cannot do

This is a production home server, not a test bench, so I want to be straight
about it:

  I CAN: run any specific test, boot parameter or debug patch you ask for, and
         report back with full instrumentation. I have a working reproducer and
         a drive I can dedicate to it.

  I CANNOT realistically: dedicate the machine to a multi-day v6.19..v7.0
         bisection. Classifying a kernel as "good" currently costs several hours
         and several TiB of reads, which makes ~13 bisection steps impractical
         for me. If someone can suggest a faster trigger, that changes.

I have not yet tested: vanilla upstream kernels, libaio instead of io_uring,
iommu.strict=1, or amd_iommu=off. I am happy to test any of these.

Available on request, immediately: full dmesg from a bad boot and from an
iommu=pt boot, kernel .config for good and bad, /proc/cmdline, uname -a,
/proc/sys/kernel/tainted, lspci -nnvv, lspci -t, IOMMU group and domain types,
queue/DMA sysfs attributes, SMART reports, AER counters, raw fio logs, the raw
btrfs csum lines, and the script that proved the A/B swaps.

Thanks,
Mikael Etienne
