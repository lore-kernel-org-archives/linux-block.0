Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2AC61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 06:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBPGJq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 01:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBPGJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 01:09:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7A460B1
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 22:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=doTNjNWwsf9dk5t1tl6Y/TQYymga/EJA7bzx9nlk+5g=; b=SGSI5Ls6vxnsYZ0pjRZk6uJyMH
        2yntJqnwgVM7jSQomqyw5ooRrFysHUSvA7sDW9m2oKdqjbM4TFIICgalwcFZy55JpUV+UJeKBE+B+
        n+cFsuAXlB/h67X91LxwdUQhuWfL3ODZT2wJ7NWCAR2TGBXlqhWosgVM/fxQBw3Fgtr//NddSxvhr
        H1r1WTu5Q21v4Un10RQ2gH28nWtQktNlwbUKUhh9fIwyBsOPzj9EhuKa/EVVnEXbuH1i77aSV5y5s
        bajjdB1Ce9AeWKxp6MirUcHWvnTzbZjff8kh/EMoPdAIoc/P9zm4rtbvqCZ0sSlFWIw2CdcNXKL/K
        RnL7UBig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXSa-008eXO-9U; Thu, 16 Feb 2023 06:09:36 +0000
Date:   Wed, 15 Feb 2023 22:09:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <Y+3IoOd02iFGNLnC@infradead.org>
References: <20230215201507.494152-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215201507.494152-1-ushankar@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 15, 2023 at 01:15:08PM -0700, Uday Shankar wrote:
> The block layer might merge together discard requests up until the
> max_discard_segments limit is hit, but blk_insert_cloned_request checks
> the segment count against max_segments regardless of the req op. This
> can result in errors like the following when discards are issued through
> a DM device and max_discard_segments exceeds max_segments for the queue
> of the chosen underlying device.
> 
> blk_insert_cloned_request: over max segments limit. (256 > 129)
> 
> Fix this by looking at the req_op and enforcing the appropriate segment
> limit - max_discard_segments for REQ_OP_DISCARDs and max_segments for
> everything else.

I'd just remove the debug check entirely.

