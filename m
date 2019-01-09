Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35624C43444
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10713206BB
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfAIMMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:12:00 -0500
Received: from verein.lst.de ([213.95.11.211]:41151 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbfAIML7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 07:11:59 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9638E67358; Wed,  9 Jan 2019 13:11:57 +0100 (CET)
Date:   Wed, 9 Jan 2019 13:11:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 06/16] io_uring: support for IO polling
Message-ID: <20190109121157.GB13779@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-7-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 08, 2019 at 09:56:35AM -0700, Jens Axboe wrote:
> Add polled variants of the read and write commands. These act like their
> non-polled counterparts, except we expect to poll for completion of
> them.

These aren't really need command variants, but a different type of context.

>  	case IORING_OP_FSYNC:
> +		if (ctx->flags & IORING_SETUP_IOPOLL)
> +			break;
>  		ret = io_fsync(&req->fsync, iocb, false);
>  		break;
>  	case IORING_OP_FDSYNC:
> +		if (ctx->flags & IORING_SETUP_IOPOLL)
> +			break;
>  		ret = io_fsync(&req->fsync, iocb, true);

I'd move this check into io_fsync to avoid a little duplication.
