Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA7FC47082
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B726760E0B
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 10:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGK6X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jun 2021 06:58:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60364 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhFGK6X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jun 2021 06:58:23 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 157AuKST011675;
        Mon, 7 Jun 2021 19:56:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Mon, 07 Jun 2021 19:56:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 157AuJBj011670
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 7 Jun 2021 19:56:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [syzbot] possible deadlock in del_gendisk
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>
References: <000000000000ae236f05bfde0678@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
Message-ID: <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
Date:   Mon, 7 Jun 2021 19:56:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <000000000000ae236f05bfde0678@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

syzbot is reporting "possible deadlock in del_gendisk" problem.

I guess this is caused by commit 6cc8e7430801fa23 ("loop: scale loop device
by introducing per device lock") because it touches loop_ctl_mutex usage
between v5.11 and v5.12-rc1. Please have a look.

On 2021/04/14 2:33, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e99d8a84 Add linux-next specific files for 20210409
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13b01681d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd69574979bfeb7
> dashboard link: https://syzkaller.appspot.com/bug?extid=61e04e51b7ac86930589
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148265d9d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a981a1d00000

