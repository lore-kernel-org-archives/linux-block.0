Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD68DC28CBC
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 10:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8434120757
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 10:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Up5yTvbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgECKdP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 May 2020 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgECKdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 May 2020 06:33:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874FAC061A0C;
        Sun,  3 May 2020 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NVgfAQiZlxOABFwVx8sCt58upVGoPzZ3/+5tTskAEzo=; b=Up5yTvbdgCqKpxfrLNWh9c3JZk
        I+8FbiIZmHCIm2JCxKt09apGC5I5x6cF/RL93NLAtpSieu2syqMFqqJrYmjfGZJjEtUSnDonsfh7q
        TaoEyN5MFFuqt9TZVWgJpmUYJ378Wtw5q2pZ3yDJbp+ooe0vU137aRmyRCl3daLbVtx4vicESLVZB
        Cui5CKyCJNLBuDC90yEMk+yzkz//WtSSYaWnMk21ODDl/DvMN37Gf9QsKtgk+5t7W/6WeToBm+gZ4
        DJU7zPvHrbonR+ZNg9lh9rCrN81lIwdj0sO9Hc+ZKKKFtyXLMgy3BoD9e0aPJvwdnXa+euy8tz2z9
        focJwbFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVBvR-0008Au-U0; Sun, 03 May 2020 10:32:45 +0000
Date:   Sun, 3 May 2020 03:32:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 1/6] block: revert back to synchronous request_queue
 removal
Message-ID: <20200503103245.GG29705@bombadil.infradead.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-2-mcgrof@kernel.org>
 <a2c64413-d0a4-e5c8-e0fa-904285a1189e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c64413-d0a4-e5c8-e0fa-904285a1189e@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 01, 2020 at 05:22:12PM -0700, Bart Van Assche wrote:
> > expected behaviour before and it now fails as the device is still present
>            ^^^^^^^^^
>            behavior?

That's UK/US spelling.  We do not "correct" one to the other.

Documentation/doc-guide/contributing.rst: - Both American and British English spellings are allowed within the
Documentation/doc-guide/contributing.rst-   kernel documentation.  There is no need to fix one by replacing it with
Documentation/doc-guide/contributing.rst-   the other.

