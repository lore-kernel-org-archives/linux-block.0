Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704C0C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 06:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1D6601FF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 06:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhKBGND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGNC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 02:13:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A6C061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LkFVnSPEbauH7cUr4oINuBC90Uvd3m6zLNXw54Uz18A=; b=etbQs9OUZA9owvwFvtneZNfsLp
        krN4q9cqEC9Iaky55ea3o5BG0c0raXU2nd3ghlFrGy1YD8rNLAvx+awpGdRrNifgvv6w/zbIKoj3n
        8UBrf1v156p+l+OQcThhp8nRm8cUoe+BQcUGcEsRu5p1lDOjw2cu0AragwSlBmQCMPY/KmINR1gbu
        6hlUQgKeRZVDvi+7qjB1qxk1nKQmisb7dNdBUapudU4QicWVRlhQuvm0RaTX3vx0N5SizCroEqtZ1
        HQy61w6tmPCPyUBUG5VRwgykRgqiMGlyPULFlUe3Ehqjxh8tTDB7dfBs/ls5DQzYu4h4NHAyGbQxp
        MhNysp/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhn04-000dod-Fh; Tue, 02 Nov 2021 06:10:24 +0000
Date:   Mon, 1 Nov 2021 23:10:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] bdev size cleanups
Message-ID: <YYDWUCZ0YIXhlbxT@infradead.org>
References: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
 <CAHk-=wii3c_VebHJxEyqU5P6FKjOLirYHQm+0=oaL59DNi-t1A@mail.gmail.com>
 <71c40f9b-7f83-be81-18cf-297077db005c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c40f9b-7f83-be81-18cf-297077db005c@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 01, 2021 at 05:19:58PM -0600, Jens Axboe wrote:
> Yes, probably safer just to make bdev_nr_bytes() return sector_t as
> well, even if loff_t isn't strictly wrong. Christoph, want to do a
> followup?

sector_t is wrong.  I actually did that in the very first version
accidentally and willy pointed out that this is wrong.  If Linus really
wants that we can add the cast.
