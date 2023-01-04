Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F1BC4708D
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 19:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjADTNt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 14:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjADTNs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 14:13:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024434741;
        Wed,  4 Jan 2023 11:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10875617EB;
        Wed,  4 Jan 2023 19:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B87C433D2;
        Wed,  4 Jan 2023 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672859626;
        bh=Ij0mrFcW6uT75Z62D42qxMtie8o67ZCbOW7kGd0W7Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLOW9DFX++NsbeT3eV+svUUzgn6Elqlyvhvp3UaDB49bAzvA8I8DMli2cXEgxtejL
         N0noFRxiQM3dtkU+9kPbRJq2tqMyZvLxzJcgCgW2bqfbr+xrKSJOz37nz0SvqTpWfY
         U5JHY99a5y+rFGSNBnW/1pJ2HBQCuPMeP5cviSntFLb/j808J0WFXr7NSpUwonPnOB
         irXxf3BxRXV1kN+/B8HXlZOokTmmrCIRWiHDtmkCMTLl6XWETVsw9sFpv+3WYtrlNB
         2ea8a1pyXokmd4YGVYaCGMbxeUT7wV9y03f1qEOxaXXKr2/Diu1Uy5CwJPqNcjNF+6
         6XHJithFHqJQw==
Date:   Wed, 4 Jan 2023 12:13:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, mikelley@microsoft.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] block: don't allow splitting of a REQ_NOWAIT bio
Message-ID: <Y7XP5w9cTyHJHwta@kbusch-mbp.dhcp.thefacebook.com>
References: <20230104160938.62636-1-axboe@kernel.dk>
 <20230104160938.62636-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104160938.62636-3-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 04, 2023 at 09:09:38AM -0700, Jens Axboe wrote:
> If we split a bio marked with REQ_NOWAIT, then we can trigger spurious
> EAGAIN if constituent parts of that split bio end up failing request
> allocations. Parts will complete just fine, but just a single failure
> in one of the chained bios will yield an EAGAIN final result for the
> parent bio.
> 
> Return EAGAIN early if we end up needing to split such a bio, which
> allows for saner recovery handling.

We're losing some performance here for large-ish single depth IO with
nvme. We can get a little back by forcing to use the async worker
earlier in the dispatch instead of getting all the way to the bio
splitting, but the overhead to check for the condition (which is
arbitrary decision anyway since we don't know the queue limits at
io_uring prep time) mostly negates the gain.

It's probably fine, though, since you can still hit peak b/w with just a
little higher qdepth. This patch is a simple way to handle the problem,
so looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
