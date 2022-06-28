Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FEEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 07:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiF1Htu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbiF1Htt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 03:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D93D410EC
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 00:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656402588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYWbhsvrQtrlyrTU8kgrlkpJK3VjxKUUZCstw/Hmm2I=;
        b=D4xfc+uC1MeobMdErUOX8pWfCo2vFOG/c6ZDkyMS1opnRfUelt2NRpdz+47x2RPbBe6hBV
        pBhD6fUrHbPTw6SyeeI1xM9hp00k+spHffQNiMbx1rEBIQc5Ua22rH5/5O3tl75f1Bj8iQ
        RiESbBfUr7JgfX05lAtHlugylO8Yjsg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-llLuKYhJNqCb4NGcAKNc_Q-1; Tue, 28 Jun 2022 03:49:42 -0400
X-MC-Unique: llLuKYhJNqCb4NGcAKNc_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F35AF3AF42D2;
        Tue, 28 Jun 2022 07:49:38 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 117244050C54;
        Tue, 28 Jun 2022 07:49:33 +0000 (UTC)
Date:   Tue, 28 Jun 2022 15:49:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <YrqyiCcnvPCqsn8F@T590>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042610.wuittagsycyl4uwa@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628042610.wuittagsycyl4uwa@moria.home.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 12:26:10AM -0400, Kent Overstreet wrote:
> On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
> > Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
> > hold in per-io data structure. With this patch, 8bytes is enough
> > to rewind one bio if the end sector is fixed.
> 
> And with rewind, you're making an assumption about the state the iterator is
> going to be in when the IO has completed.
> 
> What if the iterator was never advanced?

bio_rewind() works as expected if the iterator doesn't advance, since bytes
between the recorded position and the end position isn't changed, same
with the end position.

> 
> So say you check for that by saving some other part of the iterator - but that
> may have legitimately changed too, if the bio was redirected (bi_sector changes)
> or trimmed (bi_size changes)
> 
> I still think this is an inherently buggy interface, the way it's being proposed
> to be used.

The patch did mention that the interface should be for situation in which end
sector of bio won't change.


Thanks,
Ming

