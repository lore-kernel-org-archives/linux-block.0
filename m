Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9748C7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 06:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKGoN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 02:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKGoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 02:44:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA3E60
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 23:44:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B76068C7B; Tue, 11 Apr 2023 08:44:08 +0200 (CEST)
Date:   Tue, 11 Apr 2023 08:44:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2 09/12] block: mq-deadline: Disable head insertion
 for zoned writes
Message-ID: <20230411064408.GB19616@lst.de>
References: <20230407235822.1672286-1-bvanassche@acm.org> <20230407235822.1672286-10-bvanassche@acm.org> <81ccc853-63f6-5be4-7ab3-fc95c128b7f9@kernel.org> <a3355a43-6c2e-005e-06cc-a050a75ad623@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3355a43-6c2e-005e-06cc-a050a75ad623@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 10, 2023 at 10:09:40AM -0700, Bart Van Assche wrote:
> The code for deciding whether or not to use head insertion is spread all 
> over the block layer. I prefer a single additional check to disable head 
> insertion instead of modifying all the code that decides whether or not to 
> use head-insertion. Additionally, the call to blk_rq_is_seq_zoned_write() 
> would remain if the decision whether or not to use head insertion is moved 
> into the callers of elevator_type.insert_request.

I think it's time to do a proper audit and sort this out.

at_head insertations make absolute sense for certain passthrough commands,
so the path in from blk_execute_rq/blk_execute_rq_nowait is fine, and it
should always be passed on, even for zoned devices.

For everything else head insertations looks very questionable and I
think we need to go through them and figure out if any of them should
be kept.
