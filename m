Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49091C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 17:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154F023A5E
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 17:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbhAURNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 12:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388549AbhAURMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 12:12:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F0C06174A;
        Thu, 21 Jan 2021 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b4r0GzLAgyF8l8XKCsVbT4fA5aek9/RzgCt1cC8yk6M=; b=JjGNO8/Snl3Vsvi/ucOYGvbwQf
        Ty0B0MNaPn1IJ9ogl+h/tL7XnsfaZcMifvFRUpbxAZA28HP2orkt7G+6C0lwBlQ3hfCrEytIHE5vN
        Ftm8TK/5tkRqEIuqoP/piwnAvgdDitIa2M+TFNESW1s4KbntvWQ+gbXxMxjJtaZpQmZw/twpPpYvZ
        1DiWtFRkmMHW5gMwJJwEvE2E8eyjGMQnGzJqM18oHcAnv/Lu4rjqWsFIBl6k8WWIr2p8Z0xGjC0qJ
        bcWU531t2wLBROrXrCqgbr17umy1AfASIA0boWrLHo0oUAL3bpBocHEQLE/zYUoED2I5PwT2Yi96f
        LD7tjILA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2dUX-00HIgd-LQ; Thu, 21 Jan 2021 17:11:33 +0000
Date:   Thu, 21 Jan 2021 17:11:29 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 0/7] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <20210121171129.GA4122715@infradead.org>
References: <20210114154723.2495814-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 14, 2021 at 03:47:16PM +0000, Satya Tangirala wrote:
> When a bio has an encryption context, its size must be aligned to its
> crypto data unit size. A bio must not be split in the middle of a data
> unit. Currently, bios are split at logical block boundaries, but a crypto
> data unit size might be larger than the logical block size - e.g. a machine
> could be using fscrypt (which uses 4K crypto data units) with an eMMC block
> device with inline encryption hardware that has a logical block size of
> 512 bytes. So we need to support cases where the data unit size is larger
> than the logical block size.

I think this model is rather broken.  Instead of creating an -EIO path
we can't handle anywhere make sure that the size limits exposed by the
driver that wants to split always align to the crypto data units to
avoid this issue to start with.
