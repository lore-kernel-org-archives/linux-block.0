Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A617CC7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 22:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjEWWZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 18:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEWWZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 18:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F33C1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 141EC632D8
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 22:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F6CC433EF;
        Tue, 23 May 2023 22:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684880702;
        bh=uAMnDJ67sa3BN7aTRAukhdiO20l6XeeQhcQaTqTcj/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8a7Klc57+vJgnOp3GN2ZQ/+IRgZjqtKD3TgzPTnoCRhWd5hlfz+klmWkuwAvFuvi
         /0gk8uz6qtdglY5rAYJqHwfek/JiTL+ZtBd1Jy89gkJL7lpWm1f+Ls0qlTwZrkMHev
         P2t6rYhB7GExY2XbEfaExh95ptqY151HY3fh3W4VdUuAuxD30uqgbHijyLbT+/pCdI
         TZ29z11CCRcvPnF5Ut5D1XZKN95FNsOXGaQgAApUtsIqZ7y2jm+CfVsB20jx8j0gV0
         cgRPut62QRJZaceI3lb2bKwlY7ymhVPqwHgkRKhbIX11jBGYIuhx3RGvTrjw3oziGX
         lhRlPTTLRBUGg==
Date:   Tue, 23 May 2023 22:25:01 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     corwin <corwin@redhat.com>
Cc:     linux-block@vger.kernel.org, vdo-devel@redhat.com,
        dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 02/39] Add the MurmurHash3 fast hashing
 algorithm.
Message-ID: <20230523222501.GD888341@google.com>
References: <20230523214539.226387-1-corwin@redhat.com>
 <20230523214539.226387-3-corwin@redhat.com>
 <20230523220618.GA888341@google.com>
 <0d3d1835-d945-9fa2-f3b7-6a60aae3d1df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3d1835-d945-9fa2-f3b7-6a60aae3d1df@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 06:13:08PM -0400, corwin wrote:
> On 5/23/23 6:06 PM, Eric Biggers wrote:
> > On Tue, May 23, 2023 at 05:45:02PM -0400, J. corwin Coburn wrote:
> > > MurmurHash3 is a fast, non-cryptographic, 128-bit hash. It was originally
> > > written by Austin Appleby and placed in the public domain. This version has
> > > been modified to produce the same result on both big endian and little
> > > endian processors, making it suitable for use in portable persistent data.
> > > 
> > > Signed-off-by: J. corwin Coburn <corwin@redhat.com>
> > > ---
> > >   drivers/md/dm-vdo/murmurhash3.c | 175 ++++++++++++++++++++++++++++++++
> > >   drivers/md/dm-vdo/murmurhash3.h |  15 +++
> > >   2 files changed, 190 insertions(+)
> > >   create mode 100644 drivers/md/dm-vdo/murmurhash3.c
> > >   create mode 100644 drivers/md/dm-vdo/murmurhash3.h
> > 
> > Do we really need yet another hash algorithm?
> > 
> > xxHash is another very fast non-cryptographic hash algorithm that is already
> > available in the kernel (lib/xxhash.c).
> > 
> > - Eric
> 
> The main reason why vdo uses Murmur3 and not xxHash is that vdo has been in
> deployment since 2013, and, if I am reading correctly, xxHash did not have a
> 128 bit variant until 2019.

Why do you need a 128-bit non-cryptographic hash algorithm?  What problem are
you trying to solve?

> 
> It would certainly be possible to switch vdo to xxHash, but it would be
> problematic for existing users.
> 

Well, this commit doesn't mention that the choice was forced for compatibility
reasons.

It sounds like the on-disk format (and presumably the UAPI, too?) for dm-vdo was
already set in stone before it was ever sent out for review.

That takes away some motivation to bother reviewing it, since many review
comments will be met with "we won't change this"...

- Eric
