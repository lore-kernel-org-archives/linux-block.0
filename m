Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C95C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33E0613AF
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 14:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhELOt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhELOt0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 10:49:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58642C061574;
        Wed, 12 May 2021 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6qER5CBKsbNlRlz0pP9tX3PI2r+bhUbYf6ZB05djsns=; b=oEFbiCrod3cplqF2BzOY/m7iRM
        P37ADaOWG7bepT9Zh44ELoa+7uDnbRZjp1kzxR4XsxkkHsOPTP/jx2NNJ1JWgD2QNwPOMXJ7SObmN
        QRIVRRna5wfJjVRAAk7+izH/d3yWXCdrxK5bMmkeejP8s4JUwM3sRqZs+6qBxv0QckDrNuQm79jW/
        A7zDGeYlUZ8WoEWfhVy80TWqfNSaV2atpoYlOdO4tcLVycuISeLttsFrNsnG873e4a+zsDqmtE6kO
        3u8V9yHVJdrzqNzlCpkvVLKfQtKYSfC95MbR12p8uA7/ja68WjMXRkOfp+jKehaF0SAWso6RdZi1f
        m37LmMWw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgq6Z-008Ncg-SM; Wed, 12 May 2021 14:45:09 +0000
Date:   Wed, 12 May 2021 15:44:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] block: add error handling for *add_disk*()
Message-ID: <YJvp5x8ZaeFnvvlK@infradead.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just FYI, I have a large series to clean up a lot of the
disk/request_queue allocation and cleanup.  Which should help
with actually adding add_disk error handling to drivers, and has
some as far as I can tell minor context conflicts with your work.
