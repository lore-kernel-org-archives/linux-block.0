Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DFEC2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1726120A
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 15:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhFQPaT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhFQPaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 11:30:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A27C061760;
        Thu, 17 Jun 2021 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PbwGL8bUjpxYyR+0WdEYqqiUEuC45HxDaoltM49QXvE=; b=sLJ65hxSTVZnExEtD7X5O31nHy
        mSv3dwFtB4qX5QQAtpcN22wofXoNPi/gqbGN3t+/h27T56amfUa7c/Of8T/kqJZWy56GFoEk20nOC
        /GhdwR/qIZMwyIZ6YJQs5UPLUL/pBKR0UHbLxYzaYu7Lg4zvdJo28Crs1NvL66xYxv3LxcZaXaOS/
        qOY5oFzn4diY1r5wam6CQgd1mPxszPTx5vW7joIP55WfuM17haOFZ98mpEgCTXaEPW2rdV2WJTwI4
        xP900Iq2zL0r6wKNClUtISYRV3wiuDkzjqDBV1RV59URj0GJgjg/ZGUTvaL25yeH+U4nXEkNuAMEg
        iKNubhCg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lttvr-009HTX-EK; Thu, 17 Jun 2021 15:27:52 +0000
Date:   Thu, 17 Jun 2021 16:27:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] block: break circular locks in blk_request_module
Message-ID: <YMtp957WK8sO4hwL@infradead.org>
References: <20210617092016.522985-1-desmondcheongzx@gmail.com>
 <YMs3O/cg4V7ywlVq@infradead.org>
 <ce1567cf-bc94-790c-cfc0-e4e429e1a86a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1567cf-bc94-790c-cfc0-e4e429e1a86a@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 11:23:36PM +0800, Desmond Cheong Zhi Xi wrote:
> This fix passes the Syzkaller repro test on my local machine and on Syzbot.
> I can prepare a v2 patch for this. May I include you with the
> Co-developed-by: and Signed-off-by: tags? If another tag would be more
> appropriate, or if you want to submit the patch yourself, please let me
> know.

Sounds good to me, thanks!
