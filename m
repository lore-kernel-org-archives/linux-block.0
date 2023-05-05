Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B36C77B75
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 04:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjEEEEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 00:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjEEEEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 00:04:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46B1987;
        Thu,  4 May 2023 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJhatz1D3S4pgo3fhtDKJJtaX7Ot4usQSOKKkQ2zfAI=; b=MvlZUJqJ5TRwZt7ezPq/PMD2Mt
        9Vfk6q9uX9Cngmvo+DahcUF1JOjHHrNb7qCMF1dPU3Dbr3wvaE8EMQ8peEqyGhPbg/TkmKmTNRAS1
        0599VYRSMtkm+mDGcj0uiV0/IGBGACQOILEQKq6whVvFxVbC8DWwYZDRXv+vXXBdM5M2q0QqmtiHd
        JADbi0UPSbg+M5VxyhyKdeQi3PhDDPWBarxHNrYkWJKgRCqiHEb+EVMyGM9rIGcpi7u22Xa4WG9sY
        s9Deis9dhzKEFPCYsAVQc9RrbWt7zjSrWmTv1EPNZw0Vl56lANTsBJLU+x1ZuGfYj+6yg4TTxOi+I
        LJvwq7og==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pumgG-00BDMR-Dx; Fri, 05 May 2023 04:04:28 +0000
Date:   Fri, 5 May 2023 05:04:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 01/11] rust: add radix tree abstraction
Message-ID: <ZFSATHV0gY8raccj@casper.infradead.org>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-2-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503090708.2524310-2-nmi@metaspace.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 11:06:58AM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add abstractions for the C radix_tree. This abstraction allows Rust code to use
> the radix_tree as a map from `u64` keys to `ForeignOwnable` values.

Please, no.  The XArray interface is the preferred one; the radix tree
is legacy.  Don't make Rust code use the radix tree.  It has the GFP
arguments in the wrong place, for one thing.
