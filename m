Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B44C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3355B2085A
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 17:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfAVRPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:15:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbfAVRPK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 12:15:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F24ED87622;
        Tue, 22 Jan 2019 17:15:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80B1C261A8;
        Tue, 22 Jan 2019 17:15:05 +0000 (UTC)
Date:   Tue, 22 Jan 2019 12:15:04 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        NeilBrown <neilb@suse.com>
Subject: Re: block: cover another queue enter recursion via BIO_QUEUE_ENTERED
Message-ID: <20190122171504.GA11234@redhat.com>
References: <20190122082017.9020-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122082017.9020-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 22 Jan 2019 17:15:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22 2019 at  3:20am -0500,
Ming Lei <ming.lei@redhat.com> wrote:

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
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good, I'll drop my DM patch that set/cleared BIO_QUEUE_ENTERED.

Jens, you OK with picking this up for 5.0-rc?

Reviewed-by:  Mike Snitzer <snitzer@redhat.com>
