Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAECC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D9C20871
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFekyBy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D9C20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeKSSmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:42:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeKSSmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2PjvxPPElomiQ+FnuJ1wqWPn4doQnI2t097MbRX/HJc=; b=QFekyBy5pPPV20sLM8S2azWf7
        0rtio/oppimLSVeU2L6JNPMr2QAWmFkyraNoefuhMgjWmqoSXgPOQ1rkh+GzFoheK3zFp7YS8LxG7
        k/2k/PlhHgiN/WRotX+VZMCRCj1/4ritalJFfT9r93PKOOnnFQX4A0VKQu64EQPk5GMbujhy+jiFL
        ED8n1Ou5XklSIaAluI/BR9SrikGS6b37eIjMNTvR0qaiZ9Xp0N3o8C6m12rgdqZyevBhRVVgXtNfs
        JJQM16s3hQSs/k/sppNnqRtadB9h3jXCkLhgy/LIFoYDbeVYt+giYM5dh9O0CXXbycqfrfpNV9sAA
        rW/1eIFAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOeml-0002CE-A4; Mon, 19 Nov 2018 08:19:59 +0000
Date:   Mon, 19 Nov 2018 00:19:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] block: Initialize BIO I/O priority early
Message-ID: <20181119081959.GR9622@infradead.org>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-8-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119035131.11255-8-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 12:51:31PM +0900, Damien Le Moal wrote:
> For the synchronous I/O path case (read(), write() etc system calls), a
> BIO I/O priority is not initialized until the execution of
> blk_init_request_from_bio() when the BIO is submitted and a request
> initialized for the BIO execution. This is due to the ki_ioprio field of
> the struct kiocb defined on stack being always initialized to
> IOPRIO_CLASS_NONE, regardless of the calling process I/O context ioprio
> value set with ioprio_set(). This late initialization can result in the
> BIO being merged to pending requests even when the I/O priorities
> differ.
> 
> Fix this by initializing the ki_iopriority field of on stack struct
> kiocb using the get_current_ioprio() helper, ensuring that all BIOs
> allocated and submitted for the system call execution see the correct
> intended I/O priority early. With this, since a BIO I/O priority is
> always set to the intended effective value for both the sync and async
> path, blk_init_request_from_bio() can be simplified.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
