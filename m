Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA71C433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 21:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D3320C01
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 21:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfHEVCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:02:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57022 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 17:02:35 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x75L1u3t084511;
        Tue, 6 Aug 2019 06:01:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Tue, 06 Aug 2019 06:01:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x75L1pkt084351
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 6 Aug 2019 06:01:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        John Lenton <john.lenton@canonical.com>
Cc:     Kai-Heng Feng <kaihengfeng@me.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
 <20190730133607.GD28829@quack2.suse.cz>
 <43344436-99b5-f0a7-b71e-2bbb025dfd09@acm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b43b2434-48c8-4728-dd09-7bfdbeeb32ad@i-love.sakura.ne.jp>
Date:   Tue, 6 Aug 2019 06:01:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <43344436-99b5-f0a7-b71e-2bbb025dfd09@acm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/06 1:41, Bart Van Assche wrote:
> Hi Jan,
> 
> A new kernel warning is triggered by blktests block/001 that did not happen
> without this patch. Reverting commit 89e524c04fa9 ("loop: Fix mount(2)
> failure due to race with LOOP_SET_FD") makes that kernel warning disappear.
> Is this reproducible on your setup?
> 
> Thanks,
> 
> Bart.
> 
> kernel: WARNING: CPU: 5 PID: 907 at fs/block_dev.c:1899 __blkdev_put+0x396/0x3a0

Hmm, this is reported as below one.

  WARNING in __blkdev_put (2)
  https://syzkaller.appspot.com/bug?id=1ac7a7a8440522302ccb634ba69f8e1e6f203902
