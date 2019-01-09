Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC1BC43444
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5404A20665
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfAISbC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:31:02 -0500
Received: from verein.lst.de ([213.95.11.211]:43299 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfAISbC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 13:31:02 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BFC2967358; Wed,  9 Jan 2019 19:30:59 +0100 (CET)
Date:   Wed, 9 Jan 2019 19:30:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Message-ID: <20190109183059.GA21824@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-6-axboe@kernel.dk> <20190109121030.GA13779@lst.de> <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 09, 2019 at 08:53:31AM -0700, Jens Axboe wrote:
> >> +static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
> >> +		       struct iovec **iovec, struct iov_iter *iter)
> >> +{
> >> +	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
> >> +	size_t ret;
> >> +
> >> +	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
> >> +	*iovec = NULL;
> >> +	return ret;
> >> +}
> > 
> > Is there any point in supporting non-vectored operations here?
> 
> Not sure I follow?

This version only supports non-vectored read and write, that is
the equivalent of pread/pwrite.  Many AIO users really need vectored
operations, that is preadv/pwritev semantics indirecting through
a struct iovec array.  The non-vectored version can be trivially
emulated using a vector of 1, which is what we do in the kernel
I/O stack everywhere.  So I think we should just support the vectored
version here, and not the non-vectored one.  See my io_uring branch
for the sketeched implementation.
