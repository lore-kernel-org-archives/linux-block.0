Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D67C433F5
	for <linux-block@archiver.kernel.org>; Sun,  3 Oct 2021 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D68B61206
	for <linux-block@archiver.kernel.org>; Sun,  3 Oct 2021 02:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhJCCKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Oct 2021 22:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhJCCKF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Oct 2021 22:10:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC9596120A;
        Sun,  3 Oct 2021 02:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633226899;
        bh=CcTVnHrMDSA4LkTtKSIxceSzvu0o87NdMFY7BSSyeiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFV8gNRfyz7xj8Qr+1WcUrxap1lJcvedxLAwKOUPnrHrJVXwHuKc1lQ4w2w64E/mB
         xCwLykd5pNJaYq529qHN19AFB0Yr60Gp+8hSr+f+z2BxCDHWBbpcC0S3doewA+uqTf
         Ayh0Xmuc+XqVWu1y+YpBnkxJQVDUTNH4L92qAbIZdsNiM5ZNupGSfzPo2F7gPPpP2n
         NDNhbcCkT+B77tMWPkIwVTjYSrhZZQs8IEUxqnOEnpM2kZ+44srq2oKDGcBSPKWGXl
         GLXxENazIuxlLnm2mSjrWHGop2HQw7QQQgkjaVYosFZb2wpwMNWsDjf4XCk3EOnbRY
         hBa/jAdgcQL+Q==
Date:   Sat, 2 Oct 2021 19:08:16 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Aditya Garg <gargaditya08@live.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 5.15-rc4
Message-ID: <20211003020816.GC410131@dhcp-10-100-145-180.wdc.com>
References: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
 <CAHk-=wi2sX142TVRhhKZ=HgFzatZv2wt8yT=sR7r3Ob-p2d_hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2sX142TVRhhKZ=HgFzatZv2wt8yT=sR7r3Ob-p2d_hA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 02, 2021 at 11:06:21AM -0700, Linus Torvalds wrote:
> On Fri, Oct 1, 2021 at 7:06 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > - Add a quirk for Apple NVMe controllers, which due to their
> >   non-compliance broke due to the introduction of command sequences
> >   (Keith)
> 
> Pulled.
> 
> Did we get confirmation that this fixes the issue for Aditya? I just
> remember seeing issues with some of the proposed patches, but I think
> there was an additional problem that was specific to the Apple M1, so
> I may be confused.

Yes, the tested-by came in a little after the patch was applied so we
missed including the tag, but here's the confirmation:

  https://lkml.org/lkml/2021/9/28/50
