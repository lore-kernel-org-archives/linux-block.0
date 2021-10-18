Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE33F60F59
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 18:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJRSDX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:03:23 -0400
Received: from verein.lst.de ([213.95.11.211]:35387 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhJRSDW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 14:03:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D5BD68AFE; Mon, 18 Oct 2021 20:01:10 +0200 (CEST)
Date:   Mon, 18 Oct 2021 20:01:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 6/6] block: align blkdev_dio inlined bio to a cacheline
Message-ID: <20211018180109.GC4232@lst.de>
References: <20211018175109.401292-1-axboe@kernel.dk> <20211018175109.401292-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018175109.401292-7-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
