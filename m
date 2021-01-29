Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA5C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 02:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD85F64DFB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 02:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhA2CBw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 21:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229627AbhA2CBw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 21:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611885623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvsWOYvnGH9qfhesPAqZTHFgQmGBJIhRAqLETvnXfbQ=;
        b=QVcbvOdH90vsseap6cTtuul2rkFUE0b/GOPKSIGFnoCRkQKwhGIMWvq2YCffAMd/Sj7IHb
        gMJxq0aw4FBgmcKRTAvdJjI1N7PvBsmnC2A83pXMS2AwDlagdylx68Pc6YeZlzrDnnKIDE
        Y6jKQg4IvPYjuZbgej1QVESYV747ZSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-L6ckcgGaPCm-8SB16bMQGA-1; Thu, 28 Jan 2021 21:00:20 -0500
X-MC-Unique: L6ckcgGaPCm-8SB16bMQGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92610802B48;
        Fri, 29 Jan 2021 02:00:19 +0000 (UTC)
Received: from T590 (ovpn-13-35.pek2.redhat.com [10.72.13.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 859E62719F;
        Fri, 29 Jan 2021 02:00:14 +0000 (UTC)
Date:   Fri, 29 Jan 2021 10:00:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 2/2] block: add a fast path for seg split of large bio
Message-ID: <20210129020010.GD1649137@T590>
References: <cover.1609875589.git.asml.silence@gmail.com>
 <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
 <20210128121035.GA1495297@T590>
 <48e8c791-fe4a-60c7-aa8b-bcaf0f5562c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e8c791-fe4a-60c7-aa8b-bcaf0f5562c9@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 28, 2021 at 12:27:39PM +0000, Pavel Begunkov wrote:
> On 28/01/2021 12:10, Ming Lei wrote:
> > On Tue, Jan 05, 2021 at 07:43:38PM +0000, Pavel Begunkov wrote:
> >> blk_bio_segment_split() is very heavy, but the current fast path covers
> >> only one-segment under PAGE_SIZE bios. Add another one by estimating an
> >> upper bound of sectors a bio can contain.
> >>
> >> One restricting factor here is queue_max_segment_size(), which it
> >> compare against full iter size to not dig into bvecs. By default it's
> >> 64KB, and so for requests under 64KB, but for those falling under the
> >> conditions it's much faster.
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>  block/blk-merge.c | 29 +++++++++++++++++++++++++----
> >>  1 file changed, 25 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/block/blk-merge.c b/block/blk-merge.c
> >> index 84b9635b5d57..15d75f3ffc30 100644
> >> --- a/block/blk-merge.c
> >> +++ b/block/blk-merge.c
> >> @@ -226,12 +226,12 @@ static bool bvec_split_segs(const struct request_queue *q,
> >>  static struct bio *__blk_bio_segment_split(struct request_queue *q,
> >>  					   struct bio *bio,
> >>  					   struct bio_set *bs,
> >> -					   unsigned *segs)
> >> +					   unsigned *segs,
> >> +					   const unsigned max_sectors)
> >>  {
> >>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
> >>  	struct bvec_iter iter;
> >>  	unsigned nsegs = 0, sectors = 0;
> >> -	const unsigned max_sectors = get_max_io_size(q, bio);
> >>  	const unsigned max_segs = queue_max_segments(q);
> >>  
> >>  	bio_for_each_bvec(bv, bio, iter) {
> >> @@ -295,6 +295,9 @@ static inline struct bio *blk_bio_segment_split(struct request_queue *q,
> >>  						struct bio_set *bs,
> >>  						unsigned *nr_segs)
> >>  {
> >> +	unsigned int max_sectors, q_max_sectors;
> >> +	unsigned int bio_segs = bio->bi_vcnt;
> >> +
> >>  	/*
> >>  	 * All drivers must accept single-segments bios that are <=
> >>  	 * PAGE_SIZE.  This is a quick and dirty check that relies on
> >> @@ -303,14 +306,32 @@ static inline struct bio *blk_bio_segment_split(struct request_queue *q,
> >>  	 * are cloned, but compared to the performance impact of cloned
> >>  	 * bios themselves the loop below doesn't matter anyway.
> >>  	 */
> >> -	if (!q->limits.chunk_sectors && bio->bi_vcnt == 1 &&
> >> +	if (!q->limits.chunk_sectors && bio_segs == 1 &&
> >>  	    (bio->bi_io_vec[0].bv_len +
> >>  	     bio->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
> >>  		*nr_segs = 1;
> >>  		return NULL;
> >>  	}
> >>  
> >> -	return __blk_bio_segment_split(q, bio, bs, nr_segs);
> >> +	q_max_sectors = get_max_io_size(q, bio);
> >> +	if (!queue_virt_boundary(q) && bio_segs < queue_max_segments(q) &&
> >> +	    bio->bi_iter.bi_size <= queue_max_segment_size(q)) {
> > 
> > .bi_vcnt is 0 for fast cloned bio, so the above check may become true
> > when real nr_segment is > queue_max_segments(), especially in case that
> > max segments limit is small and segment size is big.
> 
> I guess we can skip the fast path for them (i.e. bi_vcnt == 0)

But bi_vcnt can't represent real segment number, which can be bigger or
less than .bi_vcnt.

> I'm curious, why it's 0 but not the real number?

fast-cloned bio shares bvec table of original bio, so it doesn't have
.bi_vcnt.


-- 
Ming

