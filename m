Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5398FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiESHxf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiESHxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 03:53:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B133E10;
        Thu, 19 May 2022 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B5cpWiyJrfxegy/gbK51jPPmCM2K6U8g7xBnC+gR7Eo=; b=wWmHtvr1QI5IubVYr2IEWyQx/W
        xTqvr3iBM7g2LaRaYd/m/KmIBkGdRJFZ8MWFPTL0Zfh6IvbXez/l9+fbFZzqovxUAU0qIQyRh6lpS
        GdWBQi60V1zGv80MeCAUP+mlMClhnhsh9d4gzXSeYMJ/u9woTHvWmBPYZDDHtXKQ54hZ+hrNHG52l
        /eDiWBDN+LYCNZCWshOZ9ExodIpC/jQVn2hqXXfVpSQMD+SueXQuvxnwGtDl8Ai9BHHFzD5l38HBt
        d+vgKm8212Y5qoGfKdU3wrFQuy5Q0sbC5v3DIRvv45V1ZxpJKN67x9yfaY5J1jftSC3fm4TfJTs9s
        8PhUtVkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrayP-005eWM-68; Thu, 19 May 2022 07:53:29 +0000
Date:   Thu, 19 May 2022 00:53:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: fix incorrect blk_status_t casts
Message-ID: <YoX3ebAlPIcFMpKn@infradead.org>
References: <YoH0/2FBC2YS9kk5@infradead.org>
 <55475ea9-5f6c-fa19-b52d-93fb89209850@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55475ea9-5f6c-fa19-b52d-93fb89209850@openvz.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Still a whole lot of casts.  Take a look at my "cleanup blk_execute_rq*"
for how think we can solve this in a much nicer way.
