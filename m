Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF69C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA44206BF
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 15:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgD0PK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:10:58 -0400
Received: from verein.lst.de ([213.95.11.211]:48920 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgD0PK5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 11:10:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E2D168C7B; Mon, 27 Apr 2020 17:10:55 +0200 (CEST)
Date:   Mon, 27 Apr 2020 17:10:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 06/11] block: optimize generic_make_request for direct
 to blk-mq issue
Message-ID: <20200427151055.GA6425@lst.de>
References: <20200425170944.968861-1-hch@lst.de> <20200425170944.968861-7-hch@lst.de> <20200426025352.GA512559@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426025352.GA512559@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 26, 2020 at 10:53:52AM +0800, Ming Lei wrote:
> blk_mq_make_request() still calls into generic_make_request(), so bio
> may be added to current->bio_list, then looks __direct_make_request()
> can't cover recursive bio submission any more.

True, we can't do the series as-is.
