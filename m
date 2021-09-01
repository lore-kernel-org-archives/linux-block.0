Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242D3C432BE
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 05:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F7060F4B
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 05:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhIAFce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbhIAFce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 01:32:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD63C061575
        for <linux-block@vger.kernel.org>; Tue, 31 Aug 2021 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6j+mfE77Vgg14EIyB/fj3b4vkJSqk4/W6hSi6gMSgu0=; b=gH6LxRgJ13gNGq5WJLgJ9RARWJ
        em8VQ6LkuIk+rhnxO0BdMdjHfO45LZXc4D3EMhLwViqMaAzbydtiGvYg5tpc/zdWRL9jKAK0bGgr5
        LR/miUPLFCFC5b3/XkCyZ7fziaLl/H6ljTZ9fenXkafWk14vEQ6iskMEvo2Xix7/jz+hpPjY2FWqX
        3tGGcdVneYk8TK1/g4Uq/uR73Rq5d3BvmNEhWq5MXUiJaqSzJakw8QcsIUwzsD6lsd4yGEeK6I1eV
        IJ9U1G+CYc8MMq/JaBWr3acrnU0MY1NCnKoGVMEkZyOCVEXf5N/EFCMUA6lGd4rHOZEa1ACd2UzMf
        OHnxVAHw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLIpj-001uGS-8b; Wed, 01 Sep 2021 05:31:00 +0000
Date:   Wed, 1 Sep 2021 06:30:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v3 0/8] block: first batch of add_disk() error handling
 conversions
Message-ID: <YS8QB2qw3sQXU4Yu@infradead.org>
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <cc6470a2-7e32-c582-2c45-1358d3f6de1b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6470a2-7e32-c582-2c45-1358d3f6de1b@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 01, 2021 at 01:19:44PM +0900, Tetsuo Handa wrote:
> Are the changes by add_disk() made atomically against the caller?
> If there is a moment where "struct block_device_operations"->open can be
> called when add_disk() might still fail, how is it protected from the
> kfree() path?

The new add_disk is structured so tht it won't fail after the block
device inode is hashed.  That is, the last possible failure is before
->open can be called.
