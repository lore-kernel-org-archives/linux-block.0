Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB194C43217
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 08:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiBOILA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:11:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiBOIK5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 03:10:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E468D2DAA4
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 00:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644912644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QaY2baCUA8UITfADY66sUi6rHGH1ocw36WonOllT+eE=;
        b=EYG6EaBdIcOwYiIQRzHyQ15Sjwy1DZLLvsLhbZFZZ5hE3exPwiVIHbUinjSLqjRyrtZdQL
        dkO4PP4CM+AZ5Vgd0qS/EFr0d3uKooV8jrIaTvTu6s13ETm++Q4+5WaBzzwnqgV+FYgZLD
        ZXuNm0Zz6zDrdhLQEmoA0AdAXSpE1kE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-uW_KKlH9Pg6bpd19N3T3pg-1; Tue, 15 Feb 2022 03:10:34 -0500
X-MC-Unique: uW_KKlH9Pg6bpd19N3T3pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 825211808322;
        Tue, 15 Feb 2022 08:10:32 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20FC756A84;
        Tue, 15 Feb 2022 08:09:50 +0000 (UTC)
Date:   Tue, 15 Feb 2022 16:09:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V3 4/8] block: don't check bio in
 blk_throtl_dispatch_work_fn
Message-ID: <Ygtfyq7s0sx6vkJ8@T590>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
 <20220215033050.2730533-5-ming.lei@redhat.com>
 <Ygtc2rIGVZkLRgTp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygtc2rIGVZkLRgTp@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 14, 2022 at 11:57:14PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 15, 2022 at 11:30:46AM +0800, Ming Lei wrote:
> > The bio has been checked already before throttling, so no need to check
> > it again before dispatching it from throttle queue.
> > 
> > Add one local helper of submit_bio_noacct_nocheck() for this purpose.
> 
> s/one/a/.  Also I'm not sure I'd call it "local" given that it is used in
> a different file.
> 
> > +void submit_bio_noacct_nocheck(struct bio *bio)
> > +{
> > +	__submit_bio_noacct_nocheck(bio);
> > +}
> 
> No need for a wrapper here.

The wrapper is for avoiding to add extra function call code in fast
path since submit_bio_noacct_nocheck is global and can't be inlined.

Thanks,
Ming

