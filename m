Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4DAC433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 03:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5B420738
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 03:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT/u/Qhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgHaDNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:13:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726712AbgHaDNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 23:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598843584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JL0aMOuM9kbION8BvhpWwue13ZZi5U89MMcDp91s5SE=;
        b=hT/u/QhzLjlVhXobX+heF8WaJ+l3EViMYMuTJPBgZfEODP9cADzNz8+SqiYaQQtIOOPQW9
        7/p+alXtrctOiifGWzdoQ53y2OlYX1uulBNga0ailTpAqFfolq81DwAJc5gxeigk4YXv4l
        7QivmqmvrbD8aoHsa3rktl72lPJ+G8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-FjoM1ShVPPWw_iQU2CVG3A-1; Sun, 30 Aug 2020 23:13:02 -0400
X-MC-Unique: FjoM1ShVPPWw_iQU2CVG3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5773F10059A4;
        Mon, 31 Aug 2020 03:13:01 +0000 (UTC)
Received: from T590 (ovpn-13-189.pek2.redhat.com [10.72.13.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02DBC1C93D;
        Mon, 31 Aug 2020 03:12:55 +0000 (UTC)
Date:   Mon, 31 Aug 2020 11:12:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
Message-ID: <20200831031251.GA257809@T590>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
 <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
 <20200830152800.GA16467@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830152800.GA16467@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 30, 2020 at 04:28:00PM +0100, Christoph Hellwig wrote:
> On Sun, Aug 30, 2020 at 09:09:02AM -0600, Jens Axboe wrote:
> > On 8/30/20 12:26 AM, Christoph Hellwig wrote:
> > > On Sat, Aug 29, 2020 at 10:51:11AM -0600, Jens Axboe wrote:
> > >> We currently increment the task/vm counts when we first attempt to queue a
> > >> bio. But this isn't necessarily correct - if the request allocation fails
> > >> with -EAGAIN, for example, and the caller retries, then we'll over-account
> > >> by as many retries as are done.
> > >>
> > >> This can happen for polled IO, where we cannot wait for requests. Hence
> > >> retries can get aggressive, if we're running out of requests. If this
> > >> happens, then watching the IO rates in vmstat are incorrect as they count
> > >> every issue attempt as successful and hence the stats are inflated by
> > >> quite a lot potentially.
> > >>
> > >> Add a bio flag to know if we've done accounting or not. This prevents
> > >> the same bio from being accounted potentially many times, when retried.
> > > 
> > > Can't the resubmitter just use submit_bio_noacct?  What is the call
> > > stack here?
> > 
> > The resubmitter is way higher than that. You could potentially have that
> > done in the block layer, but not higher up.
> > 
> > The use case is async submissions, going through ->read_iter() again.
> > Or ->write_iter().
> 
> But how does a bio flag help there?  If we go through the file ops
> again the next submission will be a new bio structure.

Yeah, we also have use cases of stack bio variable.



Thanks,
Ming

