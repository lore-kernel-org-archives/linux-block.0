Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029EB610C9
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhJZHiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 03:38:10 -0400
Received: from verein.lst.de ([213.95.11.211]:60768 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhJZHiJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 03:38:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9277E6732D; Tue, 26 Oct 2021 09:35:44 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:35:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/8] loop: cover simple read/write via lo_rw_aio()
Message-ID: <20211026073544.GC31967@lst.de>
References: <20211025094437.2837701-1-ming.lei@redhat.com> <20211025094437.2837701-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094437.2837701-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -	cmd->iocb.ki_complete = lo_rw_aio_complete;
> -	cmd->iocb.ki_flags = IOCB_DIRECT;
> +
>  	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
> +	if (!cmd->use_dio) {
> +		atomic_set(&cmd->ref, 1);
> +		cmd->iocb.ki_flags = 0;
> +		cmd->ret = lo_call_backing_rw_iter(file, &cmd->iocb, &iter, rw);
> +		lo_rw_aio_do_completion(cmd);
> +		return 0;
> +	}

I don't think we even need the special casing.  If you just use the
AIO path here for buffered I/O it will do the same for you at the
small price of an extra refcount operation.

FYI, this seems to be against a kernel that still has cryptoloop/transfers.
