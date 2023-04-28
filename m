Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED37C77B60
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 05:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbjD1FuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 01:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345317AbjD1FuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:50:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAE4234
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:50:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 944CA68D0A; Fri, 28 Apr 2023 07:50:05 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:50:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 7/9] block: mq-deadline: Track the dispatch position
Message-ID: <20230428055005.GH8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-8-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 01:33:27PM -0700, Bart Van Assche wrote:
> Track the position (sector_t) of the most recently dispatched request
> instead of tracking a pointer to the next request to dispatch. This
> patch simplifies the code for inserting and removing a request from the
> red-black tree.

Can you explain what the simplification is?  As of this patch the
code looks more complicated to me..
