Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED56C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 16:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FDE6108B
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 16:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhIJQ7N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 12:59:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58643 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhIJQ7M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 12:59:12 -0400
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18AGvsnc044636;
        Sat, 11 Sep 2021 01:57:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 11 Sep 2021 01:57:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18AGvsYi044633
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 11 Sep 2021 01:57:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [syzbot] possible deadlock in bd_register_pending_holders
To:     syzbot <syzbot+f5608de5d89cc0d998c7@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e272fb05cba51fe4@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <d4d71dc8-0373-b7a9-2a95-ba2d3c87f968@I-love.SAKURA.ne.jp>
Date:   Sat, 11 Sep 2021 01:57:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <000000000000e272fb05cba51fe4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit dfbb3409b27fa42b in axboe/linux-block.git#block-5.15 breaks
"sb_writers#$N => &p->lock => major_names_lock" dependency chain,
I think that this dependency chain should be no longer possible.

#syz fix: block: genhd: don't call blkdev_show() with major_names_lock held

On 2021/09/10 23:42, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    27151f177827 Merge tag 'perf-tools-for-v5.15-2021-09-04' o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=104612b3300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ac2f9cc43f6b17e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=f5608de5d89cc0d998c7
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f5608de5d89cc0d998c7@syzkaller.appspotmail.com
