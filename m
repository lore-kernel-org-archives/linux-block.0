Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB49C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648E164E07
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 16:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBPQiB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBPQiB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 11:38:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568FC061574
        for <linux-block@vger.kernel.org>; Tue, 16 Feb 2021 08:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k5FmjGZ4SmehAv0LCCEnqbiICd77AxIE4vwqKTv/VVY=; b=FiNM92LUAezK9JHAiQBxQtMLf6
        7xHSn8hpiyfiGV5BH3KZfeImKm3TpPxDF9mOAI1iIIZuEUUs0FFY+ENK0GhDT4w1Q82sR8TGbjb0a
        iVtBgIKMbNTft7Y1CUjmP9Kyv8DfG5uH2BuVaR0ugFE49pTBYDI/re8D6e9rACDZrmng+DiXrhuRh
        vb2rryGgl+uK6lq/JZoAry8yObP75gUvmzTv9wCt1ICwtTdrFDkk26Hla1QtM6C9oTmpeigGn0dIY
        aI684iQLppuknyXaUvHj4WOBQ84+Wnyy7DlfxBXjwA2Z5n3VPboCHouvtXnmWwltabJIVhRG2B4HB
        EzsiX8Vw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lC3KY-00H3k0-DR; Tue, 16 Feb 2021 16:36:10 +0000
Date:   Tue, 16 Feb 2021 16:36:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Message-ID: <20210216163606.GA4063489@infradead.org>
References: <20210216133849.8244-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216133849.8244-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 16, 2021 at 02:38:49PM +0100, Jan Kara wrote:
> Apparently there are several userspace programs that depend on being
> able to call BLKDISCARD ioctl without the ability to grab bdev
> exclusively - namely FUSE filesystems have the device open without
> O_EXCL (the kernel has the bdev open with O_EXCL) so the commit breaks
> fstrim(8) for such filesystems. Also LVM when shrinking LV opens PV and
> discards ranges released from LV but that PV may be already open
> exclusively by someone else (see bugzilla link below for more details).
> 
> This reverts commit 384d87ef2c954fc58e6c5fd8253e4a1984f5fe02.

I think that is a bad idea. We fixed the problem for a reason.
I think the right fix is to just do nothing if the device hasn't been
opened with O_EXCL and can't be reopened with it, just don't do anything
but also don't return an error.  After all discard and thus
BLKDISCARD is purely advisory.
