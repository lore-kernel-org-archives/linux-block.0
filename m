Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:44159 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbdIHKmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2017 06:42:51 -0400
Received: by mail-wm0-f41.google.com with SMTP id 137so5101604wmj.1
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2017 03:42:50 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: prevent bd removal if busy
To: Rakesh Pandit <rakesh@tuxera.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170907135825.GA44302@dhcp-216.srv.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d5587325-11b0-a50f-c260-b20f344c0cfc@lightnvm.io>
Date: Fri, 8 Sep 2017 12:42:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170907135825.GA44302@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/07/2017 03:58 PM, Rakesh Pandit wrote:
> Removal of virtual block device by "nvm lnvm remove..." undergoing IO
> and created by "nvme lnvm create... -t pblk" results in following and
> is annoying.
> 
> 446416.309757] bdi-block not registered
> [446416.309773] ------------[ cut here ]------------
> [446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159 __mark_inode_dirty+0x268/0x340
> .....
> 
> This patch solves this by checking bd_openers for each partition
> before removal can continue.  Note that this isn't full proof as
> device can become busy as soon as it's bd_mutex is unlocked but it
> needn't be full proof either.  It does work for general case where
> device is mounted and removal can be prevented.
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>   drivers/lightnvm/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index bbea2c8..cff91c7 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -369,6 +369,10 @@ static void __nvm_remove_target(struct nvm_target *t)
>   static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
>   {
>   	struct nvm_target *t;
> +	struct gendisk *tdisk;
> +	struct disk_part_iter piter;
> +	struct hd_struct *part;
> +	int err;
>   
>   	mutex_lock(&dev->mlock);
>   	t = nvm_find_target(dev, remove->tgtname);
> @@ -376,10 +380,48 @@ static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
>   		mutex_unlock(&dev->mlock);
>   		return 1;
>   	}
> +
> +	/*
> +	 * Lets make sure device is not in use.  Note that this isn't full proof
> +	 * in anyway (as devices can become busy after unlock) but it is useful
> +	 * for preventing removal of devices which are open and undergoing IO.
> +	 */
> +	tdisk = t->disk;
> +	disk_part_iter_init(&piter, tdisk,
> +			DISK_PITER_INCL_EMPTY | DISK_PITER_INCL_PART0 |
> +			DISK_PITER_INCL_EMPTY_PART0);
> +	while ((part = disk_part_iter_next(&piter))) {

A race condition can occur where disk_part_next tries to pblk (in 
block/genhd.c), and it in the meantime has been set to NULL. Leading to 
a kernel crash. Is there a better way to do it?

[root@localhost ~]# nvme lnvm remove -n pblk0
[ 5262.338647] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000010
[ 5262.340769] IP: disk_part_iter_next+0xd3/0xf0
[ 5262.342312] PGD 233f65067 P4D 233f65067 PUD 22ef94067 PMD 0
[ 5262.344285] Oops: 0000 [#1] SMP
[ 5262.345216] Modules linked in:
[ 5262.346110] CPU: 0 PID: 459 Comm: nvme Not tainted 4.13.0+ #74
[ 5262.347770] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
[ 5262.351168] task: ffff9abbf1020f40 task.stack: ffffb3d841864000
[ 5262.352722] RIP: 0010:disk_part_iter_next+0xd3/0xf0
[ 5262.354024] RSP: 0018:ffffb3d841867dd8 EFLAGS: 00010246
[ 5262.355322] RAX: ffff9abbf42be000 RBX: ffff9abbf42be000 RCX: 
000000000000000e
[ 5262.356983] RDX: 000000000000000e RSI: ffff9abbf42be000 RDI: 
0000000000000000
[ 5262.359217] RBP: ffffb3d841867df0 R08: 0000000000000000 R09: 
0000000001513fe0
[ 5262.360972] R10: 00007fffc4b764a0 R11: ffff9abbf1020f40 R12: 
ffffb3d841867e08
[ 5262.362732] R13: ffff9abbf63b2800 R14: 0000000040244c23 R15: 
ffff9abbf3e2efc0
[ 5262.364540] FS:  00007f185e4bb700(0000) GS:ffff9abbffc00000(0000) 
knlGS:0000000000000000
[ 5262.366462] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5262.367711] CR2: 0000000000000010 CR3: 000000022efcc002 CR4: 
00000000003606f0
[ 5262.369742] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 5262.371784] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 5262.373618] Call Trace:
[ 5262.374163]  nvm_ctl_ioctl+0x344/0x590
[ 5262.375828]  ? kmem_cache_alloc+0x9b/0x1b0
[ 5262.376906]  do_vfs_ioctl+0x9f/0x5d0
[ 5262.378272]  ? putname+0x54/0x60
[ 5262.378817]  SyS_ioctl+0x79/0x90
[ 5262.379378]  entry_SYSCALL_64_fastpath+0x1e/0xa9
[ 5262.380309] RIP: 0033:0x7f185ddc7e47
[ 5262.381043] RSP: 002b:00007fffc4b766c8 EFLAGS: 00000202 ORIG_RAX: 
0000000000000010
[ 5262.382735] RAX: ffffffffffffffda RBX: 00007fffc4b76730 RCX: 
00007f185ddc7e47
[ 5262.383769] RDX: 00007fffc4b766d0 RSI: 0000000040244c23 RDI: 
0000000000000003
[ 5262.384203] RBP: 0000000001513fe0 R08: 0000000000000000 R09: 
0000000001513fe0
[ 5262.384640] R10: 00007fffc4b764a0 R11: 0000000000000202 R12: 
0000000001514050
[ 5262.385068] R13: 0000000000000003 R14: 00007fffc4b76d98 R15: 
0000000000000001
[ 5262.385491] Code: 54 24 10 75 c6 5b 31 c0 41 5c 41 5d 5d c3 48 8d 7b 
28 e8 41 32 1c 00 49 89 5c 24 08 45 01 6c 24 10 48 89 d8 5b 41 5c 41 5d 
5d c3 <8b> 77 10 41 bd 01 00 00 00 e9 72 ff ff ff 0f 1f 44 00 00 66 2e
[ 5262.386619] RIP: disk_part_iter_next+0xd3/0xf0 RSP: ffffb3d841867dd8
[ 5262.386997] CR2: 0000000000000010
[ 5262.387181] ---[ end trace 4815d3130f7418a9 ]---
Killed


> +		struct block_device *bdev;
> +
> +		bdev = bdget(part_devt(part));
> +		if (!bdev) {
> +			err = -ENOMEM;
> +			pr_err("nvm: removal failed, allocating bd failed\n");
> +			goto err_out;
> +		}
> +		mutex_lock(&bdev->bd_mutex);
> +		if (bdev->bd_openers) {
> +			mutex_unlock(&bdev->bd_mutex);
> +			bdput(bdev);
> +			err = -EBUSY;
> +			pr_err("nvm: removal failed, block device busy\n");
> +			goto err_out;
> +		}
> +		mutex_unlock(&bdev->bd_mutex);
> +		bdput(bdev);
> +	}
> +	disk_part_iter_exit(&piter);
> +
>   	__nvm_remove_target(t);
>   	mutex_unlock(&dev->mlock);
>   
>   	return 0;
> +err_out:
> +	disk_part_iter_exit(&piter);
> +	disk_put_part(part);
> +	mutex_unlock(&dev->mlock);
> +
> +	return err;
>   }
>   
>   static int nvm_register_map(struct nvm_dev *dev)
> 
