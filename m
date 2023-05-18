Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BAC77B75
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 01:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjERBXt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 21:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 21:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05785421F
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684372983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDkHBjGl9sCc9Caa6fvEp3TJEYPKjYbAbq2RguBbjUc=;
        b=cVw/hXlff0q1DNNIzIyewZ1TWX69RtNPJp+jzPgIYzdT0n1JnyDY6JcZdcm7QOeU/ML+cG
        GqMu8NPquJ4k1Cx+rxUUa/D+ANveIEUZfwgyKmyg2fkP0GoyBTqmW280eS/beZOTAsXSws
        SHzLIsQCkNYeOzX2ETUjFT/5ejz/ogI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-q0phaVb9O222CjUdi_Ti-w-1; Wed, 17 May 2023 21:22:59 -0400
X-MC-Unique: q0phaVb9O222CjUdi_Ti-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA80387DC00;
        Thu, 18 May 2023 01:22:58 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F386463F5B;
        Thu, 18 May 2023 01:22:54 +0000 (UTC)
Date:   Thu, 18 May 2023 09:22:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGV96ZAjbM2/lGAM@ovpn-8-16.pek2.redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
 <ZGKUehOEnKThjFpR@kbusch-mbp>
 <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
 <ZGOXkhzPplCfK6kc@kbusch-mbp>
 <ZGRJaLSx6hToubQ7@ovpn-8-19.pek2.redhat.com>
 <ZGUZMATdnt8hFM+A@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGUZMATdnt8hFM+A@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 17, 2023 at 12:13:04PM -0600, Keith Busch wrote:
> On Wed, May 17, 2023 at 11:26:32AM +0800, Ming Lei wrote:
> > On Tue, May 16, 2023 at 08:47:46AM -0600, Keith Busch wrote:
> > 
> > > And the passthrough case is special with users of that interface taking
> > > on a greater responsibility and generally want the kernel out of the
> > > way. I don't think anyone would purposefully run a tag intense workload
> > > through that engine at the same time as using a generic one with the
> > > scheduler. It definitely should still work, but it doesn't need to be
> > > fair, right?
> > 
> > I guess it may work, but question is that what we can get from this kind
> > of big change? And I think this approach may be one following work if it is
> > proved as useful.
> 
> I'm just trying to remove any need for side channels to bypass block
> layer functionality, like this one:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2023-April/039522.html
> 

In "io_uring attached nvme queue" patchset, Kanchan tried to bypass
request/bio completely, and same with blk-mq's pt code path.

You mean you'd suggest to still reuse req/bio & blk-mq pt code path
for "io_uring attached nvme queue"?

Cc Kanchan.

Thanks,
Ming

