Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A07C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA0520882
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxTiJLbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFPOiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgFPOiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 10:38:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63DDC061573
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d/jjfL3xxeXCem2/UJQgSCRy6CaYGok2Vu3n/4UrbTY=; b=pxTiJLbvx5hEUJiHDK/vdXLfnY
        wbYXvE+3zrzXjAh6Ctj/0oNu/ZhvOFi00OF5FFg57WcKE4IuYOhhgb2kX+FzEGXifISph6AFkNB8N
        sbpp2X+wd6/nvHOg8Sn/JTfCK96SYZhs+eYKc+erxwJ8an9QER92TARcyrj2ualAER2X2VlcTk7o3
        HdGF6+UKOHeWhtkLG424r50h7sFWBtAOglCNKw5lG5K+KfLuPlD3oqoAuyRA224JXzWslb07US3nd
        rBFz5FCtLavM4ghF3C1xcQ9AgU5AmtpX4FhxHNiz8+Hyx8gtUVBj34QsgtmUUplzxxuUSyUsUqnj4
        ZCH32YSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlCjC-00079w-47; Tue, 16 Jun 2020 14:38:18 +0000
Date:   Tue, 16 Jun 2020 07:38:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sweet Tea Dorminy <sweettea@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-block@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] block: add split_alignment for request queue
Message-ID: <20200616143818.GA27156@infradead.org>
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
 <20200616072955.GA30385@infradead.org>
 <CAMeeMh-beYNtEA1TVvO5v=6BAnqSyyAFgkFN=Ngr2Z0UDfipSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh-beYNtEA1TVvO5v=6BAnqSyyAFgkFN=Ngr2Z0UDfipSA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 07:12:48AM -0400, Sweet Tea Dorminy wrote:
> Hi Christoph;
> 
> Forgive me my newness and not understanding most subtleties, but I
> don't actually understand why you say "that is a completely bogus
> assumption" -- could you please elaborate or point me at a
> document/code/list archive explaining?

There is absolutely no guarantee in what way the Linux kernel splits
and merges I/O requests.  Even more importantly there are absolutely
no guarantees about the on-disk atomicy in the face of I/O failures.
