Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F373FC4338F
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 07:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D782760E95
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 07:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhGXG4g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhGXG4g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jul 2021 02:56:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E914C061575;
        Sat, 24 Jul 2021 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FqhIgv8Rf1Zf62r3AOuw/s00sKaxHUe15ND2GKynq64=; b=vNajFkx6Jv5X4wPfPRaWpwo+np
        1PcC/dhBP5n1scFWTkeTN3sxEekyaebs4tqMrK2kQK/+5IcXCc2TlRBQgrOFR7fnzhRN5bTpbRPll
        HCGIuyuj6fUPJJtWhc+aTKW69C+kWKnIn7oDy//pzoNjZ9va7NREzp12daD5c2LJYDkJwzJnqsrls
        ygMyZGIqlvsaQYNcMyk5Y/xeER+0iRHj3aQqXCyvKkTyIyxvAHDxmshOYjbl/uKB48Q/1ptJ3pRg0
        YuRs6cgJ8+7b75UKnXL5FXp9e4Tj+s2Fhg0RLg7/HJSD7GzoEV9YAssT31rsdXaHo29BIyEzpOgbd
        AjLw7i/A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7CDM-00C5kP-Oi; Sat, 24 Jul 2021 07:36:57 +0000
Date:   Sat, 24 Jul 2021 08:36:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v4 0/9] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YPvDFH7uAP+Jas/X@infradead.org>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:34PM -0700, Satya Tangirala wrote:
> When a bio has an encryption context, its size must be aligned to its
> crypto data unit size. A bio must not be split in the middle of a data
> unit. Currently, bios are split at logical block boundaries, but a crypto
> data unit size might be larger than the logical block size - e.g. a machine
> could be using fscrypt (which uses 4K crypto data units) with an eMMC block
> device with inline encryption hardware that has a logical block size of 512
> bytes.
> 
> Right now, the only user of blk-crypto is fscrypt (on ext4 and f2fs), which
> (currently) only submits bios where the size of each segment is a multiple
> of data_unit_size.  That happens to avoid most of the cases where bios
> could be split in the middle of a data unit.  However, when support for
> direct I/O on encrypted files is added, or when support for filesystem
> metadata encryption is added, it will be possible for bios to have segment
> lengths that are multiples of the logical block size, but not multiples of
> the crypto data unit size.  So the block layer needs to start handling this
> case appropriately.

I'm still not sold on this case yet.  sector size aligned I/O is an
optional feature, and I don't think it is worth this overhead.  And
while file systems metadata can be smaller than the file system block
size in a few cases (e.g. XFS log writes), that is usually an extra
performance optimization and can be trivially disabled in mkfs.
