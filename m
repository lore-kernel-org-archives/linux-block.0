Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BC7C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02C420989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfA2G3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:29:42 -0500
Received: from verein.lst.de ([213.95.11.211]:44285 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfA2G3m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 01:29:42 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 507FF68CEB; Tue, 29 Jan 2019 07:29:40 +0100 (CET)
Date:   Tue, 29 Jan 2019 07:29:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 09/13] io_uring: add submission polling
Message-ID: <20190129062940.GB2996@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-12-axboe@kernel.dk> <20190128150926.GB10110@lst.de> <9cf014d9-cf16-fa49-83f0-0e9ddb57cc81@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf014d9-cf16-fa49-83f0-0e9ddb57cc81@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 10:05:37AM -0700, Jens Axboe wrote:
> >> 2) Probably want the application to pass in the appropriate grace
> >>    period, not hard code it at 1 second.
> > 
> > 2) actually sounds really useful.  Should we look into it ASAP?
> 
> I think so. Question is what kind of granularity we need for this. I
> think we can go pretty coarse and keep it in msec, using a short to
> pass this in like we do for the thread CPU. That gives us 0..65535 msec,
> which should be plenty of range.

msec granualarity sounds fine.  But is it really worth using a short
instead of a 32-bit value these days?

Also 16385 seems very limiting for a cpu value, especially as our
normal cpu ids are ints.
