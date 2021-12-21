Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbhLUQTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbhLUQTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:19:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994EC061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=rMtQQpm5zbIX5yVZoWIuRyrkGo
        UEPzEZDD0ryawSGtlyYJbGYFTfAK6wlO0uagOLWKzUejiticZ+FqSyVdcmnHRTqOn6J9t7pN8vzSO
        rM3piM6tSnZMIlp4l02tSKJC+h59K1rJecNqm/2wSy4s4luVXaylVQPCY9bqxWomq+yuFbqadq5WX
        X6dTWMmmqTzratqvGjSRosF6ADx2fMJF2h2KnnONQ5h3C5MwStb13X9ueiDOsxuvMvwM3vMXxu9ft
        iu1ENeMA0v95nLI7eK5lntEWxV6q/oB5kjXHJfTUkJLosaJ6sqfW/wCUzLhmiwAKWUUO9nEL1j39h
        y+AHejag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzhrV-007XXS-DZ; Tue, 21 Dec 2021 16:19:37 +0000
Date:   Tue, 21 Dec 2021 08:19:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: check minor range in device_add_disk()
Message-ID: <YcH+mWIUcO7WvppD@infradead.org>
References: <b1b19379-23ee-5379-0eb5-94bf5f79f1b4@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b19379-23ee-5379-0eb5-94bf5f79f1b4@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
