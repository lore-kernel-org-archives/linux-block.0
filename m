Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DBC28CA5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913CC61139
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhIIGoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhIIGog (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 02:44:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFDAC061575;
        Wed,  8 Sep 2021 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ZCnLsYvuS3291/ykaTnxYxXK3A
        //Ot/DWxChH7LJ9EtShPlrY+l4pLZkV4L1QDtqyByukH5XOw8ix8XDTG64+r65Ti3EWTV913Z9Lt5
        xtBJT01aoq/+w/OW1ugGXf01ZUgHSeqk/U3fepvd8yFtNKaGvAtmTjzMhGPfmecEJLnyA9UTGoi++
        IjW3y2TZEYe9HaXgjzI8/a7pCJWlZdbuHREHRkSAsoYby1vZ9EAYxuWrh7lWqzq5fnJhI5YfRJQfK
        emC1F9+s/PrCePAR9WWK8l67Vky92Vl5x4JzTH1TB0UnxGuaZokoaRxmvApBRGDL1J5+MOFQMLiQt
        ikLPW/xQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mODkv-009YKp-An; Thu, 09 Sep 2021 06:42:13 +0000
Date:   Thu, 9 Sep 2021 07:41:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v4 6/6] nbd: don't start request if nbd_queue_rq() failed
Message-ID: <YTmsse4cDT49i5My@infradead.org>
References: <20210907140154.2134091-1-yukuai3@huawei.com>
 <20210907140154.2134091-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907140154.2134091-7-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
