Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B02BC00140
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 14:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiGZOVT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiGZOVS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 10:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E45615FFC
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658845277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHzrTeOX4cxT5Mpgq6GScyBWBiYGBfxj6PEBUXqJsiw=;
        b=B/NyvmLV/UvThbYbEovretD1zbXM4iu/lyaNI/Qfqzkw1I4zCFbct50RM0Qj81hhuPnBno
        3Iv8IpAzkoeyh+EmrT4jzNYRaVWNvZwiJxqE/x9MKs0tvpoupg1zZXUKomti3yefNLUs9V
        tQNnfPmUMfLywKXiTTu88CT+5JNVhtQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-UkRxchz6N5OInXd8aWDb8Q-1; Tue, 26 Jul 2022 10:21:13 -0400
X-MC-Unique: UkRxchz6N5OInXd8aWDb8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0CF028084EB;
        Tue, 26 Jul 2022 14:21:12 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDB0B140EBE3;
        Tue, 26 Jul 2022 14:21:09 +0000 (UTC)
Date:   Tue, 26 Jul 2022 22:21:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] ublk_drv: store device parameters
Message-ID: <Yt/4UBGtFDqr2SfA@T590>
References: <20220723150713.750369-1-ming.lei@redhat.com>
 <20220723150713.750369-2-ming.lei@redhat.com>
 <20220725064259.GA20796@lst.de>
 <Yt5BCtLi70Pits34@T590>
 <20220726123224.GA9435@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726123224.GA9435@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 02:32:24PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 25, 2022 at 03:06:50PM +0800, Ming Lei wrote:
> > There could be more parameters than the two types(), such as segments,
> > zoned, ..., also in future, feature related parameters can be added
> > in this way too, and most of them are optional.
> 
> Yes.  But just having a struct that grows is much cleaner and simpler
> than those indirections.  e.g something like this patch on top of this

But most of fields in ublk_params aren't required for one device,
sending them all isn't friendly from both userspace and kernel side.
Especially inside kernel, a big chunk buffer is allocated for
the structure, but only few fields are useful for one device. There can
be lots of ublk device, and total wasted memory can't be ignored.

If we group parameters, it is easier to extend by adding new parameter
type. One ublk device usually just uses several parameter types.
And the xarray implementation is simple enough too, which is just one
array, but really sparsed.

Adding one parameter type just needs to add two callbacks, so pretty easy
to review.

So I really suggest to keep the parameter type and xarray
implementation, and will post V2 after ublksrv side is updated.

> series.  With this new fields can just be added to the end of
> struct ublk_params.  Old kernels will ignore them, but due to the copy
> back of the parsed structure userspace can detect that if it cares:

There has to be one length field in header, otherwise ublk driver can't
know the exact length for copying back.

With parameter type approach, it is natural to handle new/old app and
old/new kernel, since kernel will fail set parameter command simply
if one parameter type isn't supported.


Thanks, 
Ming

