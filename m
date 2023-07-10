Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD2EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 21:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGJVWa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGJVW3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 17:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469C106
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 14:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF4261207
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 21:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EAEC433C8;
        Mon, 10 Jul 2023 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689024143;
        bh=7B3tV+P7moNPASmCusHMN2mjIA2hwk/Xccwxrgwq77Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpztUN4aHc8XPb24sJU/t9+DK6V6lr4WhjypPqDc+cVDhKi2SMQEmoSSay5uEe5AT
         wvzEWDXzAFR0pVLeLXcSWacU8uHiCKC2jomgPsE2zAqAYiH5BQBmV9zs710SCbeK24
         IBKQzGZC8wEPGMsD1Kr4e2ta8RdOtZE/GuW3nYinINaD2Ti28Ln/bKofMX+q4cTDNT
         TL0n4nxv/D9Prbr32jYZcYOVxP2rK03htNCMzJIt5U3+ez5HThAmwUnKNe52oYNfxF
         0uqLd0zozOaAnngRI8ufhhgiOQSFeBK8PoiTEOOC2HiviYBUlmALXVO83e29igg7H1
         jVf6CglAMLeBA==
Date:   Mon, 10 Jul 2023 14:22:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
Message-ID: <ZKx2jVONy35B0/S1@google.com>
References: <20230707094028.107898-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094028.107898-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hit a kernel panic with single device.

[  148.003511] BUG: kernel NULL pointer dereference, address: 0000000000000058
[  148.005630] #PF: supervisor read access in kernel mode
[  148.008179] #PF: error_code(0x0000) - not-present page
[  148.010593] PGD 0 P4D 0
[  148.011867] Oops: 0000 [#1] PREEMPT SMP PTI
[  148.014619] CPU: 4 PID: 1905 Comm: umount Tainted: G           OE      6.5.0-rc1-custom #19
[  148.020358] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  148.024967] RIP: 0010:destroy_device_list+0x18/0x90 [f2fs]
[  148.027688] Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 49 89 fc 53 48 8b 87 40 0b 00 00 <48> 8b 78 58 e8 cf 3e 28 cf 41 83 bc 24 3c 0b 00 00 01 7e 4a 41 bd
[  148.038517] RSP: 0018:ffffa24e80be3d28 EFLAGS: 00010202
[  148.040978] RAX: 0000000000000000 RBX: ffff8bd5503bc800 RCX: 0000000080080006
[  148.044292] RDX: 0000000080080007 RSI: ffffdcfe844da200 RDI: ffff8bd55368d000
[  148.047688] RBP: ffffa24e80be3d40 R08: ffff8bd553688000 R09: 0000000080080006
[  148.051317] R10: ffff8bd5580d4e80 R11: ffff8bd57bd00000 R12: ffff8bd55368d000
[  148.054981] R13: 0000000000000000 R14: ffff8bd55368db18 R15: 0000000000000000
[  148.058391] FS:  00007fc247124800(0000) GS:ffff8bd57bd00000(0000) knlGS:0000000000000000
[  148.062549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  148.065641] CR2: 0000000000000058 CR3: 0000000001120004 CR4: 0000000000370ee0
[  148.069178] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  148.072651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  148.076346] Call Trace:
[  148.077641]  <TASK>
[  148.078839]  ? show_regs+0x6a/0x80
[  148.080475]  ? __die+0x25/0x70
[  148.082045]  ? page_fault_oops+0x160/0x480
[  148.084381]  ? check_preempt_wakeup+0x192/0x2f0
[  148.086840]  ? do_user_addr_fault+0x313/0x680
[  148.088999]  ? exc_page_fault+0x79/0x180
[  148.090899]  ? asm_exc_page_fault+0x27/0x30
[  148.093114]  ? destroy_device_list+0x18/0x90 [f2fs]
[  148.095448]  f2fs_put_super+0x211/0x410 [f2fs]
[  148.097871]  ? fscrypt_destroy_keyring+0x110/0x170
[  148.100313]  generic_shutdown_super+0x84/0x1b0
[  148.102582]  kill_block_super+0x24/0x50
[  148.104697]  kill_f2fs_super+0x83/0x100 [f2fs]
[  148.106974]  deactivate_locked_super+0x35/0xb0
[  148.109978]  deactivate_super+0x44/0x50
[  148.112235]  cleanup_mnt+0x105/0x160
[  148.114407]  __cleanup_mnt+0x12/0x20
[  148.116680]  task_work_run+0x61/0x90
[  148.118961]  exit_to_user_mode_prepare+0x18f/0x1a0
[  148.121812]  syscall_exit_to_user_mode+0x26/0x50
[  148.124595]  do_syscall_64+0x69/0x90
[  148.126616]  ? exc_page_fault+0x8a/0x180
[  148.128742]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  148.131521] RIP: 0033:0x7fc246f24a7b

On 07/07, Christoph Hellwig wrote:
> f2fs_scan_devices reopens the main device since the very beginning, which
> has always been useless, and also means that we don't pass the right
> holder for the reopen, which now leads to a warning as the core super.c
> holder ops aren't passed in for the reopen.
> 
> Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
> Fixes: 0718afd47f70 ("block: introduce holder ops")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/f2fs/super.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ca31163da00a55..8d11d4a5ec331d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1560,7 +1560,8 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>  {
>  	int i;
>  
> -	for (i = 0; i < sbi->s_ndevs; i++) {

#ifdef CONFIG_BLK_DEV_ZONED

> +	kvfree(FDEV(0).blkz_seq);

#endif

> +	for (i = 1; i < sbi->s_ndevs; i++) {
>  		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  		kvfree(FDEV(i).blkz_seq);
> @@ -4190,16 +4191,12 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  	sbi->aligned_blksize = true;
>  
>  	for (i = 0; i < max_devices; i++) {
> -
> -		if (i > 0 && !RDEV(i).path[0])
> +		if (i == 0)
> +			FDEV(0).bdev = sbi->sb->s_bdev;
> +		else if (!RDEV(i).path[0])
>  			break;
>  
> -		if (max_devices == 1) {
> -			/* Single zoned block device mount */
> -			FDEV(0).bdev =
> -				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
> -						  sbi->sb->s_type, NULL);
> -		} else {
> +		if (max_devices > 1) {
>  			/* Multi-device mount */
>  			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
>  			FDEV(i).total_segments =
> @@ -4215,10 +4212,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  				FDEV(i).end_blk = FDEV(i).start_blk +
>  					(FDEV(i).total_segments <<
>  					sbi->log_blocks_per_seg) - 1;
> +				FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
> +					mode, sbi->sb->s_type, NULL);
>  			}
> -			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
> -							  sbi->sb->s_type,
> -							  NULL);
>  		}
>  		if (IS_ERR(FDEV(i).bdev))
>  			return PTR_ERR(FDEV(i).bdev);
> -- 
> 2.39.2
