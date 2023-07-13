Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F8BEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 11:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjGMLph (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjGMLpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 07:45:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65FE5C
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SF7Zi4RxcSPTtMtQLf8MLU/ZUKKairUCR+Tv6++R/gY=; b=ExGwj+8XwkAbyX1LApe+utaTcJ
        sXXK3wWCakjP9OsSPOtTjPcJQy4IUUeQ1F3R6eA+0ealHBOmj0DkyugfCJbNZ1+tugmk0Z1VJBcoO
        1AAqCzUtkw0YCHLb0Zxet8lE98shZfSpWfgQpTU+jgR6/P2Ftq5I0NDzux7P1GFSFc747QeZ6mISG
        0I0xSIc6h3sMNxCQhPbLyUtSsaVIfLBo8LngAUewjv7/9T8vkGi8/+7X53R/U6zMhsr5B1+O3gPR0
        pvsfumCGYCqXAPSXN3FXJ0z4u7IyaITKhalpyhzKS9yUXeJQMU/mCuZjiMPmf71HTtpejUztirO1T
        9CtOvquA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJulF-003872-2u;
        Thu, 13 Jul 2023 11:45:29 +0000
Date:   Thu, 13 Jul 2023 04:45:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2 3/4] brd: enable discard
Message-ID: <ZK/j2URSDt4nwSvk@infradead.org>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201358120.26535@file01.intranet.prod.int.rdu2.redhat.com>
 <ace0451f-b979-be13-cf47-a8cb3656c72e@huaweicloud.com>
 <4b6788d2-c6e1-948-22d-dbb7cbba657d@redhat.com>
 <2ade2716-d875-5e4c-82ce-c4c7f00f1bbc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ade2716-d875-5e4c-82ce-c4c7f00f1bbc@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 10, 2023 at 01:05:00PM -0600, Jens Axboe wrote:
> When a series is posted and reviewers comment on required changes, I
> always wait for a respin of that series with those addressed. That
> didn't happen, so this didn't get applied.

... independent of that any software that assumes all block devices
can discard data is simply broken. 

