Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35553 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756116AbcIVNvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2016 09:51:16 -0400
Date: Thu, 22 Sep 2016 06:51:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Guoqing Jiang <gqjiang@suse.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] block: export bio_free_pages to other modules
Message-ID: <20160922135114.GA9036@infradead.org>
References: <1474528201-23359-1-git-send-email-gqjiang@suse.com>
 <073a35bb-7b09-e47b-b0d9-d177aab8aba1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <073a35bb-7b09-e47b-b0d9-d177aab8aba1@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 22, 2016 at 07:48:39AM -0600, Jens Axboe wrote:
> On 09/22/2016 01:10 AM, Guoqing Jiang wrote:
> > bio_free_pages is introduced in commit 1dfa0f68c040
> > ("block: add a helper to free bio bounce buffer pages"),
> > we can reuse the func in other modules after it was
> > imported.
> 
> Applied for 4.9, thanks.

And what exactly are the users?  I'd much rather look at those first.
