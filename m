Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdLLJS7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 04:18:59 -0500
Date: Tue, 12 Dec 2017 17:18:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 00/10] block: cleanup on direct access to bvec
 table(prepare for multipage bvec)
Message-ID: <20171212091844.GB8529@ming.t460p>
References: <20171208131409.11889-1-ming.lei@redhat.com>
 <20171212075738.GA26646@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212075738.GA26646@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 11, 2017 at 11:57:38PM -0800, Christoph Hellwig wrote:
> Most of this looks sane, but I'd really like to see it in context
> of the actual multipage bvec patches.  Do you have an updated branch
> on top of these?

I will post it out soon after addressing some of last comments.

Thanks,
Ming
