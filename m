Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB3C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD098610EA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJMPzJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhJMPyY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:54:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90325C061749
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JN3YZejX5AoSFo5uTLmJzdqXJvuM84Hq2uxMksL3GlU=; b=hyIL9/7vKW/tSzEXtDaFLRGyGl
        1ii6qa8c64m3vJ8TdC6+nDmoGW0k5qBvT0+sBw5fKQ+4A9gxykfBhd3Znr/fDXv+wV2OnTvlKdzGo
        csMlSjBf9BNAqUcS19mp/yzNvhA6KZXsp8dBKQ3hxPWr3l+APwOBX/e7IXJZiYYmpFC/HbriiBEzV
        P6m7UXpWqN32F5CslgTEEByO0ks8T1Rxx6UrjiaBtjqmzjl9SBDXq0ozqXOWp8Pcja7Gqz6jgSRXt
        bp4h18AxLzqoA3xFHAm8XFlOFjumBgfb+H8PPrLDdwCFkX+u1OUqbJezUh6sCVXAqpPHpxyJaHzLN
        fKWjty6g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1magW3-007ZwN-Jp; Wed, 13 Oct 2021 15:50:43 +0000
Date:   Wed, 13 Oct 2021 16:50:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
Message-ID: <YWcAK5D+M6406e7w@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk>
 <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
 <YWb4SqWFQinePqzj@infradead.org>
 <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 09:42:23AM -0600, Jens Axboe wrote:
> Something like this?

Something like that.  Although without making the new function inline
this will generate an indirect call.
