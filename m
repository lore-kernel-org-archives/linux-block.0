Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB680C4361B
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943D3207FB
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 11:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405857AbgLMLlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 06:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgLMLlq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 06:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607859620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKSW/stOci0QivHUrs5dckTF2lzWIS0IG9Tjp31B46k=;
        b=X22dFz07MuAYbppJfYxfzUmp/HsCp8EVxQSFtrbdzInp5R8zA2fokjuea4C1byHcgZz6vx
        Vj6ENK7wQx48yJoSG/Jb/xoxhKryeSnNlSyqOrmX5cDXdAwrAGA/p+j+yqGNqdtigaRhmF
        Ftv4u9r4tL0OKd2pwYqJEtey8aW48Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-1-1w0Sw5NFyDBwZN_yeU2w-1; Sun, 13 Dec 2020 06:40:16 -0500
X-MC-Unique: 1-1w0Sw5NFyDBwZN_yeU2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C436107ACE4;
        Sun, 13 Dec 2020 11:40:15 +0000 (UTC)
Received: from T590 (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E6036FA;
        Sun, 13 Dec 2020 11:40:06 +0000 (UTC)
Date:   Sun, 13 Dec 2020 19:40:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     syzbot <syzbot+825f0f9657d4e528046e@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in disk_part_iter_next
Message-ID: <20201213114002.GA1659569@T590>
References: <000000000000c167dd05b6369e69@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c167dd05b6369e69@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 11, 2020 at 01:03:11PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d8ad37500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
> dashboard link: https://syzkaller.appspot.com/bug?extid=825f0f9657d4e528046e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1393dcbd500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1074cf17500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+825f0f9657d4e528046e@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in bdev_nr_sectors include/linux/genhd.h:264 [inline]
> BUG: KASAN: use-after-free in disk_part_iter_next+0x4c7/0x560 block/genhd.c:204
> Read of size 8 at addr ffff88814080b9a8 by task syz-executor825/9848
> 
> CPU: 1 PID: 9848 Comm: syz-executor825 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
>  __kasan_report mm/kasan/report.c:396 [inline]
>  kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
>  bdev_nr_sectors include/linux/genhd.h:264 [inline]
>  disk_part_iter_next+0x4c7/0x560 block/genhd.c:204
>  partition_overlaps+0x96/0x200 block/partitions/core.c:425
>  bdev_add_partition+0x66/0x130 block/partitions/core.c:444
>  blkpg_do_ioctl+0x2d0/0x340 block/ioctl.c:43
>  blkpg_ioctl block/ioctl.c:60 [inline]
>  blkdev_ioctl+0x577/0x6d0 block/ioctl.c:541
>  block_ioctl+0xf9/0x140 fs/block_dev.c:1649
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

It should be fixed by the following patch, can you run the test with this
patch?

diff --git a/block/genhd.c b/block/genhd.c
index b84b8671e627..98d785e248dd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -244,8 +244,7 @@ struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
 		part = rcu_dereference(ptbl->part[piter->idx]);
 		if (!part)
 			continue;
-		if (!bdev_nr_sectors(part) &&
-		    !(piter->flags & DISK_PITER_INCL_EMPTY) &&
+		if (!(piter->flags & DISK_PITER_INCL_EMPTY) &&
 		    !(piter->flags & DISK_PITER_INCL_EMPTY_PART0 &&
 		      piter->idx == 0))
 			continue;
@@ -253,6 +252,12 @@ struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
 		piter->part = bdgrab(part);
 		if (!piter->part)
 			continue;
+		if (!bdev_nr_sectors(part)) {
+			bdput(piter->part);
+			piter->part = NULL;
+			continue;
+		}
+
 		piter->idx += inc;
 		break;
 	}

-- 
Ming

