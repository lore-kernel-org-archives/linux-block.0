Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6A1A0BDB;
	Wed,  8 Jan 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326009; cv=none; b=GCgPZ+GbFYGMaSFCMFoAH5nvXPxLJbySdqkBxg1SzejgBG6maVB8/p8mbixbFolweTEHC5M0pAUMM1H21xEZx2QD3tUjesPzoLfsrD+EQnwI2ZuS/l3XBp/iJ7rXa1jzeqETQjg+nl585wbmoMjDyrybbE0ylKT+gzEOPTB5iO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326009; c=relaxed/simple;
	bh=IWThq/B3TU12ss1i2aAhLetZNggV4UeqE179Ichmk9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ersFaeKW4PMFN7l2jsYQO096D9x7m5ZzHOgr6C/gvdyis6zZSKAJf1ZysZir6tiPeRwzmAfLixi0ZJVclN+700/vn6pJ1GKqIdy946SEO7oGOH6eopBcsDES7m0a1NkcHNGGejyrB+WotOC3wRcfgEGKAHSCupUmWmzuH25AQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YShNM2VMnz4f3jqw;
	Wed,  8 Jan 2025 16:46:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5A2E21A167B;
	Wed,  8 Jan 2025 16:46:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXe19wO35n8n58AQ--.56867S4;
	Wed, 08 Jan 2025 16:46:42 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	yukuai3@huawei.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()
Date: Wed,  8 Jan 2025 16:41:48 +0800
Message-Id: <20250108084148.1549973-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe19wO35n8n58AQ--.56867S4
X-Coremail-Antispam: 1UD129KBjvJXoW3XF13Ar18JFyxXF13GFWfXwb_yoWfXw45p3
	90gFWUWr1jg345Wa1xJa17JFW8ZanxXr17GF4fKrW5ZFy2vw1xX3Wv93W5WayI9rWxCFy5
	Z3WkK34UXw18G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Our syzkaller report a following UAF for v6.6:

BUG: KASAN: slab-use-after-free in bfq_init_rq+0x175d/0x17a0 block/bfq-iosched.c:6958
Read of size 8 at addr ffff8881b57147d8 by task fsstress/232726

CPU: 2 PID: 232726 Comm: fsstress Not tainted 6.6.0-g3629d1885222 #39
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
 print_address_description.constprop.0+0x66/0x300 mm/kasan/report.c:364
 print_report+0x3e/0x70 mm/kasan/report.c:475
 kasan_report+0xb8/0xf0 mm/kasan/report.c:588
 hlist_add_head include/linux/list.h:1023 [inline]
 bfq_init_rq+0x175d/0x17a0 block/bfq-iosched.c:6958
 bfq_insert_request.isra.0+0xe8/0xa20 block/bfq-iosched.c:6271
 bfq_insert_requests+0x27f/0x390 block/bfq-iosched.c:6323
 blk_mq_insert_request+0x290/0x8f0 block/blk-mq.c:2660
 blk_mq_submit_bio+0x1021/0x15e0 block/blk-mq.c:3143
 __submit_bio+0xa0/0x6b0 block/blk-core.c:639
 __submit_bio_noacct_mq block/blk-core.c:718 [inline]
 submit_bio_noacct_nocheck+0x5b7/0x810 block/blk-core.c:747
 submit_bio_noacct+0xca0/0x1990 block/blk-core.c:847
 __ext4_read_bh fs/ext4/super.c:205 [inline]
 ext4_read_bh+0x15e/0x2e0 fs/ext4/super.c:230
 __read_extent_tree_block+0x304/0x6f0 fs/ext4/extents.c:567
 ext4_find_extent+0x479/0xd20 fs/ext4/extents.c:947
 ext4_ext_map_blocks+0x1a3/0x2680 fs/ext4/extents.c:4182
 ext4_map_blocks+0x929/0x15a0 fs/ext4/inode.c:660
 ext4_iomap_begin_report+0x298/0x480 fs/ext4/inode.c:3569
 iomap_iter+0x3dd/0x1010 fs/iomap/iter.c:91
 iomap_fiemap+0x1f4/0x360 fs/iomap/fiemap.c:80
 ext4_fiemap+0x181/0x210 fs/ext4/extents.c:5051
 ioctl_fiemap.isra.0+0x1b4/0x290 fs/ioctl.c:220
 do_vfs_ioctl+0x31c/0x11a0 fs/ioctl.c:811
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl+0xae/0x190 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

