Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12DEC433E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 07:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F1420848
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 07:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n+IoMjgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404513AbgJPHTn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404399AbgJPHTn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 03:19:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC2C061755;
        Fri, 16 Oct 2020 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1P9w9u3qcroAFsEKoQTf2CUIsIxd2xOaHJsIpH8VZXg=; b=n+IoMjgMxCixm8P514TfCKSvC8
        nY5+bNKvVQDdUID4OdW6wq2PbKzFEdIBuWFvhw6O9MutWf9LjHY7ogGBluYejt9RtPfjJiqY+PIrt
        KNYzAzZWX8PLxxy0xJMEzaw+6vd7UQrXGuOcW8+JK/UQC374x/XbSJ5PugaElRWAZI2IUEB/ly87+
        34TZICEmIxAF3lmAA+zCj7LrsoaoKpkkd2pYd47tHmGtpI8X3+4ogVhBPStgi0wTxxNzvNE9bjvyd
        cmW0QHYExnsp18c0q5aEiqJxXMUYqo9mCIADvPSywAD0dbiOsiJYPEuEurXVur4QgEfvlCkKaeoH5
        CaeXaqHw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTK1d-00049y-2X; Fri, 16 Oct 2020 07:19:41 +0000
Date:   Fri, 16 Oct 2020 08:19:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 2/4] block: add private field to struct keyslot_manager
Message-ID: <20201016071941.GA14885@infradead.org>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015214632.41951-3-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 15, 2020 at 09:46:30PM +0000, Satya Tangirala wrote:
> Add a (void *) pointer to struct keyslot_manager that the owner of the
> struct can use for any purpose it wants.
> 
> Right now, the struct keyslot_manager is expected to be embedded directly
> into other structs (and the owner of the keyslot_manager would use
> container_of() to access any other data the owner needs). However, this
> might take up more space than is acceptable, and it would be better to be
> able to add only a pointer to a struct keyslot_manager into other structs
> rather than embed the entire struct directly. But container_of() can't be
> used when only the pointer to the keyslot_manager is embded. The primary
> motivation of this patch is to get around that issue.

No, please don't bloat the structure.  If some weird caller doesn't
like the embedding it can create a container structure with the
blk_keyslot_manager structure and a backpointer.
