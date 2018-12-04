Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8654C07E85
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BA42081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BA42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeLDOsX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:48:23 -0500
Received: from verein.lst.de ([213.95.11.211]:44195 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDOsW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 09:48:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E7D2F68BDB; Tue,  4 Dec 2018 15:48:20 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:48:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 05/27] block: ensure that async polled IO is marked
 REQ_NOWAIT
Message-ID: <20181204144820.GC3180@lst.de>
References: <20181130165646.27341-1-axboe@kernel.dk> <20181130165646.27341-6-axboe@kernel.dk> <1543597960.4347.3.camel@acm.org> <6044f9e1-0175-823b-b923-998094bdca72@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6044f9e1-0175-823b-b923-998094bdca72@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 10:17:49AM -0700, Jens Axboe wrote:
> > Setting REQ_NOWAIT from inside the block layer will make the code that
> > submits requests harder to review. Have you considered to make this code
> > fail I/O if REQ_NOWAIT has not been set and to require that the context
> > that submits I/O sets REQ_NOWAIT?
> 
> It's technically still feasible to do for sync polled IO, it's only
> the async case that makes it a potential deadlock.

I wonder if we want a REQ_ASYNC_POLL compound flag #define that sets
REQ_POLL and REQ_NOWAIT to make this blindly obvious.
