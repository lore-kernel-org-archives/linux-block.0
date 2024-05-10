Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C53FB87
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345413; cv=none; b=drxna7A4jBQopahsPcD39539uA3kAGklNIFmhuZhlJ4Q3R6S8iA0cjKwe0pQg+9s7I1oWW9Xapre3BvpIbHwqSWdyaFLXhGZNUzbXbRWt+6Scm4SWHqie3MdUDryDOyz8I57iwBWl4l58zt5nuzpgre3xTT7nbhLdfQxB3PhyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345413; c=relaxed/simple;
	bh=ggrYuwlgCarwQnYRuL7tIa5X65L+zve3xC8tKGZwF7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=tTOrtAtfC2e4c3Mr0VdqjPcVxm6EVb83YZ4jBKZtBQD6bwxyrAhPeUmEediu+vwU7wQHlUIVrdb01xyr2HBdVHasl12q7NSdsrBwJtvFD9aUW+5cqLKZn9iBVyWthR8LB3P0h1KC6lWlOvSZ2V6dCs016h1NdwSZvZnIU3FKU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pR54pSJ/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pR54pSJ/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b27e960016so521563a91.1
        for <linux-block@vger.kernel.org>; Fri, 10 May 2024 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715345408; x=1715950208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yw3dJdRppyDYpM0rx8UkQ2xS97nkJirNCbbU1HCC0Gw=;
        b=pR54pSJ/LBoUu1PO3/BqilDPB+1YOop1JWIU5mztOFwd1LkXQk10fcIzFycG2ibytp
         3LMVgQ3D/w/8p1BlItA+FlXDp8YbG4lcgXuvNRtkPW9x0TC6ar1VDsfe1nOSSPm1Pg4R
         C5UWMWYa6qvSPITbgfJhZq16k6i3/E+MAoPfu5DVbJ1PsnckpGc13LHSRpq8JcSjzIDh
         BHr8RL4JubJvh8hlnTrtelfwJ8QbGFC2o2w/a0dz19I6JcYEhG58SZJK5w7lNLMlBtzA
         OGpVfyl2oeXVBeK2dylY0gZoz02sUNNVH79kRVPHVWQVvejs3u+oaXqd8N1o1TpwceD1
         KLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345408; x=1715950208;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yw3dJdRppyDYpM0rx8UkQ2xS97nkJirNCbbU1HCC0Gw=;
        b=QnIw6lw5rj6dmGx7WgEwfoc1SHeLIHVx2nu7ws2bkUHfDMppuDSTHpuuJ9Zp/YLT3x
         h0NxHgF3Xk6eR0fSmhwMVhr1LfkHazsdhsyre4b2eDLi1bAn5Im8YH86SHByBTJIg2Qm
         xNT6b7YEfKOdUXHAmeBk3JwJUWmdUHtwNBFPhmLENme0DWvVNo6Z4CYDt7iBc9Udvrhg
         JTVqXH8EQq0x2ICOcQ8zIRa93wR31012jz5GKlmYUyh+xoJKY1SoippyuyBmdT4ElpoL
         jLbdVJgVbsl4qVT0EYdhbbztpvUpHTh1X23IpUvYtEFcE5gZu3hcfRUhAp0L3liayIMU
         z+cw==
X-Forwarded-Encrypted: i=1; AJvYcCWjL/xbrf40qNBVhC7xGjqI2OG/L+ztdCPyE8YyMvIrIpSXqfMu8UumXaI8kTH20neGwHpfznDIIxA4tvbfEwSunt3aVgr2k9KmV6c=
X-Gm-Message-State: AOJu0YynhC5dhOZvuW2ODZubhw4bwhWjh/2umJDuTdCXlEDSFoTpLdFF
	PzYCLRp2u2in0AiqeG/zt879hDpWUzxEK3ODq7LzXEmvJcc1o3oJWe8KVtMTiX8E2eZmFm+sR/8
	P
X-Google-Smtp-Source: AGHT+IEy/TexzHzsa9weI3JCvgAYumDJCUi+Ly1LO3ON1doWdMkl3jyhLqzlbpwatr5lvNIMNQrrpw==
X-Received: by 2002:a17:902:da90:b0:1de:ddc6:27a6 with SMTP id d9443c01a7336-1ef43d1388fmr28460045ad.2.1715345408114;
        Fri, 10 May 2024 05:50:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d177asm31181415ad.23.2024.05.10.05.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 05:50:07 -0700 (PDT)
