Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA94C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB30A610CF
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhHROmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238701AbhHROmF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E97D6108D;
        Wed, 18 Aug 2021 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629297691;
        bh=esFdvK4Q79Vy4Gyab90/VpqoxASI7Y81TktbAjiHXP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JF1LLcMITcNL9ScFvM4jxYL+ElEG6CV+yH5Mq9YRTsCMYyTEj6LTtRyLM8P8FrLkZ
         qvQ5msO3bX/oiA2VQBnqvV2ojZ4p3m5D0kdbap00k/m8+khLGqDJCpyrZQ3pdOdf9s
         3LltOwBRTmVuSO6YjBGD9/0q9Fkd1WLfkekhOw9U=
Date:   Wed, 18 Aug 2021 16:41:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YR0cGE1sgS8+UhXV@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <20210818134752.GA7453@lst.de>
 <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 11:34:15PM +0900, Tetsuo Handa wrote:
> On 2021/08/18 22:47, Christoph Hellwig wrote:
> > Hi Tetsuo,
> > 
> > I might sound like a broken record, but we need to reduce the locking
> > complexity, not make it worse and fall down the locking cliff.  I did
> > send a suggested series this morning, in which you found a bunch of
> > bugs.  I'd appreciate it if you could use your superior skills to
> > actually help explain the issue and arrive at a common solution that
> > actually simplifies things instead of steaming down the locking cliff
> > full speed.  Thank you very much.
> 
> I posted "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex"
> which reduces the locking complexity while fixing bugs, but you ignored it. Instead,
> you decided to remove cryptoloop module (where userspace doing "modprobe cryptoloop"
> will break). That is, you decided not to provide patches which can be backported.

Do not ever worry about backporting patches.  Worry about getting the
changes and code correct, stable work can come afterwards, if needed.

thanks,

greg k-h
