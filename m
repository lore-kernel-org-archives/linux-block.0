Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DBAC433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 03:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiCGDlW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 22:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiCGDlW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 22:41:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 523A04DF5A
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646624427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0jfibdz31wR7Wf7+mMeXPEHO/YqlSeh9cNFgXswLf0=;
        b=FgQ00VDRBDpxsEF31E+Dbcn7TLElWSZO75T9Jr8ps9HKRZci3PFqRCiyhdTiYXHmLQ8zSH
        jiOiNPpcrEaoZCj773KgSprvGxHy0phbQTOj2f1b6PuTieO8NF+bPPwwexEYajJAid1NeS
        E8eG/C3OG6nkaIsNnYXlLfpGAcQBeFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-AiUcYbN8Nm-sklgDTnv_pA-1; Sun, 06 Mar 2022 22:40:24 -0500
X-MC-Unique: AiUcYbN8Nm-sklgDTnv_pA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F55B800423;
        Mon,  7 Mar 2022 03:40:23 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D38D4D70E;
        Mon,  7 Mar 2022 03:39:40 +0000 (UTC)
Date:   Mon, 7 Mar 2022 11:39:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dm: support bio polling
Message-ID: <YiV+d+B2+o7q63Bm@T590>
References: <20220305020804.54010-1-snitzer@redhat.com>
 <20220305020804.54010-3-snitzer@redhat.com>
 <20220306092937.GC22883@lst.de>
 <2ced53d5-d87b-95db-a612-6896f73ce895@kernel.dk>
 <YiVr4rna9DG0Oyng@T590>
 <89612542-0040-65bd-23bc-5bf8cac71f61@kernel.dk>
 <YiVw2y1eTcXrsdME@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiVw2y1eTcXrsdME@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 10:41:31AM +0800, Ming Lei wrote:
> On Sun, Mar 06, 2022 at 07:25:11PM -0700, Jens Axboe wrote:
> > On 3/6/22 7:20 PM, Ming Lei wrote:
> > > On Sun, Mar 06, 2022 at 06:48:15PM -0700, Jens Axboe wrote:
> > >> On 3/6/22 2:29 AM, Christoph Hellwig wrote:
> > >>>> +/*
> > >>>> + * Reuse ->bi_end_io as hlist head for storing all dm_io instances
> > >>>> + * associated with this bio, and this bio's bi_end_io has to be
> > >>>> + * stored in one of 'dm_io' instance first.
> > >>>> + */
> > >>>> +static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
> > >>>> +{
> > >>>> +	WARN_ON_ONCE(!(bio->bi_opf & REQ_DM_POLL_LIST));
> > >>>> +
> > >>>> +	return (struct hlist_head *)&bio->bi_end_io;
> > >>>> +}
> > >>>
> > >>> So this reuse is what I really hated.  I still think we should be able
> > >>> to find space in the bio by creatively shifting fields around to just
> > >>> add the hlist there directly, which would remove the need for this
> > >>> override and more importantly the quite cumbersome saving and restoring
> > >>> of the end_io handler.
> > >>
> > >> If it's possible, then that would be preferable. But I don't think
> > >> that's going to be easy to do...
> > > 
> > > I agree, now basically there isn't gap inside bio, so either adding one
> > > new field or reusing one existed field...
> > 
> > There'd no amount of re-arranging that'll free up 8 bytes, that's just
> > not happening. I'm not a huge fan of growing struct bio for that, and
> > the oddity here is mostly (to me) that ->bi_end_io is the one overlayed.
> > That would usually belong to the owner of the bio.
> > 
> > Maybe some commenting would help?
> 
> OK, ->bi_end_io is safe because it is only called until the bio is
> ended, so we can retrieve the list head and recover ->bi_end_io before
> polling.

->bi_private can be reused too, is that better?

Yeah, both belong to owner(higher level storage), then block layer can't touch
them inside submit_bio_noacct(), that is also why this trick is safe.

Thanks,
Ming

