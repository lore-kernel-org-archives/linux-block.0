Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6CC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5521741
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ueAcoq6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbgKZKCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbgKZKCa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:02:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D1C0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LxBtHLItEAPa5SIJLi2a65fmDJR7Y0p/wX0QHsR3Ylo=; b=ueAcoq6lWX0OpfTrLrymqs9TdE
        KBokiBd5qxHwma1IIwgtbfxonjywilmV3dPGMfki4fO470Kp/bSj/vZGIxm4zjpXHAdBDPGm0H8qP
        RRHPT1skVbGoAITL5CQoxp2Rn3daZq7OYhz8mbZap7e1Kb+VesAkZKKdrW4oKpTaLeNZKzHJdsd3r
        fO06I+wtgXGUntCMIG4zKMyQK5AxR6u58jHINLO2FUkwepjhPMbbSyDUTu/cttFTX5h9Q2X1qsGso
        ym+6/wEjM8+rwF7xSLSZg4DHq2LG0/I9KJhHuL9OkGzJj2S8q4qZABgTD38zMIVAJ48IS8Qj8MSpP
        NoRzDAtg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiE6d-0000cp-O6; Thu, 26 Nov 2020 10:02:27 +0000
Date:   Thu, 26 Nov 2020 10:02:27 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] bio: optimise bvec iteration
Message-ID: <20201126100227.GB949@infradead.org>
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

Are you sure about bio_advance_iter()?  That API looks like it might
not always be limited to a single segment, and might at least need a
WARN_ON_ONCE to make sure it is not abused.
