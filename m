Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB613C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EBE20854
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2mFSye5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCRM1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:27:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44472 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCRM1f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 08:27:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2ICOEo5132699;
        Mon, 18 Mar 2019 12:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : references
 : cc : to : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=rV4e1ER0keWutNGoARjp7yyaYTfL4C9PQH3nR/duadY=;
 b=2mFSye5sgQGmJu5a7y+DfZcr9XAjit1GntsUgtBNJWhWhbyb4qpsmnSHi0q3TNYVR0fR
 67qSvqeStftIyNaoapKY6GiC3uPS5mryM8B9EXtij3PKn3KilegpY3sQ1vMLTi6QMCx/
 IMm9PkBXeWbKCtaMw/Pp9Jv/GcqChK3UIZTHvCdiL8FlsuGrELWgEH60ZlYlrxfZdSAi
 lIBsHTr6kuPMB/RM3/It5LRX3+Ep6EWkrdfLoVrglZ/OeMRO8PCYfygT+QYInKhxrvrv
 i7D/cnNrFWoLy91ZUM5C+qApn5QIoK1lRMeFs43QYqD5NQOtthSlcVW4rak3TMGay9qg 4A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r8ssr611h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 12:27:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2ICRPGJ032198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 12:27:25 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2ICRNFo004430;
        Mon, 18 Mar 2019 12:27:24 GMT
Received: from [10.191.7.230] (/10.191.7.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 05:27:23 -0700
Subject: Re: general protection fault in loop_validate_file (2)
References: <00000000000098bf7d05845616d7@google.com>
Cc:     syzbot <syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        penguin-kernel@i-love.sakura.ne.jp
To:     Jan Kara <jack@suse.cz>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <cb7aa6d1-6d1e-a9ac-239a-1b5d8160f8cd@oracle.com>
Date:   Mon, 18 Mar 2019 20:27:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <00000000000098bf7d05845616d7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180094
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

Indeed there is another issue implicitly reported by below console output from
syzkaller:

[  245.524424][ T9455] loop_reread_partitions: partition scan of loop0 () failed
(rc=-13)
[  245.563340][ T9499] kasan: CONFIG_KASAN_INLINE enabled
[  245.576412][ T9489] __loop_clr_fd: partition scan of loop0 failed (rc=-13)
[  245.581275][ T9499] kasan: GPF could be caused by NULL-ptr deref or user
memory access
[  245.602596][ T9499] general protection fault: 0000 [#1] PREEMPT SMP KASAN

I think rc=-13 is because of below code at line 168:

162 int __blkdev_reread_part(struct block_device *bdev)
163 {
164         struct gendisk *disk = bdev->bd_disk;
165
166         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
167                 return -EINVAL;
168         if (!capable(CAP_SYS_ADMIN))
169                 return -EACCES;
170
171         lockdep_assert_held(&bdev->bd_mutex);
172
173         return rescan_partitions(disk, bdev);
174 }
175 EXPORT_SYMBOL(__blkdev_reread_part);

I can reproduce this by 'chown username /dev/loop0' on my test machine.

Taking 'losetup -d /dev/loop0' as sample, as /dev/loop0 belongs to my username,
I am able to detach the loop without 'su'.

However, because of above line 168, the partition scan would fail.

Should we always assume the user should have admin privilege to detach the loop
and this is not a bug?

Thank you very much!

Dongli Zhang

On 03/18/2019 11:36 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9c7dc824 Merge tag '5.1-rc-smb3' of git://git.samba.org/sf..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=148a35fb200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
> dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc1adc1c55e7fe765b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 9499 Comm: syz-executor.4 Not tainted 5.0.0+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> RIP: 0010:loop_validate_file+0x23e/0x310 drivers/block/loop.c:652
> Code: 00 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 d4 00 00 00 4d 8b a4 24 f0 00
> 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 0f 85 a8 00
> 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0
> RSP: 0018:ffff88804d2bfb18 EFLAGS: 00010202
> RAX: 0000000000000037 RBX: ffff888095ffa3d8 RCX: ffffc9000e657000
> RDX: 0000000000000077 RSI: ffffffff83e754ed RDI: 00000000000001b8
> RBP: ffff88804d2bfb40 R08: ffff88808eab41c0 R09: fffffbfff11d981d
> R10: ffff88804d2bfb40 R11: ffffffff88ecc0e7 R12: 0000000000000000
> R13: 0000000000000002 R14: ffff888095ffa800 R15: dffffc0000000000
> FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000625208 CR3: 00000000a7af8000 CR4: 00000000001406e0
> Call Trace:
>  loop_set_fd drivers/block/loop.c:930 [inline]
>  lo_ioctl+0x99d/0x2150 drivers/block/loop.c:1542
>  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
>  blkdev_ioctl+0xee8/0x1c40 block/ioctl.c:605
>  block_ioctl+0xee/0x130 fs/block_dev.c:1931
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:509 [inline]
>  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
>  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>  __do_sys_ioctl fs/ioctl.c:720 [inline]
>  __se_sys_ioctl fs/ioctl.c:718 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458079
> Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89
> d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b
> b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f04b0c90c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458079
> RDX: 0000000000000004 RSI: 0000000000004c00 RDI: 0000000000000003
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f04b0c916d4
> R13: 00000000004c1252 R14: 00000000004d3160 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 81b29486bae7280a ]---
> RIP: 0010:loop_validate_file+0x23e/0x310 drivers/block/loop.c:652
> Code: 00 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 d4 00 00 00 4d 8b a4 24 f0 00
> 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 0f 85 a8 00
> 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0
> RSP: 0018:ffff88804d2bfb18 EFLAGS: 00010202
> RAX: 0000000000000037 RBX: ffff888095ffa3d8 RCX: ffffc9000e657000
> RDX: 0000000000000077 RSI: ffffffff83e754ed RDI: 00000000000001b8
> RBP: ffff88804d2bfb40 R08: ffff88808eab41c0 R09: fffffbfff11d981d
> R10: ffff88804d2bfb40 R11: ffffffff88ecc0e7 R12: 0000000000000000
> R13: 0000000000000002 R14: ffff888095ffa800 R15: dffffc0000000000
> FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000625208 CR3: 00000000a7af8000 CR4: 00000000001406e0
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
