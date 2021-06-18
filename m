Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC8C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC27161351
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhFROfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:35:50 -0400
Received: from verein.lst.de ([213.95.11.211]:35199 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234585AbhFROfr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 10:35:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 36A0168D08; Fri, 18 Jun 2021 16:33:37 +0200 (CEST)
Date:   Fri, 18 Jun 2021 16:33:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH 4/4] dm: support bio polling
Message-ID: <20210618143336.GB19284@lst.de>
References: <20210616130533.754248-1-ming.lei@redhat.com> <20210616130533.754248-5-ming.lei@redhat.com> <YMohOUlopTcO1Bzd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMohOUlopTcO1Bzd@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 16, 2021 at 12:05:13PM -0400, Mike Snitzer wrote:
> In general I'm really happy to see polling switch over to using bios,
> nice job Christoph! Are you hoping for all this to land in time for
> 5.14 merge?

Yes, although time is running out.

> Once Ming responds to my review inlined below, and I Acked-by his
> set, would you be willing to fold it at the end of your patchset so
> that I don't need to rebase on block to get these changes in, etc?

In principle yes, but I need to take a look first.
