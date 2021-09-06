Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD9FC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 05:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3C060FBF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 05:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhIFGA6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:00:58 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63068 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhIFGA5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 02:00:57 -0400
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1865xgke066103;
        Mon, 6 Sep 2021 14:59:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Mon, 06 Sep 2021 14:59:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1865xfpj066097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Sep 2021 14:59:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
 <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
 <YTUIV0mSJHfgtMov@bombadil.infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d5c7f0e6-8ded-581c-cb10-00e785a7f7b3@i-love.sakura.ne.jp>
Date:   Mon, 6 Sep 2021 14:59:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTUIV0mSJHfgtMov@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/06 3:11, Luis Chamberlain wrote:
> On Sat, Sep 04, 2021 at 11:49:06AM +0900, Tetsuo Handa wrote:
>> On 2021/09/04 10:39, Luis Chamberlain wrote:
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>>> index 45df6cbccf12..81a4738910a8 100644
>>> --- a/fs/block_dev.c
>>> +++ b/fs/block_dev.c
>>> @@ -1144,10 +1144,13 @@ struct block_device *blkdev_get_no_open(dev_t dev)
>>>  {
>>>  	struct block_device *bdev;
>>>  	struct inode *inode;
>>> +	int ret;
>>>  
>>>  	inode = ilookup(blockdev_superblock, dev);
>>>  	if (!inode) {
>>> -		blk_request_module(dev);
>>> +		ret = blk_request_module(dev);
>>> +		if (ret)
>>> +			return NULL;
>>
>> Since e.g. loop_add() from loop_probe() returns -EEXIST when /dev/loop$num already
>> exists (e.g. raced with ioctl(LOOP_CTL_ADD)), isn't unconditionally failing an over-failing?
> 
> It's not clear to me how. What do we loose by capturing the failure on
> blk_request_module()?
> 

We loose ability to handle concurrent request.

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 45df6cbccf12..9559c8aabc88 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -36,6 +36,7 @@
 #include <linux/suspend.h>
 #include "internal.h"
 #include "../block/blk.h"
+#include <linux/debug_locks.h>

 struct bdev_inode {
        struct block_device bdev;
@@ -1147,7 +1148,11 @@ struct block_device *blkdev_get_no_open(dev_t dev)

        inode = ilookup(blockdev_superblock, dev);
        if (!inode) {
+               dump_stack();
+               debug_show_held_locks(current);
                blk_request_module(dev);
+               if (!strcmp(current->comm, "cat"))
+                       schedule_timeout_killable(10 * HZ);
                inode = ilookup(blockdev_superblock, dev);
                if (!inode)
                        return NULL;

Try "mknod /dev/loop$num b 7 $num" followed by concurrent "cat /dev/loop$num" requests.

[  535.847823] [ T5261] CPU: 1 PID: 5261 Comm: cat Tainted: G            E     5.14.0-next-20210903+ #3
[  535.851419] [ T5261] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  535.855563] [ T5261] Call Trace:
[  535.856746] [ T5261]  dump_stack_lvl+0x79/0xbf
[  535.858332] [ T5261]  blkdev_get_no_open+0x86/0xe0
[  535.860036] [ T5261]  blkdev_get_by_dev+0x5f/0x540
[  535.861747] [ T5261]  ? block_ioctl+0x40/0x40
[  535.863305] [ T5261]  blkdev_open+0x58/0x90
[  535.864865] [ T5261]  do_dentry_open+0x144/0x3a0
[  535.866538] [ T5261]  path_openat+0xa57/0xda0
[  535.868139] [ T5261]  do_filp_open+0x9f/0x140
[  535.869933] [ T5261]  ? _raw_spin_unlock+0x1a/0x30
[  535.871570] [ T5261]  do_sys_openat2+0x71/0x150
[  535.873195] [ T5261]  __x64_sys_openat+0x78/0xa0
[  535.874740] [ T5261]  do_syscall_64+0x3d/0xb0
[  535.876234] [ T5261]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  535.878428] [ T5261] RIP: 0033:0x7f6b997d28db
[  535.879927] [ T5261] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[  535.886778] [ T5261] RSP: 002b:00007ffe8bdad880 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  535.889727] [ T5261] RAX: ffffffffffffffda RBX: 000055f741e5b634 RCX: 00007f6b997d28db
[  535.892466] [ T5261] RDX: 0000000000000000 RSI: 00007ffe8bdaf764 RDI: 00000000ffffff9c
[  535.895226] [ T5261] RBP: 00007ffe8bdaf764 R08: 0000000000000001 R09: 0000000000000000
[  535.898162] [ T5261] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  535.900858] [ T5261] R13: 00007ffe8bdadb68 R14: 0000000000000000 R15: 0000000000020000
[  535.903752] [ T5262] CPU: 2 PID: 5262 Comm: cat Tainted: G            E     5.14.0-next-20210903+ #3
[  535.904759] [ T5261] no locks held by cat/5261.
[  535.906905] [ T5262] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  535.906908] [ T5262] Call Trace:
[  535.906912] [ T5262]  dump_stack_lvl+0x79/0xbf
[  535.915279] [ T5262]  blkdev_get_no_open+0x86/0xe0
[  535.916942] [ T5262]  blkdev_get_by_dev+0x5f/0x540
[  535.918608] [ T5262]  ? block_ioctl+0x40/0x40
[  535.920250] [ T5262]  blkdev_open+0x58/0x90
[  535.921696] [ T5262]  do_dentry_open+0x144/0x3a0
[  535.923291] [ T5262]  path_openat+0xa57/0xda0
[  535.924816] [ T5262]  do_filp_open+0x9f/0x140
[  535.926359] [ T5262]  ? _raw_spin_unlock+0x1a/0x30
[  535.928030] [ T5262]  do_sys_openat2+0x71/0x150
[  535.929600] [ T5262]  __x64_sys_openat+0x78/0xa0
[  535.931215] [ T5262]  do_syscall_64+0x3d/0xb0
[  535.932768] [ T5262]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  535.934817] [ T5262] RIP: 0033:0x7efe3a0aa8db
[  535.936354] [ T5262] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[  535.943021] [ T5262] RSP: 002b:00007ffe1697dfb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  535.945883] [ T5262] RAX: ffffffffffffffda RBX: 000055982a4e1634 RCX: 00007efe3a0aa8db
[  535.948580] [ T5262] RDX: 0000000000000000 RSI: 00007ffe1697e764 RDI: 00000000ffffff9c
[  535.951298] [ T5262] RBP: 00007ffe1697e764 R08: 0000000000000001 R09: 0000000000000000
[  535.954064] [ T5262] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  535.956789] [ T5262] R13: 00007ffe1697e298 R14: 0000000000000000 R15: 0000000000020000
[  535.959522] [ T5263] CPU: 0 PID: 5263 Comm: cat Tainted: G            E     5.14.0-next-20210903+ #3
[  535.962995] [ T5263] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  535.965787] [ T5262] no locks held by cat/5262.
[  535.966998] [ T5263] Call Trace:
[  535.970068] [ T5263]  dump_stack_lvl+0x79/0xbf
[  535.971572] [ T5263]  blkdev_get_no_open+0x86/0xe0
[  535.973199] [ T5263]  blkdev_get_by_dev+0x5f/0x540
[  535.974893] [ T5263]  ? block_ioctl+0x40/0x40
[  535.976364] [ T5263]  blkdev_open+0x58/0x90
[  535.977781] [ T5263]  do_dentry_open+0x144/0x3a0
[  535.979378] [ T5263]  path_openat+0xa57/0xda0
[  535.980882] [ T5263]  do_filp_open+0x9f/0x140
[  535.982333] [ T5263]  ? _raw_spin_unlock+0x1a/0x30
[  535.984002] [ T5263]  do_sys_openat2+0x71/0x150
[  535.985554] [ T5263]  __x64_sys_openat+0x78/0xa0
[  535.987232] [ T5263]  do_syscall_64+0x3d/0xb0
[  535.988790] [ T5263]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  535.990804] [ T5263] RIP: 0033:0x7ff84ab408db
[  535.992275] [ T5263] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[  535.998888] [ T5263] RSP: 002b:00007ffda9b89a70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  536.001628] [ T5263] RAX: ffffffffffffffda RBX: 000055626f376634 RCX: 00007ff84ab408db
[  536.004350] [ T5263] RDX: 0000000000000000 RSI: 00007ffda9b8a764 RDI: 00000000ffffff9c
[  536.007009] [ T5263] RBP: 00007ffda9b8a764 R08: 0000000000000001 R09: 0000000000000000
[  536.009753] [ T5263] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  536.012493] [ T5263] R13: 00007ffda9b89d58 R14: 0000000000000000 R15: 0000000000020000
[  536.015854] [ T5263] no locks held by cat/5263.

If blk_request_module() does not ignore -EEXIST error, only the first open() request would succeed
because loop_add() returns 0 and all other concurrent requests would fail because loop_add() returns -EEXIST.

Actually, blk_request_module() failures should be ignored, for subsequent ilookup() will
fail if blk_request_module() failed to create the requested block device.
