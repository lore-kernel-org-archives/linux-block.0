Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE391C433F5
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 02:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE40861502
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 02:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbhKRCF2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 21:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241265AbhKRCF2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 21:05:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E370A61507;
        Thu, 18 Nov 2021 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637200949;
        bh=2/mMgS1fYXN8z+rDKKdYxbHqXX0XX5RFlQCNUYQXicY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKuJSNpOMwe7ptbY5jY4n5dEtX5qS6jYw/rJSsSsJDUZLKG+kSvAGio35JhGF3O5V
         8VslyIezryRK7So/ZZnZrno3fcX+YqX2hP727pjF1xk4+cazNhK+fwrg7FgC27mOWL
         u0cnYWBw5rmJwdtjz1zvcxzcKJ8LiNm5JOV1qUOd5CvFghczn6WvSyWfT9VV3ohA6V
         I4o1TZQWFz4voJ42LLkP17mUrumCnh+86xquTdj/pu9cF+72YUBJ/+wAfNKjbN0E+I
         YCwWu/b7/e35EdymEzCIo0EycWcBA9t919zUpQha6r/oVeMAO4jpna2SzW8yr/fdgn
         d5FjVOb3wMRPA==
Date:   Wed, 17 Nov 2021 19:02:27 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <YZW0M61sJNMQIRVZ@C02CK6ZVMD6M>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk>
 <20211117204101.GA3295649@dhcp-10-100-145-180.wdc.com>
 <YZWb1TiNLBtdQrt6@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZWb1TiNLBtdQrt6@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 18, 2021 at 08:18:29AM +0800, Ming Lei wrote:
> On Wed, Nov 17, 2021 at 12:41:01PM -0800, Keith Busch wrote:
> > On Tue, Nov 16, 2021 at 08:38:04PM -0700, Jens Axboe wrote:
> > > If we have a list of requests in our plug list, send it to the driver in
> > > one go, if possible. The driver must set mq_ops->queue_rqs() to support
> > > this, if not the usual one-by-one path is used.
> > 
> > It looks like we still need to sync with the request_queue quiesce flag.
> 
> Basically it is same with my previous post[1], but the above patch doesn't
> handle request queue allocation/freeing correctly in case of BLK_MQ_F_BLOCKING.

Thanks for the pointer. I also thought it may be just as well that blocking
dispatchers don't get to use the optimized rqlist queueing, which would
simplify quiesce to the normal rcu usage.
