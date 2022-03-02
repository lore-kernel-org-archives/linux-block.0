Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD08C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 01:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiCBBs1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 20:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiCBBs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 20:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7825A17AAB
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 17:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646185663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fK0ojIIIzGfhVfz3XrQjPm5zcOSm1vNfGYwoa8aydG4=;
        b=jTsXfMlnMgfSEF94oTwdnSLTqkiNsq4W3AOaraqF4f+PudsnpeAWwzj7AOHhH6CEeszOMc
        bXvTiOJnqiqzLk6Bp3ca1mVl3GnX2XE/Isj8j0TjCefuuf81u9NLsVysTiCx8aqosiDSD7
        hURGKR3e2Kdj6KJ6yN3yXsjOFpYAV8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-xGV81HBxNYe7yUAKka2r0g-1; Tue, 01 Mar 2022 20:47:42 -0500
X-MC-Unique: xGV81HBxNYe7yUAKka2r0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D64824FA6;
        Wed,  2 Mar 2022 01:47:40 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E6D44BC5F;
        Wed,  2 Mar 2022 01:47:25 +0000 (UTC)
Date:   Wed, 2 Mar 2022 09:47:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 1/6] blk-mq: figure out correct numa node for hw queue
Message-ID: <Yh7MqBLsE2FJvT2Z@T590>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-2-ming.lei@redhat.com>
 <45adf246-176a-b4a5-d973-4c885c37d821@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45adf246-176a-b4a5-d973-4c885c37d821@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 01, 2022 at 07:19:43PM +0000, John Garry wrote:
> On 28/02/2022 09:04, Ming Lei wrote:
> > The current code always uses default queue map and hw queue index
> > for figuring out the numa node for hw queue, this way isn't correct
> > because blk-mq supports three queue maps, and the correct queue map
> > should be used for the specified hw queue.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> 
> Hi Ming,
> 
> Just some small comments to consider if you need to respin.
> 
> Thanks,
> John
> 
> >   block/blk-mq.c | 36 ++++++++++++++++++++++++++++++------
> >   1 file changed, 30 insertions(+), 6 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index a05ce7725031..931add81813b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3107,15 +3107,41 @@ void blk_mq_free_rq_map(struct blk_mq_tags *tags)
> >   	blk_mq_free_tags(tags);
> >   }
> >    +static int
> 
> enum hctx_type?
> 
> > hctx_idx_to_type(struct blk_mq_tag_set *set,
> > +		unsigned int hctx_idx)
> > +{
> > +	int j;
> 
> super nit: normally use i

OK

> 
> > +
> > +	for (j = 0; j < set->nr_maps; j++) {
> > +		unsigned int start =  set->map[j].queue_offset;
> 
> nit: double whitespace intentional?

will fix it.

> 
> > +		unsigned int end = start + set->map[j].nr_queues;
> > +
> > +		if (hctx_idx >= start && hctx_idx < end)
> > +			break;
> > +	}
> > +
> > +	if (j >= set->nr_maps)
> > +		j = HCTX_TYPE_DEFAULT;
> > +
> > +	return j;
> > +}
> > +
> > +static int blk_mq_get_hctx_node(struct blk_mq_tag_set *set,
> > +		unsigned int hctx_idx)
> > +{
> > +	int type = hctx_idx_to_type(set, hctx_idx);
> > +
> > +	return blk_mq_hw_queue_to_node(&set->map[type], hctx_idx);
> > +}
> > +
> >   static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
> >   					       unsigned int hctx_idx,
> >   					       unsigned int nr_tags,
> >   					       unsigned int reserved_tags)
> >   {
> >   	struct blk_mq_tags *tags;
> > -	int node;
> > +	int node = blk_mq_get_hctx_node(set, hctx_idx);
> 
> nit: the code originally had reverse firtree ordering, which I suppose is
> not by mistake

What is reverse firtree ordering here? I don't know what is wrong
with the above one line change from patch style viewpoint, and
checkpatch complains nothing here.


Thanks,
Ming

