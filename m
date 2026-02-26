Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5D3A7F7C
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102272; cv=pass; b=na4zExDTPWB0n5n5KiEeszYvuCqL9ULRR9MS3OfO5vJ9wSbrspPY5p8WBttN16PUI7NGGN+TxOqL/Hgxd6JPsQFiub1Z4+/ZBLNrCOV5F6IR5d2dQjyB+YP9CzmP86c0p4g4a/UnsLHz1xNXicABd/EsY1kOfVrjcnuDoz+cZ9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102272; c=relaxed/simple;
	bh=t++P1E83jeAR5krWW041TQbj5fMJL88b0cp9l3NMYSM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gzRJJRL8U+N9r3L96j0aB68F/5QDENg8BA7EIPjPfUEOqYNosSgBqSlKUqmsQ/sPmqyNT7i2nmjPTq0pSFL1B9Nh0hIm5NHQJ3ZDXLmRQvW3joxAe9CLQJqzpgt6jJWg3d2R71uyZRWG/96cMFTrupuQNBlMiyibPuBtWbfu124=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8xztv8d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbn+o+1w; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8xztv8d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbn+o+1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772102269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/teMu1FRX6BN1ESjGI2ImXgdfpe6pXEDGwxpNartawo=;
	b=H8xztv8dtRUvzTOfdcowJ8PIlXeMvOITn9aXbqRDvFtyZ5+3Fwd0W0F+WL61jqPjHb6RdO
	xCw8aHhv/haGx5eBMbRKcwScaetC2CZHSSVu2HXZ39A3Sh+VfOrsRxQUbwhQxRR0wtP6LY
	pGMZfDaSzyZQk2gsm67Z+qEKSCcc+2M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Gcg_jB6-P9GxfRPUjPTatA-1; Thu, 26 Feb 2026 05:37:48 -0500
X-MC-Unique: Gcg_jB6-P9GxfRPUjPTatA-1
X-Mimecast-MFC-AGG-ID: Gcg_jB6-P9GxfRPUjPTatA_1772102267
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-389e6d4e857so3094651fa.3
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 02:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772102265; cv=none;
        d=google.com; s=arc-20240605;
        b=a23d0mVpXAUxKLvkjQkVj529FnFwo5QtG1eXDIl2uoA3Zxo5hjbS+FjLww8X4CL1Fp
         7w84dgyVQ9a2aODrjxG2X79BgZJx+B/nLSwhijXc5zCPPCM3xKNkbPzECimndekeOamz
         ++H9pb9HldtKirIrqOlY2kCrZIm01ZR7Zis6jALXWt+SC9B2Lcq82MdpC9YnTIw9Rhvj
         h408GWgJtT9NJfxAPJia13pHTjiRwVFKVcl+QthVEEKcE9mkldYvlqGEEzrikj+PpDCF
         EjULooWMaF+WS7jWBiy714iSw00JctWsXlXbOliMb6qBhYR/YT7dNI76Y7oZwWbPJI2j
         tqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=/teMu1FRX6BN1ESjGI2ImXgdfpe6pXEDGwxpNartawo=;
        fh=xt29vZHoE+Ybw0JCJXeP8KXJSEdyveVcydX6ABvzF4c=;
        b=lV0yKVoN0tBnnJp7Pj8Q7Kj1XJHBOuFy3YzoOxdO0n/juyz/eUJBtxIZmCM79AgSkX
         vXBwemjqxSnXuX8Y2maDKiRuNrm2qfNo9nm1oPZv0LT7EAu+/pY6drpIG21qCL1aangu
         JGr5WaVU2KhvAoZ8MVjbAw+tn/jOt++rOv3bskQw6SrW7mMsbYMEL35nzGLqcFJWczMK
         dZ09d3I+pCrtB5dJEL8+19H8WOx87bZDlGNqIfIqDRsnU8M5ObkHV5hv3DlFu17z4P/D
         4Z1JP55RinU8t3H9fqh8+Gm15vt3zpjdLlbUaQQrNwf3o2KMM9n/CB/w0eeDBup12/j5
         fUTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772102265; x=1772707065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/teMu1FRX6BN1ESjGI2ImXgdfpe6pXEDGwxpNartawo=;
        b=gbn+o+1wdd1dc0vY8NgIANdMC4rBVrjyTWY8UVvUPu5qFjsWIcYaAPMAtIAArptk/O
         MKufAZXQANd6bWRRI+sZ7TrlHtDhh0Ma4h5O93Hd5Rsho8tMfomSq0GIrTzew8Cph9QC
         FIoz0yeYotxUQ9Uc+DFfwunhMsCtqKoxaA4wGaOUPFkJNrj2NRG0teVxwehjK1qhyzcC
         psOrQGR/VSKVd1julggyRQVYetqipl52lEVN8UNMfcNllQxHlhtlE1KnHo+yPmuHOmjS
         vIKS9UyfgbDbraF0FzcNgDX4tt85ged9I7boC8YZvEgO/A7QUIV1oIWEkJpki+14m7+P
         eHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102265; x=1772707065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/teMu1FRX6BN1ESjGI2ImXgdfpe6pXEDGwxpNartawo=;
        b=IWC8hs3lDWhA4LRpo9k5DXPKb7eDdxpZkQ4u3rpL0Un/UeXYF3uldyG0lEqbpya2Uo
         B3PJj1DhSLwubyRpo9q2nlzoC/Io6xijPKe1jOrEIjFx/4XFngU3cBiTxXbpZd4URnZO
         ENgMYVa78uEqIY7DFSSiOqHmapAgjYtkTGqeJcJzDXwpriC/FU/sAWouZ5Rks57AfE9c
         IVT3uHjIOANVQpBDtCIvLtE+9fw0utGhP0GVHD1+HzGeahOjioc/FXTRFtG1RAVj5l0n
         khsluODWK44THevUo0lxh3keA60QYJEByVzBWWbUrd4ThI2jGn6k6B7IxW3T9Ovc3pIK
         ZRwg==
