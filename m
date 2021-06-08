Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7976EC47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605826128E
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFHRND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhFHRNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 13:13:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E853C061574
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=StseGrna69MbN/skOCLk29Jv0N
        zmleI6KI2sn9XoyIv6hg8oP0AGqWmznEe2AiNJ6gIE+A1AOyJoRYxvWCV36ffdJRf5IpbVKsszjZJ
        7WgLx8QlQ9BpFibiD7yf1x/OSPtJsMZkgjiD1tu/hkAfydPYKrvGCQ1sfi5/ym7m2sxgIm2NtrBos
        duVbyKb7baIVfeOzXRsKqAooiyx53qXF9L36Ldkz86dJ/AdV+DISr8GMfenrNywV8n//Zq08nV7jg
        VB1AXludo2Z6Zo6nK+UaDyC45LtbuAzVDaGkAmFiMEkkLWGALtu6qXmksel4b/kf7/NVBDJ8RKVCi
        /1SiB1uQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqfFQ-00HBgu-Pe; Tue, 08 Jun 2021 17:10:46 +0000
Date:   Tue, 8 Jun 2021 18:10:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jack@suse.cz,
        hare@suse.de, ming.lei@redhat.com, damien.lemoal@wdc.com
Subject: Re: [PATCH] block: check disk exist before trying to add partition
Message-ID: <YL+kkLIZ+1Vwpip4@infradead.org>
References: <20210608092707.1062259-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608092707.1062259-1-yuyufen@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
