Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBFAC433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C496125F
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbhDLJba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242115AbhDLJ1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:27:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4CC061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ewECoWXjFufcTcBEA3sGrKKbCn2MMxY1VG7zTTsOaUw=; b=YwlcGEAnSOWv7RGnXN8qBemTqT
        cCUVEokpBcF24P/sZ3EipRgQylkP6jWTCoJWNTB33tBlcL/CNOt4fVmrFlBMA7GjzQV3scpFtxblk
        uvLDBD1cNqbm9bzXn4smG9s3Bl/IO0R8yGM4c57OPl/PJ+AHmtA28BgqcsFnTsKYPj5fLGVh0zS73
        xv3eooElAS1Y2v7fuhn5PEjEfIuNdm0ApqOgMVYOEAtRvzSXgpMtjilVd1UFEvzexKhzrzRmJM3IP
        w775W5v2wdXHRkS9evgQvFK9r6lESEQ3rOMHiR4YQHKeYqHUfJmp/4JFBkCqR1Ip9jBzHaEUqn6Bd
        9uGH0D1Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVsqL-0045x5-8H; Mon, 12 Apr 2021 09:26:54 +0000
Date:   Mon, 12 Apr 2021 10:26:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 05/12] block: add new field into 'struct bvec_iter'
Message-ID: <20210412092653.GA972763@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-6-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I don't like where this is going.

I think the model of storing the polling cookie in the bio is useful,
but:

 (1) I think having this in the iter is a mess.  Can you measure if
     just marking bvec_iter __packed will generate much worse code
     at all anymore?  If not we can just move this into the bio
     If it really generates much worse code I think you need to pick
     a different name as  as that i really confusing vs the bio field
     of the same name that is used entirely differenly.  Similarly
     the bio_get_private_data and bio_set_private_data helpers are
     entirely misnamed, as the names suggest they deal with the
     bi_private field in struct bio.  I actually suspect not having
     these helpers would be much preferable
 (2) once we do have the cookie in the bio we need to take advantage
     of that properly.  That is stop returning the cookie up the stack
     as we do right now but just rely on the bio, which will clean up
     tons of crap.
