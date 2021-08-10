Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95EBC4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 21:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF4F60F35
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 21:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhHJVb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:31:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35577 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhHJVbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 17:31:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210810213100euoutp023dd466c7bcb58e3087506b1959a69b58~aD1Ipw4M_2155521555euoutp02r
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 21:31:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210810213100euoutp023dd466c7bcb58e3087506b1959a69b58~aD1Ipw4M_2155521555euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628631060;
        bh=KEJHq+haGuApNglVmdsYy95fhD9wipGYOxNb9VVBbAY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RjKQot5PJM3U0WKufJcSD4GuIhzCaThlyucvJiY/b2cT3iq/+jaGGxRGcg0VCRyjc
         cUVnLH2V6S93ydNsRp8asHQW+1IvbBEPL8A1M18L8SKJLp9MlyONGSVZkDYA3i6pPN
         GowxJPX/aFO1Dpd+X5L4G1frRLix/X/3U5v5wvFQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210810213059eucas1p188ca268f821568bf3054f87e3572e991~aD1HeeOPJ2448924489eucas1p1i;
        Tue, 10 Aug 2021 21:30:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A9.0F.56448.310F2116; Tue, 10
        Aug 2021 22:30:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210810213058eucas1p109323e3c3ecaa76d37d8cf63b6d8ecfd~aD1GU-qQM2449324493eucas1p1f;
        Tue, 10 Aug 2021 21:30:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210810213058eusmtrp1f307f23ea76099d5327b9cac180986ba~aD1GUW4aO0048500485eusmtrp1w;
        Tue, 10 Aug 2021 21:30:58 +0000 (GMT)
X-AuditID: cbfec7f5-d3bff7000002dc80-75-6112f0131d65
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2A.44.20981.210F2116; Tue, 10
        Aug 2021 22:30:58 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210810213057eusmtip14a90b7388e8aa141385b1535be0eeb84~aD1F3QdBr1192811928eusmtip1S;
        Tue, 10 Aug 2021 21:30:57 +0000 (GMT)
Subject: Re: [PATCH 4/8] block: support delayed holder registration
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <df80819c-1246-a5e7-15a0-b9efa9f563b5@samsung.com>
Date:   Tue, 10 Aug 2021 23:30:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804094147.459763-5-hch@lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7rCH4QSDRoey1usvtvPZrFxxnpW
        i73vZrNarFx9lMli7y1ti7aNXxkd2Dwuny312H2zgc3j/b6rbB59W1YxenzeJBfAGsVlk5Ka
        k1mWWqRvl8CVsa79DXPBsZCKC4s/MTcw9rp3MXJySAiYSNz8eZ61i5GLQ0hgBaPEm951zBDO
        F0aJxxOWQjmfGSUaZq1kgWnpndkKlVjOKDFh/mFGCOcjo0T39OfsIFXCAs4Si590AiU4OEQE
        UiV2rQ0HCTML5Eg8WL+SDcRmEzCU6HrbBWbzCthJbHv2EqyVRUBV4mvnG0YQW1QgWeLO6fdQ
        NYISJ2c+ATuCE6h3/bOlrBAz5SWat85mhrDFJW49mc8Eco+EwBkOiZ+/NrJDXO0i0fSrH+oD
        YYlXx7dAxWUkTk/uYYFoaGaUeHhuLTuE08MocblpBiNElbXEnXO/2EC+YRbQlFi/Sx/ElBBw
        lHg21QrC5JO48VYQ4gY+iUnbpjNDhHklOtqEIGaoScw6vg5u68ELl5gnMCrNQvLZLCTfzELy
        zSyEtQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJp3T/45/3cG44tVHvUOMTByM
        hxglOJiVRHh3ygklCvGmJFZWpRblxxeV5qQWH2KU5mBREufdtXVNvJBAemJJanZqakFqEUyW
        iYNTqoHJ6fgKvUS3qg98t8obW0WbvI2OL39w5uq/ZneJVjYj3TmT/lvmfN765N6aA//mJUyf
        9lH11+K5zYKnDNTkJzNOe6MYFtWr2HVPh/vm1c1b5V2O2bZG3zRXbN+4Z/PJVjXdRU6Butvj
        xTJ5rRcbMtVMmm6wfF1Cn4KI0jyFwF9RyfP3Jnj4v723MGqeiWfV3Pr1/yOuxdhbrLnJcl9b
        cucTy4s8c4/M2+m+abLsSv0AzUOMnnWKfUcOvVNWvvLkcPGORYwPm8+kFMTkV2yf6X0jb2Jc
        jn2u/cldv38x7VD/lHKSIXlFeq1IpPcltvwiH9b1Xnm2S46p8vyMZesP1p7EWHB31eVQx1nz
        zC1bGK4osRRnJBpqMRcVJwIAeEZvWakDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xu7pCH4QSDb52ClmsvtvPZrFxxnpW
        i73vZrNarFx9lMli7y1ti7aNXxkd2Dwuny312H2zgc3j/b6rbB59W1YxenzeJBfAGqVnU5Rf
        WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsa79DXPBsZCK
        C4s/MTcw9rp3MXJySAiYSPTObGXuYuTiEBJYyijxcHoXO0RCRuLktAZWCFtY4s+1LjaIoveM
        EiebpoIVCQs4Syx+0skIYosIpEosvDeBCcRmFsiRWPxuDVhcSCBc4sPHG2wgNpuAoUTX2y4w
        m1fATmLbs5dgc1gEVCW+dr4BqxcVSJbo+zKBEaJGUOLkzCcsIDYnUO/6Z0tZIeabSczb/JAZ
        wpaXaN46G8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzEC42zbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd6dckKJQrwpiZVVqUX58UWlOanFhxhN
        gf6ZyCwlmpwPjPS8knhDMwNTQxMzSwNTSzNjJXFekyNr4oUE0hNLUrNTUwtSi2D6mDg4pRqY
        xPWdJqhFOMybu5+JYVOeb5LkzcgNLrHTDblq3KzPnDj8aWmZs3xosqBC/GWxuwW7crNWaJ9o
        bmtTfuj0heOjn4YI67nla7ZaHBd3cdKQ5Hp7K+TCxcLvccKZbQbzWW2Yd054H7izp+/Ry0le
        5i/WCht8WjJ5kvhzBQvbhsexyh8m3Tqy/v/308vZfSyPOFS2hfmttTLWe/j7HJvSJIYTkQFB
        nB/5ti54qPRvnfBNr2nb1SxqfI99vLZANnrWt/6Izf2npx48XWe7etPBz7e3cUyfEdbCx7qs
        aUvoH332NM/6wFQJe4/fG71f17MusPyxlfFeckqg6MJOz9cBp35J8OkIHDfzkni383GDLnu8
        EktxRqKhFnNRcSIAfy8RezwDAAA=
