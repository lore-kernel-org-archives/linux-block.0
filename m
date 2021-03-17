Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A0EC433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 06:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506F964ED2
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 06:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCQGNa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 02:13:30 -0400
Received: from verein.lst.de ([213.95.11.211]:35529 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCQGNB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 02:13:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22B5968BEB; Wed, 17 Mar 2021 07:12:58 +0100 (CET)
Date:   Wed, 17 Mar 2021 07:12:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2] sbitmap: Silence a debug kernel warning triggered
 by sbitmap_put()
Message-ID: <20210317061257.GA14128@lst.de>
References: <20210317032648.9080-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317032648.9080-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
