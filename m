Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B2C48BD1
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222D46124C
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 14:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhFKOt2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:49:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56280 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhFKOt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 10:49:27 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15BElSRp089619;
        Fri, 11 Jun 2021 23:47:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Fri, 11 Jun 2021 23:47:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15BElSF1089616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Jun 2021 23:47:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] possible deadlock in del_gendisk
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <49e00adb-ccf5-8024-6403-014ca82781dd@i-love.sakura.ne.jp>
Date:   Fri, 11 Jun 2021 23:47:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609164639.GM4910@sequoia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/10 1:46, Tyler Hicks wrote:
> Thanks for doing this. I haven't had a chance to retry this commit with
> lockdep but I did re-review it and didn't think that it would be the
> cause of this lockdep report since it strictly reduced the usage of the
> loop_ctl_mutex.

Well, I made commit 310ca162d779efee ("block/loop: Use global lock for ioctl() operation.")
because per device lock was not sufficient. Did commit 6cc8e7430801fa23 ("loop: scale loop
device by introducing per device lock") take this problem into account?
