Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E30CC433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 11:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiBIL5U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiBILzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 06:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9507CE03E21E
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 02:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644404181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtxuNgg/Ql6dPXn7TpDXd2+85TTwmHddS11nx4e8hpc=;
        b=YMwJ5kIj/Fy8MCTG2oYc3XUvEYBJmE9La9tVLgVd1uW74ULWUoJHVSoquZ6wvqZz9G3nLi
        YznzB7FQBH2F/KEh3VqrrThpis/G9i8M5ujttLpvzm+WQcfDcL4IdfK6SP0PooLj0FeWmr
        FTeqA3H+7Of5ChUOiovqzFT3uQBpAPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-FAceydIiPfqQDBQBydcYpQ-1; Wed, 09 Feb 2022 03:36:44 -0500
X-MC-Unique: FAceydIiPfqQDBQBydcYpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75E0910247D2;
        Wed,  9 Feb 2022 08:36:24 +0000 (UTC)
Received: from T590 (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1093327CC7;
        Wed,  9 Feb 2022 08:35:59 +0000 (UTC)
Date:   Wed, 9 Feb 2022 16:35:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [RFC PATCH 3/7] block: allow to bypass bio check before
 submitting bio
Message-ID: <YgN86hJ+Ujzywtoz@T590>
References: <20220111115532.497117-1-ming.lei@redhat.com>
 <20220111115532.497117-4-ming.lei@redhat.com>
 <YeUnERz9Qoz2UtVn@infradead.org>
 <YgN3e98Px8F5w3q/@T590>
 <YgN4UCKEslA3sQny@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgN4UCKEslA3sQny@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09, 2022 at 12:16:16AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 09, 2022 at 04:12:43PM +0800, Ming Lei wrote:
> > On Mon, Jan 17, 2022 at 12:21:37AM -0800, Christoph Hellwig wrote:
> > > 
> > > >   * systems and other upper level users of the block layer should use
> > > >   * submit_bio() instead.
> > > >   */
> > > > -void submit_bio_noacct(struct bio *bio)
> > > > +void __submit_bio_noacct(struct bio *bio, bool check)
> > > >  {
> > > > -	if (unlikely(!submit_bio_checks(bio)))
> > > > +	if (unlikely(check && !submit_bio_checks(bio)))
> > > >  		return;
> > > 
> > > This doesn't make sense as an API - you can just move the checks
> > > into the caller that pass check=true.
> > 
> > But submit_bio_checks() is local helper, and it is hard to make it
> > public to drivers. Not mention there are lots of callers to
> > submit_bio_noacct().
> 
> What I mean is something like:
> 
> -void submit_bio_noacct(struct bio *bio)
> +void submit_bio_noacct_nocheck(struct bio *bio)
>  {
> -	if (unlikely(!submit_bio_checks(bio)))
> -		return
> 
> ...
> 
> +void submit_bio_noacct(struct bio *bio)
> +{
> +	if (unlikely(!submit_bio_checks(bio)))
> +		return
> +	submit_bio_noacct_nocheck(bio);
> +}

OK, that is also very similar with my local version.


Thanks,
Ming

