Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9835C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B027321871
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfA2R04 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:26:56 -0500
Received: from verein.lst.de ([213.95.11.211]:47478 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfA2R0z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 12:26:55 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 94A5F68CEC; Tue, 29 Jan 2019 18:26:54 +0100 (CET)
Date:   Tue, 29 Jan 2019 18:26:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 15/18] io_uring: add io_kiocb ref count
Message-ID: <20190129172654.GC15347@lst.de>
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-16-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128213538.13486-16-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 02:35:35PM -0700, Jens Axboe wrote:
> We'll use this for the POLL implementation. Regular requests will
> NOT be using references, so initialize it to 0. Any real use of
> the io_kiocb ref will initialize it to at least 2.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
