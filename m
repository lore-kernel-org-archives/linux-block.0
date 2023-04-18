Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3614DC77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 04:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDRE5c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDRE51 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 00:57:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB642D50
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 21:57:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0906C67373; Tue, 18 Apr 2023 06:57:20 +0200 (CEST)
Date:   Tue, 18 Apr 2023 06:57:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash when bio_for_each_folio_all
 iterates over an empty bio
Message-ID: <20230418045719.GA29490@lst.de>
References: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com> <ZD2e5lw5CqueygSA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD2e5lw5CqueygSA@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 17, 2023 at 08:32:54PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 17, 2023 at 03:11:57PM -0400, Mikulas Patocka wrote:
> > If we use bio_for_each_folio_all on an empty bio, it will access the first
> > bio vector unconditionally (it is uninitialized) and it may crash
> > depending on the uninitialized data.
> 
> Wait, how do we have an empty bio in the first place?

flush bios are always empty.  Not sure iterating over them makes much
sense, though.
