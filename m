Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F90C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 02:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiCGCml (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 21:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCGCmk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 21:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91E5A1DA4A
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 18:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646620906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7kabxOzF0F8GAUiBdn3b9WygOhE2sldgJPoGl+UqTk=;
        b=R0bS8cbfafySoJcG71SdsJQNxT4pRyER6vGw4sCsxPYaYlQxDkfcoJ4qhrCNAld0hsfxqU
        hd7XlKobD5hcILMMJKZQYI1RHM4RSwmmSr3DV3vd1qEc9OXVjGK8oMB68UfqlsHnldw5K7
        A1AaDZxYAj/1tKfoQsY52psQNxrh6mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-BZIgWRjMP2eVpUrtu3y_Wg-1; Sun, 06 Mar 2022 21:41:41 -0500
X-MC-Unique: BZIgWRjMP2eVpUrtu3y_Wg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9CFC824FA6;
        Mon,  7 Mar 2022 02:41:39 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FE994D708;
        Mon,  7 Mar 2022 02:41:35 +0000 (UTC)
Date:   Mon, 7 Mar 2022 10:41:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dm: support bio polling
Message-ID: <YiVw2y1eTcXrsdME@T590>
References: <20220305020804.54010-1-snitzer@redhat.com>
 <20220305020804.54010-3-snitzer@redhat.com>
 <20220306092937.GC22883@lst.de>
 <2ced53d5-d87b-95db-a612-6896f73ce895@kernel.dk>
 <YiVr4rna9DG0Oyng@T590>
 <89612542-0040-65bd-23bc-5bf8cac71f61@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89612542-0040-65bd-23bc-5bf8cac71f61@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 06, 2022 at 07:25:11PM -0700, Jens Axboe wrote:
> On 3/6/22 7:20 PM, Ming Lei wrote:
> > On Sun, Mar 06, 2022 at 06:48:15PM -0700, Jens Axboe wrote:
> >> On 3/6/22 2:29 AM, Christoph Hellwig wrote:
> >>>> +/*
> >>>> + * Reuse ->bi_end_io as hlist head for storing all dm_io instances
> >>>> + * associated with this bio, and this bio's bi_end_io has to be
> >>>> + * stored in one of 'dm_io' instance first.
> >>>> + */
> >>>> +static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
> >>>> +{
> >>>> +	WARN_ON_ONCE(!(bio->bi_opf & REQ_DM_POLL_LIST));
> >>>> +
> >>>> +	return (struct hlist_head *)&bio->bi_end_io;
> >>>> +}
> >>>
> >>> So this reuse is what I really hated.  I still think we should be able
> >>> to find space in the bio by creatively shifting fields around to just
> >>> add the hlist there directly, which would remove the need for this
> >>> override and more importantly the quite cumbersome saving and restoring
> >>> of the end_io handler.
> >>
> >> If it's possible, then that would be preferable. But I don't think
> >> that's going to be easy to do...
> > 
> > I agree, now basically there isn't gap inside bio, so either adding one
> > new field or reusing one existed field...
> 
> There'd no amount of re-arranging that'll free up 8 bytes, that's just
> not happening. I'm not a huge fan of growing struct bio for that, and
> the oddity here is mostly (to me) that ->bi_end_io is the one overlayed.
> That would usually belong to the owner of the bio.
> 
> Maybe some commenting would help?

OK, ->bi_end_io is safe because it is only called until the bio is
ended, so we can retrieve the list head and recover ->bi_end_io before
polling.

> Is bi_next available at this point?

The same bio can be re-submitted to block layer because of splitting, and
will be linked to current->bio_list[].

BTW, bio splitting can be very often for some dm target, that is why we
don't ignore bio splitting for dm polling.


Thanks,
Ming

