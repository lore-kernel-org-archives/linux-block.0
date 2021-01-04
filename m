Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB5C433DB
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 18:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A6B21919
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 18:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhADSOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:14:25 -0500
Received: from verein.lst.de ([213.95.11.211]:58696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbhADSOZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 13:14:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DB3667373; Mon,  4 Jan 2021 19:13:43 +0100 (CET)
Date:   Mon, 4 Jan 2021 19:13:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] block: don't pass BIOSET_NEED_BVECS for
 q->bio_split
Message-ID: <20210104181343.GA2722@lst.de>
References: <20201230003255.3450874-1-ming.lei@redhat.com> <20201230003255.3450874-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230003255.3450874-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 30, 2020 at 08:32:51AM +0800, Ming Lei wrote:
> q->bio_split is only used by bio_split() for fast cloning bio, and no
> need to allocate bvecs, so remove this flag.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
