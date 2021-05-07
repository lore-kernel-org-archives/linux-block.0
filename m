Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B63EC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6123761164
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 06:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhEGGyK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 02:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhEGGyD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 May 2021 02:54:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5ADC061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qe0k6z5u+b6SjFffNaQdzu2N3hLqsbRlL+JB6nrpbM=; b=SI10lWRH0JACHvNtl9IZLSMo8y
        OuEwkpJg/XBQHBerxxc+6X0QDfOA7No7TwSReOZxeBon5ucjrGeL7DTALiy7UnuY2pMPKY2ktfeP4
        TTceQgS0HSpiK7z3iLTwijAlbSQoEWNxggVDYCv7gTHO84PJBTIjBLGXX7kpItDCgT5vT3geu5fZ8
        7H0ZQO5HYHWdt+7A8a7ybv3kQE+aYxRNacoNV8drYSCvric+LHli62qlrFfto8F8iEd0zeWoPo5Cp
        ufzSRzVP1KuMHpXcg1sTt6KkRnwRymSgm0ZyU6oRnAjPB79LCGlv2m005MQSdjRZy35huASbYy6c1
        ULFVz16g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leuLa-002uPH-VH; Fri, 07 May 2021 06:52:29 +0000
Date:   Fri, 7 May 2021 07:52:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJTjqtbjjbU8Fwgk@infradead.org>
References: <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org>
 <YJSFm99PUlLedF+D@T590>
 <739456b9-e8d4-310e-9bf3-7b8930a1e51c@acm.org>
 <YJSggHqgMFfWIALu@T590>
 <a2a7e66b-68e8-6468-2add-19ffbe096ed9@acm.org>
 <YJTepqtgw3+K5vWr@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJTepqtgw3+K5vWr@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 07, 2021 at 02:31:02PM +0800, Ming Lei wrote:
> > It depends on how much time will be spent inside
> > blk_mq_clear_rq_mapping(). If the time spent in the nested loop in
> > blk_mq_clear_rq_mapping() would be significant then the proposed change
> > will help to reduce interrupt latency in blk_mq_find_and_get_req().
> 
> interrupt latency in blk_mq_find_and_get_req() shouldn't be increased
> because interrupt won't be disabled when spinning on the lock. But interrupt
> may be disabled for a while in blk_mq_clear_rq_mapping() in case of big
> nr_requests and hw queue depth.
> 
> Fair enough, will take this way for not holding lock for too long.

Can we take a step back here?  Once blk_mq_clear_rq_mapping hits we are
deep into tearing the device down and freeing the tag_set.  So if
blk_mq_find_and_get_req is waiting any time on the lock something is
wrong.  We might as well just trylock in blk_mq_find_and_get_req and
not find a request if the lock is contented as there is no point in
waiting for the lock.  In fact we might not even need a lock, but just
an atomic bitops in the tagset that marks it as beeing freed, that
needs to be tested in blk_mq_find_and_get_req with the right memory
barriers.
