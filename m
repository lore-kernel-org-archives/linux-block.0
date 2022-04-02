Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC60C433F5
	for <linux-block@archiver.kernel.org>; Sat,  2 Apr 2022 11:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiDBL20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Apr 2022 07:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiDBL2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Apr 2022 07:28:25 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A7D1A636F;
        Sat,  2 Apr 2022 04:26:33 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 232BQQEH011133;
        Sat, 2 Apr 2022 20:26:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 02 Apr 2022 20:26:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 232BQQqs011130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 2 Apr 2022 20:26:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d3213c1a-f82a-02f6-b5b2-0d3242e0242a@I-love.SAKURA.ne.jp>
Date:   Sat, 2 Apr 2022 20:26:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] INFO: task can't die in blkdev_common_ioctl
Content-Language: en-US
To:     syzbot <syzbot+4f1a237abaf14719db49@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000007a4a2d05dba6baa6@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000007a4a2d05dba6baa6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/04/02 16:20, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f81e94e91878 Add linux-next specific files for 20211125
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=168d578db00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=4f1a237abaf14719db49
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

This is a known problem, and Christoph does not like a mitigation patch.
https://lkml.kernel.org/r/YgoQBTzb3b0l1SzP@infradead.org

> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4f1a237abaf14719db49@syzkaller.appspotmail.com

#syz dup: INFO: task hung in blkdev_fallocate
