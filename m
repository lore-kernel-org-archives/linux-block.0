Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B579C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC0520672
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeLSQHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:07:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbeLSQHM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 11:07:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FE584E93E;
        Wed, 19 Dec 2018 16:07:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7B765DD63;
        Wed, 19 Dec 2018 16:07:03 +0000 (UTC)
Date:   Thu, 20 Dec 2018 00:06:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] dm: don't reuse bio for flushes
Message-ID: <20181219160657.GD17457@ming.t460p>
References: <a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 19 Dec 2018 16:07:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 08:50:09AM -0700, Jens Axboe wrote:
> DM currently has a statically allocated bio that it uses to issue empty
> flushes. It doesn't submit this bio, it just uses it for maintaining
> state while setting up clones. Multiple users can access this bio at the
> same time. This wasn't previously an issue, even if it was a bit iffy,
> but with the blkg associations it can become one.
> 
> We setup the blkg association, then clone bio's and submit, then remove
> the blkg assocation again. But since we can have multiple tasks doing
> this at the same time, against multiple blkg's, then we can either lose
> references to a blkg, or put it twice. The latter causes complaints on
> the percpu ref being <= 0 when released, and can cause use-after-free as
> well. Ming reports that xfstest generic/475 triggers this:
> 
> ------------[ cut here ]------------
> percpu ref (blkg_release) <= 0 (0) after switching to atomic
> WARNING: CPU: 13 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0
> 
> Switch to just using an on-stack bio for this, and get rid of the
> embedded bio.
> 
> Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Only other use case like this I could find is raid5-cache, which
> serializes access to its embedded bio (and actually submits it, too).
> That one looks fine.

With this patch, xfstests(generic/475) won't trigger the warning of
'percpu ref (blkg_release) <= 0 (0) after switching to atomic' any more.

Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
