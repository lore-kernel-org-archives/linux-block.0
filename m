Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3EDC433E0
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 08:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4282087E
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 08:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbhADI4l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 03:56:41 -0500
Received: from verein.lst.de ([213.95.11.211]:56925 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADI4l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 03:56:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87CFD68AFE; Mon,  4 Jan 2021 09:55:59 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:55:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] block: set .bi_max_vecs as actual allocated vector
 number
Message-ID: <20210104085559.GC28949@lst.de>
References: <20201230003255.3450874-1-ming.lei@redhat.com> <20201230003255.3450874-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230003255.3450874-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 30, 2020 at 08:32:53AM +0800, Ming Lei wrote:
> bvec_alloc() may allocate more bio vectors than requested, so set .bi_max_vecs as
> actual allocated vector number, instead of the requested number. This way can help
> fs build bigger bio because new bio often won't be allocated until the current one
> becomes full.

Overly long lines above.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
