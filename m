Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F539C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9196109F
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbhESJlE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhESJlE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 05:41:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024EC06175F
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L7MS9kwGwSnlT82PCo8WgRL7/Ip//oBhIAZRrAplkQI=; b=TcS41KTzks+DmbcG5hzB2MseR9
        LpqFSwaeDsQa3MXS+xdg7lwsjoCPrIjEJu9ifPs7PU+7gBmj48P48RP8T4hROQ1fju6lGfWzesWM4
        EHIXD1CQBUMB3hZrKS6xbWXqRhSAPYb4OUrSoueWdBJkRw7TH8ydc8wtDGK2Mz5HpCUn4ApYUErJH
        IULqf21xiu0Ux5eu5vfZWQE3CqVab6S+N7awbLvXvbMCorytbZgAS92r53eyhATVPKq1yt2R+m0w4
        6wkuIDehJCF8hqogQyceTUfEqfYCEHwbOEnailwqVWjRamBBQGX5YwWkusgYbaWkmOvRC/ytUwsmo
        OW7SzxMg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljIez-00EoRd-H9; Wed, 19 May 2021 09:38:57 +0000
Date:   Wed, 19 May 2021 10:38:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/11] block: introduce bio zone helpers
Message-ID: <YKTcneinm2vWqJl2@infradead.org>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-3-damien.lemoal@wdc.com>
 <PH0PR04MB7416EC127D2BB9639E82E1579B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416EC127D2BB9639E82E1579B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 19, 2021 at 07:17:04AM +0000, Johannes Thumshirn wrote:
> Can't we derive the queue from the bio via bio->bi_bdev->bd_disk->queue
> or would this be too much pointer chasing for a small helper like this?

Yes, we can should do away with the pointless q argument.