X-Gm-Message-State: AOJu0YzhBxXDGGGOFMixs5EiXS4x6fz/3peR6GpKeW0kQA38ERPMtCRg
	EehVEACBjBnNjLqb640E+kK9S7DiOv1kIAlEI4B/azAnl3peM8PYq8dmFnv7fLI3NyLrdZ1oQBZ
	HoOl8vUjqIvSOrONWPf1ILFtowHwWg5UL/7rPBp86hnQS3KBxl1MfFuUWa5x7lFtG6FmvzHODa/
	4jNWNYXk9vzInqpMz25pYnHn+mI6Qms37yGnvcYsY9Edve1rIBNh+xqes=
X-Gm-Gg: ATEYQzzpExNqM1pGMAVAapS7AfMPZSO89qL2yhayOJcicyflj3ialykXHcs8mVD/+ry
	gZFtBPqA5JCY8EYmefS2IL0DqtrlhQFuVOj7UV90gc9v4dFajr/LRf+NXwipiL8G0CqhMKyiejk
	djBrcio+O8LqBOjDqFAwd1FNcf1eieSlsXkGOJc51D5ABzRhhXYsY+C0/EjYP+9zW/chiE4mbiM
	qyWpQfXue0c36Ygdoz39BNrVm0ruR6PaatnDK2qlF3HVD56Tb9xarfb26TCgiFDUAHfg09HfuBE
	bjmgdw==
X-Received: by 2002:a2e:b8d2:0:b0:389:ecf8:16ae with SMTP id 38308e7fff4ca-389ecf81a18mr17968911fa.28.1772102265273;
        Thu, 26 Feb 2026 02:37:45 -0800 (PST)
X-Received: by 2002:a2e:b8d2:0:b0:389:ecf8:16ae with SMTP id
 38308e7fff4ca-389ecf81a18mr17968821fa.28.1772102264738; Thu, 26 Feb 2026
 02:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 26 Feb 2026 18:37:33 +0800
X-Gm-Features: AaiRm53ydmz2HpjzPebypekAHFOWhhs0TLAOpsrO3t4gEHT1yCrI8ryq5otye54
Message-ID: <CAGVVp+U0EYVX+VbbEHzcYP70zdmOXwAmUvpMYV9y3jBSRFmS6g@mail.gmail.com>
Subject: [bug report] Bug: Write fault blocked by KUAP!
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

on the ppc64le arch, I hit the issue below with ublksrv on the latest
linux-block/for-next, please help check it, and let me know if you
need any info/test for it. Thanks.

INFO: HEAD of cloned kernel
commit 37a43fd770f3dcac8f72f3ea909b3e893e2385c9
Merge: 13cd9b41227a c1dfbd7e71b0
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Feb 25 08:37:06 2026 -0700

    Merge branch 'for-7.1/block' into for-next

    * for-7.1/block:
      ublk: report BLK_SPLIT_INTERVAL_CAPABLE

