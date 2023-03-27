Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CBFC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjC0PUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0PUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 11:20:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1BF26BC
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 08:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89565B81616
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 15:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC601C433EF;
        Mon, 27 Mar 2023 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679930432;
        bh=V6CJmOFpL4dQOWubVnr93eLiyRj1ygYnVyfNNo7iD6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpKrYkFFAZSFkso3ZAJLI465UV04m/ab7Y33a8dRkxdz1LzgsujHxTcnrZ5xCTGYy
         qPySwJ5CLXqFKPjAf4uuI4mjZADKVpha0yUnyUA4jEhSyYUqiKNqqLCNR9pRZ8MtiW
         YL+nb2CqVTtOwtnp5k3TmBMFmw2WVYdsibJkjuzCxsnt5q2WPrhFPJHzoRWLsGQ8e+
         fh8aLfeJUN095J4cfsT37vpi2w5AyYJDwbOIHV9TjWyMo4VaC2r+eup2t2PvP8+9Nt
         lFT4LUwY1UsxrbdEIZrSN6N/jnijjzuyVW7gmsO54F7UiS3s64cfyb6YeHcDSCU/8f
         vyMq2ajrEie9g==
Date:   Mon, 27 Mar 2023 09:20:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <20230327135810.GA8405@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327135810.GA8405@green5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 07:28:10PM +0530, Kanchan Joshi wrote:
> > -	}
> > +	if (blk_rq_is_poll(req))
> > +		WRITE_ONCE(ioucmd->cookie, req);
> 
> blk_rq_is_poll(req) warns for null "req->bio" and returns false if that
> is the case. That defeats one of the purpose of the series i.e. poll on
> no-payload commands such as flush/write-zeroes.

Sorry, I'm sending out various patches piecemeal. This patch here depends on
this one sent out earlier:

  https://lore.kernel.org/linux-block/3f670ca7-908d-db55-3da1-4090f116005d@nvidia.com/T/#mbc6174ce3f9dbae38ae2ca646518be4bf105f6e4

> > 	rcu_read_lock();
> > -	bio = READ_ONCE(ioucmd->cookie);
> > -	ns = container_of(file_inode(ioucmd->file)->i_cdev,
> > -			struct nvme_ns, cdev);
> > -	q = ns->queue;
> > -	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
> > -		ret = bio_poll(bio, iob, poll_flags);
> > +	req = READ_ONCE(ioucmd->cookie);
> > +	if (req) {
> 
> This is risky. We are not sure if the cookie is actually "req" at this
> moment.

What else could it be? It's either a real request from a polled hctx tag, or
NULL at this point.

It's safe to check the cookie like this and rely on its contents. The queue's
hctx's can't change within an rcu section, and the cookie is cleared in the
completion path prior to the request being free'd. In the worst case, we're
racing another polling thread completing our request while simultaneously
trying to renumber the hctx's, but the request and the current hctx it points
are reliable if we see non-NULL.

> If driver is loaded without the poll-queues, we will not be able
> to set req into ioucmd->cookie during the submission (in
> nvme_uring_cmd_io). Therefore, the original code checked for QUEUE_FLAG_POLL
> before treating ioucmd->cookie as bio here.

You don't need to check the queue's FLAG_POLL after the request is allocated.
The user can't change this directly, and this flag can't be changed with
requests in flight, so checking blk_rq_is_poll() is the only thing we need to
rely on.

> This should handle it (on top of your patch):

This doesn't work with multipath.
