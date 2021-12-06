Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB4C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 07:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhLFHoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhLFHn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 02:43:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFEAC0613F8
        for <linux-block@vger.kernel.org>; Sun,  5 Dec 2021 23:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=chmrmGnE9hkGaC0+CM5+OKTy7P4tk4m1kYI9Tg5TMFw=; b=R0elMboIg6v4di5kGk6iMt9Nha
        DpVNey4JT5fQl87jXXXcHl3YBE41NYtoqxtW9PzVqN03YL5KtiIRznRFMWQXqBSHdLGz5fjSJRY6M
        3vpsr9XKxNEILE7G4nwn50mLITAWG37eJAAaUX6ritZkHz1uPplnNYRVZDqHp8ksJ1C+cRFqoNpMt
        FUaBItryVyaxGOwFMn24O/l4hW2vuUHcJ5C9Dk7VUsQPqkRo2ElSYGQAomwJxAiJM13U+PIXrR1CB
        X0M7UKcM3CVMVKNS5c7gqAzHxTux0p4/Qw0KzJRJY2e/FIqT8oU3u4J9cdrBlWfWndzuiRZhraY60
        pORR4hUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu8bu-002mcu-NE; Mon, 06 Dec 2021 07:40:30 +0000
Date:   Sun, 5 Dec 2021 23:40:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <Ya2+buqfKSFHWVvu@infradead.org>
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203214544.343460-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 03, 2021 at 02:45:44PM -0700, Jens Axboe wrote:
> This enables the block layer to send us a full plug list of requests
> that need submitting. The block layer guarantees that they all belong
> to the same queue, but we do have to check the hardware queue mapping
> for each request.
> 
> If errors are encountered, leave them in the passed in list. Then the
> block layer will handle them individually.
> 
> This is good for about a 4% improvement in peak performance, taking us
> from 9.6M to 10M IOPS/core.

This looks pretty similar to my proposed cleanups (which is nice), but
back then you mentioned the cleaner version was much slower.  Do you
know what brought the speed back in this version?
