Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C069C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 02:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiCGCWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 21:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCGCWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 21:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 294FE5DE75
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 18:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646619683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQ9tSxmodW9KKu4DR/DeOcOrKCkbGEmlneF6Nba/g1k=;
        b=X3Mp+g8GMFrk3r6GYgI/mE17GOlFzeti4H5ZcHxg3y6/ETXJiPyXieYPgy6pZ1iLiLGBF4
        ZkfzDeHZuZnUzrpOKuC7firlE538awI1DBKwOmylICX0a/wztbBy9/go1/ncmgtb18LPWO
        5rcADahyKgxd3ef1BSZhAHYO6SUme00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-UwmYX2rTNcGrbwPozomUUA-1; Sun, 06 Mar 2022 21:21:22 -0500
X-MC-Unique: UwmYX2rTNcGrbwPozomUUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110AB1006AA8;
        Mon,  7 Mar 2022 02:21:21 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E10245D91;
        Mon,  7 Mar 2022 02:20:23 +0000 (UTC)
Date:   Mon, 7 Mar 2022 10:20:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dm: support bio polling
Message-ID: <YiVr4rna9DG0Oyng@T590>
References: <20220305020804.54010-1-snitzer@redhat.com>
 <20220305020804.54010-3-snitzer@redhat.com>
 <20220306092937.GC22883@lst.de>
 <2ced53d5-d87b-95db-a612-6896f73ce895@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ced53d5-d87b-95db-a612-6896f73ce895@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 06, 2022 at 06:48:15PM -0700, Jens Axboe wrote:
> On 3/6/22 2:29 AM, Christoph Hellwig wrote:
> >> +/*
> >> + * Reuse ->bi_end_io as hlist head for storing all dm_io instances
> >> + * associated with this bio, and this bio's bi_end_io has to be
> >> + * stored in one of 'dm_io' instance first.
> >> + */
> >> +static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
> >> +{
> >> +	WARN_ON_ONCE(!(bio->bi_opf & REQ_DM_POLL_LIST));
> >> +
> >> +	return (struct hlist_head *)&bio->bi_end_io;
> >> +}
> > 
> > So this reuse is what I really hated.  I still think we should be able
> > to find space in the bio by creatively shifting fields around to just
> > add the hlist there directly, which would remove the need for this
> > override and more importantly the quite cumbersome saving and restoring
> > of the end_io handler.
> 
> If it's possible, then that would be preferable. But I don't think
> that's going to be easy to do...

I agree, now basically there isn't gap inside bio, so either adding one
new field or reusing one existed field...


Thanks,
Ming

