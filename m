Return-Path: <linux-block-owner@vger.kernel.org>
Received: from complete.lackof.org ([198.49.126.79]:47501 "EHLO
        complete.lackof.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbdJTXAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2017 19:00:15 -0400
Date: Fri, 20 Oct 2017 16:54:20 -0600
From: dann frazier <dann.frazier@canonical.com>
To: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [bug report] regression bisected to "block: Make most
 scsi_req_init() calls implicit"
Message-ID: <20171020225420.utvoqmtwit2isalc@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

hey,
  I'm seeing a regression when executing 'dmraid -r -c' in an arm64
QEMU guest, which I've bisected to the following commit:

  ca18d6f7 "block: Make most scsi_req_init() calls implicit"

I haven't yet had time to try and debug it yet, but wanted to get
the report out there before the weekend. Here's the crash:

[  138.519885] usercopy: kernel memory overwrite attempt detected to           (null) (<null>) (6 bytes)
[  138.521562] kernel BUG at mm/usercopy.c:72!
[  138.522294] Internal error: Oops - BUG: 0 [#1] SMP
[  138.523105] Modules linked in: nls_utf8 isofs nls_iso8859_1 qemu_fw_cfg ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs zstd_decompress zstd_compress xxhash raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear aes_ce_blk aes_ce_cipher crc32_ce crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_net virtio_blk aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
[  138.531307] CPU: 62 PID: 2271 Comm: dmraid Not tainted 4.14.0-rc5+ #20
[  138.532512] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  138.533796] task: ffff8003cba2e900 task.stack: ffff0000110e8000
[  138.534887] PC is at __check_object_size+0x114/0x200
[  138.535800] LR is at __check_object_size+0x114/0x200
[  138.536711] pc : [<ffff0000082c0e5c>] lr : [<ffff0000082c0e5c>] pstate: 00400145
[  138.538073] sp : ffff0000110ebb00
[  138.538682] x29: ffff0000110ebb00 x28: 0000000000000000 
[  138.539658] x27: 0000ffffd88e1110 x26: ffff8003e8d3d800 
[  138.540633] x25: 000000000802001d x24: ffff8003e1131920 
[  138.541621] x23: 0000000000000006 x22: 0000000000000006 
[  138.542596] x21: 0000000000000000 x20: 0000000000000006 
[  138.543571] x19: 0000000000000000 x18: ffffffffffffffff 
[  138.544548] x17: 0000ffff83380ce0 x16: ffff0000082dd3b0 
[  138.545525] x15: ffff0000093c8c08 x14: 6c756e2820202020 
[  138.546511] x13: 202020202020206f x12: 7420646574636574 
[  138.547489] x11: ffff0000093c9658 x10: ffff0000086ae800 
[  138.548466] x9 : 7265766f2079726f x8 : 0000000000000017 
[  138.549445] x7 : 6c756e3c2820296c x6 : ffff8003eeb51c28 
[  138.550434] x5 : ffff8003eeb51c28 x4 : 0000000000000000 
[  138.551411] x3 : ffff8003eeb59ec8 x2 : d4a0cd0f45236000 
[  138.552388] x1 : 0000000000000000 x0 : 0000000000000059 
[  138.553364] Process dmraid (pid: 2271, stack limit = 0xffff0000110e8000)
[  138.554593] Call trace:
[  138.555043] Exception stack(0xffff0000110eb9c0 to 0xffff0000110ebb00)
[  138.556214] b9c0: 0000000000000059 0000000000000000 d4a0cd0f45236000 ffff8003eeb59ec8
[  138.557653] b9e0: 0000000000000000 ffff8003eeb51c28 ffff8003eeb51c28 6c756e3c2820296c
[  138.559082] ba00: 0000000000000017 7265766f2079726f ffff0000086ae800 ffff0000093c9658
[  138.560510] ba20: 7420646574636574 202020202020206f 6c756e2820202020 ffff0000093c8c08
[  138.561950] ba40: ffff0000082dd3b0 0000ffff83380ce0 ffffffffffffffff 0000000000000000
[  138.563379] ba60: 0000000000000006 0000000000000000 0000000000000006 0000000000000006
[  138.564805] ba80: ffff8003e1131920 000000000802001d ffff8003e8d3d800 0000ffffd88e1110
[  138.566238] baa0: 0000000000000000 ffff0000110ebb00 ffff0000082c0e5c ffff0000110ebb00
[  138.567666] bac0: ffff0000082c0e5c 0000000000400145 ffff000008e25a80 0000000000000000
[  138.569090] bae0: 0001000000000000 0000000000000006 ffff0000110ebb00 ffff0000082c0e5c
[  138.570523] [<ffff0000082c0e5c>] __check_object_size+0x114/0x200
[  138.571628] [<ffff0000084e71a8>] sg_io+0x120/0x438
[  138.572507] [<ffff0000084e7c0c>] scsi_cmd_ioctl+0x594/0x728
[  138.573531] [<ffff0000084e7df0>] scsi_cmd_blk_ioctl+0x50/0x60
[  138.574594] [<ffff000000b7e798>] virtblk_ioctl+0x60/0x80 [virtio_blk]
[  138.575769] [<ffff0000084d9144>] blkdev_ioctl+0x5e4/0xb50
[  138.576756] [<ffff00000830d810>] block_ioctl+0x50/0x68
[  138.577698] [<ffff0000082dcb34>] do_vfs_ioctl+0xc4/0x940
[  138.578671] [<ffff0000082dd43c>] SyS_ioctl+0x8c/0xa8
[  138.579581] Exception stack(0xffff0000110ebec0 to 0xffff0000110ec000)
[  138.580752] bec0: 0000000000000005 0000000000002285 0000ffffd88e10b8 0000000000000006
[  138.582199] bee0: 0000000000000000 0000000000000004 0000ffff83416648 0000000000000050
[  138.583623] bf00: 000000000000001d 0003ffffffffffff 0000000000000012 0000000000000011
[  138.585050] bf20: 0000ffff83409000 00000000000000ff 0000ffff8309dc70 0000000000000531
[  138.586490] bf40: 0000ffff8344a360 0000ffff83380ce0 00000000000000dc 0000ffff83478948
[  138.587918] bf60: 0000000000000004 0000000017ee7f90 0000000000000005 0000000017ede920
[  138.589346] bf80: 0000000017ee7f60 0000000000000003 0000ffff83416648 0000000017ee7f60
[  138.590785] bfa0: 0000ffffd88e1218 0000ffffd88e1090 0000ffff834166dc 0000ffffd88e1090
[  138.592215] bfc0: 0000ffff83380cec 0000000080000000 0000000000000005 000000000000001d
[  138.593649] bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  138.595091] [<ffff000008083a30>] el0_svc_naked+0x24/0x28
[  138.596071] Code: aa1403e5 aa1303e3 9119a0c0 97f9d96d (d4210000) 
[  138.597193] ---[ end trace b7eecd0b21001177 ]---

Here's the ioctl as reported by strace:

2277  openat(AT_FDCWD, "/dev/vdb", O_RDONLY) = 5
2277  ioctl(5, BLKSSZGET, [512])        = 0
2277  ioctl(5, SG_IO, {'S', SG_DXFER_FROM_DEV, cmd[6]=[12, 01, 80, 00, 04, 00], mx_sb_len=0, iovec_count=0, dxfer_len=4, timeout=6000, flags=0 <unfinished ...>) = ?

 $ qemu-system-aarch64 -enable-kvm -m 16384 \
   -cpu host -smp 4 -M virt,gic_version=host -nographic \
   -pflash flash0.img -pflash flash1.img \
   -drive if=none,file=artful-server-cloudimg-arm64.img,id=hd0 \
   -device virtio-blk-device,drive=hd0 -drive \
   -if=none,file=my-seed.img,id=hd1 \
   -device virtio-blk-device,drive=hd1 \
   -netdev type=tap,id=net0 -device virtio-net-device,netdev=net0,mac=<omitted>

 -dann
