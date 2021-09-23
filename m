Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B97AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 04:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A56561040
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 04:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhIWEMU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 00:12:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56031 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhIWEMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 00:12:15 -0400
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18N4Afw7001949;
        Thu, 23 Sep 2021 13:10:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Thu, 23 Sep 2021 13:10:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18N4AfhT001946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Sep 2021 13:10:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [syzbot] possible deadlock in blk_request_module
To:     axboe@kernel.dk
References: <000000000000a6de6705cc9f0be7@google.com>
Cc:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <5f79bd5d-577e-86bc-e4e6-996ffb5bbe54@I-love.SAKURA.ne.jp>
Date:   Thu, 23 Sep 2021 13:10:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <000000000000a6de6705cc9f0be7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Jens.

On 2021/09/23 9:52, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    93ff9f13be91 Merge tag 's390-5.15-3' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d5b33d300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
> dashboard link: https://syzkaller.appspot.com/bug?extid=384fb45e189bf86b6bb9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+384fb45e189bf86b6bb9@syzkaller.appspotmail.com

Will you pick up

https://lkml.kernel.org/r/e205f13d-18ff-a49c-0988-7de6ea5ff823@i-love.sakura.ne.jp

which avoids add_disk() with brd_devices_mutex held?

Also, will you pick up

https://lkml.kernel.org/r/692fdc1a-6396-dcf4-c700-2d822f161053@i-love.sakura.ne.jp

which avoids double kfree() ?
