Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D4C433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDD720714
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 11:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+gWaiJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgFOLwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgFOLwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 07:52:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451FC061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sGslBeJnyrx6kSE8sbIGabBLibRnXccxUAHYptuBd4g=; b=p+gWaiJtieLa26U/jJ6Kya+PtC
        zj5MJKjSxcRtSgmNLv+9/ENJjmmBS2cnbyEV4DGN2RLIVJBl69ajhmShAan+kpTj2swl5igmuTIR1
        /c15+i0L7iIaaHWXWsf+PhuPHaVdxgoeV0MdbtLUxH3DvOPbRrE2M6jCZC0XGQdYj0z6kX47hz8M8
        V8DKqnvP38504YWtlZOXLpQZpm6oNpzxIU4tjaKH3zMv6qRHC/xArEEQOT/NqxdjrOGzAZOQJdCrm
        qeIkhZBi9w9c3QNTNIuylgFN2zNwtfU8TyYdZuI6kG08RT6mC3uxwjVcMdHk+s4TPcKNt4fUTs4Un
        eNP7VfrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknfI-0001bI-Ss; Mon, 15 Jun 2020 11:52:36 +0000
Date:   Mon, 15 Jun 2020 04:52:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Message-ID: <20200615115236.GA28124@infradead.org>
References: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 10, 2020 at 06:33:26PM -0700, Harshad Shirwadkar wrote:
> Make sure that user requested memory via BLKTRACESETUP is within
> bounds. This can be easily exploited by setting really large values
> for buf_size and buf_nr in BLKTRACESETUP ioctl.
> 
> blktrace program has following hardcoded values for bufsize and bufnr:
> BUF_SIZE=(512 * 1024)
> BUF_NR=(4)
> 
> This is very easy to exploit. Setting buf_size / buf_nr in userspace
> program to big values make kernel go oom.
> 
> This patch adds a new new sysfs tunable called "blktrace_max_alloc"
> with the default value as:
> blktrace_max_alloc=(1024 * 1024 * 16)
> 
> Verified that the fix makes BLKTRACESETUP return -E2BIG if the
> buf_size * buf_nr crosses the configured upper bound in the device's
> sysfs file. Verified that the bound checking is turned off when we
> write 0 to the sysfs file.

I don't think the configurability makes any sense.  We need to put
a hard upper cap on, preferably one that doesn't break widely used
userspace.  Just pick a reasonable large value to get started.
