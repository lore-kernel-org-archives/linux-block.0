Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5067BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 10:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243F1604AC
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 10:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhINKrq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhINKrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 06:47:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD80C061574;
        Tue, 14 Sep 2021 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6TeOkjMXXy254WVQrJQ02dTyZK+UojgkiKsmJoe+JRg=; b=XxVBnxLXKNj3NjKOYoX1cD0ef2
        IA3d4QG1/4KlnsdAOL5gr61uRGGLkVP2HZyYz0EgUUjOcuuvkd687kgjoauQq6dLuqwVdgOLOdoqs
        CLvw0N8l2JXnJRW5RdjQa36Hw9Fhym27iSVwsSfVrBrkcFvDeJYLjLhrOF8kNh7bqiy9MCuqUAJym
        t0EmdFYv/0IzHCkl4Lil7uGmyK/nzmwgsCfueEOLMqTMpc/vUfhZiXH0FdXo2LWo2TSZrfH+h1v6I
        FwykHb4wxPEVky12+ci3oUG6p2zyZFWuTDoQmU7djq2d0bSUlZmOGhd4v4gdwrX29IWF8PlXhjQp7
        Ji/9GdWA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ5wE-00EZUp-Sq; Tue, 14 Sep 2021 10:45:50 +0000
Date:   Tue, 14 Sep 2021 11:45:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: general protection fault in wb_timer_fn
Message-ID: <YUB9Pn4CrqYu7TMC@infradead.org>
References: <CACkBjsZxsm=91sf-ihJgEtx7tmBJr-yTrPbrvg6tP-_J4pGdGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsZxsm=91sf-ihJgEtx7tmBJr-yTrPbrvg6tP-_J4pGdGw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 10:00:27AM +0800, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit:  4b93c544e90e-thunderbolt: test: split up test cases
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1naN-5p-rFgKpHrshO_kQr5f_KlhvFGGU/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvAtJd6kfg-p/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/19EDhssGw_V1oO2vWOPrgQqve0TdFSgvh/view?usp=sharing
> Syzlang reproducer:
> https://drive.google.com/file/d/13EGCCoaMe9oitrQCfy44BkGVLbKKFP6X/view?usp=sharing

All these google drive links just lead me to badly localized error
messages.  Can you upload these to a less broken hosting platform?
