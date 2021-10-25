Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E033BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9A360C49
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhJYImB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:42:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4026 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhJYImB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 04:42:01 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hd7ZF3mlVz67xMZ;
        Mon, 25 Oct 2021 16:35:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 25 Oct 2021 10:39:36 +0200
Received: from [10.47.95.85] (10.47.95.85) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 09:39:36 +0100
Subject: Re: [syzbot] KASAN: use-after-free Read in blk_mq_sched_tags_teardown
To:     syzbot <syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
References: <000000000000d4e1e105cf235f15@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a189d065-fb64-b76f-9f45-f866f9d5638c@huawei.com>
Date:   Mon, 25 Oct 2021 09:39:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <000000000000d4e1e105cf235f15@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.85]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/10/2021 02:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    51dba6e335ff Add linux-next specific files for 20211020
> git tree:       linux-next
> console output:https://syzkaller.appspot.com/x/log.txt?x=10171dc8b00000
> kernel config:https://syzkaller.appspot.com/x/.config?x=1adca843ed814d57
> dashboard link:https://syzkaller.appspot.com/bug?extid=412ca156285f619b8b62
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:https://syzkaller.appspot.com/x/repro.syz?x=14f768b4b00000
> C reproducer:https://syzkaller.appspot.com/x/repro.c?x=1295a8c7300000
> 
> The issue was bisected to:
> 
> commit 645db34e50501aac141713fb47a315e5202ff890

I think that it should be e155b0c238b2 ("blk-mq: Use shared tags for 
shared sbitmap support")

> Author: John Garry<john.garry@huawei.com>
> Date:   Tue Oct 5 10:23:36 2021 +0000
> 
>      blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()
> 
> bisection log:https://syzkaller.appspot.com/x/bisect.txt?x=1597e130b00000
> final oops:https://syzkaller.appspot.com/x/report.txt?x=1797e130b00000
> console output:https://syzkaller.appspot.com/x/log.txt?x=1397e130b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by:syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com
> Fixes: 645db34e5050 ("blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()")
> 
> ==================================================================
> BUG: KASAN: use-after-free in blk_mq_sched_tags_teardown+0x2a1/0x2d0 block/blk-mq-sched.c:544
> Read of size 4 at addr ffff8880760b81e0 by task systemd-udevd/6750

#syz fix: blk-mq-sched: Don't reference queue tagset in 
blk_mq_sched_tags_teardown()
