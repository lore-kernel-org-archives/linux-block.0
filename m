Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E804C433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 06:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CA960FC0
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 06:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhIMGL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 02:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbhIMGLz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 02:11:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4ACC061574;
        Sun, 12 Sep 2021 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j1VgGedRt8a4TmNVCvWVMlPcZTUQAnlRvRfqbP/+who=; b=ruoSvBX84tnVZP0o0bJ5gmjMdk
        +yixEKGgS8N7b6NbVaozUFCoEFOn1LxoteRtbeMdEYMY/Euz8fGK2miAcDK/gnt9KeVfPw1/jYr19
        gWQeeJFBVF+lSyI9gGIaZ4w3JnPSMTBVuyMF5tkFz0dVv/ch+A4w33urGALJI2iEjJ/UrF9iPlJ/r
        3FaoRSUILI0HN9iD6pVYBTTo38Y6C0zwGJN1QXksF0kmoP2xkdEOhrfF3nm148Mgdfm562zRmrPAM
        4gz8WeQo7q5ZqpHfeCs9U2YY5m8jru4QuZTSWnWmNebWVxbHFTHrPMcrsRqcOlVgXIRiZZ4YerZFD
        SC/pd/5A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPfA7-00DDpH-IK; Mon, 13 Sep 2021 06:09:58 +0000
Date:   Mon, 13 Sep 2021 07:09:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Message-ID: <YT7rL4PhovDOHfHO@infradead.org>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
 <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 09:54:54AM +0530, Praveen Kumar wrote:
> >> +EXPORT_SYMBOL_GPL(blk_mq_submit_bio);
> >>
> > 
> > Where is the code that used this API ?
> > 
> 
> Thanks Chaitanya for your response. Please check my response to Christoph.
> That should give overall understanding of the use-case.

Which really doesn't matter, while you keep ingoring the relevant
question.  If you code is not upstream or at least actively being
submitted upstream your questions have no relevance whatsoever.
If you do not undertand that basic fact your are in the wrong place
here.
