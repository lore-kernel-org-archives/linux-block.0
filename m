Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF33C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2CA21D7F
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 14:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgLBO5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 09:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLBO5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 09:57:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8EFC0613CF
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sgBnxOCb2Zx71jXwclIhqg2guNjE7H6/xcO7mm8eIzU=; b=auxq2Y4cXnOztf9RcfWtrMXf9Q
        Fdb20HMWQBJHJPcKzliZE5Br+mAds+6hZjbjIPDVYSRHPljNT3mB+UVqUWnVR0kvtjsDnQ5Ujy8Gi
        gxeY3/6XbUvPo4daOGBrKN4K7rjMSYxApQmeQXXRqwhZVkiQZHjUmQ0p/aLEp4eys+pUKC1z/dz2h
        M0twXjTot1mmgi1J0HKgTqe/ZkiOjpMlXfo59/37EgMvcA7HjH2t01uV+DtNVVWEA0nmpij7vBwJj
        03lzu4wTV8UeUyINFLfOXS6Oae7rP9bSeAEaTGkz/HlnWCWEWTEYHb36uJm5Xf2e37cUIFshWK6f9
        OC2rFvSA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkTYx-00065i-Kv; Wed, 02 Dec 2020 14:56:59 +0000
Date:   Wed, 2 Dec 2020 14:56:59 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] bio: optimise bvec iteration
Message-ID: <20201202145659.GA22887@infradead.org>
References: <cover.1606240077.git.asml.silence@gmail.com>
 <e1acd31d91a1e9501a5420d6ac1488a4412a0353.1606240077.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1acd31d91a1e9501a5420d6ac1488a4412a0353.1606240077.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 24, 2020 at 05:58:13PM +0000, Pavel Begunkov wrote:
> __bio_for_each_bvec(), __bio_for_each_segment() and bio_copy_data_iter()
> fall under conditions of bvec_iter_advance_single(), which is a faster
> and slimmer version of bvec_iter_advance(). Add
> bio_advance_iter_single() and convert them.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
