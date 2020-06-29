Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64950C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359F320663
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h/0ZYCeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgF2UwD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731376AbgF2TN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:27 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF465C014A48
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WYcgLUPPIkQEwuVVHcdOzviCm1fV4H4LG7Xv2ykyIuc=; b=h/0ZYCeTRyDap3hB4mo2EH3soH
        30WW/HuD3YhTJ16aV4adgOE2zzvnAttEG8I6DSw7lkYA6KgCxM/HH/WEximMvhVkourON0BmlOT3i
        xhPXO5+DDcpteb1Ra4APyHGyPtj0h7j7uNi7rrUt0fYZS8PyNp7RiEE/AU1afDCWNvWKuyyfR9JSC
        0UKip+Lb5ojhXNteRmsvJd+aRxemIh+mTmAYgBtngATRzbGqont10CyzGMs+I3xHQ5Ev2xyc3yqCv
        7GCtWiWeKQU9jBFFFOsqxfNkb91c4g8rNxStP/CUc4yHWj6D3ss6eMIiN9pWvE1/kp4la90gmdWZa
        JV2jYnBg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpotT-0007cS-QN; Mon, 29 Jun 2020 08:11:59 +0000
Date:   Mon, 29 Jun 2020 09:11:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Message-ID: <20200629081159.GB28551@infradead.org>
References: <20200624230349.1046821-1-ming.lei@redhat.com>
 <20200624230349.1046821-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624230349.1046821-6-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 25, 2020 at 07:03:48AM +0800, Ming Lei wrote:
> Pass obtained budget count to blk_mq_dispatch_rq_list(), and prepare
> for supporting fully batching submission.
> 
> With the obtained budget count, it is easier to put extra budgets
> in case of .queue_rq failure.
> 
> Meantime remove the old 'got_budget' parameter.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
