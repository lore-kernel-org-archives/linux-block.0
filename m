Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA28C433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB75561954
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhC3D4O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231424AbhC3Dzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 23:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617076548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgugrUzLoQTlg1TeffveEjnxJmaQPE4uFnKyCgzgdIQ=;
        b=H/ZyOPiAF9Oi73UcH9LQuPuFd5rUVxIwC/17zYTYumONldeEXmhj54THv2PKjZs56tSXyV
        HFxA8+5cH+J8sSVzhCmZIAVpuxPGHlOCTWZNymZouBTSt6azytMSpQrTc0vEukFrDRLQIn
        pkG/4uFIeWOkz77DvLZa/xEX1inq9Ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-AUXuHJP0PrmDFoBBTGnclA-1; Mon, 29 Mar 2021 23:55:45 -0400
X-MC-Unique: AUXuHJP0PrmDFoBBTGnclA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD226501FB;
        Tue, 30 Mar 2021 03:55:43 +0000 (UTC)
Received: from T590 (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E45095D6D3;
        Tue, 30 Mar 2021 03:55:36 +0000 (UTC)
Date:   Tue, 30 Mar 2021 11:55:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Su Yue <l@damenly.su>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blktrace: limit allowed total trace buffer size
Message-ID: <YGKhMz+qPA+ZIqhA@T590>
References: <20210323081440.81343-1-ming.lei@redhat.com>
 <20210323081440.81343-3-ming.lei@redhat.com>
 <mtul73da.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mtul73da.fsf@damenly.su>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 30, 2021 at 10:57:04AM +0800, Su Yue wrote:
> 
> On Tue 23 Mar 2021 at 16:14, Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On some ARCHs, such as aarch64, page size may be 64K, meantime there may
> > be lots of CPU cores. relay_open() needs to allocate pages on each CPU
> > blktrace, so easily too many pages are taken by blktrace. For example,
> > on one ARM64 server: 224 CPU cores, 16G RAM, blktrace finally got
> > allocated 7GB in case of 'blktrace -b 8192' which is used by
> > device-mapper
> > test suite[1]. This way could cause OOM easily.
> > 
> > Fix the issue by limiting max allowed pages to be 1/8 of
> > totalram_pages().
> > 
> > [1] https://github.com/jthornber/device-mapper-test-suite.git
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  kernel/trace/blktrace.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index c221e4c3f625..8403ff19d533 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -466,6 +466,35 @@ static void blk_trace_setup_lba(struct blk_trace
> > *bt,
> >  	}
> >  }
> > 
> > +/* limit total allocated buffer size is <= 1/8 of total pages */
> > +static void validate_and_adjust_buf(struct blk_user_trace_setup *buts)
> > +{
> > +	unsigned buf_size = buts->buf_size;
> > +	unsigned buf_nr = buts->buf_nr;
> > +	unsigned long max_allowed_pages = totalram_pages() >> 3;
> > +	unsigned long req_pages = PAGE_ALIGN(buf_size * buf_nr) >> PAGE_SHIFT;
> > +
> > +	if (req_pages * num_online_cpus() <= max_allowed_pages)
> > +		return;
> > +
> > +	req_pages = DIV_ROUND_UP(max_allowed_pages, num_online_cpus());
> > +
> > +	if (req_pages == 0) {
> > +		buf_size = PAGE_SIZE;
> > +		buf_nr = 1;
> > +	} else {
> > +		buf_size = req_pages << PAGE_SHIFT / buf_nr;
> > 
> Should it be:
> buf_size = (req_pages << PAGE_SHIFT) / buf_nr;
> ?
> The priority of '<<' is lower than '/', right? :)

Good catch, thanks!

-- 
Ming

