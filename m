Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE777C76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjC1U2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1U2P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 16:28:15 -0400
X-Greylist: delayed 12651 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 13:28:14 PDT
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26096E5
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 13:28:13 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680035292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1PRkPAtZiO7+GA2eg+pzPnGLDw8cjg/JDzX3oBa/TI=;
        b=eI2Kq2e1Mx+VW5MF7uu7y/MJkBWRyUfiNwHfHg4DxeQkBkihKNLikz09sVXRtrlr4+G8M1
        nPhQr8opCHHOSe9GQWQc6Kedw9m0Wqxo+MvKY9YjqWGCoFEJxUcvTMPP5T58htlTfm+eka
        rasIPJYpojmSp3h11qityqYPROB/txo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCNN2GE3WBjMkLkH@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCIVLQ6Klrps6k1g@infradead.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 03:14:05PM -0700, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 01:44:00PM -0400, Kent Overstreet wrote:
> > Small patch series cleaning up/standardizing bio_for_each_segment_all(),
> > which means we can use the same guts for bio_for_each_folio_all(),
> > considerably simplifying that code.
> > 
> > The squashfs maintainer will want to look at and test those changes,
> > that code was doing some slightly tricky things. The rest was a pretty
> > mechanical conversion.
> 
> Can you post a code size comparism for the before and after cases?

6.2:
kent@moria:~/linux$ size ktest-out/kernel_build.x86_64/vmlinux
   text    data     bss     dec     hex filename
13234215        5355074  872448 19461737        128f669 ktest-out/kernel_build.x86_64/vmlinux

With patches:
kent@moria:~/linux$ size ktest-out/kernel_build.x86_64/vmlinux
   text    data     bss     dec     hex filename
13234215        5355578  872448 19462241        128f861 ktest-out/kernel_build.x86_64/vmlinux
