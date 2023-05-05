Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E355AC77B7C
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 06:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEEGJu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 02:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjEEGJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 02:09:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22951150EC;
        Thu,  4 May 2023 23:09:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 200BD68B05; Fri,  5 May 2023 08:09:42 +0200 (CEST)
Date:   Fri, 5 May 2023 08:09:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 01/11] rust: add radix tree abstraction
Message-ID: <20230505060941.GA12147@lst.de>
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-2-nmi@metaspace.dk> <ZFSATHV0gY8raccj@casper.infradead.org> <87wn1ns7kt.fsf@metaspace.dk> <ZFST5HAr6IQAhpjx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFST5HAr6IQAhpjx@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 05, 2023 at 06:28:04AM +0100, Matthew Wilcox wrote:
> But the radix tree API is simply a different (and worse) API to the
> exact same data structure as the XArray.  Using the XArray instead of
> the radix tree is still an apples-to-apples comparison.

And if he wants to do a 1:1 comparism, just convert null_blk to
xarray, which would actually be more useful work than this whole
thread..
