Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89898C433DB
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538242087E
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 08:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbhADI4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 03:56:17 -0500
Received: from verein.lst.de ([213.95.11.211]:56920 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbhADI4R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 03:56:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 835886736F; Mon,  4 Jan 2021 09:55:35 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:55:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] block: don't allocate inline bvecs if this bioset
 needn't bvecs
Message-ID: <20210104085535.GB28949@lst.de>
References: <20201230003255.3450874-1-ming.lei@redhat.com> <20201230003255.3450874-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230003255.3450874-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 30, 2020 at 08:32:52AM +0800, Ming Lei wrote:
> The inline bvecs won't be used if user needn't bvecs by not passing
> BIOSET_NEED_BVECS, so don't allocate bvecs in this situation.

Looks sensible.

> -	bs->bio_slab = bio_find_or_create_slab(front_pad + back_pad);
> +	bs->bio_slab = bio_find_or_create_slab(bs->front_pad + bs->back_pad);

Passing the bioset to bio_find_or_create_slab and returning an errno
might be a nicer calling convention now.
