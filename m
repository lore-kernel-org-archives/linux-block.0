Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53997C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 06:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbhLCG5S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 01:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhLCG5R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 01:57:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3FC06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 22:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ZZE3/Ljntn1z1q95AUKTVYM27K/t6FLhsse4caWupE=; b=aFcZ3NsGEXHmN5Grt+mY5P38jH
        M30xTDPHGVs7gErBXaOqjkXwr+g56FuwMMvwhYV+yGWLKbbsaRB9LDeZfv584cs5OICaxvk7Iv1X1
        XP9NKzeuL+Dnsg/IRAF3sxkQnbRTuVQYqub9xDagGC5OFu2p/gQMQSHIA6h0WGjQVvqWmg5XNWCGD
        qNtzfjHQUI+qlHiYWXfBESEY48REjDBZ9FYVUlJvajjTuVIrrdKHmyKx56E6lH2+az4w7t9VVAfN4
        cnc7j0aqwu1KXu1ZcnqFdWwz1cEdG4SUBD0wzjOtEcpJs7YrmOXThXOzVuzTlko+xlaqg8vxdrJrF
        aRRnHn7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt2SA-00EdJh-4C; Fri, 03 Dec 2021 06:53:54 +0000
Date:   Thu, 2 Dec 2021 22:53:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 1/2] block: get rid of useless goto and label in
 blk_mq_get_new_requests()
Message-ID: <Yam/Apdg/8nq+wru@infradead.org>
References: <20211202194741.810957-1-axboe@kernel.dk>
 <20211202194741.810957-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202194741.810957-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 02, 2021 at 12:47:40PM -0700, Jens Axboe wrote:
> Expected case is returning a request, just check for success and return
> the request rather than having an error label.

I have to say the current flow is much easier to read, but the new
version is indeed shorter.
