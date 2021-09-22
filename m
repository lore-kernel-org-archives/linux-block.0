Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C086C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F0F61107
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 14:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhIVOo3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhIVOo3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 10:44:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B5C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=V7G9YO2qWbblZWHhvY5RD/4IP4
        /7OG6IFwJyI2Krko1l+zcAVoBLu5eBgfjBbppAP9i6onQ3BaSd2RHaVW4GppoV0LRHUx22OnYCK8X
        9LUw8+SwUfFUgsme2YE6Vec2Yx/tQjNbCb8GcV2tySWR7fbxAV+8jOWFfxqU3tlTV0fRcplo2x8OG
        yRZKbjSe3DFoz4eLfFntVgCmXksbgIQwi6OKRoq7skjXaE1Tsvo23Jw/C5QrTuMMf1S2ArsYapgXD
        CvZpZdbk9rhd1HQbs9Ra8yr4l/srVz5V+L70+uwzckC1vc1ZTAflhFkgRpgYrZ3HLHRUtfOiyi9+F
        LP7du99w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT3RR-004sFp-0L; Wed, 22 Sep 2021 14:42:06 +0000
Date:   Wed, 22 Sep 2021 15:41:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: Re: [PATCH v2 1/4] block: Add invalidate_disk() helper to invalidate
 the gendisk
Message-ID: <YUtAqBVbjAIwK8PK@infradead.org>
References: <20210922123711.187-1-xieyongji@bytedance.com>
 <20210922123711.187-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922123711.187-2-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
