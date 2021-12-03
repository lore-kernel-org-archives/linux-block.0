Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C505C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 15:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352723AbhLCP7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:59:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60954 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245493AbhLCP7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 10:59:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD0BD62C20
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 15:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CEDC53FCD;
        Fri,  3 Dec 2021 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638546974;
        bh=rvMvltktMtExYZ7AZl518IYoxbqSSps5tugrf2qPawo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Orygo4JtyBvDrOrc4kywHixt5LMSVISuclEG9DYrSlwChNl1UgRIvswp7/AUY+xP1
         Qcbm2W56uTFIw0kHh1Wt+s8KZkVlJwY5PrzsYoUuAm8uW+rfDY50CZBeF74cACZuZ9
         E0fNHX+B8HpEcJGYmmjcHNkEvYhxslzrlThzBbgx/7opyixHtclAUW9hEhxPETFir3
         vpoBabHRzYfuQiwVb5rGq5tLWK31cl5IRJbB3AGygGU5gcJdrZy8f6bW9xRv0Z4/7B
         GEhxMcbyZRaocq0CD1mu+gVVHfxowt/kgcQO60QO6rl67O3eAZCat4TuP0roycpa/Q
         jpAjDYdCdjDSg==
Date:   Fri, 3 Dec 2021 07:56:12 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <20211203155612.GC3839336@dhcp-10-100-145-180.wdc.com>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 03, 2021 at 08:35:40AM -0700, Jens Axboe wrote:
> refcount_t is not as expensive as it used to be, but it's still more
> expensive than the io_uring method of using atomic_t and just checking
> for potential over/underflow.
> 
> This borrows that same implementation, which in turn is based on the
> mm implementation from Linus.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
