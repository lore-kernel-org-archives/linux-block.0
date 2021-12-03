Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8342DC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 11:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhLCLFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 06:05:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53773 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhLCLFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 06:05:06 -0500
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1B3B1Nth038235;
        Fri, 3 Dec 2021 20:01:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Fri, 03 Dec 2021 20:01:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1B3B1MQF038226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Dec 2021 20:01:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <0291d903-0778-01ff-927f-97df2810262e@i-love.sakura.ne.jp>
Date:   Fri, 3 Dec 2021 20:01:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] loop: make autoclear operation asynchronous
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <dchinner@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
 <YaYfu0H2k0PSQL6W@infradead.org>
 <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
 <20211202121615.GC1815@quack2.suse.cz>
 <3f4d1916-8e70-8914-57ba-7291f40765ae@i-love.sakura.ne.jp>
 <20211202180500.GA30284@quack2.suse.cz> <Yam+TsPF1jaKM+Am@infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <Yam+TsPF1jaKM+Am@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/03 15:50, Christoph Hellwig wrote:
> task_work_add sounds nice, but it is currently not exported which might
> be for a reason (I don't really have any experience with it).

I didn't find a reason not to export. But generally task_work_add() users
seem to implement a fallback which uses a WQ in case task_work_add() failed
(i.e. exit_task_work() was already called from do_exit()) or task_work_add()
cannot be used (e.g. the caller is a kernel thread).

I don't know if there is possibility that a kernel thread calls blkdev_put(),
but implementing the fallback path after all requires WQ. Thus, I think that
starting from WQ only and see if something breaks is fine.

