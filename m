Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdLLH5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 02:57:40 -0500
Date: Mon, 11 Dec 2017 23:57:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/10] block: cleanup on direct access to bvec
 table(prepare for multipage bvec)
Message-ID: <20171212075738.GA26646@infradead.org>
References: <20171208131409.11889-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208131409.11889-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Most of this looks sane, but I'd really like to see it in context
of the actual multipage bvec patches.  Do you have an updated branch
on top of these?
