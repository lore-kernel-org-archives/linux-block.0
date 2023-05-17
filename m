Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC13DC77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 09:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEQJFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQJFS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 05:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3C4225
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684314269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fnZcYD5YdV/j9w+Jg7dMu/BG2OatXrnf+id8ztkvyZ4=;
        b=PnqVYCt60qX1N4lF928TDiJZJNu7xHbttNlM4cO67+jn1ir0fdgUiPPdtk5nVBajxhxv/K
        +oAQPdQEmXKcgcjg2kLavmGCyUSvHVH0fmI3FcnG8XliZ19tYKFpwSWJWZLwuQhO+6vtvO
        1+aDhCQ+6CJn2AuIFfkOg56T47WVfTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-5mArMIwnO8Ox9o_6xSAfug-1; Wed, 17 May 2023 05:04:24 -0400
X-MC-Unique: 5mArMIwnO8Ox9o_6xSAfug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 019F0185A7A4;
        Wed, 17 May 2023 09:04:24 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C2BC4078909;
        Wed, 17 May 2023 09:02:57 +0000 (UTC)
Date:   Wed, 17 May 2023 16:58:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGSXUTA5odBi2Jr0@ovpn-8-19.pek2.redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
 <ZGKUehOEnKThjFpR@kbusch-mbp>
 <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
 <20230516062409.GB7325@lst.de>
 <ZGNBKSaULn/gpsL0@ovpn-8-19.pek2.redhat.com>
 <20230517072218.GB27026@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517072218.GB27026@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 17, 2023 at 09:22:18AM +0200, Christoph Hellwig wrote:
> On Tue, May 16, 2023 at 04:39:05PM +0800, Ming Lei wrote:
> > I can understand the point, but it may not be done by single flag,
> 
> Can you explain why?  Note that we also already have RQF_ELVPRIV for
> any request that has elevator private data.  I don't really think we
> need a third flag.

RQF_ELVPRIV isn't same with RQF_ELV, and follows the two's relationship:

	RQF_ELVPRIV == (RQF_ELV && non_flush_pt_req && !e->type->ops.prepare_request)

RQF_ELVPRIV can be replaced with the above expression to save one flag.

RQF_ELV isn't same with RQF_SCHED_TAGS too, RQF_ELV should be used for
checking if elevator callback is needed, and RQF_SCHED_TAGS is for allocating
req/tag and dealing with tags busy things.

In case of q->elevator, RQF_SCHED_TAGS is always set, but

- for pt/flush request, RQF_ELV is cleared.
- for other request, RQF_ELV are set

Then we can avoid any elevator callback for pt/flush request.


thanks, 
Ming

