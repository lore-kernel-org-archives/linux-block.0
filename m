Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BEFC433E6
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 08:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E6C21D79
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 08:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhADI5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 03:57:16 -0500
Received: from verein.lst.de ([213.95.11.211]:56927 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbhADI5Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 03:57:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE32E6736F; Mon,  4 Jan 2021 09:56:34 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:56:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] block: move three bvec helpers declaration into
 private helper
Message-ID: <20210104085634.GD28949@lst.de>
References: <20201230003255.3450874-1-ming.lei@redhat.com> <20201230003255.3450874-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230003255.3450874-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
> +extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
> +extern unsigned int bvec_nr_vecs(unsigned short idx);

Please drop the externs while you're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
