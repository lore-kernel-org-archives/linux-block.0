Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66237C433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 08:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKUIDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 03:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUIDQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 03:03:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6B15A28
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 00:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q/Aw0d5SsfCgXASAqR1GOUs8jYTu2jmEGDGWZFKrLWE=; b=cw5741AAxC3jVCcMqaCq/4puOw
        xgmU46gbuX9MXImvd2SC9GLgwZkq9E5snR+5mrwtedkYkfnFQTdUJBpZyHKKMxT/m3Qkt7GfWFWf9
        Jr+qHDCTxcNhekBH//iU0ffditzC20oXs2ojHxkuxtiK3TgYBclwS5j8yxOmdqtneBpleM7gHYl9I
        I0mjT1vURvLAN7ZxleFHsW015/s/yOZ8+9G+f6ZyaOJLlFTo/F7GHtkjuIynO37Vh+T7PTIgOZl+t
        Bo/SA812gF0j7O/L4GbMLETEyv//jiblWlM4OjFCF6/5fOceRY7OPaG6vQ/fMrHiFVlFoKp2qxplx
        eFLEuZ7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox1le-00AsJO-W7; Mon, 21 Nov 2022 08:03:03 +0000
Date:   Mon, 21 Nov 2022 00:03:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Message-ID: <Y3swtrdPaI5lGMpj@infradead.org>
References: <Y3YfUjrrLJzPWc4H@T590>
 <87fseh92aa.fsf@wdc.com>
 <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590>
 <8735ag8ueg.fsf@wdc.com>
 <Y3dscKle5oqLjSNT@T590>
 <87v8nc79cv.fsf@wdc.com>
 <Y3d+78qMOusdYUAG@T590>
 <be6940cf-7b23-4b11-1f6f-f3d4853d9a34@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6940cf-7b23-4b11-1f6f-f3d4853d9a34@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've been wading through this thread a bit, and while I can't follow
everything due some pretty bad reply trimming I'm really really
confused by this whole discussion.

Every single storage system, be that hard drives, SSDs, file systems
or what else much preferres sequential write.  Any code that turns
perfectly sequential writes into reverse sequential writes is a massive
performance bug, zoned or not.

So totally independent of zone device support in ublk this needs to be
fixed ASAP.
