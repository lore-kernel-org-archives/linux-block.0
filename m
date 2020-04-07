Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50F3C2BA1A
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0663206C0
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 17:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGROy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:14:54 -0400
Received: from verein.lst.de ([213.95.11.211]:38771 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGROy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Apr 2020 13:14:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 148BF68C4E; Tue,  7 Apr 2020 19:14:52 +0200 (CEST)
Date:   Tue, 7 Apr 2020 19:14:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V6 2/8] blk-mq: add new state of BLK_MQ_S_INACTIVE
Message-ID: <20200407171451.GB5614@lst.de>
References: <20200407092901.314228-1-ming.lei@redhat.com> <20200407092901.314228-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407092901.314228-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 07, 2020 at 05:28:55PM +0800, Ming Lei wrote:
> Add a new hw queue state of BLK_MQ_S_INACTIVE, which is set when all
> CPUs of this hctx are offline.
> 
> Prepares for stopping hw queue when all CPUs of this hctx become offline.

It isn't set yet, is it?  So maybe ".. will be set..".  Or just merge
it into the patch that sets it, which might be easier to follow.
