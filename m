Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A3C1B08C
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD986128D
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhGOHKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 03:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhGOHKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 03:10:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9487C06175F;
        Thu, 15 Jul 2021 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WRAskvpqiHo1Ie/RJZydKPMRyIzB4rMKQskw/+5e8es=; b=hYyJEIHxFWjqJRzosOMOFzdV3p
        riuWIQbs9UV1ZZcHRXjzjcyfE+L3jTaXr8seH6bF5ZMDda5jI+ZVJguoGZ2c+ndbvzXCIddGxPHv6
        SUOIuCnDaAmIwP0g9zNLs3xfyIHvlg62UWqJsISzun8CJu7Wxs2o3YgpZOPHlx4wEBngpWiH17MOu
        DfPP30s6nFEmSDrU4qvP6Lr4YMCS87i5OKpa4EXxh3NKjbm0Aiz6wc2BlvfgvlPsmOSO8Q2oesEYF
        Kkl3FnE4zf0cjAuhDyH/HBnDNunBQbzJf8p1dIHL8e3ylvHgNcmvaFLtxJNxMorUEBEDleVVK81nT
        ny6lA0HQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3vRF-0035AU-NJ; Thu, 15 Jul 2021 07:05:55 +0000
Date:   Thu, 15 Jul 2021 08:05:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] block: move disk announce work from
 register_disk() to a helper
Message-ID: <YO/eRW4VL1UFlNS5@infradead.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715045531.420201-3-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 14, 2021 at 09:55:27PM -0700, Luis Chamberlain wrote:
> This moves quite a bit of code which does one thing into a helper.
> We currently do not check for errors but we may decide that might
> be desirable later.
> 
> This also makes the code easier to read.
> 
> This change has no functional changes.

On it's own I don't really see the point of moving two function
calls and a comment into a separate helper, but I'll see where this
series goes..
