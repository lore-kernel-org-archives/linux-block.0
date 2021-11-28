Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C570C433F5
	for <linux-block@archiver.kernel.org>; Sun, 28 Nov 2021 07:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355151AbhK1HsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Nov 2021 02:48:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52418 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhK1HqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 02:46:11 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AS7gdgM042784;
        Sun, 28 Nov 2021 16:42:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 28 Nov 2021 16:42:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AS7gcT4042780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 28 Nov 2021 16:42:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
Date:   Sun, 28 Nov 2021 16:42:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
In-Reply-To: <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/28 14:32, Tetsuo Handa wrote:
> If we can unconditionally start __loop_clr_fd() upon ioctl(LOOP_CLR_FD), I think
> we can avoid circular locking between disk->open_mutex and flush_workqueue().

Too bad. There is ioctl(LOOP_SET_STATUS) which allows forcing __loop_clr_fd() to be
called without ioctl(LOOP_CLR_FD). We have to support __loop_clr_fd() upon lo_release().

Is dropping disk->open_mutex inside lo_release()
( https://lkml.kernel.org/r/e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp ) possible?

