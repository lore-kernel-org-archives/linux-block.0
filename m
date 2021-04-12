Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E7C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2DE6120B
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbhDLJ5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244775AbhDLJ4j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:56:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75177C061361
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k9+7Oie6AkMR21KF8o/wbOcfgvZTIN8r8Zl6GFWNF+k=; b=hJxeNeb+o20+ovc85c7eXf7h/u
        iIpN8QvVhdgH1wkLLe53E6imNmKe1pRPvIru0vDgLwdsvYHeYhf+/ZyqjM9hTEH40SUb+wwy1wIsX
        k0O5mxej1zMS04K3bcIFvXLaQqr1NZ/2coYSwPdBCMtB9lgPCzqxkul7A4E71NrUhOPuQrVLwkIKB
        4PufOYaj4mJIq+jTTXp5wOJcqikzsSd92Vyz2+73qPnPb2kxZP9kl6NUTk95vL4HTY+hAizdQWPbL
        YFSFCTcfM5tcGtmaPCt+Q1vYPRJ62lCT9PveiaIuuVy5oWp5Iwc7Cf89TFIlHOZBTWwt7Ul3v9Y9A
        NyoKr54Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtH1-0049Ay-34; Mon, 12 Apr 2021 09:54:36 +0000
Date:   Mon, 12 Apr 2021 10:54:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 08/12] block: use per-task poll context to implement
 bio based io polling
Message-ID: <20210412095427.GA987123@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-9-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 01, 2021 at 10:19:23AM +0800, Ming Lei wrote:
> Currently bio based IO polling needs to poll all hw queue blindly, this
> way is very inefficient, and one big reason is that we can't pass any
> bio submission result to blk_poll().
> 
> In IO submission context, track associated underlying bios by per-task
> submission queue and store returned 'cookie' in
> bio->bi_iter.bi_private_data, and return current->pid to caller of
> submit_bio() for any bio based driver's IO, which is submitted from FS.
> 
> In IO poll context, the passed cookie tells us the PID of submission
> context, then we can find bios from the per-task io pull context of
> submission context. Moving bios from submission queue to poll queue of
> the poll context, and keep polling until these bios are ended. Remove
> bio from poll queue if the bio is ended. Add bio flags of BIO_DONE and
> BIO_END_BY_POLL for such purpose.
> 
> In was found in Jeffle Xu's test that kfifo doesn't scale well for a
> submission queue as queue depth is increased, so a new mechanism for
> tracking bios is needed. So far bio's size is close to 2 cacheline size,
> and it may not be accepted to add new field into bio for solving the
> scalability issue by tracking bios via linked list, switch to bio group
> list for tracking bio, the idea is to reuse .bi_end_io for linking bios
> into a linked list for all sharing same .bi_end_io(call it bio group),
> which is recovered before ending bio really, since BIO_END_BY_POLL is
> added for enhancing this point. Usually .bi_end_bio is same for all
> bios in same layer, so it is enough to provide very limited groups, such
> as 16 or less for fixing the scalability issue.
> 
> Usually submission shares context with io poll. The per-task poll context
> is just like stack variable, and it is cheap to move data between the two
> per-task queues.
> 
> Also when the submission task is exiting, drain pending IOs in the context
> until all are done.
> 
> Tested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c               |   5 +
>  block/blk-core.c          | 155 +++++++++++++++++++++++-
>  block/blk-ioc.c           |   3 +
>  block/blk-mq.c            | 244 +++++++++++++++++++++++++++++++++++++-
>  block/blk.h               |  10 ++
>  include/linux/blk_types.h |  26 +++-
>  6 files changed, 439 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 26b7f721cda8..04c043dc60fc 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1402,6 +1402,11 @@ static inline bool bio_remaining_done(struct bio *bio)
>   **/
>  void bio_endio(struct bio *bio)
>  {
> +	/* BIO_END_BY_POLL has to be set before calling submit_bio */
> +	if (bio_flagged(bio, BIO_END_BY_POLL)) {
> +		bio_set_flag(bio, BIO_DONE);
> +		return;
> +	}

Why can't driver that implements bio based polling call a separate
bio_endio_polled instead?

> +static inline void *bio_grp_data(struct bio *bio)
> +{
> +	return bio->bi_poll;
> +}

What is the purpose of this helper?  And why does it have to lose the
type information?
