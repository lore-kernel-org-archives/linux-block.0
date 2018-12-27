Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D2C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7125214C6
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mvw7lU9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeL0NtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:49:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeL0NtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 08:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B8u/agfp1358tQLgq7NA9lF5SnAMqyU/lFLQg/eNLXY=; b=mvw7lU9uaU6oz+wf0DUGMCd30
        p3MpGdAKjApVjtvDM91yu95+VdULQZf9kn9Y95XtGNwLjLGm5EVzeV8YwvGBeQSwpUGIZMzPWGt8L
        TJkHvqPbCouUO/t+soYIiryb7QlSwharwhht6KmTN9IkoYvvTym5c5euWXBU3XEsfsn19Oa83/o85
        7F6LSIQsCEQI8EA8IgklilJVFStM0+6M+FW6MOfgMi4vDZmMlW38HPdHnDnu6jjLnxTz4MOQMmXsx
        h3NEm3OMXfkjPafXB4RX/BWX8GkfHflNaDredtV35wV6G1pJgQoTWbO1BlHesCqxrusZvquGXqhfi
        ydZzv87JQ==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcW27-0003FI-EF; Thu, 27 Dec 2018 13:49:19 +0000
Date:   Thu, 27 Dec 2018 14:47:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 16/22] aio: add support for submission/completion rings
Message-ID: <20181227134737.GA24160@infradead.org>
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-17-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221192236.12866-17-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 21, 2018 at 12:22:30PM -0700, Jens Axboe wrote:
> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO. We use the same
> structures as the old aio interface. The SQ rings are indexes into a
> struct iocb array, like we would submit through io_submit(), and the
> CQ rings are struct io_event, like we would pass in (and copy back)
> from io_getevents().
> 
> A new system call is added for this, io_ring_enter(). This system call
> submits IO that is stored in the SQ ring, and/or completes IO and stores
> the results in the CQ ring. Hence it's possible to both complete and
> submit IO in a single system call.

So this still reuses the aio interface, but I think that is a really
bad idea.  For one the aio_context_t which really is a chunk of memory
mapped into the user address space really make no sense at all here.

We'd much rather allocate a file descriptor using anon_inode_getfd
and operate on that.  That also means we can just close that fd
instead of needing the magic io_destroy, and save all the checks for
which kind of FD we operate on.

The big question to me is if we really need the polled version of
'classic aio'.  If not we could save io_setup2 and would just need
io_ring_setup and io_ring_enter as the new syscalls, and basically
avoid touching the old aio code entirely.

Also as another potential interface enhancement I think we should
consider pre-registering the files we want to do I/O to in the
io_ring_setup system call, thus avoiding fget/fput entirely
in io_ring_enter.  In general the set of files used for aio-like
operations is rather static and should be known at setup time,
in the worst case we might have to have a version of the setup
call that can modify the set up files (similar to how say
epoll works).

Also this whole API needs a better description, and a CC to the
linux-api list.

> +static void aio_commit_cqring(struct kioctx *ctx, unsigned next_tail)
> +{
> +	struct aio_cq_ring *ring = page_address(ctx->cq_ring.pages[0]);

I don't think we can use page_address here as the memory might be
highmem.  Same for all the other uses of page_address.

> +	range->pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);

This should use kcalloc.  Same for a few other instances.

> +static int __io_ring_enter(struct kioctx *ctx, unsigned int to_submit,
> +			   unsigned int min_complete, unsigned int flags)
> +{
> +	int ret = 0;
> +
> +	if (flags & IORING_FLAG_SUBMIT) {
> +		ret = aio_ring_submit(ctx, to_submit);
> +		if (ret < 0)
> +			return ret;
> +	}

I don't think we need the IORING_FLAG_SUBMIT flag - a non-zero
to_submit argument should be a good enough indicator.

Also this interface will need some cache flushing help, othewise
it won't work at all for architectures with VIVT caches.
