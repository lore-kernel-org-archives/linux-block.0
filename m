Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C7C433F5
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 09:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5592610F8
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 09:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbhIHJ2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237688AbhIHJ2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Sep 2021 05:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631093242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSMToU1uUMoHfun1y7dnDAkzWYwJfJzd2Z/oipy2Y5M=;
        b=EZjChSDfqOGSpwFi3Mg7Ds3SWhdFwKa+iMKS3/Dtzio4Bfr13BcYPmkv+vvcK69vMKZBDn
        H5p72MBDCX22XAWbfafNvkM+e0KfHQdYKseZpn8pBv3Z6a8MTYn5ANsutNRe4zWnTVIUtX
        fNNkt8SgOniTXg1W2w0Ashm0OwFmTkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-UyvgIATwOhGSYXk-KyBkjw-1; Wed, 08 Sep 2021 05:27:20 -0400
X-MC-Unique: UyvgIATwOhGSYXk-KyBkjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 862101023F4E;
        Wed,  8 Sep 2021 09:27:19 +0000 (UTC)
Received: from T590 (ovpn-12-207.pek2.redhat.com [10.72.12.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E50545D9DC;
        Wed,  8 Sep 2021 09:27:11 +0000 (UTC)
Date:   Wed, 8 Sep 2021 17:27:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v4 2/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YTiB8TLQ7ZJWvS7Y@T590>
References: <20210907140154.2134091-1-yukuai3@huawei.com>
 <20210907140154.2134091-3-yukuai3@huawei.com>
 <YThmhhI1/fZd29b1@T590>
 <e295605c-bc8e-cbb9-ca51-1355fdfc0264@huawei.com>
 <YThtq154oyROxBj9@T590>
 <2cfb6701-6e58-3e13-be85-472437a5b2ed@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cfb6701-6e58-3e13-be85-472437a5b2ed@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 08, 2021 at 04:29:57PM +0800, yukuai (C) wrote:
> On 2021/09/08 16:00, Ming Lei wrote:
> > On Wed, Sep 08, 2021 at 03:37:06PM +0800, yukuai (C) wrote:
> > > On 2021/09/08 15:30, Ming Lei wrote:
> > > 
> > > > > +put_req:
> > > > > +	if (req)
> > > > > +		blk_mq_put_rq_ref(req);
> > > > >    	return ret ? ERR_PTR(ret) : cmd;
> > > > 
> > > > After the request's refcnt is dropped, it can be freed immediately, then
> > > > one stale command is returned to caller.
> > > 
> > > Hi, Ming
> > > 
> > > It's right this patch leave this problem. Please take a look at patch 3
> > > and patch 4, the problem should be fixed with these patches.
> > 
> > Not see it is addressed in patch 3 & 4, and it is one obvious fault in
> > patch 2, please fix it from beginning by moving the refcnt drop
> > into recv_work().
> 
> Hi, Ming
> 
> With patch 3 & 4:
> 
> if nbd_read_stat() return a valid cmd, then the refcnt should not drop
> to 0 before blk_mq_complete_request() in recv_work().

The valid cmd won't be timed out just between nbd_read_stat() and
calling blk_mq_complete_request()?

Yeah, the issue is addressed by patch 4, then please put 2 after
3 & 4, and suggest to add comment why request ref won't drop to zero
in recv_work().

> 
> if nbd_read_stat() failed, it won't be a problem if the request is freed
> immediately when refcnt is dropped in nbd_read_stat().
> 
> That's why I said that the problem will be fixed.
> 
> BTW, if we move the refcnt drop into recv_work, we can only do that if
> nbd_read_stat() return a valid cmd. If we get a valid rq and failed in
> the following checkings in nbd_read_stat(), it's better to drop the
> refcnt in nbd_read_stat().

The usual pattern is to drop the refcnt on when the object isn't used
any more, so it is perfectly fine to hold the ref until that time.


Thanks,
Ming

