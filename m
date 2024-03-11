Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67112B7D
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147288; cv=none; b=TxscXhS8GHbAei6V6D6v9GTHTzBBPqhHS+LiG1C4Ht25cvD5GNDiMi3yCk4cSivis91rzaFITcqyqj9XRWIBi9AwSwSGEHGSRAVXn2E2GTLBbjsetfDV3sbt84CRgdnJDxtYKp9nXsby4lOs/Xs448C/XGV1jkzWtuyKihKUJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147288; c=relaxed/simple;
	bh=EQ3vlK7Pepp3yG2b/Z/Clid0ZJHgfF01hBZ/S/YmP1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gVBrQRYsEEVvr0hdY+WJONUAXaAcBsVVHF87RZ+BmoXp+1MMZK4772fu49LeMDmjLhR3Q7lrZodjLWbCclTWjAJhhQIiRm9PkrEcsVd1JKgyEc5Lhcho+LdDnHNJRC8akmGnOVZHxsAZ41/umw7AxzPeIwQ1GzxdXI48cie13Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBYIlbTO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBYIlbTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C97DC433C7;
	Mon, 11 Mar 2024 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710147288;
	bh=EQ3vlK7Pepp3yG2b/Z/Clid0ZJHgfF01hBZ/S/YmP1w=;
	h=From:To:Cc:Subject:Date:From;
	b=eBYIlbTOujcITNHGMtOutArU2I7b9oh4PSzQe546ksk2s5ijyB2vN9vBwVGYAHi/a
	 Rv04yXMwnbLj26iCd81INE4ekRVMXpRWc7nFYAKXzNmyLhOGhuAq3Kfyn96TtwTM+G
	 E6XQHgIXnSGZnzkJuWOlC7OSEgeRHYRuq0zPRpIS6LOoMB1MaplJc0a0ss/1yGGKv2
	 TdsBNNTC/blQvjwBBS8Beb2ATJ8GMSLiYxiFDQivG2H9csJ28E79lvjtDXmYRn7mew
	 9/bMKd5wRXIAsUA5jsuNGFA26lQg1jQ+UmdlSTjD+NbjjgCUbLA+sPt2YF0TJWl8hk
	 EFRuwJRHDAU6A==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: hch@lst.de
Cc: linux-block@vger.kernel.org
Subject: [BUG REPORT] generic/482 fails on XFS on next-20240308 kernel
Date: Mon, 11 Mar 2024 14:20:31 +0530
Message-ID: <87il1tqhbg.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Executing generic/482 on a XFS filesystem on next-20240308 kernel generates
the following call trace,

[   58.151570] ------------[ cut here ]------------
[   58.155270] WARNING: CPU: 2 PID: 42 at drivers/md/dm-bio-prison-v1.c:128 dm_cell_key_has_valid_range+0x7c/0xa0 [dm_bio_prison]
[   58.163851] Modules linked in: xfs nvme_tcp nvme_fabrics nvme_core sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft sg virtio_net net_failover virtio_scsi failover ata_generic pata_acpi crct10dif_pclmul crc32_pclmul ata_piix ghash_clmulni_intel libata sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev serio_raw dm_multipath dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes dm_flakey loop ext4 mbcache jbd2 vfat fat btrfs blake2b_generic xor zstd_compress raid6_pq sunrpc dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi qemu_fw_cfg aesni_intel crypto_simd cryptd
[   58.219177] CPU: 2 PID: 42 Comm: kworker/u8:3 Not tainted 6.8.0-rc3+ #10
[   58.223368] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.6.6 08/22/2023
[   58.229658] Workqueue: dm-thin do_worker [dm_thin_pool]
[   58.234343] RIP: 0010:dm_cell_key_has_valid_range+0x7c/0xa0 [dm_bio_prison]
[   58.239549] Code: 48 81 fa 00 04 00 00 77 21 48 83 ed 01 48 c1 e8 0a 41 b8 01 00 00 00 48 c1 ed 0a 48 39 e8 75 19 44 89 c0 5b 5d e9 f4 1c 3a e5 <0f> 0b 45 31 c0 5b 5d 44 89 c0 e9 e5 1c 3a e5 0f 0b 45 31 c0 eb e0
[   58.251799] RSP: 0018:ffffc900002ffb10 EFLAGS: 00010202
[   58.256006] RAX: 0000000000000000 RBX: ffffc900002ffb78 RCX: 0000000000000007
[   58.261500] RDX: 0000000000000c80 RSI: 0000000000000080 RDI: ffffc900002ffb88
[   58.266809] RBP: 0000000000000c80 R08: 0000000000000001 R09: fffff5200005ff77
[   58.271203] R10: 0000000000000003 R11: 0000000000000008 R12: ffff8881144f9630
[   58.276361] R13: ffff8881144f9600 R14: ffff88814cfa3eb8 R15: ffffc900002ffb78
[   58.281945] FS:  0000000000000000(0000) GS:ffff8883e1300000(0000) knlGS:0000000000000000
[   58.288928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.293493] CR2: 00000000004f4548 CR3: 0000000113416000 CR4: 0000000000350ef0
[   58.300031] Call Trace:
[   58.302109]  <TASK>
[   58.328491]  process_discard_bio+0x1b2/0x440 [dm_thin_pool]
[   58.361890]  process_thin_deferred_bios+0x61c/0xbb0 [dm_thin_pool]
[   58.395890]  process_deferred_bios+0xf7/0x800 [dm_thin_pool]
[   58.402079]  do_worker+0x2a2/0x4e0 [dm_thin_pool]
[   58.412853]  process_one_work+0x576/0xcf0
[   58.418017]  worker_thread+0x88c/0x1420
[   58.436903]  kthread+0x2ad/0x380
[   58.445480]  ret_from_fork+0x34/0x70
[   58.454180]  ret_from_fork_asm+0x1b/0x30
[   58.458617]  </TASK>
[   58.461353] ---[ end trace 0000000000000000 ]---
[   58.465787] device-mapper: thin: Discard doesn't respect bio prison limits

Git bisect revealed the following to be the bad commit,

commit 8e0ef412869430d114158fc3b9b1fb111e247bd3
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Feb 28 14:56:42 2024 -0800

    dm: use queue_limits_set
    
    Use queue_limits_set which validates the limits and takes care of
    updating the readahead settings instead of directly assigning them to
    the queue.  For that make sure all limits are actually updated before
    the assignment.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Mike Snitzer <snitzer@kernel.org>
    Link: https://lore.kernel.org/r/20240228225653.947152-4-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

 block/blk-settings.c  |  2 +-
 drivers/md/dm-table.c | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 16 deletions(-)

-- 
Chandan