Allocated by task 232719:
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x87/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:768 [inline]
 slab_alloc_node mm/slub.c:3492 [inline]
 kmem_cache_alloc_node+0x1b8/0x6f0 mm/slub.c:3537
 bfq_get_queue+0x215/0x1f00 block/bfq-iosched.c:5869
 bfq_get_bfqq_handle_split+0x167/0x5f0 block/bfq-iosched.c:6776
 bfq_init_rq+0x13a4/0x17a0 block/bfq-iosched.c:6938
 bfq_insert_request.isra.0+0xe8/0xa20 block/bfq-iosched.c:6271
 bfq_insert_requests+0x27f/0x390 block/bfq-iosched.c:6323
 blk_mq_insert_request+0x290/0x8f0 block/blk-mq.c:2660
 blk_mq_submit_bio+0x1021/0x15e0 block/blk-mq.c:3143
 __submit_bio+0xa0/0x6b0 block/blk-core.c:639
 __submit_bio_noacct_mq block/blk-core.c:718 [inline]
 submit_bio_noacct_nocheck+0x5b7/0x810 block/blk-core.c:747
 submit_bio_noacct+0xca0/0x1990 block/blk-core.c:847
 __ext4_read_bh fs/ext4/super.c:205 [inline]
 ext4_read_bh_nowait+0x15a/0x240 fs/ext4/super.c:217
 ext4_read_bh_lock+0xac/0xd0 fs/ext4/super.c:242
 ext4_bread_batch+0x268/0x500 fs/ext4/inode.c:958
 __ext4_find_entry+0x448/0x10f0 fs/ext4/namei.c:1671
 ext4_lookup_entry fs/ext4/namei.c:1774 [inline]
 ext4_lookup.part.0+0x359/0x6f0 fs/ext4/namei.c:1842
 ext4_lookup+0x72/0x90 fs/ext4/namei.c:1839
 __lookup_slow+0x257/0x480 fs/namei.c:1696
 lookup_slow fs/namei.c:1713 [inline]
 walk_component+0x454/0x5c0 fs/namei.c:2004
 link_path_walk.part.0+0x773/0xda0 fs/namei.c:2331
 link_path_walk fs/namei.c:3826 [inline]
 path_openat+0x1b9/0x520 fs/namei.c:3826
 do_filp_open+0x1b7/0x400 fs/namei.c:3857
 do_sys_openat2+0x5dc/0x6e0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x148/0x200 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

