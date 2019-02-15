Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C3C10F04
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D162073D
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfBOCYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:24:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:12068 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfBOCYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:24:46 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1F2ORdY039579;
        Fri, 15 Feb 2019 11:24:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Fri, 15 Feb 2019 11:24:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1F2OREj039575;
        Fri, 15 Feb 2019 11:24:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x1F2ORDs039574;
        Fri, 15 Feb 2019 11:24:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902150224.x1F2ORDs039574@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH AUTOSEL 4.20 49/77] block: cover another queue enter recursion
 via =?ISO-2022-JP?B?QklPX1FVRVVFX0VOVEVSRUQ=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
MIME-Version: 1.0
Date:   Fri, 15 Feb 2019 11:24:27 +0900
References: <20190215020855.176727-1-sashal@kernel.org> <20190215020855.176727-49-sashal@kernel.org>
In-Reply-To: <20190215020855.176727-49-sashal@kernel.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch turned out to be wrong and was reverted. Please drop this patch. 

commit 947b7ac135b16aa60f9141ff72bd494eda0edb5e
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sun Jan 27 06:35:28 2019 -0700

    Revert "block: cover another queue enter recursion via BIO_QUEUE_ENTERED"

    We can't touch a bio after ->make_request_fn(), for all we know it could
    already have been completed by the time this function returns.

    This reverts commit 698cef173983b086977e633e46476e0f925ca01e.

    Reported-by: syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

> From: Ming Lei <ming.lei@redhat.com>
> 
> [ Upstream commit 698cef173983b086977e633e46476e0f925ca01e ]
> 
> Except for blk_queue_split(), bio_split() is used for splitting bio too,
> then the remained bio is often resubmit to queue via generic_make_request().
> So the same queue enter recursion exits in this case too. Unfortunatley
> commit cd4a4ae4683dc2 doesn't help this case.
> 
> This patch covers the above case by setting BIO_QUEUE_ENTERED before calling
> q->make_request_fn.
> 
> In theory the per-bio flag is used to simulate one stack variable, it is
> just fine to clear it after q->make_request_fn is returned. Especially
> the same bio can't be submitted from another context.
> 
> Fixes: cd4a4ae4683dc2 ("block: don't use blocking queue entered for recursive bio submits")
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: NeilBrown <neilb@suse.com>
> Reviewed-by:  Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  block/blk-core.c  | 11 +++++++++++
>  block/blk-merge.c | 10 ----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