reproducer:
compile and install https://github.com/ublk-org/ublksrv.git
#echo 0 > /proc/sys/kernel/io_uring_disabled
#modprobe ublk_drv
#cd ublksrv
#make test T=3Dnull
#make test T=3Dloop

dmesg log=EF=BC=9A
Feb 26 00:24:30 ibm-p9z-27-lp26 journal: running null/002
Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: start ublksrv io
daemon ublksrvd-0
Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57923: ublk dev
0 queue 0 started
Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57924: ublk dev
0 queue 1 started
Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083476.4882] platform-linux: do-add-ip6-address[2:
fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
is disabled on this device)
Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083476.4885] platform-linux: do-add-ip6-address[2:
2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
ipv6: IPv6 is disabled on this device)
Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083476.4938] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
rt-src ipv6ll
Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083478.4938] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no IPv6
link local address to retry after Duplicate Address Detection failures
(back off)
Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083478.4943] platform-linux: do-add-ip6-address[2:
2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
ipv6: IPv6 is disabled on this device)
Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083488.5034] platform-linux: do-add-ip6-address[2:
fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
is disabled on this device)
Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083488.5037] platform-linux: do-add-ip6-address[2:
2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
ipv6: IPv6 is disabled on this device)
Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083488.5041] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
rt-src ipv6ll
Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083490.5034] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no IPv6
link local address to retry after Duplicate Address Detection failures
(back off)
Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
[1772083490.5039] platform-linux: do-add-ip6-address[2:
2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
ipv6: IPv6 is disabled on this device)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read user
page (7fff81210000) - exploit attempt? (uid: 0)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]-----------=
-
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Bug: Read fault blocked by KUAP!
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: WARNING:
arch/powerpc/mm/fault.c:231 at bad_kernel_fault.isra.0+0xc8/0x2c0,
CPU#5: lt-ublk.null/57924
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Modules linked in: ublk_drv
ext4 crc16 mbcache jbd2 raid10 raid1 raid0 dm_raid raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq nf_tables rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs
lockd grace nfs_localio netfs bonding tls rfkill sg pseries_rng
vmx_crypto fuse loop vsock_loopback vmw_vsock_virtio_transport_common
vsock xfs sd_mod ibmvscsi ibmveth scsi_transport_srp sunrpc dm_mirror
dm_region_hash dm_log dm_multipath dm_mod nfnetlink [last unloaded:
nbd]
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: CPU: 5 UID: 0 PID: 57924 Comm:
lt-ublk.null Tainted: G        W           7.0.0-rc1+ #1 PREEMPT
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Tainted: [W]=3DWARN
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Hardware name: IBM,8375-42A
POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW940.00 (VL940_027)
hv:phyp pSeries
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP:  c00000000014d698 LR:
c00000000014d694 CTR: 0000000000000000
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: REGS: c000000004b12f10 TRAP:
0700   Tainted: G        W            (7.0.0-rc1+)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: MSR:  8000000000029033
<SF,EE,ME,IR,DR,RI,LE>  CR: 42002222  XER: 20040000
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: CFAR: c0000000002363e8
IRQMASK: 3 #012GPR00: c00000000014d694 c000000004b131b0
c000000001a48100 0000000000000020 #012GPR04: 00000000ffff7fff
c000000004b12fb0 c000000004b12fa8 00000001fba00000 #012GPR08:
0000000000000027 0000000000000001 c0000000065eff00 0000000000000000
#012GPR12: c00000000046d080 c000000017ffa300 0000000000000000
0000000000000000 #012GPR16: 0000000000000000 0000000000000000
0000000000000000 0000000000000000 #012GPR20: 0000000000000000
0000000000000000 0000000000000000 0000000000000000 #012GPR24:
0000000000000000 0000000000000000 0000000000000300 c00000005ec52a80
#012GPR28: 00007fff81210000 0000000000000000 00007fff81210000
c000000004b13370
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP [c00000000014d698]
bad_kernel_fault.isra.0+0xc8/0x2c0
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: LR [c00000000014d694]
bad_kernel_fault.isra.0+0xc4/0x2c0
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Call Trace:
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b131b0]
[c00000000014d694] bad_kernel_fault.isra.0+0xc4/0x2c0 (unreliable)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13230]
[c00000000014e1c8] ___do_page_fault+0x318/0xa80
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b132e0]
[c00000000014ea1c] hash__do_page_fault+0x2c/0xc0
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13310]
[c000000000159268] do_hash_fault+0x128/0x1d0
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13340]
[c000000000008be0] data_access_common_virt+0x210/0x220
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 300 at
__copy_tofrom_user_power7+0x3ec/0x7ac
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP:  c000000000176b60 LR:
c000000000abd620 CTR: 0000000000000020
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: REGS: c000000004b13370 TRAP:
0300   Tainted: G        W            (7.0.0-rc1+)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: MSR:  800000000280b033
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002420  XER: 20040000
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: CFAR: c000000000176b0c DAR:
00007fff81210000 DSISR: 00200000 IRQMASK: 0 #012GPR00:
000000000e000000 c000000004b13610 c000000001a48100 c000000151b50000
#012GPR04: 00007fff81210000 0000000000001000 0000000000000020
03ffffffeae4b000 #012GPR08: 0000000080000000 0000000000000010
0000000000000020 0000000000000030 #012GPR12: 0000000000000040
c000000017ffa300 0000000000000050 0000000000000060 #012GPR16:
0000000000000070 0000000000000000 0000000000000000 0000000000000000
#012GPR20: 0000000000000000 c0000000da0e5500 c000000015325f00
0000000000000000 #012GPR24: 0000000000000228 0000000000010000
0000000000000001 c000000151b50000 #012GPR28: c000000004b138d0
0000000000001000 c000000004b13850 0000000000001000
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP [c000000000176b60]
__copy_tofrom_user_power7+0x3ec/0x7ac
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: LR [c000000000abd620]
_copy_from_iter+0xf0/0x890
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 300
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13610]
[c0000000001769ec] __copy_tofrom_user_power7+0x278/0x7ac (unreliable)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13710]
[c000000000abd620] _copy_from_iter+0xf0/0x890
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b137d0]
[c008000011371b20] ublk_copy_user_bvec.isra.0+0x138/0x190 [ublk_drv]
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13820]
[c008000011371c64] ublk_copy_user_pages.isra.0+0xec/0x1d0 [ublk_drv]
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b138b0]
[c008000011374fec] __ublk_complete_rq+0x274/0x340 [ublk_drv]
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13920]
[c008000011379898] ublk_ch_uring_cmd_local+0x230/0x720 [ublk_drv]
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b139b0]
[c000000000a940ac] io_uring_cmd+0x1ac/0x260
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13a00]
[c000000000a77e5c] __io_issue_sqe+0x6c/0x230
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13a50]
[c000000000a7fb3c] io_issue_sqe+0x6c/0x3f0
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13ac0]
[c000000000a8058c] io_submit_sqes+0x15c/0x670
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13b50]
[c000000000a80cd8] __do_sys_io_uring_enter+0x238/0x4a0
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13c00]
[c000000000031f6c] system_call_exception+0x13c/0x320
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: [c000000004b13e50]
[c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 3000 at 0x7fff91463=
e14
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP:  00007fff91463e14 LR:
00007fff91463e14 CTR: 0000000000000000
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: REGS: c000000004b13e80 TRAP:
3000   Tainted: G        W            (7.0.0-rc1+)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: MSR:  800000000000d033
<SF,EE,PR,ME,IR,DR,RI,LE>  CR: 48002822  XER: 00000000
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: IRQMASK: 0 #012GPR00:
00000000000001aa 00007fff90aee310 00007fff91557000 0000000000000000
#012GPR04: 0000000000000020 0000000000000001 0000000000000019
00007fff90aee400 #012GPR08: 0000000000000018 0000000000000000
0000000000000000 0000000000000000 #012GPR12: 0000000000000000
00007fff90af68c0 0000000000000000 00007fff90aef1c0 #012GPR16:
0000000000000268 00007fff90aef8c0 0000000000000740 0000000000000004
#012GPR20: 0000000000000000 00007fff91b80000 000000000080e9c0
00007fff902e0000 #012GPR24: 0000000000000001 0000000000000000
0000000000000000 00007fff90aee4d8 #012GPR28: ffffffffffffff90
0000000000000000 00007fff90aee418 00007fff8c0039a8
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: NIP [00007fff91463e14] 0x7fff91463e=
14
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: LR [00007fff91463e14] 0x7fff91463e1=
4
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---- interrupt: 3000
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Code: 40820130 e87f0100
481279a9 60000000 2c230000 41820114 3c82ffd7 38847e30 3c62ffd7
38637ec8 480e8c39 60000000 <0fe00000> e8010090 ebe10078 7c0803a6
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ---[ end trace 0000000000000000 ]--=
-
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read user
page (7fff81210280) - exploit attempt? (uid: 0)
Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]-----------=
-

Best Regards,
Changhui

