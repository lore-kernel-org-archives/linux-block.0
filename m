Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F13AC282DA
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061D720857
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UeE2LcmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfDISRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:17:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDISRn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 14:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w4Tq1tlD1boxk5aZkvP55taQSNxKwcRyVY1dumhNGOI=; b=UeE2LcmTeAh20O8k5k6RvyAk8
        AOR0rCbN2dd3lCKoV6MrYu8FExp40szAdowOJd6Fa0ay8gNYE452laKROK497ZzWqrCHbakL9pLJx
        TisYe9MPALrzmGNugCkLCHK8CfYdxt7+aiqHYcbzwJ45D2WJGFqmnVDFAFybt9Htsjzb2nMeMpJI1
        e8FSIGwfTyMGvv06ZmCUlYZQa12D7P1aBYzHxT3ZCnvtJfZ5vfl1YNg9vWKHDTSw5qeJYLS5v7COF
        PHmcsv8g05sxfj9z9pVRntQbLQQF2MNnVWN7h2Hf+tnGEoJADxM36tAGDaLPfJe6UVSA5LFwFD6WZ
        eVXnOMhHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDvJW-00080j-C9; Tue, 09 Apr 2019 18:17:42 +0000
Date:   Tue, 9 Apr 2019 11:17:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io_uring: add support for barrier fsync
Message-ID: <20190409181742.GA24925@infradead.org>
References: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 09, 2019 at 10:27:43AM -0600, Jens Axboe wrote:
> It's a quite common use case to issue a bunch of writes, then an fsync
> or fdatasync when they complete. Since io_uring doesn't guarantee any
> type of ordering, the application must track issued writes and wait
> with the fsync issue until they have completed.
> 
> Add an IORING_FSYNC_BARRIER flag that helps with this so the application
> doesn't have to do this manually. If this flag is set for the fsync
> request, we won't issue it until pending IO has already completed.

I think we need a much more detailed explanation of the semantics,
preferably in man page format.

Barrier at least in Linux traditionally means all previously submitted
requests have finished and no new ones are started until the
barrier request finishes, which is very heavy handed.  Is that what
this is supposed to do?  If not what are the exact guarantees vs
ordering and or barrier semantics?