Freed by task 232726:
 kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 __kasan_slab_free+0x12a/0x1b0 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1827 [inline]
 slab_free_freelist_hook mm/slub.c:1853 [inline]
 slab_free mm/slub.c:3820 [inline]
 kmem_cache_free+0x110/0x760 mm/slub.c:3842
 bfq_put_queue+0x6a7/0xfb0 block/bfq-iosched.c:5428
 bfq_forget_entity block/bfq-wf2q.c:634 [inline]
 bfq_put_idle_entity+0x142/0x240 block/bfq-wf2q.c:645
 bfq_forget_idle+0x189/0x1e0 block/bfq-wf2q.c:671
 bfq_update_vtime block/bfq-wf2q.c:1280 [inline]
 __bfq_lookup_next_entity block/bfq-wf2q.c:1374 [inline]
 bfq_lookup_next_entity+0x350/0x480 block/bfq-wf2q.c:1433
 bfq_update_next_in_service+0x1c0/0x4f0 block/bfq-wf2q.c:128
 bfq_deactivate_entity+0x10a/0x240 block/bfq-wf2q.c:1188
 bfq_deactivate_bfqq block/bfq-wf2q.c:1592 [inline]
 bfq_del_bfqq_busy+0x2e8/0xad0 block/bfq-wf2q.c:1659
 bfq_release_process_ref+0x1cc/0x220 block/bfq-iosched.c:3139
 bfq_split_bfqq+0x481/0xdf0 block/bfq-iosched.c:6754
 bfq_init_rq+0xf29/0x17a0 block/bfq-iosched.c:6934
 bfq_insert_request.isra.0+0xe8/0xa20 block/bfq-iosched.c:6271
 bfq_insert_requests+0x27f/0x390 block/bfq-iosched.c:6323
 blk_mq_insert_request+0x290/0x8f0 block/blk-mq.c:2660
 blk_mq_submit_bio+0x1021/0x15e0 block/blk-mq.c:3143
 __submit_bio+0xa0/0x6b0 block/blk-core.c:639
 __submit_bio_noacct_mq block/blk-core.c:718 [inline]
 submit_bio_noacct_nocheck+0x5b7/0x810 block/blk-core.c:747
 submit_bio_noacct+0xca0/0x1990 block/blk-core.c:847
 __ext4_read_bh fs/ext4/super.c:205 [inline]
 ext4_read_bh+0x15e/0x2e0 fs/ext4/super.c:230
 __read_extent_tree_block+0x304/0x6f0 fs/ext4/extents.c:567
 ext4_find_extent+0x479/0xd20 fs/ext4/extents.c:947
 ext4_ext_map_blocks+0x1a3/0x2680 fs/ext4/extents.c:4182
 ext4_map_blocks+0x929/0x15a0 fs/ext4/inode.c:660
 ext4_iomap_begin_report+0x298/0x480 fs/ext4/inode.c:3569
 iomap_iter+0x3dd/0x1010 fs/iomap/iter.c:91
 iomap_fiemap+0x1f4/0x360 fs/iomap/fiemap.c:80
 ext4_fiemap+0x181/0x210 fs/ext4/extents.c:5051
 ioctl_fiemap.isra.0+0x1b4/0x290 fs/ioctl.c:220
 do_vfs_ioctl+0x31c/0x11a0 fs/ioctl.c:811
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl+0xae/0x190 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

commit 1ba0403ac644 ("block, bfq: fix uaf for accessing waker_bfqq after
splitting") fix the problem that if waker_bfqq is in the merge chain,
and current is the only procress, waker_bfqq can be freed from
bfq_split_bfqq(). However, the case that waker_bfqq is not in the merge
chain is missed, and if the procress reference of waker_bfqq is 0,
waker_bfqq can be freed as well.

Fix the problem by checking procress reference if waker_bfqq is not in
the merge_chain.

Fixes: 1ba0403ac644 ("block, bfq: fix uaf for accessing waker_bfqq after splitting")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 068c63e95738..c69e9faad15a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6844,16 +6844,24 @@ static struct bfq_queue *bfq_waker_bfqq(struct bfq_queue *bfqq)
 		if (new_bfqq == waker_bfqq) {
 			/*
 			 * If waker_bfqq is in the merge chain, and current
-			 * is the only procress.
+			 * is the only procress, waker_bfqq can be freed.
 			 */
 			if (bfqq_process_refs(waker_bfqq) == 1)
 				return NULL;
-			break;
+
+			return waker_bfqq;
 		}
 
 		new_bfqq = new_bfqq->new_bfqq;
 	}
 
+	/*
+	 * If waker_bfqq is not in the merge chain, and it's procress reference
+	 * is 0, waker_bfqq can be freed.
+	 */
+	if (bfqq_process_refs(waker_bfqq) == 0)
+		return NULL;
+
 	return waker_bfqq;
 }
 
-- 
2.39.2

