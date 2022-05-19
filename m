Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D73C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 17:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiESRBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiESRBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 13:01:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DC133A24;
        Thu, 19 May 2022 10:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6446B8276B;
        Thu, 19 May 2022 17:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37278C385AA;
        Thu, 19 May 2022 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652979669;
        bh=XV4OziWazsZR9aIMGMPLdbuBofoKuXAhCbi10Q1FdUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpn1tEYXyW1++CtrtGzlu4t+T9W20GjPRjdcYW8mpCInwqIyNTIyxeR972zfrCX6p
         V4VBgiWMr+BoTVFf2V2ScFY7yvqo/I9w8MRYbkOD8qkypEsk0d/Zu5w+MN6ZufPWMl
         jitbLy2j4TJbhT5Tb+HH9G92IUdjDUV3i+iAEhxaBKc+/PcKsMB7f+IThmfYj+6Cnt
         5ig8s+G8aOQmrv30NnRhOEZVKYPejyEaIeoDPulLVZY+TOjkmCA5JfaRt9h1bwqSaa
         DShFBWbAEoZ6xnqMqr8ar8pmgNGPkUXqIX1LZ9Hoaza7SkBqOdpHLVaE4GHbtWWGu9
         UfX3eG379/hbA==
Date:   Thu, 19 May 2022 11:01:05 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoZ30XROoiFleT16@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 10:56:04PM -0600, Keith Busch wrote:
> On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
> > Note, there's also lots of code that assumes that bio_vec::bv_len is a multiple
> > of 512.  
> 
> Could you point me to some examples?

Just to answer my own question, blk-crypto and blk-merge appear to have these
512 byte bv_len assumptions.