X-CMS-MailID: 20210810213058eucas1p109323e3c3ecaa76d37d8cf63b6d8ecfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210810213058eucas1p109323e3c3ecaa76d37d8cf63b6d8ecfd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210810213058eucas1p109323e3c3ecaa76d37d8cf63b6d8ecfd
References: <20210804094147.459763-1-hch@lst.de>
        <20210804094147.459763-5-hch@lst.de>
        <CGME20210810213058eucas1p109323e3c3ecaa76d37d8cf63b6d8ecfd@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 04.08.2021 11:41, Christoph Hellwig wrote:
> device mapper needs to register holders before it is ready to do I/O.
> Currently it does so by registering the disk early, which can leave
> the disk and queue in a weird half state where the queue is registered
> with the disk, except for sysfs and the elevator.  And this state has
> been a bit promlematic before, and will get more so when sorting out
> the responsibilities between the queue and the disk.
>
> Support registering holders on an initialized but not registered disk
> instead by delaying the sysfs registration until the disk is registered.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>

This patch landed in today's linux-next (20210810) as commit 
d62633873590 ("block: support delayed holder registration"). It triggers 
a following lockdep warning on ARM64's virt 'machine' on QEmu:

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc4+ #10642 Not tainted
------------------------------------------------------
systemd-udevd/227 is trying to acquire lock:
ffffb6b41952d628 (mtd_table_mutex){+.+.}-{3:3}, at: blktrans_open+0x40/0x250

