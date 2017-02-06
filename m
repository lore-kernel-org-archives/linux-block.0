Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750956AbdBFIyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2017 03:54:36 -0500
Date: Mon, 6 Feb 2017 00:54:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 4/4] md: fast clone bio in bio_clone_mddev()
Message-ID: <20170206085433.GB6411@infradead.org>
References: <1486275733-7268-1-git-send-email-tom.leiming@gmail.com>
 <1486275733-7268-5-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486275733-7268-5-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Feb 05, 2017 at 02:22:13PM +0800, Ming Lei wrote:
> Firstly bio_clone_mddev() is used in raid normal I/O and isn't
> in resync I/O path.
> 
> Secondly all the direct access to bvec table in raid happens on
> resync I/O except for write behind of raid1, in which we still
> use bio_clone() for allocating new bvec table.
> 
> So this patch replaces bio_clone() with bio_clone_fast()
> in bio_clone_mddev().

Having the _fast in the name would be really useful for the
reader.  And as far as I can tell in the callers mddev is never
NULL and neither is ->bio_set, so replacing bio_clone_mddev with
raw calls to bio_clone_fast would be my preference.
