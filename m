Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FD4ECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 18:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ1SC7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ1SC5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 14:02:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7A1B65EC
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NR7Ke4sUoaP4D1c/8wF+ZBo548vp8xVJ2gklDnbrSmQ=; b=Qumabwewp7jLQVpiE0xAQZPeXw
        zRskF15BjqXGHz+RrRVrm34FK2qe92vl4xWC01MP1bBgtz7eu2hVezf0gdaYuM6ZS/tJgtv/YMLZL
        7zwoqao7IZZTmRnYakSyEw0gqrkdkXBlY6NTrXIAPKKY//kVrjpn2dLKEz9Kssn1394Wb6T1zyYnv
        sHGWVKvz/LXHs4FMwus4V8G4GkkOP+iYX6D5uPnYrYOOLSZmGmYbfQt5ZpXanxl7EJvwqJF7aNDn6
        SQaEUDDMNonW6xi5VZ8tsSQjXAGFjSmu0pDyEKRNlSrTgw9uJmWQ+eJUIdAGht4lZGyqOcVl2yQn/
        e8JUxwKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooTh0-00F0d0-1h;
        Fri, 28 Oct 2022 18:02:54 +0000
Date:   Fri, 28 Oct 2022 19:02:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
Subject: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn and
 max_pfn wrong way
Message-ID: <Y1wZTtENDq3fvs6n@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

	We have this:

static inline bool blk_queue_may_bounce(struct request_queue *q)
{
        return IS_ENABLED(CONFIG_BOUNCE) &&
                q->limits.bounce == BLK_BOUNCE_HIGH &&
                max_low_pfn >= max_pfn;
}

static inline struct bio *blk_queue_bounce(struct bio *bio,
                struct request_queue *q)
{
        if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
                return __blk_queue_bounce(bio, q);
        return bio;
}

Now, the last term in expression in blk_queue_may_bounce() is
true only on the boxen where max_pfn is no greater than max_low_pfn.

Unless I'm very confused, that's the boxen where we don't *have*
any highmem pages.

What's more, consider this:

static __init int init_emergency_pool(void)
{
        int ret;

#ifndef CONFIG_MEMORY_HOTPLUG
        if (max_pfn <= max_low_pfn)
                return 0;
#endif

        ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
        BUG_ON(ret);
        pr_info("pool size: %d pages\n", POOL_SIZE);

        init_bounce_bioset();
        return 0;
}

On the same boxen (assuming we've not hotplug) page_pool won't be set up
at all, so we wouldn't be able to bounce any highmem page if we ever
ran into one.

AFAICS, this condition is backwards - it should be

static inline bool blk_queue_may_bounce(struct request_queue *q)
{
        return IS_ENABLED(CONFIG_BOUNCE) &&
                q->limits.bounce == BLK_BOUNCE_HIGH &&
                max_low_pfn < max_pfn;
}

What am I missing here?
