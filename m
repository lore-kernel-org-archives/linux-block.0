Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC2C7EE24
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 09:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjEOJ1a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbjEOJ1E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 05:27:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B84185
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JkFgJiPcWkUgDXFSZR1RHXBqUEvUwsaai8/9s9Bp2a8=; b=z8A+Irwiu9MrTfsjMVhoQESrfR
        59YlU1Q5yUuyZ7QTDUb9Y6Jxf6Q3FtWrCZtx1bdE8Np17XXfz6lzwIh/D5L4VqSM5Vid65ec2RXwh
        xXafC7T04F5c+SV9c5cMExTIFC/yC0PVpH6rzp76hc7+JjaHS71ktYq1lKRucNuyrxoB4K9xqv5/2
        FJmaJju15meNL4F2eKDpWHUAWtsBl+ZT3gwowEcBkcuriZeMFV+Bw+2UAL1PdPJlbRsSl2N+FEApX
        0qp3c3InLa9FyBB0T0xhJk/qgVtUfOcAFXXAlKGk8ljwiSbUpYpPO2nMw/MKQzzpNCWDWCovY7P45
        PpgZFC1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pyUTc-001Xxp-0M;
        Mon, 15 May 2023 09:26:44 +0000
Date:   Mon, 15 May 2023 02:26:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Deny writable memory mapping if block is read-only
Message-ID: <ZGH61Jmp2qxPwNnO@infradead.org>
References: <20230510074223.991297-1-loic.poulain@linaro.org>
 <ZFub1U5f1qR5hOwX@infradead.org>
 <CAMZdPi99xo5FfSbUydvP4RNqWvDGcOCccckhdXs6S7paOa5W+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi99xo5FfSbUydvP4RNqWvDGcOCccckhdXs6S7paOa5W+w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 10, 2023 at 04:17:01PM +0200, Loic Poulain wrote:
> No, because the file itself is writable, but not the underlying block.

Eww.

> I agree, it would make more sense to simply deny the block open fops
> instead... but it could be considered as uapi breakage as we may have
> some existing applications opening the device RW, and simply
> ignore/discard the sys write errors for ro devices...

True.  I suspect the right thing might be to still only open the device
read-only.  Which brings us to the next mess that ->open for block
devices is only called once, but different openers might have different
flags (with write and nodelay being the once that matter).

> but if it's
> acceptable let's do it. For sure, we could argue that making the mmap
> failing is also a change in uapi behavior,

We really should fail it.  Unlike the device open, where allowing it
feels wrong to me, but at least has use cases being able to create a
shared writable mmap doesn't have any point.

> but except reconsidering
> a32e236eb93e which may be obsolete today, I don't see a better
> solution to prevent unwanted writing.

I think we need to absolutely reconsider it (in addition to your patch),
especially as I just got another report related to it.  I'll need to
talk to the DM folks to figure out if we can do a workaround in dm
somehow.