but task is already holding lock:
ffff0eacc403bb18 (&disk->open_mutex){+.+.}-{3:3}, at: 
blkdev_get_by_dev+0x110/0x2f8

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&disk->open_mutex){+.+.}-{3:3}:
        __mutex_lock+0xa4/0x978
        mutex_lock_nested+0x54/0x60
        bd_register_pending_holders+0x2c/0x118
        __device_add_disk+0x1d8/0x368
        device_add_disk+0x10/0x18
        add_mtd_blktrans_dev+0x2dc/0x428
        mtdblock_add_mtd+0x68/0x98
        blktrans_notify_add+0x44/0x70
        add_mtd_device+0x430/0x4a0
        mtd_device_parse_register+0x1a4/0x2b0
        physmap_flash_probe+0x44c/0x780
        platform_probe+0x90/0xd8
        really_probe+0x138/0x2d0
        __driver_probe_device+0x78/0xd8
        driver_probe_device+0x40/0x110
        __driver_attach+0xcc/0x118
        bus_for_each_dev+0x68/0xc8
        driver_attach+0x20/0x28
        bus_add_driver+0x168/0x1f8
        driver_register+0x60/0x110
        __platform_driver_register+0x24/0x30
        physmap_init+0x18/0x20
        do_one_initcall+0x84/0x450
        kernel_init_freeable+0x31c/0x38c
        kernel_init+0x20/0x120
        ret_from_fork+0x10/0x18

-> #0 (mtd_table_mutex){+.+.}-{3:3}:
        __lock_acquire+0xff4/0x1840
        lock_acquire+0x130/0x3e8
        __mutex_lock+0xa4/0x978
        mutex_lock_nested+0x54/0x60
        blktrans_open+0x40/0x250
        blkdev_get_whole+0x28/0x120
        blkdev_get_by_dev+0x15c/0x2f8
        blkdev_open+0x50/0xb0
        do_dentry_open+0x238/0x3c0
        vfs_open+0x28/0x30
        path_openat+0x720/0x938
        do_filp_open+0x80/0x108
        do_sys_openat2+0x1b4/0x2c8
        do_sys_open+0x68/0x88
        __arm64_compat_sys_openat+0x1c/0x28
        invoke_syscall+0x40/0xf8
        el0_svc_common+0x60/0x100
        do_el0_svc_compat+0x1c/0x48
        el0_svc_compat+0x20/0x30
        el0t_32_sync_handler+0xec/0x140
        el0t_32_sync+0x168/0x16c

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&disk->open_mutex);
                                lock(mtd_table_mutex);
                                lock(&disk->open_mutex);
   lock(mtd_table_mutex);

  *** DEADLOCK ***

1 lock held by systemd-udevd/227:
  #0: ffff0eacc403bb18 (&disk->open_mutex){+.+.}-{3:3}, at: 
blkdev_get_by_dev+0x110/0x2f8

stack backtrace:
CPU: 1 PID: 227 Comm: systemd-udevd Not tainted 5.14.0-rc4+ #10642
Hardware name: linux,dummy-virt (DT)
Call trace:
  dump_backtrace+0x0/0x1d0
  show_stack+0x14/0x20
  dump_stack_lvl+0x88/0xb0
  dump_stack+0x14/0x2c
  print_circular_bug.isra.50+0x1ac/0x200
  check_noncircular+0x134/0x148
  __lock_acquire+0xff4/0x1840
  lock_acquire+0x130/0x3e8
  __mutex_lock+0xa4/0x978
  mutex_lock_nested+0x54/0x60
  blktrans_open+0x40/0x250
  blkdev_get_whole+0x28/0x120
  blkdev_get_by_dev+0x15c/0x2f8
  blkdev_open+0x50/0xb0
  do_dentry_open+0x238/0x3c0
  vfs_open+0x28/0x30
  path_openat+0x720/0x938
  do_filp_open+0x80/0x108
  do_sys_openat2+0x1b4/0x2c8
  do_sys_open+0x68/0x88
  __arm64_compat_sys_openat+0x1c/0x28
  invoke_syscall+0x40/0xf8
  el0_svc_common+0x60/0x100
  do_el0_svc_compat+0x1c/0x48
  el0_svc_compat+0x20/0x30
  el0t_32_sync_handler+0xec/0x140
  el0t_32_sync+0x168/0x16c

If this is a false positive, then it should be annotated as such.

