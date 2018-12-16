Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22386C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB50A2082F
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeLPQmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:42:23 -0500
Received: from verein.lst.de ([213.95.11.211]:57936 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbeLPQmX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:42:23 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BFD6F68DD3; Sun, 16 Dec 2018 17:42:21 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:42:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        jmoyer@redhat.com, clm@fb.com
Subject: Re: [PATCHSET v8] Support for polled and buffered aio (and more)
Message-ID: <20181216164221.GA13930@lst.de>
References: <20181213175645.22181-1-axboe@kernel.dk> <20181216163405.GA13234@lst.de> <2c38c940-414f-519a-c938-8d94c249e477@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c38c940-414f-519a-c938-8d94c249e477@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 09:37:25AM -0700, Jens Axboe wrote:
> On 12/16/18 9:34 AM, Christoph Hellwig wrote:
> > Any chance you could send the series that just optimize the existing
> > aio code and don't need new interface as an initial prep series?
> > 
> > Batching things up should make it a little easier to review, and with
> > a little luck those "simple" patches might still make 4.21.  Make
> > sure to include Al on the series, please.
> 
> Sure, I can do that. So basically all of the optimizations, but none of
> the features (like polling)? Would require serious refactoring though,
> but not impossible.
> 
> Or do you mean everything up to polled IO for old style aio, just
> excluding the new ring interfaces?

No, just the various little optimizations and cleanups towards the
beginning of the series.  Shouldn't really require any refactoring.

> 
> -- 
> Jens Axboe
---end quoted text---
