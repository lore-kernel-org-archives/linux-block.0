Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E62C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Feb 2022 20:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbiBRUNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiBRUNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 15:13:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A324B292;
        Fri, 18 Feb 2022 12:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aHgTDtKeKxcYGanWKPDCgIs+EK5dBv3Z/UXQu0nW+Xc=; b=KxRtEX5VJXZ0/UKZjrddLeLa+/
        rrenu+4mxsbHNTvvYwYwxCmp3MtbdzbJUnY404h39OZPmn43zcFFbfHfismMeWGZGQQ4PZAjFdRnR
        tXvqVqTCgepxgNRhL0Ddnu47sumPHnILGQxKIGSB9qKEZ9ZYHkUuQrpNjxevF3guqA4MaBLG5qyP/
        Fk/WRLbV9lNg70aY7vfuEDRriZuczUM1ln368cwuyKQMN6suGQUb/QBF76My6dWratncPK954okGz
        PX6onM4DBCRRLlaE8Ztjm96Kkq/lRm7idcmFKYQE1IWPHk0RAz8aZPP3+DUIxToMOS6zoghD4L7pN
        3BQPvUAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL9ci-00GtzU-Pz; Fri, 18 Feb 2022 20:13:00 +0000
Date:   Fri, 18 Feb 2022 20:13:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 01/13] fs: Add flags parameter to
 __block_write_begin_int
Message-ID: <Yg/9zKvlwkVJqj+p@casper.infradead.org>
References: <20220218195739.585044-1-shr@fb.com>
 <20220218195739.585044-2-shr@fb.com>
 <Yg/6qDCDuCLGkYux@casper.infradead.org>
 <d6a89358-c43c-9576-91bd-d90db4d2aa42@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a89358-c43c-9576-91bd-d90db4d2aa42@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 18, 2022 at 12:08:27PM -0800, Stefan Roesch wrote:
> 
> 
> On 2/18/22 11:59 AM, Matthew Wilcox wrote:
> > On Fri, Feb 18, 2022 at 11:57:27AM -0800, Stefan Roesch wrote:
> >> This adds a flags parameter to the __begin_write_begin_int() function.
> >> This allows to pass flags down the stack.
> > 
> > Still no.
> 
> Currently block_begin_write_cache is expecting an aop_flag. Are you asking to

There is no function by that name in Linus' tree.

> first have a patch that replaces the existing aop_flag parameter with the gfp_t?
> and then modify this patch to directly use gfp flags?
