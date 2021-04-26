Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E7C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8A961077
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhDZRGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:06:10 -0400
Received: from verein.lst.de ([213.95.11.211]:42164 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235548AbhDZRGB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 13:06:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FF8868C4E; Mon, 26 Apr 2021 19:05:17 +0200 (CEST)
Date:   Mon, 26 Apr 2021 19:05:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: switch block layer polling to a bio based model
Message-ID: <20210426170516.GA1443@lst.de>
References: <20210426134821.2191160-1-hch@lst.de> <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can you test the force pushed update?  This now avoids the RCU free
for each bio and just uses SLAB_TYPESAFE_BY_RCU instead.
