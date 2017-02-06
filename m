Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbdBFOYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2017 09:24:53 -0500
Date: Mon, 6 Feb 2017 06:24:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 4/4] md: fast clone bio in bio_clone_mddev()
Message-ID: <20170206142451.GA17008@infradead.org>
References: <1486275733-7268-1-git-send-email-tom.leiming@gmail.com>
 <1486275733-7268-5-git-send-email-tom.leiming@gmail.com>
 <20170206085433.GB6411@infradead.org>
 <CACVXFVNhB5i_5VJ4596ktLRnEM03GhqhZD-x+E_QwK1kZydTJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVNhB5i_5VJ4596ktLRnEM03GhqhZD-x+E_QwK1kZydTJg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 06, 2017 at 06:43:32PM +0800, Ming Lei wrote:
> In theory, ->bio_set still might be NULL in case of failed memory allocation,
> please see md_run().

And that's something that should be fixed.  Silently not having mempool
is very bad behavior.
