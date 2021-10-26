Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F5C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84717610A0
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhJZHjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 03:39:24 -0400
Received: from verein.lst.de ([213.95.11.211]:60772 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhJZHjY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 03:39:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68E8D6732D; Tue, 26 Oct 2021 09:36:59 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:36:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/8] loop: fallback to buffered IO in case of dio
 submission
Message-ID: <20211026073658.GD31967@lst.de>
References: <20211025094437.2837701-1-ming.lei@redhat.com> <20211025094437.2837701-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094437.2837701-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 05:44:34PM +0800, Ming Lei wrote:
> DIO submission on underlying file may fail because of unaligned buffer or
> start_sector & sector_length, fallback to buffered IO when that happens,
> this way will make loop dio mode more reliable.

I don't think this is a good idea.  Just do an ahead of time check
that the alignment matches and don't even try to use direct I/O code
in that case.  Otherwise we get a mix and match between buffered and
direct I/O, which is actively harmful.
