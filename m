Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C50CA9EBB
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 10:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D06120663
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 10:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393242AbfJXKJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:09:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54102 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393241AbfJXKJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 06:09:02 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x9OA8tth056753;
        Thu, 24 Oct 2019 19:08:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Thu, 24 Oct 2019 19:08:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x9OA8n86056449
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 24 Oct 2019 19:08:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task syz-executor can't die for more than 143 seconds. (2)
To:     axboe@kernel.dk
References: <000000000000c52dbf05958f3f3a@google.com>
Cc:     syzbot <syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
Date:   Thu, 24 Oct 2019 19:08:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000c52dbf05958f3f3a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/10/23 16:56, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c4b9850b Add linux-next specific files for 20191018
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177b3ab0e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c940ef12efcd1ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=b48daca8639150bc5e73
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1356b8ff600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f48687600000

The reproducer is trying to allocate 64TB of disk space on /dev/nullb0 using fallocate()
but __blkdev_issue_zero_pages() cannot bail out upon SIGKILL (and therefore cannot
terminate for minutes). Can we make it killable? I don't know what action is needed
for undoing this loop...

        while (nr_sects != 0) {
                bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
                                   gfp_mask);
                bio->bi_iter.bi_sector = sector;
                bio_set_dev(bio, bdev);
                bio_set_op_attrs(bio, REQ_OP_WRITE, 0);

                while (nr_sects != 0) {
                        sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
                        bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
                        nr_sects -= bi_size >> 9;
                        sector += bi_size >> 9;
                        if (bi_size < sz)
                                break;
                }
                cond_resched();
        }

