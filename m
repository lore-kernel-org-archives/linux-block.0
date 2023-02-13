Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139EEC636D4
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 09:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBMJzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 04:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMJzK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 04:55:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF01093D4;
        Mon, 13 Feb 2023 01:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5A81SQZCM3oCZOBdiivWgIMjZUpD2rR5vq5eenMNxWc=; b=exyMVC7q5QEIFjyTqpqlKpxLGg
        aROVLYBrnx0GFc0NLvUDh1t76yskNWp+6tq39kfwqlsRVxHhJXlBwZPA0pSrzaei4GWEPb5PaQk4A
        pm7FV8kRqWX9DPR7ce1xAfjlhKqb+epp2M6PDJy5fOhlqJhBsT2iPZuWFnixnA0ccz2w+249rfEIh
        4yv+OlkF4YOAepLc8bEnzdLMrHfkQ2ivIjiZ1r5V47G1I9oQCozG8CDCYDwRuQYJfrA16LkdBjYwJ
        uuBN6RhpyahMWam6dLajTiq4mSBYyH9ZO49UKlGa9dvWBXzWnRQlWJiCxng50hSo2Eovd0y2k3ZWD
        v3idfR7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRVY8-00DzeM-5O; Mon, 13 Feb 2023 09:55:04 +0000
Date:   Mon, 13 Feb 2023 01:55:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Message-ID: <Y+oI+AYsADUZsB7m@infradead.org>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
 <Y+Ucq8A+WMT0ZUnd@casper.infradead.org>
 <20230210112954.3yzlyi4hjgci36yn@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210112954.3yzlyi4hjgci36yn@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 10, 2023 at 12:29:54PM +0100, Jan Kara wrote:
> functionally that would make sense but as I've mentioned in my reply to you
> [1], the problem here is the performance. I've now dug out the discussion
> from 2018 where John actually tried to take pinned pages out of the LRU [2]
> and the result was 20% IOPS degradation on his NVME drive because of the
> cost of taking the LRU lock. I'm not even speaking how costly that would
> get on any heavily parallel direct IO workload on some high-iops device...

I think we need to distinguish between short- and long terms pins.
For short term pins like direct I/O it doesn't make sense to take them
off the lru, or to do any other special action.  Writeback will simplify
have to wait for the short term pin.

Long-term pins absolutely would make sense to be taken off the LRU list.
