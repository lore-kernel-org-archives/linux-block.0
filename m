Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F818C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68792075A
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZWy/rWek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbgKXJnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbgKXJnK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 04:43:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F93C0613D6;
        Tue, 24 Nov 2020 01:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M/iBLJL/EG5AgOHD7behYTBNDQkWYbGk8/XLqfCBQpc=; b=ZWy/rWekEoc/XtfyySU5aZH3J0
        Krzj7EjERitAmRkbozaSIaWZ9lY1bH8N/dvz6gSzYUo7HJUedIKRAM8RWGeJeX0UwZHPzTfx0AasE
        4QDj7Pg62EbANHgDbMrY/M9BbVARJzB6RTUWA0u5uuEVQv9/l4eOBqJ+iOx32TXZkXwz8mPNKODTy
        jR85yOpj4EBh+qFIL617dqd/PiV5S960MjELfXUnMimhT/JsAfYmiLmm5sqOb0uUAPZqF0CARUpY1
        NKx2Icsy9uqPXzF2qN8PJtUsWEYToJ5JOSio1aQeuHJUunm6jbKdxizTMdBX2U1ggAIFAON3vY4Iv
        tI+0ZbIg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUqr-0000SN-4t; Tue, 24 Nov 2020 09:43:09 +0000
Date:   Tue, 24 Nov 2020 09:43:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] blktrace: make relay callbacks const
Message-ID: <20201124094309.GI31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <7ff5ce0b735901eb4f10e13da2704f1d8c4a2507.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff5ce0b735901eb4f10e13da2704f1d8c4a2507.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:29PM +0200, Jani Nikula wrote:
> Now that relay_open() accepts const callbacks, make relay callbacks
> const.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