Message-ID: <bc01417a-be59-4686-af88-3eef2e0a955d@kernel.dk>
Date: Fri, 10 May 2024 06:50:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block nbd0: Unexpected reply (15) 000000009c07859b
To: Vincent Chen <vincent.chen@sifive.com>, linux-block@vger.kernel.org
References: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Bart


On 5/9/24 11:04 PM, Vincent Chen wrote:
> Hi,
> I occasionally encountered this NBD error on the Linux 6.9.0-rc7
> (commit hash: dd5a440a31fae) arm64 kernel when I executed the
> stress-ng HDD test on NBD. The failure rate is approximately 40% in my
> testing environment. Since this test case can consistently pass on
> Linux 6.2 kernel, I performed a bisect to find the problematic commit.
> Finally, I discovered that this NBD issue might be caused by this
> commit 65a558f66c30 ("block: Improve performance for BLK_MQ_F_BLOCKING
> drivers"). After reverting this commit, I didn't encounter any NBD
> issues when executing this test case. Unfortunately, I was unable to
> determine the root cause of the problem. I hope that experts in this
> area can help clarify this issue. I have posted the execution log and
> all relevant experimental information below for further analysis.
> 
>  ==== Execution log and error message ====
> # udhcpc
> udhcpc: started, v1.36.1
> udhcpc: broadcasting discover
> udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
> udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
> deleting routers
> adding dns 10.0.2.3
> # nbd-client 192.168.10.169 -N arm64-new-poky 10809 /dev/nbd0
> Negotiation: ..size = 385MB
> bs=512, sz=404463616 bytes
> # [  114.228171] nbd0: detected capacity change from 0 to 789968
> mount /dev/nbd0 /mnt && \
>> cd /mnt && \
>> mount -t proc /proc proc/ && \
>> mount --rbind /sys sys/ && \
>> mount --rbind /dev dev/ && \
>> cd - && \
>> chroot /mnt
> [  119.563027] EXT4-fs (nbd0): recovery complete
> [  119.566381] EXT4-fs (nbd0): mounted filesystem
> 153d936d-5294-4c41-8c7d-e0a6df246e30 r/w with ordered data mode. Quota
> mode: none.
> /
> # stress-ng --seq 0 -t 60 --pathological --verbose --times --tz
> --metrics --hdd 4
> stress-ng: debug: [230] invoked with 'stress-ng --seq 0 -t 60
> --pathological --verbose --times --tz --metrics --hdd 4' by user 0
> 'root'
> stress-ng: debug: [230] stress-ng 0.17.07 g519151f46073
> stress-ng: debug: [230] system: Linux buildroot 6.9.0-rc7 #20 SMP
> PREEMPT Fri May 10 11:40:17 CST 2024 aarch64, gcc 13.2.0, glibc 2.39,
> little endian
> stress-ng: debug: [230] RAM total: 1.9G, RAM free: 1.9G, swap free: 0.0
> stress-ng: debug: [230] temporary file path: '/', filesystem type:
> ext2 (158058 blocks available)
> stress-ng: debug: [230] 4 processors online, 4 processors configured
> stress-ng: info:  [230] setting to a 1 min, 0 secs run per stressor
> stress-ng: debug: [230] cache allocate: using defaults, cannot
> determine cache level details
> stress-ng: debug: [230] cache allocate: shared cache buffer size: 2048K
> stress-ng: info:  [230] dispatching hogs: 4 hdd
> stress-ng: debug: [230] starting stressors
> stress-ng: debug: [231] hdd: [231] started (instance 0 on CPU 3)
> stress-ng: debug: [232] hdd: [232] started (instance 1 on CPU 0)
> stress-ng: debug: [230] 4 stressors started
> stress-ng: debug: [233] hdd: [233] started (instance 2 on CPU 1)
> stress-ng: debug: [234] hdd: [234] started (instance 3 on CPU 2)
> stress-ng: debug: [233] hdd: [233] exited (instance 2 on CPU 3)
> stress-ng: debug: [232] hdd: [232] exited (instance 1 on CPU 2)
> [  196.497492] block nbd0: Unexpected reply (15) 000000009c07859b
> [  196.539765] block nbd0: Dead connection, failed to find a fallback
> [  196.540442] block nbd0: shutting down sockets
> [  196.540787] I/O error, dev nbd0, sector 594178 op 0x1:(WRITE) flags
> 0x4000 phys_seg 2 prio class 0
> [  196.540871] I/O error, dev nbd0, sector 591362 op 0x1:(WRITE) flags
> 0x4000 phys_seg 1 prio class 0
> [  196.541976] I/O error, dev nbd0, sector 594690 op 0x1:(WRITE) flags
> 0x4000 phys_seg 2 prio class 0
> [  196.542335] I/O error, dev nbd0, sector 591618 op 0x1:(WRITE) flags
> 0x4000 phys_seg 2 prio class 0
> [  196.542821] I/O error, dev nbd0, sector 594946 op 0x1:(WRITE) flags
> 0x4000 phys_seg 1 prio class 0
> [  196.544018] I/O error, dev nbd0, sector 594434 op 0x1:(WRITE) flags
> 0x4000 phys_seg 1 prio class 0
> [  196.544786] I/O error, dev nbd0, sector 591874 op 0x1:(WRITE) flags
> 0x4000 phys_seg 1 prio class 0
> [  196.545507] I/O error, dev nbd0, sector 592130 op 0x1:(WRITE) flags
> 0x4000 phys_seg 2 prio class 0
> [  196.546175] I/O error, dev nbd0, sector 592386 op 0x1:(WRITE) flags
> 0x4000 phys_seg 1 prio class 0
> [  196.546829] I/O error, dev nbd0, sector 592642 op 0x1:(WRITE) flags
> 0x4000 phys_seg 2 prio class 0
> [  196.570813] EXT4-fs warning (device nbd0): ext4_end_bio:343: I/O
> error 10 writing to inode 64522 starting block 317313)
> [  196.572501] Buffer I/O error on device nbd0, logical block 315393
> [  196.573011] Buffer I/O error on device nbd0, logical block 315394
> [  196.573478] Buffer I/O error on device nbd0, logical block 315395
> [  196.573949] Buffer I/O error on device nbd0, logical block 315396
> [  196.574475] Buffer I/O error on device nbd0, logical block 315397
> [  196.574974] Buffer I/O error on device nbd0, logical block 315398
> [  196.575420] Buffer I/O error on device nbd0, logical block 315399
> [  196.575411] EXT4-fs (nbd0): shut down requested (2)
> [  196.576081] EXT4-fs warning (device nbd0): ext4_end_bio:343: I/O
> error 10 writing to inode 64522 starting block 319361)
> [  196.576243] Buffer I/O error on device nbd0, logical block 315400
> [  196.577125] EXT4-fs warning (device nbd0): ext4_end_bio:343: I/O
> error 10 writing to inode 64522 starting block 296833)
> [  196.578172] Buffer I/O error on device nbd0, logical block 315401
> [  196.578713] Buffer I/O error on device nbd0, logical block 315402
> [  196.579861] EXT4-fs warning (device nbd0): ext4_end_bio:343: I/O
> error 10 writing to inode 64522 starting block 298881)
> [  196.582001] Aborting journal on device nbd0-8.
> [  196.582146] EXT4-fs (nbd0): ext4_do_writepages: jbd2_start:
> 9223372036854772702 pages, ino 64522; err -5
> [  196.582192] EXT4-fs (nbd0): ext4_do_writepages: jbd2_start:
> 9223372036854772768 pages, ino 64522; err -5
> [  196.582940] Buffer I/O error on dev nbd0, logical block 139265,
> lost sync page write
> [  196.584172] EXT4-fs warning (device nbd0): ext4_end_bio:343: I/O
> error 10 writing to inode 64522 starting block 385021)
> [  196.584626] JBD2: I/O error when updating journal superblock for nbd0-8.
> [  196.585291] EXT4-fs warning (device nbd0): ext4_end_bio:343: I/O
> error 10 writing to inode 64522 starting block 302849)
> stress-ng: fail:  [231] hdd: rmdir './tmp-stress-ng-hdd-231-0' failed,
> errno=5 (Input/output error)
> stress-ng: debug: [231] hdd: [231] exited (instance 0 on CPU 1)
> stress-ng: debug: [230] hdd: [231] terminated (success)
> stress-ng: debug: [230] hdd: removing temporary files in
> ./tmp-stress-ng-hdd-231-0
> stress-ng: debug: [230] hdd: [232] terminated (success)
> stress-ng: debug: [230] hdd: [233] terminated (success)
> stress-ng: fail:  [234] hdd: rmdir './tmp-stress-ng-hdd-234-3' failed,
> errno=5 (Input/output error)
> stress-ng: debug: [234] hdd: [234] exited (instance 3 on CPU 3)
> stress-ng: debug: [230] hdd: [234] terminated (success)
> stress-ng: debug: [230] hdd: removing temporary files in
> ./tmp-stress-ng-hdd-234-3
> stress-ng: metrc: [230] stressor       bogo ops real time  usr time
> sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> stress-ng: metrc: [230]                           (secs)    (secs)
> (secs)   (real time) (usr+sys time) instance (%)          (KB)
> stress-ng: metrc: [230] hdd               10839     61.51      2.14
>  94.28       176.20         112.41        39.19          2124
> stress-ng: metrc: [230] miscellaneous metrics:
> stress-ng: metrc: [230] hdd                    0.00 MB/sec read rate
> (harmonic mean of 4 instances)
> stress-ng: metrc: [230] hdd                    2.96 MB/sec write rate
> (harmonic mean of 4 instances)
> stress-ng: metrc: [230] hdd                    2.96 MB/sec read/write
> combined rate (harmonic mean of 4 instances)
> stress-ng: debug: [230] metrics-check: all stressor metrics validated and sane
> stress-ng: info:  [230] thermal zone temperatures not available
> stress-ng: info:  [230] for a 62.50s run time:
> stress-ng: info:  [230]     250.00s available CPU time
> stress-ng: info:  [230]       2.13s user time   (  0.85%)
> stress-ng: info:  [230]      94.32s system time ( 37.73%)
> stress-ng: info:  [230]      96.45s total time  ( 38.58%)
> stress-ng: info:  [230] load average: 3.75 1.12 0.39
> stress-ng: info:  [230] skipped: 0
> stress-ng: info:  [230] passed: 4: hdd (4)
> stress-ng: info:  [230] failed: 0
> stress-ng: info:  [230] metrics untrustworthy: 0
> stress-ng: info:  [230] successful run completed in 1 min, 2.50 secs
> Bus error
> #
> 
> ==== Kernel information ====
> The git tag of the testing kernel is 6.9-rc7 (commit hash: dd5a440a31fae).
> The configuration of this arm64 kernel is based on the arm64
> defconfig. I only change the CONFIG_BLK_DEV_NBD from m to y and
> specify a rootfs.cpio via CONFIG_INITRAMFS_SOURCE.
> 
> ==== Platform information ====
> The platform I used is the virt machine of ARM64 qemu (git tag: v9.0.0
> ). Below is the QEMU command.
> 
> $qemu_img \
>         -M virt -cpu max -m 2G \
>         -machine virtualization=true \
>         -kernel $IMAGE \
>         -netdev type=user,id=net0,hostfwd=tcp::7171-:22,hostfwd=tcp::7070-:23 \
>         -device e1000e,netdev=net0,mac=52:54:00:12:35:03,bus=pcie.0 \
>         -gdb tcp::1234 \
>         -nographic \
>         -device virtio-iommu-pci \
>         -smp 4
> 
> ==== Disk content information ====
> I used Yocto poky (commit 13078ea23ffea) to generate all the contents
> of the disk. I refer this website
> https://learn.arm.com/learning-paths/embedded-systems/yocto_qemu/yocto_build/
> to build it.
> 
> Because the default setting of poky does not include stress-ng, I made
> the following changes to include stress-ng.
> diff --git a/meta/recipes-extended/images/core-image-full-cmdline.bb
> b/meta/recipes-extended/images/core-image-full-cmdline.bb
> index b034cd0aeb..4b92dbfbb9 100644
> --- a/meta/recipes-extended/images/core-image-full-cmdline.bb
> +++ b/meta/recipes-extended/images/core-image-full-cmdline.bb
> @@ -7,6 +7,7 @@ IMAGE_INSTALL = "\
>      packagegroup-core-boot \
>      packagegroup-core-full-cmdline \
>      ${CORE_IMAGE_EXTRA_INSTALL} \
> +    stress-ng \
>      "
> 
> I also placed this disk image I used here
> https://github.com/VincentZWC/HDD_NBD_issue/blob/main/core-image-full-cmdline-qemuarm64.rootfs-20240510025944.ext4.
> 
> ==== stress-ng command ====
>  stress-ng --seq 0 -t 60 --pathological --verbose --times --tz --metrics --hdd 4
> 
> 
> 
> Please let me know if you need more information about this bug. Thanks.
> 
> Best regards,
> Vincent
> 

-- 
Jens Axboe

