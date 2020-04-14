Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9F4C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA714206D5
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="te8BkjAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440988AbgDNPwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732058AbgDNPw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 11:52:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC322C061A0E
        for <linux-block@vger.kernel.org>; Tue, 14 Apr 2020 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r12VrXLVPVlZ5CWNog7R0IAZQ8e6rSVHOAuaiO7Wj5Q=; b=te8BkjAng6TouFcWWOaYDd3hdU
        JGoE0QeQ74CMq4rXQKBNvNJcJb9F72eJpFezhxe4eyQnd1YFiWF9lC/gDFhouZlDeYAm2NTZvkEsq
        SDuvO/d4Jr0A9aG63FHtcMMcbZuz7xoG+FZbEoZxcwnFQAHfKRkWpLElvYkcjJXxObVE1lPjXRKG7
        vXczOgtN9SMrD0U7d738wbS9SWVCk4Suy6O9blfzdbOND6/EBxF2aeo12Bh1toBIefjbXe2VrOn3L
        5WB3he3ojC2P7aDzk+UVlO335x9GN0+z+5+wZIyhdZQg38lqfJaybrkW1UKDkafxbRPd4c8zXJSw7
        V7Uk+/BA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jONrQ-00085b-Jn; Tue, 14 Apr 2020 15:52:28 +0000
Date:   Tue, 14 Apr 2020 08:52:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, hch@infradead.org
Subject: Re: [PATCH v4 0/6] bdi: fix use-after-free for bdi device
Message-ID: <20200414155228.GA17487@infradead.org>
References: <20200325123843.47452-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325123843.47452-1-yuyufen@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looking through this series the whoe approach of using a lock to clear
the ->dev pointer looks rather odd to me.  What is the reason for now
simply adding a separately allocated name field to struct
backing_dev_info that the name is copied to on allocation, and then
the ->dev field is not relevant for name printing and we don't need
to copy out the name in the potentionally more fast path callers that
want to print it?
