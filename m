Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A1DC4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D776108B
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhHSJQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:16:53 -0400
Received: from verein.lst.de ([213.95.11.211]:36719 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234211AbhHSJQt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 05:16:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5DEE767357; Thu, 19 Aug 2021 11:16:09 +0200 (CEST)
Date:   Thu, 19 Aug 2021 11:16:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20210819091608.GA12883@lst.de>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp> <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp> <YRi9EQJqfK6ldrZG@kroah.com> <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp> <YRjcHJE0qEIIJ9gA@kroah.com> <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp> <20210818134752.GA7453@lst.de> <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp> <YR0cGE1sgS8+UhXV@kroah.com> <a6fee3cb-6e5b-bc91-415d-2b100a1d7c83@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6fee3cb-6e5b-bc91-415d-2b100a1d7c83@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 11:51:24PM +0900, Tetsuo Handa wrote:
> The loop module is one of critical components for syzkaller fuzzing.
> Bugs which involves the loop module prevents syzkaller from finding/testing
> other bugs. But changes are continuously applied without careful review.
> Therefore, the changes and code are not getting correct. Stable work cannot
> come afterwards...

I know a very simple solution: review them and provide detailed feedback.
It's not like patches just appear in a tree somewhere.