> ---
>   block/genhd.c         | 10 +++++++
>   block/holder.c        | 68 ++++++++++++++++++++++++++++++++-----------
>   include/linux/genhd.h |  5 ++++
>   3 files changed, 66 insertions(+), 17 deletions(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index cd4eab744667..db916f779077 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -447,6 +447,16 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>   		kobject_create_and_add("holders", &ddev->kobj);
>   	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
>   
> +	/*
> +	 * XXX: this is a mess, can't wait for real error handling in add_disk.
> +	 * Make sure ->slave_dir is NULL if we failed some of the registration
> +	 * so that the cleanup in bd_unlink_disk_holder works properly.
> +	 */
> +	if (bd_register_pending_holders(disk) < 0) {
> +		kobject_put(disk->slave_dir);
> +		disk->slave_dir = NULL;
> +	}
> +
>   	if (disk->flags & GENHD_FL_HIDDEN)
>   		return;
>   
> diff --git a/block/holder.c b/block/holder.c
> index 11e65d99a9fb..4568cc4f6827 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -28,6 +28,19 @@ static void del_symlink(struct kobject *from, struct kobject *to)
>   	sysfs_remove_link(from, kobject_name(to));
>   }
>   
> +static int __link_disk_holder(struct block_device *bdev, struct gendisk *disk)
> +{
> +	int ret;
> +
> +	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
> +	if (ret)
> +		return ret;
> +	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> +	if (ret)
> +		del_symlink(disk->slave_dir, bdev_kobj(bdev));
> +	return ret;
> +}
> +
>   /**
>    * bd_link_disk_holder - create symlinks between holding disk and slave bdev
>    * @bdev: the claimed slave bdev
> @@ -66,7 +79,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	WARN_ON_ONCE(!bdev->bd_holder);
>   
>   	/* FIXME: remove the following once add_disk() handles errors */
> -	if (WARN_ON(!disk->slave_dir || !bdev->bd_holder_dir))
> +	if (WARN_ON(!bdev->bd_holder_dir))
>   		goto out_unlock;
>   
>   	holder = bd_find_holder_disk(bdev, disk);
> @@ -84,28 +97,28 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	INIT_LIST_HEAD(&holder->list);
>   	holder->bdev = bdev;
>   	holder->refcnt = 1;
> -
> -	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
> -	if (ret)
> -		goto out_free;
> -
> -	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> -	if (ret)
> -		goto out_del;
> +	if (disk->slave_dir) {
> +		ret = __link_disk_holder(bdev, disk);
> +		if (ret) {
> +			kfree(holder);
> +			goto out_unlock;
> +		}
> +	}
>   
>   	list_add(&holder->list, &disk->slave_bdevs);
> -	goto out_unlock;
> -
> -out_del:
> -	del_symlink(disk->slave_dir, bdev_kobj(bdev));
> -out_free:
> -	kfree(holder);
>   out_unlock:
>   	mutex_unlock(&disk->open_mutex);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(bd_link_disk_holder);
>   
> +static void __unlink_disk_holder(struct block_device *bdev,
> +		struct gendisk *disk)
> +{
> +	del_symlink(disk->slave_dir, bdev_kobj(bdev));
> +	del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> +}
> +
>   /**
>    * bd_unlink_disk_holder - destroy symlinks created by bd_link_disk_holder()
>    * @bdev: the calimed slave bdev
> @@ -123,11 +136,32 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	mutex_lock(&disk->open_mutex);
>   	holder = bd_find_holder_disk(bdev, disk);
>   	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
> -		del_symlink(disk->slave_dir, bdev_kobj(bdev));
> -		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> +		if (disk->slave_dir)
> +			__unlink_disk_holder(bdev, disk);
>   		list_del_init(&holder->list);
>   		kfree(holder);
>   	}
>   	mutex_unlock(&disk->open_mutex);
>   }
>   EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
> +
> +int bd_register_pending_holders(struct gendisk *disk)
> +{
> +	struct bd_holder_disk *holder;
> +	int ret;
> +
> +	mutex_lock(&disk->open_mutex);
> +	list_for_each_entry(holder, &disk->slave_bdevs, list) {
> +		ret = __link_disk_holder(holder->bdev, disk);
> +		if (ret)
> +			goto out_undo;
> +	}
> +	mutex_unlock(&disk->open_mutex);
> +	return 0;
> +
> +out_undo:
> +	list_for_each_entry_continue_reverse(holder, &disk->slave_bdevs, list)
> +		__unlink_disk_holder(holder->bdev, disk);
> +	mutex_unlock(&disk->open_mutex);
> +	return ret;
> +}
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 0721807d76ee..80952f038d79 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -323,6 +323,7 @@ long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
>   #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
>   int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
>   void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
> +int bd_register_pending_holders(struct gendisk *disk);
>   #else
>   static inline int bd_link_disk_holder(struct block_device *bdev,
>   				      struct gendisk *disk)
> @@ -333,6 +334,10 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
>   					 struct gendisk *disk)
>   {
>   }
> +static inline int bd_register_pending_holders(struct gendisk *disk)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
>   
>   dev_t part_devt(struct gendisk *disk, u8 partno);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

