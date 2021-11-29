Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AD9C433F5
	for <linux-block@archiver.kernel.org>; Mon, 29 Nov 2021 10:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbhK2KmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Nov 2021 05:42:10 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55043 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346963AbhK2KkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Nov 2021 05:40:09 -0500
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1ATAaYbg056564;
        Mon, 29 Nov 2021 19:36:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Mon, 29 Nov 2021 19:36:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1ATAaWHR056557
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Nov 2021 19:36:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
Date:   Mon, 29 Nov 2021 19:36:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <YaSpkRHgEMXrcn5i@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/29 19:21, Christoph Hellwig wrote:
> On Sun, Nov 28, 2021 at 04:42:35PM +0900, Tetsuo Handa wrote:
>> Is dropping disk->open_mutex inside lo_release()
>> ( https://lkml.kernel.org/r/e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp ) possible?
> 
> I don't think we can drop open_mutex inside ->release. What is the
> problem with offloading the clearing to a different context than the
> one that calls ->release?
> 

Offloading to a WQ context?

If the caller just want to call ioctl(LOOP_CTL_GET_FREE) followed by
ioctl(LOOP_CONFIGURE), deferring __loop_clr_fd() would be fine.

But the caller might want to unmount as soon as fput(filp) from __loop_clr_fd() completes.
I think we need to wait for __loop_clr_fd() from lo_release() to complete.
