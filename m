Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332FC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 10:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA64960524
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 10:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhHRKJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:09:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55214 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhHRKJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 06:09:24 -0400
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17IA8S0N053142;
        Wed, 18 Aug 2021 19:08:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 18 Aug 2021 19:08:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17IA8SF8053137
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Aug 2021 19:08:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: sort out the lock order in the loop driver
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210818062455.211065-1-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <87997eac-a0bc-c643-0b88-87b09af4e61f@i-love.sakura.ne.jp>
Date:   Wed, 18 Aug 2021 19:08:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/18 15:24, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series sorts out lock order reversals involving the block layer
> open_mutex by drastically reducing the scope of loop_ctl_mutex.  To do
> so it first merges the cryptoloop module into the main loop driver
> as the unregistrtion of transfers on live loop devices was causing
> some nasty locking interactions.
> 
> Diffstat:
>  b/drivers/block/Kconfig    |    6 
>  b/drivers/block/Makefile   |    1 
>  b/drivers/block/loop.c     |  327 ++++++++++++++++++++++++---------------------
>  b/drivers/block/loop.h     |   30 ----
>  drivers/block/cryptoloop.c |  204 ----------------------------
>  5 files changed, 188 insertions(+), 380 deletions(-)
> 

Despite big change, this series introduces at least three bugs by ignoring
what lock protects what resource and/or operation. Locking explanation is very
very wrong. I never want this series merged for v5.14/v5.15 and stable kernels. 

  (1) Will crash at uninitialized mutex_lock_killable().
  (2) Will crash at unprotected idr_remove().
  (3) Will crash syzbot due to hitting WARNING messages (at least two different causes).
