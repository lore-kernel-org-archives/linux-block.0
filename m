Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A0C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 05:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DFA61412
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 05:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhFOFcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 01:32:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57499 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOFct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 01:32:49 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15F5UeOv015935;
        Tue, 15 Jun 2021 14:30:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Tue, 15 Jun 2021 14:30:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15F5UchD015832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jun 2021 14:30:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: drop loop_ctl_mutex around del_gendisk() in
 loop_remove()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Vorel <pvorel@suse.cz>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
 <718b44b5-a230-1907-e1e1-9f609cb67322@i-love.sakura.ne.jp>
 <4e315cc1-cbb9-b00e-c4cd-ca4f6f60f202@i-love.sakura.ne.jp>
 <d15e9392-44d0-f42c-cbac-859459a99395@i-love.sakura.ne.jp>
Message-ID: <2af74b56-5f25-5f07-df48-86b341ad8c2a@i-love.sakura.ne.jp>
Date:   Tue, 15 Jun 2021 14:30:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d15e9392-44d0-f42c-cbac-859459a99395@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Found that commit 990e78116d38059c ("block: loop: fix deadlock between open and remove") went to 5.13-rc6.

#syz fix: block: loop: fix deadlock between open and remove

Now syzbot is reporting

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(nbd_index_mutex);
                               lock(&bdev->bd_mutex);
                               lock(nbd_index_mutex);
  lock(&bdev->bd_mutex);

at https://syzkaller.appspot.com/text?tag=CrashReport&x=11b8a5bbd00000 .

