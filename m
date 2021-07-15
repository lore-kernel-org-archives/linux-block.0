Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5A3C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4176128C
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhGOHRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbhGOHRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 03:17:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C2C06175F;
        Thu, 15 Jul 2021 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nthw7+H9DsL3CqcVPXgloMpkXopb6k/WOK6hCfAUI9E=; b=Yf5fDEh/TbD3agyP0vCxl08zZk
        VxIVuUOtkRIotrEii4sjruD/CK52P0fMofWhTiSQF0W9GJbjsKHc7xMT4Hxyt8UbMJynwnmza9AIa
        uSnR+JA68HQ1w1H4nWotj1TORoXTli9/2s4yiDMkD4c0We/pLGidninGkJBsCBt3t7wIMtFgDjtGX
        LgwFgGoR18bggom19evLRe+N0KYCqoqcZgwclLF21d09GnyJX8UU9VPAgADErdMiVwsfSMSMc82AW
        GcalPNYUjjyHY9/xqgzKCEMfVmnJJoolCIyLmCm5V7aq2Va9owd6CnSHY/kVOKJGPD0uNeUajGpiM
        6o6mztkw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3vXJ-0035SQ-FE; Thu, 15 Jul 2021 07:12:26 +0000
Date:   Thu, 15 Jul 2021 08:11:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] block: skip queue if NULL on blk_cleanup_queue()
Message-ID: <YO/fvbe5LeAP2Mtq@infradead.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715045531.420201-7-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 14, 2021 at 09:55:31PM -0700, Luis Chamberlain wrote:
> Now that error handling for add_disk*() calls is added, we must
> accept a common form for when errors are detected on the the
> add_disk*() calls, and that is to call blk_cleanup_disk() on
> error always. One of the corner cases possible is a driver bug
> where the queue is already gone and we cannot blk_get_queue(),
> and so may be NULL. When blk_cleanup_disk() is called in this
> case blk_cleanup_queue() will crash with a null dereference.
> 
> Make this an accepted condition and just skip it. This allows us
> to also test for it safely with error injection.

So you plan to call blk_cleanup_disk when add_disk fails?

For all drivers using blk_alloc_disk/blk_mq_alloc_disk there should
always be a queue.  The others ones aren't ready to handle errors
from add_disk yet in any way I think (and I plan to fix this up
ASAP).
