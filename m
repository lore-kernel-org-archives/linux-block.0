Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2200C4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 20:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKCUjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCUjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 16:39:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C6DFFB
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 13:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97EAFB82A04
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 20:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85618C433C1;
        Thu,  3 Nov 2022 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667507971;
        bh=RHAZe3GqgR+VgFxzGfLlFgwffbK+mipPN01FLSK7k8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c475ZXwDXYcU1B1/IoE7sNlRQy6OhTPQPzrOqlFpLvlCFgLJXWsEmUhWu4W0umeLX
         IkN9H7oC1UiIQuEViRegZvB5rEA3duHDLdlQIDTBhxJ4vpbaqVpC578ct/BxqCVP+E
         toH9SI+ACwLVqaO/ik0TOi8EC018fGhzsQ6k1S5f2qhQdFxdRYeVIW7TpFYsCzk/WU
         5kX507Ji0g/ThuEpJDC9z5YL7J1Ypzngz327IoqrJTBLHB4lvk4kSt2kpzfALXFHmh
         g2uhUme5dp9GBWDfD3ZlbGREm0C95KKiQG08Xj1qcoeHXDDOL+DTeplnG8TKfG6lRI
         ral10Qxl/LxBA==
Date:   Thu, 3 Nov 2022 14:39:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk, stefanha@redhat.com,
        ebiggers@kernel.org, me@demsh.org
Subject: Re: [PATCH 0/3] fix direct io errors on dm-crypt
Message-ID: <Y2Qm/yGlVbDRskkr@kbusch-mbp.dhcp.thefacebook.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
 <alpine.LRH.2.21.2211031224060.10758@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2211031224060.10758@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 03, 2022 at 12:33:19PM -0400, Mikulas Patocka wrote:
> Hi
> 
> The patchset seems OK - but dm-integrity also has a limitation that the 
> bio vectors must be aligned on logical block size.
> 
> dm-writecache and dm-verity seem to handle unaligned bioset, but you 
> should check them anyway.
> 
> I'm not sure about dm-log-writes.

Yeah, dm-integrity definitly needs it too. This is easy enough to use
the same io_hint that I added for dm-crypt.

dm-log-writes is doing some weird things with writes that I don't think
would work with some low level drivers without the same alignment
constraint.

The other two appear to handle this fine, but I'll run everything
through some focused test cases to be sure.

In the meantime, do you want to see the remaining mappers fixed in a v2,
or are you okay if they follow after this series?
