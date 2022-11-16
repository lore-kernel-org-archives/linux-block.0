Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1C4C43217
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKPV3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiKPV3C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:29:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6C14FF8B
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E014861FD5
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 21:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0958FC433C1;
        Wed, 16 Nov 2022 21:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668634141;
        bh=0kwXMMaWQoowwZaUSia1gptXZ3IFRHypINgR5ZFzPUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fubJun5fP98ugUz3EQElgHkgSFdtOPgxOdL0aWbVm8WwyBqINUURDI5KEbtlvEcX9
         u54dNdG3TZrU6pAkOONjM1o6o1ber7yt+oyeGCOxFzZ8ibowdaachemgBaT5Bs1pQ9
         aof1uYvF7qSNtS6yUVj8TfHGkqLcdf2ghLv9o41U=
Date:   Wed, 16 Nov 2022 13:29:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 04/14] mm: use part per 1000 for bdi ratios.
Message-Id: <20221116132900.ab7554e7e8342c4d30739bb1@linux-foundation.org>
In-Reply-To: <20221024190603.3987969-5-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
        <20221024190603.3987969-5-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Oct 2022 12:05:53 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> To get finer granularity for ratio calculations use part per 1000
> instead of percentiles. This is especially important if we want to
> automatically convert byte values to ratios. Otherwise the values that
> are actually used can be quite different. This is also important for
> machines with more main memory (1% of 256GB is already 2.5GB).
> 
> ...
> 

This changes an existing userspace interface, doesn't it? 
/sys/class/bdi/<bdi>/min_ratio.  Can't do that!

We could add a new interace to the same thing, I guess. 
/sys/class/bdi/<bdi>/min_ratio_fine or whatever.

We might want to go for more than 100->1000, too.  Otherwise in a few
years we'll be adding /sys/class/bdi/<bdi>/min_ratio_even_finer.

Also, this patch forgot to update
Documentation/ABI/testing/sysfs-class-bdi.


