Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FCC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F9461243
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbhDLJxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244124AbhDLJv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:51:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68017C0612FF
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ACmYiNXhSir4M9ELYi+eVYDDStvpn6kWnrrlMpaeudo=; b=ZCvpWMlWjRjE9zOIcJlH5EtR48
        RnC+hXdpQ5I7rJ84mxpSbIgBu+7fBrNqgH7G5WDetYJSM8N4jt5expsvndFW0hhFPXg1YrHGl10sf
        /A5lq5DQ1fgVa0bE5rLtgrgAjBm71R0MeR1I0e5wp1OXIu9uysTt8Vdrg3ZTiUf5hbxkWj+O0kl/d
        4/xXLqmcwIRYNcuPnczv7P6ZGs46DAPckC8xbPRlzXzdo1HkILryCXR1vdu5aKXFHyPZTSsXb5ztU
        qTwoF1OndxYuO26dxvidWdvzWsMIeXkYNJyRoY5ag6/cFeYI8rSpiDvFbOYmpeMDIKg+bMM2ityr3
        kOLUVpSA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVt9E-00488b-2b; Mon, 12 Apr 2021 09:46:26 +0000
Date:   Mon, 12 Apr 2021 10:46:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 00/12] block: support bio based io polling
Message-ID: <20210412094624.GB981912@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I really struggly to review this series.  A lot of the code and
especially code organization is really strange.  For example a
signiciant chunk of the bio based poll logic is added to blk-mq.c where
it obviously does not fit in, and a lot of the patches seems to both
change blk-mq logic and add new bio based logic.  Also the bio poll
logic is split over various patches in a way that is absolutel not
obvious to me.

Can you try to restructure this a bit:

 - move everything that cleans up or improves existing logic to the
   beginning of the series and into separate patches (where that isn't
   already the case)
 - keep the actual bio polling logic together where the functionality
   isn't otherwise useful
 - maybe add a new block/bio-poll.c file to keep all the code togeher?
