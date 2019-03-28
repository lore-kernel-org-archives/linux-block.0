Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31EBC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773F220823
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfC1Rs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:48:58 -0400
Received: from verein.lst.de ([213.95.11.211]:47754 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfC1Rs5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:48:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E56768B02; Thu, 28 Mar 2019 18:48:47 +0100 (CET)
Date:   Thu, 28 Mar 2019 18:48:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, lkp@01.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [block] 4e366a7962: blktests.nvme.005.fail
Message-ID: <20190328174846.GA22610@lst.de>
References: <20190325010409.GB6379@shao2-debian> <bb98759a-2b51-9785-d903-282ca1ed91cb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb98759a-2b51-9785-d903-282ca1ed91cb@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 28, 2019 at 05:31:29PM +0100, Johannes Thumshirn wrote:
> In all cases I could reproduce it I had nsegs == 2 and
> rq->nr_phys_segments == 1 (rq->bio->bi_phys_segments == 1).

And all cases are pass through as well?

Can you check if this still shows up with the series from Ming which
switches the passthrough requests to use multi-page biovecs aswell
and gets rid of the hairy code you quote below.
