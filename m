Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529AFC43461
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D61E20639
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 15:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIBPlG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:41:06 -0400
Received: from verein.lst.de ([213.95.11.211]:60153 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgIBNpA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 09:45:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEAE168B02; Wed,  2 Sep 2020 15:44:56 +0200 (CEST)
Date:   Wed, 2 Sep 2020 15:44:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 2/2] block: move 'q_usage_counter' into front of
 'request_queue'
Message-ID: <20200902134456.GB32502@lst.de>
References: <20200902122643.634143-1-ming.lei@redhat.com> <20200902122643.634143-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902122643.634143-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 02, 2020 at 08:26:43PM +0800, Ming Lei wrote:
> The field of 'q_usage_counter' is always fetched in fast path of every
> block driver, and move it into front of 'request_queue', so it can be
> fetched into 1st cacheline of 'request_queue' instance.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
