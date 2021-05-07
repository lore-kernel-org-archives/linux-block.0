Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2582BC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C3961154
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhEGGcQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 02:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233054AbhEGGcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 May 2021 02:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620369076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKnXc1Ty9Cs5V1tjoizsrn6lZNpUsN1Qm4aKV2boKMQ=;
        b=OwVdoN3Zoi4L9z2btdZX/4cRojmNWtAJiMxSEp9Z9oNo1v6WWlEoagAR+UF+c0S3Z4bPkb
        ONKlqsnhu1GpNZmPRhV2s6jFkvGrHuICOpMxjbVqGcWBnzmlBRSiCWrhd7HEwEj7PBBVr/
        mD4Ix6wsAZH0qLRsGTAlaDitIqYdmGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-PFe_q8a1MfieZGpp2Gwn2w-1; Fri, 07 May 2021 02:31:14 -0400
X-MC-Unique: PFe_q8a1MfieZGpp2Gwn2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0D7764149;
        Fri,  7 May 2021 06:31:13 +0000 (UTC)
Received: from T590 (ovpn-13-197.pek2.redhat.com [10.72.13.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3EC45D6AB;
        Fri,  7 May 2021 06:31:06 +0000 (UTC)
Date:   Fri, 7 May 2021 14:31:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJTepqtgw3+K5vWr@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org>
 <YJSFm99PUlLedF+D@T590>
 <739456b9-e8d4-310e-9bf3-7b8930a1e51c@acm.org>
 <YJSggHqgMFfWIALu@T590>
 <a2a7e66b-68e8-6468-2add-19ffbe096ed9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a7e66b-68e8-6468-2add-19ffbe096ed9@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 08:16:25PM -0700, Bart Van Assche wrote:
> On 5/6/21 7:05 PM, Ming Lei wrote:
> > Putting the lock pair after clearing rq mapping should work, but not see
> > any benefit: not very readable, and memory barrier knowledge is required for
> > understanding its correctness(cmpxchg has to be completed before unlock), ...,
> > so is it better idea to move lock pair after clearing rq mapping?
> 
> It depends on how much time will be spent inside
> blk_mq_clear_rq_mapping(). If the time spent in the nested loop in
> blk_mq_clear_rq_mapping() would be significant then the proposed change
> will help to reduce interrupt latency in blk_mq_find_and_get_req().

interrupt latency in blk_mq_find_and_get_req() shouldn't be increased
because interrupt won't be disabled when spinning on the lock. But interrupt
may be disabled for a while in blk_mq_clear_rq_mapping() in case of big
nr_requests and hw queue depth.

Fair enough, will take this way for not holding lock for too long.

Thanks, 
Ming

