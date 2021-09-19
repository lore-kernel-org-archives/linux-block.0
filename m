Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC59DC433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73CB6101C
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 13:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhISNjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:39:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55174 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhISNjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Sep 2021 09:39:08 -0400
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18JDbYo5078668;
        Sun, 19 Sep 2021 22:37:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 19 Sep 2021 22:37:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18JDbYEr078665
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Sep 2021 22:37:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [syzbot] KASAN: use-after-free Read in bdev_free_inode
To:     syzbot <syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000004a5adf05cc593ca9@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp>
Date:   Sun, 19 Sep 2021 22:37:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0000000000004a5adf05cc593ca9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This seems to be kfree() before RCU grace period.

struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
{
	struct block_device *bdev;
	struct inode *inode;

	inode = new_inode(blockdev_superblock);
	if (!inode)
		return NULL;
	inode->i_mode = S_IFBLK;
	inode->i_rdev = 0;
	inode->i_data.a_ops = &def_blk_aops;
	mapping_set_gfp_mask(&inode->i_data, GFP_USER);

	bdev = I_BDEV(inode);
	mutex_init(&bdev->bd_fsfreeze_mutex);
	spin_lock_init(&bdev->bd_size_lock);
	bdev->bd_disk = disk; // <= Assigns pointer to "disk".
	bdev->bd_partno = partno;
	bdev->bd_inode = inode;
	bdev->bd_stats = alloc_percpu(struct disk_stats);
	if (!bdev->bd_stats) {
		iput(inode); // <= Will call bdev_free_inode() via i_callback() after RCU from destroy_inode() from evict() from iput_final() from iput().
		return NULL;
	}
	return bdev;
}

struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
		struct lock_class_key *lkclass)
{
	struct gendisk *disk;

	if (!blk_get_queue(q))
		return NULL;

	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
	if (!disk)
		goto out_put_queue;

	disk->bdi = bdi_alloc(node_id);
	if (!disk->bdi)
		goto out_free_disk;

	disk->part0 = bdev_alloc(disk, 0);
	if (!disk->part0)
		goto out_free_bdi;

	disk->node_id = node_id;
	mutex_init(&disk->open_mutex);
	xa_init(&disk->part_tbl);
	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
		goto out_destroy_part_tbl;

	rand_initialize_disk(disk);
	disk_to_dev(disk)->class = &block_class;
	disk_to_dev(disk)->type = &disk_type;
	device_initialize(disk_to_dev(disk));
	inc_diskseq(disk);
	disk->queue = q;
	q->disk = disk;
	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
	INIT_LIST_HEAD(&disk->slave_bdevs);
#endif
	return disk;

out_destroy_part_tbl:
	xa_destroy(&disk->part_tbl);
	iput(disk->part0->bd_inode); // <= The same race problem exists?
out_free_bdi:
	bdi_put(disk->bdi);
out_free_disk:
	kfree(disk); // <= Releasing "disk" despite "disk->part0->bd_disk == disk" when bdev_free_inode() will dereference ->bd_disk after RCU.
out_put_queue:
	blk_put_queue(q);
	return NULL;
}

