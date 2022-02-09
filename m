Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D350C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiBIINN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiBIINK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 774F6C05CB81
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 00:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644394392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wAKr5zA6/9+p9sNX37MgCYmWDGLnmk8aVMfeb0DzhA=;
        b=ZMCar2UpHS2shlXHewGHgnNEMkd1OlX4qsEuDgK1Vsp3qRXXVINisruvO/Dvk9TAiWDVng
        DC8ZIJ9QrBNmawA4nBgwpf0SotZpT1ppCS3VRS2IUH+6qSOAYlqbpsqcDAGr/ipLqnD/65
        Gw2Y+rraA3sQ3yOUGIBT88PlOyhP43Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-kItQq1ECPPKteVvYpENFHA-1; Wed, 09 Feb 2022 03:13:09 -0500
X-MC-Unique: kItQq1ECPPKteVvYpENFHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1700283DD23;
        Wed,  9 Feb 2022 08:13:08 +0000 (UTC)
Received: from T590 (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9A6C66E01;
        Wed,  9 Feb 2022 08:12:48 +0000 (UTC)
Date:   Wed, 9 Feb 2022 16:12:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [RFC PATCH 3/7] block: allow to bypass bio check before
 submitting bio
Message-ID: <YgN3e98Px8F5w3q/@T590>
References: <20220111115532.497117-1-ming.lei@redhat.com>
 <20220111115532.497117-4-ming.lei@redhat.com>
 <YeUnERz9Qoz2UtVn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeUnERz9Qoz2UtVn@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 17, 2022 at 12:21:37AM -0800, Christoph Hellwig wrote:
> 
> >   * systems and other upper level users of the block layer should use
> >   * submit_bio() instead.
> >   */
> > -void submit_bio_noacct(struct bio *bio)
> > +void __submit_bio_noacct(struct bio *bio, bool check)
> >  {
> > -	if (unlikely(!submit_bio_checks(bio)))
> > +	if (unlikely(check && !submit_bio_checks(bio)))
> >  		return;
> 
> This doesn't make sense as an API - you can just move the checks
> into the caller that pass check=true.

But submit_bio_checks() is local helper, and it is hard to make it
public to drivers. Not mention there are lots of callers to
submit_bio_noacct().


Thanks,
Ming

