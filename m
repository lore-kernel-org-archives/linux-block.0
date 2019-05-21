Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E972C04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13F921773
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEUM7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 08:59:55 -0400
Received: from verein.lst.de ([213.95.11.211]:60148 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbfEUM7z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:59:55 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1E37268AFE; Tue, 21 May 2019 14:59:32 +0200 (CEST)
Date:   Tue, 21 May 2019 14:59:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] block: rename BIO_QUEUE_ENTERED as BIO_SPLITTED
Message-ID: <20190521125931.GC4577@lst.de>
References: <20190515030310.20393-1-ming.lei@redhat.com> <20190515030310.20393-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515030310.20393-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 15, 2019 at 11:03:10AM +0800, Ming Lei wrote:
> cd4a4ae4683d ("block: don't use blocking queue entered for recursive
> bio submits") introduces BIO_QUEUE_ENTERED to avoid blocking queue entered
> for recursive bio submits. Now there isn't such use any more. The only
> one use is for cgroup accounting on splitted bio, so rename it
> as BIO_SPLITTED.

Actually - this now is only used for accounting.  What about renaming the
flag to BIO_ACCOUNTED and just test and set it in blkcg_bio_issue_check?

That function looks way too big to be inline while we're at it..
