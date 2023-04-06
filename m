Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43345C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjDFFkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDFFke (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:40:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D76A65
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TW3L7C/uDNQOPXo9uesDkN9Y7m9i5Xf7AS1NlCSkVxw=; b=IHJMNbRluiiLz7huvoT1e/VWbS
        pK4VJxgeCP6/qdjuD9m+698u/jXczBOq3JmH3gt+bfXZhwPoO+Hp6EFlokoJvIHhVUOl+VgqsawdN
        Jiiaw1pnf0dP3pfw9TR39V2MGEGlrLYR/CrUXLUPb5txhR6ACpRIzy05tlSZejJsSLJyfz2Nebefs
        Dt1yf3L39YZxeXvobSYDW1MU6Ax6YM3Z2pQ2crfe3T7FxLl1lBjzx2Ox3uhQmNeiBEwAND+jybC9C
        P9DWFJeWt28b0d3XASBlwaam8eRKq2QilXXs28Z+W9Nxx+hZ6DypNlHPC5/0AP3eH5Oh+/z+/vRgw
        Yl0xZDbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pkIMK-006OJZ-0a;
        Thu, 06 Apr 2023 05:40:32 +0000
Date:   Wed, 5 Apr 2023 22:40:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/16] zram: implify bvec iteration in __zram_make_request
Message-ID: <ZC5bUD5NOE9sUL7P@infradead.org>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-4-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

self nit:  there is a s missing in simplify in the Subject.

