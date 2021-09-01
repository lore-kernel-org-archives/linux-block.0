Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E4C432BE
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 04:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3765B60F4B
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 04:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhIAEVT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 00:21:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51713 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIAEVS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 00:21:18 -0400
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1814JjgC033046;
        Wed, 1 Sep 2021 13:19:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Wed, 01 Sep 2021 13:19:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1814Jj4Y033043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Sep 2021 13:19:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH v3 0/8] block: first batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210830212538.148729-1-mcgrof@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <cc6470a2-7e32-c582-2c45-1358d3f6de1b@I-love.SAKURA.ne.jp>
Date:   Wed, 1 Sep 2021 13:19:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210830212538.148729-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/31 6:25, Luis Chamberlain wrote:
> Jens,
> 
> I think this first set is ready, but pending review of just two patches:
> 
>   * mmc/core/block
>   * dm
> 
> All other patches have a respective Reviewed-by tag. The above two
> patches were integrated back into the series once I understood
> Christoph's concerns, and adjusted the patch as such.
> 
> This goes rebased onto your for-next as of today. If anyone wants to
> explore the pending full set this is up on my linux-next branch
> 20210830-for-axboe-add-disk-error-handling-next [0].

Are the changes by add_disk() made atomically against the caller?
If there is a moment where "struct block_device_operations"->open can be
called when add_disk() might still fail, how is it protected from the
kfree() path?

> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210830-for-axboe-add-disk-error-handling-next
> 
> Luis Chamberlain (8):
>   scsi/sd: add error handling support for add_disk()
>   scsi/sr: add error handling support for add_disk()
>   nvme: add error handling support for add_disk()
>   mmc/core/block: add error handling support for add_disk()
>   md: add error handling support for add_disk()
>   dm: add add_disk() error handling
>   loop: add error handling support for add_disk()
>   nbd: add error handling support for add_disk()
> 
>  drivers/block/loop.c     | 9 ++++++++-
>  drivers/block/nbd.c      | 6 +++++-
>  drivers/md/dm.c          | 4 +++-
>  drivers/md/md.c          | 7 ++++++-
>  drivers/mmc/core/block.c | 7 ++++++-
>  drivers/nvme/host/core.c | 9 ++++++++-
>  drivers/scsi/sd.c        | 6 +++++-
>  drivers/scsi/sr.c        | 5 ++++-
>  8 files changed, 45 insertions(+), 8 deletions(-)
> 

