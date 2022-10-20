Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEDCC433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 08:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTIcU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJTIcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 04:32:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B2165C93;
        Thu, 20 Oct 2022 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lZniaKMxG9ACzQr0eHnJ4s9IgEGgM6CKvE9MDqlY+MM=; b=2tntOe3TKz5J0uTSsNutdZFKhD
        ArLoALj6dqXLhxcMeb9GMj4ZpgZA/p1aiNuUulq2TGzhfjnHQOfPr0NCdQIB6nS7czTLC/KNAQH/N
        T1uoStohp0dc4+P6GuOxkDR1TK2RhAFArfwJ5t0oYgomVslHAa8PFzf+6DYsxJmnuK1DQ4UhuOUhi
        zCajeqVL4g7dgSTR/2qiZYbAKVxCaloYpTH/gwGJ+WSQTS6GWPPSvmhfjjiA1LDErPSjec9YzMxpt
        /H0JOkwpxoYORgMt3LYWoV+AFmH4OCaO+lpbkWaehQEGHn/DqZmT64Pt12ZR3piXJkQSKSybT+No6
        k3Du7Sng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olQyL-00CEuc-N0; Thu, 20 Oct 2022 08:32:13 +0000
Date:   Thu, 20 Oct 2022 01:32:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC for-next v2 0/4] enable pcpu bio caching for IRQ I/O
Message-ID: <Y1EHjbhS1wuw3qcr@infradead.org>
References: <cover.1666122465.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666122465.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 08:50:54PM +0100, Pavel Begunkov wrote:
> This series implements bio pcpu caching for normal / IRQ-driven I/O
> extending REQ_ALLOC_CACHE currently limited to iopoll. The allocation side
> still only works from non-irq context, which is the reason it's not enabled
> by default, but turning it on for other users (e.g. filesystems) is
> as a matter of passing a flag.
> 
> t/io_uring with an Optane SSD setup showed +7% for batches of 32 requests
> and +4.3% for batches of 8.

This looks much nicer to me than the previous attempt exposing the bio
internals to io_uring, thanks.
