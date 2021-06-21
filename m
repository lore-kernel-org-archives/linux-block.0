Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA84DC48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9628F60FDC
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFUHjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:39:13 -0400
Received: from verein.lst.de ([213.95.11.211]:40911 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUHjN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 03:39:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 295EE68BEB; Mon, 21 Jun 2021 09:36:57 +0200 (CEST)
Date:   Mon, 21 Jun 2021 09:36:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH V2 3/3] dm: support bio polling
Message-ID: <20210621073656.GB6896@lst.de>
References: <20210617103549.930311-1-ming.lei@redhat.com> <20210617103549.930311-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617103549.930311-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 06:35:49PM +0800, Ming Lei wrote:
> +	/*
> +	 * Only support bio polling for normal IO, and the target io is
> +	 * exactly inside the dm io instance
> +	 */
> +	ci->io->submit_as_polled = !!(ci->bio->bi_opf & REQ_POLLED);

Nit: the !! is not needed.

> @@ -1608,6 +1625,22 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
>  	ci->map = map;
>  	ci->io = alloc_io(md, bio);
>  	ci->sector = bio->bi_iter.bi_sector;
> +
> +	if (bio->bi_opf & REQ_POLLED) {
> +		INIT_HLIST_NODE(&ci->io->node);
> +
> +		/*
> +		 * Save .bi_end_io into dm_io, so that we can reuse .bi_end_io
> +		 * for storing dm_io list
> +		 */
> +		if (bio->bi_opf & REQ_SAVED_END_IO) {
> +			ci->io->saved_bio_end_io = NULL;

So if it already was saved the list gets cleared here?  Can you explain
this logic a little more?

> +		} else {
> +			ci->io->saved_bio_end_io = bio->bi_end_io;
> +			INIT_HLIST_HEAD((struct hlist_head *)&bio->bi_end_io);

I think you want to hide these casts in helpers that clearly document
why this is safe rather than sprinkling the casts all over the code.
I also wonder if there is any better way to structur this.

> +static int dm_poll_bio(struct bio *bio, unsigned int flags)
> +{
> +	struct dm_io *io;
> +	void *saved_bi_end_io = NULL;
> +	struct hlist_head tmp = HLIST_HEAD_INIT;
> +	struct hlist_head *head = (struct hlist_head *)&bio->bi_end_io;
> +	struct hlist_node *next;
> +
> +	/*
> +	 * This bio can be submitted from FS as POLLED so that FS may keep
> +	 * polling even though the flag is cleared by bio splitting or
> +	 * requeue, so return immediately.
> +	 */
> +	if (!(bio->bi_opf & REQ_POLLED))
> +		return 0;

I can't really parse the comment, can you explain this a little more?
But if we need this check, shouldn't it move to bio_poll()?

> +	hlist_for_each_entry(io, &tmp, node) {
> +		if (io->saved_bio_end_io && !saved_bi_end_io) {
> +			saved_bi_end_io = io->saved_bio_end_io;
> +			break;
> +		}
> +	}

So it seems like you don't use bi_cookie at all.  Why not turn
bi_cookie into a union to stash the hlist_head and use that?
