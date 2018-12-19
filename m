Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C7BC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E452084A
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeLSQNv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:13:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeLSQNv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 11:13:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 199405A1F0;
        Wed, 19 Dec 2018 16:13:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1F6E5DD63;
        Wed, 19 Dec 2018 16:13:48 +0000 (UTC)
Date:   Wed, 19 Dec 2018 11:13:47 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Dennis Zhou <dennis@kernel.org>
Subject: Re: dm: don't reuse bio for flushes
Message-ID: <20181219161347.GB29426@redhat.com>
References: <a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk>
 <20181219161157.GA29426@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219161157.GA29426@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Dec 2018 16:13:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19 2018 at 11:11am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Wed, Dec 19 2018 at 10:50am -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > DM currently has a statically allocated bio that it uses to issue empty
> > flushes. It doesn't submit this bio, it just uses it for maintaining
> > state while setting up clones. Multiple users can access this bio at the
> > same time. This wasn't previously an issue, even if it was a bit iffy,
> > but with the blkg associations it can become one.
> > 
> > We setup the blkg association, then clone bio's and submit, then remove
> > the blkg assocation again. But since we can have multiple tasks doing
> > this at the same time, against multiple blkg's, then we can either lose
> > references to a blkg, or put it twice. The latter causes complaints on
> > the percpu ref being <= 0 when released, and can cause use-after-free as
> > well. Ming reports that xfstest generic/475 triggers this:
> > 
> > ------------[ cut here ]------------
> > percpu ref (blkg_release) <= 0 (0) after switching to atomic
> > WARNING: CPU: 13 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0
> > 
> > Switch to just using an on-stack bio for this, and get rid of the
> > embedded bio.
> > 
> > Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
> > Reported-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Thanks for sorting this one out, definitely wasn't happy with how
> exposed DM was left with the recent blkg changes.  This is clearly
> better.
> 
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Please upgrade this to:

Reviewed-by: Mike Snitzer <snitzer@redhat.com>
